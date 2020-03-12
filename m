Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FCAC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA7B20724
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="KqxjUgPB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5eYntJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCLEGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:06:02 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55481 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgCLEGC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:06:02 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E6773220CA
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:06:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=9WB4s0P0GLw2kpcnQPSljPA6+qz05zO17kIv8Ng5sTM=; b=KqxjUgPBxzT3
        Jk33Obcq1lF0U/a36PZ58gv8pEjfaBP2qF0rk0WC/al/ViDlsGWH3HmKvfRxIne0
        TuWYJur4lc2Ev+uiq/ygKFaKDfE34NYapKIQHT9PHt+6/1+DNC2wpYq7VjmxJzon
        B76htRh6bELok5+a56gEIIxSaL9qffw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=9WB4s0P0GLw2kpcnQPSljPA6+qz05zO17kIv8Ng5s
        TM=; b=R5eYntJ6GYeNhq3VMaSw4Dm98bexr/HZPIhtJwfTGzhOVOQR/eF+Id1m7
        xtaarIZtgZznH1RnvUFjAw66vFNsYT7vW1EcJSciOoxY0Z2jiNZoIHnCCW77yAgH
        K+akr8pdl8pjw4gzXihG5wlU3KabnIrGDSBMBhhL6ywFO1F29/llu9RC1rXEofcT
        0+/9iT8/rg5XrfmUKt76w9KxoMLhszKHAAhi+ayTliCw8nKnMlGB/oHqMvy5RqDU
        h/Y8qJCy20jxuR3xFWzyiwBVl30q5iNCrJtfmZr+Sdwf/D2CyZdei2sGUnHEqMUY
        GKhHEZAiC8hpNlp3fSJjfWUHE4yYA==
X-ME-Sender: <xms:KLVpXkzylb0p_NI8Gk-JvuROs1V1wzbYj8FEAhyu5ZWw_jdHuKG4Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:KLVpXuQRLI9Ht85Gqfr_zvNRvptJzHsmUwxqgFsdd853Br33r3OvBQ>
    <xmx:KLVpXj9sT_jnc76-j8IZsDtp0V9O_xgceRN2kqf8g6vgMwHlV3yxUw>
    <xmx:KLVpXtr5_6hYYrQxjfVFu9Z6id0DkCfSi7eahZdW4HDC_WYTSz0I8Q>
    <xmx:KLVpXsut4hIoa7BkmnXEctXw1J9UcPAO8LLh4mSZlOBizaJoa4a2iQ>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0E3C33280059
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:05:59 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 10/17] Expel =?utf-8?b?4oCYZ2l0IHNoZWxs4oCZPw==?=
Date:   Thu, 12 Mar 2020 15:05:57 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <AF7A56C0-FDDF-476B-B7B2-F58CE6115353@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Jonathan N: Cannot use safely on its own. So why do we still have it?

2. Jonathan N: It’s not an interactive shell, it’s a login shell. To 
give the user only access to a git repo.

3. Jonathan N: Gitolite is the only sensible thing that uses git-shell. 
If this is the only good use-case? So can we donate it to them?

4. Peff: If it’s a tool for security, but no one is using it, so 
it’s dangerous to have it around. It’s mostly stand-alone, so it 
should be possible.
