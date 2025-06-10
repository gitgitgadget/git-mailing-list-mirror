Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766E1A3148
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593875; cv=none; b=gR6XRCISC3XN2+7p5uvTuVW0GdNTYnntGit186h1aPXPwc0MAZc8Q1OBUc/XqZmy80pQqZe5dJs4YH1F8yh1G8I2UBidq+RbmQmpSZ7uLe5IwgischmJKb7AW7Gtv7P1woIQRadj5PWZd2YDYQ300S1pq5elEdP2grX+rViuIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593875; c=relaxed/simple;
	bh=YGXdiOd51xDVELVWJfU+x2rJbe509Rq1KPtv1pGS858=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfyL5oZZMBCvoSo1rSxpkiux4/7zes9Iwmk0bNP7oqU1cFHQWdX+rhVcyMVm5cyrfe6NnGsa8cPLD2+WhBp6JuBccdUdYR/glG/7TyBIOP0YFpfKoogVs7umScmNV3i3CC7br+KdKIaptb6BmknE8g8r429CPyXeye15cVackEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKxTOXCl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKxTOXCl"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ade48b24c97so536074066b.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749593872; x=1750198672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QPxir80KPY8T0G9prAmIg9Fpq830v0yFGhka7+d4VII=;
        b=lKxTOXClvo2QQHrj+xX/DNfdsjUwx/TRz3zhbAsdzKxqwMLWVQ8DNm5dWVKYO38mF6
         Eyu9B4GDmngYlPy/9ABibUVyJd7nILZWJgYLwvDjPfk7cJh22W500BwG6A4yP2sg8YbO
         nKaE9GZ2/PwIxb+DYaNsQKqcvMMUIYlaJGWz4xU9i8HQqEnU+U9ULSAEsmMlFWLY7k5J
         tUjR6bpjBkwYVF7Q8P4kQhvDEJyORP8+ejgQiDo2HwfYBFMiik4HkfUT/IAd5freHwxD
         nQlsnFqlxjo14M1BMEGgflx6H29a4pS1R0jXezrKnWUNgmsaCYZDJfxGI/OB5GDyZy2x
         k8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593872; x=1750198672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPxir80KPY8T0G9prAmIg9Fpq830v0yFGhka7+d4VII=;
        b=VcI9PAnt/5jJfDJ8OWwCfv+wSO4/Njxu8w7K8xNwSaEDrk8Eg6fTcfWVKExiEn2vS5
         l/hDAXfMNaTuwJHpkwoquAHJUga0ykgCjon7/1Kra0nhEnZFrFgNPBbLTs430iHj9y6d
         2u7SnX/Fxgu0pPyGh9EI8RHuxy8hS0ARc9RyzLXN4RTrwyqrMylcNeQuhLGoy/+tpT9p
         VvlMD0B5zJAHmwVQfQuA9Z7w10HLrQEe+QIqXgPoSLImRQ5Bdr9V+MqUAJWzoYXc2Hrr
         5KoUyuHs1OmknDIqCPVD90uic0hg2UHtUDbqysQCmSGbYUVgVo3CHmvRioCmbTjqC2Xi
         xLIA==
X-Forwarded-Encrypted: i=1; AJvYcCVvVkzTAfdqFmjogyE/VRHpd7iXwq79uiTVsqla8NETWeDVkLuQ9HYIW9D/RcB2P0WvwSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbWFdBRSI6CDk0MLHYCAaRMGCbdnnTUBfNgqYITjMU+0DmwfN
	sYSCNsu1PEBPwJtXrq+C4EJwd558mlr0ZLodKOnZJVGAlIItbvvA/nAm61YKqoQAfJwow/vtaEA
	o8NQvrWhnLrCcuS6oC8EezRekyFkZyms=
X-Gm-Gg: ASbGncun0w/EDjEzpdZ3ESvx34JMZCngfxYYGdIOAwCZz5bjeT4UUcwQcJFEILx+7Yl
	0M0Dw0TXThLt/uJf4pUtsnDdbVKBdTHtm2cvCw118KxEvGCMW2obMWol9WQY8E+gBvEgYCSwO8g
	uKRSRWtzODtgS6U6tFQR5ZBA2eZIVJgXoupS3dPMPJ5w==
X-Google-Smtp-Source: AGHT+IFR1YWMMjDhNCRsJma0aAO/Jk1zhVjUF8JFpKCmvKbYmx5e0qJyMYqCguJoy1U0HZtjvksksFOrbqgH0kpfJmU=
X-Received: by 2002:a17:907:3e23:b0:ad8:8f44:134 with SMTP id
 a640c23a62f3a-ade8972af9bmr107838866b.46.1749593871560; Tue, 10 Jun 2025
 15:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1992.git.git.1749546464346.gitgitgadget@gmail.com> <xmqq7c1jmgpq.fsf@gitster.g>
