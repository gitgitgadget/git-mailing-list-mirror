Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3687B4B95BB
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391419; cv=none; b=ZmMW0DWWAIy3Y2NmfcWA0Tvh0xrSms1peZD/IO7VBom/3E9vrckiq8rATto6AI2C9bStcaM0Mh4GrIbxaZEahYQjxe2OiQqxBzgmOXZuwLwLyXhAXPYuO+s3+6EBdTBhBM7d98GDK1QB3hg7aoOjZT7bzgsBlxK5ymgQVoiAe8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391419; c=relaxed/simple;
	bh=qPiMmvgc+xwhUgR+Wtvtf+V9xGaB5y+OEF4H3iDRLKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uw54728vXdawPwOIVbAzOnh1k+sCIM4XO15W1yAGqHXTZSzBpL8lPGWJXjdt1rvIkEQy2R6Q4RJZeOqIDuKcWjcaaHT8ms8B7STVguwxAYJ021siZoCm0asZxcuunLJD36ea4ljEAmY2aouFy3PPGhgQ6K901dyYHziDcFMnbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FUQENspZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m0QCFOfY; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FUQENspZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m0QCFOfY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F822EC0496
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 12:43:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 07 Oct 2026 12:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791391417; x=1791477817; bh=ftN564maEV
	2vdzuyyKGYqFtThi3gSKLW5PObVyFjIzU=; b=FUQENspZeHrbveieiB9yCTdJ8e
	6gj6L9BmmaXV+GRbauTTPMQB5Qj0MjQwQMcnB26b6DinxyqjmluJ5ULY6iMVaGpg
	dlWem8zN0lMIz9yNotJ8c+hx5jcGqmRQ6Pc7KIiIfRl1aKroZk492w0wQrrILNep
	Z9AKNDolgriHRHqIt+hCFaMi/ozZKj06dK6ZeG0iDa5Jq7odoExB46WVttqOFST4
	PhLugrsgoKgbsQGNv89CIXgVwM8EDiTohnElIFzSlyAm/2a68MNsYw9dxzZEPwvI
	xAkvGzN0HBh5Bcm4q+EUHJqZPeaVH65DU4E2qUPoNQ21CUM/SaJRA73aMLaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791391417; x=1791477817; bh=ftN564maEV2vdzuyyKGYqFtThi3gSKLW5PO
	bVyFjIzU=; b=m0QCFOfY3LQWcHFUQje2P9h7O6C6RNaAQAgbhlgivkpecBOtPDT
	pdu6l9baxxd3LWxLdzRhLvTEtYIm+5Gl47E0152JhD2WqR6vO5wtt+eP9HzP8dlZ
	UYlJ/DUHIGnOp3XREdGZeI83Dc5RNEBWefx3QRc1lWJk6l0xAroMwdO0FY23eqxN
	c/DPYmxqbNreJqiTWpJfS5jkD6jgBXVYL4325KmE4f2l59jer156r9CDct5Loout
	ddPIfAC9djR2MKb9UESQI0KIeMVZrcDVTs9/k3Ld5TJ4YbCiv/34xCylmD1xFGyl
	kodsEmAiSrtuMsHJR6iWwH8F/Zc8IrNzBlA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791391417; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:igQhRTN1c6SUWFyq6hDTVam93iuKDGJE0JOnjQuweHJl8lp
	yiDCIXt2zea3B65Qj6wBQpEMJGDxpNAV4cyiTgAgFfNpj6BMi2Z+aO9l7zfyz6mW
	xmVAiC0axQxL9ezMJ/AFI8nysdakKvJlzw89aYsOXgImDy3heQQim+nctSH81O5R
	WQ9e3AcpHiw0kng12+OuXupFDaDR9oZPUFipk7Ldq1ayHSa97U31maH0lYoqxUyO
	64gzyT7+RAjxDl/fAZTSUjGhgrMuvw99IUC1qHt+WFrXYukeN7hrqk69zhrKDUEl
	gX8xM6IRdx+7Lt2RmlSDMyvTSKG9ec29kYZBUug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YP74ekp6DLLVqM27RQ0KEyJpPKhq+i0wd7WNGT0iTPU=:qPiMmvgc+xwhUgR+Wtvtf+V9xGaB5y+OEF4H3iDRLKo=;
X-ME-Sender: <xms:uXbGanjeKU67YV65KlwQYTh1BrGOjXERj6nb_kQ6LMXQMZWb3ANfMw>
    <xme:uXbGarBJgm931vq9NVp7UCa8Nwfb1cvB5URN32r0CF8yoMbWjZils3g6uQ3I9nuTD
    4L8PihdcuJbAaC_gE8GtBijenK7efjH2qnax44FvNafBCOaaPEcJmAl>
