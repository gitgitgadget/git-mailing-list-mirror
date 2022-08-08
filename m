Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8D3C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 16:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243793AbiHHQsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 12:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243759AbiHHQss (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 12:48:48 -0400
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Aug 2022 09:48:46 PDT
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [IPv6:2a01:4f8:c010:8611::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C027414007
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 09:48:46 -0700 (PDT)
Received: by algol.kleine-koenig.org (Postfix, from userid 1000)
        id E7B9852203E; Mon,  8 Aug 2022 18:39:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kleine-koenig.org;
        s=2022; t=1659976794;
        bh=tS0V5ZoQKcqtrPZnRWwheMmR8KjGIF0x2uFcEAqmNkM=;
        h=Date:From:To:Cc:Subject:From;
        b=VLkiL/jfU9kiuWPEJS1lQZPm/rMmPPkPO1gF/8w9kFOkOVV2AHxVpe4f+PAG45xxh
         rVE+lP9AOgDa+WS/v4Jq550PpsUiqf2sypahgvSngrvWcNEgst0RKpo/dKBs8rpkVk
         mB0Cr5n0UeAl7dDvpSMXhIu7pwfFZxZnj4ezbcUhDD2TzcQZ+fo6SffrLl8b75XJg3
         O3kYdT3O9mGmLUjlSzE9tcqCziZA/7VnuZMJ+fO9EcvhqE68BqzrbiA/uVTaUqcmg8
         hzfyYliZ0+cKGPSrDiY79wNyD57dbG6QCDTAAlfldS8WFnTJ0v3S9NRGPahbgSpgeS
         uCHFndk0WkZsw==
Date:   Mon, 8 Aug 2022 18:39:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     git@vger.kernel.org
Cc:     Jakub Wilk <jwilk@debian.org>
Subject: git add -N vs. git stash
Message-ID: <20220808163954.tnozlrv7nyx63imu@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vse4pel4ul4tf6bd"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vse4pel4ul4tf6bd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

somehow git stash doesn't understand the index after git add -N:

	$ git version
	git version 2.36.1

	$ git init -q

	$ echo foo > foo

	$ git add foo

	$ git commit -a -m .
	[main (root-commit) 0e4b48cb4913] .
	 1 file changed, 1 insertion(+)
	 create mode 100644 foo

	$ echo bar > bar

	$ git add -N bar

	$ git stash push
	error: Entry 'bar' not uptodate. Cannot merge.
	Cannot save the current worktree state

I'd say that's not a feature, is it?

I would have expected the last command to just remove bar from the
index.

Best regards
Uwe

--vse4pel4ul4tf6bd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLxPFcACgkQwfwUeK3K
7Ama0ggAmMegdHz+tQEWGu/DQdm044zHXqC1XH9u22nFhS1zz5TflkIWteFA3tO4
GXGGixGIX5Yj2f7FEDDxtBnGsG58m0Nsx6Q0JAgtLJdw/JvUpUlASsnn9WIhaQ6U
ofb7JwMNEeAd4jrywnuLxfw3N1/24S/IavUSFsWbit/qmf/7BSNIFXL6mxH8SqVU
YYBaJxojGXGd/+x8lq/T0Z/E0cHUlpG5VYfooh1Y3hOi8y+O9nWxyDJq5ezqHoYV
rEH4leVK7RI+CITmVwlA3fMXRy50GjLudt0732U6JDSO/8lR6a60J6ZNEDXfQy2+
G9hQWRVqtKNZ40mji6uh3CIbUUSOYg==
=R2UJ
-----END PGP SIGNATURE-----

--vse4pel4ul4tf6bd--
