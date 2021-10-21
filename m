Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13784C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 01:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E703861052
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 01:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhJUBDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 21:03:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37848 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJUBDv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Oct 2021 21:03:51 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5980860734;
        Thu, 21 Oct 2021 01:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634778065;
        bh=zdqj+Os7URL9DQIH2RFKmzcZzH1U/c4j0L+GD3jiybc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=p2DV2JBz3hp/NK88YtzNzdLxGlfar6lyujuZnCqlRCeofGful0NiVEHLX3mPCWGx6
         UgQd/35B+wbGn9sbfcqm+fWW6vJWWJraMZUY6CoO90DUSkYwMTnYR59p90qsbE6jNo
         fzseTA46lp0i7lOMIzIRTHjsHpdWNduBB0KFJJI0mUPjBZp/HCU7cdcYTOTZxzXf+1
         xKtIuPC3fwElJIY36/s07salW7P9XzKJJ6u9++OPQJYcm+uQT52tDPD39TPYZvODEJ
         a8kGUv8YYgfnO/dx2DwCiaoUEiJqr89JubOv8/g+y22xOD2KUUaew2F2d8I7DPwQQQ
         MhMDQt0Ijka/gwwNSpCZYlztD7TBSNyy9GW1DiStsmIH3JXtpsOADt6C5v42q4I8SS
         94e/QyBTmmR8NaDoaKvICU+OJ0g49f9bMtDZOzCtazBclZ3G48II5ES48jnBlIs2b/
         Mq3GEUhn2qXa6cKgoWpSmqbDTK9fLfzUd2Nj0c60YMj4QcdDb5L
Date:   Thu, 21 Oct 2021 01:00:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     BARDOT =?utf-8?B?SsOpcsO0bWU=?= <bardot.jerome@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Questions, improvements
Message-ID: <YXC7vfnnEQClQu4N@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        BARDOT =?utf-8?B?SsOpcsO0bWU=?= <bardot.jerome@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <9ad3d241-5441-9fbd-76a4-7c47c6a1b70e@gmail.com>
 <YW85Gs8aU9rrBDOv@coredump.intra.peff.net>
 <9eafffc8-8576-f1ea-45a3-ae4c337db7f1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M894/FfoZPTFg68R"
Content-Disposition: inline
In-Reply-To: <9eafffc8-8576-f1ea-45a3-ae4c337db7f1@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--M894/FfoZPTFg68R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-20 at 12:25:32, BARDOT J=C3=A9r=C3=B4me wrote:
>=20
> On 19/10/2021 23:31, Jeff King wrote:
> > I think you may have a hard time getting people to agree on what should
> > go into those rules. ;)
>=20
> Yes but for certain things i think we will are most of us agree. (In
> professional context)
>=20
> Temp files for Operating System, file system, text editor and IDE.

Unfortunately, there are a lot of different patterns here.  Some IDEs
use entire directories, and sometimes those patterns conflict with
common patterns used elsewhere.

For example, GitHub's recommended Visual Studio .gitignore[0] recommends
excluding directories "Bin" and "bin".  However, it is extremely common
for folks to have a "bin" directory in their dotfiles (I do, at least),
and that would cause problems.

It is generally recommended that projects try to remain reasonably
editor independent so that people can use whichever editor they prefer.
As a result, many projects don't include any editor-specific .gitignore
patterns, and rely on each individual user using their
`core.excludesfile` settings to ignore their own editor's and operating
system's files (e.g., Vim swap files).  Only editor-agnostic files, such
as .editorconfig files or files to run linting or formatting tools, are
included.

Also, when you try to pick common patterns, you end up with having to
decide what "common" means.  Should we support every editor's temporary
files, no matter how infrequently used?  Should we only support the top
N editors?  How do we decide which editors we should support?  How do we
decide which OSes we should support?  Should all patterns be case
insensitive to support the most OSes, or case sensitive to prevent false
positives?  How do we limit the rules to avoid bad performance from
giant lists of rules?  How do we resolve conflicts between these rules?

As you can see, it becomes quite sticky pretty quickly, and we're
basically bound to make somebody unhappy.  Letting each project decide
the appropriate rules for them may not please everybody, but it at least
displeases far fewer people, and it lets the people most competent to
decide those rules (the project leaders) make the decision.

[0] https://github.com/github/gitignore/blob/master/VisualStudio.gitignore
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--M894/FfoZPTFg68R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXC7vAAKCRB8DEliiIei
gRQHAP9HLFt3POh6YtO8ZAh/AcDPcqbMVtM3D6mBFcnw2Ta7cAD/bOUShX7dFz2K
4eh0gZB0DRJlb350lyUTBW/y6ux7hAA=
=IdfK
-----END PGP SIGNATURE-----

--M894/FfoZPTFg68R--
