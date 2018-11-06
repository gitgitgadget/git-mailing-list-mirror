Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC651F453
	for <e@80x24.org>; Tue,  6 Nov 2018 00:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbeKFJgH (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 04:36:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53332 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbeKFJgG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Nov 2018 04:36:06 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7F3B86077B;
        Tue,  6 Nov 2018 00:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541463224;
        bh=HryYjOSLKxiFHFlIYJMIP9f27Tzc3THmg9Z8Trogcis=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KgHHeavLCYDdcwe6NH0zvKes/HDvL4tzMs4vH0AbmvBjmyPkCC+sxRyem/tcU5jFo
         WxLyId6LGQ9XgWVLIj1eIIfyTgmhSGX0C1KCwSiFKnG5UP8yY32pAFfrBxH+5Hz1Ou
         CoxboqBxucpZKG5Cuhg90qvEqFB/GSGxImPIfRyJLfDFczNMqC4dJTqvWFsdsoV6R+
         UePidOz6ddjtmsupZKpU2zVZmm7VWfcFcR5LeMfgPA4EhBAij3VmDJt9YiE3McgD2V
         6E3n17p3oxd7rZ55/yeQX6/a0yqkkEIW2t7AdLEWxSgq4ucVJbR/NSPFS56GgPjJ4K
         WtfjaZdRcuer279S+VXGtnGliDbfO9+oF01U56qUGts1bal4VtGizDecjDBfwL42J9
         ALu3Vd9ci1IfvpWEJ4NbQVA7RgcWYyuRNG6LNs/RicRqhR5tDkIHIDnqlgLyZ7P6er
         udQHLQwNH+2grprjrHXShZkf64qWasRaBCiHBGEuGIIIDwqnlAq
Date:   Tue, 6 Nov 2018 00:13:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Design of multiple hash support
Message-ID: <20181106001340.GC890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20181105010032.GN731755@genre.crustytoothpaste.net>
 <CACsJy8B+WAyjrthKs9nr=kLpx7f8k_Dug4rRdYDoBR+mmLHCuQ@mail.gmail.com>
 <20181105220042.GA162375@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <20181105220042.GA162375@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 02:00:42PM -0800, Jonathan Nieder wrote:
> Hi,
>=20
> Duy Nguyen wrote:
> > On Mon, Nov 5, 2018 at 2:02 AM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
>=20
> >> There are basically two approaches I can take.  The first is to provide
> >> each command that needs to learn about this with its own --hash
> >> argument.  So we'd have:
> >>
> >>   git init --hash=3Dsha256
> >>   git show-index --hash=3Dsha256 <some-file
> >>
> >> The other alternative is that we provide a global option to git, which
> >> is parsed by all programs, like so:
> >>
> >>   git --hash=3Dsha256 init
> >>   git --hash=3Dsha256 show-index <some-file
> [...]
> > I'm leaning towards "git foo --hash=3D".
>=20
> Can you say a little more about the semantics of the option?  For
> commands like "git init", I tend to agree with Duy here, since it
> allows each command's manual to describe what the option means in the
> context of that command.

Sure.  The semantics for git init are "produce a repository with this
hash algorithm".  The semantics for git index-pack are "the pack I want
you to index uses this hash algorithm".  Essentially, more generically,
the semantics are "the repository or data object uses this hash
algorithm".

> For "git show-index", ideally Git should use the object format named
> in the idx file.

I agree that will be the eventual goal.  It will also be what I ship in
the final series, in all likelihood.  I have most of pack v3
implemented, but it's not complete yet.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvg3LQACgkQv1NdgR9S
9osPEBAAo0SuwFCvBuKjufjxyie4ThCR9ZXUvF4q9emP38QRRJsel++gpgAwOUGt
zFtHjqxbx772ainEodsYYB2YnaRXBOWjHqtqUJhFAQmcpnZ0ntzQxqzkTIE9o30P
Ge5pUAEbeZQmu7RcS7OOkOZmLU8wbDJQWTUUMLkSUgObsRR0dbcPIod8A/vf/V7x
EdmrXqXqrcHUbxQxzCUFIzs1ChSKT9lz3OPF+U74f94nI9wxMNgksk4vpme37Q7L
t4J4mNhcT++tUnd7er7yk+VpyF6uOjJglcc2CqIoHH8K1cIjVpZVIWjCg2GDEQGW
ZPV76wkyrOiEhQ4+kboTNN0GzbTP1G5qz6cgpVdjFyLYjKfiwFYTGmnfoc7fOMrO
t1QZnNpuQzx1+/+YxyLpETsfmBS4ZY1klJdWZ4+UNo2lAbr8BWTLZleuhkmfpJOP
u634HkxBb17D0K1Q7zZG7VNbRgc4tleY8IsLAkJsV94nrAoYET4DgDPhY9ZpvVHD
h5JXO5lRhgt6NkzU8novQ1Je1cjIuy0JBfrwy0zcB6puczHEG3Z8ZnAXPf4FfDVA
N6ntKlVk6v4vmvPdxgBTIR/UCBAYaXH52J8/OoNYq1cdG7KVW7N6uNQg8gTGhOYs
pcUtn1ipWhQXZIrPUm+2HGhHvCZeCMXHrABo0/k05wM1iHMC294=
=8yWA
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
