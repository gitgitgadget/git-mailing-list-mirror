Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCBEC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 01:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLGBPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiLGBPn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 20:15:43 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3543B1FCDB
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 17:15:42 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7DAE25A201;
        Wed,  7 Dec 2022 01:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1670375741;
        bh=krlkKKcXRBPZE/Tn3wte4D9u4N/9SCqHfSpIYyKzr6o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JHBp7RCVv51hA6WRKdxRIrNeQhcXW7q8Z8/2knoXSielkMJ/jpzWZVGrJpNoTsVpx
         IgIWZnM3JN2Ni3kn0BjuLrLM9UldMFP0iWWFXO9tTfLFljhKQhHg+px5ImdWD9ONqA
         9zIK6zhfvjqlZdb/71DBbB3eHQLeqphI7pC/M599AG3EcpIq9o5d2cBnApfGhqywHX
         RXeIJI6uFj79y/yc9lUIxU96LhSwjkkhxgUKTkv6LVg42SDYNOMwXMbgveRAkf5Dfw
         q9U2hm18l0Wgmt5c2OOqO8P7LFwmspXhBpL9nHojNcx6G+MB7q9FVv+P8iTQJ0bg1l
         4x8WpR5c22xlBaaEyHPOxtTo8pw15KI16/vwu/l00HEaieAa7zj4d62/51MFXMGcHg
         mNsJ9YHZyBXq7y4XkR9fDSzRWS+STPpfTgfc7RXBVElgvL5+9qtK6vW3frAi/0pVXP
         Sr3UCanYgxvgxQiNrEkGAGhk57TnptFECdZqc1UACiWLIDGiGUg
Date:   Wed, 7 Dec 2022 01:15:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Gennady Uraltsev <gennady.uraltsev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git credential store conflicting configuration leads to
 unexpected behavior
Message-ID: <Y4/pO55b5DtPnavg@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Gennady Uraltsev <gennady.uraltsev@gmail.com>, git@vger.kernel.org
References: <CACH4KQSutGnoyFGP2RmkwQT3yhnEg1RcvedXVSMOVVDAnz_aFg@mail.gmail.com>
 <Y4+/VQly2NKnMrFY@tapette.crustytoothpaste.net>
 <CACH4KQSj64WeqAV3CDkCXc+YW6dr+S2vN_QBj5SwcSP05fM0Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nTUJVTHdNxS1gWxM"
Content-Disposition: inline
In-Reply-To: <CACH4KQSj64WeqAV3CDkCXc+YW6dr+S2vN_QBj5SwcSP05fM0Eg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nTUJVTHdNxS1gWxM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-12-06 at 23:53:05, Gennady Uraltsev wrote:
> Thank you!
>=20
> This makes sense and the solution is simple. Is this somewhere in the
> documentation (honest question, I am not being a jerk)? I tried my
> best to figure this out before bugging people on the mailinglist.

Yes, but maybe not where you'd expect.  In gitcredentials(7), there's
this text:

  If there are multiple instances of the `credential.helper` configuration
  variable, each helper will be tried in turn, and may provide a username,
  password, or nothing. Once Git has acquired both a username and a
  password, no more helpers will be tried.

  If `credential.helper` is configured to the empty string, this resets
  the helper list to empty (so you may override a helper set by a
  lower-priority config file by configuring the empty-string helper,
  followed by whatever set of helpers you would like).

The `credential.helper` option mentions that manual page.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--nTUJVTHdNxS1gWxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY4/pOwAKCRB8DEliiIei
gViMAQC4FqVBPKxuPaiSF+t3sFJEjgWOgla767buFIL14l4gngD/d+WG9jmabw+Z
sXf36bEa8UNiqTVVpZQkYBvqORw07wk=
=Eaqp
-----END PGP SIGNATURE-----

--nTUJVTHdNxS1gWxM--
