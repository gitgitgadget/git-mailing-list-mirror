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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94CAC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F682224C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqeK/7Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgKMMLG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgKMMLF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:11:05 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A39C0617A6
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:10:55 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so2377463wrt.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UiyC54l9v2XbmUn2Eb9DWlWjmAiu3dBfYmc0opmC7/0=;
        b=FqeK/7Hxdtfn1JR5qKSaDy2EIK46ZbB9FbMpz+4RWFXarMMBezmChjDofJPPrANFmF
         cD6HOgs6pftAzQhsbjc6DiNiZxzLKW020WVC2LSKvdpSF55+JAUYWZ9v18aIibma5ZlS
         ZuiC+iq40mUpI3JzEo/HU//5a3lr35t1YWVAityGRIJa7VIdnFLAXC4/yXLFpujdpqqx
         4paFwj0PT2rOCUaLrdFU5GitlfAhxp54L13JSBVNTeD6AxevYpkDKcFnFy+xZAYeBiUV
         dH2o5fSA00YIfNCFyNy7u/MqyjYd6EMCOdjeAzxGIvt0Z+CdVaAklP4dBQ0nYwB4Whjl
         ky8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UiyC54l9v2XbmUn2Eb9DWlWjmAiu3dBfYmc0opmC7/0=;
        b=mmooI8L6rjkuouKEf5Lr42X/fjLuEKipq7bFJ+GEpEDuPgoAngmkes8asLNTyMSYdv
         i4U1RH38REz2AD5tXEBdW8IOVPTlUqlUH02cwFwULr7pjcxYssb2vpUYvEHf9/1iA2/b
         1Mnj/x3PiuKcqxlmYackuopcY4XsWAVql4bkr3WMx8DlKQ4E6KxPFBibGxaomKm3VMNl
         +dXyUcO3xGl94LMrqJrBD1FFtNVbRnkT1/0VVcqf3vDnToGlpot3pWummE+yeK+GpEL2
         H8uzLj++P3S5jCwoTtBRy0xtYwdkmlYp+wp859QElCG2Sd+OkAGrjRcJbAD8GARSM+SW
         Q8HQ==
X-Gm-Message-State: AOAM530+yozflHtqor+BZwIIzLo3MpWFpNJvAZXr9nWGlIfIz00/333J
        h5O8SXimixcWreEuwNDFYY+p9vlFrgE=
X-Google-Smtp-Source: ABdhPJydHckGJEV30u5wmV0FHYjnuwMYPgWBhqp3rHxtxKiBY6BD5/QllS/2v6dDiX0G34wvY4UrHQ==
X-Received: by 2002:a5d:4409:: with SMTP id z9mr3017449wrq.309.1605269453571;
        Fri, 13 Nov 2020 04:10:53 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id g138sm10083697wme.39.2020.11.13.04.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:10:52 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 05/12] merge-index: don't fork if the requested program is `git-merge-one-file'
Date:   Fri, 13 Nov 2020 12:04:21 +0100
Message-Id: <20201113110428.21265-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113110428.21265-1-alban.gruin@gmail.com>
References: <20201005122646.27994-1-alban.gruin@gmail.com>
 <20201113110428.21265-1-alban.gruin@gmail.com>
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
index e1d121c993..aa31b7045c 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -173,6 +173,17 @@ int merge_three_way(struct repository *r,
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

