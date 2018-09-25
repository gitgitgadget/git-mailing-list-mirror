Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF8D1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeIZEoQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:16 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:46919 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeIZEoO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:14 -0400
Received: by mail-ed1-f50.google.com with SMTP id k14-v6so156512edr.13
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oWXFQ8MjrqjSjjC4mWz5gcf4HKxOyLRVeYXIgbl5k5g=;
        b=W3dC5um3OWCR4vBjXtDD4B5EBG2PHs8qhbeOoHwoPv0+Ot8/R9bxin9TMv5HTene5n
         qnqX59OvCWdg3uXKP2It/lk6HWzlTJg0ukAJ9oq6xoZYqK3PrsnWX11nTqbqZefqaYWs
         Pz9IAVVvjdWopVayikubrIeZlUEDwUocFmPavZK44+4Wes6PN6EESk3EKK896Z5V73CN
         A6ycaFhtbc4zW60sYhwmPeOl+FGHYtT5ZfizVd/t/oPTWWM3DCmcAAMdLVnJ/MDW8Gxo
         ApNGPehokVB4xtKo2dCxvN/Dw6tJhfPLMjfdsGWnbco+ETK1WKgsdd6/8gFVno0CH4Da
         Rmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oWXFQ8MjrqjSjjC4mWz5gcf4HKxOyLRVeYXIgbl5k5g=;
        b=LnyCgeZhzgl/AteIRg9eSH0jFW+b6ZbRlqeQvLjyBGucAHFfgSRn3rzEcMBjt8Jrcs
         LCdO+9RkNDgnrt77CdQo01YJYGMjlGyLLfyGs3QYz91ahNWS42qPmKUygZ/V7Iw+nNiL
         b5kRo8SwR9iV7MS59V6J45wobQHfXi+oafQYvKQwgA3tSavhJ6o5L+fwZRLYwGwxf8AD
         JUK/0AcBRkIa9r/EUUuX/G3LDI56w1iJQQL+o0MpUgLBXzMrQU3jBjxAtz8HeR6yUrBZ
         +rj6ng7qr/roZMNon0Vvb/nmBZ/l1Ddm4cRuTQ7dKUSzsM42qSAC2wbTKB6Dvjqw8Jjd
         EtWg==
X-Gm-Message-State: ABuFfogpriP4cgf5xZjXKhB1Wz2yYPtnHpsDsi+xiWklM+rxIqHhk68y
        xsFtl+a0dn8QacYe3/CczkbxpTdP
X-Google-Smtp-Source: ACcGV62BHDj0Oxt1W3xp7cHNYJVVNDNvzhU24ElgFLt8E+ZmjAgo6j3hDJr+Roh8OsmdevU9HiE57g==
X-Received: by 2002:a50:8ea1:: with SMTP id w30-v6mr4755468edw.197.1537914868559;
        Tue, 25 Sep 2018 15:34:28 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:27 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 06/21] stash: add tests for `git stash show` config
Date:   Wed, 26 Sep 2018 01:33:21 +0300
Message-Id: <666ffbebb75a2d142023271d10ceb17fb6613a28.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit introduces tests for `git stash show`
config. It tests all the cases where `stash.showStat`
and `stash.showPatch` are unset or set to true / false.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 t/t3907-stash-show-config.sh | 83 ++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100755 t/t3907-stash-show-config.sh

diff --git a/t/t3907-stash-show-config.sh b/t/t3907-stash-show-config.sh
new file mode 100755
index 0000000000..10914bba7b
--- /dev/null
+++ b/t/t3907-stash-show-config.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description='Test git stash show configuration.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit file
+'
+
+# takes three parameters:
+# 1. the stash.showStat value (or "<unset>")
+# 2. the stash.showPatch value (or "<unset>")
+# 3. the diff options of the expected output (or nothing for no output)
+test_stat_and_patch () {
+	if test "<unset>" = "$1"
+	then
+		test_unconfig stash.showStat
+	else
+		test_config stash.showStat "$1"
+	fi &&
+
+	if test "<unset>" = "$2"
+	then
+		test_unconfig stash.showPatch
+	else
+		test_config stash.showPatch "$2"
+	fi &&
+
+	shift 2 &&
+	echo 2 >file.t &&
+	if test $# != 0
+	then
+		git diff "$@" >expect
+	fi &&
+	git stash &&
+	git stash show >actual &&
+
+	if test $# = 0
+	then
+		test_must_be_empty actual
+	else
+		test_cmp expect actual
+	fi
+}
+
+test_expect_success 'showStat unset showPatch unset' '
+	test_stat_and_patch "<unset>" "<unset>" --stat
+'
+
+test_expect_success 'showStat unset showPatch false' '
+	test_stat_and_patch "<unset>" false --stat
+'
+
+test_expect_success 'showStat unset showPatch true' '
+	test_stat_and_patch "<unset>" true --stat -p
+'
+
+test_expect_success 'showStat false showPatch unset' '
+	test_stat_and_patch false "<unset>"
+'
+
+test_expect_success 'showStat false showPatch false' '
+	test_stat_and_patch false false
+'
+
+test_expect_success 'showStat false showPatch true' '
+	test_stat_and_patch false true -p
+'
+
+test_expect_success 'showStat true showPatch unset' '
+	test_stat_and_patch true "<unset>" --stat
+'
+
+test_expect_success 'showStat true showPatch false' '
+	test_stat_and_patch true false --stat
+'
+
+test_expect_success 'showStat true showPatch true' '
+	test_stat_and_patch true true --stat -p
+'
+
+test_done
-- 
2.19.0.rc0.23.g1fb9f40d88

