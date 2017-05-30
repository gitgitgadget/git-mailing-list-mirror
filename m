Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8C62027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdE3RcT (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:19 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33094 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdE3Rbu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:50 -0400
Received: by mail-pf0-f174.google.com with SMTP id e193so78469162pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M/EXqS6bi+c2nmKq4M+9ybx1+kO+A9EkufwoHqGn9Vg=;
        b=PWQXE7HsyxX43bygQxERiSk6gwG9YLdVSQGtTxhhf9rQMYN5dHa9mPs5PjtPwLziPi
         l672PxinRPoJavpjjOC1BClYEm7MqP4BL9u7ekaC3E6/M++FZRMrBmYGyigQY5Clakay
         N05Nba5ID4hOxux4LSmUIkl7DaIj2CzX0JMF6k4RPzhNK7EKpRPhnfrHpehfIOO6GBai
         ePwFFncwYk3Dt4DRl9B24NkbUudZKJhtwgSMIZGDsNPIGQMqBW7vvWHo1QXiWs2PSyqL
         N43/RrioYMqDt2OhO+6ASvi3vK8Cg+Z13rRpBtFFzzCiYC8R4inecU73sj7Hvt1M190o
         KKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M/EXqS6bi+c2nmKq4M+9ybx1+kO+A9EkufwoHqGn9Vg=;
        b=foKrrpr/p999uGNCj421aSwUwVqv1SheobNfIPxYisWkxp2ThVR2xuG6UcqeCNUMZ2
         2WEexXUqorMEH2Z/0jUZvQ0aBXsPW+ec8HI5I2C11rB+EkwLl+JBL1vAtUzES1Xb9U1b
         NM6aTAGi0WBDcrPknZJ0uOhmsJTEx0iL+AdG+cq5VxySqM+/guPj7LsFBu3vZbWOENcX
         gYMCVn4dPIvq5XUQ2Ii8UWtVDdxxLIi+YThl6w1ySgP64lI+rVuQr7uF2gCMwXswvXXG
         hfOHy/AkFs+jwjj9rRoGUkTnJG3fUWQ5m5QSv5bLCamFCoy5AbbK8aDMAifZOIKF96Qr
         p2hw==
X-Gm-Message-State: AODbwcBVotKdHBU/6vmg+NJ2Adm43wDk1ldfMzw4Yz8s4Ds3G7wIKBYA
        Af/URCcY15470JBPX0+YIQ==
X-Received: by 10.101.69.143 with SMTP id o15mr944136pgq.84.1496165509185;
        Tue, 30 May 2017 10:31:49 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:47 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 22/33] notes-merge: convert notes_merge* to struct object_id
Date:   Tue, 30 May 2017 10:30:58 -0700
Message-Id: <20170530173109.54904-23-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert notes_merge and notes_merge_commit to use struct object_id.


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/notes.c |  6 +++---
 notes-merge.c   | 58 ++++++++++++++++++++++++++++-----------------------------
 notes-merge.h   | 12 ++++++------
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index b13fc8789..2ebc2b7c4 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -724,7 +724,7 @@ static int merge_commit(struct notes_merge_options *o)
 	if (!o->local_ref)
 		die(_("failed to resolve NOTES_MERGE_REF"));
 
-	if (notes_merge_commit(o, t, partial, oid.hash))
+	if (notes_merge_commit(o, t, partial, &oid))
 		die(_("failed to finalize notes merge"));
 
 	/* Reuse existing commit message in reflog message */
@@ -842,9 +842,9 @@ static int merge(int argc, const char **argv, const char *prefix)
 		    remote_ref.buf, default_notes_ref());
 	strbuf_add(&(o.commit_msg), msg.buf + 7, msg.len - 7); /* skip "notes: " */
 
-	result = notes_merge(&o, t, result_oid.hash);
+	result = notes_merge(&o, t, &result_oid);
 
