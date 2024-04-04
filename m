Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62E84D0F
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231007; cv=none; b=OE80fsXDvGYE75iwK81Vg1xTNmQO2684DwzFwxxkMgvE5cy99U8R46pqXLLNIUQFbMl8NXIVvG+leZ6BGGgfmsqRF/Bh1DIPzeBykrbbjBt4qD9VfLXXRFsWUzNcy8smR202HA9lo7sJkxPDXM9C93trSII3e/pRui3F87UeGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231007; c=relaxed/simple;
	bh=foxS/AKXYq/hBn7IKrcNJt2V+8C7UYzN22sEV8VOdPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2N7W6nDq2+7qkWAcViTwMYdGQP71XfLkLSdqdKEm40Lx8ZdGgidk/dOATVEwqGsCmumnvfSgIcH1qhZLLLK1RYc6ptzCqPA9HR9kK95Rrm5DWNJO35oEDKOzEGR8d6L0Zpp0gmvoS4GB2ghugH3inEFfdL4efLuGrzWeYkHcoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=njpRQW1m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pr0TGO0p; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="njpRQW1m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pr0TGO0p"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2626D11400CA;
	Thu,  4 Apr 2024 07:43:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 07:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712231003; x=1712317403; bh=foxS/AKXYq
	/hBn7IKrcNJt2V+8C7UYzN22sEV8VOdPU=; b=njpRQW1mZlGC6pJg6NPrsTNnsO
	gxGwQELf4uSwNPYCPSXPbvZINHHTR/gRenh5ZeS0ibYp+gua7mE/9aNWXPEy7txM
	VorQGLE+VOkwgQnJ/HFboYxT4cAod6gVqgcxSgRz6Jachizc54e4KMokowQa2Qa4
	zW1pNQY1hUDUzNOS+FBtSLXijV/cdZIOy042zFsVAlWvOAAyUUDQsB8W2z+s1Sjd
	RrdCTuR+1zFiVYzDOga9nhMMySF2KHmyreJOw9DoU3WKUeZTRvuoie12pgdV8Mqe
	L6hMftXHsijU/mq4wpIcyOlwyKMiV90d8ryKyhhMJMit61Lhz5FOWaxf/tCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712231003; x=1712317403; bh=foxS/AKXYq/hBn7IKrcNJt2V+8C7
	UYzN22sEV8VOdPU=; b=pr0TGO0p29NLX9YYyTEYZvqHYkj9Lwvk7Z7Oxu6oDumF
	t06Mw4jcIsxGrhagl2Sa0t5allN2vftttXWFSZq/1uuBTwQIa9HQbVDaMZcvi+5h
	N0q/G2pJgAtI+tpPmMm+L5Ug3LgUvceRbAkA9y3zJ7dYHmjWSoCAVVeJ2Al+NJ50
	tnVfqOjxMYpX/GtdwxrJVvGEBXeWn3XIgDTMw6mejyTEp1rvCo53UlW4UwGfZBmf
	6lKpiPleetlYuBm9peUgozg3+xP5YWAx/KXQ20ZtLZtLUydHHJYI3OCVLbebIpUm
	Mt4pimvHYExiHFf/VfWLFqEgyyR/dqPnezd0ADobFw==
X-ME-Sender: <xms:WpIOZiG-s-6TVn19c6weBsjpU32Y4FoPHk5VrvARuog2R0QlClUuNw>
    <xme:WpIOZjW2u0vWN1vV4ziqBEQHXtR3h-lITK3YCBOusDWelbwQnX_ogVDI7AwLmXzwy
    vCkjlBbru9yYa9_0A>
