Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EE4C433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 09:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384388AbhLDJHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 04:07:39 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:34817 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1384394AbhLDJHh (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Dec 2021 04:07:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EF38F3200EFD;
        Sat,  4 Dec 2021 04:04:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 04 Dec 2021 04:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=7oya3UTQk45Xh
        Ar+9IVYZvtuyE4WOwVWMrSTPw8aWII=; b=HtAGfBAkIjg4WfccHmx5ustloF7gh
        A/CwoJHJjuRSVPOPvpNAHub8DvruFRZO5Cu2Bl3X5XfQKWJmJZsWHDVBuxdHEGa2
        IiQkKyT1h7q/i4/mVL2CVNSFvHexbCA9mRDN7clvn/9JyZOHr/YOvkXin2GFqqeB
        KlXhv/obU41nA2d9j9cLjah3yJjrxQEW2YoMIx6ThokoRgtjD4Dlxd/oyBq9ruMW
        snavEl/bdzk98NxesfWcSvAMiYjey9TP9Cj/uZbxGjSZWQ9w0ay9RU5knnmkyI5Q
        5F2MHaqn3LwJHJy9sLmWApsRPJ19FXXHHXerbI4+q+3lBwJXvlsE2q2rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=7oya3UTQk45XhAr+9IVYZvtuyE4WOwVWMrSTPw8aWII=; b=hSPCC3wH
        vwlOPoGr04S4h/hP5L7LaPSF3Llhk+HsBxl5kik0Qw5cctIv5PSiyzwhz2icYeWt
        juha5XN0bOLSfT0ify7m1ZOJ30G3NtVU4tnSyuPnXQTkIqdDRsMPCkfLMLnIENbi
        VKwP0svalKh1JYqChcd0YBa/B73p5nfVQg+euXJtaF8R4VPxdftTCERczB110Xqy
        iv/s8dK3G5a2bYS4UKAhucn+xm5hqymiaFCB3HXJ5+bF5VkM3TPdHOx9js7fzNvZ
        1HRfNSN4ZTh8oaiUDXAsqjmIB2O6deJw6FoA/23kAOMCjB4zbjJz83V+kNj6EIH5
        VyadwDJsu478MA==
X-ME-Sender: <xms:Ci-rYWHHllu_Qx73OmXIQ1rhY6jQER2YOoCOSy8XnE-CEWcNGbAfZQ>
    <xme:Ci-rYXUmtqlbw5sxMn7qHcYDZ5Q856SyUXpq7OgqqmciCxEtQ6hKA6Y3tNQ813QsY
    sUa-ZD_k4XfYo5oOw>
X-ME-Received: <xmr:Ci-rYQLWV8q4mFmouo7j36ATg3lVwkC4y8KSJmrk9mmaDxMTY1afISsHC2NGSYVjkDp->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieekgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:Ci-rYQFXZ1yOD8GoImROR-zInbggxsGCRoh8Wx481V11N5R44PEk6w>
    <xmx:Ci-rYcW1Wn-2RSGHQRyMgzEuCP-Q-vnLW2FyPx8hBuD5ZupcZiLQ1A>
    <xmx:Ci-rYTP_cKEHOsqV2X8bevauqIbrMgqt8Cj1iylOygyCNsqauxsMkA>
    <xmx:Ci-rYeLGONKqJoEdj2sTibZxrMhwGPweUR2UXllKi6czUugqEO6MSg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Dec 2021 04:04:08 -0500 (EST)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, davvid@gmail.com,
        sunshine@sunshineco.com, seth@eseth.com,
        levraiphilippeblain@gmail.com, rogi@skylittlesystem.org
Subject: [PATCH v4 3/3] vimdiff: integrate layout tests in the unit tests framework ('t' folder)
Date:   Sat,  4 Dec 2021 10:03:51 +0100
Message-Id: <20211204090351.42369-4-greenfoo@u92.eu>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211204090351.42369-1-greenfoo@u92.eu>
References: <20211204090351.42369-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new test case file for the different available merge tools.
Right now it only tests the 'mergetool.vimdiff.layout' options. Other
merge tools might be interested in adding their own tests here too.

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 t/t7609-mergetool--lib.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100755 t/t7609-mergetool--lib.sh

diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
new file mode 100755
index 0000000000..8cfc22e27c
--- /dev/null
+++ b/t/t7609-mergetool--lib.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+test_description='git mergetool
+
+Testing basic merge tools options'
+
+. ./test-lib.sh
+
+test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
+	. $GIT_BUILD_DIR/mergetools/vimdiff && 
+	run_unit_tests
+'
+
+test_done
+
-- 
2.34.0

