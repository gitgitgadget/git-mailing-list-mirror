Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761016191E
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330932; cv=none; b=avIULPwKYTb13fVGLk7FIRKvxZYjG18Ypor4aNpPv98hiwvK9nsM680XfhYq5rFZTxqYMXqeFVmH3Itqxth2R87gK/oro5d+NfUwg3VHV06Eo+9hK8JK8NVHWgWthxYBcAfn/Q0gGxiIGVNnmt6imZRj6VhZRxFsOgneA8/qbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330932; c=relaxed/simple;
	bh=NefqH34taI8e9F+w2IdYS9zTSknexbcWY5VDLrhnLT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1fPUzPzRTyD+sp3MN0na2XIvbchDcxvPMz7S9M837GK6O4ZRQyUZQ1DR1Zv/fZiJdku6CdTVaKh1nAOWie06u2SedhdET7i5OGR9RkpdZ5jtEvQPlwg0UoFAj2wkmg/OcKGMlVNUsLHJP3bBgSsLd+SbM2NHOF32Ln10NLJx98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q2dlcDzz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ld+pVVRh; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q2dlcDzz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ld+pVVRh"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 077141C000FC;
	Fri, 10 May 2024 04:48:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 04:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715330929; x=1715417329; bh=GUZwx+Mess
	3P6tijL5FWYfAuO75K0nztYeYZzaHVcAc=; b=q2dlcDzzNzjULyHJ94QVW03Rhd
	UzZJBr7gpyosSbqziPROqsJbM23S6CMsjPuwswY7RKPxUgKSwzFxXDmNRwgs0poS
	XuwWhg5+dD/QOMu2gZymBdykiufBb9XAQBS33ikfm9tUbrlgkMhtymu5Gy3EoAF/
	pquosgr4FBvDeL3wGPWkJB3spYuHz5195nvz+Fh1XKpaC0Seq8d+Slu4fykM6+uV
	4gsivxL503NgmExJzLPIYqa0r9vGzVCgqed9u9O8e9OpuERDIsPrEcQCF9mtEucj
	/w9bsCpWMx+O6U168s2No7wum8cjGK8BwV2Abh/0or2fB0vmFu0Jb5N7yCRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715330929; x=1715417329; bh=GUZwx+Mess3P6tijL5FWYfAuO75K
	0nztYeYZzaHVcAc=; b=Ld+pVVRhYeazkabnNYXQUJJJtFTBFqCXWr1sl/yIRWB/
	Iz+N7g8i06DqwpIJaqnwPzm/dr6QG7Seuez2WPo7FKSL5RV2r+xA8DHnq6IubE9u
	+sKiwwiTRTPO4bAlJ1vF0xgTW4Bj5k0qdb+W/pqvpfcwC3L9MhHVslEuxPFetrNN
	1Jrqby2KwnlhPdRwFNy+He8kYsjpa0Snb5R9WBfkM/W2reuErNTHh4jSIMHADbzU
	Ysh/SH52/9q4mSmsOWyvhKXKhKlN5cG7DSkkmNTOZ4jM3i+idXndaZm1rCsZwzSj
	IlYbSWxi057yfMudwuC2aLedGfKGTQJgp8D7MvMY5w==
X-ME-Sender: <xms:cd89Zi3xsq1T0hNhlv5e-4XposfOePD6oliytzonkxu0B0NOtdB39Q>
    <xme:cd89ZlE6UV2-PBnvNU38FXUIX5Ra87CkTZg1j-flUiLLvXrp7CwaiF9HntpR8UXR3
    -I6Kh7oxqfj-ogITw>
X-ME-Received: <xmr:cd89Zq7yBq4LQ7ZYIHB6ECQ8rFp_XOrhmwTPyzxerP8-ty8xBAG5C9Xfark_nn6iTp_lZN7TSXnSTKudrAbD_U1GF4e2X4ljIYLJsK2su4h3ZIffwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:cd89Zj0USTjA-cUy-ODo1ByCH9JVW4ZtWfpS-EmDolvQbsmbNplbFw>
    <xmx:cd89ZlEwzGkHL-QwQGRBU9LTA8mhHxsPsPsABb-v6ndIKahbfT6FHA>
    <xmx:cd89Zs_068hYCiLokw-fBgyY03GBAwnjhDBTJxDxnmmPQ363Y7Qphg>
    <xmx:cd89ZqnH2i2aYIPqRu2Kap4tntmFKRSmY1tIp7MDXRHaX9IZ4Hu6qw>
    <xmx:cd89ZrbiL6yLFeAn0rwxIeFASIC2eXAKDYJu6sHJXVeTA7iiQd9kAOLv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 04:48:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b7eac8c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 08:48:35 +0000 (UTC)
Date: Fri, 10 May 2024 10:48:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v4 09/10] ref-filter: properly distinuish pseudo and root refs
Message-ID: <86f7f2d2d83774544e3f2fb1c2ec37cbd41e26be.1715330206.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715330206.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7qt5vathEDQcB7cT"
Content-Disposition: inline
In-Reply-To: <cover.1715330206.git.ps@pks.im>


--7qt5vathEDQcB7cT
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
index f5e98e5b46..c882ece6e7 100644
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
index f6f4d61e1b..815dc514c7 100644
--- a/refs.h
+++ b/refs.h
@@ -1080,4 +1080,22 @@ void update_ref_namespace(enum ref_namespace namespa=
ce, char *ref);
  */
 int is_root_ref(struct ref_store *refs, const char *refname);
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


--7qt5vathEDQcB7cT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY932wACgkQVbJhu7ck
PpRV/BAArpPfKmNxsZbVGrSwd9AK/VZMGDIhbu2jAkqSW2xOhRGiboyjLKtblAm8
h2LxVErU3Wlr5rot1jWvf/QfZa4zPsTY0MB8A4x+WAto6yasRMC7TecHhs6ngC/r
+P7IvYMjNJmvOdNkImkWzzovFoDBSJD0CCXznscl4JOYTYX3h0LIbAFJmIEBGB23
ylnd5Xz0e1JxicwRR3rv9tpX9+nw0gddX3ClQR/eDJQjrkQAM7JfCy+++SXEirIU
92InaBM4vczhPGdA14gYG5yYFyDYK6To2vZP+mfqxLGQxiArXioVravqJuT0I6it
fdygNcvVK8i5w2n9jopH4HjWXqfbgoUiW5N8AJ+dsxQJCoFH+L1QEZLtNmIZlJy7
rOGnbJA/zcnD0auYbsA253ns30ji+PhTorfQU+gLJjW+lDVAkPwvHtYy9q3xNFKv
aTctxxmIX4oNrzL0rIGU8g1GPC7CXrYRFjURO4SkGePn/jkAZ67jwZL62mODX55j
e9UoMukUIZtlL318RNGAm0CU79wyGOTfMIXJxThCvH1Qd95GqxIxglTVZyGcOJ58
sy+HkK2W9ECCvW6pRrA8uktz9yBm+TrBoLCMFwUQYsaGjE3ZH+5szYoIVv7bnWW+
QXyqbF/QoGGzaDm+4PHMmCbX24WtWN4Cvkv8DVSFBN78ShhGFso=
=b2S0
-----END PGP SIGNATURE-----

--7qt5vathEDQcB7cT--
