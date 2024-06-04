Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5D145358
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504749; cv=none; b=hhLgN/HHwBibm8K0Mdj0tPp83s1oG/r6Z4D44Ves5V2BBnBr9nOwkosb91IAITAdfGihx2HeNIffX0aT471nWOeI4EOXSrCeCrtPBrvwS2Ay3Tl4Vl/VJIcCUXGpkdfFBV7B9ksTooBuQy7MLFlmsMdxMEx+GEUjeqjcNX5gAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504749; c=relaxed/simple;
	bh=DaTnLjg6WPGMI59HzTFP72dFXL0KfCHe4qR4gEEDmgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flXGlkNR7jCDm2mzr/GbMN5HGuswyE0d7k3UMMXQ7DbORQWEm5yxeqzGMZuvi7p1LNErEIO0MmThYuFFVjjs119Qr4cZSFQWeX6XgJDQHwRina4ogj/pgYFcNsJPtxU5BWz8tNPrmVqLGOFMGsTdZTuth4w/VaJLEZY2CD1mBPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JgRSdx3O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UU3tXrCJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JgRSdx3O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UU3tXrCJ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A8CA8114014B;
	Tue,  4 Jun 2024 08:39:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 08:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504747; x=1717591147; bh=DaTnLjg6WP
	GMI59HzTFP72dFXL0KfCHe4qR4gEEDmgs=; b=JgRSdx3OfmLd0XnhnqOaBhGpcI
	ftqSsUOLVDa5uh2fTtTLwrSQOyA4YxR4rsUIdBM0pW4ZP3uzdTFeiOXcWdyyoXVm
	kZEfAktXDqwWb+kICMYGUuSIi1K+pUOqJPwstZrVZ0obxHrZhk9N8JZiq9tEQq8q
	w3vTM6pIiLwKJ9qPOrcixmTVoPFZeHp/xfbO3U1D6MCVDeg5R7bOI8NPvLd2Bt0X
	9vkZ49cIhJHmceAu2fluDV1J9aSga5bjY7HzainWrGlx0gf10f+Xndnl8wQh7J9x
	ARqI+Oi7hG2hn4Wn8TAxqQbYs861Z8PaBGR31f6/XTNsL8V4B8NugdOVp2oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504747; x=1717591147; bh=DaTnLjg6WPGMI59HzTFP72dFXL0K
	fCHe4qR4gEEDmgs=; b=UU3tXrCJlDFiHwA60yqFCHqoOMxPoZzzchZT1MmE6dej
	IjJjiiJ9Hy7Fd2qB0vhk3DeYqyVLWcjyYIoaM2HieTU22Q1pthXDvrR9GYb1mCq1
	ukbXRp/sRCibCVm0c7/rKAdfLbXrsoy5SP8qCj2wXpEUOUBQOGoguAZPCwfHx+xl
	xqPcfj0rzxTtZGFV2VKGlP2Wozq0+gvYyY59ScJemJaJRmgPG3wTUthEA9yU6XoM
	xDEY1t55tX72QsjEFVKKLTg2MuKkaRPVOqPzhe3u4TixfPPk7d6pYd6mpGorT0qV
	5tFZhfDY1uLwtJZjp8xn98Gfsrv4d62kwcKpvo4Syg==
X-ME-Sender: <xms:6wpfZnmzznUHjCm2NonmUIFiJHHEN0SQSGFP4baWNE-KAtFH358nLA>
    <xme:6wpfZq08w4fZsGFhhuJMs2jsgaBPO-_R6WB7nJ_bxnVX8uffwS2RhV4I4rFwb0qwe
    9c6Cb637kkMmcVYQA>
