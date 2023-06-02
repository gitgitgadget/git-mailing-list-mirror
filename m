Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B7CC77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 00:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjFBAfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 20:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjFBAfl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 20:35:41 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF4019F
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 17:35:39 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 08B825A1A8;
        Fri,  2 Jun 2023 00:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1685666138;
        bh=HOV0weHpTkdqiFwwSnYMIObnanOzYNSz1U4C91u2yX8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Lj90A7zV9/bUqBWeOkqj97+e7s7QBO+MeWQES5yiu1uQ/RQNbR34wRtb1AKzyZ8VK
         mYNx0zAZO0GP20cblRRKxI4es/XN2QxxwkSE5jRgYsSk6G26KBiSMziOugTpp1xpka
         lpUvJBEdHzYtCfzj22YjfWJLFM1J9R1XWZQ6t8Sj1f9CYNDJ3bNaBwA1FMih9F/NvY
         DcHX5ITBBvbRbjLk8uFlitUTkcvgCebPyygLGvtWeMTynhn8CRaq+D1xzriRMnE/oH
         7kIkbBNOlgP1igK6MgchTnP6Hs0oCF/O1cXSBfv3C0/fHvaAlIjcQQ13eG2nARcPSb
         XCRtBLH/5/ucYuX65POyzqMlycs2glBU+NXadz0Nx+q/ilar8VtOIy86dhtEHZjbr4
         tDxSti0F0imrsy772xWWGrQQOKXM0/PaPqxD0HHffG4EiChyy3rnKNkW3h/pc9mAxA
         prsK10ewq+alCc2pQp6YH54z/s9/hr6XCsZRw5sfPJXYTikMr2/
Date:   Fri, 2 Jun 2023 00:35:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Priedhorsky, Reid" <reidpr@lanl.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug? subprocesses can use wrong Git if $PATH is unset
Message-ID: <ZHk5V6U9gfkuwErH@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Priedhorsky, Reid" <reidpr@lanl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <E7D87B07-C416-4A58-8726-CCDA0907AC66@lanl.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0xwK1SMtrsrL/ooL"
Content-Disposition: inline
In-Reply-To: <E7D87B07-C416-4A58-8726-CCDA0907AC66@lanl.gov>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0xwK1SMtrsrL/ooL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-01 at 22:21:05, Priedhorsky, Reid wrote:
> Hello,
>=20
> I may have found a bug in Git. It seems that if (1) multiple git(1) are i=
nstalled on the system, (2) one is in the shell=E2=80=99s default path (i.e=
=2E, used if $PATH is unset, not the default value of $PATH), and (3) the d=
esired git(1) is at a different path, then subprocesses of the desired git(=
1) invoke the undesired git(1) instead.
>=20
> $PATH unset is indeed a pathological situation; one of our own bugs in ou=
r software that calls git(1) inappropriately cleared it. However, in my vie=
w it=E2=80=99s surprising enough to be a usability bug. I would expect git(=
1) to call itself for subprocesses regardless of the environment.

I don't believe this is a bug in Git, but rather a behaviour of your
operating system kernel.  If you don't set PATH, then when Git does an
exec, the kernel or libc supplies a default PATH value.  Traditionally
this includes /bin and /usr/bin, and on some systems, it used to contain
the current working directory, which has typically been removed for
security.

It isn't possibly to portably determine that path that was used to exec
the current binary, so Git doesn't try to do so, and it assumes that you
set PATH appropriately.  In fact, on some systems, you can use fexecve
to execute file descriptors pointing to files that have been unlinked,
so in general, it's not possible to determine which binary to use
without the PATH.

I'm not aware of any other major programs which do this in a better or
more useful way, so I don't think there's anything to change here in
Git.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--0xwK1SMtrsrL/ooL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZHk5VwAKCRB8DEliiIei
gZSoAQDEVFP2Vag8XVmkCx6mvKwKI6MeN3elVLs/W9chvSeYugD/RFYtfNbWpvzT
u5ynoPwxTvxbMuSR4Z0fL+GrTz+HYg4=
=/+FU
-----END PGP SIGNATURE-----

--0xwK1SMtrsrL/ooL--