X-ME-Received: <xmr:uXbGasGN14RSfexZ_SP49qcf7T14IhjcbHfLZ_UOchmHuRTJRkRgr_XWQ91riHpgpctqKzT0XDGk9BohmEFIuZM3ydCQiyhY0yDz>
X-ME-Proxy-Cause: dmFkZTFyYA3Eve8wwgksHUlEKvhRcDwU/1vqf53n5CeqWuUg+HdZY38g2eYqMyPHnhy4Og
    xyuBEzAH0mDGOL9Rw5Ks7QReekPTzi6vG0cm0CDydT8KChdmT2d/wUnDwcYVES8IVnLKZ7
    fHHSKbRDHtpD+qF0OwL0zzRuYP05Xqjf6R8yoDikbOfnhKKGN48EoBfU0/R5B/Evj6yu1s
    cbUtaZcIHyiMAY9Hv5o+2J3G1HGLDWwbeCteN4xlbxlpelYKRBy63MIljGCqTA4wHJaXdi
    TLE072f7ijCilqDMsaQ4ITbx+GwR1KnCBVv1SlI5hHueWEOc/XMP/sF6VpvJu0qLYu2TWx
    hu3HRc1S56/92uXc4fqrOT4CTJhu6mmKZIFsE3yfPci6grQZWhcYS48bReBS7di+JHMBPm
    pvR5SEKlBrP80iKddeJKbExzpZOMzdVf1ub4Rfhb/elTG3R1l2xjat25BW0ShCgxbv4ddL
    E/hs+SnwSOpI/Au0ds69lLwTyTrcJgzom6ZbFcc1xWRu49m0Ueh1cCbzUp7xe+Ft78Birs
    Xdrt3g+fKypSUCtup5WF+VROhShbqr2BBEX1wH7Z4s4thJsf8IGUEMBqhFEkkDbSebP+Y7
    yQ+GOpt/8q83LGZntR+4aPN6+vfneDBOCBbvWaJI1Rc4H2x8Oe4kgrmVmAvw
X-ME-Proxy: <xmx:uXbGajLPLh48xIFHfTu68RVVhCBcaq705Kyrf1tEXHsi8IAl-N6mvg>
    <xmx:uXbGaglabvPXLW9NOcEky174OTGxFSwgbFsTZMdwIYqnmdJfJSZFEw>
    <xmx:uXbGarS5wud_Qd4eyWBMX8ng7WKylMeFLohOSZdG0Y2F19uT8DmwpQ>
    <xmx:uXbGaiLdm3IQWES5P1_Cq_Bws42gnn85ISk41Y3bq15RMcJqt-D89w>
    <xmx:uXbGajkP7HqQDXqKM9V6vJwXaL0O20MvMmkRKwx_Jij4yN3hql5z5dpb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 12:43:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <pull.2250.git.1791384721919.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Wed, 07 Oct 2026 14:52:01 +0000")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
Date: Wed, 07 Oct 2026 09:43:35 -0700
Message-ID: <xmqqik3da2bs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/detached-head.adoc b/Documentation/detached-head.adoc
> new file mode 100644
> index 0000000000..1e00712124
> --- /dev/null
> +++ b/Documentation/detached-head.adoc
> @@ -0,0 +1,43 @@
> +`HEAD` is where Git stores your current branch. `HEAD` can either be:
> +
> +1. A branch, which is your current branch.
> +2. A commit ID, when you don't have a current branch.
> +   This is called "detached HEAD state".

HEAD is branch which can either be a branch or something else?

    HEAD records the state from which your current changes started.
    This can be a branch (the "current branch"), or it may not be
    associated with any concrete branch (in which case HEAD is
    "detached").

> +It can sometimes be useful for `HEAD` to be a commit ID.
> +For example, it lets you look at an old version of your code
> +(with `git checkout COMMIT_ID`).

To "look at" an older state is more versatile than simply running
'git show COMMIT_ID:path', as it allows you to do anything you can
do on a branch, such as building and testing.  Thus,

 	A detached HEAD is useful when you want to tentatively visit
	an old state with 'git checkout --detach v0.1', without
	having to create a dedicated branch for it.

> +The only problem is that if you create new commits while in detached
> +HEAD state, those commits won't be on a branch.

I would suggest rephrasing "The only problem" to "One caveat is" or
something.  When sightseeing and experimenting, the ability to
create throw-away commits without the need to clean them up later,
or to invent a unique name for a temporary branch, is not a problem.
It is an advantage.

> This makes those new
> +commits much harder to find later. Also, Git considers commits that
> +aren't on any branch (or a tag or other reference) to be garbage.
> +Git will eventually permanently delete those "garbage" commits during
> +garbage collection.

Correct.

Perhaps it is better to clarify this by adding "after you leave
the detached HEAD state" after "to find later".  While you are in
the detached HEAD state, you can run 'git log' to find the commits
you created there, as you can do everything you normally can on a
branch, or use 'git reflog @{now}' for that matter.

