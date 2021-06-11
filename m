Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1821DC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 19:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED94F613D0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 19:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhFKTFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 15:05:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47740 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231617AbhFKTFa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Jun 2021 15:05:30 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 445E560400;
        Fri, 11 Jun 2021 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1623438211;
        bh=0vk9qjXcbPLtwzMviTBoAMhkwGH7I3lXNWH5+d7BonA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cOsBUVMW1Rb7Q27ndJzH9ttOdBHcqZP1WdB62wxNIfACAgjBUX5p28xC/p/GKXeC/
         6s2rpQMDOZXXkB4tONmhDDZ54HuYrew2LVtaPR/f6YJDZtbuFNpOyaew3/aocZ2MO5
         SMmq6OeQ9XsDQyY1AB6SvUykJxBMvaFt7ICck3DiFDtKZCALqD/fM3vFC+lexSd/NX
         mRmW77c8+QpN9EvdWkaSB8wdxz0pNmBCCJNakY4ix2uj+gT0e2lMGbIDBEAzvsPpfB
         1jZKBp0sIIi9ywts2iwPOdo1KcNepPRJSz9ZaeRx5gCzsIRvUjxuIwJp+MKrTm1sOl
         wBurr0LWNWApJXcAPnxPG0aBNg3MUBFx9zrCqxJt+c6R+WyUXVBSs1upY0E2p6ulLv
         r6X44W3S/VhJSIDnm5Zlp1vpwcFUVOlnK1fjp5SwhRfSC2AHEEVH8NFVToM8Lu+04g
         2CH9dul8QFawFPF7AtZEo1191hOlKsL11z9I1MD7AVJYbQ3J3Vx
Date:   Fri, 11 Jun 2021 19:03:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Axel Obermeier <axel.obermeier@gmx.com>
Cc:     git@vger.kernel.org
Subject: Re: Optionally include submodules in git archive - status?
Message-ID: <YMOzf2I+SRfHcMdd@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Axel Obermeier <axel.obermeier@gmx.com>, git@vger.kernel.org
References: <trinity-ccbae402-c6b8-4280-abe0-7fecf75af9f3-1623396089396@3c-app-gmx-bap17>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZLiEGofsoCIp2J2T"
Content-Disposition: inline
In-Reply-To: <trinity-ccbae402-c6b8-4280-abe0-7fecf75af9f3-1623396089396@3c-app-gmx-bap17>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZLiEGofsoCIp2J2T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-11 at 07:21:29, Axel Obermeier wrote:
> Dear git developers & community,
>=20
> I'm trying to find out the status of including submodules in git archive
> - I'm sure this has come up before, because it creates lots of pain,
> especially in packaging [0].

Nobody has implemented it yet.  It could theoretically be implemented
for submodules where the submodule is already downloaded and populated
on disk, but if the submodule isn't populated, then the data won't exist
and it wouldn't be possible to put it in the archive.

So it can be done, but it's a bit tricky.

> Github in particular punts on including submodules in the automatically
> generated tarballs (which are therefore often broken, i.e. not including
> all necessary parts to build), and this is in part because the underlying
> git archive command does not provide that option.

It is unlikely that GitHub will implement this anytime soon.  GitHub
essentially invokes git archive to generate its archives, and even when
git archive supports that, the submodules will usually live on a
different set of file servers than the main repository, so the data will
likely not be accessible.

For Git LFS, we issue our own source tarballs for different reasons (the
fact that git archive is not guaranteed to produce stable archives and
we want to provide signed hashes), so at least for now, the solution
would be to provide your own tarballs if you need something special.

> I could not find a bug tracker for git (though I noted with interest
> from [1] that the git-scm website has one...), and could not easily find
> something on the ML [2].

The list is the place to report bugs and request new features, so you're
in the right place.

> It's creating enough friction for me that I feel tempted to implement it
> (e.g. with a switch to recurse one or all levels of submodules), even
> though I don't know the git codebase at all. In any case, before rushing
> ahead, I wanted to check first what the status of this topic is.

We would love to see a patch.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--ZLiEGofsoCIp2J2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYMOzfwAKCRB8DEliiIei
gRh7AQC9dr3+ahXH01HYHlKGyO+jC8oCg16qSXZEtgbcaAMnzwEAp1YOIwshKZRa
Z9uwjnAAgcEv3PDIS3MGspq1k1vj2QQ=
=Kin1
-----END PGP SIGNATURE-----

--ZLiEGofsoCIp2J2T--
