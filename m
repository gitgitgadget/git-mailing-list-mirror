Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D22E3E9
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637877; cv=none; b=Go24Gnx9MFbrpdgIWH0SFFc867cX5z9Zmam8xTfJqfI3Mspab80aIBQwKmbDQwR9qd10eMAm/YP5QLLL+rh6vxQvkzG5SiGFKB07TYPq+TYc+uTEzj/jf6l1WobF/rzImo5hBpsSAxIGatKUg07xaoa7FKQl4uC2GyGTG50BoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637877; c=relaxed/simple;
	bh=ZklXTU0glvzDK5etBExuHEr0oZ1Od1Ti3Ls6oB8aaRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npfXmj2VTxsXRyoZe4gHr2PJHx6Wr03MerE1vuz1O5DozprxoCpRDJSdTg18O0XH9o+j+iMMrE7xxJggNNgliMMnr3yCtWRrzHTu8ay96hxSAir90nWROGl4GuVrfwaUdduvBaCBR02aEhi9k5FOn9UnKwk2n39UL2h4XOwMPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gCnASpJL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ym0+xefP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gCnASpJL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ym0+xefP"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3BAF61380F8B;
	Thu,  2 May 2024 04:17:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 02 May 2024 04:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637875; x=1714724275; bh=iU/a/E/Jl2
	+caygpcVRY45r8NSADAyTVEnpC6lOGncc=; b=gCnASpJL9LR9Pf+CIkgwCLhFg0
	toxKKb85ujvAxX41sWp/vFYqNpnGp+Iw+lBg9eumyQ7GeVXBKfv0vJkrG6JbDyBo
	e8Dk9DIYR8v2LQJsQ2K9u3ZYO7Kc6W+Q/Uy08Wj8iTHp7Jv+3mvxV3criMkJnUYg
	8lIM7jsG/ZuBnMw9Z33wrqG4h3WWGbytQn77yQa0ZQCjsHCuLyII6hLf3rzSDNIv
	2p0oA9s4dOGQWdkIWyduWtIIiAoKS68Uo/QgbXVE+ixgwa5I1Ib+IJ+gD/+r6pSn
	4Dx4mb8mhaBhaLpwnq85uat5U3uHuLrpx8MUwWJo/1FFnPnyUKKYpa3yGzug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637875; x=1714724275; bh=iU/a/E/Jl2+caygpcVRY45r8NSAD
	AyTVEnpC6lOGncc=; b=Ym0+xefPAJP3m9TudBmFbIeqe1guN6Dt5pwA+2ltfgzQ
	p1XjSBO0O9Q9VPjNpC1RdsSVkQFDjKp7maGZ/bm2B+//uTsCp6BQRfpAkRBlHorU
	7A9/Ob7BhatdBPj7ZVJz/7QA7oP2IULKaqFSE8/iL3A6n3xa6Tt2qg+S9Kpq/i0V
	as5+6L7vgFSHNaEFW+3yqO2ydqcr7kiOkxpg3Jg+nr6SoPJ2Q840z9GOZtIyucfG
	go+yNCHfiLQ1e5gDvgFBz3yhNVipOyCkRfTT2tXNWu0XmAxn76Z+a8/vJr5ywPQU
	Yb8hWB/AZRwV1Z3jCu+1QOoI32yEwRnrTowrHZPegw==
X-ME-Sender: <xms:M0wzZvmTwOu9Ehp2pA3OJ2tOydYAawDQ2RhfEGONdOacx7bT4wQvHA>
    <xme:M0wzZi3TcgWYxL_x_YG8R6uTeEyCDhrYurD8PQS2U0s0j9L8uIEZ_H2C_mHur0hI_
    PGqhxKQgbjzegipcA>
X-ME-Received: <xmr:M0wzZlqweiZQxxU1r-3hNps_Jw0JS6nDnygvvgYV09C5u3U7DIed5ZLic533v7Jn4QZp1DW41LchNEEj_OA1kZnzVtRGytZ5B8rCHq0s6cgX7wc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:M0wzZnleiYCNUvw4J9GOUO3y9ceJeuE7KeqaBCCsYLkwf_H8O6pp3w>
    <xmx:M0wzZt2zLWcpoQTbV4v1M6fchTZVyGSC08kis5-BNpXa1UthQxuCRA>
    <xmx:M0wzZmu_sPS__uoa5g3obDr3fHhn3n_rgRXkGm9HKvyRzJWpuxdSoA>
    <xmx:M0wzZhU0fa4mUZIg7DLr226NmvtoCPL5O4qfDoaz-Ws6q53BmOlwcA>
    <xmx:M0wzZqmCm8optYz6RPX3IKkxaVZqAhcX6dt-CUQvV38z1WxXXuIc3SjC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:17:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ddfae1a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:17:28 +0000 (UTC)
