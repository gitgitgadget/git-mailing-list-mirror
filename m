Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B0720A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeLIKp1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:27 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33484 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeLIKpT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so5975543lfc.0
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkznHaG/cRFD+TIPO6ja3JGagfCfNsdMtUtFwIrBUT4=;
        b=gZvIpWFiOrPS3XpBvPgHCMS61PF4k8L1Rbe2BxZ88ZMUNgcIv0LiWTX60PACA56BNb
         IT6GgDa7YSk1+nnyEkgnILdxb5utuRevW7kE/S7S+m61wMkB0QDUmbBvcV6DGdz7HP5p
         +6nRwpeZNr0W0Qz3S7bCfvAuhr3ednG9auz749CP+Ze7MAgnjQFa2YKVARmYOIrfyJX2
         f5xrRvHgTJ66emzGqRFr4m6lGCYAnflditZQRsS0cyQrDeR8YoOjJA85nMWCAhN7W11M
         Cq7n1GnamP6hILJNrSmaKyRexEEFxvBldoCM0nwMbD4HoherD7XDRecF95kj0WbRROPg
         fxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkznHaG/cRFD+TIPO6ja3JGagfCfNsdMtUtFwIrBUT4=;
        b=jmE4ZVllSzfV6eOKBjv6d6f7zQBhqXJc1OBnARwHHlBZ7XIOW5kPfWDD1In7dhgLsR
         Jt1X6GlGzJ6NS9h3TPAzMsCLlbYjEv2VLteEaUlugihpb+q3VH2yW8dW4QLWq7RM563a
         JSqRjqxfWwJL/JcnsN5Pyvz9WPCKffm8iD+9TVlUJeidLbTKtH7RgPszfjESAIRSKFxw
         VYETJa5Y2+BN3Pv69+toCPVvXsVdUJNTPqabiXG8a508jtQXW28Kbd5QkYZ0fe/wjmLx
         BNKx7DnNNBDAbxvYSm5KMFTVXWPAijAd4j6zil9iYaJqG13+sA5U38yhvtQN6bAQXcLX
         eAfQ==
X-Gm-Message-State: AA+aEWZ93zNbo5OyCif7koTlQws1iN5D88LdHHYK4oGdPig44sz9JBhB
        CF+O7/qfAKIGlJEc1oEwJ/wlQ2As
X-Google-Smtp-Source: AFSGD/XPCBPAlHAHJFE7XJF2d/s8ZHI+Chqwmq4NbncBpR6ihbCGWfpZEgkvCYI9BLJy5SnTtFc2qQ==
X-Received: by 2002:a19:aace:: with SMTP id t197mr4552887lfe.7.1544352316137;
        Sun, 09 Dec 2018 02:45:16 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:15 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/24] gc: prune backup logs
Date:   Sun,  9 Dec 2018 11:44:09 +0100
Message-Id: <20181209104419.12639-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 backup-log.c | 33 +++++++++++++++++++++++++++++++++
 backup-log.h |  1 +
 builtin/gc.c |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/backup-log.c b/backup-log.c
index 5e38725981..dbb6d5487e 100644
--- a/backup-log.c
+++ b/backup-log.c
@@ -4,6 +4,7 @@
 #include "lockfile.h"
 #include "object-store.h"
 #include "strbuf.h"
+#include "worktree.h"
 
 void bkl_append(struct strbuf *output, const char *path,
 		const struct object_id *from,
@@ -288,3 +289,35 @@ int bkl_prune(struct repository *r, const char *path, timestamp_t expire)
 	strbuf_release(&opts.copy);
 	return ret;
 }
+
+void bkl_prune_all_or_die(struct repository *r, timestamp_t expire)
+{
+	struct worktree **worktrees, **p;
+	char *bkl_path;
+
+	bkl_path = repo_git_path(r, "common/gitdir.bkl");
+	if (bkl_prune(r, bkl_path, expire))
+		die(_("failed to prune %s"), "gitdir.bkl");
+	free(bkl_path);
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+
+		if (bkl_prune(r, worktree_git_path(wt, "index.bkl"), expire)) {
+			if (wt->id)
+				die(_("failed to prune %s on working tree '%s'"),
+				    "index.bkl", wt->id);
+			else
+				die(_("failed to prune %s"), "index.bkl");
+		}
+		if (bkl_prune(r, worktree_git_path(wt, "worktree.bkl"), expire)) {
+			if (wt->id)
+				die(_("failed to prune %s on working tree '%s'"),
+				    "worktree.bkl", wt->id);
+			else
+				die(_("failed to prune %s"), "worktree.bkl");
+		}
+	}
+	free_worktrees(worktrees);
+}
diff --git a/backup-log.h b/backup-log.h
index 06fe706f81..6572ce9c93 100644
--- a/backup-log.h
+++ b/backup-log.h
@@ -31,5 +31,6 @@ int bkl_parse_file(const char *path,
 		   void *data);
 
 int bkl_prune(struct repository *r, const char *id, timestamp_t expire);
+void bkl_prune_all_or_die(struct repository *r, timestamp_t expire);
 
 #endif
diff --git a/builtin/gc.c b/builtin/gc.c
index 871a56f1c5..50a5d46abb 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -27,6 +27,7 @@
 #include "pack-objects.h"
 #include "blob.h"
 #include "tree.h"
+#include "backup-log.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -657,6 +658,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
 		die(FAILED_RUN, rerere.argv[0]);
 
+	bkl_prune_all_or_die(the_repository, time(NULL) - 90 * 24 * 3600);
+
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);
 	if (pack_garbage.nr > 0)
-- 
2.20.0.rc2.486.g9832c05c3d

