Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C935674D
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966132; cv=none; b=YFPF5QHE8tb6iOSkMCwGx7DATwy4As1d3rFCXSdZPt1RtWHMsKPF/IOmw2Wbz80gs2eFMvrWuXHpneFr+4UeoPCiBrPBN3madLikmij/v2fB0scu7NFiH6TDLGrUdmpLXE0fimpEB+dRAgtc1X+dbFVZK+eKvmQL5Oj9BXaBNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966132; c=relaxed/simple;
	bh=yTbbN3o151l5asDlt0qWjWD+K6uYxIeXpN0VuEw98xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFfkoINWNYUoGz21EYYWoVZs8cp3OQJpKLJ0tgThBkBjSUUrHv5ZPLAT8iqnxFEizVzV60CZRg/fRg4XWmcJLT40xLS324mIoaquG1IC3eRaRjwMlFccWWWzxU8cgSsop+dznC8KlbJGZ594ZVFmwYvoTN9y+G8QBDpQmwphPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXqNvbg1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXqNvbg1"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so205439966b.1
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725966128; x=1726570928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTbbN3o151l5asDlt0qWjWD+K6uYxIeXpN0VuEw98xU=;
        b=hXqNvbg1r6QHPndyog+vg0X8X+v1YAfjsvW35/HjYVVjJf2HdEdxXPDN/EaHg4QChr
         ARX3v8gonvZjjKgOns1wcISl6DzYyOTKauGa3D6hAzbEPMNayZII3U18Vp3yf3koMqT0
         Xc6qG16P3iDOFaJh9/pYitDD473RdTDNpt6/XLDuoksEB36y6xgfyD+9RC74bPcAEdfa
         BQGByksychVwh5yAEzhUrOZDcIRESUVJS5u7WWtu7dbcE1nZmnhiuGzgMKRV7XIbf4bc
         pmw/m9tO7iOjbmKURhA4Iz+c1b+sgtoaoVEh3xeneoFThvFEm9ubmQo5cZ//AG/jPwL8
         vVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725966128; x=1726570928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTbbN3o151l5asDlt0qWjWD+K6uYxIeXpN0VuEw98xU=;
        b=vwlW3QI8ih8cIRuDm2PGT6/aAk5D7cxJ6QrN0MqNiYqZ3A/rqXZ9bWpR7sQuu3OVAX
         6UMrNr02txJlJ+0Xv6fnkoRw0h1eViFulacA2y/C3JJhcbBIvBSsKiUazwNbvrEYQ+iv
         tPpztP28gnNhaRxQwS1U4cEh81QMv47PtnaHxRSpVw0thS7Jwt7FW4/ktb91FvrND4+o
         WPpJKaJ4hUWWWrBmztMM6Ytp7WV3+XP6JFwfXlxQABaj4bB143F4OtIEGALs3VGPGLmk
         VuoPc4XKm0Dcc6HeZgtC55KqGB8fvwTSllFXQt6GWQAyFXz9wLm7GeqVlVKfzBW81sLQ
         12dw==
X-Gm-Message-State: AOJu0YypLYjOYq38yrQrB+3+I7Z42pUuINrUyhIUc3/tP6VaUmSaYlQ5
	2LUGF6j65DfKIQI8XNTrHGrpB+/knWllXf9Nd7GcGMq8P5lvhjp7L6aFNqvb4c2k59ITfDfjF4Y
	QugvmgRkaQIIvGFsOe1Hld9sb3hA=
X-Google-Smtp-Source: AGHT+IE2umP+jRhPz0AH7cwLLAvM3kTtbA4fUEjt6YCsx1ztl06uYDfcJJ0VGy0Md09V7AsbPM4LKiXOpuk7/WdVp8E=
X-Received: by 2002:a17:907:2d22:b0:a8d:51a7:d5e8 with SMTP id
 a640c23a62f3a-a8ffaac0998mr41154366b.15.1725966127645; Tue, 10 Sep 2024
 04:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmR1y64OP+506JUO3Beic9kn5_TrhMQ1ZucVcDEn03noLg@mail.gmail.com>
 <612756e2-fc84-4d49-9f74-ff1998f66f7c@gmail.com> <CANrWfmS9PCKyK3X0rFnWfecrn-ETmcdtoPtA6j9QS7nTwfivKg@mail.gmail.com>
 <20fc64ed-24a1-45c0-928f-ddb4c6106262@gmail.com>
In-Reply-To: <20fc64ed-24a1-45c0-928f-ddb4c6106262@gmail.com>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Tue, 10 Sep 2024 23:01:56 +1200
Message-ID: <CANrWfmS4EHQU9pHH9t1kk6hq9E=W6uqi48CAvYgNnzSY-wkVTg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGBnaXQgcmVtb3RlIHNldC1icmFuY2hlcyAod2l0aG91dCAtLWFkZCkgPG5hbWU+IA==?=
	=?UTF-8?B?PGJyYW5jaD7igKYgYCBkb2VzIG5vdCBhZGQgcmVmc3BlY3MgdG8gYHJlbW90ZS48cmVtb3RlPi5mZXRj?=
	=?UTF-8?B?aGAgd2hlbiBgcmVtb3RlLjxyZW1vdGU+LmZldGNoYCBkb2VzIG5vdCBleGlzdA==?=
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's good to hear that the bug could get a fix! Looking forward to it!
The documentation does not say the expected behavior of that, so it's
under-specified whether it's a feature or a bug.

