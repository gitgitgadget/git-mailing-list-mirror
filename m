Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720B146A7A
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254906; cv=none; b=fHDFOSdETpFCYz2tvgK4EiZrA1sulrscHytlXp2fnXmp60froubb0ekmZAB0y+oh4TrWkITPdGo2hAleBLrq7eW9NABw0sEMEdHw1aPVh+I8f/PIbCvokfGPHZaWZedZ3DKyDcrgfzCd7SjPIixegkdELxeECnIUUrFUUA1JxG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254906; c=relaxed/simple;
	bh=IbOiFi0XlA/3o1ORxWzoWfVmhELrsZSHpi22BQO1TJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA4U5yTIBQkw/xI/QZI2j43VGZyxUIYxCIT/EUxMIXLRkmIwZtIzdLnx48eM310z3jw5G1CbyhNEqQjdamacIkTw41lT85q/5kj4QohTSG6DQ7ikkCVcZ+CxFVZyufCtpmsSN/9lNsuSQRuN3OiIjdQ794WWEn6j67V2ZPzAu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KmRKw0e7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H868xneN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KmRKw0e7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H868xneN"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 29CF11140179;
	Mon, 29 Jul 2024 08:08:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 29 Jul 2024 08:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722254904; x=1722341304; bh=1LDftdBE/t
	HbpmRdAH9qqNhDEQMx87ez/JJG8zvBg5E=; b=KmRKw0e7GEWocf6K3NFFwLmwlA
	0PsoQX5HX9EPf1nwTxQWJLo2uj+E77GWRe6ZMLWO3uaUdYn3pU0PK0jGy2uCA2rV
	UQuRW/0l7q+2GxVtwyOUJTJ6FjruDZh/Hy28d6CxIpU26b6pWbZTPDRaYmL/FgDv
	9ZiY4wyas6pWzIgpzUmONiei4vE2/Zn5Utkiehzn7i5rzhOz3xYRPvUnYcM46Zn3
	VMb0+c5v3ypV2c1zJyzrO0Ud1TLxG3nY3ev+ma21qGApnpvbSxhN5ikQcG2r49bS
	ps+ansmJgnZJZnEmAMv0WL+DLYOG2Aoan6MEoB4q7Kh486rvDGZ6M6LZnZtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722254904; x=1722341304; bh=1LDftdBE/tHbpmRdAH9qqNhDEQMx
	87ez/JJG8zvBg5E=; b=H868xneN5qTnsq4CVHLzZOKm4tqpnKcxKxMzh8tCwe7C
	hEgYH7v7Le4u9OidkbToEKjAVCwkdx7W3So6DXS3UgR22ij7+mfGB9rPdkjvxgnw
	X8mcGjnBCI5Cq2LMKVZQpPDyly3RRrKXxGiNlrdlRKnmgZ2jzdnrsbLiI5XHor6k
	ncQjIfiIDlrWXxYbaBt0Qjd8NtkCh4zekiOJEvsCcRlu1RwF1WS/ARqzW3ArH6xD
	vw/si/SZZYQlJsyyKPldgYXTJwrLnPNG1y7pT2vSGnSnzu94xg0gR4n9qw9VGAvB
	F1xtO8FfuYMCTZPHhU9+dxFzswIXEQHq73d4F3voVw==
X-ME-Sender: <xms:OIanZph8gSToH1VJrh2sio05J0jbxIHPDA6qRb-uBhp-OWVzHmYWeA>
    <xme:OIanZuC4KNUDKWCaxWzy0AgYp0pHdW5ZAhRuRX0WlhLTg_F_fdEwk5Ib6SaI_DGYl
    MJeI1FgQsGmSW-CUA>
