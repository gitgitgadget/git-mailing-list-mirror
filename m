Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE01CC433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 00:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A172A610F7
	for <git@archiver.kernel.org>; Sun,  9 May 2021 00:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhEIAVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 20:21:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50472 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhEIAU7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 May 2021 20:20:59 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1F6346042E
        for <git@vger.kernel.org>; Sun,  9 May 2021 00:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620519597;
        bh=S4VsXATtgd4DKkg1xG2ijRgu1pvr6rN3HeH2RK1y+Dc=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QJabdy+hWgpC3y401vQMnxhzazZ7PrbkZGcXT4nWxYmiZVQPxV0Je0k6M+/kwCltJ
         h+0ZxuNpvm9LXKc5Lku2ckpRStH0Fl5gIw4SFK8DaSe3lImNgLnW6P68CbeujyMvgV
         zZv4GLWUkZS8/4mtdql2AOoWsdTjDNi2vyZyxGrLBBJObKIpZKQFKOgYj5SYJqJKwB
         DNNvA47+HpibY84mjTU9MZ84R9vGT0n+jEt/G6TeuJ2VPIoEBdPAIjpRGKIUrPqPEk
         3oEzyDwey2uRBEYB/rpt8BlCXeOSjzQXxkrJ0zssEa2TR1qBuph3I0GDZpCLOk39fc
         v8WKM0u0gXQmZe1KoslsGW4Nc89UTd92T/21YZzpLnFLD9ShVgsXPfuxruq+5PMkkU
         Sw7voOBfffyi9823wN+quw9lDQqQpc7tOvaAEt6K+3YeHP5++jkd5Xrf5WtwXdeXAd
         ph16oo6uSe1LnsbP6BTYs3T8LUuAni1Z+A0VhExE4mkNRHjNtCB
Date:   Sun, 9 May 2021 00:19:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Re: Preserving the ability to have both SHA1 and SHA256 signatures
Message-ID: <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20210508022225.GH3986@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="68IKpQnvCtiNDPC0"
Content-Disposition: inline
In-Reply-To: <20210508022225.GH3986@localhost>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--68IKpQnvCtiNDPC0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-08 at 02:22:25, dwh@linuxprogrammer.org wrote:
> Hi Everybody,
>=20
> I was reading through the
> Documentation/technical/hash-function-transition.txt doc and realized
> that the plan is to support allowing BOTH SHA1 and SHA256 signatures to
> exist in a single object:
>=20
> > Signed Commits
> > 1. using SHA-1 only, as in existing signed commit objects
> > 2. using both SHA-1 and SHA-256, by using both gpgsig-sha256 and gpgsig
> >   fields.
> > 3. using only SHA-256, by only using the gpgsig-sha256 field.
> >=20
> > Signed Tags
> > 1. using SHA-1 only, as in existing signed tag objects
> > 2. using both SHA-1 and SHA-256, by using gpgsig-sha256 and an in-body
> >   signature.
> > 3. using only SHA-256, by only using the gpgsig-sha256 field.

Yes, this is the case.  We have tests for this case.

> The design that I'm working on only supports a single signature that
> uses a combination of fields: one 'signtype', zero or more 'signoption'
> and one 'sign' in objects. I am thinking that the best thing to do is
> replace the gpgsig-sha256 fields in objects and allow old gpgsig (commits)
> and in-body (tags) signatures to co-exist along side to give the same
> functionality.

You can't do that.  SHA-256 repositories already exist and that would
break compatibility.

> That not only paves the way forward but preserves the full backward
> compatibility that is one of my top requirements.

I've reviewed your proposed design and provided feedback that we need to
preserve this functionality in your new design as well.  People will
want to have that functionality.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--68IKpQnvCtiNDPC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJcqqAAKCRB8DEliiIei
gVcnAP9PDRzYSh8KvFLIorvypf6xpRqX5LiWbdYtHijxPIlcIgD9FWYU4HB5+p7U
Q/jRnY7CxK/+9/4FzYr69V1eIEMC3wI=
=f/n3
-----END PGP SIGNATURE-----

--68IKpQnvCtiNDPC0--
