Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6CB211B3
	for <e@80x24.org>; Mon, 24 Dec 2018 21:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbeLXVYn (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 16:24:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38541 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXVYn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 16:24:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so12492163wrw.5
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 13:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8c8OoLbfzpqZrlyybUOqeD427o4wEm3JwyIZEa/SR0=;
        b=Dy44gc5NMTtfPeN38Csek7VZv0/82KlS5VXai2olSopPWPw+9XxVU9YobWLpxhO5U8
         xKCfH+FHizUjQrpnsExXAmMdvwiAeK3nufAQJhxeZQAKMhMxknrNAm8vdoFi126We4IN
         1K3U56CemwpCKjN/vYZMg9xppPQyEeKXJPOIX//ducgKSxin8ep+0xIlD2IAMlg3rM19
         sXlglP6XrLkBgwsvmLriHArr7nYfNwlslQ9oZTdLk2JqBFoxU0+Do5XYlT5MygSTZ74F
         1pN7Qkb5DoglzATOh67MwPYnk4oxg5F69tBTEZtGOWONTzgYMCt76kg6tgWcNeR2Upq+
         X0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8c8OoLbfzpqZrlyybUOqeD427o4wEm3JwyIZEa/SR0=;
        b=b6yzpCiVwwc+j2hAA1nEVVQTSkc50DVfU8xzM7elXDZPniZuYi8zfp64x1FM27VVtR
         a7ui2ysaVctJxIeYgtoGnPwW+pHIJIGG/NRoHeMbGBeRoGB4hkJUyqkJzzDprJufuZUb
         SrgKSGkrNII2eq+Yshs7w2CDCQV3MErGulgBcjaNw2i5JLdJqmQIPNG9bU552t5SnlhU
         e7Kt7BzF8T1Z+nDed0hqYrI72eCYFNx8ze2b/k/SY3BKbO0MK7284l9QKXGPXK8/2yh8
         KD+B0adIIb6gRcYqf7wobOi2ZkNbIpHKueWxqWlqtWRtbt4u46tHnMFN32BGK41NIKZH
         NyYA==
X-Gm-Message-State: AJcUukfuV/VmuqML/gAh0l+5oi7t8AAMtohlXnSWE/m+pSjFW28nP8uA
        C8ctwpJiO10rYtmc2B1TrJFtjewz
X-Google-Smtp-Source: ALg8bN5J8yMHZEftxYYIP39eG0kE0aO8ELU4DOuUZDgQrUwBcbSmc/WjdOMZBWYm2ymtGxAwnYywVg==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr12576997wro.208.1545686680945;
        Mon, 24 Dec 2018 13:24:40 -0800 (PST)
Received: from localhost.localdomain ([95.86.80.136])
        by smtp.gmail.com with ESMTPSA id n5sm23637815wrr.94.2018.12.24.13.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 13:24:40 -0800 (PST)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH 2/2] Rebase: Run post-checkout hook on checkout
Date:   Mon, 24 Dec 2018 23:24:25 +0200
Message-Id: <20181224212425.16596-3-orgads@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181224212425.16596-1-orgads@gmail.com>
References: <20181224212425.16596-1-orgads@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 builtin/rebase.c              | 11 +++++++++--
 t/t5403-post-checkout-hook.sh | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b5c99ec10c..7f7a2c738e 100644
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
@@ -1465,7 +1471,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 					    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 					    options.switch_to);
 				if (reset_head(&oid, "checkout",
-					       options.head_name, 0,
+					       options.head_name,
+					       RESET_HEAD_RUN_HOOK,
 					       NULL, buf.buf) < 0) {
 					ret = !!error(_("could not switch to "
 							"%s"),
@@ -1539,7 +1546,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL,
-		       RESET_HEAD_DETACH, NULL, msg.buf))
+		       RESET_HEAD_DETACH | RESET_HEAD_RUN_HOOK, NULL, msg.buf))
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
 
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 9f9a5163c5..5b4e582caa 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -13,6 +13,8 @@ test_expect_success setup '
 	EOF
 	test_commit one &&
 	test_commit two &&
+	test_commit rebase-on-me &&
+	git reset --hard HEAD^ &&
 	test_commit three three
 '
 
@@ -51,6 +53,24 @@ test_expect_success 'post-checkout receives the right args when not switching br
 	rm -f .git/post-checkout.args
 '
 
+test_expect_success 'post-checkout is triggered on rebase' '
+	git checkout -b rebase-test master &&
+	rm -f .git/post-checkout.args &&
+	git rebase rebase-on-me &&
+	read old new flag < .git/post-checkout.args &&
+	test $old != $new && test $flag = 1 &&
+	rm -f .git/post-checkout.args
+'
+
+test_expect_success 'post-checkout is triggered on rebase with fast-forward' '
+	git checkout -b ff-rebase-test rebase-on-me^ &&
+	rm -f .git/post-checkout.args &&
+	git rebase rebase-on-me &&
+	read old new flag < .git/post-checkout.args &&
+	test $old != $new && test $flag = 1 &&
+	rm -f .git/post-checkout.args
+'
+
 if test "$(git config --bool core.filemode)" = true; then
 mkdir -p templates/hooks
 write_script templates/hooks/post-checkout <<-\EOF
-- 
2.20.1

