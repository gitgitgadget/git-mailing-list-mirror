Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AEFC433FE
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 11:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiD0LKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 07:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiD0LI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 07:08:58 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26671193D7
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 04:05:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 32FA3320095B;
        Wed, 27 Apr 2022 07:05:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Apr 2022 07:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1651057540; x=1651143940; bh=qC+mT98Hpy
        uQ/GGFk+8QxKw9+mDeLOfydSHkJFvNpVo=; b=Qc2NA4dKKI9pBVp7UUx7KixLy7
        EIt1Vfm8tI5TJ63WMvB1a8pGdaFjEhLv6QXaPrZZ4fPAuRjOGJnAwDOaP4q1/vGG
        nJqB8Ib1ugGAFhQ+sBQs7n3ApaYcVrpwR+IN4nndUBQ5gPTpHFweS3kAnikP170m
        y+yx28HZN9Q4uWXSK1T7WlG+KjaX3pNxelVgOZ53PX/3OY0BY5sljdVyuzb371WT
        EpZKtn/ukRIj2/Sm4is1t8LD91idnwe/HDfzNwlnwoJ39gwm12hGK4i6lguApF9B
        FvGPX1KUtlMUy1v+l/7gkxipvomh9W943/pCsM6yVwZ2t90pfLAPxxw9iMrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651057540; x=
        1651143940; bh=qC+mT98HpyuQ/GGFk+8QxKw9+mDeLOfydSHkJFvNpVo=; b=d
        q9CdYW0ONXtDvBq+zSLOJy4vciKjenS9A6ZiIbNskw8EYClAj/M5t0EdsuPYdEBn
        SQHSSD/PPhieXyXwVlzBb/NXJcQdgi3QoJBnpR30JPtecWy3FTNUl9cI+5SauAev
        vhHbKc/xkjB+4COWvNL2tDk6hg5I4z8V9KYekOBpvMHjn2kUpYslQycVL50SUQkv
        eeXG6mVwx5/IBrOpsEL4yQxwG4VM7QgaI5NwYWXL9CUU2ONcXCAxBDgq148y/vSa
        p3kqpxJy2t8XmpWNCKdVGvp9ZF8svo/FX078SFF789+9zr/F152q3tabFA8baErG
        IsEr/anBIV+pY0eV94s+g==
X-ME-Sender: <xms:hCNpYrz-qAuK5KpGlI9Fz3GtMGWLR9xZP9KSn1OElLvPBawxDlC7ew>
    <xme:hCNpYjR6F_EFcsVD8TQN_X4vOhCtbk5D66mMOrjNnnXuyZOU0RYgfgkz1Of85YKHC
    VJIhZJJ0EyGCumvlQ>
X-ME-Received: <xmr:hCNpYlUYGnabZqoHattZCYUVOOPjczlEFODr8-OwMhDzqVNQgv47HTMSpKGHPACwT9FGy8bhml3DrDyo7DMA6GPsHlN9c8HLLmWV04TqZecOsgWN9clyc6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:hCNpYlgmOCSAcwJi2BbnHNMbGYxrdAWdRR4IXCSU1ZlN9X74yACBmA>
    <xmx:hCNpYtAnv8MOekSdLAzsfWGWAaKs48bxFFH4jsRkhKHViWqpSS7TmQ>
    <xmx:hCNpYuJvz6rbM6WZ8zmvLa_r0YWDKf9IVMkek2VOOXvi07KQLCbiyA>
    <xmx:hCNpYsMvjUoykhVs0O8z5DJssTD9xVZI9NHp-RYEozjLijLmha5Ydw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Apr 2022 07:05:39 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d71a79eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 27 Apr 2022 11:05:36 +0000 (UTC)
