Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1E5140384
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480009; cv=none; b=uBJ2VZdEKZ/ZQ0GjzQ1ahSY3HAxcoju6JkegtUMvVWshO2/XzGpbEEhQimUFnBlcio9sjru6q7VDcMSUHZ1ZuqLIf5bzj+Ms9ytV/38DtZZ/fvLdbzqykTYdb/XOlqOhL6/BATqlqr2Yq/5rzLWrFMpaWFJKJuz35TGzUogqLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480009; c=relaxed/simple;
	bh=OnLLvQoi1mbyFOERIdR55C1Y4+eoFUSK3bvu1vqUbFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arE9YNwWhgK//7aDrgKkzBNp/TY7n1EvBpqgmUXAxzXl8qZGAygBI6v/sQ5Ebe81SmBbcv4ckGz4AF5HaI3BIZjDlKYYX899tbOZl6UB9bIQKDupF7Uy0PndCyUn5rKlso9Rq+n7Yd+xR4btZNjo/toDYIpfY6fyLdX9rdVxtAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jXWxFfUO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VDUtqQfe; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jXWxFfUO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VDUtqQfe"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id BD56C1C000F7;
	Tue, 30 Apr 2024 08:26:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 08:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714480006; x=1714566406; bh=QcbhTT35lw
	uPBSxa6yg88Gtc8PW2UaVx/ICH7SoOQ4U=; b=jXWxFfUOoHz/CC0br3+Eg9to2L
	D9uj6RifmwzsHLmVq0nidP6zZF3UCvpe5u/Dwsv2+TNgJwuPmhK98mhpi1jdXAoP
	TBI6PXKf5V3VHSwvHHHtNSUGVRqLAo4dtfYFtZPwPY1vYJjLbVZ/YCP6tTTLOLZF
	NV/L3WR3Q/mFgrXEZfUbp7mrPvEt2xwayoeWPC7E4wiIuKcvwxTVLHcHu7bUNZjk
	RhxrlAo0QpBZRUS6rR4b0RiW7JnXb5YZODHeSV3PTabUhXnGTI0RVkUjHTEXpMDB
	8RSAbTU/smWLsgWDL5m9JEgRInwITmsv2ryYqLkbOx7OwXxIN1fTU1Cq6f7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714480006; x=1714566406; bh=QcbhTT35lwuPBSxa6yg88Gtc8PW2
	UaVx/ICH7SoOQ4U=; b=VDUtqQfeG63MzI3dahwnbdf+7Xr0rpxizsGzCo+oxUUI
	lTX7I7dmI3jAh2vqdCkqk4LO9SKaCU1hL+hgNt1He/A9TrtlhEo/v1wKsVipr3cr
	AwYRSDobJgblEyuzRH/yfvbN5QbJzv6bgolCG2VDaHdgcQSk2g2azUsSWLt/wgYw
	1AjXj/3n8MXujvgmIQ51Wqe2I2jW/yMMJ5DtzwFAosC2BrpxeF36ntO3GQsQX/dx
	7tMmmpn6p7BFD+7XaQ7O9oFf02fTFKnLyDUdRwop38alnD5uu9gPGuasuz922eA9
	2sBcLCzyCqckdwNQEW58lfaPHwH/EHF6u4eRGAZ0Hw==
X-ME-Sender: <xms:huMwZkm6GoE381CNky3IVXSSHhRIwz9227ZtThVwBtvcL9zU82RCUQ>
    <xme:huMwZj0DAU3kfDCB9cARu8wKeklxtTziF2fzlz4tkzOszFWLU4T_twbxgbvpj_HPd
    shY8Eo6j_6Cyuv_tQ>
X-ME-Received: <xmr:huMwZiqH84uHILS7ao1wPo_K75fo5bIUt5NJ0-m747Q-qOlAnYwnDRiAT9H4pdTV3Bk26uEK1lzKDswtismadoR2q2YnRB7tTdQd4Li0DNLjhCt4fnEv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:huMwZgm1u62BM_HrPIwBfR5NzIlYlgoPEkUOMCkaKftQllSt_FsXdA>
    <xmx:huMwZi3vIYz6RZngNA3nw3PIVh8ZqzDqwcwd-Gh2E8d9TpgWhL6QWA>
    <xmx:huMwZnvgtyvnIGUnQRAYdwxRJZjwQM0XR0w8C3qHjnWVLkui_S6ilg>
    <xmx:huMwZuWn-t4ttgrDqRm1DXjxKLgdV3_Nai9xHxwn3tTBCKa2CJPAKw>
    <xmx:huMwZspDv3HSi3EDgZeK2q4JNRF6B4FJV0JOIGBU2PyesbZjeDemmKx4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:26:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5d85e475 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:26:23 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:26:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 05/10] refs: refname `is_special_ref()` to
 `is_pseudo_ref()`
