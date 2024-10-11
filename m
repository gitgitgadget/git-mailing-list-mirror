Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB95194A73
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728685117; cv=none; b=hc/8fHsHBRDE5bw0PoKmK0IZKumuGOFCeVVnHt0YAPY0A2fggAol29uEGlZcDIltdPR2CUfwZ5OIn+qf6uRLIy3izLWEAa0g1RBRAiiMUT+jALF0DRy2fwvRnCTF5a1G/0ZQho0TI5ToDlQaiiA9ADZx+tLu3FFwbi+SuKgurT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728685117; c=relaxed/simple;
	bh=+T8fmX44k+928lO0cMM/1/r+5nA/+e5QlbTThY2kkkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=Le94nXL/sX5AvdGe3asZ0ZHePafil7D0ZChPrUBywKPHiEBrJySfpVkdE/h4+0e0kw8t8ZhM5/kmYmucelqfqNq3SpgVP2kiT1F39U1hl5tjyN3SGw17duYXs6GxPGwDgWQ6QncMC0eLFy8jJT4msMupu7P24HBOoBMTBbOncJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxbOewvF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxbOewvF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so1537590f8f.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728685113; x=1729289913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNXMNfUMtm5y+MdpSkE8wJ6Y5zva/KPXU3g5E/xST04=;
        b=ZxbOewvFR8DN1PrMNED9of9r7aVgk9KC7uXgCKIVOMJkYfkrx+zPGNDKq+iGKUnHJp
         Ud3R3btfYLNY5pvpcwcPI0TISMJNykTvJNE6w1StMmntB0LuQ+vnofgDmq3/FcBNJFO6
         PmmHtBLYhg1R1vT0143YpCr3rw+62/MZx4/UmhbzhxL0FiBigfroyn4ymt6wHdfD1BLz
         jGri5hgVpY3KmhR7Lgb0x9Gpq0Pyxuuc3Ntn+dUQ/ePCpltsdY0ZH4rK/3KUhcCHN6zq
         Riox+Sj0ZePARxlayEHu8Y3BnaK9K8zl4zt2//Wtbyse5i8/cgUet8jdNBVKrlFmeA6P
         LaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728685113; x=1729289913;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNXMNfUMtm5y+MdpSkE8wJ6Y5zva/KPXU3g5E/xST04=;
        b=tIqQXdPkWdg6yY26SuJ4QRrhK8boT/FTWLoglxjlVXOjnMVoaQYa+M3TqK6INbJCQT
         DL+q1Y6Z4V0q2MWcBMutUA3/WLMnCwMdnLz3bRUCH13E1ggoGhixrKUw0waLM6Ec9TL9
         GFKOisBzHqzXWr1NOVFrXO9Q9ucMvcLepLIpJ4AucgFNFLnzrDkCghGjfnrkKH1L3yTM
         amEiI/larcf6K4HbHlO60dCrVnQhAL30IyhELVdcbpqf3SIcPMpo8D6J33EYyYeMC/0L
         dVRhKCHDVncJxTgSVjNIy7Oqa+cJvIdhuvYKolEv7viAR+hUqEacs917MPeyOIxwMIjQ
         vP7A==
X-Gm-Message-State: AOJu0YwyGVxoSn3802oZ78Sc6yx4mjqFGop3Llg3UUDkY9IJQRahDznm
	eOzs/GiIHkXTPmtaivC7+PCqSsXfv9Q0XctR3Hyr2H5NWnBsvB8jdv84zdyHj4fudpGK3wEKzjn
	oVl5WKzzwlAJw1NPUfY4Hn8VSROcE3LcJ
X-Google-Smtp-Source: AGHT+IFBPNM9vw3KPuCuB8bdudEFFf3nVgMsckzb0ui1itZVTK72IN8wbf3MdRh7dHNRjMmKd+PTa3cD+JD41TVTqTI=
X-Received: by 2002:a5d:4f8f:0:b0:37d:387b:f080 with SMTP id
 ffacd0b85a97d-37d5519b99bmr3017147f8f.15.1728685113267; Fri, 11 Oct 2024
 15:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D4SO70M9Z1QI.1AC4QF9ZG8T4L@pm.me> <444a412d-bf4c-4bbe-8250-18d8bc86fd21@app.fastmail.com>
 <D4SQFBEB1HYZ.QDOLCYY80DIZ@pm.me> <517c8829-f98f-4fed-af4d-b84182fb253e@app.fastmail.com>
