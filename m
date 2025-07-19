Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C3629D0D
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 03:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894896; cv=none; b=uazkm3tyAaFqrpmXmw8Tz4J2rWvr88+iEwd5zGZVxyXTObpFOCseI8Yo6UK9og2nJDtUmLZ2aje9chd8duEvbFnf6I+nIQZqbfibuq1Y2ybJb2I98Y/qazZpqssftmkghMmtnuCyHZNN1P3DeSzpgJ6wP1qHz7E62re9o9vkOHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894896; c=relaxed/simple;
	bh=YdyktknVEHlI+rdAABAxAIVsjKyT5oY9JJythZRQo44=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i7pecNPt+ftaLkOdH6LIcO2DWx5OBgQqxwgEzCSipMiShAS3H6PuDiTvS6tuYyUENIKs+0C7JjyYYbJu2i/TOJZOJJoIKnsE7Lnsn6wceBUTJHB8oWObXqS1L+slNo7LYUIqHxcDITynue3u8dd0FUJGBinTQGX6sSEamfSbhy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWP487Rg; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWP487Rg"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-23c703c471dso40665915ad.0
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 20:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752894894; x=1753499694; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSE0yQ54moRyESUsyXc9vwGB89QY8d8lTjmDARwpfxU=;
        b=fWP487RgbncLXXj6etzEwMCwnhlQNr3lFg8qU9jUILyekXAFbtBCinDk043JHH+BL5
         6c5uDoRIPnuTdeptpUYWLgBiLxV0aIJS+kmCNkoS4JhXP7wL7HpSg2/flKlr7oTbz5x7
         drdVtIXNlIIzcOk9c35aSDl0HWtV1qpSfru0ZCq4hzbjNn1zPjPBei0ycrlVirMkcTq8
         Ifrxb8vpxsO1GyKRDLbJ8z/Md27ntB+1dRVUeP8rZRJQiTmfk5ty8U9ilGsLiaKKjArJ
         KloDjvO4oAWycRQ1xnRdJZnTaxicrGOCD741jepyVyJzJo9f/bXg1JXj6HsZSd/uvtBH
         Cu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894894; x=1753499694;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSE0yQ54moRyESUsyXc9vwGB89QY8d8lTjmDARwpfxU=;
        b=CNMebyMHrEKNpmGidiUbdjC2y+P+fo0lbSohXH0nM/ZDG0mN3XzwGIJ5Wd7mEWXIwr
         H3CE1z4rQIyYPtG+eQC7d3cLGgGblVtP0U5p03KFzQLSSe+8Gm+4CaiI1UXmzmNbL9Wt
         tuQffCqAcnkET3i/b/nsKmZeHQxeH5W6DQ8j70TrAzS6UmDc9zAV0HEUQueqTiYL0LwZ
         jIo6FMWzsIGfTkHWnVPCu1NHH8ekN8YnUPijkAP/EHHD6/M4rEJm3P0Phblf++Wkdr6K
         NF2i3oHQsuxH30353JZ9pBs2LmP5ew0LvgFRKERYyEOZJnd1mHrpXvpFK0nDpKP9affp
         Ty1A==
X-Gm-Message-State: AOJu0YxJPN8QYtMZcyx3X5drhORW/pBvxll3KzB0EQgt9+Kt63Nz0/Yq
	pnKZe+I2iGzOlivLCQjvKQZKsFWPAeO1SSIoQfI4YscjGrUh+ZKkqOxZn00m0frY
X-Gm-Gg: ASbGncvfWizPDmqq/awdLjJzQb90rbqMjPLPEpK5h+01IXu1CR+wljZsrlZo/w8xutl
	bpK5Lw4cTQLeWg9Bf3BMdKDeX9yy+k1q0AODfQjKsMit8Tp/B4DU7JOzM2Y2Y0O+ETXVMYHZl9D
	6MriKIckCDy10nXdGShfiQmAkVevKkgv7qmviWDZ0AZC3fszto8h4L9SsucivYdYHNFOjfrNIGr
	tEpQ2fjX4verH2unK6+J5ISAMZw/4qWNvtOz1orV5JIY8GC5EwNVLI4r/iQmA3U2U6DkrO3pMwG
	ZDvDccFWHzNQfG24qA0Tj1bUyqEx8ZF/eodtdWlCE7NdItv2G4fl94E28k4UdwHFeFRNYl4avrY
	5dAzpXD//nEIV41DJqk9mVDB9u1ISdwYta5mQTSpz9UOax804mW5Hje7bHBaG657S/ZFrCkt8+Y
	7AxFasiJUGz2mW8ZOV72spQw==
