Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471131F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeJOFzn (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46759 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeJOFzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id g32-v6so16034608edg.13
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s6OjoA8rBBGQxbFi3RGbS6742xIheaCVIwfbZRwvsEE=;
        b=XqFdCSOGTm6vPxTJAuKfk1WycF+3RhIYvNhAqcPEuIykXWJIaXnHucj1j9bSKEHTmn
         3LayszOiWLnq5netyFCmyPTGeSVMKt6lfWABDwQypSfguXvlKbg8QNiEBnxW3pQnyWe7
         zna/VAfxVYrKc4ORNKjrBVao7FJLGGqiMF84XiItuXxcFFHkGtEUvm9l7qGEdhqDCj57
         Fg3jrHP/6pzb8Mzv+0qtZRrH8jXnR0kb0EcIZ8egbHee7lFprOGqgv1g+UcUzJKakLLu
         FkpxYBwSwMpNHzrZyJyiWtzP5uT0OTCVOpDTQo3Z71pdk+7acVncf/UClhBUxCOUDbkj
         mzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s6OjoA8rBBGQxbFi3RGbS6742xIheaCVIwfbZRwvsEE=;
        b=gf/4FQd8lHyKqpa728SMxcg7aQS/lOPJfyOtN/t26SIDCO+H1MwO09jw6KQsqLT+9S
         Xl8sVn4RsDDon6bXvsbHIgrGq6meBKyTqthRiXoCZpVTNEMRxfcCEsKkuO77Lj8PfAoA
         Thlxzj93P4YdT3n5xu7RushBoje409oAA2EArxtceYG1r7pYeZBVFhlYtkSh5twDQSM1
         pyqOCjImXhC9GHbiMoA0mX28YYMG4r4x8YNcesumOOakITW523i0jaNxmo05zqNb9OA9
         dwxqiJphWT4M9VaOrHCGNFukh/GcMrjgjfeskAkBhSXFQRIMd6p+x/kq/pyVE7G8HCvU
         IMbA==
X-Gm-Message-State: ABuFfohouR2T5m18P66WJiW3JyRrpY64MFK+xQv2or8LwTDBD0dDLIh3
        mrEYA4mxu6fk/0UxgemW8I7ZTvX+
X-Google-Smtp-Source: ACcGV63Fvrp+h5p1JjTCx3O/9atnESKNW8xlbxuotLdWA1wbzx4HGA0V/GqmPWlx+lyF3X8maObYNw==
X-Received: by 2002:a17:906:454b:: with SMTP id s11-v6mr16290881ejq.83.1539555195244;
        Sun, 14 Oct 2018 15:13:15 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:14 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 06/21] stash: add tests for `git stash show` config
Date:   Mon, 15 Oct 2018 01:11:12 +0300
Message-Id: <60d86c0637da9e3fee99b56377a0f54712473d24.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
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
2.19.0.rc0.23.g10a62394e7

