Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DEE18629C
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324299; cv=none; b=Y4XYUY7KCAHALrhcgsbCTtg9s2M1F83JlSW8KMnVVDdTt7e4uE0VVmPWKgyl+XaixZGjbVaiLStgpc18wUQUHKn/YnPg6OuH0MgnLUybFAxM9J0C82nl0IfYlmTrVio5G+S24+gQbCNigrXUBgh6kAM1aCIeDqBcQmsS4NUEmB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324299; c=relaxed/simple;
	bh=tPGQT7LKOAWg0azvSP33SVBEEeFyLUdBL5/yzm+7PjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP88sTDzUWXDX2K2jfRDRha3bOOMJJjZSP6/DSzc2kz9pRopkUOqbtP9K0+S56nIlENwfh7Uk8gtn0ZHJ1MSK2Wkogg1uysC0F6EdQlzsy6pOZBfUdtvw0UjYVvw41rajVY7fVRZUoRx22LGxOvwjf0E5wYs9b0FNKUO5WbCIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cdwjmP8k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HpDIqT+1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cdwjmP8k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpDIqT+1"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id A1D3113807C3;
	Tue, 30 Jul 2024 03:24:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2024 03:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722324296; x=1722410696; bh=8c5ENsvlJ9
	Q6luQQWn2Prawu9Nfn6IwX/TW4b5XePWk=; b=cdwjmP8kv4dCzZUXoffKR6n3ru
	VPDeACSvuX8qylEIw5zGEsvkKqPd3Fbpaf37SY3iZvr6ZH9+miLsaHx6xncMnC3o
	ZvRK6joJQ/uYgr9AAaknc6Coc4htJGm25BQfZMqvrrjR55xv8JqoqFI76KcUCeYi
	mYUdZ3Vjxz5TdrFsDpnfrosgDkLHc4/sG39pk7wXJuYVUhzaFanx0FYo5Kg7HyMi
	JO8s2V0FPbOzJ2urFU/2IlJudkx414eHC1mG1It1pTeE4sUXx6exaX6510Jd3AeU
	vPhAXoswjE/lViTCTdTVH1s0+0GKLAQPgP5Dl/5cu28ewSmknN8F1eEMme7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722324296; x=1722410696; bh=8c5ENsvlJ9Q6luQQWn2Prawu9Nfn
	6IwX/TW4b5XePWk=; b=HpDIqT+1yeDzjwtndCJmb6G0NThmYJ1woS83na9CZ6zL
	4xMoIskJhn6y+Fdozl+V2oYpCDqNiZw+sz3H6aszBKP+H5yL4OFgkgeUMscFxk/D
	D00GT1MfiFrMdPlCpDpb4P1beF0tM99EdnnLRAk7dNezJXOrxcBdHX8ME7sg2yx+
	R5t75WfoELvdR7ACf7M0ZZylDi6n08T6JYYB9wmpSLLpW2Z2ojhLogSD2dcB32a6
	+rAnltrijwOHyprnd6gamzY5n5v17Tfr5JC69kjFvCHouKH8x4M8yCCA37cfJTJC
	ZdgWWOtXcXXw9mcSutD+Ph7JJTTIgxUIEr/XLSA1qg==
X-ME-Sender: <xms:SJWoZt5rsmOE5oUAXa153b7z3-0wuN1OHtRS2ixoF4vrdslRw6oAtQ>
    <xme:SJWoZq59f_zRODzFhTx_wGgwBygSTP-L3jib7DWj75ZOiY25S-6W02ChkVac0EtPM
    muRjAT7Sa-0h3nUuw>
