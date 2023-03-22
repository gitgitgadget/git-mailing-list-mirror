Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53791C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 09:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjCVJEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVJET (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 05:04:19 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C2E10A85
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:04:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7B4073200903;
        Wed, 22 Mar 2023 05:04:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 22 Mar 2023 05:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679475855; x=1679562255; bh=OQ
        iX/uYyDbXCrFgmbG9wPKtohUldfvpI4I9ahKkrwew=; b=vkfOPBeMryKXaoYTUL
        qAFgzIB18aojcSeHWD3kfNts13ozQ3oUJD3swEsRtr7p9l9opv8WmUKMXwfhmwcO
        rhtdzq1UkhLhbPucw1IteQnkO/aoq1bg9SFzfCaXPoRLMDjNbrlhNU2V35EZYOZM
        ZOIA8JKZ93sVv18CSPBh/ZOrcRMHvKqY+0xgyW/vLCgMZUnTtLs5oJYIHZEdb4/O
        5HqxuKXeUiJGeGjPTqMAG0DO7tWw2Q7mTLemYAGH1sxHVelOZBp+PIps85/CELJy
        4muG2hSd1pNEX8TLVtSBzcsgQvprSJqWvm8NvtHh7eeH248zSL9a/vx6dLzMgo/l
        T1zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679475855; x=1679562255; bh=OQiX/uYyDbXCr
        FgmbG9wPKtohUldfvpI4I9ahKkrwew=; b=uIdpcTeDLF/bh4tyI8BW67VSCzl2z
        l4G9f3Wu9beDxZQcxbYKP/JIElgXMb4D2HNRltTAdpF8Qus/nuBqnyBpvxa4et7K
        q4ptmwoDnSr8FqxyRE2KdLL9RSKwwt0QgVmVxmZzeOXwm60UGsKnkklhp+RqqpP2
        iXYtrVvDuEgK4cNKsM4m8W9RhrkN26EyPix5dkrDqzR/kaX7zQVjjezJxEbrmRmF
        6mT+yatH1jqoEBgBbTi9VtL1uBLsUmmgtsgmPqiWS/t1qy7l3U3hVSrxfl4gDvb6
        b7CyjvQfzb7j3bBVE1LN8+vv7trP0710CdWtkSG3LrpVyf29qi9XBx0sw==
X-ME-Sender: <xms:jsQaZE_hoSqCQRBbh7fVo4JgbR87xnMUDZxb88OxJ8XTU0OaAc770g>
    <xme:jsQaZMsEJBaaWJbS2aLkrwllTMmhjDfJOa7PsUIR46NiWndLf8fR6qNICYOiJeJeC
    5cGAq98HE0OXrZ-GA>
X-ME-Received: <xmr:jsQaZKDEKDZZtPBXRiKGfPH6184ZKs4Hq8av3yACyjtYlSQu0rqLWWNbz6BThVOL0ck2LsVJ4TlJ3cd93IW0XFY_1TSQPq-gC_ZobxU_Epgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeguddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jsQaZEfkZvi0G4egtPjI6B-VzbTIr0Kvy85G3Di5GPqTyRVdnv0opw>
    <xmx:jsQaZJPAnnQSzA-a90dO2mfANv85s2Zq5FaqsEAtyD4QP495QbgqDw>
    <xmx:jsQaZOmsBsuy-DMjQrgy3vaSgZPVYxkEpPCRbPLvfbgBVWz2lRnGQg>
    <xmx:j8QaZH2RpR_eQ9nlUaNFxxLtfigK2Gtl8gZbTPhJEQFYbC9M16fPug>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Mar 2023 05:04:13 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id d779a1ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 22 Mar 2023 09:03:35 +0000 (UTC)
Date:   Wed, 22 Mar 2023 10:04:08 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] fetch: centralize printing of reference updates
Message-ID: <ZBrEiKnbaq5N9DOl@ncase>
References: <fe7e2e85eb37cd4068b5160721663c21a16a8138.1679315383.git.ps@pks.im>
 <20230320225702.1471172-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8aUwU7W6bmssVIOs"
Content-Disposition: inline
In-Reply-To: <20230320225702.1471172-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8aUwU7W6bmssVIOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 03:57:02PM -0700, Jonathan Tan wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > In order to print updated references during a fetch, the two different
> > call sites that do this will first call `format_display()` followed by a
> > call to `fputs()`. This is needlessly roundabout now that we have the
> > `display_state` structure that encapsulates all of the printing logic
> > for references.
> >=20
> > Move displaying the reference updates into `format_display()` and rename
> > it to `display_ref_update()` to better match its new purpose, which
> > finalizes the conversion to make both the formatting and printing logic
> > of reference updates self-contained. This will make it easier to add new
> > output formats and printing to a different file descriptor than stderr.
>=20
> Thanks. Patches 1-5 look good to me. As for this patch, I'm still not
> convinced (I thought that the new mode would still print to stderr),

The reason why I decided against printing to stderr is that it's already
used by other things. The progress meter is one of these, runtime errors
are another one. I also think it's weird to have a parseable format that
should be parsed via stderr.

Anyway, let's discuss this once I'm posting the second patch series to
the mailing list.

> but
> if other reviewers are OK with it then that's fine. Alternatively, patch
> 6 could go with the next set of patches that implement the new mode of
> printing ref updates.

I'd be fine either way. Thanks for your review!

Patrick

--8aUwU7W6bmssVIOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQaxIcACgkQVbJhu7ck
PpSwCA//WSfN4alOy3LoH0naT4kkpsNYl5duTPUFoZ8SJWM6PfTTbQuIhZbIx1Oq
UEkdK0ImBoczfAz7d48HLHj5v7btCxNZeEOmVFPBISny2TunQ78F4v9Qa13CEAcR
lr/IQdxez/14xSgPVcnfoEoX57VKXglKOWMltPewZcUVAPKF6VJjbrFtHTHqmsBx
40e+A6re1rLotXCEjvDCn+7nTtk+zSalr2ztbuRhpCBLTgI0aHbFUD+SPgLXVL9u
CQnBI6DP3pyrAED/lnNWAXB6boWSSFDuqSP5+IYo1gputqPMYYKnkdAdPm+BsXHr
HnGl09e30zOnR55dKY5h/LmGN0nVlhM/7YfRL53qWhYkZ4JO4V1RowI5L9rucDLv
5GavGKh6JAD9NSvimHiRuSuYQC60I1zCs+ce6+an491KRR2OYS1187qV60sKYAlO
BICzyN40TxKgsVaPgSw4gR9zn6E3OgtWq1g11WMkUyVPXEPzTe/hsKXDxEuuDYCV
YoCG/ie9eLfRr4xHOo6fi3lnBZ5CTbuIO9LK0MLuNuROUa7tuz7hzgd/P6SCxRBO
sF01YizTsJNql9x9NuUFPOIhjdxh1B11+/K6DyTM1lzB6q+NN7/tcGRi3gCB/pxd
NCwbFZ1BlW6rAstUHGhj0KyjyRtgRauJ/4GPxtyo/z5BGTh2FyE=
=K9If
-----END PGP SIGNATURE-----

--8aUwU7W6bmssVIOs--
