Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A9DC433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F37206A5
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qSMkj3qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGJCPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:15:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40350 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgGJCPb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:15:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 27A7E6048A;
        Fri, 10 Jul 2020 02:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594347300;
        bh=rCqELUc5dy3HWHo9U2i0uqzcM65gTOQiHkddy5/gvf4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qSMkj3qukdJPXH/knlfVDU66bGK3uFsy9p9iXZfMpHYPcZUTkM+G/kV0xAo8IQ6Ve
         pQj15lht1hsYilb5Fynz6BUzN/v/dQWPQC9smPfEWwNnEgBVJW4EUwb77ubhO7uII4
         ExShl+eRm8c5rYpznTLozyqdVpMwtQxIReVIl2e+ahy/oKRZLAXEWaYNLL4bAd7E8f
         XDxTnMO+pHOSqJKZf6gubQnD02W2deSN4ZdTPBdN/BBMYKxghyXUb0GKPkfe2ihJgK
         54nqoKS0MV61rVnxnMMqo09szRev28oHcqO3Ncsua+xve+dxg2MuomlqE9P+H5Zez8
         zCxQy8Pmntjg8dCrYTBkVWcfEMXPjP8w/ycQDN/QHySjHs6C/tpQOMnwAj2DoOlKKc
         jwFV8CkgwDFxbRsOHqd6gANrzkYGBrHOyIvUYJGvukwT8NSeFMq1K2wBM5AV0F9w+p
         HBcVvwhSsKu3cQroOglRFWg/sG5OpE4FVsCSZMfWshtCYJF2xG+
Date:   Fri, 10 Jul 2020 02:14:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
Message-ID: <20200710021451.GI9782@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200710014242.1088216-1-emilyshaffer@google.com>
 <20200710014242.1088216-2-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Content-Disposition: inline
In-Reply-To: <20200710014242.1088216-2-emilyshaffer@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-10 at 01:42:41, Emily Shaffer wrote:
> Before now, the progress API is used by conditionally calling
> start_progress() or a similar call, and then unconditionally calling
> display_progress() and stop_progress(), both of which are tolerant of
> NULL or uninitialized inputs. However, in
> 98a136474082cdc7228d7e0e45672c5274fab701 (trace: log progress time and
> throughput), the progress library learned to log traces during expensive
> operations. In cases where progress should not be displayed to the user
> - such as when Git is called by a script - no traces will be logged,
> because the progress object is never created.
>=20
> Instead, to allow us to collect traces from scripted Git commands, teach
> a progress->verbose flag, which is specified via a new argument to
> start_progress() and friends. display_progress() also learns to filter
> for that flag. With these changes, start_progress() can be called
> unconditionally but with a conditional as an argument to determine
> whether to report progress to the user.

So to make sure I understand this right, we'll collect traces regardless
if it's enabled, but we'll still honor the --quiet flag if the user
doesn't want to see them?  If so, I'm definitely in favor of this
change.  I was worried when I read the cover letter that we'd display
them to the user regardless, but from reading the patch and the commit
message, it seems I misunderstood.

I think the making the verbose flag a parameter simplifies the code
nicely and puts the rendering decision in the right place.
--=20
brian m. carlson: Houston, Texas, US

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXwfPGwAKCRB8DEliiIei
gfyBAP0ZIIxFu3J6OmaFhUMu1AbtUupPhyLB6lH/o+PlofWyfQEAgsDAxM6n1eWN
VGLGaYLvtEb6llM97MxAfe/JgOcqDw0=
=VdxA
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--
