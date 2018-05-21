Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D7E1200B9
	for <e@80x24.org>; Mon, 21 May 2018 14:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbeEUOzP (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 10:55:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35862 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbeEUOzM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 10:55:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id k5-v6so4223102wrn.3
        for <git@vger.kernel.org>; Mon, 21 May 2018 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhvrAdEOm4kKcASrPOEM2M3aehSZHLhkIMRHGLSLHHw=;
        b=ew/T5fa0W/39Yhu9b1+amqjEIWpBc3+In+auz+Db40DVMX4zWo8w1wjzqD/i903Ukp
         zkO/TUldQe7o/V7gMRJ+Y1nC1OqukCGWwSmud25FaMsiO84balJ51ypV/ISkBMjfkQ3j
         QfAQlhn0o0GxtTNJSchtnp1PFUT6W4zVjnDGEyTqtyhgUc/TybD2A4VmtqrBh4/PhhLG
         AuxHlGGmR/p69xEC2HzVwE4BR8uID2rGD3V1AIu9Hh2tWd7rC0gCeH5YdPDFMS9xDUWf
         fwX67CvM+Qr+UohXagW8CC/kAsBK3YHF93dnnq4Fi4mrfPQIsZzV6rC52uq3wBiC3TF9
         lIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhvrAdEOm4kKcASrPOEM2M3aehSZHLhkIMRHGLSLHHw=;
        b=a849dENoe129SQSmx6ud8KaDSPQs4ozq+oZP9eoFCPo6v8j52m+Ljj5ebfcLPMCKsn
         uxmslOw0HF057ANxipzI143PjqdD5HfO7V/QA6zMsQE6v4aZyCr2L5/o6i3fNqghfaN6
         MQIHY3FTf0kee/2odR870in3F9h9tj019HELJBDd21OQQAROOlZp8EGEDmI0FSvPiDQB
         FFje7fh83rijivWM9esnds9uZvNUMpVQX+UFJJnrkXHcr89bv7wBDOVBL4x0SdvhbfAF
         Vqxg9pkgZ50NOX83486lf2cFi/kq0lyxahVRaPiEvM7F28z4et+c40XXD9EIoV44PUfs
         i6lA==
X-Gm-Message-State: ALKqPwcBhlIo67k1mPlJNQyauUdj6nCLMu3duRPVbjrIOoAr38slduKp
        DVttpubcCOTgDSMf6Ge4ooY=
X-Google-Smtp-Source: AB8JxZrg74nvtCThlKoQpaLfs+XHAkBEzp5H7T2JjlGaVsIKjyTSFKnk6b6mwEmzPjZau4eMaby2aQ==
X-Received: by 2002:adf:c109:: with SMTP id r9-v6mr2639191wre.84.1526914511357;
        Mon, 21 May 2018 07:55:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id b10-v6sm37627460wrn.42.2018.05.21.07.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 May 2018 07:55:10 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 4/4] unpack_trees_options: free messages when done
Date:   Mon, 21 May 2018 16:54:28 +0200
Message-Id: <18a37ca30fe644ebd635807aba1513992220ebd6.1526913784.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526913784.git.martin.agren@gmail.com>
References: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com> <cover.1526913784.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strings allocated in `setup_unpack_trees_porcelain()` are never
freed. Provide a function `clear_unpack_trees_porcelain()` to do so and
call it where we use `setup_unpack_trees_porcelain()`. The only
non-trivial user is `unpack_trees_start()`, where we should place the
new call in `unpack_trees_finish()`.

We keep the string pointers in an array, mixing pointers to static
memory and memory that we allocate on the heap. We also keep several
copies of the individual pointers. So we need to make sure that we do
not free what we must not free and that we do not double-free. Let a
separate argv_array take ownership of all the strings we create so that
we can easily free them.

Zero the whole array of string pointers to make sure that we do not
leave any dangling pointers.

