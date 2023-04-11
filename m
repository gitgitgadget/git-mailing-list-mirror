Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13769C77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 17:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDKRHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDKRG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 13:06:59 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F08FE50
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 10:06:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C46A73200033;
        Tue, 11 Apr 2023 13:06:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 11 Apr 2023 13:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681232815; x=1681319215; bh=jg
        Z4/4AagW35MrTOZu98ZKevxDsgnAxabn5905cYaGY=; b=io+D4R2Lbi1mi2RQOZ
        ncBvSITnDO3Uhz4HKE2RUh4CGA+tXTQU1kYncHaQb1jKhWC4mmsRIC3F5KVUYyQZ
        rdyVQ3c6KEuFPmnDBGV1Hm3xdCXmcfk7KeVaBZ/eNtWI/PMJtnlMbgUWDTN6tyot
        5f3jg66llgXyBDxUzXVE+fWygO69uOXai3y+36WpZ0r0H3s9z47yi/D36PSf/2X7
        /Mu2WBhK/N7lmj/lO1tSI8aSmWEENzAzWz70KwXRV6m48ZAKRhfOuhPEJBoIz1No
        zkY8Jiy397smn8TnuMP7QIID56eZdL7rQJJ1qcyM9eG68YGfkEJvC74bYAtZizUt
        A4Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681232815; x=1681319215; bh=jgZ4/4AagW35M
        rTOZu98ZKevxDsgnAxabn5905cYaGY=; b=c1toB3Jwkaq9TGh9r5UbpFhia+Ki9
        yTI/XOYN3Xdjloah3XFzrmpekrYldKcXa/3nBEySzG7bPd2zFaBQepZ0d3dXjHtW
        LE11RllGZE8q8Jbi36I//tF15Gjcpf/zuUB1GucPiYYLvD38r9qO019sdMaBiq34
        mLKohQLq1CEwY83NatC1u3rzmKtOTF7TbAXfaNQH2CuBKP3puvlSahDBAVEvI8yB
        LrTG0PUwccnYBVzjOMuDWqRkKHWLR697tTsnltbC6sVJIbzHOpVEInNNvvI6EyEb
        KJlGeD/0D0Ze3P2QMiWqheeP4ewgvSSMAqMCd1hij86+PWNlS3D4xNYNg==
X-ME-Sender: <xms:rpM1ZNFb2mYK5znAeoBijim1ntPhnFecl8bWYJwkL0KzFQNOCeUNNw>
    <xme:rpM1ZCX6GCQSB8xAVkvAXp10oA_1E2G2q-DWEZhELFBvfl06zfoJhu3ky5DawYinI
    76fCoVnzC1gtkBS_g>
X-ME-Received: <xmr:rpM1ZPIX3HZ8eZ01a12iI4PM7Jobz8GvUJ1l0CcxmKPjjhGG2QUZnEKY2BKW4AHj35oRfpGJviPLDmXQAV11To9MPartBGWNAxj7s-LW_eciMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:rpM1ZDEKNY3IG3FVPZ-G7P4SRsAIj4o_GmDKPvtYd0Asijiwr2Gf2Q>
    <xmx:rpM1ZDUhLeb-82_m_z1i4p-8PpjRKd5YcKF5goGJMgoJKwAF_nkWmQ>
    <xmx:rpM1ZONdz6B4nmHIBpXixnuUboD3NzwYpV1Xg1enGj6PFMEXlr4GPg>
    <xmx:r5M1ZOR8gvoC0F1G7ifp7jIyIlRDwfA2IP72H_R-elAoi_52mHokkQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 13:06:53 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 43c3a481 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 11 Apr 2023 17:06:31 +0000 (UTC)
Date:   Tue, 11 Apr 2023 19:06:47 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH] repack: fix geometric repacking with gitalternates
Message-ID: <ZDWTp2RfFTbiE9I9@ncase>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <ZCxytq1esQWvjIz/@nand.local>
 <ZC0eY8q6ushpfkrQ@ncase>
 <4c7b95e1-9d3c-e253-98ca-ac6c201babb3@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jN3mB3W4JPnPilmV"
