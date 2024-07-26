Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4687DA3D
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996050; cv=none; b=arMMQxKFTvD0nrtNI6ZuVfDlloaiZcYYsH3P6mgIokiRlrRjakzCBR9PDHYA1UMlOuwbBjdpk1xXl09eUhCs3wzRyeQYD78CuYhfcjIz2/JINEd3ZhZBNuBLAUqzFpMDBGvUET19oYBZjzIvDTMdEfVE7e/UEKXbA4K6+8tPnO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996050; c=relaxed/simple;
	bh=2d8b9LJmbevrXYxtFZhIEGUXlA4IFeHYkmNk6mSGnzM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzRsGCfDkljHMQoVF2Bl//adUkhvgmOzrAgvfO0BhfxzqVF+yEC6YHluTeGB39SqC8qqAJr+LC8aN/qsVsCOF6DbecguS+nEeQVwcBp0omIvJePicXFDg3xFh26ohd5iCLWs+gIyL/7A6FjzFjUFbr6XfqfUWehv/WHFOE/aTis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jE2+Za71; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a8Ek1pNR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jE2+Za71";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a8Ek1pNR"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 19387138063E
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:14:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 26 Jul 2024 08:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996047; x=1722082447; bh=TSAq4/bUnD
	B7UtIBwCvWyVdHqn9Jg3Y9WCHO5y8tkU4=; b=jE2+Za71OXbk+GZJNnwkVGl185
	25+MoBBs+J/5wJDgcpWkIAbH0Dq/z3SPb6wDtsZmBQxlNa0+RraPYBhnMJaJQciX
	YUejxvaGNtKsv7sDD+SKuQ6ZklHV5mAC7UU2FDuyNBXUys5wT5mFKcwvkQLxqfAM
	R9IOVy8CMaqCaNKcbt7DhTHLBU+RCw3xoeNrXsqq84AP6OPQq2+croA+uZYZMRBU
	h2PJxq0scu//Tva59Qr/Kp1YQl8/c7TNHkcTy92lKnwfLCMtWtd8CNaKsj3XhW0A
	aEuFHu5SzISR7GGbZFss4nOCjHX3zBibivrcCKch2hvybhAMjUwxZ7155OjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996047; x=1722082447; bh=TSAq4/bUnDB7UtIBwCvWyVdHqn9J
	g3Y9WCHO5y8tkU4=; b=a8Ek1pNR4aJrunSzz/SxdGBPBb9cEmBj87kkgzzlIA/y
	cZf6VGZL/4sV3n0VlBROXp1CNL5zjXo/Dvh/7FZF/GJNRFFpjiVd0OHezD2LieeB
	DnDH42Z1zoNGQZtRr3JsQ+uKdU668/zqRxOWApK5GNqi61eT5qxEk9jai1XyFmC+
	85eJUIOu5M2If3dOkBbKUCS0byPeAR2J+Jd0mQEN8zK2M+dalh75cVMWeVKbHM+2
	BvycLtvEmyxkZhMcuAeD7t7yoqofeAqHcP5tY+/2zIP9QqzfiEa8JA/+Vrw8Dq63
	KtPLsxL2fFjXj+BHlPIM1oAB+YmnH0ykyv6UmyNI/g==
X-ME-Sender: <xms:DpOjZn6kbb5FpkR8Hkzs1W5LjkJt0fAQqOq0pBGq0oKLC3PsnwFpPw>
    <xme:DpOjZs5ZlsZKnKEgY7A2byeNE6PzQ0tq_raeteJGCie2Vp6Sl2JWCm4ALxmebSydN
    x730uvr_ZZNxqAF1g>
X-ME-Received: <xmr:DpOjZueo-wdhHOuvTPEH9ofXXdSc1jSMCKR5gXVUmNgUY6FLC8JZFhYusIWrO_tCsJHOVcPO4OkHLuh27DVz5fizO3e83s2m4dIaGam_At9Xidok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:D5OjZoLgvcv7vPKwZ_8RRdzNtS9PSRjmBPELgsfQE6I9l1K8Ic1Biw>
    <xmx:D5OjZrInqUcWrcIBL9XouQoQegpyHqMP7kLF2Sm4nF05VoWHnvobvA>
    <xmx:D5OjZhxvrvHavIw92sLAOHV5DG8aQoQi2RQ5ZL_zMMn7mRkj3b6teA>
    <xmx:D5OjZnIIhsf4PCpW_U8RX4l-cQtlQ4bH45WZEiF1HYMyWo_oCuAVxg>
    <xmx:D5OjZhi6C35PnjZ0bEvWbyNGnibYqlR3c_jmrp6ipNvsHEln1EJ6IcSN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:14:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e6abcc89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:12:46 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:13:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/23] builtin/replay: plug leaking `advance_name` variable
Message-ID: <dd044eacc2b20c3e426f5825fdc30f4db6618052.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d7I/hGbl0RY89+nq"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--d7I/hGbl0RY89+nq
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
2.46.0.rc1.dirty


--d7I/hGbl0RY89+nq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajkwYACgkQVbJhu7ck
PpS5eg/+LSOqrT3idukO1WpR6f9Nq7aOc3KLf3RAXIB4U6I7CR7G9v/QCO6ZQiST
8j9KnbNkUdFAXoWss5htWe3nAxL9iKLQrOnXZnK5WgILBixGcai7R97lUKRUpm5+
ylaJCXJ5UokgnA6t/rZ9Y7brXhae8Fgsxoq9nh2kJIFpIBlyzGfOLa13Z8G1fHcA
HRCg0xRWLpHh/0ynGbgriE5cxZCWLOVwF/pyrcVVWahVduR72b4RF8uzOWYfbqx/
X3ROqQlv3TObHK5L8ec0zqDtDA5SjlYFPzoSQJbT3ZYQ5V0/gXwAzZTOM9mIhn6H
B8ryxddBzZ+6JWaFIrh8k1YFCX+f5m8QyuBR8FrQuRXg9ecBzPcNzymr5O5JgW0k
0jtmY1F+n/whXt9e7ug0kCkYVhzP1pSyOWutLtyte50Socmh9yruC4+05rDgi1ay
exE9i+KB3rCznGxJ6zGszTA/tcy03QMUgIwOBYbXwQ3uUMICRKS+dQUoRbnyRy6m
A/kYoBwrBjVrtcw7G0NBZIforaCO2c6QFZq+xKUIwO9BXcZgWyPLc/PWlM54YaPl
TP0iXo8wlhda5q7OWD44MMcGljWLa7MKcd31wSiS5Ffaoa80MC6uw7b9NDRFDt1z
8Z+r45NwF2Qo/ebjG5RQ670XL3PmGTaHgeLVbtnHGGi+cDTiABY=
=KbRl
-----END PGP SIGNATURE-----

--d7I/hGbl0RY89+nq--