Date: Thu, 2 May 2024 10:17:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 09/10] ref-filter: properly distinuish pseudo and root refs
Message-ID: <cd6d745a0107245072317d7f67ca6e0b2aebc972.1714637671.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dwtwUIQbTmg3EhDi"
Content-Disposition: inline
In-Reply-To: <cover.1714637671.git.ps@pks.im>


--dwtwUIQbTmg3EhDi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ref-filter interfaces currently define root refs as either a
detached HEAD or a pseudo ref. Pseudo refs aren't root refs though, so
let's properly distinguish those ref types.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/for-each-ref.c |  2 +-
 ref-filter.c           | 16 +++++++++-------
 ref-filter.h           |  4 ++--
 refs.c                 | 18 +-----------------
 refs.h                 | 18 ++++++++++++++++++
 5 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 919282e12a..5517a4a1c0 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -98,7 +98,7 @@ int cmd_for_each_ref(int argc, const char **argv, const c=
har *prefix)
 	}
=20
 	if (include_root_refs)
-		flags |=3D FILTER_REFS_ROOT_REFS;
+		flags |=3D FILTER_REFS_ROOT_REFS | FILTER_REFS_DETACHED_HEAD;
=20
 	filter.match_as_path =3D 1;
 	filter_and_format_refs(&filter, flags, sorting, &format);
diff --git a/ref-filter.c b/ref-filter.c
index 361beb6619..d72113edfe 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2628,7 +2628,7 @@ static int for_each_fullref_in_pattern(struct ref_fil=
ter *filter,
 				       each_ref_fn cb,
 				       void *cb_data)
 {
-	if (filter->kind =3D=3D FILTER_REFS_KIND_MASK) {
+	if (filter->kind & FILTER_REFS_ROOT_REFS) {
 		/* In this case, we want to print all refs including root refs. */
 		return refs_for_each_include_root_refs(get_main_ref_store(the_repository=
),
 						       cb, cb_data);
@@ -2756,8 +2756,10 @@ static int ref_kind_from_refname(const char *refname)
 			return ref_kind[i].kind;
 	}
=20
-	if (is_root_ref(get_main_ref_store(the_repository), refname))
+	if (is_pseudo_ref(refname))
 		return FILTER_REFS_PSEUDOREFS;
+	if (is_root_ref(get_main_ref_store(the_repository), refname))
+		return FILTER_REFS_ROOT_REFS;
=20
 	return FILTER_REFS_OTHERS;
 }
@@ -2794,11 +2796,11 @@ static struct ref_array_item *apply_ref_filter(cons=
t char *refname, const struct
 	/*
 	 * Generally HEAD refs are printed with special description denoting a re=
base,
 	 * detached state and so forth. This is useful when only printing the HEA=
D ref
-	 * But when it is being printed along with other pseudorefs, it makes sen=
se to
-	 * keep the formatting consistent. So we mask the type to act like a pseu=
doref.
+	 * But when it is being printed along with other root refs, it makes sens=
e to
+	 * keep the formatting consistent. So we mask the type to act like a root=
 ref.
 	 */
-	if (filter->kind =3D=3D FILTER_REFS_KIND_MASK && kind =3D=3D FILTER_REFS_=
DETACHED_HEAD)
-		kind =3D FILTER_REFS_PSEUDOREFS;
+	if (filter->kind & FILTER_REFS_ROOT_REFS && kind =3D=3D FILTER_REFS_DETAC=
HED_HEAD)
+		kind =3D FILTER_REFS_ROOT_REFS;
 	else if (!(kind & filter->kind))
 		return NULL;
=20
@@ -3072,7 +3074,7 @@ static int do_filter_refs(struct ref_filter *filter, =
unsigned int type, each_ref
 		 * When printing all ref types, HEAD is already included,
 		 * so we don't want to print HEAD again.
 		 */
-		if (!ret && (filter->kind !=3D FILTER_REFS_KIND_MASK) &&
+		if (!ret && !(filter->kind & FILTER_REFS_ROOT_REFS) &&
 		    (filter->kind & FILTER_REFS_DETACHED_HEAD))
 			head_ref(fn, cb_data);
 	}
diff --git a/ref-filter.h b/ref-filter.h
index 0ca28d2bba..27ae1aa0d1 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -23,9 +23,9 @@
 				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
 #define FILTER_REFS_DETACHED_HEAD  0x0020
 #define FILTER_REFS_PSEUDOREFS     0x0040
-#define FILTER_REFS_ROOT_REFS      (FILTER_REFS_DETACHED_HEAD | FILTER_REF=
S_PSEUDOREFS)
+#define FILTER_REFS_ROOT_REFS      0x0080
 #define FILTER_REFS_KIND_MASK      (FILTER_REFS_REGULAR | FILTER_REFS_DETA=
CHED_HEAD | \
-				    FILTER_REFS_PSEUDOREFS)
+				    FILTER_REFS_PSEUDOREFS | FILTER_REFS_ROOT_REFS)
=20
 struct atom_value;
 struct ref_sorting;
