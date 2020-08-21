Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925CBC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 22:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671AD2067C
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 22:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zdb8lwMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHUWwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:52:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44966 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbgHUWwo (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Aug 2020 18:52:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 59C8D60457;
        Fri, 21 Aug 2020 22:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1598050363;
        bh=jd7+g+hmcqWRXpteCnZb1E6rdoKIN0ZWElyadYaZJb8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zdb8lwMp+1Ix3oXX2gYOD63vUpDZOnalF3gWMDGYXs8fg3CjBjy/jcsSj/pu34WDu
         ChAendKgr5a1EsKY+swL3DAEj+ySnBTqTfkpKdoyA2DiVAXtg4MxIP3zl4iAhjXvME
         lu5Ab9olNbRZZULzL7AFR7D/7gy5lcH3Oa+eGV9crWM0zq+osSVjcrqDg+J+kW84K0
         kZnCF7owIJEW+NseuvYXfnVDyr5u0Vzm9Haw1Tpju4wWsadSr675vQbh/eL9K5CVZu
         V6LoMHvt6ar16ApIDhlHvgVu3GuB2BKd6ulMKaLvYxW8vb2nePbdSFGo8OVBlW3kHq
         1h7ikn8kxlzlnekZ+IJ/QCPSvxNU8m+nrrR7+DYyAIfWaQHEozu0LBhuFNORKM2v1g
         phctWTR+4rmjN9I4SE5WJNet1xgyNDmOlyk0SZFaZGDDFdc7w4l5CyYvhpN+MsXI1U
         sVIAf/+CYYEjnR2qB7I+vCGHFuacayUyLxSp3sKvOLMjumCfw1o
Date:   Fri, 21 Aug 2020 22:52:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200821225237.GW8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lukas Straub <lukasstraub2@web.de>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
References: <cover.1597853634.git.lukasstraub2@web.de>
 <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
 <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
 <xmqqimdetpuw.fsf@gitster.c.googlers.com>
 <20200819201736.GA2511157@coredump.intra.peff.net>
 <xmqqa6yqtm03.fsf@gitster.c.googlers.com>
 <20200819203825.GA2511902@coredump.intra.peff.net>
 <20200820133445.2bd162a3@luklap>
 <20200820130125.GB2522289@coredump.intra.peff.net>
 <20200821143941.28f71287@luklap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i/VKSWANvDZSIhsB"
Content-Disposition: inline
In-Reply-To: <20200821143941.28f71287@luklap>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--i/VKSWANvDZSIhsB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-21 at 12:39:41, Lukas Straub wrote:
> The downsides we discussed don't apply in this usecase. These are mostly
> personal files, so I wont upload them to any hosting site (not even priva=
te
> ones). There is no security impact as I only sync with trusted devices.

I realize this works for you, but in general Git's security model does
not permit untrusted configuration files or hooks.  Configuration can
have numerous different commands that Git may execute and it is not, in
general, safe to share across users.  This is why Git does not provide a
way to sync whole repositories, only the objects within them.

Adding the ability to transport configuration through a repository is a
security problem because it allows an attacker to potentially execute
arbitrary code on the user's machine, and I can tell you that many, many
people do clone untrusted repositories.  Just because you are aware of
the risks, are comfortable with them, and are the only user in this
scenario does not mean that this feature is a prudent one to add to Git.
It violates our own security model, and as such, isn't a feature we're
going to want to add.

I want to be clear that it is not that we don't see your use case as
valuable or important, only that we can't see a way to implement it
securely as proposed.  Warning users unfortunately isn't sufficient
because users tend not to read documentation.

Multiple core contributors representing various aspects of the Git
community have weighed in, and it looks like the answer is unanimous.

Sorry for the bad news.
--=20
brian m. carlson: Houston, Texas, US

--i/VKSWANvDZSIhsB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX0BQNAAKCRB8DEliiIei
gRaVAP0QykhU80tZXUSEcI06HH7W9FLydm1fOg8JevX7y6AwOwD+K8YQt1seApWQ
hgPaDWzKDCpsyt+k5cATmHaflGq4xQc=
=BHU4
-----END PGP SIGNATURE-----

--i/VKSWANvDZSIhsB--
