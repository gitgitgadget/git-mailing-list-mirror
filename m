Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F155C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 11:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbiBQL1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 06:27:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiBQL1d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 06:27:33 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80BC15C645
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 03:27:18 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C3B323200C20;
        Thu, 17 Feb 2022 06:27:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 17 Feb 2022 06:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=vFspHzlxRfiJWzerstlxJr6TBSodBx7EnNxSmu
        h7eVc=; b=EP86ITFlWft0R4mg0BwAj5G6yLTUwPHHp6ofEaBDBj0ZZ1Jxj6bArk
        WHzmWKa079tLaDdAcgPd2RiLzHLZNZGNycrfNG/K48zHg5AcnAdvA7+537yogM3l
        +0kwIldTjD0kumyOoTAQOj0l3zcwJcSKF5UxlWLqlrYT7Sj2c7QJh68wQeCup2Dc
        Uf4cslEJqmUPasNrX1oZoti49Zt/R/okYdOYSKKeJQjyztzx71prQ0RwpcSHVfaE
        woXV3iLACBiGvr0Vqlb7rO+ycGqZrCJw5SnU845MQaxfCiTXlKkFQmCTi9PWGjCZ
        1mFmYad+HwNoDelbRlgcP2TNQmhJvf7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vFspHzlxRfiJWzers
        tlxJr6TBSodBx7EnNxSmuh7eVc=; b=Rk8aozBqCpv4Ym9zmE4mqKySKFDCPgTin
        wKpoveVkaLnNFb8sOSZKez70MfQ+dRG9/Z8bupH8yP/wlccqHBJ+MdZiBhYtBjkj
        eZspg6S3yntnDhFND4/3WJ5jWNiVkPt9vhTR5mglRj+BoQ+/B/6liZbrL0lOQv67
        eoJkIMMP/jfs8A280x1PeSAjFM/kpgVVlu/6Zb44f+TrmiGILM3BGKnYOwkMAcaR
        BqR03FbD6Tbh8UdA41OrMLL0Ik1sJBDxh/VE8aXczy3+AWTNqYkewSS60l3tLBHL
        lM2vv95jckxMYEsJ46/UYQjIhBSuhuISLzbQemA+6ZUEmf5hMhl9g==
X-ME-Sender: <xms:FTEOYjv4iaBo81eITyluyMVjQIISbFJS020lHcsOtnR4xB-BN6cnXw>
    <xme:FTEOYkfPHZizKUTl2Y4vCn-PAsg4wj28FI-EmcGOGkVOLitwSLA59xw3iDpSpmB2T
    dZXeF-65vIUwtwy5A>
X-ME-Received: <xmr:FTEOYmxjvysus-9ft_UNfeX50jXOf_4CA9RlL-B76YY1Fun3BxaukX1vpiExsTSZNyvQSn-6OFGTp3-0UjK0FFBxqTKY39omiNSAPGGMqIIexYpVrARvFtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:FTEOYiPJQyg9EXBQfLQSDqLr8530Trw92KefC1o1E5ETgYDGYdIdMA>
    <xmx:FTEOYj_aGQ4yLx7RDqZHyGAs8xX49O3c6h-peHUdvipWtcJeTZBpWA>
    <xmx:FTEOYiUjEZCk9wgumL75_dMb8yZHF9PYJQxlD3UMnrMY1rlqs6EsKg>
    <xmx:FTEOYgECVR3MAbl8E1yyPCJLQcUbLvuOGPVDb7Z2j_PCdHP8w-OXuQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 06:27:16 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f2f936ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 11:27:15 +0000 (UTC)
Date:   Thu, 17 Feb 2022 12:27:13 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 4/6] fetch: report errors when backfilling tags fails
Message-ID: <Yg4xEQmXyzSeYZ1k@ncase>
References: <cover.1644565025.git.ps@pks.im>
 <54fdee845bea7f67f46817417f8e5a504bd39665.1644565025.git.ps@pks.im>
 <CAP8UFD0MQCpFfWg2FP3S1VpDAxCwp3WGucFPn7K9BZ7UnckNLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GzB+FVxxPZAZx+lv"
Content-Disposition: inline
In-Reply-To: <CAP8UFD0MQCpFfWg2FP3S1VpDAxCwp3WGucFPn7K9BZ7UnckNLw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GzB+FVxxPZAZx+lv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2022 at 08:52:14AM +0100, Christian Couder wrote:
> On Fri, Feb 11, 2022 at 9:03 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > When the backfilling of tags fails we do not report this error to the
> > caller, but only report it implicitly at a later point when reporting
> > updated references.
>=20
> Probably stupid question: are we sure that it's a bug and not a feature?

Good question, and I don't have a definitive answer for it. But to me it
very much smells like a bug: if I ask for a fetch and the fetch fails to
populate some of the data I have asked for, then I want to get a
notification on that failure.

> > This leaves callers unable to act upon the
> > information of whether the backfilling succeeded or not.
> >
> > Refactor the function to return an error code and pass it up the
> > callstack. This causes us to correctly propagate the error back to the
> > user of git-fetch(1).
>=20
> Even if it would have been the right behavior when backfilling tags
> was implemented to return an error when backfilling tags fails, I
> think it's interesting to ask ourselves if this change could be seen
> as a regression by some users.

Yeah, it's not all that clear-cut because auto-following of tags is a
bit obscure. But our default behaviour is to fetch tags pointing into
the history, and if a user didn't want that they should've passed
`--no-tags` to git-fetch(1). So conversely, we should assume that a user
is asking for auto-filling of tags if we're not told otherwise, which
also means that it is a failure if this fails.

At least that's my take, but I'm happy to hear arguments against my
viewpoint.

Patrick

--GzB+FVxxPZAZx+lv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOMRAACgkQVbJhu7ck
PpSAJQ/7BZjSy00+/1PvmYyi3Co5EAB0SxuFCSVw7nyMDL762wHJq0P4Cl+TfBJK
b3nFobhw6LYHNmLoxHY15j1LWduXy/MXhX1cRxkjtoR3ISwzEuPWuxJgXTMsD0UW
Jev9AMx+4KtcluoE5LHMFIU20czcPW+gemul1cSYKGHrhD0gmyxkbVRTmYxQjoOz
qeFS2fuU1XRU0fQjHlNb1xTnKVrDupvuiGIy2GjQH2HJgvVeQ3SfjC7vWTqdQ9O0
WpAi3GVDJAXR70UiDaToTIMfszrylyUBcJNvSmv6G0DxrZnoHWO+QZZuSeJnESbf
3of3k9+f0DMz3EAdXkOLgAhH0DGm+P6P1m9pMZpOEU8giu4UjjWqcZNoW1Y204a2
myqW+aTJfDkTWvZh8BILalukxJtwxHqd/nM7/E3lKh6kxQImciKPVIfyOYRni8NE
k428Q6cC6lhhv2FfQEIa0Af8xSXvTOcKME8wBH/yRcGobNZl2v+7wOg7yPNra+WD
P1TlR1zDILr2pEyX8lg6v0IOXJ4+2vHFtwKu0w6F1xBLrrWGwASrQb03a4EczYrl
rR8Eh4ZEo5XAT/Uc8q9Auh+oX7bCkSKBrDG0h5iPuDxRh02vtOpsQmrajvod5QRn
1F0AiPOzpR12aShFWV/TlS/JL74nASHEvF6PITJHdv7K5tJ0VUU=
=YErx
-----END PGP SIGNATURE-----

--GzB+FVxxPZAZx+lv--