X-Google-Smtp-Source: AGHT+IEAweehLr2haWQmTnULdQz63ybecZvIIrD6d5Cb/ee2kP3FjlK+xhMj5SPbngrUfBHHmfMQXw==
X-Received: by 2002:a17:902:d4c1:b0:234:595d:a58e with SMTP id d9443c01a7336-23e38fb11efmr91391925ad.25.1752894894132;
        Fri, 18 Jul 2025 20:14:54 -0700 (PDT)
Received: from smtpclient.apple (awork062012.netvigator.com. [203.198.28.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2d6fsm20669395ad.20.2025.07.18.20.14.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jul 2025 20:14:53 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] pull: add pull.autoStash config option
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqjz45172n.fsf@gitster.g>
Date: Sat, 19 Jul 2025 11:14:48 +0800
Cc: git@vger.kernel.org,
 hi@looping.me,
 j6t@kdbg.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CABAF88-B343-4996-B968-3736FC24917B@gmail.com>
References: <20250717030732.75106-1-yldhome2d2@gmail.com>
 <20250718035221.2293-1-yldhome2d2@gmail.com> <xmqqjz45172n.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> Git uses `rebase.autostash` or `merge.autostash` to determine whether =
a
>> dirty worktree is allowed during pull. However, this behavior is not
>> clearly documented, making it difficult for users to discover how to
>> enable autostash, or causing them to unknowingly enable it. Add new
>> config option `pull.autostash` along with its documentation and test
>> cases.
>>=20
>> `pull.autostash` provides the same functionality as =
`rebase.autostash`
>> and `merge.autostash`, but overrides them when set. If =
`pull.autostash`
>> is not set, it falls back to `rebase.autostash` or `merge.autostash`,
>> depending on the value of `pull.rebase`.
>=20
> Very well reasoned and described.
>=20
>> diff --git a/Documentation/config/pull.adoc =
b/Documentation/config/pull.adoc
>> index 9349e09261..3aa1e67923 100644
>> --- a/Documentation/config/pull.adoc
>> +++ b/Documentation/config/pull.adoc
>> @@ -13,6 +13,17 @@ pull.rebase::
>> of merging the default branch from the default remote when "git
>> pull" is run. See "branch.<name>.rebase" for setting this on a
>> per-branch basis.
>> +
>> +pull.autoStash::
>> + When true, Git will automatically perform a `git stash` before the
>> + operation and then restore the local changes with `git stash pop`
>> + after the pull is complete. This means that you can run pull on a
>> + dirty worktree. If `pull.autostash` is set, it takes precedence =
over
>> + `rebase.autostash` and `merge.autostash`. If `pull.autostash` is =
not
>> + set, it falls back to `rebase.autostash` or `merge.autostash`,
>> + depending on the value of `pull.rebase`. This option can be
>> + overridden by the `--no-autostash` and `--autostash` options of
>> + linkgit:git-pull[1]. Defaults to false.
>> +
>> When `merges` (or just 'm'), pass the `--rebase-merges` option to =
'git rebase'
>> so that the local merge commits are included in the rebase (see
>=20
> The new text is inserted at a wrong spot.  This "+\nWhen `merges`"
> is a continuation of the text that describes `pull.rebase`.  If that
> is set to `true`, one thing happens.  If that is set to `merges`,
> something else happens.
>=20
> Insert the text for `pull.autoStash` immediately before the
> description of the `pull.octopus` configuration variable.
>=20
> As to the text itself, "you can run pull on a dirty worktree" may
> not be what you want to say here, for a few reasons.
>=20
> * (pedantic) Even without the configuration variable set, you can
>   run "git pull" in a dirty working tree; it just will refuse to do
>   any damage until you stash the local changes away yourself.
>=20
> * If your "git pull" merges, it would work even in a dirty working
>   tree as long as your local change doesn't overlap with what the
>   merge would bring in.  This is quite useful for a maintainer with
>   "upcoming" change to GIT-VERSION-GEN always updated locally in
>   the working tree and not having to worry about pulling from
>   contributors and submaintainers who won't usually be touching
>   that file, for example.
>=20
> * Not limited to this instance, when you have to say "(This|It)
>   means <<B>>" immediately after making a statement <<A>, I would
>   like us to think if we can just say <<B>> without saying <<A> at
>   all.  In this case, it is not so, which makes me suspect that
>   perhaps we do not even want to say <<B>>, as it may not mean
>   <<B>> after all.
>=20
> Here is my attempt.
>=20
>    When set to true, automatically create a temporary stash entry
>    to record the local changes before the operation begins, and
>    restore them after the operation completes.  When your "git
>    pull" rebases (instead of merges), this may be convenient, since
>    unlike merging pull that tolerates local changes that do not
>    interfere with the merge, rebasing pull refuses to work with any
>    local changes.
> +
> If `pull.autostash` is set (either to true or false),
> `merge.autostash` and `rebase.autostash` are ignored.  If
> `pull.autostash` is not set at all, depending on the value of
> `pull.rebase`, `merge.autostash` or `rebase.autostash` is used
> instead.  Can be overridden by the `--[no-]autostash` command line
> option.
>=20
>> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
>> index 63c9a8f04b..134da2185c 100755
>> --- a/t/t5520-pull.sh
>> +++ b/t/t5520-pull.sh
>> @@ -472,6 +472,96 @@ test_expect_success 'pull --no-autostash & =
merge.autostash unset' '
>> test_pull_autostash_fail --no-autostash --no-rebase
>> '
>>=20
>> +test_expect_success 'pull succeeds with dirty working directory and =
pull.autostash set' '
>> + test_config pull.autostash true &&
>> + test_pull_autostash 1 --rebase &&
>> + test_pull_autostash 2 --no-rebase
>> +'
>=20
> Most trivial case.  No command line override.
>=20
>> +test_expect_success 'pull --autostash & pull.autostash=3Dtrue' '
>> + test_config pull.autostash true &&
>> + test_pull_autostash 1 --autostash --rebase &&
>> + test_pull_autostash 2 --autostash --no-rebase
>> +'
>=20
> Command line override specifies the same behaviour as the
> configuration, so we cannot learn much from this test.  It still
> should keep working, so the test is worth having [*], but I wonder
> if makes sense to combine the above two into one test, i.e. set the
> configuration variable to true once, and then try --rebase and
> --no-rebase with and without --autostash (four combinations).
>=20
>    [*] In this review, unless I explicitly say "this test is wrong
>    and expects an incorrect result", they are not wrong, even
>    though what they test may not be as interesting as others, and I
>    am not suggesting its removal.  This is one of these tests.
>=20
>> +test_expect_success 'pull --autostash & pull.autostash=3Dfalse' '
>> + test_config pull.autostash false &&
>> + test_pull_autostash 1 --autostash --rebase &&
>> + test_pull_autostash 2 --autostash --no-rebase
>> +'
>=20
> Configuration should be overridden by the command line option, which
> is a good thing to test.
>=20
>> +test_expect_success 'pull --autostash & pull.autostash unset' '
>> + test_unconfig pull.autostash &&
>> + test_pull_autostash 1 --autostash --rebase &&
>> + test_pull_autostash 2 --autostash --no-rebase
>> +'
>=20
> Another most trivial case.  Shouldn't we already have an existing
> test for this, back from the days before pull.autostash got
> introduced, since the command line option has been there all along?
>=20
>> +test_expect_success 'pull --no-autostash & pull.autostash=3Dtrue' '
>> + test_config pull.autostash true &&
>> + test_pull_autostash_fail --no-autostash --rebase &&
>> + test_pull_autostash_fail --no-autostash --no-rebase
>> +'
>=20
> Configuration overridden by the option, opposite of what we saw
> earlier, which is another good thing to test.
>=20
>> +test_expect_success 'pull --no-autostash & pull.autostash=3Dfalse' '
>> + test_config pull.autostash false &&
>> + test_pull_autostash_fail --no-autostash --rebase &&
>> + test_pull_autostash_fail --no-autostash --no-rebase
>> +'
>=20
> Uninteresting test that does not tell us much; we cannot tell which
> between the configuration and the command line option caused us not
> to auto stash with this test.
>=20
> Two cases that may be worth adding to this test immediately after
> setting pull.autostash to false are:
>=20
> test_pull_autostash_fail --rebase &&
> test_pull_autostash_fail --no-rebase &&
>=20
>> +test_expect_success 'pull --no-autostash & pull.autostash unset' '
>> + test_unconfig pull.autostash &&
>> + test_pull_autostash_fail --no-autostash --rebase &&
>> + test_pull_autostash_fail --no-autostash --no-rebase
>> +'
>=20
> Another uninteresting case that probably should be already covered
> by existing test, since this tests "what happens when autostash is
> explicitly declined from the command line when there is no
> configuration variable to intervene?".
>=20
>> +test_expect_success 'pull.autostash=3Dtrue & rebase.autostash=3Dtrue' =
'
>> + test_config pull.autostash true &&
>> + test_config rebase.autostash true &&
>> + test_pull_autostash 1 --rebase
>> +'
>=20
> OK.  Perhaps make sure "--no-autostash --rebase" would fail while at
> it in the same test?
>=20
>> +test_expect_success 'pull.autostash=3Dtrue & rebase.autostash=3Dfalse'=
 '
>> + test_config pull.autostash true &&
>> + test_config rebase.autostash false &&
>> + test_pull_autostash 1 --rebase
>> +'
>=20
> This is more interesting than the previous one, as we make sure that
> pull.* trumps rebase.* with this test.  Perhaps throw --no-autostash
> specified on the command line into the mix?
>=20
>> +test_expect_success 'pull.autostash=3Dfalse & rebase.autostash=3Dtrue'=
 '
>> + test_config pull.autostash false &&
>> + test_config rebase.autostash true &&
>> + test_pull_autostash_fail --rebase
>> +'
>=20
> Another good one.  It might be intereseting to test --no-rebase and
> make sure it also fails?  I dunno.
>=20
>> +test_expect_success 'pull.autostash=3Dfalse & =
rebase.autostash=3Dfalse' '
>> + test_config pull.autostash false &&
>> + test_config rebase.autostash false &&
>> + test_pull_autostash_fail --rebase
>> +'
>=20
> Not as interesting as others.
>=20
>> +test_expect_success 'pull.autostash=3Dtrue & merge.autostash=3Dtrue' =
'
>> + test_config pull.autostash true &&
>> + test_config merge.autostash true &&
>> + test_pull_autostash 2 --no-rebase
>> +'
>=20
> Not as interesting as others.  Throw --no-autostash given on the
> command line into the mix as well?
>=20
>> +test_expect_success 'pull.autostash=3Dtrue & merge.autostash=3Dfalse' =
'
>> + test_config pull.autostash true &&
>> + test_config merge.autostash false &&
>> + test_pull_autostash 2 --no-rebase
>> +'
>=20
> OK.  pull.*=3Dtrue trumps merge.*=3Dfalse.  We test the other way =
around
> next.  Good.
>=20
>> +test_expect_success 'pull.autostash=3Dfalse & merge.autostash=3Dtrue' =
'
>> + test_config pull.autostash false &&
>> + test_config merge.autostash true &&
>> + test_pull_autostash_fail --no-rebase
>> +'
>> +
>> +test_expect_success 'pull.autostash=3Dfalse & merge.autostash=3Dfalse'=
 '
>> + test_config pull.autostash false &&
>> + test_config merge.autostash false &&
>> + test_pull_autostash_fail --no-rebase
>> +'
>=20
> Not very interesting.  Throw anothre that gives --autostash from the
> command line in the mix, perhaps?
>=20
>> test_expect_success 'pull.rebase' '
>> git reset --hard before-rebase &&
>> test_config pull.rebase true &&


Thank you very much for your thorough review. I will reorganize the
documentation and test cases in v2.

- Lidong=
