Received: from uggla.sjd.se (uggla.sjd.se [178.174.241.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3E24166E
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.174.241.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780744; cv=none; b=mDYeyPCcty/+IxHlybu5cRy0bsTbQZtX+A/qoCwP8cN4COwEk/tTE+b/fZq7XlPVUZRfK9IEGprTaJdgPRq+wrV/Oyk2wXtksgeG0eTJ/11C4FTyahwkjBeF4R7gvq/tgNLdkVadLWghScILehLZXmLJPu4jnVB5ga9g1gaQ3do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780744; c=relaxed/simple;
	bh=prO+cv3GMHhfM2vNGR7d9KDkoTz8rwfpjDT4JMVrVPo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AsY2VCuVlrqIBhA6EmKi5hIeVogGFT6ApVMWmdNgzvDUgw7W0pBjdY4AHnQt6mCyAwvpHXehjXZZO9kwELDQ8G3J6ipy61zZNg3wlQoHhAZVONuvWp3lGeNYOvLRb1Cwt4dcm/TfhCWmYCIiIIktXaKtRX7dFwo9fFGT664tcmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=josefsson.org; spf=pass smtp.mailfrom=josefsson.org; dkim=permerror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b=AMrFhA/S; dkim=temperror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b=FMnDSg6I; arc=none smtp.client-ip=178.174.241.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=josefsson.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josefsson.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b="AMrFhA/S";
	dkim=temperror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b="FMnDSg6I"
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=josefsson.org; s=ed2303; h=Content-Type:MIME-Version:Message-ID:Date:
	Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description; bh=jxBbMN0q6EGLn65T/pyvm6NlEmFMqTtWcjSjwkbd+Y0=;
	t=1741780733; x=1742990333; b=AMrFhA/SPZwe2EbYYWGLEzrypBY54+yauglZisFTwiz8/1v
	DyBcliAIzem9VcfzhI/jaNNqy2g4N6rbZSJ5CBA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=josefsson.org; s=rsa2303; h=Content-Type:MIME-Version:Message-ID:Date:
	Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description; bh=jxBbMN0q6EGLn65T/pyvm6NlEmFMqTtWcjSjwkbd+Y0=;
	t=1741780733; x=1742990333; b=FMnDSg6IHqUTnmbV+odOjej+8cWctFaSlvKIrohGRjEMxYS
	rS/zZ+T8i5Cur8i17CS4M6DPyqHW1ZtbvaUduLHp2xp0flx/qODe8MvwotCIlHOe8Utjh82UHNR2C
	11713iS9A8sQ1NaUVUC+OPZ5t+VDM/i8dwtjPs7fLAUkh7P3SLTFgOE/nAAl/1nGMPXk8Eq2y3aqn
	KKlQo6FWxp9zZhOkV7bvNvTLUEWITdH/FC4YeSV74R96lxuAr0OfrjDfvqg/S96uK0tbDiG8cw/GN
	AAGlqYX1dYM7U+UR4u6utxspTdko6dlk36u6yzdkOjPcfB0I2G+MfaNcatBMgJCNHy+0oGCex4RSD
	j0SeMiv7X2oK5ySjppdOwdSMa2ADxOgKiaa2Dyhbiyx2y3xw3h7IlyoPc5xX8CcJx3uvqGCfbHQxe
	gqnFiXuvsom9BDY7U98+RC+M;
Received: from h-178-174-130-130.a498.priv.bahnhof.se ([178.174.130.130]:47958 helo=kaka)
	by uggla.sjd.se with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <simon@josefsson.org>)
	id 1tsKRh-00GDZd-74
	for git@vger.kernel.org;
	Wed, 12 Mar 2025 11:40:21 +0000
From: Simon Josefsson <simon@josefsson.org>
To: git@vger.kernel.org
Subject: Making bit-by-bit reproducible Git Bundles?
OpenPGP: id=B1D2BD1375BECB784CF4F8C4D73CF638C53C06BE;
 url=https://josefsson.org/key-20190320.txt
X-Hashcash: 1:23:250312:git@vger.kernel.org::Gva/lkjr8EsOX0WA:Sf/G
Date: Wed, 12 Mar 2025 12:40:05 +0100
Message-ID: <871pv2jx4a.fsf@josefsson.org>
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

Hi.

Thank you for the "git-archive" and "git-bundle" features, making it
easier to do source-based builds in a no-Internet environment.

I have published a Git bundle of Gnulib:

https://www.gnu.org/software/gnulib/manual/html_node/Gnulib-Git-Bundle.html

As you can see at the end, I struggle to come up with a recipe to allow
others to reproduce the git bundle that I created.

If I run the recipe above twice (including the clone), I get different
checksums.  This even if nothing was committed in the remote repository
meanwhile.

Is it possible to create a bit-by-bit reproducible git bundle using some
other set of commands?  If so, how?  I'm using git 2.48.1 from Guix.

Can anyone explain what is causing the irreproducibility?  Running
diffoscope is not helpful, since the bundle is compressed and diffoscope
doesn't seem to know how to untangle it.

If this is not possible today, what do you think about changes to make
this work?

Thanks,
/Simon

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQNoBAEWCAMQFiEEo8ychwudMQq61M8vUXIrCP5HRaIFAmfRcpUUHHNpbW9uQGpv
c2Vmc3Nvbi5vcmfCHCYAmDMEXJLOtBYJKwYBBAHaRw8BAQdACIcrZIvhrxDBkK9f
V+QlTmXxo2naObDuGtw58YaxlOu0JVNpbW9uIEpvc2Vmc3NvbiA8c2ltb25Aam9z
ZWZzc29uLm9yZz6IlgQTFggAPgIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgBYh
BLHSvRN1vst4TPT4xNc89jjFPAa+BQJl/YgIBQkLehFUAAoJENc89jjFPAa+CboA
+wUa06RD5e5VTCxvSWtPS75Wq2qBeYGZnf0jvUMxa2n4AP4xkUeAPPnNuMsTm2fs
FCDIGaEM2Yn6Vb2huzzT1Fw/BLgzBFySz4EWCSsGAQQB2kcPAQEHQOxTCIOaeXAx
I2hIX4HK9bQTpNVei708oNr1Klm8qCGKiPUEGBYIACYCGwIWIQSx0r0Tdb7LeEz0
+MTXPPY4xTwGvgUCZf2IKwUJC3oQqgCBdiAEGRYIAB0WIQSjzJyHC50xCrrUzy9R
cisI/kdFogUCXJLPgQAKCRBRcisI/kdFoqdMAQCgH45aseZgIrwKOvUOA9QfsmeE
8GZHYNuFHmM9FEQS6AD6A4x5aYvoY6lo98pgtw2HPDhmcCXFItjXCrV4A0GmJA4J
ENc89jjFPAa+GcYA/26YQY05bLtnXiIjTiAzrGQrRXxTHPA8Av7TDFHvIetWAP9s
HSoU8OfTwmTiEnGwLlsV7QJclZg3YNz/Ypcp9TqQBrg4BFySz2oSCisGAQQBl1UB
BQEBB0AxlRumDW6nZY7A+VCfek9VpEx6PJmdJyYPt3lNHMd6HAMBCAeIfgQYFggA
JgIbDBYhBLHSvRN1vst4TPT4xNc89jjFPAa+BQJl/YgwBQkLehDGAAoJENc89jjF
PAa+phoA/jrDqIrl/55vUMBhIQv+TP635d2iCTEnyFmbUcP9+gh6APoDsXalVd2c
OGxQtSC+TF8PkZMn1TLkJKAjVxr+xx40AgAKCRBRcisI/kdFohlQAQDBjqFWNqqz
5Orm9Ge0/7NbSehs7NgCBw7b3QOC+zjpjgEAw329A0W8RgzlbCZ0L1Gf5+joMO90
FwUFGbfc07SrVQQ=
=dJYG
-----END PGP SIGNATURE-----
--=-=-=--
