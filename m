Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE533C9
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718688386; cv=none; b=h2bVOzSi2VYY5vSPa8CbJLtjzNWK0vDnXshyCSDq+5rxkfGavJ63kl+Wd7YHFxQ0AxEYSQbdDnM9O3iswSJHDpsmRgX4T1JIbdyTBnNuaEckoOsFujXqDZWrUkTHoeiMJ88HGNWGyv9DsrkUTLu8IBwsQDZc3asO65HxStDN8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718688386; c=relaxed/simple;
	bh=r3GdaEN/pIbv27Vss4plli1P7GfIQTQ02SjR8cS09oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NUOd4gpSQDTG8hWzS2SvsdgViHxOozHdKqmuKqQhjwEIJL+FWhbQPWJb6zMzb/9HdP63zzPdQikxAsyGc3s1sQhp8mguN1+fN1iBtToa7eaYt1pPqJtIqHp+ysMpuyLB5N4nSkyA2jamRu2FgVJCEp9Cs0t59RZswtoAmvDjuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C9MOHHAa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HkIncjh2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C9MOHHAa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkIncjh2"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6D9121380275;
	Tue, 18 Jun 2024 01:26:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 18 Jun 2024 01:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1718688382; x=1718774782; bh=r3GdaEN/pIbv27Vss4plli1P7GfIQTQ0
	2SjR8cS09oQ=; b=C9MOHHAa9CBY5G5salZeFfN44n75YDH19vcHxNCeFT+mTeqr
	6sbCKeCW++J4t3XBLR0GekmH7xgW2p2jBdD2du3J6PNysC+eUnJwvnYYLndat8a/
	a8uKhj8DbAjcm5RwxsELahVSV9Lf7vG/B2oEZMqn/8iHzNiZzQ6ngwztoP3bk6qQ
	Qr3nsOKx5rkbiHckoyPOfWkmIoDB9rmDsTtUq7Mbf72kg31G63bNYWBV1a+1D6t8
	2kOa2kS4/OtXDTvRSlghj+GnBtvbqMn/4vp/B6LJBJHHmQR9P2Uv1NWnHOwqo/Uk
	F1iWYQ3d+beH7BSZd9JOknBsL64jDX5LsS2Cig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1718688382; x=1718774782; bh=r3GdaEN/pIbv27Vss4plli1P7GfIQTQ02Sj
	R8cS09oQ=; b=HkIncjh2/mVWwPKk77qDXwg+o7kVik/EfbA/N4paJZhRSY7gf6w
	vSiEhukBsdmnLMfCXG+ED9AlJ82NHIw0Q80g7uz+OYYIIv8+clFjJiQ5cxx8js4P
	51MW/cnKSniRwyhB7al4m/1Wntocl8uylKV7dYJCBFpahSrZIwqCETYrzqRpLYrl
	t1C/zwzUOEzSkyD9TjWwzP78cxW35QNHXzlHxiuWGYoH5yJmMvh3aN+e630sIEqT
	cYKmTE8e+ymklEIOGYGwA0av0XhMuzK6yS6AlYlmi7I+xHSort71FKRkY02ZFeAe
	6ztir3qMGMGp0aYmgSK1ifT3Hwc26mec8aw==
X-ME-Sender: <xms:fhpxZmQHhI_-bRVsZ0oH5_g6XUSFT_nG41d9r-xh5YYrMsUVcjP6cg>
    <xme:fhpxZrwZAYpJqW32A8Tb57DDh0Sp9wcz-jT2glg29b01KiXlz1hE8h1HUlNwM4aEc
    UhVgMLGORZkghMJrA>
X-ME-Received: <xmr:fhpxZj01R3iZsGLEqZ0Rtp-BmCQhQkDgxj_ipMUI9QFju1vJ_FF2022O96_nf8TnJgPtWZkwHyhTxVihns9G9-GjdQ5MadeCrDHNU17XGdrUkoe->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuefguedtueeiheetleevgedujeekjeehleejjefhhffghfevgfekueekjedtieejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:fhpxZiDlRW8OZw13s20eDcn9rW_GFzF5MG-dIKfHHuw09UYBkr7tPg>
    <xmx:fhpxZvgSYWLdgh-bOSUGu1a9DXoQa4AHq6UJmSxIG75DN5Lhlt3eyw>
    <xmx:fhpxZup_5ieBuDvde7kGS7eef_SQIEujgXjdPJntwEnfKMS_bK4NNA>
    <xmx:fhpxZihEZl43twMzmrYL7h-s_WsUegsKQX3nVUUwFiVCbe6ihh_J4w>
    <xmx:fhpxZqUNUv1Hc-9_SCVGvbZVwoSlGPGql0be8ygD2ww6Gbx16hqIqET7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 01:26:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id df47bcf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Jun 2024 05:26:12 +0000 (UTC)
Date: Tue, 18 Jun 2024 07:26:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	shejialuo <shejialuo@gmail.com>
Subject: Note of absence
Message-ID: <ZnEaeaQsBy8k34-q@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GI78YpXQjskKGKou"
Content-Disposition: inline


--GI78YpXQjskKGKou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'll be out of office for the next 5 weeks due to my upcoming wedding
and honeymoon and will be back around mid/end of July. Meanwhile,
Karthik and Justin will cover for me in case anything comes up either in
the context of reftables, or in other areas I have recently touched.
Please make sure to Cc them on related bug reports.

The GSoC projects I am mentoring both have a second mentor (Karthik for
the fsck project by Jialuo, and Chris for the reftable unit test project
by Chandra), so we're good here, too.

Thanks!

Patrick

--GI78YpXQjskKGKou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZxGnkACgkQVbJhu7ck
PpQZPxAArS5+GvEH+z3vI189hhLhEKLFc18iRI+oy0m+0ZVDL1V0SaRolTC6Awh3
VBx+1KMyv73sVhkTQNi3wSu7uJohMP+ZD7TjMnXGJjf72WcuY4633fGW9ORImbTc
TjHnDJFerycQQEKreq99NFK9GWqePh+NAgy23pOpRYkCSa/iXDzEJWC/ELWjadzi
Son2VwVLrLeK10zwjZB7+tFwb9gKTw/C6qKAXDvIbt9RbmqwTsYTuUbDRUmT+edL
/I3hjJebulzjFM15rn/aZSYBTYrGaFtQBhm1wMRQMlxEFR9DCPm6O17tQq92WedH
LgnrEhCE0tPtwiKjXOn0cL15y/o2i4TJHO7TwtfDsFeb4dGPljf1KD4aIFw7ovW+
M+YgxYVs3TGtYRwEN1Yw3UbZrhGgJIgTZfo9Gi3Whb1gSvBg7leOYXCqOC8R+/xx
7jXmi2mN7h7kXbkYwuwYIGG3dVkXj4+29dMJ6ou+jt2TYpiONXlQr/DlgZiFzfoB
Vq5Rxajs42m6UsN/zsY1qIDwIrU4Yq9FMp5swRljHJVkN9RfLPMalSVExd2nvZBt
ICjkpKijy2NWXkQLg6R9VWzJKpP+7NVk9OLZZ0KwakuEYRU/A31+iSmfF7MCkcrd
gbFt7a8TbFNwzGIYgHZINJXCt0sd+H+K+4o6jzHgAOjA2YHa1dU=
=dgwY
-----END PGP SIGNATURE-----

--GI78YpXQjskKGKou--
