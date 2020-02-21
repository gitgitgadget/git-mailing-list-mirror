Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C507C11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA1D20659
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xO46LC+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgBUBpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:45:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37660 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729045AbgBUBpl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Feb 2020 20:45:41 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D675660478;
        Fri, 21 Feb 2020 01:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582249540;
        bh=OtbH6sKlaLDzPyTz1SGmvWRNPXmU2k2vGQ36hsuyBnY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xO46LC+Ep+CShsiGpgxEFiskHedo2FUpg5NHO6j7urNseTRg4y0QsvLK2tmnN6T6D
         V0eSazivt/rRyri1uiUjSKBVL6cCwEUcy9alUdqH05CnLE2JmULPjAVTvDDijcJxHw
         jT0aOY3PwKTdprKmr+erpQhq3y51LkS/o9HeU5Lzs2MhBpAJ/DT9ugO0sM9MoB07or
         ewF83sOlsWJ0BiAVWXIUy4YnWGhmjFa5dOKAw+KHha0AmZQrex+9gMOQcndYSExgtx
         S1iXlxCwfGbIZIjowAu41BO0MZS5hcZ+Vcx9cC3AEgNYa6IMZLi/4J/CLYpXsKyjdq
         rbHNh2FKJVJoZ/a6/hIX7hpJiYoayCVmfbYsk76/y3/tTczqxKp3ml/Q3U9to9KKcD
         MggGOT8IREAAIxho8Km2Pil12wSTODPArz3gScOe5P9WHcTorABwF7inv6UOVmoCHk
         2ZmefC4X42gKaiH/3k1UVkWaqL3ui39pcxg6ZWfGAwb+yIJ/r9n
Date:   Fri, 21 Feb 2020 01:45:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Adam Milazzo <Adam.Milazzo@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG: git clean -d cannot remove files from read-only directories
Message-ID: <20200221014535.GC6462@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Milazzo <Adam.Milazzo@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BL0PR2101MB10898F2F84B06B1A6B23228380130@BL0PR2101MB1089.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <BL0PR2101MB10898F2F84B06B1A6B23228380130@BL0PR2101MB1089.namprd21.prod.outlook.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-20 at 18:27:22, Adam Milazzo wrote:
> Repro steps:
> 1. git init
> 2. mkdir d
> 3. touch d/a
> 4. chmod -w d
> 5. git clean -fd
>=20
> Actual result:
> Git doesn't remove anything, saying "warning: failed to remove d/a".
>=20
> Expected result:
> Git should remove the subdirectory 'd' along with its contents. Note that=
 git can remove a read-only file (touch b; chmod -w b; git clean -f) with n=
o problem.

I don't believe git should depart from rm in this regard.  I believe
that in general, Unix has stood the test of time, and when in doubt, we
should behave as Unix utilities do.

Note that other utilities (such as Perl) which have implemented
different behavior (usually for compatibility with Windows) have found
themselves with security vulnerabilities in that behavior.  That seems
like a prudent reason not to replicate it.

> Why this is important:
> * This has a significant impact in real scenarios: the go language,
>   when using modules, will download referenced modules and place them
>   in read-only directories inside a cache directory, potentially
>   inside the git repository. These cached modules can't be cleaned up
>   by git clean. (Furthermore, git clean then returns a failure status
>   code, which causes our build system to fail. I don't want to ignore
>   the failure code.)

This sounds like the real problem.  Why is Go placing data in cache
directories that are read-only?  Cache directories are explicitly
ephemeral and should be able to be destroyed at any time.  You'll
probably find more luck convincing the Go maintainers that their caches
should be temporary than you will us that git clean should be your
automatic destroyer of data.  Rust, for example, doesn't do this.

You could also just move your cache directories into $TMPDIR/go-cache
and then do "chmod -R u+w $TMPDIR/go-cache/* && rm -fr $TMPDIR/go-cache/*".
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5PNj4ACgkQv1NdgR9S
9ovhFRAAvvJyol9aashxCQCPakWlKrRoTWPRTMlj7oUKEpavnDIRzFWevGHx5XII
bGaUy5cnBC4o/PVziY+FzNBXbGJvbmZLLZydzjH+qVnq7pjS+J7FyjIhUGD94WLz
mLRdZsw8ETYT6p+sy9eqEA8r/QukAz8Sg6088ldf2laxdgkbCaekAOPMwhARjBzf
GDH9e9d92Qa8r2lr5ZhbMK391ulWAJKAPA5eK/2MxddgFyiMzUFVp7xP/r56Fwjb
Ndb12ijzin7zdZeezKsY1J8FpP3mrNhQBK+PBygQ7ylO76sXcP/b97Lv/yjIBhxV
HbmDRYwZs3PN/qXPIDIWs+/6HzMAKVwBkshwQWm7bvkB4xXnyHuHFoN4Z2aS1D/I
hKN/138xcmwKLwS2wxC5SWQ4duJWhW/m6Za1CpUBohvuVIrAxG9T6z9VSmyx7ehG
D4/44xT96LWxMHPxJb2ezd90zdNGcK8yR/ldI0zv+N1E9rjFppWQaH7bDOUqP0L2
cLus5FBNGqt3EW4cutE9N28kid9sRQuccVvbl4ln67eNMLijDeXAJTBQ6dhwBCd9
WZ0NFC6lP++d6PDJ/zXmQQrpBk3V3FbTBdM3ji+XLvHuIvpHiPE8Nmr5kowTGkkt
W5g+EVWYycMMSsys01qnhmFdCwa7GKtFn28IgVaTK4GtFXUivIk=
=HRMW
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
