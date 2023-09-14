Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764CBEDE9A0
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 10:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbjINKeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbjINKeH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 06:34:07 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C381BF0
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 03:34:03 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E665C5C07D1;
        Thu, 14 Sep 2023 06:34:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 14 Sep 2023 06:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694687640; x=1694774040; bh=V7
        hI62GjM6r5H55rHYoG1TuuHvntXvltGr2wprDXhiQ=; b=ltMsEiw7xfwCTT7NAa
        DRMx+n+i0Xnq15lel1nztOb4xckFVQyzETAyvqwPowYf+kzGlsSwRHonZ3BNOt5H
        jZMsi4rxvAwOjjUfpGtfVJ9ljdZI0AH8K88ueOvUiysDbToZu3Qig7wky2gC+NP7
        mnAflJaEgFZhKBYi1oi1B4JsTTz1HuFxYUAF6WlDtPm5ZLlM6Mkq0Xx2I8wGKYmL
        u8k2x7MPVfuU0vmcsqtA//t46ZzG9QjNbCF8khhTTWdKc+IdzXWXdhh+2cdo7n/8
        bzJe+nuM7u2/ulhV+Sczm5wxw8QATw7evWtl/E1m6CDFRDh2DDPgSHrkyTatKGx0
        dylg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694687640; x=1694774040; bh=V7hI62GjM6r5H
        55rHYoG1TuuHvntXvltGr2wprDXhiQ=; b=KByCM9lJ0R4o1kEYUZh2++APxEwMD
        GDtORkp7jrhyPdqvZYDcXyOtbaviEhUI4vnQ+N/mbs6cEYmfrcbf+g8XKI8vE1EL
        3kvCLr1JC+QZTiWbrZgXsiFUFgG7QICN2FYNgXFfUfTTH09uHIzOo9YsbAbNso5x
        7/eqB0VPbf33BSRXJhwGhB2OPxm5FGHzNJ6vOHiZMUKm89uA1iPmQi9CXLUzuoGn
        Q+LFUfPkgA2FDWOisi7oL/fylvAtKfwfRupoYv5AaogoCzyvr9WQCZGJzEKCjBkd
        i3I8c6lLfBxz+t4j9rBidXFKuiQ81tazC1VV8Yk4X/S1oPkFwPicuDuMA==
X-ME-Sender: <xms:mOECZVsV7Ma8Ao0YwM2uxR7OJfNma8E3aPps-0VEu9HOLFVvtAXqxg>
    <xme:mOECZef1jq8MEvUUv4PaRz-oFdpRQS4-u-IczsgUHPhzO3d323n09fdB3hcPCLo_K
    5tffeRtpb0V7AIY1A>
X-ME-Received: <xmr:mOECZYyVICs4WKQNlsL2Zdusq47kfBWLId0j8WTTg6T3Q63RbslhpgUkeAhifEcQeQkxdteu_v1EgfI0eo4XwQRWW8CERbqXxO2hK_uoP2KltA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejtddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:mOECZcPgLi1gsGETZ7phyuL-zhpo-BSWx3eALgNeE7rxap8aV6dLYA>
    <xmx:mOECZV-p7OTrWzekV9-IWzF2H6VRpcAOZHgmK2RyMz9Gmo_ZbIthSw>
    <xmx:mOECZcUTah-xcRXncTFa8AbuxbLPyIL_zYuchbqqKQi7MQX5WBhs0A>
    <xmx:mOECZQZNFQvW9ihJLqvv_cBkiU3CH7lLNXQuUS-OMazrF_cUk4c0rA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Sep 2023 06:33:59 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 65dc2679 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 14 Sep 2023 10:33:40 +0000 (UTC)
Date:   Thu, 14 Sep 2023 12:33:39 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 0/8] repack: refactor pack snapshot-ing logic
Message-ID: <ZQLhg43mCVF3-vjp@tanuki>
References: <cover.1693946195.git.me@ttaylorr.com>
 <cover.1694632644.git.me@ttaylorr.com>
 <xmqqa5tpluyj.fsf@gitster.g>
 <20230914000750.GA1709736@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K/Gn6AZvSMXTs9S1"
Content-Disposition: inline
In-Reply-To: <20230914000750.GA1709736@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--K/Gn6AZvSMXTs9S1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 08:07:50PM -0400, Jeff King wrote:
> On Wed, Sep 13, 2023 at 12:44:04PM -0700, Junio C Hamano wrote:
>=20
> > Taylor Blau <me@ttaylorr.com> writes:
> >=20
> > > Here is a small reroll of my series to clean up some of the internals=
 of
> > > 'git repack' used to track the set of existing packs.
> > >
> > > Much is unchanged from the last round, save for some additional clean=
-up
> > > on how we handle the '->util' field for each pack's string_list_item =
in
> > > response to very helpful review from those CC'd.
> >=20
> > The change to [7/8] was as expected and looking good.  Let's see if
> > we see additional reviews from others, plan to declare victory and
> > merge it to 'next' by early next week at the latest, if not sooner.
>=20
> This looks great to me. The motivation in the revised patch 7 is much
> easier to follow, and the end result is much nicer to read. :)
>=20
> -Peff

Agreed, the patch series loogs good to me now. Thanks!

Patrick

--K/Gn6AZvSMXTs9S1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUC4X0ACgkQVbJhu7ck
PpRBag//cz7hct7PDkB6AOpAbK+U/BYS+/mmAy/t+Ukl/FkpoR/Tw9BDgPoyaBQ8
JrmubC8FBBwg1WzWrPP8b71gI3Li/2lGDtr5WQOKul5ipo6fmoWAvPykfCxrKmsl
Wme3KBoJGFD3AmJ7drEZC7qVA3EvnmB2l+scYt7U4u3EtbB8Zs7sL7rV6aLPF/jt
TpLqGo2J4WMdwiUVj3uQrhxEhvvclStfCPDpr6RAcb5J4hmGuEohS676CX8zr+eT
crne/sep9s93gvBEvs/9U7mow2WdcYlFQ6yeI/4cjQJ0Zza0lCdusAdq181fM2jd
YUIahSzk3g/5ImdodAGrQukVWn681Lib+gw3uJ9ao0c2lofkQr2gKkiMW2Ol75YT
RtKDNQgBJcB6H4ROL+yko9V0rjsFcNiIA+0A4WaZS+T9WR92PqsKBJs3yY6MA2IU
+oKpsc81FuJV3BOAKpcYTr78KKRyl2Hu4GSkS0o7Heq0eJXZO790/+df5FzHJJVK
g4nzphQ3Wk4zRMX0oECwaGUBZUNrZqCTtLXg8Lr9B24Z9+F/YE9Z6gmgWnEFeQjJ
MjOSQ8saWH8M5ITOp+5Zcvxif7Oe2MOva3cgZrk2LhrxCLsQf2a0A825XGx3PANm
/9ElEkzvZs/09SbNOgagy3WJT1RN4zBDv4j5ybjSJPYYWmh3LLU=
=hLvR
-----END PGP SIGNATURE-----

--K/Gn6AZvSMXTs9S1--
