Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C180140384
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480013; cv=none; b=AL/ofjxDmMuy7zakyjLQMiVhIvfrMD3e0kBCEuH7Mewa+qPN8U7xZFTBX5sPW21SovdSWEjqmM9L4Pl5iDlzV5th7ZnlJzcivd7vqwVcChiVWpnc1Sr62Y+6svNPZea/3EOK4mrSYprPQukV1vZt1emtYNnNTGLCKThqH/CnbwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480013; c=relaxed/simple;
	bh=DRCpjFx+ZmjyfIL4M+xhmyTgsk7mRa5LIKQ/xtkFBBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6OqZ/MrhQo+bvzfZA3jxX7dJ76bJpiFqiBIfDKV/dqKSgpbVf5g4KWkWTJun2TafYS8FFfNP+oWYCvVHk062lNs91S8V8TJLqFu24gSrhpi72Nyrlj6+bycUZk9fW6KdDtwJlcCNfAwpEjIgufEC4gXZV5gpQEWeX++2e9l+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YdAWfup6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zs9Sf+2Z; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YdAWfup6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zs9Sf+2Z"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4B75C1800155;
	Tue, 30 Apr 2024 08:26:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 Apr 2024 08:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714480010; x=1714566410; bh=u8QLNqzxeH
	Ce465zBp4kSPUEIZ7TXWAC/d5eoExA0lI=; b=YdAWfup6pMA/6YLl9rdKdFjZy2
	2JgFYCL+FMpP+m+QBETTy3dZRecjdNM9/yjN63O674VeniecjNYgxpnRv027WWc6
	iDbm/bBj150ivneq0BD2eQ4AiBT2UpzndtEB0XgmUt5tCukQ5nm0QAnC43fbw62/
	ERUdqQeCcyU4mMM8H2zG7o/W0a3CEvmtHyOHgDhcx/mhaPLrnRa7muqNK3c3UnwK
	UCjzhBGyCKIG6ReP2pmeXoSno7GVK2tCAbBpnTdFl53/TpMGcpXVtxKR0LDiifqM
	NjYxwpaLPTRVpk5nXAiGKe8P6c/+K0Suhb0rqeBLMcQQaYu477He7U1sG+nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714480010; x=1714566410; bh=u8QLNqzxeHCe465zBp4kSPUEIZ7T
	XWAC/d5eoExA0lI=; b=Zs9Sf+2ZObcAm2SJkkq3rvbOrInkSHDW2a2RJRDvKH+O
	pM5yTX/UpcgYYsc31nqCpqxTrfU4NSKGK1Y+6LtxGfhs8b9I+X3OTVTrZ6NeccNj
	GD5TQBzLQyHbvDhMBWPBRiUdkOPN6m5Ks60QWVLqUN/T6QqvYKVNXwdoYqQNZvlS
	5Qp9A8e1pzcqZ/TNNDTScRg+L0GQfLW1e/tPpDGilGQdATbjlH8t2eYMFIjP1x9U
	wf4jc8a5gxfdlIkyOfvP3+7cIJu4kULZQ7vlfsXYdA+9k6hrs+2JTg2G+6hGoWj9
	K/NcktexXfALL6oBYW3TunCWnPRi+dQnCqtWEhDPVg==
X-ME-Sender: <xms:iuMwZu6tfq0_GFYyq0rW2T45_EQGm7iagmc_ZughwMYZF9-yButYTA>
    <xme:iuMwZn7-kbLsm6wuF9WyXUP3TZi9EFfKt-itXBMd17FvfTykAEcHI7tv-G83jS5IJ
    GXfUPsZezLRMxzGMg>
X-ME-Received: <xmr:iuMwZtfnVgoCQKYsT0GiuDtLUXX_9KHVmdR4gS3EWYKfeo1qtqjhodvqzbeqyFNOqVq2FaQtw6DwmXcuz2zlDbk_PDG5vV3_NiDRrlZnPqGpZ85p3Urz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:iuMwZrJMY-zWLjhwhPXmSd9CFbBkZLoJj8oAFmDazkigYGmwo_WQIA>
    <xmx:iuMwZiJYiymiPbBgFb3iwnrDsO5DBRxm5Uujc0Zm5OcezDb4Up8TvA>
    <xmx:iuMwZsyuwR2Cg5jFDFV8L19a-ZP16orrAbVIKtEzk6h8iy44Y3Wi2Q>
    <xmx:iuMwZmJGMC1j-gkEbKBKqgfdK4KA54FCUeypZ_FoN6yCH9jhHtWqeA>
    <xmx:iuMwZq9qy8WXU5KMhevJxI0j-KwX1sdQQLHxSQE5Up8jDd-i8V6sBykE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:26:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 15839947 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:26:27 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:26:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 06/10] refs: classify HEAD as a root ref
Message-ID: <44f72a7baf22c833549bdfbbf3c960b4104dcb1b.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TLgCiVeWq32c8V8P"
Content-Disposition: inline
In-Reply-To: <cover.1714479928.git.ps@pks.im>


