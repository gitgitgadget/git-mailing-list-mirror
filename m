Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6EFC433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 04:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A665520708
	for <git@archiver.kernel.org>; Tue, 19 May 2020 04:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=iskunk.org header.i=@iskunk.org header.b="PydRljfU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0RzNmhXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgESE06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 00:26:58 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49387 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726153AbgESE06 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 May 2020 00:26:58 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9A89EB58;
        Tue, 19 May 2020 00:26:57 -0400 (EDT)
Received: from imap36 ([10.202.2.86])
  by compute7.internal (MEProxy); Tue, 19 May 2020 00:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iskunk.org; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=nD/PA
        vs1VntE1L5XelqR56WOhuayLpJMGvRodNb34d0=; b=PydRljfUz14i3CVfeIanP
        VVP9iNtQ+fjJ16aUl9eXHPV0teboT7+Ld2N2WdEpRYFmJHClevwGAhsEfcwmzVnv
        +TFxxHbi1GVRMANxsIFDdaPlyyr0B9xdxvDqpjHWHe0Cnmtw3hQlXMpNfmvTNzAm
        R20ma8Px5N66CfD2ScIl0XaXVI8Rn0/uM6BnlWRPhCanDn+cDVurdSu4w8dh1KsM
        FYVRJvbLoOU+wzuR46pELO4D4roSIwEVJcD6v7xvGvPEQH3J5XNn5zSboCN4q4XA
        aSP1zb/RmrvHUi/JoR397lwmKjNY7+CUGXX4xPD3kMiQTO50+JOtXIVJlsDhaFGH
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=nD/PAvs1VntE1L5XelqR56WOhuayLpJMGvRodNb34
        d0=; b=0RzNmhXDN3mui4KBnlnBMW0IHrvNwYeQjcNKR4CSFrXLEZv646e0sZwsW
        yRH9ggsLlEgRJs/2hqhfwdYCsk44KGdARwsixgolF9qLRN337ghLfoMVWSQWzpWb
        2hze0+gl5iuY2ojHcosj47WsfU3Mta7yq91u3Iqr9MOW5noMXimIh6XZDeb9Yywf
        vSLGGNNgYZCaVJpEE/Ufii9TfmpSAVYWX54xy2xWOCAjQfEt6pVHvYhtvjZFrAyh
        EKM9UtHvAtcDnTIJBfoibcDe8xN5Pyxe+SH51wgD4X7GAGb/tGwfg4hsW1Jr7asi
        TMRo3DnbMQ716YSl+sS7+Lwyr5T2w==
X-ME-Sender: <xms:EWDDXok94D_bPDJa7zMAahP8mkkaFUkw8YXmM3DIe6fjv7omg-ZSww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtiedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfffgr
    nhhivghlucftihgthhgrrhguucfirddfuceoshhkuhhnkhesihfumfgfpffmrdfqtffiqe
    enucggtffrrghtthgvrhhnpeelleejhfefgfetkeelhfegffejgfegkeegjeetueeufffg
    ueeiieduieefieeukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehskhhunhhksehiuffmfgfpmfdrqfftif
X-ME-Proxy: <xmx:EWDDXn1lBXr8HMPKBpGVVdl_qEGoI2OjXho7Jx7-eDCpk86ycWAtcQ>
    <xmx:EWDDXmrcFrqs958--llWxIRRwCGaCsTnTZML1V5PS-mb3qTpewqyvA>
    <xmx:EWDDXkmBXigMNRW5u8Isf4NQD2wKxKWyaXg7BfkpYJAn4gBKua_cVw>
    <xmx:EWDDXnBwPQqeSlc-agOvGrNKh4koQLcw_YqDEnFMJWz3NB8sACtgyw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E55B41880067; Tue, 19 May 2020 00:26:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-464-g810d66a-fmstable-20200518v1
Mime-Version: 1.0
Message-Id: <bbaacb8f-e2d3-4c4a-98d7-acea0b637081@www.fastmail.com>
In-Reply-To: <20200519030440.GB20332@Carlos-MBP>
References: <7422404e-7fc8-4961-aae4-3f0adb71bb3a@www.fastmail.com>
 <20200519030440.GB20332@Carlos-MBP>
Date:   Tue, 19 May 2020 00:26:02 -0400
From:   "Daniel Richard G." <skunk@iSKUNK.ORG>
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Minor portability issues + fixes
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Mon, 2020 May 18 23:04-04:00, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> On Mon, May 18, 2020 at 09:15:58PM -0400, Daniel Richard G. wrote:
> >=20
> > I am building Git 2.26.2 on AIX. A few compilation errors arose, but=

> > they are resolvable with a few minor changes that will improve overa=
ll
> > portability.
>=20
> which version of AIX is this?

4.3, believe it or not :-]  This system is used for compatibility
testing of a legacy product.

> we include inttypes.h which is supposed to include stdint.h per POSIX[=
1]
>=20
> could you take a look at that header and see if there is some macro de=
finition
> preventing that to happen?

There's no #include at all, and stdint.h is not present under
/usr/include/. But I am building with GCC 4.7 (as the original
vendor compiler has outlived its usefulness), and that provides a
modern stdint.h.

The original inttypes.h is fixincluded by GCC, but this did not add the
stdint.h #include.

As I remarked to Jeff, would it be kosher to #include both inttypes.h
and stdint.h if both are present? It seems that most of the time, the
latter would be a no-op.


--Daniel


--=20
Daniel Richard G. || skunk@iSKUNK.ORG
My ASCII-art .sig got a bad case of Times New Roman.
