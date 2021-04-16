Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B09C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 00:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37066113D
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 00:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhDPAEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 20:04:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33998 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235133AbhDPAEg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Apr 2021 20:04:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 08FE26042C;
        Fri, 16 Apr 2021 00:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618531452;
        bh=92axGAi5Mhkb2OJViJL+jsn0zmewwLQ1jhaSudlZAnc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=F2IEnp+/AvV4Ru/1yvtVhabYiu18izzYlXM0uwEKL9LEuiziH16yvCBJQ66oUsNHs
         p87KMaoJV1cR82rAgFgOVUTevUGLLcYWqptogTxbQwulJ23tEwwzE2bZoM8N7FfZPj
         zb/oZcpV5NSK5PKjLEdtCcTkk4Nc87Tx4Hf/ONjrYx4bmhubgXxBLDR0t0IUCh2ZUx
         XfRv8Vi5WDKXpcFWiIJMHVCVOK+rUinK1/6WzKNlMqXiK9yGZX9q0XpWrehBkkTNp3
         0QA2KIL+wAWS1HzWPiNr5kc3ynN3XlQSwqgCAKP7PgkWH5ULTiGb7hPmJw2ZIIwQI2
         a/AjpIhlilKBqZJfgMrhrXVwcccKZCTMtnRcvhTEp8hYOEUXosvmpqpD11XgrXYW1Y
         kVMDYzJ5oMl8DmiSDBSo6nbkPmY9fvPtN8l2ZASLZARgAV4ukXmc47gQXxgHwOuiQt
         5bZMBFKG8D3VTJDhfaOOCU+DZXMVx1uv1eAye0kMYs36oJ8pvge
Date:   Fri, 16 Apr 2021 00:04:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     "Simon, Martin (Digiteq Automotive)" 
        <Martin.Simon@digiteqautomotive.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: possible race condition (fetch-pack: unexpected disconnect while
 reading sideband packet)
Message-ID: <YHjUd67KujPCl1U9@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        "Simon, Martin (Digiteq Automotive)" <Martin.Simon@digiteqautomotive.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <df13300936784af7bb6c23f9fe0465c9@digiteqautomotive.com>
 <YHf5bkiE7SVPTBvU@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aWgfzOxZ4NjYluHz"
Content-Disposition: inline
In-Reply-To: <YHf5bkiE7SVPTBvU@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aWgfzOxZ4NjYluHz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-15 at 08:29:34, Jeff King wrote:
> On Wed, Apr 14, 2021 at 10:12:44AM +0000, Simon, Martin (Digiteq Automoti=
ve) wrote:
>=20
> > Actual result (when failed):
> > Cloning into 'local-repo-name'...
> > remote: Enumerating objects: 237, done.
> > remote: Counting objects: 100% (237/237), done.
> > remote: Compressing objects: 100% (129/129), done.
> > fetch-pack: unexpected disconnect while reading sideband packet
> > fatal: early EOF
> > fatal: fetch-pack: invalid index-pack output
>=20
> This could be many things. A bug or race on the client side is possible,
> but it could also be that the network session really _is_ being
> disconnected. This could be something in the network stack itself
> terminating the connection, or it could be a bug or other error on the
> server.

I'll point out that this kind of occurrence also happens if folks are
using proxies or TLS middleboxes, as well as some antivirus and firewall
programs on Windows (which often end up being well-hidden proxies due to
their configuration, unfortunately).  That usually only applies to
HTTPS, so oftentimes switching to SSH, as Peff suggested, may be a good
choice.

You can also try running the operation under WSL 2, which generally is
not subject to most of those programs and mostly handles its own
networking, to see if it is one of those programs or if there's a more
general network- or protocol-specific problem.  That will at least give
you more information about the nature of what's going on and help you
troubleshoot further.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--aWgfzOxZ4NjYluHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHjUdwAKCRB8DEliiIei
gQY+AP9zSfDKm4EOHc94L0qXhcrLz1LlpUfX5Wa82MpUEzD3FQEAz3Zxk8dLqRho
tFXMIyVfSqQlG90DJcrqV2H59HrgCwI=
=FUDU
-----END PGP SIGNATURE-----

--aWgfzOxZ4NjYluHz--
