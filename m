Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2884C0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 21:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjGMVrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGMVrI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 17:47:08 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736BF1FD8
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:47:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 495D85C0153;
        Thu, 13 Jul 2023 17:47:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 13 Jul 2023 17:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imap.cc; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1689284826; x=1689371226; bh=/xPlvdfxZ17VGDjQxfA5nckFMfb/MuMAiXM
        I/Pxr6js=; b=F09ULpAGokY/KITwk4fZey6WN+CFff4oHd57Jiy6ooICHm/H6Vk
        yyUWbyDRXny94UGtS3NZS+6aJOGmXWTWNX4altrdyPqiwfkrdnvj1tI5xw6hp1WN
        p5U3hv4uCP0VhpCDdBrAfcLCw8n9qzsZmAbPDPkHV1MDAJPJ4bYZrdStKTYeKyLe
        Y+hRyvYjvmhLjEPLvU9uv9SthdKdbjopeaDe9mM2UJpGbIr+GNl/97XYmfDPRWQm
        Pc5v/to8ngJP4hxum4uAfGZCHiGFy2L5Vq1OiwgSslc9dmjYwkH4qxXddhZTj+ZZ
        5IqfN1WjjlHG8JFkqXQyt6t8eUFcJ3Gq3BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689284826; x=1689371226; bh=/xPlvdfxZ17VGDjQxfA5nckFMfb/MuMAiXM
        I/Pxr6js=; b=J+9uHJVyYKbQBijXCqB5aup+umMIpKjRBvqPTGdzP7RQIyCZP1x
        +7jQiJM4xAmIC5KKCS4SUL9DZupZtzR5WT5MqnV9aw0V+a8e2bogyzuAHDXgoarc
        o0P0l2Ed1Y9wpMvudYKaNlagC7gG4kAsJa9rg/WAc6EgHwElvX+PdMu+QYm+O6ub
        LvzyN0Ik5c0tbIB+DaWrJOYZ812RKXJ4CsOvPz4NtKAT3kdargl7d0nDXUiDWgyc
        IKPaMuO2s2nzdUBjIqNB3eA2N3QOrKMxOqjSBrq9+daPbdGyJN78nf+NE57JBxcE
        S0Z36/KrRW0RSn8sSJq8UDr2cfVZCJrEKsg==
X-ME-Sender: <xms:2nCwZPX2ERkKJbY6PNjQM8mvziUTGECle8rL4o1BOz5PCciY212bjA>
    <xme:2nCwZHlgWDibwpSEyZ0h5xahkBBEnGuxdUklz-UsBHnorMuHtfkzO3E3qvvmr_pG_
    LfZ4QCc8Ka6WxIe3g>
X-ME-Received: <xmr:2nCwZLYhOjkuiW1--1S4T8Y3ncsjDRMw8X23jdN3OvnZwvfEnVGjUyPrCEXwk4wIdfO-sn_SCyQdLvDp5ywbK72ZkpYGZynkLBx6YlNOdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdeftddmnecujfgurhepkfffgg
    gfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefrvghtrghrucgguhhtohhv
    uceophhvuhhtohhvsehimhgrphdrtggtqeenucggtffrrghtthgvrhhnpeehgfeufedtge
    fhleejgeejffffvdeivefgudduffejheektedtkeekueefteelueenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvhhuthhovhesihhmrghprd
    gttg
X-ME-Proxy: <xmx:2nCwZKVKtcRJwVJ5L2P7xyKmyvBHtfOl20ESWuLL--ATkFDkbs-Img>
    <xmx:2nCwZJnKoMRq8NGxEMuIRudQd7JeUqy8BqrdS8mHCmkLwI3RimCi5w>
    <xmx:2nCwZHdVbiJrUd_VRCevVzfAFKgK5ScolGu-j33OeFXoCtc4lsDncw>
    <xmx:2nCwZIt_CY3VjfVnleDh0R0JuU9QTenERm6QbNocniErIsnO6ycuSQ>
Feedback-ID: iccdf4031:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jul 2023 17:47:05 -0400 (EDT)
Message-ID: <0e566b2b-8e61-3895-59a6-292dfc46bd4f@imap.cc>
Date:   Thu, 13 Jul 2023 23:47:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] docs: highlight that .gitmodules does not support
 !command
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
 <20230713193342.1053968-1-pvutov@imap.cc>
 <a8bde495-57fc-6a70-e325-6e2a52f40552@imap.cc> <xmqqwmz3oacg.fsf@gitster.g>
 <9de918bc-6913-0486-02dd-5b4028a7fe1b@imap.cc> <xmqqa5vzo7jy.fsf@gitster.g>
 <xmqqv8enmr21.fsf@gitster.g>
From:   Petar Vutov <pvutov@imap.cc>
In-Reply-To: <xmqqv8enmr21.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks. I'll digest this and reply tomorrow. Until then, I remembered 
something:

On 7/13/23 23:37, Junio C Hamano wrote:
>   
> -The following 'update' procedures are only available via the
> -`submodule.<name>.update` configuration variable:
> -

Originally I was trying to write a disclaimer about `none` because the 
current documentation we're removing seems to be trying to say something 
like this:

"The following `update` procedures are not supported via the command 
line: none, custom command"

It's referencing this bit at the top:

 >   The 'update' procedures supported both from the command line as well as
 >   through the `submodule.<name>.update` configuration are:


