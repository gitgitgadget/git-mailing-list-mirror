Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0E85F844
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707590568; cv=none; b=sFo8DfCH/YhJ8fQNLzYv9ims9pPCgqRHN9Q3i6KQ2rHefg7U+mKvOUl1E8HjPy7mxpT6eCckQzMLRiPZMcrxIQa3AHgWsXTKbTglXi0R9CkBm3t1rNE7SGHcbXnZjxqFU6uMNXxLvR+qFNBKL41gBV5R41RbyeOu1GASABxJ10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707590568; c=relaxed/simple;
	bh=9tMfKGSj/90NHxeg+0j5bNb9Vd5nSpa/g6He4anynYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deQR+qGaWqR2MDzuQzwmHubnTVM7NMW8UD33k9+DRCHM/yUfxXJTjupEdXnKAHgZwET1nlzW9JDvQVAsf4WSnnOPtzEJdiLaUWSuQFW7a4KAUVapv1PT7td8Rcb+i+7yQMny4DUejDl0MegqHLZmK4/CwVnTLKwqZ95ao+ka3Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWvhRql6; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWvhRql6"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso21731431fa.3
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 10:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707590564; x=1708195364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Hcs3hSHIscuZV6p4k0jIfxcdKAprGzJ8ylKG30k/GY=;
        b=VWvhRql6V9umWugOpDFiLWXz2/E5L8OGnrAvOCyrm6By34/Lnbr9aoqoOjLrFU6bZB
         7I0w2XEBaj3MdeQM+DNCrVPJsLhuY2QD1C5Sfvucrp1fNynJLWJ0yQp3lZ26J1EU8TyK
         BU1my6CHkO+U1Amr05dmWMznqQSJSSAMaOLEzW/sURJhlRscY6CbUVKIH3qErBFAyAkk
         De+fQ7J1BMub/YSXEugGjDLNcWyJlcfx8lmV2HgC/Ca7VA0rwv5QsBR19RpRN5hNMcoN
         S4Tw60EFnOp4Kkhlx2I2LqYmbLO0y8SI6bRChaQW9TLWfwGVdxfHSAG6mYeHJe6gjA/G
         tAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707590564; x=1708195364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Hcs3hSHIscuZV6p4k0jIfxcdKAprGzJ8ylKG30k/GY=;
        b=FP4lBzzQnL6tKVKtDVKfho74SXKgrqEXSFv1CAdPR4Vlo0cGqahzIroJRCdd9YPLER
         3mV3qmbEEfEDWjpA7fBsbsXMTnzstmdPJ73t911h2IHKxrCf8AP3VRDB3uxdmj9i6j4Z
         Fxiy2gabLzTe3fiY9VYYZcqCfFpQdh+Srj+rKDaFenBz7PbFekvYViW4ObWE+lq8v2mJ
         bj5CmAFsWdzLs26Ah7UmWphCYJeusjZ9ONPdXWhKhkKXJMiU4iSm+8J+j28TwGaHrwVo
         MIVNzvFG7l5F7c7nk2UMSVpfzit8LIo5IHQqlxHVeWVQmIA61NUdQ91EAcqfD/fGG14U
         r6wQ==
X-Gm-Message-State: AOJu0Yw57C9LXsI4ydrJ44C7suIFuKLNl2lGoegkZUDDttrF7DXPAKOA
	4vvlHg/Hf2PFQR5ed2nk3nqpT5D7cNEeKsgkoT1NIUwfOahqatWN9TcWluBHfND8eQ4pFnvvczd
	mDXY1tgRebLB0qDI9V2uluAIF7gx5tPyQ0MkpTSfz
X-Google-Smtp-Source: AGHT+IEyIdHQf26djVPfnumB5bhFJ28pp7jlAt+ilrWNv1u06PHUzt21uljx+FDzxD5zF2S4RFzjxAXrrcpMi3w21jY=
X-Received: by 2002:a05:651c:124b:b0:2d0:de6f:c697 with SMTP id
 h11-20020a05651c124b00b002d0de6fc697mr1504846ljh.13.1707590564070; Sat, 10
 Feb 2024 10:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7MZG1MeeS5QNPog9oS+MbdKpkDXu61eVOszsC20Q=ik+Ng=g@mail.gmail.com>
 <m05xyw9r92.fsf@epic96565.epic.com>
