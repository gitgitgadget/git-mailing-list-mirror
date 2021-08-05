Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8D1C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E282661108
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbhHELZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:25:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55903 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240623AbhHELZm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Aug 2021 07:25:42 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 20B435C00C2;
        Thu,  5 Aug 2021 07:25:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 05 Aug 2021 07:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=WuoF964+NMkZPHlCpgvNh99sdy3
        /bDL1xWbmx3G4QfQ=; b=TYzh82ARzCmhNoP1sPDqJptekuMlsRP5ploOBFbqMeC
        cvlWt0Mcn+bqn1MxaO9fa8GTu8WpZZ/iGz+xOJpECRFuNDu6Gri7T3jCYiYH+rrp
        NCogiK1MK772zx5eTDpglRJ8DtU1/TBl3GF7Q8PuhkhbxxGEOm9M4exRHxM960sf
        RmyahIL64LF2iuRBjLgOPsOR0HEB8LJinKWFtYiWcSH4yLbx6EJsx7mm9vOYgN9V
        Zr8v9sCILTgMbzoKJ/wcm+kLSwq0PjYBGrqY9quPTXY91i9zPjRGQAS7xApf+ksE
        CrHROvmB7nJYeqovHzbw3Iig+evV+KscRGl8oVHLN2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WuoF96
        4+NMkZPHlCpgvNh99sdy3/bDL1xWbmx3G4QfQ=; b=Z7RPJhG1v7YoSlzJwNzZLd
        5Dxtmz/vDhGdfNckC4YwVejElLcdDPZrf3cAtqCEAMAKg6DpMEX6UNfBa1MzNzel
        og8OKcxrzA88M6t+z4VfYU6Jtrwci49TNN9exqe+PpSplh0sxYb7T9XnnYmJE65f
        eCkfQfbhsi3F3Hz/DeUs3Ers9MR7K8r0KKcrOiH6J0v5oOY5PrPpyjFCe4J4uB56
        8c0TOeyHubrRp9rlp+U15K2XKp8Lz6R2AKhiaIOnQJlY6zVebjmUzxByYRylM+kj
        mpss8mDOqg3ykqOJwNsosibu4CTKNPFOeeTZ9R67okDYESPg+vPn0ujV0ZgMzu3Q
        ==
X-ME-Sender: <xms:qMoLYfGrxELBvAnw-Wxr08FkKoC9vajIjFqgllI4HvIdBNDkpoU6hg>
    <xme:qMoLYcXXWeiaxZSvtnOmBsU6HPvptHx7CXbKuTayurKMpdTnWcFRi9v-0ohglINja
    BHK7sEFqaQng2Y6eA>
X-ME-Received: <xmr:qMoLYRI1GF3NAKRDgLyDSQgTdzH7xwdeY4eUBWiZ1siLWNYwgJ28J4NN7VyYTvu0OpXpqbMAgrk8Z8XsTdMzaeqaEdkndnXO-g0b8lpnWSlKLiOVT0uHAzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:qMoLYdEweDBxfLGe24OTgXS0S5IZdkLLRHdnXBIZUnj4Ym1xy02DNQ>
    <xmx:qMoLYVVT-BkbxMyD5L0v7cMoTXYEDnHTTP2b4EXlgQaIOUlUCXWGkQ>
    <xmx:qMoLYYN13DJP6J1QjUU5exAEZHqGnFMYvKFe1VQGDvOWMvtbAgpEYA>
    <xmx:qMoLYXLv6HH5VwD1s8xEt3n0DUhAR7KM4evW-RCAqCwhIqUsclxe_A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 07:25:26 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 153a1d56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Aug 2021 11:25:25 +0000 (UTC)
