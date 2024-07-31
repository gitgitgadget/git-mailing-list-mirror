Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F053370
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420939; cv=none; b=gFa+IEk5QRjomx4iG0nEeY5eb3rzwKRe8j3pGmFgyqp+4pyzXtJp3EBU/QD1poGbwArBuYNTx6IJNb4PWbp4GToLjFuV5WoQ5el28y9eQLlCryjTK0r+pqyHF27v+7LkSnJpiM0l8iv11uGjklEY+DIAlvnbspiUJtN61btcxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420939; c=relaxed/simple;
	bh=mno61rdLD9KwSgYpTfeJT9ofNJ7H147gBvi/G1XUb7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE/M4QKXtxGKVakRoOWmdlzQUynszpwXCWWXSv50qh/2ueW/BjlhMPPq0LvALpQ27fH3H6QeKBUX1tRQVxj6bawDO2cXsENNUD3cv2nkqazh3aBxXlAvtoYFxDd4xC9NO6e6pvf8CuPd5l5TcSakRta7ABknTUe7RnlGuPjFbfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BqatB23C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LxVhcgb2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BqatB23C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LxVhcgb2"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 71BAE138230A;
	Wed, 31 Jul 2024 06:15:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 31 Jul 2024 06:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722420936; x=1722507336; bh=mno61rdLD9
	KwSgYpTfeJT9ofNJ7H147gBvi/G1XUb7M=; b=BqatB23CJLYxaSoFEGsUs4FLmT
	9ubpBDs+zmnYdbiA9Sl4RBKpdHIsNU6jnz7WoYBKLN7fufuK5UJrUGR4wYSBM1c/
	Olv2gM3J/Tb2vc6hXRpbzyOuFkzUkubx9UWesphRZ8zOji5vljRTyh6JETcLqo3e
	Dn2UtKXkJXB92WUj+vNweSfJEvI983fhwP/FzKNiCjwnMfsXR1hJjnyO3xhCqPDj
	uSHuRsMffHxI6EUJ1VnxMQh4zoMtAsT2IOHToHL5wkx2/Sr5Xgr7ZLjhLlrAq69u
	r/mvdHXnoVKhsYBrh5JIshA2lKLHgqwCJI9sjuXxhPE1kSLC4MlHe8cKruAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722420936; x=1722507336; bh=mno61rdLD9KwSgYpTfeJT9ofNJ7H
	147gBvi/G1XUb7M=; b=LxVhcgb2Bb1EK4Mup68L8rKSFsZUq4StoCumXPz/vj6U
	gv6tFssHp3Z2o/2OiMDQmNAhIURpyTG4ogPAXmVkdkRJ0tqX+g/QCBxUPmC7umAs
	IujD6qZfgAy/+xA/4DNiS75KOFlx3S4W20IhC9ruGUdi+Kf94MQUgqnrss8M9Mc/
	jQEWV30NKBNVvSECn9mXwOZQWoDZkEVKT/Ywj499k7BwnyxPbKHJ0ezNM18W+DAF
	xEDJo5WGlRkF8T/QA2wzRGpOGmYQ4z5AJE3jEYSx39pon5fyRfmeK4PHfYk9Jj/c
	QaSi/clcL7ry+jGp0ahlquu7ZcxVENYwaTPDPb6bGw==
X-ME-Sender: <xms:yA6qZns5SbpBtmQZkxMhZaLfqBUjMybU2fFQd3KhZ_RxTddgksT6KA>
    <xme:yA6qZocXLApY2f8cAZet239Z72vGcyIHLalgMfi__6YwN7b9o-QY_OqqfMr-sqhU_
    mLdbDdADqjtq8dLFA>
