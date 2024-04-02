Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931615A490
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078707; cv=none; b=ugbON9Sv3h63MTVzqufj7fATBKeql6AFOvnNeNONPnyIJq1tpPChzv0Q16D0imtbW7pHqVxyMRWmO4V8Dq/EJbYN95d368aWnPycUGEkb8dKk7dDyemKJ++BPUjTYIDq4u2UGlpoxw3l/u10voW6IBo4owz2CRw9mV6o3QPmC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078707; c=relaxed/simple;
	bh=LmNFZ3PZCR+5LJJS/esdb890aP5IYavm2vBpUMQH2Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0WTFscGKMPMDcgjEd359g+FJDQEcq7YaMcSXhJeE6i8I0BMCeUcZXOauMBFMS2j9qNdP3pyYtklUPKvBRy0GCDVYjhfzQC/bFjEN80k+yoals5x+CfTuc84kF8WNje1KyDAffUSV255I1g9mJdt5U2ZGctP/wXLesZgScNssmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LTQMVGSx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TqNjIKjK; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LTQMVGSx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TqNjIKjK"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 1F6E81C000C1;
	Tue,  2 Apr 2024 13:25:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 02 Apr 2024 13:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078704; x=1712165104; bh=Rs53Dc6qX5
	t1TqKa1D4KWsI0X6rRwidagARDSD3qn3o=; b=LTQMVGSxonvJWjbz0uxgdmjzme
	XiJtdM5pEf7hoBvkLR9KOq/hDgkYXcGLhdbYgdJtPJZiEyzepi5dc7vFmATRB5kU
	z14mXxlYUkT4H4iHhAH0p6teOiIPV+makY0lEBcJDVuHIbdGImcxRDeEl59QMBuy
	SEqjDjTu6flR8Sn2Q//V2JjkJOGE8WWIXlp9uF6PQDQjvqc9rSVVpdsuNGm4Ellz
	z/gXeuM/w8ekfqX6KCAmWhFAbn0FvNb+2AzIyQ0LyQIpmtThbdYocYaHc5Oqw0fQ
	PpIxrV2b7+u2IaIbUvCGT+DE/RyxYgMtuAo9msoepnWu8u2wU4i5MCE+pSyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078704; x=1712165104; bh=Rs53Dc6qX5t1TqKa1D4KWsI0X6rR
	widagARDSD3qn3o=; b=TqNjIKjK6CZo8XeK2psUDYUi+vfNGFW7kw7Q3KsALT7R
	kg0GLaegSM8KlIxjpTg6JVqwWRgLq2UCw/SxigrJVC9mkcKqyMAEaN9Pzve6gT8H
	ilrJLaQ7pxXTfSnQiKiRXjO1PQAMTeDwb1eZMzdR/tBn04VPDDCJwf+Mj8oNfDk+
	0hs6VSb1ONfuFtjSgVPZ0pmJzaeSUGjG6vLNpnawj3PN2iM5yIY75Cv/GqNp2nfB
	TYue5GIzmC3IN5tdOTmkPUUVMcoRnmfTHUqbnBvEA5e08NvErUrGkPQEcUsT86nG
	mCr1OB0HvIbS9IWj7N1XZtuSuEhiGeUyAxgotbyGhw==
X-ME-Sender: <xms:cD8MZvmR8wT5gd_Ozs_dX4aKAdkqGK2fX_v4OoKMNMZQN1GL4Wdmgw>
    <xme:cD8MZi35XLgP03wfBpBT1iPIC9CK9TxpdqyFzGxNMUc8i0lrwt5IATGz2lGGYI3ey
    dLYv8M-XGSrZupc6w>
X-ME-Received: <xmr:cD8MZlreULqQI2swGLOlvkUe7k9ev-qX9Z1J9G9kfHvPYyvgvHKQ_NTqF01oXGcTKBzabmdmYj3Auwh1x4IQof79CTSXU702UNA9aPndKwtxMQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:cD8MZnn0DkiUlX-i9wVN3tb-bYFGXq-wv9ywU9WQs2G-iOXSgUDmUQ>
    <xmx:cD8MZt2R0qcgl1IPUG2MNwjoU8dB5Wau51MSL6l8yiL9QzORQZKN_A>
    <xmx:cD8MZmtFV0LCzA4IpQBZzLI_e7rHA9C_O9tkl2iPTsAbSrCUWe0prw>
    <xmx:cD8MZhVCyOLzqjsZJ9gi4N0L9enxfHnv_3r4djYYZS98zBc7B4H34A>
    <xmx:cD8MZmzNfCRdkiNjdbR_zw2neYKa9wYaJw2aeEuTsilJdDmu-PNhFStg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 13:25:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ee72962 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 17:24:54 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:25:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 6/7] reftable/record: extract function to decode key
 lengths
Message-ID: <f87f7ad01a5789b77a695c6e4e246dcb2b740000.1712078263.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712078263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="udQuBSUk35Lx8jqw"
Content-Disposition: inline
In-Reply-To: <cover.1712078263.git.ps@pks.im>


--udQuBSUk35Lx8jqw
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
2.44.GIT


--udQuBSUk35Lx8jqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMP2wACgkQVbJhu7ck
PpST8g//U+r/BusCGSW0WJndPR9oh4kfrkZkkzf55Ouh/edlMHvqHv0+gz0tQDym
I0TH64jtu+dVnBwgH0zd3mx9SW1q90zloR/AItShT+sIdKMtEnS8gsdqj1p/K53M
niH4WLwZVCZ/F4CO/P/YkdVXLtAlpRzCIGCNzB+QxWKOevQ7Htvw5bgMGAii898h
kokDOApQe0Cv30F8g7Mgml9z8DfG0Q8jAIRjbiahB79q/g4q3a+zqMSJoCNHDTIu
Dx/mIN7uEbT9w05rzZSsNgAXxZcGphJXa9YyvbIy2tZ+ViRdQ7YG/K7sro/xc+f+
mOpA7ouC11tljXwjnf8uf+NmS7TKrgy3Wq7EXtB5ddEEcaaRM+Gie1BwbcsbLEvd
Hn/QyZPy7j8ogSx/atYHUNl8jPabVhtLbwJSD5Y4zsD9hwJyJR3jeM0KqOl1V9tO
GEpszGaaPhIzsAIYTrqVgqeXbkiY0+vwpwbfp2BIiPD5+i0T6urtbpC0t42R4kIv
YcF/lDl+LbtQnqo+i/iZMrN9rEdRj1PYOw0IYdMduSVeo9L20E6codkVXI7axSA/
D3Y3+yvLZRhrjKxIK8YMDkKtnxIpo4ry5K8g2zqayb9clYnqQ0HRgYaKJ7hlRhtm
UcyjB5t+v4nKEQ41okZn7xX50fdQMMmfG3o+FmJnEBNIPqD+cvQ=
=0DNZ
-----END PGP SIGNATURE-----

--udQuBSUk35Lx8jqw--
