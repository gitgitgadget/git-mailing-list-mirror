Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AAA161311
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422548; cv=none; b=N6NnI98EWT0Hl3ZJRgNg5aYXRBKYO6E1VrBVMYjrmPF+cQe9SkifhHEmfpSzbfHacCCfnLyrh10xuaXe8rnXVuVbDYqEX4I/uFLGrVH1ckMd+f1MVQWkF1PNFf8y/Et3RphCIqP7YTJvdqKxgCljITSMnPB1PrJKqyp6sd+Wd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422548; c=relaxed/simple;
	bh=1XZXL1UWQnfT0kD5jjB33xkaXlz6xGnY10R3GYfQoIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzkxMoqfRsQAgsY/lIIVgY6NCW3Iy4bxYskjye9gXu2SVJ9P/Zm0Oht4ogdGBqMshyQI/aFW/d7HY8JNsf17dSpfvCswRCIGhTez6G/ZM9YXiBZdM1s58aD8vLFKeNnLXYK3ajVZrvHjertgiATuaRwshEI0EE9Ny0HsLMavQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VasJWN9H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qMlnI1I0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VasJWN9H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMlnI1I0"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 080BA1380785;
	Wed, 31 Jul 2024 06:42:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 31 Jul 2024 06:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722422546; x=1722508946; bh=UePGLs0Yub
	cmY6kdmgsDLCB/423ckQmYIhU09kh6j7k=; b=VasJWN9HOjNEWcWOl69NueHSVz
	kJOcXi0D+oCS2lFDRbWOZkZzx9n0mH0SIBUI4pKTqGW2vrEOM3saa4Nk1/Ryh7YZ
	jqTS6PAiRwdysciamIpZxNPkGZkbUvIEDXNpysf1J9HbRdxhsbF/RfmIxR20rRKr
	RjAyFygJMKQC2ScgapSU15bPYhCtDEZMEYhIbPtdvsllkoqM8AKnCIPCkRFvGX6k
	L0deAR3XWkkFitAugPVyRq1rJ+kJ8o6BcTrRG9H5ZeQi+jeC6NDRZ8wKXuR2jCZK
	r+0MF24hSDpQw2GtHClnKu2QUuKr+03lSmk2r76hf/yjJld+rPCHH/MPg50Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722422546; x=1722508946; bh=UePGLs0YubcmY6kdmgsDLCB/423c
	kQmYIhU09kh6j7k=; b=qMlnI1I0RG8gxucLDrei44laUgZa0fyAeoeSp+ZkC6PL
	fKJbChiqKlK6rSBwgDrPKP/3PlQXhjyefuQDA2AZ82M1mDpepcSnuplR4cOf0tSq
	p5m7bJwg+AhH03FPXWIuTZUcy9hoZxyBSw5GF39ui5s1wPlSSnt/23VG+n9jeVFK
	Qn1qAVDl5zmrn63IBGHe+520pRbRkIQrlFaQjpZfwK/3wxVNj+leI3dOcmwHtN6O
	UBXoVXMtLD68DXAZwW67rbA51WX3tME6p4vNorvx11PQ4FX56d5e+8JKpBnNUPsB
	Ut1CC2u4ACSvBUma+YTDkTxgkmOfD9Ie2IhiLY9LLg==
X-ME-Sender: <xms:ERWqZqEl4cGJZeXfeqTatEVV_smFYSz7AfF3cuyDqld7Fj391YPS8Q>
    <xme:ERWqZrXHDWtiN_YC78zCOz9LMxb9mYSCtAWlE8AWGIHKUes8tt5SrKoJaKMraDwnd
    rXXRHGsuvkrmsoJyw>
