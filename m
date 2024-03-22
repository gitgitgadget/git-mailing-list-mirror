Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D213FE35
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110176; cv=none; b=F/jSGBB86jsjeYEyklJEmyAea14WF5iB66ECUQvjZ0seVOYmhtDgUwDv6tGcZ9RYYYMl2NNsIP67GyQCsUlOFWQwR5Lk3dHcHP9z7HtBl4GLej8d05G4eycDE2LHu7rm4/PanO9dr3g3LOfoJSc0tTMgcZGJ85B6LhOznI/VwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110176; c=relaxed/simple;
	bh=Fr9LJfIB+JrZxiqmP67X+MhljCSwejQ7Tq4cU4io5gg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyH8abcMLCjRm2vVJnEL/dKCIvgQJbmOhUQSn8G/RVGr7ZoItRxcrMp0rYTtVvozmVqLGYz5LVopzNrgPhrLzFbnEEZ56XOkcRA12e2C69ILZfDyRimtaiw/fAj/PlY5qVDkoTmmD6wWmH8VV9QT0kXwjBncFVFDf4jZUpF3k+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iOcFuz/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UU+VyN7B; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iOcFuz/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UU+VyN7B"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 25C825C0096
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 22 Mar 2024 08:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711110174; x=1711196574; bh=R3BC2Jdu0u
	ZGvghyx3l8jrFbgh4VIJ05l18uTDDkOPk=; b=iOcFuz/lL8R5NlXK66mlZCjjiJ
	N+Uoas1AKkB3DuMPN6OejOgR6DQHbLpFWnOQmw3ljm2bTnO12K8pPjMAqFUWfq99
	thsVXyGKp5RIEijQ3OcAFiDVOw79q9GOJjTR3ck+ExrLszzPATI2fHk+n8ILsEGT
	c0AO0nCVS7BQjYWeVMUnWcVcxNHAl3ttNsrE/zl0yn4pMIjYpbFIPnmfSa7cIoR3
	ASwlE1b9XDeBvdPkDCqVD4bbEyhNNT0/bTfDAopVqqqruKGXK83CzZQYzIY8zd5X
	T7FQmPvoiLfemIJEuR46q5ayf59I5GVKVv/ETK/UvrcwTJnPzSzPTuG/UoSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711110174; x=1711196574; bh=R3BC2Jdu0uZGvghyx3l8jrFbgh4V
	IJ05l18uTDDkOPk=; b=UU+VyN7BhC4/ie5++K8d+g2vdn/zRMIAswWbZ4nLcmNr
	4PfkxKPw1jVtD+K5bu7UDuqqthHvWYFML04xU7iWXQYi9kjCQ4rQQrHQSjJSSrb4
	Eh/cEeScGXOoss/JgreRJfnOKgRDW0OZOOb3oSgvspLi2fqRPuhiEfu/6llCF7x5
	Z2vy2AyRBUeH4zkdOkIHc6UY4cT2ijsHh8YmPAwmVc2yRLPeUCEb7YEf8oxaTkPW
	vZKzjNGMsh8ONvCGXF/XNGfmea0KaotMsIbrKQMAf6U/adpr/1W4TJD8gzl+KGTe
	ShcA0oR33/EVtQKO615tZ2uqm9yqi46BwBbXr7sxvQ==
X-ME-Sender: <xms:HXj9ZbYVIX2N1igC-YBv47B8Wtlf_-n2kC6cAnFQ6XWRKePw3R8JKg>
    <xme:HXj9ZabeVSAGgtfvFP_kxUBBoC2UH_-SspsLnrExpPjVy-xWyZXbxW72ZUsStGq-Y
    HrbXMY4fMgDd4rtyw>
X-ME-Received: <xmr:HXj9Zd9IARcvF7X6MILmAflZALZI-gu5GaHpcpob6T-m4gA2WAVWn0QKJiMjDObsq7KnrlZUVDgaK4Kz4utkwaFNslCR4JD-uUJBc2_rlwXdYq824w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddttddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:HXj9ZRrNe8cnBz4XkqNkUkVSlhLDi0q6lOF-fgm2dFn17zEiXt6ykw>
    <xmx:HXj9ZWp0NwYTqO2AGiOYym3ZU7Jk9iNVhT-LXTCxRRYTrMyjVDwOtg>
    <xmx:HXj9ZXRp0jaK7IFUGNp9FgOjWUx2PqBZWSby_-AY7jVS0E0-nEGFSQ>
    <xmx:HXj9Zeqv4qOF2u4YfzrFlByMX30F2xefVJ74WUx8_7RkVNMAac9XTA>
    <xmx:Hnj9ZbChcYGev1cn-XTA8-NNsPqwT-y4E72zuRpBoXe3LsdURqUaCQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3da4b4f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 22 Mar 2024 12:22:47 +0000 (UTC)
