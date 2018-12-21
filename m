Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AFDE1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 13:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390564AbeLUNRm (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 08:17:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45154 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbeLUNRk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 08:17:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so4620115edb.12
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bY0Qd6dGuXDlojP8U3bvz/0yqdQ+JqpSXiwY6B1z0O8=;
        b=nQ9BBekJHgRDxmp72ogo94Y522Ls1iRqZ+pjSTU2kJrlU5vfs0rMa6JAnLqXZSb4A3
         dCc8RiPIRl/kE3OTHGFfMugLWip8vZGtSsr8g5HXl2AtfCA9oJIYOtbHMqbizgz1O49R
         TJ7fsg1XxzNAINb2lM/SAiblOqJqkcyj7Mq00mg2TneGV2GcskOWKjuQbRlPaoBssj+Y
         k2tEBxRSdi0lrlZwZBmUu+QdJehAim6UEP1/3zmL1dfHO8UvfbkhAngIJh3Vvhq4uxOB
         2Au9iyXwff73vfVMD8rNjSRFrNX7YuqHllXMaYcEvoNoPT+bI/Q9bubmQvRF/LLNcxo1
         tqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bY0Qd6dGuXDlojP8U3bvz/0yqdQ+JqpSXiwY6B1z0O8=;
        b=nDDEvtK8F+/Yb/QEx4n6597bFh0n4N802FQWORGMRvL0Wdt7wbuBq0U81dVCWcrcpR
         aVjB+W48LWV0+NR7k+B+n2Eonm1fOIfQs87DAGsF1JjF8bY7IwktnQ6a4sAG36sdrYeD
         b6oN+gVxn1eAfim03ylvBlgcRRGv6fAwQ7Jb/w2Ug9IX5vb1Ptfq82HnEKno4eeyFx9X
         vWCsnJbSSiol5Yh8rmYPF++PKDTZB1rmz8/c03ypCDHM3wafTZ1kz1KiMAIo+PgeC6uq
         p+JQtLgLZae/Dg5Ee+RCFiSG7Xhgi7mN/rXuwkNZv2v/SPDVYAy39XGi7qRbQ7nyDDkp
         18vA==
X-Gm-Message-State: AA+aEWamWom1mFGNiKlKZp7TjyqHX4KejZTfkZ4BusYPqoMovhY/pmyi
        KdKDLqLHlQLYdfcnG/9XDo1e3PLD1p/lug==
X-Google-Smtp-Source: AFSGD/VfXEymX/kRq9X5hq2vi2eO0JX5OpbybBnKBfKUJrapK2CaQ63NmKSavDNtymD6hbEEYn3ymw==
X-Received: by 2002:a50:a1e5:: with SMTP id 92mr2434986edk.181.1545398258631;
        Fri, 21 Dec 2018 05:17:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm7084613edc.28.2018.12.21.05.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 05:17:38 -0800 (PST)
Date:   Fri, 21 Dec 2018 05:17:38 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 13:17:33 GMT
Message-Id: <21939140e00d96cf6f76e4c994638fecd3a95639.1545398254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.24.git.gitgitgadget@gmail.com>
References: <pull.24.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/4] rebase: teach `reset_head()` to optionally skip the
 worktree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is what the legacy (scripted) rebase does in
`move_to_original_branch`, and we will need this functionality in the
next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 768bea0da8..303175fdf1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -337,6 +337,7 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 
 #define RESET_HEAD_DETACH (1<<0)
 #define RESET_HEAD_HARD (1<<1)
+#define RESET_HEAD_REFS_ONLY (1<<2)
 
 static int reset_head(struct object_id *oid, const char *action,
 		      const char *switch_to_branch, unsigned flags,
@@ -344,6 +345,7 @@ static int reset_head(struct object_id *oid, const char *action,
 {
 	unsigned detach_head = flags & RESET_HEAD_DETACH;
 	unsigned reset_hard = flags & RESET_HEAD_HARD;
+	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
 	struct object_id head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
@@ -359,7 +361,7 @@ static int reset_head(struct object_id *oid, const char *action,
 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
 		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
 
-	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
+	if (!refs_only && hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
 	}
@@ -372,6 +374,9 @@ static int reset_head(struct object_id *oid, const char *action,
 	if (!oid)
 		oid = &head_oid;
 
+	if (flags & RESET_HEAD_REFS_ONLY)
+		goto reset_head_refs;
+
 	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
 	unpack_tree_opts.head_idx = 1;
@@ -412,6 +417,7 @@ static int reset_head(struct object_id *oid, const char *action,
 		goto leave_reset_head;
 	}
 
+reset_head_refs:
 	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
 	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
 	prefix_len = msg.len;
-- 
gitgitgadget

