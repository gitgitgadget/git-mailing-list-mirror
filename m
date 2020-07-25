Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D92C433DF
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05CA0206C1
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rZRKPFD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGYB7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:59:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40622 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbgGYB7r (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Jul 2020 21:59:47 -0400
Received: from crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 70ABD60479;
        Sat, 25 Jul 2020 01:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595642386;
        bh=AGm9gjezk+3jSvSA69nFoWRZlWtySRAHM6d/cswMlnE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rZRKPFD9nn7IzodWlK21PvVQvrJ5o/DAuEqsi/lV0ZnOEfx0GOjqhTZ6zqRmOz34D
         24M4wGPbHPMuPjUjxBjpf+LmsnryqpxetG2vZ38ZbS7jIBQqQVcfasqsMxlF0kcj6A
         +kNA8CMcqQoZmN00tXPUgF75cTvZ4ZfRaMXXssAIwIgfuyXsQ4jdoZJ2zA8j/ymhZT
         4aKsYUJMta817Y3VdnBbHlwCkw8BwNa6GBpDWNiODx66KUNgyFe0wkw9Wu3czSy+KX
         mDNsHF7bhF05BbSqed7WVK4KGeqv6Nz+s8atpWF6CARkPbeBIiepM5RbEG58pbqZgi
         qYWH4Y3WUt+I/ue286W630LBHH8J1XExfRJmzCb+OGexio55OH7Go/4h7FnRslhiVz
         Re4gGNvYMxXq/WhTNubNNJHmeSyWprn/vQVMpbkOKPZAD/Gv93ALzNrK750zzhI0yV
         VaGjVse1bCPytD39iavpsWcR7nIHUQGZ11lsYCVpxlt5Ahfm3Nv
Date:   Sat, 25 Jul 2020 01:59:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 32/39] setup: add support for reading
 extensions.objectformat
Message-ID: <20200725015941.GB2395079@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
 <20200723010943.2329634-33-sandals@crustytoothpaste.net>
 <xmqqblk73s1n.fsf@gitster.c.googlers.com>
 <20200723023900.GA1758454@crustytoothpaste.net>
 <xmqq4kpy50k6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <xmqq4kpy50k6.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-23 at 04:15:37, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> >> By declaring that the repository is invalid if its version is less
> >> than 1 and objectFormat extension defined, we prevent unwanted
> >> upgrading from happening by mistake.
> >
> > Yes, and more specifically:
> >
> > * If the repository is v0 and has an objectFormat set, we fail in newer
> >   versions of Git (i.e., after this series).  Older versions which do
> >   not support the extension will see breakage (because unknown
> >   extensions are not fatal in v0), but we hope by adding this check that
> >   nobody will ever configure a repo this way, since it will be totally
> >   nonfunctional in this state, regardless of version.
> > * If the repository is v1 and has an objectFormat set, we work with
> >   newer Git and everything is great.  Older Git versions fail hard here,
> >   and the user gets a moderately helpful error message.
> >
> > v2 of the series just ignored the setting in v0, which would make it
> > equally broken in older and newer versions, but would provide a less
> > useful error message (probably about a corrupt index).
>=20
> Peff's 'jk/reject-newer-extensions-in-v0' uses a bit refactored code
> to make it easier to add only-v1-and-later extensions while rejecting
> them, even if the code knows about them, in v0 repository.  Even
> though the mechanism is a bit different, the spirit is quite the
> same as this step.
>=20
> Please double check origin/seen:setup.c to see if I resolved textual
> conflicts in a sensible way.

Yes, this seems quite sensible, and exactly the resolution I was hoping
for.
--=20
brian m. carlson: Houston, Texas, US

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXxuSDQAKCRB8DEliiIei
gczfAP93fQc0CGKWUumuyle/FCvWhmuptVzO7E0+wZoW2RAn1gEAzylcojj1FVpD
/dFXCVBvB7y1WRVSNa92OiIvarbQgAU=
=xRwL
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
