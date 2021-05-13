Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F26C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 14:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68708613BC
	for <git@archiver.kernel.org>; Thu, 13 May 2021 14:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhEMOoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 10:44:02 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38655 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234656AbhEMOnv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 10:43:51 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 501552879;
        Thu, 13 May 2021 10:42:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 13 May 2021 10:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:content-transfer-encoding
        :in-reply-to; s=fm3; bh=8f3dw9IKQZbFwq2buvHYAr47wI2hN6El/u7XdCb3
        Zkg=; b=J0k9n/+iugRLYLNG1narWwRo2gkxKwR8X1COTnPsCGnetwrFTlqAT6KH
        a2kAhe2SkisHetansiz3/Neh8zTcT7yiDFBeHtSzLmGvCZewlTVMuBf5iHy2lpE9
        5npKbYdPQI83io/inKMqTCAiKXoznwk4PA9eyV4tcVoyV/sCqoCq8IZBMqCiL7ri
        OiONnpcNBhXFx7u6FfG+5ayqN/OsygtnuPZheg4KJPbzALxEKTosp02lC6FA6g0s
        VSugklxLV1ho18D6BKqweTu5Gfxomd0zDJmw09XpYmlC2xIzV2NUrPJgtyzW8iNE
        zDPlpiekMAoRomXqwpb2A51/EaGZ0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=8f3dw9IKQZbFwq2buvHYAr47wI2hN6El/u7XdCb3Z
        kg=; b=pr5LS8G0/e4dofikrJRmt3jmcxf768aSeaiaKg4kf3WnDtvZYvc6BNVis
        QRTOTuFjA87M8jrsbeNZAQVgjqCpImLRIBspVsUnNjc1kG7K3PW0i+ayl7X548Cf
        D3Vyy8JAl+2fWEFRHv6Dl/6D7sw/6mqTRbFlo/VSGmdbWYNEGcwpJftnCCTY1k3l
        X79ZBq3601XFt3t0c6SGTfYpySbQTh5cZR5P6/cLETKl0R4+xzJeniSBJKM3DfAn
        piKe+8lnSoCJNsF7NWojrjmx81lUpK0RJtMFSEMPVMYKqXA/42W1N8ubpq6shPkm
        nK7V+vMqoCquHUMn+ISOhAdzXdsQA==
X-ME-Sender: <xms:3TqdYNEB_YdBM7AmlbtGny-p-SxCMjLPDqflDb5CDHxrgu5nRWPaVw>
    <xme:3TqdYCWo_WirlPshWiliXC-aM9JjSDNRAsYxC7A-0jzuVVeSyC6hi24eknqMaz4Qv
    663Cw6dFKlr5cJM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehgedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjggfsehtkeertddtreejnecuhfhrohhmpeffrghv
    vgcujfhushgvsgihuceougifhheslhhinhhugihprhhoghhrrghmmhgvrhdrohhrgheqne
    cuggftrfgrthhtvghrnhepheegudefteekvdegudeiheeiuefhkeeludfhffetvdekuefh
    hfetveelteegtefhnecukfhppedujeegrdehvddrudehrdefjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegufihhsehlihhnuhigphhrohhg
    rhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:3TqdYPItjqjU4I0EQkz2iQQG_AZoGie3B6lqdqgUN1ZvLsJQ-Nop8w>
    <xmx:3TqdYDFozP3vqVodo2l_ptNMYoAQG5ub2poZ0D__3jhgt7YIChfXyg>
    <xmx:3TqdYDUnFH2Prf8VwkkvmvrvZ0KGzlxp1rIx_amV1u22LqoEa8f1iQ>
    <xmx:3TqdYKfoe0XXpQiRPrp6kfhKd256Drp7hH017ZeB5pinAaff-stXTw>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 13 May 2021 10:42:37 -0400 (EDT)
Date:   Thu, 13 May 2021 07:42:35 -0700
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 3/3] SubmittingPatches: remove pine-specific hints from
 MUA hints
Message-ID: <20210513144235.GA11882@localhost>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <patch-3.3-9da5bc4a0c-20210512T084137Z-avarab@gmail.com>
 <20210512235136.GB10785@localhost>
 <87mtszrrum.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtszrrum.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.05.2021 09:50, Ævar Arnfjörð Bjarmason wrote:
>So I do think that if we're including such a niche guide we're better
>off splitting it into another file and linking to it, same with the
>whole guide in SubmittingPatches now teaching people to manually craft a
>patch without using git-format-patch, another obscure edge case we give
>too much space / causes distraction.

I agree with you on this approach. There's one other subtle distinction
that I realized last night and that is the distinction between best
practices for using email for working *with* Git and using email for
working *on* Git. I think Junio pointed it out in the thread on writing
down the mailing list etiquette that the Git project itself has its own
etiquette that is likely different than the etiquette of other projects
that use Git and email. Maybe we should make that distinction clearer.

SubmittingPatches and MyFirstContribution.txt are clearly about using
email and Git to work *on* Git. So is the MailingListEtiquette.txt file
I'm proposing in the other thread. Some of the tips that would go into
MUA-specific files would only apply to using email and Git to work *on*
Git while others are likely to be about using email and Git to work
*with* Git. It is subtle but important.

IMO, I think we should have a Documentation/WorkingOnGit subfolder where
all of the documentation for the Git project resides just to clarify the
distinction.

>In this case though I think saying anything about pine crosses the line
>from niche to obscure archaeology. We're inlining a patch for abandoned
>software that has a replacement. If we're going to say anything about
>Pine in such a list I think it should be:
>
>    Pine: abandoned and has known flowed text bugs, use its successor
>    alpine or another MUA instead.

I'm good with this. I suppose the old docs are always in Git history.

Cheers!
Dave
