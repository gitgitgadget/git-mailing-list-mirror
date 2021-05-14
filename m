Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B370BC433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 17:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877CE61444
	for <git@archiver.kernel.org>; Fri, 14 May 2021 17:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbhENRkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 13:40:25 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:39485 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230487AbhENRkY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 May 2021 13:40:24 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6D00C1546;
        Fri, 14 May 2021 13:39:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 May 2021 13:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm3; bh=lWd
        KmvzDTQrb/Or/oujbCkPt5n8CUrKRWao00PvlBNQ=; b=c42oFGXe9bnLHBtIr6a
        WAdHwgD8KMR17MmZxjuUyRZ2U49M1iuF2H1DWc6U//nkj1dbodd2pH6mXkuqZ+IW
        c5wDHjVk/W6Mdk5E/1pfkC51V0OxPuWcA8RL9PnX5RAKd9by/Z7sGhuxDOy+0Kv+
        nT4lktKVfJywBhGgJUQeS/dLj3Apa+8VUyE/XpQmhgcaSi+63/fG1liYdWUK0O0x
        yGiu8Q8Pr8xFki0wj3K5Rkio9CufD8YUWZFqR5oozsHfDu6AoQ7UT5ZOfBwSw6l5
        hdXKR8RTNLS7WLcXpLpLSXEiMbK2feVBpNUfYa5qFnkGBiZFbb+q1broj0Ta9o7h
        64Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lWdKmv
        zDTQrb/Or/oujbCkPt5n8CUrKRWao00PvlBNQ=; b=Pz1XoCkE0A8B29xF240I+1
        BYc2P5+ATCwffaVEy/u03zoRtt+oldX1FFpCcmOxwzXEAfKoV/IaesC/cHRXUKN4
        uTMJFlo8yNcRdiaWDdZ6Av21RPyUiVO3IDg+zRBnlFTIOQjxwohCU4eNO3wwd6jS
        +VV0ZCJQJ1gObDbpCA69sEyHIbEoO6LdqC0UWMDzinEvGqJoO9uESFlsvL7w8uOL
        WMWjNCqbbLpcOoVYhbxiYkZAObqmanpsjs75XJE2lHy9QVW1s7cxzln6BGfX5YOO
        CzQnbDvH42CpKeXZDqNNxsAumuiAF8LEt3nb/SzXlDUjDi04lyV/dVaqweRrbiBg
        ==
X-ME-Sender: <xms:v7WeYMN21UdODTCkhqBWdZuktuqc-gpFklsYgczD6y_KFMpgyAt6hg>
    <xme:v7WeYC_fUDzdb-zhyBsoVWJzfEoFtgw2i0TMoyb2KMfHL38-M4w5k-G9OsqD_MuGq
    LKJ2BC3RrkaCJC3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttderjeenucfhrhhomhepugifhhes
    lhhinhhugihprhhoghhrrghmmhgvrhdrohhrghenucggtffrrghtthgvrhhnpefgtdekvd
    ektdefveehieefgefgffehjeekffdvlefhffeffeelhedvheehieelleenucfkphepudej
    gedrhedvrdduhedrfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugifhheslhhinhhugihprhhoghhrrghmmhgvrhdrohhrgh
X-ME-Proxy: <xmx:v7WeYDSZp883Qbh73lIs64WvC6QEl4eONfTgk_4wT-cHUNU4i2Hsrw>
    <xmx:v7WeYEtf1JYhv8kdjrS8ZgwM7K6McjuptQQUxhJiflaXeXzf0NfDoA>
    <xmx:v7WeYEe5cSW26dVoPEuMGQQieo8La_YprEJg04IEVJ240Z6OZlNwwA>
    <xmx:wLWeYMkok3UMAmAnEEXzi3glST058aXuHGrUyaeidXrma-B1__ZYdA>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 14 May 2021 13:39:11 -0400 (EDT)
Date:   Fri, 14 May 2021 10:39:09 -0700
From:   dwh@linuxprogrammer.org
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Is the sha256 object format experimental or not?
Message-ID: <20210514173909.GA16542@localhost>
References: <20210508022225.GH3986@localhost>
 <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
 <87lf8mu642.fsf@evledraar.gmail.com>
 <YJm23HESQb1Z6h8y@camp.crustytoothpaste.net>
 <20210513202919.GE11882@localhost>
 <20210513204957.5g76czb5bk3thlep@meerkat.local>
 <20210513234706.GG11882@localhost>
 <20210514134501.3vzgqdfwwejafkq7@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20210514134501.3vzgqdfwwejafkq7@meerkat.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.05.2021 09:45, Konstantin Ryabitsev wrote:
>As you know, this is my third attempt at getting patch attestation off the
>ground. 

Yes, I've been following. It's been a long road.

>I'm hoping that this version resolves the downsides of the previous two
>attempts by both being dumb and simple and by only requiring a simple one-time
>setup (via the sendemail-validate hook) with no further changes to the usual
>git-send-email workflow after that.

I'm very interested in whether this one works. You and I are completely
aligned on this. I don't think I'm paying enough attention to the
emailed patch attestations as you have. I think I understand the
requirements but maybe not all of them. Do you have any threads on
public-inbox where you discuss them? I want to make sure that what I'm
doing doesn't undermine anything you're trying to do. The end goal is to
have an air-tight provenance on all contributions and
accountable/audtiable software supply chain. We're all working towards
that.

>I've not yet widely promoted this, as patatt is a very new project, but I'm
>hoping to start reaching out to people to trial it out in the next few weeks.

Hopefully this approach strikes the right balance.

Cheers!
Dave
