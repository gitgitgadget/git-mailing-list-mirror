Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EBBA207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 17:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbdDZRDz (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 13:03:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33972 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbdDZRDx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 13:03:53 -0400
Received: by mail-pf0-f196.google.com with SMTP id g23so1385551pfj.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T12TyrWUuxpLFsWV+d497hczQRwIUh8kGfmtsggauUc=;
        b=sVs1bdcLodwnOTsbHS4OXzHFQSqzZSxS1PPW2MYw5e1OYcUrrVBg/Ji8DiKrXJfLsS
         QFR+aVa11a/Cn60lPVd3yTKMCew9lPVHx9KhuK7SZG+LBaUOMM80ImBdaW3opFxRl6Xk
         yuWoI3Fr0I/jRA7TNZLjNrHTq3DAdR2qlXHQVE4KzByARVl3yrBsN9Fp5AftVLmsX1+I
         hunIoLe0s2QoyzsTNxaPG5PtP+5l5hSVnPlkkuMdioa6U/8RoGIsxY45LQIwcDA+vsma
         Gyqj7sho/8gw40vF+MrowkPKpngpbmBfsTWJ7irHJPvk7/PECFM373rghEg/5pPHfy1l
         tbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T12TyrWUuxpLFsWV+d497hczQRwIUh8kGfmtsggauUc=;
        b=n8J+fNuFbrvOrwfaBcmJgPt4nTRnBgIr1b8S7eQk11aCRbfzvyTvt5iXJNwrt5kFO5
         EKUg8bNXL3RgBbctrc7Ij1yOMzGFjIfMrMq7/2BJ0Q2wG7GlWWSPmf7I/FAjljpIG0Ij
         Z/7Rs9inRyOpBLiHZXe2kSr423sJuvTBQux4kzTKxh7bUcjFf2SBT4BTIaHctriQxu8C
         xz7Qb86n3FSH25oiCS1w6Dj5xjjFTVIxgorWTQOIjrFdmp8UuV24siccmd/BmnypYvwT
         8xBKnQ6Neb8+gBG2PYBOy3BEjOYdJUw7Hl4dlh+pTGMoE9ZLxxTrlRS89jA9a2e8sQSB
         LHCQ==
X-Gm-Message-State: AN3rC/5gdHROZrJIDgqzbeK7U/ELPO0wE41MO7k9+46oqMupuXueilA/
        jQ2emovNNQdGLg==
X-Received: by 10.84.137.129 with SMTP id 1mr1034533pln.134.1493226232933;
        Wed, 26 Apr 2017 10:03:52 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net (c-76-102-227-215.hsd1.ca.comcast.net. [76.102.227.215])
        by smtp.gmail.com with ESMTPSA id q70sm1376479pgq.45.2017.04.26.10.03.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 10:03:51 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v11 1/5] dir_iterator: add tests for dir_iterator API
Date:   Wed, 26 Apr 2017 10:03:35 -0700
Message-Id: <1493226219-33423-2-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1493226219-33423-1-git-send-email-bnmvco@gmail.com>
References: <1493226219-33423-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create t/helper/test-dir-iterator.c, which prints relevant information
about a directory tree iterated over with dir_iterator.

Create t/t0066-dir-iterator.sh, which tests that dir_iterator does
iterate through a whole directory tree.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 Makefile                     |  1 +
 t/helper/.gitignore          |  1 +
 t/helper/test-dir-iterator.c | 30 ++++++++++++++++++++++++
 t/t0066-dir-iterator.sh      | 55 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0066-dir-iterator.sh

diff --git a/Makefile b/Makefile
index eb1a1a7..a669e43 100644
--- a/Makefile
+++ b/Makefile
@@ -614,6 +614,7 @@ TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
+TEST_PROGRAMS_NEED_X += test-dir-iterator
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index acd5db1..60adab5 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -3,6 +3,7 @@
 /test-config
 /test-date
 /test-delta
+/test-dir-iterator
 /test-dump-cache-tree
 /test-dump-split-index
 /test-dump-untracked-cache
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
new file mode 100644
index 0000000..a7d1470
--- /dev/null
+++ b/t/helper/test-dir-iterator.c
@@ -0,0 +1,30 @@
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "iterator.h"
+#include "dir-iterator.h"
+
+int cmd_main(int argc, const char **argv)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct dir_iterator *diter;
+
+	if (argc < 2)
+		die("BUG: test-dir-iterator needs one argument");
+
+	strbuf_add(&path, argv[1], strlen(argv[1]));
+
+	diter = dir_iterator_begin(path.buf);
+
+	while (dir_iterator_advance(diter) == ITER_OK) {
+		if (S_ISDIR(diter->st.st_mode))
+			printf("[d] ");
+		else if (S_ISREG(diter->st.st_mode))
+			printf("[f] ");
+		else
+			printf("[?] ");
+
+		printf("(%s) [%s] %s\n", diter->relative_path, diter->basename, diter->path.buf);
+	}
+
+	return 0;
+}
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
new file mode 100755
index 0000000..46e5ce5
--- /dev/null
+++ b/t/t0066-dir-iterator.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='Test directory iteration.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir -p dir &&
+	mkdir -p dir/a/b/c/ &&
+	>dir/b &&
+	>dir/c &&
+	mkdir -p dir/d/e/d/ &&
+	>dir/a/b/c/d &&
+	>dir/a/e &&
+	>dir/d/e/d/a &&
+
+	mkdir -p dir2/a/b/c/ &&
+	>dir2/a/b/c/d
+'
+
+test_expect_success 'dir-iterator should iterate through all files' '
+	cat >expect-sorted-output <<-\EOF &&
+	[d] (a) [a] ./dir/a
+	[d] (a/b) [b] ./dir/a/b
+	[d] (a/b/c) [c] ./dir/a/b/c
+	[d] (d) [d] ./dir/d
+	[d] (d/e) [e] ./dir/d/e
+	[d] (d/e/d) [d] ./dir/d/e/d
+	[f] (a/b/c/d) [d] ./dir/a/b/c/d
+	[f] (a/e) [e] ./dir/a/e
+	[f] (b) [b] ./dir/b
+	[f] (c) [c] ./dir/c
+	[f] (d/e/d/a) [a] ./dir/d/e/d/a
+	EOF
+
+	test-dir-iterator ./dir >out &&
+	sort <out >./actual-pre-order-sorted-output &&
+
+	test_cmp expect-sorted-output actual-pre-order-sorted-output
+'
+
+test_expect_success 'dir-iterator should list files in the correct order' '
+	cat >expect-pre-order-output <<-\EOF &&
+	[d] (a) [a] ./dir2/a
+	[d] (a/b) [b] ./dir2/a/b
+	[d] (a/b/c) [c] ./dir2/a/b/c
+	[f] (a/b/c/d) [d] ./dir2/a/b/c/d
+	EOF
+
+	test-dir-iterator ./dir2 >actual-pre-order-output &&
+
+	test_cmp expect-pre-order-output actual-pre-order-output
+'
+
+test_done
-- 
2.7.4 (Apple Git-66)

