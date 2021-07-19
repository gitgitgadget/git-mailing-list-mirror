Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05566C12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 07:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA4261003
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 07:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhGSHio (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 03:38:44 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38751 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234764AbhGSHin (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Jul 2021 03:38:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6629A5C00DE;
        Mon, 19 Jul 2021 03:35:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 19 Jul 2021 03:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=8k5vcwhE7XIH1wvZCufnnhPlW3s
        WefIFt/HbIb03EYk=; b=RKZ7sEO5xop136HXnDduEDbM+jO9Sn/yraJNhk8sDsB
        H8uVYrAO+gqoTfoZXvihe5/q23/LsCW4vxDABo6fgac3LU88RTqAARQBUjG5d5Io
        yGpg39U2a6YF7BeyEeRE9/M4ci92g2+zEW/iCgfnJesBCHl74dFFw1gTDrp7RtVr
        zOB6mBdvi2eoVa9LCjp+pLbR7euz2ZNSGHXeVJvIQXa1XhH1+PHwi2y+XC3cVpZD
        5luByuMvnGUR6rBiZu0nITu4qDjbhVyAzQdrg/1c6kSpg5P07E1beDHAN/BYItE2
        9T3xdZOd77UBALkNEFD2AgEZrJ1UsysynLzeE5LXEtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8k5vcw
        hE7XIH1wvZCufnnhPlW3sWefIFt/HbIb03EYk=; b=PlmF5yEjRQrs8ZHJ7/nNvg
        yn6TqHTHbGCGnAL2TDH+NUCPOBtwIs0pb2T8rHnU9oMyi00Ax600KHq0b4+SDs2V
        /LKd9swVcfW3mEd8jq54HI2birII739x7R1PFt1XYOIbT8J4CU1TvAJfIs0g+/MQ
        nPWiJQorzi+V6naGS1oFoLi+NyHfukc2kHBoWVDwTTd9Go8Ka7ftm8q90stzL8U0
        Eo9zr78SWdDmRRX/Ahimbc5Dd5IX4UiwEDpQo+ecDJ6byOM+s/Mfv5BmKLlun6DG
        XIoVlIJk/VLm9x7i7y4WF1tOXowd4oYA4haTOWfeyX6LEN1evIpU4y7g3msPEnIg
        ==
X-ME-Sender: <xms:Tyv1YB2ODk8iLwEcIkBb_RUfYYbIo5Wh-6Hh6Xp7ShUuyG6eT7X3vQ>
    <xme:Tyv1YIGski2EWjq5cElCy3cyPitQunba2dHHRLBV1klmfio233QuB-iyYWe21fnjh
    SQWW-v1GgmzRp_nMg>
X-ME-Received: <xmr:Tyv1YB6xuwojd-mA4FWAMVZft3G4Lu5IMU-33MH8Nkb8SRwEcOo2XPTO2rQOpb4DGfScl_YQKADCpXqop8Ud0s3DigTh65KK6amOwakWzC4v7NcEGp-fqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdelgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Tyv1YO3JlsN5HFSnpEIA5fyWosr8I17sPicVt4X5wTFgpQZsd3Zakw>
    <xmx:Tyv1YEGsXqnw0TzlycGYx4M77FsDHsGvpQLyzuGuySnmi03CGxR_bA>
    <xmx:Tyv1YP9Z5NarRe5cgUuUfRECke899MYE1mY8V25VsYJz4dr7Sfag3Q>
    <xmx:Tyv1YPOT1lhGSCacTyqtHigCytnkKUxuZVHjavdCrllWPYDG8ISJJw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jul 2021 03:35:42 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c89ad950 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Jul 2021 07:35:37 +0000 (UTC)
Date:   Mon, 19 Jul 2021 09:35:36 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Message-ID: <YPUrSB8+zEur+ZBt@ncase>
References: <xmqqmtqpzosf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UNmXKhQaxzWQ1G/M"
Content-Disposition: inline
In-Reply-To: <xmqqmtqpzosf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UNmXKhQaxzWQ1G/M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
[snip]
> * ps/perf-with-separate-output-directory (2021-07-02) 1 commit
>  - perf: fix when running with TEST_OUTPUT_DIRECTORY
>=20
>  Test update.
>=20
>  What's the status of this one?

=46rom my point of view this is ready, but it's still missing reviews so
far. The lack of interest seems to indicate that nobody has hit the
issue so far, and I wonder why that is. Am I the only one who sets
TEST_OUTPUT_DIRECTORY to a tmpfs directory in his config.mak to speed up
tests?

Patrick

--UNmXKhQaxzWQ1G/M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmD1K0cACgkQVbJhu7ck
PpSTdA/+PG4pjPGFu/w6uvIPoZn23tBtF4fwQXcjc3JV7UgOQvFppfkhffXEALWZ
pGAYX+D0s0u+sh+c9rOGvS3kjfXpHLlWTdzwO69mU3YGYiIB7ERHVndzpYb2laa2
hqH53yzCYg517KzMRlwZvBOrxwvnA4VwdGg0cRdHYyT5B8iP19L3pp7r4DuIYKgD
eOmghT/yeg0x+9b1TSKDQMnvcjXO7eCoGStmsXj8BV/Ca23IPOVtYHpMkTlfsXFg
GIMnEe6t8Oz7kVIdrO6x6HEJzp0cPo5Tjen6B3rmyYRWsglSmakZDOoBdpIb/tA+
r3X88AOp3XgOVGZZDWtz5LkpO5cm99Vv6Gl7sr3rKbGYSLbOgFhXR2ik2KnL6agp
DAyln9Qq+snGsc0dsG+1CFqdN4N9cHp3FSKTXYeEMfJL6RtMLyW9swTHXI3cYHUb
BGGAEYBA6SGDE6gA9r8GmCuSM2tSnxr66CTWp/M2CgBW5n3Ueb93EiCXRFBQP5DJ
wzClQT2IvqG8RsBHfHRtPQ7skRavuRnpMktJhNLwZ3xpq/fklqvHCSzmxLCBpqGG
WUEEv87k9fZJzBHnnuEBpUv03xZXM2SGAD3h8UzqpWBRDAhwW0tkxu/fnKJtmqrQ
zBkbguDYfqLJRpk9O+3X88UNiJxD+rGl9VGDPFB01kM7hSXypXI=
=6VZy
-----END PGP SIGNATURE-----

--UNmXKhQaxzWQ1G/M--
