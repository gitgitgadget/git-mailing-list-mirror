Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E31D2D627
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 04:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242886; cv=none; b=b0x9if1nByDCcCCG7M5ICs5yMN5rRrX2T0H1fd86Tko7ATHhJ3P5Zzun/dTdJMQVPxi0C5oBgxIV9NFw90YQB439opwijq3LWMVbxJF7QCgDMtCchWPzYz5ClJFkybAwhMYt1YCdB8/wzxA1O/EH3vldUo3uYtZLOzat/t2NqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242886; c=relaxed/simple;
	bh=itcf7YVI2E5E31vvyEKPdXNgI/jIhrI1i9WLuo4FS1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdvwYsJq1OuOr1ORNOKg0mVSgkDeJftPA3rK7WwL73LZy62Tcb7a9hUlwcjLvWP0W8zjteoot9MXvpvCOwKt0/tbdu2bHjwZKxl84H9EI3aczg9FHn8qUmyRtw6ZS96AgZQd8r7x6JE6NXAMblffOHEb+wjSmUzarpzZqclYx34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e/Th3yQc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frpGnq8X; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e/Th3yQc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frpGnq8X"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id B88661800101;
	Tue, 16 Apr 2024 00:47:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 16 Apr 2024 00:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713242878; x=1713329278; bh=VRAs8JVBj4
	dz/xcCwl0HgdFYEpkHNHMA6i2rqDg7N4o=; b=e/Th3yQcXwwavjiGZGssRWvR38
	OzkqEfch3W++P2gICVIHUJLQlQI7a2ggM3Y1RcwZBAtsTkVABMDEEkYUDB18TY5g
	yYqFafkVTiDZYP2W215PsTgm5HUH4aOW2fNPWKvIBgjxbLCxSUO4TvMZqhmbYFXJ
	yN5RlKQBYcr86Y7LhSbm3Geh1QAvpyr1oL+2WuNnj0RO3iduxLTkMEBY/t1y3736
	RC1wqDlbn/ozmAXA+b/ApHjSGgbCIk2LVTdK/Q8R9FKpsAVS/3w24bL6zkABS/S/
	xurCASqFC93cuL/85TnfMyUipmDx2KwLA4FfiP6kP8YvPKGJVf0j9NYlcQqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713242878; x=1713329278; bh=VRAs8JVBj4dz/xcCwl0HgdFYEpkH
	NHMA6i2rqDg7N4o=; b=frpGnq8XNjnPlSQEkJhS1SPb3P25E3mLI8xmFWTOaoY/
	8eB5xu38u76d8XYESf4vskwB4eeS7b2Sx0FfA4DmRsT2Oi0l749+5QIcQdU8JS6Y
	bPNI1Zz87f3Rx6EFojT5Hyn4/rDE/1ZEthq9PgjyNBtFtkT2ta3FrY8a4ojiTTam
	noAlBkNj2e5kI/EN76AQ//3Cze2OYPnHUDXW8IqhiG/8KKd1mlgaqo2P/3w/bAUu
	fXlnS8JWNMqMHTYfaHA8VGiZ96Te+h1lmvklItTo696LyisMRvjcVS7rRArg0Cy7
	SPnRRsasopwrelBhRmnyQ2kQMS2DLqUTD7w7O5IU/g==
X-ME-Sender: <xms:_gIeZiT7DempYI0TSFxYqG2DHxn41JFG0IzFgBSJQACNQkpkZdT2rQ>
    <xme:_gIeZnxivM9_tsqwSxIJ3aMjpQ0rrZ-P9DazHdfIt_o4iNXZb5tn7jEWCKQ1eguzM
    i76ZkT7YSum7wGO4w>
X-ME-Received: <xmr:_gIeZv2uYf2KIZgY0kVIIx1y7M0mtSRg01COBRf_JKVr6a_2QIZOgCc-sk440N5B43tlThuuX2V7jlX_xAXpjxu-yl8kF3fw6DExwqmM5nX-lYJoyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejfedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_gIeZuA77qFaA1AQ1rgR7JfeKDS-07CDmZFKbb4llHpqBM9kiUDsIA>
    <xmx:_gIeZriC_qr3zD692JYImCjTmK78piyvH1WgRJyI7sldBOD3oxX4aA>
    <xmx:_gIeZqqUVQrPwE82s3bK5Qd6QnI1lBO2VJIy5BeNCcdMVuSBAe5lNw>
    <xmx:_gIeZuiZVjXPD94gjClb4s3lHBKivD2iyTEnRJ2ZThYmDjpHymfTkQ>
    <xmx:_gIeZusuYgfYb7Pcr-rdPpQnKRAtY5VKbaSRpxpbL4FcywBpA7HHV41e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 00:47:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fc3af948 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Apr 2024 04:47:32 +0000 (UTC)
Date: Tue, 16 Apr 2024 06:47:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] pack-bitmap: gracefully handle missing BTMP chunks
Message-ID: <Zh4C9xhOC4BVslyX@tanuki>
References: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
 <a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>
 <Zh2vZB/60QlLYjUZ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VdtAe5WAwXGMXUcD"
