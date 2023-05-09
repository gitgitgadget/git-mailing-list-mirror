Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F3C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 13:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjEINCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 09:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjEINCG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 09:02:06 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201E3199C
        for <git@vger.kernel.org>; Tue,  9 May 2023 06:02:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 85D245C0079;
        Tue,  9 May 2023 09:02:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 09 May 2023 09:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683637324; x=1683723724; bh=iv
        GA7AF5uviEhLPSEkszc5WKbH1vvWZJxjoBP6ti5dw=; b=oeSn1bJUf1EHdUIh6K
        U/ya+7Spg/44mtvBD5jguW5xStNxgfY1aERB9mjOBqkfn+4h37XEcoqrBwlJHniy
        q+2sJDvPxSWdj1/PWsH4JqP/i0i/QP8zlQB+GQeRGC/gHRuiNdEt0PSJj/Vo6p1E
        lGDCaTEf9AQGhg7YMbpDVQlcUAMEyYGgqQuSTaoGKqHcx1QjVrNCOgiTL3n9zZzu
        Bd1ZGAKxUr4FywniD8iKNTtYVCXdfooJ9HBFYhqOD54erVRvyfXyMmc42U19oH54
        DidlsaRrkAPu5au+xmd7CHqdkJ831hYsPc4aXmBpU396AyvKdiL41+UF7vQBlYR/
        XToA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683637324; x=1683723724; bh=ivGA7AF5uviEh
        LPSEkszc5WKbH1vvWZJxjoBP6ti5dw=; b=I/4aRgnSR3oSOCwY5QDlI5jp6LAcv
        vPaFD0/gTozeREHkJgx/pdxzYjWQ5xlLQ+AjjSD0yL2J/a+Mh3+W1G2WzkME6dOG
        yLwmHX5pyT78m0gi2dtDMC7r0e63RW0A5zYJ2yp7IIY9RE1cG2fK1KgVoX/b8kun
        b47HV0M8nK0Gy+o9ZT8xgLcr2FEw88c72oJ27N5Z+bb+SkUiASLz5a0tXm3CU7kI
        ngWAaLsp8Jh6wJGONppjOu1Tt55s+PYZXitNcKwc5dHgyGTKxUz1KaisUM6O9pI8
        U9SjvQGJutO3Ivhj6tLFGnA4mfQnjqwbXGdgFW1GgbdkZp7AyCsEz95/Q==
X-ME-Sender: <xms:TERaZMNhcXYKDDehJ3amQR9RyzSUXtTXl8AuuFPeA0iz3bgcooCxww>
    <xme:TERaZC_u1c3Lg0w-kOG584O_j-9LfIP0uQJtcOzkM0d7LY-9gJDN6arPiJcejaAPB
    IR50Zpz_saMofVhcA>
X-ME-Received: <xmr:TERaZDT8yCTlYlAq-NfkZ_VTqylS3Xwymywkq6a_WllHp8xLRUVVJYx-KMkEBsb01Pyw_DcmtDHSGHYwTM9yk-uLLAWacrWf0C0U2H2_iVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:TERaZEuG_RiwwYeu6-sEcW1AYSjWtvOAKdqgmQlBmMM04ipvNFQTjQ>
    <xmx:TERaZEdUAX6lUPR4ktdxkTGHIklUqnup1J6KGkytxcv1_mUHp4WYMg>
    <xmx:TERaZI1Io5y8-MqHsqUP0ys9TRxk_0vri5NXX3dn2XRq3fd10MNw2g>
    <xmx:TERaZD71xLr3xuGDyXkvX_MCl6nvSt1cYD6OSLsSjIPTBLro1uPjHQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 09:02:02 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 92cb2a02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 13:01:52 +0000 (UTC)
Date:   Tue, 9 May 2023 15:01:58 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 0/8] fetch: introduce machine-parseable output
Message-ID: <cover.1683636885.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6XAgpB/lyvdefvcS"
Content-Disposition: inline
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6XAgpB/lyvdefvcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series to introduce a
machine-parseable output format for git-fetch(1). It applies on top of
e9dffbc7f1 (Merge branch 'ps/fetch-ref-update-reporting', 2023-04-06).

There's only a small set of change compared to v3:

    - Patch 1/8: The test added by this change has been significantly
      simplified.

    - Patch 8/8: Reworded the commit message to clarify that parallel
      fetches and `--recurse-submodules` aren't niche on their own, but
      are likely niche combined with `--porcelain` given that they are
      user-facing while `--porcelain` is script-facing.

    - Patch 8/8: Clarified that `--porcelain` takes precedence over the
      `fetch.output` config option in the user-facing documentation.
      I've also added a test to verify that this is the case.

    - Patch 8/8: Amended one test to not depend on the state that its
      preceding test cretaes.

