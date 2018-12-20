Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 901CD1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 21:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390085AbeLTV4O (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 16:56:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52952 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbeLTV4N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 16:56:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so3543610wml.2
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 13:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQWQEKydtGuh1E56wh8XKeL4jAB756aJUqFiVDCeEWk=;
        b=Yxk8+oiEF7EWkOcNHouHZ1f3JmJa7RRtYlsrazg2qvsA/c2wlRGFx1l0TPoSTXs3Bl
         VAtGLKFBdjYUmIBUQjKEhfC9mWKOYK7Jwfs4iX5pduIKnR8wDBi2qHbcAR70zmHR9u99
         XfCj//r2aUQLQkJri0dWzQfrmClVBtb1t3OocUlSm1fRl7n73QFEkByOLxF+V0zxSXBr
         dSPxIcA6cJnbasbpJlsvljmTU+uBqWEm5XuHmuiQUua5Q+3iF+AIuIwRLXoFpUjStBmO
         T1YLCScJN9KzCClFWnp5IuqwIppaoX29GEMxmKzxAuFmAGM1oMyTEzKscEclCdFJR3rW
         B47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQWQEKydtGuh1E56wh8XKeL4jAB756aJUqFiVDCeEWk=;
        b=GcqY3MWRcY9UhfZUxVWfCCTClIsGfJsR8I85mp7wyaKFRVdCREk3YLFu8I122RTd2Z
         9dJ0hF1s37MeAiAvUYANLY/9hk9iM0JG7+gUN5e7cQCDzk9J98Y2lQrRvW4PxHou7hnq
         JzmbcS9+DKEBoKFt25DpBjB3gMI6aarh/nxHrQvkWxeR2v4sb4dueyzNwUYiFTUR6+wX
         bAMmYziWwGM/AYfTGEhxc1e24uD18PSr9Q6CVB4IOiwB+jMyZZvcRBAl6CSqkSkfe+WP
         eyYO7c2CVweMnGgKab1TBDL4HRYllkJm86Rhcgcd7TCIn2nVq4NYfnVR2H7wn1btnw/m
         o+OA==
X-Gm-Message-State: AJcUukfCwobcntQ5LRxfkedTL5v46sVsDbDtU6ropV15euH0IC4ujLBi
        RTAIpTxz1bz70S0y4cHDpmedZLR1
X-Google-Smtp-Source: ALg8bN4Vk7zg/wWIw53gD09ep5FQrXSQnaTI62dIyR6FY10kuYlmW5cF3HDsn1GnWLoG5ZEa+z12XA==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr317215wmh.87.1545342970533;
        Thu, 20 Dec 2018 13:56:10 -0800 (PST)
Received: from localhost.localdomain ([95.86.125.58])
        by smtp.gmail.com with ESMTPSA id b18sm8453017wrr.43.2018.12.20.13.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 13:56:10 -0800 (PST)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH 2/2] Rebase: Run post-checkout hook on checkout
Date:   Thu, 20 Dec 2018 23:55:59 +0200
Message-Id: <20181220215559.22454-2-orgads@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220215559.22454-1-orgads@gmail.com>
References: <20181220215559.22454-1-orgads@gmail.com>
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
index 868d6f7272..ed4cc6e945 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -9,6 +9,8 @@ test_description='Test the post-checkout hook.'
 test_expect_success setup '
 	test_commit one &&
 	test_commit two &&
+	test_commit rebase-on-me &&
+	git reset --hard HEAD^ &&
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

