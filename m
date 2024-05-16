Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC701311B1
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846698; cv=none; b=af/kIP9ysw587Ds89y09q7mjyn/ZlH4nSnxrQmd1DCEQ0sT8hMcpUo6sV47kmaqsfKjl0R98kTtNUAtB807pPRUD2SRSr/fPo6+YZrRlxM78FsYT4ArCdW76sydqcR45uUBiNQ+npXrgkiJxTH23SVmjdTBb56lgyNTN9k7VZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846698; c=relaxed/simple;
	bh=mMu39OqqWmVANxdAmcQ8xN6Dma87VooSlYYbxUJt+vM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaeI2FfcyJ6Xp+oBhqFkAz5urnY2UmFZYuytjkSY78b0SMXrMDkTc85TyIQlvAexyn3ZQ7QOGcByChOPisith+X2gaiFa/EiP8wiwtSOcybyjlVW1KMMjJODG+TRSI4iv79NMDdVMwiqNxL+5/6eE5E0Pj6M+0lwg5y8FfL4Tcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dH4qaMIb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j3LxLwDy; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dH4qaMIb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j3LxLwDy"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id EF5921380E54
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:04:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 16 May 2024 04:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846695; x=1715933095; bh=Ml2nQ9xdcP
	448Z5PS94oiBupAgbvPBCJH2dzR3IfHGQ=; b=dH4qaMIbbKSRbpxX6IClOhdPwl
	4giA+UhgmD1GjAf71Wt4g8f70Q1qffUJNkfk0ENjQbcDxAcKcxoLHUqxK2TOJuED
	Nchg6qANtuAZ8ahm3aeEASZiNWeZH9/FTpV3i4glcdwCRCR0KvVu4sAz2+v8EtVd
	L3TKClcHyc/DGed1zFT07s8T15/k8cBsGINFldCNHlrXRpXi5mJLAmH+6clQSgTF
	VdscipGd8+F7W24/uORxj2qTF1GHWRpHiZ998CgDiOTkUz9zENHEiqfRLQraHpJC
	ah2Dw8kjwu6vrJRyt+rEe/My3xhUuA2QalIkZwnU2WWhIYdzNIIsUHXjfUDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846695; x=1715933095; bh=Ml2nQ9xdcP448Z5PS94oiBupAgbv
	PBCJH2dzR3IfHGQ=; b=j3LxLwDyYF++G35ZJo12wiLTAsSgJvo0H233VX0+CnuK
	5JsPMxkWV9aPK5gsydSrVkKkkQ7/2wB7GcvjEUVWKjNq4p4OFP0M4oPVBCVtugTZ
	BLLCYeSIjELNNaUdqy7PceuvABR2dp3kMu37ScU5hcbqJd2RYXUhZkJjvyXqxms7
	Cz7y5UnvPLwa3Mq375xod9A+myC+yLpfb4FEpSNkh1iJKyltvo18LmPCWPvCBBas
	ui266RsKBYTVRlGd+LEe66m7Dq3ynIeBk/Zx/x9nqgLUbbPcVyDF8qQvj7H/tiLH
	ixA+bSC0s00CvxV5+IRnVLiDX8wJwjO0UoNGV5xnPA==
X-ME-Sender: <xms:J75FZg7kD_68_HNEZ1lmix8w-GumyATFnFeyPdbW19gdJR0_xBqEFg>
    <xme:J75FZh7KhhxLsANuJkmud5rULVfEH6Ryl9JiDkHZF9ijKrrTuVk_fVyR9NzxNCfT7
    _giZ6KrrECVn228tg>
X-ME-Received: <xmr:J75FZvdaA45uHBMl_OgWFfySQYJR77GSZc5ovTEIGPXyj3aWCUmGW25d42Nmul6IoifqLMWcBt0EbqpjxUxHdcDai5wyyXU3eJctZ3VkpeJLaMs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:J75FZlIRv81yunIk5lcI2z2AI2UNE5OjKDN2nJ4kbs_pNBZk9v7kBw>
    <xmx:J75FZkLQxZOnLkzh5ynb9YX_UWtoPcFb05BlTOW96-yI02BCcWP_hA>
    <xmx:J75FZmyUE16Qv4dnAN3lfKsWepma5JVC5WPD9igWl_jNy0QvSFCmKg>
    <xmx:J75FZoLL3JOGXg0qE6L1EPU3fepDfxopEK4KCxNfOijaiehg5WkA0Q>
    <xmx:J75FZug0lLthR5ACbSSlOVvHTEXtqU29eT-i2ssdpDg1-KjdepL3IMlB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:04:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 87b5a060 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:04:30 +0000 (UTC)
Date: Thu, 16 May 2024 10:04:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/16] refs: pass ref store when detecting dangling symrefs
Message-ID: <50c5d72c6af22c6f2f40ccb78ea7076d80c385d7.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EzvUTxOJedIkR5zg"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--EzvUTxOJedIkR5zg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both `warn_dangling_symref()` and `warn_dangling_symrefs()` derive the
ref store via `the_repository`. Adapt them to instead take in the ref
store as a parameter. While at it, rename the functions to have a `ref_`
prefix to align them with other functions that take a ref store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c  |  3 ++-
 builtin/remote.c |  3 ++-
 refs.c           | 40 ++++++++++++++++++++--------------------
 refs.h           |  7 ++++---
 4 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3829d66b40..3df1c0c052 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1412,7 +1412,8 @@ static int prune_refs(struct display_state *display_s=
tate,
 					   _("(none)"), ref->name,
 					   &ref->new_oid, &ref->old_oid,
 					   summary_width);
-			warn_dangling_symref(stderr, dangling_msg, ref->name);
+			refs_warn_dangling_symref(get_main_ref_store(the_repository),
+						  stderr, dangling_msg, ref->name);
 		}
 	}