X-ME-Received: <xmr:6wpfZtqbgCNS1fUGQdrJKTm3JrWmEFqUZ9vdY_y_0-g0rf6g-lOFO_BlSg8Dkf5LM4q_Npfuh3UOQWAapNnTp-oMEp3vpiiA3TK3Ff1ZkLaiztT_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdekfeegieeiudfgvdegfeffgfdtheegfeeiteffkeelteegffdvhfevjedujedt
    necuffhomhgrihhnpehmrghkrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6wpfZvmjo6fYhbzf6p9HiU-hUdoLlrjXW_hIXOkfQQqiu7r8gHiMKg>
    <xmx:6wpfZl1Lzrndf_V6RCRFFTjwkyQYNPJdldLDNNmjZT8ik_gUl69HJg>
    <xmx:6wpfZutALhXz1WZEHqh39wVoOWHdVZDulYki8rH-dyzBSFu0smDbjQ>
    <xmx:6wpfZpVXRqi2l4zjAarJjEjtj3gRt7jTupp-GhCS6fKOJau1CuBZSw>
    <xmx:6wpfZgRk8enikpfCVM18sshMxaIHtY_fj7a2OeruGEHfrTi7iy-ikS6e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:39:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6a313bf1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:38:39 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:39:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 27/27] config.mak.dev: enable `-Wwrite-strings` warning
Message-ID: <0cd4ce07d8329829c5b914e2d78761ea32b25e6c.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4x4k9MYhZ0jOLQSf"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--4x4k9MYhZ0jOLQSf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Writing to string constants is undefined behaviour and must be avoided
in C. Even so, the compiler does not help us with this by default
because those constants are not in fact marked as `const`. This makes it
rather easy to accidentally assign a constant to a non-const variable or
field and then later on try to either free it or write to it.

Enable `-Wwrite-strings` to catch such mistakes. With this warning
enabled, the type of string constants is changed to `const char[]` and
will thus cause compiler warnings when being assigned to non-const
fields and variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.mak.dev | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.dev b/config.mak.dev
index 981304727c..1ce4c70613 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -37,6 +37,7 @@ DEVELOPER_CFLAGS +=3D -Wpointer-arith
 DEVELOPER_CFLAGS +=3D -Wstrict-prototypes
 DEVELOPER_CFLAGS +=3D -Wunused
 DEVELOPER_CFLAGS +=3D -Wvla
+DEVELOPER_CFLAGS +=3D -Wwrite-strings
 DEVELOPER_CFLAGS +=3D -fno-common
=20
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
--=20
2.45.1.410.g58bac47f8e.dirty


--4x4k9MYhZ0jOLQSf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCucACgkQVbJhu7ck
PpTd7w//S5HrNyR72xLhxcW7ztwooBWRVPR0oeA+vEC/pjTZVB2h0dEQnlNZFwwy
fXBvENCSfmn3Mzs55v+VIwLYUtjjJl+CoP6yDYooPXtzw99N7zOI/tNoVn+5+jJc
hsj55Uhm+3uQllq1E2W2e84cXjU8Dul9aMEYuenX9S+GAsRHR2CwjjXHnhChG1d7
7UDPZG5ctNIFvinkV5t0JVQ2qShL1Q/rXL4yy9RnjD74w4PmPyW7VZOkjZs0GzQr
d6e9e3OkRyYxeRzb1cOmXlOw7YH+YBgvHRr8rVv/4P6zsRk2iOTm44xnS3i0D5dX
GYxKvInstE4DmEGynJNOqohRXLfm/KyA7y2cMnQHsKGp96pG1Mpzm2ARCM5RljWP
5tViG69SLLVPQepLJNdo5FrV8exMEF3q8SN9nUgl/twNyhiYUZWsh5KUkQ94S0+M
LQ77y3yDokJ1uVajW9pu4fcFOlq610DPtJcpScdGTt7mYvaZhWkK63Dpq2hBL30Q
61AxIaAimsHLumsIeOGW+U0yf2+lMvnqQK8K08iUK2/vo6S7ZUbhFOA5gCcI1PKk
sgUqnk+Jz5R4ctgR1tn+d0rfsThTzb6XDyiLHyPnaHGzTO58WYQo7Vh2itUFxSx1
NjJqEa9hnvWh7RQ1Ivmc0uLA+73qng12OUvZ1mE01Fi6U6bmFrs=
=zRen
-----END PGP SIGNATURE-----

--4x4k9MYhZ0jOLQSf--
