Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A77E1
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331968; cv=none; b=BHjiUA1M2KAXNMldNY9Qd6Y1+HB2bBlU+RqqA97WpUOyUgRY3g2bt/naIpwSvRxHRYTU6fgqdR2AF0bSH6mZO9cFcnETWAsISWi3CNwGwE2CIfs9+riUqmr2Tg+xL2n11+D5z6vyMeZrXTcO3RS6DGb+Qqh5kBf2Dd7ssZbA4/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331968; c=relaxed/simple;
	bh=KSrpYQXyFoW9T9+cVcTCOSoBm3E9Lapo4BIOgvMC5F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUpEiQnJnoiFpvHtUFQyehP9rB+apHhymqnrYMaPTaD8K5rKFUE9GvTUumtAsX2o1JdaM7hTTeirHoezsPIp/fUqCL7QhU0FI/OwQRxgYiqLsGerHHsnw3s6cH+EwKGYyirWb88UbkvgIVMG1pYQliKxMQY5kyiNFgezpw3ltLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uf6PlPpz; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uf6PlPpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1742331963;
	bh=KSrpYQXyFoW9T9+cVcTCOSoBm3E9Lapo4BIOgvMC5F8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uf6PlPpz2ecAxAPsCjfQ/PRk4OkW5Jnjsf66j92GSVTaFg5ZEi8f2doDr1KG5xwkC
	 AjgK1rC51XW79JoFLMCySXK2T0ZMd+m+mnpxesBqlqxoq04TE2OZqiNtsMeBV52Hb6
	 fhwfPBfqDh9DDi+1PkE+qCyqGC1ya9GdQkh94+ptZSXumBEVNbfxIR7G2cIYHnWimx
	 mr0U2ut5yaIQEj41cAcOLDsvrYSkPRr4AevfxzDZ0tqelje/QbIfQZmztD0vCgZCrR
	 8jcaWMWGLbOzzawPBbsGvT6LaaHSHkeS2Fog3eTrj2xxp6scdagqBo7CTaMy7/ONB/
	 Mt1RqmO5smlvXY7NMU2g8tKMx4uUYyESFggUFCwvGdtmxe1dQAE1IRBDlgB/8kUpmY
	 eal41+ljewsPwypM3nP5AIm5tFOHKuvdqWhSMuUPx1vrYDX8iU1ZC/ADysWrTwsutY
	 BDceHGDeAAKree6hhq5M/NOQTaqHW1AquWFp8F7UuAPeHR/RBIZ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A05AF200B7;
	Tue, 18 Mar 2025 21:06:03 +0000 (UTC)
Date: Tue, 18 Mar 2025 21:06:02 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Yissachar Radcliffe <yissachar@block.xyz>
Cc: git@vger.kernel.org
Subject: Re: Slow git add . performance in large repo
Message-ID: <Z9ngOub5FZJceQQ2@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Yissachar Radcliffe <yissachar@block.xyz>, git@vger.kernel.org
References: <CAOHNGAW7ucD+xqvEuvq2GHMc42+WdKJX44XGguadK_y=pMf0Vg@mail.gmail.com>
 <Z9ipn_-J-ZKbnVQh@tapette.crustytoothpaste.net>
 <CAOHNGAUWR0K4RtEMU7WjQUhw9=rNekKfQ-1_rLNniiLKRgVzaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g+Y9KbHr0zOmMyNw"
Content-Disposition: inline
In-Reply-To: <CAOHNGAUWR0K4RtEMU7WjQUhw9=rNekKfQ-1_rLNniiLKRgVzaA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--g+Y9KbHr0zOmMyNw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-18 at 02:04:43, Yissachar Radcliffe wrote:
> > When you pipe the results of `git status` to `git add`, you are
> > effectively using the `-u` option, since that will only ever list files
> > that are tracked.
>=20
> I'm not sure what you mean by this; `git status` lists untracked
> files. For instance, if I `touch foo.txt` and `git add -u .` then
> foo.txt will not be staged. But if I pipe the changes from `git
> status` into `git add` then it will be added.

Ah, I thought you meant piping the entries without `??`, which are
already in the index.  Yes, this is faster because it uses the untracked
cache in many cases.

> Is there a reason `git add .` couldn't use the untracked cache even if
> other pathspecs didn't? I have to imagine that `.` is by far the most
> common pathspec used and there would be value in speeding that up.

I don't see why it's impossible, but nobody has sent a patch.  Most Git
developers don't use `git add .` because there are better options and
typically it isn't recommend to just add everything, so it hasn't been
implemented.

> I wouldn't expect them to perform identically, but given how much
> faster it runs when piping in the data from `git status` I think it's
> reasonable to expect it to run much faster than it does today.

As I said above, `git add .` isn't something I expect most Git
developers use on a daily basis.  It's very easy to accidentally add
something you didn't intend, such as a build product that was formerly
ignored but now is not (because it's no longer generated and someone
removed the pattern), so it's not an approach that we typically
recommend for that reason.  The possibility of files that have
accidentally not been ignored properly is not at all uncommon, and I run
into it probably a couple times a month between work and home, even
though I work with people who usually range from moderately to
intimately familiar with Git.

If you feel strongly that this should exist, then the code is in `dir.c`
(search for `pathspec`), and you could add a special case for this and
send a patch.  That doesn't guarantee that it will be accepted, but it
certainly is more likely if you send a patch.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--g+Y9KbHr0zOmMyNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ9ngOgAKCRB8DEliiIei
gZE+AP4/TZwhu/1WbUPGLFtsOH9VHxrtCNJc/mGHqBkEBZT1agD/divYGVSzDreb
SBTX1u9CH9T1lc1P3HHgHRElO1y6hQY=
=rQ22
-----END PGP SIGNATURE-----

--g+Y9KbHr0zOmMyNw--
