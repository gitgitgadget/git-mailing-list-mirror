Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6E4C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 09:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCQJvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCQJvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 05:51:32 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FD59E66A
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 02:51:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5EF9E3200A70;
        Fri, 17 Mar 2023 05:51:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 17 Mar 2023 05:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679046672; x=1679133072; bh=fU
        hE45KV/9dG1KED+1nKhFBvZYHT5SNjY/W0Rdunj/0=; b=DjyYNm51EIMX3E20uJ
        /d6Jo437v1l4MvvVWSV/w2ZIm9FTmz7GjZKiPHPUq01uARi4CrKYn3+VQUlqSCdj
        yPvclNPM8p1YgxwQhdu/Vg/pnnuAygds2713JKPEmr0rmxsasJcmz7nl9zyEJqXV
        w94o5nyuNLIKzbYgtBvM5i4vxnNz8Y8RFHBDnHukwpy1XH+PUq0441qSlcu1jLSs
        +PzGrmw0Rpt8WogwtxJPHM5vya+LQl090IBv31Ay2p0l+U+CePQte1UDYPI/JboZ
        jvblYzLACs0/biDzL7tane2trTHIX+6OTLVnAG9cFxEbJFZcB9PvxOui3J45ZOJg
        AvXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679046672; x=1679133072; bh=fUhE45KV/9dG1
        KED+1nKhFBvZYHT5SNjY/W0Rdunj/0=; b=S5P3hY+g9ZwNsiqH+wbT0BgkCaBPA
        ShaHBrSjLax0V7lxd9hIAybR2Xxup0VQHrOMTs/FoUxWHf1sMHN84+fuyX48T+6/
        ne84BtA3DhGEBMd+DfxOtQWL8QOyQMVAEJgbgT50U4NndsGv2hEN49ODcs1+z3uW
        00W5XH1v1Euu9porhAr9/2/TOOjLC5L0E1SAm2oRDBYXt80ityusOIRb5SDXoqAv
        d8b4w7RC3msBElEGpeavk0rbPffZSVmk1fd/Ua6qjnoNpLv503IHKFomPiqtbePd
        rpKOlhq8+qjxLnOKwfF5PKKeWU+8EvyRWCzyn2F2I8IXRbEySqHbIRQXQ==
X-ME-Sender: <xms:EDgUZEnDj_MULkLicNjlftoNHZs491lwBcNNPh5sJUyh2I5aXLKWSA>
    <xme:EDgUZD3Y63qQ1dBIA3ecXIV1LyXhZxKIpYlfh_t6VbNhsY4aVxsFZBIYmxyVderkp
    KD69ziYUSTkpdQPbg>
X-ME-Received: <xmr:EDgUZCo4TnAQar7bhlKQDAtwBtp3OQ4PTmCK5jjKaT7s4D_GhWWEZNbBsiww86eOsNMuyrTx4Bc6lsRIdUEraawtYNnf7_9R1MBUX67o4YE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:EDgUZAkSX4__KwTdfzJzdSOIgAQsGdjHRM9kqTliUTQtSAZTLBeLFw>
    <xmx:EDgUZC2IPiCqwTCQj2jPBqtgApFct69orvCWuGWt213m1zzo7dNv2g>
    <xmx:EDgUZHsFW_mRueGpHL5l_XMsm-AYfvzLGaiQZiif9fdxy8Tef7X4OQ>
    <xmx:EDgUZH9wVmtBJOZNNxK7jhAIfdrbww5QgMgAbuHMsS4-Ed5hayiZKg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 05:51:11 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 7191079f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 17 Mar 2023 09:50:41 +0000 (UTC)
Date:   Fri, 17 Mar 2023 10:51:06 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] fetch: deduplicate handling of per-reference format
Message-ID: <ZBQ4Cqkq9v2cB77f@ncase>
References: <cover.1678878623.git.ps@pks.im>
 <d45ec31eeaf42ee042bad04efd69668144df3138.1678878623.git.ps@pks.im>
 <xmqq4jqlocqf.fsf@gitster.g>
 <ZBMwXAnEnD5QjsFE@ncase>
 <xmqqv8j0ljxd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b6EwIQPrH2MIrbja"
Content-Disposition: inline
In-Reply-To: <xmqqv8j0ljxd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--b6EwIQPrH2MIrbja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2023 at 09:50:38AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> So, I dunno.  The result of applying this patch leaves it in an
> >> in-between state, where the division of labor between the caller and
> >> the callee smells somewhat iffy.
> >>=20
> >> Thanks.
> >
> > I totally agree with you here. From my point of view this "division of
> > labor" is getting fixed in the final patch that then also moves the
> > printing logic into `format_display()`.
>=20
> Yes, again I smell the same "isn't this series going a bit too
> roundabout route to its goal?" which I expressed in my response to
> an earlier step.  The endgame of the series, even though I may not
> agree with it 100%, is self consistent and does not leave the "this
> ends at an in-between state" aftertaste in my mouth.
>=20
> Thanks.

Yeah. I did have some problems to lay out this series in a sensible way.
In an earlier iteration I tried moving the printing logic in one of the
initial patches, but from my point of view that resulted in an even more
awkward in-between state where the formatting and printing logic was
kind of all over the place. And another try with "big-bang-refactoring"
was barely reviewable, either.

Maybe the solution is to keep the order, but document intent better in
each of the patches leading towards the unified printing logic.

Patrick

--b6EwIQPrH2MIrbja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQUOAkACgkQVbJhu7ck
PpToCQ//emY3rVeY2Qiltu4EA8RBapt81syjLOw5IzR3oX9i1+bMS+kApRjHBOk9
CA4s+iE3vLJO+H97ZXjBHYo5q7iioTHqdSgrT55JgQKHOlKBtAXrkrhqlwUx/RtD
GgsHYOzIXYqmghN0aFrUVRyjryc/kbRKF8ZdFXSFpVCQMdv0w8YSk3VMerCnXZaq
JCxFT7MLrNp3pETw068vqhjtZzCRuq00L85O0ZPJucOKGvLnI3JMhcI2LYA1dFtC
aEGUZLfui4HGZAyiQyelZzkeJfFIBhZcx40We9uxjMj7ZpePXA2IwB/rm9u5dmfJ
tTjwE22EEOvLnWzg80LDEFOX+P8OBb3vgUJpQI7V4ojXhjrjH7LfkDkoDzp7eT9Z
qk0cqndnW4W+Ijtzg3XGYIRCOEH8Gxki+8ikd4E9zKSm+3HXPY3Qo+TmeF8s1zf5
mPSRwWQDPwtYPOMqKQrH26EDLYeyuoKZWH3S+pPs3qX8z1Q5Jfmm/QL3Va9Kj1IL
zXY1Vj8gZp44j1F6Z4zrhe3pWYzzYVGMGmyx9b7v1AYbipmxxxt8wlMzAEBHYbLA
KLhoG47t0jfQ8j7w97OVm4n5eOIiIKSxZlFc0rFMPRKuW3ZzTNgY/PFMZcgjSrX0
Z/TSvSkiITMPkATcYeHyjC/dfSADuTm0ExoPBfiFTB+WQTRaat4=
=b+9j
-----END PGP SIGNATURE-----

--b6EwIQPrH2MIrbja--
