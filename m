Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52187C433FE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2971661BFA
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhKQBAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhKQBAN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 20:00:13 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699BAC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:57:16 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id w7-20020aa78587000000b004a28bb92381so615091pfn.22
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=11Xxzf5yVdB60QZKKeSbKLqofXA3z/c5/STQ0C+V378=;
        b=UyrYQRBrJmhESIIOwZvr71LdprK/psLxjqiClP/kMHzVmceuK7q2QwNNETxz6NSbaL
         kHJCJSOZ6WW3igGu3AJfzjf18Pok3QzOx08wyWPxbfJJcmlShPnIaBbWmQH653K861MK
         NcFFnOF4CVGyJa/Ko27fIuPJ/VKdMYDmp5cWyjWAyBbfTW2WdYvujcKSwWmEXO3yRon5
         Y/NVtuUgJhbgIhhAHI7tRPT7QIMCmOP8Y4y6Jgwj3Xq4WCA9XImuYsLyjYMhFaBXAD3I
         /fZky8dVEVx2kOFOmbNr+tj7q3bXGXwBjguCrcXn01x8XkCKS2T3U+aPbIie9JA938J+
         qvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=11Xxzf5yVdB60QZKKeSbKLqofXA3z/c5/STQ0C+V378=;
        b=j3MsURGK38sAZqsaAKMQS3mbgmimn1/wIjo1v6gwvn6KTpVwmN1WjXaB/52FLH2mKk
         omUWJ79KY32a7yTfzYVZ0W2FPuWLEPqR47eEycjVo1deC+8TDyhH0wrxDNZGKaT4nDKU
         JwkTvQF0FlyuXxRrvYEteixwUcr/glfKF5QxknKuQUnr8XcKy4kRrTVNQkvJRkArfejJ
         IRfzMauTCBcFVNb6GFnOhcbBSZEg3/50QM+QV8TGIrJpFYfeUvsB5ttnmCNx9g8NCanc
         dlfNwlCH/8LZI5ZexwuHVTisH1HK2UqB7KNsVe9pmaf7zcWD7LIw/tqcEJYOZK9PJEEG
         pmHQ==
X-Gm-Message-State: AOAM532c4gBmwJuHs+D3Usr0SmDz283sfdRahmwVCPWy6JOwHU7BPect
        3LzmpzZySSpibQtgykN7ZfHe5Va2ZvtQGj9HYDfUnszkqXA8DtNK/bHMts5ESms9B8LkMnkXNNO
        jjzNP7guLKKJOrqdWaSQtJfDAiygBDvPmmMAlrJFqpjt6WZI/sidpw7FGhUEeWb0ct+JLSC3XXQ
        ==
X-Google-Smtp-Source: ABdhPJx/GVHgTrm/xWBzYj0zIcvs2gVhVjTHU7tE0FqFNio4XlW19Mby/nETToEF3GZ101cp/L7R38rPm7XiQTdXhAA=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:205d:7edd:a3da:3608])
 (user=emilyshaffer job=sendgmr) by 2002:a17:903:283:b0:142:1243:d879 with
 SMTP id j3-20020a170903028300b001421243d879mr50936962plr.61.1637110635864;
 Tue, 16 Nov 2021 16:57:15 -0800 (PST)
