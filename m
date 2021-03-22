Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2ADC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6756198E
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCVMRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:17:36 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42417 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230196AbhCVMRE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Mar 2021 08:17:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 416C65C016A;
        Mon, 22 Mar 2021 08:16:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 22 Mar 2021 08:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=I0g4d7cSoDxTFOHbho1GBo9304m
        SI4ot9T4otMSH7Cc=; b=RkZ3Vcram6DpkfoFj7kD6O8IXOeEAVEaUgBYJdUtRWJ
        iAn+GNpSvv5Kc5daCs8KVb1IhqJNtmjiSbvgHdMrnaeTR5o5Tdtp5o9xjLYCOLPk
        a/gnq0nU9mVx883zagnnx2+VcwgXgv6sViqkjw+1teLHjC0OzZRd/btZVUJoHyHz
        ska6WG8uPyrzkCYhkBYTqaBRSq9dbrPEx7CR1EqYDAb1lQPYVBRnR8BHqpgV7wJ5
        fHAmw1hzK6Ge+21XG6B6PojL7uPmLcTi/x7TWM2RzBIuQIdFG+PtDrtJ61wH2YOS
        jTH1CRi0+yfwkinvtf7tifC+Os5PNNJVOywR04eflww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=I0g4d7
        cSoDxTFOHbho1GBo9304mSI4ot9T4otMSH7Cc=; b=mfi0f70oK225cEadvN+Y43
        T/u8bnTmhzSWQ2OFttYby2VQ117WacFj5P4xE3jI58c3w+Mmwt96ZmsthY52yOgt
        Fe0Wj10CBzNyBTHCdPCfWG3hLBBeEoPb1gnKjlN2m3L//jqSytkwLrhisLq8yzgs
        1+CjbpGFIX8NAe1oAf0Z0F26tyJKR40PaOMeXz0xWHzdC8cBp8C0WMk2Rzu2BBPb
        CJeb8iL2mnSvGcNm6n0b8+cGKnCE6TOXI480MPXqg5H+zkTd1YG5oWBX5hpPgCtt
        sHpoGO0UQ/8UD2lbxY6UVMIDEDtcAVjk7qf/K2FPkGV+13t7ecoorPv/IV8NqIVQ
        ==
X-ME-Sender: <xms:uIpYYF-nPjn0ghrINa-igIvx-XKxuD_nLogWPoZqG16Kapu4EVENmA>
    <xme:uIpYYLsIw9MTOJpDNhfBRDdO9bgmQjWwReGQJsYQ8KaLdQmBeLmuNCX0mCrILxNVf
    ZIKHeHZ-iu4V0JaAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudefrdduheekrddufeejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:uIpYYMY6vALB5sp0aV50KBj4bp7vapZLgvYrAe9QFWcHa9eRqgwUDg>
    <xmx:uIpYYLrfn8rnUtJqQ3O8GaVmKEnTuANBiCaWGHT3euMncQSRMEaMLQ>
    <xmx:uIpYYB9LNjYVlxZtjL3XMDICG6Q2vanS_qlzrpwHog7VpogPUsR3Dw>
    <xmx:uIpYYBw8eSaM0Aq4mt7QO_WPLIQQxvGgmslsecxxipBV-P2p9tnyug>
Received: from vm-mail.pks.im (dynamic-077-013-158-137.77.13.pool.telefonica.de [77.13.158.137])
        by mail.messagingengine.com (Postfix) with ESMTPA id 990BB240356;
        Mon, 22 Mar 2021 08:16:55 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 19b4637b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 22 Mar 2021 12:16:50 +0000 (UTC)
Date:   Mon, 22 Mar 2021 13:16:49 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-bitmap: avoid traversal of objects referenced by
 uninteresting tag
Message-ID: <YFiKqf8P0XVSca8L@ncase>
References: <e342077ed116fb47c6a0fa645abd5558310efb09.1615993858.git.ps@pks.im>
 <xmqqk0q4ov95.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0f0RJ7JB5LTQGGmE"
Content-Disposition: inline
In-Reply-To: <xmqqk0q4ov95.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0f0RJ7JB5LTQGGmE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 18, 2021 at 05:13:58PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > While most benchmarks are probably in the range of noise, the newly
> > added 5310.8 benchmark shows a performance improvement of 25600%.
>=20
> which sounds impressive, but ...
>=20
> > +test_perf 'rev-list with negation (objects)' '
> > +	git rev-list --not --all --use-bitmap-index --objects >/dev/null
> > +'
>=20
> ... is this an interesting use case to begin with, without any
> positive end?

Not at all, but it's easy enough to end up with something similar. E.g.
`git rev-list $TAG --not --all` wouldn't typically show anything at all
if `$TAG` is covered by a revision either, but it shows the same
speedup.

I've changed the benchmark to be a bit more realistic here. I've also
added a second benchmark which shows a modest 16-20% speedup when using
`git rev-list HEAD --not $TAG`, where `HEAD` and `$TAG` point to the
same commit. There's probably other cases that may show speedups, but I
hope those are good enough for now.

Patrick

--0f0RJ7JB5LTQGGmE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBYirAACgkQVbJhu7ck
PpRDFxAAldslb3im3dOUbjmeJUuvjEdmF5BUCNHwVDijWdRut4ilMwQNq7Cj0Wid
jQZkKqzO/zm9d0jyuUIwUDWJRCx0odrpzAxyc/XO8qksqb8RLn4CIXv/Q+KxZivo
/DvwYTsIyLD0SyWc9Wx3o+zdFH+ENJq8sDHcWsSbelBc9G0glwmina/wqOI/87to
IIkm5LgzrUVkUOYq28Gbi3qX97V9AU//d4eg7h4LgDpdp9gQCPesZrlijwHNO+Fb
VrzsxJBlo4Bd4WORLmW3x9cxBSbFf4bidQCdjF9ev8mYRtaW7FJKvAdIECAcNavC
8DLKo1BBWidGG+XlRMa5KboY0NfMJvCqtOu2a3sfRWctt/4bfza4wLjVj9VzRD/2
Ay+jGxCxNvZtPOLUDxxl28pqhIp1yaQRP1P6eOFPIBpMEk6TxwoAQ4uOjE5ylJYc
1wn8KcCFBOihpGSSNV2+fWt1xrHxE/A0Ur8HzMb8IC5uQmsR2MABuyF4lwoXlj67
kkEFcCH5F1BR7p7UV2XCg8rAtAYi868XYgYjLgVD1Bx/nPMo5kB8uUXdx/8Q7ZWd
0pECu+h4q+rx1o7FIEYtX2VgcN/u+8eG3Puze1TkPZNAMjCxsw4FLGXNCaGDC4u0
3iOjchtpuxV78EoWqVyKeZhDfIfQ5VD+tttGD93GH0De9isPVDg=
=J1Mg
-----END PGP SIGNATURE-----

--0f0RJ7JB5LTQGGmE--
