Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3DA156C2
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711303084; cv=none; b=aTW4mMuRl1RqNmbveQlgu9nswIqT8WPF/ZjFA6QlZHFB8icogS/xs5RH8+8myK59weHgcn4JW0hA+eaFyabASIG/YFKx8BlP6f7UiGqBhKSvDoIZXO6rmPxsqq5SJaiH4PLJKO7Ntbgk78cH2Qvpsi3BRBWtyLMuhkS4uic3pWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711303084; c=relaxed/simple;
	bh=vhaGG7t1zoph11vHinXbfl3zslaakC2ub2o1dU03cZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrGpIESwzlqnG1195ClWbg3jO3bqhcrJ5gnVICyFUhmz/bBPZUSdATqYDpXYe6/nC8WOjiES3Nc/SkqUlSfT3F8HN//cbW4mG3aVW9xxotaD5kVTa6WK+HzEBR//fmYcFcqIGbV+fuy3bqLJH0yf3tLCtDmoxHSXbSO0g6zstjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQikB+JT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQikB+JT"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso423075166b.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711303081; x=1711907881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHv2sWy2fxnbb3i4KpeSK8m/X8ffwr75HnXeFAG1iow=;
        b=MQikB+JTLXoQ2BI/HBD4vEyUWoe5LwxY8k0brY5ImuxVpmWOUzpaib/c4lMA4qtmkq
         FjicxfI7jLNVtU14m4BalALe125I+52xQFzg7Vix/QD3oPXkbcxFmZ78Pu/7U4ZR9jiU
         kQfjrkr9BFcAfNX1YGMMbPm5TmRwbnce8PyunzkInLtMx37gCM3dSZY1sKCDlMxyy2Mc
         Jicsn94SdRQkc/7lo2XNl1KimOjMRoiw5rZRRQqChEq/30/LjBtPA3KMWK8bVsDzNB4i
         qXeF5KY2qPnYht8ucpi91iYdavw4VCV6pwDTB7/JU9AY9eIJ/aGnICuRNnSPp3jMFs3e
         YZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711303081; x=1711907881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHv2sWy2fxnbb3i4KpeSK8m/X8ffwr75HnXeFAG1iow=;
        b=Xe7NuzGtZ5lg0EtjGaO9stimJ0UavyOR+CQWKw8pFDxphO95UusRwi7uJQtlC9LeOP
         gCNfrEGH3KR/DMzZrKk7vxoEIb7I83OznK/NOaDCIOpw7nYSOsE8ifiw8VcOU8NHvFHF
         YKPsE8E4yxVsm2UZTetCQ0BVj9iog9BiIhb+oRBW6oGb4wI6sGEMB5/4rVZas+t5VGIf
         LDyPdTjIpfGXxivuan3hjObe/ywdEn+7TgomTRUVOvqcEh2lLtOF9yLImDqsiKa7wPtJ
         sNp/+9RHqzsXI0AOJXtoYgL3sge5wJFVcic97f/ui/zfjmf1hu0lwkmwgyLpN6xgj1po
         eoIw==
X-Gm-Message-State: AOJu0YydOMBSVQINr2n+Ykhz3dq8JFs0yJmgIPyD91+QiZ7WmdWkYlgm
	/FSytchioe4LqiGeK5mwanYCH05zZN5aFYO2a/BUWZqT/3xXIx75XuRD5DARA8CPAqA2cZvW2qX
	hMT+vAcYamYQ7WszRxMqO0dsT8n0=
X-Google-Smtp-Source: AGHT+IEoTp3Va7v4PnLx1YWmtmbJCJ48SfKO0nXn2jHL8UOL0mAPmU9/fJ0fdj6AB2pLpThDkgfAAQEvz9ylga0AUmY=
X-Received: by 2002:a17:906:a106:b0:a47:41fe:dc0c with SMTP id
 t6-20020a170906a10600b00a4741fedc0cmr3198399ejy.22.1711303080362; Sun, 24 Mar
 2024 10:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ee4b8d8-5acb-3d3c-28e0-be972945e8d7@gmail.com>
In-Reply-To: <6ee4b8d8-5acb-3d3c-28e0-be972945e8d7@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 24 Mar 2024 18:57:48 +0100
Message-ID: <CAP8UFD2dNix6OMzCR5Ao8YLD-OVbcOfZOP90G7-QRx=OtRAoYw@mail.gmail.com>
Subject: Re: 'git bisect run' not fully automatic when a merge base must be tested
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 5:57=E2=80=AFPM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hello,
>
> I have encountered a situation where 'git bisect run' is not fully automa=
tic,
> i.e. it stops before finding the first bad commit with the message:
> "a merge base must be tested".
>
> Is there a reason why it could not run the provided script
> on the merge-base that it checks out ?

The git-bisect-lk2009.txt file has a "Checking merge bases" section
that has some explanations about why merge bases must sometimes be
tested and why a bisection should stop if a merge base is "bad".

Now I am not sure how `git bisect run` behaves in practice when a
merge base should be tested. It's possible it never actually worked,
or perhaps there was no test case in our tests checking this and it
stopped working at one point.

