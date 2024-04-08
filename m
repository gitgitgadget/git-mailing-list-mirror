Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD33613FD84
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590260; cv=none; b=cpCgVX10gkORXextfNW284dPcBb3jpyOI2KFMzTvXz0GYeCUohQ4iudTskL7RJUV0JjEzpFKoJWZiXmOAW9zsJmlW1bFh7//2/a53cDzg4f3tOWEtZUpbLiLDdkT6H7I+dI4/walNsKn1e60tjjqoHRQSb8Qvc35Q5Xi6+snoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590260; c=relaxed/simple;
	bh=uLsorNkO1N9eCsuwPqnq4eTF/Jdufntz3E/qvv+o8mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjIkiMiKVges6kZLPqwb0d3DqHTlbCaNM0pEqsg19waxMLuY5fPh3p3ZoWKRgz7eVgBuXXjuv1zuze2QHA2FJXtlTB8ycFix2e4BKuATL18B0MiQMU/+pbfw+zbo+RbDqLCZMvTFVe7ok0CfEckREonPsQ0w55XXwCrYyt7USE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kpt/SQZf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RYS31biy; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kpt/SQZf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RYS31biy"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D58CB13801AE;
	Mon,  8 Apr 2024 11:30:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 Apr 2024 11:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712590256; x=1712676656; bh=hwXV5YDo2g
	1j7A4VpG6uMgeXB8If9f0JuhtnogJzH5Y=; b=Kpt/SQZfRZPVxW02NCHkw2LUR2
	Jr6LZz9OMO82254FYcMWbynwBV/C6j+a+g4oQI3IJKVXLJBM+cQMe9xdzCJhu9Y1
	lDczDd/qip4nzRkE6gCqMm8QBK4NrsVBYkKTOrhRVw7UHRWBjeg/UJqr6D7ddiuH
	XLusUaYUtosmuZqRnhJ3KmYSKpjJQIXzpoVIR6QPzCZ6SQCwhqGFVbYU6XLJsgYS
	B59XypvUJ/S3sWQvvcESV0AquzcfohMEdV7nujLnXtmOhY4MATtCny5a5H3eXK8u
	zuh2AKur2N7CECdPjUJqWy+5F25v1uK93BPMYjOZAO+hGnoFRtpupqhUzGog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712590256; x=1712676656; bh=hwXV5YDo2g1j7A4VpG6uMgeXB8If
	9f0JuhtnogJzH5Y=; b=RYS31biyb1Kicw27/i+0mjcAWipmTeeeFJFN9S8y7DAw
	UiLiIGHZ08OqbTeo8CbMeJ/Xl/K/p8IO4wkS7ZiF5fFIb+mXTMSvE2/uyQ7Xw4tu
	0twTT4d/JPwsLeP98W+lchvvecGOWNcdrYdXj4O7hOo1OSwJzmVhPCS9zHYXoIqG
	IrDMB9oUeHW8/ktDL7M3i4gME3qrjiMk5E8APUYVtNi+oHn6nAxQNUZ/qjHssBkQ
	8thm0Qz8M2NRvKkLkBA6q1QjZi3EvYoHXHCAfwo4leANWEoKqqs81I1++29T5Ukm
	qv1xLud7KGOSoFE83n5r/r8ox83+kZ3tcP9nKr0dYQ==
X-ME-Sender: <xms:sA0UZteSzh5V2-4RWQR16rKhVlaiWKEa5mfgmds3ITYltHokRA7DcA>
    <xme:sA0UZrPLC84SfsDe6LVrTcyrFAMJZl3Ldgss7mO9LT3si1pALmDkyZZUxaMucm3X3
    cOETv_W4KT3oa9GGg>
X-ME-Received: <xmr:sA0UZmjlbE4opSkFRTHf6lB5fUqh1rqVMQ2tElNlSR12EjmyG0oY5WRIXpAKWtsljg02c8vdJ8FJGyz6J-AQ3qwQRzRQl7rkBK_g0HLc4MgQqOjx4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:sA0UZm-JPCstD4NdtAmB0N5W4nWw3d2kuNTCt0vUZS5ogE8qo9mkbA>
    <xmx:sA0UZpsC2PxSOe7jHYnPuE0J7Zg58zxvNTsEqvBtlVvwZGCXwLa0-w>
    <xmx:sA0UZlH6GgybKpT5cA34zSt24H_8o99jaul8wWkdx_tVt4fQvVrB_Q>
    <xmx:sA0UZgPsqtfSoA6wHGjB9TkZGGXtW-YnLZpWX0MEeq9qJKSXqinhUw>
    <xmx:sA0UZi6oqCOAGapOfDNupBu_MBSYm0sApRIFbbBJV1P-nkWJ0mJMootb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 11:30:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 91ab0520 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 15:30:47 +0000 (UTC)
Date: Mon, 8 Apr 2024 17:30:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] t: local VAR="VAL" (quote positional parameters)
Message-ID: <ZhQNq4ITp68ikVVy@tanuki>
References: <20240406000902.3082301-1-gitster@pobox.com>
 <20240406000902.3082301-4-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xf2DyO5Tnrc8MOGC"
Content-Disposition: inline
In-Reply-To: <20240406000902.3082301-4-gitster@pobox.com>


