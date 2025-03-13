Received: from uggla.sjd.se (uggla.sjd.se [178.174.241.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA4E1F461C
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.174.241.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897053; cv=none; b=IAldrW80P72G05dyh/PIi8nr4wvtxTgI8ph8+PbtTz1/1w1qUUWHzR/ykdJ55UUs0ezDEQN5GBb4JUbTk/8fKwicDrBfXbNjlAwAPeAhfMmTdtnnQQpCOrzCGNAqFX/8J/h/Q83SljTQBf9tkPGf6bTRu9P1d/mDAYYuRic78wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897053; c=relaxed/simple;
	bh=m6vICqZDs5OE1zMwTCGKoQwVaYncmLgVaTDTJHQj5FY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lLbXcZqP+8z6AZN9Ep5l9BszOtG7ylcXTRAtzXguE3F6fQPXw/1szgy4cxQ0qX4VdPgBCV8x9SlyJ46823cs+ik6lsla2+TLkBAERAsbDqa0KNxPqkDtCU2WK9wuEGwPz7Izo/nCmPQ3IzkXXfhFOoBk7+zzGb8zuCXiwQwVpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=josefsson.org; spf=pass smtp.mailfrom=josefsson.org; dkim=permerror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b=OWol8mNO; dkim=temperror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b=L6OV1Ve8; arc=none smtp.client-ip=178.174.241.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=josefsson.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josefsson.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b="OWol8mNO";
	dkim=temperror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b="L6OV1Ve8"
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=josefsson.org; s=ed2303; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TLYOqtxLY7w6awNeupZaBXu3JlzicMSGw4v9TTYb4B0=; t=1741897040; x=1743106640; 
	b=OWol8mNOt6EwT1d/uzeBaiDbZAq/b5wm9cAtR2ngIpdFupV+7PSH+WZioON5FIyQ+J7ZJMyHwVg
	uMap8Z7mnBw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=josefsson.org; s=rsa2303; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TLYOqtxLY7w6awNeupZaBXu3JlzicMSGw4v9TTYb4B0=; t=1741897040; x=1743106640; 
	b=L6OV1Ve8fGyQ1i1PE5np7AX6LUVGYLaH1MDsM6RllxcrsrcVccXu8oXIzRucfu4omjsoX54UDbr
	O2jfq0d9xZ5f/N36oIluIftR+vPzi517WatPFM5stIr0ou6Q/QEcemDliUt5xJx8sokkFk1Sc9XVR
	qsz/X4WMgMbj7nmUQYzegp+bsCEjndcutTa2EztQLIPjoy4oGBLddqMw5FKyqVFkw3sjf1yZTqlyA
	ZGwnL8iFOSIHp2JRZ371J/skx8XVFPZnNvkLDl8Y8W/goJ/pvtK5L7BXPMzxEspVv/5ph/fB09rCK
	XQqxhTxqSNjF6XTYrHbORmDkoPHoO7vxgauPHc6VAd3RkvR7vTf8DBv+0h1zBZFoPipAZPMz7KnCC
	qR1BK2T8ZCijDucbjARoX/AW4MA1hJhgDYMDivRPj4VgaXxnJEkyB0xUxf/eTLiuj1tlx53Um;
Received: from 83-233-139-15.cust.bredband2.com ([83.233.139.15]:29169 helo=kaka)
	by uggla.sjd.se with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <simon@josefsson.org>)
	id 1tsozP-0012vS-3t;
	Thu, 13 Mar 2025 20:17:11 +0000
From: Simon Josefsson <simon@josefsson.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: Making bit-by-bit reproducible Git Bundles?
In-Reply-To: <20250313051538.GA94015@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 13 Mar 2025 01:15:38 -0400")
References: <871pv2jx4a.fsf@josefsson.org>
	<20250313051538.GA94015@coredump.intra.peff.net>
OpenPGP: id=B1D2BD1375BECB784CF4F8C4D73CF638C53C06BE;
 url=https://josefsson.org/key-20190320.txt
X-Hashcash: 1:23:250313:git@vger.kernel.org::TH+lC2QxvKDA+eRd:g/to
X-Hashcash: 1:23:250313:peff@peff.net::xLnlEFuGqZyHW3k7:0A6mV
Date: Thu, 13 Mar 2025 21:16:34 +0100
Message-ID: <87msdo1yal.fsf@josefsson.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

>   [now without threading]
>   $ git -c pack.threads=3D1 bundle create --no-progress - HEAD | sha1sum
>   c897caf9c68d2c37d997d3973196886af3b0b46e  -
>
>   [and we can do it again. yay!]
>   $ git -c pack.threads=3D1 bundle create --no-progress - HEAD | sha1sum
>   c897caf9c68d2c37d997d3973196886af3b0b46e  -

That's the commands I use -- it doesn't lead to the same hash in two
different 'git clone's.  I tried running 'git clone' with the same '-c
pack.threads=3D1' but it made no difference.

>   2. There is no way to pass pack-objects options down through
>      git-bundle. So you'd have to either assemble the bundle yourself,
>      or perhaps generate a stable on-disk pack state, and then generate
>      the bundle. Perhaps something like:
>
>        # make one single pack, with no reuse, using the default options
>        git -c pack.threads=3D1 repack -adf

Yay!  You may have solved this for me.  I have to verify this a bit
more, but this looks promising (these are two different git clones):

jas@kaka:~/t/gnulib-1$ git -c pack.threads=3D1 repack -adf
jas@kaka:~/t/gnulib-1$ git -c 'pack.threads=3D1' bundle create gnulib.bundl=
e --all
jas@kaka:~/t/gnulib-1$ sha256sum gnulib.bundle=20
c780bb07501cf016e702fbe3f52704b4f64edd6882c13c9be0f3f114c894e890  gnulib.bu=
ndle
jas@kaka:~/t/gnulib-1$ cd ../gnulib-2
jas@kaka:~/t/gnulib-2$ git -c pack.threads=3D1 repack -adf
jas@kaka:~/t/gnulib-2$ git -c 'pack.threads=3D1' bundle create gnulib.bundl=
e --all
jas@kaka:~/t/gnulib-2$ sha256sum gnulib.bundle=20
c780bb07501cf016e702fbe3f52704b4f64edd6882c13c9be0f3f114c894e890  gnulib.bu=
ndle
jas@kaka:~/t/gnulib-2$=20

> So I think it's possible, but I doubt it's very ergonomic. You're
> probably better off using some checksum over Git's logical model, rather
> than the stored bytes. The obvious one is that a single Git commit hash
> unambiguously represents the whole tree and all of history leading up to
> it, because of the chains of hashes.
>
> But that implies you trust Git's object hash algorithm.

Right -- I think anything but bit-by-bit identical files is going to be
too complex to verify.

>   # print all commits in topological order, with ties broken by
>   # committer date, which should be stable. And then follow up with the
>   # trees and blobs for each.
>   git rev-list --topo-order --objects HEAD >objects
>
>   # now print the contents of each object (preceded by its name, type,
>   # and length, so there's no chance of weird prepending or appending
>   # attacks). We cut off the path information from rev-list here, since
>   # the ordered set of objects is all we care about.
>   cut -d' ' -f1 objects |
>   git cat-file --batch >content
>
>   # and then take a hash over that content; this will be unambiguous.
>   sha256sum <content

How to read this output?  Could this be made git bundle compatible?

But if the above is solves it, this part isn't necessary.

/Simon

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQNoBAEWCAMQFiEEo8ychwudMQq61M8vUXIrCP5HRaIFAmfTPSIUHHNpbW9uQGpv
c2Vmc3Nvbi5vcmfCHCYAmDMEXJLOtBYJKwYBBAHaRw8BAQdACIcrZIvhrxDBkK9f
V+QlTmXxo2naObDuGtw58YaxlOu0JVNpbW9uIEpvc2Vmc3NvbiA8c2ltb25Aam9z
ZWZzc29uLm9yZz6IlgQTFggAPgIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgBYh
BLHSvRN1vst4TPT4xNc89jjFPAa+BQJn0XQkBQkNZGbwAAoJENc89jjFPAa+BtIA
/iR73CfBurG9y8pASh3cbGOMHpDZfMAtosu6jbpO69GHAP4p7l57d+iVty2VQMsx
+3TCSAvZkpr4P/FuTzZ8JZe8BrgzBFySz4EWCSsGAQQB2kcPAQEHQOxTCIOaeXAx
I2hIX4HK9bQTpNVei708oNr1Klm8qCGKiPUEGBYIACYCGwIWIQSx0r0Tdb7LeEz0
+MTXPPY4xTwGvgUCZ9F0SgUJDWRmSQCBdiAEGRYIAB0WIQSjzJyHC50xCrrUzy9R
cisI/kdFogUCXJLPgQAKCRBRcisI/kdFoqdMAQCgH45aseZgIrwKOvUOA9QfsmeE
8GZHYNuFHmM9FEQS6AD6A4x5aYvoY6lo98pgtw2HPDhmcCXFItjXCrV4A0GmJA4J
ENc89jjFPAa+wUUBAO64fbZek6FPlRK0DrlWsrjCXuLi6PUxyzCAY6lG2nhUAQC6
qobB9mkZlZ0qihy1x4JRtflqFcqqT9n7iUZkCDIiDbg4BFySz2oSCisGAQQBl1UB
BQEBB0AxlRumDW6nZY7A+VCfek9VpEx6PJmdJyYPt3lNHMd6HAMBCAeIfgQYFggA
JgIbDBYhBLHSvRN1vst4TPT4xNc89jjFPAa+BQJn0XTSBQkNZGboAAoJENc89jjF
PAa+0M0BAPPRq73kLnHYNDMniVBOzUdi2XeF32idjEWWfjvyIJUOAP4wZ+ALxIeh
is3Uw2BzGZE6ttXQ2Q+DeCJO3TPpIqaXDAAKCRBRcisI/kdFooUlAQC+kERCJVV4
RZzlEKBkfcwL97lKKyPsmVgxFWr2E8f1qgEAxOSqFIGxy4YFGLFD9lH3V0fGtRRu
MxOsRafTX3KzNwc=
=XyVV
-----END PGP SIGNATURE-----
--=-=-=--
