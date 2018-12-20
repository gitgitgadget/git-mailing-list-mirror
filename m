Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1991F405
	for <e@80x24.org>; Thu, 20 Dec 2018 21:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390066AbeLTVsj (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 16:48:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42703 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbeLTVsi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 16:48:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so3251248wrx.9
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 13:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4ioQTCyq2ttsFLScKLde0K877I98/kYudHo6MKN7AE=;
        b=MCqDEKl7fib5DlIdorJzVnJiDxdeeYsy9QN2Wv3dYl2ghDTTUnOvG/PE0wNzqi0b5Y
         g/PjgFtr3Fg5aqeLfyz8Jggh0f2CI09rzde/TIQtpQw+HYGyyI8uPIRgMwRkXwJtvw4T
         zshJ2chbld7v+I6mG5ardcalP57a7/r2yHA187EyDkA2jDXQsQe4Ey34XekLRUMvA+eR
         HiaOHCOmTTd4Kb6Qz4ZOmPOzqyR4YzDvvnS/L6VZyfbaBs1mYgI2QRt+G9+mMm3mq9HD
         Si/KutzVqsi9wlS+77TRuIr82bbaAS5sxaY6n0vgpph3E3yU2gcQ9/SlW0PqPPoT1DKV
         AqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4ioQTCyq2ttsFLScKLde0K877I98/kYudHo6MKN7AE=;
        b=U6dZTYm157FHYnsBa2F4CmkjaMSWR7LYScMhP7DvY38k48kXdQg8ixzLbz5tNLHsSF
         UwpHSsPYRrSwCOx9qiBwU0RSwyMBDGPQTWUwG233SSL0F6Ku2ZD2ZOgnrmSSjRk+hEq3
         iLZVic4QVSZyXeXsMVnbZKKT8fmj6BVOiv08LgE8QBBgt+dcYq4oyvtU/g7+tR8o6dq1
         kYB3Zb/96soLYl327DgecnYvRXIRwaG5nrE5iM2srwO940vV65V8l7GDm8k88bVvDbGf
         5ODC9sx8o+7kRRlpoMey+xe3L4YhCkRcykNO64D+TILq9rbinfFN/kIqopk/CeBUTTcO
         8/cA==
X-Gm-Message-State: AA+aEWYkeMrg8XA5DU0Z3spnNrnClliGIdpTFb9JYST7CJsYp3hFbXyH
        oww1nNUH+pJHsYhNnSi7Jsjn2GLr
X-Google-Smtp-Source: AFSGD/VNy1yk8nMRxRkPIkrIJlm4bg4zYOyICX0Yha2Dt/+5fUHCOHi1XwGfU+dCoBp0tP63c+UYTQ==
X-Received: by 2002:a5d:444a:: with SMTP id x10mr25076420wrr.162.1545342516072;
        Thu, 20 Dec 2018 13:48:36 -0800 (PST)
Received: from localhost.localdomain ([95.86.125.58])
        by smtp.gmail.com with ESMTPSA id t5sm8620006wmg.43.2018.12.20.13.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 13:48:35 -0800 (PST)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH 2/2] Rebase: Run post-checkout hook on checkout
Date:   Thu, 20 Dec 2018 23:48:23 +0200
Message-Id: <20181220214823.21378-2-orgads@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220214823.21378-1-orgads@gmail.com>
References: <20181220214823.21378-1-orgads@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 builtin/rebase.c              |  8 +++++++-
 t/t5403-post-checkout-hook.sh | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b5c99ec10c..78a09dcda2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -530,6 +530,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 
 #define RESET_HEAD_DETACH (1<<0)
 #define RESET_HEAD_HARD (1<<1)
+#define RESET_HEAD_RUN_HOOK (1<<2)
 
 static int reset_head(struct object_id *oid, const char *action,
 		      const char *switch_to_branch, unsigned flags,
@@ -537,6 +538,7 @@ static int reset_head(struct object_id *oid, const char *action,
 {
 	unsigned detach_head = flags & RESET_HEAD_DETACH;
 	unsigned reset_hard = flags & RESET_HEAD_HARD;
+	unsigned run_hook = flags & RESET_HEAD_RUN_HOOK;
 	struct object_id head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
@@ -636,6 +638,10 @@ static int reset_head(struct object_id *oid, const char *action,
 			ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
 					 UPDATE_REFS_MSG_ON_ERR);
 	}
+	if (run_hook)
+		run_hook_le(NULL, "post-checkout",
+			    oid_to_hex(orig ? orig : &null_oid),
+			    oid_to_hex(oid), "1", NULL);
 
 leave_reset_head:
 	strbuf_release(&msg);
@@ -1539,7 +1545,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL,
-		       RESET_HEAD_DETACH, NULL, msg.buf))
+		       RESET_HEAD_DETACH | RESET_HEAD_RUN_HOOK, NULL, msg.buf))
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
 
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 7e941537f9..de9c7fb871 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -9,6 +9,8 @@ test_description='Test the post-checkout hook.'
 test_expect_success setup '
 	test_commit one &&
     test_commit two &&
+    test_commit rebase-on-me &&
+    git reset --hard HEAD^ &&
     test_commit three three &&
     mv .git/hooks-disabled .git/hooks
 '
@@ -52,6 +54,22 @@ test_expect_success 'post-checkout receives the right args when not switching br
 	test $old = $new && test $flag = 0
 '
 
+test_expect_success 'post-checkout is triggered on rebase' '
+	git checkout -b rebase-test master &&
+	rm -f .git/post-checkout.args &&
+	git rebase rebase-on-me &&
+	read old new flag < .git/post-checkout.args &&
+	test $old != $new && test $flag = 1
+'
+
+test_expect_success 'post-checkout is triggered on rebase with fast-forward' '
+	git checkout -b ff-rebase-test rebase-on-me^ &&
+	rm -f .git/post-checkout.args &&
+	git rebase rebase-on-me &&
+	read old new flag < .git/post-checkout.args &&
+	test $old != $new && test $flag = 1
+'
+
 if test "$(git config --bool core.filemode)" = true; then
 mkdir -p templates/hooks
 cat >templates/hooks/post-checkout <<'EOF'
-- 
2.20.1