Date:   Tue, 16 Nov 2021 16:57:01 -0800
In-Reply-To: <20211117005701.371808-1-emilyshaffer@google.com>
Message-Id: <20211117005701.371808-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211117005701.371808-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v6 5/5] submodule: use config to find superproject worktree
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that submodule.superprojectGitDir is being treated as the point of
truth for whether a repo is a submodule or not, let's use it in `git
rev-parse --show-superproject-working-tree`.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>

---

This commit may be more of an RFC - to demonstrate what life looks like
if we use submodule.superprojectGitDir as the source of truth. But since
'git rev-parse --show-superproject-working-tree' is used in a lot of
scripts in the wild[1], I'm not so sure it's a great example.

To be honest, I'd prefer to die("Try running 'git submodule update'")
here, but I don't think that's very script-friendly. However, falling
back on the old implementation kind of undermines the idea of treating
submodule.superprojectGitDir as the point of truth. One thought I did
have was to put that error message in builtin/rev-parse.c instead, and
print it to stderr (per usual with user-visible messages) so it doesn't
interfere with scripts, but gives a hint for debugging.

Another thought - captured by the NEEDSWORK in the diff - was that we
could "heal" by adding that config after we know the worktree of the
superproject.

Or, it could be that it won't be a problem for a long time, as anybody
running 'git submodule update' will eventually have that config
specified - that's why I included the traces, so we could try and get an
understanding of how long repos remain in this state where they have
submodules but nobody ran 'git submodule update'. But that will only
give me visibility into submodule users at Google, who we expect to be
making a lot of workflow changes soon, anyway.

1: https://github.com/search?q=%22--show-superproject-working-tree%22&type=code
---
 submodule.c          | 85 +++++++++++++++++++++++++++++++++++++++++++-
 t/t1500-rev-parse.sh |  9 +++++
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index d7395c7551..ad95cdda07 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2236,7 +2236,7 @@ void absorb_git_dir_into_superproject(const char *path,
 	}
 }
 
-int get_superproject_working_tree(struct strbuf *buf)
+static int get_superproject_working_tree_from_fs(struct strbuf *buf)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
@@ -2320,6 +2320,89 @@ int get_superproject_working_tree(struct strbuf *buf)
 	return ret;
 }
 
+int get_superproject_working_tree(struct strbuf *buf)
+{
+	char *super_gitdir = NULL;
+	const char *cwd = xgetcwd();
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf absolute_super_gitdir = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	struct string_list lines = STRING_LIST_INIT_NODUP;
+	struct string_list_item *it = NULL;
+	const char *wt_prefix = "worktree ";
+	int rc = 0;
+
+
+	/* Do we know we have a superproject? */
+	if (git_config_get_string("submodule.superprojectgitdir", &super_gitdir))
+		goto fallback;
+
+	strbuf_addf(&absolute_super_gitdir, "%s/%s", get_git_dir(), super_gitdir);
+
+	/*
+	 * NEEDSWORK: This is a child process call because worktree.c still
+	 * relies heavily on the_repository. If we can make worktree.c work with
+	 * a repository object - or, better yet, a gitdir path alone - then we
+	 * can drop the child process and ask worktree.c directly.
+	 *
+	 * Alternatively, if 'git worktree' learns a way to say 'the worktree
+	 * associated with this gitdir' instead of 'all worktrees', that would
+	 * be clearer because we could skip the foreach below.
+	 */
+
+	/* Get the output of `git worktree list` from that superproject */
+	prepare_other_repo_env(&cp.env_array, absolute_super_gitdir.buf);
+	strvec_pushl(&cp.args, "-C", absolute_super_gitdir.buf, "worktree", "list",
+		    "--porcelain", NULL);
+
+	cp.git_cmd = 1;
+	if (capture_command(&cp, &out, 0) ||
+	    !string_list_split_in_place(&lines, out.buf, '\n', -1))
+		die("submodule.superprojectGitDir is stale; run 'git submodule "
+		    "update' from the superproject.");
+
+	for_each_string_list_item(it, &lines) {
+		char *trimmed;
+		/*
+		 * Lines containing worktree dirs look like
+		 * 'worktree /some/path'
+		 */
+		if (strncmp(it->string, wt_prefix, strlen(wt_prefix)))
+			continue;
+		trimmed = it->string + strlen(wt_prefix);
+
+		/*
+		 * '/some/path/to/sub' is a prefix of '/some/path' - that's our
+		 * worktree
+		 */
+		if (!strncmp(cwd, trimmed, strlen(trimmed))) {
+			strbuf_addstr(buf, trimmed);
+			rc = 1;
+			goto cleanup;
+		}
+	}
+
+fallback:
+	/*
+	 * Because a submodule may have been created before
+	 * submodule.superprojectGitDir was introduced, fall back on checking
+	 * whether ../ is the superproject.
+	 */
+	trace2_data_intmax("submodule", the_repository,
+			   "get_superproject_wt/config_missing", rc);
+	rc = get_superproject_working_tree_from_fs(buf);
+
+	/*
+	 * NEEDSWORK: Is it possible to teach a submodule the path to its
+	 * superproject when this happens?
+	 */
+
+cleanup:
+	string_list_clear(&lines, 0);
+	strbuf_release(&out);
+	return rc;
+}
+
 /*
  * Put the gitdir for a submodule (given relative to the main
  * repository worktree) into `buf`, or return -1 on error.
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 1c2df08333..e569910289 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -247,6 +247,15 @@ test_expect_success 'showing the superproject correctly' '
 	test_cmp expect out
 '
 
+test_expect_success 'show the superproject correctly without superprojectGitDir' '
+	# repos created before submodule.superprojectGitDir was introduced which
+	# have not been `git submodule update`-ed lately must not break
+	git -C super/dir/sub config --unset submodule.superprojectGitDir &&
+	echo $(pwd)/super >expect &&
+	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
+	test_cmp expect out
+'
+
 # at least one external project depends on this behavior:
 test_expect_success 'rev-parse --since= unsqueezed ordering' '
 	x1=--since=1970-01-01T00:00:01Z &&
-- 
2.34.0.rc1.387.gb447b232ab-goog

