Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A162D51A
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765790; cv=none; b=mS7AMynVTXVpGLp8gq2k4pqgiP7L0/z87uJ5quSgrbB3xV0dahsYYuMXs6pjw8XDK3nx32X3Be1+yiYAL4r9vwE3YlA2+lIzZZw7Kh4boO5LizOpWWwDKEcQu1wTA6U4Sco3dz1Js3hCEWEGnSGOht7jZ06XZYCY+ryLHsOoEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765790; c=relaxed/simple;
	bh=cLeBBMhQz5JbLKPO6EiHUXiJ6A4Jww6dBaulq+Go2bA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/PaHOD41fLH0Q3VqBjb4Wh+nw2RpZxU5ugmSUxHK8J5BfFZSArrTZ7B9X6xgqAd29hoiDGpT4RGYITUG/3MLal8Q9DyZq2XCt/2Yi4whgQzG8sR6BgCf8oUQNPdnYhII50Gr1ibSLSInB5/4B3pbFpR9ye5VgobSn1EXqI7r5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qPPRrIw4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cowqJRKu; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qPPRrIw4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cowqJRKu"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id E4ED71C0010A;
	Fri,  3 May 2024 15:49:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 03 May 2024 15:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714765786; x=1714852186; bh=9m/oW2zRTd
	n1AXpApKGOyNLn98vEexN0RarPrlnp3aE=; b=qPPRrIw4QliFpqCSUY1zf7o0lM
	noFBtuMdaSHrOc2pLaOnLl5TSAsL97R05omiPOQIFTNBtrHRwyHAzhXu7eKnBOiZ
	pzuDU2KO1SsMjkjA9NgBlp/jHL35xAE90aVxpBuVGxb9SZANuuAnSpaczb871BB9
	ovAdjGGhuCfGIDUEI5OnwAZsh+NUukC4907xPJpwZ+IsPxt3D8cbjXagRaNj7fCC
	2M0jYBYSZbFhWy815MC+U1ih4BaPgNxtSx4u9PFjp8vUdRZpN6y3dXQMP3xVUcET
	dW2UVe9BtumEfBUtiW7vpLhCh62pymvc/GfF+6GYusntwzMTcdv8wpHFtGAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714765786; x=1714852186; bh=9m/oW2zRTdn1AXpApKGOyNLn98vE
	exN0RarPrlnp3aE=; b=cowqJRKuf1m//u/RT2AHqJB32Sz1Ih/8LA90SGeAIeA8
	PHBlTCEiQluPLIr1wOyHUSzCEsfRp3z4lZ5AhqLPZPuBmoPQfOwkUH5nEuItjB2j
	NUqecgyG+DRl/ZHbscugPND0Tq1Z/cXBaNr6a3/HdQwEnX3RaijmIlfF6S1voKrt
	KHNvam25xd+VqiaMPNKCkxmNHxguw6Od3ug4uKcneNDypWiNmnVpqhNzinSD0oP2
	QrBqeB3ZjEeGAaU+j/ov0Ehx7i1J8K41+34AhCFn+9Clyv7YQdvoDD/gHmgM778R
	ChLA01n29/opnXualwXMp/d3AxrQagoNkcpr0M58CQ==
X-ME-Sender: <xms:2j81ZmuX6qFRPu7BAPDJ5tswCc7lO_1RJFEmZBugMxidZcihYsG1Vg>
    <xme:2j81Zre2hl3jAnj5njHb-4J-g9TcxapeuejfSI-EwRJaTCT81rJn8hrcvCtlWOv2y
    rGlX1arBuxphZaUQg>
X-ME-Received: <xmr:2j81ZhyOmPRmcho6lagNKSxB4K6fNvYo3Kj9mNAyNzg3gVAh_BK4S9ERdxOmZr-bGwrVBprPKbv8PUVhQgSdUrsuUAx-HvHo5ejgCP-df8fpxJbT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:2j81ZhMWVcNsoAnYjHYtA1bI8oDepAf9-k884YOslS_Fxk3R0Vxw7A>
    <xmx:2j81Zm8816zmRqqu0L_BYr4VLYdQoYRT6t3fUEq3ddi2KXSUQ5RZFg>
    <xmx:2j81ZpURK3Fuurrk4qBTc1p23DoWM-RsJsNMaSsg4z67lGi_rnZGng>
    <xmx:2j81ZvfrG7-ijeG8sWsjxm3EhVtRD5UdeQcbu-MQEm-CwLjHy-EITQ>
    <xmx:2j81ZmytqFmV-qR0WD6wPT3QJQBl0qNTG0AibIFcg5w870c2mBfDoKnw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 15:49:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id abce9e2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 19:49:41 +0000 (UTC)
