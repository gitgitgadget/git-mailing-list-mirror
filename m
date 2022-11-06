Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A49FC433FE
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 07:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKFHfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 02:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFHfX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 02:35:23 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF3DF89
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 00:35:21 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 067CB5C007A;
        Sun,  6 Nov 2022 02:35:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 06 Nov 2022 02:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1667720118; x=1667806518; bh=K1kcsR95YEvivs5rE/TuRtvb5
        kthU6XGADKWKqy3lFc=; b=GZ9rSFnBp4M2px4uwOBFtznPbTg6N8fyI6PWkMkMB
        nvRxBCAoaPZUEaYr0VRcUYQLhMvKk5FB1GK3dJ4IYBfigeZlv/0awD2I4u8f7GI6
        g3l6lli8Gv0FvLTkloMh54p4atJmHEnnn+1NwByGysjrEgv+mpKpdNo/g77aqKXG
        IomAoOTaUUgWHf19oC7W5k6Os8yjJ0AOErE27qWfuL8u18cJ14GMAaQOWYu3dklm
        YfBafA93U9IRrSk/lQKdLrKU/PUrrQURxiP8YMiQquS1onVBKp06PKKVVb7en3l/
        sjbFx2882DHKyXamAoEMwfVk7tIZDArvzFrCTi87aXGng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1667720118; x=1667806518; bh=K1kcsR95YEvivs5rE/TuRtvb5kthU6XGADK
        WKqy3lFc=; b=DUfTsYY9Qk0whZoyZjJ15Rq8HlMfFhqASonChD5L37sBigKhZjs
        py/haDhydo7mWs0MD9vpHsSFLkxkuTczi7v1lWilH9ZUzEdEaUOIFz7jQHlGc6TI
        mqxLmH+x7s+WCz30oP8krEewj1ZeTrO8zYvYX0uB/FKwaFnXB7YrbYMXIQLrV8Pk
        DA5VCXNfzlYXSN67Dy8yZoBE9BD7fMDT1Ld94tSVVRev97khruSuzqcNBFeoN8Ju
        W8EEbr8T3wSvj5G5umcAsjPB2AV8Shlfz+Qlt+7Rd3ZU9cwAR6QwkGyCTS/aYDTZ
        2a5KVqpnznqe46+qt65EnEa6FgY5sgMZTsw==
X-ME-Sender: <xms:tWNnY4pgVvAI5td3oN8ENbZO2zVhN60tEliYr60spUji_fzVfd0M2w>
    <xme:tWNnY-oyseLaviCkiZY8cKgAJhARzljRS8jMHonBpkuOVz-59EqpX2ZhkvYK_tWFz
    EIK-cELJEMVLoMJPiE>
X-ME-Received: <xmr:tWNnY9NBSYzrS2HfKVtiEx6WrcSfAuy9nLw4a5XZ9PU6FCbHeU8cFvl0MmtJ8BEYHuO3cyVb-rAbJUUWvcQHbXFKD11dY5ueXAKJDK5STFVhL3PTYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdehgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeggihhntggvnhhtuceuvghrnhgrthcuoehvihhntggvnhhtsegs
    vghrnhgrthdrtghhqeenucggtffrrghtthgvrhhnpefhffdtteeiffefvddvteevfeevvd
    dtvefhudelueefhfeugefhtdeukeeufeeivdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgrtheslhhufhhfhidrtgig
X-ME-Proxy: <xmx:tWNnY_4EvHmq7tfbjx7XVjWbHo65Hg2b052gCZX2Pocr7nBfU4mOQg>
    <xmx:tWNnY34Y9tsba1Ad9ovUE60ZbL7p94yQgyFoTCrn82R0esznaDuTaw>
    <xmx:tWNnY_g92BqOUr_PXoPA1OTgpKCxhrBZm0yEoSa_UxBMFrxykeabeg>
    <xmx:tmNnY0imH06qIPwLLzYsTfNNsexmw3z2yVoctErNt7kdTFePQq4Nag>
Feedback-ID: id69944f0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Nov 2022 02:35:17 -0500 (EST)
Received: by wally.luffy.cx (Postfix, from userid 1000)
        id 8C22C5F7D1; Sun,  6 Nov 2022 08:35:15 +0100 (CET)
From:   Vincent Bernat <vincent@bernat.ch>
To:     git@vger.kernel.org
Cc:     Vincent Bernat <vincent@bernat.ch>
Subject: [PATCH] ls-files: fix --ignored flag in synopsis
Date:   Sun,  6 Nov 2022 08:34:45 +0100
Message-Id: <20221106073445.47789-1-vincent@bernat.ch>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Vincent Bernat <vincent@bernat.ch>
---
 Documentation/git-ls-files.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index d7986419c250..5c877d05b593 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-files' [-z] [-t] [-v] [-f]
-		[-c|--cached] [-d|--deleted] [-o|--others] [-i|--|ignored]
+		[-c|--cached] [-d|--deleted] [-o|--others] [-i|--ignored]
 		[-s|--stage] [-u|--unmerged] [-k|--|killed] [-m|--modified]
 		[--directory [--no-empty-directory]] [--eol]
 		[--deduplicate]
-- 
2.38.1

