Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE95C7618D
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 22:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDEWsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 18:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDEWsk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 18:48:40 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B8B1BC6
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 15:48:39 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2E8D25A215;
        Wed,  5 Apr 2023 22:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1680734919;
        bh=qOpHRpiAA7B5sXU6zmBty6fqiRUSut574HcdfjO5ync=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uR12lCOHa+68336GVAG7hIHbSVWzfXEo2tPswHeTeJDGDLO5wonE+m8HOzq37jh+Q
         HGrf4/0wkZU/DGWd+kw33/EFRKwx6QXf6kHgPTSEU7GU2f4RHT71A+KTO5m5ki07Un
         Ci+lPEDRMyci79tO+8udISDyF6pmJVQ3Qv70keZ0EgNn13NjNn/WEze6C0Qhha19xV
         EHKfESp88EhHKYzUzeaN4N9R79M+RounfrtZVjQjA3v1jLohTcb1H7kBj7M6Jf1zW6
         HQdS8gJCCrAVvtbgc6iZ77aLEGzd1qJ3aluokqNWy9rYIoiPxlnPZTzEaBkKDU7laL
         aP8U31HG79at8mhnooA9CuSdym+LfHwMJ1oSFTQpgxQgdhr40iO/KsfsDiklpm+YZw
         BzpZ7gso+T2wx8Ig6YLhnjhfFFVDRPEkr/X5PBvwn8kaA7Gh1qNxJF7w0gZqNxeQVY
         Cnf8yTYVYUuHk1VE2BraNMlN1jZlBsQ8UEVKjVeyqzyfhW6zYyU
Date:   Wed, 5 Apr 2023 22:48:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Adam Majer <adamm@zombino.com>,
        git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
Message-ID: <ZC36xXGBIAHcetZW@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Adam Majer <adamm@zombino.com>, git@vger.kernel.org
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
 <xmqqr0syw3pe.fsf@gitster.g>
 <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
 <20230405200153.GA525125@coredump.intra.peff.net>
 <xmqqa5zmukp5.fsf@gitster.g>
 <xmqq355euj2i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FuvS6MsRDC9Q9LE4"
Content-Disposition: inline
In-Reply-To: <xmqq355euj2i.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FuvS6MsRDC9Q9LE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-04-05 at 21:15:33, Junio C Hamano wrote:
> A user could prepare an empty repository and set it to use SHA256 as
> the object format.  The new repository created by "git clone" from
> such a repository however would not record that it is expecting
> objects in the same SHA256 format.  This works as expected if the
> source repository is not empty.
>=20
> Just like we started copying the name of the primary branch from the
> remote repository even if it is unborn in 3d8314f8 (clone: propagate
> empty remote HEAD even with other branches, 2022-07-07), lift the
> code that records the object format out of the block executed only
> when cloning from an instantiated repository, so that it works also
> when cloning from an empty repository.

Yeah, this looks like the right thing to do.  I know this did work
originally, at least for protocol v2, but I may have neglected to add a
test when I wrote it and it regressed.  Thanks for the patch, which I
think is obviously correct, and adding a test for this case.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--FuvS6MsRDC9Q9LE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZC36xQAKCRB8DEliiIei
gYwDAQDP3n/NfIfrvrogXitpnhVZjSY1lDjxajzNTZ/VyQcMKwEA6xQujzbHP5SN
BqQXjkeur3cqxOtMBgjSAui/5kT5ng4=
=7fHe
-----END PGP SIGNATURE-----

--FuvS6MsRDC9Q9LE4--
