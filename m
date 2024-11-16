Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309E2F3E
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731758995; cv=none; b=It4pwtEJwatV78ZWV/JO0otRy14AKz0zSvbxKzGX/R6akeGr83SJ7WVM/5DLjoEdUh4HPs4+foLFYlHy4CqtnOu1M+miRoUpsmJg7TTAfsiKt+wFwN9cu6d2FvjF8nN97rMvuXQZeXF14grRAuJapZ+1fPt4HvqZa281dvyabAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731758995; c=relaxed/simple;
	bh=hjlJ5RWl0ceCq+VJgktPf3SvHqw7yQp0nJwhjy+4KYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcxB1Gus0tWIf+XkRYeTMUeBhz+dO2xsh+l4nPJ6QmoSzRIr3rvg+m5L1g5YrA8vST4m0Sv1qubxA9m7R+7qU6fn+ndjWxrdQuiQYJCx3qMn0UJr42J5MYopA1KRO9eTdQL4f3hjWC/ofIzzbSXPutHVJJU+VtWLKEYvctSgdoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYcJpmIR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYcJpmIR"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea39f39666so260347a91.2
        for <git@vger.kernel.org>; Sat, 16 Nov 2024 04:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731758993; x=1732363793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8l+rvtHpS2+5x6XCUvgOBnvsPtpSBQMP4F0h2dcMnt4=;
        b=dYcJpmIROpV/DLIJ8/DKDL62kRbwKcaRQbzBZaZZxV+HET3dpckCW172ws4r84vmVd
         83fy0lm9QSHQ3oufeaS7/65PsAttqhByaxxrzo4DbyKCSdWOQVDvQP13Zw79V8vfU8o5
         rBm9JlaJhNRKNWd1I0IG6R6jLOcvW3cgeUex+skZDL3p/GnD+77is/4LnmMYvIOjx+ay
         bouQNyTBVcmL2z/0s2odN3xSFrZJheRpx0S6ZUsrqIJKgqunzpV+oCNq0ClH2X02Fd3B
         /Z+H4HEGfSnmjYNcQRl/WoHs94vc2uHVxPh4QWnT5KVbrb6G9m59zud8/Ib8x3hgehac
         t1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731758993; x=1732363793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8l+rvtHpS2+5x6XCUvgOBnvsPtpSBQMP4F0h2dcMnt4=;
        b=NmsVHmvuOkAXCvrtAQ30JPHTvGEh/xYxbayg0upJVOop5tk4BdcAXGt7Zso39yruzj
         WVoUj9fAI9EZUL5JVN8Zx6Hx+fJurIrga2CMh08NdhFShScVUPThQKIwBWdXJDvVawFR
         XhWv6EyA9Xa5xl/NrzVVeu1ZsJsB88i7K6PJ6/XEcfyG/HOxlnJIU9ZTqO00ACWjZwUI
         PzUDWOjJ0In77geAglgpbfuVoFshvbqCTP0BkwMkH7euULjOm6VhnL1AErDCbU7MCsyR
         /kOpL0LJ5qyX//rf1OyuucWihEb8w+oEz7HeoLbUZLlVCWMuq85GxHmNtIVQ9ZnWzagC
         t/5A==
X-Forwarded-Encrypted: i=1; AJvYcCU1+doIWtJYAiQjWykzx8ekri/nSUWw0aFxMq0GFp4520FJEpuiUdeWSpRg9F8BYLD5pNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39b0jqQUVoyfjoyh1o+xwfINUp7nxlM/dCBRiql/bKbSHPOL/
	+u4tDzq3SCkmBud+zhqkHhOH3PrZPvq++Q1i+4IVM9TkkIqOdEyc
X-Google-Smtp-Source: AGHT+IHEwMKT0wy2+bRnEPdIkyAu/2PddlnIT766l75knrtUZO+4BvGLuroWq8Heu8XwoBlNmqrw3A==
X-Received: by 2002:a17:90a:e7c6:b0:2ea:10de:1cee with SMTP id 98e67ed59e1d1-2ea155a2349mr7473500a91.37.1731758993426;
        Sat, 16 Nov 2024 04:09:53 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea3f4ea617sm812146a91.30.2024.11.16.04.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 04:09:52 -0800 (PST)
