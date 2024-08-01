Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC58170855
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504719; cv=none; b=D2xCB1G+/p35qaaDmffYven/2t/gwey2mGHR9xq7b22AH+nx7sJCXWZL4/j1a+LkEn2b3D21Dqzq9wwdNC+97Oj7qFP6yWZ20ZVhqb6Ita+esDJIMEeG5eSV15S89/4I4r3PkEZwvFHY5EUcDS8CSMF2hXmp5MPW4uoUK1mb+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504719; c=relaxed/simple;
	bh=gMLvyFAZshbaA4K8F/z5rKWWeNHJ4P9G0n8Yf/7zIHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oez8M73Zajk9rE6SHmBTbgGwBJNO63NQ34Dqf2j2jgN8i+zzuSZbPFXTMkQ1NVx/Gy20QuCcE9ErACHgl2uVKUtanfbpgnLT/PCafg2Z9BrzXg9iBsX/lEUWM9HaW8lXzLrw559rfwdg3fTZ9HG6q+j0L+jsRPE6Wi7m2g1HLSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FdBHJLKP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Atx6iqBu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FdBHJLKP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Atx6iqBu"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5C438114AB8D;
	Thu,  1 Aug 2024 05:31:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 01 Aug 2024 05:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722504716; x=1722591116; bh=Ps+ThsrsAo
	HhxRfFuLTFXozhimpyQo9CN99IjfDMkbs=; b=FdBHJLKP4dZ3EAm6XMUsZvIm2A
	C2NRTqSXZu8nuFu10Ai4PudNq1icF4o7nXFfwfdjcFZyyaTXIBdTzyQ+6RpP0+x0
	PPmMXCD+8EQxQD5VMn7+kZpQ7Ck+gTBczkhQiuJMEG6VQpHrducom1YhoCNE72nZ
	kt0lUV3v9D71noI69ALMVQgW+jM/ExB0yb2V079NvB5Z0OSthAx/hTH8CNjd0ozQ
	Z/RN4LVoOa7IPwGrsmtT8YW8bD1pIYwOoiMHC7qAWTAJgedORLN9gu/mOq+vca0l
	NaPlTrtaTJsK8UZ12JHiEw3Jk+LtZKSB70Nkyb2bxM+7bC3sWLJb4/GTm/Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722504716; x=1722591116; bh=Ps+ThsrsAoHhxRfFuLTFXozhimpy
	Qo9CN99IjfDMkbs=; b=Atx6iqBu7u5aBXq07ye1Ts2hXUvefseyG/2lt5w52Od4
	4b5HPG52ocQsuGwXTsNFZQH/cL6uKEho7stCnrVbwbCcfUBbWOI2qcZEdHIbULOE
	Y3AciOYyIOuBEq/97cSP9aoeaKhaLAsET8r2SSBO5PTxGT6iRVN2RKgK9+0b7kGK
	zM2zPBELBlFXHaoCMeyrRvbY96MD7hyRB5qT4pZsxFkB3qhlVrb9QwxPZU3pH+cf
	//atYsuVLSHmnwAPeErpW0fWIdyJwTwFOeorYkNB1rEc7ToN5x81i5znYa/HJlcA
	lXB31jTLVLZK4Kg5dMVa+bbr3DMYNo0+NOb4/5oxEg==
X-ME-Sender: <xms:DFarZnMLuKbTL14SUzsuyCGpuaZ4awTxDm-IA4Q1w8d1NIaCC6gQKw>
    <xme:DFarZh9OoOaeoCzDgH1pXXiN-aiTFL7ghTu6Ui43MLvDwxMAO6roVU2a2xEqdE2xr
    MQR4hAOj-iAoZXnhw>
X-ME-Received: <xmr:DFarZmR1ZRbtzvQ5OoZnK4xaC-ouI8zCGOM7XIEk79Ec0H90i6QbbkP708TwM3mmsNjGlJhuF_V3JnlbxJ45qEZGxEDePb3WWTdDJrJi2N1O8i4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:DFarZrs_vuX2wChSjKhL7P0xeTRsSIPRJCbsbG-YBSakMMTiPDzyog>
    <xmx:DFarZvfo6uUny_4PFK6XUQujMpDVxRS94qUG4OMa_0lVNIjYu57vDg>
    <xmx:DFarZn237WiBQDbYnm1G56LPCW5JKT8lJ9kC4Z93EZi_RVqG87-ssw>
    <xmx:DFarZr__6j_ypl1cgOzdNlwioYxF3OqCFWkmnLuVWb2qHK-HOkvOlA>
    <xmx:DFarZhuexceH2z1flB2MlHWcbMRV9otvZD17ShhGUOtHn1a_lVIci-cb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 05:31:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ad47f4cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 09:30:23 +0000 (UTC)
