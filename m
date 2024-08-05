Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4214C5AF
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850610; cv=none; b=YxkBHUk9Xj4LMx9KAX553gTn6fsuGuxYrPCN/PtuwIKM3SrQKmEswZgtTINOzVZwSo4Vb2Ugan6FPNcQIWNw49HO3NfhiLH+qRB2Erhea+LQXhUKjTtTpJ0f+/DRI+lYlxJYh+VOCg01gR4lkD2vDZSUVggpGM379qnCfFJCFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850610; c=relaxed/simple;
	bh=mwOouM6vQnU4CrNZH579nDVujCgqax63f8J44emrbOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOIVTLKZ6UOB0Q+zMKzf+GMMur0qebvv2Csj1ZC+mqK7Ps7InoXeQ/zf4XLI5lzazbejX8SHFSL1yulXs3otLCjwvi6m1Tg7cIf4Zi8jSLza4wHOvC3ycZH01ra9ZDADpW1OIL6Zcc8HjyX2GdUI9HFXxEEylG/SMntCMoISRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f2+x1upl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=feKXqXXj; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f2+x1upl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="feKXqXXj"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 957201151C9F;
	Mon,  5 Aug 2024 05:36:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 05 Aug 2024 05:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722850607; x=1722937007; bh=mwOouM6vQn
	U4CrNZH579nDVujCgqax63f8J44emrbOk=; b=f2+x1uplgXSsyYGDhewzXVbhti
	gWeczk5noPbSCxrCoF69z/QGKPzfeGGCZZmpaYOXIXgYx0ugVnjMLmpRPi+jBmPd
	x8vfqzovHyWgKlTHI85cGdqBDnkfhtOtjXxoLrTPHUZbi2ObwLZiwg/NPIeIANap
	9Pdbhq/fqfWEBK4lkrfh6vjlMla+VSssMmAMf/VXTO6l/9OiDJyWpoevuymJlU0Y
	Be9oMiw6nK5sEkV2ujwMJF/B5Lc7MKi92oRpfBTJWLCVw38+HWikEDtZwPFsZeD4
	zO9+czq9PTOGeybPC0zOvv2r4t3zAN1J25Ao+egppSFSf/hyhfvUerXY0U+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722850607; x=1722937007; bh=mwOouM6vQnU4CrNZH579nDVujCgq
	ax63f8J44emrbOk=; b=feKXqXXjxNbCefps9eT6McksePRCFUewJjTgOBjmM2QI
	2LKb8C8jTOcareGU2lhM9swqQdkLwXzL7i4pbpsaiKsYkgTks02x4d7bFF34B3oz
	vBIs//RQwKmoAvRTaZbmndGHVwrjgUA5FhLLalDbnDw4N1qGDwdqPQxkx/Dc9ryv
	gdLVZSPq3pvO6YqQa4oqp1+s0PggnxUtKoNuUWUHIuSGm8HOJzIXBRFbFHfFQy49
	PKp1IQK/Yq6kEknW/ZEeDQcZVPNClWbZ8FBnSLajHiynNhGneP4dheO4S4SmZdMZ
	L9qob5gsVDPcs0n8FrLeoKU5WI+T2XYOBIM0o1h1EQ==
X-ME-Sender: <xms:L52wZv6PqwVpL41R6RFY4WfeFShuR8CmwLEK1XMYGmjoJef2Hv3fwA>
    <xme:L52wZk6fiNe_s_WF5S9vC-XiS5MG1vJm6qb6gW-la_w2kCG3Tn9_Yk6LY0EloC6bd
    Yr55H0LjevIiAHauw>
X-ME-Received: <xmr:L52wZmdAlPuV_Qg6-TYPFOtc1J85vyeRtqEhLp8wuOER9q9afhKN6A8eyTKXXtuEfnmSbGS-LuQJQlnksawXAEXHGF0YUu7NPyN6ijODaITQacmNJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:L52wZgJi00X_1XTlv0hjo2Z8Ebzx3eU4FW6kfT3eCoKgKYinEJjTBg>
    <xmx:L52wZjJLKvcqWVl6tSHUvRnMxQi62PkSngebmgiEXLShhc1KXSEVrA>
    <xmx:L52wZpyMj2t8XeG1irbI9XwF8BKZT82x_SCgH_VjjDPfKBG1hr0s7w>
    <xmx:L52wZvKX4B7FlU15jtCgS3vRGuSBS-sQVpv7b9mq41LP5Yal5-uGPw>
    <xmx:L52wZqXMLMpxFks7FcnV6Ekak16LN0oqDIBTx1BM2v7-RKcSC8XGS00x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 05:36:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b494719 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 09:36:45 +0000 (UTC)
Date: Mon, 5 Aug 2024 11:36:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/6] [Newcomer] t7004-tag: do not lose exit status to
 pipe
Message-ID: <ZrCdK_DbYyxT2D5e@tanuki>
References: <20240804071137.30326-1-abdobngad@gmail.com>
 <20240804071137.30326-3-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FG1bv9jei12SVZiL"
Content-Disposition: inline
In-Reply-To: <20240804071137.30326-3-abdobngad@gmail.com>


--FG1bv9jei12SVZiL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 04, 2024 at 10:11:33AM +0300, AbdAlRahman Gad wrote:
> split "test-tool ... | sed" pipeline into two commands
> to avoid losing exit status from test-tool

The commit body should be a full sentence and thus should start with an
upper-case letter and end with punctuation.

I'd also drop the "-tag" from "t7004-tag" in the commit subject, as we
typically only mention the tag number.

Patrick

--FG1bv9jei12SVZiL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawnSoACgkQVbJhu7ck
PpSpjA/8D5WJN9+DrczWraihK0vMPrpPeqLz9m/sI26xzMGmjdf2r++Uuz2VPH0Y
n7nFSZtBMTlb9CqFpJLDA69pQkVq98GZHWsN6SqeKDS49cflm062wUpfAY3Kt9ex
klxGE6DQcUo6MGUplcu9h8si9AkB3/Ki2zogUwK3DlgtLV6VNgQVsPl67REDyC0C
Vkf4X3JjrCAky4LOxiLdE/S8a/USUkbIVD0EcovxTPivqMNerH091Ct9gzStY1XR
Ih6ChlJEHIaVpVVyinzLnlWgJxC6glc0HrgnmJhmf2NPCXb/SsktV97Cm58xgOOO
oubKMqOWCtb+1SUiMvWEZm15ocwqjEyrJrF8unV8wH6RoOBjxYWfj51V8VkoOxqP
BOT0viegUykkDHi2TFFs8Nm8k+ggbRSCFvksldj/u4oI/kuA0yiJ76FW1ELwrhG+
/jBrWBeUpQsiNUdPbbSmpMlzNrh6X5n03rM8DYQr5F4M0rKy9svLgks0sf/cPJpR
NPE8JpL75Nvvyu9waGut/Add9SOX24uSNswbfNdwaCJQ1bB9dSBmPd0cBVnUhd10
jGi3j2ZkRmg+oy7HdEc3oVDtIvrnwAG5BLzBshof93Vlj0glTSX8jOfth5b/TKvM
VYCGhgMSeAgdUtl538ddaLjlRCXAVWaox8utfebB4v/QbvlNBKw=
=+Zpz
-----END PGP SIGNATURE-----

--FG1bv9jei12SVZiL--
