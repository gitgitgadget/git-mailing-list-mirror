Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351A31F42D
	for <e@80x24.org>; Sun, 20 May 2018 10:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeETKSk (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 06:18:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40744 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeETKSh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 06:18:37 -0400
Received: by mail-wr0-f193.google.com with SMTP id v60-v6so13176777wrc.7
        for <git@vger.kernel.org>; Sun, 20 May 2018 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cz0haGE8hp1KgfnD4lK3PesdeeDKG+Os0EO5WQvKqBw=;
        b=H7GKzKUjR4FEp6hBsXLXEWMUzsCixky+ER/sdRK+jzcucpOfaT8XH3IkKjNhARgnw+
         jkqXilYbNQhRoB/ef52PKnJ0kywfquiU2XVtxK+ActZXAZETcIzLjrexHTJwn5GTIS3i
         qu3VXqn61qgzOiVlxujcxerO7WKJTL3n73tXt/96WGmuZ+Mkx9VllROvUdCF02EX1ODD
         kqkCXeVzqQ7oOuSON63pBTmX65pC+Un/oYG0CA69oeUc/X4LVLSCVXiOe4OVvVEFwe+F
         yVS4uYAkCoegj9vjCHrq5sM6UJoHAveTDhAXGD4gvA8YPuzaMMNezWzUXye4MT84t1aP
         mMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cz0haGE8hp1KgfnD4lK3PesdeeDKG+Os0EO5WQvKqBw=;
        b=dI+PTLlrccpNDjcmCo9zOEoHulHdivt8nZ1utuRDZ/gzsti5FbfXgEFv2X5GCm0x+g
         UGnVbarZF4PPzzlFHODlLLrYtQrp0BjkoW6/4H9fIV1ZOkFOhh56jFP0QbicSfEWCOWd
         3uXPssk4r6b531SUkbsGfyEd34AWLrg01Pc1L12xG66/9RtgyrUhEqm674Yrgxfi5Bie
         D6nnmdMn5+MOaWRte7ymcmyWWWyxPh1zi5MOxAmmfIBbxP+YNShaDWJJrTkXpR7mRXx+
         Jmm+fRFJToNGV2CwWGIV8E9tYl4YjH0oi/gjz1Ki0ks2Clx+AWbeR6asLr0/vhVcmm+B
         Rd4w==
X-Gm-Message-State: ALKqPwf2JQMxb7CET/nYOxkDsbfFHhu0a/opNTXW2Nywcl6jPLshjvHf
        x+0Qn//bNH0korQvJRlAul8RNWz1Ucw=
X-Google-Smtp-Source: AB8JxZoh0g1rdN25h3ZHmjjVk6QjZ4XxtjVSFJ8kSAVqKfBYnzCHwSsG2k3GnTbye667KKHoYa1i0w==
X-Received: by 2002:adf:a005:: with SMTP id k5-v6mr12415995wrk.202.1526811516145;
        Sun, 20 May 2018 03:18:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t189-v6sm10210374wmf.22.2018.05.20.03.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 03:18:35 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 4/4] unpack_trees_options: free messages when done
Date:   Sun, 20 May 2018 12:17:37 +0200
Message-Id: <93230899d8491b0282a617233d23e9773fe8ec73.1526810549.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526810549.git.martin.agren@gmail.com>
References: <CAN0heSp7DqxOy-UeLgj8t_T_4f-fNthMpGNS8oUbcs7+NvS-zw@mail.gmail.com> <cover.1526810549.git.martin.agren@gmail.com>
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
not free what we must not free and that we do not double-free. Keep the
unique, heap-allocated pointers in a separate string list, to make the
freeing safe and future-proof.

Zero the whole array of string pointers to make sure that we do not
leave any dangling pointers.

Note that we only take responsibility for the memory allocated in
`setup_unpack_trees_porcelain()` and not any other members of the
`struct unpack_trees_options`.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 unpack-trees.h     |  6 ++++++
 builtin/checkout.c |  1 +
 merge-recursive.c  |  1 +
 merge.c            |  3 +++
 unpack-trees.c     | 20 +++++++++++++++++---
 5 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.h b/unpack-trees.h
index 41178ada94..5a84123a40 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
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
+	struct string_list msgs_to_free;
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
index 79fd97074e..86046b987a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -103,6 +103,12 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	const char **msgs = opts->msgs;
 	const char *msg;
 
+	/*
+	 * As we add strings using `...appendf()`, this does not matter,
+	 * but when we clear the string list, we want them to be freed.
+	 */
+	opts->msgs_to_free.strdup_strings = 1;
+
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
 		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
@@ -119,7 +125,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			  "Please commit your changes or stash them before you %s.")
 		      : _("Your local changes to the following files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
-		xstrfmt(msg, cmd, cmd);
+		string_list_appendf(&opts->msgs_to_free, msg, cmd, cmd)->string;
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in them:\n%s");
@@ -139,7 +145,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		      ? _("The following untracked working tree files would be removed by %s:\n%%s"
 			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be removed by %s:\n%%s");
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, cmd, cmd);
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] =
+		string_list_appendf(&opts->msgs_to_free, msg, cmd, cmd)->string;
 
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
@@ -156,7 +163,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		      ? _("The following untracked working tree files would be overwritten by %s:\n%%s"
 			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, cmd, cmd);
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] =
+		string_list_appendf(&opts->msgs_to_free, msg, cmd, cmd)->string;
 
 	/*
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
@@ -179,6 +187,12 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		opts->unpack_rejects[i].strdup_strings = 1;
 }
 
+void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
+{
+	string_list_clear(&opts->msgs_to_free, 0);
+	memset(opts->msgs, 0, sizeof(opts->msgs));
+}
+
 static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 			 unsigned int set, unsigned int clear)
 {
-- 
2.17.0.840.g5d83f92caf

