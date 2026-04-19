Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06412C21C5
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776617705; cv=none; b=I6LTIGwRJ6yP7kxLPwF5bzRRpsJuiIonu5rqUNO6sJSQahTkB12CVltcp9zgKa0RqHh15Mv80ydeTvLCtf8FVtGYPxv+y60uPqhLEpYiSVUDxtihNMcVgZMOkGRaRGMc44beUVXM5hAVQxOFw+T4fuz8ekPYtwHxN1kryzJQq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776617705; c=relaxed/simple;
	bh=j2BqgKdI8SU/wNjwHyAw9L3mJep2Ge70evN9U2OathM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWcBUOBbTuUmLxQ73+v5gliXdUKZ0EsXxNjbMHSh8F7gGLDP+gKJmF7bgZ/O8aRkDgwt6l1oUA0TJ0Fg0Nye5pLB9znsiOEuqO7hDZ6GWdmbGLgD/Mgn7gHJyCKVx2C0wpwwI8PNzclFoXTgshSOpkeuMlGBiTqhBRgft+v0okw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mU5f6CH/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU5f6CH/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82748257f5fso1760656b3a.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776617703; x=1777222503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgoGlCSOtfMMxAfCE5MEEZFDZSr8hePcQYb6J4M5SX0=;
        b=mU5f6CH/6cwTk2olv34xL4a/Ebmc2uAtcQ0d/piPEG2e/NGIj5dRwxhYCjbkp5krKw
         aSf1pdgcVcQ/O9QdxOjrk/4KHhcSnuQPOO/cyXvZGpnkceQGjooNX6IKc/atRPoLKxgA
         heiaqpxXNE9MQ8nXqomgOvwy2J3gj2bt8ZR0kWw8neBY6ci2XMXxyfgfC+Vnp4fAB92w
         uDzo1T7zy2yj2VqGfY7706NZ8uEVx5K4r7oseyGSGh6EFQD7JM878DON+Cr3Upti1/wQ
         7TY7ejs/O+eY2W+lr/mZ7BHpN7/LTsvcYmudEdd0mzAE8vmy7F/ee9MwxjMeS1ijGeWu
         tNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776617703; x=1777222503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgoGlCSOtfMMxAfCE5MEEZFDZSr8hePcQYb6J4M5SX0=;
        b=SxoW/BH07Swr84qr5n0xp3+LJ2rVOQiM63rmYuR56MX/RpJz6Ig2fymwt16RZZ3Bms
         q5VZO9swbFrQ8XAq3oOa4yG0WZm2eKQlBta4159DVBnpxsoU5Awr4/pZgw1oiKpYL8XR
         ZoSxpTQbAXk5xH27FsdnACuSZfl/uR7C53Z4RPxBPa0joxV9zR8Je/XfISHOyOWojGxc
         EhiLsD9lxGG6tyPHOFD48/5RnwAtzyVZDU2Fca+ohOfkm+4otoyToJXTIVPjq1Zqvee+
         CnFf2GKaC4fKmsgW3Pm+DLJ3AMRSL9bu6ZHmXHbvVXv+JRj8ApfaZpk7KwNaYx/Jra88
         Ty0Q==
X-Gm-Message-State: AOJu0YxyQB8RwL/G9JZoR1ZDVMYv+aC+TO9ZJCqDWY6Yv2Y1MmA7nrNS
	BvykLexg/oQgb13CPiAZ7VUxJSbBOdfPYTRZlJJh6USgr+SSYLkS8AQH4IUJ+A==
