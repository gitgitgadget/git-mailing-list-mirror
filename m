Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C265183CD3
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493966; cv=none; b=JjSm6ATR8v8b28ujwVpEBKXqJTE97Y4qoGcZIgeTf+pNYX90xcotvN3YqKuljNAl7jxfC8PH9fbdAjxhcHWbP28kjvbxrI0RsKWzNMqiMJX3VBZVpfrGqpgoke4+qINTipidhliQlT6gwOt/rpx8m/jF49pH+mEXPfMvX029L8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493966; c=relaxed/simple;
	bh=c7xNvua18D1IzvQ7uMoGEoWwGPH+FZ5aeOZK5H0MlMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uI/DtT1v9jM4omUzXwQ8lnmc/OIDCdgMoGegb31UkJuz96AJQYFg5A89FjIHP3igcJxk5iBhciCximeCmT1ZBUtWp+KsENHMPl2wBQqaNnnL8zJ35SirrHy2FUkZedP3pv1IFJvZyyTPhzsiNKKP/jIBcr2yOK6aqOZdcChiE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax9BQmOk; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax9BQmOk"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f4f24263acso4076631fa.0
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 16:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725493963; x=1726098763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xERfdzFoKDyDgLUIbXMdJLGNxzf7BYraciTCfbivP1o=;
        b=ax9BQmOkIZsH4o7NzGrw1s59/dzHzn3L6LtIOKyTj0An67zBjimS7r7vvKhcOfTlUf
         tZ5SsGIWzfc13Fe2PIXPv5OCAmg126oV7CDRV0O6Skm+RQa7TWZVeVpt9Sk2rzaJSEjr
         bgc/5PKwOGtz2B5RxjH3H/ZQnbYdDt0yApnI7Gu0bkdQ06gv5SJjfxz7VVhk/knJCI2b
         GJKfqBNcG5YxvHn/KUlKYjEvvR08K6PI3p8EB3iP4/Kloyve5lt+eMpZRQl+Tk1S3D1Z
         EtBWFdNyr/eU+bhuwq8E8fLcQEgP7BaGK5lCB5DWu22AVX5ad0QQ5csqQ1WfTqwb8knz
         S4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725493963; x=1726098763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xERfdzFoKDyDgLUIbXMdJLGNxzf7BYraciTCfbivP1o=;
        b=R+oS75WmY+MnAwgh8Zdl3I50QrukyQiJCtg2aM82xpFxu0Da9syJVwDq2WiMu0bPJE
         iK7ICfbf98P9KAeQ6HlYmSL26EtkbTjn0BA3vqeuzB+KWUs+0IYr/HcI+zaC5NxuPGZg
         a+I2AtSMDoeCqJBfUEPh7PreyTM1/dNtQJzGrn+iS6wL/c7B5u5YWLg5bch/zJ3/m0vR
         ZS1m3it/q+nkNaC+XnJJ23mxuTLKhhni/LwL4W9ZjWcjPMCGQ8/yhEAzLi3j1nq4FLyU
         LM5GUs+FX8COWb7Kh5+1ZZnsLZL3AA49vB9CB1Oo50Zm4oNHE80OzhCrUEuOWJa2pDfV
         gDIg==
X-Forwarded-Encrypted: i=1; AJvYcCUhitw+ht2pjLjTES9z+7DBVMEcp8TKxXg029c9Zb6wviTZVbMm0IGUAyedM7JksGCnWpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqAO59UP7QmOFJqyu2I5V2jSPvEELGVWHOMtyhGzfmrAnXzjKI
	mMymgY/nJXe1GS/agSrJcPVvITiYKuMKtIvtF68slCgkIyo8ybPp/4QlbddfPy5PXyZF9T+fUPw
	XYjyeYlqRQWF5Jg2A5Zotw76pgEEOOlrED18=
