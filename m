Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7826EC2D0A3
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 01:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2D420825
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 01:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgKGBXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 20:23:54 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36024 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726447AbgKGBXx (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Nov 2020 20:23:53 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8FCF960427;
        Sat,  7 Nov 2020 01:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1604712232;
        bh=Ma1YNBbGcqWLryxCVmUeTUQ6D7nG8b1j4mVcIaxDVNQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1Wm5oxZ2HiQ7tQsBwlIqdTxQnVc0A6j2b1U9R3Xe2yZ2ADCKdJvvlDtduN9QXPO65
         eRwZ1VGJGIIhbJ6ov01wAka6ag99/wnmcrGWDPY0toKVg6Q6glC8uAsQ6plAjjTbe9
         dD6xD8reWfutDWIDdYPPkTTxyYadnEJCB8tNXqXvUTDdLxPfFIW2AeS+xoaAbL8pQ6
         bzxVLu4sTGp7Wv9K9934OwtvsyCxCy4skt4L8iRUHxtxUvVwO1wZrJ/1Bbv/ZK+NhA
         gwhJJidvyBjzK3wVuCQ6mJoAIva3gom8aNKbAHGNYecLXo5dTo2C72LUc0hoIvr2En
         J6nXrmQANayy4b05b64HkrYy0eOmDXTB07LFdiZwaBzHJriFjArZNsL3B/bMH4RnGA
         Ur2gbvhPn9PG56fae9Tw82y8LUummX8/6xwZ87xhuGOyIWw57CnHVl/7a9zPWW+1i4
         Lt9mw0NJcQ79g/EzKpdM73YFnVo7UKXVCyc2JiC4JfhNVWUKfTn
Date:   Sat, 7 Nov 2020 01:23:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] tests: consolidate the `file_size` function into
 `test-lib-functions.sh`
Message-ID: <20201107012345.GD6252@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.780.git.1604711577662.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline
In-Reply-To: <pull.780.git.1604711577662.gitgitgadget@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-07 at 01:12:57, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> In 8de7eeb54b6 (compression: unify pack.compression configuration
> parsing, 2016-11-15), we introduced identical copies of the `file_size`
> helper into three test scripts, with the plan to eventually consolidate
> them into a single copy.
>=20
> Let's do that, and adjust the function name to adhere to the `test_*`
> naming convention.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

This seems reasonable.  For a moment, I was going to ask why we didn't
just use test -s, but then I remembered that test -s doesn't have that
behavior, Perl's -s does, and you replaced that with the helper for
efficiency on Windows.

I looked at the patch and it seemed pretty straightforward.

>     tests: consolidate the file_size function into test-lib-functions.sh
>=20
>     My ulterior motive with this patch is not even to address that old
>     concern, but to avoid having to exclude the code comments from the
>     upcoming master -> main rename (because those code comments talk about
>     git/git's main branch, which is called master).

Also a good reason.  Why modify code when you can just delete it?
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX6X3IAAKCRB8DEliiIei
gaTIAP4zu61TBfv4x4i9hFh4jUYTT2ESUTMRDalGx4YQoz9m2QD/c5iKObPS+YXT
e6I8K7d1jr4yCv2BK7aNHleCZr2QaQ4=
=BlVc
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
