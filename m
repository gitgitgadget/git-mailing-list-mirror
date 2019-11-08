Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28F31F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 09:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbfKHJoN (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 04:44:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36731 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbfKHJoM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 04:44:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id v19so4231856pfm.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 01:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LLzDtpst56qSBMMluFonWzNqrGxP4CrCsTzz0xGk6Yk=;
        b=AY9TW298+RoxconG3OafUzp3ogEyLOdI4jbI5puTesZyS0LgV5z/jvmtcsVxDeER3B
         O2IwjIlRoPj4fPvVak9jzUy9nQNg9ZTqfR2Nrtvlrfwu+M11wAVBxZTNcZBGK+W/HnI0
         Zkya3QQwFy0bKCp4co7t1gYxHwyhr9OuXL9U1lpfdQDUvKVGZNXt3CBLqULSrl9eQPii
         u6LE5igZt9DLpBMldHQCXXYymLmk5XBytMXohX3YsbNvGisQDrNfyfXfnOZmZGjHTxyj
         iyLcFTkpPbAQ44CWytJE9s4iRSkd68BQzLnwNrTolckS3VhuomPQl3/XjBxPnQx+mW2E
         /sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LLzDtpst56qSBMMluFonWzNqrGxP4CrCsTzz0xGk6Yk=;
        b=X37XrVuF+F4qGV2uML8OQHGaYw0qW0mHwGK+TqAieO5R3L4LaH6trQ5yPrFWCYwrW0
         lHvMMH+RAQdB/gaK84AA89KrXhB3DPB+IGzndYePypwWTGiMFFMWp37TtNDXEhZydl3S
         zY/AKIQbR1enczTH4lx7moAJFrCVcWTZjG+C9vk9Bzem+YwA91Th9Rn5RmFIHdrJq6F/
         n+nQE/mznxsZWEX5LjWmYnYIHnvxKTm9XQgu59nTodbo86xQkw6TugKCywOMWcT2PZiS
         tI9LkhOsknMYpZ3FIM0UbMa8NUzRKc6NXbXMk8tAbpxGIkp+Tpzn1wtXwZyEuqt90xf5
         AVjw==
X-Gm-Message-State: APjAAAXfRrPQnkBPwp84LOGCeONCh+hfPv36HWI7G6nclpV+VNj2t9X/
        SZ7y5V1+vdqKG2mnr2Jfb+TgKSKv
X-Google-Smtp-Source: APXvYqyh842mFwxWHjASR7XA560WEJQHDducj3dat/vez9NbdJuMcNZvtv9BabkY4qFs769YsHq04Q==
X-Received: by 2002:a63:535a:: with SMTP id t26mr10943028pgl.215.1573206251569;
        Fri, 08 Nov 2019 01:44:11 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id e198sm6995821pfh.83.2019.11.08.01.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:44:11 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v5 7/9] sequencer: reencode old merge-commit message
Date:   Fri,  8 Nov 2019 16:43:49 +0700
Message-Id: <def9adf97ecb946a2cbde94b3eed742c17eb46c2.1573205699.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g2e95ca57d2.dirty
In-Reply-To: <cover.1573205699.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573205699.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During rebasing, old merge's message (encoded in old encoding)
will be used as message for new merge commit (created by rebase).

In case of the value of i18n.commitencoding has been changed after the
old merge time. We will receive an unusable message for this new merge.

Correct it.

This change also notice a breakage with git-rebase label system.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---

Notes:
	eucJP.txt is copied from t3900

 sequencer.c            |   3 ++-
 t/t3433-rebase-i18n.sh |  57 +++++++++++++++++++++++++++++++++++++++++
 t/t3433/eucJP.txt      | Bin 0 -> 68 bytes
 3 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100755 t/t3433-rebase-i18n.sh
 create mode 100644 t/t3433/eucJP.txt

diff --git a/sequencer.c b/sequencer.c
index 833a928929..d735d09f98 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3374,7 +3374,8 @@ static int do_merge(struct repository *r,
 	}
 
 	if (commit) {
-		const char *message = get_commit_buffer(commit, NULL);
+		const char *encoding = get_commit_output_encoding();
+		const char *message = logmsg_reencode(commit, NULL, encoding);
 		const char *body;
 		int len;
 
diff --git a/t/t3433-rebase-i18n.sh b/t/t3433-rebase-i18n.sh
new file mode 100755
index 0000000000..bff5a68d25
--- /dev/null
+++ b/t/t3433-rebase-i18n.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Doan Tran Cong Danh
+#
+
+test_description='rebase with changing encoding
+
+Initial setup:
+
+1 - 2              master
+ \
+  3 - 4            first
+   \
+    5 - 6          second
+'
+
+. ./test-lib.sh
+
+compare_msg () {
+	iconv -f "$2" -t "$3" "$TEST_DIRECTORY/t3433/$1" >expect &&
+	git cat-file commit HEAD >raw &&
+	sed "1,/^$/d" raw >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success setup '
+	test_commit one &&
+	git branch first &&
+	test_commit two &&
+	git switch first &&
+	test_commit three &&
+	git branch second &&
+	test_commit four &&
+	git switch second &&
+	test_commit five &&
+	test_commit six
+'
+
+test_expect_success 'rebase --rebase-merges update encoding eucJP to UTF-8' '
+	git switch -c merge-eucJP-UTF-8 first &&
+	git config i18n.commitencoding eucJP &&
+	git merge -F "$TEST_DIRECTORY/t3433/eucJP.txt" second &&
+	git config i18n.commitencoding UTF-8 &&
+	git rebase --rebase-merges master &&
+	compare_msg eucJP.txt eucJP UTF-8
+'
+
+test_expect_failure 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP' '
+	git switch -c merge-eucJP-ISO-2022-JP first &&
+	git config i18n.commitencoding eucJP &&
+	git merge -F "$TEST_DIRECTORY/t3433/eucJP.txt" second &&
+	git config i18n.commitencoding ISO-2022-JP &&
+	git rebase --rebase-merges master &&
+	compare_msg eucJP.txt eucJP ISO-2022-JP
+'
+
+test_done
diff --git a/t/t3433/eucJP.txt b/t/t3433/eucJP.txt
new file mode 100644
index 0000000000000000000000000000000000000000..546f2aac01b67e39d19de601f5586097b34a8325
GIT binary patch
literal 68
zcmZ2-e#x69mzLaKa+Ql~$@V43mMmHFddayZYZfkovW_oY%ys|3$+JKuZ<btN@@mOl
SAboGi<s}<{?6*s90HpysEiSzP

literal 0
HcmV?d00001

-- 
2.24.0.8.g2e95ca57d2.dirty

