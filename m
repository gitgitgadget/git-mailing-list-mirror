Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1C8C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F421241A6
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506711AbgJUW3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:29:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54314 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506707AbgJUW3j (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Oct 2020 18:29:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4F6596042C;
        Wed, 21 Oct 2020 22:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1603319347;
        bh=D2vlXcIzRgM2EOaroqLSDm8sMcu9OUN+Hy9k0y05B58=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uQRZwfFbtlIZLfhV6tr93K3eSvjIgnwlsegpX2iOknLaomolPrB6q/2G2Bgh/jD3o
         U4kQcIr19yMvHOpI4hpCTbeYitUWP7JFCzEdJ6RqIJPpPaYAx7YuvAmMQ5tjJrtGfD
         H+jlzsna2HAW3lEVSSdqy8p2yvx+FgAw4TB4NfsosYFsi4DKcnZ21s90q6kz16q3EE
         KDiN0OBwB+V4T/Ol/1MVslN+VbxLsUN9dpVYQpiQlVCJfG5hnyhOfRflD3OHD4RJWI
         Log0iejwCs7emh5dYvIPchAC9Caq4v8sDWWyIXM0hSFmmIPAoiIjLS+0mJx8qz0W6f
         YB9bZjg5hZVoxm5v2ZZRzwPtN60UsV/WkuC6ixiThIHRho2oV6VzRXb31/mHCd028x
         k+sK4vQAYqjor12XZXcid+OWDFjRRRAg1LIK1vZkRc75gAXvsZECl7WK6Wts4jLcKv
         DlKUS2b+deAxGD0wPm0HlBmPgrtYUx7lP3L/nMxz2BcbbmLnQog
Date:   Wed, 21 Oct 2020 22:29:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nikos Chantziaras <realnc@gmail.com>, git@vger.kernel.org
Subject: Re: git svn log: Use of uninitialized value $sha1_short
Message-ID: <20201021222901.GK490427@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Nikos Chantziaras <realnc@gmail.com>, git@vger.kernel.org
References: <rmpve5$q2s$1@ciao.gmane.io>
 <20201021202642.GA60606@coredump.intra.peff.net>
 <xmqqwnzj5mq5.fsf@gitster.c.googlers.com>
 <20201021212917.GA62005@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45wMVEkw4XUbiYON"
Content-Disposition: inline
In-Reply-To: <20201021212917.GA62005@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--45wMVEkw4XUbiYON
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-21 at 21:29:17, Jeff King wrote:
> Yeah, I'm almost certain this is the solution, but it was a little
> disturbing that no tests catch it. Besides the warning, it probably is a
> functional problem (I guess that regex is now overly broad since its
> last half is blank). But maybe it doesn't matter much. It looks like
> we're parsing raw diff output from git-log. Short of a really bizarre
> --format parameter, those are the only lines that would match /^:/
> anyway.
>=20
> The tests do catch it if we do:
>=20
> diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
> index 3858fcf27d..92e223caed 100644
> --- a/perl/Git/SVN/Log.pm
> +++ b/perl/Git/SVN/Log.pm
> @@ -1,6 +1,6 @@
>  package Git::SVN::Log;
>  use strict;
> -use warnings;
> +use warnings FATAL =3D> qw(all);
>  use Git::SVN::Utils qw(fatal);
>  use Git qw(command
>             command_oneline
>=20
> but:
>=20
>   - we'd need to do that in each .pm file, as well as git-svn.perl
>=20
>   - I wonder if it's suitable for production use (i.e., would it become
>     annoying when a newer version of perl issues a harmless warning;
>     right now that's a minor inconvenience, but aborting the whole
>     program might be a show-stopper).

No, that's not suitable for production use.  Perl does add new warnings
=66rom time to time and breaking things when Perl gets upgraded will
definitely not make us the friends of Linux distros.  Doing this is like
using -Werror: fine for your personal development needs, but not
suitable for shipping to others.

We could run "perl -w" on each file and look for a single-line output
with "OK"; that's what we did at a previous job.  However, any change we
make here needs to be conditional on DEVELOPER, because otherwise anyone
who needs to build an Git with a new version of Perl will potentially
have a broken testsuite.

> It would be nice if we could crank up the severity just while running
> the tests, but I don't think there's an easy built-in way to do that.
> This seems to work:
>=20
>   use warnings ($ENV{GIT_PERL_STRICT} ? qw(FATAL all) : ());
>=20
> though I'm honestly surprised it does (because "use" is generally
> resolved at read/compile time. I guess perl is smart enough to run
> that code snippet at that point.

Yup, that would run at BEGIN time.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--45wMVEkw4XUbiYON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX5C2LAAKCRB8DEliiIei
gYzIAP9eDnrXx5gReYXWne43z+3mROB/fA0S2ABlgGQtHU95ywEAhO8Hij2JCq09
I5vKNzP6L2qzLjBUDaXG2sOejvAmTwU=
=5b8a
-----END PGP SIGNATURE-----

--45wMVEkw4XUbiYON--
