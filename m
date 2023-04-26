Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EA1C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 20:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbjDZUky (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbjDZUkw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 16:40:52 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0CB213F
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 13:40:50 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 3B7945A569;
        Wed, 26 Apr 2023 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1682541650;
        bh=ngU8mGvCe0LTWJiuviwrMPuT5qs6I5yvi/EfzUmykXA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qcHn6QoV9H1mRqFce8S8rHTmk1WC14yx2lcZND+oig9PdVSYsYj1FLwv3WKf/hkyZ
         cLj1fwxpefaBpzNJdmQzO5jmD5sA2EpANRERx8BcA970bTotFukWwo1Iy60wo5Qvt3
         v5M4xALJsxKDhJM/gJhooM5tUlsw2QHZzhhoOfi1dDwm1sT8vFVYOQl30+DemVIrri
         Hg7gsvI15pLujphTaVFxKHBtGH9WRwdjf6E15HIsiAonFzQmExaqd9SNvRTbBFsCsY
         CqPSkDamGOlrBbiR7dIjBx1a8dYi7u1n4FUOxYLsLb4rJkEVe6gnQAurPsRqKeCfTk
         b+9rFpGutuPL8AsxlAoSaAz4XaUILrKPGnuuOOWjLz7ULlWhwFQ4pztKH+nhJRnM9p
         AMJgyz23w9cGMR/joTdGASDYq7Mk0d1uNvZDu7ausB0k/PAL3r8xlOKr3mE80zXta1
         lFrnVhtfpFXWPiB530WYINeGwLIHxkxPuEVdIUg1WXZiBTHefUf
Date:   Wed, 26 Apr 2023 20:40:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Adam Majer <adamm@zombino.com>,
        git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
Message-ID: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Adam Majer <adamm@zombino.com>, git@vger.kernel.org
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
 <xmqqr0syw3pe.fsf@gitster.g>
 <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
 <20230405200153.GA525125@coredump.intra.peff.net>
 <xmqqa5zmukp5.fsf@gitster.g>
 <xmqq355euj2i.fsf@gitster.g>
 <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
 <xmqqcz3ry2sw.fsf@gitster.g>
 <20230426105134.GA130148@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zuc/EG5KPEJxOvN7"
Content-Disposition: inline
In-Reply-To: <20230426105134.GA130148@coredump.intra.peff.net>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Zuc/EG5KPEJxOvN7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-04-26 at 10:51:34, Jeff King wrote:
> We could send a capabilities^{} line, which Git has supported on the
> client side since eb398797cd (connect: advertized capability is not a
> ref, 2016-09-09). So sending it should not break even old clients
> (though we would have to check what alternate implementations like
> libgit2 or dulwich do; we know JGit supports it).

I have a patch which does exactly this, which I will be sending shortly.
I've confirmed that libgit2 and JGit support it, which is unsurprising,
since all of the implementations, Git included, share the same code.  In
addition, this is the behaviour we document as supporting, so all
implementations should support it.

> However, the object-format support here was broken until the very recent
> 13e67aa39b (v0 protocol: fix sha1/sha256 confusion for capabilities^{},
> 2023-04-14), so it would only be useful going forward (before then we'd
> die(), but maybe that is preferable to having the wrong object format?).

I think it's better to die than to silently have the wrong object
format, and it also prevents the problem if other clients using v0 or v1
(which effectively have to be supported for compatibility, while v2 is
optional) try to clone from a fixed server.

> I'm not sure it's worth the effort, though. If you want to use sha256
> everywhere and tell the other side about it, you need a modern client
> anyway, and that means the ability to speak v2. So this would only
> matter if for some reason the v2 probe was being ignored (e.g., proxies
> eating it, ssh refusing environment variable, etc), which itself are
> things that ideally would be fixed (and can maybe one day even go away
> if we optimistically default to v2).

Using v2 everywhere is difficult because many SSH servers still don't
pass GIT_PROTOCOL by default, meaning that we're stuck with v0 and v1.
In retrospect, sending an environment variable here was not a great
decision, but we're stuck with it now.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Zuc/EG5KPEJxOvN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZEmMUAAKCRB8DEliiIei
gRizAQDK/g9P7xrW+9i/IzfWiKWgJqJsYAZdEXEtGR5JfEZ/xgEA9cm0C96avibr
i0vpIhrFPuZazBW/2fyOhd1bsG+4awY=
=lvoq
-----END PGP SIGNATURE-----

--Zuc/EG5KPEJxOvN7--
