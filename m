Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1221F955
	for <e@80x24.org>; Sat, 29 Dec 2018 21:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeL2ViJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 16:38:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37191 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeL2ViI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 16:38:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so23767036wrt.4
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 13:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vewpZ9xQ4N6RC0wPq/sx8Zd1AV6VgFLTI9f1GfRrPAc=;
        b=iDbZumu5ByGs2d6rDb8ERE5pRkeCOP0k9oc8D7Fzgf5eQq8ktA315sI2Px4ILHYU2f
         Q+YS/hdKExVjqVn9hHfqwbRQxTxS5TYxGcnsQUSGScA/BXNrDmph/UfLlKukGcSO+T8Y
         M8ELuKMX1B+CEhIKk+TXbRS/JgOsKLpGYBq3Ep8gNhKvJX1tKihXKp3ZCQOegd2G1nuT
         1DcF6LKN+qY3qy2Pb87dW7Sk8qfJcybBUDPQw9FWId9jYDTU139bJcRcAqh5wmGD+XtJ
         fF73k5YjQNaOfIVYgtZsKgNeRzo9W6ziBrhh/HukQk7jWvn55K0AeTSOdxLT5hY3mqnk
         PWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vewpZ9xQ4N6RC0wPq/sx8Zd1AV6VgFLTI9f1GfRrPAc=;
        b=hNzEO2grW1TUhGSAIv0ZW3qYnnaDEWpQveZvuUxBsclmbm73vRUgeui7hMc9+6JdfY
         Tii9XmOlZ5szTObNho6PDRs9wtt2RwRKQKIrNGAA7KCM163DhBjCiUeokugwfjzJ6Gtc
         7JEeytEkzH3A8nhsZlkzsZJ3YVTAxRNhhgKnZ+g0bM4PSPqtqoy8HUMSGYhNvRWm8OR1
         HEC8/9xRhACwjLWIVi0qWw2pkp+vjiVsZ/Zq3YmuPGumWzRqF+mS3mLWtEG20cvuliuY
         SEESag6ygc8phYb0qk9vTEVxhw9HkPwayN7ARzGjn7Z1+KBp5Tw4l998UDRYdeCFDIFS
         DJrQ==
X-Gm-Message-State: AJcUukey3Fms6FLbWGOfKpqbthbubXM08Ffla3rMh/gvKp0Y/R9EI8Go
        mWvnsQCsmfkfHK30y6EF65pibVHA
X-Google-Smtp-Source: ALg8bN4aBPKn3WDCxb0udr6vpUtCI6PXSUNEi94MTJrBs98oAy4mekcim3v+x75X4jLKU/o6pL6zwA==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr30588565wrn.142.1546119485942;
        Sat, 29 Dec 2018 13:38:05 -0800 (PST)
Received: from localhost.localdomain ([95.86.70.194])
        by smtp.gmail.com with ESMTPSA id n9sm25282448wrx.80.2018.12.29.13.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 13:38:05 -0800 (PST)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH 2/2] Rebase: Run post-checkout hook on checkout
Date:   Sat, 29 Dec 2018 23:37:59 +0200
Message-Id: <20181229213759.12878-2-orgads@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229213759.12878-1-orgads@gmail.com>
References: <20181229213759.12878-1-orgads@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

The scripted version of rebase used to run this hook on the initial
checkout. The transition to built-in introduced a regression.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 builtin/rebase.c              | 12 ++++++++++--
 t/t5403-post-checkout-hook.sh | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b5c99ec10c..8402765a79 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -530,6 +530,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 
 #define RESET_HEAD_DETACH (1<<0)
 #define RESET_HEAD_HARD (1<<1)
+#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
 
 static int reset_head(struct object_id *oid, const char *action,
 		      const char *switch_to_branch, unsigned flags,
@@ -537,6 +538,7 @@ static int reset_head(struct object_id *oid, const char *action,
 {
 	unsigned detach_head = flags & RESET_HEAD_DETACH;
 	unsigned reset_hard = flags & RESET_HEAD_HARD;
+	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
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
@@ -1465,7 +1471,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 					    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 					    options.switch_to);
 				if (reset_head(&oid, "checkout",
-					       options.head_name, 0,
+					       options.head_name,
+					       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 					       NULL, buf.buf) < 0) {
 					ret = !!error(_("could not switch to "
 							"%s"),
@@ -1539,7 +1546,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL,
-		       RESET_HEAD_DETACH, NULL, msg.buf))
+		       RESET_HEAD_DETACH | RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
+		       NULL, msg.buf))
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
 
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 1d15a1031f..a539ffc080 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -13,6 +13,8 @@ test_expect_success setup '
 	EOF
 	test_commit one &&
 	test_commit two &&
+	test_commit rebase-on-me &&
+	git reset --hard HEAD^ &&
 	test_commit three
 '
 
@@ -44,6 +46,24 @@ test_expect_success 'post-checkout receives the right args when not switching br
 	test $old = $new && test $flag = 0
 '
 
+test_expect_success 'post-checkout is triggered on rebase' '
+	test_when_finished "rm -f .git/post-checkout.args" &&
+	git checkout -b rebase-test master &&
+	rm -f .git/post-checkout.args &&
+	git rebase rebase-on-me &&
+	read old new flag <.git/post-checkout.args &&
+	test $old != $new && test $flag = 1
+'
+
+test_expect_success 'post-checkout is triggered on rebase with fast-forward' '
+	test_when_finished "rm -f .git/post-checkout.args" &&
+	git checkout -b ff-rebase-test rebase-on-me^ &&
+	rm -f .git/post-checkout.args &&
+	git rebase rebase-on-me &&
+	read old new flag <.git/post-checkout.args &&
+	test $old != $new && test $flag = 1
+'
+
 test_expect_success 'post-checkout hook is triggered by clone' '
 	mkdir -p templates/hooks &&
 	write_script templates/hooks/post-checkout <<-\EOF &&
-- 
2.20.1