> For context (and a reproducer), I was bisecting the
> 'git commit --verbose --trailer' regression I reported in [1].
>
> I was running the bisection on a machine without curl installed, and so I
> was building with 'NO_CURL' and thus needed to cherry-pick my 30bced3a67
> (imap-send: add missing "strbuf.h" include under NO_CURL, 2024-02-02) at =
most steps
> of the bisection. So I was running this command:
>
> git bisect reset && git bisect start &&
> git bisect bad v2.43.2 && git bisect good v2.42.1 &&
> git bisect run ~/bisect-git.sh
>
> with this script to drive the bisection:
>
> =3D=3D=3D ~/bisect-git.sh =3D=3D=3D
> #!/bin/bash
>
> git cherry-pick --allow-empty 30bced3a67

It might not be a good idea to change the current branch when a
bisection happens. I think it would be better to apply a patch using
`git apply` before the tests and to remove it using `git apply -R`
after the tests.

> if   make -j NO_CURL=3D1
> then
>     # run project specific test and report its status
>     ~/bisect-trailers.sh
>     status=3D$?
> else
>     # tell the caller this is untestable
>     status=3D125
> fi
>
> # return control
> exit $status
> =3D=3D=3D=3D end of ~/bisect-git.sh =3D=3D=3D
>
> and this one to reproduce the regression:
>
> =3D=3D=3D ~/bisect-trailer.sh =3D=3D=3D
> set -e
>
> export PATH=3D"/path/to/git/bin-wrappers/:$PATH"
>
> repo=3D${TMPDIR:-/tmp}/test-trailers
> rm -rf "$repo"
>
> unset $(git rev-parse --local-env-vars)
>
> git init "$repo"
> cd "$repo"
> date>file
> git add file
> export GIT_EDITOR=3D'cat file'
> git commit --verbose -em "file" --trailer=3D"key: value" > /dev/null
> git show | \grep -q value
> =3D=3D=3D end of ~/bisect-trailer.sh =3D=3D=3D
>
> This results in the bisection stopping at:
>
>         HEAD is now at 4a14ccd05d imap-send: add missing "strbuf.h" inclu=
de under NO_CURL
>         Bisecting: a merge base must be tested
>         [d57c671a511d885a5cd390e3d6064c37af524a91] treewide: remove unnec=
essary includes in source files
>         bisect run success
>
> with the following bisect log:
>
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [efb050becb6bc703f76382e1f1b6273100e6ace3] Git 2.43.2
> git bisect bad efb050becb6bc703f76382e1f1b6273100e6ace3
> # status: waiting for good commit(s), bad commit known
> # good: [61a22ddaf0626111193a17ac12f366bd6d167dff] Git 2.42.1
> git bisect good 61a22ddaf0626111193a17ac12f366bd6d167dff
> # good: [5edbcead426056b54286499149244ae4cbf8b5f7] Merge branch 'bc/racy-=
4gb-files'
> git bisect good 5edbcead426056b54286499149244ae4cbf8b5f7
> # good: [5baedc68b02c1b43b307d436edac702ac3e7b89d] Merge branch 'jk/bisec=
t-reset-fix' into maint-2.43
> git bisect good 5baedc68b02c1b43b307d436edac702ac3e7b89d
> # good: [2873a9686cf59ecbf851cea8c41e6ee545195423] Merge branch 'rs/rebas=
e-use-strvec-pushf' into maint-2.43
> git bisect good 2873a9686cf59ecbf851cea8c41e6ee545195423
> # bad: [03bc5976514f706889fceea623f35133014ebe78] imap-send: add missing =
"strbuf.h" include under NO_CURL
> git bisect bad 03bc5976514f706889fceea623f35133014ebe78
> # bad: [9ae3c6dceb187af1ae09649dc5c61bb05a7013d9] imap-send: add missing =
"strbuf.h" include under NO_CURL
> git bisect bad 9ae3c6dceb187af1ae09649dc5c61bb05a7013d9
> # good: [007488839cabbb5bc6777924ae03c4edeb1b6110] imap-send: add missing=
 "strbuf.h" include under NO_CURL
> git bisect good 007488839cabbb5bc6777924ae03c4edeb1b6110
>
> This was the first time that I did a bisection with 'git bisect run'
> that was not fully automated so it threw me off a bit.
>
> I tried it again today and realized that if I modify my ~/bisect-git.sh
> to use 'git cherry-pick --no-commit --allow-empty' instead, then the
> bisection runs to completion and finds the bad commit. So my understandin=
g
> is that cherry-picking a commit during the bisection (without --no-commit=
)
> alters the commit graph and might not be the best idea...

Yeah, right.

I think the merge bases should only be checked at the beginning of a
bisection. So it is strange that it happened so late after it was
started.

> Looking at the man
> page the example does use 'git merge --no-commit' so I should have known =
better.
>
> But the question remains: in general shouldn't 'git bisect run' do everyt=
hing
> automatically and not require the user to do something manually ?

I agree but it might be a bug because git bisect just doesn't expect
the current branch to change while a bisection is going on.

> And a side note to finish:
> Initially I did not use 'unset $(git rev-parse --local-env-vars)' in
> my ~/bisect-trailers.sh, and I was running the bisection in a secondary
> worktree of my clone of git.git. This did not work at all since the
> 'git init' and 'git commit --verbose -em "file" --trailer=3D"key: value"'
> steps were running _in my secondary worktree_ instead of in $TMPDIR,
> because of how the repository detection works in worktrees and
> exports some variables (I think...) This was also very confusing
> and I'm wondering if we should add a note somewhere about that
> in the documentation, although it seems specific to bisecting git.git...

Perhaps we could also have examples of good git bisect run scripts
somewhere that we can point Git developers to.
