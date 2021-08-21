Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2ECC4320A
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 21:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5536125F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 21:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhHUVvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 17:51:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47902 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230178AbhHUVvD (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Aug 2021 17:51:03 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ADEB160749;
        Sat, 21 Aug 2021 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1629582622;
        bh=1zojWall1rUOInTQwIIR27ms2wXQJD78bFDz9cWtY0w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sPfV8eKkxUMA3N5xUJm6uwB1qre5jRrwMsSTlglCWau7zJJ88Sj9uQxp5O8Gg/qJB
         AFcuDDMJP/XYeRlxvIWhRJzfPwzc2XDkvupy/rChwTG/UvsrTs4SumtmFs7XHmqGbl
         p3yiKs4gi+yYfDon/LlOhTD+pKaK/ifnY1p8AR2MjfiZaIAZV4Oa7A2hM/VEIRnXWb
         tWas9guBCLy3q9yNFLns9iq+JY06tRKvrmtZBJrni0+de5ujOjLmY850fyLBIz7SDp
         Mezxg9UcTCcdOd3pQzG51CXGxlwRbgOywYLcsqRv3D92Iyl/nQIKWa5tpundUOhkKo
         naa1tubUmToL9stjyEenKMtkanpP/hDLeSe+USvRqIxgB8oFG0hv7amyPpkgQF6khl
         /mWNyKL7qVO/pYs+pmZYuqhZZhTmLl/wmgdARKhzr7SWkrXQ7y+gjOqNL19rJFZxTU
         1Lx7L3lv/n+PBUuVt6Ti8HUTMbIgv8sWhJoUd4X4L8Qf6LP48mp
Date:   Sat, 21 Aug 2021 21:50:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Rafael Santiago via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Rafael Santiago <voidbrainvoid@tutanota.com>
Subject: Re: [PATCH] Give support for hooks based on platform
Message-ID: <YSF1GfpHXRrXebsB@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rafael Santiago via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rafael Santiago <voidbrainvoid@tutanota.com>
References: <pull.1069.git.git.1629576007891.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mSbqCZqt8HM1OZDv"
Content-Disposition: inline
In-Reply-To: <pull.1069.git.git.1629576007891.gitgitgadget@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mSbqCZqt8HM1OZDv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-21 at 20:00:07, Rafael Santiago via GitGitGadget wrote:
> From: rafael-santiago <voidbrainvoid@tutanota.com>
>=20
> The idea behind this commit can be useful for teams
> that share git-hooks into a custom directory and
> dealing with projects that must be developed,
> built, maintained on several different platforms.
>=20
> This commit allows the execution of git hooks
> based on the current operating system.
> A "native hook" is defined in the form:
>     hooks/hook-name_platform
> Where platform must be equivalent to the
> content returned in sysname field in utsname
> struct when calling uname() [but all normalized
> in lowercase].
>
> On Windows, independent of version, flavor, SP,
> whatever it is simply "windows".

I'm not sure that this is going to work out very well.  The MINGW
environment used by Git for Windows and Cygwin are quite different.  I
would fully expect to write shell scripts and Unix tooling in Cygwin,
whereas users using Git for Windows might not want that at all.  That
also doesn't take into effect using Git for Windows in WSL, which
introduces some interesting logistical challenges.

In addition, I have a few concerns about the grouping of Linux
altogether.  While in many cases it is possible to write tooling that
works natively across Linux distros, most binaries will not.  Therefore,
binary hooks that might run fine on Debian would fail on a Fedora or Red
Hat system, especially if those binaries link to any of a number of
different shared libraries (e.g., OpenSSL).

There's also work to move hooks into the config and out of the hooks
directory, and I don't think this will mesh well with it.

> The main motivation of this extension is to
> reduce dependency of scripting languages,
> logical trinkets etc just to execute minor
> tasks during scm events that could be done
> natively but differently from a platform
> to another. Less dependencies, cleaner
> repos: a small step for a better world
> for any software developer.

Is there a reason that the proper hooks couldn't be copied or symlinked
into place with a script?  I think that would resolve this concern with
a lot less work.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--mSbqCZqt8HM1OZDv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYSF1GAAKCRB8DEliiIei
gQReAP4/kvvrpzTtAezpmHmjNVC4JM6I/AFXEcpLBg5y8bExtwEA1g526Pw3YLLg
Yg1AP2JUiSxagfbnUynmNaiSUMVTcQo=
=LArw
-----END PGP SIGNATURE-----

--mSbqCZqt8HM1OZDv--
