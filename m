Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F75EEB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 18:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjGLSrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 14:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGLSrU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 14:47:20 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274421BF3
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 11:47:19 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E5318320090A;
        Wed, 12 Jul 2023 14:47:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 12 Jul 2023 14:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imap.cc; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1689187635; x=1689274035; bh=J5lkf2X9FmZD2lSGMXBv+Rx8iGuv9yC2Z+9
        VbxpUL5M=; b=Sk5zlZWbCUgUdTxHKq8hrBB++PuyqWUMWargPqvtQjBhFUplTPf
        Chkff3/MCk0+Tb6n8PbHdy5uHUwrO3xJm3mHAb2vqbG3WdqrHnee/S2++xlb1Rlv
        pXna2lSJUiQPBemWubwk+kqe13YwuMykOdZFrw7J9TRi9OvRKME3zIrHwS+mOQHm
        //WDh0n0I9lRa5NIXzmVgpbEIJZBxn54eLbboqxZlK0FuWqXtM73imS4a2i5YK0c
        JQhrOPh6TajOAgfNWAp3WHSW7jE+1JCI+BOxwqo5O/pE1NRoJi5srX06Pu9MhRpl
        wHF0OYaatCj7qfNzpT8rjjPRyktgLhz1GDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1689187635; x=1689274035; bh=J5lkf2X9FmZD2lSGMXBv+Rx8iGuv9yC2Z+9
        VbxpUL5M=; b=J/wnw1gSKNUauQpanAKjv80gk6BhRyLBYNlZiAAdK2oGlaV6t4w
        6rxMfJBYCj8AlVciDpbhgifNM0pJgqGTKact/86jWeYj2GwaoBKh1Kmc1If4REO/
        7YWTSZpKSEPt1ZjOHx2k5SWrsIrsCI7L3arG+6MV92hPFIgp/xo8VdTDg5JhdDTD
        BBQZFq5m39rOA3ePbWjrdMjWqJdT2zhVoBOM58VOp3adGtRdqD5Kkfx6fLaxXmpC
        r4WyOnjCaXWVvCtBeaae8J+uArYXiAegMUDrGCDmq6Sd9anZMRVYclt15yeLmdWY
        pGLdnQECi5SrpV7M/Au37sZytzXLUzxLetg==
X-ME-Sender: <xms:M_WuZLcbr_R10rvGUyD1xlShyCHPFEsltoEoyf6uLZTOuKlcM6IggQ>
    <xme:M_WuZBNTHwjieTQuCeYTuTcpewvf0QNj7CE7Qxp__-lfLdPAnjTFlxZ7yOeoNX5HX
    mZrTk2ya9MrT_vKHQ>
X-ME-Received: <xmr:M_WuZEjJ3aDdWT7qdMmLRCJE0WQ9tKchG0PAaL2CEdde84BH437lEQTEifWZb0btISoyXO1JJ3Tc8sYNAH1TYhqWyYhdeRiE0m2NtpM6aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedvgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefkff
    ggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheprfgvthgrrhcugghuthho
    vhcuoehpvhhuthhovhesihhmrghprdgttgeqnecuggftrfgrthhtvghrnhephefgueeftd
    eghfeljeegjeffffdvieevgfduudffjeehkeettdekkeeufeetleeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhvuhhtohhvsehimhgrph
    drtggt
X-ME-Proxy: <xmx:M_WuZM_PiAQVvshLmf8mtQH3QPKUZrfCm7xTU-8EUajraHISRaeeFQ>
    <xmx:M_WuZHs5DCps4ebBx9A0Qg_gIpRiAH2G7GNyF5SmB1TaqeCIqXCMNg>
    <xmx:M_WuZLGXIwuwWsmY2gRYvWZTHDo7z1ViW94jlivZT4gZGp-IdRRLBg>
    <xmx:M_WuZF3HT3QPd16saw3SMoHEkkABMNn9KlYH66WP8Ts1cvMpwPvffg>
Feedback-ID: iccdf4031:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 14:47:14 -0400 (EDT)
Message-ID: <7090349c-4485-d5c4-1f26-190974864f72@imap.cc>
Date:   Wed, 12 Jul 2023 20:48:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] doc: remove mentions of .gitmodules !command syntax
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20230712160216.855054-1-pvutov@imap.cc>
 <xmqqleflt75z.fsf@gitster.g> <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
 <xmqqfs5tt3qz.fsf@gitster.g>
From:   Petar Vutov <pvutov@imap.cc>
In-Reply-To: <xmqqfs5tt3qz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/12/23 19:54, Junio C Hamano wrote:
> 
> Perhaps
> 
>      "... available via the ... configuration variable, and cannot be
>      used in the .gitmodules file"
> 
> would have helped you?
> 
> Thanks.

I think that addition is good and makes the intent clearer.

But it's slightly wrong - only 'custom command' cannot be used in 
.gitmodules. 'none' is legal (and mentioned in the gitmodules doc as such).

What about something like this?

 From 7b2fcd9a56b4954863cc74e1cf89a4b9d9d3ad52 Mon Sep 17 00:00:00 2001
From: Petar Vutov <pvutov@imap.cc>
Date: Wed, 12 Jul 2023 20:40:10 +0200
Subject: [PATCH] docs: highlight that .gitmodules does not support !command

The `custom command` and `none` entries are described as sharing the
same limitations, but one is allowed in .gitmodules and the other is
not. Instead, describe their limitations separately and with slightly
more detail.

Signed-off-by: Petar Vutov <pvutov@imap.cc>
---
  Documentation/git-submodule.txt | 9 ++++++---
  1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt 
b/Documentation/git-submodule.txt
index 4d3ab6b9f9..eb024a1531 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -160,16 +160,19 @@ checked out in the submodule.
  	merge;; the commit recorded in the superproject will be merged
  	    into the current branch in the submodule.

-The following 'update' procedures are only available via the
-`submodule.<name>.update` configuration variable:
-
  	custom command;; arbitrary shell command that takes a single
  	    argument (the sha1 of the commit recorded in the
  	    superproject) is executed. When `submodule.<name>.update`
  	    is set to '!command', the remainder after the exclamation mark
  	    is the custom command.
++
+Custom commands are only available via the `submodule.<name>.update`
+configuration variable. They cannot be used in the .gitmodules file.

  	none;; the submodule is not updated.
++
+The `none` update procedure is only available via the .gitmodules file
+or the `submodule.<name>.update` configuration variable.

  If the submodule is not yet initialized, and you just want to use the
  setting as stored in `.gitmodules`, you can automatically initialize the
-- 
2.41.0


