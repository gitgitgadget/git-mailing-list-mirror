Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC815532A
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575101; cv=none; b=iiM4RC94mOZxDfk3BZN9Si2wytBd+Ay+bler6o91g+/hn7vqZ6jnYVJSyiLQ9/HLwxlS7Ade0efsFXGqNJcDgOgj6tmqd++vVyfcmk8N0qa5gCBhV7LVCL1lS7RVm+WVVebqxS4gpufskZCqdQ0VMHzMo5xaqZCDqZlRczUdCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575101; c=relaxed/simple;
	bh=LUAoWnAcvdoIrzIrTWSX6eCwbI6a7qXqbOQ3fUxjPyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlCWR4/kXdYw8so6ZiPRm9JEUIvhboMnV3hu1FO07Q+L65l7M9UV9+8jMJR8299oELdCj1lYlqwOVApBrg4YdvmzoaDQowgYVvyI8PW+1gCEJc9PI1PEkFjCpUI2UYAvABP8C/FUYPJhp600zWlnS+zYrxOXwleXI0pRthRFm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWkJhlsi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWkJhlsi"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c3c34e3c39so1964882a12.2
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725575098; x=1726179898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUAoWnAcvdoIrzIrTWSX6eCwbI6a7qXqbOQ3fUxjPyE=;
        b=ZWkJhlsiCtbVHmd33AYQMiciB9xbX7x43vXJupelO/doG7U4yqktoTq8R7mIhGldeh
         zYxXxaQ1P3Q9L9xvoNANA3b+aXiXYv7DR3yiQEcgi0V6GFv1uWRsZsIyJ1/iZDjqVBp1
         MmbYdjPG7oJUh60pUbRNpXF2nisa9StI78vvq0Zo3flJK6JxCED+mQh8blKnQkOL0prT
         2ktYM+FxC7c0dgvbqtfJ9GWlh1oENCNZGTiGM/F5oAmJr5ub1ruf+NgMoFKeCg6X7Jkc
         mP4uCc7g0kcq0QrELvVXgkbfJwzIlqJBTp4pLri2J/j1KyQW5NA+86uDUnHMTZ4u/rKI
         XeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725575098; x=1726179898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUAoWnAcvdoIrzIrTWSX6eCwbI6a7qXqbOQ3fUxjPyE=;
        b=hfjfhXz7zaSSkRWc2y21nSqeji7gLCzScu1dG0hU0EEdlIFMEVd94FzQFAtONclUhC
         0LkPkxH8CM9Jyk2ILsg1KME6FcUV6slmwBfOO6AaLL/ifE0zq83QPzuf+sHbFB5bTMUu
         JKkzAJoIZVjNAD7BIueG6SE68Dl/BS+dvPyeGRGCtEJwcWRG2IC0iMj6xuvJKGt/JROB
         KQbIA4T5+B1Sy0MwgkFMQR97ONaaHaAeO2PXlq7AodcbBIBYe/y+UapUVZYTTObHFxwt
         1xUm1wMC4dsf0BljXVbCLpa91/rnTYoREHOqCa9EQUD8h8VCG7DeW445q3sZ1Y1y4J5c
         CCqg==
X-Gm-Message-State: AOJu0Yz8D4oh9Rm1GuqtU2IcHfZjNxxCCt5Y38I5nijHeXaEobET8VwK
	qWTsAxZpoiE4MtO9KLrvqFESRie8vgreIHeKbcjSuaW6sc6BBReRkudBghcBqjsTzBiOHd2bb/4
	XfBinHvkx407RvRJVHL+uqrPJ3h9E6FZQ
X-Google-Smtp-Source: AGHT+IHXamlhtz5k7QnMCrscydb947uK/S3tY0K5u+jcorX6Htn7Wxvqkvas2Gf+pMjBZwa1XWxEQpuCXoQF5A8gKqg=
X-Received: by 2002:a17:907:2d9e:b0:a8a:7e62:8fd7 with SMTP id
 a640c23a62f3a-a8a8866b1c7mr44893866b.38.1725575097821; Thu, 05 Sep 2024
 15:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmR1y64OP+506JUO3Beic9kn5_TrhMQ1ZucVcDEn03noLg@mail.gmail.com>
 <612756e2-fc84-4d49-9f74-ff1998f66f7c@gmail.com>
In-Reply-To: <612756e2-fc84-4d49-9f74-ff1998f66f7c@gmail.com>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Fri, 6 Sep 2024 10:24:46 +1200
Message-ID: <CANrWfmS9PCKyK3X0rFnWfecrn-ETmcdtoPtA6j9QS7nTwfivKg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGBnaXQgcmVtb3RlIHNldC1icmFuY2hlcyAod2l0aG91dCAtLWFkZCkgPG5hbWU+IA==?=
	=?UTF-8?B?PGJyYW5jaD7igKYgYCBkb2VzIG5vdCBhZGQgcmVmc3BlY3MgdG8gYHJlbW90ZS48cmVtb3RlPi5mZXRj?=
	=?UTF-8?B?aGAgd2hlbiBgcmVtb3RlLjxyZW1vdGU+LmZldGNoYCBkb2VzIG5vdCBleGlzdA==?=
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A way to get into the state is `git remote set-branches <remote>`
(followed by zero <branch>es), which removes `remote.server.fetch`
configuration variable. After that, `git remote set-branches <remote>
<branch>=E2=80=A6` does not work. (But `git remote set-branches --add` can =
be
used to get out of the corrupted state.)

