Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A47A4D133
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124275; cv=none; b=BVglzPDRd2YAVVEvH5vhmCSzsSjBHHxPtHBvrJGJI17ZtqIoAjcOSwb4b3W+dHzkMxmDrEs7fIazBELsDFSPboJxy5Me0dSw29tWjD3lpk9NQXdUzU1Ku1+N6wctUuths/E0+VPOlS1B2JpDTAefCgFHS6hz+593n27qdyr2diU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124275; c=relaxed/simple;
	bh=OstjbyC2SKVuKoIrbC3GLyKYiMPilvwFIdeyWaYUtvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvPZ6DApivusYE0cZOcXp8aByLMttp8DYjf/yM6Wf0yfzuawaFyPIso8oyiiKSmTyCQGTOqygUDhE15sM5Nq9C9G2nkQFri1fdzlsAXvS0NRymXuVhgrWiXLRwQHhsItcoyRODB518r4nxiCTKxIPrbszBrRlmyS94Mid6/h3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NQtJE09O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F6fQVGr0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NQtJE09O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F6fQVGr0"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id DCD9113800F4;
	Wed,  3 Apr 2024 02:04:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 03 Apr 2024 02:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712124272; x=1712210672; bh=kn4ev0CKDc
	8v6+HGzzmOini7k6ZVXrPCJ1+NHJ3Ah+M=; b=NQtJE09O2O9ORxvmfI8wCEy3RJ
	GeDrDmck3LlL/KxQfYfUyInxGYbg9YEAwmxngcu/Yatv7RX6NJMQYR8Nnp9wx92/
	r7tNvynHqHn6rzKXz9OLOHPOIgIy1O26heLEaSFZCzd5owfZ64d+W36E1X0/kxQV
	+QF9zPg9Z6XscSB3ySCLCZRoGJEA7eWxZEta594iCKqJQR4ToWdftDXlxQsl0QbO
	qPqaXBGz5blwOKfx8FXXMutfMACu17ZYpAEpZfJwYAI8PKgnpMHXzhSz1Q9BCqZG
	5a6mowWP9gqvrRAaMjmbbRepLG8qMG/aQAiXXltZ65MzR76VT9r4ZWWpvLmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712124272; x=1712210672; bh=kn4ev0CKDc8v6+HGzzmOini7k6ZV
	XrPCJ1+NHJ3Ah+M=; b=F6fQVGr0kAu+cBR24osnV9rz/XIW1LP8FyRNrSIxqDIn
	NAwiO12ILlwinHWXSGHVK+v6t5a8TNJaHyMyl+AtjNQ1ou7FxI3haCL4AR/o8sLn
	0uRiJmYL6rJpFv1+z8IJG6+0rZXHej4qtIPhrQPjSqpHAGmH6nwz+CBPk7tHyJrl
	5zKU0MxWQ4uLFMix5Scka8+b87+YyFWAp0TTe2TiSnk57Zc7rBp1bBhnaudiHeVd
	pXJya9aUgdeV5ko3ES7nNiF6axBpoyRw1pPpeHvSe+S7NhYGycF0unoSZ2klkCml
	Pwo5IDwXIH0ZWOV2LBL/OkWPWU6OJ2LBATzkKdSdYg==
X-ME-Sender: <xms:cPEMZhi94zsWt6ub2uY98H98drT9WZg9xr4Eg9YO02kYqzPIYiecrw>
    <xme:cPEMZmAv8YXXvM0jgsB6UC27HTbdp4kAFC5wbIrqg6cG9blwv5M44gPjrU7HvN1zF
    p4itbVNJaQXmYd7Eg>
X-ME-Received: <xmr:cPEMZhHEIZwjhtix0ZpYwuidipCujQyo4sRUSZq7kcEyKNQiM8VhQqAfw_6w8oxdugaNTYHIksAvO0NwhrPknDn9fEYmvbwrxuP7S5L3BZDwDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:cPEMZmQtF5NsFgdGJ9Jyrt1daWAm2WjwsHLwPMIlPqbXH-8SCQLF3Q>
    <xmx:cPEMZuzvGUC0Qsw6H5Kbi0k9c2xg42RCs7ITvexrsjNjcPwKu3NHmw>
    <xmx:cPEMZs7LD-_mgQvsKftDa9YyCfel0YmFgviqxA9TAE4MrlDuGd1kOA>
    <xmx:cPEMZjxsWvP01btn3k5YBCd8bac0V6KMxzqICu5fHyR_6z_ddbCPAw>
    <xmx:cPEMZi-dDO3Bxp15MrQUqsTRtpVRir3K7_LVSdYwByQf3pcsJcDM-b6r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 02:04:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 62d74181 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 06:04:22 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:04:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 7/7] reftable/block: avoid decoding keys when searching
 restart points
