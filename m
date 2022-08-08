Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00D1C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 05:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiHHFfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 01:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiHHFfK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 01:35:10 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583E3EE12
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 22:35:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 987EE3200684;
        Mon,  8 Aug 2022 01:35:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 08 Aug 2022 01:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659936908; x=1660023308; bh=fm
        mBVaMJQITCbKB/iCSW/LxRh0S+Tn5VguyzOpxSgPw=; b=ZvhGqi2/XXFV693cX3
        7ycW3PeSfbQyTV75T3t5uTU5ugC00SXW29prHcCcovMKxKcbIYaPYl8nrcTwvic+
        yXRJBlh2P/BJEvZV7frF2T/nme0Xe8s2OE3o/gNQkWgu5CDtoTyKpXJGFk9qx9jC
        7Nru+8V5deJk3257FGDWh0OMfQ4CQX9eLV2nQGuC5eyuttfMKlhbFTHbpOBCR6F6
        GnDa//LpAUgEYDyrQQCt/XH2n7eLxt/tLqva2RF5Bx8MaSlpt6JXc1r4npcElX0s
        J/Hj++IUg/heJshM2SYvEwfLap0264jrQsDxVHBkjZgRv2+vP861L41mXpfGlQUe
        6BxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659936908; x=1660023308; bh=fmmBVaMJQITCb
        KB/iCSW/LxRh0S+Tn5VguyzOpxSgPw=; b=xI7274P7FpAnkOOgLudhYHcYFabrk
        CFExIPBVK+H4uxa0t16TDJMgYXYP4V87zcwUb2+AN/Q657rIT+X7IWPEECbKQHHW
        Vr+3yoVb/tCZ6qYNKUod4yAtQp9x5L3fDmmdEPzhId+EEc4NTnb/tRJVQa8tNTu3
        MbvXR6OZEcKk5uSRKJekfshkyPvE7keG/xYYS0IEkoCvnkIqjJOTokE1jblbu6bn
        9vreKRSkeCb2rof0xJSrJPTX0W6NYTrvAUVvgGBwDUMU6Br9zrVDl+ulI7n0GsgT
        GFH5cJh72w3tpj0b6svnBr+HAFIWwtZ8vxL+sjDCViau9JfwY3WiCQymw==
X-ME-Sender: <xms:i6DwYtXidjkjbeJk5DbgwROZV6WXXgyVXzHVUCTgTvf7gBZnpY_dnA>
    <xme:i6DwYtkOvGH-bUkMzZYTwiEXJGoWxdcP6w1Y4k0PBOmdICpuH53zAIuPtqkC6kXU0
    Pf1MTMjc4ymyLMLhA>
X-ME-Received: <xmr:i6DwYpag1Wd_Dl1eZHatV7AVzacSSX4dy7HuqgnftOEcZVjG6OypxsaMtxOiRqq-_lT0EsNoGAXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhephfgvrhhnrghnughoucft
    rghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrthhtvghrnhepie
    euvdeggfdvteetkeevtedtgfehudettdelvdegvdfffefgffevgfeujeehveeunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfoh
    hosehuledvrdgvuh
X-ME-Proxy: <xmx:i6DwYgWQZ4fkymEIna70g3YSfmdX8Tqbd-SEcfh1KMZrhsYDOLtcVQ>
    <xmx:i6DwYnmUXAm6hJ3_HCuW5T7btAOH05XrOXRe793-HNRi7WFCIz5xKQ>
    <xmx:i6DwYteJQniVA5NdXwnC3jO55zT4UjMq9Z1bunMh2mKkA8QE5Nf0Lw>
    <xmx:jKDwYvu23M1S9jw_K2-wuqWqS4lmwIUHLYXyY0NN29jdQN6hUZy9ow>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 01:35:06 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     greenfoo@u92.eu
Cc:     felipe.contreras@gmail.com, git@vger.kernel.org
Subject: [PATCH v3 1/3] mergetools: vimdiff: fix comment
Date:   Mon,  8 Aug 2022 07:34:57 +0200
Message-Id: <20220808053459.184367-2-greenfoo@u92.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808053459.184367-1-greenfoo@u92.eu>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <20220808053459.184367-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

The name of the variable is wrong, and it can be set to anything, like
1.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index f770b8fe24..ea416adcaa 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -29,8 +29,8 @@
 ################################################################################
 
 debug_print () {
-	# Send message to stderr if global variable GIT_MERGETOOL_VIMDIFF is set
-	# to "true"
+	# Send message to stderr if global variable GIT_MERGETOOL_VIMDIFF_DEBUG
+	# is set.
 
 	if test -n "$GIT_MERGETOOL_VIMDIFF_DEBUG"
 	then
-- 
2.37.1

