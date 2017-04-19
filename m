Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3E01FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 13:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763531AbdDSNPF (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 09:15:05 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34978 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763519AbdDSNPD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 09:15:03 -0400
Received: by mail-qt0-f193.google.com with SMTP id o36so3096184qtb.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3zWUg6PlHoA8YTzHiLm9aQsI9rP4F042HjncR0Gmk7M=;
        b=c7xUvCmGnkhYCcoTrQ+XY99VNR0TSzXe/SsSTcZpvpBvhYYuiW5RQE7WPk0x1NYfs5
         CLci6pk82SdP2hRe7RYBQfrEWQB4tJB7gYJ2dG2ACDjHFv4NO1p2FSKxwxDuUA7Fej/g
         MdMx8QsrmkGAAY4Znowx57UsrZ9cqn1vY4gz11Foq/z8lgO2a1moQkCPQEdgxHFQPg1Z
         TGSroZzd/jd+47uIicTGG7iMjC3TosgZ5yIve+LPJseu0t2QCVxNyQC6XqJnBfpJ3g2I
         zMwiIsS3rY46S77h4kr9HBth1ltk9FZ8+kJUCDKlZvflEJ6PFq8amJRldDA8vxsz3xeZ
         GWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3zWUg6PlHoA8YTzHiLm9aQsI9rP4F042HjncR0Gmk7M=;
        b=Wqdf1h6SYhY7LfmWReSNw6x28mF0DPJwtZiTLVgt2+xZKulfilClKxf5jDy4/OOqLc
         riaoIpzqp3DeItBPRc2pwyGFergjcB5oGtVvFTZhrTnbl+2p+/n2xrwnXcQe3MaVawKq
         A2HtvqVr0oYw3tPaRmFMpG8+fATOFVauikH3DBpKSZlBlM1sssM+RTHbxKTTJzuffl9X
         YAyvf4nwL94Ve6nIBve1dHt4qIPIFqVGxmGLqqF2k+sbvkC1vsDjG42wgG0FBZBwEwAB
         e42qppB9BIlVdU1hguTzJzVwJuZdwTDqZPW7buwumQnjzuIE/EfdF/LEYqJTii+RxcR9
         +T/A==
X-Gm-Message-State: AN3rC/4qYPf0Jd48UsLXSZkKvjB4oGWP5F16C2Cmj8svUalpJShNnYuj
        HoSjTNSww7rUyQ==
X-Received: by 10.237.56.196 with SMTP id k62mr2535636qte.61.1492607702754;
        Wed, 19 Apr 2017 06:15:02 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id k133sm1835587qke.25.2017.04.19.06.14.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 06:15:01 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v10 1/5] dir_iterator: add tests for dir_iterator API
Date:   Wed, 19 Apr 2017 10:14:08 -0300
Message-Id: <1492607652-36341-2-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1492607652-36341-1-git-send-email-bnmvco@gmail.com>
References: <1492607652-36341-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create t/helper/test-dir-iterator.c, which prints relevant information
about a directory tree iterated over with dir_iterator.

Create t/t0065-dir-iterator.sh, which tests that dir_iterator does
iterate through a whole directory tree.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 Makefile                     |  1 +
 t/helper/.gitignore          |  1 +
 t/helper/test-dir-iterator.c | 30 ++++++++++++++++++++++++
 t/t0065-dir-iterator.sh      | 55 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0065-dir-iterator.sh

diff --git a/Makefile b/Makefile
index d595ea3..a5c1ac0 100644
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
index 758ed2e..a7d74d3 100644
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
diff --git a/t/t0065-dir-iterator.sh b/t/t0065-dir-iterator.sh
new file mode 100755
index 0000000..46e5ce5
--- /dev/null
+++ b/t/t0065-dir-iterator.sh
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