--TLgCiVeWq32c8V8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Root refs are those refs that live in the root of the ref hierarchy.
Our old and venerable "HEAD" reference falls into this category, but we
don't yet classify it as such in `is_root_ref()`.

Adapt the function to also treat "HEAD" as a root ref. This change is
safe to do for all current callers:

- `ref_kind_from_refname()` already handles "HEAD" explicitly before
  calling `is_root_ref()`.

- The "files" and "reftable" backends explicitly called both
  `is_root_ref()` and `is_headref()`.

This change should thus essentially be a no-op.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  | 2 ++
 refs.h                  | 6 +++++-
 refs/files-backend.c    | 3 +--
 refs/reftable-backend.c | 3 +--
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 6266f77474..5b89e83ad7 100644
--- a/refs.c
+++ b/refs.c
@@ -874,6 +874,8 @@ int is_root_ref(struct ref_store *refs, const char *ref=
name)
=20
 	if (!is_root_ref_syntax(refname))
 		return 0;
+	if (is_headref(refs, refname))
+		return 1;
=20
 	if (ends_with(refname, "_HEAD")) {
 		refs_resolve_ref_unsafe(refs, refname,
diff --git a/refs.h b/refs.h
index d0374c3275..4ac454b0c3 100644
--- a/refs.h
+++ b/refs.h
@@ -1059,7 +1059,8 @@ void update_ref_namespace(enum ref_namespace namespac=
e, char *ref);
  *
  *   - Their name must be all-uppercase or underscores ("_").
  *
- *   - Their name must end with "_HEAD".
+ *   - Their name must end with "_HEAD". As a special rule, "HEAD" is a ro=
ot
+ *     ref, as well.
  *
  *   - Their name may not contain a slash.
  *
@@ -1078,6 +1079,9 @@ void update_ref_namespace(enum ref_namespace namespac=
e, char *ref);
  */
 int is_root_ref(struct ref_store *refs, const char *refname);
=20
+/*
+ * Check whether the reference is "HEAD" and whether it exists.
+ */
 int is_headref(struct ref_store *refs, const char *refname);
=20
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0fcb601444..ea927c516d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -351,8 +351,7 @@ static void add_pseudoref_and_head_entries(struct ref_s=
tore *ref_store,
 		strbuf_addstr(&refname, de->d_name);
=20
 		dtype =3D get_dtype(de, &path, 1);
-		if (dtype =3D=3D DT_REG && (is_root_ref(ref_store, de->d_name) ||
-								is_headref(ref_store, de->d_name)))
+		if (dtype =3D=3D DT_REG && is_root_ref(ref_store, de->d_name))
 			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
=20
 		strbuf_setlen(&refname, dirnamelen);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 5a5e64fe69..41555fcf64 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -356,8 +356,7 @@ static int reftable_ref_iterator_advance(struct ref_ite=
rator *ref_iterator)
 		 */
 		if (!starts_with(iter->ref.refname, "refs/") &&
 		    !(iter->flags & DO_FOR_EACH_INCLUDE_ROOT_REFS &&
-		     (is_root_ref(&iter->refs->base, iter->ref.refname) ||
-		      is_headref(&iter->refs->base, iter->ref.refname)))) {
+		      is_root_ref(&iter->refs->base, iter->ref.refname))) {
 			continue;
 		}
=20
--=20
2.45.0


--TLgCiVeWq32c8V8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw44YACgkQVbJhu7ck
PpRJYA//e0zJB9Devd4QI9rna/kDkYZKyGgiyVO1tWAMXSVHNdsaPmQ3Au5f/kIT
LbOxoEUKbfCro7SEemSLzIsKXI0aZ6PXu3FOr13MU+PdUu5thdMOPdnb8ScvLGZi
wyHgqJ7j4f4fEalUGCpCvtApksZJ/2JExQasAZmN6C7HME4Wrtfm4Bos7xubQfcN
/Z2civatcQTvj2A4iSwXzg2R5PKHAoPa743e2/P86FW6zQjCyfVCAIB4bDwXt3nP
XYrMhX7jPsZTUB7j9vf8EFGSEs3Te02QFmSh7qr/60zQ1KYwvQELaMgGjMjZ5LHX
mvEpReqP+0Vj/KeFJ8vTwiT3gn9X+0mcjAgH+tZki3PFOej4ycV+HjgdKbxuckoB
9R5/3q4KSbirlfpclTPWXSnKfxRM2jzLyP4dV0BXB/SiswOg2K+oCjiTWANMGzUU
1tj1F4eC880XirteM0G5XuAoRfGiTOc8PhV65rCHL+kWdvzEmCo3ooZDV3KdfUND
NxvY/r553c3tztGzIEuCuyTk9L9oF+MuuFCE1FQSFOp1QctFsPGTprZ1NZg9rsnd
T1L0PXpN+/PZcDAIXCxdkdEJbE9NnV5wbfxehxKf13o4sHUxdQIWBAg1AVXUkx0u
N3GdYoQFJQ2/wntbogfvsemydH0subnzTx+d4kzr6r5xN/mP8PY=
=zr7v
-----END PGP SIGNATURE-----

--TLgCiVeWq32c8V8P--
