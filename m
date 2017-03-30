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
	by dcvr.yhbt.net (Postfix) with ESMTP id A90A020958
	for <e@80x24.org>; Thu, 30 Mar 2017 03:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932613AbdC3Dcl (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 23:32:41 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34512 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbdC3Dck (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 23:32:40 -0400
Received: by mail-qt0-f193.google.com with SMTP id x35so4657941qtc.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 20:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l16dL+HTbwWAlM1dY3uw/svbi5M03RvsWv9H3M+GdJE=;
        b=CJ/aLp4BCKtWufzQxI4zOmGVOfWUYRhx18uFONjrlObi7ozhQ0TGU0TffrHjy5/pEw
         /CNr7CHuzFD7lfcToHYzMYxyCU7m0+wiUZxZZvp2NJHHukI4tjAOGM6mRoGx9RHSh6DH
         gVYjtijMalR0iskZgYjkZKGYkStycx4ZtUMiK/lOwXhMXRCqtm4dJXi8HlpxtBU+KHgt
         a+eHQCJDHszEUOcZfGYilkXA31AYnlWNZnvliS1zEhTsHxVN3xo9se+Qb3OWq4HQ5HgC
         vwxt7DYZnd5wgYw6GtXxNiucPTch3njkDD3LXbEnhqKzUVW5bt3+mX9lA8h4zhTi/zcb
         XOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l16dL+HTbwWAlM1dY3uw/svbi5M03RvsWv9H3M+GdJE=;
        b=PrHA5BqsyGvfzbCrojJz0a2Zmtd/Of33puaXkQFQkijfG3Mf6uW+FpibBaJjyaGecp
         Cc7/Y813zcum+y0K/0B2E/AhAr4p7PAyBoPPz1o4mFf9jGSWJsDfrFupUUkvA0TUf63r
         8BtG3uvN2sNzPmvZG+DkSLfJVAU1CGwmGI0/BXuKz571cvfjLzzmuPW2n3sBfZ6Ur6Vi
         RBzuvhnQadR6xAgZOdgHDLNfhLYARz+H/9OBIuwe1ASsmQzDISIvXpFBW+Jx6tkklRVn
         PliD51OEuyaaP8u+xylZELlRrR1OynEWDzux/uR6CzMMquTtOoh2tPyFfoipDmCY9Udr
         CdRA==
X-Gm-Message-State: AFeK/H2zEShNHtvSGBOEOhopbi5z+xEx1VJfFvCpr3ZZ5IeXJFwTVE9LuWiWvlmDddnzQQ==
X-Received: by 10.200.46.151 with SMTP id h23mr4471267qta.239.1490844758582;
        Wed, 29 Mar 2017 20:32:38 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id d136sm624095qke.32.2017.03.29.20.32.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 20:32:37 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v5 4/6] dir_iterator: add tests for dir_iterator API
Date:   Thu, 30 Mar 2017 00:32:08 -0300
Message-Id: <1490844730-47634-5-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create t/helper/test-dir-iterator.c, which prints relevant information
about a directory tree iterated over with dir_iterator.

Create t/t0065-dir-iterator.sh, which tests that dir_iterator does
iterate through a whole directory tree and that post-order directory
iteration is correctly implemented.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 Makefile                     |  1 +
 t/helper/test-dir-iterator.c | 32 +++++++++++++++++++++++++++++++
 t/t0065-dir-iterator.sh      | 45 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0065-dir-iterator.sh

diff --git a/Makefile b/Makefile
index a5a11e7..d0245f3 100644
--- a/Makefile
+++ b/Makefile
@@ -607,6 +607,7 @@ TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
+TEST_PROGRAMS_NEED_X += test-dir-iterator
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
new file mode 100644
index 0000000..b4a148f
--- /dev/null
+++ b/t/helper/test-dir-iterator.c
@@ -0,0 +1,32 @@
+#include "cache.h"
+#include "blob.h"
+#include "dir.h"
+#include "streaming.h"
+#include "iterator.h"
+#include "dir-iterator.h"
+
+int cmd_main(int argc, const char **argv) {
+	if (argc < 2) {
+		return 1;
+	}
+
+	struct strbuf path = STRBUF_INIT;
+	strbuf_add(&path, argv[1], strlen(argv[1]));
+
+	unsigned flag = 0;
+	if (argc == 3 && strcmp(argv[2], "--post-order") == 0)
+		flag = DIR_ITERATOR_POST_ORDER_TRAVERSAL;
+
+	struct dir_iterator *diter = dir_iterator_begin((&path)->buf, flag);
+
+	while (dir_iterator_advance(diter) == ITER_OK) {
+		if (S_ISDIR(diter->st.st_mode))
+			printf("[d] ");
+		else
+			printf("[f] ");
+
+		printf("(%s) %s\n", diter->relative_path, diter->path.buf);
+	}
+
+	return 0;
+}
diff --git a/t/t0065-dir-iterator.sh b/t/t0065-dir-iterator.sh
new file mode 100755
index 0000000..3c8ea9a
--- /dev/null
+++ b/t/t0065-dir-iterator.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='Test directory iteration.'
+
+. ./test-lib.sh
+
+ITER_SORTED_OUTPUT='[d] (a) ./dir/a
+[d] (a/b) ./dir/a/b
+[d] (a/b/c) ./dir/a/b/c
+[d] (d) ./dir/d
+[d] (d/e) ./dir/d/e
+[d] (d/e/d) ./dir/d/e/d
+[f] (a/b/c/d) ./dir/a/b/c/d
+[f] (a/e) ./dir/a/e
+[f] (b) ./dir/b
+[f] (c) ./dir/c
+[f] (d/e/d/a) ./dir/d/e/d/a'
+
+test_expect_success 'dir-iterator should iterate through all files' '
+	mkdir -p dir &&
+	mkdir -p dir/a/b/c/ &&
+	date >dir/b &&
+	date >dir/c &&
+	mkdir -p dir/d/e/d/ &&
+	date >dir/a/b/c/d &&
+	date >dir/a/e &&
+	date >dir/d/e/d/a &&
+
+	test-dir-iterator ./dir >it &&
+	test "$(sort it)" == "$ITER_SORTED_OUTPUT"
+'
+
+ITER_POST_ORDER_OUTPUT='[f] (a/b/c/d) ./dir2/a/b/c/d
+[d] (a/b/c) ./dir2/a/b/c
+[d] (a/b) ./dir2/a/b
+[d] (a) ./dir2/a'
+
+test_expect_success 'dir-iterator should list files properly on post-order mode' '
+	mkdir -p dir2/a/b/c/ &&
+	date >dir2/a/b/c/d &&
+
+	test "$(test-dir-iterator ./dir2 --post-order)" == "$ITER_POST_ORDER_OUTPUT"
+'
+
+test_done
-- 
2.7.4 (Apple Git-66)

