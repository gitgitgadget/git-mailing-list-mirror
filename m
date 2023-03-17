Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4872C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 09:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCQJzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCQJzL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 05:55:11 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F426906E
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 02:55:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7A4593200AF9;
        Fri, 17 Mar 2023 05:55:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 17 Mar 2023 05:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679046908; x=1679133308; bh=Oz
        aSFyXVBix0u8vtp5WCvDtwGgJc9Y73IRVACjxJC8Q=; b=mexiLu/HpvBE1+Mhxm
        1btzyBVqGiWJ5X/u9qQB5ybb5qiR51mjQc5jyxrNm2KrpDPD/XAOUqm1xXNHyWi+
        1m2Kjvom7459EFkyirYZZbzkfmVUFnVFjqQg4hZLZ+ATAP3mvIGDV7ObyQC4HsfO
        vwrqwp57si7kqNWlZ6vNPz6BohsS3HOo3IWOdFQQOjo4vnQG7aFgZEAXvYTE0BBj
        b//ZuZF4BvER+Hbh+SHsZdq1M5y76i/c8GwjFXfh48gjNe525HhHOrzs/XtfaHBh
        FJVqulg72PRKR1riXH5Wl5PdXFrIzppDbbSm9/Ch49jaqdKVY2G+PRiDFyRp5Z4h
        0KJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679046908; x=1679133308; bh=OzaSFyXVBix0u
        8vtp5WCvDtwGgJc9Y73IRVACjxJC8Q=; b=ny0l5mFn0qDkr5r7Zgd21YMAEfKH2
        odD1oJM8mMfX91FFwDRmC2j9FKRYsAMU42N3O1oHgpfNlgRgsG8C/Ik5YbL5xH1F
        uPHpxtA5um9VZqsbnTMV+OOBLrI0xOeuZ3zU8Tu+i7HfEvO+4i3UOgcNzIo5A8eq
        jrFgL8VTrVKJv07heU/yVMtGWXldVk25+qWPn6A1sPo0vQvHDXnEF4WkPXGE4vJj
        8tOLYCU7PwY06cDN1xHXRc0ssEpTjDBDkT9KTYC6CFYcUs6VGRPmhhiam2NS9+2S
        0iGG8IP9EBwm+WyF8lb1uMlWfM57ErWlOxABw/0SQfPe0jqnbiUqMUqTg==
X-ME-Sender: <xms:-zgUZC-Nx0vKvDn8BeaCkH4d3UqavcBgdwc_kfXLi-8zZrNiQ3Swew>
    <xme:-zgUZCtzGb7Ay4M2kYAfmrifZF0RVArx3tetnlt7XFX5Nj-XuRnxMsmLA08d-NuGs
    lWDqSwz6HtU3VgdGA>
X-ME-Received: <xmr:-zgUZIADUztaXGRov71JmahUK-UEbk0Y_9f_FaKsi7xiMSGI5Y9WPW6ldXxR9lFyG_uMlmWz023MteuW13LmjkwYZd6F1v7AO001Zt5HL5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_DgUZKfpYFZfoRBkRKn5ecfLPE8xAI224-dXBl0dmWpMhS6n4iH6SA>
    <xmx:_DgUZHNKZ03sS9NMLravOcSP5cnvASGpkoQ7waq8w-CCdGPrfOIvnQ>
    <xmx:_DgUZEmhyJ46XDJyrunB7OW8HGuHd0GO4b-fOZ6tB2aQsWNVwuWwAA>
    <xmx:_DgUZJUQrV65dGurBREVT9TwLEvWSNe7a_1Uir8gpTQr4kqJ3b75Lg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 05:55:07 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 690f1c87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 17 Mar 2023 09:54:40 +0000 (UTC)
Date:   Fri, 17 Mar 2023 10:55:05 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/8] fetch: fix inconsistent summary width for pruned and
 updated refs
Message-ID: <ZBQ4+f/YU0r6ntfb@ncase>
References: <cover.1678878623.git.ps@pks.im>
 <f67f9640a853b605dd1bc4be25e9988c4f059684.1678878623.git.ps@pks.im>
 <xmqqttylmww4.fsf@gitster.g>
 <ZBMwhLgGeUhtd5Zb@ncase>
 <xmqqh6ukmzex.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/FCINQTM/5257UQp"
Content-Disposition: inline
In-Reply-To: <xmqqh6ukmzex.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/FCINQTM/5257UQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2023 at 09:30:46AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Practically speaking we could go even further than the current version,
> > as I now compute the width across _all_ reference updates, even those
> > which are deletions. But theoretically speaking, we could just skip over
> > any deletions completely as they won't ever contribute to the column
> > width anyway.
>=20
> OK.  It's good to see that you have thought it through.
>=20
> > Fair, having a test for this would be great. But what kept me from
> > adding one here is that the column width depends on the length of the
> > longest shared prefix of two object IDs that are about to be updated.
>=20
> You do not have to prepare "this is the correct expected output",
> when you need to make sure that two kinds of lines use the same
> width settings, no?  Extract such lines from the two camps, measure
> them and see if they are of the same length, or something?

Well, comparing widths of these two lines is the easy version of the
test, agreed. But in order to test for the bug I'm fixing I'd need to
generate two sets of object IDs, where the first set of object IDs has a
longer shared prefix length than the second. Because otherwise, the bug
wouldn't be guaranteed to even surface.

Anyway -- I'll have a look at adding the easy version.

Patrick

--/FCINQTM/5257UQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQUOPgACgkQVbJhu7ck
PpR3IA/5Ae9LZutX1ja14lKlPSPGMz7Y+9pZzrVR53IrTPONdUSv1/LTJotTvinP
5LG577NPfYtGTBUjz6XvR/tMrxaFx99eV2WpSrgDQwxxiGaV484caeBGsOIoTYxW
e/g9L+N830fgwqx6Sy4pkEBm5ihmK8K69nePDXKhxiQ/IO03/Lok8kZ+hcFW7ltk
ISTgXufYoqGIv7voRlxRVmrqyUwwo4Mk8LyZnB9q11E3OmO7uIO8EzYUtiJfq3oZ
qaOGWu7tmXyHA69mFaudXaikGt7FTRVRGLt4SQgf1PKFFqkxemXsIpGYez8e9kQq
cKIytdct/+cnUFBz+bDrGvYPNcTktjV7XzXmvaJ20mlwY9tNTUAXTtq1dC43zrS8
8FTwKHH+7MLxIaFBZocM60zApg+/Nolg8lLp9aWFwu4+P1ylgeAPXf/F6CEqnCxE
9ucnzy5HhuYzkJMP4BSNfUGkW+IbFtgdidA39WaLVWG8G7Rb13btLa7TRlKHggNZ
vFPP6u2V39347Gwf6liw7zTCZd9xAF+RDNPPk10YxDOOZDS4rGAmtSU6uo96/jdb
LGxLLPOXVNGgPlcW8mTgUSOBQQsDSmSxyyfagH3nWxzxcm1Q7zF185VnGpesndmM
rLNn5UJbyzy6KRuBUgOI27ih7b3Z16BKE19E83iZpvT9AEK+7P8=
=3TGF
-----END PGP SIGNATURE-----

--/FCINQTM/5257UQp--