Date: Sat, 16 Nov 2024 20:09:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] git: remove is_bare_repository_cfg global variable
Message-ID: <ZziLlXln3NLPaHc-@ArchLinux>
References: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
 <3d341a9ae4ef1d2776734fa82a45913f91e6083c.1730926082.git.gitgitgadget@gmail.com>
 <xmqqv7wzsijc.fsf@gitster.g>
 <ZyzlBZnL-K3S7Env@ArchLinux>
 <xmqqjzdeqzzk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzdeqzzk.fsf@gitster.g>

On Fri, Nov 08, 2024 at 10:24:31AM +0900, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > I also want to ask this question. Actually, I feel quite strange about
> > why we need to add a new parameter `is_bare` to `repo_init` function.
> >
> > For this call:
> >
> >     repo_init(the_repository, git_dir, work_tree, -1);
> >
> > We add a new field "is_bare_cfg" to the "struct repository". So, at now,
> > `the_repository` variable should contain the information about whether
> > the repo is bare(1), is not bare(0) or unknown(-1). However, in this
> > call, we pass "-1" to the parameter `is_bare` for "repo_init" function.
> 
> Isn't this merely trying to be faithful to the original to avoid
> unintended behaviour change?  We initialize the global variable
> is_bare_repository_cfg to unspecified(-1) in the original, and
> for a rewrite to move the global to a member in the singleton
> instance of the_repo, it would need to be able to do the same.
> 
> And for callers of repo_init() that prepares _another_ in-core
> repository instance, which is different from the_repository, because
> the original has a process-wide singleton global variable, copying
> the value from the_repository->is_bare to a newly initialized one
> would hopefully give us the most faithful rewrite to avoid
> unintended behaviour change.
> 

Yes, I agree that this is the most faithful way to make sure the
consistency when we want to create a new `repo` instead of letting the
caller do this itself.

So, I think what I feel strange is that we need to do this assignment.
Because we make a global variable not global by incorporating this into
"struct repository *", we have to maintain this state whenever we create
a new "repo".

It lets me think whether we should place "is_bare_cfg" into "struct
repository" in the first place. I will explain why in the later
comments.

> At least, that is how I understood why the patch does it this way.
> As you noticed, too, there are ...
> 
> > When I first look at this code, I have thought that we will set
> > "repo->is_bare_cfg = -1" to indicate that we cannot tell whether the
> > repo is bare or not. But it just sets the "repo->is_bare_cfg = is_bare"
> > if `bare > 0`. Junio has already commented on this.
> 
> ... places in the updated code that makes it unclear what the
> is_bare member really means.  The corresponding global variable used
> to be "this is what we were told by config or env or command line",
> but it is unclear, with conditional assignments like the above, what
> it means in the updated code.
> 

Yes, John has changed the corresponding code paths by setting the global
variable "the_repository->is_bare_cfg". So, we will refactor this later.

In the previous days, Kousik wanted to make "builtin/mailinfo" not to
reply on "the_repository". I have commented in

    https://lore.kernel.org/git/Zw6SsUyZ0oA0XqMK@ArchLinux/

In this thread, I do not agree that we should not incorporate the global
variables in "git_commit_encoding" and "git_log_output_encoding" in
"environment.c" into "struct repository *" because we could use these
two configs outside of the repo.

So, I don't think it's a good idea to put into "is_bare_cfg" into
"struct repository". Put it further more, we should not put the global
variables in "struct repository" structure for the following reasons:

  1. These variables are used across the whole lifecycle. Not just only
     related to the repository. Some variables could be used outside of
     the repo.
  2. Currently, the config functions which set up these variables don't
     have parameters to access the "struct repository *". Of course, we
     could add the parameter, but as 1 shows, some variables could be
     used outside of the repo. We may need many efforts for such
     situation.
  3. We need to maintain the consistency if we create a new "struct
     repository", because we will make global variables not global.

So, in my perspective, we may just create a new structure called "struct
env" to incorporate all these variables in "environment.c" just like
what we have done for "struct repository *". But we also introduced
another overhead, we may pass this structure to every function when
setting up.

> Thanks.

Thanks,
Jialuo
