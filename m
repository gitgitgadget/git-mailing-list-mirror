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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AF7C4332B
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8EF464FD8
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCKCMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhCKCLn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:43 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD1C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:43 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id o70so14289150qke.16
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GjM4mAmp+AKf53XGmy31JDt5g6a1N4hK21N+qPDtk6E=;
        b=v8DNhrvGKrntreeJWV2EUg8qZHi+nJy3wbznZr/vDrx8sLvc37CtTtgg5AGSp6AJz/
         PZ5LdMwJR6B5C6oo28pAKOMbNGwetXB5dolWoDOxGt946Cg3KCaDIpnZjRSCLmXiraLi
         hIDbu+diDW8p5vGR3INrkKn0DReUFmHoIILuQy+my9UIs0b7mV/zmDVJX6/YllVdm1du
         x8CbKPH91VLzsR7ZPSY2iTWYaibmKrBmZvJm3E+auC+keN60792MCyuRuLUj0an1AKLf
         mJGWwEnWuQJhwVH1EgobCLcqyGH6WMZseZlYgz4yPY84rvZFURY6RLZdx5bTNK20oWyJ
         koFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GjM4mAmp+AKf53XGmy31JDt5g6a1N4hK21N+qPDtk6E=;
        b=dPt4+lhV9bnMsOPpJmXXDfpjJU6uLd1F/Y6HKHBkCaXUxhC9xaHzNgXznJMFmhRojt
         qODk6enZUt2MnRi5bGFtWJGC8+8uOe/jPW+ShGp4EOXQBU2DxVXf+BxegGKJX4ZtveNH
         8vJnYNkzPAbxG2RPzr378M5zOcIlAdbXu/8k+rVh0TZIjI6U1WldswBbQeRIk0+cKBq7
         h+hXb+4bpaSWmU/NYG3N8FsGKp7Q1Zrs0aaRnUfajKK9e+ONV56BGIR3Hnk6i1f4+WV9
         RPPyokxm9CAoG/BRn+jTbOWnF61MzgfBZwpxgWXxQy8edlFg+oagYOawkGePgMUfAA3E
         J6yQ==
X-Gm-Message-State: AOAM533jNZYcjwmyW3+slZsGb0D4w2HrkrE+wvlMH5pIvYLUUYHFmQZv
        Moarh3/tRiegb838X1A3rOPmXz2fsSLqDvfhpiq+lBLFGjtPNdbKNvl4EqHds2OtjHTc7Ic5Gcx
        YLntuZrAv8Za2E7QS5lt8qVT1ez9JffD1Jdn24An048IM5WyOqYbdjUH2R4Euni15lWf2Y1EClg
        ==
X-Google-Smtp-Source: ABdhPJwmsb+/NrbVHWNd5uGyftZ18fpIykQ4kRyLJdsRzjKym1lJQ3OG+TMs5HZsZqITG3M9/F81H5xMvpmBYHe0jBs=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:20a1:: with SMTP id
 1mr5957436qvd.30.1615428702475; Wed, 10 Mar 2021 18:11:42 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:29 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-30-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 29/37] reference-transaction: look for hooks in config
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
 Documentation/githooks.txt       |  3 +++
 refs.c                           | 43 +++++++++++++-------------------
 t/t1416-ref-transaction-hooks.sh |  8 +++---
 3 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 489c93a7cb..dc8b7111d5 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -530,6 +530,9 @@ The exit status of the hook is ignored for any state except for the
 cause the transaction to be aborted. The hook will not be called with
 "aborted" state in that case.
 
+Hooks run during 'reference-transaction' will be run in parallel, unless
+hook.jobs is configured to 1.
+
 push-to-checkout
 ~~~~~~~~~~~~~~~~
 
diff --git a/refs.c b/refs.c
index a665ed5e10..4fccbac3e6 100644
--- a/refs.c
+++ b/refs.c
@@ -18,6 +18,7 @@
 #include "strvec.h"
 #include "repository.h"
 #include "sigchain.h"
+#include "hook.h"
 
 /*
  * List of all available backends
@@ -2061,47 +2062,37 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	const char *hook;
+	struct run_hooks_opt opt;
+	struct string_list to_stdin = STRING_LIST_INIT_DUP;
 	int ret = 0, i;
+	char o[GIT_MAX_HEXSZ + 1], n[GIT_MAX_HEXSZ + 1];
 
-	hook = find_hook("reference-transaction");
-	if (!hook)
-		return ret;
-
-	strvec_pushl(&proc.args, hook, state, NULL);
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "reference-transaction";
+	run_hooks_opt_init_async(&opt);
 
-	ret = start_command(&proc);
-	if (ret)
+	if (!hook_exists("reference-transaction", HOOKDIR_USE_CONFIG))
 		return ret;
 
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
+		string_list_append(&to_stdin, buf.buf);
 	}
 
-	close(proc.in);
-	sigchain_pop(SIGPIPE);
+	opt.feed_pipe = pipe_from_string_list;
+	opt.feed_pipe_ctx = &to_stdin;
+
+	ret = run_hooks("reference-transaction", &opt);
+	run_hooks_opt_clear(&opt);
 	strbuf_release(&buf);
+	string_list_clear(&to_stdin, 0);
 
-	ret |= finish_command(&proc);
 	return ret;
 }
 
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 6c941027a8..3a90a59143 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -125,11 +125,11 @@ test_expect_success 'interleaving hook calls succeed' '
 
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
2.31.0.rc2.261.g7f71774620-goog