diff --git a/refs.c b/refs.c
index dec9dbdc2d..50d679b7e7 100644
--- a/refs.c
+++ b/refs.c
@@ -844,24 +844,8 @@ int is_per_worktree_ref(const char *refname)
 	       starts_with(refname, "refs/rewritten/");
 }
=20
-static int is_pseudo_ref(const char *refname)
+int is_pseudo_ref(const char *refname)
 {
-	/*
-	 * Pseudorefs are refs that have different semantics compared to
-	 * "normal" refs. These refs can thus not be stored in the ref backend,
-	 * but must always be accessed via the filesystem. The following refs
-	 * are pseudorefs:
-	 *
-	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
-	 *   carries additional metadata like where it came from.
-	 *
-	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
-	 *   heads.
-	 *
-	 * Reading, writing or deleting references must consistently go either
-	 * through the filesystem (pseudorefs) or through the reference
-	 * backend (normal ones).
-	 */
 	static const char * const pseudo_refs[] =3D {
 		"FETCH_HEAD",
 		"MERGE_HEAD",
diff --git a/refs.h b/refs.h
index 4ac454b0c3..8255989e7e 100644
--- a/refs.h
+++ b/refs.h
@@ -1084,4 +1084,22 @@ int is_root_ref(struct ref_store *refs, const char *=
refname);
  */
 int is_headref(struct ref_store *refs, const char *refname);
=20
+/*
+ * Pseudorefs are refs that have different semantics compared to
+ * "normal" refs. These refs can thus not be stored in the ref backend,
+ * but must always be accessed via the filesystem. The following refs
+ * are pseudorefs:
+ *
+ * - FETCH_HEAD may contain multiple object IDs, and each one of them
+ *   carries additional metadata like where it came from.
+ *
+ * - MERGE_HEAD may contain multiple object IDs when merging multiple
+ *   heads.
+ *
+ * Reading, writing or deleting references must consistently go either
+ * through the filesystem (pseudorefs) or through the reference
+ * backend (normal ones).
+ */
+int is_pseudo_ref(const char *refname);
+
 #endif /* REFS_H */
--=20
2.45.0


--dwtwUIQbTmg3EhDi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzTC4ACgkQVbJhu7ck
PpSL1w//TbV9wDNykff6SMbnPfhujGiqrwOB5xNW96x2GFBUilA6cqQsoMiwEB4x
qnJhEHcDC6z5jnmV+pn2T6nHNpIWiRyjPWlsvGyV6Fkt6NqbR2JdjJoV6BZX2yJc
Bg/sgNSPZJ+L9d5Rsh9FuEoGOndxfMZScR68MyltztmzYyRYUiGSSNBGkRalZR7x
N2TXZhCY67vxytweVCGj3KXUWYUIaoDLzGfPA/VEsmJyeEPcqUT8mtyRB8kwE28B
j+zw1KaV3FcvzcEhpCIMqoK5j29Ud0jfXALLI957zVuUFUGAGGqpybHtJZDMl0N2
zIOg7RavyP8h26XoSFB/EyPzqP2G77D8Yu3avOJUrWSXrXXiKtuQ5wnksr+RuIaZ
ULtqleKPxMQ13iwJdK2Q8E84AYH3lnuFQwboDsXGqLQHCV9d6CizOU3lGA4KPWMo
SB926W+GkGPiHgYd1ld8xw6fqSfNFVcIm5Th+sr0B0bmDg1+2aSoG/lVioUW8b+I
o/VvjMp0pVoLI5Iv5SC4HbtvDHYh7ZY+bhFbVOrhNfWuPX4KU8Mll94XejVptxoO
L+CzWGokaaMjRMkL3UzJzCeZZnuOOHzk/Z8yejrAW0rAagOhXFHB+26rZbffE1uO
X9Tgz9tRh/ZOJYPWzj1o/EX77UE95yQMwCHIyQk25wFJSXAfOJE=
=65CB
-----END PGP SIGNATURE-----

--dwtwUIQbTmg3EhDi--
