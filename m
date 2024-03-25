Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91DF19F52A
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361452; cv=none; b=ixrsLvZMrzPPmEOFvJF3HZShDKZ0iLJYjWVpNWiCfS9nxsU+jIOvW76nmtyaZbrNsuCn5uiFu57rrsWIo1MTkKh3EQ9qoUcfTuhdGgZrdrrvcvlVVSAO0NPk84AFHV4ZkKDJ7LeraqoUskkfwEzu4Yi5/H4FicPvJhwnRdaqxRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361452; c=relaxed/simple;
	bh=zQFnffg0xqi9KwVSYmrqd7FE5InPataIde2pt6CMvOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwv/hhvIKu3x77iJq4RuwlYfhlSImGGUI2gt6CBd9CxbjnHTAl8YOlAG7rWVYoEHeyxvIsM3m0IW19jUS1eop3BUgWjeWIqhPCrw2gqKH5sMwjJg7utw4x4CACmBVB6WHkO5HaA9IQF3C+ozcIsG9wU1w71soD4BzZzS7ppozCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fHEkIol1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+m408iN; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fHEkIol1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+m408iN"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0477B1380114;
	Mon, 25 Mar 2024 06:10:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Mar 2024 06:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361450; x=1711447850; bh=rI1TZB7rEk
	0b5IMU7vDKi3gjp60u1WWIqvXZ6icS7h8=; b=fHEkIol1OmrzlhBioWvgPE9um0
	xeIkNNbPkg/U0ieeEdabj47UswGwCpAxj3WJG6hFXYRMrcQ2z4Pn6RjON7JlW55m
	7a3TDblkH17/OoBgnlV4lrCuO8KhC/hgHa/ShpzfWGnUF8TS/lAxDs2mIavB1rB0
	vCUkpRNWKGjFFFKvPXjzM7JG95Jk6MKRRWggo6jyq4KN81LU4N76Y/TQ44vvICH3
	QV/eXYX9zTDBMeySUzlMtEsKhmZcox36SfT+3fVw4XRnenKaMeIvev8TGbMga/Af
	IPsyKxAhEstG1CCIZZz4bJuJ93Hlc/4VHCjU3R+E6HFFE9L8JZaVvY8fTwQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361450; x=1711447850; bh=rI1TZB7rEk0b5IMU7vDKi3gjp60u
	1WWIqvXZ6icS7h8=; b=G+m408iNEMIXR19zEEme7PQcL90GIDxiToWVjxnaO1k8
	bg3LdEvR0dlGrb4DxnCJdh5baCZzftt8NAk0vxbBjuOr7636hj1OkXPBEWPv3/J+
	e8mZK7XEnRzvoR3w/JqmASFEiga6yp1QoSUKRdh7jtSIcJ34LhxVzeWDjMSryGT3
	ilkBaq2bPy7F9v5WsWZDspxATyPaWaIllampdGlKnypKh7LGHfRp7AN54n8jD6fP
	PvvwzOLD0J5Pm8m1CJUx62ghc2zXqxk/01Wq2BnjmDpTGI9mjA2/MA4A0edf5znt
	Hg1cgadxZyHTfKVjgiQ4wG/3v6J206CWU1rGICMTUw==
X-ME-Sender: <xms:qU0BZnaL580wWFea8izSmCSqeNFz1mR0pFVli1SZ1dwxpVRedS0wtw>
    <xme:qU0BZmaBoN-pHn0QxRPSfU50QHiVmZB-j5fGRYt362qzwQd790oZCRVlx5mk510p_
    qwA_MQh8xr-zAV-Mg>
X-ME-Received: <xmr:qU0BZp8UASE9IMr9sMy-jaaWnIZgbLwyKDEoOP0ByEy25m44-c3AiopLJsJ-pCkpC3nJBdZTyF0x5sMtrjocGlDky122bhxLekBbRmsnmRu9Ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:qU0BZtoNdC9LXe2-4fdnkZhmDZEWKS5uIyReaOY1V95J9MtS6o05Vg>
    <xmx:qU0BZiqGF4YDumtR5uTrZHioqbzTHOUIZTmAbZuEsAiKI8E1kuVzig>
    <xmx:qU0BZjR4LNZHIlxGMIRXzKqKYbSbDG7uGuxW9nRfByh0xEY_8RbKAQ>
    <xmx:qU0BZqp3e3-FZiB5hYaPlguCn-X5MvtUuhdADLq32ogw242FQX_Yww>
    <xmx:qk0BZlUwkMsyb5IjRIL3keu57dgYhEYrDmnIyuX_acfUcyLVkT_j9g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:10:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b18ea232 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:10:39 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:10:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 5/7] reftable/block: fix error handling when searching
 restart points
