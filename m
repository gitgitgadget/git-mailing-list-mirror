Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 812BC1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFZXu6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:50:58 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:38442 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:50:58 -0400
Received: by mail-qk1-f201.google.com with SMTP id n190so384979qkd.5
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sen6ZwQgv3aWuTbmAbGUnYrLEp4BCiEIQlsg2Gfb4qM=;
        b=PQBwy0CfLiyn5JA0lKCKQgpWLa5A5VZ9ZQmGDZBnzcWLFba06dcEyEj8/pgMNlT0EV
         GZz4drKTQ6eweATeNnjGR+IVdAC2kWkQ2KsnieaveCTF/shfiN0uABNOjMJtvHJLts7m
         cNAyT2bODneT7ItEAGeLZQHZ5nqd+ZjYZSBqV7bgxAZbd3SMpccwauxSc5PG6vaWY2Fy
         WfhZidqVdRnI68uWv8ltgtap91ac+klXL/QhJSWb/2vVkijarzLpzcha6Bisj1qj07iq
         zf6SyQAGSq/aI93geotM8EIGw98TMiO9uceygxGuyeizuxP4jmk3Wjtv3V4O5rlWJ8Ki
         Gaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sen6ZwQgv3aWuTbmAbGUnYrLEp4BCiEIQlsg2Gfb4qM=;
        b=Z+NTqqfBlXXEvZtceSAg5zQZjCgSfH3yUqm/LKpb2sxfwujJVpZUYSaRUR2seKjojY
         MhokEbVW1EGIqd+RY10CMv+EGgooUzQLWib1glh+e1bj1Gpsz2qWPxbcyNb50Ok2H97u
         JozSXhd78vQXQ3B6Wqfh0EFY9OPvPBtRS53IbSCVe9u4rB3dSJU5HZFAIz871nCVMjVR
         gLThoaFKxvM2wrhVgsqNgDX+gTaadOX88y0RQ7CAH9crQ+3ldNSC1QJL+wFGyzHeP/66
         7g4Rxfw16cztb+5+WGYc7ZTvFyyWlOnSD+zyjyMIcWt1NqxBYm8hG/yh04e1U+fJtbr6
         OiCQ==
X-Gm-Message-State: APjAAAX29B5sd1FUVCLH5wSqGd/63g5f/s8agYNqgmyM59GLuuitAvTC
        ZyN1LOa6/J9bUyU2Fzd5bLsjEd3j1k77eYmqcQ6XsQVzdah/GKf7H5jOxS+Stt61ruaNAX4UVYQ
        jBHt+pQfuGGME03gtEjrFI7YcFqV5sba0OXlx/d3vLlrWVP48Bqs/9g1PUQuCyeZU+CR4Vf51MA
        ==
X-Google-Smtp-Source: APXvYqwytdcU6y7z0C0FMxxC+hEtzEhQyQiaIuSsgQLyn2nPKHTxx69Vw7GTONOvktgl/ppAgGJq8H5O6yyAh1ZDTpY=
X-Received: by 2002:aed:3bb5:: with SMTP id r50mr512754qte.89.1561593057089;
 Wed, 26 Jun 2019 16:50:57 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:20 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 01/13] walken: add infrastructure for revwalk demo
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Begin to add scaffolding for `git walken`, a toy command which we will
teach to perform a number of revision walks, in order to demonstrate the
mechanics of revision walking for developers new to the Git project.

This commit is the beginning of an educational series which correspond
to the tutorial in Documentation/MyFirstRevWalk.txt.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I64297621919412f54701e111366e99c4ef0feae3
---
 Makefile         |  1 +
 builtin.h        |  1 +
 builtin/walken.c | 13 +++++++++++++
 3 files changed, 15 insertions(+)
 create mode 100644 builtin/walken.c

diff --git a/Makefile b/Makefile
index f58bf14c7b..5bac1dbf8d 100644
--- a/Makefile
+++ b/Makefile
@@ -1137,6 +1137,7 @@ BUILTIN_OBJS += builtin/var.o
 BUILTIN_OBJS += builtin/verify-commit.o
 BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
+BUILTIN_OBJS += builtin/walken.o
 BUILTIN_OBJS += builtin/worktree.o
 BUILTIN_OBJS += builtin/write-tree.o
 
diff --git a/builtin.h b/builtin.h
index ec7e0954c4..c919736c36 100644
--- a/builtin.h
+++ b/builtin.h
@@ -242,6 +242,7 @@ int cmd_var(int argc, const char **argv, const char *prefix);
 int cmd_verify_commit(int argc, const char **argv, const char *prefix);
 int cmd_verify_tag(int argc, const char **argv, const char *prefix);
 int cmd_version(int argc, const char **argv, const char *prefix);
+int cmd_walken(int argc, const char **argv, const char *prefix);
 int cmd_whatchanged(int argc, const char **argv, const char *prefix);
 int cmd_worktree(int argc, const char **argv, const char *prefix);
 int cmd_write_tree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/walken.c b/builtin/walken.c
new file mode 100644
index 0000000000..d2772a0e8f
--- /dev/null
+++ b/builtin/walken.c
@@ -0,0 +1,13 @@
+/*
+ * "git walken"
+ *
+ * Part of the "My First Revision Walk" tutorial.
+ */
+
+#include "builtin.h"
+
+int cmd_walken(int argc, const char **argv, const char *prefix)
+{
+	trace_printf(_("cmd_walken incoming...\n"));
+	return 0;
+}
-- 
2.22.0.410.gd8fdbe21b5-goog

