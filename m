Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F40C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiF3VRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbiF3VRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:17:41 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C825387A7
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:17:40 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A56A55A49B;
        Thu, 30 Jun 2022 21:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1656623859;
        bh=3Uv3vZiE+OiHnltPs10QAZvEqcoEjdZWQTnVeOSi++0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sROqzf4G6f4NWTb9zHZ4gMe1HRjQNBRyZcL+HSqySaJPCngyVQBILLoOqqTps6ANY
         5izrVqC0jof6jBWKIOG5LAa8D6rQlwYyh9UwMenYZ3l0Y4yXqF92cO6HBAmsigUQhi
         Rr3oPb836Ms6obBrAUjp/qvGC4Lqaz0hs8owuWsmDuEJsT90jBOSnvFxKg5Dteo1af
         iCRwceZJ+S6SfBeJrNxg9dX7yHK0xa2eBZwXccm9NPdWsy0+d7hdWqwDS2fmk+oukL
         yfGQHRZPl19s2uFKzc5JBrf8SRqn6PTgZNklOYpm2VTn2pN4hzrTfK3vUgbM2Ja20V
         wBCMgPFyDGcNDeCVzf67Vf9ksJxnkcNCIkP8KjPPtH50urVcIajuPfr0TzF40dckD2
         i/aU9WhJ7xadzaVFMHf3ORc7nU50AEGGRF0OSgLb/xx2rfbQECGv7c/GvNWyRs92zf
         I7IHr82lOFdwHl+MD1XagRpDq1A2Vi7IiXqP6aRpdOAYxUX64Kz
Date:   Thu, 30 Jun 2022 21:17:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Non-interactively rewording commit messages
Message-ID: <Yr4S8jHKbtuBuT1z@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
References: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eiBcGKWbIlPSFcUr"
Content-Disposition: inline
In-Reply-To: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eiBcGKWbIlPSFcUr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-30 at 15:27:57, Konstantin Ryabitsev wrote:
> Hello, all:
>=20
> What's the best approach to non-interactively rewrite specific commit
> messages? In this particular case, I am trying to automatically retrieve =
code
> review trailers sent to the mailing list and put them into corresponding
> commits.
>=20
> For example, I have a set of commits:
>=20
> abcabc: This commit does foo
> bcdbcd: This commit does bar
> cdecde: This commit does baz
>=20
> They were all sent to the mailing list and a maintainer sent a "Reviewed-=
by"
> to the second commit. In a usual interactive rebase session this would be:
>=20
> pick abcabc
> reword bcdbcd
> pick cdecde

You can set GIT_SEQUENCE_EDITOR to a command which does this in-place on
the file...

> When the edit screen comes up for the bcdbcd commit, the author would man=
ually
> stick the new trailer into the commit message. However, I can automate all
> that away with b4 -- just need a sane strategy for non-interactively rewr=
iting
> entire commit messages at arbitrary points in the recent history.

=2E..and you can set GIT_EDITOR to modify the commit message in-place in
whatever way you want, and then use git rebase -i to rebase.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--eiBcGKWbIlPSFcUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYr4S8gAKCRB8DEliiIei
gSFRAP9WOZnKnZl0vIgfJ+04k9Q2dITLfH7ps4jnm+eP+NntZgEA45NAKUVJqMWO
zIjJQVdt2x1twawbf3kZyYsEXaafjwI=
=lXN0
-----END PGP SIGNATURE-----

--eiBcGKWbIlPSFcUr--
