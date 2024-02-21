Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE07657AD
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519044; cv=none; b=CyEEoHwtNbbzjT5Q6T5k0L3hY4Eu+ssE2CTUlmN/w2yXGV1KDEC8osOTH1tewZCluvtDGu0/5bVeCmVi2E5Xa5CD1W0uzOPahSIjxpGGiVg881f/t/RMB3PDYJmZaoyCtngw7Op9sjkPQViA2zfZiCRX8WxG6nMv89fDAdKzu+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519044; c=relaxed/simple;
	bh=3nHBiinYzCmUyjq6kOu374/Hr22kLqlev4tpos8Xt7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0JFmGe35mjabMacOoRcC7QrCE1Rs6UVdythiwtA87y4OYkir+JSYK1KkkD6/VnTj2ll3MZUxT7vl2c4mLn+0VxqD8rj54NzeYhAzpgycWI8UbIqC8Z/yFy/0hD2l2WL1sflCeIoyx/iCgoZTE6z2aoQOWJvxnzPJyjcNV/9Ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iZtjPIHC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ev14OFRu; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iZtjPIHC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ev14OFRu"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8102718000CA;
	Wed, 21 Feb 2024 07:37:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Feb 2024 07:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708519040; x=1708605440; bh=DbEUmtFg0X
	ZEn1q1Ldn5yTW2tkWxpkozVauWC2HsKDE=; b=iZtjPIHC/+rqwkq6MtoJlK8swU
	0Tfcm55hzLTCb8HN5M8BFVTNC3FEXWbHUZxjPXTErOzac99cVl3U+t1dmVpXfxZl
	NbQSJCvrHDpcg7kAFvqOxVGmsUPn+gVELUQVD8zvXMAUDNXkj6DS0+5iM2oVHra+
	T4WNgeOt7dZuyYvuLYgj6pHeUB4CJUmbAJWGsLIQBFo13umUxmR23ihlmElN/e5H
	XfFKf5vGUlnvmPrAF16LORXNvwjgXffY3wUfBNw5qQSzrjo/WlowuxMHu3X0y/5M
	HzPJTtoYW7y/aBLH6qAKeTIPmEgHMQZLwLZ2AE1iBL39VYP+EeWgRq+HCjAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708519040; x=1708605440; bh=DbEUmtFg0XZEn1q1Ldn5yTW2tkWx
	pkozVauWC2HsKDE=; b=ev14OFRuTsMrUlU/H70ASuJvPP+d8ameV22cAqMgjRL1
	TdkA6Z0wTfDRAN/C+qEzplCZEId5qLNIdZJsmcITVAXllywDlD0M67z/6tDxspiU
	qHHEYPPKLA9HaaVKAblJ9tga1Gg5RmdTlhxxoY1F631T1V/+lquqU9Dr/fNYYoWD
	HmZ7JITLt/Djf4RwWaJIP5ox7jcCXylK9ibeDeeXfsTo4FxNr6D5hBCpYtBE5KNk
	tyb3lsDAtah1ydSsN6iPVf5qeaX0qcnq8o7TLXt4WLe0y6fxJSLLnIOV90nwQzeu
	pCRHFw+/V/RWYLqJuzwv0COzAXVNkjpvHS0ufWYlIg==
X-ME-Sender: <xms:f-7VZddH0q7kQyZivHjmh1ddGfkXA_VnZc9XUd6LgSjO5MxvgrMj3g>
    <xme:f-7VZbPcPVCcLzMzkB7ooQFaQPnHjTSZ56xahgqJXxDjG7KuqIsglzbWWwzbyuD_W
    U9ulGHFrhYeCDmtgg>
X-ME-Received: <xmr:f-7VZWgiBGWQ05FraR2FYR_-g4CFXOTvp406OUir94D2Suai3R6CJO4gdmnYkcaG9ZnVWEonULM4BSwEfwn4V7ppa9S484_0nbXX4y2y9r4j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:f-7VZW-Cb-ZhzPTnL66JrodY_AnhOWyq2K9eSMP6i3_JB5TE72IFxQ>
    <xmx:f-7VZZsHQglT5DBPt58jS_nI_YuLoLvCogCxxMptKuQgdougNtULXg>
    <xmx:f-7VZVEbvTGy062TLzatNNuvSDcm0ttsiUSGY99VyWoqHszI31jIkg>
    <xmx:gO7VZS5Nbk9BFtZLW2zrR4t_lAmLeLEOEeQlbBdGyqnwaJiLTDNn9rl8ibM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 07:37:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f748619a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 12:33:12 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:37:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/8] reflog: introduce subcommand to list reflogs
Message-ID: <cover.1708518982.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mkcFGQC38jO9WNDu"
Content-Disposition: inline
In-Reply-To: <cover.1708353264.git.ps@pks.im>


--mkcFGQC38jO9WNDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that introduces a new `git
reflog list` subcommand to list available reflogs in a repository.