In-Reply-To: <m05xyw9r92.fsf@epic96565.epic.com>
From: Vijay Raghavan Aravamudhan <avijayr@gmail.com>
Date: Sun, 11 Feb 2024 00:12:32 +0530
Message-ID: <CAK7MZG29+Cy-7SJnWayro_5GGEe3iZLysQqVaATLz8GLtEtA5A@mail.gmail.com>
Subject: Re: git status became very slow after upgrading git
To: Sean Allred <allred.sean@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for responding. I have run the command that you gave on an open
source repo so that its easy for you to replicate. The remote url is:
https://github.com/vraravam/ferdium-app

The output is:
 =EF=85=B9 =EE=82=B0 =EF=81=BC ~/d/o/ferdium =EE=82=B0 on =EF=84=93 =EF=84=
=A6 develop =EE=82=B0 GIT_TRACE=3D1 GIT_TRACE_SETUP=3D1
GIT_TRACE_PERFORMANCE=3D1 git status
00:08:15.548976 trace.c:314             setup: git_dir: .git
00:08:15.550590 trace.c:315             setup: git_common_dir: .git
00:08:15.550600 trace.c:316             setup: worktree:
/Users/vijay/dev/oss/ferdium
00:08:15.550604 trace.c:317             setup: cwd: /Users/vijay/dev/oss/fe=
rdium
00:08:15.550611 trace.c:318             setup: prefix: (null)
00:08:15.550707 chdir-notify.c:70       setup: chdir from
'/Users/vijay/dev/oss/ferdium' to '/Users/vijay/dev/oss/ferdium'
00:08:15.550723 git.c:463               trace: built-in: git status
00:08:15.552184 read-cache.c:2386       performance: 0.000183000 s:
read cache .git/index
00:08:15.555964 read-cache.c:1629       performance: 0.003696000 s:
refresh index
00:08:15.556442 diff-lib.c:273          performance: 0.000132000 s:  diff-f=
iles
00:08:15.558558 unpack-trees.c:2004     performance: 0.000019000 s:
traverse_trees
00:08:15.558801 unpack-trees.c:438      performance: 0.000003000 s:
check_updates
00:08:15.558813 unpack-trees.c:2096     performance: 0.000394000 s:
unpack_trees
00:08:15.558819 diff-lib.c:638          performance: 0.000524000 s:  diff-i=
ndex
00:08:15.559166 name-hash.c:613         performance: 0.000148000 s:
initialize name hash
On branch develop
Your branch is up to date with 'origin/develop'.