X-Gm-Gg: AeBDieuYlP77YXAbLWpWYwbmG8f5ZETWYUEHOTxQxsNEQ1GlBka2AIU4Rz90VObvYFm
	jNZv0TjRC20Lx56RUV11xLDXWZq98LUrVLH4Wt0DIM21MjjydwALgCfVbM1a7tKl6iS8I3QFhV1
	FCQktLwGBSsnsIgyCnTiJStVBkX7WLUlj1jOWxE7X5HsAuIwuMYwBvXS4Hn4XPy1XpFeoHlrDL2
	T2UYSAuJPQ2McHAglSuP1OMN5l4l9Otnhtfq3hsrjhjYHEu0WTXB2XS9FfIsr2G8TiTpflN3SGN
	Y5gDnm7S8MfVvB7ecL3xYala5bn+YAN2o9AbN2YDnOkaw0503pt4FuCju/bEmw/AgvB8CEIyttH
	daGNPAfh+dj2xP6VURN5I36ENKc/GQw3/l/a9sSocZLFuONOK+NmYm4No85aGJFokRnOg1fvEON
	OuinqqnRDe0FENiPmhvZOuXGBONa9BoklrRHxjfsUq98V/DeSGpun1HRPB2Ba0+twuf+n7TI+jg
	mc+
X-Received: by 2002:a05:6a20:158a:b0:3a2:c9a1:2c26 with SMTP id adf61e73a8af0-3a2c9a2b9ebmr602876637.7.1776617702684;
        Sun, 19 Apr 2026 09:55:02 -0700 (PDT)
Received: from d.iiitdmj.ac.in ([14.139.241.214])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797702faaesm5738622a12.23.2026.04.19.09.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 09:55:02 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	mroik@delayed.space,
	quentin.bernet@bluewin.ch,
	gitster@pobox.com,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v5] stash: assume "push" when command line starts with an option
Date: Sun, 19 Apr 2026 16:54:53 +0000
Message-ID: <20260419165453.32593-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260404143640.6679-1-deveshigurgaon@gmail.com>
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "git stash" is run without any subcommand (on the command line),
the command tries to assume "push" but rejects non-option arguments
(i.e., pathspecs without "--") to avoid treating a misspelled
subcommand name as a pathspec.

This means "git stash -m foo file" is rejected even though "-m" is
clearly an option and not a subcommand name, and the user's intent
is clear.

A command line that begins with an option cannot be naming a "git
stash" subcommand, so move the decision to cmd_stash(): when no
subcommand matches and the first argument starts with "-", assume
"push". When the first argument does not start with "-", reject it as
an unexpected token as before.

This simplifies push_stash() by removing push_assumed/force_assume
logic; the caller has already made the assumption decision.

This was marked as #leftoverbits in [1].

[1] https://lore.kernel.org/git/xmqqtsu1jipp.fsf@gitster.g/

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>

---

Changes since v4:
  - Move push-assumption logic from push_stash() to cmd_stash().
  - Remove stale push_assumed/force_assume handling.
  - Drop incorrect note about negated options being rejected.
  - Use "assumed" (not "inferred") in documentation.
  - Update tests/style (including ${SQ}) and add --no-keep-index coverage.
---
 Documentation/git-stash.adoc |  7 +++--
 builtin/stash.c              | 53 ++++++++++++++----------------------
 t/t3903-stash.sh             | 30 ++++++++++++++++++--
 3 files changed, 53 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 235d57ddd8..946b51c7a5 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -61,9 +61,10 @@ COMMANDS
 +
 For quickly making a snapshot, you can omit "push".  In this mode,
 non-option arguments are not allowed to prevent a misspelled
-subcommand from making an unwanted stash entry.  The two exceptions to this
-are `stash -p` which acts as alias for `stash push -p` and pathspec elements,
-which are allowed after a double hyphen `--` for disambiguation.
+subcommand from making an unwanted stash entry.  Pathspec elements
+are allowed after a double hyphen `--` for disambiguation.  When
+the command line begins with an option, "push" is assumed and
+pathspec arguments are also accepted without `--`.
 
 `save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-u | --include-untracked] [-a | --all] [-q | --quiet] [<message>]`::
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 95c5005b0b..bf04cf58a6 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1831,9 +1831,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 }
 
 static int push_stash(int argc, const char **argv, const char *prefix,
-		      int push_assumed)
+		      const char * const usage[])
 {
-	int force_assume = 0;
 	int keep_index = -1;
 	int only_staged = 0;
 	int patch_mode = 0;
@@ -1868,26 +1867,14 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	};
 	int ret;
 
