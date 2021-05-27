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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88064C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D563613CA
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhE0AMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhE0ALj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:39 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E878C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:56 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o14-20020a05620a130eb02902ea53a6ef80so2098938qkj.6
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5qfSluBsSvJIq1htHRAc/V19BZWcOjZE5Zgmui+lgmI=;
        b=TtynfeWnbFl5rJLlxhZnjx/ikflCy9mQqU1D5Pabr/zfaA9H50AQcImIdeeeLRJMUC
         fKLD8J9DPANFlUnM7UPsNdABNs+53O+fSkFFG5zK7Im5N9eG/6k3cK5z+GROQbsvb/sr
         zGd9cr65wu4x+t7rCu4VCev9grqOXKNf9kyNA+P7APZoPoERQFLiYLgE58IaEDxCYm2R
         ekX8PsXurTYmtk3gcbZWVQn2RAM48ajBiCj65iKTS/ZAOrFR6JzpNq5g0QusGFu1/iJB
         yBLrsKKW/K/uiVzfaIo7mn4JL68et/8yDZw15GpY7ls6KYVH9w55aSCtOL4pO/4rLyQh
         rUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5qfSluBsSvJIq1htHRAc/V19BZWcOjZE5Zgmui+lgmI=;
        b=BlwCO/sFqUuseM6d31BL6tAPPeYjT7GXaA1AXHs+M0kH/2DDBLP0eFQAFxpid+EfF/
         6k/Cv2vzmnAfFXXxfeQUZOT0AjJE6TmqG2ja/JBzzOhHMLnSA5uBs0o+7WSZ99Q0eX/g
         PafvMuTXb5MV8orjHzu3O+4TXx2SrKvE9Cb0v3CMZZe8074kBuOCB0UrjrycAhPQsf6H
         wKElaYvlS6wpyWt8OkoJfM2l6yc9w0nmGJfYwdWNVy7ekMhPKJUdVUxjtzRMXm36cth5
         mqPNJWw2QRCaqx1jp3HjLMoEttj0TwrSUJZmd9ZPSiwia/iDqa/qvXU7eKZmpgNseq1H
         CNug==
X-Gm-Message-State: AOAM5302wjQOotbS2RaJeJEOwOwjzMxhPJ37pHJTK6LC8I4ezi7409KN
        WCbAnDULrmSJ4F3oKhcRUjWD8TXOHzG34ME3kE3JdZciIPPM0AxdHcG7I06OPWNkWqy6GmAiDBG
        WVOQ8ZGPemnAsq54zNEzL3FEuyEVaM812kTY2dwUKf092VTDoKCmXDd+yb1kl8U7Ga07w1ZKLqw
        ==
X-Google-Smtp-Source: ABdhPJxlebAdyKUHXhbDN9aGSBOn1YHScRdnvPdkE9iAGOMVlzPdrDwAEJYpLCzgY0D42ZenNfha0SO0r8ZSYtzIzso=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:f8d1:: with SMTP id
 h17mr1073542qvo.2.1622074195199; Wed, 26 May 2021 17:09:55 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:47 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-29-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 28/37] reference-transaction: look for hooks in config
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
 transport.c                      |  1 +
 4 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 543244ec0a..edb840dcdd 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -539,6 +539,9 @@ The exit status of the hook is ignored for any state except for the
 cause the transaction to be aborted. The hook will not be called with
 "aborted" state in that case.
 
+Hooks run during 'reference-transaction' will be run in parallel, unless
+hook.jobs is configured to 1.
+
 push-to-checkout
 ~~~~~~~~~~~~~~~~
 
diff --git a/refs.c b/refs.c
index 8c9490235e..32e993aaff 100644
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
diff --git a/transport.c b/transport.c
index dbc7bb7820..9191107626 100644
--- a/transport.c
+++ b/transport.c
@@ -1202,6 +1202,7 @@ static int run_pre_push_hook(struct transport *transport,
 	struct strbuf tmp = STRBUF_INIT;
 	struct ref *r;
 	struct string_list to_stdin = STRING_LIST_INIT_DUP;
+
 	run_hooks_opt_init_async(&opt);
 
 	strvec_push(&opt.args, transport->remote->name);
-- 
2.31.1.818.g46aad6cb9e-goog