Date: Thu, 1 Aug 2024 11:31:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?J1JlbsOp?= Scharfe' <l.s.r@web.de>,
	'Kyle Lippincott' <spectral@google.com>,
	'Phillip Wood' <phillip.wood@dunelm.org.uk>,
	'Josh Steadmon' <steadmon@google.com>
Subject: Re: [RFC PATCH 0/3] Introduce clar testing framework
Message-ID: <ZqtWCHbnieW6nQKk@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <xmqq7cd18srf.fsf@gitster.g>
 <008901dae362$386ae280$a940a780$@nexbridge.com>
 <xmqqfrrp7bbu.fsf@gitster.g>
 <00a901dae387$c68f6f70$53ae4e50$@nexbridge.com>
 <00ba01dae389$7ecb2c40$7c6184c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dCp94s2CVI0wHg2n"
Content-Disposition: inline
In-Reply-To: <00ba01dae389$7ecb2c40$7c6184c0$@nexbridge.com>


--dCp94s2CVI0wHg2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 04:37:37PM -0400, rsbecker@nexbridge.com wrote:
> On Wednesday, July 31, 2024 4:25 PM, I wrote:
> >On Wednesday, July 31, 2024 12:53 PM, Junio C Hamano wrote:
> >><rsbecker@nexbridge.com> writes:
> >>
> >>> I'm sorry for being so behind the curve... what is clar and where doe=
s it run?
> >>
> >>We have t/unit-test/test-lib.[ch] that are our home-grown unit test
> >>framework.  A handful of tests have been written to use it, when you
> >>say "make test", or "(cd t && make)", unit tests binaries linked with t=
he home-
> >grown unit test framework run.
> >>
> >>clar is a _potential_ replacement for our home-grown framework,
> >>suggested here because it would be nicer if we can use off-the-shelf
> >>component instead of having to enhance and maintain our own.
> >>
> >>Where and how it runs does not change even after clar turns out to be
> >>good enough for our purpose and we commit to replace our home-grown
> >>unit test framework with it.
> >
> >Well... I would like to be able to see whether this can be built/used on=
 NonStop just
> >so I can stay ahead of the curve or be far enough in advance of it to re=
quest any
> >required fixes to make it work on platform.
>=20
> After checking out clar, I would say it has potential, but needs to be sl=
ightly more
> portable to depend on more than gcc CFLAGS (specifically -Wall). I will a=
sk that
> of that team. It does look like it might be possible, but it should integ=
rate with the
> config.mak.uname settings, so c99 or c11 (or soon c17) could be used with=
 other
> CFLAGS from that file so maintainers only have to worry about one locatio=
n.

I'm not sure I follow what you're saying. We don't use the Makefile of
clar at all but integrate it into our own build system, so honoring
config.mak.uname should come for free, I think.

In any case, if there are C constructs in clar that do not work right
now, then I'd be happy to address those issues. The clar is overall
quite small, so it shouldn't be all that involved.

Patrick

--dCp94s2CVI0wHg2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarVgcACgkQVbJhu7ck
PpSbqQ//fJsVhkgSBDJAm5xipg7f2FlfEzI8ImYAruYEuoRM8PYBOSrfCkrsgaeG
RjDPtEBpLA38/M/J6wojosmLMddfSIduFtIeQ78RM1ARVLAM9EEhIh+QHEPNqeHW
hSa3i+2bC4odtl2V0fZgqy1b0Z4MRg62bOgsazA035qGkqmz/7Yxwpgp2Q+k8Y1j
wAsTb6rHs+R+ay2DzGUiMZMdiEcZnorjksbyLTEoqKVHszw63qbQSvQRvHOp5fmz
71/wqare/RUq3La8tLPpmNPUaSq4DmrtIhHLGT09I/YRZi+7LeyfH4/QSEXB5PVP
HnqJsNGU5i87O8k+levgUUTnR7Dl6lKdnnzIdJvSHlPdPaL7qBM0r6gNblJt/VD6
mPxYnEc8nt3MwXdhsu7/t0S8rFhAtwFfLu5wpC7XwFkkkc8yZ9uOZeE0OC2gz8vI
vFoK9Kh+1tWEPnxoTVks80RBXZc02Hdt++USLYu8I52nBNpmprtCpkcIuRNzR+nM
jvsOE6HfPASbyByFokO9jFXENcAD33+ondP9VyoA4j0uFUBRVSW9BPlQV760Yr4F
lXlvcWxR0bg9IoSMmzVAoHWUfdawHDyn7NDTy4e/hqnfRSXo+ZXv5spdjc/cGCe2
ohx83c4i6QhPQMERHF2tYlOo2W+9GIVNOrJRobOZNEk/fyo8Rdk=
=atiH
-----END PGP SIGNATURE-----

--dCp94s2CVI0wHg2n--
