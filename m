Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52BA120248
	for <e@80x24.org>; Thu, 28 Feb 2019 15:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388623AbfB1P1u (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 10:27:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32895 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388345AbfB1P1u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 10:27:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id c55so17347417edb.0
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 07:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g+pGs+pPQS4yupX4F+r6Rl4wu7svmR1go94XtrRFlIY=;
        b=vVtemPVYE9nOT+i1sR+CLA9S8dt6P5DJP7zPhNMnzjbyCwgWWL9zmI0ABjcZMhDr4j
         JxwOTz31f66ZNG7bM9AtWv++hSe2UYiT+K8ELB5d//nIIEjknQ9bA3fgdb6S5rnrgH21
         qTGruDcz4EM/I9MA/yx6cJUz/Ko9l04UH10Lk8hHipbq7wMknzdRTzSfjY8/lMhyITGl
         KVCRP3weUQJmNsxBGD+CkokLhHfMT0J0OuQixK8DaWpF3R7YooFY0c9FRghauP7qfQwX
         yK4tXtiiAvJlwjo72qAlfHhkVBfFVF26bPswnBykgq1aNjOfXuiybI6LKT0kR2+MSSaE
         WSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g+pGs+pPQS4yupX4F+r6Rl4wu7svmR1go94XtrRFlIY=;
        b=kXXoVxbOKFUeyj2rdwjPtoKYsVfp0t/nMgO0OQRf6DFisg/4mEgSkeeznOAiX/8sbk
         8+6ggs0ngPLNyc3XBKjd9VDeYfbZ5W33t+MprHixz2+QACRle1zZJsnOdNLh4Z8p1S9s
         4fTJ8sAK4lpfmPgYaac/gR6W11ziwbh1uQfIk52G75oLgMYcfliTHGjI840b5LWFidUH
         EZawdYkc3xLj2dJMLWp6M4/vWYqCMo5x+P2ByM75+FsfCFtyg/PyMbz/DUTerXXLg8e6
         d6Xjoo0xQNeHpBp8QO8qZu7/EaMC93xSOvX8ZZbvXYTn6cYRBS7vDV9fNHWJ3bYC01mr
         tr2w==
X-Gm-Message-State: APjAAAV/1q0ifX0UD9ot+ZgH4eu79jcfeAdKLPUCbx1LbaMLFtUlXGfQ
        kEKWziyw7zEtZg/6e+7AW3aGFqBQ
X-Google-Smtp-Source: AHgI3IYrGU+4u0p/968QU/wBKTbPwQHuImJT6BA8RHpdSK0LxXPvxoVXD+agdx2cc/KUQ+17xosOjQ==
X-Received: by 2002:a50:ac09:: with SMTP id v9mr124664edc.3.1551367668338;
        Thu, 28 Feb 2019 07:27:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b29sm5184258eda.48.2019.02.28.07.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:27:47 -0800 (PST)
Date:   Thu, 28 Feb 2019 07:27:47 -0800 (PST)
X-Google-Original-Date: Thu, 28 Feb 2019 15:27:44 GMT
Message-Id: <1786c172effb38fa44cea0c1d98de604602a5634.1551367664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.153.git.gitgitgadget@gmail.com>
References: <pull.153.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/4] built-in rebase: set ORIG_HEAD just once, before the
 rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Technically, the scripted version set ORIG_HEAD only in two spots (which
really could have been one, because it called `git checkout $onto^0` to
start the rebase and also if it could take a shortcut, and in both cases
it called `git update-ref $orig_head`).

Practically, it *implicitly* reset ORIG_HEAD whenever `git reset --hard`
was called.

However, what we really want is that it is set exactly once, at the
beginning of the rebase.

So let's do that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c  | 31 ++++++++++++++++++-------------
 t/t3400-rebase.sh |  2 +-
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index aa469ec964..0f4e1ead49 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -369,6 +369,7 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 #define RESET_HEAD_DETACH (1<<0)
 #define RESET_HEAD_HARD (1<<1)
 #define RESET_HEAD_REFS_ONLY (1<<2)
+#define RESET_ORIG_HEAD (1<<3)
 
 static int reset_head(struct object_id *oid, const char *action,
 		      const char *switch_to_branch, unsigned flags,
@@ -377,6 +378,7 @@ static int reset_head(struct object_id *oid, const char *action,
 	unsigned detach_head = flags & RESET_HEAD_DETACH;
 	unsigned reset_hard = flags & RESET_HEAD_HARD;
 	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
+	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
 	struct object_id head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
@@ -453,18 +455,21 @@ static int reset_head(struct object_id *oid, const char *action,
 	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
 	prefix_len = msg.len;
 
-	if (!get_oid("ORIG_HEAD", &oid_old_orig))
-		old_orig = &oid_old_orig;
-	if (!get_oid("HEAD", &oid_orig)) {
-		orig = &oid_orig;
-		if (!reflog_orig_head) {
-			strbuf_addstr(&msg, "updating ORIG_HEAD");
-			reflog_orig_head = msg.buf;
-		}
-		update_ref(reflog_orig_head, "ORIG_HEAD", orig, old_orig, 0,
-			   UPDATE_REFS_MSG_ON_ERR);
-	} else if (old_orig)
-		delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+	if (update_orig_head) {
+		if (!get_oid("ORIG_HEAD", &oid_old_orig))
+			old_orig = &oid_old_orig;
+		if (!get_oid("HEAD", &oid_orig)) {
+			orig = &oid_orig;
+			if (!reflog_orig_head) {
+				strbuf_addstr(&msg, "updating ORIG_HEAD");
+				reflog_orig_head = msg.buf;
+			}
+			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
+				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
+		} else if (old_orig)
+			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+	}
+
 	if (!reflog_head) {
 		strbuf_setlen(&msg, prefix_len);
 		strbuf_addstr(&msg, "updating HEAD");
@@ -1725,7 +1730,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL,
-		       RESET_HEAD_DETACH, NULL, msg.buf))
+		       RESET_HEAD_DETACH | RESET_ORIG_HEAD, NULL, msg.buf))
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 7e8d5bb200..460d0523be 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -59,7 +59,7 @@ test_expect_success 'rebase against master' '
 	git rebase master
 '
 
-test_expect_failure 'rebase sets ORIG_HEAD to pre-rebase state' '
+test_expect_success 'rebase sets ORIG_HEAD to pre-rebase state' '
 	git checkout -b orig-head topic &&
 	pre="$(git rev-parse --verify HEAD)" &&
 	git rebase master &&
-- 
gitgitgadget
