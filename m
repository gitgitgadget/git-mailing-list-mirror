Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAEFC2BC11
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 293EC206EF
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxOevdNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIAK7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgIAK61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 06:58:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F4CC061247
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 03:58:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so1014314wrt.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 03:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9u6VhGt9mdyc7EjCCutN9MD/zciOgZS2KPfC/PQ6IoA=;
        b=pxOevdNCCbKKjzKcp2Av9ahz7pgSU1Vib4PI2H+37GcJlyP0kqYzqAL7r7mKv0QJYz
         QxPbGZ4mSk6kzeYrFZ3fRRKfTe7TMvsePThcvAJOxVyPWOtDYN7ZRbr46i6Vs6aG3Jno
         L5yb4Qz+A5hysSGqdE+7W14pQur7PH4W1JJEd4w+OKqxMmoQj9CCY7mfPYrSnB/oTj2/
         iySaTkSpaG0ROUYSqLP9p1NpjNrYd1KplS391Dl+dQUVNN3nzEdyGp/EUvBOwn//4JhL
         SQ8O/qu2I7GLMt86TpOpOh4fhXUFjxFdq6Ee3SFuz3NuaJYK31r6wFVtPoBcZCsoMvJo
         ZAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9u6VhGt9mdyc7EjCCutN9MD/zciOgZS2KPfC/PQ6IoA=;
        b=j54lVqac+X+061yygQZhkpa+gWiyHNQO8jgFCIdOl4abf3ZcO5fxnb0VLa9+pyOBms
         jiIMMe8c+5+WdVQlgf1s78eJOU55tj7Iwu9MR6eesCjz124YJs/wUBgJLGLaDYpdvt+B
         pBA1vx44m8E+mAFCFGLTYaBrPnfYi0mII7489hOx7bwSnygDEBquv9jvqPWEbJ3FCMp/
         rRlh8pr2TuOAqN61kB6kkSMK52FVllgCdZNSmOgd3yB1QI2YTKDreCJpT5yjySQ2IKho
         gTPy4vE0XGVWqj+XteKEgb4Mm+6SUWzAYj22bO1Go0S5tYYwJPFTsqWdVSjFm0iNVVSf
         elng==
X-Gm-Message-State: AOAM533T09NzkQIhpIr4cRPv/t1ZYdZBt79dCDzBrNTvxV0RTl6CrW7M
        r4jEYQXpTgAdbbJ6LauIxx2M3FadJnw=
X-Google-Smtp-Source: ABdhPJwJq9G4XHkbw1N0cIOMlZHEHZ5oajErmD1Q51MVWIP4cOgfMev91Y9atQ5QwhLVOd3+ywunIQ==
X-Received: by 2002:adf:ab57:: with SMTP id r23mr1315038wrc.386.1598957893282;
        Tue, 01 Sep 2020 03:58:13 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-378-135.w86-199.abo.wanadoo.fr. [86.199.233.135])
        by smtp.googlemail.com with ESMTPSA id x16sm1705875wrq.62.2020.09.01.03.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:58:12 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 04/11] merge-index: don't fork if the requested program is `git-merge-one-file'
Date:   Tue,  1 Sep 2020 12:56:58 +0200
Message-Id: <20200901105705.6059-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901105705.6059-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200901105705.6059-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since `git-merge-one-file' has been rewritten and libified, this teaches
`merge-index' to call merge_strategies_one_file() without forking using
a new callback, merge_one_file_cb().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-index.c | 29 +++++++++++++++++++++++++++--
 merge-strategies.c    | 11 +++++++++++
 merge-strategies.h    |  6 ++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 6cb666cc78..19fff9a113 100644
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
+	merge_cb merge_action;
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
+		merge_action = merge_one_file_cb;
+		data = (void *)the_repository;
+
+		setup_work_tree();
+		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
+	} else {
+		merge_action = merge_program_cb;
+		data = (void *)pgm;
+	}
+
 	for (; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!force_file && *arg == '-') {
@@ -36,13 +52,22 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "-a")) {
 				err |= merge_all(&the_index, one_shot, quiet,
-						 merge_program_cb, (void *)pgm);
+						 merge_action, data);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
 		err |= merge_one_path(&the_index, one_shot, quiet, arg,
-				      merge_program_cb, (void *)pgm);
+				      merge_action, data);
+	}
+
+	if (merge_action == merge_one_file_cb) {
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
index ffd6cf77d6..00738863e4 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -199,6 +199,17 @@ int merge_strategies_one_file(struct repository *r,
 	return 0;
 }
 
+int merge_one_file_cb(const struct object_id *orig_blob,
+		      const struct object_id *our_blob,
+		      const struct object_id *their_blob, const char *path,
+		      unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+		      void *data)
+{
+	return merge_strategies_one_file((struct repository *)data,
+					 orig_blob, our_blob, their_blob, path,
+					 orig_mode, our_mode, their_mode);
+}
+
 int merge_program_cb(const struct object_id *orig_blob,
 		     const struct object_id *our_blob,
 		     const struct object_id *their_blob, const char *path,
diff --git a/merge-strategies.h b/merge-strategies.h
index cf78d7eaf4..40e175ca39 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -16,6 +16,12 @@ typedef int (*merge_cb)(const struct object_id *orig_blob,
 			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
 			void *data);
 
+int merge_one_file_cb(const struct object_id *orig_blob,
+		      const struct object_id *our_blob,
+		      const struct object_id *their_blob, const char *path,
+		      unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+		      void *data);
+
 int merge_program_cb(const struct object_id *orig_blob,
 		     const struct object_id *our_blob,
 		     const struct object_id *their_blob, const char *path,
-- 
2.28.0.370.g2c2dc3cc62

