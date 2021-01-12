Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E9AC433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8065123109
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbhALMaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:30:13 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51347 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387857AbhALMaM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:30:12 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 52D3816A2;
        Tue, 12 Jan 2021 07:29:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=tVgALWtwX0HUbiEG7mUrqoHgYVH
        JnieCM5lJK7lwW64=; b=dgW6HSYIjjLVAffs9CJSl8DXh9UgqUMRuCfLIngcCra
        ftK9dJ+b8AQIzCrXArK4D8w2luY5+pJu363RvPpi9jbP8Ym/3ebglXr8XEdCR0Un
        pnDjblIJUR5jDUYyEmaC46yDf7KfeXoY2lQxGNU+abV53ndGYupoy5rkleLiwZts
        JfVy2pXXnWenRY/o0gudeXE3d8kWO4yZE6SB8X5GWCfT0R62ptZN/yOcXJGkbEdc
        DwNRlulxDrqenGmRDWLJzqc2tHd7mMHJm0PsFOuYBSII6s4/keSF+GBKDetzTfwT
        0iNuXN16c94jk5sWbTmViMl7i9aN5ROZySFbqq/RqkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tVgALW
        twX0HUbiEG7mUrqoHgYVHJnieCM5lJK7lwW64=; b=mis4hajEGkIot6HCs0vD0X
        Kp0k3+Qt9d2wJ73s6vpNpa7QBEHqpvVXa/f43un+xJZXD3DABc62ViGEi7KTzEar
        BLQ382JP8BjZ40ROx2D6mF1MrI+jIIV1CJx8ZfuQJpThXM7V0H7uXDuk4cnfmPey
        KG61rH9vFNAWzWIBPflVoQSKp6gyazlgD9n8qvOEWy0fCLlWm5xFIRz4T0NJMOPo
        vvm96VRWLRtveEI9c1zeVvsPlIsunWjOKWz0P4uFKS9NUar9SmzyvYmK88NdR3NF
        TueUMsO3c4vkxnvgHKjd2iel/jOLcCK/g2or29PYUg558CKgL94FFlctrLAKFMoQ
        ==
X-ME-Sender: <xms:EZb9XyhQMr5tXj2gFU-aI7uw8Q1CsgGgdQzeu0QQsXvlCNjETX2grw>
    <xme:EZb9XzAtRgyPxueH8wevMLWl0BkZrNB3qV1M4QH-4osJ0fkSTugccwY7-TaKd-a_7
    Dqw5K2LQn9mEBR-5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgepudegnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:EZb9X6G1GobUTKK7j2j_68548ad1oFf5vfBKZ7eRpQGD7RTRwJkrBA>
    <xmx:EZb9X7Rn3WuiIxtMScLC6KhDc1nFt0xC4tjD1Q2-Wsm22c-wNXVbSQ>
    <xmx:EZb9X_yjpMbDmBSp4PYvC3pQjxcyGzaDUPUKwt8ElZCLMN2093UvFQ>
    <xmx:EZb9X4o1Tk-zrteverC2HLZM_kSaAtmIf5aec4bf_Dgt2BLEyzE0cQ>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id DBA44240065;
        Tue, 12 Jan 2021 07:29:04 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 11ecf03c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:29:03 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:29:02 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] fetch: implement support for atomic reference
 updates
Message-ID: <X/2WDt5Kb6rZNXW5@ncase>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610107599.git.ps@pks.im>
 <53705281b60285837905137f45fc8607012d2f19.1610107599.git.ps@pks.im>
 <xmqq7dongeji.fsf@gitster.c.googlers.com>
 <X/wrgYYcZfYZj+4/@ncase>
 <xmqq5z438ddv.fsf@gitster.c.googlers.com>
 <X/2UkKS0AhT6jLXj@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kttNZ9UtAkHWfj5i"
Content-Disposition: inline
In-Reply-To: <X/2UkKS0AhT6jLXj@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kttNZ9UtAkHWfj5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2021 at 01:22:40PM +0100, Patrick Steinhardt wrote:
> On Mon, Jan 11, 2021 at 11:47:08AM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > > If we change to
> > > always accumulate first and flush once we're done, then we essentially
> > > have a change in behaviour as FETCH_HEADs aren't written in an
> > > interleaving fashion anymore, but only at the end.
> >=20
> > I view it a good thing, actually, for another reason [*2*], but that
> > would take a follow-up fix that is much more involved, so let's not
> > go there (yet).  At least buffering a single line's worth of output
> > in a buffer and writing it out in a single write() would get us much
> > closer to solving the "mixed up output" from multiple processes
> > problem the current code seems to already have.
>=20
> The buffering of a single line is exactly what we're doing now in the
> non-atomic case. Previously there had been multiple writes, now we only
> call `strbuf_write()` once on the buffer for each reference.
>=20
> > > Also, if there is any
> > > unexpected error in between updating references which causes us to di=
e,
> > > then we wouldn't have written the already updated references to
> > > FETCH_HEAD now.
> >=20
> > That one may be a valid concern.
> >=20
> > Thanks.
>=20
> Just to be explicit: are you fine with changes in this patch as-is? They
> don't solve concurrent writes to FETCH_HEAD, but they should make it
> easier to solve that if we ever need to.
>=20
> Patrick

Never mind, I forgot that I'm still replying on v2 of this patch series.

Patrick

--kttNZ9UtAkHWfj5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lg0ACgkQVbJhu7ck
PpSJzw//eGJvoCql2gDIF1IwmM9Hk4YBAADa6Jf6CTczd8K+aOA2ekkz8WszXqsA
/ue+JKj5W5QlOKBu++nRw4db79z/64VOoND5vkRCXGczwbtw53HSYTeNNXhmXZUl
vxv6+sJCKvg6myQPz8WpyGY3+RWiOuPdSZHY2gnuwX9dMWCI1HF9WxmHytbTK7sK
zOCLr0JodXUlT+CUAgnHKM1ZDeemsWxZulCs0+lG3BuSeTGzWribEAbkqSWasUBd
b498Z8wkrNwapwde/qEfaUkcW5pwO+k6y64vRGapAMwicZyWDKxD39C62o48l2of
+juKcpc8wv/9NtQdnl5hjlzZvGTotE92Sp7JxgwGhngKpP01zim8eZPXp5lcxPi7
InFT2y/F/OrskVFEuZQX3nIQvWm16hgo/cwjTAFaUBUld/IOQCVLVCP/zlArHj8U
ExGaXP9qX5DCEJj74Im5OFIpw52ONDFAkmNgqFi7HdDq+MGvD+aI6Yyho+h/1rIU
AgctPDPqkue6mZFKCjVgMawuSyJJ0W9vBl0XdcFAgpe6LWd31ilKl7zoB8ChnWyS
dcO/30r/Q27Jxs565OUzcZdG2k5ql1b5WQixsaB0WBPVYB9rAqXVmJmlv7pxE4Dl
QG5e/eRQTAhz2Ovn+iHOMaRAClhJrsrfYM6d8VlRY6ZadeSfNug=
=u6tq
-----END PGP SIGNATURE-----

--kttNZ9UtAkHWfj5i--
