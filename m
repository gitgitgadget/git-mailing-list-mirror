Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F914C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 11:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E01061107
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 11:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhKJLoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 06:44:03 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47779 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhKJLoC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Nov 2021 06:44:02 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EB31A5C01C8;
        Wed, 10 Nov 2021 06:41:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 10 Nov 2021 06:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=02aP22DWNh7nYKgzTGLnIO1jACs
        QmDB2yP+cwIlMwUY=; b=WRZpbHCZ5TupEIhUvhywmr18kQ/qh+jc2Etrjj1Rorh
        svARoaC4uJJDNcoW7gi41grtM1tj7JmvJ1Oxp59NX2UsAXZcPh/aZTBm66NJBtoC
        rLrJuDLsldaTSN2MUcm1iULLCr9DaSExZxFvhAa4n26nYSAMmnbhU2VyrR61e8Wb
        jMK5+18ZgQmxxUFzQ06p/mpR6MxvT4U/ASJzuJw19TGlOjoqsF39IgPM3IWyvU/Q
        Ss7mv/7McN/s2bLcaCKUVR4hZKbePpupDu1tp3jmVxOWBBEV4mlbVzw9XhT+aYns
        yLmWzUqT0+uPIG0pRyZEu7TW5RnkUl6obzPt9w5XKPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=02aP22
        DWNh7nYKgzTGLnIO1jACsQmDB2yP+cwIlMwUY=; b=g4YLwBtSGcRQ4hx72oWBY6
        ihAr19U1N6qZsnQouB3zqcOmZ2Q/irQ/vgvBbjC2KDYzqeeQksErqzZ8ijeXeY5v
        wpaK/B9j7lnlxo0Dv0MC8BdV3j/dDEbG+2deuPVJ9KU84B1vGhgk8OMDgJg/jtNP
        oKKxvNzbh7AbPPNvI4QYPORlxCaBUKiVFQ2UdZRPCEfsPCOb7Wa9LEwhFO89ZuRZ
        bOrhhbq930FG6hpgiQe7J6Pk5G/1l46/eYS4skYEeJT4+l5qdPwblLKEA+i0U5H2
        VLn3EL0W0dBtiW1gnbtcDrksXI7vWK74UKKZNSNTkOStRq4CVayYGKQBcrGtgN7Q
        ==
X-ME-Sender: <xms:2q-LYWHnR9qj171LDazyOAZsKqyOUxetbiF-roPJyx_Yh4Jug4OPnQ>
    <xme:2q-LYXXG4D3BkJAvYo1rUgcDkJ62D_MbSKWyZBe9rAazssGe7NbUDylYofNPTKLRe
    A7xUugvSXoilx_VZA>
X-ME-Received: <xmr:2q-LYQL2PazjVO4CEvbzKMNj99HbP0xUhJ4BV0JY4mxma3UG32tjhmzvNJ8U8meCqpn-SU8vLs2ZDyZGQ1-1TUw-xCj3Bwde_3MB3ybXENC-Az4cW4wYFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:2q-LYQH3IswnAyIIhzbkluGtyk2ei2tB33NaXnYNkVQpidPoyhvSkQ>
    <xmx:2q-LYcXV_SMQlL6LrxHuRr7YFmeIFEKpSTSV5rVtCiMS0UDkHgYDug>
    <xmx:2q-LYTOfpclXV8LpHO97S332eOehFNgEPGzQlmOiPMR0Y1H4B-0A3Q>
    <xmx:2q-LYWeIMbXCihCNfnvQewa1LSrhpT_tsPXz5sf5mZmXHYC3KxFRXA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 06:41:13 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 312ca0e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 Nov 2021 13:26:23 +0000 (UTC)
Date:   Wed, 10 Nov 2021 12:40:50 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: [PATCH v2 0/3] refs: sync loose refs to disk before committing them
Message-ID: <cover.1636544377.git.ps@pks.im>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WNsS3vcAKoioeC+Q"
Content-Disposition: inline
In-Reply-To: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WNsS3vcAKoioeC+Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

[This is a resend, I initially used the wrong mailing list address.]

this is the second version of this patch series to implement syncing of
loose refs to avoid a class of ref corruption.

This series is implements the same batching as Neeraj's series [1]. It
introduces a new config switch "core.fsyncRefFiles" with the same three
toggles "on", "off" and "batch". Given that it reuses funcitonality
provided by the batched object flushing this series is based on "next".

Please note that I didn't yet add any performance numbers or tests.
Performance tests didn't show any conclusive results on my machine given
that I couldn't observe any noticeable impact at all, and I didn't write
tests yet given that I first wanted to get some feedback on this series.
If we agree that this is the correct way to go forward I'll of course
put in some more time to add them.

Patrick

[1]: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>

Patrick Steinhardt (3):
  wrapper: handle EINTR in `git_fsync()`
  wrapper: provide function to sync directories
  refs: add configuration to enable flushing of refs

 Documentation/config/core.txt |  7 ++++
 bulk-checkin.c                | 13 ++------
 cache.h                       |  7 ++++
 config.c                      | 10 ++++++
 environment.c                 |  1 +
 git-compat-util.h             |  7 ++++
 refs/files-backend.c          | 62 ++++++++++++++++++++++++++++++++++-
 wrapper.c                     | 30 ++++++++++++++++-
 write-or-die.c                |  6 ++--
 9 files changed, 127 insertions(+), 16 deletions(-)

--=20
2.33.1


--WNsS3vcAKoioeC+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGLr8EACgkQVbJhu7ck
PpQzrQ//RomUpTSZXvJcIweorwwcKbd2T9YsGX/PpYBKvdsnjNkuxgnkSxKNq2B3
0kcqwneEyllwoORxs5G2oA7Cq7CWe2Kbk1OC1ZXBOg5EAdeRcGxTv9xqsh3qRxt9
i5mtb47E5dSew++a017MQNS9jsh9soR25SPDbzj6/U4f7mqvpCA5RcTw2nxe9vS4
Y8OkabPzpxMwjYyD/UepYQr6usbcIQQpVe57mMVz5T71juCjK4K2elHrGY6DAKBA
Qjdk3JCK7Ia6KWqcVg8XeKRocifyDLWsvXyh3fcD7zjec9QyZelboUU1D3+2DOqb
eWNy8D0EARTYwZXs/ZPfcTPkEi4wLze2bKMn3MAPnK7V7zj/zO/1m5gSWAvFEFy0
oFUWv9dEttxFKFKvviAeWKdmA9MBEHP/pyE742NY1LPs8sgAvb/n0EsJVEQI3/Iv
CWSBy0tyVXutKpg0yCfyoh1xQYHP1MvfhaWm3k0ip9X8WKIDX/QZqU8Z+MSN0rT+
P0oXm18bq0Mq2o3F+0gTPxV77ITEbvBJO+WyIQTgtThJB+rVniKa+QArBe9ynG2c
m77uC6LKmnPCGYG7RbhGeXsWfMYyli9Q+2bDNUk5GqtpToKuaQ/yqwz3Y45hAc09
xX7ib5iEh+YhHsbXCrpown7jgB6aFVom5bdtUUf4Kd/DNFx6qgM=
=dscC
-----END PGP SIGNATURE-----

--WNsS3vcAKoioeC+Q--
