Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E729CC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF756103B
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbhJGU1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbhJGU10 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:27:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8F0C061770
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 13:25:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r10so22757953wra.12
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vRAQxRV4mWm5KzO2JMO1K4ORWwbDDHcdGl0emEa8Wlg=;
        b=LGIzGoCZHx7JzOkTvYYtVZFcPbo9OT8+bnH0hSiPgPc242P8UMQgCXkV2w/sV1cnRU
         SjWkPzak1TtAM1+RRA1pQZbbho4DJ1xMUwWVCR5UzG5I93U1YPkNAbT3eAH/qi3h2U18
         zbve4rK6v6YsJMNegtNwGoFOoY7YlM7WT2oN10oeLPH9nJWAbJS8qKwwEbR8vt/GQj9w
         pEaT4M4GDUo2yuqLZheD7PWa4dBOkPPQHh3oyLX8cO7ZsL44EKs12h9GCNE0PysK7XO4
         SpVFI07FgV0C3tK932nxkAT8ZTHHWysJpLB7t9tmI0PRhUd09O1HuD4mEio56aJ4jnWn
         xJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=vRAQxRV4mWm5KzO2JMO1K4ORWwbDDHcdGl0emEa8Wlg=;
        b=AIuRlFp4h12d8byYEvwBaRzyZjIW4YYlnzNlC585bLTV0V9bmY4U+xjqoD+3F9EwM+
         upNpiN0nau84pHjd1siyeD+Vx7CqgpFQCF/mPVfk0wIK0u1vORG5gJ1qGpp3ZxekXSaf
         0s5HKKcqhDt+yW6oyQSycyNzG+LR94hRKKALo0wCT4zagV6tnIDHcYwbYT9PAaCDdjZv
         GCZwp7ZyZVzgqkmUE0zd5X8teDqS9oeNoruLXPminEG0T6ck8jnDp7+OtKm1z/3j2rbb
         PyG6H61taYvB7OwJUAJL2bfyuZzVnP2qsuKXe8uKIWf8NLyHkyYF1cqzWEX9uGcMWbTl
         0r5A==
X-Gm-Message-State: AOAM533aUK6kGda21+j7HhAZ22MJFaDp98Wnban1vWLFwGCHyBfHxMJT
        HMvZo69ftnAXRCuh88TzIyX2BmynCs4=
X-Google-Smtp-Source: ABdhPJw2JYzjOBzhzxhIsScAO7m/+RghCMnrHbmEG97QhYdGGJ1RBPj74DzLB1U9RiQrJ7lgGDlbAw==
X-Received: by 2002:adf:8bd2:: with SMTP id w18mr7942158wra.432.1633638330841;
        Thu, 07 Oct 2021 13:25:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e1sm360444wru.26.2021.10.07.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:25:30 -0700 (PDT)
Message-Id: <2f825cdb2d46d4420e1830c9798d62ee3b3b2783.1633638316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
        <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 20:25:14 +0000
Subject: [PATCH v4 18/19] reftable: add dump utility
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

provide a command-line utility for inspecting individual tables, and
inspecting a complete ref database

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 reftable/dump.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 reftable/dump.c

diff --git a/reftable/dump.c b/reftable/dump.c
new file mode 100644
index 00000000000..155953d1b82
--- /dev/null
+++ b/reftable/dump.c
@@ -0,0 +1,107 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "git-compat-util.h"
+#include "hash.h"
+
+#include "reftable-blocksource.h"
+#include "reftable-error.h"
+#include "reftable-merged.h"
+#include "reftable-record.h"
+#include "reftable-tests.h"
+#include "reftable-writer.h"
+#include "reftable-iterator.h"
+#include "reftable-reader.h"
+#include "reftable-stack.h"
+#include "reftable-generic.h"
+
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+
+static int compact_stack(const char *stackdir)
+{
+	struct reftable_stack *stack = NULL;
+	struct reftable_write_options cfg = { 0 };
+
+	int err = reftable_new_stack(&stack, stackdir, cfg);
+	if (err < 0)
+		goto done;
+
+	err = reftable_stack_compact_all(stack, NULL);
+	if (err < 0)
+		goto done;
+done:
+	if (stack) {
+		reftable_stack_destroy(stack);
+	}
+	return err;
+}
+
+static void print_help(void)
+{
+	printf("usage: dump [-cst] arg\n\n"
+	       "options: \n"
+	       "  -c compact\n"
+	       "  -t dump table\n"
+	       "  -s dump stack\n"
+	       "  -6 sha256 hash format\n"
+	       "  -h this help\n"
+	       "\n");
+}
+
+int reftable_dump_main(int argc, char *const *argv)
+{
+	int err = 0;
+	int opt_dump_table = 0;
+	int opt_dump_stack = 0;
+	int opt_compact = 0;
+	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
+	const char *arg = NULL, *argv0 = argv[0];
+
+	for (; argc > 1; argv++, argc--)
+		if (*argv[1] != '-')
+			break;
+		else if (!strcmp("-t", argv[1]))
+			opt_dump_table = 1;
+		else if (!strcmp("-6", argv[1]))
+			opt_hash_id = GIT_SHA256_FORMAT_ID;
+		else if (!strcmp("-s", argv[1]))
+			opt_dump_stack = 1;
+		else if (!strcmp("-c", argv[1]))
+			opt_compact = 1;
+		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
+			print_help();
+			return 2;
+		}
+
+	if (argc != 2) {
+		fprintf(stderr, "need argument\n");
+		print_help();
+		return 2;
+	}
+
+	arg = argv[1];
+
+	if (opt_dump_table) {
+		err = reftable_reader_print_file(arg);
+	} else if (opt_dump_stack) {
+		err = reftable_stack_print_directory(arg, opt_hash_id);
+	} else if (opt_compact) {
+		err = compact_stack(arg);
+	}
+
+	if (err < 0) {
+		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
+			reftable_error_str(err));
+		return 1;
+	}
+	return 0;
+}
-- 
gitgitgadget

