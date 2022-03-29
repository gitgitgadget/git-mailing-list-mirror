Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EFDC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 22:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbiC2Wqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbiC2Wqs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 18:46:48 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D9923D77D
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:45:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 20A403201FDA;
        Tue, 29 Mar 2022 18:44:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 29 Mar 2022 18:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=SB5TLn8ylwSUHx7rUqZ5aUTxEPBsAI
        a80DsIVz4FoY0=; b=KA/t7ne3tO2fciUfCcGzehNVhUcr4JpLhEGc4WTvY7SIPW
        FPOOaK7qSBG/bQb4MGU0oaCk61Y/tql5HSpesDUEJtn5vYV0mxJ1mOqznKbYO5BR
        B3kqvgGetj+cjVfVMtHgr2mXTA3VkcfVGshyTLhqEjDE8Ero0MzcIT06m0Iy1vrE
        FYx/Lu1RfcMSvHWr6pYO17K/MNQTh2KFkNqYkGF4Zg8l5qCHNRHcJ7lsT+Uk+y7g
        lSjkCqnAeCXH/QeJOM+5kFMq7yxZEz6SjWPoImXStL8B6v7KvYJiIJ9MAzM3lCBs
        LoxcFIxXmz271OhrPFm08XgmZQ3MaCNh8LbLeBhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SB5TLn
        8ylwSUHx7rUqZ5aUTxEPBsAIa80DsIVz4FoY0=; b=iAbQaWpDin4+O8FmVHUMqL
        ZTf1mBsO0uDqp7v0SdZOAJuLn+Lj6HxiiuimlsWxpm8qp07IzIUKEV9upmLRFJbl
        jNW+N/KhqS9SUYWTCwQmXKgfzYQv0gA5A7gj8RJyN1+QfAVhYLgJwAA3fa56aYeI
        fJmIHSvXr63xzjumWGHmqI01JB8l0b388qTgWbh+VepyZa1iGJ7Met5TliQ94ON+
        2eDPkvbfGUGGsrPCSacfD8T1HfRQIEJeDUEl9qqvYZwYtOjP1iCq3NDhPmcbQ+BK
        y4QuJdx8lVb7/4KnEQrdRCXCi9RELm8KqL7LOxu23cGsmcvTkcd6B/XX7LvBTTQA
        ==
X-ME-Sender: <xms:6otDYn8l1ugarX7Ia-K6lztadmYceM2VMs8igvL2z_iqnzOOVK9C2Q>
    <xme:6otDYjst6INyE2p7UTWv0yG2Z7s7oB679pk-7Bm21winFg-Tdt920pnBOOSlfOJCN
    QmpHsu1EA8LQWgjrg>
X-ME-Received: <xmr:6otDYlCcQpZigbmJW1ubkN3no-CBQOPO0x5kH_Cu1zdbo6d4GyRaUTg-X3mKpKXev1epXH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgepvdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:6otDYjfab5E6EH29AUEQdkP2KT1pfXYnCFDzpacxS1UVEW9uSXuf8A>
    <xmx:6otDYsMXpYPITzteOko7ZzlA2akb7yaD1Fz-Z9yMCZDRBS12dSxYGw>
    <xmx:6otDYlnsTuPtNRPmg8GxgZDHCIf-_A-SL92cn4HEcKa0brHwK6NGAQ>
    <xmx:6otDYjd8c9-veVUmW4MexEvnyz42qOXStgkHV5L8iXiTAoebmt2REw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Mar 2022 18:44:56 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com, greenfoo@u92.eu
Subject: [PATCH v8 5/5] mergetools: add tools description to `git help config`
Date:   Wed, 30 Mar 2022 00:44:39 +0200
Message-Id: <20220329224439.290948-6-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329224439.290948-1-greenfoo@u92.eu>
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <20220329224439.290948-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now the output of `git help config` not only shows the name of each
tool (as before) but also a short description (as it is the case when
running `git mergetool --tool-help` or ` git difftool --tool-help`)

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1eb9192dae..faed285462 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -302,12 +302,12 @@ $(mergetools_txt): mergetools-list.made
 
 mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 	$(QUIET_GEN) \
-	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
+	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && TOOL_MODE=diff && \
 		. ../git-mergetool--lib.sh && \
-		show_tool_names can_diff "* " || :' >mergetools-diff.txt && \
-	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
+		show_tool_names can_diff' | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >mergetools-diff.txt && \
+	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && TOOL_MODE=merge && \
 		. ../git-mergetool--lib.sh && \
-		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
+		show_tool_names can_merge' | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >mergetools-merge.txt && \
 	date >$@
 
 TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
-- 
2.35.1