Shortened version of the example:
git remote add server git@example.com
git config list --local
git remote set-branches server
git config list --local
git remote set-branches server branch1 branch2
git config list --local

On Thu, Sep 5, 2024 at 9:07=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> On 03/09/2024 11:37, Han Jiang wrote:
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
>
> It is always helpful to show how to reproduce a bug but please try and
> aim for a minimal reproduction recipe. It is much easier to follow if
> you show which output lines come from which command. In this case one
> can reproduce the issue with
>
> $ git remote add test git@example.com
> $ git config --get-all remote.test.fetch
> +refs/heads/*:refs/remotes/test/*
> $ git config --unset-all remote.test.fetch
> $ git config --get-all remote.test.fetch
> $ git remote set-branches test main topic
> $ git config --get-all remote.test.fetch
>
> I haven't looked into what causes this. I wonder how likely users are to
> be affected - how did you get into a state where there was no fetch
> refspec set for your remote?
>
> Best Wishes
>
> Phillip
>
> > cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd =
"$_";
> > mkdir --parents -- './server' './client';
> > git -C './client' init './repo'
> > git -C './client/repo' remote --verbose
> > git -C './client/repo' config list --local --show-scope --show-origin
> > git -C './client/repo' remote add server 'file://'"$(realpath
> > './server/repo.git')"
> > git -C './client/repo' remote --verbose
> > git -C './client/repo' config list --local --show-scope --show-origin
> > git -C './client/repo' remote set-branches server branch1 branch2
> > git -C './client/repo' config list --local --show-scope --show-origin
> > git -C './client/repo' remote set-branches --add server branch3 branch4
> > git -C './client/repo' config list --local --show-scope --show-origin
> > git -C './client/repo' remote set-branches --add server branch3 branch4
> > git -C './client/repo' config list --local --show-scope --show-origin
> > git -C './client/repo' remote set-branches server
> > git -C './client/repo' config list --local --show-scope --show-origin
> > git -C './client/repo' remote set-branches server branch1 branch2
> > git -C './client/repo' config list --local --show-scope --show-origin
> > git -C './client/repo' remote set-branches --add server branch3 branch4
> > git -C './client/repo' config list --local --show-scope --show-origin
> > git -C './client/repo' remote set-branches --add server branch3 branch4
> > git -C './client/repo' config list --local --show-scope --show-origin
> >
> > What did you expect to happen? (Expected behavior)
> >
> > (local config has branch1 and branch2:)
> > remote.server.fetch=3D+refs/heads/branch1:refs/remotes/server/branch1
> > remote.server.fetch=3D+refs/heads/branch2:refs/remotes/server/branch2
> > remote.server.fetch=3D+refs/heads/branch3:refs/remotes/server/branch3
> > remote.server.fetch=3D+refs/heads/branch4:refs/remotes/server/branch4
> > remote.server.fetch=3D+refs/heads/branch3:refs/remotes/server/branch3
> > remote.server.fetch=3D+refs/heads/branch4:refs/remotes/server/branch4
> >
> > What happened instead? (Actual behavior)
> >
> > (local config does not have branch1 and branch2:)
> > remote.server.fetch=3D+refs/heads/branch3:refs/remotes/server/branch3
> > remote.server.fetch=3D+refs/heads/branch4:refs/remotes/server/branch4
> > remote.server.fetch=3D+refs/heads/branch3:refs/remotes/server/branch3
> > remote.server.fetch=3D+refs/heads/branch4:refs/remotes/server/branch4
> >
> > What's different between what you expected and what actually happened?
> >
> > Anything else you want to add:
> >
> > Please review the rest of the bug report below.
> > You can delete any lines you don't wish to share.
> >
> >
> > [System Info]
> > git version:
> > git version 2.46.0.windows.1
> > cpu: x86_64
> > built from commit: 2e6a859ffc0471f60f79c1256f766042b0d5d17d
> > sizeof-long: 4
> > sizeof-size_t: 8
> > shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> > feature: fsmonitor--daemon
> > libcurl: 8.9.0
> > OpenSSL: OpenSSL 3.2.2 4 Jun 2024
> > zlib: 1.3.1
> > uname: Windows 10.0 22631
> > compiler info: gnuc: 14.1
> > libc info: no libc information available
> > $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bas=
h.exe
> >
> >
> > [Enabled Hooks]
> > not run from a git repository - no hooks to show
> >