Note that we only take responsibility for the memory allocated in
`setup_unpack_trees_porcelain()` and not any other members of the
`struct unpack_trees_options`.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 unpack-trees.h     |  8 +++++++-
 builtin/checkout.c |  1 +
 merge-recursive.c  |  1 +
 merge.c            |  3 +++
 unpack-trees.c     | 17 ++++++++++++++---
 5 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.h b/unpack-trees.h
index 41178ada94..c2b434c606 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -2,7 +2,7 @@
 #define UNPACK_TREES_H
 
 #include "tree-walk.h"
-#include "string-list.h"
+#include "argv-array.h"
 
 #define MAX_UNPACK_TREES 8
 
@@ -33,6 +33,11 @@ enum unpack_trees_error_types {
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd);
 
+/*
+ * Frees resources allocated by setup_unpack_trees_porcelain().
+ */
+void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
+
 struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
@@ -57,6 +62,7 @@ struct unpack_trees_options {
 	struct pathspec *pathspec;
 	merge_fn_t fn;
 	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
+	struct argv_array msgs_to_free;
 	/*
 	 * Store error messages in an array, each case
 	 * corresponding to a error message type
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b49b582071..5cebe170fc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -526,6 +526,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
+		clear_unpack_trees_porcelain(&topts);
 		if (ret == -1) {
 			/*
 			 * Unpack couldn't do a trivial merge; either
diff --git a/merge-recursive.c b/merge-recursive.c
index ddb0fa7369..338f63a952 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -382,6 +382,7 @@ static int unpack_trees_start(struct merge_options *o,
 static void unpack_trees_finish(struct merge_options *o)
 {
 	discard_index(&o->orig_index);
+	clear_unpack_trees_porcelain(&o->unpack_opts);
 }
 
 struct tree *write_tree_from_memory(struct merge_options *o)
diff --git a/merge.c b/merge.c
index f123658e58..b433291d0c 100644
--- a/merge.c
+++ b/merge.c
@@ -130,8 +130,11 @@ int checkout_fast_forward(const struct object_id *head,
 
 	if (unpack_trees(nr_trees, t, &opts)) {
 		rollback_lock_file(&lock_file);
+		clear_unpack_trees_porcelain(&opts);
 		return -1;
 	}
+	clear_unpack_trees_porcelain(&opts);
+
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
 	return 0;
diff --git a/unpack-trees.c b/unpack-trees.c
index 79fd97074e..73a6dc1701 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,5 +1,6 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "argv-array.h"
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
@@ -103,6 +104,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	const char **msgs = opts->msgs;
 	const char *msg;
 
+	argv_array_init(&opts->msgs_to_free);
+
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
 		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
@@ -119,7 +122,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			  "Please commit your changes or stash them before you %s.")
 		      : _("Your local changes to the following files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
-		xstrfmt(msg, cmd, cmd);
+		argv_array_pushf(&opts->msgs_to_free, msg, cmd, cmd);
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in them:\n%s");
@@ -139,7 +142,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		      ? _("The following untracked working tree files would be removed by %s:\n%%s"
 			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be removed by %s:\n%%s");
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, cmd, cmd);
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] =
+		argv_array_pushf(&opts->msgs_to_free, msg, cmd, cmd);
 
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
@@ -156,7 +160,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		      ? _("The following untracked working tree files would be overwritten by %s:\n%%s"
 			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, cmd, cmd);
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] =
+		argv_array_pushf(&opts->msgs_to_free, msg, cmd, cmd);
 
 	/*
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
@@ -179,6 +184,12 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		opts->unpack_rejects[i].strdup_strings = 1;
 }
 
+void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
+{
+	argv_array_clear(&opts->msgs_to_free);
+	memset(opts->msgs, 0, sizeof(opts->msgs));
+}
+
 static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 			 unsigned int set, unsigned int clear)
 {
-- 
2.17.0.840.g5d83f92caf

