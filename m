Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1FA170A37
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508697; cv=none; b=QjyGk+xl6HHt32gNoH6jl1NGpFjPo95LE1lQj6zBcQjrLeiKgXPqOZdnRQnv4bmwemvRigqnTQ+FQn95vAjC4IHhLAmY8blzgGxeDtuW6howA0iefL7adI2nnmWBwVXdRoRMeJVNVRa7cb470dW60pnPlz98hFjXz+v/We67cUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508697; c=relaxed/simple;
	bh=XMo+CPb4WyYUIbe7xV9U1wLE/QNLl+SmBsjwyPTenXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YygeVgRYVs+yZhBql3hpjzLp/BBgTLQf/z7KM1E/67t4c4SDFNHRFRHIT63boODppia2MdDxh/rkyK+9wbBSbWMEIpoaqVxV8RAPMkPutF/TNu0vCZj77uUvOFIlJ92CF+OnJKhjurRZAsUD99D3EiyUr7rztsD1dPrFEYCszlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VvAchu1p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kZNcD4Fq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VvAchu1p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kZNcD4Fq"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id DACE31387A85;
	Thu,  1 Aug 2024 06:38:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Aug 2024 06:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508694; x=1722595094; bh=VOnmKJ4VYp
	O7niPKNJn9ogghV1pawQJ7Kgxw6JlaSI8=; b=VvAchu1pdQrPoAZw7ZeK8+2X+M
	9twythE2AftqaBBhZoqQvyWtZgR4APK7dPwBryTVIeHwO4y94CIZUtE3J5e3r7dI
	tWQrzVEvAahrOWIJkpBzWeYT2NM5urmvWVyKxP/qAkyHTuo0rBJKuGGyMJiVCKBD
	kIDGG2YYo8jy2duvjXVwYTqRco7R+vKYbrcRtfgLU66vQNZ4BiWAX3rPKsKM9pah
	ZWVPmPYBEYgaBOW4WMn0ZFt0t0iJXcVmo0MNwtKUE5hUg/lmu92D+G47BzVBkCZ+
	pYmVB8FRuKgVQTWUf0EhwchrRpxT3Xm3Weep6Ecj8UmHZSLhSi43V1VmNYSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508694; x=1722595094; bh=VOnmKJ4VYpO7niPKNJn9ogghV1pa
	wQJ7Kgxw6JlaSI8=; b=kZNcD4Fq7stLzNAnpR84azVySUUuUaYD/5cfZrzYbeZZ
	N1hAfmOirjiNphShvV68XjoWsU4veQPQJFC8G/oAXgQYkXWYr5e7p5JJq1gA4t3M
	ceZ2gcLwZKpu80Tl+32TxsMBUjoqLR8/oDU9uXPqCvsXzRyGMxJACmyB5OrW7iGc
	VIcA0LW6CJ7wfVswvayAiGC3MPFpgbXOvSpyGfSqAZI0dArqqMxTK5ptlJ4J93Yw
	bWiZdg28N9kDjoRyNEzYRr0EjVWGZrvw3EEbh5NF+yA5JUP5QLAIeKZbSnWCjkeE
	+mBcsDuryh22HaQXNl81To/a8i1hlsCJija4i140yQ==
X-ME-Sender: <xms:lmWrZp8PS6yCuMRA6ptxcBYoBXcLsq1apJi7-ygq9p8CqU40g7OjNA>
    <xme:lmWrZtuciFwkmz2lEVIjeW0oblB5-hnWonMiHgTu7v5P8qyxVKDEFLVbIirJJnMcC
    Ryh_e-jH3dY8s2LbQ>
X-ME-Received: <xmr:lmWrZnDjW57jm3uBUrtBhRrBx61Oe8HSxRe2cU9cGvjxz0-SO0CrJJoccMcnLEFqBFXKlM8v0mxiN6mbJCSeXk1wuOknD8vyiD5OSNm0-c5oz-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:lmWrZtfimQt7OwjAY_twb68nJdfaTGJWY13aPVXw-ThvP37UKwprpQ>
    <xmx:lmWrZuODyv6pqQhXRSil5Ou9GQJcFgKZItbRoQatWzVH95ucKrHJfg>
    <xmx:lmWrZvm14l6HhL9tBbeacWxy8gWld_G3DlGKyDPCg75FE8i3yAEjww>
    <xmx:lmWrZovCLjjrfl_mruN79BWVtl1X34Yzc2itP9nhIde6RGVk6moW0A>
    <xmx:lmWrZl2MYuEbDOSEsrPD4hyyr98s1A-Wh9kb7_7Zp9dTgk8oc2E9sVyX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:38:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 46ddb5fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:36:42 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:38:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 01/24] builtin/replay: plug leaking `advance_name` variable
Message-ID: <b5c8a9495ae81ba0757c92df634117e836e89699.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SGiPy9ARpyx9xdLZ"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--SGiPy9ARpyx9xdLZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `advance_name` variable can either contain a static string when
parsed via the `--advance` command line option or it may be an allocated
string when set via `determine_replay_mode()`. Because we cannot be sure
whether it is allocated or not we just didn't free it at all, resulting
in a memory leak.