X-ME-Received: <xmr:SJWoZkcv-8TZzXxTfV1ilOGSxW5sQbe_DL-s2R0V2d3NeJYmzEVxdBagueLKRvBEzmTnbp-pyZ9E9JQwOZi-arGmfzMAjDt_f3U0q0H_idbS1cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:SJWoZmJXxPdq5FA0Gdcdc1WEnyMaCtQd_P_ewULfYBdHY44dmc5q1Q>
    <xmx:SJWoZhIFt6vRtfsdyrO0N832vyt4V5MqMk9gNyFTNDHkVHc9a765Zg>
    <xmx:SJWoZvzw-VRlpYJ93nwmziyQ0b3vRke4uJoFlip4QriRdqu-l1okfA>
    <xmx:SJWoZtKU298Pk_ojI9jj1uky7-TIQdx0-EEeXyyYRFVg_NUk1z9tIA>
    <xmx:SJWoZuErCIIEWQYXrC5u-5vPePaWLjfDo9EWG3iF7dVn_dLj0MVK-vuR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 03:24:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d269a42c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 07:23:27 +0000 (UTC)
Date: Tue, 30 Jul 2024 09:24:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 5/5] Documentation: consistently use spaces inside
 initializers
Message-ID: <8789323ac770e00707df4708994f7767bf57b00f.1722323818.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im>
 <cover.1722323818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DpdIra6J9dEphAbp"
Content-Disposition: inline
In-Reply-To: <cover.1722323818.git.ps@pks.im>


--DpdIra6J9dEphAbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our coding guide is inconsistent with how it uses spaces inside of
initializers (`struct foo bar =3D { something }`). While we mostly carry
the space between open and closing braces and the initialized members,
in one case we don't.

Fix this one instance such that we consistently carry the space. This is
also consistent with how clang-format formats such initializers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/CodingGuidelines | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index b63a8f9a44..3daa1f82bb 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -244,7 +244,7 @@ For C programs:
    . since around 2007 with 2b6854c863a, we have been using
      initializer elements which are not computable at load time. E.g.:
=20
-	const char *args[] =3D {"constant", variable, NULL};
+	const char *args[] =3D { "constant", variable, NULL };
=20
    . since early 2012 with e1327023ea, we have been using an enum
      definition whose last element is followed by a comma.  This, like
--=20
2.46.0.dirty


--DpdIra6J9dEphAbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaolUMACgkQVbJhu7ck
PpTQ4g/+IJTOY5omV9MwtYHiizGW/5fY7aaLeWS+SHN7AN8O8KEFlUcGg+NEy/Tc
EPVjRXux7ORoRiC4nJ+U0G04PZ9xQAzkaqkj3BUqQ6Jr3d+EOQ3+2XmLIejj+jgB
QC3t0bogrqb+sMl4A8p16YsEvC+5N8k+yPodN6pzgAg/28CCUNDp29j5TWvSqhW1
xzV/qlH+UgjKquCLWjN9fPtNzuosikRhUgTl7g5qtn+JMz/4xwJ83oX3onYv/haD
o0OAft0lAK0MXnpRjs9rQ/uBwGSF/MqXvhrGbwPz5cMXQ17nIgzoPdyzSQ5so7cF
9A6pP7oHE4UMCktuQTZxFxQdYKQDPSB7OVRboS6NjQvtalDkZOtwgB/dhAYw8W+s
ZQOLXSpJH6XYoJMCzuQJizG2mJw/nqGSdErAPjCOGeNZi55SfSfR4cn6ARS+k+yi
fD6SYDKtcjumZl2Vlo+6GgtwHZgFpBSiSUj6hJnBnLeR2uc5QcAWcHwQPHpompw7
ljStNepx8tLZQhTC4SuJFNJGS/urZKr47gbpUWWlwL5lG0Qu+BMXCvTKpZiha4si
n1dTINQhh+Nc6LfzxusuR90Gf6YOfuliJuN4r08Y7i1XcwwuvU3GhBuhYd0vlYsh
JLAmnBwGRQMvespo3A+2Y1Ed6Lm/sJxE+MR43NLRhZy4/JeGwkQ=
=l6dW
-----END PGP SIGNATURE-----

--DpdIra6J9dEphAbp--
