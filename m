Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70DFC1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 06:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKKGE1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 01:04:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34459 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKKGE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 01:04:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so9974062pff.1
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9NniXLoxW9Lgi4XgbeMQKMLTukToMqqx89//Cnr+Tqw=;
        b=LwE2Xa9uUd4AIn5ExBYaLOz2sBD6JePoh2ghgCrV3LKHjIvAPCPr60esR7w8YAGjv5
         zYiqoxZLBY9QXHLYZjFPFNiRte1MK4RDLVwA6dIRQOD+ERBmNK0xjtSkmb/p7uuIHrOx
         kr3RqZxsV+ZTQI8jC39xVzgvWLBJdAU67g4DiAUOo+ggj6ioQtlNbPB6/psZ7epmG5qI
         Y2jJulupaUYJH07cl1+n600JSpnSh8UCrSi3ZNj4SJIF3UYR6vLcN4KT66iXdBAbG6KT
         hnz3UuXe6dVawBfkX+ROGdUnhk7BvNVUOpP55GKquiD/nTjmzuJnm96F3yvmLhtdYXLk
         11Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9NniXLoxW9Lgi4XgbeMQKMLTukToMqqx89//Cnr+Tqw=;
        b=m6rxqMWZ2SeEeoMeI8G8kjqnNvIJsvwOEZv5Jbd4TkLBHUERu1ml1D43xxXiUoPTQv
         dNau7efcCcaUeRgAG4kSQ1+hTApQb+ycsMM+vrscGrVnMbU2tHiL+Iaf8OT4pO3YzGlA
         XG1GcA6NUTZIuluNsrk9q74zS4fhd+lGTvc+J+xnonMS+LhML5tNreeHVWOIldAY0ILE
         XxZeVxg5p/ZpZ/Yi0OyRFYWom+H2btH7kh39TXf1h0avXV1qmzbmaQ0seJHmhn1S5XV+
         +IAaNMlBnvwLMfNdrRFLK4i+jlUSYctZlVrgjoYVgE6LyRZdY1tTRG9vfbyfzCDIcoqL
         ogxA==
X-Gm-Message-State: APjAAAV8tFHIvX+RNWFijfXCkoxZ1sQquxy9P78myaPgrjNH2UT14sAG
        Lcn5wPfUN4vBRx/qkcCCSK6N0Otn
X-Google-Smtp-Source: APXvYqzIi74Wz8xMR+NFC1keORvD84sp8/6YcFb7fiRhy+iNivXQzPk7C9YoXs4ILUo4GCi7jqmdXw==
X-Received: by 2002:a17:90a:c004:: with SMTP id p4mr27698290pjt.104.1573452264038;
        Sun, 10 Nov 2019 22:04:24 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id v16sm15112315pje.1.2019.11.10.22.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 22:04:23 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v6 7/9] sequencer: reencode old merge-commit message
Date:   Mon, 11 Nov 2019 13:03:40 +0700
Message-Id: <4dfdd4b83ed0cf59ae1a4e888ba1f7e4c7d1f80f.1573452046.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.164.g78daf050de.dirty
In-Reply-To: <cover.1573452046.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573452046.git.congdanhqx@gmail.com>
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
 sequencer.c            |   3 ++-
 t/t3434-rebase-i18n.sh |  57 +++++++++++++++++++++++++++++++++++++++++
 t/t3434/eucJP.txt      | Bin 0 -> 68 bytes
 3 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100755 t/t3434-rebase-i18n.sh
 create mode 100644 t/t3434/eucJP.txt

diff --git a/sequencer.c b/sequencer.c
index b5712e59d9..18bc4d515d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3372,7 +3372,8 @@ static int do_merge(struct repository *r,
 	}
 
 	if (commit) {
-		const char *message = get_commit_buffer(commit, NULL);
+		const char *encoding = get_commit_output_encoding();
+		const char *message = logmsg_reencode(commit, NULL, encoding);
 		const char *body;
 		int len;
 
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
new file mode 100755
index 0000000000..c6c16373eb
--- /dev/null
+++ b/t/t3434-rebase-i18n.sh
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
+	iconv -f "$2" -t "$3" "$TEST_DIRECTORY/t3434/$1" >expect &&
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
+	git merge -F "$TEST_DIRECTORY/t3434/eucJP.txt" second &&
+	git config i18n.commitencoding UTF-8 &&
+	git rebase --rebase-merges master &&
+	compare_msg eucJP.txt eucJP UTF-8
+'
+
+test_expect_failure 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP' '
+	git switch -c merge-eucJP-ISO-2022-JP first &&
+	git config i18n.commitencoding eucJP &&
+	git merge -F "$TEST_DIRECTORY/t3434/eucJP.txt" second &&
+	git config i18n.commitencoding ISO-2022-JP &&
+	git rebase --rebase-merges master &&
+	compare_msg eucJP.txt eucJP ISO-2022-JP
+'
+
+test_done
diff --git a/t/t3434/eucJP.txt b/t/t3434/eucJP.txt
new file mode 100644
index 0000000000000000000000000000000000000000..546f2aac01b67e39d19de601f5586097b34a8325
GIT binary patch
literal 68
zcmZ2-e#x69mzLaKa+Ql~$@V43mMmHFddayZYZfkovW_oY%ys|3$+JKuZ<btN@@mOl
SAboGi<s}<{?6*s90HpysEiSzP

literal 0
HcmV?d00001

-- 
2.24.0.164.g78daf050de.dirty