Content-Disposition: inline
In-Reply-To: <Zh2vZB/60QlLYjUZ@nand.local>


--VdtAe5WAwXGMXUcD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 06:51:16PM -0400, Taylor Blau wrote:
> On Mon, Apr 15, 2024 at 08:41:25AM +0200, Patrick Steinhardt wrote:
[snip]
> > diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps=
=2Esh
> > index 70d1b58709..5d7d321840 100755
> > --- a/t/t5326-multi-pack-bitmaps.sh
> > +++ b/t/t5326-multi-pack-bitmaps.sh
> > @@ -513,4 +513,21 @@ test_expect_success 'corrupt MIDX with bitmap caus=
es fallback' '
> >  	)
> >  '
> >
> > +for allow_pack_reuse in single multi
> > +do
> > +	test_expect_success "reading MIDX without BTMP chunk does not complai=
n with $allow_pack_reuse pack reuse" '
> > +		test_when_finished "rm -rf midx-without-btmp" &&
> > +		git init midx-without-btmp &&
> > +		(
> > +			cd midx-without-btmp &&
> > +			test_commit initial &&
> > +
> > +			git repack -Adbl --write-bitmap-index --write-midx &&
>=20
> `-b` is redundant with `--write-bitmap-index`.

Oops, right.

> > +			GIT_TEST_MIDX_READ_BTMP=3Dfalse git -c pack.allowPackReuse=3D$allow=
_pack_reuse \
> > +				pack-objects --all --use-bitmap-index --stdout </dev/null >/dev/nu=
ll 2>err &&
>=20
> A small note here, but setting stdin to read from /dev/null is
> unnecessary with `--all.`

Is it really? Executing `git pack-objects --all --stdout` on my system
blocks until stdin is closed. It _seems_ to work in the tests alright,
but doesn't work outside of them. Which is puzzling on its own.

> > +			test_must_be_empty err
> > +		)
> > +	'
> > +done
> > +
>=20
> This test looks like it's exercising the right thing, but I'm not sure
> why it was split into two separate tests. Perhaps to allow the two to
> fail separately?

Exactly. It makes it easier to see which of both tests fails in case
only one does.

> Either way, the repository initialization, test_commit, and repacking
> could probably be combined into a single step to avoid re-running them
> for different values of $allow_pack_reuse.
>=20
> I would probably have written:
>=20
>     git init midx-without-btmp &&
>     (
>         cd midx-without-btmp &&
>=20
>         test_commit base &&
>         git repack -adb --write-midx &&
>=20
>         for c in single multi
>         do
>             GIT_TEST_MIDX_READ_BTMP=3Dfalse git -c pack.allowPackReuse=3D=
$c pack-objects \
>               --all --use-bitmap-index --stdout >/dev/null 2>err &&
>             test_must_be_empty err || return 1
>         done
>     )
>=20
> TBH, I would like to see this test cleaned up before merging this one
> down. But otherwise this patch is looking good.

So I'm a bit torn here. I think your proposed way to test things is
inferior regarding usability, even though it is superior regarding
performance. We could move the common setup into a separate test, but
that has the issue that tests cannot easily be run as self-contained
units.

Patrick

--VdtAe5WAwXGMXUcD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYeAvYACgkQVbJhu7ck
PpQTyw/9FPWKbxaPAVuurOXGcrHtLtBM3a6rIKgARvqKP8pgajRw8oB6aW+Bh5/d
tdHMHK3LcLigdDScAn1lgxMIsd0MjwXiDJCjsIaSOAf4hJRPzxPZKW5Xn7b6kNC8
NptWqliF3PzhHhhgYI+SyeaIbnkz3L7Zj8rFQWrFiU/d2b6CwL1ubuI4cyqZka4r
1okV6f9Wi06EsdBDvvL2+wuJ2bFqbHL1P/YygV4K/tZqvSc2eDrX3uLnjLJdjBax
kxhg1JAWwUhVrX+VfmWwErgqRIlW/UWYOU/XdFFqJFy7gr0Nxu6xxzylRBp4wc7S
AVma83x0J/mqFkXJNJlsgzAA1/4lZEXTNNUADDEGe2M6q8PnQz0M1yo3KTsQyaau
uzPU5wfR4GFv1Jzg8Lec6Ly+DherrxxQ9l+OoFo//llFG9HYeZ3kp1WtSL6+IcRx
EuqHNsfoE9NoeIT6m+Dit5PkYXZB2fiSIIK9fqjUEyNhkRHQRi8SA9w1taeEosZr
vgX34AESf8NRtcKcyUYUtwRUhorStNrHop/Japh18R+Ihy57mPw9S8D1DS5ldyB5
/yctDnlokvVx6f2pfpp9ERW0McdDgpSvN//xCvnVjfdmQcE7aYZ7d6bPXoUW2sNr
vB9KpP3hz6X3vSMojB6CtlhaEr7l5XZztx/9Q0/k17QyIbVdSK8=
=yM3h
-----END PGP SIGNATURE-----

--VdtAe5WAwXGMXUcD--