X-ME-Received: <xmr:ERWqZkL-hv62OYLTPiu1Kvfnz13NCFem4mRrqOpdlPvkDgJ5fOAmtZBRFgCzQms2tK-BvgotrdqV80DdrGO0JpU957f1VxOpRobdZgoCmzfi09FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:ERWqZkH6pI33DGT1T9BkG9deNUPZzzjZYnFQHuMRCbkxszUWGxYcSw>
    <xmx:ERWqZgW4RNaVlBbS9h0KGTuMt-PKrpb_GzNi48lTrmVHh-75KA766g>
    <xmx:ERWqZnN0GXR3KFyO5Z7Yznxft1P4eR8RFrIyYQqJnpnWZOsPDFppxQ>
    <xmx:ERWqZn14F9RbQruJN2Hc-2oKYz8hyMqDwSF1oF0szs7aEXeEQ0Pa4g>
    <xmx:EhWqZtjgqr3C4ga23_MeVoNMlO2BS45NhQoMyZBrWxEnPA0dmUSPmk_J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 06:42:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 84339277 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 10:40:54 +0000 (UTC)
Date: Wed, 31 Jul 2024 12:42:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/23] builtin/describe: fix memory leak with
 `--contains=`
Message-ID: <ZqoVDkOw5IEWv52m@tanuki>
References: <cover.1721995576.git.ps@pks.im>
 <08a12be13c2fed247d6086967e7a3f03fa6519e1.1721995576.git.ps@pks.im>
 <xmqqr0bagark.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rmpsGiBY2Mdgo1aG"
Content-Disposition: inline
In-Reply-To: <xmqqr0bagark.fsf@gitster.g>


--rmpsGiBY2Mdgo1aG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 08:27:59AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> [Footnote]
>=20
>  * The fact that cmd_foo() is called is not a hygiene thing to do in
>    the first place, and in the longer term #leftoverbits we may need
>    to refactor the thing further, into a proper library-ish reusable
>    helper function that can be used to compute name_rev() any number
>    of times, plus cmd_name_rev() and this caller that call it.

Agreed. There have been several instances of this scattered across the
codebase. The fix is quite ugly in my opinion, but it would be a bigger
topic to refactor those cases properly, so I refrained from doing so as
part of this series.

Patrick

--rmpsGiBY2Mdgo1aG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqFQ0ACgkQVbJhu7ck
PpTExg//YQJNevvPOJkWN9uIIWS0pj/aUHnWcH1YkYLv3aY+OPratuz+pxYgUBWv
otwHyokpZ68uwWUIQIyjhTF4RVVoV+/YljDgONyYBX4dtozWlDN16ggpSD9ddtxu
Hfkd8AXfKeLMyljARo/ACA5NCiqS7rJzibvGnd/mVW4Z7BwXHm148yBLsIXp01hl
YIa4oNsGHwm0f5GW5xHqFolIucd8kr348LVcIQ/Pj7MEjwpqp47C6lmDAmVxpfbT
Dr3HLZ8M5Fqjd9B6LothCqJfN+ciB0pQvf8eMpRV1y4NYRCdv0cyyx5+DOZU7G67
qt/cKJQBvSQeKyA+mB9BTQiDanmIjC5UxFUIaPPWiAQmCoiNEGOXyJ0jCx60vK+x
JIj6EYlaeNBOH/opvzLaTEY9ywudRjmEtt34Gz4LrP2VzavSQ/+Jq8SHhsayIwOk
CPBAabIVyWmlsDtWChwCNRfeGsY7zBcseJO+F1JHjArAVE344FGZFgT8cSp2J/nq
LnjwLerHae2zxNprcGG2RxEWQdhdluIVR8Z1u4g/lkpIWGuZXLRo7XPkBtjcF5XU
qIRRTy8Q/06+A26tKZapge3FBV3/w9tVD1hEHaPif6qrG7OWQPLPyOoxNwLtWngH
Flkes+RiD+m8KlE9EABt5eGHx+ustmdfFxtoKHif6P7c8Kg6DJM=
=sQeR
-----END PGP SIGNATURE-----

--rmpsGiBY2Mdgo1aG--
