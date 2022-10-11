Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAF4C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 20:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJKUlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 16:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJKUls (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 16:41:48 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF3118E1C
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 13:41:46 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 377245A12A;
        Tue, 11 Oct 2022 20:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1665520906;
        bh=OQD7FjuRKGMB4iPlvjO/xl6hJ0VVLvt6f59E5EmDi/I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=02aWaJ84SH0P6xm52L3xcV3T6snaSycCzkYFemkRCFu/y24Kt+STm/nbOyGHpvZO3
         eF6O1wvrfUlH8v50PD9cdSwjjgfCGHXpYXBCmnkbe7PHqFZYMOUoTpLgIoSC9J5ZYl
         CKcaJjpchOhcSEpiiGDhHiOwu8B9QaGj4ASBLFBgUK9ptOgw09WitiCy1CTkZocL9Q
         AN/1Gn/f77VdWFe2MMMF9zLiE5/0q5S9pHdqRMiApuBeZk1cQTSQhIspS/mbEB6Vb8
         SR6z+24dOqiCsUklpd5xy5/LAip++eJm8DlShlLcv5x9vI+Lu/s1sxwa1kh27JJpEq
         q2mUhIyQ4eATO8cqkkPKLoj2T3F8Mx/dniIB/olhM3Y4zSvNfR5De4JtUgc3Bp3F0u
         +KlBTpQ9KUye5xtlpStutYibTM/lf3xD3mYIyRFGKoqO/MkjkHcvIkWx3YQQNu8InY
         QIB9AzoivW2WeE+0Nl6iNNeDgJVqecMmD3hRZJ3YKdu0IdOEvat
Date:   Tue, 11 Oct 2022 20:41:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Nicolas Graves <ngraves@ngraves.fr>
Cc:     git@vger.kernel.org, Cuckoo Aidan <aidancuckoo@gmail.com>
Subject: Re: Error / feature-request: Signing git commits with SSH hardware
 key
Message-ID: <Y0XVCDu9o3xDnt81@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Nicolas Graves <ngraves@ngraves.fr>, git@vger.kernel.org,
        Cuckoo Aidan <aidancuckoo@gmail.com>
References: <875ygqw7p8.fsf@ngraves.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NN4VLzKn/auyOW4j"
Content-Disposition: inline
In-Reply-To: <875ygqw7p8.fsf@ngraves.fr>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NN4VLzKn/auyOW4j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-11 at 18:12:19, Nicolas Graves wrote:
>=20
> Hi!

Hey,

> I noticed git commit signing works well with ssh-ed25519 keys, but does
> fail with sk-ssh-ed25519@openssh.com SSH hardware keys (with can be
> used to clone / post to github for instance).

I was surprised to hear that, so I just tested on my Debian amd64/sid
system, and I was able to sign and verify using an
sk-ssh-ed25519@openssh.com SSH key using my YubiKey 5C.  I do believe it
does work, although when the signature occurs, there's no notice that
it's waiting for user interaction, so you just have to look at the
lights to determine that the touch is needed.

Could you maybe mention what version of OpenSSH you're using and on what
platform?  I used 9.0p1, and as I mentioned, it's Linux.  The output
looks like so:

  $ git verify-commit --raw HEAD
  Good "git" signature for sandals@crustytoothpaste.net with ED25519-SK key=
 SHA256:PNxAWB7cxxxrCTbgsdoDq71o3rCm9O7Er4q+0YrEAdM

Specifically, what error message or other indications of failure do you
see when you try to sign?

> I also noticed a similar error in a previous mail from Cuckoo Aidan
> <aidancuckoo@gmail.com>, but he doesn't say which type of key he
> used. In any case, would that be possible to include the info about
> which type of keys cannot be used to commit in the github guide
> https://docs.github.com/en/authentication/managing-commit-signature-verif=
ication/telling-git-about-your-signing-key#telling-git-about-your-ssh-key) ?

We don't control the GitHub documentation, since we're independent of
GitHub.  If there's incorrect information, you'd need to contact GitHub.
However, as I mentioned above, I do believe this works at least in some
cases.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--NN4VLzKn/auyOW4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY0XVBwAKCRB8DEliiIei
gUWWAP0VXCfJUf2nWjrYAQvFPc9SP/1pwh2Xw9sai9LS+4CFngEAwpXsjMn1lXsb
hL+IQ3OrJ2+ioHKJj0MlmOZE47GC4wA=
=rrJS
-----END PGP SIGNATURE-----

--NN4VLzKn/auyOW4j--