X-ME-Received: <xmr:yA6qZqymvauhzFvxQLY2xSd16aaCgBlFlv77CKDFjwvoioN5nXBP8RPErvk7tdmvuE6nULhiqzW3tcSB8Q_z5n8OIPZNnO060fxChaTJVzL9ZL08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:yA6qZmPr8ZbaGVxS5SCFrehzjJwigna94bKblcyON-4CGLb1-Wtzbg>
    <xmx:yA6qZn_vA7TzMzMFnsnynIQl3dTYZsLHtNKeEk-m1BvfFCC2KeR6SA>
    <xmx:yA6qZmWv05o_uCyr20LP5dyAZe75csTMrE5j8Tk87HrlOit_6-pmSg>
    <xmx:yA6qZof9b9UxGgsr58eqTAYsRmGlpO47Zhu8SiyqDk02GGpDmsGY3g>
    <xmx:yA6qZpLNZ-Gvn1_MoluRKXMxwdFjp4-UiFxVPHEgi6UPeY-TD3dky0KK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 06:15:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id faffec42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 10:14:04 +0000 (UTC)
Date: Wed, 31 Jul 2024 12:15:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: update Perforce version to r23.2
Message-ID: <ZqoOw_8xDaKLhL99@tanuki>
References: <cover.1721740612.git.ps@pks.im>
 <ee5d836b779087890acdad061ef6995642942479.1721740612.git.ps@pks.im>
 <xy2vh6bv6sjixvwd6fifuctozjizxns5evvgnqee5s6snnzb36@5hhtwvdk2a36>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0dnsiEJ74BxmARBr"
Content-Disposition: inline
In-Reply-To: <xy2vh6bv6sjixvwd6fifuctozjizxns5evvgnqee5s6snnzb36@5hhtwvdk2a36>


--0dnsiEJ74BxmARBr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 05:48:38PM -0500, Justin Tobler wrote:
> On 24/07/23 04:05PM, Patrick Steinhardt wrote:
> > Update our Perforce version from r21.2 to r23.2. Note that the updated
> > version is not the newest version. Instead, it is the last version where
> > the way that Perforce is being distributed remains the same as in r21.2.
> > Newer releases stopped distributing p4 and p4d executablesas well as the
>=20
> s/executablesas/executables as/
>=20
> > macOS archives directly and would thus require more work.
>=20
> Out of curiousity, for Perforce is there a defined range of versions
> that the Git project supports? I guess I'm trying to figure if it even
> makes sense to support older version of Perforce in our tests.

Not that I'd know of. Which is why I'm being doubly cautious to
deprecate support for older versions :) Not that many people would care,
but still, I don't want to make such decisions without having any clue
at all about the surrounding Perforce ecosystem.

Patrick

--0dnsiEJ74BxmARBr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqDsMACgkQVbJhu7ck
PpSuWg/7BWFk7D+GJjBzRDjq882sHt+x9vO3cZ68TAK8MHkqQ4sa1isva0VQI4FU
VmVdYq2FOAwanZdYzSvbYQ0iiHt5LrZgCJz6GhskoHG0KyzR7VDbOcv5CGc9CKXb
3wSnqdoTw+DkR+zPMU60M9MBkTGPjUHMwDSgZLORYEE4TNL1QRhCIuZYiuymHbQB
CcTl0wjudoXzIJOBEMNi0N10EY4ow0dBAFUdTTazWvM6BVayZuhIR7zyDJR1wVCN
82eYZv0XdwM+gA6QUzVqywbYs3PQ8M8ySYlvRMor7ZjyEA0Tj9XaRyubNY/tKNyO
JS1k1vzxpo9uNejaXdMnUx6UWJ5ZUVVI7q/X2qeXwjvZEjBtvp8+ATXqw+xvuNiF
O0JLBTLB3B4g0X6G0cyAmyXNF3u3hzXyhhGl8VSH3p502e4jG7/gRSpruWdaPN+G
BHHUtyFXVcffYXwU/xjPyVer8w9lsT0pCoHtqK0TLwkYfaqTPUiARjSC2v7hiHuq
Is6YYIjaX+CUemBHqdn150x3B+Cz7P4rmnl7eH6e7nOHiSbj/AVf4p21IQhmdT2n
pLBUigF348pRRAZyeea2GIte5u5BmY3hkpxl8f8TNjRJuRyy1/zrgbTILm4Sp3ao
/UivyhhVAjLtn8NMAvArTjhO6vF0b4O/M43ZvsnzMe+cGA4Ay6E=
=1OTj
-----END PGP SIGNATURE-----

--0dnsiEJ74BxmARBr--
