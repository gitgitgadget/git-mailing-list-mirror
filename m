Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7091411C5
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480027; cv=none; b=GvJNDsxBUWfUw191c6O6lG7wM9ogtrD4OYs3qovedG2uJYwCV2U26/CIYKf+Vs4YpgOur/OKxCTEuITIHN372WEW/tK/0EPUp6ou9TOJR6TUPt68Y6vV1tgwRwpceIYPDAR6ji8cUBMey6P8BCZ6pRbOExYsPpl6gekbLJDM0wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480027; c=relaxed/simple;
	bh=DT8qCTPfZvRNZTE9aHi76WYqiSlqXLyklCW4edCiuFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DULEBGS7gWSsRc67YDd/k4rqdV1TffYzuWjTMC2OPuX7L4Te0o5EcmKrtwTyacZGTeKhEQYZL0K6QmvbEhg9Y61eqjfeg00AiqM+AmpegfGApNSnaCBD0QVXKItk8e+XfLshXn6Z3JtpCn63s1a+QK0NDtlxxmKD2YU2xRKMnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c9pNOnQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOwaV0tk; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c9pNOnQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOwaV0tk"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 41D2D180015A;
	Tue, 30 Apr 2024 08:27:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Apr 2024 08:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714480024; x=1714566424; bh=Y8+M9trjBH
	Kx3SdheJxWgOJJ/Nu72h08hGi3lA9EHj4=; b=c9pNOnQ1Cwj+pKHd8buG15U4TH
	WlgFENpegp1kTTLo6H+Ne38YGRQgO10Z7nc8FKvGQuYoLuXo8QyoC1K9r2gIwZAD
	G7jLqH8CGbLngLBmi91Tiw0sTgg2SUskDUmvElZe+zI3mCRkN1cckk17T1vECGKx
	h7N0RZMNo00AHp7YwBsOszXqCx6vZORcjD8Pv0456XR7STIqMD3lh6jAFdgGuxOV
	W6EghAZ3v436JBqbDBVjCgItOMPlkjnXpadGVD1a0/hZGqY4um3Xnx/ti9fEimif
	Y8q6LH9Q1tU1EDv9CQPh/eQnpz3M549j+poVFMdBc5b95v5ndxCCIlCstIwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714480024; x=1714566424; bh=Y8+M9trjBHKx3SdheJxWgOJJ/Nu7
	2h08hGi3lA9EHj4=; b=TOwaV0tk1gwBv+MA/0hSE1XHj6sAsm15cnXME7tCkgcE
	dPqMVJx6w/+/41PlZTA/pa6ZzqnvxO0wEveEWGxXukgVj1lsXXLPI1O16IDZUWtM
	BCV6irln0cy//yF+gfU96BgJAwskdcg5VrIlYosmiAa+3QSBuT+FfLKxqg6M6jA6
	2TYLnDRdCEXAgHg5sSefz9VHFMJrIJzuRK1ewplWyPiIIW2sMRvdFbDe2iLGkxvF
	CLeWYAlxpFqbC3tLPsVg/UrAwfWrDPMlle2SBA4rDwo8lhv2yQnrgBQTmw1oyhqx
	ekaOcki0iO8vtlIZwJzi0a2ccVHLS4jC2jn/XdXUQA==
X-ME-Sender: <xms:mOMwZoMtxTDLc7yyJxBkmRdv-CeSV5x071vXnu7B9sl60PcuDpuZbw>
    <xme:mOMwZu8uksEGnVxfE0QYP1e4mnOpifYDOw0rHUVSRcDYjssaZ-baWvXRE12BJ1wBa
    cNFJ_mc2J4YNJbI4w>
X-ME-Received: <xmr:mOMwZvQNHT_RxzYKMp4w7qYbcJbOTJEKsmosz9hPbyBOOCO0Lb5cZhWpLJ3ZSPjOz-5zxGNStneTAPScFDo3cJNFlbWJJ1NvOy9WNxb6PYjPyty7VLNW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:mOMwZguVu7OMxmezY-hdvuKItCHSfaJUI7FzhecuCnEWVg8QnogKVA>
    <xmx:mOMwZgccLjsbdLoEGFFPZVwXEBbuPr-XXybYL2mPvjJmHzIil58-rA>
    <xmx:mOMwZk3VKgl2XnDbsmMNq2JTgSfDFLzz67umHbWLZFWMm233xRzjpA>
    <xmx:mOMwZk-ReT5GuAjukGpNzCtIkIVZEBmJ6CfEcA5xU-YUWd2y5tHaVw>
    <xmx:mOMwZoT5NFcVbPprVQJVT8i3wW0bPO9-L1hTFtmS5GY6ZHfySBJJoXix>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:27:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4b6e9ba6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:26:41 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:27:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 09/10] ref-filter: properly distinuish pseudo and root refs
Message-ID: <95d7547b2e8c5305e76888f7dc0a41d2b9e2f558.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pr3pxwSG0ShScjqP"
Content-Disposition: inline
In-Reply-To: <cover.1714479928.git.ps@pks.im>


--Pr3pxwSG0ShScjqP
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


--Pr3pxwSG0ShScjqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw45QACgkQVbJhu7ck
PpRyTw//aU62qXMvcvxxWJJZmGpk1UEWupu9/9lEmefA6QRX1eDADFzfnhE2jmtU
bTFohhNfbLKNIpH4GkBVgbHC82V1ToSbOHIaaH0m6PGmzKsIRbtAnzuqrqMws67h
cu4Zvs72xnhGxFpQZxwbrd/7A115knod9j/WTV/NvPTD6UDbywlvGX4I3WNDoNhJ
7gfXZX7jXYgwDqWMapUMaddjsgluekT8adCoqAe6tIVbpE52rAVtEgeL2WDZkBPd
5m/nFilB8hS4pK5gdOckkJi1JlukXE0/UUrG0ng0a5G9lJMGpn6UUYsSkHxdQf1B
p7La5yjgaX3dfrVHPs7NQ5YOJUg+XBhmYbriPSIm5bVladLNuXYXks5f+vLEKejC
VpBzhPjDpICJyCxw32Gf3xT/Dz6L3f9WIcDSbRszQ1EruQYHXQV0bQmYKDT9iGIP
Qi7aRzu6MrV138UdkT2EnstwG4/VzRHxLlNK5AY5GGCCpqpXMf3Fc1BFJ8k7MXQ6
qeRRyaP23z97GdEHCq8YuNugBeTLtLUwYXL9kvEvlfoNJvaY5ZfPcDQJZfa6mKc2
4hmVFN27Vu+5xl5VeBieyv4pis5K/9nPnJI8NAxbgUHaAPeF8fFQjlmodhc9pifK
U2XCnaaDYG7UCB01zVcK2I+Gx2LwPFO1eASB9wx1nhZUfxYdevk=
=3em1
-----END PGP SIGNATURE-----

--Pr3pxwSG0ShScjqP--
