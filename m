Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4E020248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfBYXRE (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56100 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfBYXRE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id q187so579522wme.5
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoQd5EyOoEuw6mIodw5i3+zkiVGN2E5J9WPR1tTHSBQ=;
        b=tDjvlO2f8ndOaCOwRui2/z8TY/E4Cro25fpGvMdDxd+QKQoFI4wCdfdJqyqlBvyWl2
         VfV5ew2Q/1K7nVVhHpbs6Et2U5x6YlL1RknIk9U5ztvHD7ydirSowHlr7AYpGadSjcEu
         JjhVXj9a0H/utB35YkvvQ1PVJXveP5y2l40KfbzKYN7MkD9DR/AEzlbt2c7mkHBXShG7
         ZriWeofj2SkLTWYamjJEsSm85vaXUPnYfEvz6FCTX/RUB+drKtbz6dnRuGM5aZrzDmtv
         0SWTgXCt2llHvPZv4cEkY6uaVsFRGkU5q3ICvJpi2/8CNWxC+RGKO0O8yyc+c8MO/vca
         6OQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoQd5EyOoEuw6mIodw5i3+zkiVGN2E5J9WPR1tTHSBQ=;
        b=fUdJ2b6772oSM+kiy7LbyqN8ZgXnuBN4oRP/ZDQTTOMs/aQkXDRcejgtG5OXZlxGNk
         axP5oYGvSdbmSp13MibSMZ0/rzmzMNsTSRUxXkl7nD+0hQSn5FPRbf2Qvb1WRXx3gN0v
         P+16VZy51FDzVizqMARFb8tJVFRvRN+5Yh3JFZJp4rIPfYLgQOfL/jk/ujVaCMDIidHM
         mSzG3BUoOG2qDdbBaYVyXLtv1v7bomIpok26ZQiEeMEWxgGjxK0Kmg7lsA2p9q2szO97
         TfP5CgjAl2BSSEH9n6AdvSGOjp1EXT5GqwjYiNoXDK5Zw15f1eIDH6wKIKHq/hNZ9w3u
         ngHw==
X-Gm-Message-State: AHQUAuZf07GNzDFrNjqSA5CteDz3d4EvMYa0VlmP/PZFkXclFyd3kVJl
        sNY4/Pe0WQOVH3j0Py4eDXzTm6v4
X-Google-Smtp-Source: AHgI3IYrns4FVwwIeR5e/ROzxGYEfN8FX0XodTU5cycHsc4Pajd7Qg4M2QMqoVUAUVQ05SdVevzMrw==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr665140wmd.110.1551136621272;
        Mon, 25 Feb 2019 15:17:01 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id d15sm22613442wrw.36.2019.02.25.15.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:00 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 09/27] stash: add tests for `git stash show` config
Date:   Mon, 25 Feb 2019 23:16:13 +0000
Message-Id: <20190225231631.30507-10-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

This commit introduces tests for `git stash show`
config. It tests all the cases where `stash.showStat`
and `stash.showPatch` are unset or set to true / false.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
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
2.21.0.rc2.291.g17236886c5

