Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B2C6FD1D
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 14:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCFOH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCFOHM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 09:07:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1705C25BB0
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 06:06:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k37so5762921wms.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 06:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678111601;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xzhk9czL0tfPZE5t5QjBWnqeCGPryB1dJT4/B524tO8=;
        b=aJtyaTrRLgEN+sP7xVieUGh5sUKDCkK7oEpYA30889cdIYS+BZiC2y5kIJ16+wEPUu
         J+ee8uwgad4AlgRq65OdBnnc/OppYyumyV7yfwxIu6Cnx3EXuvYBYw0bKWlN9QIDsH5H
         ULQ+jfEO1oDmEUOTmuT4TeVIZ2BgbSTtvBgUS2Ku5+9ox8wInf9xJ9LmzJEl+Qi0+bkr
         hvr31GGwwtJeKUv0kDFFQRSKlAwxmSAX91jlGNF+o/quyGsuDi8y60InxTEYJMGXi9Cx
         tOWt4rqslcjwnG3LNQeB2nAOeG44Zk/SwZ0lx/04UGzwPBd1fwYrphJkVOa2ttTyPik/
         EYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111601;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xzhk9czL0tfPZE5t5QjBWnqeCGPryB1dJT4/B524tO8=;
        b=I2Mx4kgoNfozFgqOPUJhUEbqnWda22xZ4auqr+FRAJylZDIuE1Ur3wm8AAPYCvbEUz
         BtWaUMFGcA/puw07tXvWv/vdCURfZf3t8WwwHBOcZzCz1qJK/eXwyzHs6uFaPcpGV6V9
         apnUQyEN9ysfJ7oeQClkucMk2hOvgOG8SH/qfreBW6waRadyjImQAGJWfPmNmS4Jvrj1
         yd3MEukEFRST0nIHdhhKVLZdi7TjtyC8hM8TAsAQiW99aUiL9sQVnbHY6lzmTT8quQwC
         mMk6sABf1f/LrG31OecotVn7rNWPVUCDRrxlKhcgrGMyWjv3Zq0LXAI03CFFfPMqNxri
         XV/w==
X-Gm-Message-State: AO0yUKV6r8AKcCvpGwsgqlyJGUOZBKvIc5kYuw01AWa9Y530Os9gnWfb
        UlTqFeDLofOt1zXlF58ex0Jq0Fgggqk=
X-Google-Smtp-Source: AK7set+Y0zGxXU+ph75o992IpJKB8mcV0tjAvVv0hsw3UFvnCLvQBEwwkgC570ytMPHXCd+c7wkTLw==
X-Received: by 2002:a05:600c:1f0a:b0:3ea:9530:22a6 with SMTP id bd10-20020a05600c1f0a00b003ea953022a6mr10221010wmb.1.1678111601202;
        Mon, 06 Mar 2023 06:06:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c164a00b003e20cf0408esm10040567wmn.40.2023.03.06.06.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:06:41 -0800 (PST)
Message-Id: <08fc0710017d4b6178a8c5772e0f15fc69c84ad6.1678111599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 14:06:32 +0000
Subject: [PATCH 2/8] ahead-behind: parse tip references
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Before implementing the logic to compute the ahead/behind counts, parse
the unknown options as commits and place them in a string_list.

Be sure to error out when the reference is not found.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/ahead-behind.c  | 39 +++++++++++++++++++++++++++++++++++++++
 t/t4218-ahead-behind.sh | 10 ++++++++++
 2 files changed, 49 insertions(+)

diff --git a/builtin/ahead-behind.c b/builtin/ahead-behind.c
index a56cc565def..c1212cc8d46 100644
--- a/builtin/ahead-behind.c
+++ b/builtin/ahead-behind.c
@@ -1,16 +1,31 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "config.h"
+#include "commit.h"
 
 static const char * const ahead_behind_usage[] = {
 	N_("git ahead-behind --base=<ref> [ --stdin | <revs> ]"),
 	NULL
 };
 
+static int handle_arg(struct string_list *tips, const char *arg)
+{
+	struct string_list_item *item;
+	struct commit *c = lookup_commit_reference_by_name(arg);
+
+	if (!c)
+		return error(_("could not resolve '%s'"), arg);
+
+	item = string_list_append(tips, arg);
+	item->util = c;
+	return 0;
+}
+
 int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
 {
 	const char *base_ref = NULL;
 	int from_stdin = 0;
+	struct string_list tips = STRING_LIST_INIT_DUP;
 
 	struct option ahead_behind_opts[] = {
 		OPT_STRING('b', "base", &base_ref, N_("base"), N_("base reference to process")),
@@ -26,5 +41,29 @@ int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	if (from_stdin) {
+		struct strbuf line = STRBUF_INIT;
+
+		while (strbuf_getline(&line, stdin) != EOF) {
+			if (!line.len)
+				break;
+
+			if (handle_arg(&tips, line.buf))
+				return 1;
+		}
+
+		strbuf_release(&line);
+	} else {
+		int i;
+		for (i = 0; i < argc; ++i) {
+			if (handle_arg(&tips, argv[i]))
+				return 1;
+		}
+	}
+
+	/* Early return for no tips. */
+	if (!tips.nr)
+		return 0;
+
 	return 0;
 }
diff --git a/t/t4218-ahead-behind.sh b/t/t4218-ahead-behind.sh
index bc08f1207a0..3b8b9dc9887 100755
--- a/t/t4218-ahead-behind.sh
+++ b/t/t4218-ahead-behind.sh
@@ -14,4 +14,14 @@ test_expect_success 'git ahead-behind without --base' '
 	grep "usage:" err
 '
 
+test_expect_success 'git ahead-behind with broken tip' '
+	test_must_fail git ahead-behind --base=HEAD bogus 2>err &&
+	grep "could not resolve '\''bogus'\''" err
+'
+
+test_expect_success 'git ahead-behind without tips' '
+	git ahead-behind --base=HEAD 2>err &&
+	test_must_be_empty err
+'
+
 test_done
-- 
gitgitgadget