-	if (argc) {
-		int flags = PARSE_OPT_KEEP_DASHDASH;
-
-		if (push_assumed)
-			flags |= PARSE_OPT_STOP_AT_NON_OPTION;
-
+	if (argc)
 		argc = parse_options(argc, argv, prefix, options,
-				     push_assumed ? git_stash_usage :
-				     git_stash_push_usage, flags);
-		force_assume |= patch_mode;
-	}
+				     usage,
+				     PARSE_OPT_KEEP_DASHDASH);
 
-	if (argc) {
-		if (!strcmp(argv[0], "--")) {
-			argc--;
-			argv++;
-		} else if (push_assumed && !force_assume) {
-			die("subcommand wasn't specified; 'push' can't be assumed due to unexpected token '%s'",
-			    argv[0]);
-		}
+	if (argc && !strcmp(argv[0], "--")) {
+		argc--;
+		argv++;
 	}
 
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
@@ -1935,7 +1922,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 static int push_stash_unassumed(int argc, const char **argv, const char *prefix,
 				struct repository *repo UNUSED)
 {
-	return push_stash(argc, argv, prefix, 0);
+	return push_stash(argc, argv, prefix, git_stash_push_usage);
 }
 
 static int save_stash(int argc, const char **argv, const char *prefix,
@@ -2387,7 +2374,6 @@ int cmd_stash(int argc,
 {
 	pid_t pid = getpid();
 	const char *index_file;
-	struct strvec args = STRVEC_INIT;
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
 		OPT_SUBCOMMAND("apply", &fn, apply_stash),
@@ -2427,19 +2413,22 @@ int cmd_stash(int argc,
 	else if (!argc)
 		return !!push_stash_unassumed(0, NULL, prefix, repo);
 
-	/* Assume 'stash push' */
-	strvec_push(&args, "push");
-	strvec_pushv(&args, argv);
+	if (argv[0][0] != '-')
+		die("subcommand wasn't specified; 'push' can't be assumed due to unexpected token '%s'",
+		    argv[0]);
 
 	/*
-	 * `push_stash()` ends up modifying the array, which causes memory
-	 * leaks if we didn't copy the array here.
+	 * When the command line starts with an option, assume 'push'.
+	 * Unshift "push" into argv so that parse_options() skips it
+	 * as the subcommand name.  Use git_stash_usage so that invalid
+	 * options show the general stash usage rather than the
+	 * push-specific usage.
 	 */
-	DUP_ARRAY(args_copy, args.v, args.nr);
-
-	ret = !!push_stash(args.nr, args_copy, prefix, 1);
-
-	strvec_clear(&args);
+	ALLOC_ARRAY(args_copy, argc + 1);
+	args_copy[0] = "push";
+	memcpy(&args_copy[1], argv, argc * sizeof(const char *));
+	argc++;
+	ret = !!push_stash(argc, args_copy, prefix, git_stash_usage);
 	free(args_copy);
 	return ret;
 }
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..836cc29a6b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -410,8 +410,34 @@ test_expect_success 'stash --staged with binary file' '
 '
 
 test_expect_success 'dont assume push with non-option args' '
-	test_must_fail git stash -q drop 2>err &&
-	test_grep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''drop'\''" err
+	test_must_fail git stash someunknown 2>err &&
+	test_grep "subcommand wasn${SQ}t specified; ${SQ}push${SQ} can${SQ}t be assumed due to unexpected token ${SQ}someunknown${SQ}" err
+'
+
+test_expect_success 'assume push when command line starts with option' '
+	test_when_finished "git reset --hard" &&
+	test_when_finished "rm -f untracked-file" &&
+	echo changed >file &&
+	git add file &&
+	git stash -m "implied push" file &&
+	git stash pop &&
+
+	git add file &&
+	git stash --staged file &&
+	git stash pop &&
+
+	git add file &&
+	git stash --keep-index file &&
+	git stash pop &&
+
+	git add file &&
+	git stash --no-keep-index file &&
+	git stash pop &&
+
+	echo untracked >untracked-file &&
+	git stash --include-untracked untracked-file &&
+	test_path_is_missing untracked-file &&
+	git stash pop
 '
 
 test_expect_success 'stash --invalid-option' '

base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
-- 
2.52.0.230.gd8af7cadaa

