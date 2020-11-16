Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34ACC5519F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A857206D5
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dirDWaxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgKPKXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgKPKXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 05:23:14 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4207C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:13 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so18029314wrc.11
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eN5AsqAo7eJjL+aiPSr/B/Ni3cQHcqh53762V550vWw=;
        b=dirDWaxBvFQGLSMFexani1erzBcrV2GNGXSH9Z5VXg2pzwBYsjxTJC5TtSgPGzaxtq
         702qxdSwguQWG/oKZz/5NXqfxwGrQdmxzn5P/RxK2kYjMophYnvsy0aqyfGhA7zNAw9j
         z0UxMRjtDjRKZ9BhqI9n19xZo5EHoqQx+l01u17uCfKMF6ImFy6NE8MhRZtJUGGyXiG4
         RK1XjJ7JaVZXW0H66xYa/3P5a7BvNzWvbb7cM9YRjcRkxZZY7VCD/g41fLOC2RKJ8H+u
         DuELlTq+nCxr8YWkUQmIECqTqJ1Ztp/sdztGiM+o13laWTcBTWJA2//Wv9mNUA+sYXjf
         KJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eN5AsqAo7eJjL+aiPSr/B/Ni3cQHcqh53762V550vWw=;
        b=jiAI1AmNPaO40wxIN9zU3GPyIIZwHr5JM5+ysCzQLug+MsfSODQlB9lqxGMShet1Ya
         heLlYkZSVLQk6R+45wYuMyK8F2c9jcorEwzYLiKlFzmIonCuO5erjUqk5yAYc5AUYEUw
         cQJ2Jxp9w7uG27Kq/B0Rs4PUSRHnFjIxCIB+NMS7U7V3j9eDtRy85uusyTHMSujDpWXB
         Hn2Z2mANjwr22ewW7PGd1qfIxXHfc2tIYC9kUPlEwrVRV+n/eWvjGg3a5mrlnFQxgCo8
         l8agt7tDOq1C3RbofZQD4uz6KBASWA5j0AK9dunM2CvMQ+ASSNBWsMjGlrPWL1DUsP/J
         7VTQ==
X-Gm-Message-State: AOAM532+zj1SgMCkJ5oFvNeORlnboUX1RiulBaueuM3Ym6NJj/XHn/HU
        Uag3qImYB6gauSDT5ZMLHKEqXyejdzY=
X-Google-Smtp-Source: ABdhPJwP3Q1giA0ezkC/Rq7jQZH9DImPl6DIv93hsxzkX3v9rV4RY6FSo1F/K8WrKBUG0PMRLQ1jTQ==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr18333865wrv.299.1605522192408;
        Mon, 16 Nov 2020 02:23:12 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id f5sm22884520wrg.32.2020.11.16.02.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:23:11 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 05/12] merge-index: don't fork if the requested program is `git-merge-one-file'
Date:   Mon, 16 Nov 2020 11:21:51 +0100
Message-Id: <20201116102158.8365-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116102158.8365-1-alban.gruin@gmail.com>
References: <20201113110428.21265-1-alban.gruin@gmail.com>
 <20201116102158.8365-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since `git-merge-one-file' has been rewritten and libified, this teaches
`merge-index' to call merge_three_way() without forking using a new
callback, merge_one_file_func().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-index.c | 29 +++++++++++++++++++++++++++--
 merge-strategies.c    | 11 +++++++++++
 merge-strategies.h    |  6 ++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 49e3382fb9..e684811d35 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,11 +1,15 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
+#include "lockfile.h"
 #include "merge-strategies.h"
 
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
 	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
 	const char *pgm;
+	void *data;
+	merge_fn merge_action;
+	struct lock_file lock = LOCK_INIT;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -26,7 +30,19 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 		quiet = 1;
 		i++;
 	}
+
 	pgm = argv[i++];
+	if (!strcmp(pgm, "git-merge-one-file")) {
+		merge_action = merge_one_file_func;
+		data = (void *)the_repository;
+
+		setup_work_tree();
+		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
+	} else {
+		merge_action = merge_one_file_spawn;
+		data = (void *)pgm;
+	}
+
 	for (; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!force_file && *arg == '-') {
@@ -36,13 +52,22 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "-a")) {
 				err |= merge_all_index(&the_index, one_shot, quiet,
-						       merge_one_file_spawn, (void *)pgm);
+						       merge_action, data);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
 		err |= merge_index_path(&the_index, one_shot, quiet, arg,
-					merge_one_file_spawn, (void *)pgm);
+					merge_action, data);
+	}
+
+	if (merge_action == merge_one_file_func) {
+		if (err) {
+			rollback_lock_file(&lock);
+			return err;
+		}
+
+		return write_locked_index(&the_index, &lock, COMMIT_LOCK);
 	}
 	return err;
 }
diff --git a/merge-strategies.c b/merge-strategies.c
index 4eb96129f1..2ed3a8dd68 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -176,6 +176,17 @@ int merge_three_way(struct repository *r,
 	return 0;
 }
 
+int merge_one_file_func(const struct object_id *orig_blob,
+			const struct object_id *our_blob,
+			const struct object_id *their_blob, const char *path,
+			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+			void *data)
+{
+	return merge_three_way((struct repository *)data,
+			       orig_blob, our_blob, their_blob, path,
+			       orig_mode, our_mode, their_mode);
+}
+
 int merge_one_file_spawn(const struct object_id *orig_blob,
 			 const struct object_id *our_blob,
 			 const struct object_id *their_blob, const char *path,
diff --git a/merge-strategies.h b/merge-strategies.h
index d2f52d6792..b69a12b390 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -15,6 +15,12 @@ typedef int (*merge_fn)(const struct object_id *orig_blob,
 			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
 			void *data);
 
+int merge_one_file_func(const struct object_id *orig_blob,
+			const struct object_id *our_blob,
+			const struct object_id *their_blob, const char *path,
+			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+			void *data);
+
 int merge_one_file_spawn(const struct object_id *orig_blob,
 			 const struct object_id *our_blob,
 			 const struct object_id *their_blob, const char *path,
-- 
2.20.1