X-Google-Smtp-Source: AGHT+IEmz8ZS27qZgHAT4weHQGcH72lQLjn5h6+nK2GE19nwTl7nPJF2sTIvleM7A5Llchacjvec+EWV65jTlz2a1zo=
X-Received: by 2002:a2e:a590:0:b0:2f3:cb70:d447 with SMTP id
 38308e7fff4ca-2f6108ad85amr202518651fa.40.1725493962099; Wed, 04 Sep 2024
 16:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmSe0ekbRR9VsX8jALWQQVdhDv-2WTSm47jHTiV9-Z7-pg@mail.gmail.com>
 <a33a73f7-e6dd-4f97-a635-c6c5dfcadeb1@kdbg.org> <CANrWfmRdz1Xxud=f0GWrc=nURV2xZU8Wm=8u2X+W4tL4d-yeTg@mail.gmail.com>
 <562614e4-5384-4220-896a-20b3f79771bd@kdbg.org> <xmqq5xrbbc36.fsf@gitster.g>
In-Reply-To: <xmqq5xrbbc36.fsf@gitster.g>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Thu, 5 Sep 2024 11:52:31 +1200
Message-ID: <CANrWfmQCBwjzydyBFJ5OTE7E7EJFFmht-Qz54hin0UZd1LKXCQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=60git_fetch_=2D=2Drefmap=3D=3Crefspec=3E=E2=80=A6_=3Crepository=3E_=3Cr?=
	=?UTF-8?Q?efspec=3E=E2=80=A6_=60_providing_NON=2Dempty_=3Crefspec=3E_to_the_=2D=2Drefmap_A?=
	=?UTF-8?Q?LSO_causes_Git_to_ignore_the_configured_refspecs?=
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> But then in section "Configured Remote-tracking Branches" it is said that
The problem with the doc is "how to override". From
https://git-scm.com/docs/git-fetch#Documentation/git-fetch.txt---refmapltre=
fspecgt
it seems we need to `git fetch --refmap=3D'' --refmap=3D<refspec>` to
really override configuration variables.
I guess the inner working is like this: first for-loop traverses
configuration variable `remote.<remote>.fetch` collecting <refspec>s
into a list, then second for-loop traverses `--refmap=3D<refspec>`s,
clears the list when an empty string is encountered, appends to the
list when a non-empty string is encountered. Maybe I'm just
daydreaming...

> git fetch --refmap=3D"" foo bar baz
I think the correct use case of empty string, is to specify more
--refmap=3D<refspec>s after it (like in
https://git-scm.com/docs/git-config#Documentation/git-config.txt-pushpushOp=
tion
), otherwise the mapping (to operate upon foo,bar and baz) would be
empty.

Sorry that I didn't use examples to express my intended use scenarios clear=
ly!

After I searched "empty value" or "empty string" in
https://git-scm.com/docs/git-config yesterday, the most intuitive
behavior of `git fetch --refmap` (for me) was:
`git fetch <remote> <branch>...` uses `remote.<remote>.fetch`;
`git fetch --refmap=3D<refspec> --refmap=3D<refspec> <remote> <branch>...`
uses `remote.<remote>.fetch` and all the `--refmap=3D<refspec>`s;
`git fetch --refmap=3D'' --refmap=3D<refspec> --refmap=3D<refspec> <remote>
<branch>...` uses all the `--refmap=3D<refspec>`s;

Here is an example of all of these being used at the same time.
1. Normally, user uses `fetch-safe` which uses `git fetch
--refmap=3D<refspec>` to use whatever mappings specified by
`remote.<remote>.fetch` and also let our backup logic sneak in.
2. Occasionally, upstream is rebased and our backup logic (refspec
without `+`) blocks the process because of `--atomic`.
2.1. When that happens, user uses `fetch-bak-current-time` which uses
`git fetch --refmap=3D'' --refmap=3D<refspec>` to clear whatever mappings
specified by `remote.<remote>.fetch` and use our another backup logic
(refspec with `+`).
2.2. After old tips are saved, user uses `git fetch --force` to use
whatever mappings specified by `remote.<remote>.fetch`;

Currently [1.] is not working because --refmap=3D<not empty string!>
clears `remote.<remote>.fetch` instead of merging with it. Hence this
bug report.

cd '/'; cd '/'; rm --force --recursive -- './test_git2'; mkdir "$_"; cd "$_=
";
mkdir --parents -- './server' './client';

git -C './server' init --bare './repo.git'
git --git-dir=3D'./server/repo.git' --work-tree=3D'.' commit --allow-empty
-m "$((++number))"
git --git-dir=3D'./server/repo.git' --work-tree=3D'.' commit --allow-empty
-m "$((++number))"
git -C './server/repo.git' branch branch1; git -C './server/repo.git'
branch branch2

