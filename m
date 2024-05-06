Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473347F4A
	for <git@vger.kernel.org>; Mon,  6 May 2024 05:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714974824; cv=none; b=NKDFUbtvv1jhMrMlyPqdhuV45n4dI10oVW+gciqSvcUgXtrK/w6EWTGOoiskP4SFbZ1kYZfl/o6ihr4xLYSFSM6xZ+rHwegkqMS0saXgUgLTRKZqEz2eC8d/UWHsPNWsk29YIFXxvphK9ioYFmj8hzAFnZfDOr3ROWY1egqpZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714974824; c=relaxed/simple;
	bh=oREyoGblxSKNqL1L2oVaZe4RgKYKTjbS4pJ3FXr27WM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD6rnA7y5Wj3+140DG9s6cW/k5PnySyRM0b41uqpMTyViydJrbjjLXgbE8YJN10vFNC9SPF36TXIdFdoXiWzxpKQHvBYeRe6FwPrGtKHREDND/fqD/j+GD7PpdzBFEH9cVQjR3TR2lyQNIIw3z8Gsdk9weklk2ltHKk36odPAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fd1lRdkv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QRlNMPYk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fd1lRdkv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QRlNMPYk"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3861A138025C;
	Mon,  6 May 2024 01:53:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 May 2024 01:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714974822; x=1715061222; bh=T4B3Cw3PTA
	wje/o8aaFiOgzAaV+B6qhon2nm/Mjv2+Y=; b=Fd1lRdkvnxz8SbeBbdNkAAYzpC
	eCdBhYgBl70R6BXpNOhP2dkX9FX/VTfNnXyVgaU95TBEFtCJIOgh41V9+jONb3Ex
	c2sm1vzSmpBdgpUkUgDLx/ZsRSBCfAVPkZrvGc/vOP8wfKzcwrwx+p2qys+hLYVR
	/y5XOBQ4rYMXTxRK4UNDK7m+cUSCzDR2Y0ewYx8OMM8EZynx5YeqEM1OFATNFxyN
	X4clEXl7bL8tgClSKgcg7NQHp74Y6t08uMrqyQfcmClFkeAfLsDM4cbKvSBPGXfg
	3JeZVYd1728pEP7kMCsYJrLQHeoQWHxNwvOPE3c5vQ//nii47Rfnc+UKGBsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714974822; x=1715061222; bh=T4B3Cw3PTAwje/o8aaFiOgzAaV+B
	6qhon2nm/Mjv2+Y=; b=QRlNMPYk+7QEuCSacUEksk+6hp16kOl/xN4ccFY7C6la
	FOov8hiGWYWwTPIA06yebAbpjttENuymyFECIhDwu6AAa+6xGm16iWQxwcHM2l0h
	pVnBmRwHABzf6+DnLMn2Lgz6dNvI4HxCOPP1o2IWP92PjhpK+JMGZf+ek6Sa3Ack
	KztF7fRJnAY2rkg4aJ1DPQiu3+nawGs36S7F/jHbhRV488Ln60ivm0j3Tqgz7N0f
	LDP6fC5fUASYjf7rxKdli4uxz68Dy2RSJcH2G7H9IN1msM4CKcsGEaGJq1UUCPYZ
	VBL1DeybEy4OXzm1zbG1D5l3YoFdtFBRFR7tymbAfg==
X-ME-Sender: <xms:ZXA4ZpbcLD7YXjMXA0uh_PAqWpBuIluE6HC7epLhvazSeqK2rnBqGw>
    <xme:ZXA4ZgbMhn25yyxBf9Pgc1EJW-10c8C2fhlWfwjEar9ac0zqivXf7A9gYgbi5rOSr
    2noNIdBbVnlb_OCyg>
X-ME-Received: <xmr:ZXA4Zr-ams7R2qkXgDft-Iv1xj06DhVQFj3TXf6cOMqnwW28wuU9Yij9WE6SkhhJ7Q-hFq6b66Z3TPiHaju5gEuZVDYfYrmETjvVAHvSzvbfXb5R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepiedvjeefheeiteekgeejveefffdtvedvudfgvdeuheeffeejfeetudeutdefgfeg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ZXA4Znrp0m1ECEhJG7UWdVJwNdr_Qpfp3ELwIZ28V5QOXdoSVpTGRA>
    <xmx:ZXA4ZkrJTIV2fP3jCkl_MeOEV_CUwPg_XpdPYgV71147qZK63hcfKw>
    <xmx:ZXA4ZtTMqPu6ISCdcvdEcB_2b3mliLY-X_yaZbApyHBt2lIpvRa77Q>
    <xmx:ZXA4Zso_8-w62i5cQwN2CgskQ-5YSVFQ2mbKl4IzLHEZSbni8pC7ZQ>
    <xmx:ZnA4ZleTggKmDpKhVQbL4evY3_Hu1WsUSiG-Mlpa_imKi-Rru9DeVwz9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 01:53:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f12f7cb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 05:53:33 +0000 (UTC)