There is only a single change compared to v2. Junio made me double check
my assumption that the select function for reflogs yielded by the merged
iterator in the "files" backend would return things lexicographically.
Turns out it didn't -- instead, it returns all worktree refs first, then
all common refs.

This isn't only an issue because I prematurely marked the merged iter as
sorted. It's also an issue because the user-visible ordering would be
quite weird when executing `git reflog list` in a worktree.

I've thus added another commit on top that extracts the preexisting
logic to merge worktree and common refs by name from the "reftable"
backend and reuses it for the "files" reflogs.

Patrick

Patrick Steinhardt (8):
  dir-iterator: pass name to `prepare_next_entry_data()` directly
  dir-iterator: support iteration in sorted order
  refs/files: sort reflogs returned by the reflog iterator
  refs/files: sort merged worktree and common reflogs
  refs: always treat iterators as ordered
  refs: drop unused params from the reflog iterator callback
  refs: stop resolving ref corresponding to reflogs
  builtin/reflog: introduce subcommand to list reflogs

 Documentation/git-reflog.txt   |   3 +
 builtin/fsck.c                 |   4 +-
 builtin/reflog.c               |  37 ++++++++++-
 dir-iterator.c                 | 105 +++++++++++++++++++++++++++-----
 dir-iterator.h                 |   3 +
 refs.c                         |  27 ++++++---
 refs.h                         |  11 +++-
 refs/debug.c                   |   3 +-
 refs/files-backend.c           |  55 +++--------------
 refs/iterator.c                |  69 +++++++++++++++------
 refs/packed-backend.c          |   2 +-
 refs/ref-cache.c               |   2 +-
 refs/refs-internal.h           |  27 ++++-----
 refs/reftable-backend.c        |  67 +++-----------------
 revision.c                     |   4 +-
 t/helper/test-ref-store.c      |  18 ++++--
 t/t0600-reffiles-backend.sh    |  24 ++++----
 t/t1405-main-ref-store.sh      |   8 +--
 t/t1406-submodule-ref-store.sh |   8 +--
 t/t1410-reflog.sh              | 108 +++++++++++++++++++++++++++++++++
 20 files changed, 380 insertions(+), 205 deletions(-)

Range-diff against v2:
1:  12de25dfe2 =3D 1:  d474f9cf77 dir-iterator: pass name to `prepare_next_=
entry_data()` directly
2:  788afce189 =3D 2:  89cf960d47 dir-iterator: support iteration in sorted=
 order
3:  32b24a3d4b ! 3:  8ad63eb3f6 refs/files: sort reflogs returned by the re=
flog iterator
    @@ refs/files-backend.c: static struct ref_iterator *reflog_iterator_be=
