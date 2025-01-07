Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4771F471A
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267609; cv=none; b=b5HS3TZpKzZFD8n0Qs4saMidoMvKcfIUzepXCrOzVaHS04O1ZZvM5wOu2VNobKL1N/Tm2K7KpVeNnHOW+7yDG0KeITuMNWPzlsVTiAb3s6ugQzUijCKoRUJl0puA9/Wqn7ilGVzvTYdIWGMzoqiNoGGt9IblOuTZdx2uNza9T98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267609; c=relaxed/simple;
	bh=cd1/5psO4TkF+1m+iXTQzn6vL6+ybuMHorHz2Athe30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzrNbwwLFQKyo3IyoC0ZYYjKpDjWNn9midMD0vh9oNTSguNSSvxv1izUqO4VPO5pCqk+678/c2bKItrM+zzxKEAqlMC+Ruq4P0RICQcYeysCLC3lW3pRiUQifsvKiKQ6E/zEID1g2CUUoYUhhAY5yEKFyX3HsqTG6E3qIw+kU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/F87mPk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/F87mPk"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2efded08c79so18250861a91.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 08:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736267600; x=1736872400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZwFsBUsWdz8lsmPE/zQw5bPt8bwP/vTb8dv19oJ920=;
        b=Y/F87mPkuTwedqT/viwfHlvo1FrV4RQJ5YjNPiZ0cA8AuJxdJhfrzcF1Wm79KWS9sv
         TdiuBeXTncDpXW/r9Y5Jhwf2Fjle6nUHbItCC2rWf7MtTJenlr4mROKlwSK+tCpjcDWd
         b0aNOODcOec6pXxtBGpR+h/9ceGoVKAfQwzVglJQ+5rZX5ziuhIETJuz1/Tp1SYnD5c3
         T5JPKuAiNgs4h49itNKzVaydRZXtGAEz8bXRmmwyKi94g6KP74d/6sjLaV+vl2aQCVGi
         FMhzvLcwcWC9K0La1BBOYkrtvyWxko19DFhYbD+PWKvxFVDJ5faGgfgkvML8zyIg3A5Z
         eq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736267600; x=1736872400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZwFsBUsWdz8lsmPE/zQw5bPt8bwP/vTb8dv19oJ920=;
        b=ha7dreCDhnmRfG/ex23sHbtvn7KALYBco1oJVx8GvgMoDslu60764MA/y4xWnbBwEG
         Qar39VSN2V1JB3yndTBfQQ8w7KY5Z5NJg5NNf5+exf70eyKJSowqxSuUxj5dcCe5wmat
         1v0E3SvQkKSFpoOFfqGYyJrsmap+r84EW1eyaI7yYPzSkiwXCRg++5gtm81x54CMgI7E
         Ai8i4RoEhjQy7O1IohuA09q+gMtqCh3CIUZnaB3bFCFMWfadglYth87oWdpDjeroNqUl
         t4qR8l4dQ6ZZQkDpKq9AZzRSpMaApETRZlAUSbsKowU5OM3vG+mtXn1DmcIcUWp2eI1g
         KVzQ==
X-Gm-Message-State: AOJu0YxCff2rCUOlxu4wtWb/LybV/Al+dj74yFYGkVJI5qTyVLwGLu3U
	HUpPNB/VFKtrSNpWzSRHEP3HNWPR/TizSUGQOnRT9RkKHQE3bouM
X-Gm-Gg: ASbGncsgo7TvsH3uB9dacsBbfv/GxFSHV6/W2EfGK7XkKGvrj4yg6JTAIzJVpYFneo2
	9dqrbzF1qVbF1GkIHyPGGHCWhx+xiD/aFI3uYq0k4hH1BRAuBKogRnPnKI5wWTTyCquDDFCAUwr
	bwkhcTeOwhkYgXilDVPi7HbBWbypKpVcDlcQCmPeLo1hMmvOm08rLqzE78e5R2zRPh41c6FaZJv
	1AFN1FQR3fMJOB7ILZx+zGW1/dLf+1Tg8Q=
