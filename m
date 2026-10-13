Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD4517BB4
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902936; cv=none; b=JnM4zcE/iP03eBxON+U3iSnMxvUiuomhtRFVFf9XQWS41N+wW6c/4CiyalE+6hFBDQ0lrZSVNbSk3ff3cZRwwrZ+lOeQCcGyHxKX1P792rVtdQVXzwBN/9oJ9tm1/3hkreCx5ldI7ZXH5n1w5vOcW/yWoQ29jCypAWQxpQmiMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902936; c=relaxed/simple;
	bh=uRBj8Xttct0t9IArobli3AJkly4tA98v/ymtxtJt1pE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fKOKUNYeq+hxY+IyuA6wZlZPsUHq8J/1hkGPE6MUhuh4Sm5ZIR4cW56nw+OoQrLy2+xJM5j2hFIAfPDJalPPAuin+XA3r8REJGnR9cWEA0Y25Q3SQv9txLFGeIQbgfx+cJUKh9d6xai5TMznb1LIm0Etc5GHd9mor679gDlCt4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAvO2rQK; arc=none smtp.client-ip=209.85.217.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAvO2rQK"
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7be93024717so2512925137.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791902934; x=1792507734; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRBj8Xttct0t9IArobli3AJkly4tA98v/ymtxtJt1pE=;
        b=LAvO2rQKlKedmnnqBPhRoR35UcSsOSSkmfp4LH7/1qV5a4eDThwVGE0Oj6j0094NwJ
         e2zxaVBwVXWIfJZaOHcaRyfaMGAnGAArnGZPFOaITXqP8x+oj0oqY8+UZMOO4mUkjVbN
         Ip4jeuiv2j7TZJxRgdPCJvs1rajcAWW2GmzR3P0KIeKzY+Sv6uUUSSa7O7L7IyyEyA9U
         Twh5jIa8heYZ98eWFyMERvAq1LOCsrL5UJHdJ1ugmxqzCNqTl59VDI7jfkAqM+si0zBn
         2KBl+GvfXam4q2xs4QA9aqZh6WBCAw+HQJ/hIBOsyTna28EFwciH9qfBR/N7EBmzlEy9
         lXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902934; x=1792507734;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uRBj8Xttct0t9IArobli3AJkly4tA98v/ymtxtJt1pE=;
        b=1okT0UB7ugQ+Y7ryqXqFwW3zAld8LCMSlaKxfCG4mfkqGU9ivLnoRWMB6rHvODfo/0
         ZDmGPxHccX+NMfSMMqb56s3Om1ndsTyknkHjc84OiYFAbZfhP6vdkoozmU20gquacpm1
         TniSBwHnx1MuPuCBhiUpOSCqO4Ohnb6AF7PEemQ8vC1ZAulxYKPyo/5Oca5/KETkD2aE
         pOIZ9Up5i10ZoQ3qUn0eDJksbf2jYOMOsQmsCGI0OqYvmvMcmKYgG9JWpJZI0koTshWf
         xSVc7IO2mBvkiCe9ABb8q1oVL9O7NmUfe0IXZg9JjUJW5KwoMxKT3dZAfKqPzJxeT55/
         Au0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzYq6xc7lrnly1c2V04BHiPTf2dnRgBxndAIBVq4z2GFYo9VOynXIQygeDb2+0xwkhOIb0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqKFzRxieUK7wTJ/48MA4A9WUyYYsYkjm9csaqHKujT3g9icFd
	Ej9UVrMWw7NSFnn+8/rtSdWtP4O4J54bUNRaKrgHw2Rw6e++6KShTCALQHBsqzC6RyOThPtVLuN
	CJwXpSEMeiA==
X-Received: from vsve28.prod.google.com ([2002:a05:6102:f9c:b0:7c0:cfba:75b])
 (user=rmistry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:50a7:b0:7c3:a114:99a7
 with SMTP id ada2fe7eead31-7cb3a065818mr4231462137.14.1791902933556; Tue, 13
 Oct 2026 07:48:53 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:48:52 +0000
In-Reply-To: <xmqqwlrm4o6z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
 <pull.2224.v2.git.1791493644.gitgitgadget@gmail.com> <35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
 <xmqqtsmsdpxz.fsf@gitster.g> <20261011222929.2957901-1-rmistry@google.com>
 <xmqq8q43eszt.fsf@gitster.g> <5fcd107d-b620-44d1-91b7-e5f9965171cc@gmail.com>
 <xmqqbj8yan77.fsf@gitster.g> <20261012192157.1835972-1-rmistry@google.com> <xmqqwlrm4o6z.fsf@gitster.g>
X-Mailer: git-send-email 2.56.0.rc0.2.gd1c5d74986.dirty
Message-ID: <20261013144852.1155285-1-rmistry@google.com>
Subject: Re: [PATCH v2 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
From: Ravi Mistry <rmistry@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ravi Mistry <rmistry@google.com>, Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>, Abhijeetsingh Meena <abhijeet040403@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Ravi Mistry <rmistry@google.com> writes:
> > For v4, I left the behavior as reading from HEAD:.git-blame-ignore-revs
> > to match hosting sites for now. Maybe consulting the working tree could
> > be explored in the future in a separate series if desired, or please let
> > me know if you or Phillip would prefer to change it in this series.
>
> It needs to be justified in some way other than "match what the
> forges do (which is to use the one from HEAD)", but other than that,
> I think it would be more ergonomic to pick up the copy from the
> working tree (with local modifications) in non-bare case.

Makes sense, I did not have a justification for sticking with HEAD other
than matching hosting sites.

I have sent v5, which reads .git-blame-ignore-revs from the root of the
working tree in non-bare repositories (and HEAD:.git-blame-ignore-revs
in bare repositories) and updates the commit message to justify the
behavior on ergonomic grounds.

Thanks!