Thanks to Glen for the feedback.

Patrick

Patrick Steinhardt (8):
  fetch: fix `--no-recurse-submodules` with multi-remote fetches
  fetch: split out tests for output format
  fetch: add a test to exercise invalid output formats
  fetch: fix missing from-reference when fetching HEAD:foo
  fetch: introduce `display_format` enum
  fetch: move display format parsing into main function
  fetch: move option related variables into main function
  fetch: introduce machine-parseable "porcelain" output format

 Documentation/fetch-options.txt |   7 +
 Documentation/git-fetch.txt     |   9 +
 builtin/fetch.c                 | 437 +++++++++++++++++++-------------
 t/t5510-fetch.sh                |  53 ----
 t/t5526-fetch-submodules.sh     |  19 ++
 t/t5574-fetch-output.sh         | 251 ++++++++++++++++++
 6 files changed, 552 insertions(+), 224 deletions(-)
 create mode 100755 t/t5574-fetch-output.sh

Range-diff against v3:
1:  4b2b0cfe15 ! 1:  d82b42ed34 fetch: fix `--no-recurse-submodules` with m=
ulti-remote fetches
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'fetch --all with -=
-recurse-sub
      '
     =20
     +test_expect_success "fetch --all with --no-recurse-submodules only fe=
tches superproject" '
    -+	test_when_finished "git -C downstream remote remove second" &&
    ++	test_when_finished "rm -rf src_clone" &&
     +
    -+	# We need to add a second remote, otherwise --all falls back to the
    -+	# normal fetch-one case.
    -+	git -C downstream remote add second .. &&
    -+	git -C downstream fetch --all &&
    ++	git clone --recurse-submodules src src_clone &&
    ++	(
    ++		cd src_clone &&
    ++		git remote add secondary ../src &&
    ++		git config submodule.recurse true &&
    ++		git config fetch.parallel 0 &&
    ++		git fetch --all --no-recurse-submodules 2>../actual
    ++	) &&
     +
    -+	add_submodule_commits &&
    -+	add_superproject_commits &&
    -+	old_commit=3D$(git rev-parse --short HEAD~) &&
    -+	new_commit=3D$(git rev-parse --short HEAD) &&
    -+
    -+	git -C downstream fetch --all --no-recurse-submodules >actual.out 2>=
actual.err &&
    -+
    -+	cat >expect.out <<-EOF &&
    -+	Fetching origin
    -+	Fetching second
    ++	cat >expect <<-EOF &&
    ++	From ../src
    ++	 * [new branch]      master     -> secondary/master
     +	EOF
    -+
    -+	cat >expect.err <<-EOF &&
    -+	From $(test-tool path-utils real_path .)/.
    -+	   $old_commit..$new_commit  super      -> origin/super
    -+	From ..
    -+	   $old_commit..$new_commit  super      -> second/super
    -+	EOF
    -+
    -+	test_cmp expect.out actual.out &&
    -+	test_cmp expect.err actual.err
    ++	test_cmp expect actual
     +'
     +
      test_done
2:  6ebc7450ba =3D 2:  33112dc51a fetch: split out tests for output format
3:  78479922ac =3D 3:  006ea93afb fetch: add a test to exercise invalid out=
put formats
4:  46e1266ab0 =3D 4:  e599ea6d33 fetch: fix missing from-reference when fe=
tching HEAD:foo
5:  acc0f7f520 =3D 5:  80ac00b0c4 fetch: introduce `display_format` enum
6:  cd23440128 =3D 6:  826b8b7bc0 fetch: move display format parsing into m=
ain function
7:  edbc31013f =3D 7:  20f2e061d6 fetch: move option related variables into=
 main function
8:  e132d9494e ! 8:  24ae381950 fetch: introduce machine-parseable "porcela=
in" output format
    @@ Commit message
         be ambiguous without also printing the repository in which the upd=
ate
         happens.
    =20
    -    Considering that both multi-remote and submodule fetches are rather
    -    niche and likely not going to be useful for the majority of usecas=
es
    -    these omissions feel acceptable. If usecases for either of these c=
ome up
    -    in the future though it is easy enough to add a new "porcelain-v2"
    -    format that adds this information.
    +    Considering that both multi-remote and submodule fetches are user-=
facing
    +    features, using them in conjunction with `--porcelain` that is int=
ended
    +    for scripting purposes is likely not going to be useful in the maj=
