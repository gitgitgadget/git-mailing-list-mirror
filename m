Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40279DC
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897099; cv=none; b=epRYanE+CaGkrwb548beeHQAEud/nZJkY/4KtFL1sJdjWiGTj2dyXNZ3gqOaT1EnFoL9ebN1CTco8+mTT9xjIRi0FiGRoQvUiSXDpU7urZi3cJwK7N9isbzV/OnoTyW3Kfp4O9troG3py0Iz7dBCqZao28ndkoGndClYksr6gMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897099; c=relaxed/simple;
	bh=NabVWjCW093tNGt84x85NEyBYtHlDAkiJEk56F5IRzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4e5yejNRrSBrw+l8R/pY8bVWQn9SI/xf+EYSssuMl5fteApLbHMwVdNK6Ptv5cB0Dx1jjemuaNopd55YBUMSkEyeHxp2guImN0omLTSY7YjQpVuXsk6KHyMGBH9ut318ufXSxrXI/hP1DqoMyGZAKt0cdAWNpOMw87IO+ZP+I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qfp/iGb0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z0wvOahU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qfp/iGb0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z0wvOahU"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id CBB0413802C9;
	Fri, 12 Apr 2024 00:44:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 12 Apr 2024 00:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897096; x=1712983496; bh=WgPu7k6hps
	5GanXDBZLr+JJaZ6JBzHbeq9bPCLRt/Io=; b=qfp/iGb0B8zzuhJXqecWU08mxe
	oDW9klzyF3AKQyRFyeHZLkuIQLApWGEnHd+T/5+OwUPsQjrdjMgMq60oYOrR637y
	WtTDDWJOU88ZRRThvx1ZROKdHO9bFuWtmN7l/ARmHgu96nQo1dLcPJ6qtg5YV5KZ
	wH8AEyE5+okWJI8m7YJSLvkTcT5w9pDx9HAXxqsaCFskY03fhVkrGMBE7+SRac7Q
	reg6TC5/Ljh/PLMqKtl8w+6fybDbENWZ0tJ59TSLAJYMeScqk2ZQgUaqlMca8Txv
	MGaZryvZUzrMdQ79xgMZemWOrFTIyck05SwniDOqVWg1NeHPVqkAKRaIGKFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897096; x=1712983496; bh=WgPu7k6hps5GanXDBZLr+JJaZ6JB
	zHbeq9bPCLRt/Io=; b=Z0wvOahUE7dH22b0pBxNQWMyZAJxPii0vh1KhadjphIS
	UcZgk+CIqVq+yg1swcpn4ap+Qt5wst8jiP98J1WRN3RqTjuDoto7a+lkUwAFMLm5
	NqLJE8GnLU505u7rXq8xhxm2vHjmYpvJy4cOgqXQxQ/V9mPPyuMqeQGDN3IvG7sI
	ZpPHhHe26BffYROZInMFs8emqEWhRpyWqldwR5ARJeOyFjgwNdBAAx8HEQ9tkZ7m
	5X0QpuBROOXalKZYsXf7UUBbEBP8K2H9hTPdebQmxUYbSOgfQttek3DEDmh4Ot0C
	XY8ONlhIkMyFj8q5bBp3hSrlxpKeM++0nL6dYeSCmA==
X-ME-Sender: <xms:SLwYZnzlbw0LFIc41OI0jpmo2cdqph6AZb7FMHjPTkf3KMI1vzZsUg>
    <xme:SLwYZvQ5GJ8HlAUbWr6t9p8NPPyeQEmknDYyBlIWyUc4LH-0R75DQ46vk89mIUwlI
    0bDRUyo6AVWtCTWqQ>