X-ME-Received: <xmr:WpIOZsKK3Mr7NCEiwWHwZTwaklIpMVH3YdCbmNbc-109cKk4QFSxlbYPw3DThkdGn9CSZp56WCG929JFwgzXOpqpIY4xSqTAsJ-GANMokBbvkpQd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WpIOZsHMTPDEWCr4zV6wwM349F55xkpTrxui0U_ZYLQpSS_nu69avQ>
    <xmx:WpIOZoVY2KzQ823pxVFqmZvVMwRQkQ-jlVtnw_WVt3rxo6bUTGskuA>
    <xmx:WpIOZvPKJ2kOyPMyUrBYCgXcKca3Nzz61S8nRcrfkrLOTLJSN9Ohkg>
    <xmx:WpIOZv1M6cpfC6GzRZfdSM2KUOIp6ywk8lEbX-xNBYuCrWNnnXRohw>
    <xmx:W5IOZmyeZqfH2ybi8iFwHxnO1t9a-CV54KWUsiDuLebteXa_cnnr--1F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 07:43:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c6a5a693 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 11:43:16 +0000 (UTC)
Date: Thu, 4 Apr 2024 13:43:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/11] reftable/writer: unify releasing memory
Message-ID: <Zg6SVcGC8kSGSYh-@tanuki>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
 <41db7414e17201f85b476af5e0183e72de450310.1712209149.git.ps@pks.im>
 <CAOw_e7aBPF1vPvF7iYXCM5VBQu-Nw00dO2pRC_6DU3PtdDUsbg@mail.gmail.com>
 <Zg5Xorz75NMRqONI@tanuki>
 <CAOw_e7a9BnEh2OatwaGoSyVK46Wv2-sVkArbtXHLPt79b6g2qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6g2o8WhfkAyKrKAO"
Content-Disposition: inline
In-Reply-To: <CAOw_e7a9BnEh2OatwaGoSyVK46Wv2-sVkArbtXHLPt79b6g2qQ@mail.gmail.com>


--6g2o8WhfkAyKrKAO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 11:00:46AM +0200, Han-Wen Nienhuys wrote:
> On Thu, Apr 4, 2024 at 9:32=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > On Thu, Apr 04, 2024 at 09:08:46AM +0200, Han-Wen Nienhuys wrote:
[snip]
> > It might not be the cleanest way to handle this, but I think this patch
> > is an improvement over the previous state because we plug a memory leak
> > and deduplicate the cleanup logic. So I would suggest to defer your
> > proposed refactorings to a later point, if you're okay with that.
>=20
> yes. Please add reftable_writer_release to reftable-writer.h for
> consistency, though. Or remove the reftable_ prefix.

I've dropped the `reftable_` prefix locally. Will wait a bit for
additional reviews though before sending out v3.

Patrick

--6g2o8WhfkAyKrKAO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOklAACgkQVbJhu7ck
PpRIzw/+KsZFmsA9Eln9k4jSSHj5U7LssW0SP6joq5OzM1I/GBAk8JFcNC/zKVFI
aKf10q5S6nVdfCf66IlKiSB2/4AW7CJWJjvO6lzzzRo4TtthB/cMJ/gmF3d7mmPg
Yri7pT8SYm3SjyBdoHHKKK9rUSQNNOQv3m7f3XF6dRUhpE5PA8CDtQxhtU43+RwU
4D+00Ot7MKn9IjM7EafZ5f7jSzM/rLamnp8CQ5F0AVnIEh2/jR9kMnP1zt7AzeJW
naSA6pqwVrJfAzyBJUBBVkGUEVh2MFBN5Sl3zEPEyEQeddESnddXoKrBeCOfzv8F
J9Pq1F1QQQqxSC6/K5BRE0IzDpOh2DA++z/yPzjftSB97MtfjHosK0EquTGGwruJ
czob7uGK1Z/ZrE4YQa7t1c6pvG9aslDDtUJ/gE9Bq+vuSkqyaNG0AI7hCYELKh81
80dyWEY389T+S3kkeI8qV10dZAovaQ9j1Wfv8pEQSBSoMvgrcJHHXIHcpoXWOu0g
kH4qqOVgYLWvJs8ew3UA6YFhWMMSarZgujm4AkdBGwzgQqhKdKh5ynaD2JJ+ok0N
gHWJAfGrW214JSL86KDKBbGmSETFsNu0EZJDOW568mQnYB5Jw/F+dMx/VENKvEhv
fj2aKEVnTOt3hSjUvaZn4nNGDkX+9/6vQpfcAriedQQOOly0bro=
=AGo5
-----END PGP SIGNATURE-----

--6g2o8WhfkAyKrKAO--