ority
    +    of cases. With that in mind these restrictions feel acceptable. If
    +    usecases for either of these come up in the future though it is ea=
sy
    +    enough to add a new "porcelain-v2" format that adds this informati=
on.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ Documentation/fetch-options.txt: linkgit:git-config[1].
     +	Print the output to standard output in an easy-to-parse format for
     +	scripts. See section OUTPUT in linkgit:git-fetch[1] for details.
     ++
    -+This is incompatible with `--recurse-submodules=3D[yes|on-demand]`.
    ++This is incompatible with `--recurse-submodules=3D[yes|on-demand]` an=
d takes
    ++precedence over the `fetch.output` config option.
     +
      ifndef::git-pull[]
      --[no-]write-fetch-head::
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output' '
     +test_expect_success 'fetch porcelain with multiple remotes' '
     +	test_when_finished "rm -rf porcelain" &&
     +
    ++	git switch --create multiple-remotes &&
     +	git clone . porcelain &&
     +	git -C porcelain remote add second-remote "$PWD" &&
     +	git -C porcelain fetch second-remote &&
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output' '
     +	new_commit=3D$(git rev-parse HEAD) &&
     +
     +	cat >expect <<-EOF &&
    -+	  $old_commit $new_commit refs/remotes/origin/force-updated
    -+	  $old_commit $new_commit refs/remotes/second-remote/force-updated
    ++	  $old_commit $new_commit refs/remotes/origin/multiple-remotes
    ++	  $old_commit $new_commit refs/remotes/second-remote/multiple-remotes
     +	EOF
     +
     +	git -C porcelain fetch --porcelain --all >actual 2>stderr &&
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output' '
     +	test_must_fail git -C porcelain fetch --porcelain --recurse-submodul=
es=3Don-demand 2>stderr &&
     +	test_cmp expect stderr
     +'
    ++
    ++test_expect_success 'fetch porcelain overrides fetch.output config' '
    ++	test_when_finished "rm -rf porcelain" &&
    ++
    ++	git switch --create config-override &&
    ++	git clone . porcelain &&
    ++	test_commit new-commit &&
    ++	old_commit=3D$(git rev-parse HEAD~) &&
    ++	new_commit=3D$(git rev-parse HEAD) &&
    ++
    ++	cat >expect <<-EOF &&
    ++	  $old_commit $new_commit refs/remotes/origin/config-override
    ++	* $ZERO_OID $new_commit refs/tags/new-commit
    ++	EOF
    ++
    ++	git -C porcelain -c fetch.output=3Dcompact fetch --porcelain >stdout=
 2>stderr &&
    ++	test_must_be_empty stderr &&
    ++	test_cmp expect stdout
    ++'
     +
      test_expect_success 'fetch output with HEAD' '
      	test_when_finished "rm -rf head" &&
--=20
2.40.1


--6XAgpB/lyvdefvcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaREUACgkQVbJhu7ck
PpR3Nw/+NKpxyZmP8d530jMvxM/xxSoDqPTbSwGxoo8mepyTazCch5mWew6lkwnV
xqUtXtPraTp20tip0QKSGpGoF83QJ5D6q3fwwPs+hQ9Jp6IfIJsfApI311nc5TZx
FTZv0AOxyGtsSkDHeg05cLip2M3MuhS0aKjzafRUwN/YBQTgQ+RwAl/qKGZ6X/jV
1JX/SAjWU9Zc16mlTC5ryqObvfGD84nSFi7ptvBcA4zguityV6s5yBLJVcVgI3gy
mLYMM7Nvx11tHGW6FFeJv4vQR27MVcl5aOwtd+IeseznDABj64pQM5m3WnkVY92p
GLqkiLnriwUIonWk5N730IuHPflEYPWfJpyyvUDNt4MIwVo0JRebT9JLGWqb1TBc
8hmJhzzKOZvoMBBI1EekIWPhS4ebol3NPRP18lbOXDZUUigmTaiGsH/qXQow30W3
4f1ffcU8chJ4yv+zlXjfsU80vgoslk6JWR0WRrgb2wJt16kKfJTzx0eJlzUN+j3+
4Qe//+CWk7+QjUZ/lL3hdIVTlg5afyvzkRLGMAtH3KdCMcvgR77ntSGD5pOFtbSq
eBBKuD8ADirCOFR5tPRCcyEh8GA8iMs7bqf70rtwv1bBJbdRY5FS0dv4qmr0Ugff
3OkBJSormYqAvEYriI0HwIcYLZxvqC/D2ehmUKXSwOXA+Xe3oSE=
=jUEZ
-----END PGP SIGNATURE-----

--6XAgpB/lyvdefvcS--
