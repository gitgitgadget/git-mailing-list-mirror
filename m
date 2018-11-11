Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4A91F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 23:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbeKLJtG (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 04:49:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37827 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732407AbeKLJtF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 04:49:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so3413642pll.4
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 15:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IbrtGcWZtjag4rWqBqY9hqD0XTtHQ/l+JOdGkN5ePzY=;
        b=qPfgsTUUs//Q+sQptOzlPe6PqgRIqlNgwRMJ/hKgVmhZc9lNYnQ4wU4GGvhKlIWA4S
         HHVxMGn7Niz83UKzxrOf16zivBcOizYJhLiHdKk3wmkbytAheUCkT8iGWhfj/lLbm6jO
         iQPb7bnnwQTyQnFSxDohETZZe9oBv7WmCmxWwdLtyY33adew2vy6aRjH+GXzuBlX/dYz
         x8rWoR2XceYHnaBqcUgq9EP4FJe/TDmEoB0ucl0Do4/wb8uvhkR4I7Hl/8wy4w+KJgw1
         LnVsDiJqfbB/6wHVwsdWG3UtAq/Szua74aixLWz+UWUbfakqwqdZ2aC3edaqv1fmLSWI
         BbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IbrtGcWZtjag4rWqBqY9hqD0XTtHQ/l+JOdGkN5ePzY=;
        b=ojCpaVz5IN9k8XK+7ODmxlcWGqrvuScYA2jMxunfw0w/nN8gzKAHm3KXSUZErDpefv
         OLOBzJOwFTo7zV/cNaRLtXvSl8yFApKnDn29TZhiRNVLEVhi4ti07F0E3anYWp5wsYE6
         eLVoIZQ7QDPaGHUjDFW9EaLj6LIMTNyVCekywjiXki80ZcKIh+iu4B/9NSj8GwmLxN4h
         5CBP86DfruVAksZ/1JVX/AnrbLIrmZHOVwIlQyu3I34aiUNyg83RImsJsjsTJP+dFprB
         PSS6ugpKeCNss22R0ArUFXliWoDDZJo9ajFWezOeNMt7rUwPdF4QqwztF64kiPpXW0hR
         5huw==
X-Gm-Message-State: AGRZ1gIgZXDo49ntaVz1LL/EG1Q9+yU5tgqijMJraotP6gAeZOMWLAM/
        uh3f1ReWB7zU3TqVbo8dAEo=
X-Google-Smtp-Source: AJdET5dsZO3LQqop6H7FvY/vaHhO4Clg/uHhOcKRt94vuF8/YBQ0wcqBDX21UAfVyEDlG80w4efWow==
X-Received: by 2002:a17:902:7a2:: with SMTP id 31-v6mr17507318plj.277.1541980721806;
        Sun, 11 Nov 2018 15:58:41 -0800 (PST)
Received: from localhost.localdomain (143.sub-174-211-23.myvzw.com. [174.211.23.143])
        by smtp.gmail.com with ESMTPSA id v5sm16954798pgn.5.2018.11.11.15.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Nov 2018 15:58:41 -0800 (PST)
From:   nbelakovski@gmail.com
To:     rafa.almas@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, nbelakovski@gmail.com,
        peff@peff.net
Subject: [PATCH v2 1/2] ref-filter: add worktree atom
Date:   Sun, 11 Nov 2018 15:58:30 -0800
Message-Id: <20181111235831.44824-2-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20181111235831.44824-1-nbelakovski@gmail.com>
References: <20180927204049.GA2628@rigel>
 <20181111235831.44824-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

Add an atom expressing whether the particular ref is checked out in a
linked worktree.

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
---
 ref-filter.c                   | 31 +++++++++++++++++++++++++++++++
 t/t6302-for-each-ref-filter.sh | 15 +++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 0c45ed9d94..53e2504f5d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -20,6 +20,7 @@
 #include "commit-slab.h"
 #include "commit-graph.h"
 #include "commit-reach.h"
+#include "worktree.h"
 
 static struct ref_msg {
 	const char *gone;
@@ -114,6 +115,7 @@ static struct used_atom {
 		} objectname;
 		struct refname_atom refname;
 		char *head;
+		struct string_list worktree_heads;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -420,6 +422,28 @@ static int head_atom_parser(const struct ref_format *format, struct used_atom *a
 	return 0;
 }
 
+static int worktree_head_atom_parser(const struct ref_format *format,
+									 struct used_atom *atom,
+									 const char *arg,
+									 struct strbuf *unused_err)
+{
+	struct worktree **worktrees = get_worktrees(0);
+	int i;
+
+	string_list_init(&atom->u.worktree_heads, 1);
+
+	for (i = 0; worktrees[i]; i++) {
+		if (worktrees[i]->head_ref)
+			string_list_append(&atom->u.worktree_heads,
+							   worktrees[i]->head_ref);
+	}
+
+	string_list_sort(&atom->u.worktree_heads);
+
+	free_worktrees(worktrees);
+	return 0;
+}
+
 static struct {
 	const char *name;
 	info_source source;
@@ -461,6 +485,7 @@ static struct {
 	{ "flag", SOURCE_NONE },
 	{ "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
 	{ "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
+	{ "worktree", SOURCE_NONE, FIELD_STR, worktree_head_atom_parser },
 	{ "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
 	{ "end", SOURCE_NONE },
 	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
@@ -1594,6 +1619,12 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else
 				v->s = xstrdup(" ");
 			continue;
+		} else if (!strcmp(name, "worktree")) {
+			if (string_list_has_string(&atom->u.worktree_heads, ref->refname))
+				v->s = xstrdup("+");
+			else
+				v->s = xstrdup(" ");
+			continue;
 		} else if (starts_with(name, "align")) {
 			v->handler = align_atom_handler;
 			v->s = xstrdup("");
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fc067ed672..5e6d249d4c 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -441,4 +441,19 @@ test_expect_success '--merged is incompatible with --no-merged' '
 	test_must_fail git for-each-ref --merged HEAD --no-merged HEAD
 '
 
+test_expect_success '"add" a worktree' '
+	mkdir worktree_dir &&
+	git worktree add -b master_worktree worktree_dir master
+'
+
+test_expect_success 'validate worktree atom' '
+	cat >expect <<-\EOF &&
+	master: checked out in a worktree
+	master_worktree: checked out in a worktree
+	side: not checked out in a worktree
+EOF
+    git for-each-ref --format="%(refname:short): %(if)%(worktree)%(then)checked out in a worktree%(else)not checked out in a worktree%(end)" refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.14.2

