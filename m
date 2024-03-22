Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0F66FB0
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711074232; cv=none; b=HHH8uk7XdJCkMyxDwuPk97sdvh2YEFFk7E8bAD51LOvJ2u/bJCEMX+D+OKcYAR1hGrJ0kL0DbK68DyMe3vAr7V+eriYCKm8HYZE6g3TyYW1sX0eawIQvCvunUyPcfmzErp3iCoqjffUnmIsXcsiT05y50xhKxzUW2B+OSaja+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711074232; c=relaxed/simple;
	bh=b5V9RtSIen2zDCxc9O0mFA+vRPXxNvdrvi6JA18W0jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rE1vllmMVWqOAUkkKAqvG1lD5eaecTFM/LVZ6utgE6qbmcJ3zrPvuxSA++ROo9j7++cVlcOqK/fSyQAbFCIY2mPE9d/nPU5FJA+VOUQ1w0iNhDlL1ceTjbbKK8y7fqm303IZyeGPRLUUQlIF2MLmu6iCuSoUf3WipzOVj3dwPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aGdn2a7d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AFJiYZMK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aGdn2a7d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AFJiYZMK"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 820771140118;
	Thu, 21 Mar 2024 22:23:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 21 Mar 2024 22:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711074229; x=1711160629; bh=am7wkuljp0
	POZKuZhapUpF7+smn3UVf+Zqe6mMVOBD0=; b=aGdn2a7dILqMEuffuosuxNrNTc
	vr5o/UWn3m3ZX/BbObYaygcwsBatWp3IhOHCJyOOoRA5ewU1vNfEXOOUivH6qo3C
	66J5VgMydX8TJxGJUbibgopPovbElXqeOyDAL51qFtajmY9yFtdBybHKb7a+nVDu
	b7xREYphoXBXQiVlF1N1Q/ermF5Kl4b7A/q8GVef+hfAbinixT0VXo6Quv9jVTbF
	uWzCKZRq0sn/SnOvPjRU/pVeQHfFpSBKFzwK9v3AVOTkq+3ur+GqOpCUAr/qQ/zF
	qbTC8BAHWqNLWGaTIHJNudT46YQu1mre+WSLUcM/netiWFdhG/VWEWrIv/kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711074229; x=1711160629; bh=am7wkuljp0POZKuZhapUpF7+smn3
	UVf+Zqe6mMVOBD0=; b=AFJiYZMKxlwnyCez8o3TMjSaL/fbAaL7l7oiJb+ZBzhk
	YnRgQQ6r26q0ZP+wjsDByX2Pl534uJE9OBphCk3mjiQboXHgpxrtTzbiKdoW0Vrg
	oAMkQMWnpO4+k8kemTC6WCCyvsIFhHvkCAWgxLq8du3pNDNWbGEuAWPfRT5AGYXl
	BRrYaMkmT4x7WHwyxBGIou2KgOsh8SHiNyQXDJK5g5sdGS7WihiMaZTr3syngEif
	RY1+18+VUZidgedQYlMFDlUYBgi8jMxds6ggu5yOaH7a0fDSfQ8AmL1jL5jnHHMG
	2I196zZW8gJdfeZ1tAGQr3H+p9GEgOtrzIEh+CL2+g==
X-ME-Sender: <xms:tev8ZTaBtGAcDDAap8JK5pKxaqQWOk8ucjmkQz4IKbgb88L6NEWD_w>
    <xme:tev8ZSakr5KZHiMo-SmmjXgKlm8cXsMTiQ9f47ANvgpRS2Vaer5r5b1d-UPr4GBBP
    -YE5fkMAcE4cxeVIw>