--xf2DyO5Tnrc8MOGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 05:08:59PM -0700, Junio C Hamano wrote:
> Future-proof test scripts that do
>=20
> 	local VAR=3DVAL
>=20
> without quoting VAL (which is OK in POSIX but broken in some shells)
> that is a positional parameter, e.g. $4.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/lib-parallel-checkout.sh | 2 +-
>  t/t2400-worktree-add.sh    | 2 +-
>  t/t4210-log-i18n.sh        | 4 ++--
>  t/test-lib-functions.sh    | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
> index acaee9cbb6..8324d6c96d 100644
> --- a/t/lib-parallel-checkout.sh
> +++ b/t/lib-parallel-checkout.sh
> @@ -20,7 +20,7 @@ test_checkout_workers () {
>  		BUG "too few arguments to test_checkout_workers"
>  	fi &&
> =20
> -	local expected_workers=3D$1 &&
> +	local expected_workers=3D"$1" &&
>  	shift &&

I was wondering a bit why this is a problem in t0610, but not over here.
As far as I understand it these statements are fine in practice because
the expanded values cannot be split, right? So if "$1" expanded to
something with spaces in between things would start to break.

In any case, changing all of these to be quoted feels like the right
thing to do regardless of whether or not it happens to work with the
current values of "$1". Otherwise it's simply a confusing failure
waiting to happen.

Patrick

>  	local trace_file=3Dtrace-test-checkout-workers &&
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 051363acbb..5851e07290 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -404,7 +404,7 @@ test_expect_success '"add" worktree with orphan branc=
h, lock, and reason' '
>  # Note: Quoted arguments containing spaces are not supported.
>  test_wt_add_orphan_hint () {
>  	local context=3D"$1" &&
> -	local use_branch=3D$2 &&
> +	local use_branch=3D"$2" &&
>  	shift 2 &&
>  	local opts=3D"$*" &&
>  	test_expect_success "'worktree add' show orphan hint in bad/orphan HEAD=
 w/ $context" '
> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> index d2dfcf164e..75216f19ce 100755
> --- a/t/t4210-log-i18n.sh
> +++ b/t/t4210-log-i18n.sh
> @@ -64,7 +64,7 @@ test_expect_success 'log --grep does not find non-reenc=
oded values (latin1)' '
>  '
> =20
>  triggers_undefined_behaviour () {
> -	local engine=3D$1
> +	local engine=3D"$1"
> =20
>  	case $engine in
>  	fixed)
> @@ -85,7 +85,7 @@ triggers_undefined_behaviour () {
>  }
> =20
>  mismatched_git_log () {
> -	local pattern=3D$1
> +	local pattern=3D"$1"
> =20
>  	LC_ALL=3D$is_IS_locale git log --encoding=3DISO-8859-1 --format=3D%s \
>  		--grep=3D$pattern
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 2f8868caa1..3204afbafb 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1689,7 +1689,7 @@ test_parse_ls_tree_oids () {
>  # Choose a port number based on the test script's number and store it in
>  # the given variable name, unless that variable already contains a numbe=
r.
>  test_set_port () {
> -	local var=3D$1 port
> +	local var=3D"$1" port
> =20
>  	if test $# -ne 1 || test -z "$var"
>  	then
> --=20
> 2.44.0-501-g19981daefd
>=20
>=20

--xf2DyO5Tnrc8MOGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYUDaoACgkQVbJhu7ck
PpRGRw//USxKsoYIo9El8TcfYzCRVBFsMmOOGIE1FAblXoywaJZv7cQji86V01dI
qyOBddUmYDN8DhgVenzr81kURdkqn8aR0P3NqXyVD1av/pRuV+6tr5N+xV4zZs4m
KxHBV/SNLIBiCthxDNAeV/2vHHRMi5Tz8rjKYlGyUJBKbWPCcOVtY1uLhuCg07SX
Xvtr4h5XSpiDtCiXKCSwa6/dxK70JlOLZh++IgheK1tp1iE9VhMDdPvMZ3ylzULI
TnVWAA9SiWoDwbIw0WWhndwsbLuMlDrJ7HtiqZHiEh/6QBtudOM3GiCDNs42aQLW
4MV/ZXcfxGs2PGkiLycfngSxZfoTnQeXZ02h80RRCSnwh5M71xGOkUZPC+awsriJ
wup+UUzookC5vyEbMFt1sizOefTXVt3+Md2QanKtkimW5PP0wSD2Q3IAxjnt+k1N
Lwb6/tNi+y7gBDt5Z98vcPA9JSxWM5no+pLuxCyceZqFsYdY5N56T9iYqvhB0+Bm
hfXRFsJKk2Kcfi4+h1RFByt9x8+Qy5rfnKSxfF9jLaKaAzGE5C7dpWFiHZaUaOVg
xSlSZPTa6MJ6Lq/41OFR9goktCGZSuy03cSIBnqrLtXdwihd3vi8sMdWH9r8yJqH
uDqlBg6umBBXQZiD/Z+HD/mEVDYe6p8yG3AsOIxuuyeB7ybPdVs=
=vJ/p
-----END PGP SIGNATURE-----

--xf2DyO5Tnrc8MOGC--
