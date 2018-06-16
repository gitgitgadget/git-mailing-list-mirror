Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91641F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbeFPFmY (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:24 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41569 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932188AbeFPFmP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id d24-v6so17512978lfa.8
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JFq8o5/dBq8stwR89bGuCvIusxbl9gRK+IBu+OH44bc=;
        b=ROVeRrflUDuW23EgvLJ4cuX22L2zXiysUf2NNA9hMFwWIeV+wjbW6OouuF+gFigBQE
         uuRmf1n4R0+peCWhawCUWRyMEtsPlgIkOjmyPvmv9rKEzFl475p9C7UtahYZaaEATbLd
         s7jb5dFOkfhpfNTDGho020pOwZAPRPPt4/JNFzlonaL51jYrEm2AOy147o4Fjrees/Cs
         2pXj7OBp63zGBQ0NWgOR6xUXyjoIhjrrEce6+hmE1c+F/VMae1VkNkOwqATUwtgpvJFb
         GBMrZx4GSRvUuP6aP6TQz1CYeNvxqnyTFgMfgsF6D75yvJEOJZ2Ok8fYFaHas19qKecI
         zAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFq8o5/dBq8stwR89bGuCvIusxbl9gRK+IBu+OH44bc=;
        b=ZWEbBlz8Dof1ey6jHJph+V1lU//Dxwy7WMgOh9xqBZFWJTs/jDrpb4D6rrNsav6cyg
         +f/D3f8TQnSHLcqoKXS6UB1InLaK3W+z7Zig7ZxdkiB2mQZH+RXqRzsTxeQxCRZS17WN
         Uk7h6Ra9jdDaydW+IUtRuK0AUo89bWIVmR0MpcOSYyqglwjredtc7AMz8u5txuSYEnBN
         O7egMTrk3fOAO4Ja+nS9qtqZrAXCCKvBtnCHcumKUQPPA558D9hIYO/QAytdoYKLbx5v
         KfhpmWB/Wr3RVa9ztiBfug0WhXwfvbyv0zFm1Uk5KzX9eQ8DZacEnCxRX1Y2z4ojueT/
         pk+g==
X-Gm-Message-State: APt69E29A5ee5tV7IjAFC3eFL+AXAzbXY4DiUfretvqHIQVkY+FAJl3u
        FPe8OSFjv4bQ53idT3XctFBqyQ==
X-Google-Smtp-Source: ADUXVKISS+chcS4RktXnfPoQ5RXq0mwy0nqgF6YHoIM357mwj/1jpxqtxZwsgsoEuCAOLZ0dFSe3Og==
X-Received: by 2002:a19:cf46:: with SMTP id f67-v6mr2681731lfg.101.1529127733475;
        Fri, 15 Jun 2018 22:42:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/15] sequencer.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:54 +0200
Message-Id: <20180616054157.32433-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sequencer.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cca968043e..ed8af2a4cd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -435,7 +435,7 @@ static struct tree *empty_tree(void)
 
 static int error_dirty_index(struct replay_opts *opts)
 {
-	if (read_cache_unmerged())
+	if (read_index_unmerged(&the_index))
 		return error_resolve_conflict(_(action_name(opts)));
 
 	error(_("your local changes would be overwritten by %s."),
@@ -467,7 +467,7 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 
-	read_cache();
+	read_index(&the_index);
 	if (checkout_fast_forward(from, to, 1))
 		return -1; /* the callee should have complained already */
 
@@ -500,12 +500,12 @@ void append_conflicts_hint(struct strbuf *msgbuf)
 
 	strbuf_addch(msgbuf, '\n');
 	strbuf_commented_addf(msgbuf, "Conflicts:\n");
-	for (i = 0; i < active_nr;) {
-		const struct cache_entry *ce = active_cache[i++];
+	for (i = 0; i < the_index.cache_nr;) {
+		const struct cache_entry *ce = the_index.cache[i++];
 		if (ce_stage(ce)) {
 			strbuf_commented_addf(msgbuf, "\t%s\n", ce->name);
-			while (i < active_nr && !strcmp(ce->name,
-							active_cache[i]->name))
+			while (i < the_index.cache_nr && !strcmp(ce->name,
+								 the_index.cache[i]->name))
 				i++;
 		}
 	}
@@ -525,7 +525,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
-	read_cache();
+	read_index(&the_index);
 
 	init_merge_options(&o);
 	o.ancestor = base ? base_label : "(empty tree)";
@@ -571,16 +571,16 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 
 static struct object_id *get_cache_tree_oid(void)
 {
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
+	if (!the_index.cache_tree)
+		the_index.cache_tree = cache_tree();
 
-	if (!cache_tree_fully_valid(active_cache_tree))
+	if (!cache_tree_fully_valid(the_index.cache_tree))
 		if (cache_tree_update(&the_index, 0)) {
 			error(_("unable to update cache tree"));
 			return NULL;
 		}
 
-	return &active_cache_tree->oid;
+	return &the_index.cache_tree->oid;
 }
 
 static int is_index_unchanged(void)
@@ -1644,7 +1644,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 				       NULL, 0))
 			return error_dirty_index(opts);
 	}
-	discard_cache();
+	discard_index(&the_index);
 
 	if (!commit->parents)
 		parent = NULL;
@@ -2637,7 +2637,7 @@ static int do_exec(const char *command_line)
 					  child_env.argv);
 
 	/* force re-reading of the cache */
-	if (discard_cache() < 0 || read_cache() < 0)
+	if (discard_index(&the_index) < 0 || read_index(&the_index) < 0)
 		return error(_("could not read index"));
 
 	dirty = require_clean_work_tree("rebase", NULL, 1, 1);
@@ -2801,7 +2801,7 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.update = 1;
 
-	if (read_cache_unmerged()) {
+	if (read_index_unmerged(&the_index)) {
 		rollback_lock_file(&lock);
 		strbuf_release(&ref_name);
 		return error_resolve_conflict(_(action_name(opts)));
@@ -2991,7 +2991,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		commit_list_insert(j->item, &reversed);
 	free_commit_list(bases);
 
-	read_cache();
+	read_index(&the_index);
 	init_merge_options(&o);
 	o.branch1 = "HEAD";
 	o.branch2 = ref_name.buf;
@@ -3016,7 +3016,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	 */
 	ret = !ret;
 
-	if (active_cache_changed &&
+	if (the_index.cache_changed &&
 	    write_locked_index(&the_index, &lock, COMMIT_LOCK)) {
 		ret = error(_("merge: Unable to write new index file"));
 		goto leave_merge;
-- 
2.18.0.rc0.333.g22e6ee6cdf

