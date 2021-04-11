Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E89C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2DE61007
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhDKVwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 17:52:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59456 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231405AbhDKVwJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Apr 2021 17:52:09 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BFD2D60422;
        Sun, 11 Apr 2021 21:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618177882;
        bh=SSf7QbYR2AIJSGIZ7FhMriUcCJYA9ge7C9wlO2E7p5o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BOxJKsa4pAH/6LerhqWO2TI2VJd1hodQdar60ddx+rZw06oWb8VhDBRZ2vf9mgsCW
         Gjfu6rNDpDkyFEQAKJEvOKBjpjzxBbbQBrMprXrwQJoeATNFbl0pitASqq8aweKy74
         Ax27OwKdM9gss4/hIGDkvePXtBSZB/pUDUjmzbZueeynFOtU3DFcT3cvZT48+6cALM
         MFPel5S8BeAirEqXi/MRFn367hmawCRgQ0SBNnQrKv/x333p0ymfGxG490/4N5YdwL
         zQKPzIxyMOKIeQqSxq2zjtzIk8fFVBaj0M0bhloANyi1HXv2TdMo+B8ivYEmVWOp7m
         r3/gNa0VLc+gXpIddCRMvBKg1TH814OehdIa0CTaggSnjEVttCZCcOHx1cxiFFivN3
         g1VK4J3Bnl9enJ2GnVldKwS8JMebowYz3tIiCcQhTgfx/rH2cVZXB10VZBHnhAaz7d
         TbA4OZ8cERUdw4maX1Pu4bCnxZ1VUCs94IIH5HnldwTEcwnjHvB
Date:   Sun, 11 Apr 2021 21:51:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 10/15] hash: provide per-algorithm null OIDs
Message-ID: <YHNvVWyRK3bfS/ZL@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-11-sandals@crustytoothpaste.net>
 <xmqqy2dohqau.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Dxr/v+16tjxjVk6"
Content-Disposition: inline
In-Reply-To: <xmqqy2dohqau.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9Dxr/v+16tjxjVk6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-11 at 14:03:05, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > diff --git a/object-file.c b/object-file.c
> > index 5f1fa05c4e..50bb5b6ca4 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -55,7 +55,6 @@
> >  	"\x6f\xe1\x41\xf7\x74\x91\x20\xa3\x03\x72" \
> >  	"\x18\x13"
> > =20
> > -const struct object_id null_oid;
> >  static const struct object_id empty_tree_oid =3D {
> >  	EMPTY_TREE_SHA1_BIN_LITERAL,
> >  	GIT_HASH_SHA1,
> > @@ -64,6 +63,9 @@ static const struct object_id empty_blob_oid =3D {
> >  	EMPTY_BLOB_SHA1_BIN_LITERAL,
> >  	GIT_HASH_SHA1,
> >  };
> > +const struct object_id null_oid_sha1 =3D {
> > +	{0}, GIT_HASH_SHA1,
> > +};
>=20
> sparse wants this to be a file-scope static.

Can do.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--9Dxr/v+16tjxjVk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHNvVQAKCRB8DEliiIei
gUhsAQC0wYglGR/Fo+5e23VkcgjVkdS/Tw4Q3pk7zWAVz1FtwwEA47tmRAenFsW/
qxatl1/XcQi610Yf/7wSgttzBLo6Kgs=
=MeOA
-----END PGP SIGNATURE-----

--9Dxr/v+16tjxjVk6--