X-ME-Received: <xmr:SLwYZhU9sn1SM0anvCm8s3bQUBmauowumxJcxY0QYY2p695_GFsdA1ukev5G-4k96yvKJQrUM96JvvMo4XZKv9ugZMonuKPbXPTmsay7yOszlNwRxSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:SLwYZhhMBHJ_QHHB7rAr5qGItzMRhZbddymbi5GTE6Hi5w-jFPN5lA>
    <xmx:SLwYZpC6lZpVSxn4tzpHDFFFlem_b3hnqzJySE5EHRDeGChs-mQidg>
    <xmx:SLwYZqJrBLUAm7luJF3flbJeT9fqOVquy3ZJN_BfEp87H0U8bxXKhw>
    <xmx:SLwYZoDxijMpx8coLPQo2z_BfNuYeb2l9oDb708UMsflLrTpc6w8Zg>
    <xmx:SLwYZjAplEqhlHkR4tSqwxsc1UltsPz7jRZaGvsurgVAC1cYxxV9K2Ea>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:44:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f5ecadd9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:44:42 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:44:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 12/13] t0610: fix non-portable variable assignment
Message-ID: <a9b71e8eeabee42378312c860c7af49aee641491.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+2ElJG9+CaOSTdFV"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--+2ElJG9+CaOSTdFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Older versions of the Dash shell fail to parse `local var=3Dval`
assignments in some cases when `val` is unquoted. Such failures can be
observed e.g. with Ubuntu 20.04 and older, which has a Dash version that
still has this bug.

Such an assignment has been introduced in t0610. The issue wasn't
detected for a while because this test used to only run when the
GIT_TEST_DEFAULT_REF_FORMAT environment variable was set to "reftable".
We have dropped that requirement now though, meaning that it runs
unconditionally, including on jobs which use such older versions of
Ubuntu.

We have worked around such issues in the past, e.g. in ebee5580ca
(parallel-checkout: avoid dash local bug in tests, 2021-06-06), by
quoting the `val` side. Apply the same fix to t0610.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0610-reftable-basics.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index fd0ddb96ae..b6e67724ce 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -78,9 +78,9 @@ test_expect_success 'init: reinitializing reftable with f=
iles backend fails' '
 '
=20
 test_expect_perms () {
-	local perms=3D"$1"
-	local file=3D"$2"
-	local actual=3D$(ls -l "$file") &&
+	local perms=3D"$1" &&
+	local file=3D"$2" &&
+	local actual=3D"$(ls -l "$file")" &&
=20
 	case "$actual" in
 	$perms*)
--=20
2.44.GIT


--+2ElJG9+CaOSTdFV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvEQACgkQVbJhu7ck
PpQW8xAAhHqze9v7U6e1cmxcsc5FOQc3cwdh3GlUFpa2kOwSX9Law9U10Z7gVYjo
k1MNp7nBqtMd2t9kmvGcDMkurbw5wEWnV2l/KV1v0sfITTJxuk7n6uHxiJpO9b0P
LtrKmXPdCLXN6oVYXtwSJYjZmmCQleornSgc8j7NCU6vxtwLZaadj+dW6avPxiaY
j4pGCBHiB6a29A/SJSLAUrCtKCKdCXZIvxDE2wGFiqaMHwpm93DwgZUxD4XPCYTM
hYTGLM9YDLxH3+Q9dosyMugT2Q1uqruvoD40sPlcbwPOz+42XG+S0BdIM0gNlVob
afJlWWda5TCPEwG1tE2GMAyyqFsx4hDVT3TT9wxjL7rr2PkSQkwocRBWm34EQMoh
Ye3QCpCG4qUUwT53mwCLvEvx7oAfaWj0kzYoTA/td7IgHX6u/IBxOUbWBzRRheyX
rJKz/bJMGOuFesvJIE7S7FWS9X4nS+jh78E0nIrro4M6z4pAvlV8Sm4xWNyATDw5
Q7jMKctoQ2IQmaimk6cdR+fcEpxPlEeXwiskJO3Il7cz/BeUJ1prcUsFFpP5hNfP
D7IXNDMOHhcrtaqJZZ09nnydGqFtSe+DCsjIDRDFzs7NK+6arrUwYCvyzBF8gMxU
aqGKpJRQrXs3kGfyq4kyIXvjzBtHSBLH8RaWCzZG6CgC0S+BWQ4=
=rHZP
-----END PGP SIGNATURE-----

--+2ElJG9+CaOSTdFV--
