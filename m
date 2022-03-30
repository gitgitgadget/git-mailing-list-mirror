Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7334C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 19:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350585AbiC3TVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350691AbiC3TVS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 15:21:18 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C315A1F
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 12:19:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 26AC03201F86;
        Wed, 30 Mar 2022 15:19:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 30 Mar 2022 15:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=Xzui5rsaW1vv/ampjOQkbmT4wzzlMs
        y7x1WClz7l+HA=; b=B3e41X37hQIpbYthe7ngeGTkOOJoVg8/UoaB1KGSWHzmLj
        3YmFkB6ogAkDLDKlsoh9320FNoDAZC6BdPKA2BSFG775vtxnJIblYJIQEBYYBjBP
        ORLXeBaL4cVCfRj+8v3DfZTaUu0mCn6B9I7U8vQq4oLw4HHboCRsOOHdVUo1IaEZ
        lYXLkolY7ve9u71O0WpGY8+cN/QB1rHKIlXTavtkKMJqfRvFDWVyT5POTC5YwzP4
        C+AePzwbWQdt04pFNE54zLuUwEZ4QXULM7LzkhBxfBxV/9P7Lab2ylkV9Mgbeupp
        eaJLlhomFIlanCEdKvSlq1pVsnXNZ0qIGzequljw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Xzui5r
        saW1vv/ampjOQkbmT4wzzlMsy7x1WClz7l+HA=; b=gugoW+s7AJE4MTKuloNBxX
        jXe/IWOAy2Nk49DGpQZyPyCsdZxDMFuX4+0Y+xfNq5D1eNuMnIP74YLcsG9i0AU+
        eb1OPOPrL7ryOsywA0AQmBLIphFPgRvdOju0Ic2FFpeV4y2tcRgnx8QEUd3+32gm
        5xcwncKIigG4OheOUz/glLe24uc0FBfV8CkOilvPxHuF5QR81CPrvWCgu1DvkvXT
        8OUQRPDEXvozqR9TiYZYXVNMxUuXHqWMSMMt+EbzJfY2I/UMNoLZrxw+Zvmco4pH
        8xneYBN844A8tAb111ijZgcPMB/+Y9soZagQUe+U+B5ZSa38CxxBdB5kD+sNEJOA
        ==
X-ME-Sender: <xms:O61EYhP9zO40cOZtqq8Ph7phsmDEAubB6g_8hXldSGt7Xuj0hypiLg>
    <xme:O61EYj_vIOgPf4UqB-ZDoIiT4_SeOZRqbWMGqmTFHIi80mGr2RWjw6lmVX0M6lz1L
    CGVfqB8v6KvawIvnQ>
X-ME-Received: <xmr:O61EYgTQbJQqj9P0dRoKGkqVMlGreO1-7BzD5i1BhvbgY5IiDxF5sHS2HPYRM9oPBis7Eac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhho
    ohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpeekleekjedtheejheekfefggeevvd
    fgueegffeuveduhfehueegkeeijedvvdejfeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:O61EYtuVy3UbeLP8IzdR4FTRs6EOsgg3XFrTUVMbyc8C_Uoh5idISQ>
    <xmx:O61EYpdUeVzJk9p-tv5SadSgkIPHrrk8ZVK_m9IMKt44HlnnPbEFUg>
    <xmx:O61EYp1Kw89fhhC3gvQANB2vNPc4rzxzl0f3whOpJsdkyzRssZJg1Q>
    <xmx:O61EYjvHMC0M4IuZvzDcBrPWZ6GHcGLYZyuyeT1QR0j9TJ0xnpMO_A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Mar 2022 15:19:21 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com, greenfoo@u92.eu
Subject: [PATCH v9 2/4] vimdiff: integrate layout tests in the unit tests framework ('t' folder)
Date:   Wed, 30 Mar 2022 21:19:07 +0200
Message-Id: <20220330191909.294610-3-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330191909.294610-1-greenfoo@u92.eu>
References: <20220329224439.290948-1-greenfoo@u92.eu>
 <20220330191909.294610-1-greenfoo@u92.eu>
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

