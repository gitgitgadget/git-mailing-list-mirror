Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56047C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 09:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjECJOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjECJNo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 05:13:44 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407305BA3
        for <git@vger.kernel.org>; Wed,  3 May 2023 02:13:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 45EB05C00C3;
        Wed,  3 May 2023 05:13:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 03 May 2023 05:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683105182; x=1683191582; bh=Kr
        ESkUz5WH/hc26X7hc+0SAuNkcrNbXdRFa/y1oj55I=; b=KQvu2TG4B7Ss7g5jOR
        unI299yKiXoLyLg57ZqxuDsfnmUcvvsov+POXVNAgw66H5luHbn2wC9F89W39OVb
        sQyVucCzj6paKcibiV50YvkVtyHESZgjcgKWSG3opm20+bEL9mpZWeqRO2vayI55
        7dqXNL3ZR/cYQsJpU+k0BokpDREzdsKeySL5ARAcnPgFm2EwmhWgR0A9QMAibl5q
        aZ4ymAYzSeF+MbATYPv3bgmuCxekBsEu2PwKW3vEobzI6xtRCKb6GOlKWN0xJXvP
        pA/dCWfnKrG3NgdwmYmpkzCbO61HzHOy3kwXtKTd+L52QZLEsX/gvOHXHVSW7XST
        5rxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683105182; x=1683191582; bh=KrESkUz5WH/hc
        26X7hc+0SAuNkcrNbXdRFa/y1oj55I=; b=i1mrkZB3dwhYWsdLsJYm+OttYpi/i
        B2L/k6tUcHwVmoJDKNSpCnVWKpp5UK4rzh5G2ZUAy4THOlfNfJw5DeB27taEejnP
        xLs4upXkQ7G7pNBE811FW/nsTacC2LTO5aWh7yV1MQBjoXSAbB6eldndrKrnsx89
        nGp/SOT+tQKMbDR5KyNj5eFmzIqhY6DBnNgiA3zGDXjEd0BAULaciHqO4pFXyTkM
        +Q4izLtCiBWXhi2yTnfwNeZB2T67qJaZs8EvvQeIKH82zzOoyHinvNYyWWNqhNut
        b9xCxMYa+OsN1IQCw/HzAQxucrT1PqlHzZRWZ15IwEwoVy3yv59mhbEjA==
X-ME-Sender: <xms:nSVSZBZVRu8daYOd9nk1v0H0RALBrFiUVqtnCTMarIsEayoGSKfB1g>
    <xme:nSVSZIYaot2iprJVGixnOVWkvhpD4SvVpbPeR-qqLeafv9AHktxNTX3MPaware8Mm
    EVkkUP_DThY0toRYg>
X-ME-Received: <xmr:nSVSZD8HwqBVXz3OsMAbvQT7uCAhGmnaqz1JY9kvThH_-0OWG4Im7uItUcIfR-5Jx_3C_DC716UYlNqyigMLV4KaSsBP8WhI1ydOp6DEnBUH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nSVSZPobF1q1HXFTxm_G7mXUd3VsqAyyK4NRcnXf40YHA_2KxrLPCg>
    <xmx:nSVSZMpJtfHdkj6fMJQMyP2E5k7HouReaNNFRejpZtt7bNgw7zuTMw>
    <xmx:nSVSZFSDmn2MsPwQjDarTyJ7J6UghthKYJXyyxbJvcPO7W4tflqq4A>
    <xmx:niVSZFkC0aDeqtcAxalMk5_lRsl3t02V5k4Ih-3Y8Q0ckXVNLQ4DOg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 05:13:00 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 842cb921 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 May 2023 09:12:16 +0000 (UTC)
Date:   Wed, 3 May 2023 11:12:55 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 7/8] fetch: introduce new `--output-format` option
Message-ID: <ZFIll22dBQvSm2nz@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1682593865.git.ps@pks.im>
 <0335e5eeb4ded336c5ff7c8888c8aab9dfed2505.1682593865.git.ps@pks.im>
 <xmqq8redhtn6.fsf@gitster.g>
 <kl6l8reb3br4.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9NSk+JFxW9YuTTZl"
Content-Disposition: inline
In-Reply-To: <kl6l8reb3br4.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9NSk+JFxW9YuTTZl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023 at 03:03:43PM -0700, Glen Choo wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > I wonder if
> >
> > 	static const char *const display_format[] =3D {
> > 		[DISPLAY_FORMAT_UNKNOWN] =3D NULL,
> > 		[DISPLAY_FORMAT_FULL] =3D "full",
> > 		[DISPLAY_FORMAT_COMPACT] =3D "compact",
> > 	};
> >
> > would be easier to maintain?
>=20
> It's easier to read, so I'd think so.

Yeah, I'll adopt this approach in v3.

Patrick

--9NSk+JFxW9YuTTZl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRSJZYACgkQVbJhu7ck
PpTuzg/8DmaT1zmbDAA+tLdXd1pVHGE+OF5LdZ5LJxutl/RleQ4tAkYBB2VNIqvL
sv6j9uGPvd004Oq146/WqqZTv4vU2lBGrRdoPk2b+f3EW1yOEIwvpKFSUom2kuBT
88HUp5mntg+d5kAQ1MPuMP9aAceUFHV8XPoThCpfwDTKpembDqf5Jpa70URovxuI
wqZ2NrtqNipSfxeKIJXf7FbzficTn2YX6D4cdUgnfzVGPCtEnc5fYJOglttuclB8
An63Isw/LkTERwAL2gO+jV5/sZIVjvlsCIGCc6E2JXWe0aH/OmzLUkYGigxZpb6P
5o6fDEZjX3FAmNTzYfhTHpV3iIrMYLq2Imp9CjzxisPr3PTfCzTPa+tG0lxbnNmf
H0ygfg2sRrOfBowlPa4eKxTeTgQsbiGrya9hSxqnxh/+tktx7ulUVhDkNHIhVDz6
a62jmCzEDB5CUS1qpGYT9UUaGwweku06WnpesvEY/co3SA8KhO5N9SI1sFn4ZEM8
EkmpTCPuarZEH3ESwRaopXNprIayP3jFsmg65mQfDQsAaPuMF9CSvhmPtYFZnyz3
YBySKYJ2JTeVnhIQgyLjfHDT4Gs3nm+js03UhlKAlbLsgxupsXx30UfclV47XWc3
TVbN/xfavk9YYnD9EHv/r5S+NYyL/yiACq7K9Ii5ez1hJH8sCaI=
=y6OV
-----END PGP SIGNATURE-----

--9NSk+JFxW9YuTTZl--