X-Google-Smtp-Source: AGHT+IF2uNvlByNnR4zo7rTwFozDLBVm5G6MzEhEXL5SzrleBcr9RSrilmJEleXlQhtqCXRf7iI61A==
X-Received: by 2002:a17:90b:2f0b:b0:2ea:356f:51b4 with SMTP id 98e67ed59e1d1-2f452e1b24fmr90089451a91.13.1736267600386;
        Tue, 07 Jan 2025 08:33:20 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed52cf9esm41763200a91.8.2025.01.07.08.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:33:19 -0800 (PST)
Date: Wed, 8 Jan 2025 00:34:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 02/10] builtin/refs.h: get worktrees without reading head
 info
Message-ID: <Z31Xj6sZk1th2mRQ@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN30z1NCXa3AX-@ArchLinux>
 <CAOLa=ZQ6J9GLQjJihKxbDwH6SmHbmVq4sHrKh0ZtMqyEt3hsiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ6J9GLQjJihKxbDwH6SmHbmVq4sHrKh0ZtMqyEt3hsiw@mail.gmail.com>

On Tue, Jan 07, 2025 at 06:57:08AM -0800, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > In "packed-backend.c", there are some functions such as "create_snapshot"
> > and "next_record" which would check the correctness of the content of
> > the "packed-ref" file. When anything is bad, the program will die.
> 
> So you're saying, `create_snapshot()` and `next_record()` exit the
> program on any error. Okay that seems to be valid.
> 
> > It may seem that we have nothing relevant to above feature, because we
> > are going to read and parse the raw "packed-ref" file without creating
> > the snapshot and using the ref iterator to check the consistency.
> >
> > However, when using "get_worktrees" in "builtin/refs", we will parse the
> > head information. If the referent of the "HEAD" is inside the
> > "packed-ref", we will call "create_snapshot" and "next_record" functions
> > to parse the "packed-ref" to get the head information. And if there are
> > something wrong, the program will die.
> >
> > Although this behavior has no harm for the program, it will
> > short-circuit the program. When the users execute "git refs verify" or
> > "git fsck", we don't want to simply die the program but rather show the
> > warnings or errors as many as possible to info the users. So, we should
> > avoiding reading the head info.
> >
> 
> This is a bit tricky here. If the information for the `HEAD` ref is
> incorrect in the packed-refs, git would exit early. Which is what we're
> trying to avoid in this patch, by using the `get_worktrees_internal()`
> function.
> 

I think my commit message may confuse you here. The information of the
"HEAD" ref will never be stored in the "packed-refs", but if we need to
read the head information, we need to parse the "packed-refs" via
"create_snapshot" method. Even though the corresponding referent is
correct (and even if it is not correct, it won't let the program die),
"create_snapshot" will call "verify_buffer_safe" to check whether there
is a newline in the last line of the file. If not, it will die.

However, this is a bad thing. For example, if the HEAD points to
"refs/heads/main", now we need to use the code path from packed-backend,
we have to call "create_snapshot", the program will die. And we cannot
tell the user the other faults.

```packed-refs
<good_oid> refs/heads/main\n
<bad_oid> <bad_refname>\n
<oid> refs/heads/a
```

So, the motivation here is that we should not read HEAD at all when we
are doing consistency checking to make the code totally independent of
the "create_snapshot" and "next_record".

> However, I would question if this is the right approach. Shouldn't
> `get_worktree()` failing indicate that the repository is invalid? In
> that case does it really make sense to allow the user to even run `git
> refs verify`? Isn't the prerequisite for running the `git-refs(1)`
> command a valid repository?
> 

As I have talked about above, even though the referent of "HEAD" is
good, "get_worktree()" will still fail because of some fatal errors in
"packed-refs" file. I don't think that the repository is invalid in this
situation.

Put it further more, in what situations, the users want to execute "git
refs verify" or "git-fsck". From my intuitive thinking, the users will
execute these check commands when something fails. They want to know
why. So we should execute these commands when the repository is invalid
to tell the user what may be wrong. And this is the value of these two
commands.

Thanks,
Jialuo
