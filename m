Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69119C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhLIKUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhLIKUm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:20:42 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8FEC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:17:09 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r5so4671165pgi.6
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqdgORCD3UPzWUPCO+jsBmMdNwiZLwNxuJgbSPFzOEs=;
        b=A/QtLVwEGh4nlu9x1xFK0Ql2YtTlxc4usrK7ioN9tJaMruXtHkTU7mz6906kQFDrEz
         hdwpNK0QOuQAqdNLM+mAnUVNzLH2ONoX3no3XxQWG0AcL1LRwHnBGiUBA9hb4uTzEasa
         i9qT97qtJUwxiz8HLAFsz3q+DToDKGa+zqbzWRmVgmGy3GiR9aHiLyIH5R3fcFp0rmrJ
         C7zEAjA48HkDs9SGb/ptBzig7ot/sgrtGjNqhvC8xxXLyXBGUDZMNsgKbCOaQ7kBvBKJ
         9loIVwSict65WV5Jv3dFwpeJcx/YoMXQjGZ+ODd96faB6tFWjgYliL8Rc0VaEr7JeUDR
         g9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqdgORCD3UPzWUPCO+jsBmMdNwiZLwNxuJgbSPFzOEs=;
        b=lCr5yk08QraOyNqc+kOQLfACfY9F7vtjUin5bNOogo4v1nkLi1L53pSGV2+twiNXYj
         2Vvd0vStOY2kgOn4xJea6sjOwfkSjLD00Vcs+ZnjPow2cn6hDCxuucqPg5DumakX0UIA
         L/H2ScQHNrVsKfkFTROqipG1ktUoUjs8kR5jaRpbe642u+1T5Hegp/CBEi5v+iOKTwsZ
         fzKLNd+5PtRQpZ/Y2+5R5jwbG/CGMWtC8Ph2ML8EnVQCX9iGpG8yRMVtqQVrJ80YE/2C
         13vKAYOk/cxH6xw9AjkZ5mBeknUp0xaYrG5CTjg/GmBz3RK0OXlbo/NDcJJcEVpH4EHr
         wfqQ==
X-Gm-Message-State: AOAM532q4GUjhLZswPsrcKk6JKM5tRKVYig7Sip+b3lMNB6P++IhNW6p
        dcSvKcmAolE0MxUyvOVgwGdaMxevJqMpyg==
X-Google-Smtp-Source: ABdhPJwVl7mK4Dzb79+0cg1K/z9nbTBTn9DFXjD0Yvd6A+m0m3hhf23uQE8GPTPnKfDNq2+/uHFHdw==
X-Received: by 2002:a05:6a00:2391:b0:4a2:cb64:2e43 with SMTP id f17-20020a056a00239100b004a2cb642e43mr10766544pfc.49.1639045028357;
        Thu, 09 Dec 2021 02:17:08 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.157.96])
        by smtp.gmail.com with ESMTPSA id m6sm5236859pgs.18.2021.12.09.02.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:17:08 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: [PATCH v3 1/1] push: make '-u' have default arguments
Date:   Thu,  9 Dec 2021 15:45:50 +0530
Message-Id: <20211209101550.19582-2-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209101550.19582-1-chakrabortyabhradeep79@gmail.com>
References: <20211207182300.4361-1-chakrabortyabhradeep79@gmail.com>
 <20211209101550.19582-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git push -u" (set-upstream) requires where to push to and what
to push.  Often people push only the current branch to update
the branch of the same name at the 'origin' repository.  For
them, it would be convenient if "git push -u" without repository
or refspec, defaulted to push and set upstream to the branch as
configured by the "push.default" setting, of the remote repository
that is used by default.

Teach "git push -u" not to require repository and refspec.  When
the user do not give what repository to push to, or which
branch(es) to push, behave as if the default remote repository
and a refspec (depending on the "push.default" configuration)
are given.

If "push.default"=matching, push all the branches matched on both
remote and local side and set those remote branches as the upstream
of their respective local matched branches. Otherwise, set the
refspec to the refspec for current branch.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/git-push.txt | 10 +++++
 builtin/push.c             | 11 ++++-
 t/t5523-push-upstream.sh   | 87 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2f25aa3a29..6fd474441f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -375,6 +375,16 @@ Specifying `--no-force-if-includes` disables this behavior.
 	upstream (tracking) reference, used by argument-less
 	linkgit:git-pull[1] and other commands. For more information,
 	see `branch.<name>.merge` in linkgit:git-config[1].
++
+`-u` can also work with zero arguments( i.e. no `<repository>` and
+`<refspec>` are given). In that case, it tries to get the `<repository>`
+value from `branch.*.remote` configuration. If not found, it defaults to
+`origin`. If `remote.pushDefault` is set then it uses that instead. The
+value of `<refspec>` depends on the current `push.default` configuration.
+If `push.default` is set to `matching`, all remote branches to which
+local branches pushed, will be set as upstream of respective local
+branches. For all other values of `push.default`, current branch's
+refspec will be used as the `<refspec>`.
 
 --[no-]thin::
 	These options are passed to linkgit:git-send-pack[1]. A thin transfer
diff --git a/builtin/push.c b/builtin/push.c
index 4b026ce6c6..8bc206c9d8 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -202,11 +202,12 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 	return branch->merge[0]->src;
 }
 