X-ME-Received: <xmr:OIanZpFPUP7EPCBjbMvCVZcLB2F_KJlkgY6-5gThUPbyTX3bLCRzDt3grTlQY98juITEIDN04J_vyWA35RR1USDlpu0Wyafu7b0eXk6JKmCPWbkIrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:OIanZuSSPcxIBpgUl6ksOhxgXheHPP4vZhGi66z8VMXA9K04dLlZnA>
    <xmx:OIanZmwnpKbPR608iUNeA7Nq31WzF4BSxepkNcTSChc_qrSKGxWcKA>
    <xmx:OIanZk5txu-dVJdlwH7iHjB3iTW4dwFcoIdzh_UrdztpLuUTb3jnFA>
    <xmx:OIanZrwvNjivpYM1jiH62KkMo2YYgEhjQcQUfa0GU3BgSbDmv4qywg>
    <xmx:OIanZh82DPNvlW-c4UkGnAlfdYhYG15QsjyirPW7odp3S83SDqCsBmV4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 08:08:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 28fb0902 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jul 2024 12:06:56 +0000 (UTC)
Date: Mon, 29 Jul 2024 14:07:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] patch-id: tighten code to detect the patch header
Message-ID: <ZqeGBJrqIrU2A4jl@tanuki>
References: <20240621231826.3280338-1-gitster@pobox.com>
 <20240621231826.3280338-6-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nKGFDEXoxUMKbsIO"
Content-Disposition: inline
In-Reply-To: <20240621231826.3280338-6-gitster@pobox.com>


--nKGFDEXoxUMKbsIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 04:18:26PM -0700, Junio C Hamano wrote:
> @@ -196,11 +211,13 @@ static void generate_id_list(unsigned flags)
>  	struct strbuf line_buf =3D STRBUF_INIT;
> =20
>  	oidclr(&oid);
> +	flags |=3D GOPID_FIND_HEADER;
>  	while (!feof(stdin)) {
>  		patchlen =3D get_one_patchid(&n, &result, &line_buf, flags);
>  		if (patchlen)
>  			flush_current_id(&oid, &result);
>  		oidcpy(&oid, &n);
> +		flags &=3D ~GOPID_FIND_HEADER;
>  	}

I think I'm missing the obvious. But why don't we have to set
`GOPID_FIND_HEADER` when we have flushed the current patch ID? Is this
because we know that `get_one_patchid()` stops once it finds the next
line starting with a commit? Makes me wonder what happens when there is
non-diff garbage between patches for which we are about to generate
patch IDs.

Patrick

--nKGFDEXoxUMKbsIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmanhgQACgkQVbJhu7ck
PpQ7UQ/3azaueyometkzImskXRA72QaGcoEJOon9NG7Yl7hlQjDITVcirfeLhTSb
cnhXg5/D6lNn9r7rsKg/1LjW1OTUtWcYojRTzRg2HsOK9NXZF/GFqvxgeJoqwjZM
ShlsQl10wxylBvExzYOvq6Ah2S20FfG438pNJDO5HYEtk3p//J9ZlYy7o4dzlEoo
eyOdBmZ2BcT+eAIG4yRf/VFSkScD75P2mtX5MqFAf4VnkixKqJ+ESX3EV1VdRVXu
GMVHp6SV15kN04n1Eyv/oMa69J4OqWHTJL7nIXUrV4G40uGqmLErHlKOdw4FUwM4
nfQaYGixEmlar+aQjKIJ28utpbjNXRqefQ/IoHjEBYyroagVBsYzw7pUnv2RjL2J
a/HtvCAtSNqPc5Uorg8Y52u4a/GwXxAe+VhG0Mb+q9/bmcyOKhHbXJ8aX3xDaNZt
yBWk+w1gEcNfh0OD0sDkWSkm91HTb1qMhsUwam7+2sN3pXF0wyJAzbzy1GAJ0BGU
ZROEIp51aH4SMzsaYb2GlEsJlGtn/hf1KcjfmFCN5m4lzaE2OwlID+sUK4BHtoq5
RaBSBcyzvazxvb3c6qidamKdFwjs2DxqByNuYCHggJ9JlqAGKBl5H3uQB+zX+xru
CzFaQFVRaAkf+rjIEgNlFSXTwHDSn/odBKBhLTIKwj4oVO3nTA==
=uDx6
-----END PGP SIGNATURE-----

--nKGFDEXoxUMKbsIO--
