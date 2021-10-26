Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A93C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB965610A2
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbhJZWiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 18:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhJZWh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 18:37:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F074C061220
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:35:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g141so815106wmg.4
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CA2tqvf0iPoQU9EZel2QXt0Wb/Fc1vAjZ5KIReZC3vc=;
        b=mZwqjM37IJU5pVEbaHWG9EufUwxiEnht2msXLvQ0l1TYhEUpTH96BfVy5pcWX7WpG1
         /9Ijlav2+hk4v/NzwYc//zr9Wuz2gs3tiQV+sfT3SxrcwnkMxaIA8l2cQnlSz7HKh0ka
         slJ4x/l5P9qUVlGXXMG4uWYWvSssCMHRtdB1cGdDrjVzLezgpQxrfIDWiCSnJWedx1vQ
         1KHgDBaQ4rMoeLbY+MXhmoDUpRrb2a6QxCQHdKUUSNk9Jv0N//PZV86J5S+pSgxzleXj
         j6ME8kTaXvXY9CakoIYR4TM/gxiTM/RZXiEpnsvR1wKdxHd1oXdNwM10lb/FJjOEMCGg
         tNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CA2tqvf0iPoQU9EZel2QXt0Wb/Fc1vAjZ5KIReZC3vc=;
        b=BjiMvjleICpOKgZdMkW5R3t+bD5q0+JfRuvAKVSzqbpjvh2Zg7POMNOqEUO5t4AilH
         QbjFFaZ/nKWbc6iYkoHAaKUaGF7xRv+oCJOfdf+w4toGEHRxmTSOUoONKlxOz3lD81rg
         Rsvy+ydO4S5wfU1t1gN1WNwLU9ACfBtV2m6jUy4sMU2Izug8n6Aljqi+fPJi+bdMb1uf
         8oqtwWTMffimyHarMVHy4Dj6f2beUnG40NfvKXruPEy0un1AhB4rrhbdZ4A9b9WrmOVb
         2CVy8fMg32TJTM0Ng1gh3uFLn+MNVtDC8CFX+/NIUM4OBI7eIXto3wSNoZUNWu7IDKT7
         J5iw==
X-Gm-Message-State: AOAM533xNRdZ1tsyhgQPNPY7FDLGvQnORpmHSr8cITzgctmFN7y9mBu/
        z4lzbQXmE/nhTolikl1HK467p06iKrw=
X-Google-Smtp-Source: ABdhPJz58p43HeuR4fa54YNal52ahkfc/+P6YTflVcG2+FghYtPGrawuJrPffpfwCZFfchoxx03J5w==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr1669963wmb.150.1635287732609;
        Tue, 26 Oct 2021 15:35:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12sm1809769wmq.44.2021.10.26.15.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:35:32 -0700 (PDT)
Message-Id: <ef5a087813b7dfd232a9366eee09774d197e2307.1635287730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.git.1635287730.gitgitgadget@gmail.com>
References: <pull.1067.git.1635287730.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Oct 2021 22:35:30 +0000
Subject: [PATCH 2/2] fixup! tmp-objdir: new API for creating temporary
 writable databases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

When setup_work_tree executes, it redoes setup of the object database
path and various other aspects of the_repository.  This destroys the
temporary object database state.

This commit removes the temporary object database and reapplies it
around the operations in the chdir_notify callback.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 environment.c |  5 +++++
 tmp-objdir.c  | 25 +++++++++++++++++++++++++
 tmp-objdir.h  | 15 +++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/environment.c b/environment.c
index 46ec5072c05..7ba5ae06c71 100644
--- a/environment.c
+++ b/environment.c
@@ -17,6 +17,7 @@
 #include "commit.h"
 #include "strvec.h"
 #include "object-store.h"
+#include "tmp-objdir.h"
 #include "chdir-notify.h"
 #include "shallow.h"
 
@@ -344,10 +345,14 @@ static void update_relative_gitdir(const char *name,
 				   void *data)
 {
 	char *path = reparent_relative_path(old_cwd, new_cwd, get_git_dir());
+	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
 	trace_printf_key(&trace_setup_key,
 			 "setup: move $GIT_DIR to '%s'",
 			 path);
+
 	set_git_dir_1(path);
+	if (tmp_objdir)
+		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
 	free(path);
 }
 
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 45d42a7bcf0..3d38eeab66b 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tmp-objdir.h"
+#include "chdir-notify.h"
 #include "dir.h"
 #include "sigchain.h"
 #include "string-list.h"
@@ -12,6 +13,7 @@ struct tmp_objdir {
 	struct strbuf path;
 	struct strvec env;
 	struct object_directory *prev_odb;
+	int will_destroy;
 };
 
 /*
@@ -315,4 +317,27 @@ void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
 	if (t->prev_odb)
 		BUG("the primary object database is already replaced");
 	t->prev_odb = set_temporary_primary_odb(t->path.buf, will_destroy);
+	t->will_destroy = will_destroy;
+}
+
+struct tmp_objdir *tmp_objdir_unapply_primary_odb(void)
+{
+	if (!the_tmp_objdir || !the_tmp_objdir->prev_odb)
+		return NULL;
+
+	restore_primary_odb(the_tmp_objdir->prev_odb, the_tmp_objdir->path.buf);
+	the_tmp_objdir->prev_odb = NULL;
+	return the_tmp_objdir;
+}
+
+void tmp_objdir_reapply_primary_odb(struct tmp_objdir *t, const char *old_cwd,
+		const char *new_cwd)
+{
+	char *path;
+
+	path = reparent_relative_path(old_cwd, new_cwd, t->path.buf);
+	strbuf_reset(&t->path);
+	strbuf_addstr(&t->path, path);
+	free(path);
+	tmp_objdir_replace_primary_odb(t, t->will_destroy);
 }
diff --git a/tmp-objdir.h b/tmp-objdir.h
index 75754cbfba6..a3145051f25 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -59,4 +59,19 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
  */
 void tmp_objdir_replace_primary_odb(struct tmp_objdir *, int will_destroy);
 
+/*
+ * If the primary object database was replaced by a temporary object directory,
+ * restore it to its original value while keeping the directory contents around.
+ * Returns NULL if the primary object database was not replaced.
+ */
+struct tmp_objdir *tmp_objdir_unapply_primary_odb(void);
+
+/*
+ * Reapplies the former primary temporary object database, after protentially
+ * changing its relative path.
+ */
+void tmp_objdir_reapply_primary_odb(struct tmp_objdir *, const char *old_cwd,
+		const char *new_cwd);
+
+
 #endif /* TMP_OBJDIR_H */
-- 
gitgitgadget