-static void setup_default_push_refspecs(struct remote *remote)
+static void setup_default_push_refspecs(struct remote *remote, int flags)
 {
 	struct branch *branch;
 	const char *dst;
 	int same_remote;
+	int is_default_u = (flags & TRANSPORT_PUSH_SET_UPSTREAM);
 
 	switch (push_default) {
 	case PUSH_DEFAULT_MATCHING:
@@ -214,6 +215,8 @@ static void setup_default_push_refspecs(struct remote *remote)
 		return;
 
 	case PUSH_DEFAULT_NOTHING:
+		if (is_default_u)
+			break;
 		die(_("You didn't specify any refspecs to push, and "
 		    "push.default is \"nothing\"."));
 		return;
@@ -234,11 +237,15 @@ static void setup_default_push_refspecs(struct remote *remote)
 	case PUSH_DEFAULT_SIMPLE:
 		if (!same_remote)
 			break;
+		if (is_default_u)
+			break;
 		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
 			die_push_simple(branch, remote);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
+		if (is_default_u)
+			break;
 		if (!same_remote)
 			die(_("You are pushing to remote '%s', which is not the upstream of\n"
 			      "your current branch '%s', without telling me what to push\n"
@@ -401,7 +408,7 @@ static int do_push(int flags,
 		if (remote->push.nr) {
 			push_refspec = &remote->push;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
-			setup_default_push_refspecs(remote);
+			setup_default_push_refspecs(remote, flags);
 	}
 	errs = 0;
 	url_nr = push_url_of_remote(remote, &url);
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index fdb4292056..ea5d1ae914 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -60,6 +60,48 @@ test_expect_success 'push -u :topic_2' '
 	check_config topic_2 upstream refs/heads/other2
 '
 
+default_u_setup() {
+	git checkout main &&
+	test_might_fail	git branch --unset-upstream &&
+	test_config push.default $1 &&
+	test_config remote.pushDefault upstream
+}
+
+for i in simple current upstream nothing
+do
+	test_expect_success 'push -u with push.default=$i' '
+		default_u_setup $i &&
+		git push -u &&
+		check_config main upstream refs/heads/main &&
+		git push -u upstream main:other &&
+		git push -u &&
+		check_config main upstream refs/heads/main
+	'
+done
+
+check_empty_config() {
+	test_expect_code 1 git config "branch.$1.remote" &&
+	test_expect_code 1 git config "branch.$1.merge"
+}
+
+test_expect_success 'push -u with push.default=matching' '
+	default_u_setup matching &&
+	git branch test_u &&
+	git branch test_u2 &&
+	git push upstream main:test_u2 &&
+	git push -u &&
+	check_config main upstream refs/heads/main &&
+	check_config test_u2 upstream refs/heads/test_u2 &&
+	check_empty_config test_u
+'
+
+test_expect_success 'push -u --dry-run' '
+	git checkout main &&
+	git push -u upstream main:other &&
+	git push -u --dry-run &&
+	check_config main upstream refs/heads/other
+'
+
 test_expect_success 'push -u --all' '
 	git branch all1 &&
 	git branch all2 &&
@@ -81,6 +123,13 @@ test_expect_success TTY 'progress messages go to tty' '
 	test_i18ngrep "Writing objects" err
 '
 
+test_expect_success TTY 'progress messages go to tty with default -u' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push -u 2>err &&
+	test_i18ngrep "Writing objects" err
+'
+
 test_expect_success 'progress messages do not go to non-tty' '
 	ensure_fresh_upstream &&
 
@@ -89,6 +138,14 @@ test_expect_success 'progress messages do not go to non-tty' '
 	test_i18ngrep ! "Writing objects" err
 '
 
+test_expect_success 'progress messages do not go to non-tty (default -u)' '
+	ensure_fresh_upstream &&
+
+	# skip progress messages, since stderr is non-tty
+	git push -u 2>err &&
+	test_i18ngrep ! "Writing objects" err
+'
+
 test_expect_success 'progress messages go to non-tty (forced)' '
 	ensure_fresh_upstream &&
 
@@ -97,6 +154,14 @@ test_expect_success 'progress messages go to non-tty (forced)' '
 	test_i18ngrep "Writing objects" err
 '
 
+test_expect_success 'progress messages go to non-tty with default -u (forced)' '
+	ensure_fresh_upstream &&
+
+	# force progress messages to stderr, even though it is non-tty
+	git push -u --progress 2>err &&
+	test_i18ngrep "Writing objects" err
+'
+
 test_expect_success TTY 'push -q suppresses progress' '
 	ensure_fresh_upstream &&
 
@@ -104,6 +169,13 @@ test_expect_success TTY 'push -q suppresses progress' '
 	test_i18ngrep ! "Writing objects" err
 '
 
+test_expect_success TTY 'push -q suppresses progress (with default -u)' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push -u -q 2>err &&
+	test_i18ngrep ! "Writing objects" err
+'
+
 test_expect_success TTY 'push --no-progress suppresses progress' '
 	ensure_fresh_upstream &&
 
@@ -112,6 +184,14 @@ test_expect_success TTY 'push --no-progress suppresses progress' '
 	test_i18ngrep ! "Writing objects" err
 '
 
+test_expect_success TTY 'push --no-progress suppresses progress (default -u)' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push -u --no-progress 2>err &&
+	test_i18ngrep ! "Unpacking objects" err &&
+	test_i18ngrep ! "Writing objects" err
+'
+
 test_expect_success TTY 'quiet push' '
 	ensure_fresh_upstream &&
 
@@ -126,4 +206,11 @@ test_expect_success TTY 'quiet push -u' '
 	test_must_be_empty output
 '
 
+test_expect_success TTY 'quiet push -u (default -u)' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push --quiet -u --no-progress 2>&1 | tee output &&
+	test_must_be_empty output
+'
+
 test_done
-- 
2.34.1