Date: Fri, 3 May 2024 21:49:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4 00/13] t: exercise Git/JGit reftable compatibility
Message-ID: <ZjU_1PJnvmGhtckO@ncase>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
 <x7v4d4siixs3wllzycibxtgsqipnwohhyxg72zvcxboucshd2t@won3yobvixbu>
 <ZjUxY7kqgy-iLIzG@ncase>
 <ZjUzjhN78lqYtXqT@ncase>
 <2hhwttin6gvs2munwpl2zhnm2573bm5vklbk6mcwxbgc7z5sog@3dygnrnnnpna>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u/uwCt/b8lYFicby"
Content-Disposition: inline
In-Reply-To: <2hhwttin6gvs2munwpl2zhnm2573bm5vklbk6mcwxbgc7z5sog@3dygnrnnnpna>


--u/uwCt/b8lYFicby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 02:35:46PM -0500, Justin Tobler wrote:
> On 24/05/03 08:57PM, Patrick Steinhardt wrote:
> > On Fri, May 03, 2024 at 08:48:03PM +0200, Patrick Steinhardt wrote:
> > > On Fri, May 03, 2024 at 01:42:32PM -0500, Justin Tobler wrote:
> > > > On 24/04/12 06:43AM, Patrick Steinhardt wrote:
[snip]
> > Maybe we should do something like below patch. Basically, we start to
> > acknowledge the fact that Python 2 is end of life and always use Python
> > 3 on ubuntu:latest. We might go even further than that and only use
> > Python 2 on ubuntu:20.04 and slowly phase out support for it.
> >=20
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 473a2d0348..3967a5af85 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -325,11 +325,18 @@ ubuntu-*)
> >  		break
> >  	fi
> > =20
> > -	PYTHON_PACKAGE=3Dpython2
> > -	if test "$jobname" =3D linux-gcc
> > -	then
> > +	case "$distro" in
> > +	ubuntu-latest)
> >  		PYTHON_PACKAGE=3Dpython3
> > -	fi
> > +		;;
> > +	*)
> > +		PYTHON_PACKAGE=3Dpython2
> > +		if test "$jobname" =3D linux-gcc
> > +		then
> > +			PYTHON_PACKAGE=3Dpython3
> > +		fi
> > +		;;
> > +	esac
> >  	MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/$PYTHON_PACKAGE"
> > =20
> >  	export GIT_TEST_HTTPD=3Dtrue
>=20
> This seems reasonable to me :)

Please feel free to adopt and adapt this fix. I probably shouldn't be
reading mails at this time of the day in the first place :)

Patrick

--u/uwCt/b8lYFicby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY1P9MACgkQVbJhu7ck
PpQBAA//WpwYiGunhutsj1hFYDuhHEbI+DbLa2ol9YqKbwZcoii0dU8mJf+48Dbx
pp4uaf99ySfnbIy17TXUJW4lx2uzMBRYtrvJXi240JYaTyzDgu1wDN4B+loKYj7+
z0EVpEfkrgEtA7rDL2t0MyVS52lYruLoRFcPBLypAGSa1qZChwBmmvxwlG/TfYw4
Y0jCBo0vDI9pXsGKAE3/NjMGtb72Cg0CtXO7RvVVGQakmQ8075IbgNit12UC21hy
oEK7VTIEMDi5qOAWZx2R6Cu+jkxESxr1ty3PpyjGczh9JtDYExgBj/Yhtchv3oN8
S+ap1EYX8o21NbVTrDxXE08rsjovGLgBGMX9YIxJrLoFkn+upKXwSGvHRiGKC2/P
tdWVpU43SXonoxn+EIIDgLDKvhckAvLCSnscmEGtVQu7XJnzqYbiVr2a4Vfk2gKM
BkQ3JnrNftMiLiqvxfzoBDp0s8bdWXA/osdfNK/+zsamsPpxcigi4YJgtDpxH4DR
VS3MUDX5/kr5GV3z7mBMtw3iMaNwuQRD471dppqn6qrU97zddRXW9Ia3FqfcWvfH
NHudpwEFjKuzzub9WdhvbMmC6N9PebIztP8EYXzA9llepABR+pZXqOx1qbvYJ+S7
18uWQYT0bwOaH4+rkAsU7eyi6DEAsPzAg6wwYvj4jbDtZE+TEcs=
=sL23
-----END PGP SIGNATURE-----

--u/uwCt/b8lYFicby--
