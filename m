Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D39C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 11:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C56023383
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 11:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbhAMLXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:23:33 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56001 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbhAMLXc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Jan 2021 06:23:32 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 57CD05C00C1;
        Wed, 13 Jan 2021 06:22:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 13 Jan 2021 06:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=77YUDTN3U8FCEe9YJBKNV7McdCx
        auqoal/PqfppHoFM=; b=bFhaV9vTBJSmKBN0YeNZYrbkAofCpCTaQL74siGISnp
        hS/wbEDgHzfEvF0cB9OZp0TAzf495mhx0VH4Os2+LxisulEsJo6FR9T5LrmzoxRQ
        646/N4KGmdpB4kXiXmmzQYaFoGFqkfyfYe0Q0jxxhmn3fFkmplUSBUUyGSUdL2UX
        7jzWiGSZ1QRp4XHezcBbaJoGft7DEtl1Uyq3iQAvbrklzeD8y3uHWVrC6AV3zpes
        cppsz5GMUnBb1cxHdl2WnjGT8WT0ch2FTqAPhsyfjOgO6gj4eu4C2r3JXkqXVkRZ
        4TmzEdpZbbwmfXrfXGDKH97Py4EpjsaI+PTKxOSpjYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=77YUDT
        N3U8FCEe9YJBKNV7McdCxauqoal/PqfppHoFM=; b=XnzMM1vU9Ce3aTb4G29uHD
        3fu//H69P6UQNkYKlYoiEsTGZYzIcOVb4DVFYKLtHyVoA93TrL6XtsUccMJuHK08
        ImToROYBya1iJaeJN5dNihmqnpCMP1/9jELjDLMB3UX3/8+rbq7ZGw8H9s+nPO8X
        Dj5mGb0X/D998BZ3EfJ4mep3FuUsRn9t/wzOr808aPg0R0LvvNdZYghbdAbixdYz
        pIXJEy1VOLp7itFPvKK8hmfk8623W4TClOcAulSYRFmj/tNPIbvvAjBEmMDnyvRZ
        3R25TlnBSBm9W0eQm2TWC9v2sgI4kZx1W65PPjJfTXgZLZqSEa1Fyo/wk9DrI7Ow
        ==
X-ME-Sender: <xms:6tf-X_66konYVqz4mCYvtn4dojF0TfgIrqzeSwo8ayV2MTCTbgTyhA>
    <xme:6tf-X07ul1XrYKl4F-ZCImjBQKcJ-5J4HfPKzJ-3Mk-4EHuJrgC0Nl4s6NebPL-nV
    t8yaQ132ZNcyUfGlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdefgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrdduuddrfeehrddujeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:6tf-X2fjEj3LV6UM7DhEtFZOLqVm0s9uzBUflUEpv0EYA6lCcDuqCw>
    <xmx:6tf-XwLJMDO_Jq9u8VoclyUa0ej9Qj6-fYHWloSblZuWJs3Jwp31JA>
    <xmx:6tf-XzImeebLX2q96IKGynEEt_VJvrwdVz5_ATmwlInGe1rqHcmZMQ>
    <xmx:69f-X5gyw0y7s5vsBDd1SS9Ki990k317CVcqi3RuddmSyQWQHdslhQ>
Received: from vm-mail.pks.im (dynamic-077-011-035-177.77.11.pool.telefonica.de [77.11.35.177])
        by mail.messagingengine.com (Postfix) with ESMTPA id 433EC24005C;
        Wed, 13 Jan 2021 06:22:18 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9176542d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 13 Jan 2021 11:22:16 +0000 (UTC)
Date:   Wed, 13 Jan 2021 12:22:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH] refs: Always pass old object name to reftx hook
Message-ID: <X/7X5ku3wvMr2hw6@ncase>
References: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
 <X8n1Qf7TJyqIOE/l@ncase>
 <X/4Pin4Zdf58n1jc@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DhsEzeZ0CFvvLoh6"
Content-Disposition: inline
In-Reply-To: <X/4Pin4Zdf58n1jc@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DhsEzeZ0CFvvLoh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2021 at 04:07:22PM -0500, Taylor Blau wrote:
> On Fri, Dec 04, 2020 at 09:37:21AM +0100, Patrick Steinhardt wrote:
> > Quick ping on this patch. Is there any interest or shall I just drop it?
>=20
> Apologies for completely dropping this from inbox. I am interested in
> it, and the patch looks good to me. I suspect the reason that this never
> got queued was that nobody reviewed it.

No worries.

> Would you consider resubmitting this patch if you are still interested
> in pushing it forwards?

I can, but does it help to resubmit the same patch? Your response bumped
the thread up to the top anyway.

Patrick

--DhsEzeZ0CFvvLoh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/+1+YACgkQVbJhu7ck
PpTmNA/9Fs07NP92d2dmi0dvx9dSbvMai4tH4kDSqG4oIe3KlPYwuM9H+WBKm8YO
TcOM8H75Q5mMt/l+YcMTgvBaid6hh3rofAaMHHFPW4NA4k59tt/bkbCuh2tovZiR
HueP9AR1Sjx/2KCpmKvsBe/hVW1LfK1fyM40i9jYpdwMqwnAUeYm5+VmNLs69Nn6
k2o6jMV0bNjWx7pLQ08VjkSPh5CSYs1vj9htUwLA5XX1A+BcOjEtXAHI9jKIdEO+
dM5klCxleOigFxFh+/p7cylEhhxSTmvt6eBhk5pNvB6In9jN0EqWW2Gtp9l1lEw3
fS5E5ps8taHxGP804wKpjffa+cYvlUiZ2ao1fVaTHVYhlVKuhMGdubiDxwEcUcer
nDj7PxNqeU1tsFzohClRmee+j9bQN06z+eF4hK9nuTNUtiluGZ/dTAMo1hgTrMAL
7qW0clvBvs/cxTE+RuNSddZInNzu7jAEJgtJ/IfL5HJGGR7CtLQHkIn/qDwF/Iys
/aPKgq31zZJ7og3N7GbfIiXkmSapb1swJ9ufapR+kJjyUWvbu4fPCOhcbIBPvv4f
Ct5p9g91TdXpirH3dvnhjzcGoGciXEgF5CdeX45jt6xQ++BGDkLCvHxGoflR5TEM
6wyC1OFgtmXaHIZbaiZ2qtXYPiSsggA3JoPXYyDNuLE9m5H3rMI=
=fjtK
-----END PGP SIGNATURE-----

--DhsEzeZ0CFvvLoh6--
