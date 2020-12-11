Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEC1C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 03:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8492B23ECF
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 03:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389404AbgLKDoO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 22:44:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58008 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391758AbgLKDnm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Dec 2020 22:43:42 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2DEB260769;
        Fri, 11 Dec 2020 03:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607658149;
        bh=1X5KTQYG+lDpMLjfpbi0/vXm7cKnFd1pASkGhmiyjao=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HSq/h1qzP4ZLMAbDNuNyS1MRnK0VxH/EyKkfQcg7pGQsVYiJzW0fQFvR1q74wES9o
         OzmosYOHl2AKEoCL49ZfMecrTMwDpJrGQlwwbWyVqvMY/bQ6JAc6ohTqCUAVINDbzb
         LCCwVVQalLM47IrgQWcqFNqIeP7ArpV5AM2eaN2h7Zmz5UnM0DcLdhZN7rntXcScPe
         l1MBGT2kkHAs6auZUO3UueJkoM/qs2+9PxxxeWonfUA3iOq2Mzh1eSXiawabiP3hjB
         X3DbEKBcR7zDSUGlFE6Lan0EKNBsxA5q0aQyE6MH4XbrSbHYh8I0DYa921rtbe0Nq6
         AkosKMPqywxf8ct09RSd0SWsUvUoLc6xfoXfgXIeH+n2EOsiyjqDGqONVON2T7RnLC
         bkOZIU+veYtOgXU/evqhYRYaElSEa4BnnmOea1g5yqb2vA2QUWMzgMn0z/ft2lF/is
         aNbqmeEzslrXnZ7YF0JTarEXoMvcejYNfOgmQmq4fptfZSDaqDC
Date:   Fri, 11 Dec 2020 03:42:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Why does "git pull --rebase" require a clean git directory?
Message-ID: <X9LqnolNcWZvA7Bm@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <ea1e654cec62411884e2c260524fb05a@deshaw.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sqDt2Jysk1Q4nXYP"
Content-Disposition: inline
In-Reply-To: <ea1e654cec62411884e2c260524fb05a@deshaw.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sqDt2Jysk1Q4nXYP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-10 at 22:15:11, Shupak, Vitaly wrote:
> Hi,
>=20
> "git pull --rebase" requires having NO uncommitted changes, even if
> the locally modified files haven't been updated upstream, or even if
> there are no changes to upstream at all. I know I could use
> --autostash, but that's inefficient and may be undesirable if it would
> create a conflict.
>=20
> Would it be possible to change the behavior of "git pull --rebase" so
> that it only fails if the locally modified files conflict with the
> files modified upstream (similar to the default git pull behavior
> without --rebase)?

I suspect the reason for the difference is in how the two pieces of code
work.  A merge in general can work in a dirty tree whereas a rebase
cannot.  That, in turn, is because the merge code merges two files
internally and then writes them out to the working tree, whereas the
rebase code, at least in some cases, doesn't contain the same
precautions not to modify the working tree.

Moreover, a merge is a single operation, so it's safe to operate on a
commit and then give up.  A rebase consists of multiple operations, so
we'd have to evaluate each operation and synthesize it, internally
performing the merge (or apply) that's a part of it, in order to
determine if it would conflict.  Otherwise, we'd have to just try it and
somehow abort cleanly in the middle without otherwise dirtying the
working tree.  Right now, that abort step involves a reset --hard, which
is going to blow away your data.

So is it possible to do?  Sure.  Is it easy?  Not especially with the
current code.  So certainly it could be done if it were important to
someone, but it will likely be a good bit of work.

Sorry this wasn't the news you were hoping for.  I'd love to have some
easy solution that I could offer to send in a patch for this weekend to
solve this, but unfortunately it's not that easy.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--sqDt2Jysk1Q4nXYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX9LqngAKCRB8DEliiIei
gX9VAQCGFq4w6Y/1kaO0QfZnPDlI0c38fb2lBQZnJKmp2QlqVAEAzw0Rl69EAJ1i
PFzlWXQqswSoWgUDTw30NLBwmX/mqAE=
=r477
-----END PGP SIGNATURE-----

--sqDt2Jysk1Q4nXYP--