On Mon, Sep 9, 2024 at 9:13=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> On 05/09/2024 23:24, Han Jiang wrote:
> > A way to get into the state is `git remote set-branches <remote>`
> > (followed by zero <branch>es), which removes `remote.server.fetch`
> > configuration variable.
>
> Oh, I wonder if that is a feature or a bug? I see we don't sanity check
> the branch name either so we'll happily create refspecs containing any
> old rubbish. I'll send a patch series that fixes the original bug and
> checks the branch names later this week.
>
> Best Wishes
>
> Phillip
>
> > After that, `git remote set-branches <remote>
> > <branch>=E2=80=A6` does not work. (But `git remote set-branches --add` =
can be
> > used to get out of the corrupted state.)
> >
> > Shortened version of the example:
> > git remote add server git@example.com
> > git config list --local
> > git remote set-branches server
> > git config list --local
> > git remote set-branches server branch1 branch2
> > git config list --local
> >
> > On Thu, Sep 5, 2024 at 9:07=E2=80=AFPM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> >>
> >> On 03/09/2024 11:37, Han Jiang wrote:
> >>> Thank you for filling out a Git bug report!
> >>> Please answer the following questions to help us understand your issu=
e.
> >>>
> >>> What did you do before the bug happened? (Steps to reproduce your iss=
ue)
> >>
> >> It is always helpful to show how to reproduce a bug but please try and
> >> aim for a minimal reproduction recipe. It is much easier to follow if
> >> you show which output lines come from which command. In this case one
> >> can reproduce the issue with
> >>
> >> $ git remote add test git@example.com
> >> $ git config --get-all remote.test.fetch
> >> +refs/heads/*:refs/remotes/test/*
> >> $ git config --unset-all remote.test.fetch
> >> $ git config --get-all remote.test.fetch
> >> $ git remote set-branches test main topic
> >> $ git config --get-all remote.test.fetch
> >>
> >> I haven't looked into what causes this. I wonder how likely users are =
to
> >> be affected - how did you get into a state where there was no fetch
> >> refspec set for your remote?
> >>
> >> Best Wishes
> >>
> >> Phillip
> >>
> >>> cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; c=
d "$_";
> >>> mkdir --parents -- './server' './client';
> >>> git -C './client' init './repo'
> >>> git -C './client/repo' remote --verbose
> >>> git -C './client/repo' config list --local --show-scope --show-origin
> >>> git -C './client/repo' remote add server 'file://'"$(realpath
> >>> './server/repo.git')"
> >>> git -C './client/repo' remote --verbose
> >>> git -C './client/repo' config list --local --show-scope --show-origin
> >>> git -C './client/repo' remote set-branches server branch1 branch2
> >>> git -C './client/repo' config list --local --show-scope --show-origin
> >>> git -C './client/repo' remote set-branches --add server branch3 branc=
h4
> >>> git -C './client/repo' config list --local --show-scope --show-origin
> >>> git -C './client/repo' remote set-branches --add server branch3 branc=
h4
> >>> git -C './client/repo' config list --local --show-scope --show-origin
> >>> git -C './client/repo' remote set-branches server
> >>> git -C './client/repo' config list --local --show-scope --show-origin
> >>> git -C './client/repo' remote set-branches server branch1 branch2
> >>> git -C './client/repo' config list --local --show-scope --show-origin
> >>> git -C './client/repo' remote set-branches --add server branch3 branc=
h4
> >>> git -C './client/repo' config list --local --show-scope --show-origin
> >>> git -C './client/repo' remote set-branches --add server branch3 branc=
h4
> >>> git -C './client/repo' config list --local --show-scope --show-origin
> >>>
> >>> What did you expect to happen? (Expected behavior)
> >>>
> >>> (local config has branch1 and branch2:)
> >>> remote.server.fetch=3D+refs/heads/branch1:refs/remotes/server/branch1
> >>> remote.server.fetch=3D+refs/heads/branch2:refs/remotes/server/branch2
> >>> remote.server.fetch=3D+refs/heads/branch3:refs/remotes/server/branch3
> >>> remote.server.fetch=3D+refs/heads/branch4:refs/remotes/server/branch4
> >>> remote.server.fetch=3D+refs/heads/branch3:refs/remotes/server/branch3
> >>> remote.server.fetch=3D+refs/heads/branch4:refs/remotes/server/branch4
> >>>
> >>> What happened instead? (Actual behavior)
> >>>
> >>> (local config does not have branch1 and branch2:)
> >>> remote.server.fetch=3D+refs/heads/branch3:refs/remotes/server/branch3
> >>> remote.server.fetch=3D+refs/heads/branch4:refs/remotes/server/branch4
> >>> remote.server.fetch=3D+refs/heads/branch3:refs/remotes/server/branch3
> >>> remote.server.fetch=3D+refs/heads/branch4:refs/remotes/server/branch4
> >>>
> >>> What's different between what you expected and what actually happened=
?
> >>>
> >>> Anything else you want to add:
> >>>
> >>> Please review the rest of the bug report below.
> >>> You can delete any lines you don't wish to share.
> >>>
> >>>
> >>> [System Info]
> >>> git version:
> >>> git version 2.46.0.windows.1
> >>> cpu: x86_64
> >>> built from commit: 2e6a859ffc0471f60f79c1256f766042b0d5d17d
> >>> sizeof-long: 4
> >>> sizeof-size_t: 8
> >>> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> >>> feature: fsmonitor--daemon
> >>> libcurl: 8.9.0
> >>> OpenSSL: OpenSSL 3.2.2 4 Jun 2024
> >>> zlib: 1.3.1
> >>> uname: Windows 10.0 22631
> >>> compiler info: gnuc: 14.1
> >>> libc info: no libc information available
> >>> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\b=
ash.exe
> >>>
> >>>
> >>> [Enabled Hooks]
> >>> not run from a git repository - no hooks to show
> >>>
