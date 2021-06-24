Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5327C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E6061351
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhFXXN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 19:13:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56314 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232614AbhFXXNz (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Jun 2021 19:13:55 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8AF4C60424;
        Thu, 24 Jun 2021 23:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1624576292;
        bh=cFYGqVm6uosE0kfmirnq3bLOb5aqeTka1RVf4IjtC0k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=n2ogGg/83Nr+hI1RrQFMaiIQCI9mLCWwzxTBljwngNaapOFaBNKYooGf8yE4BkNQ7
         87A/8GuJmcf99VM6kj90EcZO6AMTSGs0VAfARKLt//v8BNqNIAea5mg3b70tUxzjyQ
         dmqxHjBvrvA+CY913/exDDOGcLALCkZ2I58kYMqbYUy2/T3AIRcntO7xIGAfky8btZ
         Wjeg3iIFP8r+j4C1bV+ZFEJ3+drf0S5vgwhUa4P8X7v8Uk8laIGTbfGw71eDD1Gn4l
         Yu1Zuf2e9MKJ50pjGA0wvDlNRFcviDZlSRudB/Zt3DRcHRDlZc7yYTgB7kSTnkIliC
         tBMPgoBPKzm05JcjrKCZBW2YZxk4I3IzBjjctEg9QjyC3+eT3lpOIDSjxXOY0RMJ9x
         LYmqdHXZOcxOs17L/MeOg//9r4iR0+5UCUzszsr3URQkeuRjok4IRVI0M4YBxtjUfq
         Mf0OQxN4jEPrqaRg15haDET+Lnb1SKsvs/ipYWuI7Osz83YgeOr
Date:   Thu, 24 Jun 2021 23:11:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
Message-ID: <YNURHyBLaPjlKSSn@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        emilyshaffer@google.com, avarab@gmail.com
References: <YNExhalSLWvmky55@camp.crustytoothpaste.net>
 <20210623225809.4023571-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wF6p1KuBz6WWjXhZ"
Content-Disposition: inline
In-Reply-To: <20210623225809.4023571-1-jonathantanmy@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wF6p1KuBz6WWjXhZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-23 at 22:58:09, Jonathan Tan wrote:
> > If we do add this feature (which, as I said, I'm opposed to) and we
> > decide to store it in a ref, that ref should not be a normal branch by
> > default (it should be a special one-level ref, like refs/stash or such),
>=20
> Any particular reason not to expose it as a branch (besides following
> from your general idea that a user should seek out such a feature and
> not have it presented to them up-front)?

Branches are for the main code of the project.  While it's possible to
have orphan branches that do other things, I think that's in general an
anti-pattern, and using a special ref for things which are separate and
independent from the main code of the repository would be a more elegant
solution.

> > In addition, there should be an advice.* option that allows people to
> > turn this off once and for all, and it should be clearly documented.
> > Ideally it should be off by default.
>=20
> I don't think this would be considered "advice" like the other options,
> but having an option to turn this off once and for all makes sense.
> Making it off by default would probably mean that projects that use such
> hooks would recommend cloning with "git -c my-config=3D1 clone $URL", but
> perhaps that's OK.

Sure, I'm not picky about what it looks like in "advice" vs something
else.  I think forcing projects to explicitly opt-in to this behavior
means that the social engineering and security problems are much
reduced, and while I'm still not wild about the idea, I would feel much
better about it.

> > This also makes me deeply nervous for much of the same reasons.  There
> > are situations where e.g. ignoring whitespace can lead to security
> > problems in code review (think Python), and in general it's hard to
> > reason about all the ways people can do malicious things.  Typically
> > adding untrusted config ends poorly (think of all the modeline
> > vulnerabilities in Vim).
> >=20
> > I'd definitely want support for this to be off with no prompting by
> > default.
>=20
> To use your example, the model we're proposing is more of only using the
> modelines from sources we trust - as opposed to ensuring that all
> possible options set by modelines are benign. Admittedly, the
> administrator of the source may have difficulty ensuring that bad code
> doesn't slip through code review, for example, but that is a problem
> they already deal with (at least for projects with any form of
> executable code in them, e.g. production code or a build script).

As I think I've previously mentioned, I don't want to receive
configuration of my development environment from sources I trust.  Even
at work, I don't want the repositories I work with to modify my
development environment in this way.  I tend to have a highly customized
configuration that breaks many people's expectations about tooling, so
the cases that this isn't a security problem (in repositories I trust)
can still result in a functionality problem.

Also, since we don't know what repositories the user trusts, the only
safe assumption is that the user trusts nothing unless they explicitly
tell us.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--wF6p1KuBz6WWjXhZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYNURHgAKCRB8DEliiIei
gYMZAQD3eexD53tolPa0zblVlNzBHWhsA9w3w5tTNJj5D/bVKgD/QJikeJpUcTum
hHyE0NSrRDtcP3lWvToumTuJqyZwogc=
=zkYP
-----END PGP SIGNATURE-----

--wF6p1KuBz6WWjXhZ--