In-Reply-To: <517c8829-f98f-4fed-af4d-b84182fb253e@app.fastmail.com>
From: Patrick Callahan <pat.callahan1@gmail.com>
Date: Fri, 11 Oct 2024 18:17:57 -0400
Message-ID: <CACt=GQpQNvhuCJgkOcjefkaC+TToEMEp1V3Kt15t68zYpN0W4A@mail.gmail.com>
Subject: Re: `git worktree list` when bare repository is named `.git`
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:21=E2=80=AFPM Rebecca Turner <rbt@fastmail.com> =
wrote:
>
> > Why would you move the `.git` directory? If you're trying to move the
> > repository, then wouldn't you just move the directory that contains the
> > `.git` directory?
>
> Ah, I should give some context here. I'm using worktrees with the layout =
you
> describe later in your email:
>
>     my-repo/
>       .git/      <- bare git directory
>       main/      <- worktree for main branch
>       feature1/  <- worktree for feature work
>       ...
>
> I'm writing a tool to manage these layouts for you. I want to provide two
> features:
>
> 1. The ability to add a new worktree in a slightly more magical manner; i=
n
>    particular, I want to be able to do `git my-tool add feature2` and add=
 a new
>    worktree in the same directory as all the other worktrees.
>
>    For a non-bare main worktree, that directory is the parent of the main
>    worktree.
>
>    For a bare main worktree named `.git`, it's the path of the main
>    worktree. (Nothing in the `git worktree list` output indicates this is=
 the
>    case!)
>
>    For other bare worktrees, it's the parent of the main worktree.


 Rebecca,

I'm working on a tool to manage worktrees as well. Can we compare notes?
My directory structure separates repositories and worktrees in
separate directories, but the goals seem similar.

git documentation seems to treat the bare repository concept as if one
only uses bare repositories on a server, not locally in a development
environment.

But, I've found that local worktree-based development is possible for
multiple applications, libraries, toolchains, and CI, but it isn't
very easy to maintain by hand, so tooling is a must. With some
scripting, it works well for many bare repositories, numerous branch
worktrees, and multiple build-and-run scenarios. Switching between
tasks is almost instantaneous, with no need to stash or un-stash
anything.

I've managed to come up with a bash implementation with just three
commands for starting an editor/ide, building and running.  Parameters
to these commands set the context for whatever it is I'm working on at
the moment. I'm working on separate commands to maintain the
environment.  I need to do such things as clone an upstream repo,
clone

-Pat Callahan
 Framingham, Ma

Here's the list of requirements I'm working with:

Overview

- Use only bare repositories and worktrees
- Start an Ide, a build, a run for whatever I'm working on at the moment
- Support development work on multiple applications, libraries, or tools
- No limit to the number of working contexts.
- Instant focus on a specific context: a set of repositories,
git-references. and worktrees
- Instant switch between different working contexts within the same
application or between different applications.

Repositories

- Bare clones of a set of official and forked repositories from
Github, Gitlab, or Sourceforge
- Local Bare Repos Only
- All Repos in one directory as repo-name.git
- Worktrees as needed for building

Worktrees

- All Worktrees in another single directory as repo-name.git-reference
 (git reference being a branch, tag, or commit
- Worktree synchronization by git pull upstream, or git pull upstream --reb=
ase
- Directories
- Hierarchy as flat as possible
- Automatic setup of out-of-tree builds using symbolic links to one or
more worktrees

IDE or Code Editor support

- Automatic setup of multiple multi-root workspaces based on the list
of worktrees used to build a specific branch.

Building and Running

- A default build script and custom build scripts where appropriate
- A default application run script with custom run scripts where appropriat=
e
- Straightforward, flexible command line syntax
  Example: Build four separate cmake build types: Debug,
RelWithDebInfo for each of two branches

    b app-name branch-name1 branch-name-2 d rd r m
