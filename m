Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676BDC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5372F60E54
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbhI1PM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241576AbhI1PMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 11:12:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5B4C06176F
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s21so18612206wra.7
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vRAQxRV4mWm5KzO2JMO1K4ORWwbDDHcdGl0emEa8Wlg=;
        b=cBHY/DGKHpVplcZEWnckRP51oqXLdoLK8JpqUQV1cJQSTP99oFHr6oZCZF2u+nN6VM
         aFtJGvPyf6YIucGe7Co5OoORY6DaZ1ylm3IMRYap1pOb/zoGJgei30su8ZnMhSG8NuyG
         5BRzuExJWa80bRK3A5BXePntFYN4hTdNr7SYWB0kJdu1WDI6ZMC0druccv3uK7+pzwzy
         zdgXuFSWQriZwnseIwjk9qJ97XNZcKrxvTxE+WLiM8Q+2iC7oPP3c/MLeWXT2+/7Rczr
         IeDA213pW/iMHNdLkwbLXuExqIhTJ9GKefezUBwXD9BiFJURMTCCiKvwfmJb3aXNIWwZ
         nJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=vRAQxRV4mWm5KzO2JMO1K4ORWwbDDHcdGl0emEa8Wlg=;
        b=Ox/qhC9I1Ff7qb1C669Logpl0a4zTx2HQoTGp+EtNffpRokyfdhL4WtVnPc1+spYeX
         WCFFJbXyD5q8i+re21xJHejZEWBEY9Di6gOClWn+lK65KePSqvfe9zugdxmY3ay3nB8A
         9aZF2/xmLPXgKLx/tkkPYh8+RjtL+3BLE8g5TNxqBdpW7pcK8DeGY9TTBZteNFqQdSin
         LZAXTjBjVb+m31WGhhyOqbfrF99R8vJzaAZhBrbz2Rx3Xh99UaJYyrp73rZdgx0Eg6+H
         Vqxm0Lfw8JLDmS5KHFUj9wzCXHu/YaUqb82BrUDVlx3AEoJQ0p9LfT8pIiuFEnguZfDJ
         160A==
X-Gm-Message-State: AOAM5330A0wcQPJdNHMKTC4YetfZrzZfC4rcwgWIXZjR4wWuGrlJcX6I
        1dWlkHCn233Oi1ZsdTs4p1vMui+YnxI=
X-Google-Smtp-Source: ABdhPJx/BINhQGtaMrrQrcCG6nebZaTtb7fJAhH90qvjJMS6y7r5PovllZIV0WIhr1sVwD7Yh09wFw==
X-Received: by 2002:adf:f481:: with SMTP id l1mr595616wro.411.1632841831365;
        Tue, 28 Sep 2021 08:10:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1sm3477424wmk.2.2021.09.28.08.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:10:31 -0700 (PDT)
Message-Id: <795a15000fbf526b614719dcf33085c2b089f431.1632841817.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
References: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
        <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 15:10:15 +0000
Subject: [PATCH v3 18/19] reftable: add dump utility
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

