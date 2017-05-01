Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0F51F78F
	for <e@80x24.org>; Mon,  1 May 2017 19:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbdEATIm (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 15:08:42 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33038 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdEATIl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 15:08:41 -0400
Received: by mail-pf0-f180.google.com with SMTP id q20so24479298pfg.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Onyu361tnNqCHEEtqtnMKPYzsUu8y5kEvM/jrN2adbI=;
        b=c1XxXo5qnGnqMeKw6hxoaVvCuMWDftujY03vXmDYb5gA7uXuBRQ2ajOtzEwAykti8G
         kmCd6vk8y+afprvQlJqCujLtd8u0kPo+doKWTJfNEbCkgxwfQtQ7CpVvDQUNHXv1kSB+
         kIAMp3oLoKqQOguTLf+lPIcmNHt59F+enC/i5gVuv9mP8TT/Fpg8zENvxHuZEGrKAmKD
         om4b3Sl0wA0ZnqfhT+gd5QYiWudSBbg+FadOBdmk1NjytoxlrcdtVYCxnMh/slPCpCEk
         ETLClhUB6Pkl6oLbSV3YSjG0yv7WcyXBhSF3TCFFxxzEWZTTl70iSsODd8odG72DQor2
         Pv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Onyu361tnNqCHEEtqtnMKPYzsUu8y5kEvM/jrN2adbI=;
        b=hZxErV5nD8uYwVkQ+uqLCpmny00oYzAFDhRm+hlm2PS37MfGSLyN13dMYwsGHLZOyo
         QYMWfczzPQbO2qcP4p/so3uOTcHVXnVZzxsY/gmIdvxU1uLVSzZbuy1OT3XY7uCP2ozY
         NVbZmpmnQ3hydtUZn7lj+u6jfRgLZkh8yGXN+he3YF4ZZTGGXfM9Ebr0pVt+MSLg64Jq
         3Oh0CPhK4cBeY02HLur45HrGmSoFpE9EB3nCqJ0PzbQzpFZkNDf5nAdHklqEo3qL5HBJ
         mymNNfcyTTLrxOceVMwQoOiIMSlmlRi+kxsWPsNHD7MAWg1b1ESvU2iteMNkWBz3vxzc
         OHIA==
X-Gm-Message-State: AN3rC/6Kg7K8a8Xd4UtrNggIvijagtKw4pPXkSVPoztVaZCbJIqW3GkM
        fnVxR5eAnTy07sv7GdotmA==
X-Received: by 10.99.107.198 with SMTP id g189mr27972136pgc.162.1493665720587;
        Mon, 01 May 2017 12:08:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c4be:9746:6a14:c7a4])
        by smtp.gmail.com with ESMTPSA id n65sm23219098pga.8.2017.05.01.12.08.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 12:08:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] cache.h: drop read_cache_unmerged()
Date:   Mon,  1 May 2017 12:07:19 -0700
Message-Id: <20170501190719.10669-6-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.1.gbc33f0f778
In-Reply-To: <20170501190719.10669-1-sbeller@google.com>
References: <20170501190719.10669-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

@@ @@
-read_cache_unmerged()
+read_index_unmerged(&the_index)

Additionally drop the define from cache.h manually.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/am.c        | 2 +-
 builtin/merge.c     | 2 +-
 builtin/pull.c      | 2 +-
 builtin/read-tree.c | 2 +-
 builtin/reset.c     | 2 +-
 cache.h             | 1 -
 sequencer.c         | 2 +-
 7 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index cb3e4dff63..bb0927fbcc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2053,7 +2053,7 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
 	if (!remote_tree)
 		return error(_("Could not parse object '%s'."), oid_to_hex(remote));
 
-	read_cache_unmerged();
+	read_index_unmerged(&the_index);
 
 	if (fast_forward_to(head_tree, head_tree, 1))
 		return -1;
diff --git a/builtin/merge.c b/builtin/merge.c
index 4d4c56050c..c27c806ac1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1170,7 +1170,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		goto done;
 	}
 
-	if (read_cache_unmerged())
+	if (read_index_unmerged(&the_index))
 		die_resolve_conflict("merge");
 
 	if (file_exists(git_path_merge_head())) {
diff --git a/builtin/pull.c b/builtin/pull.c
index dd1a4a94e4..42578cee05 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -788,7 +788,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	git_config(git_pull_config, NULL);
 
-	if (read_cache_unmerged())
+	if (read_index_unmerged(&the_index))
 		die_resolve_conflict("pull");
 
 	if (file_exists(git_path_merge_head()))
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index f997814933..0bcf021ead 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -195,7 +195,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	 */
 
 	if (opts.reset || opts.merge || opts.prefix) {
-		if (read_cache_unmerged() && (opts.prefix || opts.merge))
+		if (read_index_unmerged(&the_index) && (opts.prefix || opts.merge))
 			die("You need to resolve your current index first");
 		stage = opts.merge = 1;
 	}
diff --git a/builtin/reset.c b/builtin/reset.c
index 03c5498d6e..4a4eb723dd 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -66,7 +66,7 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 		opts.reset = 1;
 	}
 
-	read_cache_unmerged();
+	read_index_unmerged(&the_index);
 
 	if (reset_type == KEEP) {
 		struct object_id head_oid;
diff --git a/cache.h b/cache.h
index a66ae97fb7..9b94339573 100644
--- a/cache.h
+++ b/cache.h
@@ -355,7 +355,6 @@ extern void free_name_hash(struct index_state *istate);
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
 #define is_cache_unborn() is_index_unborn(&the_index)
-#define read_cache_unmerged() read_index_unmerged(&the_index)
 #define discard_cache() discard_index(&the_index)
 #define unmerged_cache() unmerged_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
diff --git a/sequencer.c b/sequencer.c
index 9409b65aaa..f20e05fe60 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -349,7 +349,7 @@ static struct tree *empty_tree(void)
 
 static int error_dirty_index(struct replay_opts *opts)
 {
-	if (read_cache_unmerged())
+	if (read_index_unmerged(&the_index))
 		return error_resolve_conflict(_(action_name(opts)));
 
 	error(_("your local changes would be overwritten by %s."),
-- 
2.13.0.rc1.1.gbc33f0f778

