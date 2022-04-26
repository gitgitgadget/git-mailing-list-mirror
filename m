Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E9BC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 21:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355439AbiDZVb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 17:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355437AbiDZVbz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 17:31:55 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4CB9AE41
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 14:28:46 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 545965A421;
        Tue, 26 Apr 2022 21:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1651008525;
        bh=z3BefkF9n8Bh6yHkstXiA0Ye4GBrRYoXEb+RwTUpKKc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=D3pV/YAPhd5jYBxrtDpezKJMsU8AG4XoA+a4vc56+hOfvo1SQ04py1fh4Gocux0Ui
         /l/8HGOtmWElzw8LpIdn7Ug/hYDrEvvYkoaXgkLdQMD3LHn51nsCVPKOVx/S4kxh/q
         O4r5rrVa4PXs+jfToxQAM8S0YAC7UUZHsFC9aTPhYUhtYepzY+HTzbVU0zHnXUbmcR
         zqWDAODjpjyxXQrVkSZvzzjJSelSoKO1+OQMmZIjAKpZUK21OqXOsXEMyidvMoT6PH
         /o0z1t5XhEVMfvNDBtaiMu5qM/B/f0nFUfPkdpebwypJ9XH5Wa5B12A5qS8FzBUYcp
         SD2dsEeJlYz8YfqqlZ5wWMvCSlptA7usFkhvIJplCFEl8S6W4fbmBX5iGnxWSBMxg8
         bOQYMLwf+InEk0/fKgAeYHDJfMef7yp4qeFNeOzZKk1+pg0E9mMk3pRIz1p68U93rL
         BoxXUP7I91CwoHq37vGDYDFPQuOzRtVuMn5JZ/9ctjYgCaRhm3L
Date:   Tue, 26 Apr 2022 21:28:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Drew Green via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Drew Green <agreenbhm@gmail.com>
Subject: Re: [PATCH v2] Added Curl Option to Override Request Method v2
Message-ID: <YmhkCAbmNE8A7Wqy@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew Green via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Drew Green <agreenbhm@gmail.com>
References: <pull.1225.git.1650970894143.gitgitgadget@gmail.com>
 <pull.1225.v2.git.1650988659280.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zslQjjf4yFchsATJ"
Content-Disposition: inline
In-Reply-To: <pull.1225.v2.git.1650988659280.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zslQjjf4yFchsATJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-26 at 15:57:39, Drew Green via GitGitGadget wrote:
> From: agreenbhm <agreenbhm@gmail.com>
>=20
> Added support for environment variable "CURLOPT_CUSTOMREQUEST"
> and config option "http.customrequest" to allow setting the Curl
> option to override the default request method used by HTTP Git
> operations.  Primary reason for this is to allow support for
> cloning repositories where only GET requests
> are allowed by a local web proxy but not POSTs.  When cloning
> a repo first a GET is made to the server and then a
> POST is made to the "git-upload-pack" endpoint.  In some
> corporate environments with strong controls
> only GET requests are allowed to known repository hosts (such
> as GitHub) through a web proxy to prevent data leakage.  Using this
> new setting, a user can set the "CURLOPT_CUSTOMREQUEST=3DGET" env at runt=
ime
> or "http.customrequest =3D GET" in their config file which will
> change the second request from a POST to a GET, bypassing
> web proxy restrictions on the type of requests allowed.
> Tested with GitHub, changing the request from POST to GET still
> results in the expected behavior of the repo successfully being cloned.

I don't think this is a good idea.  It may happen that GitHub or other
servers happen to accept a GET request here, but that is a bug and
should be fixed.  It is definitely not something we should depend on or
rely on, and it isn't a documented part of the protocol.

If your corporate environment doesn't allow POST requests, you may wish
to use SSH for Git operations instead, or you may need to explain to
your company why you cannot do your job with their proxy in place.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--zslQjjf4yFchsATJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYmhkCAAKCRB8DEliiIei
gdpRAQCVM3W/bt2qpBkPCSxqPA26DywkvaaANvq2dwC3R/bI4QD/c+rui9aAVAvF
OOhu6EwrRDgA8EM26reXPqQS4UIxzwY=
=nEuA
-----END PGP SIGNATURE-----

--zslQjjf4yFchsATJ--