Date: Mon, 6 May 2024 07:53:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4 00/13] t: exercise Git/JGit reftable compatibility
Message-ID: <ZjhwYNWO-tdqcUyt@tanuki>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
 <x7v4d4siixs3wllzycibxtgsqipnwohhyxg72zvcxboucshd2t@won3yobvixbu>
 <ZjUxY7kqgy-iLIzG@ncase>
 <ZjUzjhN78lqYtXqT@ncase>
 <2hhwttin6gvs2munwpl2zhnm2573bm5vklbk6mcwxbgc7z5sog@3dygnrnnnpna>
 <ZjU_1PJnvmGhtckO@ncase>
 <enfz4bzeg5m3odkbhrzwjfgah3cd5fl333rgos3sz3aju33y4y@do3yczu7a6hc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cqCJaqUEkFx9KvsG"
Content-Disposition: inline
In-Reply-To: <enfz4bzeg5m3odkbhrzwjfgah3cd5fl333rgos3sz3aju33y4y@do3yczu7a6hc>


--cqCJaqUEkFx9KvsG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 04, 2024 at 12:32:31PM -0500, Justin Tobler wrote:
> On 24/05/03 09:49PM, Patrick Steinhardt wrote:
> > On Fri, May 03, 2024 at 02:35:46PM -0500, Justin Tobler wrote:
> > > On 24/05/03 08:57PM, Patrick Steinhardt wrote:
> > > > On Fri, May 03, 2024 at 08:48:03PM +0200, Patrick Steinhardt wrote:
> > > > > On Fri, May 03, 2024 at 01:42:32PM -0500, Justin Tobler wrote:
> > > > > > On 24/04/12 06:43AM, Patrick Steinhardt wrote:
> > [snip]
> > > > Maybe we should do something like below patch. Basically, we start =
to
> > > > acknowledge the fact that Python 2 is end of life and always use Py=
thon
> > > > 3 on ubuntu:latest. We might go even further than that and only use
> > > > Python 2 on ubuntu:20.04 and slowly phase out support for it.
> > > >=20
> > > > diff --git a/ci/lib.sh b/ci/lib.sh
> > > > index 473a2d0348..3967a5af85 100755
> > > > --- a/ci/lib.sh
> > > > +++ b/ci/lib.sh
> > > > @@ -325,11 +325,18 @@ ubuntu-*)
> > > >  		break
> > > >  	fi
> > > > =20
> > > > -	PYTHON_PACKAGE=3Dpython2
> > > > -	if test "$jobname" =3D linux-gcc
> > > > -	then
> > > > +	case "$distro" in
> > > > +	ubuntu-latest)
> > > >  		PYTHON_PACKAGE=3Dpython3
> > > > -	fi
> > > > +		;;
> > > > +	*)
> > > > +		PYTHON_PACKAGE=3Dpython2
> > > > +		if test "$jobname" =3D linux-gcc
> > > > +		then
> > > > +			PYTHON_PACKAGE=3Dpython3
> > > > +		fi
> > > > +		;;
> > > > +	esac
> > > >  	MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/$PYTHON_PACKAGE"
> > > > =20
> > > >  	export GIT_TEST_HTTPD=3Dtrue
> > >=20
> > > This seems reasonable to me :)
> >=20
> > Please feel free to adopt and adapt this fix. I probably shouldn't be
> > reading mails at this time of the day in the first place :)
>=20
> Thanks, I'll give it a go!
>=20
> -Justin

I've sent out a fix for this via [1] now so that we can hopefully
fast-track this.

Patrick

[1]: https://lore.kernel.org/git/cb8cefc20f373a3516695e7cbee975132553ea95.1=
714973381.git.ps@pks.im/T/#u

--cqCJaqUEkFx9KvsG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4cF8ACgkQVbJhu7ck
PpRd4hAApMblzdKlQLcSAwFnQbp80gE4SCWkiqvDpH3t7Up++/jSVX67b1S2+QfM
ruk8PBd0eEIWpkXKiEnTekQ3tVdSxSNRHaV0GcdYaxjxwEoh4rsqSoJ1j0MWtjTL
5JOseGhxxLZnuoyxOggwWmkZFUKeQiwd7ik5t+t1AJGR2Kx78l1QT0iLXQFAETPr
fjVuTGoCpn0fy/zbbn8dR9bOw+cKnBDkVDhXVNFLz23C0s5B0ire7Vo9sQytZ5Be
KC8oQlCNlaZfOSxq/P0gRiJrHrAl+pqkh33nqb8Oa62BQMFap7aI0026zY3KAHVF
pv9P8fs/LEnaNnKtc2kFtA1PGjnhAeDraAlMU2wDTTUuPrj5Y6wYjWSYGs/aLpJn
ALTg6flDkTZw/pOAU8k1+oq/drd8cg8N/2AS7eLQmo6V4oCoHVNZsCM147+T3erq
no2wZs5YXkcn1hbHarloeOqdQmDdZ+204hNDjoMdBbr+V/CCQmguwjhXQ675rz8M
fvYrnW/F5vSNFaLFeoFTN7V1wradldZ3qLHPe3whI3XOTXJ4t1fJ6x5vboaXvAd/
lNKO+FWF/1WzrX7xdVW/m0BC2poyU8HMFwl4PIsb1eAA3aF3eRZqwODweJrc8Wow
zEPvoCRIR9Kpt8UDEEYMAMXHTdj93Ae6R0etPBh4AckorwHjXoQ=
=Oeno
-----END PGP SIGNATURE-----

--cqCJaqUEkFx9KvsG--
