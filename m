Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5861AC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 00:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 374D2613CA
	for <git@archiver.kernel.org>; Thu, 13 May 2021 00:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhEMAQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 20:16:18 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49375 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351891AbhELXwt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 May 2021 19:52:49 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id C5E321B3F;
        Wed, 12 May 2021 19:51:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 12 May 2021 19:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:content-transfer-encoding
        :in-reply-to; s=fm3; bh=8nekpU8tBfHPz4Gtyu0dfRO2VHHK7AC5owUxeXAZ
        auY=; b=b2vFjQ5iKe3ZU+78KpGg7FSgDQ1pfizs/hvEn5x+QnxVzQrvF21bHsXj
        YdAVl3PwmqSyz7QepRmaQXZ4Czhb8sTphctpqXgiimocg8pjI8KxeWuOTP1P2hOm
        SDkVmD0xpjAsKxDLNhAjc++ymRWx+LM2Si2DDKensaov5vsFujUi3ThWJycyQOsx
        TvEWsdN+yVamQm0uz7eiY1RqhsawoZGoB1jllLr4eiTp+rR99vl488tiSF5vf6xu
        0yuqv+yNP3Gu+/lxCZauibfOkjA00/qlnBJmWsegURfaFHvMdXKtH3f7e/N8FlEM
        6Az1W/enrajkHRgb65mdh9MT2EwGmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=8nekpU8tBfHPz4Gtyu0dfRO2VHHK7AC5owUxeXAZa
        uY=; b=H9gingw2Z5iOSrUDlBtR6IrkDb1m32o073XiSchxFQtiBEO94472OSkbz
        42CpQG2fX9jmMxgGyReiMErumhxjQQwZQ0qeQehH7Aw1HKURmZ6KGqO/xw19/aGG
        x5iHerevMT1mEQCpgnn4oDGuiKzv4wwDr2fqQ3mv47jJF54ElfqU4SSVlxUGrrDg
        E5QDXmy2aYAH81d6VkU5GCwhLffgI690orQ3Jn5V/XzNIRE3PPztxreaGNCEvWIP
        7yWVpVoO9sHMJRbVIiZBaBIgCQSUT1SIfOKQ+WXUeDOm4Zwb1LJfEbTf50K9RaAX
        2DD5SzkuLyfFzFP1f0nnnpXoQ3Hiw==
X-ME-Sender: <xms:CmqcYI5W7-IEd7d8EshKATCQJFjweoVBlWhlg8-_0CW5uwol2gDFiQ>
    <xme:CmqcYJ6Kid7mgDX3f-dRqWoQM7ILoXOWvg45CbY2PFcRYn8BBpSGw5NsxAuc6f9_G
    sIKypzaIsKCW2Ay>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehfedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjggfsehtkeertddtreejnecuhfhrohhmpeffrghv
    vgcujfhushgvsgihuceougifhheslhhinhhugihprhhoghhrrghmmhgvrhdrohhrgheqne
    cuggftrfgrthhtvghrnhepheegudefteekvdegudeiheeiuefhkeeludfhffetvdekuefh
    hfetveelteegtefhnecukfhppedujeegrdehvddrudehrdefjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegufihhsehlihhnuhigphhrohhg
    rhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:C2qcYHdRIhjsL2eZvQwUXoXBi7ntKzFc2onBt6uu_XJujeWOaPsN1w>
    <xmx:C2qcYNIFZaxKn-oHEQXhg8IS8aOEKvfcirABCrv7HpC2yhPv1L_P4w>
    <xmx:C2qcYMLqGeBKi2EV2MrXuietUsbRHKQNxU5DD1TXrDjfgs6D25HBSA>
    <xmx:C2qcYGg5VFikHjhXxP27ni8LsWqmZp_yX5k7y7qzBadz5Dw9AOh4lQ>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 12 May 2021 19:51:38 -0400 (EDT)
Date:   Wed, 12 May 2021 16:51:36 -0700
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 3/3] SubmittingPatches: remove pine-specific hints from
 MUA hints
Message-ID: <20210512235136.GB10785@localhost>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <patch-3.3-9da5bc4a0c-20210512T084137Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.3-9da5bc4a0c-20210512T084137Z-avarab@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.05.2021 10:45, Ævar Arnfjörð Bjarmason wrote:
>There hasn't been a release of Pine since late 2005, in Alpine the
>no-strip-whitespace-before-send switch is already the default.
>
>This documentation was initially added in 9740d289ee7 (Update
>SubmittingPatches to add MUA specific notes., 2005-08-26), at this
>point it's safe to say that it's not useful to anyone anymore, let's
>remove it.

What is wrong with keeping it in there? My latest version of the
etiquette patch moves my Mutt MUA config notes to this section on MUAs.
It could eventually become a somewhat exhaustive reference of MUA
tweaks. Old tools may not be popular but they sometime have niche uses
and/or userbases. My recent switch to Mutt has been mixed at best and I
went back to take a look at mh/nmh to see if I liked it better and I may
give it a go for a while to kick the tires, likely making me the only
developer that uses nmh.

Keeping these notes on old tools--at the bottom of documentation no
less--seems to have little to no "cruft cost" with the potential of
helping somebody someday, even if nostalgia is the only reason.

Cheers!
Dave