In-Reply-To: <xmqq7c1jmgpq.fsf@gitster.g>
From: Andrea Stacchiotti <andreastacchiotti@gmail.com>
Date: Wed, 11 Jun 2025 00:17:39 +0200
X-Gm-Features: AX0GCFsAjIiQXS8JlyGrYQq6Q-GDDPmWNg121lNi_xitccUeeCI9TyJPW5OTpcM
Message-ID: <CAEgWtF-fNXaC88FWw5K_3ZpbvQSxAfeuCFy8kkrh_z16vD77=g@mail.gmail.com>
Subject: Re: [PATCH] branch: move multiple branches in a single --force
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrea Stacchiotti via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for your review, the concerns are fair, I'll reply point-to-point.

The general issue is that AFAIK the only way git has to say:
"point non-checked-out branch B to commit-ish X, leave B's config intact,
if B doesn't exist create it" is `git branch --force B X`.

This is likely an abuse of `branch -f`, it might be better giving it
another flag
altogether, like `-p/--point-to`.

`branch --force` is massively overloaded and most of its functionality is
tied to `--move` or `--copy`, so changing branch names, not repointing branches.

This patch aims to make repointing multiple branches to the same commit-ish
easier, currently it needs a shell loop.

I'd like this functionality for gitops repos, where each branch is an env
and I want to update dozens of envs to the last config state.

Il giorno mar 10 giu 2025 alle ore 23:25 Junio C Hamano
<gitster@pobox.com> ha scritto:
>
> "Andrea Stacchiotti via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Andrea Stacchiotti <andreastacchiotti@gmail.com>
> >
> > Using either the 1-arg or 2-args form of --force
> > it is possible to only move one branch at a time,
> > to HEAD and <arg2> respectively.
>
> If you are renaming (or "moving") a branch that is not checked out
> anywhere to a new name that is not in use, you do not even need to
> force.  You can just do:
>
>     git branch -m old new
>
> You are not moving branches without "-m".
>
> What you are doing is to point a branch A to point at a commit X
> with
>
>     git branch A X

Indeed, this is about repointing, not changing branch names.

> Your proposed log message talks about "--force" too much; if you are
> creating a branch, you need "--force" only when the name you want to
> use is already taken.  Pointing the branch tip to a commit is not
> inherently tied to "--force", but your description gives a false
> impression that you are adding a special feature when "--force" is
> used.  The proposed log message needs rewritten.

Right, it's that I'm using "force create branch A onto X, delete A if
it existed"
as "repoint branch A to X, create it if needed", I likely have a skewed
view on it.
This usecase might be better served by a new flag.

> If there is not yet a branch A, you do not even need "--force" on
> this command line.  Also take a special note that "X" does not have
> to be a branch name.  It only has to resolve to a commit, so this is
> also valid:
>
>     git branch [--force] A X~4

Yeah, it was not clear from my message, nothing about the
change is about renaming a branch, my usecase is about
repointing to a generic commit-ish, like you say.

> I can understand that it may appear to be handy to be able to set
> multiple branches at the same time with
>
>     git branch A X~4 B X~3 C X~2                (* does not exist *)
>
> with or without "--force".  If none of A, B, or C exist, they can be
> created from these three commits X~4, X~3, and X~2.

I'm not opposed to implement this if it's preferred, but I liked
the cp-like syntax as it's less repeating and the average shell user
is already exposed to it via cp or mv.

> Or you could propose a different syntax to create branches pointing
> at the same commit
>
>     git branch A B C origin/master              (* does not exist *)
>
> But either syntax to create multiple branches feel somewhat
> inadequate.  What should happen to their associated configuration
> data like branch.A.remote and branch.B.merge?  Should they all point
> at the same remote & a branch at the remote?  How would that make
> having multiple of them useful?
>
This is closer to the intended syntax and use of the feature, I'm more
focused on branch repoints but I'd also use this when I create, say,
the staging and prod env of client newclient via
`git branch [-f] newclient-prod newclient-stag <commit-ish>`

The branches are useful because they are then supposed to evolve
independently and track the real world state of the two envs.

If <commit-ish> is a remote branch the implementation sets up
tracking, but this is really not the intended usecase, once
the branches are created their remote tracking
is set at push time to <default remote>/<branch name> as per
default push config.

Thanks for your review, I hope my intent is clearer.
