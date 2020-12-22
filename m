Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF3BC43219
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2722AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgLVAGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgLVAGM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:06:12 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8242CC0611CE
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:05:05 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y2so5844975pfr.12
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mgaJUEyE3U2GM/t3u/ymLmxNso4EbETblhtJPcndBjI=;
        b=tNfH1/T9qs68wLH3IKVyo/RvR9pM8uSeCL/R93TUA69hrgj26cTLWSAvvDMD4q9NZ7
         6E6t+6XuNtsQSexdi40kDJr1htKdMKnxBqGiky+xOSgKPlIXsVQ23vdvR1wDBw0RqNSw
         AnNN+9mwcyA2SfZ2GeCGQRJlqrjSMHNX8gOiRaRLV46p4co06J1KpdcPhgb5cppePAmQ
         6ZUpAR92Be71dE0msPbM6x9v7DG4hZJVCYOzrzcXAb9JHuz79IM9uJPsh/y6Om2+HQ0/
         gWkR1FhADos1NBWWHVHHxDUudfFJ0kOp/VEI266PSFM8zG6M26wDN6Oy9QQcMIlKNq50
         3BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mgaJUEyE3U2GM/t3u/ymLmxNso4EbETblhtJPcndBjI=;
        b=CjDJYgdmagA0s65FwxZ/QKusklmPjjG8MSjba5YnFrLqIb+wSmB9P9K2xONmXC+Vhy
         xCoD5Oi1brMB/C8u2hBpwK5BkT955hu/5GbptwzE2NmUkgFjxFbSae9wLl2T8eb1De9x
         jRLmYkKmFhF5PtP8x9v6ipNleqS3BqARwpqOfhbZU2vY4AO6gW6Dd3A3h5Oh6tKrjYio
         hvZkFZTQ0ZbgfYVfFEPhE42+3HHdpEa+nyDmoT8c9dNWs8Vl3Hw/xmRvAlCodrLNPIO7
         oEXGsNXa1GRr/yU1br3pJUMj4xStY0emRZ00MjdL785OictF5JQocMaIACrIyWwYcbbv
         JyaQ==
X-Gm-Message-State: AOAM532vsbiY1jRmAgWkXnReS0gNV/DPOz6Uy9e399kCgYiXLs2+bjNX
        NMKjRPy4nidiFH+A2UmJs6QigbdmA/7OKJZXVTon1IG17PnhiP/99kJ88V7R4YjZjnupBYQ+a+A
        WRB7GymoqNoEFCV2S/teoXehUkvuGhP6vCypeKpV+V8KwW87MY01xuPKWXxj5WbcNt1TNBTk9Hg
        ==
X-Google-Smtp-Source: ABdhPJyMkLC2JzxAcu5gvM/ZW5YMEAlgVXqGfeD5DiBcKH3VdQeK7bnSBqWAM6aZr3fzqGSQ0CkWTQqHuC1OEtwpgXo=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:902:bcc6:b029:dc:44a5:c363 with
 SMTP id o6-20020a170902bcc6b02900dc44a5c363mr1973563pls.5.1608595504939; Mon,
 21 Dec 2020 16:05:04 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:30 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-13-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 12/17] reference-transaction: look for hooks in config
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
 refs.c                           | 38 +++++++++-----------------------
 t/t1416-ref-transaction-hooks.sh |  8 +++----
 3 files changed, 17 insertions(+), 31 deletions(-)

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
index 392f0bbf68..b025dc4140 100644
--- a/refs.c
+++ b/refs.c
@@ -18,6 +18,7 @@
 #include "strvec.h"
 #include "repository.h"
 #include "sigchain.h"
+#include "hook.h"
 
 /*
  * List of all available backends
@@ -1957,47 +1958,30 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	const char *hook;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
 	int ret = 0, i;
+	char o[GIT_MAX_HEXSZ + 1], n[GIT_MAX_HEXSZ + 1];
 
-	hook = find_hook("reference-transaction");
-	if (!hook)
+	if (!hook_exists("reference-transaction", configured_hookdir_opt()))
 		return ret;
 
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
+		oid_to_hex_r(o, &update->old_oid);
+		oid_to_hex_r(n, &update->new_oid);
 
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s %s %s\n",
-			    oid_to_hex(&update->old_oid),
-			    oid_to_hex(&update->new_oid),
-			    update->refname);
-
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
+		strbuf_addf(&buf, "%s %s %s", o, n, update->refname);
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

