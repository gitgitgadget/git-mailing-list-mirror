Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120DBC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 14:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbjDEOsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 10:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbjDEOsL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 10:48:11 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D75E107
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 07:48:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5757B3200941;
        Wed,  5 Apr 2023 10:48:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Apr 2023 10:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680706086; x=1680792486; bh=og
        PTuF2DXJt1GlLOWKloFIAp8xsM3m2BLXNHA9lR54Y=; b=p7HLot2hz7PSY5LyIB
        DTqQ4IghkX1qDhQ4QVe/jdqrlYTNZHfnqspjlNtu96NmM0RH9x0dzyBIHuvW4LmB
        g1itOHKSgWDkDgAH4h0KjOBPwacCowXLIXLExdjUwaPIbx7+QEWOAN4nBmO5uURV
        FEfKZuuiR4PMU6jQ77RKbVO/NHVKzIbS1stU1CCXFanTE5jSWjyUi6iYFsfAjS5E
        RHcb2g53+B34Sn8Bg7yhDKgsndXtCRcT7VPa02tLNwGOFZECjmvupuBxgDcxZ1kK
        nhormBa+f2u3j7T8I5exO8bdWq8fKXaaa6B8aEq9p5zKfZYzHw+1u6Iq/QUax3HJ
        ARYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680706086; x=1680792486; bh=ogPTuF2DXJt1G
        lLOWKloFIAp8xsM3m2BLXNHA9lR54Y=; b=EBi1Sba9P4Qmag+k9aNKeQq5OSzrt
        8yYNz6xqGiMGov19s9BLfnjBqfUpN8GLMw9nFjFjoIY6nUTNF3UuWP7zImSGB+f0
        z4b8YfqogNIFX0VuCg77tx95UGlhs7msRFBkr5ecEQHHloiLH/RLYYaSLvRImlEG
        OLp4mRCc3/5ptTCOpPXxnMVnUfQUSQ83zKRlWQlLyA5CdqB8jXsTctYUJCMoenOu
        +e4AgPJBJlJyntki0BRgGjjAqfZvFzzKgtYMApJnHXDmGq7eLE6Se5uIEbnLei8B
        GhOZZyyuo/hGlvn66yVO39wpWYJD2hobdxaQXTxUitNKM0snCJIATmBDg==
X-ME-Sender: <xms:JootZCUfLqH4jA2O5WkUsn8_0udlAvK_-KXmjOIP8KY9rzoMZ20l3g>
    <xme:JootZOmcsCSCtn_ewuwBP_U8R-Hjq-NlXTTu9jW3hbFZMoYk9jCmwLMvtyipBL7mK
    dW-a-eas2VAK67VxA>
X-ME-Received: <xmr:JootZGZ9WPjkG26HOB23YnrcysC0g1tgWANxrQPnxxaFhu7UO-_TCzbNk8ua2ONaPKEB3I57wgqLQG7TuTYdqR8LOVGtmQuyAGSshmL_jB1J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:JootZJV0QpGTVONOgOuKFQVHul01n5P6K0J8puk8uUsS2Yq3PlYk9w>
    <xmx:JootZMlFqXlVuIHi9D7ZsleBRVWA74YimTcghtjT0AtShaBqWaQcKQ>
    <xmx:JootZOfo9wW6wj0wGa_WbfgwLT19UgmVT8uErGptD-87xL9XP24LbQ>
    <xmx:JootZDuhVZsqOY5qCErRZ3dm-yZy2kWDNsPqD9jhfeH8HAR1CARzyg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 10:48:05 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 5d753d65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 5 Apr 2023 14:47:56 +0000 (UTC)
Date:   Wed, 5 Apr 2023 16:48:00 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <ZC2KICsJN5pmsqWX@ncase>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <CAMP44s0eLNOWFr7fc6M5Fompw1Y13vAxk8=fAWVZ8-22Y-xihg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g/tTUJAQIFyMQNzc"
Content-Disposition: inline
In-Reply-To: <CAMP44s0eLNOWFr7fc6M5Fompw1Y13vAxk8=fAWVZ8-22Y-xihg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--g/tTUJAQIFyMQNzc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 08:35:50AM -0500, Felipe Contreras wrote:
> On Wed, Apr 5, 2023 at 5:53=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> >
> > The majority of Perl scripts we carry in Git have a `#!/usr/bin/perl`
> > shebang. This is not a portable location for the Perl interpreter and
> > may thus break on some systems that have the interpreter installed in a
> > different location. One such example is NixOS, where the only executable
> > installed in `/usr/bin` is env(1).
> >
> > Convert the shebangs to resolve the location of the Perl interpreter via
> > env(1) to make these scripts more portable. While the location of env(1)
> > is not guaranteed by any standard either, in practice all distributions
> > including NixOS have it available at `/usr/bin/env`. We're also already
> > using this idiom in a small set of other scripts, and until now nobody
> > complained about them.
>=20
> This is standard practice in Ruby, and it does seem to work everywhere.
>=20
> However, I wonder if /bin/env does also work. I can't imagine a system
> system providing /usr/bin/env but not /bin/env.

NixOS does indeed only have /usr/bin/env and does not have /bin/env, so
it wouldn't.

Patrick

--g/tTUJAQIFyMQNzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQtiiAACgkQVbJhu7ck
PpTduQ/8C/4JD9lBe6RTVL8uvB+HXOcOUyjyYMAVyT4GCfXr2gJYcraMTLqc+htZ
8lYKtKE6efi+9KOqL9axKY4V44z6AyGQwurVxYka7xiiOUin4tRh0111l1CGG09j
ILVqVu+1pOuRTwUkIECAapDG+1UcAxPJZoYFBqDfY/hK1q0l7X0RSHj73CoKLg6S
Io6mc07KiqWkd8tgKRhOIKbDoKTTrpasTN4FwaufdLbFFvJahUH4t5WYZH3JhKvy
TiQI/3DsjIRiauEKurIa7ISa0Ign6dY3A31WbKo9nCDdlfgFExA9MVPmruXyaEyb
Pk2pG6poFq/5O0pPYzTLTF+0LRFeg7SVCkP6qPxvuw06595REQCWEEwyPq2EOqnu
gO/Ow/1HKfwGS+6sC56n8rL2Vv9yVC/K6KqLcft/BqMtcFxAGHIU6budhsKWBb4M
O1paeXvGxMc9wOijt3cr6PrnKY55CMEWJeLLLoXKSzI7ZTbLEFuWcPRoWmw3aHwf
76YD5G9QyCOmR8SCvpsXy7kyPStIocUU7WVNcbmcDU4KvXodMVvyoPsOe8+lUem4
oGyXtn3NiWslavhWAilA+JeATWqPYXgLXre1XNNIzseKfpCie8VtAis5LrAJ8Jll
F7QTxYzigYwqPFGBHAaHCCqRpnF073EtzVVki/4Bn5p0ok5xVuA=
=dlMQ
-----END PGP SIGNATURE-----

--g/tTUJAQIFyMQNzc--
