Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51AE01F453
	for <e@80x24.org>; Sun, 23 Sep 2018 15:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeIWVvk (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 17:51:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39082 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726223AbeIWVvk (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Sep 2018 17:51:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:596e:6738:f59:e0e0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E64C16046C;
        Sun, 23 Sep 2018 15:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1537718024;
        bh=NOhMkGYSWTphs9qADHvPfH5UPMsspgyYAgBrf0TE8AY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XvXAsqNqLYOUHubsItxN1vj05mO1wraGFOKOcxSeFaW+VBi9ZJbeC20FpLMjNYT42
         0KMpStQftmFS85PhKbv5qXnJHiLo3vvXcqjcZzQLgmenxDVk2C2AsrKAnXe9ccYewh
         /PdITrjNt0o/Th0uZwMCTQcCq0qd2zIaDGb1sKMHtNstHFfpYtfYKOkhyy5yAnfblc
         dknUDcfS6jcgRbH7c6ro6mPbJZpAzZ7X356chqmwbqOxxi0KwqY1NLx2rz7LXu2G2+
         VuEEfpnlRkVNG3UthyP44bgN2obZN1yG53ydKZxrUEcDFsc/GHso2aC9jDAtWvNUtv
         h19CJKTSWS0Z385e5Dj+sa/j85UH+i4pbnjqWwn//tcAmG6Eq14i7gMHGBYuq0rBmQ
         +AVQCJMnt5qLd/JMbB4AAaMfjAjiLn275Nj43+AHLNmIh+WmoxRPjWTEKbWixiB5CS
         wEwQz9h/jz9Uj6MtQOrbRwKLlfUB2NdEwYqYomaGJvCnuhrqDk0
Date:   Sun, 23 Sep 2018 15:53:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: Import/Export as a fast way to purge files from Git?
Message-ID: <20180923155338.GF432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
References: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bina0ufSB9dLMnVr"
Content-Disposition: inline
In-Reply-To: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Bina0ufSB9dLMnVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 23, 2018 at 03:04:58PM +0200, Lars Schneider wrote:
> Hi,
>=20
> I recently had to purge files from large Git repos (many files, many comm=
its).
> The usual recommendation is to use `git filter-branch --index-filter` to =
purge
> files. However, this is *very* slow for large repos (e.g. it takes 45min =
to
> remove the `builtin` directory from git core). I realized that I can remo=
ve
> files *way* faster by exporting the repo, removing the file references,
> and then importing the repo (see Perl script below, it takes ~30sec to re=
move
> the `builtin` directory from git core). Do you see any problem with this
> approach?

I don't know of any problems with this approach.  I didn't audit your
specific Perl script for any issues, though.

I suspect you're gaining speed mostly because you're running three
processes total instead of at least one process (sh) per commit.  So I
don't think there's anything that Git can do to make this faster on our
end without a redesign.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Bina0ufSB9dLMnVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluntwIACgkQv1NdgR9S
9otsdw/8C58pb45BOU6/NQl6PMHLN/kPbEKvDpYNaWH/ETwsJAeNKPREEZRMRa5F
Ifj/Jhx7+SaKS/LaVbVelgd57lrfIrq2sH+LV1LmUYMkxNAsy54DDC0X7Uf1FjRJ
D8uKIypLtcw1yzr1BFTvT/wsuYI4XpT+lg5WBUb9Y9pCUZy6FTN5O6HLnfvahDJc
+2CpvmmpsC3wkLUYWRpt5EgcvAEFi/vywUiXrYBALVpy+ze2Rh6IOhoyizRq7YWc
w3oxSupOthdUV/rL30p+s9UDSilEf8SBqx2Rux1OEX01OKVno9oKTHJBp+y32pcy
XKCk4wXAVgs2DsyOtiGAWFuogpnh903QoA8mFnsIU/soq8lO4xx6X7dlfcO/aBng
inMhuTXSEkUAwWy9Ya5MWSjjF4sqYWe+cKC6mRGCHSA4jrnxv1OM0TxlYSowxfAP
QkYSuFdMXP1bMCS5/RHbjQltBP04YbuJat4sbOsIZyqeHnOgVONnbV9fUMFYMre1
NbXbMNHzA+sx8Ci4J2eGiU7HTw/B45DJSVWDIiYuqfOj7en7cMYttisfd0YuMjG/
2DRzsey4n+3W2vlg2GCdZQO41agtZtmc++pTxWxzhvyEpR5Kt+BK3hL5KZb71cCw
gPshh3aJFuEeDQzH41cQZr+o4oOuw6YcpcheeYy9dmYa6k1TlSw=
=krSy
-----END PGP SIGNATURE-----

--Bina0ufSB9dLMnVr--
