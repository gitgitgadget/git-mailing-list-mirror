Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7D1E51E1
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904912; cv=none; b=ELDfYGrtznt3gLWgZuJvBoaLpw9lkwGmbP/xznLfqmUMQi8Ey7whhYKYvf0YH8kiXg8IkEKEAixkZ/+nHMGmLd0iNJTYOo9+cdqv1Uw7OVbAM9/M5EvVBxZRYXylhQ9NEc5cIXltkuXFtlEyXP3P9PsEJv7PhqG1ANWMuMQxBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904912; c=relaxed/simple;
	bh=bYHx1uWwvjCdFIWoZzOLpJV3vk+XSTfRT/S+DHKBmiQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Hvj1cMj5MmNSHS6fiRhpfgYhFJYuQMPpIFgCpG58y2FzBPQO13wOgsVKMqXtC1h3+nFYIj8y6/uYh9//Vq8sSzWF9HOCLb4isgAW8DL1La7Qr9ycRRmiEM4ObOVvfOabmygx65uz37CYBCusb3bHAlLgDEWChrnN1h342TTLRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7Kos4+n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7Kos4+n"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220bff984a0so105091965ad.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 10:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739904910; x=1740509710; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfbnmmT5a8uQ2bJQP+fY5aAnrdlRQJrQuONWD77hthw=;
        b=h7Kos4+nAgRWnXCQf66WkTPFxm63acdDS9knnWLV0T8osLOwIl4dBfrfSoxeznO8T7
         FR3iI1j6dXiXqIrkTOzl/CgcgyZj+SdzlaHjMkTo1Wf8uzsxlDYkARvhDPs2MJjd6NZS
         dr45F0YEd7jhpsM+6t5q2URwXPGL65nvxMjZfvflGO9Hj7ZJGpfttns5Umuy+IUvMvBM
         q0gVZFIRQgVNooobBlzyZVEdHc5ALWpjL0hI5Dxs+5fUvY3hr+TV8oI8LPNYexwwbDMv
         W9bn8ZEZLHIYEcieKQZYkOhvF+1tix+l7frGnHw2ebgAwcFclcF693k113KOzGSuZC5/
         Yjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739904910; x=1740509710;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfbnmmT5a8uQ2bJQP+fY5aAnrdlRQJrQuONWD77hthw=;
        b=FmUWIJPjw8XIMuyxTd3bQJ4YjnYrSqXSFWWN/+iRJzcqyKMU68sOeCqgnwRy6khX2O
         QUt35Js2weVvRok8Z7/wK0/NRgwRGnJlaidMO192DHZ4ZHm8pGt7R/XZDcjLXmM1hXFT
         khT93SPfTt6NIJweDd3Hu5bk3Gp51wO6Bafmmr3xbJO6JaMfEUDSceeH9/mALcRCiu2I
         wvwDAda19Z8e0A1davnw3aBaHoPwOzKWK0voDUcduEoWd06R5FJu+azRKhrFBgw3fdmS
         soR/XHLgTV2gznE9H55ZHfkf9zPfxgU0ZESOPQtKSs8KOAc4ajJN69BTcWbK6N8WnSXK
         hMcw==
X-Gm-Message-State: AOJu0YxiMFwlDqD5F4zBQWMMF/8HLmuSCIaYfWcGhJLwm0ELfggd6S2w
	0SHIxUR/vCm8Cr5IUhgw0lGfoAXpdKDb9bAgMv00Jg4Y0SoxaFtuLtIUrhon
X-Gm-Gg: ASbGncu3TKNTCqv9CCZILAnOevqcHyiVQ7g7+V/yjQl3254x/wXJsBIu3OpHMhrpfWD
	n05lRec/UvPZP6GXeYYdj49iDVP9oKJ+Pt4nRi+MSdth0tt0yJkZrySTtCgtW+6b+22DI/TUqC7
	fFUyy/rO83fqknW9GogfwwMG0LFtxYLkzndIR1MXOHqzvucqPY4Ae01zc8FCAUjVN4hztcoTYSw
	dt6Sz3HxHuAEfCTjyPdp/cIjBugAaYnS/MEc+Cv5mO9ckkYYP5JsvODG/9NwgSt2DzUc6ZGqaNA
	BJrVs/aQ3RUNSiFDhoiEaiR+PVX1u/VhAO6aGAc=
X-Google-Smtp-Source: AGHT+IErowu4seCOA0WYvs2GM5BcKnDNjihouXUeV8dLwYqxatIJ/ciAYVrzZOloAQ5pcSYnG0jjlA==
X-Received: by 2002:a17:903:2b07:b0:220:c178:b2e with SMTP id d9443c01a7336-221040200a5mr234775885ad.17.1739904910292;
        Tue, 18 Feb 2025 10:55:10 -0800 (PST)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d3a6sm91694375ad.160.2025.02.18.10.55.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2025 10:55:09 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [GSoC][RFC PATCH] git-merge.adoc: detail submodule merge
From: Lucas Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CABPp-BGpOi9ZqrPFwxCiRLFjozgnYKV=zbYVAA5c9Z9yDUTBGg@mail.gmail.com>
Date: Tue, 18 Feb 2025 15:54:57 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EE88CF05-9120-4CAB-A097-84CC5EA2FACE@gmail.com>
References: <20250217232847.8567-1-lucasseikioshiro@gmail.com>
 <CABPp-BGpOi9ZqrPFwxCiRLFjozgnYKV=zbYVAA5c9Z9yDUTBGg@mail.gmail.com>
To: Elijah Newren <newren@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> It may be worth referencing the commit(s) that introduced the behavior
> for other reviewers: commit 68d03e4a6e44 (Implement automatic
> fast-forward merge for submodules, 2010-07-07).

Ok! I'll inspect the codebase and reference it in a future v2.

> "referred by it" is hard for me to parse.  Maybe something like
> 
> """
> In the case where the path is a submodule, if the HEAD version of the
> submodule is a descendant of the MERGE_HEAD version of the submodule,
> or vice-versa, Git...
> """
> ?

Perfect! Actually, I find submodules a little abstract to be explained
using only words, but your sentence is very clear.

> Also, the references to HEAD and MERGE_HEAD do tie this documentation
> rather directly to `git merge`; the basic idea is applicable to all
> callers of the merge machinery, but none of the other callers use
> MERGE_HEAD (some use CHERRY_PICK_HEAD or REBASE_HEAD), and some do not
> assume HEAD points to one of the parents either (e.g. merge-tree and
> replay).  So, if we want to move this somewhere more general, we'd
> need to reword it a bit.

Given your previous suggestion, what about:

"""
In the case where the path is a submodule, if one of the versions of
submodule is descendant of another, Git...
"""

?

> Oh, maybe we could put this information in
> Documentation/merge-strategies.txt?  Hmm....

Looks like a good place to put this. My only concerns are:

1. It would need to be documented in both `ort` and `recursive`. I don't
think it would be a big deal as most of the first paragraph of both
strategies are equal.

2. Maybe it would detail too much on this specific case, while not
covering others (e.g. changing file permissions, symlinks, etc).

> Thanks for sending this in.  It's always helpful to get researched
> documentation improvements, even if I can't help but nitpick and
> complicate matters here and there....  ;-)

Thank you! Given how deeply you understand the merge machinery any nitpick
is immensely valuable!

