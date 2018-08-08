Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBEAC1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbeHIAj6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:39:58 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:51705 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:39:57 -0400
Received: by mail-qt0-f201.google.com with SMTP id x9-v6so2948208qto.18
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QLbYS+gQuqt1WFhnuGAnNxfStL/19tRw20w/J/D/JTI=;
        b=kMtWTvL/9yOEAmBvSjeDoBcJchSYEeOzWuV2/YUcLBFbwGPjCpmkRptVIXLzmC7pqz
         FSSS1qhrDjplLP98VYdln2ok047tGLGcycKJyg5vZCcA2Yh6cesmu3LKo/z6829rZcPR
         FB5tnY0kcoNq52ZUovZoaSpnxmEDgut6pdWI3jY36ib5ncFf302tspFwMF5vHizpiVrK
         ZqaaDjqUg8TrdClYjsbk2ix4TqanWvprFZRoIe1T+Hi/JudiEdEdeNkaC67AfZFyhJ8y
         TDPiFsai61qeDCCZAt6HLmXIB6qYpaT8axnHYx5G1h9G+Zu0XekWtUKdUlccTyN9Mc73
         iLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QLbYS+gQuqt1WFhnuGAnNxfStL/19tRw20w/J/D/JTI=;
        b=tiOUwfAP5CaHZ3IMikwgUpSOpLIzDelnF//ZlYLAJW96knsQJxsHAzZ2+KzstGuXMx
         BhwQj8oFhYYTSr7n8+X9whdDkvyZXQAlEIiWz3rrHgOiAUqSiEiyyKP/V53DavAJ7wTw
         0FUZzqpe8lCRZ1Q2hHumA5WvcBL8rXp0LeC/l1Pyr2vozLlIr+FiVZVZWA+5EMv1yZGy
         JC55ZNqfDqfAzUdn1ydxdclh2bYA07FwwKW94fzSZhjRYLgRC8QW+1Oqjl2Jviw4QcLV
         C6W8lTGsEwTod1ndETG6oge8vV5IWcYgcdiMeYsi1bdKEDjyenBMM8DL4Fp0gutTY4xi
         PHOg==
X-Gm-Message-State: AOUpUlG2lBAvGzTpSBaZwAQyr/DQKGVkq2lS/kwvENH+Sn6Mm91fm7HE
        lxeXF+ISnhwrykVmefbUC/0ckicImw0A/odmrQK1T5IJ3oUL50rpT7ngiSzRHIY88gFjB7Gs5xk
        I7EQCwtBQr2PlFsCqCSYd8hA86XpsL0FkCJOUgqRBNwVHWMnudpHw98qAhw6J
X-Google-Smtp-Source: AA+uWPyp5uxan0HB8zols/p8OOuVMlID+R3sBn4ycghfKNc/PS5u9knTWaDBL47IiRMDSkBsCFHYO0JDwR1u
X-Received: by 2002:ae9:ef44:: with SMTP id d65-v6mr2550933qkg.19.1533766696472;
 Wed, 08 Aug 2018 15:18:16 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:17:46 -0700
