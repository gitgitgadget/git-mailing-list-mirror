Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70B751F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 01:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeK1MVh (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 07:21:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56458 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726924AbeK1MVg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 07:21:36 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c029:e61c:1a0c:a1e6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DE02C603C6;
        Wed, 28 Nov 2018 01:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1543368108;
        bh=sfliYMNAsXwOXTEv85kDBTkCUouEoP185HC2X5rGAWM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OBC+wtvoV/SfUIBY4tOw59u/PyeAnEKPOPfTMLZctXw0t049hDPj94CebMwXTFtRD
         muCLZ4LEHYhw6657UwxncB/7J5vW9kWXMBZ6FHRwdJOrPsvAsqiz6iCeOfH8cUJDgT
         +S1pbfJJmQtBtrshlsTE9FGXJtBa42RRoZBOlE1nnRAAChN+zp5CDLXvOmTspXquiD
         fIN1gPV2vivoxWlOTihYtdH2qTP/Qs0Q9yCwaXjGPq9IbE/IF6+j74ucxdIpQStJfD
         O06ncTxIqPPdfVMVVcyVtqzNW/hGVPmuvXpSKWvLngSIk/aH705FHMP0/Noi6DoIMv
         vfaENqNKk44zwUtrwkPHabsmpi235IvKFYh9rXUuiQXTODOqSAiqGr3eCYFGyGpCX/
         fk4b2bWHNECRaA5/jOhP2Jn6rbsinlvIksBsnJsBOGuktW6+bsghREHAJtLHs50bQD
         tTJdZe+zCP9eFS7SJmqp12zLzGG2Ic6xZ6pQlB2vbFuc0dtNJ+A
Date:   Wed, 28 Nov 2018 01:21:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Per Lundberg <per.lundberg@hibox.tv>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        "jost@tcs.ifi.lmu.de" <jost@tcs.ifi.lmu.de>,
        "jjensen@workspacewhiz.com" <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        "drizzd@gmx.net" <drizzd@gmx.net>,
        "hellmuth@ira.uka.de" <hellmuth@ira.uka.de>,
        "kevin@sb.org" <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
Message-ID: <20181128012142.GT890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Jacob Keller <jacob.keller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        "jost@tcs.ifi.lmu.de" <jost@tcs.ifi.lmu.de>,
        "jjensen@workspacewhiz.com" <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        "drizzd@gmx.net" <drizzd@gmx.net>,
        "hellmuth@ira.uka.de" <hellmuth@ira.uka.de>,
        "kevin@sb.org" <kevin@sb.org>
References: <20181112232209.GK890086@genre.crustytoothpaste.net>
 <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
 <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com>
 <87sgznzwcp.fsf@evledraar.gmail.com>
 <CACsJy8C4deg=M+sjmTBM-qs_=zZ9KarND3MNaR6-MqxukBJoSA@mail.gmail.com>
 <87pnurzvr6.fsf@evledraar.gmail.com>
 <CACsJy8Ck7CZ7JWaN6ark=wrAngywJJh76y-FvJ87gE2ckVS8pg@mail.gmail.com>
 <f6aad4a2-8cb4-acc2-af9b-9c9c82059b89@hibox.tv>
 <CA+P7+xri1=peNpEiZCE802HwCXhojyp2BDvOR+6BBSoRtsZyzA@mail.gmail.com>
 <56ffc52f-644c-2c1d-6a16-c1005b064385@hibox.tv>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FT/vNgDLxVq4t/AU"
Content-Disposition: inline
In-Reply-To: <56ffc52f-644c-2c1d-6a16-c1005b064385@hibox.tv>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FT/vNgDLxVq4t/AU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 02:50:34PM +0000, Per Lundberg wrote:
> I agree strongly with this personally; if we must choose between "might
> break automation" and "might delete non-garbage files", I would say the
> former is the lesser evil of the two.
>=20
> But, if I had 10 000 000 servers set up using automated scripts that
> would break because of this, I might think differently. Quite likely so,
> in fact.
>=20
> What are these automation scenarios _more specifically_? Junio or Brian,
> would you care to elaborate? Is it for build servers where you want "git
> clean -dfx" to always reset the working copy to a pristine state or are
> we talking about some other scenarios?

We had long-running CI servers, since bootstrapping a new system took an
hour.  These would check out the branch to test and run some process
(essentially, a "make" and "make test").  Then, another branch would be
tested, and so on.  The old branch would likely not be merged at this
point.

The scenario I'm thinking of is when a file (say a CSS file) became
built instead of stored in the repository.  Then the file would be added
to .gitignore in the new commit, and it would be generated as part of
the make step.  It would be important to blow away that file away when
checking out a new commit, because not doing so would mean that the CI
system would simply fail to work and require manual intervention.

Moreover, a CI job might fail, due to either a flaky test or a
legitimate failures, so the job might need to be re-run multiple times.
Requiring human intervention, especially when such jobs might be running
at odd hours, would be undesirable.

Another thing we did was to use a specially named gitignore file in our
build step.  We created a new repository, copied the special gitignore
file in as .gitignore, copied in the source and build products, ran git
add and git commit, and then ran git clean -dfx to remove proprietary
source code, packaging the result.  A change to the behavior of git
clean -dfx would be devastating here.

I point this out to underscore how fundamental this change is.  People
overwhelmingly do not read the release notes, so expecting people to
realize that a change has been made, especially when many people only
upgrade Git because of a security issue, may result in unexpected
consequences.  Just because we don't think of this use of Git as normal
or desirable doesn't mean people don't do it and don't expect it to
keep working.  People do read and rely on our documentation.

I think any change we make here has to be opt-in, at least until Git
3.0.  A config knob would probably be the right way to go.  I realize
that may not provide all the benefits we want out of the box, but it
lets people turn the option on once and forget about it.  It also lets
people who don't desire this new behavior explicitly turn it off.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--FT/vNgDLxVq4t/AU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.11 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlv97aYACgkQv1NdgR9S
9ouJRxAAgTlnzFx+mh5MD6hapdUpqY0u6O/jhxopjEuqk8eZnmBSNpFRZIrl1xUs
zs08HhlBxpF1xsth3P2eyI/H8bmvUQiAvczq+9S3zMsEDCHrbCJKDB2ItxayiMu9
f1eik8U9b4WGyxgymGd9vNr4l8IUzyIMW1Fj4IS6cj6JppbkY92ArlxZFcblFpFv
FsJxsASySgQikCri58HD2xD43+CkD99lqaNUu7PrGbnRWOai9Ss975QkN0nmutIU
x8uRchalJ4O73bv79CtQVmbfjKeN1Otds3H9n343mSuBx1FsdLdNp1LM2opApj1E
P+bJLsYj0T4fOv0+i46bxcmLVsBnaaxRkdSUJZxTqapRXlGlwgtilmepI7sPVH/3
vbSFlXaS/SyeZWGVwc3VR1C88aZAIXSeBNoKIeJI2MFeT+fbnvyoG3SmZRmg2XQ0
FSEmyUNwesoZxjkxhjTIl1cERUzt/URUMohQTZBtY31dMiIwuD//V1wLh2eSgVMK
J2M+Dt06Pb1yJHdLR/NNIKpxvoaehb9Sy3Yaet4WNEu45r4X3rpT16h1X7Ylp+Kd
rPCtYSIeZyFoCbdGGfo9L+ypz2liD8C+32eIueyGLt2o6cZAzMJU2GNtUh/GhbWd
vunpeOvK/EGp2ZCkTC8itSrlmAe4f2K2V/huBVAKlHG648Zl0UI=
=3iUS
-----END PGP SIGNATURE-----

--FT/vNgDLxVq4t/AU--
