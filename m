Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1621B1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 04:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbfHGER4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 00:17:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57316 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbfHGER4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Aug 2019 00:17:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c831:5a62:6d5c:8da3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DB81B6047B;
        Wed,  7 Aug 2019 04:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565151474;
        bh=2w6Rd6LlUkIfuAW8VLOKunz3YF4GXin5pABAXtq+kjg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=c55QJ//n/c7n+k+Em4Y/6mUC/vsPKpPMYpMJ1rTGpGbxj9GV5LI7mtDVTM/+As4UX
         gb6dfzYH2KuxPsI5h/Y1jzOo/yme0rjYgmm8ouYq5Sbv9rsWm1/OSaILx6EfylsRxK
         QqAH1lls2RTJhPYP7n4SrNN23NVUfiQObjhjJgJFc/v9LZ2IUuy5tGuKhPDzPkPmn0
         OVrtBhCiYF2o35A3C8qTfGe892ATwqVBeHTMT7Q1vpEmIvvq5bn4XZy+0CJMkbFlJO
         +0eEazOFCfLlqj6GcDk6V0J36KT4NvbY3S0OXLVQNV7lRUpowkY1tM4uuFPPdERrqk
         MLNXf58EQe2daqKnwwy3Nt7mab3DrGc4TnX5GSR6m62KXEwFpDzioN4PJCgCoX9DzW
         Ls3xfCoVBbjfUo2a/4YDc1r7grVF1QJcyANLwG10B1kUrh3zznKoVizsumUDIY2Srg
         nlEJsaJ+8nfjoxJq6pU1PSuKYpml3cfoWk3161dUrAfFsRjucqm
Date:   Wed, 7 Aug 2019 04:17:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] --end-of-options marker
Message-ID: <20190807041749.GI118825@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190806143829.GA515@sigill.intra.peff.net>
 <20190806225853.GH118825@genre.crustytoothpaste.net>
 <20190806234319.GA19178@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C01fF7hLGvN0zd9s"
Content-Disposition: inline
In-Reply-To: <20190806234319.GA19178@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--C01fF7hLGvN0zd9s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-06 at 23:43:20, Jeff King wrote:
> On Tue, Aug 06, 2019 at 10:58:53PM +0000, brian m. carlson wrote:
> > Sorry, I hadn't had a chance to look at this series in depth, but I was
> > wondering: could we not just accept two separate "--" arguments, and if
> > there are two of them, interpret the first with the traditional meaning
> > and the second with the Git-specific meaning? That would be much more
> > intuitive for folks, although I suspect it would take a little more work
> > in the options parser.
>=20
> That also crossed my mind, but I think it opens up some complicated
> corner cases.  For instance, if I'm parsing left-to-right and see "--",
> how do I know which separator it is meant to be? I think the only rule
> that makes sense is that you must have two "--", like:
>=20
>   git rev-list [options] -- [revs] -- [paths]

I was assuming that we wouldn't have a huge number of command-line
arguments and we'd check ahead, although that could of course cause some
pain when used with xargs, I suppose, especially on Linux with its huge
ARG_MAX.

> but that means parsing the whole thing before we can interpret any of
> it. What kinds of tricks can an attacker play by putting "--" in the
> revs or paths areas? E.g., what does this mean:
>=20
>   # expanded from "git rev-list -- $revs -- $paths"
>   git rev-list -- --foo -- -- --bar --
>=20
> I think if we at least choose the left-most "--" as the official
> end-of-options then they can't inject an option (they can only inject a
> rev as a path). I guess that's the same as with --end-of-options. But it
> somehow feels less clear to me than a separate marker.

I suppose if there's more than two, then interpret the first one as the
end-of-options marker, the second one in the traditional way, and any
subsequent ones as pathspecs matching the file "--". Writing such a
command line would be silly, but we'd fail secure.

> It also doesn't allow this:
>=20
>   # allow paths and revs, with optional separator, but no more options
>   git rev-list --end-of-options "$@"
>=20
> though I'm not sure whether anybody cares.

That's a good point. I don't have a strong view either way, but I
thought I'd ask about alternatives.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--C01fF7hLGvN0zd9s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1KUOwACgkQv1NdgR9S
9ot3zA//VPBAeVc9MPSAb5jVfJaOaH9qDrwUtLvBr6LdteNQMroXWCbzZYojmu62
LGitoa/0/YmMfFT16AD+lpKdeiO+6cIsOTE6G6KgPk4W84fcrj70vcltsQYqC8B5
fC4w3Pd9l21U4/4gkI4kJdz7Ep0wGVOe1xBPG+ezXYGvNQps5E7YpTTQCf3Cekwb
ZHpye3RSJxZquwEaky+6kpOWwzjDGFLwuEYeoWloxS2pm6hadzqLP//sCuXNXqrx
3c4Y4IckJ4BseDAbV836GaMLcg0Ah04QosneExCJcQNw300dTaigSLg0IQIYJyaa
EFo2iv92rTW+wf5Vws0t88Ff4kS1APdbgtwp9Ioz+O4815zxyn0NQIx8GM5irzDU
gweb9uw+Ev2LuJsku1bYKeoVlUMWYhwB9vTmKaMAd3748RXWhsoe8BJLgu0QdGUP
ShtpgMEIfN6YUx/+JicqQ09uuJygd41An6jjN3v8vo35B7FDp/IH9RIzIJssnyLs
1oHzZVA0mBwSNyt/YnlxqJYEaa74H+fYCdarLYQyytFK7AqoUyQiaTK/b3ruP2vD
smC6F8/hR74qiOPQqeJHSvDzKXk/u9CMiQWeCPDh+9f4Q7wq3VUsKtcAhw3bitDj
RIaQtvQMxCUZtzonE4DRfalib3u8jyQOJRbwZqRdn4RihPvKOb8=
=bYWE
-----END PGP SIGNATURE-----

--C01fF7hLGvN0zd9s--