Message-ID: <632f725dde7b7f2eda83d285af90c7d989f294dc.1712123093.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712123093.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UavFzc5DQG9k0U2Y"
Content-Disposition: inline
In-Reply-To: <cover.1712123093.git.ps@pks.im>


--UavFzc5DQG9k0U2Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When searching over restart points in a block we decode the key of each
of the records, which results in a memory allocation. This is quite
pointless though given that records it restart points will never use
prefix compression and thus store their keys verbatim in the block.

Refactor the code so that we can avoid decoding the keys, which saves us
some allocations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index ca217636ae..298e8c56b9 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -287,23 +287,32 @@ static int restart_needle_less(size_t idx, void *_arg=
s)
 		.buf =3D args->reader->block.data + off,
 		.len =3D args->reader->block_len - off,
 	};
-	struct strbuf kth_restart_key =3D STRBUF_INIT;
-	uint8_t unused_extra;
-	int result, n;
+	uint64_t prefix_len, suffix_len;
+	uint8_t extra;
+	int n;
=20
 	/*
-	 * TODO: The restart key is verbatim in the block, so we can in theory
-	 * avoid decoding the key and thus save some allocations.
+	 * Records at restart points are stored without prefix compression, so
+	 * there is no need to fully decode the record key here. This removes
+	 * the need for allocating memory.
 	 */
-	n =3D reftable_decode_key(&kth_restart_key, &unused_extra, in);
-	if (n < 0) {
+	n =3D reftable_decode_keylen(in, &prefix_len, &suffix_len, &extra);
+	if (n < 0 || prefix_len) {
 		args->error =3D 1;
 		return -1;
 	}
=20
-	result =3D strbuf_cmp(&args->needle, &kth_restart_key);
-	strbuf_release(&kth_restart_key);
-	return result < 0;
+	string_view_consume(&in, n);
+	if (suffix_len > in.len) {
+		args->error =3D 1;
+		return -1;
+	}
+
+	n =3D memcmp(args->needle.buf, in.buf,
+		   args->needle.len < suffix_len ? args->needle.len : suffix_len);
+	if (n)
+		return n < 0;
+	return args->needle.len < suffix_len;
 }
=20
 void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
--=20
2.44.GIT


--UavFzc5DQG9k0U2Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYM8W0ACgkQVbJhu7ck
PpREPA//UailXJGRYf6PGEsUo83jCQZ/4edtEE7oluaciPIM+6Vdc8Jq3Kgjk1FI
Z+dpTUvkyUcTUgQiqQ8Kgrq1E+3i+aP9doFIPOncOzWqlB0JmXFsXXiu7f3JR4sv
UAaabhhvdHljutIR3YyMfdbNoWD2mykuKfjhvDLg0DCyI1sF1y9AXyixIKwsSv0F
jUZn4e0jVNZbyqas5cZsoA/zsYOo1pcU5tMAgBb+jIjCJ8dmmXNFNdoEnGFty3Oe
FvavoyAbbQ2LehINwPvjRsFsMeqXSjNoikD7xT06ILP8p+JU3m03YTDHF3uUnRWy
/RGxDUvROW5zAKuR9AISRFteY5LlTwBdZ7IlMEEca11O5yFYO6P+0s/9GppRKV9j
VEt9q139rML2K43LaJtni3FsBVKjJKEzhTq9/yfALPq4iq8FGh3yMyMsq7DXV5/8
J39CXuYgPUR3wmwkewFYtF7jEp9b1lm5+lLiyKw/yBgubIAlZQgT3W78m3VxZxkc
bkLbH6b6npc/7JuhsqCftR4EPTenAFlVtb+JpqR9nR3lFMOs2lu1xp4giUiznoyX
ClMxBYO0+cEF0PDGFYVKQ1EQXmbZnWy0lLYnRkL1AP3k+zPXMFHW/UD4r3/cTLVa
XdeavWAuD6q1450N36axvcDoCZUh/h4uKRXY9yaKSrlZ29xxD4o=
=n/vp
-----END PGP SIGNATURE-----

--UavFzc5DQG9k0U2Y--
