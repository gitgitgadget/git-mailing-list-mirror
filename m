Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC2C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 19:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF856100B
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 19:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhFRTQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 15:16:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51860 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234205AbhFRTQQ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Jun 2021 15:16:16 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 60E8460443;
        Fri, 18 Jun 2021 19:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1624043616;
        bh=OJ40JIOrKU9KAgHzfVz9HKE+apRufSdHWUNp8uowpVw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=a2XGBpcg4Es3KPUqe260au8r3Y7q01gMkUDUJt3TZGuMbnI/XvjIOVlXPwkiwHqcq
         Jr4heLee1T1M1/xgUwHcDqnUbdRFfWk8xuB8TLI7ebozIdGOZ/YS8NEXk+mdN5or2b
         9Tnnz7MJetUo7oSsr8cyDTGM2KLLkv8VeSWTu6MtFilkEGLCynbwrh13bfsKDwjIuk
         lWGaL+ADDILi4VBH2skfHQlT03Efen0lB0msNw7vZn6EdHV3Wwrvh7ZTGSQzXU9LJR
         OuL4lC4i1A21ZXoS0QP1QKykbujjMES1r62WRm4pvD3gmbIbOm9ey8bLL73jz9DPxb
         xUX7qz+UaaWjUrjAJXJuMERmKlZIad2e/dRSeOJCJ/mE2DPSFVVbbQFfDU8A9Gl6Zl
         9nKCcw6ON7lBCZSZqzss86nWXDL+rERqtahBgTZ3jlW+Q/joq8HXAP0cExwT8HAsMM
         sf8yhfKD+muPAzhGcyqVRHa73lQyMPgd0e9U7r9rj4J9Qw66XrZ
Date:   Fri, 18 Jun 2021 19:13:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: use portable wrapper for readlink(1)
Message-ID: <YMzwWxkQXjDT+mi+@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <YMzKlrmHFZdx2ti9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgEPKC/CPVkgCGvt"
Content-Disposition: inline
In-Reply-To: <YMzKlrmHFZdx2ti9@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lgEPKC/CPVkgCGvt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-18 at 16:32:22, Jeff King wrote:
> Not all systems have a readlink program available for use by the shell.
> This causes t3210 to fail on at least AIX. Let's provide a perl
> one-liner to do the same thing, and use it there.
>=20
> I also updated calls in t9802. Nobody reported failure there, but it's
> the same issue. Presumably nobody actually tests with p4 on AIX in the
> first place (if it is even available there).
>=20
> I left the use of readlink in the "--valgrind" setup in test-lib.sh, as
> valgrind isn't available on exotic platforms anyway (and I didn't want
> to increase dependencies between test-lib.sh and test-lib-functions.sh).
>=20
> There's one other curious case. Commit d2addc3b96 (t7800: readlink may
> not be available, 2016-05-31) fixed a similar case. We can't use our
> wrapper function there, though, as it's inside a sub-script triggered by
> Git. It uses a slightly different technique ("ls" piped to "sed"). I
> chose not to use that here as it gives confusing "ls -l" output if the
> file is unexpectedly not a symlink (which is OK for its limited use, but
> potentially confusing for general use within the test suite). The perl
> version emits the empty string.
>=20
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is a re-post that doesn't seem to have made it into "seen"; the
> original[1] was buried in a thread, but =C3=86var reported there that it
> fixes t3210 on his AIX build.
>
> [1] https://lore.kernel.org/git/YLk0Zm2J6VOA%2Flks@coredump.intra.peff.ne=
t/

In case I didn't say it up in the previous post, this looks fine to me.
Using Perl here seems like a fine solution.  If we needed to in the
future, we could add this to test-tool and use the real readlink(2), but
we can hold off until we decide we need to.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--lgEPKC/CPVkgCGvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYMzwWQAKCRB8DEliiIei
gftzAP9oyqcDtOunuX7QAsWX5yRn0jWY4OrcBTs7AxrKSPt6dQD/a1WUYFth3vvf
tiBLOtNVBUIzSlFcUFFieONz8XltRAU=
=/xqt
-----END PGP SIGNATURE-----

--lgEPKC/CPVkgCGvt--
