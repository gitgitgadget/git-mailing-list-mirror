Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9FC20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 20:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbdK2UD1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 15:03:27 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37096 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbdK2UDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 15:03:25 -0500
Received: by mail-wm0-f67.google.com with SMTP id f140so8307688wmd.2
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 12:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q7bjTGVT5RcntFf+oRH00vLZUzEecqXimh7gwbgPiMU=;
        b=FKAPOkbknjridNEtO369N7VUUSg6IkctTeLhymK9jW8PR7+zbK+dkrp7d0QuNfdh/V
         C0+9Ba9mzAtq+k9C9RDnaynOAEHKNWsqxyrzQYg1vkvfuT3UiqdaRUpqP0FERkFFHo2U
         xKV/10HfcOuMYuq+pZiiNyiGT/JhnAkBtbtYFY+bTpzuBIXgsHUIpbJSCZdLrDdK4BpX
         ZZPWgCSEsxmDWmJZcY0kFlzGB4IW9bQZoApq6U07L/ahFOTwKCQGLVONxGFeCMlHbHvN
         I1raAS7KSdhDguG0Yu5SZ3zAGUuRiueoUv5fU0S3MyAHP5tfE/VC5XmZG4NtFGUZYYUE
         CqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q7bjTGVT5RcntFf+oRH00vLZUzEecqXimh7gwbgPiMU=;
        b=kK6VBJyY4KE6eQ9avqIDnHEBDTks4sFE4sLwDZ1THLmW4Cu/qC0JBZwsoUFK+4nPA/
         TINP48vqqc6d3I4LWQ1rZTkW8OFhPvyRp+sZYnlxT1Yz1F4a8BCyuo3IYDzpsjtbECBe
         MPNi1L/RYkZcoK90ueCzyIJ0DWcoligIPOv726UyCjSH0XMLv9CvV43stSaZlHktmRDY
         IxEGFd1rM7eJrdb7vVcIrlUAuwlZJRGK9HJCPzdqn4D3czLmSmODBbF3tVBcShoE1Be+
         8Y7L19Y22LT8R/yo0s4UVYqKNxlAxes4NNCy/7K2WkhTEYAzADgMkjWaRzNyXIrLZEyR
         Gvlg==
X-Gm-Message-State: AJaThX4squu8SWsMxpNMTH4D2fca4TOb4KLi34VxntSeQ5AqhUJ43641
        y2XhvxnGgW84qnn0hJKXPF+PPYUI
X-Google-Smtp-Source: AGs4zMZ47k8wewF+bWIwRdRGA+9DfYffPLZ72XGCokCr+DpiHY20gCwsodKryYWZiVm9k9vtZhD02Q==
X-Received: by 10.28.111.15 with SMTP id k15mr16833wmc.139.1511985803237;
        Wed, 29 Nov 2017 12:03:23 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id c12sm2830753wmi.43.2017.11.29.12.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 12:03:22 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 3/6] worktree: add --[no-]track option to the add subcommand
Date:   Wed, 29 Nov 2017 20:04:48 +0000
Message-Id: <20171129200451.16856-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171129200451.16856-1-t.gummerer@gmail.com>
References: <20171126194356.16187-1-t.gummerer@gmail.com>
 <20171129200451.16856-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add' sets up tracking branches if '<branch>' is
a remote tracking branch, and doesn't set them up otherwise, as is the
default for 'git branch'.

This may or may not be what the user wants.  Allow overriding this
behaviour with a --[no-]track flag that gets passed through to 'git
branch'.

We already respect branch.autoSetupMerge, as 'git worktree' just calls
'git branch' internally.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt |  6 +++++
 builtin/worktree.c             |  8 +++++++
 t/t2025-worktree-add.sh        | 51 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 121895209d..15e58b18f7 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -107,6 +107,12 @@ OPTIONS
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
 
+--[no-]track::
+	When creating a new branch, if `<commit-ish>` is a branch,
+	mark it as "upstream" from the new branch.  This is the
+	default if `<commit-ish>` is a remote-tracking branch.  See
+	"--track" in linkgit:git-branch[1] for details.
+
 --lock::
 	Keep the working tree locked after creation. This is the
 	equivalent of `git worktree lock` after `git worktree add`,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index ed043d5f1c..ea9678cac8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -341,6 +341,7 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *new_branch_force = NULL;
 	char *path;
 	const char *branch;
+	const char *opt_track = NULL;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -350,6 +351,9 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
+		OPT_PASSTHRU(0, "track", &opt_track, NULL,
+			     N_("set up tracking mode (see git-branch(1))"),
+			     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
 		OPT_END()
 	};
 
@@ -394,9 +398,13 @@ static int add(int ac, const char **av, const char *prefix)
 			argv_array_push(&cp.args, "--force");
 		argv_array_push(&cp.args, opts.new_branch);
 		argv_array_push(&cp.args, branch);
+		if (opt_track)
+			argv_array_push(&cp.args, opt_track);
 		if (run_command(&cp))
 			return -1;
 		branch = opts.new_branch;
+	} else if (opt_track) {
+		die(_("--[no-]track can only be used if a new branch is created"));
 	}
 
 	UNLEAK(path);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index b5c47ac602..72e8b62927 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -313,5 +313,56 @@ test_expect_success 'checkout a branch under bisect' '
 test_expect_success 'rename a branch under bisect not allowed' '
 	test_must_fail git branch -M under-bisect bisect-with-new-name
 '
+# Is branch "refs/heads/$1" set to pull from "$2/$3"?
+test_branch_upstream () {
+	printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
+	{
+		git config "branch.$1.remote" &&
+		git config "branch.$1.merge"
+	} >actual.upstream &&
+	test_cmp expect.upstream actual.upstream
+}
+
+test_expect_success '--track sets up tracking' '
+	test_when_finished rm -rf track &&
+	git worktree add --track -b track track master &&
+	test_branch_upstream track . master
+'
+
+# setup remote repository $1 and repository $2 with $1 set up as
+# remote.  The remote has two branches, master and foo.
+setup_remote_repo () {
+	git init $1 &&
+	(
+		cd $1 &&
+		test_commit $1_master &&
+		git checkout -b foo &&
+		test_commit upstream_foo
+	) &&
+	git init $2 &&
+	(
+		cd $2 &&
+		test_commit $2_master &&
+		git remote add $1 ../$1 &&
+		git config remote.$1.fetch \
+			"refs/heads/*:refs/remotes/$1/*" &&
+		git fetch --all
+	)
+}
+
+test_expect_success '--no-track avoids setting up tracking' '
+	test_when_finished rm -rf repo_upstream repo_local foo &&
+	setup_remote_repo repo_upstream repo_local &&
+	(
+		cd repo_local &&
+		git worktree add --no-track -b foo ../foo repo_upstream/foo
+	) &&
+	(
+		cd foo &&
+		test_must_fail git config "branch.foo.remote" &&
+		test_must_fail git config "branch.foo.merge" &&
+		test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
+	)
+'
 
 test_done
-- 
2.15.0.426.gb06021eeb

