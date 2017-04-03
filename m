Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60AF21FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 15:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753701AbdDCPQ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 11:16:59 -0400
Received: from siwi.pair.com ([209.68.5.199]:37782 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753680AbdDCPQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 11:16:58 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DBCCB845D4;
        Mon,  3 Apr 2017 11:16:56 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ramsay@ramsayjones.plus.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 1/2] test-online-cpus: helper to return cpu count
Date:   Mon,  3 Apr 2017 15:16:41 +0000
Message-Id: <20170403151642.2889-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170403151642.2889-1-git@jeffhostetler.com>
References: <20170403151642.2889-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Created helper executable to print the value of online_cpus()
allowing multi-threaded tests to be skipped when appropriate.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                    | 1 +
 t/helper/.gitignore         | 1 +
 t/helper/test-online-cpus.c | 8 ++++++++
 3 files changed, 10 insertions(+)
 create mode 100644 t/helper/test-online-cpus.c

diff --git a/Makefile b/Makefile
index 9b36068..3bb31e9 100644
--- a/Makefile
+++ b/Makefile
@@ -626,6 +626,7 @@ TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
+TEST_PROGRAMS_NEED_X += test-online-cpus
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-prio-queue
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 758ed2e..b05d67c 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -16,6 +16,7 @@
 /test-match-trees
 /test-mergesort
 /test-mktemp
+/test-online-cpus
 /test-parse-options
 /test-path-utils
 /test-prio-queue
diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
new file mode 100644
index 0000000..c881073
--- /dev/null
+++ b/t/helper/test-online-cpus.c
@@ -0,0 +1,8 @@
+#include "stdio.h"
+#include "thread-utils.h"
+
+int cmd_main(int argc, const char **argv)
+{
+	printf("%d\n", online_cpus());
+	return 0;
+}
-- 
2.9.3

