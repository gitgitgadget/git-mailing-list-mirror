Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5D3C64E8A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FB820782
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwMQHLKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbgKXLzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733077AbgKXLzE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 06:55:04 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84639C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:04 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so2189238wmd.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ubb0INeANAYMb16i69KeUX5xGYNDbvX9WtbpHIPN7E=;
        b=iwMQHLKTewTMZHhxiTjvRky2yp+kA+Hcly2J5/A9Pp4DavKIwP3HunBjVYvcORTe+3
         lgE1Y5/abpHqu46N5Viq+PH6foafjHWoCBpNCMY2vXI9X9tJh1pHS+Cx9LrOvHq4LFYN
         mrIXdc5HQ436oNxikK/BRwRT7Cl61Ht7z4ZOdX+XntWlaQoZ4EZ0YYoK3MaNTuqYa3Z0
         BcOdNdD8k2l0hucuXb8+E7litgRwE6BeN2gTsDODS/LDV1mUKjZiRPifTb1+6RO2m26g
         vbhtuKD2lgyY+u2apgisK753yzKoJdc4sQN/X7T+NRxHBjmvKudlQ4fGAAsLpns8OJTn
         iYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ubb0INeANAYMb16i69KeUX5xGYNDbvX9WtbpHIPN7E=;
        b=MRPYCvPMIDTZbb60G/kx+Sewktx9iTHv6N15iKDzKS5Cfldl42EX3Ot9yS5aehSt43
         Zl+TNbKwSShCmJMiFECiZ+4ApjjLyTIh6BGb8QBNZ1r+PTl69YCriEJpdAS6L9kXv2+c
         T7uLM9cY0zfIU5B/dr8Cd6VRECWnBoTY1MUI4sSXY74/8SWicAUE8NPwyDJqC7yjQA9Q
         AL0AEriWG5ahMKfGnPBEj77UvBhJRSd2Rr0n9RA/UbqDpuJERTc5ksFwhbcENEb3Kxdv
         rE83PQWenFrgSTY91/l2tzSxpqouhvMO1cX1F3lpzUkkN0mGl2whfoRvsDxKWGx63EtO
         1eiQ==
X-Gm-Message-State: AOAM532KK54WQn0W64O36q3v4m/AoinHyYPa3JHL1cYYmH7+obj4E1un
        le6Xy6TDEFFlUhBP/R5ShqLVnx7ue1I=
X-Google-Smtp-Source: ABdhPJxVku46VDcnaIX14v5LQBvPMjhwmJj2dsX8r9l1fzEYAphdx5/ZVFqeMhRC5YegGkj1i9trZg==
X-Received: by 2002:a05:600c:290a:: with SMTP id i10mr4159295wmd.187.1606218902980;
        Tue, 24 Nov 2020 03:55:02 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.googlemail.com with ESMTPSA id l13sm25893227wrm.24.2020.11.24.03.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:55:02 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 06/13] merge-index: don't fork if the requested program is `git-merge-one-file'
Date:   Tue, 24 Nov 2020 12:53:08 +0100
Message-Id: <20201124115315.13311-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since `git-merge-one-file' has been rewritten and libified, this teaches
`merge-index' to call merge_three_way() without forking using a new
callback, merge_one_file_func().

To avoid any issue with a shrinking index because of the merge function
used (directly in the process or by forking), as described earlier, the
iterator of the loop of merge_all_index() is increased by the number of
entries with the same name, minus the difference between the number of
entries in the index before and after the merge.

This should handle a shrinking index correctly, but could lead to issues
with a growing index.  However, this case is not treated, as there is no
callback that can produce such a case.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-index.c | 28 ++++++++++++++++++++++++++--
 merge-strategies.c    | 25 +++++++++++++++++++++----
 merge-strategies.h    |  7 +++++++
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index d5e5713b25..60fcde579f 100644
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
+	void *data = NULL;
+	merge_fn merge_action;
+	struct lock_file lock = LOCK_INIT;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -26,7 +30,18 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 		quiet = 1;
 		i++;
 	}
+
 	pgm = argv[i++];
+	setup_work_tree();
+
+	if (!strcmp(pgm, "git-merge-one-file")) {
+		merge_action = merge_one_file_func;
+		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
+	} else {
+		merge_action = merge_one_file_spawn;
+		data = (void *)pgm;
+	}
+
 	for (; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!force_file && *arg == '-') {
@@ -36,13 +51,22 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "-a")) {
 				err |= merge_all_index(the_repository, one_shot, quiet,
-						       merge_one_file_spawn, (void *)pgm);
+						       merge_action, data);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
 		err |= merge_index_path(the_repository, one_shot, quiet, arg,
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
index 6f27e66dfe..542cefcf3d 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -178,6 +178,18 @@ int merge_three_way(struct repository *r,
 	return 0;
 }
 
+int merge_one_file_func(struct repository *r,
+			const struct object_id *orig_blob,
+			const struct object_id *our_blob,
+			const struct object_id *their_blob, const char *path,
+			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+			void *data)
+{
+	return merge_three_way(r,
+			       orig_blob, our_blob, their_blob, path,
+			       orig_mode, our_mode, their_mode);
+}
+
 int merge_one_file_spawn(struct repository *r,
 			 const struct object_id *orig_blob,
 			 const struct object_id *our_blob,
@@ -261,17 +273,22 @@ int merge_all_index(struct repository *r, int oneshot, int quiet,
 		    merge_fn fn, void *data)
 {
 	int err = 0, ret;
-	unsigned int i;
+	unsigned int i, prev_nr;
 
 	for (i = 0; i < r->index->cache_nr; i++) {
 		const struct cache_entry *ce = r->index->cache[i];
 		if (!ce_stage(ce))
 			continue;
 
+		prev_nr = r->index->cache_nr;
 		ret = merge_entry(r, quiet || oneshot, i, ce->name, &err, fn, data);
-		if (ret > 0)
-			i += ret - 1;
-		else if (ret == -1)
+		if (ret > 0) {
+			/* Don't bother handling an index that has
+			   grown, since merge_one_file_func() can't grow
+			   it, and merge_one_file_spawn() can't change
+			   it. */
+			i += ret - (prev_nr - r->index->cache_nr) - 1;
+		} else if (ret == -1)
 			return -1;
 
 		if (err && !oneshot)
diff --git a/merge-strategies.h b/merge-strategies.h
index 94c40635c4..0b74d45431 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -16,6 +16,13 @@ typedef int (*merge_fn)(struct repository *r,
 			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
 			void *data);
 
+int merge_one_file_func(struct repository *r,
+			const struct object_id *orig_blob,
+			const struct object_id *our_blob,
+			const struct object_id *their_blob, const char *path,
+			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+			void *data);
+
 int merge_one_file_spawn(struct repository *r,
 			 const struct object_id *orig_blob,
 			 const struct object_id *our_blob,
-- 
2.29.2.260.ge31aba42fb

