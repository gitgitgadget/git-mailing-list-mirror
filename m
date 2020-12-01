Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5BFC71156
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8F920657
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lv0CgTti";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YlrioKKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbgLAJ4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:56:43 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:34939 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgLAJ4m (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Dec 2020 04:56:42 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C260BC45;
        Tue,  1 Dec 2020 04:55:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 01 Dec 2020 04:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=fCG42qws/iC7MhIKRrRE4pBttVN
        iHcauADEeTzKtkwk=; b=lv0CgTti8kPWrRCaQ/xs4SFZ4Q2ehBZKmZcSAOiEiQ2
        VenKW04Wdp3TpPhkPpyDHI2Uj2ZIy0XoOEjGMOpnWDSUzhXSu1jV8E1z3ly8lQTJ
        k1FH4Ng4fYNM9UrBWM0wQeRXY1v/kgNpDB5fffQl2IwmjHQC+Srr1AVbqeS3Xs8C
        Jujm/S0Y0hz5HpNj+gcrxX6aERhOvbDwb3Hr3QESdvvT4oUAt1qbcRO5GrYTzyEX
        SKDPtF7lajfwiNadRqBZZhXgGrBOW6Fg5wKz8PMoKSkRJArYEzTgqCkd+CUDkJnp
        2zRzjBaI9CCZtILvMEn7tfeIFSFqQxGyo5IPissyb9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fCG42q
        ws/iC7MhIKRrRE4pBttVNiHcauADEeTzKtkwk=; b=YlrioKKHHgtapmIz+nWNXI
        xsZ3CSUm6L0xl5wnIaFsI+6V3PljR75X4nitR+4G4JDmXjmhmL6+pK4XJ5P0s3yN
        5Yq5kENG994i0aarrirPJgEO5SSuNhrE/HRxoeTOALpLhR/iciUBr47EALow5lz2
        kdTfR2x4YU7UGGo1uV+wHoN9kxilN5AEhRO0GnmpZWtEbeXfUmpLgaRbWIGm78aC
        7oxysCBxXbrTu2pDaEx653ufbtnBiWDWuCw/OJ3QEa7co9vL8f36WF6phwZaasG5
        v4FCYD9Z6ra7Z/w96SeyAqCBqLIEZu7IEuZBI0TJ44Zsr8L1+Go4O2be9o2ml2WA
        ==
X-ME-Sender: <xms:KxPGX9j9byd2MtZtDl5_uGKwQooCNmasiSomgLIuxzusAxONSk2UGw>
    <xme:KxPGXx-mVCRyIT7lD3cUEw9QeyyVICNZoRHqIpLZCr6CqfZSHYuJbxmfNUZdBUtv_
    JqqDr7grCVCtoIHHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehgedrudegrdehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KxPGX5-KAy0iLP5T0gNGLYu_4wyO_MHQtBkj2b8d24G79WKcS_OS7A>
    <xmx:KxPGX6DMS8c3y9tQ94C0sMdThoBGTWwezo4ZTDO9a4t-Fr4qlLFJuA>
    <xmx:KxPGX5zpnGcxceJD3Vg2VVDfxhbU0Zp8paGHHS9hA0dtmYS5qSYMqw>
    <xmx:LBPGXyOwBWXiLw02uBTbCI-8CwTInvDyTHEvZ6MyV_Br7_f05LuEyg>
Received: from vm-mail.pks.im (dynamic-078-054-014-057.78.54.pool.telefonica.de [78.54.14.57])
        by mail.messagingengine.com (Postfix) with ESMTPA id 075821080068;
        Tue,  1 Dec 2020 04:55:54 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 341202a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Dec 2020 09:55:53 +0000 (UTC)
Date:   Tue, 1 Dec 2020 10:55:52 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v3 0/4] config: allow specifying config entries via envvar
 pairs
Message-ID: <cover.1606816110.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O3q9WxPGI2YGMZIh"
Content-Disposition: inline
In-Reply-To: <cover.1606214397.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--O3q9WxPGI2YGMZIh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series which aims to implement a
way to pass config entries via the enviroment while avoiding any
requirements to perform shell quoting on the user's side.

Major changes include:

- Another test case to test interaction of GIT_CONFIG_PARAMETERS.

- I've exposed `getenv_safe` and now use that to retrieve envvars to
  avoid platform-specific lifetime issues of returned envvar values.

- I've split out a patch which performs reindentation of preexisting
  code to make the actual code change easier to review.

Still missing is the `--config-env` way of doing things. I'd be happy to
live with both ways of doing things and adopt it as part of this series,
but I wasn't sure whether this would be welcome or not. Too many ways to
do the same thing may be confusing in the end, even though their target
audience is probably different.

Patrick

Patrick Steinhardt (4):
  environment: make `getenv_safe()` non-static
  config: extract function to parse config pairs
  config: refactor parsing of GIT_CONFIG_PARAMETERS
  config: allow specifying config entries via envvar pairs

 Documentation/git-config.txt |  12 ++++
 cache.h                      |   1 +
 config.c                     |  99 +++++++++++++++++++++++-------
 environment.c                |   8 +--
 environment.h                |  12 ++++
 t/t1300-config.sh            | 115 ++++++++++++++++++++++++++++++++++-
 6 files changed, 220 insertions(+), 27 deletions(-)
 create mode 100644 environment.h

--=20
2.29.2


--O3q9WxPGI2YGMZIh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/GEycACgkQVbJhu7ck
PpTovxAAgPHTXTqLujvCHpnweJqzea/IXUyWKZQtvKzTBI8UwIYXmwfU9aVtsSiE
hl0w7U7/ypVyvqD16/uVHt/p33Q2Qx9nZrF4RB4Z68UZtddCxX9ics40nuq3BwXJ
LGrdMJbamaTLaikabuz10pt2s4m+cFNjdkr8HL9mjUO+VWtsirLcSuXGXJSlPW6K
vFXQFr9R1PiJ0/qNvYaM5Y/+ygXoA7u3DMEyH6JOSiQ84dt4nLzEW/nH4teJEJbz
yhGbosEed9PLJj+sTxq1DSO8r6lExm/AXbLeYZ8CEmC2nbxS6HWiCmV6XjSoFRRL
GOw4D6iving/zgXrYm9tV0hFhmKpVzcGA4HWJNC6s9RNIazhgRIQampde/Fc55B3
AdFVLm3WZ49yg2pMl2rclSlJGl7NKYTefnNlVepkX1QSDR1V4PYvkPZ1We055xL3
iZgOlTpN6OQipteEdZgSCp7HanikZR65y8Kica8ZAnOy+oQGY5t59ELnYcw7v20/
GnJMXJUC1tNgtlD2JJkA/rKGvH9TfeWYOsAdDvNyklZkWHKqnuS6mFMB1ddXwa1d
ds6ys1BaDsADb4NAjxr4U8vKhLms+90E4Fmxjiej6Kuyh3k8oWYySqPZj2gaVX3e
ah8B2dlKmBA0kN9MEupuQdsmV4qI4yOvuRZwBMG9nnDx/LggLxM=
=v79a
-----END PGP SIGNATURE-----

--O3q9WxPGI2YGMZIh--
