Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9469C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 00:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618A020734
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 00:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="vPVAfX/x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMjaYQn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFPAul (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:50:41 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:46797 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbgFPAul (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jun 2020 20:50:41 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 071E2760;
        Mon, 15 Jun 2020 20:50:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 15 Jun 2020 20:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        x4v7cKI6MrKYFtAuejVgnq4cgXxNinkE+96RA4tmEIg=; b=vPVAfX/xp2YTD22e
        Vagr9Bg4DMLVY03jJiPhNfvONMmbum/jz9Pe3Sz/JpG6tm0YX2LKd3xJlap6nXHc
        wyFKTm5U+JVGJI5NTfCNFIX3PGbUZCdJ30EM40TpPfEq3Dadprqx2DaSvJlxQ6gm
        MQ5tRlbnCXp6EzqIbqTpIbi8kME5uV/BrJY56HwLjmmPPoESD0MGDy5j/w8+f3hP
        GtjNyLtpQq30qcsBAZdx4hnY5q3wXPPd+P8XuIiW6z9c2Nsjmp1DVR3zx2J4JgLj
        ktUKq4HdeqFH9sOTRn1vGrb9vQqNsIKr5t3N1pTghYvN6PTSnaNm5JVdw3PEQ1ta
        lr5+jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=x4v7cKI6MrKYFtAuejVgnq4cgXxNinkE+96RA4tmE
        Ig=; b=qMjaYQn2kg9CvzLVmOhHdMuZi72q02l6fvp5Kfgb28yWZx0/cM4kYwDVJ
        uq/cb/qeDb/LB6avcaE8Yn7TsgmU7yuOJIUuOOwqrWpyi+QM6WDjeMHXQupM+lEj
        AjManNgqOScIx2U1oow8/3iDLIp4m5I5rds4m/92OyhMxTib9gGTxogTNjlj9KPV
        M7DnHwG1WCQXLN3oNtY3W8vDA6WpmnnnpfN8Y6Bxhbi5uyeQbk5tt4Karv9Q4Fve
        FeQuVMlHcArNnM+yBybxmtPE+zQYIwrrwCRHVvkqdIRtvcpLjNBXtz7cY6mKFWf0
        koL/ofS8fSRay9wBAVHnDgRrBkaRw==
X-ME-Sender: <xms:XxfoXh1HXv-WaEEkzmACkAYD6tApf4WZ_BNwtnVC109Lma7UWEvidg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeiledggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffoffkjghfgggtgfesthekmhdtredtjeenucfhrhhomhepfdflrghm
    vghsucftrghmshgrhidfuceojhgrmhgvshesjhhrrghmshgrhidrtghomhdrrghuqeenuc
    ggtffrrghtthgvrhhnpedtjeefieehfeeileegudfgheduleejtefffffhhfeliefgueel
    iedvteeukeetteenucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppeduvddurd
    dvtddtrdeirdduuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepjhgrmhgvshesjhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:XxfoXoFxumt6BsbK_b5-FfB4oC4E3PuggUM7vMEyHMXgHcPtS13WSw>
    <xmx:XxfoXh6SqNi29musJvOpt2P4gVvAF4hf25wFuuVbM-tmp67TKMolnQ>
    <xmx:XxfoXu2WmK-CDLEJwW5SgeZDD6K-vFNnjRfeDp2KE4ZpgliHtPrr3w>
    <xmx:XxfoXuOyAId_hmyNihNqW28M0Xjlx3duSF43ZfcwRM0bM77kA33reA>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9E8683061856;
        Mon, 15 Jun 2020 20:50:37 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     "Taylor Blau" <me@ttaylorr.com>
Cc:     git@vger.kernel.org, "Jeff King" <peff@peff.net>,
        "Bryan Turner" <bturner@atlassian.com>,
        "Daniel Gruesso" <dgruesso@gitlab.com>
Subject: Re: Consensus on a new default branch name
Date:   Tue, 16 Jun 2020 10:50:33 +1000
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <41438A0F-50E4-4E58-A3A7-3DAAECB5576B@jramsay.com.au>
In-Reply-To: <20200615205722.GG71506@syl.local>
References: <20200615205722.GG71506@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16 Jun 2020, at 6:57, Taylor Blau wrote:

> Concurrently with this, GitHub, GitLab [3], and Bitbucket are working 
> together
> in order to make a similar change across our respective products. 
> Because of
> this, we are met with a bit of a challenge: we would like to make 
> these changes
> before the next version(s) (and so need to settle on a new default 
> branch name),
> but we also want to avoid a situation where the community is fractured 
> (eg.,
> GitHub uses 'main', Git uses 'default', etc).

Avoiding inconsistency is definitely front of mind for me.

> My interpretation thus far is that 'main' is the planned replacement 
> for
> 'master'. Consensus seems to have formed around this name [5], but if 
> that's
> incorrect--or there are yet-unvoiced opinions that you would like to 
> share--now
> is the time to discuss further.

Based on informal surveys internally, and polling on 
https://gitlab.com/gitlab-org/gitlab/-/issues/221164, ‘main’ seems 
to be the preferred option. Using GitLab’s MECEFU (Mutually Exclusive, 
Collectively Exhaustive, Few Words, Ubiquitous Language) [1] approach to 
naming I think ‘main’ ticks all the boxes. None of the other 
proposals seem as clear.

I think Elijah’s points in other messages about the problems of 
‘default’ are particularly helpful. I would prefer to avoid that 
name.

Thanks,
James

[1]: https://about.gitlab.com/handbook/communication/#mecefu-terms
