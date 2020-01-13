Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5DBC33CAB
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F51B21744
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVq8tvJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgAMI3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36938 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgAMI3e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so7573904wru.4
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 00:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=8EVhwcqn3ez5CrWfRdXQz68SdCU2A2kepky5wS7jgNg=;
        b=vVq8tvJwxPvc4NXI09QqScSrrJ+KGcfD9NuJgVRx8x1ntkS+O5QQmLOG/wH8WQ6BGf
         gAYixQoWYc+Vk4NUd/Av8oah5h9dbCd/WevMkyx8PP6JJupo9h1b+jpHQNiqkrqPg2y2
         utwuYQZw/2I8CBao159aXHbYxAmra98etMmpOnbgdSCnXmMFu1WDhIasGdrGhDLVXeqa
         jUYJ2mYZMop/qckZHmQ6tVba7UDHJsNwMU29IqM9A3vubq4Y7TinvcuBCaX5W5e0AIbP
         u/Xey8vjXqilUqWg3i5b7CroVdenduBnEWQRx+M1wfwT9jg/GcYz0MS+XlVid8dJCzZ+
         zfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=8EVhwcqn3ez5CrWfRdXQz68SdCU2A2kepky5wS7jgNg=;
        b=WPYrYWUaMASO7pHFdfIljeuTR5jxYH+p243/1HtvARcivqlUZygL/XPDe+7gaTRcXt
         0TT7LfJEA36veQ5Z5UvoQL6UksNa5nSZKXY2O8YUIXT0fJtnOC7EHXbFpeAPKXYpm6fp
         wNtPzTbPkNBEw7nuEto1KNcUUqXW1Ww8hxDs0WhTyrhEpMjdR1QGGk9NveytLy6nQvbH
         uCSBCCKTG68Pt2WAi8qWI8BW3eH1RAQoVRE/uJoRAJBV5zy7l1shBEyfsQwWJGIXoU0a
         zrY3yEgcpo7z8UNnsqkatvgnL5VWhoVF45bsP7HwZ6DZxQKe4E+kRxLAabDqLvi0A3Up
         dv0A==
X-Gm-Message-State: APjAAAXTd3X9rKjjmicy9vg8PPLDB9XJkVSTvVJiaPYX5PMtKxlTMwsN
        0pJ7X3/srmokijsYkMb+Re9/1QI9
X-Google-Smtp-Source: APXvYqwXmVn7sNovwvZwWHhaO4Rkjoi3EBekqGvblAfs6VguEqLSIqXT0+dhEO2w4qjHSHmi/nHuXg==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr16471357wrv.333.1578904173322;
        Mon, 13 Jan 2020 00:29:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm13445172wrs.8.2020.01.13.00.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:29:33 -0800 (PST)
Message-Id: <5e258a8d2bb271433902b2e44c3a30a988bbf512.1578904171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
        <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jan 2020 08:29:22 +0000
Subject: [PATCH v3 01/10] built-in add -i/-p: treat SIGPIPE as EOF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As noticed by Gábor Szeder, if we want to run `git add -p` with
redirected input through `test_must_fail` in the test suite, we must
expect that a SIGPIPE can happen due to `stdin` coming to its end.

The appropriate action here is to ignore that signal and treat it as a
regular end-of-file, otherwise the test will fail. In preparation for
such a test, introduce precisely this handling of SIGPIPE into the
built-in version of `git add -p`.

For good measure, teach the built-in `git add -i` the same trick: it
_also_ runs a loop waiting for input, and can receive a SIGPIPE just the
same (and wants to treat it as end-of-file, too).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 3 +++
 add-patch.c       | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index a5bb14f2f4..3ff8400ea4 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -9,6 +9,7 @@
 #include "lockfile.h"
 #include "dir.h"
 #include "run-command.h"
+#include "sigchain.h"
 
 static void init_color(struct repository *r, struct add_i_state *s,
 		       const char *slot_name, char *dst,
@@ -1097,6 +1098,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 			->util = util;
 	}
 
+	sigchain_push(SIGPIPE, SIG_IGN);
 	init_add_i_state(&s, r);
 
 	/*
@@ -1149,6 +1151,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	strbuf_release(&print_file_item_data.worktree);
 	strbuf_release(&header);
 	prefix_item_list_clear(&commands);
+	sigchain_pop(SIGPIPE);
 
 	return res;
 }
diff --git a/add-patch.c b/add-patch.c
index 46c6c183d5..9a3beed72e 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -6,6 +6,7 @@
 #include "pathspec.h"
 #include "color.h"
 #include "diff.h"
+#include "sigchain.h"
 
 enum prompt_mode_type {
 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK,
@@ -1578,6 +1579,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	};
 	size_t i, binary_count = 0;
 
+	sigchain_push(SIGPIPE, SIG_IGN);
 	init_add_i_state(&s.s, r);
 
 	if (mode == ADD_P_STASH)
@@ -1612,6 +1614,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	    parse_diff(&s, ps) < 0) {
 		strbuf_release(&s.plain);
 		strbuf_release(&s.colored);
+		sigchain_pop(SIGPIPE);
 		return -1;
 	}
 
@@ -1630,5 +1633,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	strbuf_release(&s.buf);
 	strbuf_release(&s.plain);
 	strbuf_release(&s.colored);
+	sigchain_pop(SIGPIPE);
 	return 0;
 }
-- 
gitgitgadget

