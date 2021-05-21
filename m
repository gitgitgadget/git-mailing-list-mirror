Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17EBC433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 01:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713306109F
	for <git@archiver.kernel.org>; Fri, 21 May 2021 01:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhEUBfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 21:35:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47370 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236826AbhEUBfx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 May 2021 21:35:53 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4926E6043F;
        Fri, 21 May 2021 01:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621560840;
        bh=X+ddimYoZGHi7RRYEQ/XugSAmQQzjv/4q4ErZNSQVW0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zKJaQGRPgicl8guRJzNsPb/+nvgUO935FFQggFDYgXRV68bNJq520N5RhCdSQouUt
         ORRDkhM5nkgK9+93r9FEy3IYwL4YOv/cBUJhpX67YJG+f2FPi+qh80dKW2Avu08/NL
         zODtwvN56HUn3adQiO1tYAlkDpMVDzuPzjugGUyd2mF4XqJPQKWBrbpOgKrrCskJpp
         CJK7/VtSkVlYMKByXBfGhpnnRPaO/8ZCYu8jaox0o7ofUoo7s68kcES+UcdjQrA0Lq
         XyWUTcPD7+3/gFYSzHDxEJrmuCANYSsIIorCZ9H/6bF2EqaODsVYIyLG/GHcZTdle+
         /d4158RKx/QPdLAUKAhA10vylZRk5K+H2Kc/czxArJiTHhp8JYof+jnR6nlzqmjRdH
         PoZIri8oCBaekTrrsOttM1dPZB4TmIHok9TC9YNtsOxibteNT9ktubdeTgUkOtW6JW
         Yd3B3LlEcujxukj8RLzED9K7i4Yg0JxJQo7NASjQqujoL5VmFJ4
Date:   Fri, 21 May 2021 01:33:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: RFC: error codes on exit
Message-ID: <YKcOA7iVstB7LtZH@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <YKWggLGDhTOY+lcy@google.com>
 <795fd316-2bb5-e382-b104-85d1aaa09a1c@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gPNhJ4uAR+JONCy1"
Content-Disposition: inline
In-Reply-To: <795fd316-2bb5-e382-b104-85d1aaa09a1c@jeffhostetler.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gPNhJ4uAR+JONCy1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-20 at 15:09:44, Jeff Hostetler wrote:
> For the error event that `error()` and `die()` and friends generate,
> I emit both the fully formatted error message and the format string.
>=20
> The latter, if used as a dictionary key, would let you group like
> events from different processes without worrying about the filename
> or blob id or remote name or etc. in any one particular instance.
>=20
> Would that be sufficient as an error classification and something
> that you can key off of in your post-processing ?

I don't think that's going to be sufficient.  Many calls to die()
contain a translated string.  I am a native Anglophone and work in a
company where English is the sole language of communication, but I have
my computer configured in French, and I have had it configured in
Spanish as well.

It's totally possible that one of my colleagues who has a non-English
native language might be using a different language as well, so it would
be difficult to reliably map the format string into a fixed error case
in a typical corporate setting, since many languages might be in use.

> Granted the same format message might be used in multiple places in
> the source, but I also provide the source filename and line number.

The source filename and line number would be more helpful, but
inconveniently, people frequently change the code of Git, so the line
numbers aren't always stable over time.  So I think an error code would
be helpful nevertheless.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--gPNhJ4uAR+JONCy1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKcOAgAKCRB8DEliiIei
gdiOAP9I0OokfRB9dfynOoVJHF1NIvDsTIB0zje2Cxs3cmDlUQD/YRIJVN64fk6m
9qlFuJLO3laxDaHBLwQKppbz928IuwU=
=7MS0
-----END PGP SIGNATURE-----

--gPNhJ4uAR+JONCy1--
