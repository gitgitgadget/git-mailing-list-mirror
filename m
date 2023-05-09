Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A98C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 12:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjEIMnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 08:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjEIMn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 08:43:27 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B9059E9
        for <git@vger.kernel.org>; Tue,  9 May 2023 05:42:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 26A3C5C0103;
        Tue,  9 May 2023 08:42:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 May 2023 08:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683636142; x=1683722542; bh=aW
        fU0mbnRhj1QFy2GbiO6ha1GMlwRhXGyECW1G4NX0U=; b=kORzikMkTUpuqgR3lX
        PhwZOYlv8/yUTncH83/wCfFxo9hABJazQ51EOxUJT3vwtanuLiWDFFtjgximQNih
        1bEr0o+Agpaeo7uDrjz05FPali6GnfcNlrg7eGEkPbYgtbxtLczhkONfStr0K628
        8/lgC/Qa0P49bTRXZMOSHcVGpKo4zc0cHdN+9SoeWzX3h8slNgc5EnZVBgkVWG3C
        I4Hs1L/BWqgZ/hmrcHNnNXYlrpd8DP7fiqRErPlq00C5vVdmwqhLwRfAEZVwUN2M
        EkLbMD5kg5X2FUEZTXUWGh+GCjzhtGIhRuE5RGYCUKIsLMRmYFEPghewoUWTrR/M
        jyHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683636142; x=1683722542; bh=aWfU0mbnRhj1Q
        Fy2GbiO6ha1GMlwRhXGyECW1G4NX0U=; b=Spy60AaTgqnWcKWJDje+b4eQeBrzQ
        odRxn46TYkRgb5nJKisaIpds3EL2WMRX5x0TuXwFMKia47BxI3lR/hYzQM9OzN+a
        cQDPd48XxM+UpYIkBLpS2md5qBXY9tKcdZiEV4gZ/dzBNdW4oBdL8h5E0chW/D2t
        hHAe1PtAqyj1bifrHndZx2NUFevfbwn6AGT/atSzc9oKKN5fFpRgz8q2gU5Ig5/k
        bBz5ZKe6O8GO6UsSkz9tMGhiLxyv1SCE2VIZsDZYs04fFJAeHMhPkYeco96XavVG
        wCqYHzAQPu0AYuHN8x9d7EOzKErYkFUZuplnXRMqNyPv/v8dMJ3go9k9g==
X-ME-Sender: <xms:rT9aZGQ1BqE3J7S7uIBgM6n7pUawDNT6KIPx7K1mfB9S2a64z6RAtg>
    <xme:rT9aZLyvwlv0HUFQSXYLWI4VeHaopt9n9HDKPdVZyt325xnbZWoICqJN45fkedUNe
    5OzozeXNTWBIMBq3A>
X-ME-Received: <xmr:rT9aZD0TePwwb1HO1sqUhC1usXYlpA5m1u9aPtgW479z-GTUeyQekVM0diiEXsTdmj1gSaQiuFDZegx8WDpkkYyqM62zVHf_04_nBrZOeyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:rj9aZCBriEem5-Hv9lj7CXK4jrBlbq1YZ7-1O59pclVppk3PZxaKFw>
    <xmx:rj9aZPggGMP6emgKaA9P6GY71k-TFF5qz4SG8sJmN7PyWC_LqOc4XQ>
    <xmx:rj9aZOp1a7Q0-2Ni1risp0KKR2w-AZSgU38lBlpZPcDFRB2AOtnl0A>
    <xmx:rj9aZPet90cINGcEHFYwny6PcFGaz6EKSnXvDFQMoRaAx5dyjxpH5g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 08:42:20 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ef48dfd7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 12:42:12 +0000 (UTC)
Date:   Tue, 9 May 2023 14:42:18 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v3 0/8] fetch: introduce machine-parseable output
Message-ID: <ZFo_qpzWkEHVhpFx@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683113177.git.ps@pks.im>
 <kl6lcz3a1i7v.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KVfzwmoVNyIeYfyB"
Content-Disposition: inline
In-Reply-To: <kl6lcz3a1i7v.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KVfzwmoVNyIeYfyB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 05:06:28PM -0700, Glen Choo wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Hi,
> >
> > this is the third version of my patch series to introduce a
> > machine-parseable output for git-fetch(1).
>=20
> This version looks great! I only had minor comments this time, mainly on
> docs and tests.
>=20
> Thanks for your patience and receptiveness, and for the fruitful
> discussions :)

Thank _you_ for the extensive feedback and constructive criticism.

Patrick

--KVfzwmoVNyIeYfyB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaP6kACgkQVbJhu7ck
PpRgiQ//caTvK75njuvhiJe5SHrmelShlACKs02KaK062S6IOAvgJQH+sogZBnWK
2Ica5nBU1lJzv2UGRWS0I/5gHxyYyQWLcCKqmTfuk41jIpvPRfQpaFtTZn/k5cyE
LcIsyrWHT2eMpbXM2C6XDZWK+hRx3O1cCNDQOY9cAEBNGC9QHiH6f1othCgQ1FQR
ijcyIa+OakMZl7TaBl7+Y+Hj8I9YMINk4+MbJvNo1cKPp5aG41rwijB5jG7nPY1F
7vTyG2xREhXKPP0ka/r4kXhrUYo0Wy9c6kQxQKBoKw4Y0rToMYldLN+6SBYys9HQ
Sw+MhW/tLZZHqTWlSOvKJJZ6LC+BkyE+KBul4Ksl8W5VF4thO9RZD0iRudb96ejG
IL495MhbLIvrv47yfssi2rkI0+EiglGM0T/Ua9QbsY3NiOX1QDNmGDBf6ZSO3eTs
Pq6JeDlTFpjXpE36QyhD+No36U3Su9WqIWtQkFTWno+IIRgWBvnR9HgWAqFIklP4
igDG1JHwMRwYXx7VanWwRYIS6J/iS5BR90VzuN/gZiYFWY4bm8xB2twUJpXbHk24
9J8Ox2zU7TUzi9QkcU3CcJct2HXeHjiXCCJPw8BDm8F2GEH0otDTPykJAEcJfgwM
XH9qU3n5Wnp1NL5vF2vttB7lUPcmlaXEpf7tWLpS7F6BtMoK2fQ=
=Iv0O
-----END PGP SIGNATURE-----

--KVfzwmoVNyIeYfyB--
