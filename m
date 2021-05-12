Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF81DC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A185D61278
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhELC64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 22:58:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51895 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhELC6z (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 22:58:55 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B35515C0185
        for <git@vger.kernel.org>; Tue, 11 May 2021 22:57:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 11 May 2021 22:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm3; bh=dBD
        CySBu3GgP+Oe3s3dZsZhX+4sC3JP3ex9u33Actj8=; b=jwZNQJgE9VVsTwKgQbo
        YZaVT869J5Gta5pS0Dd68hg8WEUAzLCs/v/7arByFxmz9Upo1+Fladx/OK3gvqAD
        +LC3plrTEzKikVDtIxV+CywzmQsLBkmcV6GRqh6n+yQacdGSPf957pTs0bQrJmIa
        eeyua8Xc2IiVbuLRFjqmNBtaXde9oTviWYTlOssrpLaFwfHdyCW8IsOGponUU4dP
        +Fj0L+g5eoOQ9mgPdThFAGMmJfOjzhY/zjKHAGhbwqjdmA1FxJt7ExoVBAEJFblI
        cGHDe83BiCcAxqdoduD3SlpVUIiOoD/61VG0wMOlqYYMfUEwvjaWHrwu7tlr6flq
        90A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dBDCyS
        Bu3GgP+Oe3s3dZsZhX+4sC3JP3ex9u33Actj8=; b=gWlD51gmzhbOdAVhbtwz5B
        nHiVGDm/0I3Fm4GchmV5CqXfLKMjeRBsGH3qObPn8lykuNqz2aP9hwpxuDfcRM6J
        WLh/0lQzm8DWnLmipH/t97JTuec7HKkS2/cNR5JVVp7zVRDNMbqWSL+cRv3HLND8
        PV3XVGoxFnVetJJee4p5ST/eXRdcdTgGM+Ez1LRLnklEF4GiHb6pO+paMNPoruNs
        ktq9sMWAbjsI0k2Jrm1OQM7L44iXRgJGHRBKJ5Tvyq+V2oO1LjTcILPAMsJkNCUV
        C6cZWrStKmD0O/7iH2wG8vCtIdbTeRnbGiJbYtIp5/RyOPS6s3xGkN5qrKfmUqkA
        ==
X-ME-Sender: <xms:K0SbYHcRQ9WgYgYIR-ttK6Yya5YdGWENuRLKH-8Z-aXRfXS3Vi8EKQ>
    <xme:K0SbYNN16aJBtHcShbWAbLX9k7iza33FhFlTTOKLhyZCwT6FXC3haMFSsDcaqCfwA
    dVYE4KX5mHgN4GO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtreejnecuhfhrohhmpeffrghvvgcujfhushgvsgihuceougifhheslhhinhhugihp
    rhhoghhrrghmmhgvrhdrohhrgheqnecuggftrfgrthhtvghrnhepueekgfejledvjeffve
    elgffgveekvdejjeeigeffgffggeefvddttdefjedtudefnecukfhppedujeegrdehvddr
    udehrdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:K0SbYAgVJ632HltFKiGfCymLgIeh5CJJSL8PQKDTkTGlnKiBSJccsg>
    <xmx:K0SbYI-QzG6cSKqNOC4-j6xBd1EwXNXRVFvsMMy1yK32Sdl2Owx7Pg>
    <xmx:K0SbYDvLEXnCeKRbxxm46ZmIYD8qbt6glueeDRd2SQ_3onaVPXBiDw>
    <xmx:K0SbYENV-6FxtSicYQPlK8FxiZTghBG9CnpFRwwsVSyLSsJXTEdTGg>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Tue, 11 May 2021 22:57:47 -0400 (EDT)
Date:   Tue, 11 May 2021 19:57:46 -0700
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     git@vger.kernel.org
Subject: Re: [PATCH v1] Writing down mail list etiquette.
Message-ID: <20210512025746.GA1899@localhost>
References: <20210512025447.6068-1-dwh@linuxprogrammer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20210512025447.6068-1-dwh@linuxprogrammer.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doh! I forgot to make this patch In-Reply-To the previous thread that
sparked this discussion. Well, at least this patch email doesn't have a
Mail-Followup-To header.

Cheers!
Dave
