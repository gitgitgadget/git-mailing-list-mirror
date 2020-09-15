Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93416C43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 23:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CF4208E4
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 23:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgIOXVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 19:21:08 -0400
Received: from forward5-smtp.messagingengine.com ([66.111.4.239]:38789 "EHLO
        forward5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727355AbgIOXVC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Sep 2020 19:21:02 -0400
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2020 19:21:01 EDT
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailforward.nyi.internal (Postfix) with ESMTP id C0A30194164A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 19:12:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 15 Sep 2020 19:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=jXJTM3reQhYDMLhd2ywm4JoIWOmw0Y0ehGjSuZJR0
        4g=; b=q+0yQ5iNvUIVK5uvyy91SQtehMDYHiTGBn6zpY+IegOJWAo8VbcHuck0u
        lTs2occr/w4ve+5ut9+yJUKXfQ0IrCIql68ZU2P3Jd0Al8FpKZCx2jI5HEUEb6HQ
        NjH6dmhuN0vkM70AGIF+r/Dn6aZhx80InNcJEPypK47KOPk1VB0lfNV38hkeR9r1
        79xP/oJ6jlboFd7eMbg9awyhKClfCfOCswLVggmth5Y1Kx/6hfkDLpkmvrTbaBTv
        Qp84He+tFithHGklJP4RIEI6fxUJG8R6oDuYeQRuPfsirOZKhxxQ9U9x2v923Rbo
        yZflQhoc1TG7DWYSzo1tQ6ifdtO1Q==
X-ME-Sender: <xms:ekphXzkvDVcG1PV2DSwRpQgl0-yDhn1GvE5qiETWHABqFm0pu2yKvg>
    <xme:ekphX21tjCcThEQE-ia51TrttO9Rv0dCWI9w1Zaflur_Aya6euBSh09YkeLCCjuTi
    UymuKC2TTsJ8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtddugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthejre
    dttdefjeenucfhrhhomhepvehonhhorhcuffgrvhhishcuoehgihhtsegtohhnohhrrdhf
    rghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeefveejveejvdetffehgfefud
    etueefkeeiieevhfduheefkeegveehveejtdegfeenucffohhmrghinhepghhithhhuhgs
    rdgtohhmnecukfhppeejvddrudejjedrfedtrdduudeknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithestghonhhorhdrfhgrshhtmhgr
    ihhlrdhfmh
X-ME-Proxy: <xmx:ekphX5rd9l78gfhE4DN23X00YwegniprEGIrv3X8L3elkiSm2lUp3g>
    <xmx:ekphX7kiEFVGJ_CnQokH2NoYgXll8NZPc9WKZEDdj8GeWxyEYK45eg>
    <xmx:ekphXx3D4GNVwflr4g0EKsQWRvgcv2BDE5zg4jGdqrwjN592Fnlwtg>
    <xmx:ekphXyDolC8ehmu-qbiz5PQnn6OQK4ZgqrLU_sy9Pgd--JECyuFzXg>
Received: from [192.168.233.10] (072-177-030-118.res.spectrum.com [72.177.30.118])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70B5B3064674
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 19:12:58 -0400 (EDT)
Subject: Re: [PATCH] commit-graph-format.txt: fix no-parent value
To:     git@vger.kernel.org
References: <pull.733.git.1600142634326.gitgitgadget@gmail.com>
 <20200915042607.GA19144@nand.local>
 <8ff4e93a-7291-3093-2f79-9e98236c11f7@gmail.com>
From:   Conor Davis <git@conor.fastmail.fm>
Message-ID: <7107abb6-e957-da69-5f64-ed6eeb16f14f@fastmail.fm>
Date:   Tue, 15 Sep 2020 18:12:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8ff4e93a-7291-3093-2f79-9e98236c11f7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/15/20 7:16 AM, Derrick Stolee wrote:
> On 9/15/2020 12:26 AM, Taylor Blau wrote:
>> For what it's worth, I can hardly blame the author of a9aa3c0927,
> I can!
>
> Thanks for noticing the doc bug. May I ask why you were looking
> at the format document so closely? Are you working on a new
> implementation?

Yes, I'm adding commit-graph support to gitoxide: 
https://github.com/Byron/gitoxide/pull/21

-Conor

