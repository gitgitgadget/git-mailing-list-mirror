Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6BDC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 22:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A7061073
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 22:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhDPWC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:02:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34758 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234898AbhDPWC4 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Apr 2021 18:02:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7A1D860744;
        Fri, 16 Apr 2021 22:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618610519;
        bh=lis+wzkdKqnZOeKLkXEh21qsp0o3pyYpuMXSGTR/xOc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=b/sl/OSr6pisYNEvUv298NgEANgVefn7xuMAvuisq8Zw5SEnAiRn+qqP7a0oRcElA
         ydkwG5S0H6dHsdzKYPqfl1UQfVvXZtHXJC8Aye+/yx3BefRlPTk6cAowCF6D5EtNgL
         hPhsgLJG37pI1tppF7iDogsLi4BEXiuAh7+8yrfLEXe188uadejk85JtjqEcUDZhzV
         M19YsXAuTJBmYj7xQ7165vEukjVxuzoxXcUqmSAkVQA2vf0Iu7bLdAXsOyYIbKoSES
         twcJvP5UeERWlMUQFIn/b/kwH0G7mXaI1ysJdMJuabWMnPyGdqqULGFx8BpOro/yJI
         ZoGGrat8BO0J+UJ8erZdsY4rarB/eIo86BYViEmDuGn667ehFF8hErrnj3XgxVt+D7
         S7SoyV9I8ohJyqY25l9kkYA4GMhV0Xay7ZmJtJM6l9LSP7Wt8+PlvF9z027bH4pcu0
         88NThuX3RgkuTQ+uD0jbkvcB8PAIolKjLPpYal7fP8MY1J5b1TA
Date:   Fri, 16 Apr 2021 22:01:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bruno Albuquerque <bga@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] object-info: support for retrieving object info
Message-ID: <YHoJUrqeT26Nihua@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bruno Albuquerque <bga@google.com>, git@vger.kernel.org
References: <20210415212017.1407303-1-bga@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jcLq6Km8ofPBIDk4"
Content-Disposition: inline
In-Reply-To: <20210415212017.1407303-1-bga@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jcLq6Km8ofPBIDk4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-15 at 21:20:17, Bruno Albuquerque wrote:
> Sometimes it is useful to get information of an object without having to
> download it completely.
>=20
> Add the "object-info" capability that lets the client ask for
> object-related information with their full hexadecimal object names.
>=20
> Only sizes are returned for now.
>=20
> Signed-off-by: Bruno Albuquerque <bga@google.com>
> ---
>  Documentation/technical/protocol-v2.txt |  31 +++++++
>  Makefile                                |   1 +
>  protocol-caps.c                         | 115 ++++++++++++++++++++++++
>  protocol-caps.h                         |  10 +++
>  serve.c                                 |   2 +
>  t/t5701-git-serve.sh                    |  26 ++++++
>  6 files changed, 185 insertions(+)
>  create mode 100644 protocol-caps.c
>  create mode 100644 protocol-caps.h
>=20
> Hello.
>=20
> This is my first git patch so I thought I would introduce myself. I am a
> software engineer at Google and I have been involved with opensource for
> a while (mostly with the Haiku OS project) and now I am working on some
> Git changes that hopefully will be generally usefull.
>=20
> For this specific change, a clear usage scenario is implementing a VFS
> on top of Git (something like https://github.com/microsoft/VFSForGit) in
> a way that would not require someone to always fully download objects to
> get information about them. Object size is the obvious one and what is
> implemented here.

I want to point out a few notes as someone who's worked on projects
appurtenant to VFS for Git.  If your goal is to create a VFS, then
learning what Git thinks the object size is is not helpful.

Git performs all sorts of operations on files when checking them out,
such as smudge and clean filters (e.g., Git LFS), line ending
conversion, and working tree encodings (e.g., to and from UTF-16 on
Windows).  Thus, your VFS must necessarily exclude all of this
functionality to use Git's concept of an object size as a VFS parameter.

For the average project, the worst functionality to lose is actually
line ending conversion, since that means people will practically check
in a mix of line endings unless you are very strict in CI.  VFS for Git
was originally designed to address the needs of a project that was not
cross-platform and thus this was not a problem, but these limitations
are substantial and I wouldn't recommend repeating them.

So I'm not opposed to seeing this functionality come in if you have
other plans for it (which is fine and I'm certainly interested in
hearing about them if you do), but I don't think this is helpful for VFS
scenarios and shouldn't be used for that purpose.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--jcLq6Km8ofPBIDk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHoJUgAKCRB8DEliiIei
gSFWAQCg0y5G7NOLFBGe5Zac+woP7SPHIMfbaOR2lnwkR02K4wD9GoKxhSrndW9z
3QxjN/7Skn20q633fxFQKn32jXqVNwE=
=v5LK
-----END PGP SIGNATURE-----

--jcLq6Km8ofPBIDk4--