> +There are 3 main ways you can end up in detached HEAD state
> +unintentionally:
> +
> +1. `git checkout COMMIT_ID`, where `COMMIT_ID` is a commit ID
> +2. `git checkout v1.3`, where v1.3 is a tag name

These I wouldn't call "unintentionally".  They are documented and
supported ways to do so, and will remain to be so.  "unknowingly"
may be a more fair way to call these gotchas, though.

> +3. `git checkout origin/main`, where `origin/main` is
> +   a remote-tracking branch

This can happen when the user forgets to say "-t" ('git checkout -t
origin/main' dwims to 'git checkout -t -b main origin/main'), so it
is closer to 'unintentionally' than the above two.

> +Checking out a tag puts you in detached HEAD state because `HEAD` can
> +only be a branch or a commit, not a tag or any other reference.
> +So `git checkout TAG` will set HEAD to the commit for that tag.

Correct.

> +The easiest way to avoid accidentally ending up in detached HEAD state
> +is to use linkgit:git-switch[1] instead of linkgit:git-checkout[1] to
> +switch branches. `git switch` won't let you detach unless you explicitly
> +pass the `--detach` argument.

Correct, but the motivation to 'avoid accidentally ending up' may
want to be spelled out.  Most often checking out a tag is to go
sightseeing, where you do not want to 'avoid' detached HEAD.

> +To get back onto a branch, you can:
> +
> +1. Switch to the branch you want to be on, with `git switch BRANCHNAME`.
> +2. Create a new branch at the current commit, with `git switch -c BRANCHNAME`.
> +   You might want to do this if you've created new commits, so that you can
> +   find the commit later and so that it won't be garbage collected.

Very good.

> +If you create commits in detached HEAD state that aren't on a branch,
> +you can find them later using linkgit:git-reflog[1].

This, as you already said, is "much harder to find later" option.
There should be a better recovery option described here before
resorting to "git reflog HEAD" after you switched back.  E.g.,

    If you have created commits in detached HEAD state and then
    switched away from the state, all is not lost.  "git checkout"
    would have give you a warning message, like this:

	Warning: you are leaving 2 commits behind, not connected to
	any of your branches

	c816689 typofix the previous
	8e1bff5 decsribe detached HEAD state better

    You can create branches to keep them, e.g., "git branch saved c816689",
    by using the commit object names left there.

> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index 2aefea0228..4e9e94e24d 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -376,135 +376,8 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
>  [[DETACHED_HEAD]]
>  DETACHED HEAD
>  -------------
> +include::detached-head.adoc[]

Losing the diagrams is a bit concerning.  However, if the intention
is to have readers learn how HEAD refers to a branch pointing at a
commit with history structured as a DAG elsewhere in a more basic
concepts guide, I suspect that it would actually work better.  This
could even be reduced to a simple "see also" pointer to that other
guide.

If an existing user only uses 'switch' and never reads 'git help
checkout', they are already not seeing these diagrams, or perhaps
they learned the concepts elsewhere.  They still manage to
understand Git well enough to make use of it, so perhaps this
approach is OK.  I dunno.

> diff --git a/Documentation/gitdetachedhead.adoc b/Documentation/gitdetachedhead.adoc
> new file mode 100644
> index 0000000000..0aeecd159c
> --- /dev/null
> +++ b/Documentation/gitdetachedhead.adoc
> @@ -0,0 +1,14 @@
> +gitdetachedhead(7)
> +===============
> +
> +NAME
> +----
> +gitdetachedhead - How detached HEAD state works
> +
> +DESCRIPTION
> +-----------
> +include::detached-head.adoc[]

This may be good as a first step, but we may want to have more here
than what we show in "git help checkout" later.  If we miss the
pictures we lost from "git help checkout", it can be moved here.

Thanks.

> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/advice.c b/advice.c
> index 401d047391..43f86c2eaf 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -291,6 +291,7 @@ void detach_advice(const char *new_name)
>  	"\n"
>  	"  git switch -\n"
>  	"\n"
> +	"Run `git help detachedhead` to learn more.\n"
>  	"Turn off this advice by setting config variable advice.detachedHead to false\n\n");
>  
>  	fprintf(stderr, fmt, new_name);
> diff --git a/command-list.txt b/command-list.txt
> index 63ae2a67c9..313689335f 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -218,6 +218,7 @@ gitcore-tutorial                        guide
>  gitcredentials                          guide
>  gitcvs-migration                        guide
>  gitdatamodel                            guide
> +gitdetachedhead                         guide
>  gitdiffcore                             guide
>  giteveryday                             guide
>  gitfaq                                  guide
>
> base-commit: 5a7d1e8045ce66c908f62598e26cbb8df7b39a90
