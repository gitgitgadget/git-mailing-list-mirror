Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 870941F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389421AbeLTTpF (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40323 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389202AbeLTTpD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so3492833wmf.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HlIF+lfhvQDm16Se1Y52mVjVO6oEVfbhl3tVwsxkctE=;
        b=sYX4bKeuqQ3b0ILT/jItFA9QVhEYYeH2HBVoinzCjyOsCGUNYKQfXQd2c6JaLxP759
         FNOHTQryjp0rqdsJclihyM5OeYcH440+9y9LC65zZHt0Zaigqa8i4heGpLChxe2AAYJU
         E50NE+y+11wKufixL4U1pjwlwNn88Fz0IWy65KT45wM8h0nv/BjpFhBw094hRbtGyoSl
         Pep8BFXGRY41mYYIA1xp4JM46X/BzE8dAqJSYjOKU1qbpH/gOby48ucS5tXpKgw2oX7D
         6dxcu7wd5MDmASkF1GJ0Co3+3eClhQaMsDrJ4mFBI5uKWYLuMdrbWp0ku8hUoJKnoYbN
         8mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HlIF+lfhvQDm16Se1Y52mVjVO6oEVfbhl3tVwsxkctE=;
        b=EjSowasQXTK6aYb34/EC5gJ317KPeUin2GstBYPv04/oCwg0icm7xaX1ZmM/vGgT5T
         WNe/5t3juyMPAcmO0tCMaz+TtkX04KhSYjwXZ3BNwSSpt6rcjfyxrsxQFXTu+KSyXj6v
         X1y3XXWCmjFjeknsOBMRvKndneTI4A3S14UTQKtoorwtU8jjuwn5DarS1uy2tGOj3fr4
         zmK0v/vYvHI1oIFtOUtsbHu76LDcNh49dUGpfY2D+LF39nw0abccx9aekaJfdi54i4o1
         etLP0KJeLnjviYsAFNNaBCJETbxLACNpbuLTiGL2FG4BxOc5AtL4zEOXaQy1vVXIikoc
         qiMg==
X-Gm-Message-State: AJcUukfcMmEbJHcbzBzP25ikf2u1wGttTTjT77p26WzI4DfBKioPZZWC
        UyE+K9prsbqLMjshV9kWlf2V8Xn/Mbo=
X-Google-Smtp-Source: AFSGD/XhMCVXTeybieBZb5quZcU8ZY6G/o+abQtWGqfjOShVhTnm54BEF+87Is18SiHpnyvwGFpo9A==
X-Received: by 2002:a1c:934e:: with SMTP id v75mr8017wmd.126.1545335099944;
        Thu, 20 Dec 2018 11:44:59 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:44:59 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 12/26] stash: convert branch to builtin
Date:   Thu, 20 Dec 2018 21:44:28 +0200
Message-Id: <9f69a7f2530772992bd3319c450f516bb100675e.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

Add stash branch to the helper and delete the apply_to_branch
function from the shell script.

Checkout does not currently provide a function for checking out
a branch as cmd_checkout does a large amount of sanity checks
first that we require here.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 46 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 17 ++-------------
 2 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 07b8ec5bcb..68b65165e4 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -14,6 +14,7 @@
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	NULL
 };
@@ -28,6 +29,11 @@ static const char * const git_stash_helper_apply_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_branch_usage[] = {
+	N_("git stash--helper branch <branchname> [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_clear_usage[] = {
 	N_("git stash--helper clear"),
 	NULL
@@ -537,6 +543,44 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int branch_stash(int argc, const char **argv, const char *prefix)
+{
+	int ret;
+	const char *branch = NULL;
+	struct stash_info info;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_branch_usage, 0);
+
+	if (!argc) {
+		fprintf_ln(stderr, _("No branch name specified"));
+		return -1;
+	}
+
+	branch = argv[0];
+
+	if (get_stash_info(&info, argc - 1, argv + 1))
+		return -1;
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "checkout", "-b", NULL);
+	argv_array_push(&cp.args, branch);
+	argv_array_push(&cp.args, oid_to_hex(&info.b_commit));
+	ret = run_command(&cp);
+	if (!ret)
+		ret = do_apply_stash(prefix, &info, 1, 0);
+	if (!ret && info.is_stash_ref)
+		ret = do_drop_stash(prefix, &info, 0);
+
+	free_stash_info(&info);
+
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -563,6 +607,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		return !!drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "branch"))
+		return !!branch_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index b8f70230f9..67db321a4c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -615,20 +615,6 @@ drop_stash () {
 	clear_stash
 }
 
-apply_to_branch () {
-	test -n "$1" || die "$(gettext "No branch name specified")"
-	branch=$1
-	shift 1
-
-	set -- --index "$@"
-	assert_stash_like "$@"
-
-	git checkout -b $branch $REV^ &&
-	apply_stash "$@" && {
-		test -z "$IS_STASH_REF" || drop_stash "$@"
-	}
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -690,7 +676,8 @@ pop)
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
2.20.1.441.g764a526393

