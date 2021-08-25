Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D1C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 06:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8235861373
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 06:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbhHYGFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 02:05:00 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:46685 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232480AbhHYGE7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Aug 2021 02:04:59 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BA2D23200A3D;
        Wed, 25 Aug 2021 02:04:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 25 Aug 2021 02:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=m9ukwYjxTiEprymHLs1KDBfnD/O
        JJHcLLjo7NTcLIsI=; b=EeSml+E8g320YlQQnUoRzWksEmPnVZ9sdd3ZIwtqG5d
        Cqb6glDDBabfz/XOt2lg5xPa6dRtrEMYVd5jmprAh0sKrEbAOzipAfzXo4uSxYZ2
        mOyUOZZCQqcgLgOlxQf08escXPSy8AEaVnjbA7P0sTz48ijmT+n8HteoA92yRi2F
        3Ru/hOaiXe4ntZtSTlVEEmDaO9xO8LcP180UlmA7GVLuijTmqQElRW8sfdiBSQSU
        jLOtEdWEeHp546MX/HBEGY7KZ5eLrHTKdXd8rze8JIIDqj6CkXY2pFsksYR7oiE6
        Q6ToxD9MSRPEqqSQepepsU/aidGfMyvDHE3prfk+c7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=m9ukwY
        jxTiEprymHLs1KDBfnD/OJJHcLLjo7NTcLIsI=; b=u56oUkdO+9lwxLWQm/x+6O
        WLVrkgpo5ipTTl35jVYwRRYTD6fXQ3YxxX/iAQgcFQQPp++nPp0aLkmqDarDhKAJ
        yX1/Mr8fTs253TCMnSsujeVYze8FQZgCtNg4Wb1H/FrHBdmZXHXiFO7XU46zGUuZ
        JYiyEcnWSLK4dcEfjsY4vy2UG1OYrzyuxtVyN0VF0dNcy1GErogofknNnzXp5Mu+
        VvmCDY9Zw99yFpd2sXDec6/tzU7RDQBYFVXW4oTqjyNDgmWxMyyu8ReWWnmB+z22
        IRNrlpUl7M8L1EVlZPS7aXNQsDXYBlUIAvec94SG6rrb+5Gug5AoGnhqviVXMhvA
        ==
X-ME-Sender: <xms:XN0lYRLgV37WXR_IEAA7maGvUchKY3PNhamALBq41VV7PJ6v8NhBlg>
    <xme:XN0lYdKvSDN70_1hZTiRhhVBlwehxnaqaeq1laOtHcR00B_fY-EOzqbRSGyOSoKHI
    IeA4Bv2BEsK0YhxOw>
X-ME-Received: <xmr:XN0lYZvg4Uwu-RnXeftM1LggUKA_BwP-yUKAr_slz_ThI8zyQY9y5z2kIwgTUBf__5OGvUPXxfCx7ZihoA5MncU5zEU8bGBLAp1ZwWu2Z3p-AqTCNHwVmNI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtkedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdeffedvhfelheehleeghedtveeiieekffduvedvudetfeffjeffjeelleefvefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:XN0lYSZQv2kFlQoo4X35uYBQSu_YvcWPuKdNIKA1B0CfWBzoJjwmmQ>
    <xmx:XN0lYYYIw_tifo8ZgJVKN6YqmterIKX_oP_bW0cQ-XIzTKU3B_BB7g>
    <xmx:XN0lYWChIfzdx865XHU468_N-C6pL-ArDjW9E-JJIvcNnY_DexPk3A>
    <xmx:Xd0lYfVcpB_PnBv5AJ6cvFdeIQrKm7m-GO8dASQBHhL3RC10HP0-Pw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Aug 2021 02:04:11 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c97289ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Aug 2021 06:04:07 +0000 (UTC)
Date:   Wed, 25 Aug 2021 08:04:06 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 0/7] Speed up mirror-fetches with many refs
Message-ID: <YSXdVpSbWtjBkREs@ncase>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1629800774.git.ps@pks.im>
 <xmqqfsuylarw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JvbHhhfqtAY7ON4k"
Content-Disposition: inline
In-Reply-To: <xmqqfsuylarw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JvbHhhfqtAY7ON4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 24, 2021 at 03:48:19PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> A better way to handle a situation like this is to limit your
> dependencies more explicitly.  If you look at what I did to the last
> round of this topic, you'll see that there is a merge of the
> 'ps/connectivity-optim' topic into v2.33 followed by application of
> the patches, like this:

I wasn't quite sure how to best handle this, but I'll keep this in mind
for future iterations/patch series. Thanks for the explanation.

[snip]
> I had to adjust [4/7] while applying them on top of the same
> 3628199d4d I created for queuing the previous round, and it would be
> appreciated if you can double-check the result.

The result looks good to me, thanks.

Patrick

--JvbHhhfqtAY7ON4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEl3VUACgkQVbJhu7ck
PpQMLw//Tmi1fYCE118/s3HV1hpOtHqCuKtq1atiI8qvnR4Nh9brXeZTs71MjUwh
Ngd8j8uO5UMRFOQpneb5KZAxd7LXSUv42Gl84qCew9vrSMsXgmCSBnfe2SaZWRsi
yedLUri/HoNYA8OasOFMH5vdqP89ndWE5IzbZZY7dW76zjV6uaS9bIJ8h3E5NgbA
BK/TcWVwuLlr1FkzMwZQqEpQLy7R7k9obg6OOMqXb/wxklgeyEMWRRAi8bcKaZX+
8Wj6zLICJp2OG3MCI0rN4NeDzoZfYzQDdwPabbOQCupefF6LoxPuJYZgLLYw+1pP
u5tN/8UdpU5iCM9d9ihnNdE+mpev4NeSruopvZfbAcYAnPxaLDJPEetr9CV9hLI5
ZP0cm2dm9h3L18Ms7mWXh8hGwISKjHICD3IE/FKSSLfdICDVZoXDVFAgVuPeV56i
EFL/upPxCA6r7l9yEbW/zs2VIZkAXjR5Lth37p3+Chkwkvv11rf6uYET8zwgNGnn
IEzcQt56ZZtDN6tVhxV4LMxbR0lfHtKUpERuAlUZlGLrgZvS56Ej4PNiurmgZcCr
wGLK/DgacWcTQMeRAjFK/y50438iQ5xIJhL0+8smfv8NElndu2piu32sETZvLZnP
RB4BuCwux6FqZG2wIw+zGafYSJ9yFPEDKcaBk6fWNld+wlMCmig=
=/k+O
-----END PGP SIGNATURE-----

--JvbHhhfqtAY7ON4k--
