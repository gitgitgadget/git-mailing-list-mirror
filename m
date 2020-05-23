Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD78C433DF
	for <git@archiver.kernel.org>; Sat, 23 May 2020 23:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396A620735
	for <git@archiver.kernel.org>; Sat, 23 May 2020 23:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uSq+NRPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbgEWXXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 19:23:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38634 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388047AbgEWXXb (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 May 2020 19:23:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 888366045A;
        Sat, 23 May 2020 23:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590276210;
        bh=ksNUDHAp58LhdY/+H8Y6hz8kxTn1CR0kWInIpgcOMQc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uSq+NRPyf5+2LWcUykMrE6IgxMJm5/u5VRw7SpMPaa5cDROLRLcpHwem1WKjEuKpD
         tzc6+Xos2nVXt5RqWjKyCVmpOIz2UPyOgSIzwxzgkhdyWKK4eo5b6YUA+Wf8zE2gQr
         h1yyYwfubTJZdlg4CNqPweVzL2KX7m+FPgl38FLsl24C9RoN7VLaZjGVgLve1UmIo4
         CXV+/iYZS0g/e4cZRG+i+h4Z7CgD15Jh2mb5fAVjzi7CIgvLWC2FouLGmV7EIGMFH2
         ILGJBvEAkGBcYx1uXaw3ad7XAA7GS8JP4mJGq1SkBXpexyMgh9gZuTWrRToX08dz40
         Kn11prQ0WwZKdI21NZRE2foEkEqx6jfN4OxL18K77yy+mv3aygMP+C0LSCEZxh8JHx
         fHtXsJl/d0TWbLuzZB1HkoO9Cl+v9TV/Aq+014J9nDG9H9bjzM6mKp45hZqkoxozGE
         DlFjDZLZ0SNYSlzrq6wIt5S28PjCReDa319VkeHJluu49zDnN4F
Date:   Sat, 23 May 2020 23:23:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michal Vrana <mivra1@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Submodule init uses STDERR output
Message-ID: <20200523232324.GB1915090@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michal Vrana <mivra1@gmail.com>, git@vger.kernel.org
References: <CA+sZKRqMaSZqj3PdpRz3xrruTbz1CJV=W9s_ox4BrhCAuQqhKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <CA+sZKRqMaSZqj3PdpRz3xrruTbz1CJV=W9s_ox4BrhCAuQqhKA@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-23 at 22:44:59, Michal Vrana wrote:
> Hello,
> I've come across an issue that seems like a bug to me. If I clone a
> repository with a submodule but want to initialize it separately, then
> the error output is used during this initialization for what seems to
> be a standard message.
> Motivation:
> Cannot use - Fail on standard error setting in a devops pipeline

In general, this is not a good setting to use with Git.  Git uses
standard error for many progress outputs if standard output is
potentially scriptable.  You're better off checking exit codes to
determine success or failure.

Git is also not the only tool to do this; other tools such as Docker do
as well.

> Steps to reproduce:
> 1. git clone
> 2. git submodule init 2>err.txt
>=20
> The err.txt contains a message like
> Submodule 'xyz' (xyz.git) registered for path 'abc'
> From what I've read this is the standard output in this case. And if
> not then why when I use "quiet" mode then the error output is empty.
> So why is the error output even used?

c66410ed32a gives us the answer:

  Reroute the output of stdout to stderr as it is just informative
  messages, not to be consumed by machines.

  This should not regress any scripts that try to parse the
  current output, as the output is already internationalized
  and therefore unstable.

  We want to init submodules from the helper for `submodule update`
  in a later patch and the stdout output of said helper is consumed
  by the parts of `submodule update` which are still written in shell.
  So we have to be careful which messages are on stdout.

I haven't looked to see if we could change it back, but that's the
reason it was written that way.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsmwbAAKCRB8DEliiIei
gWUXAQDHp0Bu3SlwJfmu2cBeOzzkXbiiHJmNWYITQ3jAjNjecAD/UtqiqoFPH1iZ
8q5oKGzaMRhfoKUe39H7OVNJmN8enQs=
=qUGt
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
