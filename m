Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DFFEB64D9
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 01:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjF3BVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 21:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3BVt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 21:21:49 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D17E270E
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 18:21:47 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 298225A210;
        Fri, 30 Jun 2023 01:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1688088107;
        bh=KHhtefkaizBsbk/8Z4r7YiHrCO+ij8bZB6lTHSqaE1E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YfLu+rDOgkj5LtZ4j+TuXBEqGcWNuaGK47uiKkONfC3ZJSjTTVzgRA5kLiUAPUTeE
         p4r+OjQS4XXpacHBXTOaUZFrU2S6NjcZrlv5rrd+BP9pqbohAajr1HZxzVJwostAUA
         uCm6xfseM5BZM9sTm8+0LaxizilEywhvagjlWXasvcB8O0LN9Hzn5kgLouvWKMNuXX
         n/aM1G6lLTUspbr45I5oCYnY1akIjjbnVhOHdcQCmaKL9fGU7DcTNGe+q5w0jXHa1N
         GoSC8gsITi6KxMwMawBwIUNZ/f4ZxOAE5+uBdL7UJ2TNWt+gjwNTyv59ER/PZP/1kQ
         Y9QMnUVMaJAIvfbD52/AR+l9PtcVCoeHZcdc6Ppelosz9dTxgblyzRt/fPsI2DWwBn
         EzjaYaV/WOgU5lpWk1BVn7TbMFec34hP+Og6WePipL/FmAk63QHMKkrWZQD2zRB7mU
         UKY0kTp3R2XMUyQJ0WTyZHTx1kqQDGsOfIjmJExYG/db4Jue7X5
Date:   Fri, 30 Jun 2023 01:21:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: SHA256 support not experimental, or?
Message-ID: <ZJ4uKYIZMxi3DHo3@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Adam Majer <adamm@zombino.com>,
        git@vger.kernel.org
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
 <xmqqmt0iajww.fsf@gitster.g>
 <ZJ303bm+VAvp5nyV@tapette.crustytoothpaste.net>
 <xmqqa5wh9adg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmbF+K7ZIomaSdXV"
Content-Disposition: inline
In-Reply-To: <xmqqa5wh9adg.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nmbF+K7ZIomaSdXV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-29 at 22:22:51, Junio C Hamano wrote:
> True, and our messaging should avoid scaring them away from doing
> so.  But isn't the lack of interoperability one of the reasons why
> GitHub and Gitlab do not yet offer choice of the hash?  There
> certainly is a chicken-and-egg problem here.

There are a lot of necessary changes for a forge to adopt SHA-256.  For
example, at GitHub, we have a single null OID constant in some code that
has to be addressed, libgit2 has to be taught about SHA-256 or removed,
and UI changes need to be done to accommodate the larger IDs.  I'm
sure that GitLab has very similar situations, as do all of the other
forges.  After all, think about the extensive number of patches that
went into Git itself to get us there.  Everyone has made all of those
same assumptions in their forges.

I'm certain that whether or not interoperability were available would
not influence the forges' desire to support SHA-256.  It's simply a lot
of work to fix all of those spots that need it and requires a lot of
communication and discussions across teams, all of which takes time.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--nmbF+K7ZIomaSdXV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZJ4uKQAKCRB8DEliiIei
gUASAP9kDCifZUGuZd9A+bQbslPOCdhx91LUDbIgJlNcmyp2YAD+PfIelq5/PGv6
JP4TMS3RHBfuJUgMWKYYikLWiosr6Qc=
=/zY6
-----END PGP SIGNATURE-----

--nmbF+K7ZIomaSdXV--
