Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB9158D66
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773923; cv=none; b=K1kEAQtPGqpre+8IMQo79HT4wA27/FCaf16UeHgplKWcOoFIECphUt7t8dNdc1N31/fuUatL50hXy4WoqLmOAA6/4luZLAI2bcHWWICe7aVnvrkHbgsOTcWy9VkzGAD7nZ8q0y5d+/2ZLwxp/2h1Sl0GoU1nciJBQILlOj4jKsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773923; c=relaxed/simple;
	bh=9lhm9BrmUSzT/FRqdJA0OMgkj4DdK2bvq5Txy+TzcLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+iraWdUMfZU1BZslBxOtAr9hH3pwtrQmShTvH0p38e2ZyfW1V4bp4s5ltAVI2xyBMTHZ1PnTDMGw8RkvWuj0WnrqcXMRHRUPpvTdS8U3plWFGa78EsOnJnYTSe/7BeZUNkBzR1+3yFa4+pzozDWn2XCsBsi2czhtz2iQXAcTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YxU+u5r9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dt8i4gDl; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YxU+u5r9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dt8i4gDl"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 17DEC1C00069;
	Thu,  1 Feb 2024 02:52:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Feb 2024 02:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706773920; x=1706860320; bh=zy7fp1TsAn
	wdqDSCYTVtkx4q1A96ArZxxyywa6k8ILQ=; b=YxU+u5r9VU6oxQ1E1LRZCOFYIF
	jjI7m2Yc1BnsKUGNyHS0Pf4xQ56rgvmTEs7VfZ/7zNxGgyPJcywSAxUJ9MlDbiEM
	hs+nHKhX5MbefiR5T1K4M3U9MFtcDvZ6Oiu2lgSUpEhdKNrwgDJU42WrnNg5Qenr
	TCTjMG81yFLCEQJAStwnHw7mdS+nH9BYMfRvTP2UuaaAgRg9trgF10zYUsiGTgKn
	I6v74XIl1a9Uh/14+OKUi6jreV3oFJbL7vrQJPFE0h/kU2jrDnwx5g3vVF/bnIX6
	8nOFqLDZHFOzyY7NklagtgPfjX1quckar9xLF/Y75CacSxS+SFWjIpEXQcRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706773920; x=1706860320; bh=zy7fp1TsAnwdqDSCYTVtkx4q1A96
	ArZxxyywa6k8ILQ=; b=dt8i4gDlaWJr7J5GLQSiHdOyDCLdzyD5scGfg/5lLYsA
	DfpzsSSuzmwBlBagVQijHaw8Azh61xdA/YrvHgabc7ARBXC3skUp0db1WFEXXOum
	iNKSGDeXBIQ6QizAG6X2WodK0UgR2IcjFRRXI7HUrdegOxV+9RiftxNxpRTH6s7H
	OKOa82Q+3UuglcZhd2eEYjyD6MBTJ6jpLMzssXjhLpCENXYVItJgj7UPWiIJxT/o
	NDY2opu1ylw/C/8koq5qi82I6KWm4nbrJ1wHP255vYU5Lnrd5malfMAc2l3PLiIc
	v4cQXCSU6bIM7ALSY+eUvO7YfKxeqPPBv8o34X/D5g==
X-ME-Sender: <xms:oE27ZfGl0Kgf3VxA5XEUdJW1msrKwviVahUSX2rU8PBex8NkOzv7Ww>
    <xme:oE27ZcVJD5bXFwsF3yKA03tKPFNNJGiPyKawfu5AbVHOdcZjFgE6BKlmhFSHOrnKt
    6Qeo6nDiCiw6-ifBg>
X-ME-Received: <xmr:oE27ZRK_xW9SkDK8jxr8RAOUtGUTffd7V4NWoIeytg1tZMHZhXBXZ7KfdzRI_zCu9l9OiZkE4X-LkSB4flRT5y6PcnzbpRst0mOc8WZrim5_wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:oE27ZdHyV0ZRTMf1f97vGHHgNjcBqASOZrp5_Kcqg6pv4SMTqRj2mA>
    <xmx:oE27ZVXtiUoWCLSWw2vs6qKAIz0_V4pacM6tLNFtHxEpsX0YjNc-VA>
    <xmx:oE27ZYMHN6nU-_w2EMSNt_oja_dZX9DaEb46sGoHR9CaMqK23nYzZg>
    <xmx:oE27ZbyhCqQOEc5tJpK21t3af5th9EHIaTKJJi1L9PHGU2kM3QvV8fOt7i4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:51:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7475996a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:48:36 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:51:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 1/5] reftable/reader: be more careful about errors in
 indexed seeks
Message-ID: <ecf834a2996f554aa046839dedb835385ef84df5.1706773842.git.ps@pks.im>
References: <cover.1706263918.git.ps@pks.im>
 <cover.1706773842.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BFi5J2MdZ94YzuWO"
Content-Disposition: inline
In-Reply-To: <cover.1706773842.git.ps@pks.im>


--BFi5J2MdZ94YzuWO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When doing an indexed seek we first need to do a linear seek in order to
find the index block for our wanted key. We do not check the returned
error of the linear seek though. This is likely not an issue because the
next call to `table_iter_next()` would return error, too. But it very
much is a code smell when an error variable is being assigned to without
actually checking it.

Safeguard the code by checking for errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 64dc366fb1..278f727a3d 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -509,6 +509,9 @@ static int reader_seek_indexed(struct reftable_reader *=
r,
 		goto done;
=20
 	err =3D reader_seek_linear(&index_iter, &want_index);
+	if (err < 0)
+		goto done;
+
 	while (1) {
 		err =3D table_iter_next(&index_iter, &index_result);
 		table_iter_block_done(&index_iter);
--=20
2.43.GIT


--BFi5J2MdZ94YzuWO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7TZsACgkQVbJhu7ck
PpSsoA/7BUVTVU450F8GyqETBVi1x2oy3pq4ufbNOgIFh1NpzH3uHUwD/TLe1JXT
qwe7TbH/NKfBLODLhStRZ0zwKROHphRLsUqMsE/UMbqnlQls0GyHe19h1Cl0bWMa
Dlt5+80mtrIz9d05MJkYVFxBK/eKp79jRZRCw58lpQtBT/jPM623SHeWs55uoiNj
ohc4vDnciYUhtOTwJw3NLRhw1T6fhhVj8a4blFnnNpjUxIUmWFjq8kR/6oco1tTf
icHW6YkfNX2bxBtl2cwcOvs+tnZL7rMQHXOY3WF9B0GTlsE7va6tZD+Fqe0Ac0iO
44zNnWI3fokAIW0wiHxxilBQJYex7ijolGc/F+UqHWx68fbIxhLHW/+pBdmMERGh
pMPWD0VOMxLVWXyKngqsECm7u17df7He/23ldkYxPTI8PrzqKQoweNTVKf2+bBjp
HlTP2vUrIDziSAezWaiRaYWaw3baHhLC1jdQU+QcNNinX64Px3u4R9euDsErRGvO
+cfEbZRgktskVzdCNkfBdaDsnJkpVw4wAvPffpRvnzpf+k7JsFGA+oukHXuON55L
z9v1nllsJ/UNTHoFR3iUUIE1cmWBeaac6VOSjkfNA25LFtl/IJGwBnAKek16zNt6
KSk8CveHYUuN5ve5pSvV99+IzSn8vTMz8PKDkbafEO3mOS3L2WY=
=k6fU
-----END PGP SIGNATURE-----

--BFi5J2MdZ94YzuWO--
