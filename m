Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA8DC388F7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 01:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD08206FB
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 01:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbgKFB5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 20:57:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35432 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730414AbgKFB5P (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Nov 2020 20:57:15 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6948D60752;
        Fri,  6 Nov 2020 01:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1604627833;
        bh=SHlQ8oK3bB90Ez8fjlgCMKj6CsuGA3AldPh7nyK5/kY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rjQspR9hoRkkzQ2hcX9AqSCXM0bK7dpK3TDkYDDmWY6PkNwqdqw91cFtwEbuFVhJQ
         yHw4GKwQDd8yF0LpaxGFhyaYcSrWGhf5KCN+z+Ia5bU3MFjeMrH2hDFo6cUmWvLkIQ
         37r/lQmPEHwtC1ABntVGfkH2TZT3I1JHbI+r1OmmQ0LL83ukMs7bjC/d3Zy7omrkvm
         kNmEg5ZKflO+E0FsvDvywuOFkWRHVEajpoZ/615zuHKR6R1VGmrhV3JglUFWNxNGSy
         Y6rpQ0NvxaI43awgUkwyhdRg71LI1X5bIAbO9geZdi/l2co/Ws2ZY2+m8TK3V4Nt5w
         bk/ot1dqMX4qTJ8hD7k5dLqP+QiaZGDNNyvChyEgJzUU9wM8xqNkPxn71ti7qzEiTj
         zOfhvhNcM0tHBS3/c+MuP/ICRIlyAAVoe0UBEl18r/CCJM10O43WpDOAZCV+7VS7N3
         zKVO9skGmelLQ/jgShVnw5modWNkc23Rj6yX4zaJE2kV2Td1Ctm
Date:   Fri, 6 Nov 2020 01:57:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rev-parse: add option for absolute or relative path
 formatting
Message-ID: <20201106015708.GB6252@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
 <20201104221659.GA3183353@google.com>
 <20201105031153.GA1332931@camp.crustytoothpaste.net>
 <20201106005110.GA3479573@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <20201106005110.GA3479573@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-06 at 00:51:10, Jonathan Nieder wrote:
> Ah, thank you.  So if I am understanding the above and [1] correctly,
> this means:
>=20
> - when a path is within a repository, converting it to a path relative
>   to the repository root
>=20
> - when a path is not within a repository, learning so
>=20
> and that making relative paths with ../../ portion that exits the
> repository is *not* an important part of this use case (though it
> could be useful for other things).

Correct.  I felt that adding an --absolute option would be less
beneficial than both an absolute and a relative option, so I implemented
a more generic solution, even though my use case didn't require it.

> Thanks much.  I think this tells me enough to understand the series.

Sure, thanks for asking.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX6StdAAKCRB8DEliiIei
gUfVAP0UQAASgoVqNVyTs281XggwYiMetQzMzOPDlrsGsHGmGQEAo16iAD0I8z9D
RVd7tqjlzPwOjpAD2O42VM8i3HiiRQk=
=J0pC
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
