Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C1C4361B
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 11:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A357822C7D
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 11:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407347AbgLLLaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 06:30:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58914 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbgLLLaO (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Dec 2020 06:30:14 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B9B4A60769;
        Sat, 12 Dec 2020 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607772573;
        bh=PxHNfcQwiraYckk+jqmL88uUcY+5YocNQMRgscT3z6E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BYI6n2GI7ZAnasVHcreMoYfeqzYE/+OREuJkJVXAzEJb1VrlDST1ryNKIw6Tp2DnZ
         GZvtqPqsYhjEO/ZvQfhr+czADPSB3ECohe9oEcm5x/PzVKuCvBLRTBvFstzwt1cUKF
         MFmT/86pQXWyDE0MxGhT0nuLrZ8w86uWNheXDX3AEHi4BHn08LIC0ffUAanySvieOg
         7Bt2sqJ+l3/oMhWT5Da9a1POGvachr7nMNFB9n+ZJvSo9DLOsim2V2zgp6SWzdU3ZN
         7S2DPLNxTTVKTIWFI8mwvWqdTsE3FcAwq/f7YGvWpAkcoBpZUjpdVpYbYJ2xOagSL4
         J+BWz9GWAyU7sGalYdycN5SQMiSVIh8mO8zA2I7I7cxTto4V9udIGoQw2bFkeWJE5N
         olkEOOwQY1MBL5XGUJe1n87kroI0X4D4i8W7q4+6Gnk11ZK+CgrCa/4YtAuesBN1YG
         zixH4/PmlHWuVwgqLqq/6e8V344Mt2/Y6HjEYAqczrAyKBy1wab
Date:   Sat, 12 Dec 2020 11:29:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Why does "git pull --rebase" require a clean git directory?
Message-ID: <X9SpmGKUVgrSBy9j@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <ea1e654cec62411884e2c260524fb05a@deshaw.com>
 <X9LqnolNcWZvA7Bm@camp.crustytoothpaste.net>
 <f5b5b94830ca45b69440c0ebc1de5e69@deshaw.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qMsgsev1Mj1QmWdA"
Content-Disposition: inline
In-Reply-To: <f5b5b94830ca45b69440c0ebc1de5e69@deshaw.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qMsgsev1Mj1QmWdA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-11 at 21:23:23, Shupak, Vitaly wrote:
> Thanks for the explanation. It seems like some optimizations may still
> be possible. For example, if the pull could be done with a
> fast-forward merge, then you don't need to rebase at all. This could
> be an option like pull.rebase=3Dnoffonly.

Yeah, I agree that if our operation is a fast-forward, that could be
done in a pretty straightforward way.  It's still a little tricky
because of how the current code works (the fast-forward logic is in the
sequencer, which gets called after the check), but it's something that
we could add more easily.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--qMsgsev1Mj1QmWdA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX9SpmAAKCRB8DEliiIei
gXAlAQD32fgkbR8X7ijdXHsak40Ay5vgMZWYEcf0mwT/D3QemQEA4TNa97YHc1/J
oxNJbDh9vVY+jzHZbN/HRch8+zY45QY=
=OYJS
-----END PGP SIGNATURE-----

--qMsgsev1Mj1QmWdA--
