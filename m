Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4D823B5
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407575; cv=none; b=ZEzR0QbyxxzOx4h61rN5weiGgJMSnV4zSTtFU+PEVOhKSvMlsEzJkdCRq9SZX8M+yh88MQFqJ1vfCtgz37YWpOFYxW5TnQv/yV7za1ThoHNemfYOCKnY7ZzceWpYcTtkhxkXFtEIp+BXeV5N/8pSRSdzdFohrQPCGpwEpqHo1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407575; c=relaxed/simple;
	bh=VS3nTUA1mMQlKZ5WrRk6c7wEvVy1VCXmp7GWhEKiOEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z53BlRvPWAR/qp1QORTgZuf6cGyGbjIRLNSS9vvA3OwhMl0uEUNX+dfoTpe/0bbDmn/ZgpUyo1WeShn27nCr/WAYPCHngYpzlBGx+Zp7UY/u4EQZVDCSC7kJ1llU/LhRT0YRZA+/JHsF0e7lZXgRe+PqSCUuSej96T+h5PLSjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UwMGJETP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TGO24VZD; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UwMGJETP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TGO24VZD"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 35DD1180009D;
	Mon,  3 Jun 2024 05:39:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407572; x=1717493972; bh=uoOmtTRuH9
	nFg3fH90+doVRIeMN8KuN5jHN9nwPMzA4=; b=UwMGJETPZK+13t6I2JaCxQyqcJ
	CInPbBlHrRu5af4nkPf2tYnsgdg++htqiAAAH/3/38pCrv9dgVp5kg+DX7QI2iZd
	3LTVzU33CNK/gGFF3tMD5kDet8Wh+BZgNmqPCvEA42ohV7qTxklrLOG14bqFdteR
	1FiHLWMyniNsUlj+uGzd+zjOT4AMAJqE2sM6bzV5UCjIWR/hSnnKxtbCOaGUnkcX
	gyFJOtJBNz/bM0ITEkgUsqKsrplZKPKkFwOva4Yncauxc6DVb8OpWv30bS0kSJOX
	s1iUjI2hufrDG8QqBqct4t2RrnCppGFzVTpUcej62We+ozUms1VQoqxBvcEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407572; x=1717493972; bh=uoOmtTRuH9nFg3fH90+doVRIeMN8
	KuN5jHN9nwPMzA4=; b=TGO24VZDoU/oOwULTSXL06hdhJ++isT6USXEeHHKhX8n
	buqGzP0KD/za5jUeRiu9xGjrKVIZmqKOLSA9wdqRuw2P2IErJcx31+xqGhyK/Bg3
	58PuUrm38OjFFPpU+gGJU03QWgFVvpbD4KEVjzxofMGILFDqjTjsNqrQy1a4fBH8
	dM8/gadmI8fZLaX6MbGNWjPIaDa4tW/3O69eYuLpoMqvuyzMI/Y+p0EBA36KwH17
	hyAy3Qtltbx+3fyzaShRBRMuG7fRpirpzUFN+7on6IuO47UGxTSBlQvIvmOXGovy
	b2zmSkf6TQ7PsJWjqlUgxBttpOi/zA3hbqeHcmyfWQ==
X-ME-Sender: <xms:VI9dZqd37_W4jtPiTf_2NuWUbfbKV2YvTR1qXhW3445nttlAlkTBBA>
    <xme:VI9dZkMYYEQmD9DmAW6UQMU-gTROTN7AhVVBCbPpppQa21jMmSl6L-RGEinKrEiLO
    awYoN7dLi27LieQUQ>