Split up the variables such that we can track the static and allocated
strings separately and then free the allocated one to fix the memory
leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/replay.c         | 20 ++++++++++++++------
 t/t3650-replay-basics.sh |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 0448326636..27b40eda98 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -151,7 +151,7 @@ static void get_ref_information(struct rev_cmdline_info=
 *cmd_info,
=20
 static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
 				  const char *onto_name,
-				  const char **advance_name,
+				  char **advance_name,
 				  struct commit **onto,
 				  struct strset **update_refs)
 {
@@ -174,6 +174,7 @@ static void determine_replay_mode(struct rev_cmdline_in=
fo *cmd_info,
 		*onto =3D peel_committish(*advance_name);
 		if (repo_dwim_ref(the_repository, *advance_name, strlen(*advance_name),
 			     &oid, &fullname, 0) =3D=3D 1) {
+			free(*advance_name);
 			*advance_name =3D fullname;
 		} else {
 			die(_("argument to --advance must be a reference"));
@@ -197,6 +198,7 @@ static void determine_replay_mode(struct rev_cmdline_in=
fo *cmd_info,
 		if (negative_refs_complete) {
 			struct hashmap_iter iter;
 			struct strmap_entry *entry;
+			const char *last_key =3D NULL;
=20
 			if (rinfo.negative_refexprs =3D=3D 0)
 				die(_("all positive revisions given must be references"));
@@ -208,8 +210,11 @@ static void determine_replay_mode(struct rev_cmdline_i=
nfo *cmd_info,
 			/* Only one entry, but we have to loop to get it */
 			strset_for_each_entry(&rinfo.negative_refs,
 					      &iter, entry) {
-				*advance_name =3D entry->key;
+				last_key =3D entry->key;
 			}
+
+			free(*advance_name);
+			*advance_name =3D xstrdup_or_null(last_key);
 		} else { /* positive_refs_complete */
 			if (rinfo.negative_refexprs > 1)
 				die(_("cannot implicitly determine correct base for --onto"));
@@ -271,7 +276,8 @@ static struct commit *pick_regular_commit(struct commit=
 *pickme,
=20
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
-	const char *advance_name =3D NULL;
+	const char *advance_name_opt =3D NULL;
+	char *advance_name =3D NULL;
 	struct commit *onto =3D NULL;
 	const char *onto_name =3D NULL;
 	int contained =3D 0;
@@ -292,7 +298,7 @@ int cmd_replay(int argc, const char **argv, const char =
*prefix)
 		NULL
 	};
 	struct option replay_options[] =3D {
-		OPT_STRING(0, "advance", &advance_name,
+		OPT_STRING(0, "advance", &advance_name_opt,
 			   N_("branch"),
 			   N_("make replay advance given branch")),
 		OPT_STRING(0, "onto", &onto_name,
@@ -306,14 +312,15 @@ int cmd_replay(int argc, const char **argv, const cha=
r *prefix)
 	argc =3D parse_options(argc, argv, prefix, replay_options, replay_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
=20
-	if (!onto_name && !advance_name) {
+	if (!onto_name && !advance_name_opt) {
 		error(_("option --onto or --advance is mandatory"));
 		usage_with_options(replay_usage, replay_options);
 	}
=20
-	if (advance_name && contained)
+	if (advance_name_opt && contained)
 		die(_("options '%s' and '%s' cannot be used together"),
 		    "--advance", "--contained");
+	advance_name =3D xstrdup_or_null(advance_name_opt);
=20
 	repo_init_revisions(the_repository, &revs, prefix);
=20
@@ -441,6 +448,7 @@ int cmd_replay(int argc, const char **argv, const char =
*prefix)
=20
 cleanup:
 	release_revisions(&revs);
+	free(advance_name);
=20
 	/* Return */
 	if (ret < 0)
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 389670262e..12bd3db4cb 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -5,6 +5,7 @@ test_description=3D'basic git replay tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 GIT_AUTHOR_NAME=3Dauthor@name
--=20
2.46.0.dirty


--SGiPy9ARpyx9xdLZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZZIACgkQVbJhu7ck
PpS00w/6Agidth7rgCBne88F4bNCtc5sgHjcHXtZpmNLsXHOtIdQKTVdO1A4bcFb
iEYWEjkGDjbFBZMZv/uIoEjxoVdkpPsjIuULWk6UxNZTJ/As31T3LYGTUbL67LFK
1V+YTXlohYt8FoZfkp5ic3/b8FGKEbFWSQsOTyDMK2HB0qumTNtC+9L2CVcClhiQ
LVltVO//DpGsTF/yJxtnQhP9vg8LU5p3mUtvqt4RTiNJq1ze5Oz32K1tg3vYOsP/
0ZGv7EkDszucjOYbYSzlCcLLTv4nY/vdqzPIcQUbd57nh4pLzQ96yseGvdaEOuSe
np0ryH1t3s91z/GwUTMvbXDdC5QmdA/kMPH1FDndQb9/JOWQ7qoPA8EWE2rMtqng
t88cc5Lj2ELFRePi3tZxx4eOFFLP+TalRRGbzOfvF7x+HM45xDmU+V4WKlH5nUZo
fHpMOlqqmLvCcAxeJ2C3oOT6CWVt3cHJBef1QelgrQL2V8aHLSrZRqgQX5/xtNQO
mgBeCaLgJmXZ+yZkKQbdbnydhZ/i6q6vOTccDIvxc8KyNJqPDoxCCFpSLiXwR1h8
IYNXEKBo2QEnbBopbyxyRmmOc/XJiiwPuaPWBYec6NlaY/ThzoswE72LoUPW27rA
oAO+j1fhvcq1QJNYjImHQ1i2QAPV6ZCWjyPtjaIUWkhevWApGbM=
=NgcI
-----END PGP SIGNATURE-----

--SGiPy9ARpyx9xdLZ--
