Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CA420987
	for <e@80x24.org>; Wed, 28 Sep 2016 11:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbcI1LoP (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 07:44:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35505 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbcI1LoN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 07:44:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id 6so2064593pfl.2
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 04:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UD0DVy6vEE6tbe5AApIdVUzUZ3CQbRDnAWnyB2LkwmI=;
        b=AA5B9HU/wArJGtcNECwj+xmr7JZqRCWdBj6FzuzkTnhIKfWLoLOm2Aztw/s9UaA74V
         1FpmlSVT2HlzpDcGgA0ZMfmp9iqansWHtdZxuc6g5IullOqD+jMU8zAVKfL/3GKD8eRv
         XQxMBVDsFaQCvzXwPcOOh+TD+gHQQkH41Dq5lCE8ROAimvWs+RqPnTjLJb5Hsg97UqU1
         MUE5Fg5DkteL4JdYQJaNgVGEcWd1NBX0utGfaGreFgSyftkHpbH9t62g6udnrNWyhRKe
         P2048h5JUhjouy2jIgUh9ZiktAnBIFZt/s/k3Vl/xnlE78D2Pp4ct4piabXlHDhtuip/
         DQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UD0DVy6vEE6tbe5AApIdVUzUZ3CQbRDnAWnyB2LkwmI=;
        b=QG8TGgy2VUvslH1Kmu5ER649LuRyeXo4Bp7/Brk/HufIJkRTaQ9eB1cHMcgHDrBwUp
         aTv2SMA1EiY/xsSIoOnSdyb0KwBxLeo6pdThkveHjp7k2Y8BWMrlNwr277YTbLLZ3jWt
         oySK0sScXKPdKrE5hu8uQxNrZMQqFUotFV8W0LBClx4jGyR5L8XOhu5RqbYRvAVOahtq
         JEoC6QcajFlmQZb1d+d1amPdfqEobpZMKMBzGKxLWX3XfN8KEjQAf1WYaBUT/3Sf9odY
         Gdq6Z8fZG+nZ4zeGcTNDK3UN8f2/o3jmNe/cCcdcGA45T+BJBKeu/gNK/CJGMvGbl3OY
         O5/w==
X-Gm-Message-State: AE9vXwNpjoKFm5BFSKRwB40h3O/jXCUpu2tFWGwI5C6uAVfmhs605byFhKUK7gjT5GuG5A==
X-Received: by 10.98.223.218 with SMTP id d87mr57407281pfl.48.1475063052234;
        Wed, 28 Sep 2016 04:44:12 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id 138sm12053858pfx.41.2016.09.28.04.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2016 04:44:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 28 Sep 2016 18:44:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/3] diff-lib.c: enable --shift-ita in index_differs_from()
Date:   Wed, 28 Sep 2016 18:43:47 +0700
Message-Id: <20160928114348.1470-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160928114348.1470-1-pclouds@gmail.com>
References: <20160928114348.1470-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is basically "git diff --cached HEAD", It has three
callers:

 - One in builtin/commit.c, which uses it to determine if the index is
   different from HEAD and go ahead making a new commit.

 - Two in sequencer.c, which use it to see if the index is dirty.

In the first case, if ita entries are present, index_differs_from() may
report "dirty". However at tree creation phase, ita entries are dropped
and the result tree may look exactly the same as HEAD (assuming that
nothing else is changed in index). This is what we need index_differs_from()
for, to catch new empty commits. Enabling shift_ita in index_differs_from()
fixes this.

In the second case, the presence of ita entries are enough to say the
index is dirty and not continue on. Make an explicit check for that
before comparing index against HEAD (whether --shift-ita is present is
irrelevant)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h               |  1 +
 diff-lib.c            |  1 +
 read-cache.c          | 10 ++++++++++
 sequencer.c           |  5 +++--
 t/t2203-add-intent.sh | 11 +++++++++++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index d0494c8..1ddd515 100644
--- a/cache.h
+++ b/cache.h
@@ -561,6 +561,7 @@ extern int do_read_index(struct index_state *istate, const char *path,
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
+extern int has_ita_entries(struct index_state *);
 #define COMMIT_LOCK		(1 << 0)
 #define CLOSE_LOCK		(1 << 1)
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
diff --git a/diff-lib.c b/diff-lib.c
index 62d67c8..ea55ee2 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -545,6 +545,7 @@ int index_differs_from(const char *def, int diff_flags)
 	DIFF_OPT_SET(&rev.diffopt, QUICK);
 	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
 	rev.diffopt.flags |= diff_flags;
+	rev.diffopt.shift_ita = 1;
 	run_diff_index(&rev, 1);
 	if (rev.pending.alloc)
 		free(rev.pending.objects);
diff --git a/read-cache.c b/read-cache.c
index 31eddec..f6a5f61 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1674,6 +1674,16 @@ int is_index_unborn(struct index_state *istate)
 	return (!istate->cache_nr && !istate->timestamp.sec);
 }
 
+int has_ita_entries(struct index_state *istate)
+{
+	int i;
+
+	for (i = 0; i < istate->cache_nr; i++)
+		if (ce_intent_to_add(istate->cache[i]))
+			return 1;
+	return 0;
+}
+
 int discard_index(struct index_state *istate)
 {
 	int i;
diff --git a/sequencer.c b/sequencer.c
index eec8a60..10cded0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -469,7 +469,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		unborn = get_sha1("HEAD", head);
 		if (unborn)
 			hashcpy(head, EMPTY_TREE_SHA1_BIN);
-		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0))
+		if (has_ita_entries(&the_index) ||
+		    index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0))
 			return error_dirty_index(opts);
 	}
 	discard_cache();
@@ -1064,7 +1065,7 @@ static int sequencer_continue(struct replay_opts *opts)
 		if (ret)
 			return ret;
 	}
-	if (index_differs_from("HEAD", 0))
+	if (has_ita_entries(&the_index) || index_differs_from("HEAD", 0))
 		return error_dirty_index(opts);
 	todo_list = todo_list->next;
 	return pick_commits(todo_list, opts);
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index c6a4648..aa06415 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -129,5 +129,16 @@ test_expect_success 'cache-tree does skip dir that becomes empty' '
 	)
 '
 
+test_expect_success 'commit: ita entries ignored in empty commit check' '
+	git init empty-subsequent-commit &&
+	(
+		cd empty-subsequent-commit &&
+		test_commit one &&
+		: >two &&
+		git add -N two &&
+		test_must_fail git commit -m nothing-new-here
+	)
+'
+
 test_done
 
-- 
2.8.2.524.g6ff3d78

