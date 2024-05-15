Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A94C62E
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755873; cv=none; b=cfhZ3c6RE52Ws4l9pSo0+27AuCd0doqxWhX0MdetSh/VJy35pcyGxMBVrRRd4mllB7wH/c9jjf9qkrAsERgWBnPw/EoSwozVDxYDggVzlBWu2hA5ZlUcLqQCGF/V3OvqeS90dalxz7bbM/8P2b6d40opwGQFi6d95h5lQp5P8UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755873; c=relaxed/simple;
	bh=ju+bKAx5I6JVpQlwJmrPeKmCk3hEfSVaFk4IMdxbOZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM40ao1OkY6628+l8nucTGFQkMyN89bGOjmuJFpWgmQFuwul6gP6YI7sV4lT20JY9pDcErlIpohP9Ngs8DxyYar6wPEaQ76QzgInoa1qAzmSaEJOcacdQSRtKMPB/56eaBH4gGiyG3yUHM6PEMhlLV1+C7CD9neqMJRiK1UHeXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QVwHYjyw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b2woRis0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QVwHYjyw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b2woRis0"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3F075114017E;
	Wed, 15 May 2024 02:51:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 15 May 2024 02:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755870; x=1715842270; bh=WK7BgqG7Ug
	KwFr+VCwAM/jcRFEexSnofeAC1otEEAsE=; b=QVwHYjywCs4r2QlXhk8EaErnMH
	nsqWGnyNrmM7xyNnUkI0pZm2DWc1nWqpO8aiBADiyJX1oJQfFf0E38u+YX1J19Kw
	2+ott7sLK0xpbGXJaRLtwfzfRWjjFodcg03qys4smgkZ4kkLWfYS/1B5xywz95D9
	lNvKXUkeFLBIhGp+rMxrpr0Mm1x7u8FvCzzCliyCigBDV0FYE+eo1BYoyJvXRrAJ
	QTYwvwbsR3tAtxk/9v4tZnjbnxpNuA5AiFw1ukCxaaICFswjbPE8/P+Vs72ZzAa1
	TMTOrV1XX/Z6YF2PQQYdQ/71TF3nizNi3vkpmHt/ovJOET+yTK2BNLuZ/mbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755870; x=1715842270; bh=WK7BgqG7UgKwFr+VCwAM/jcRFEex
	SnofeAC1otEEAsE=; b=b2woRis0vZJoT54FfL6ByDYQSEtDJ+7H51loAR631dfX
	XhOJ/j9+ZwVjLZMaEb36/Zn8bXJFU6fOv96gnz3t5/dNR6CJueZ3ddk5g8yxsgH9
	YJDqvF96oHowHfUq7eIReJSW1ISqHBK0viP9NjMl+xAeL0scP322ERplGMulJHfF
	oxbRJB8qh8ir/aQHAM836HE4/kebkFnwhPCJhZM/vrPP4h40PUUEGfXfoW7o3GVB
	vgBt5uppUeJrt9IcmXEuXZwsA/03cV2VQYhR7LMQfeCtVvxLM1EcNzqvZnDEzyus
	EgIfjHJ0Nubv9d30fvLxy4LOcXoph62nrEaZI0uMgQ==
X-ME-Sender: <xms:XltEZt2eS6KbGo5WzQBTNKms13LbDNrQUwaF7FdnGdK7IzvxRs7cGA>
    <xme:XltEZkFOn2yX6Igdcy36n9NdXSXM2WnHW1V-jwN_zXiSsOb_F0-ATdAl8CQrpUaOi
    8Bpynkypvs-Zomq2g>
X-ME-Received: <xmr:XltEZt4Pb9mZI6I1f6FEMovaGneANLR47ZkoOvDLET3qqvSHB8c3NAbBFT3VZSm1-pqVt1RSMD9Mm4PSTTMLLdUsfCHLgdsqfPvqkuZELvqSMCR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:XltEZq2hFsbEUifxo62aikI7eUA_1NiFPISIVIcYtsbk-l00Zin3zw>
    <xmx:XltEZgEJpPqiq4anSWSFGVjCoVpQ-Vy5bow6jQC62fFbBavPsxBkCg>
    <xmx:XltEZr9XwcMUtCC8x-va1y0eB3r2iHz2-DE8su91eCbwuKzqnw0Feg>
    <xmx:XltEZtmH2QY4YNNRJrPOq2xRkY7AflwTtdZeifshNrVUX4Sne_7zDg>
    <xmx:XltEZuarmbvR_A_5wPKyheG6Dp2k8-g48iSsMWWfKdCEBeWlPrMO6lsd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:51:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f2d1cb45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:50:45 +0000 (UTC)
Date: Wed, 15 May 2024 08:51:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v5 09/10] ref-filter: properly distinuish pseudo and root refs
Message-ID: <c7e90e31706b214cd9b61492487fafe3345a77ee.1715755591.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fssJahhI0QLOvfTI"
Content-Disposition: inline
In-Reply-To: <cover.1715755591.git.ps@pks.im>


--fssJahhI0QLOvfTI
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
index 23e81e3e04..41f639bc2f 100644
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
-	if (is_root_ref(refname))
+	if (is_pseudo_ref(refname))
 		return FILTER_REFS_PSEUDOREFS;
+	if (is_root_ref(refname))
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
index 2074281a0e..c13b8ff6d8 100644
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
index 8489b45265..dc4358727f 100644
--- a/refs.h
+++ b/refs.h
@@ -1080,4 +1080,22 @@ void update_ref_namespace(enum ref_namespace namespa=
ce, char *ref);
  */
 int is_root_ref(const char *refname);
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
2.45.GIT


--fssJahhI0QLOvfTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEW1gACgkQVbJhu7ck
PpSBIBAAqsAhC5OEL46SKyCXrtql3it9oQtHiLk0AKw8L4KjBG0OlqCxDuLgEKHM
Eb7mUHf/K5WYwLsHHmQZaVcHiAqL00L6bmYX5mKl2QNEqeUduwivU8TxTiHydw1W
y/rOpA3ycUZjkAJfGFCCS3a0mvqYY568Ww/McRsyLNfWUdBvUWblOczXdWGN18qh
GFn4dorkI70jWJJGHvfqcOZHBeFjowqr6lMnLJvzMWIoRzcuc/nxII6+IUb73fwS
07pDaWMe+PvWwKHWLoSncr7de6XfnB5K6dBsLllo5a68AFbOPc0Ii3NXwEemUYs2
hTY+EnZReypcvykNeTkcwpG3GKb4EMmBDA82aaZPPKr23OcOOOYmQLLGmHFpJw5M
Dw0OGP8zutRYH6v8ehcdvK3NvhyawjJSJT5++/j3+jLkYUFkggc/VwfhO432fDYU
3oFzMwlYgekIIzkcdJ0SBDtUImJpOakODlGcjwHbrMFVwIt/AleHzUl7XNl6dmrI
Wn7yi4qtD6322M/qnvWEqaxhtNJo/BUg5vEU4skBD07Kok5V4qMeo2v1GFfR7DW3
1ZsJukHS6/3B7QxwT8+DIgjnFqg1j0V9UhBlPwf0w95OTjUfXMx22oI4enrLT1wZ
ONxNc6hn5izAhu4uScr77m6qazaB9bAB/0Hgsuu2EnGFx5PZXw8=
=k9gI
-----END PGP SIGNATURE-----

--fssJahhI0QLOvfTI--
