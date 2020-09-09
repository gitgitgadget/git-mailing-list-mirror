Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D78AC43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 22:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC3720C09
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 22:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgIIWc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:32:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56608 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgIIWc0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Sep 2020 18:32:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5759B60489;
        Wed,  9 Sep 2020 22:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599690715;
        bh=7+18P6KVUmkLjSQcMx/tnVQfZ8GdqAwluy8tjoTYc6A=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=B2e74TP+hqJyqgohxYEuHbfGsyD9q1jb/qQY+nJpcPtvShwoDeSbdNtq76GwFgDjh
         Jzhf3GPjzc3r0OT3pC0J8Po/gp0TcRT9Wk4rFzXhTH1NqolBRROC3JUIXoiranXC2b
         wpdvjhktDwge4ElY2GwuawbaSoCWNTI2HQQjtA+o0WMlBw00yyYWFrljQAfV1OR4dx
         U5Yk+GMLk/ezzoft55Owz3IPjecLICR06kHDNtrDbeZNluBwrL+Gd6WBdNsth9qGki
         HprPWaYxUUnavMqxNYj5JmMnU5JtdmY+Jr3a4SfuuxOFco3i71v53kP57nTq5M4dAh
         ISzFfRRvh09gOwW8+rDG3ekAhSKq0BP0jJl9XIbYf7RmuP3/d60uj5chzF+VUjZREd
         KwawJzMLQ18pMEFQ8wW3YE9JyoMhScY9mTo7AQnGUNjsmp+C5+YzUFkLjivqA3aXkg
         Lc53X9rgECQz8q6RhoioBp+yWVsCN1aod7VX8e2N2mEeAlSJ0Yk
Date:   Wed, 9 Sep 2020 22:31:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rev-parse: add option for absolute or relative path
 formatting
Message-ID: <20200909223151.GI241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2009090513300.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2009090513300.54@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-09 at 03:23:32, Johannes Schindelin wrote:
> On Tue, 8 Sep 2020, brian m. carlson wrote:
>=20
> > git rev-parse has several options which print various paths.  Some of
> > these paths are printed relative to the current working directory, and
> > some are absolute.
> >
> > Normally, this is not a problem, but there are times when one wants
> > paths entirely in one format or another.  This can be done trivially if
> > the paths are canonical, but canonicalizing paths is not possible on
> > some shell scripting environments which lack realpath(1) and also in Go,
> > which lacks functions that properly canonicalize paths on Windows.
> >
> > To help out the scripter, let's provide an option which turns most of
> > the paths printed by git rev-parse to be either relative to the current
> > working directory or absolute and canonical.  Document which options are
> > affected and which are not so that users are not confused.
> >
> > This approach is cleaner and tidier than providing duplicates of
> > existing options which are either relative or absolute.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
>=20
> Nicely explained and implemented.

Thanks.

> > This impetus for this patch is Git LFS, which is written in Go.  Go
> > lacks a cross-platform way to canonicalize paths in the same way that
> > Git does, so when Git produces relative paths, such as in some cases
> > with --git-common-dir, we end up with problems when users are doing
> > things with unusual paths on Windows, such as when using SUBST or
> > OneDrive or various other edge cases.  Go upstream does not appear eager
> > to address this problem.
> >
> > The obvious solution to this is to have Git canonicalize all paths, and
> > rather than adding yet another one-off, I decided to implement a more
> > generic solution.  This can also be valuable for shell scripting
> > environments which lack realpath(1) (e.g. macOS, IIRC).
> >
> > Dscho CC'd for visibility into how this will work on Windows.
>=20
> On Windows, at least in the version from git-for-windows/git,
> `strbuf_realpath()` uses the Win32 API function
> `GetFinalPathNameByHandleW()` to canonicalize paths (whenever possible),
> meaning that the `subst` issue you mentioned above will be addressed
> adequately.

Yeah, I looked into the function Git for Windows used, and it's also
used by Rust's std::path::canonicalize, so I think there's wide
agreement that this is the right function to be using here.

I think for _most_ of our cases, it matters a little less how we're
handling paths than that we're handling them consistently, but if we can
fix all of the cases, not just most, that's preferable.
--=20
brian m. carlson: Houston, Texas, US

--81JctsDUVPekGcy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX1lX1gAKCRB8DEliiIei
gQ/OAQDvJqHWeMhe58XuciO/7jG1y/BKlqRzpkQkLWSecj6VxQD+JKv6tg8GvU3/
sdCAbWc62EoQISMck7tPfC1Gd3YPlAo=
=099U
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
