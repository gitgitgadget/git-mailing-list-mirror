Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BA36F510
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398091; cv=none; b=XwFh8ohp1CzUIPwWtqD15+X/00sqkZlTxFBM72FzI6mb/TxBjcnHXST5hid2eKN+Ag9zVCR7cngIolTCK9CIHN16aO+FFhCBMddufLZKvaTv6J+4eXmobLJXxBYGw9ROZ6eqF1EnSA5ae+w8eU0DQR/5lpCqO+HuHE9/y4syR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398091; c=relaxed/simple;
	bh=3Ue7uzpbD2fi4x6v6hFbQ7KFVdxF2INBF6aJBay53O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLi+OR4cqE0MbCzoyDFYiCn2UVR+UIKMmOyDMfKVO1Ibn09ttkTaFfoLYSLMWdlhppcCMrWyRFx3IrPfZJ/ren/6H2GTZUyHGt4uZyvbAs71bcLKVnpbAAn3JYLLnOgCBqRNzAqFnfjtLFIBKqmgsrkeAYG6DBLUwVjInOycFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pjg5FoBV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hotQq0Qx; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pjg5FoBV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hotQq0Qx"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 17C851C00171;
	Mon, 29 Apr 2024 09:41:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 09:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714398087; x=1714484487; bh=l2EkZY1Ba7
	3wexEf7sVNvbaEM1OJN20D8IfWn5NTRZg=; b=Pjg5FoBV4IQhwkqTjCThiARzBW
	MFZdMUdzVc9MeRfYcz/ACcYW3VHQ/qVjtF+PTDiKGkgYWORNCSLxvSTqVknzLgOe
	8XLFKHw78ZMOxrgbuWHKvRVguM6h24IXDGG5rtkHMipinjgtQCQHtva4N78ZuNfx
	FuR0kMoY9U+1w7Awihf21CsjSKtA+DR9nk+4TROFLqE7uyBsaB/RRL+Jw5fPTE/y
	XKwQpWTRvMdMASlXOpZlxofZYfdbWylD0QA0lG17jQtbqksmNIboqyk3Syhwf6+F
	/A+6bvcTZL+6AgdYPeUcqY/dYMUqNFkJ7dgIhP2DlEUaWVEAW3xGWd+LtFqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714398087; x=1714484487; bh=l2EkZY1Ba73wexEf7sVNvbaEM1OJ
	N20D8IfWn5NTRZg=; b=hotQq0QxowoWzBDWBQ4u8E5Uxl5fnoQkbaFGl3jNjO+m
	4/YviLkuSv/I+Rq9X/vJYtcg0GO7fz11030FOcT34WbogmD87ejdOK3B0yjMmZSv
	OTP++buOBdKLdfZYJsFkveEa/ZjjVxIyUuOlS+ij5g5i+3i/yacmK4nP+ZLeLJPh
	QAJbW7KbJYU8SUI7ULq63HMWTCLNwFk+cAAGxRnEf8+7A76NqnXDdsi6Y/s4sUBJ
	Di44Pd+MzgHnuF5yjfyTlTAAPqqr1g0+LjhXBqWb4B5onl8YLUWuItluji8eVwee
	o04NWq3tQKeEdQqVNwvP8V8fCc6a+g72P5Np7pi/iQ==
X-ME-Sender: <xms:h6MvZhAzDw_DG0qiTaRJqhPPngyXDLWJccjRccRCdGFzkugqgM3zVA>
    <xme:h6MvZvg5D0zIcCoN8Qoa5URllpO0VRSEoGHPcjH5xqbw1rAHa6bRzy3aG2kVRAptx
    CZFy-MNMX5MNRkKBg>
X-ME-Received: <xmr:h6MvZsnWkIh94WzdM4BPIwA-oG12xCMjxj-dxi34MfJ8nKjXOcQVt_oIyiWi5o8BRIEcer3xbAOTwOJA_cxtq4RMQUI5sEWKxpkpGoOtvYAjYGzu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:h6MvZrx109q7HGFZiyfHiFdm27huXfww1gL8Q2GZwbeyP2GB307M5g>
    <xmx:h6MvZmTNY_Utf7gLrphGn0ZaSacgyhvu3WNyDL1MGIwjpneRUcVSkQ>
    <xmx:h6MvZubnHLdsdXCJVc84dtPn_lZN-pvTRhfgZ03bZXv9NzH9mNFwgw>
    <xmx:h6MvZnTyTJ7hmYBKdxq8MMQIfij4cc2o8NKT5wntrtGxYKBAQ1OpUg>
    <xmx:h6MvZkckqNLoednhKAT4Jy3NBzsiEbIFXuvtHfFtLVgPXCST3GxWu5G5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 09:41:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id de24b269 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 13:41:06 +0000 (UTC)
