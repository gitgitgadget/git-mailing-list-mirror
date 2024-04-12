Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3761C2B3
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897049; cv=none; b=X0R3ZH3v1Cs1DIpLDU4QQ6adOVcEY6k2cwXIbF3mfsx3L/7hwJ+NnnCvpeoLZSO6aJeX5z13IM5+Y90u7+7anMXhzgonx5nO7N9JmG9lM02rYwUuZZgYjMkO6tYc0ss2OM4xlvxi+4umJtPVx3lp3j7AhLuR8HltFeu0Q9c6mAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897049; c=relaxed/simple;
	bh=HjiV6nbLoBvFdEXnMaFm8/Z7Zsx9cLEr2PFXf2GGOC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFS3+NTKmri1VFe3sJI1Qtf0x7ZFCXkmmFUPH4FXwBjfXKDzsoqxP7cK4j/jEYOL3mXtgj6WOXiSd0XE9xtZWocltfvFsnxOPJiS5gWyC34hjEtIQFjBETF/lTQqPelIXPotQCJMYNjUnCTXZMxLR+rMv/guoAR1CbU0tYot3us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LFH4CxTf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFNViOlq; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LFH4CxTf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFNViOlq"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7A71813802F7;
	Fri, 12 Apr 2024 00:44:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 12 Apr 2024 00:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897046; x=1712983446; bh=3iiJbImMl6
	qe07299cG5yYdsDcYU6AQFCKtMofwCUWg=; b=LFH4CxTfBACtRLlu6ZGkMDlDCa
	+V74tw4VJXcu/eqnALPahb1KK7Z2zoiOWbe0OQ6J+CF5WyoGwTBIqtBvHeyTOA64
	2z/fUDsSaOO8l1n07/RulDiFmFbOucfOyDtAfdqkPZFacMm/dk2BQrn3M94kJzNS
	Tkoom5HN/CQj/JCWzSV+VMkN7ONyJrfkwSoUt3ba09yt5dx/jMru4YPumjrwOSEv
	xuP9niumKIZtUxyi0mMF5vRbUqly7gV3z5WX7i/kn3kkGwQP8x22ZWk9H3bpOe8B
	yCxEQ4AMzBnfo/ASz0WSDbqnj6GGthknnd2zJyvUrITxKSiXTCu/+kmyu9Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897046; x=1712983446; bh=3iiJbImMl6qe07299cG5yYdsDcYU
	6AQFCKtMofwCUWg=; b=DFNViOlqbUQQyKkllgGp+6Bia/xdpI9Q/jxHSQpo2Yr2
	OY6osGuzYlQnEJJWj5nFNkvK5I56nW7mJnorfn4zVPztuKjScNHZnxCtfz982Cl4
	p4xoJjM4mri8OPDwdqwX+VyKyIoFJRkTUb1A2fu7sNi6ZCCdFgYra6SlKi3QqOCj
	DZ4wJHA3xSWVEAwm6F+rnOir8I84RYm64qejxsD2JMIkuK8cjF+kgXG6Vft5wAF2
	L5vy1y0taJ6zmcByyZSgvyZvwyfwfJc/1DIGZ4uDQ0YhceA3/V17FwgLTJm5k/4a
	P1kgKk6P3a4Y5ErKvgyARarDRHZChdY/DSO7uii2rA==
X-ME-Sender: <xms:FrwYZn0dC1fUOlQ73TEkJhkLVO6MtSz5sHriTPWTFtbxyxP5w1MRNA>
    <xme:FrwYZmH4a-kyAjqaik7RJE61kwCjf9kjATM3qFOXuvGk-dXpvPnam8AzZvRpXA2fv
    JD9AXkp9E9uQ45GRA>
X-ME-Received: <xmr:FrwYZn4_7HK3kOM3IKhX_B_OhIFRS11UJY0fylbTZ5IbcFOMaibTivC9ClYgKtpDyPcfEepleUjgQt7d577dk7eDT_3AsamP5lXYN8UraIHj2F-p5vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:FrwYZs2orUDw2sTSGCBuVSettuKH5RRaPu2loscqyRJUTY51UDsvOA>
    <xmx:FrwYZqHR2C6bFrZ7L-59YsK8Cy7cRaF-vh6nDOeo39O5S2mc8Kurvg>
    <xmx:FrwYZt-D-h0_l2HSP_UiixfmIfdV8QdPudndzaUhsU_5t-EF8FmTqA>
    <xmx:FrwYZnkRVjyc85mXXpxgaEa7C1BdGmF5GXgmOBTNjHGlxz_6bvpojQ>
    <xmx:FrwYZt1cuPpZ2Gio7OzkXWU1Be5qHroy0H4C-6rmrcbh8Ci-pFDQh5To>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:44:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2090888f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:43:51 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:44:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 02/13] ci: expose distro name in dockerized GitHub jobs
Message-ID: <e1d4e1320d8834de3c37e3c0e9a6e4682aa79a0b.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lv/g1EE+tNb0lyn1"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--lv/g1EE+tNb0lyn1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Expose a distro name in dockerized jobs. This will be used in a
subsequent commit where we merge the installation scripts for dockerized
and non-dockerized jobs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 684ef5c00d..71cd4e5486 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -342,12 +342,16 @@ jobs:
         vector:
         - jobname: linux-musl
           image: alpine
+          distro: alpine-latest
         - jobname: linux32
           image: daald/ubuntu32:xenial
+          distro: ubuntu32-16.04
         - jobname: pedantic
           image: fedora
+          distro: fedora-latest
     env:
       jobname: ${{matrix.vector.jobname}}
+      distro: ${{matrix.vector.distro}}
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
--=20
2.44.GIT


--lv/g1EE+tNb0lyn1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvBEACgkQVbJhu7ck
PpQo+xAAqQ0AibGpKArHWiPZ6jZWegWEauXdOkbBVcGu+OPfNE68W1zZ3m9mwX6V
WfnO5lkfqBQXy/P+ZrfHOoOResw5pvMydCyyIQmTGJTP0Vc4yoV9216rOZUKCUm/
fHbeRKMm+X9KgiRycHA3qm4jZ6AiqeLtpUNXl347QSGe5eULczbZqtuzWPS2zCHh
KbnLW7mJryTp6NFDRan+rVqN/g6yZ8WtjcFrRU0fYhL9+Jr1kF8feKbhORn1FyIL
NkD7wAhw/8Y3boMJ8SKvwJ7k5ntjqxELa1GA9jcbkciw7RhSBdpyn+qpFxUssHRy
EdnLIJtaEoEjzc7HIvIK8P794lwvtFtZzOsiIt2wKNrgxMcTAZ+fCsh0rn+N9GbC
yg+jrGOALLKIXCWW/hpiFqi5+SZCix3voqhL0jJSoAq0mxTh91qg70uNXhh0o+ep
pJxl9Sw0yGQ8gwvlfqHuvP+2MHrSLZxJTpCEXGyBRXI4z0um+wIa4zUg0/YRKCkR
hE4pmG+1XMs9Q+PTZ/JoeCfj4+dKeCORIDzoriN0vlpJjtBn2wBhgy3f2JMn/ce6
ug0Ceama2rWDaNajHGeA1I3889zUu5ePed1Ufexqln0dumNeSaJemlKYo/elNeL/
jVXQ3OMGZbdqxTTjoMdX/LeIUhMn/gNUCd1Tov1lwNtdqSnBGCI=
=LqhT
-----END PGP SIGNATURE-----

--lv/g1EE+tNb0lyn1--