In-Reply-To: <20180808221752.195419-1-sbeller@google.com>
Message-Id: <20180808221752.195419-5-sbeller@google.com>
Mime-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 04/10] submodule.c: convert submodule_move_head new argument
 to object id
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All callers use oid_to_hex to convert the desired oid to a string before
calling submodule_move_head. Defer the conversion to the
submodule_move_head as it will turn out to be useful in a bit.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c        |  6 +++---
 submodule.c    | 12 ++++++------
 submodule.h    |  2 +-
 unpack-trees.c | 13 +++++--------
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/entry.c b/entry.c
index b5d1d3cf231..4b34dfd30df 100644
--- a/entry.c
+++ b/entry.c
@@ -358,7 +358,7 @@ static int write_entry(struct cache_entry *ce,
 		sub = submodule_from_ce(ce);
 		if (sub)
 			return submodule_move_head(ce->name,
-				NULL, oid_to_hex(&ce->oid),
+				NULL, &ce->oid,
 				state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		break;
 
@@ -438,10 +438,10 @@ int checkout_entry(struct cache_entry *ce,
 					unlink_or_warn(ce->name);
 
 				return submodule_move_head(ce->name,
-					NULL, oid_to_hex(&ce->oid), 0);
+					NULL, &ce->oid, 0);
 			} else
 				return submodule_move_head(ce->name,
-					"HEAD", oid_to_hex(&ce->oid),
+					"HEAD", &ce->oid,
 					state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		}
 
diff --git a/submodule.c b/submodule.c
index 6e14547e9e0..5b4e5227d90 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1597,9 +1597,9 @@ static void submodule_reset_index(const char *path)
  * pass NULL for old or new respectively.
  */
 int submodule_move_head(const char *path,
-			 const char *old_head,
-			 const char *new_head,
-			 unsigned flags)
+			const char *old_head,
+			const struct object_id *new_oid,
+			unsigned flags)
 {
 	int ret = 0;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1679,7 +1679,7 @@ int submodule_move_head(const char *path,
 	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
 		argv_array_push(&cp.args, old_head ? old_head : empty_tree_oid_hex());
 
-	argv_array_push(&cp.args, new_head ? new_head : empty_tree_oid_hex());
+	argv_array_push(&cp.args, new_oid ? oid_to_hex(new_oid) : empty_tree_oid_hex());
 
 	if (run_command(&cp)) {
 		ret = error(_("Submodule '%s' could not be updated."), path);
@@ -1687,7 +1687,7 @@ int submodule_move_head(const char *path,
 	}
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
-		if (new_head) {
+		if (new_oid) {
 			child_process_init(&cp);
 			/* also set the HEAD accordingly */
 			cp.git_cmd = 1;
@@ -1696,7 +1696,7 @@ int submodule_move_head(const char *path,
 
 			prepare_submodule_repo_env(&cp.env_array);
 			argv_array_pushl(&cp.args, "update-ref", "HEAD",
-					 "--no-deref", new_head, NULL);
+					 "--no-deref", oid_to_hex(new_oid), NULL);
 
 			if (run_command(&cp)) {
 				ret = -1;
diff --git a/submodule.h b/submodule.h
index 4644683e6cb..d1cceabb9b7 100644
--- a/submodule.h
+++ b/submodule.h
@@ -118,7 +118,7 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 #define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
 extern int submodule_move_head(const char *path,
 			       const char *old,
-			       const char *new_head,
+			       const struct object_id *new_oid,
 			       unsigned flags);
 
 void submodule_unset_core_worktree(const struct submodule *sub);
diff --git a/unpack-trees.c b/unpack-trees.c
index f9efee0836a..6c76bd6162a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -256,7 +256,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
 
 static int check_submodule_move_head(const struct cache_entry *ce,
 				     const char *old_id,
-				     const char *new_id,
+				     const struct object_id *new_id,
 				     struct unpack_trees_options *o)
 {
 	unsigned flags = SUBMODULE_MOVE_HEAD_DRY_RUN;
@@ -1513,7 +1513,7 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 
 		if (submodule_from_ce(ce)) {
 			int r = check_submodule_move_head(ce,
-				"HEAD", oid_to_hex(&ce->oid), o);
+				"HEAD", &ce->oid, o);
 			if (r)
 				return o->gently ? -1 :
 					add_rejected_path(o, error_type, ce->name);
@@ -1576,8 +1576,7 @@ static int verify_clean_submodule(const char *old_sha1,
 	if (!submodule_from_ce(ce))
 		return 0;
 
-	return check_submodule_move_head(ce, old_sha1,
-					 oid_to_hex(&ce->oid), o);
+	return check_submodule_move_head(ce, old_sha1, &ce->oid, o);
 }
 
 static int verify_clean_subdirectory(const struct cache_entry *ce,
@@ -1821,8 +1820,7 @@ static int merged_entry(const struct cache_entry *ce,
 
 		if (submodule_from_ce(ce)) {
 			int ret = check_submodule_move_head(ce, NULL,
-							    oid_to_hex(&ce->oid),
-							    o);
+							    &ce->oid, o);
 			if (ret)
 				return ret;
 		}
@@ -1850,8 +1848,7 @@ static int merged_entry(const struct cache_entry *ce,
 
 		if (submodule_from_ce(ce)) {
 			int ret = check_submodule_move_head(ce, oid_to_hex(&old->oid),
-							    oid_to_hex(&ce->oid),
-							    o);
+							    &ce->oid, o);
 			if (ret)
 				return ret;
 		}
-- 
2.18.0.597.ga71716f1ad-goog

