Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85AB1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 17:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeCXRhl (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 13:37:41 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:42032 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeCXRhj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 13:37:39 -0400
Received: by mail-pl0-f43.google.com with SMTP id w15-v6so9354240plq.9
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7R0bd8MuRIXk/0Tf+QHtT4dBBm+4v4cVnERscRAg2Y0=;
        b=ABRr1WWVMkbEGDOrUNt8N6wOsm2iHe71YudI28ziEikNEG/913gZ0p7WG0E/1e2Nze
         u1eQsUwoj+ghgw2Q8yRMii7+m4DlrZLTMwnC4RWIrcCmxPrX4Fl7wa7ykfnHliGp/J9C
         wjQxmR+FaDrSHnl4JqqdG64RTbQ3qOXDwswIw2B3cW8RZyeXKr8VgmkdG/2kQBhzX78C
         EWc3lnWirhD+jHc5Xmz0HW7VyLMN03EVH6W7d0bzhHVPr1RWv/a4GkXafrzA0y/KYj4v
         6vx9qb2fAjkJputD9XPji7kF2p0cN1FAhInKdmfBztxpU0AfH1lKYloXjE6t+IXEz/NA
         BGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7R0bd8MuRIXk/0Tf+QHtT4dBBm+4v4cVnERscRAg2Y0=;
        b=Jhqr7akuDbXvMIj7O/rl/0xn5pvc1aFSAx4goZqRIlSH9njh8gSTJPZz0MqNs+u3SR
         qrypUzzzCDdbxcmQ/LKrVEU989J52z9vNYF3Kn6QYcT++HfdxZOYjXHPQmRilF90+ZER
         YDWF5gUZCQ9wBmlwWckEemh/9J5Z80wqFnkaJin71pe5p8bNkmWykoBBR362L86KlXMO
         6ZJVxR3+ppNaJ7IILy4GA54co/SmhBt3BTohPe5dbKAhl0ZBHJnfSiYySPn17MXdjzTT
         a99U1rbkteAt8Sd5o+BBW3dhB1/T0/GGUXs15FfE0RpzuB3kp0ZAvcSsDgQjYCIlMTJ5
         T9hg==
X-Gm-Message-State: AElRT7HkzFXcfQZUHPRLdBeQuKkcm1GqlufUg7Xw5ZVroA+EmEKmZkVs
        XMlwpw9OjFssWlCRMsDpvTOQ+xI=
X-Google-Smtp-Source: AG47ELsebthkjCAy9ndUTg7B62BpI7NSAb0NbmmcCZMZVTeWGYl6HdsecWVYtFpp9s1scIqvS+ymDQ==
X-Received: by 2002:a17:902:a713:: with SMTP id w19-v6mr33237964plq.246.1521913059117;
        Sat, 24 Mar 2018 10:37:39 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id z6sm22005486pfe.9.2018.03.24.10.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 10:37:38 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH 2/4] stash: convert branch to builtin
Date:   Sat, 24 Mar 2018 10:37:05 -0700
Message-Id: <20180324173707.17699-3-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180324173707.17699-1-joel@teichroeb.net>
References: <20180324173707.17699-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/stash--helper.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |  3 ++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index e9a9574f40..18c4aba665 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper branch <branchname> [<stash>]"),
 	NULL
 };
 
@@ -20,6 +21,11 @@ static const char * const git_stash_helper_apply_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_branch_usage[] = {
+	N_("git stash--helper branch <branchname> [<stash>]"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static int quiet;
 static char stash_index_path[PATH_MAX];
@@ -307,6 +313,42 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	return do_apply_stash(prefix, &info, index);
 }
 
+static int branch_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *commit = NULL, *branch = NULL;
+	int ret;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct stash_info info;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_helper_branch_usage, 0);
+
+	if (argc != 0) {
+		branch = argv[0];
+		if (argc == 2)
+			commit = argv[1];
+	}
+
+	if (get_stash_info(&info, commit))
+		return -1;
+
+	argv_array_pushl(&args, "checkout", "-b", NULL);
+	argv_array_push(&args, branch);
+	argv_array_push(&args, sha1_to_hex(info.b_commit.hash));
+	ret = cmd_checkout(args.argc, args.argv, prefix);
+	if (ret)
+		return -1;
+
+	ret = do_apply_stash(prefix, &info, 1);
+	if (!ret && info.is_stash_ref)
+		ret = do_drop_stash(prefix, &info);
+
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	int result = 0;
@@ -329,6 +371,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_stash_helper_usage, options);
 	else if (!strcmp(argv[0], "apply"))
 		result = apply_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "branch"))
+		result = branch_stash(argc, argv, prefix);
 	else {
 		error(_("unknown subcommand: %s"), argv[0]);
 		usage_with_options(git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 92c084eb17..360643ad4e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -736,7 +736,8 @@ pop)
 	;;
 branch)
 	shift
-	apply_to_branch "$@"
+	cd "$START_DIR"
+	git stash--helper branch "$@"
 	;;
 *)
 	case $# in
-- 
2.16.2

