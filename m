Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E5A20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 20:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbdK2UDe (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 15:03:34 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:44727 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbdK2UD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 15:03:29 -0500
Received: by mail-wm0-f66.google.com with SMTP id t8so8723380wmc.3
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 12:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WzmgH3r3zUIoDX8/S2PNZuM2ff36E3Ya7BomgvtHn+0=;
        b=EFYRYetF2VOdKdoJT+ZiBaeAC7EugoYejwvuquAMqYP3Bwus9ODMFPm7ijY4hQLNRe
         zm1c8SgoXIPS5GfLHl/zGWNAviQbsedT2jwU+i/SK/molmc5qf+i1K5blvezjiCCsGxj
         VYMz6UvXO0olr4DlDcivRMhdxlRmsJ+Quc4zhFf4F7QTl0Em6nCBtToC6MohL3iify9a
         hnqbnXGe6kucWbyJliH0jIZewc3t4hNfev0A4HbandJUX6PauobN69VyulRPmsp9RZgG
         ZHac90q/8Z6/VE+CyO0KFxvtEBSzbYbmuE1SSybyEb2DW6XyOTgVJjKq/7Bg6o6rTBv3
         psRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WzmgH3r3zUIoDX8/S2PNZuM2ff36E3Ya7BomgvtHn+0=;
        b=ZUsG96PrF95xtTpfkp5F18kAP0BZ+jtPP92rQzQBXny8wBQ0i3mD7SqRtgFVIBGFlk
         jyDFszaFcP7vXbhPHZzXEOoC7q0PEpLeHpTu4wx8ew7Pa5fIbYD712Yv5MIq2nXgX55Y
         3HS876K3RPOUa3p5fdyKcxxo5BEtNQMv3XJ4fnlrdCgUn8wlOhVLkhNDPICt4w/Udkwz
         TeVzKIH5V9V817ut/nylMXG644jlu8pynMBALZeqP8oBa8UUNlYs5Pf1bf+kRxuvGrep
         05FnmRnwYY1ldCCPPANbq5sMKaO8hZ0FJdXm9JwM0tOzjLE5SXR5Ja1CyIZU+6Q6l6rF
         nzsA==
X-Gm-Message-State: AJaThX4S9NyB6k9m945CF0MEUHh9amKVb5iC/EUEyiYQol+0TFiiy5UK
        MQHkEjhnxXOP6pSK1yvbKv9jz5yF
X-Google-Smtp-Source: AGs4zMbuYUXIkruGMzvtb8mGOF9pCTPREUMsZCoS8UyJOzpqESHkBfXmZOq/tp94Hh91CaTyHYqQDQ==
X-Received: by 10.28.230.78 with SMTP id d75mr5936wmh.54.1511985807316;
        Wed, 29 Nov 2017 12:03:27 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v18sm2133860wrv.37.2017.11.29.12.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 12:03:26 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 6/6] add worktree.guessRemote config option
Date:   Wed, 29 Nov 2017 20:04:51 +0000
Message-Id: <20171129200451.16856-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171129200451.16856-1-t.gummerer@gmail.com>
References: <20171126194356.16187-1-t.gummerer@gmail.com>
 <20171129200451.16856-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some users might want to have the --guess-remote option introduced in
the previous commit on by default, so they don't have to type it out
every time they create a new worktree.

Add a config option worktree.guessRemote that allows users to configure
the default behaviour for themselves.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/config.txt       | 10 ++++++++++
 Documentation/git-worktree.txt |  3 +++
 builtin/worktree.c             | 14 ++++++++++++--
 t/t2025-worktree-add.sh        | 31 +++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f65fa9234..4966d90ebb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3425,3 +3425,13 @@ web.browser::
 	Specify a web browser that may be used by some commands.
 	Currently only linkgit:git-instaweb[1] and linkgit:git-help[1]
 	may use it.
+
+worktree.guessRemote::
+	With `add`, if no branch argument, and neither of `-b` nor
+	`-B` nor `--detach` are given, the command defaults to
+	creating a new branch from HEAD.  If `worktree.guessRemote` is
+	set to true, `worktree add` tries to find a remote-tracking
+	branch whose name uniquely matches the new branch name.  If
+	such a branch exists, it is checked out and set as "upstream"
+	for the new branch.  If no such match can be found, it falls
+	back to creating a new branch from the current HEAD.
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index a4ffee5e08..89ad0faecf 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -121,6 +121,9 @@ OPTIONS
 	branch in exactly one remote matching the basename of `<path>,
 	base the new branch on the remote-tracking branch, and mark
 	the remote-tracking branch as "upstream" from the new branch.
++
+This can also be set up as the default behaviour by using the
+`worktree.guessRemote` config option.
 
 --[no-]track::
 	When creating a new branch, if `<commit-ish>` is a branch,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 15cb1600ee..002a569a11 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -33,8 +33,19 @@ struct add_opts {
 
 static int show_only;
 static int verbose;
+static int guess_remote;
 static timestamp_t expire;
 
+static int git_worktree_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "worktree.guessremote")) {
+		guess_remote = git_config_bool(var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 static int prune_worktree(const char *id, struct strbuf *reason)
 {
 	struct stat st;
@@ -343,7 +354,6 @@ static int add(int ac, const char **av, const char *prefix)
 	char *path;
 	const char *branch;
 	const char *opt_track = NULL;
-	int guess_remote = 0;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -591,7 +601,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_worktree_config, NULL);
 
 	if (ac < 2)
 		usage_with_options(worktree_usage, options);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index d25c774cb7..6ce9b9c070 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -413,4 +413,35 @@ test_expect_success 'git worktree add --guess-remote sets up tracking' '
 	)
 '
 
+test_expect_success 'git worktree add with worktree.guessRemote sets up tracking' '
+	test_when_finished rm -rf repo_a repo_b foo &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git config worktree.guessRemote true &&
+		git worktree add ../foo
+	) &&
+	(
+		cd foo &&
+		test_branch_upstream foo repo_a foo &&
+		test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+	)
+'
+
+test_expect_success 'git worktree --no-guess-remote option overrides config' '
+	test_when_finished rm -rf repo_a repo_b foo &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git config worktree.guessRemote true &&
+		git worktree add --no-guess-remote ../foo
+	) &&
+	(
+		cd foo &&
+		test_must_fail git config "branch.foo.remote" &&
+		test_must_fail git config "branch.foo.merge" &&
+		! test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+	)
+'
+
 test_done
-- 
2.15.0.426.gb06021eeb

