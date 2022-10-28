Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A17ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 22:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJ1WWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 18:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJ1WWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 18:22:03 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F081DB244
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 15:22:01 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 653085A1FB;
        Fri, 28 Oct 2022 22:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1666995720;
        bh=NeSJ0lbO14X7okdc2q9kwpzXPyktyIoA5RmR3T0l77M=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dxCXKnhBVRZO5956sCfIBQUTxaJ9lC9FkwFF26IZBFl6eEk18emowZKT8rI3BI385
         mo/Phm66s9VytXzYLHF63Njf8D8JdQ3WrBsIYZcT1Dh/HWMYr0ktp9iTYkEH8FYKKX
         LU3cwbFAMmI+edpWrK3Jh2UzF2CR6700uNFurQRQQutgVSwMSKqMq+9hlFfBMJkya3
         XV9V9i3PxpzEx0U3j1UaqdqR+iYqKtVFkqgJVP1FMpUi5AJ9O5SvpJ+9A5vUc5goBV
         aHNbe88cFh8CGhY7FHN/esU6zzaYflIgMKKyF6t4La9HVwOPn5u84+jOoXwdM826Po
         72V5GjrZXujLE42PaSXQd1224Qfi3a9ebopdBsbNgOE47hqgK/WkCwaIyl3MXyLV1M
         ejW+HBnnj7ZPT0YZx4U4AsybBKl4u7qfHHgL+Y4to5Pn9Mr8ymJgIzXgA2swJPYrUs
         7SleB8rFDg2GH0Y2gDXnKYP4xlMPO4O0elYYYY2YVOMwYvV2ZSV
Date:   Fri, 28 Oct 2022 22:21:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Julien Moutinho <julm+git@sourcephile.fr>
Subject: Re: [PATCH] adjust_shared_perm(): leave g+s alone when the group
 does not matter
Message-ID: <Y1xWBiZUAbPmt71W@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Julien Moutinho <julm+git@sourcephile.fr>
References: <xmqqr0yrhco6.fsf@gitster.g>
 <Y1xNrDB10XEcAa0d@tapette.crustytoothpaste.net>
 <xmqqbkpvhb0x.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/ZqdbqXfuuuaHyrk"
Content-Disposition: inline
In-Reply-To: <xmqqbkpvhb0x.fsf@gitster.g>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/ZqdbqXfuuuaHyrk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-28 at 21:51:42, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On 2022-10-28 at 21:16:09, Junio C Hamano wrote:
> >> Julien Moutinho reports that in an environment where directory does
> >> not have BSD group semantics and requires g+s (aka FORCE_DIR_SET_GID)
> >> but the system cripples chmod() to forbid g+s, adjust_shared_perm()
> >
> > I would personally use a different verb here because I have the
> > impression it's offensive, at least when used as a noun.  Perhaps
> > "limit" or "restrict" might be more neutral, or we could pick another
> > verb which expresses our displeasure at this design (maybe "impair"?)
> > but maybe is less likely to be emotionally charged or offend.
>=20
> castrates? butchers?
>=20
> tweaks?  That's quite neutral.

I think "butchers" or "tweaks" should be fine.  I might say "modifies"
as well.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--/ZqdbqXfuuuaHyrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY1xWBQAKCRB8DEliiIei
gfnXAQC8evYsFPP1ecEjj+eDGrCC1wxNs4rgus+xONa7qI+d7QEA+TIb0Sxx1Pi7
9oCWMhw81smbVCHnQoJ1m8LU8cPpGAo=
=F2Yl
-----END PGP SIGNATURE-----

--/ZqdbqXfuuuaHyrk--