X-ME-Received: <xmr:tev8ZV9gq4CjDTXaZAnCOoGpNsn50MpWFklIQ8RjN5PYVWwrCvpOrDPFw7fk7uK70UPrDw1JFuwq9NqZqnQ7r-qtPT1Yngu3N_op5tqqvrMUDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleelgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:tev8ZZrOBEDdqWpnIFhqwkg83uTDrRfMc6vOophBe1EMbVO6-BTplg>
    <xmx:tev8ZeoX5tGm0__OGHQo7OsFy40Z6LycnTyZmjIPtwUCE-kT8VoyMw>
    <xmx:tev8ZfQGE5HP-2D9AjYPFLko9Rz1acCI5DxAiqMKv7epWDJ0BveYnw>
    <xmx:tev8ZWq_5lACin4wjH1BY1ocgh8yLRVX3V4VfI9HvDiP3gYBTWlq-w>
    <xmx:tev8ZXkR5ZOZXM3QkJlu1usMr3ZYDA8ipo0yVh8PqRTYha-KQCIuQw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 22:23:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 614abf82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 Mar 2024 02:23:43 +0000 (UTC)
Date: Fri, 22 Mar 2024 03:23:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] t/README: document how to loop around test cases
Message-ID: <f83b710208c5b6d6bd6904230e5fd96aab0ef42e.1711074118.git.ps@pks.im>
References: <cover.1711028473.git.ps@pks.im>
 <cover.1711074118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CTpFOob6qgISYxg1"
Content-Disposition: inline
In-Reply-To: <cover.1711074118.git.ps@pks.im>


--CTpFOob6qgISYxg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In some cases it makes sense to loop around test cases so that we can
execute the same test with slightly different arguments. There are some
gotchas around quoting here though that are easy to miss and that may
lead to easy-to-miss errors and portability issues.

Document the proper way to do this in "t/README".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/README | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/README b/t/README
index 36463d0742..4422ab9b98 100644
--- a/t/README
+++ b/t/README
@@ -721,6 +721,26 @@ The "do's:"
    Note that we still &&-chain the loop to propagate failures from
    earlier commands.
=20
+ - Repeat tests with slightly different arguments in a loop.
+
+   In some cases it may make sense to re-run the same set of tests with
+   different options or commands to ensure that the command behaves
+   despite the different parameters. This can be achieved by looping
+   around a specific parameter:
+
+	for arg in '' "--foo"
+	do
+		test_expect_success "test command ${arg:-without arguments}" '
+			command $arg
+		'
+	done
+
+   Note that while the test title uses double quotes ("), the test body
+   should continue to use single quotes (') to avoid breakage in case the
+   values contain e.g. quoting characters. The loop variable will be
+   accessible regardless of the single quotes as the test body is passed
+   to `eval`.
+
=20
 And here are the "don'ts:"
=20
--=20
2.44.0


--CTpFOob6qgISYxg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX867EACgkQVbJhu7ck
PpSdSw//XMEl1inApZtnxorX0GjVKYD5tnmRj0rar44sJsc7u8pG7nlwlEfGGm6W
v6sRslGE5P8w3lLc8eU8T6cxkXEJ2UApPXDJv+EH65/y9ofv5zFkAYGCZPK4vNh6
mndPOKD76bxxvoDLd/cLuI8GdDlYSa6rRGWxsJ3ViFjMqXrMwmuWm3B4muh9Sg9e
iNpg67zcngx6wu+T7GfnyLzzL2BWHTI5CX9jEcDkUEoJPnlkN1LBS5eoTOVjQr7b
Fd4FAgzGhOsoEFh3Nl9JfHy8uS9BdrIsL25rkgCGLkD5jE8EkBrowHoaHjT22tz1
qi600nlspRxldJ3HB39ouMoAsN0afLYvE91lpKdGgfc2dTKArbaJtRJJIQsg3PGL
EdF8rgLkSc5V1nmdpE6MBHYlGSRspTVsj+E4ks9as7CjYwCjY8yEDTt+cT5WGZiw
DDTUMzPE0E7Va2wm/rtNVM9o6ISI9BzJFtUw82N/lnBkesV0XTx59MBUHyteXGvo
diF0gzamUmrBr77RWWJZW6Nt6FrByrq3fjazYJJ2oE541RR5e+yIxvn+zZbF2WTP
zBpVun6mHKXbns0PnlU1CZUE2O/ohfd1PClb6xNPmWtqd1sPQHFLHydi6Qlj5fav
NniL+ZHap+Gl2a4vSyIB8P/tLlyX9mWAS3m7byGBUiUyVa5GgKs=
=dnzb
-----END PGP SIGNATURE-----

--CTpFOob6qgISYxg1--