Message-ID: <5bbeab114f9f0563c9a6c07417b90d41c7fcddc1.1711361340.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oBIQkwkho9M2OJJ6"
Content-Disposition: inline
In-Reply-To: <cover.1711361340.git.ps@pks.im>


--oBIQkwkho9M2OJJ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When doing the binary search over restart points in a block we need to
decode the record keys. This decoding step can result in an error when
the block is corrupted, which we indicate to the caller of the binary
search by setting `args.error =3D 1`. But the only caller that exists
mishandles this because it in fact performs the error check before
calling `binsearch()`.

Fix this bug by checking for errors at the right point in time.
Furthermore, refactor `binsearch()` so that it aborts the search in case
the callback function returns a negative value so that we don't
needlessly continue to search the block.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 5 ++++-
 reftable/basics.h | 5 +++--
 reftable/block.c  | 9 ++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 2c5f34b39e..fea711db7e 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -39,8 +39,11 @@ size_t binsearch(size_t sz, int (*f)(size_t k, void *arg=
s), void *args)
 	 */
 	while (hi - lo > 1) {
 		size_t mid =3D lo + (hi - lo) / 2;
+		int ret =3D f(mid, args);
+		if (ret < 0)
+			return sz;
=20
-		if (f(mid, args))
+		if (ret > 0)
 			hi =3D mid;
 		else
 			lo =3D mid;
diff --git a/reftable/basics.h b/reftable/basics.h
index 2672520e76..523ecd5307 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -22,8 +22,9 @@ uint32_t get_be24(uint8_t *in);
 void put_be16(uint8_t *out, uint16_t i);
=20
 /*
- * find smallest index i in [0, sz) at which f(i) is true, assuming
- * that f is ascending. Return sz if f(i) is false for all indices.
+ * find smallest index i in [0, sz) at which `f(i) > 0`, assuming that f is
+ * ascending. Return sz if `f(i) =3D=3D 0` for all indices. The search is =
aborted
+ * and `sz` is returned in case `f(i) < 0`.
  *
  * Contrary to bsearch(3), this returns something useful if the argument i=
s not
  * found.
diff --git a/reftable/block.c b/reftable/block.c
index 6cd4c053df..ca80a05e21 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -387,11 +387,6 @@ int block_reader_seek(struct block_reader *br, struct =
block_iter *it,
 	int err =3D 0;
 	size_t i;
=20
-	if (args.error) {
-		err =3D REFTABLE_FORMAT_ERROR;
-		goto done;
-	}
-
 	/*
 	 * Perform a binary search over the block's restart points, which
 	 * avoids doing a linear scan over the whole block. Like this, we
@@ -405,6 +400,10 @@ int block_reader_seek(struct block_reader *br, struct =
block_iter *it,
 	 * too many record.
 	 */
 	i =3D binsearch(br->restart_count, &restart_needle_less, &args);
+	if (args.error) {
+		err =3D REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
=20
 	/*
 	 * Now there are multiple cases:
--=20
2.44.GIT


--oBIQkwkho9M2OJJ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBTaYACgkQVbJhu7ck
PpRtORAAkRti7/S+i06AkAKOMvrQ5tu4im1dST1+D1+c8CU84Adjc/gB7g3bwWA6
W7eMc8Q01yQBi00oPh1ZFPbNldo7dy2VaH96yEo0noUhNnrcfb1rHdLo46E5dcNv
RcPODdehFgPO8MXImWgPaTAgMJFnDEmGmB8pDVnIlGiq0antWachyPyPZtQDQRpu
oxmxYerDU/3j68ojOuCzTBrDhLlwOfUOz4JeyvYpZNPbKe6TlbnrIpT8wQP/6VBI
VyStrmHyNScAK8B4fv5pVyETM2ddFXTrhbE3zbvPrmNTXJWhx65P4cpRE/gpGvT7
xJbIB5m1r3Ta5RUcWASkQN0Wzf92WXjN2ZuHvnmBCiZj8isBo/8TkqleosK9HdVs
U6bXkYe+KbKcwg/mm6ULCEsIz//FxBUaBl6uzebEDUo/c1qEKEvw07C180cLD2gd
Hfbq1UjEAhXoPeqLo9NTedcl3G72GVi+sC7iahtXAVcepn/iVvC2yO1vRcAF8YcQ
Bhoc4sZ5NQu8rX6Pvlm25MlWAhSwJeuytN7Sqv/tfCIHc643b+1XS3zMurJGS4zQ
UbcThFYC/NyGX/tAwlzv0l0phhl59cprzvpnJJFqQ/7knFHFp6BZcjoPry0RXaW3
LOJJiRyw3r8yS7kk/ctsWg3j8JX46zj5kCRk9E6ZsPcVztwq9O8=
=zIsA
-----END PGP SIGNATURE-----

--oBIQkwkho9M2OJJ6--
