Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D994C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C05761078
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhHIIMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:12:14 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35033 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233588AbhHIIMJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Aug 2021 04:12:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 939085C012F;
        Mon,  9 Aug 2021 04:11:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 09 Aug 2021 04:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=y5xqV5xBxnIdFczNjPBEwHXBGsQ
        FZJNQYX7p1l5ILd8=; b=hjPjEY76rnUsS2XNWgDWU/fLkKBPhM2XeUBNUO9SUne
        IVLPfN1HDxxVGIaxpuvAbvCYEG8lypsoZOU8QArSpt/MddDJqcBLXC1EpBoGw6va
        pXJDx4Qhbb5Oq7DbmSE2cgtWC4wJs2xrnmqsen88xzAXUbBlyAKTL3XZDgaN0rAZ
        6UPp9nhGz+4xuRx4Lh1rvdFGPDIEMVQvXyy6NMfpCsjMsXzy3s+65hjOqf8RoXHA
        z+Wc2smQ5BHG2Qoda2c1BnLCTshMD3OVyPrcdeGTGrHucRvLXn9Q4nB2td8oBgY0
        Xq8SgFxVAkpOV5rpY9v77BwpRjvPSmBG7dEue8+0E4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=y5xqV5
        xBxnIdFczNjPBEwHXBGsQFZJNQYX7p1l5ILd8=; b=G6QLRlqhHbrTGVPTdA1kBe
        VtAwAN6f6zLOyLBpNBZYGnaEjC201Zq1how2+709vXdm4WLm5aU7KQ02eU4bJXsx
        AQp4RTp+jRAxgUooWmtAJ8Yyl1ZJbsbSzA9BhqaPJSneU/V8ClyecYAnb+IKwu07
        bM84YgFniUs9dyek596o/sqSYJ7eTgYeTu8KD+gzt8rU7ljsylTTRjXaNiG9AaOd
        Gqk0FixxmORTEZFP8DotjM9JMSIzAz33Reul16/WNcoojWIuzlUxv4/0TDARGFio
        h0H/YmbpoqqYkZ9WrUrBfVAOVu4CxsQlcBE1qVD7u2+nU33TPHNtkA4rSvhxClFQ
        ==
X-ME-Sender: <xms:ReMQYX9TCwQYxCS6VMKJjiQ7xGdgjD_emz-z1TXnXQna5mv84aljNQ>
    <xme:ReMQYTvD4EhFDT09N91bgfc7gK8qK4hYMkBC89cN4wYU2sLI6DZUo6FYM9FMEqTdu
    3Dy2_YNU7BFzSEpAQ>
X-ME-Received: <xmr:ReMQYVB63hL5-uJfxEO8ywvgb5XflqmHZ3LG5uyxOLYlybHsIHCjBmYFDjobZrFLmuDeOtctmn2vCH7Y94tZaexT4Wd_AhaDnaXGiPOZqh93Y-DccpWAXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeejgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:ReMQYTdgQVGUP7qPCIDjJbsInJzbI36z-xASxkXKCC3XrgkZ-kxBOQ>
    <xmx:ReMQYcMlP_YxtDYlQr5pyI4070GYpui-35KdlE6uySWbhhELX1b1LQ>
    <xmx:ReMQYVniev_3oWMerdijeunXpCMfk6LvbXK6s9etcu4MIEmr5vKQQw>
    <xmx:ReMQYYCWgD7L4WmZAvTlg_kElJMGeUonC8KqCNCKjTAzu_1stYd1Mg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 04:11:48 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b53ce53d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Aug 2021 08:11:47 +0000 (UTC)
Date:   Mon, 9 Aug 2021 10:11:46 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 1/5] revision: separate walk and unsorted flags
Message-ID: <67232910acf4a248654060ad51a17af37acba0fb.1628496539.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628496538.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IGFndhIuVqRXLrPe"
Content-Disposition: inline
In-Reply-To: <cover.1628496538.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IGFndhIuVqRXLrPe
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


--IGFndhIuVqRXLrPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEQ40EACgkQVbJhu7ck
PpSH0BAApWXXLrmUWfce3lG+VefTXNokW8ZSgu7FdWUkkJPXtPRND0KUV/55DfYS
mGZvV2oIGcjUdbN2PDQlkDPOh3w8dNp1x0BZVVivTm0RaolwZuPnY29k4rlIcWca
5rgnwYhzuO60TfN+KEFbZmv/d+9OpoJVubxDE94LlncfNOE1Oz5q4i0cK2yEubLq
qqxg2YH54vBpDbCwyqJM+mkDHSYZyMJ0iINLNcQnSYWtNIfgbaKzGlLOyMlC1Q3P
MVg0gzaH5Zv6Stbznyym7/zgoiNMdqoCpLtcuND7JqyxSjh8Qkir40SxnzBBvk4i
2TlgJmkNpbHH1Ot62+MIajq5Xghyq2IE9NESqLB5LTcm2+RYFxa7Fm5rBRe8Ol0K
cJCaLFqcZtuMwAsGnM8sZOjoOxYuiw63zD6H7r3uzniObEn9DMqTnPBho6ejNEl0
C0mx+IE7UvnvP3bNi2ix9AeSElMgKXrHtK55GGZrls4LD12DnL4DOe1OAb4Ud3nu
Djjjp3A7jRmGpfVCxRvV4h/tln+Hd+zMAehhk+CLFZwoY2LeynyKhIKOp93GWb8e
4CFeo8TTlafKc9U/ee4YMbqVR8B3sQyXgwLvRAnM+KkfP4tmCHpIqMhlgRjl/aBc
m1FD93uUklA2FQk1GhCcF+s2KBZymbOf1oNXppuOsNFKCVnqNcU=
=CHDK
-----END PGP SIGNATURE-----

--IGFndhIuVqRXLrPe--
