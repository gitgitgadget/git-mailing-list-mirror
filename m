Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233382022D
	for <e@80x24.org>; Thu, 23 Feb 2017 20:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdBWU6K (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 15:58:10 -0500
Received: from kitenet.net ([66.228.36.95]:58986 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751277AbdBWU6I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 15:58:08 -0500
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1487882826; bh=MIma7F8qViawKl7fA9csieLjOJ4g0L2YNUnHoO92vkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+F1vzX2moyNLnj/+wgcECQZlXhgfOKv5e6AjWt7T/nuluWCLF92+5Wt3GymrojrA
         sGbNaFO6bpVuFBduBBXZ6oz/CtF4IwFzf2PxAPmWlGAKaajRBxL4vJPpCOFJIe2bMe
         BHXk1ni0DHhBYNBlm9qN90c1OqzKyqWOPUe8+whg=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1487882819; bh=MIma7F8qViawKl7fA9csieLjOJ4g0L2YNUnHoO92vkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUkBbqnNiyFZqViZ9fTPqfd3y/chmsV/Oyg1uKt1H7jfYOR6JmX/3QNn7fxz2lK6F
         /8wX5qJjjOM2xwK/saS7EbDMTfDEvrtI2uTRwHna23iW0ayL0vBaLEekeW51MpClV2
         j/5VYClIXUpkjCa/MMUD4AZD1czZflcoWPBj5LEw=
Date:   Thu, 23 Feb 2017 16:46:59 -0400
From:   Joey Hess <id@joeyh.name>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223204659.prmbuip4s4snwtci@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net>
 <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
 <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vwrg5avozjrh2i6s"
Content-Disposition: inline
In-Reply-To: <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vwrg5avozjrh2i6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> It's not an identical prefix, but I think collision attacks generally
> are along the lines of selecting two prefixes followed by garbage, and
> then mutating the garbage on both sides. That would "work" in this case
> (modulo the fact that git would complain about the NUL).
>=20
> I haven't read the paper yet to see if that is the case here, though.

The current attack is an identical-prefix attack, not chosen-prefix, so
not quite to that point yet.

The MD5 chosen-prefix attack was 2^15 harder than the known-prefix attack,
but who knows if the numbers will be comprable for SHA1.

> A related case is if you could stick a "cruft ...." header at the end of
> the commit headers, and mutate its value (avoiding newlines). fsck
> doesn't complain about that.

git log and git show don't show such cruft headers either.

BTW, the SHA attack only added ~128 bytes to the pdfs, not really a
huge amount of garbage.

--=20
see shy jo

--vwrg5avozjrh2i6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FpfY7MdJMHr8NgcyRDZIiUS48cFAlivSkMACgkQyRDZIiUS
48cLiQ/+JTSPSJK39BmC9qERSq0G21smBKzSjGzegptTGcdr/dspMWR8XnivpLO4
74QMYoGP96Uozm4DRJ7OloB3FmLJwj5HDAnvlsBuReD2ydmLhUc0eXEixf3u8UB7
8XIAzB5AVYpFjyebpd5Fu0NEjJndr3UwE7jMh1wC2eimE9yf86kt2Qi0QmXNchSZ
AIoiOaqx7FO1OK7OX4HtKrkf4i4BjYLiw3o56E0xoFroP6lUT7+0MucmnTCXVsXa
Hpy7rZo26JFENw+LetTUi4nv2W2Wsb80C8MWb513oG9odcF/gbLQMg92vMqv14eu
KcunaW2waZoM1+a8GONmVyQGGh1Ikt35uvZ5/6Llo5RL14wGGBMVRIcU4vSKeX3+
Ueo9wD1wdPMNGi1Wglw9RFid2fZjO//oLSeCwI844cUdu84Wj9H17hvXW7nnoq2B
k3EOKN1Wmtgs7qKL19woTSgWkzX68lQ28WFUMqUBgtM6KN2JsMOxYLp79cR6nIgx
jNDQNzo9nxULL587urShCjHI5JVidxBT7h3r9Sf/V3yUrOgiwNGny1PhM4GoSslg
BnTyNCjMWEuJdqRrJEsdtKPlbYh/s23G16saIJHLyC9mlUeeSO4K6TcTmQp5aY2+
9tWKXxwqBTlBXBLtHzrvdTq9KbWB7qkPT43ZGBGf388rKLHtXHs=
=Lpr8
-----END PGP SIGNATURE-----

--vwrg5avozjrh2i6s--