00:08:15.567249 run-command.c:657       trace: run_command:
GIT_INDEX_FILE=3D.git/index git submodule summary --cached --for-status
--summary-limit -1 HEAD
00:08:15.833334 git.c:749               trace: exec: git-submodule
summary --cached --for-status --summary-limit -1 HEAD
00:08:15.834114 run-command.c:657       trace: run_command:
git-submodule summary --cached --for-status --summary-limit -1 HEAD
00:08:16.880778 trace.c:414             performance: 0.000013000 s:
git command: git --exec-path
00:08:18.216639 git.c:463               trace: built-in: git rev-parse --gi=
t-dir
00:08:18.218740 trace.c:414             performance: 0.002132000 s:
git command: git rev-parse --git-dir
00:08:18.489025 git.c:463               trace: built-in: git rev-parse
--git-path objects
00:08:18.490677 trace.c:414             performance: 0.001675000 s:
git command: git rev-parse --git-path objects
00:08:19.031080 git.c:463               trace: built-in: git rev-parse
--show-prefix
00:08:19.032882 trace.c:414             performance: 0.001827000 s:
git command: git rev-parse --show-prefix
00:08:19.296074 git.c:463               trace: built-in: git rev-parse
--show-toplevel
00:08:19.297559 trace.c:414             performance: 0.001504000 s:
git command: git rev-parse --show-toplevel
00:08:19.830285 trace.c:314             setup: git_dir: .git
00:08:19.830972 trace.c:315             setup: git_common_dir: .git
00:08:19.830981 trace.c:316             setup: worktree:
/Users/vijay/dev/oss/ferdium
00:08:19.830984 trace.c:317             setup: cwd: /Users/vijay/dev/oss/fe=
rdium
00:08:19.830990 trace.c:318             setup: prefix: (null)
00:08:19.830994 git.c:463               trace: built-in: git
submodule--helper summary --cached --for-status -n -1 -- HEAD
00:08:19.834629 read-cache.c:2386       performance: 0.000164000 s:
read cache .git/index
00:08:19.834914 unpack-trees.c:2004     performance: 0.000024000 s:
traverse_trees
00:08:19.834932 unpack-trees.c:438      performance: 0.000003000 s:
check_updates
00:08:19.834940 unpack-trees.c:2096     performance: 0.000157000 s:
unpack_trees
00:08:19.834958 diff-lib.c:638          performance: 0.000307000 s:  diff-i=
ndex
00:08:19.834975 trace.c:414             performance: 0.005922000 s:
git command: git submodule--helper summary --cached --for-status -n -1
-- HEAD
00:08:19.836137 trace.c:414             performance: 4.003693000 s:
git command: /opt/homebrew/opt/git/libexec/git-core/git submodule
summary --cached --for-status --summary-limit -1 HEAD
00:08:19.836842 run-command.c:657       trace: run_command:
GIT_INDEX_FILE=3D.git/index git submodule summary --files --for-status
--summary-limit -1
00:08:20.106802 git.c:749               trace: exec: git-submodule
summary --files --for-status --summary-limit -1
00:08:20.107638 run-command.c:657       trace: run_command:
git-submodule summary --files --for-status --summary-limit -1
00:08:21.162243 trace.c:414             performance: 0.000006000 s:
git command: git --exec-path
00:08:22.496146 git.c:463               trace: built-in: git rev-parse --gi=
t-dir
00:08:22.497722 trace.c:414             performance: 0.001589000 s:
git command: git rev-parse --git-dir
00:08:22.764795 git.c:463               trace: built-in: git rev-parse
--git-path objects
00:08:22.766763 trace.c:414             performance: 0.001991000 s:
git command: git rev-parse --git-path objects
00:08:23.304626 git.c:463               trace: built-in: git rev-parse
--show-prefix
00:08:23.306436 trace.c:414             performance: 0.001833000 s:
git command: git rev-parse --show-prefix
00:08:23.575506 git.c:463               trace: built-in: git rev-parse
--show-toplevel
00:08:23.577138 trace.c:414             performance: 0.001656000 s:
git command: git rev-parse --show-toplevel
00:08:24.111335 trace.c:314             setup: git_dir: .git
00:08:24.112123 trace.c:315             setup: git_common_dir: .git
00:08:24.112138 trace.c:316             setup: worktree:
/Users/vijay/dev/oss/ferdium
00:08:24.112142 trace.c:317             setup: cwd: /Users/vijay/dev/oss/fe=
rdium
00:08:24.112149 trace.c:318             setup: prefix: (null)
00:08:24.112154 git.c:463               trace: built-in: git
submodule--helper summary --files --for-status -n -1 --
00:08:24.113679 read-cache.c:2386       performance: 0.000216000 s:
read cache .git/index
00:08:24.117811 diff-lib.c:273          performance: 0.004115000 s:  diff-f=
iles
00:08:24.117838 trace.c:414             performance: 0.007389000 s:
git command: git submodule--helper summary --files --for-status -n -1
--
00:08:24.118895 trace.c:414             performance: 4.013083000 s:
git command: /opt/homebrew/opt/git/libexec/git-core/git submodule
summary --files --for-status --summary-limit -1
nothing to commit, working tree clean
00:08:24.119646 trace.c:414             performance: 8.571954000 s:
git command: git status

Hope this helps. Also, I noticed that the same repo, same versions of
all tools, etc - this issue only occurs on my M2 mac, but works
without any slowness on the intel mac.

On Sat, Feb 10, 2024 at 10:43=E2=80=AFPM Sean Allred <allred.sean@gmail.com=
> wrote:
>
>
> Vijay Raghavan Aravamudhan <avijayr@gmail.com> writes:
>
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > 1. brew update which pulled in latest version of git
> > 2. git status in a repository (without submodules)
> >
> > What did you expect to happen? (Expected behavior)
> > git status should have been fast
> >
> > What happened instead? (Actual behavior)
> > git status takes almost 5s to complete.
>
> Thanks for the report. This isn't a whole lot of information to go on.
> At least, I'm not able to reproduce locally with a trivial repository:
>
>     git init
>     echo foo > file
>     git add file
>     git commit -mtest
>     git status
>
> If you're able to reproduce, can you re-run `git status` with tracing
> enabled and provide your output?
>
>     GIT_TRACE=3D1 GIT_TRACE_SETUP=3D1 GIT_TRACE_PERFORMANCE=3D1 git statu=
s
>
> If you can provide reproduction instructions that start with `git init`,
> that would also help. It may take some time for you, but it'll take less
> time than folks on this list taking shots in the dark :-)
>
> --
> Sean Allred



--=20
You can visit my Github Profile to get to know what I work on outside
of my day job
