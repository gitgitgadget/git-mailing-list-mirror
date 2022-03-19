Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E75C433FE
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 09:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242559AbiCSJNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242550AbiCSJNV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 05:13:21 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281978FE57
        for <git@vger.kernel.org>; Sat, 19 Mar 2022 02:12:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 393A23200EF5;
        Sat, 19 Mar 2022 05:11:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 19 Mar 2022 05:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=nNLuRHjYNZ7pgjwYHKZRKV4orR7DHv
        7aoTqWOP5zTqY=; b=RdHL02PUCGOExZKZbRjGSs3S3UgequpF5Vn1C07L1KqOOo
        tUHE1YNyKs143JoIMNphvagj5bFxvhYiJpGOPxJtgHOgcLGr3WjTwQ1R6hAUpWIl
        Yk1uphofvlEhzsmMPooVOdtP5MJu2l4Z9uNH5B1yr5C1PFRoXbfhetRrapXNRqgJ
        BUpkPDMv2Q4Ear9Uycekt2qM6MyLfSxC+gdZXydGchv9B7YaM4wHk8FoNpiftiQl
        g30OXGYIcReyWIzjdS/qPS5LJq6c+iqGkqmMpi3ANLxA4wsyFseTgewTvZ1LjKen
        CjyiY6ng+i++636k7JpHCk/Yb5SUe8irERxSrzfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=nNLuRH
        jYNZ7pgjwYHKZRKV4orR7DHv7aoTqWOP5zTqY=; b=eswQiZMObow57qbZ1zjvcd
        9w5LvWEuUvcMcekXrXq9sBTBs4x+FlagNDg87jDsqeei7TMlbWOtBP0S/N8Tpod3
        x1VDk0BDnJtTdk9gEokpE/g7D0qHNBGVsJYo5qbAdU4y6LDghn48bd1gdLfBYXFq
        eo7Egj09e8p2TPWZDJdaaDvIGQm4rhdAs23VLOIKZ/VvfPJgtPTu+CnYrO96VjUD
        6I5j96Fw/ahaRpq1Tne9m40qdoEJddW21rQw/qKLV+rvNCTLEp2jZ5lMjFvB81xx
        8vDxVtQmHJcSm7/pLqlMKf28aRPTZsdQuVgjg7sanSyNIkzAP/9oJWQBTvsIPPWw
        ==
X-ME-Sender: <xms:Xp41Yl9oems93AUucSUD-C05YqRFEIqi-i_K7WgG4ZR29BtjCV5cOw>
    <xme:Xp41YpvmbZ60iKgxzs6FkpLvAGckODO-zbIMsdgYzY71G5VMr5dVz9kdYwo206BnL
    8SLfr549u48t50cuw>
X-ME-Received: <xmr:Xp41YjDKPiqRqXGGZT6G1lQg03ISacz5YZYuDm5o1G4ALmzLtWQxr3DqulpbL1dDzKx_DsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefkecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertd
    dtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhel
    vddrvghuqeenucggtffrrghtthgvrhhnpeekleekjedtheejheekfefggeevvdfgueegff
    euveduhfehueegkeeijedvvdejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:Xp41Ypeihq-FrRMNc44brfSq4bP_jNHIlqy9FfDe3oA-93Ml_P9R_A>
    <xmx:Xp41YqOo3sOfDqo-t9D-3DC0onIlB6CZpBSwPsm-eBZNl3tsWm2wag>
    <xmx:Xp41YrnbesK1IPTevjOhgQxuZyuU0nQzYo9rvCQx6lx2C2xFsa0hdg>
    <xmx:Xp41Yh1Af489JjMEUh-V9Rn68w31SP6yn0L6sk6Mhnqm_dZmSpbyZQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Mar 2022 05:11:56 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: [PATCH v5 3/3] vimdiff: integrate layout tests in the unit tests framework ('t' folder)
Date:   Sat, 19 Mar 2022 10:11:41 +0100
Message-Id: <20220319091141.4911-4-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319091141.4911-1-greenfoo@u92.eu>
References: <20220319091141.4911-1-greenfoo@u92.eu>
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
2.35.1

