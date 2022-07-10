Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52B7C433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 20:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiGJUMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 16:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGJUMo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 16:12:44 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38CD10551
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 13:12:41 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id AE3045A1AC;
        Sun, 10 Jul 2022 20:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1657483960;
        bh=SJ8ns3MZvZoQzFN2CxnSMMevsF8gYyKI+iPXVXqfuBY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Fo41f5YFTXXiQwkZv3s0bRuXTRt4HxJtp57byz+WbCkyq/ak2KwaKXkjfMWpZQY2R
         4kukGJM0AigpGcYnZdiB/QWij/cRLfncBAYcC/xTQKM8XFcaTij/YEk9cdXfm1rZGV
         SsVjxz0lPqrlR/xpLbIhXcvtRSwUVxEQgSXjzj/b5D5k/yB6bGom8L8rsDwvdhDU54
         9iTCpip5ZSUQlCPrJ6PyEXLeHZPEd5GwA37oUS2iAXBUXN8QpVcVMafHoZcNzcC4Jd
         EXaWybO2CKQXzPku/QE2kzCGMQZKaaqSwEYig+fkHp+sxmWRnV4DFqJimFbkzxdxEz
         v44WEAjkapesiKrltwNpqhEYeaeVMhCjUEvmhd2CasISjQg/0Ex5B4fz2URZXdeJLK
         h82qSkvvBHxWVa7/1pDp91mM7C277HO3O5qZ8b3llmfGqg0irPnmZkM2RvDFnNOjop
         H2j0H1zU19ZOgJ2NDUPwrFGo5Ncngb3Y0QY9Ht4ieB8HQZrstd8
Date:   Sun, 10 Jul 2022 20:12:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] sha256: add support for Nettle
Message-ID: <Yssyt40xrxjtaL6m@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
 <20220710132907.1499365-1-sandals@crustytoothpaste.net>
 <220710.86mtdh81ty.gmgdl@evledraar.gmail.com>
 <xmqqwnckrkg9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q+tJtf19nGp3OP7F"
Content-Disposition: inline
In-Reply-To: <xmqqwnckrkg9.fsf@gitster.g>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Q+tJtf19nGp3OP7F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-10 at 16:39:18, Junio C Hamano wrote:
> Allowing users to list whatever is available, instead of requiring
> all users to choose only one, is a deliberate feature in the
> arrangement, so it is not unfortunate and it would be breaking
> end-user expectation if we gave an error when more than one is
> given (and it would be easier to write and maintain autoconf rules
> for the feature---we do not want to have two places that makes
> decisions on precedence).

Yeah, I think given the fact that many folks use autoconf, it's
beneficial to allow multiple options and just choose the one we like the
most.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Q+tJtf19nGp3OP7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYssytwAKCRB8DEliiIei
gbHRAP9vBMVjYYOIeuN2uI0V1xL3E8/zMhmqjUM+0oKarW97AwD+IGF1VkjZ2xhF
qvH6qAPi7m+OFs72N34ErAcS5KbNRwM=
=1rIt
-----END PGP SIGNATURE-----

--Q+tJtf19nGp3OP7F--
