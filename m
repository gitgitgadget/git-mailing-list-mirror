Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCF5C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 22:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbiHVWLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiHVWLc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 18:11:32 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303874C617
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 15:11:31 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 418145A29B;
        Mon, 22 Aug 2022 22:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1661206290;
        bh=v2802PdskmHfbW5CB0I0TbqM43YpMPWgDi1C70o6QP0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uocIhA0eAsdFhEpbLKi5mPB79sUVcxAaYByQkkDR3MjYOlVSOmyYQKZaAQQmIn65i
         v16QZhP5p9IiwjqlK2sPJw0+dnXGvAGcg2XiS9Q1g4fV3D1utYjSxb/NqFVvqWjnYe
         D9/0qQ6BrAig2Ees/53Hy0C66886x7PtfZgZgxlutZrlPAlSaPF4eM7q/BKkWvBCH7
         7TLeLhBE02CbCSADxYyME5oPMnN/c1du4bCPV7vhad3F0BgycU4UqGu58elFVJWy8i
         SLbAKBFEwplwADXggs85qswAtXj8fLJyLd3Z8Aorqoxk706Y3xzHuIJYT5L+7BZBD5
         ml5NzrOZnobk7FqIIVza20gvw/0DprT1X1IRWFMscRJ1kkgXS9JASyO+7vu0Igpola
         sUMm95/OwWcjNUNBJ7Dpazp68n3EkMLwoCNuV3QgCGXePcncfsOS/QUQVmST/p/+q0
         9vTUH5UtCeiSi/DqOWOPijNO5HkAmGHwJXQtsUiucDj/RspgqP1
Date:   Mon, 22 Aug 2022 22:11:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Daniel Stenberg <daniel@haxx.se>,
        =?utf-8?B?546L5bCP5bu6?= <littlejian8@gmail.com>,
        git@vger.kernel.org
Subject: Re: git clone with basic auth in url directly returns authentication
 failure after 401 received under some git versions
Message-ID: <YwP/EYTwHbA14AZV@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Daniel Stenberg <daniel@haxx.se>,
        =?utf-8?B?546L5bCP5bu6?= <littlejian8@gmail.com>,
        git@vger.kernel.org
References: <CADmGLV32OAg6HU+n1UsP2Fq-MjcyUsFFF=q0_jZCB0JEop5VUg@mail.gmail.com>
 <YwCe6ONEaeIj4SO/@coredump.intra.peff.net>
 <o4sp3o6-75sp-o12o-2p29-r94s2s769r47@unkk.fr>
 <YwNGoqcx3c27XpQL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2m4c+c796FnfmdXM"
Content-Disposition: inline
In-Reply-To: <YwNGoqcx3c27XpQL@coredump.intra.peff.net>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2m4c+c796FnfmdXM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-08-22 at 09:04:34, Jeff King wrote:
> On Sun, Aug 21, 2022 at 12:32:54AM +0200, Daniel Stenberg wrote:
>=20
> > I would not mind having a discussion in the curl project to see if we s=
hould
> > possibly consider adding a middle-ground where we allow sending credent=
ials
> > to another port for the same host name, but I am personally NOT sold on=
 the
> > idea. I think such redirects should rather be fixed and avoided - since=
 I
> > believe users will not understand the security implications of doing th=
em.
>=20
> I'm not 100% on it either. When it comes to security restrictions,
> sometimes simple-and-stupid is the best way. I was literally thinking of
> something as basic and restricted as:
>=20
>   if (from_port =3D=3D 80 && to_port =3D=3D 443 &&
>       from_protocol =3D=3D HTTP && to_protocol =3D=3D HTTPS)
>         /* ok, allow it */
>=20
> just because https upgrade is such a common (and presumably harmless)
> redirect.  But possibly even that leaves wiggle room for bad things to
> happen. I'm happy to defer to you and other curl folks there.

I think it's actually better to fail in this case, and here's why.  If
someone is using HTTP and getting redirected to HTTPS, there's no
security if an attacker intercepts the HTTP connection.  Anyone who
knows how a captive portal works will recognize this immediately, and
it's why we have Strict Transport Security in browsers.

If we fail when a user redirects, then they'll fix their URL to use
HTTPS, at which point their connection is prevented from tampering
effectively forever.  If we redirect, then when they make a connection,
they'll be vulnerable to tampering every time, possibly sending
credentials over the wire in plaintext or being redirected to a rogue
site.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--2m4c+c796FnfmdXM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYwP/EQAKCRB8DEliiIei
gQcdAP9w2zUISeRRf6bnlrgpqrcp9W0OFfbF82QKoSwaTrJBfwD9HTe500YLZcwo
6k+peF3uozL4SnAYhY658pVaXJG9fwc=
=8xDU
-----END PGP SIGNATURE-----

--2m4c+c796FnfmdXM--