Date:   Wed, 27 Apr 2022 13:05:35 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Michael Heemskerk <mheemskerk@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: reference-transaction regression in 2.36.0-rc1
Message-ID: <YmkjfyB3gIQ2t45V@ncase>
References: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
 <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
 <220413.86r161f3qp.gmgdl@evledraar.gmail.com>
 <xmqq4k2w92xo.fsf@gitster.g>
 <CAGyf7-EU4aBO5JGfDAK+rkrjMwmDjZdCBeXBh_=z0Cqv=KnCkg@mail.gmail.com>
 <220415.86sfqebhl6.gmgdl@evledraar.gmail.com>
 <xmqqr15ye19j.fsf@gitster.g>
 <CAJDSCnOUQm-doY-xTobPk64oeiSsTd+vSFzsb_cz9BLORAxXGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5U1IPcayCQRE0T6"
Content-Disposition: inline
In-Reply-To: <CAJDSCnOUQm-doY-xTobPk64oeiSsTd+vSFzsb_cz9BLORAxXGA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--b5U1IPcayCQRE0T6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks a lot to all of you for handling this regression while I was out
of office!

On Tue, Apr 19, 2022 at 11:54:19AM +0200, Michael Heemskerk wrote:
> Apologies for the late reply. Bryan had his last day at Atlassian last
> week, so I'll take over from him on this topic.
>=20
> Thanks for asking this question, which is lot more urgent and I
> > should have asked last night before I went to bed.  Yes, Bryan
> > already said that the revert in 'seen' the previous day made their
> > system happier, but it certainly helps to know the reverts were OK
> > at the tip of 'master' without all the other random topics.
> >
>=20
> I have run all our tests on the tip of master prior to 2.36 being release=
d,
>  and on the released 2.36. Our tests are happy on both, so thanks for
>  reverting those reference-transaction changes for 2.36.
>=20
> I'd be happy to provide the fix to files_delete_refs in a patch (including
> some extra tests) on top of Patrick's
> avoid-unnecessary-hook-invocation-with-packed-refs series if and
> when that series is unreverted on 'next'.

That would be great. To be clear, do the fixes you have also fix the
pre-v2.36.0 issues Bryan has mentioned?

Please let me know whether you want to pursue this and whether you need
any further help with it.

Patrick

--b5U1IPcayCQRE0T6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmJpI34ACgkQVbJhu7ck
PpRZzg/8DPLh5EG618PzzZiS2EjjqfOZC0r2+WUc5M3U29FUsth2NpfxIMN+wQxK
kMJIpUm5cJI0CoGNvnS4ZYxMSOkTJjb9lK2M3J2GFG3udfiWYCYwDbSYcfSWqzgK
9LMBgEp7UdlXdV13HjspuCb8xvAMGHinNd7Bw2g78nC+xNTV0nxDSaDic5w0PC+d
9Exk4fFGnjn8SB63C2uFr00Tvm2HJgGlzuLZ5sd8Mwi8b0YaT269ehhoH5ew+GKP
ZdiPWLAT2XBG4ZYppI6LIUCWeRXnev1ssA4Tpe4xUqoRVUXo4G0Y8njRj2NA9qpw
L+4UGYX6kg2T26qJvx1xZpYrp9+JF86vG9pu1ZYUOsPffWiuULfet+GmtOS5wHme
9bsZBNOvEfpIqeh06/MVUpMBDH3sSXo4F6OcrJg5jHo3z2R8+E8VfPjofjdqR0FQ
m+mxtqK8UtuAG/TG2uJ9l96BZpQKRdp4LVWnYDUmZe9PBtJFHSZi4tMGHzu6E6n3
ByiGMAjiKWOXm1KtN9B4f5Lt9fv++I+TOdSKPEdHfa9XvrkEOuhwldoMengAWOFd
/Ujtwy2RO10F2c6Zt5zkkX7qrio+cxv2aM/0K/drhq/0rL7Y/5vqv/6Mpn7n6xxC
j2YOcch6xegKfLs1amLFS77Tu6D1AGfNJ7FuUJAkM2ns2aUDrS8=
=ubZD
-----END PGP SIGNATURE-----

--b5U1IPcayCQRE0T6--