Date: Mon, 29 Apr 2024 15:41:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/3] refs: move `is_special_ref()`
Message-ID: <ded4ffabbc77e62e720e3dd50c6a1738da0f3cf7.1714398019.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cyd8MrC8idfKHVF9"
Content-Disposition: inline
In-Reply-To: <cover.1714398019.git.ps@pks.im>


--Cyd8MrC8idfKHVF9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move `is_special_ref()` further up so that we can start using it in
`is_pseudo_ref()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 62 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/refs.c b/refs.c
index 55d2e0b2cb..c64f66bff9 100644
--- a/refs.c
+++ b/refs.c
@@ -844,6 +844,37 @@ int is_per_worktree_ref(const char *refname)
 	       starts_with(refname, "refs/rewritten/");
 }
=20
+static int is_special_ref(const char *refname)
+{
+	/*
+	 * Special references are refs that have different semantics compared
+	 * to "normal" refs. These refs can thus not be stored in the ref
+	 * backend, but must always be accessed via the filesystem. The
+	 * following refs are special:
+	 *
+	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
+	 *   carries additional metadata like where it came from.
+	 *
+	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
+	 *   heads.
+	 *
+	 * Reading, writing or deleting references must consistently go either
+	 * through the filesystem (special refs) or through the reference
+	 * backend (normal ones).
+	 */
+	static const char * const special_refs[] =3D {
+		"FETCH_HEAD",
+		"MERGE_HEAD",
+	};
+	size_t i;
+
+	for (i =3D 0; i < ARRAY_SIZE(special_refs); i++)
+		if (!strcmp(refname, special_refs[i]))
+			return 1;
+
+	return 0;
+}
+
 static int is_pseudoref_syntax(const char *refname)
 {
 	const char *c;
@@ -1876,37 +1907,6 @@ static int refs_read_special_head(struct ref_store *=
ref_store,
 	return result;
 }
=20
-static int is_special_ref(const char *refname)
-{
-	/*
-	 * Special references are refs that have different semantics compared
-	 * to "normal" refs. These refs can thus not be stored in the ref
-	 * backend, but must always be accessed via the filesystem. The
-	 * following refs are special:
-	 *
-	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
-	 *   carries additional metadata like where it came from.
-	 *
-	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
-	 *   heads.
-	 *
-	 * Reading, writing or deleting references must consistently go either
-	 * through the filesystem (special refs) or through the reference
-	 * backend (normal ones).
-	 */
-	static const char * const special_refs[] =3D {
-		"FETCH_HEAD",
-		"MERGE_HEAD",
-	};
-	size_t i;
-
-	for (i =3D 0; i < ARRAY_SIZE(special_refs); i++)
-		if (!strcmp(refname, special_refs[i]))
-			return 1;
-
-	return 0;
-}
-
 int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno)
--=20
2.45.0-rc1


--Cyd8MrC8idfKHVF9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvo4MACgkQVbJhu7ck
PpTgYQ/9GevFs8Lah5k2k/fY0bALOsiZ2MSdnUY6ZGPvuPVzPYNCWlR74DID67/3
bdDVVmE6FFbzCX+QVRhkDlhr3DJAiGoL7uA+Q1CF47LJhOd7RzojYnzOX3da/X6s
aIpTv+qx7Fhz24DXaiJ1UvYZ672dP64Vifb9Pjno+PDyfshppzHnKTd7Kk46DPks
/j3se+d7TNpDSljvCuwuIACRPMdwRaMI+aUQGilV5DYaOvrs74vh/wU5iELzlHuR
uFPDAKkGvhZsxzDlyaGo67H8xRdBtqG5EdxvnsjTbyRFivod7zkr22C458lDv+5J
aVKN9nUyxlwrph1euqwmFGIryXgcv9XMknI2zRdtwSIDVQxlpTJcgyFfAtqzj7lW
bG+SyBLkR17KIYzf4jm8OjLV/FmkhFrz6c/LQmUtZ7QKv4NyUmR26nO5mRlayJ11
ndu7bLynScHtumdKbN6xnl5jcyKZSjrtCJGAHr+FfBGLoCRtrWgkCRC/M3b6G53m
tqHCwxiPdYLtENm3SniupX76b6v2Nr7x/e32ClxBhHBPKSxvLUy9BHd5Z96KP8aI
WkbqX4ElRF0qW4qlKkO4zif+dmsJtdFrP9s1yj1oaEreu5d/nMiLCo+oZ96P5Y1h
hOx7xI3cnMrqKTFhNf5s5qy13eguJEB7Rf9otsOdxTA7TOvh7aw=
=Tul/
-----END PGP SIGNATURE-----

--Cyd8MrC8idfKHVF9--
