Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B696C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 22:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbiC2Wqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiC2Wqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 18:46:34 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD82F21414D
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:44:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D2AEF3201DFD;
        Tue, 29 Mar 2022 18:44:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 29 Mar 2022 18:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=Xzui5rsaW1vv/ampjOQkbmT4wzzlMs
        y7x1WClz7l+HA=; b=yJjS6eIvKIbR9m8tXNR9w22KHpg4zEOK9l1h8PFQTjNlir
        GE54e/8NW/z0yzxUfsliLVHe6gX3HXZejkPHVr4Mz6O5Pugt5KltoH47BR3/ITlq
        1PbqjmSfGsRx7lKQz2LY2QXQKF7uNHwDhZ6glOkPzcgchdUfcYxXAFG3orxQh2Hz
        BLuR7Vnad0BMFVBXQfrJ0ChY/OPxgaNfAOSh1YyAoym8Du46PncKhCXKuhoIjio+
        zSEyZNeqfEo8btF4TTOrSoLcxKfNit8zwYSJxD9/2GL2tchDoUjnAGQEXb34e+ug
        TuR0Tj89pY7mskiMDglEwHrESkSoG1YWrIlQDkiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Xzui5r
        saW1vv/ampjOQkbmT4wzzlMsy7x1WClz7l+HA=; b=ChFJS3bneY8+qg19H75qQE
        BNjHkrg+r/PNXq0eYQ7hr3lL98YO6vcBOOOdeuAAVWGZr4qXLousuCCgMTQFvuHy
        XqqX/6Y6rUlupr1+TznRipti89zVawM4aIk5zp/d7okaaI8hxRjkvPs5mwvd6CrH
        7z9rOTnjKlydFQyzPkbcjrzAaaQ2GNmdpTwAvLahMcE73nHo6UN05arwpX24vYrH
        RpneReIPqGNgSuKv15MyhERII7vvSmGUoft4OiFwORSNo5Y4ZEa5yvtmgZNqrUPR
        SJngt7NP20Jf+oXSeFLYF8EBxpbW/zLGkPqamKkkvQ+a+R0oYGw+x1u5adSiibpw
        ==
X-ME-Sender: <xms:4YtDYlD6LQdvMQ9sswTjw_7prLTLqYC3KQCJKhB20KH8tLFnlsuCgg>
    <xme:4YtDYjiQLce2zfDBDgYe8qVf9qfj2eeID6_L_-Dh4Nxm_ZYy3VpNePhLsfgW9lEWs
    vFlQhEUtc1AV7Lb7Q>
X-ME-Received: <xmr:4YtDYgkQ-ThbA0GhEqT_qHLxp9MFyiBCjRa7UZzaO2_PltdzxDxx67SZuERT-cF0XFyXUpY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:4YtDYvxVo-HaFQNboPlmiBdCYB5XsoBMvos677IEuhIg8HEaFk_U0g>
    <xmx:4YtDYqTIX9rneSB1d8TrEWjif_wgP3xxtReUHLLqEsxqfna7d2xb1g>
    <xmx:4YtDYiZiIrk6CbVqf4i037V0UcM3fsWNA7MzxVh83j6UWtQ3t7LlGQ>
    <xmx:4YtDYnSYezm_UxXdq_V59FMVTgc0CzzedxqqMObhOsGKoEMUb7MgQw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Mar 2022 18:44:47 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com, greenfoo@u92.eu
Subject: [PATCH v8 2/5] vimdiff: integrate layout tests in the unit tests framework ('t' folder)
Date:   Wed, 30 Mar 2022 00:44:36 +0200
Message-Id: <20220329224439.290948-3-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329224439.290948-1-greenfoo@u92.eu>
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <20220329224439.290948-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new test case file for the different available merge tools.
Right now it only tests the 'mergetool.vimdiff.layout' option. Other
merge tools might be interested in adding their own tests here too.

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 t/t7609-mergetool--lib.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100755 t/t7609-mergetool--lib.sh

diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
new file mode 100755
index 0000000000..d848fe6442
--- /dev/null
+++ b/t/t7609-mergetool--lib.sh
@@ -0,0 +1,14 @@
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
-- 
2.35.1

