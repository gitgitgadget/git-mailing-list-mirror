Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D447383AE
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869413; cv=none; b=V6nvz9ty2acR79MrsO3ZGkcPqffwRR9c9Lv/DvjcKE9AqL8FBV8bKLcYhruhaIc3B+T4ksCCaBXmLaX2ZxrxIGKq1yxQwPIIqdA808ptXZ1fslMaxXYORw1dl9vg5rJAAsnl3JUrE4fhD52A8gf0nECNhwhe/PKwhPawx+6V3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869413; c=relaxed/simple;
	bh=B8DWtfe/ezs4nTkpKvOmX7gWuis+4kOaETXYDfYWpCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q5fpfOgVUDq3mrWTJ3UUacgfjqqhu+wHiZDNzUrQssGoHI47psEDmVZGbG2FMY582qUNhZZL869P0J+PT44aoG+YRn8q+KYL3dg06boqnuSclCcu8Zjs9W9ggzKtgvOvx1Xqm+8y71AkdLWyGO+SrdmkYdcstYI7dZw+3eUqPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tIVNqeNN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIVNqeNN"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c5c8ef7d0dso241383a12.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712869411; x=1713474211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8DWtfe/ezs4nTkpKvOmX7gWuis+4kOaETXYDfYWpCM=;
        b=tIVNqeNNRlx8OSSKhycr2d9ASeKeqfimhscSgxKDLikd1CJPEsN0cri8HLt4NWot8Z
         I3hjq9i9ZAsHDnJo0LNKLSZ55oMHyN7QaW3MIzU/NpgTe6gZ/wZiQlrYe/dHAlkVudi+
         NhOMiPlL9Ysy7EPF9iZ0EfDRSj2Rpd0ehXqzlAUhojMnv0ISNIYYAuZKPkeADmEpSDYB
         h69oaSi9UV+9KlKHzDFT7SSFL7pHc8r0BcFLYgdtyTzOpfsJNvfIrS99Ej9/vHT58OMl
         q60gyOIAqj8eTEDV+QQ0BHcjVA0QdfAigjAI5YuQa8SNNkiz2RVWClC7iyUo8e67s+Ij
         ZA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869411; x=1713474211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8DWtfe/ezs4nTkpKvOmX7gWuis+4kOaETXYDfYWpCM=;
        b=fHx+znZr03OJL6GU0dT4C42e9I8m6fwu3PDG0MtXsLI2Zj5CSfSbmfj6nqJpbz9XOm
         o8iZ2yU5hMNyVIqIbdhVnrwtfvdYGAd93lfWmV3wWLvZLlyx/pj07FSA5Q/eNsPWzBXm
         2je+RE3V9kKgt+ZA2Q6usQvD3tglq68HRmcVO0u8a1XGVrQoKTmHSQ2uWSBXzZ8G2uQG
         VRvJDwkFSmscmcPRgbVJDUD+0oAGyYed1nCiMnE69Dzp30053C2KIF8x7349f4zWw8pt
         431GSqYAQnoBBEAOnaOkObX7V639wyG7MKnYDTTjGzV+t7wEaTox2rxL5nF0d3R5BtPq
         6npQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC7jFGSw18O4EzRLbtF+IJkcoAQ0t0DJ2dXho+JaZqGuAytOk/AMptTL1rPN4GYsxvRoCSEMz3pyMm3LO6ICe46xTv
X-Gm-Message-State: AOJu0YwtusasunVZlXNcjSUPOg6q33SYp5tU+u41gVXAL8jgXefFAHkm
	Zb/XblL3NBr/xfPgjtFl44HgWV/7oxe4YxWCULpHc9UpfJt3Fh1nxJs/dWu0vl4azsoYaxfP4pe
	DKA==
X-Google-Smtp-Source: AGHT+IEIc8mzcDtvEPWLTMihB7soKUzGt0jAqP2muLEJe0khTVIyi2+1Kr5C91fkp79sitENdcfIxJEXLlw=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a65:51c3:0:b0:5f3:e755:b8dc with SMTP id
 i3-20020a6551c3000000b005f3e755b8dcmr2020pgq.4.1712869411276; Thu, 11 Apr
 2024 14:03:31 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:03:29 -0700
In-Reply-To: <20240411001922.67800-1-kipras@kipras.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <4fcab0d3319fa47c2f4126139ca636d6848e9e3d.1712699815.git.gitgitgadget@gmail.com>
 <20240411001922.67800-1-kipras@kipras.org>
Message-ID: <owly8r1jsjby.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 8/8] SubmittingPatches: demonstrate using git-contacts
 with git-send-email
From: Linus Arver <linusa@google.com>
To: Kipras Melnikovas <kipras@kipras.org>, gitgitgadget@gmail.com
Cc: Johannes.Schindelin@gmx.de, git@matthieu-moy.fr, git@vger.kernel.org, 
	gitster@pobox.com, jonathantanmy@google.com, nasamuffin@google.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Kipras Melnikovas <kipras@kipras.org> writes:

> I don't think `git contacts` is available by default?

Correct. It's a Perl script that lives under contrib/ in the git repo
(it's not part of the core set of default Git subcommands that the "git"
binary is built with). On Ubuntu it lives under
/usr/share/doc/git/contrib/contacts/git-contacts [1].

[1] https://packages.ubuntu.com/focal/amd64/git/filelist

I could add a blurb about this to avoid confusion. Will update.

> ...
> $ git contacts
> git: 'contacts' is not a git command. See 'git --help'.
> ...
>
> ...
> $ git send-email --to=kipras@kipras.org --cc-cmd='git contacts' 0001-TEMP.patch
> 0001-TEMP.patch
> git: 'contacts' is not a git command. See 'git --help'.
> (cc-cmd) failed to close pipe to 'git contacts' at /opt/homebrew/opt/git/libexec/git-core/git-send-email line 2021.
> ...
