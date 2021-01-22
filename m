Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA69C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 01:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674A4239D4
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 01:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbhAVBeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 20:34:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58074 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbhAVBep (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Jan 2021 20:34:45 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3921960781;
        Fri, 22 Jan 2021 01:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611279213;
        bh=OrXpcCopPQgwbmmzSLP/0bgZvjSxAa5uh4lN+mwyp3o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=u9rbgxA+zve8Ylsuvaad4tjWh57Fi1eGviypNfnp7gDRpXjctZh4WE3VrcvYpf4Qq
         F4AykYVoBMnHsPUSbIQ5K9rkXnXrC/S9E4F5owDikAmxrlCTlaJxMyg2kLXVUXKjbz
         Em6AbLI66v6WhfK1salcOU3OYoteCcMermY8lae5gJBAeILXcpa7nNUE7E0cJ2r1UR
         T5T6/xrVmYSXUM57e52yBKuyYVqwIXYD2aJGk0v05YxQ75KdMCbRZiNqv7Oe7nPQQh
         Apedf0ixLbyQljalW5xjNM8vII5QFAgsgx/qn6KH1uHSddfNbrzZaasdO+JF/KgcWf
         Xw0fQldVV1/yjhOnttHxK5NZ1ti5v0BuamdX3gFep4CLKOwKTBgF1Xypi5RUEyX7PP
         4FtRuEx7h+63rLdvnn84nkALcW6Ue++BooG3/NwnVb/4o1AK5Q3XEhMQSY4vm9xxOc
         BHijvcRAVDE7ZMLsghGJ+jrLxIYgJ7PiJdTWezqBnhCD/QG69nD
Date:   Fri, 22 Jan 2021 01:33:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mail <mail@dragonsoul.com>
Cc:     git@vger.kernel.org
Subject: Re: Incorrect $HOME value when using runas on Windows
Message-ID: <YAoraIvKWWRj4cLJ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mail <mail@dragonsoul.com>, git@vger.kernel.org
References: <b2b0fd42-14a8-fbb6-8817-4e53efb9e730@dragonsoul.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G9JcM4ST/D9OchH8"
Content-Disposition: inline
In-Reply-To: <b2b0fd42-14a8-fbb6-8817-4e53efb9e730@dragonsoul.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--G9JcM4ST/D9OchH8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-20 at 10:12:57, Mail wrote:
> To reproduce the issue:
> 1. Install git-windows x32 or x64 for all users.
> 2. Install Total Commader or any other file manager that support system
> context menu
> 3. Add user in Windows via msc or settings app and set password. Don't
> forget to disable "User must change password on first login" in case user
> created via msc
> 4. In current user session execute runas.exe /user:NewlyCreatedUser "Path=
 To
> File Manager"
> 5. Right click on empty space in file list and choose Git bash here
> 6. Type `echo $HOME` in bash console and press enter
> 7. The $HOME is `/c/Windows/System32`. Expected `/c/Users/NewlyCreatedUse=
r`
> It seems git for windows uses HOMEPATH that points to system32 in case of
> runas command. Might be using USERPROFILE variable is better.

I'd recommend reporting this to the Git for Windows project[0].  The
setting of $HOME is normally a feature provided automatically by
Unix-like operating systems, and its behavior in the MSYS environment is
controlled by Git for Windows.

[0] https://github.com/git-for-windows/git
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--G9JcM4ST/D9OchH8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYAorZwAKCRB8DEliiIei
ge5bAP4ho2gnOtgWptDos4d9uEwnF2irbgdtW8bfmjsx6JhMDgD/W6NTCDcuMbrE
Scq6neOrmp6kuhtsQKqjO4PhkxC1+go=
=sbmW
-----END PGP SIGNATURE-----

--G9JcM4ST/D9OchH8--
