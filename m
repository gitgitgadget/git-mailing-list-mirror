Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86391F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeJQHT1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:19:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50950 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbeJQHT1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 03:19:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6A9E261B72;
        Tue, 16 Oct 2018 23:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539732402;
        bh=ZJRN1H6/T6mxYXKOp6NjdZ78lA3dkpMe/HE+L50KbCw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uCRIzDfy3GGYhRAL0bcj0JwsgTmuy6IwMMX/mnvh9rA1rBB0Rwe7QPvssyGQxz/RU
         faS27GYMLf3c69HH3epoEcTVpx26UzyQJv9O5kBZpcqavAIAhW3ajP9QLT5g9twWOn
         m1kzyQGdNq3xE2tlUfcj+mYlGnHneSRQ6qgY2B9WfHRxevMnEcYvngBURUwm1sOKxT
         S3UCwgxgYZNbTUldrGNhaHsIQ/Aj/PNqv/Mq1MAGaI0nOGoYw/QwWOQrjwGQWZJCQp
         2TWrVI1Ty+2fHyP+lEzlmms+UTdtpzVZl6JbdI07YS9AKG+Pw6mPGnTzf9v6K7loc3
         XrXWDhnASuU8ElDCOtbIkPxXq+onq2FhhhAxHEi1T/pcp3+xEqGb0mtwMup9ozDF5F
         oxriamK2FskiqcRPe/6F+Nt6BqhJJlBqJcIONqdhBN/QxZi6PFuSfdgJ0wvt+/Mfli
         VyPCLx9fZ2xSw2QhRXAlX0sinAITsNPEsFNSeqadyUt/O5vOd15
Date:   Tue, 16 Oct 2018 23:26:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stas Bekman <stas@stason.org>
Cc:     git@vger.kernel.org
Subject: Re: problem with not being able to enforce git content filters
Message-ID: <20181016232636.GF432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stas Bekman <stas@stason.org>, git@vger.kernel.org
References: <5d4966c8-8171-9a0a-5120-f7c151c2b81f@stason.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cNa0Phtf76TQ4tlb"
Content-Disposition: inline
In-Reply-To: <5d4966c8-8171-9a0a-5120-f7c151c2b81f@stason.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cNa0Phtf76TQ4tlb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 01:36:37PM -0700, Stas Bekman wrote:
> The problem is that it can't be enforced.
>=20
> When it's not enforced, we end up with some devs using it and others
> don't, or more often is the same dev sometimes doesn't have it configured.
>=20
> When a person has a stripped out notebook checked out, when another
> person commits un-stripped out notebook, it leads to: invalid `git
> status` reports, `git pull` breaks, `git stash` doesn't work, since it
> tries to stash using the filters, and `git pull' can never succeed
> because it thinks that it'll overwrite the local changes, but `git diff`
> returns no changes.
>=20
> So the only solution when this happens is to disable the filters, clean
> up the mess, re-enable the filters. Many people just make a new clone -
> ouch!
>=20
> And the biggest problem is that it affects all users who may have the
> filters enabled, e.g. because they worked on a PR, and not just devs -
> i.e. the repercussions are much bigger than just a few devs affected.
>=20
> We can't use server-side hooks to enforce this because the project is on
> github.
>=20
> And the devs honestly try to do their best to remember to configure the
> filters, but for some reason they disappear for them, don't ask me why,
> I don't know. This is an open source project team, not a work place.

This sounds like it could be easily solved by continuous integration.
You could set up a job on any of a variety of services that checks that
a pull request or other commit is clean when when the filter runs.  If
it doesn't pass, the code doesn't merge.

This is what other projects do for style-related and tidiness issues.
Similar approaches can be used in other situations to enforce that all
line endings are LF, or whatever your project desires.

I don't think it's a good idea to provide Git configuration to end
users, even with prompting, since there are many novice users who don't
know what the security implications of various config options are.  I
also personally never would want to be prompted for such a thing, so
even if that were a feature, people would turn if off, and you'd be no
better off than you were before.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cNa0Phtf76TQ4tlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvGc6wACgkQv1NdgR9S
9ov63hAAiG/XN15wldT89Jkq+jDv3w5UqsCPTwNYEem3Y1jeWWHJJaxaRYBlA0me
l96Cz4wuOrMEosXs3m2Xkq3LXSb3a8QH61w6EswUTHLVL6jMvGjR2ySUxA5uZm23
65Y9lvVuF0UXe9XvJ7BssRcEgVXt/JWA5WllZmbYCR/8z2Aa3yX8oZCtmMXQVDl0
z8oyZJW8p7D87QmiYFJCOnbJiCv/6I/UN73icSjCz7vMjDAB1rpy5pmSwCY2x3m0
4lodDSPUGGjUCl44OVmJOtdfliTbB861pEKhMGIr3XdABQkWLx/CO23YrXUQRsjy
Wyk6nF3mu8YoSb+PCDWqbkM58V83IHDlXCsv8aVk00c6SOuod0zdz5AWrHrug153
tdnpuq3t1oVTaVBWLghZHvwYEtUY7yl93/nrFvYh8ZWGOM3FM/93was/ngzJGnpY
nXk8etuhbMNX7D8TRP804m8Ux+b6S4gEDdh9Sf46ty+95GIKHbEzDF9aRO4gqkq/
33yd0LRAb5GvfyLZrtFY7VJ8U/2ZX3fPYII129fHVc8Lpg3baNX6NQp1WTZOOBLT
ZG1ilQ7RVwJddy9N8tZCUMf937WvUYl0eLWFGFAlVKyS9JIGn2R8vKQPIZsDme18
9YaNj33z5JLV0Bpe+s1vjp/emr3/HLH6cuAe1SmhkQHQgRThbao=
=meum
-----END PGP SIGNATURE-----

--cNa0Phtf76TQ4tlb--