Content-Disposition: inline
In-Reply-To: <4c7b95e1-9d3c-e253-98ca-ac6c201babb3@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jN3mB3W4JPnPilmV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2023 at 11:06:49AM -0400, Derrick Stolee wrote:
> On 4/5/2023 3:08 AM, Patrick Steinhardt wrote:
> > On Tue, Apr 04, 2023 at 02:55:50PM -0400, Taylor Blau wrote:
> >> On Tue, Apr 04, 2023 at 01:08:33PM +0200, Patrick Steinhardt wrote:
[snip]
> > I'd personally be fine to start honoring the `po_args.local` flag so
> > that we skip over any non-local packfiles there while ignoring the
> > larger problem of non-local geometric repacks breaking in certain
> > scenarios. It would at least improve the status quo as users now have a
> > way out in case they ever happen to hit that error. And it allows us to
> > use geometric repacks in alternated repositories. But are we okay with
> > punting on the larger issue for the time being?
>=20
> I think the real bug is isolated in write_midx_included_packs() in how
> it may specify packs that the multi-pack-index cannot track. It should
> be worth the time exploring if there is an easy fix there, and then the
> po_args.local version can be used as a backup/performance tweak on top
> of that.

The problems are quite multi-faceted, but taken on their own most of the
problems actually seem quite easy to fix. I've got a local patch series
that addresses almost all of the pain points I have found until now:

- A segfault in git-multi-pack-index(1) when passed no packfiles and a
  preferred packfile that it cannot find.

- The issue that git-repack(1) asks git-multi-pack-index(1) to write an
  MIDX with packs that it cannot actually track because they are not
  local.

- An issue with git-pack-objects(1) that keeps it from packing objects
  that are non-local due to the way `--stdin-packs` is only referring to
  the packfile basenames.

- The fact that we don't honor `-l` when doing geometric repacking.

I'm still busy polishing it and finding testcases for each of these to
demonstrate the actual bugs, but will send out the series later this
week.

Patrick

--jN3mB3W4JPnPilmV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ1k6YACgkQVbJhu7ck
PpQ1Mg/+IDr0EOE18esmSnrkZJdkd6piUiitKqWPBQopeTuUUYDlkuRxH10Z1hQX
Ei7mq/FML3INBXXKvPdDY2gNdq+1ZedgZMyaffEVczOJTWqMm4mRrYv2rwVdN/Az
WspeNJ3txqZCda2DM6WolCmkNIoUVSmUOMVTkR4BPcW3Uy71cc3jq8OaOo0Pxj/r
PMyMPhWBlIZ76imckTr1VwLkXjPFAdRpSWGO56rN09gFCUGrsUqaGVQkR74ZfAgQ
j2SYZ8f+qwJt9ygBf7w5lEXN/CkGoQ+OQ4XGhXiiQBCe6aD6thw0HEZ0GS4V6v5z
m5kfvMe3UyRpe9IeGVoviTsRiX9B+kHpChPSlS14Uo+4SqJBRphfYVZqOLC7t/Oo
li2zHuRDVCGl6t3+nDTJqVj7k1UIClBwCZHkJcNJT415XNGo0j99SA0L4KHp+W1E
4QoDMIBHgAJ5bAiHYzkBK3Cb8P8YxbrZk/USTNQyXChsDxu6MuqP9YBpZsF++2oS
XAukP/R3IVOKQ97Fu1g/NZNQgKi3QioKU2JgiHtvbv72hW0roWB5kdBuGMw0xyBR
m4u8j5tksNuHNQiyW2f2ogC+hFDxK6jhYzkdqruRUD2Y6JLBTbunRmVtdCZZxU2W
Fu7iTbZh2KpImD7ycvNdINle4YIgChttq4vT/Dzas7r8dywOdcc=
=bLQb
-----END PGP SIGNATURE-----

--jN3mB3W4JPnPilmV--
