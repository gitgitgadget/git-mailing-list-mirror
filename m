Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C49C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3252085B
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcbqKduc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgJEM1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJEM1n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:27:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D74C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:27:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e17so641180wru.12
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQ0GJ4E36ELS4BFjFwFHRqCVo74tbgfktw0J6x7UGhU=;
        b=dcbqKduczbDNIfKMmgXiXi+vOdzMtqZTTe3LbZ8dXYQsFsHK/cCzq4kDEXnfYWMCP0
         NgJVJbnYGdSXXgN0qPCIggjgExzMRqM6BmzPi0u6Ujzi8qtsxKezIi/zRouYHJKPZ5Cf
         NHq6lGtehYVRng4CT9R5IR0Y3DuDWP7Bvwtp2jRQAenrKVqwNBYlMivpupDrmKNRcaN+
         oTGCTRPmL4YcfwE3sfZGRxYW/k6zSSCGnGyJZsVHgJ00t8H9OrJOYaXt0hAuVOxdptPD
         TAfpnR5ITxYXgLirtACXDu8wuhF/LmfGuwQC9mzzIymOQv+7tltYx4bd3xB/cAfX2ywA
         t3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQ0GJ4E36ELS4BFjFwFHRqCVo74tbgfktw0J6x7UGhU=;
        b=md/QpI7G0xy3dBiglIupwuJaSa9sJk9hQVyQavSvanD74+VEmeHDhRRyJM4LKa0rqd
         XpjcNIs+i/U3YhliuUYb1EeyFfRmShFPeV/fQsiy2SBrn3f2F+QpcaIzStdKSE8JSB/i
         eP1I55LJ1/wPTP+L6SsjmaXTfyKBEKcOlbseAGN+koWKGKBuPacca0hLXUTSobgBhlOy
         naC2l1O14Nkp7Z8rO9JFLILVdUcv9zYeCp+U/U88oQ54MY1ZSVk6Ei0KQPikKXWZnD+c
         j0dFYwtoqg4WK0IgXQk9t0Y7cNqfv39oyybHftTYZNE7kxy1LsRwGO1DgeVTsqLDIebX
         HozQ==
X-Gm-Message-State: AOAM532zr1iz0pQIleBjVV+0N8PDw+C/9t87o12VJJ5jl+x6e/JgCeI5
        FTNXRYaNcWFpW3gVN7YF9QERnNevIPk=
X-Google-Smtp-Source: ABdhPJzlezWKGBpCNjmzmSunJW/i6ygV95zs9Bou+GI5EfeaLH6+zaOpteNkgFMhcUg6RS6Qr38KFQ==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr12082943wrb.292.1601900861473;
        Mon, 05 Oct 2020 05:27:41 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-293-21.w86-199.abo.wanadoo.fr. [86.199.76.21])
        by smtp.googlemail.com with ESMTPSA id n2sm13270400wma.29.2020.10.05.05.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:40 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 04/11] merge-index: don't fork if the requested program is `git-merge-one-file'
Date:   Mon,  5 Oct 2020 14:26:39 +0200
Message-Id: <20201005122646.27994-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201005122646.27994-1-alban.gruin@gmail.com>
References: <20200901105705.6059-1-alban.gruin@gmail.com>
 <20201005122646.27994-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index f0e30f5624..c022ba9748 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -214,6 +214,17 @@ int merge_strategies_one_file(struct repository *r,
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
2.28.0.662.ge304723957