X-ME-Received: <xmr:VI9dZrje2uFcBRyRSma1u4ECcsbD3NgA51oGRnEs-LgRMBkfPCnOVh54B66tmrUUZAjUT64dmaMSG1moZqnWQEhqBhG5TNGjKdNV6reFSVTQZsM->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:VI9dZn-QzfRJM76K2JTfVi8fYCmsqzF1gwJJg4i3LYCFNzpOmsreZg>
    <xmx:VI9dZmtksH5XmdTb5oPqiWsXC17Y8HpXc6T12S2CGf6YFSXbGFRkMA>
    <xmx:VI9dZuF_3Ugjbvr4lCsW4biStzWHC4C25VSnFkDRYF-o_wzMM82n-A>
    <xmx:VI9dZlMqPXuVXJYGQwCvSzmUn31lPEUjTciech7EhqxhslxB-Y2HAA>
    <xmx:VI9dZqKgJxe1X_L3qhWEmJVAIpPKSD4O9v6abJd1tDo1tr3Et3vXCB3C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 80c4ca3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:39:07 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/27] diff: cast string constant in `fill_textconv()`
Message-ID: <750429472aedd05c33722607d3f8bd7a8c432a8a.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kcgfluui1ZdqfKkO"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--kcgfluui1ZdqfKkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `fill_textconv()` function is responsible for converting an input
file with a textconv driver, which is then passed to the caller. Weirdly
though, the function also handles the case where there is no textconv
driver at all. In that case, it will return either the contents of the
populated filespec, or an empty string if the filespec is invalid.

These two cases have differing memory ownership semantics. When there is
a textconv driver, then the result is an allocated string. Otherwise,
the result is either a string constant or owned by the filespec struct.
All callers are in fact aware of this weirdness and only end up freeing
the output buffer when they had a textconv driver.

Ideally, we'd split up this interface to only perform the conversion via
the textconv driver, and BUG in case the caller didn't provide one. This
would make memory ownership semantics much more straight forward. For
now though, let's simply cast the empty string constant to `char *` to
avoid a warning with `-Wwrite-strings`. This is equivalent to the same
cast that we already have in `fill_mmfile()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index ffd867ef6c..cecda216cf 100644
--- a/diff.c
+++ b/diff.c
@@ -7235,7 +7235,7 @@ size_t fill_textconv(struct repository *r,
=20
 	if (!driver) {
 		if (!DIFF_FILE_VALID(df)) {
-			*outbuf =3D "";
+			*outbuf =3D (char *) "";
 			return 0;
 		}
 		if (diff_populate_filespec(r, df, NULL))
--=20
2.45.1.410.g58bac47f8e.dirty


--kcgfluui1ZdqfKkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj1AACgkQVbJhu7ck
PpSyRg//WGukA7DAgQjvmQlOkJcHIJWHf9AmCNqJjgtA/rGmTQP/CyVRKlvjUuKd
1N6y7ZbVZaThjKSzMXWoP3H4KNLGKZEboRmj4q21HdV9wSXkx0by5FEMU/0VWcBX
Ix3XTuvK5rL3AfK31DdMaBPmjrlsbmrfbErPb9v90u6aOKw5966Qad+m/4MXvHNa
XUqgYBSKZLdoDL0zOnVtpx55+em1NS46/uJKqJ57nvu64HvEYrSEiMNb+Yq4X2Qb
OYb8hBLaE/8UrMCTY1MVl48yBRtdkmYgKpZYJ2sV5gDy8J67IyOR0lPYnrHEzmYj
EvpssxnyDDTewHFwnNrsLbEzn/V9HZWWti59SU8GvttXCgIN/RYlvwPETUXwSFJB
3PtNcw7qIGfAS0A4jXwLPA4kqT6T3P+d1Y+F29aHWGcbRIoGet7xXpHeDtKN/0vz
0tIdB9V9/VmEj4vxOJwK354AcPr6XIsqwD75orabsye0KO9R452CYU4u9yJn1fYJ
R4PEdgBYQ6wqDUFwKp7avPmOqRxUiV5unCUhQXBxUj9Yo4oaATnfNR8PKAAxhrYu
T3yAG7ERj5ptEiidWmnsWWncKjsmrq8xe75zQG3FtKrT4sY27dON8nXEui22AmKP
IEwo5octLwQWTskKgmtKpL3/vW0uHaEjy+LZ2LwDim68IcfAB2o=
=4Iyl
-----END PGP SIGNATURE-----

--kcgfluui1ZdqfKkO--