-	if (result >= 0) /* Merge resulted (trivially) in result_sha1 */
+	if (result >= 0) /* Merge resulted (trivially) in result_oid */
 		/* Update default notes ref with new commit */
 		update_ref(msg.buf, default_notes_ref(), result_oid.hash, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
diff --git a/notes-merge.c b/notes-merge.c
index 9a1a49506..9dbf7f6a3 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -533,17 +533,17 @@ static int merge_from_diffs(struct notes_merge_options *o,
 
 int notes_merge(struct notes_merge_options *o,
 		struct notes_tree *local_tree,
-		unsigned char *result_sha1)
+		struct object_id *result_oid)
 {
 	struct object_id local_oid, remote_oid;
 	struct commit *local, *remote;
 	struct commit_list *bases = NULL;
-	const unsigned char *base_sha1, *base_tree_sha1;
+	const struct object_id *base_oid, *base_tree_oid;
 	int result = 0;
 
 	assert(o->local_ref && o->remote_ref);
 	assert(!strcmp(o->local_ref, local_tree->ref));
-	hashclr(result_sha1);
+	oidclr(result_oid);
 
 	trace_printf("notes_merge(o->local_ref = %s, o->remote_ref = %s)\n",
 	       o->local_ref, o->remote_ref);
@@ -553,16 +553,16 @@ int notes_merge(struct notes_merge_options *o,
 		die("Failed to resolve local notes ref '%s'", o->local_ref);
 	else if (!check_refname_format(o->local_ref, 0) &&
 		is_null_oid(&local_oid))
-		local = NULL; /* local_sha1 == null_sha1 indicates unborn ref */
+		local = NULL; /* local_oid == null_oid indicates unborn ref */
 	else if (!(local = lookup_commit_reference(&local_oid)))
 		die("Could not parse local commit %s (%s)",
 		    oid_to_hex(&local_oid), o->local_ref);
 	trace_printf("\tlocal commit: %.7s\n", oid_to_hex(&local_oid));
 
-	/* Dereference o->remote_ref into remote_sha1 */
+	/* Dereference o->remote_ref into remote_oid */
 	if (get_oid(o->remote_ref, &remote_oid)) {
 		/*
-		 * Failed to get remote_sha1. If o->remote_ref looks like an
+		 * Failed to get remote_oid. If o->remote_ref looks like an
 		 * unborn ref, perform the merge using an empty notes tree.
 		 */
 		if (!check_refname_format(o->remote_ref, 0)) {
@@ -583,12 +583,12 @@ int notes_merge(struct notes_merge_options *o,
 		    "(%s)", o->remote_ref, o->local_ref);
 	if (!local) {
 		/* result == remote commit */
-		hashcpy(result_sha1, remote_oid.hash);
+		oidcpy(result_oid, &remote_oid);
 		goto found_result;
 	}
 	if (!remote) {
 		/* result == local commit */
-		hashcpy(result_sha1, local_oid.hash);
+		oidcpy(result_oid, &local_oid);
 		goto found_result;
 	}
 	assert(local && remote);
@@ -596,47 +596,47 @@ int notes_merge(struct notes_merge_options *o,
 	/* Find merge bases */
 	bases = get_merge_bases(local, remote);
 	if (!bases) {
-		base_sha1 = null_sha1;
-		base_tree_sha1 = EMPTY_TREE_SHA1_BIN;
+		base_oid = &null_oid;
+		base_tree_oid = &empty_tree_oid;
 		if (o->verbosity >= 4)
 			printf("No merge base found; doing history-less merge\n");
 	} else if (!bases->next) {
-		base_sha1 = bases->item->object.oid.hash;
-		base_tree_sha1 = bases->item->tree->object.oid.hash;
+		base_oid = &bases->item->object.oid;
+		base_tree_oid = &bases->item->tree->object.oid;
 		if (o->verbosity >= 4)
 			printf("One merge base found (%.7s)\n",
-				sha1_to_hex(base_sha1));
+			       oid_to_hex(base_oid));
 	} else {
 		/* TODO: How to handle multiple merge-bases? */
-		base_sha1 = bases->item->object.oid.hash;
-		base_tree_sha1 = bases->item->tree->object.oid.hash;
+		base_oid = &bases->item->object.oid;
+		base_tree_oid = &bases->item->tree->object.oid;
 		if (o->verbosity >= 3)
 			printf("Multiple merge bases found. Using the first "
-				"(%.7s)\n", sha1_to_hex(base_sha1));
+				"(%.7s)\n", oid_to_hex(base_oid));
 	}
 
 	if (o->verbosity >= 4)
 		printf("Merging remote commit %.7s into local commit %.7s with "
 			"merge-base %.7s\n", oid_to_hex(&remote->object.oid),
 			oid_to_hex(&local->object.oid),
-			sha1_to_hex(base_sha1));
+			oid_to_hex(base_oid));
 
-	if (!hashcmp(remote->object.oid.hash, base_sha1)) {
+	if (!oidcmp(&remote->object.oid, base_oid)) {
 		/* Already merged; result == local commit */
 		if (o->verbosity >= 2)
 			printf("Already up-to-date!\n");
-		hashcpy(result_sha1, local->object.oid.hash);
+		oidcpy(result_oid, &local->object.oid);
 		goto found_result;
 	}
-	if (!hashcmp(local->object.oid.hash, base_sha1)) {
+	if (!oidcmp(&local->object.oid, base_oid)) {
 		/* Fast-forward; result == remote commit */
 		if (o->verbosity >= 2)
 			printf("Fast-forward\n");
-		hashcpy(result_sha1, remote->object.oid.hash);
+		oidcpy(result_oid, &remote->object.oid);
 		goto found_result;
 	}
 
-	result = merge_from_diffs(o, base_tree_sha1, local->tree->object.oid.hash,
+	result = merge_from_diffs(o, base_tree_oid->hash, local->tree->object.oid.hash,
 				  remote->tree->object.oid.hash, local_tree);
 
 	if (result != 0) { /* non-trivial merge (with or without conflicts) */
@@ -646,28 +646,28 @@ int notes_merge(struct notes_merge_options *o,
 		commit_list_insert(local, &parents);
 		create_notes_commit(local_tree, parents,
 				    o->commit_msg.buf, o->commit_msg.len,
-				    result_sha1);
+				    result_oid->hash);
 	}
 
 found_result:
 	free_commit_list(bases);
 	strbuf_release(&(o->commit_msg));
-	trace_printf("notes_merge(): result = %i, result_sha1 = %.7s\n",
-	       result, sha1_to_hex(result_sha1));
+	trace_printf("notes_merge(): result = %i, result_oid = %.7s\n",
+	       result, oid_to_hex(result_oid));
 	return result;
 }
 
 int notes_merge_commit(struct notes_merge_options *o,
 		       struct notes_tree *partial_tree,
 		       struct commit *partial_commit,
-		       unsigned char *result_sha1)
+		       struct object_id *result_oid)
 {
 	/*
 	 * Iterate through files in .git/NOTES_MERGE_WORKTREE and add all
 	 * found notes to 'partial_tree'. Write the updated notes tree to
 	 * the DB, and commit the resulting tree object while reusing the
 	 * commit message and parents from 'partial_commit'.
-	 * Finally store the new commit object SHA1 into 'result_sha1'.
+	 * Finally store the new commit object OID into 'result_oid'.
 	 */
 	DIR *dir;
 	struct dirent *e;
@@ -721,11 +721,11 @@ int notes_merge_commit(struct notes_merge_options *o,
 	}
 
 	create_notes_commit(partial_tree, partial_commit->parents,
-			    msg, strlen(msg), result_sha1);
+			    msg, strlen(msg), result_oid->hash);
 	unuse_commit_buffer(partial_commit, buffer);
 	if (o->verbosity >= 4)
 		printf("Finalized notes merge commit: %s\n",
-			sha1_to_hex(result_sha1));
+			oid_to_hex(result_oid));
 	strbuf_release(&path);
 	closedir(dir);
 	return 0;
diff --git a/notes-merge.h b/notes-merge.h
index 0d890563b..eaa8e3b86 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -33,15 +33,15 @@ void init_notes_merge_options(struct notes_merge_options *o);
  *
  * 1. The merge trivially results in an existing commit (e.g. fast-forward or
  *    already-up-to-date). 'local_tree' is untouched, the SHA1 of the result
- *    is written into 'result_sha1' and 0 is returned.
+ *    is written into 'result_oid' and 0 is returned.
  * 2. The merge successfully completes, producing a merge commit. local_tree
  *    contains the updated notes tree, the SHA1 of the resulting commit is
- *    written into 'result_sha1', and 1 is returned.
+ *    written into 'result_oid', and 1 is returned.
  * 3. The merge results in conflicts. This is similar to #2 in that the
  *    partial merge result (i.e. merge result minus the unmerged entries)
  *    are stored in 'local_tree', and the SHA1 or the resulting commit
  *    (to be amended when the conflicts have been resolved) is written into
- *    'result_sha1'. The unmerged entries are written into the
+ *    'result_oid'. The unmerged entries are written into the
  *    .git/NOTES_MERGE_WORKTREE directory with conflict markers.
  *    -1 is returned.
  *
@@ -52,7 +52,7 @@ void init_notes_merge_options(struct notes_merge_options *o);
  */
 int notes_merge(struct notes_merge_options *o,
 		struct notes_tree *local_tree,
-		unsigned char *result_sha1);
+		struct object_id *result_oid);
 
 /*
  * Finalize conflict resolution from an earlier notes_merge()
@@ -63,12 +63,12 @@ int notes_merge(struct notes_merge_options *o,
  *
  * This function will add the (now resolved) notes in .git/NOTES_MERGE_WORKTREE
  * to 'partial_tree', and create a final notes merge commit, the SHA1 of which
- * will be stored in 'result_sha1'.
+ * will be stored in 'result_oid'.
  */
 int notes_merge_commit(struct notes_merge_options *o,
 		       struct notes_tree *partial_tree,
 		       struct commit *partial_commit,
-		       unsigned char *result_sha1);
+		       struct object_id *result_oid);
 
 /*
  * Abort conflict resolution from an earlier notes_merge()
-- 
2.13.0.219.gdb65acc882-goog

