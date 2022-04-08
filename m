Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228C7C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 22:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiDHWcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 18:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiDHWcW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 18:32:22 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8907413F67
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 15:30:17 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 98E1F5A0E9;
        Fri,  8 Apr 2022 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649457016;
        bh=O3PQzmMX0liwE4mOcjtQuGuSm5DzdfbFfZPQKFBpZWE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kvDHqQTHUdzU54d9H5XWcNg5lOHgkT1QaUg56dghnYHaOhAJEc+YuBlsf2Kx6v5Yd
         OZJn9T1Xq+15vxwYTyB8btfVVgsSFzxOZWLeKTc33XzMAbF9kYK7odiabp/cEnBAn/
         ljjcrieSPRCDkfrwisK6kh1MCXdMmGsfO5H8d6c1XCg4Bta1vIDlxK09n6hQgKrLlR
         T4gIO9FKiDUZY7BwCVvYAJdG6HQ0pLSw+QwBkvtAl0ASFKNFSDA81FMjQgBeGbnfKU
         mxEtbtO9Hl3L3CF38Q5i6hqNpUuJ1Gg2pfugaTQN7hBE5Egkj/DOsLC9flJk+3LiHO
         RUPO1Q7liE7bEedncH5LfhgJHS+56arNhNA2y64v6o2kwBBNZOXfOWym3mm/2m+LEe
         dhM5W7S+8YpSykJ0wqo3ZYNj/EohZPqdOnflSmjP75LtNgYwkEcVT9cXsjlqVkHmsM
         QRIwdHBLdwULFW/9LnIAoPnMZgx7pDsOcgaYW0lV+3wMbX7YcFb
Date:   Fri, 8 Apr 2022 22:30:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     jurgen_gjoncari@icloud.com
Cc:     git@vger.kernel.org
Subject: Re: Make commit messages optional
Message-ID: <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5yM6CXtnnGtWW0Ti"
Content-Disposition: inline
In-Reply-To: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5yM6CXtnnGtWW0Ti
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-08 at 03:35:04, jurgen_gjoncari@icloud.com wrote:
> I think that often commit messages are unnecessary. I propose that by
> default a user should be able to commit without a message.=20

This topic comes up from time to time and you can see the previous
discussion in the archives.  The reasons we haven't done this are
roughly as follows.

First, writing commit messages is a way of communicating to others about
your changes, as well as to future you.  In my experience, it is
substantially more important in software engineering to communicate
clearly and effectively than it is to write code.  The computer will
accept anything that runs, but when you write code others must read it
and change it, and they must have the appropriate context behind those
changes to evaluate your changes and to make their own in the future.
We want to encourage good software engineering practices.

Tools like git log use the commit message, and empty commit messages
mean that viewing the list of commits is completely useless without
viewing a diff.  This means that functionality such as `git log --graph`
is just completely broken.  Writing even one line in the commit summary
makes a massive difference in the usability of these tools.

Users who want this behaviour can use --allow-empty-message or create an
alias with that option.  The functionality already exists.  I use
aliases extensively in my development and I know others do as well, so
this shouldn't be an impediment if you're working on projects where this
is acceptable.

> I don't think this would be a problem from the UX point of view,
> because a user could get a lot of information about a change, from the
> history of the GitHub repository, such as from the time of change, and
> seeing the diff.=20

I certainly hope when you are writing code that you explain your changes
somewhere.  I know some people who use pull requests prefer to do so in
the pull request rather than the commit message, but I for one would
never accept a change that doesn't contain some sort of explanation
about why it's valuable or relevant somewhere.  I am, unfortunately, not
omniscient, so I need people to communicate their intentions and
decisions to me, and the best way to do that is with words.

I should also point out that the GitHub UI is specifically designed to
show the commit summary in the history view, so GitHub intends for you
to write at least one line of helpful text (the summary) in this
context.

Overall, I don't believe your proposal is likely to gain traction here
for the reasons I mentioned above, and I personally don't support it.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--5yM6CXtnnGtWW0Ti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYlC3cwAKCRB8DEliiIei
gT2wAP9STZU0FiRf0jD1fi7infYnTmCyR9zELTXaM4ae848gogEA35AbkjMFQXfA
xiJ4Jyvyty+z6SZT64eLXukVxEGoCQs=
=UnXd
-----END PGP SIGNATURE-----

--5yM6CXtnnGtWW0Ti--
