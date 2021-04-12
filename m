Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F03AC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4572C6134F
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbhDLNPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:15:46 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51013 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238989AbhDLNPk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 09:15:40 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 451B5CB3;
        Mon, 12 Apr 2021 09:15:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 12 Apr 2021 09:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=rh7eTdF6ICVcF3/QHH4KzdqJ4Wn
        5F1HaykFK4K28mFk=; b=F+VMh+EN1L0MBvL8sn3qB/aM5CBJ8RzT8H4NKpfdsVw
        LxgNt90Nv0YN2r9Hzim6ho/TP/uG/QrPoPdP9dvUkVLvPaxsl5DvDAuMLi0LMtGw
        S1jhpuQF3uQ+sEyeYnXkcG1EH0uRM5KZ/8g9hOsTJDOTaW6D/GQ+1TQbZfWVMOWG
        kYj6eUBmDD/lDB/C1jlBzbVHvs7i/dhDC/ASulBgFI1IAm5XFqOathresXNsMwWP
        vC9yyt0Wq2gc/1tyPPPJPDg1gcZsdi6I8m30VT75jpWW8mhmbGP2PzbNkrVrFVRi
        ee1H6Zuyji7wCTABD6O+y1HVfsismmBfjObRwFtGjHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rh7eTd
        F6ICVcF3/QHH4KzdqJ4Wn5F1HaykFK4K28mFk=; b=Mo74QTUlCbMdS3b4uoOpbA
        bMCHIV/XHIt1Gjby0ZNg54RbmuOFaYNT1TnzjNraD+DqTGxsb1IBPsfM5ipL0eF4
        s7hIUEPjONmmu8nxDoW3jPBTqFeTek899Zy1/QOdes7IR51Plqnb/NZefl6LdFtQ
        K2cmOu6OIutBvWw2P0ta+yi9LQWGGMz90iiXl6WU1JR6MWFyEdofR65yjBWx3wBZ
        NFsXnLpBtXKDpYCDclRGRUGmQb/mnSO2fFlVlxsWZ3zi1cl9FVo1HFrEXm6D79FI
        NOb+8Nc3XoI91/2I32amfS2p/KZFS9nHSW6NN72avTjzZaAKuzKoAgHj9k8F0T/w
        ==
X-ME-Sender: <xms:6Ud0YDeW70NyIjGZiSmB3tm9B0QMWSGLUzmjZzzH5KlRoIpHPA3Q7A>
    <xme:6Ud0YJN7oqKXUcqehA4xZq14XjWIQ4uc2qAX9bAD00EK5vd0LNUs_Bqz1bHj1PaVf
    Cw3RwdRWZHpXAu2GA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:6Ud0YMgHGZewxns6oWCVtpB2828r7QLgpzu7HSiXYed8aomvwjGQjQ>
    <xmx:6Ud0YE9s6bM-iIN-YGa2zlvGn1WQylV-v0iT6_Sit6fhy0wwkDddZg>
    <xmx:6Ud0YPvbyehldcQmv6T7eYNeaUNycPxPCfZG4yvXP0Ja0qsxJd0wfw>
    <xmx:6Ud0YI5NuM7Sp1lOU_D20C1pYNHz0T4t_diKA0djPOa4RTkPqMfxWw>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 667C71080063;
        Mon, 12 Apr 2021 09:15:20 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 35ca815e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 13:15:19 +0000 (UTC)
Date:   Mon, 12 Apr 2021 15:15:18 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 8/8] rev-list: allow filtering of provided items
Message-ID: <YHRH5so2onO5cfwy@ncase>
References: <cover.1615813673.git.ps@pks.im>
 <cover.1617967252.git.ps@pks.im>
 <796606f32b3ffc286a3157312d00ee0ee3e5600c.1617967252.git.ps@pks.im>
 <8788dbca-3caf-e9d6-7995-b09e276d1609@iee.email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YfFP0Wq9tVf4sBnh"
Content-Disposition: inline
In-Reply-To: <8788dbca-3caf-e9d6-7995-b09e276d1609@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YfFP0Wq9tVf4sBnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 09, 2021 at 04:00:26PM +0100, Philip Oakley wrote:
> typo nit.
> On 09/04/2021 12:28, Patrick Steinhardt wrote:
> > When providing an object filter, it is currently impossible to also
> > filter provided items. E.g. when executing `git rev-list HEAD` , the
> > commit this reference points to will be treated as user-provided and is
> > thus excluded from the filtering mechanism. This makes it harder than
> > necessary to properly use the new `--filter=3Dobject:type` filter given
> > that even if the user wants to only see blobs, he'll still see commits
> > of provided references.
> >
> > Improve this by introducing a new `--filter-provided` option to the
> s/--filter-provided/--filter-provided-revisions/
>=20
> Also in some tests - I presume the option should be spelled out in full.

Right. I did fix these in the resend because I forgot to stage changes,
but still had it in the commit message.

Fixed now, thanks!

Patrick

--YfFP0Wq9tVf4sBnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0R+UACgkQVbJhu7ck
PpRKkw//SiL4GpwW8F7p3yksFPLRmn6W1SxyxkKdSpHswRwHI8HN5BE9f/bh19UA
DZvR/blyiLGTM7rUhS2y9OIRjTkrXLwESmj79yJisU2FlWhyCmBkgp01nUE/Uggt
6E6AgcklH77yjZYumXQKqsy4RuEDm7YGSLGN14jgSvNPQHZ/clc/wdD1yzRvpzJ9
yXv1JZcTcRtEvFvQWWfdzfxmNxXOP3wfXkgqHWt/7jFuuhYwA4M9HfP+WC+fFJHP
K8MI+dD1/Iwej/xZb5+hhfTRX4As3DWy/SPOYc9h7Lw4nCob0CkpWFNV3NM5uWKe
IAzr+XTKSkG7I26wiUvYw+FU/I1Eq781A8EiB7ihFG0aPuYlpRzCdLxTFIG2sLGI
NWgqREl0pum/yl6EKra+00FjHXUAkfX/h6hkxoPvEgsLxLbBIYD6LWJIcL4tz1SZ
OE+XWwuQigG03qxBHatqXL+nB/LmZ2BqiZXO3Gu5Z1Lv0f5YyZe5wVUAHQpZBtDC
4qkKiDL+mtrkyU/l6rpIcePwcr2RbON+aIhl3VBNze2a2OCwnZX2e8jD8gQ3Cb/u
L2l786m5Ec5Fx8QNFJHU4wOtPAGAZ3EdTlIyFG7PPwjH3piCMDeg/7JYZBEzdODJ
t5pWxrq0DpzG9g3uZNudGqzNwSgUWjGB7169ayjf/BB/bkiJILQ=
=MxlP
-----END PGP SIGNATURE-----

--YfFP0Wq9tVf4sBnh--