git -C './client' init './repo'
git -C './client/repo' config set --local 'alias.fetch-safe'
'!git_fetch_safe(){ server=3D"$1"; shift; git fetch --atomic
--refmap=3D'\''refs/*:refs/namespaces/'\''"$server"'\''_backup/refs/*'\''
"$server" "$@"; };git_fetch_safe'
git -C './client/repo' config set --local
'alias.fetch-bak-current-time' '!git_fetch_bak_current_time(){
server=3D"$1"; shift; git -c
'\''remote.'\''"$server"'\''_backup.url=3D.'\''
--namespace=3D"$server"'\''_backup'\'' fetch
--refmap=3D'\''refs/*:refs/namespaces/'\''"$server"'\''_backup_'\''"$(date
+'%Y%m%d%H%M%S')"'\''/refs/*'\'' "$server"'_backup' "$@"; git fetch
--atomic --refmap=3D'\'\''
--refmap=3D'\''+refs/*:refs/namespaces/'\''"$server"'\''_backup/refs/*'\''
"$server" "$@"; };git_fetch_bak_current_time'
git -C './client/repo' remote add server 'file://'"$(realpath
'./server/repo.git')"
git -C './client/repo' remote --verbose
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' fetch-safe server branch1 branch2
git -C './client/repo' show-ref
git -C './client/repo' lg --all --decorate-refs=3D'*'

git --git-dir=3D'./server/repo.git' --work-tree=3D'.' commit --allow-empty
-m "$((++number))"
git -C './server/repo.git' branch --force branch1; git -C
'./server/repo.git' branch --force branch2
git -C './client/repo' fetch-safe server branch1 branch2
git -C './client/repo' show-ref
git -C './client/repo' lg --all --decorate-refs=3D'*'

git --git-dir=3D'./server/repo.git' --work-tree=3D'.' commit --allow-empty
-m "$((++number))" --amend
git -C './server/repo.git' branch --force branch1; git -C
'./server/repo.git' branch --force branch2
git -C './client/repo' fetch-safe server branch1 branch2
git -C './client/repo' show-ref
git -C './client/repo' lg --all --decorate-refs=3D'*'
git -C './client/repo' fetch-bak-current-time server branch1 branch2
git -C './client/repo' show-ref
git -C './client/repo' lg --all --decorate-refs=3D'*'
git -C './client/repo' fetch --force server branch1 branch2
git -C './client/repo' show-ref
git -C './client/repo' lg --all --decorate-refs=3D'*'

On Thu, Sep 5, 2024 at 4:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > Am 04.09.24 um 13:12 schrieb Han Jiang:
> >> 1. If the doc says "providing an empty <refspec> to the --refmap
> >> option causes Git to ignore the configured refspecs and rely entirely
> >> on the refspecs supplied as command-line arguments" then it's
> >> reasonable to guess that "providing a non-empty <refspec> will not do
> >> those".
> >
> > Fair enough. But then in section "Configured Remote-tracking Branches"
> > it is said that "The latter use of the remote.<repository>.fetch values
> > can be overridden by giving the --refmap=3D<refspec> parameter(s) on th=
e
> > command line." So... I dunno. Just my 2c.
>
> This cuts both ways, I suspect.  It is so unusual to say
>
>     git fetch --refmap=3D"" foo bar baz
>
> to use an empty string as <refspec> in "--refmap=3D<refspec>", simply
> because you would not say
>
>     git fetch origin ""
>
> and expect the empty string is a <refspec> in "git fetch origin <refspec>=
".
>
> Any string other than an empty string, e.g.
>
>     git fetch --refmap=3D"refs/heads/*:refs/prefetch/x/*" foo bar baz
>
> would have an extra side effect of storing what gets fetched, when
> your primary focus is "I want the command to ignore the configured
> refspec".
>
> For these reasons, I would actually say it is quite fair for the
> documentation to single out the empty string case as an idiom that
> may be hard for readers to figure out for themselves without being
> told.
>
> I would not be opposed to add a sentence or two to clarify what
> happens when a non-empty <refspec> is used, though.
>
> Thanks.
>