Message-ID: <e6b6db972d8009fa2a4e17f9b46e69d94391feb5.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tDC5ey16d1vvHdY1"
Content-Disposition: inline
In-Reply-To: <cover.1714479928.git.ps@pks.im>


--tDC5ey16d1vvHdY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rename `is_special_ref()` to `is_pseudo_ref()` to adapt to the newly
defined terminology in our gitglossary(7). Note that in the preceding
commit we have just renamed `is_pseudoref()` to `is_root_ref()`, where
there may be confusion for in-flight patch series that add new calls to
`is_pseudoref()`. In order to intentionall break such patch series we
have thus picked `is_pseudo_ref()` instead of `is_pseudoref()` as the
new name.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 0a4acde3ca..6266f77474 100644
--- a/refs.c
+++ b/refs.c
@@ -1876,13 +1876,13 @@ static int refs_read_special_head(struct ref_store =
*ref_store,
 	return result;
 }
=20
-static int is_special_ref(const char *refname)
+static int is_pseudo_ref(const char *refname)
 {
 	/*
-	 * Special references are refs that have different semantics compared
-	 * to "normal" refs. These refs can thus not be stored in the ref
-	 * backend, but must always be accessed via the filesystem. The
-	 * following refs are special:
+	 * Pseudorefs are refs that have different semantics compared to
+	 * "normal" refs. These refs can thus not be stored in the ref backend,
+	 * but must always be accessed via the filesystem. The following refs
+	 * are pseudorefs:
 	 *
 	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
 	 *   carries additional metadata like where it came from.
@@ -1891,17 +1891,17 @@ static int is_special_ref(const char *refname)
 	 *   heads.
 	 *
 	 * Reading, writing or deleting references must consistently go either
-	 * through the filesystem (special refs) or through the reference
+	 * through the filesystem (pseudorefs) or through the reference
 	 * backend (normal ones).
 	 */
-	static const char * const special_refs[] =3D {
+	static const char * const pseudo_refs[] =3D {
 		"FETCH_HEAD",
 		"MERGE_HEAD",
 	};
 	size_t i;
=20
-	for (i =3D 0; i < ARRAY_SIZE(special_refs); i++)
-		if (!strcmp(refname, special_refs[i]))
+	for (i =3D 0; i < ARRAY_SIZE(pseudo_refs); i++)
+		if (!strcmp(refname, pseudo_refs[i]))
 			return 1;
=20
 	return 0;
@@ -1912,7 +1912,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, co=
nst char *refname,
 		      unsigned int *type, int *failure_errno)
 {
 	assert(failure_errno);
-	if (is_special_ref(refname))
+	if (is_pseudo_ref(refname))
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type, failure_errno);
=20
--=20
2.45.0


--tDC5ey16d1vvHdY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw44EACgkQVbJhu7ck
PpRPqw//STz/EBaNDoozrYatSvLB1Cagr4gUFiqGF+9FlhIF3e10PH+E7c8B7zaS
b8bieB8MosxteVrxvcJDArx8yddRiDcAl9HcQ8+BMMJvpsHhYMJTy3PDa4EeVp+W
amlx4IY65pJ1H9dRRllmhaoCFOfAFEhDF6M0CWlkcDJCYtVOKlI08ORHgZspw98P
SiBr4wmoYyOgXXviWMc3ut0PNpiaiz6/KjiR4k4f6leeWbkTH5JDCeAuGb5Cogig
PDL4JSbH+hZcTRCe7ZMZB6BG1Jhewbkv0ZISXbOcD0kXxCGbhXzNJ3LQlne4HvNm
VIWTm+lSmmjn2NEXM2yFShY0R0cWaoJO4F3qSpjFYXFbEZtaIEYrdQA6FgI0RrUz
eFCexKDs3vsRdqUooBYs3njylq95zJ3ZzysJsIRLU+nLQS0bzzDoiyXeESn2h/x+
56/6vQC7JgAh0Ong9tEtWWAbaHl6eXIl9uCAeFOgijqmboxmCSkgCq5n190Td1iL
e6Okiz60DvyU7WDvAxWbNkIxEbUbSHrwhlJBDpNQetRFSk/XvhFvFrop9ZShek7v
oSJZ43e1UtsduEmLI50sp9gHCVilK3GSdBicMmTj/M2vUNk3l7vOhyLAGHQ5yJ57
cEBYjd7AfHBLDEvUJ9wQYfRZ0RzBljYkKyF/ip0m2nuNsoRGROU=
=uzmm
-----END PGP SIGNATURE-----

--tDC5ey16d1vvHdY1--
