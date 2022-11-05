Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F21C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 18:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiKESKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 14:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiKESKR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 14:10:17 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A3CDE94
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 11:10:15 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7DB205A1FB;
        Sat,  5 Nov 2022 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1667671812;
        bh=UP5P17I0bSWdP5w7Q3BDVAUHXmDHXcsnz/dl/um1nZM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=q2MC4rnwDdZr4ct6aRjfcGTgkpxbOnvFX4ATQoH143xgF7mtR4+042kkTjRuHeoYR
         OzoPQxX6QHftPY5odpLTSvOf+LXUajTTicq4hkbMClOsHi7hbAGOsNBvJoXvC6Ow6c
         U20uRNBxc69D5oO9UBwkyepgtyqts/n6EiW0yiyNLGJ18zicK/Op1fNuSgM5asYtud
         L++2LyIWHGqCqsi6WApbWMMwZKYt6CUNDLSi4fINQyJY6lYPuddJjpHztrdS+6pQmH
         druEpKpSPs/022AealLOVnnKwps7ouOj15JFVYttTre33lD+bicEjl2V3sDOZ5hzej
         L8Mu45tOZQPgNRPdH3d16UzdHJ+ZiGGhR6ETjen7q+LB/H9kytmkWD1SmNGJUnUk71
         DearCY6znFEAPNGa1iHiSaqfmxtFwe2Png98vLDSI98FFTDyq1LdCJcnNUeOsesiNZ
         wK9Zk4wmASV0lOBi4URA0iBEDO8ffUaux/f8+M/HRsOpRLlyEKY
Date:   Sat, 5 Nov 2022 18:10:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Wu Zhenyu <wuzhenyu@ustc.edu>
Cc:     git@vger.kernel.org
Subject: Re: Can git send-email support neomutt?
Message-ID: <Y2anAijZxu9QEX4M@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Wu Zhenyu <wuzhenyu@ustc.edu>, git@vger.kernel.org
References: <20221105154600.hbrqs74inmvpebie@desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="di031d/VM3MIHznv"
Content-Disposition: inline
In-Reply-To: <20221105154600.hbrqs74inmvpebie@desktop>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--di031d/VM3MIHznv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-11-05 at 15:46:00, Wu Zhenyu wrote:
> Excuse me.
>=20
> I want to use neomutt as git send-email's cmd:
>=20
> ```
> [sendemail]
> 	sendmailCmd =3D neomutt
> ```

Mutt and Neomutt are MUAs, which stands for mail user agent.  That is,
they're mail clients that people use to read, compose, and send email.
The sendmailCmd wants an MTA, or mail transfer agent, which is
essentially a mail server.  It's customary for most Unix systems to have
such a piece of software which emulates the original Sendmail in its
command-line interface, even if that's to send data off the system.

That's why you see a fixed interface here, because whether someone is
using Sendmail, Exim, Postfix, or a smarthost-only tool like esmtp-run,
whatever software is being used presents the same interface.

It's not likely that we'd add a lot of customizability to this option.
However, you can use the same SMTP server that you use with Neomutt by
setting the smtpuser, smtpencryption, smtpserver, and smtpserverport
options.

You can also use `git format-patch --stdout | neomutt -f -` and that may
provide you the same functionality you were hoping for with
`sendemail.sendmailCmd`.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--di031d/VM3MIHznv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY2anAgAKCRB8DEliiIei
gVvjAP4z1JqFkM4hROitWgnAR8o+lguCrPCuXlrNkJ6w3dSNKAD/Y6ceej/RdJx0
7nSTKgdgyaMOnvPMcxYHVrwAIdjQmw0=
=lTZB
-----END PGP SIGNATURE-----

--di031d/VM3MIHznv--