=20
diff --git a/builtin/remote.c b/builtin/remote.c
index ff70d6835a..c0b513cc95 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1477,7 +1477,8 @@ static int prune_remote(const char *remote, int dry_r=
un)
 			       abbrev_ref(refname, "refs/remotes/"));
 	}
=20
-	warn_dangling_symrefs(stdout, dangling_msg, &refs_to_prune);
+	refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
+				   stdout, dangling_msg, &refs_to_prune);
=20
 	string_list_clear(&refs_to_prune, 0);
 	free_remote_ref_states(&states);
diff --git a/refs.c b/refs.c
index 345d6a1e06..e6bae9d52c 100644
--- a/refs.c
+++ b/refs.c
@@ -447,6 +447,7 @@ enum peel_status peel_object(const struct object_id *na=
me, struct object_id *oid
 }
=20
 struct warn_if_dangling_data {
+	struct ref_store *refs;
 	FILE *fp;
 	const char *refname;
 	const struct string_list *refnames;
@@ -463,8 +464,7 @@ static int warn_if_dangling_symref(const char *refname,
 	if (!(flags & REF_ISSYMREF))
 		return 0;
=20
-	resolves_to =3D refs_resolve_ref_unsafe(get_main_ref_store(the_repository=
),
-					      refname, 0, NULL, NULL);
+	resolves_to =3D refs_resolve_ref_unsafe(d->refs, refname, 0, NULL, NULL);
 	if (!resolves_to
 	    || (d->refname
 		? strcmp(resolves_to, d->refname)
@@ -477,28 +477,28 @@ static int warn_if_dangling_symref(const char *refnam=
e,
 	return 0;
 }
=20
-void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refna=
me)
+void refs_warn_dangling_symref(struct ref_store *refs, FILE *fp,
+			       const char *msg_fmt, const char *refname)
 {
-	struct warn_if_dangling_data data;
-
-	data.fp =3D fp;
-	data.refname =3D refname;
-	data.refnames =3D NULL;
-	data.msg_fmt =3D msg_fmt;
-	refs_for_each_rawref(get_main_ref_store(the_repository),
-			     warn_if_dangling_symref, &data);
+	struct warn_if_dangling_data data =3D {
+		.refs =3D refs,
+		.fp =3D fp,
+		.refname =3D refname,
+		.msg_fmt =3D msg_fmt,
+	};
+	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
 }
=20
-void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct str=
ing_list *refnames)
+void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
+				const char *msg_fmt, const struct string_list *refnames)
 {
-	struct warn_if_dangling_data data;
-
-	data.fp =3D fp;
-	data.refname =3D NULL;
-	data.refnames =3D refnames;
-	data.msg_fmt =3D msg_fmt;
-	refs_for_each_rawref(get_main_ref_store(the_repository),
-			     warn_if_dangling_symref, &data);
+	struct warn_if_dangling_data data =3D {
+		.refs =3D refs,
+		.fp =3D fp,
+		.refnames =3D refnames,
+		.msg_fmt =3D msg_fmt,
+	};
+	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
 }
=20
 int refs_for_each_tag_ref(struct ref_store *refs, each_ref_fn fn, void *cb=
_data)
diff --git a/refs.h b/refs.h
index 77f9887235..492ecfa4a1 100644
--- a/refs.h
+++ b/refs.h
@@ -388,9 +388,10 @@ static inline const char *has_glob_specials(const char=
 *pattern)
 	return strpbrk(pattern, "?*[");
 }
=20
-void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refna=
me);
-void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
-			   const struct string_list *refnames);
+void refs_warn_dangling_symref(struct ref_store *refs, FILE *fp,
+			       const char *msg_fmt, const char *refname);
+void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
+				const char *msg_fmt, const struct string_list *refnames);
=20
 /*
  * Flags for controlling behaviour of pack_refs()
--=20
2.45.1.190.g19fe900cfc.dirty


--EzvUTxOJedIkR5zg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFviQACgkQVbJhu7ck
PpTDMRAAh+Nyt5B+VGIbgsw8S2/Bbsx2yt3xnVXIEga+Fp/JMAWNVkKcZCK0HyzZ
SG3ROHVh0ZZXeOVknykT777R/PX1rUQv1wbCYHwbGgC9dGovhnz13NnKGH7fWOqB
YcU4ISdAUofFPZtTrIbC8loBy8FSEF1QcoxIWFn4hOrNQZXA841dYD8g3EmAmi/r
fTwikSHJcjT7ZslhxHELrHebw1g3Xu5KHxNf49Z28G2yO0Hv64HVewzkg9a40zkN
RXUq+qy1iGdnIhi1KyvvBxFODHFGjgPlw72F+8oEiLJOLgWZzQLjPLep30G0KVCh
lxxpDMeR324K9A1/XwkA4fclPkDJT0zkTyjXnWkXsZ9dr3Y/EOMmn/nP43ACq7ae
Un2waPVtPW3R/AztGc2Cc3FuqXGCY+474MjVmxb5NqIUgPYJfDMbXMG2ETRzj54t
6GD45bp0Ci1ix/bXocLw2KEDDAWnCDJowfrncJHL3vqRr2T0RUSqe6xWl/ZKL8xk
c/k35AKZqWODFrqowsexIpcwABFrt+WgfwxDCbk24yai96ltwzYf9WrnGXFVo1iY
w9FEl3NKXt2YBKXks/qK9yaneIrusojyiO4nrheYhW/rrIggqni33BKoA6Q6mlO0
QgTrJVEPmxvR/5+y5K7dxjhU0wN0MW+gsEHBgl81YcEnekIlEko=
=SK+v
-----END PGP SIGNATURE-----

--EzvUTxOJedIkR5zg--
