Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA3C1B0D8
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939D322E00
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbgLEBvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbgLEBvW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:51:22 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579A5C08E862
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:13 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id q13so1765953pfn.18
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ji++r9XLN8Rr7X/IEi+t7ZCiQClY2IJFMJyN2+5q56Y=;
        b=ApAiT8bo7JDboJPw9+ErzjKWfMUTsJja84JzeF/x7C73Ep2r0MBYkbJcE1/yoXcbFF
         UiVuJbmplZk5LnHxKlFpNyBQCaekmFlBz9XO+hd5J3wf28CZP2wITYDw848NH+Mu1/nJ
         +T0mgRnoBQErLCkQK2Md9K9FJAwZUmZp4flplvz0S9fjJRw2EuaQpOPjfreV7tF2biOM
         wIE3wMyMnrQ+CdH8fOvk2Z7RaTOElh+Be6XdAxodNIlQEPZ05LOXXdxxSyldU+FZnwsh
         rsewQs0ABOBvyxd3kUr+sqj/saytKrkoZe8rld6e95pOHCk1BqsZsH1yoGWpDkMg6R4L
         rMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ji++r9XLN8Rr7X/IEi+t7ZCiQClY2IJFMJyN2+5q56Y=;
        b=OrmVvvLsuYFd2yu+TZmSlmcE8Z1pyRdllUMxuQbrWrCgL2+ZyVxRlQrz7qdCMR3ZAY
         hKuqxfbCjYtK0QkvwCcp9PCADW6dMgUwhmq45rKg/+JmtidHUYIv2epdectX6r4TqmSF
         Mw+QW4+bcVTt9sFVTAFcDCY/ZhDLFND0pf8eVhSOkASPvI1avXV4q4hHe+/mr1QtY8ue
         BJ3t93bRnZAXI3uoBMqPc/H0wbmjq/gPwM5TXidXBto89ds16zr3xI/2ZT1I8nMJSJcC
         2L+744cOSq5dWV7sFMIkDMUZteIljEUh1TApBbc8NFVT5c2wZ2Zwf3mBy0iwAbKfXPHg
         yRyQ==
X-Gm-Message-State: AOAM531F5HqU3ZmEsvr3Tr46o8FuVqDW+ClIFUpplagxtrMvgKcFSbt5
        bntzKx84Lkh94sAVjMgApI6ywrTCaQDvbJL55xk8acQlR29OnpmLH4SgttNMVAV79gIJ+30UBHb
        d/wKUXLBpMNxb3qMFefSSYNalt8ouek5eP4UcXmy+t2mhqUeQ0Kc/DCAkmGPy+7Y3utVPIhJD7g
        ==
X-Google-Smtp-Source: ABdhPJw+03e6aAiHRG+pi5u/W+wryB6CVhS+eR8ZziTXZKLIJX49ha/t1qyHtdVOZYi/v5EFRgt3hvZ1O9udpVcesio=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a62:37c4:0:b029:197:bfa9:2078 with
 SMTP id e187-20020a6237c40000b0290197bfa92078mr6346496pfa.15.1607133012802;
 Fri, 04 Dec 2020 17:50:12 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:40 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-13-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 12/17] reference-transaction: look for hooks in config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using the hook.h library, reference-transaction hooks can be
specified in the config instead.

The expected output of the test is not fully updated to reflect the
absolute path of the hook called because the 'update' hook has not yet
been converted to use hook.h.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt       |  2 ++
 refs.c                           | 33 +++++++-------------------------
 t/t1416-ref-transaction-hooks.sh |  8 ++++----
 3 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 8f5524055b..3a35500132 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -521,6 +521,8 @@ The exit status of the hook is ignored for any state except for the
 cause the transaction to be aborted. The hook will not be called with
 "aborted" state in that case.
 
+Hooks run during 'reference-transaction' will be run in parallel by default.
+
 push-to-checkout
 ~~~~~~~~~~~~~~~~
 
diff --git a/refs.c b/refs.c
index 392f0bbf68..b67bca367e 100644
--- a/refs.c
+++ b/refs.c
@@ -18,6 +18,7 @@
 #include "strvec.h"
 #include "repository.h"
 #include "sigchain.h"
+#include "hook.h"
 
 /*
  * List of all available backends
@@ -1957,47 +1958,27 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	const char *hook;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
 	int ret = 0, i;
 
-	hook = find_hook("reference-transaction");
-	if (!hook)
-		return ret;
-
-	strvec_pushl(&proc.args, hook, state, NULL);
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "reference-transaction";
-
-	ret = start_command(&proc);
-	if (ret)
-		return ret;
-
-	sigchain_push(SIGPIPE, SIG_IGN);
+	strvec_push(&opt.args, state);
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s %s %s\n",
+		strbuf_addf(&buf, "%s %s %s",
 			    oid_to_hex(&update->old_oid),
 			    oid_to_hex(&update->new_oid),
 			    update->refname);
-
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
+		string_list_append(&opt.str_stdin, buf.buf);
 	}
 
-	close(proc.in);
-	sigchain_pop(SIGPIPE);
+	ret = run_hooks("reference-transaction", &opt);
+	run_hooks_opt_clear(&opt);
 	strbuf_release(&buf);
 
-	ret |= finish_command(&proc);
 	return ret;
 }
 
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index f6e741c6c0..17f11f5cb0 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -122,11 +122,11 @@ test_expect_success 'interleaving hook calls succeed' '
 
 	cat >expect <<-EOF &&
 		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
-		hooks/reference-transaction prepared
-		hooks/reference-transaction committed
+		$(pwd)/target-repo.git/hooks/reference-transaction prepared
+		$(pwd)/target-repo.git/hooks/reference-transaction committed
 		hooks/update refs/tags/POST $ZERO_OID $POST_OID
-		hooks/reference-transaction prepared
-		hooks/reference-transaction committed
+		$(pwd)/target-repo.git/hooks/reference-transaction prepared
+		$(pwd)/target-repo.git/hooks/reference-transaction committed
 	EOF
 
 	git push ./target-repo.git PRE POST &&
-- 
2.28.0.rc0.142.g3c755180ce-goog