Date: Fri, 22 Mar 2024 13:22:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/7] reftable/record: extract function to decode key lengths
Message-ID: <38666de451348b0306c55b57d22fa55d2365792d.1711109214.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8DbC/bfd6REOECKo"
Content-Disposition: inline
In-Reply-To: <cover.1711109214.git.ps@pks.im>


--8DbC/bfd6REOECKo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to refactor the binary search over restart points so that it
does not need to fully decode the record keys anymore. To do so we will
need to decode the record key lengths, which is non-trivial logic.

Extract the logic to decode these lengths from `refatble_decode_key()`
so that we can reuse it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 34 +++++++++++++++++++++++++---------
 reftable/record.h |  6 ++++++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 23b497adab..5506f3e913 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -159,26 +159,42 @@ int reftable_encode_key(int *restart, struct string_v=
iew dest,
 	return start.len - dest.len;
 }
=20
-int reftable_decode_key(struct strbuf *last_key, uint8_t *extra,
-			struct string_view in)
+int reftable_decode_keylen(struct string_view in,
+			   uint64_t *prefix_len,
+			   uint64_t *suffix_len,
+			   uint8_t *extra)
 {
-	int start_len =3D in.len;
-	uint64_t prefix_len =3D 0;
-	uint64_t suffix_len =3D 0;
+	size_t start_len =3D in.len;
 	int n;
=20
-	n =3D get_var_int(&prefix_len, &in);
+	n =3D get_var_int(prefix_len, &in);
 	if (n < 0)
 		return -1;
 	string_view_consume(&in, n);
=20
-	n =3D get_var_int(&suffix_len, &in);
+	n =3D get_var_int(suffix_len, &in);
 	if (n <=3D 0)
 		return -1;
 	string_view_consume(&in, n);
=20
-	*extra =3D (uint8_t)(suffix_len & 0x7);
-	suffix_len >>=3D 3;
+	*extra =3D (uint8_t)(*suffix_len & 0x7);
+	*suffix_len >>=3D 3;
+
+	return start_len - in.len;
+}
+
+int reftable_decode_key(struct strbuf *last_key, uint8_t *extra,
+			struct string_view in)
+{
+	int start_len =3D in.len;
+	uint64_t prefix_len =3D 0;
+	uint64_t suffix_len =3D 0;
+	int n;
+
+	n =3D reftable_decode_keylen(in, &prefix_len, &suffix_len, extra);
+	if (n < 0)
+		return -1;
+	string_view_consume(&in, n);
=20
 	if (in.len < suffix_len ||
 	    prefix_len > last_key->len)
diff --git a/reftable/record.h b/reftable/record.h
index 826ee1c55c..d778133e6e 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -86,6 +86,12 @@ int reftable_encode_key(int *is_restart, struct string_v=
iew dest,
 			struct strbuf prev_key, struct strbuf key,
 			uint8_t extra);
=20
+/* Decode a record's key lengths. */
+int reftable_decode_keylen(struct string_view in,
+			   uint64_t *prefix_len,
+			   uint64_t *suffix_len,
+			   uint8_t *extra);
+
 /*
  * Decode into `last_key` and `extra` from `in`. `last_key` is expected to
  * contain the decoded key of the preceding record, if any.
--=20
2.44.0


--8DbC/bfd6REOECKo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX9eBoACgkQVbJhu7ck
PpR+DA//e2AN1SgFPx9JxagypFvoT+nHPzkYkZzhuw+S1lz7g3t12ihyynv4i2bT
jHGEsLwYD1+qhoI+j8OwWEBwi0BjFuvR5iW5S7HGpqmlff9rCMElQwpr/bzNifL0
82mSjLlldPz0vCT+o75KSd3Mo2LxjUhXuo7MfN3Z56H8OtJVLXb5iQ3QbEs6yh5D
UBQhW0k02qbP694H+7Yv4LJO3nMSAILovGPVxJUp9oBblIaOnFGuOnwru6kFNsTw
EXzi6+TnLwMeqNBJq4Mr1Il2W9SNGE91fCrP/mMYYPtNCVr8U6Gr07dr6HTEpM20
vDakJquo58sSMzWvayJ7zUCxgBE725WsqyzRuQCVJlP6o28XFbTSo1AZBsKxbaa+
UFOFkaYr+p9a7JD/tD1qLn+28DJuT8UZAMRogwr2MsCOXT+Bq+OkbNwRKGUDB6Tz
Sqe9W6L7fMeh58LaUIuijMCZrhSZz8lsMK8oyxFGXTcuzU9m+RfDtjEW/EdcBOpb
wMM6LUqzPFLThhmJlMzZSVyF7dw2EelImRRtktLJgSSYHyUd0/FshwbZNrOV4cfZ
xI/rV/WAlEA+ucMIBQGLgHG3/8sD4a1fGTm5D2qyQXmE0vDADMiHT6gnwvxxVSIL
SnYXfgAc1yf3iLhcUMW8eDwNMAAMbeti05UnqTLdncvhsten5CM=
=s2Yb
-----END PGP SIGNATURE-----

--8DbC/bfd6REOECKo--