Date:   Thu, 5 Aug 2021 13:25:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 1/6] revision: separate walk and unsorted flags
Message-ID: <67232910acf4a248654060ad51a17af37acba0fb.1628162156.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628162156.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="koPKDLV5mS1MFM9z"
Content-Disposition: inline
In-Reply-To: <cover.1628162156.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--koPKDLV5mS1MFM9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--no-walk` flag supports two modes: either it sorts the revisions
given as input input or it doesn't. This is reflected in a single
`no_walk` flag, which reflects one of the three states "walk", "don't
walk but without sorting" and "don't walk but with sorting".

Split up the flag into two separate bits, one indicating whether we
should walk or not and one indicating whether the input should be sorted
or not. This will allow us to more easily introduce a new flag
`--unsorted-input`, which only impacts the sorting bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c    | 2 +-
 builtin/revert.c | 3 ++-
 revision.c       | 9 +++++----
 revision.h       | 7 ++-----
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 3d7717ba5c..f75d87e8d7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -637,7 +637,7 @@ int cmd_show(int argc, const char **argv, const char *p=
refix)
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.diff =3D 1;
 	rev.always_show_header =3D 1;
-	rev.no_walk =3D REVISION_WALK_NO_WALK_SORTED;
+	rev.no_walk =3D 1;
 	rev.diffopt.stat_width =3D -1; 	/* Scale to real terminal size */
=20
 	memset(&opt, 0, sizeof(opt));
diff --git a/builtin/revert.c b/builtin/revert.c
index 237f2f18d4..2e13660e4b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -191,7 +191,8 @@ static int run_sequencer(int argc, const char **argv, s=
truct replay_opts *opts)
 		struct setup_revision_opt s_r_opt;
 		opts->revs =3D xmalloc(sizeof(*opts->revs));
 		repo_init_revisions(the_repository, opts->revs, NULL);
-		opts->revs->no_walk =3D REVISION_WALK_NO_WALK_UNSORTED;
+		opts->revs->no_walk =3D 1;
+		opts->revs->unsorted_input =3D 1;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
 		if (!strcmp(argv[1], "-"))
diff --git a/revision.c b/revision.c
index cddd0542a6..86bbcd10d2 100644
--- a/revision.c
+++ b/revision.c
@@ -2651,16 +2651,17 @@ static int handle_revision_pseudo_opt(const char *s=
ubmodule,
 	} else if (!strcmp(arg, "--not")) {
 		*flags ^=3D UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
-		revs->no_walk =3D REVISION_WALK_NO_WALK_SORTED;
+		revs->no_walk =3D 1;
 	} else if (skip_prefix(arg, "--no-walk=3D", &optarg)) {
 		/*
 		 * Detached form ("--no-walk X" as opposed to "--no-walk=3DX")
 		 * not allowed, since the argument is optional.
 		 */
+		revs->no_walk =3D 1;
 		if (!strcmp(optarg, "sorted"))
-			revs->no_walk =3D REVISION_WALK_NO_WALK_SORTED;
+			revs->unsorted_input =3D 0;
 		else if (!strcmp(optarg, "unsorted"))
-			revs->no_walk =3D REVISION_WALK_NO_WALK_UNSORTED;
+			revs->unsorted_input =3D 1;
 		else
 			return error("invalid argument to --no-walk");
 	} else if (!strcmp(arg, "--do-walk")) {
@@ -3584,7 +3585,7 @@ int prepare_revision_walk(struct rev_info *revs)
=20
 	if (!revs->reflog_info)
 		prepare_to_use_bloom_filter(revs);
-	if (revs->no_walk !=3D REVISION_WALK_NO_WALK_UNSORTED)
+	if (!revs->unsorted_input)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
 		return 0;
diff --git a/revision.h b/revision.h
index fbb068da9f..0c65a760ee 100644
--- a/revision.h
+++ b/revision.h
@@ -79,10 +79,6 @@ struct rev_cmdline_info {
 	} *rev;
 };
=20
-#define REVISION_WALK_WALK 0
-#define REVISION_WALK_NO_WALK_SORTED 1
-#define REVISION_WALK_NO_WALK_UNSORTED 2
-
 struct oidset;
 struct topo_walk_info;
=20
@@ -129,7 +125,8 @@ struct rev_info {
 	/* Traversal flags */
 	unsigned int	dense:1,
 			prune:1,
-			no_walk:2,
+			no_walk:1,
+			unsorted_input:1,
 			remove_empty_trees:1,
 			simplify_history:1,
 			show_pulls:1,
--=20
2.32.0


--koPKDLV5mS1MFM9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmELyqMACgkQVbJhu7ck
PpSBbBAAhc/vfr1KJRxcVatkFRzmP87jl0WrNJY+Iot23husCo0avCGuM+4GWdSH
TrdLI5IJDJ+6Mb6uVneQrErL3LG1LBnKnxvWh/jGnVGFcnuXfELThbiGRchOJlp+
RO1AzNaOr6HCHIfY+88LRnS26A0uQo9kDoo5pF2sfW7CnjFep/ii3p0sebkf5jWI
xOhe68ZlZcLP1/Uurx8Q7C6mZzmYVbRdf8pU7gZ0GmuVhPWQyQmtowR8L2PJfaoe
i9zn/tZkylkanI0du5VFoFHuuS4VIDJ++dLPrqoWD799INaxui8vud6ySLaN/bar
bIaZMU7GpVtNEyRO1Mn4ESCPjm1a4enutl3OXi/AsovckMk0lCQaXsl6Fcyx2LEJ
LaWhL+S3QASWAKmfn8Bd47sI3g3UHRtmEmHLAGndCS9lOyhWRpVrS0xOzTPAe96E
KApVxntkN3FCLp3CeZlxgfRvP6iLMx6gpb0yzQtXfVjZmxUWYzUpQeD08IZXYoTe
DBgfk6TUG1Ifau6/NM/jRSdFPJx2HGvS62yotFXr5nA1HNK0HKdPXBIwl3RotJPl
KT/HcQlSKyHf7WGVTf03Ofk+7MRm4T9G4WFFeaE3ODoc1qDSm9QnBeu1dQ3YGa8W
A2011EobWpQCXuiXdCQNQUjbkv3kn4TwSrX5+d151S7H0ARQeq0=
=UYV7
-----END PGP SIGNATURE-----

--koPKDLV5mS1MFM9z--