gin(struct r
      	iter->dir_iterator =3D diter;
      	iter->ref_store =3D ref_store;
      	strbuf_release(&sb);
    -@@ refs/files-backend.c: static struct ref_iterator *files_reflog_iter=
ator_begin(struct ref_store *ref_st
    - 		return reflog_iterator_begin(ref_store, refs->gitcommondir);
    - 	} else {
    - 		return merge_ref_iterator_begin(
    --			0, reflog_iterator_begin(ref_store, refs->base.gitdir),
    -+			1, reflog_iterator_begin(ref_store, refs->base.gitdir),
    - 			reflog_iterator_begin(ref_store, refs->gitcommondir),
    - 			reflog_iterator_select, refs);
    - 	}
    =20
      ## t/t0600-reffiles-backend.sh ##
     @@ t/t0600-reffiles-backend.sh: test_expect_success 'for_each_reflog()=
' '
-:  ---------- > 4:  0b52f6c4af refs/files: sort merged worktree and common=
 reflogs
4:  4254f23fd4 ! 5:  d44564c8b3 refs: always treat iterators as ordered
    @@ refs/files-backend.c: static struct ref_iterator *files_reflog_itera=
tor_begin(st
     -			1, reflog_iterator_begin(ref_store, refs->base.gitdir),
     +			reflog_iterator_begin(ref_store, refs->base.gitdir),
      			reflog_iterator_begin(ref_store, refs->gitcommondir),
    - 			reflog_iterator_select, refs);
    + 			ref_iterator_select, refs);
      	}
    =20
      ## refs/iterator.c ##
    @@ refs/refs-internal.h: enum do_for_each_ref_flags {
      	const char *refname;
      	const struct object_id *oid;
      	unsigned int flags;
    -@@ refs/refs-internal.h: typedef enum iterator_selection ref_iterator_=
select_fn(
    +@@ refs/refs-internal.h: enum iterator_selection ref_iterator_select(s=
truct ref_iterator *iter_worktree,
       * Iterate over the entries from iter0 and iter1, with the values
       * interleaved as directed by the select function. The iterator takes
       * ownership of iter0 and iter1 and frees them when the iteration is
    @@ refs/reftable-backend.c: static struct ref_iterator *reftable_be_ite=
rator_begin(
      	worktree_iter =3D ref_iterator_for_stack(refs, refs->worktree_stack,=
 prefix, flags);
     -	return merge_ref_iterator_begin(1, &worktree_iter->base, &main_iter-=
>base,
     +	return merge_ref_iterator_begin(&worktree_iter->base, &main_iter->ba=
se,
    - 					iterator_select, NULL);
    + 					ref_iterator_select, NULL);
      }
     =20
     @@ refs/reftable-backend.c: static struct reftable_reflog_iterator *re=
flog_iterator_for_stack(struct reftabl
    @@ refs/reftable-backend.c: static struct ref_iterator *reftable_be_ref=
log_iterator
     =20
     -	return merge_ref_iterator_begin(1, &worktree_iter->base, &main_iter-=
>base,
     +	return merge_ref_iterator_begin(&worktree_iter->base, &main_iter->ba=
se,
    - 					iterator_select, NULL);
    + 					ref_iterator_select, NULL);
      }
     =20
5:  240334df6c =3D 6:  c06fef8a64 refs: drop unused params from the reflog =
iterator callback
6:  7928661318 =3D 7:  fc96d5bbab refs: stop resolving ref corresponding to=
 reflogs
7:  d7b9cff4c3 ! 8:  f3f50f3742 builtin/reflog: introduce subcommand to lis=
t reflogs
    @@ t/t1410-reflog.sh: test_expect_success 'empty reflog' '
     +	)
     +'
     +
    ++test_expect_success 'list reflogs with worktree' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		test_commit A &&
    ++		git worktree add wt &&
    ++		git -c core.logAllRefUpdates=3Dalways \
    ++			update-ref refs/worktree/main HEAD &&
    ++		git -c core.logAllRefUpdates=3Dalways \
    ++			update-ref refs/worktree/per-worktree HEAD &&
    ++		git -c core.logAllRefUpdates=3Dalways -C wt \
    ++			update-ref refs/worktree/per-worktree HEAD &&
    ++		git -c core.logAllRefUpdates=3Dalways -C wt \
    ++			update-ref refs/worktree/worktree HEAD &&
    ++
    ++		cat >expect <<-EOF &&
    ++		HEAD
    ++		refs/heads/main
    ++		refs/heads/wt
    ++		refs/worktree/main
    ++		refs/worktree/per-worktree
    ++		EOF
    ++		git reflog list >actual &&
    ++		test_cmp expect actual &&
    ++
    ++		cat >expect <<-EOF &&
    ++		HEAD
    ++		refs/heads/main
    ++		refs/heads/wt
    ++		refs/worktree/per-worktree
    ++		refs/worktree/worktree
    ++		EOF
    ++		git -C wt reflog list >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
     +test_expect_success 'reflog list returns error with additional args' '
     +	cat >expect <<-EOF &&
     +	error: list does not accept arguments: ${SQ}bogus${SQ}
--=20
2.44.0-rc1


--mkcFGQC38jO9WNDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXV7noACgkQVbJhu7ck
PpSCVA/5AQBNDo3z+niu4zYLEZ3eXYMZCJCtNYycaZbKVa1PIp0UpgnEq3+VIsk2
I4aAB8Y//MozzqVjzKUAzmNIY6BTLcWXtTDTQkoXw5LQi7oueFThUz2oQREM3YS4
k4ut4EA1O1KfFzE7fzjQ9jIx+DdMOs5k9KL/0u1lDLsI793l/WS+HA58rPrVGoX1
hg9rX480bV+kfHZshvGwktwcbyUWsN/salP9Kff8yS23zoWnPUP2wmAnnwKGwIdV
WD6feY1OWrOgJOtvpN6d0fixqQF052l4JaNW6qq8yffJins8ogMtSS7E4XMiU+DL
YNuUeFdIVWm0SeP13RyX8r03b8mLi0ajgB5Mv6Esk5htWyTocXXTS8AuuyxCCFrD
eqc0w9DikipJ/H1ZKWTjpRw2Tl/g1gfc6wVtpiwtTlJDN0SLtKe4jx3AfJh8Pb/u
iRk6C/LpOM7GC+44VHyMuvpNk8Prc5zVKBOarvVSxAzM73ER2FKYZ4z07t/Dxp2S
xMPH94cGDJ5A2oQx2Fqb6ifQkVK+dboIffEJlUAL2h3U+VfZ3erARc+pPFjYF/9v
fAFN2AW50wbddX+BK5HxM0WDRDMe8csQWP0XljwWsOknUAJNU/QOnmxvGJk82izA
V3dOd5HHI9ZJP5dBWOJ0IwuFyQcKjNVFCzibM5gZZIWy+0oLPRQ=
=Vhf0
-----END PGP SIGNATURE-----

--mkcFGQC38jO9WNDu--
