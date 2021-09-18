Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5CFC433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 17:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F938601FA
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 17:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbhIRRUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 13:20:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43024 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238582AbhIRRUN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Sep 2021 13:20:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 81DBA6048E;
        Sat, 18 Sep 2021 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1631985498;
        bh=A97un3k7ybI8VnJcSIGbHG7fQh59nXV2f5suyXlGsb0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=esR05i4Y3c9jAQHzJ7hlTXAniuaKXGQGAC/QCo2aBe+UYsvCF8cx+5s9bOaQmn7wM
         Xg8d0+8pJhR6nDFMGQfruMsmZEqvF59iDo1MR3OpyUyZ8ng2uAppP3ZykYEDmxM6Tc
         moyM2oFIEqGwFNRsLpUFBdQVClxeC62xJw9YbZAwsTkPuxeHabO825FrsUKFOs57Cb
         DuOsE25+1ftC9DOn+BG7hYvEka+xOiii9UVoav77f72QDLD7028+v5iYN38GzJ8Vp6
         XVMSQYCupQoECXW+fJ6IWkOg3CHvxSPQLUwqYG9K61peVSIwV853ozU9r8qpzwcyLr
         ZS/BMqxmKEvzcpTKEfld+Z417wuCfFSMSKY2tTjGRwZbPCFI8Mz7sONasl7FjYSaYv
         eD6I1a5BkX8daB7Pqz/YJ7U72kx9gT1WUpOVwatZsSbqhO1YJ0ov/1JPbMw3f7sZuh
         56XzmQntrYsET+NfUQUg2pajg0OO2uv4THmZqhjG0qMdJ42rbPw
Date:   Sat, 18 Sep 2021 17:18:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH] connect: also update offset for features without values
Message-ID: <YUYfVM8jMkPG85qT@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, Andrzej Hunt <andrzej@ahunt.org>
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dWeg6ZW31YmCcS4q"
Content-Disposition: inline
In-Reply-To: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dWeg6ZW31YmCcS4q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-09-18 at 13:14:32, Andrzej Hunt via GitGitGadget wrote:
> From: Andrzej Hunt <andrzej@ahunt.org>
>=20
> parse_feature_value() does not update offset if the feature being
> searched for does not specify a value. A loop that uses
> parse_feature_value() to find a feature which was specified without a
> value therefore might never exit (such loops will typically use
> next_server_feature_value() as opposed to parse_feature_value() itself).
> This usually isn't an issue: there's no point in using
> next_server_feature_value() to search for repeated instances of the same
> capability unless that capability typically specifies a value - but a
> broken server could send a response that omits the value for a feature
> even when we are expecting a value.
>=20
> Therefore we add an offset update calculation for the no-value case,
> which helps ensure that loops using next_server_feature_value() will
> always terminate.
>=20
> next_server_feature_value(), and the offset calculation, were first
> added in 2.28 in:
>   2c6a403d96 (connect: add function to parse multiple v1 capability value=
s, 2020-05-25)
>=20
> Thanks to Peff for authoring the test.

Thanks to both of you for the patch and test.

>     Note: I modified the test by adding and object-format=3D... to the
>     injected server response, because the oid that we're using is the
>     default hash (which will be e.g. sha256 for some CI jobs), but our
>     protocol handler assumes sha1 unless a different hash has been
>     explicitly specified. I'm open to alternative suggestions.

This is a fine solution, I think.

>     ATB,
>    =20
>     Andrzej
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-109=
1%2Fahunt%2Fconnectloop-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1091/a=
hunt/connectloop-v1
> Pull-Request: https://github.com/git/git/pull/1091
>=20
>  connect.c                      |  2 ++
>  t/t5704-protocol-violations.sh | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/connect.c b/connect.c
> index aff13a270e6..eaf7d6d2618 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -557,6 +557,8 @@ const char *parse_feature_value(const char *feature_l=
ist, const char *feature, i
>  			if (!*value || isspace(*value)) {
>  				if (lenp)
>  					*lenp =3D 0;
> +				if (offset)
> +					*offset =3D found + len - feature_list;

Yeah, this seems sensible.  A few lines above, we compute the value
offset ("value") as "found + len", where "found" starts as
"feature_list", so this will be either the space following this value or
the NUL byte at the end of the string.  That means that we'll make
progress next time because strstr will start searching from that point.

(I'm sure all of this is obvious to you, but I'm just mentioning it to
ensure that my understanding of the code is the same as everyone
else's.)
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--dWeg6ZW31YmCcS4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYUYfUwAKCRB8DEliiIei
gcnGAPwJ8x+u34nDp0AunKOceqX+jIulDSsZtqgIwV47PIQPaAEAk4443nx4fGBG
x2/2lkYHO+VqaZ9oBXeMyk9tLQubXQs=
=mgqX
-----END PGP SIGNATURE-----

--dWeg6ZW31YmCcS4q--
