Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8839769E
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785663084; cv=none; b=qhhtCNV0YHYFcyK+kghfpMONRcL1i0rQqplRoo/Q2f2yUB+BDo13x0nxureGVj1wrqOVPKr+GTepKLxYi7B2RVpU+lZRJTPBnDZXFHvu7Dc6C0H6xdSZMHIVWTLDWldW+bl7DdlHWoEwG9b5zvGifFuzB74q2mQTlmZOsl/BCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785663084; c=relaxed/simple;
	bh=r9jBzxcf5Phq54MVvmCRfB0pt8ias81/hM8n5IWbuUE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MyIzGs3HGWgKOV1S+GGbpxAMVsumfB8K1qG8auHnhjlzdocYRp8h73RSe3oSE3Q/e/y977EJhCWjLOwIU5Z2ZJeITWOTU6FUSQ+SY+DTMKNfaafn9fPoNT51BgmzR29KWte7Ljj2pUAnJVZYY/TvgtRfG1E1Z2NSsjTaDDrGJ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APAxwIxo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APAxwIxo"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1804135a91.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785663082; x=1786267882; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VsgLV1zICdxCpG2pO5fJYufCBPaj1aMW3G2RNHGomqM=;
        b=APAxwIxothB00qbtKXLAz9vEtM05u5VRkvi/cmCh1ZsWdHYmc7Be/+b1YyJkeNbpKk
         2+bpNEoPMJKeP7s221j6ggaQBVJwzrNLUEZd0gykzAZBdvPfWyLF8puTgbnXmIADYyP8
         4Nd0BNQdlzPl/RGIkFZliwzgEXcZm7D3WPQI9CWb9c8we3poFiJqc6RoII6wMn1kFRL1
         YPUWH0koO2kt11DKu+BidSLR5EuIQC/dboJNsNQ22iLisQYPEJG3+Re5FikXVxoVBuaE
         SyWj2j3pD1EqXO4oei0arCpsoXXdIWIbNvkoV5lRjmjCoE8GShYZGc9vwZ0sF/FyOPwP
         9WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785663082; x=1786267882;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VsgLV1zICdxCpG2pO5fJYufCBPaj1aMW3G2RNHGomqM=;
        b=Z4VqwnKQOpOOeYaOaOegXtpbJY4TWZYxpFUpv6vNzyMcaJCy3BTj9Wjnvj85cvOHVX
         SH1O5zCDKJk+5wQVr/VhzF7tkmcgVWgNnjezx9PJzylmaJBcCHt5YBffRTKPFDaDWctI
         dxKSCFFL/52nA571Tw+vUZDVmzCyESIpOGh5bDFAeqEUm77MuEzPrQU0fN0ldx9eyfex
         KFzxBc2zuyQKPbY03U0eK3d6kGC4trS+HyFxJ9LRGlRNAQmVp5FRjuOF+3kD2u+iqOSj
         AuMPV/YVVTNSZO++UR9GSdEiaRQKi82ztRZG7G0th1s/VNaFeT1EkZIfoXEsK0KehK86
         u3Pw==
X-Gm-Message-State: AOJu0YzYbq8yFDJjrIjLY1U+LvKK8+Nc2k6K/jReJHriYg7cwuDI/xU7
	ZHlwPXgofKB4Nt7V5TsH1a/BiITwczZkHh742DpBOL/FdjpIW5bskU5OcdTbmA==
X-Gm-Gg: AR+sD11BjxSPAozLwNc8+keaOZKdmPrD1qBf+yTFcVcSo5mkjII851hCEMXoi5X/hxP
	cfuBWnNN6zp6cy2vGgGXkKhaWMFSwsCpj2BPijDYR3sKLx4XV67y49AZsAn4tH1yPCe9zzEJJ6k
	KxNlE4ccqfwDquCEKVvZ6NtJwtnDadp3x24BtBJSUJ2yQ7N6/gahD6JS5Zi5xpiPtQYIqqn+R78
	wrQV0xi7CdQ6SzWh9shHP081ilh6ztr//jEnGaDzyaHYvfDb+QrIL5Y7o1UvsfU0u9WSeMOD3l6
	9m9gHTCengSKDieBtHEMcMfY3vzPfzwENjCzU7owSQgXqCorINleHKABVMi7Vz9Xg0ccmD5F6eS
	wu5n3D900n0BkhpNPx8EL4fVwrjGY8XxNKJd/YRvTBoXK07OiBePhd2/CCSinEZy6jo2nS83a4I
	8RNFNHAfdqk1hzdN16OxNlfMfJMl90b8ZNBxyUtOLrSXf3vrJSI0mCgkYrgr30SH2E
X-Received: by 2002:a17:90b:280a:b0:37f:c28a:de61 with SMTP id 98e67ed59e1d1-38fbc45521dmr5351273a91.17.1785663081569;
        Sun, 02 Aug 2026 02:31:21 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.167.113])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb51asm32017429c88.9.2026.08.02.02.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 02:31:20 -0700 (PDT)
Message-Id: <ec362f3b82227de55375db8610536138a6e5cdbd.1785663075.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
References: <pull.2335.v4.git.git.1785577445.gitgitgadget@gmail.com>
	<pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Aug 2026 09:31:15 +0000
Subject: [PATCH v5 2/2] bisect: add --reset-when-found to leave when done
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When a bisection finishes, "git bisect" reports the first bad commit
but leaves the session active until "git bisect reset" is run by hand.

Add a "--reset-when-found[=<where>]" option, accepted by both "git
bisect start" and "git bisect run", that resets as soon as the first
bad commit is found. The "original" value returns to the commit checked
out before "git bisect start", while "found" leaves the first bad commit
checked out; omitting the value defaults to "original".

Persist the selected target in a BISECT_RESET_WHEN_FOUND state file
and perform the reset quietly.

Propagate the internal first-bad result and its commit to
cmd_bisect(), which performs the reset after the subcommand has
returned. For "git bisect run", this means BISECT_RUN has been printed
and closed before cleanup, which also works on systems that cannot
unlink an open file.

Reject this option together with "--no-checkout", since that mode must
not check out either target.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-bisect.adoc |  14 ++-
 bisect.c                      |   6 +-
 bisect.h                      |   3 +-
 builtin/bisect.c              | 157 +++++++++++++++++++++++++++++++---
 t/t6030-bisect-porcelain.sh   | 121 ++++++++++++++++++++++++++
 5 files changed, 287 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-bisect.adoc b/Documentation/git-bisect.adoc
index d2115b2990..aabddd42ca 100644
--- a/Documentation/git-bisect.adoc
+++ b/Documentation/git-bisect.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [synopsis]
 git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
-		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
+		 [--no-checkout] [--first-parent] [--reset-when-found[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]
 git bisect (bad|new|<term-new>) [<rev>]
 git bisect (good|old|<term-old>) [<rev>...]
 git bisect terms [--term-(good|old) | --term-(bad|new)]
@@ -20,7 +20,7 @@ git bisect reset [<commit>]
 git bisect (visualize|view)
 git bisect replay <logfile>
 git bisect log
-git bisect run <cmd> [<arg>...]
+git bisect run [--reset-when-found[=<where>]] <cmd> [<arg>...]
 git bisect help
 
 DESCRIPTION
@@ -385,6 +385,16 @@ ignored.
 This option is particularly useful in avoiding false positives when a merged
 branch contained broken or non-buildable commits, but the merge itself was OK.
 
+`--reset-when-found[=<where>]`::
+	Once the first bad commit is found, report it and clean up the
+	bisection state. `<where>` may be `original` to return to the commit
+	checked out before `git bisect start`, or `found` to leave the first
+	bad commit checked out. If `<where>` is omitted, it defaults to
+	`original`.
++
+This option may be given to `git bisect start` or to `git bisect run`. It
+cannot be used for a bisection started with `--no-checkout`.
+
 EXAMPLES
 --------
 
diff --git a/bisect.c b/bisect.c
index 94c7028d2a..a3cf1abc38 100644
--- a/bisect.c
+++ b/bisect.c
@@ -488,6 +488,7 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_reset_when_found, "BISECT_RESET_WHEN_FOUND")
 
 static void read_bisect_paths(struct strvec *array)
 {
@@ -1041,7 +1042,8 @@ void read_bisect_terms(char **read_bad, char **read_good)
  * the end of bisect_helper::cmd_bisect__helper() helps bypassing
  * all the code related to finding a commit to test.
  */
-enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
+enum bisect_error bisect_next_all(struct repository *r, const char *prefix,
+				  struct object_id *first_bad)
 {
 	struct strvec rev_argv = STRVEC_INIT;
 	struct rev_info revs = REV_INFO_INIT;
@@ -1113,6 +1115,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		res = error_if_skipped_commits(tried, current_bad_oid);
 		if (res)
 			goto cleanup;
+		oidcpy(first_bad, bisect_rev);
 		printf("%s is the first '%s' commit\n", oid_to_hex(bisect_rev),
 			term_bad);
 
@@ -1211,6 +1214,7 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
+	unlink_or_warn(git_path_bisect_reset_when_found());
 	/*
 	 * Cleanup BISECT_START last to support the --no-checkout option
 	 * introduced in the commit 4796e823a.
diff --git a/bisect.h b/bisect.h
index 8621460f93..d1e3c9c721 100644
--- a/bisect.h
+++ b/bisect.h
@@ -63,7 +63,8 @@ struct bisect_state {
 	unsigned int nr_bad;
 };
 
-enum bisect_error bisect_next_all(struct repository *r, const char *prefix);
+enum bisect_error bisect_next_all(struct repository *r, const char *prefix,
+				  struct object_id *first_bad);
 
 int estimate_bisect_steps(int all);
 
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 5393690f6b..5217900976 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -24,11 +24,12 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_reset_when_found, "BISECT_RESET_WHEN_FOUND")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 #define BUILTIN_GIT_BISECT_START_USAGE \
 	N_("git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]\n" \
-	   "                 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]")
+	   "                 [--no-checkout] [--first-parent] [--reset-when-found[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]")
 #define BUILTIN_GIT_BISECT_BAD_USAGE \
 	N_("git bisect (bad|new|<term-new>) [<rev>]")
 #define BUILTIN_GIT_BISECT_GOOD_USAGE \
@@ -48,7 +49,7 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 #define BUILTIN_GIT_BISECT_LOG_USAGE \
 	"git bisect log"
 #define BUILTIN_GIT_BISECT_RUN_USAGE \
-	N_("git bisect run <cmd> [<arg>...]")
+	N_("git bisect run [--reset-when-found[=<where>]] <cmd> [<arg>...]")
 #define BUILTIN_GIT_BISECT_HELP_USAGE \
 	"git bisect help"
 
@@ -68,6 +69,12 @@ static const char * const git_bisect_usage[] = {
 	NULL
 };
 
+enum reset_when_found_mode {
+	RESET_WHEN_FOUND_NONE,
+	RESET_WHEN_FOUND_TO_ORIGINAL,
+	RESET_WHEN_FOUND_TO_FOUND,
+};
+
 struct add_bisect_ref_data {
 	struct rev_info *revs;
 	unsigned int object_flags;
@@ -78,6 +85,8 @@ struct bisect_terms {
 	char *term_bad;
 };
 
+static struct object_id first_bad_oid;
+
 static void free_terms(struct bisect_terms *terms)
 {
 	FREE_AND_NULL(terms->term_good);
@@ -269,7 +278,75 @@ static int bisect_reset(const char *commit, bool quiet)
 	}
 
 	strbuf_release(&branch);
-	return bisect_clean_state();
+	return 0;
+}
+
+static int parse_reset_when_found(const char *value,
+				  enum reset_when_found_mode *mode)
+{
+	if (!strcmp(value, "original"))
+		*mode = RESET_WHEN_FOUND_TO_ORIGINAL;
+	else if (!strcmp(value, "found"))
+		*mode = RESET_WHEN_FOUND_TO_FOUND;
+	else
+		return error(_("invalid value for '--reset-when-found': '%s'"),
+			     value);
+
+	return 0;
+}
+
+static const char *reset_when_found_mode_name(enum reset_when_found_mode mode)
+{
+	switch (mode) {
+	case RESET_WHEN_FOUND_TO_ORIGINAL:
+		return "original";
+	case RESET_WHEN_FOUND_TO_FOUND:
+		return "found";
+	case RESET_WHEN_FOUND_NONE:
+		BUG("no name for unset reset-when-found mode");
+	}
+	BUG("unknown reset-when-found mode %d", mode);
+}
+
+static int read_reset_when_found(enum reset_when_found_mode *mode)
+{
+	struct strbuf value = STRBUF_INIT;
+	int res = 0;
+
+	*mode = RESET_WHEN_FOUND_NONE;
+	if (is_empty_or_missing_file(git_path_bisect_reset_when_found()))
+		return 0;
+
+	if (strbuf_read_file(&value, git_path_bisect_reset_when_found(), 0) < 0) {
+		res = error_errno(_("could not read '%s'"),
+				  git_path_bisect_reset_when_found());
+		goto out;
+	}
+	strbuf_trim(&value);
+	if (parse_reset_when_found(value.buf, mode))
+		res = -1;
+
+out:
+	strbuf_release(&value);
+	return res;
+}
+
+static int bisect_reset_when_found(enum reset_when_found_mode mode)
+{
+	char first_bad_hex[GIT_MAX_HEXSZ + 1];
+	const char *commit = NULL;
+	int res;
+
+	if (mode == RESET_WHEN_FOUND_TO_FOUND)
+		commit = oid_to_hex_r(first_bad_hex, &first_bad_oid);
+	else if (mode == RESET_WHEN_FOUND_NONE)
+		BUG("automatic reset requested without a reset mode");
+
+	res = bisect_reset(commit, true);
+	if (!res)
+		res = bisect_clean_state();
+
+	return res;
 }
 
 static void log_commit(FILE *fp,
@@ -682,7 +759,8 @@ static int bisect_successful(struct bisect_terms *terms)
 	return res;
 }
 
-static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
+static enum bisect_error bisect_next(struct bisect_terms *terms,
+				     const char *prefix)
 {
 	enum bisect_error res;
 
@@ -693,7 +771,7 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 		return BISECT_FAILED;
 
 	/* Perform all bisection computation */
-	res = bisect_next_all(the_repository, prefix);
+	res = bisect_next_all(the_repository, prefix, &first_bad_oid);
 
 	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
 		res = bisect_successful(terms);
@@ -705,7 +783,8 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 	return res;
 }
 
-static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
+static enum bisect_error bisect_auto_next(struct bisect_terms *terms,
+					  const char *prefix)
 {
 	if (bisect_next_check(terms, NULL)) {
 		bisect_print_status(terms);
@@ -729,6 +808,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	struct strbuf bisect_names = STRBUF_INIT;
 	struct object_id head_oid;
 	struct object_id oid;
+	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
 	const char *head;
 
 	if (is_bare_repository(the_repository))
@@ -752,6 +832,13 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 			no_checkout = 1;
 		} else if (!strcmp(arg, "--first-parent")) {
 			first_parent_only = 1;
+		} else if (!strcmp(arg, "--reset-when-found")) {
+			reset_when_found = RESET_WHEN_FOUND_TO_ORIGINAL;
+		} else if (skip_prefix(arg, "--reset-when-found=", &arg)) {
+			if (parse_reset_when_found(arg, &reset_when_found)) {
+				res = BISECT_FAILED;
+				goto finish;
+			}
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
 			i++;
@@ -789,6 +876,11 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 			break;
 		}
 	}
+	if (reset_when_found != RESET_WHEN_FOUND_NONE && no_checkout) {
+		res = error(_("options '%s' and '%s' cannot be used together"),
+			    "--reset-when-found", "--no-checkout");
+		goto finish;
+	}
 	pathspec_pos = i;
 
 	/*
@@ -868,6 +960,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	if (first_parent_only)
 		write_file(git_path_bisect_first_parent(), "\n");
 
+	if (reset_when_found != RESET_WHEN_FOUND_NONE)
+		write_file(git_path_bisect_reset_when_found(), "%s\n",
+			   reset_when_found_mode_name(reset_when_found));
+
 	if (no_checkout) {
 		if (repo_get_oid(the_repository, start_head.buf, &oid) < 0) {
 			res = error(_("invalid ref: '%s'"), start_head.buf);
@@ -1098,7 +1194,7 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	if (is_empty_or_missing_file(filename))
 		return error(_("cannot read file '%s' for replaying"), filename);
 
-	if (bisect_reset(NULL, false))
+	if (bisect_clean_state())
 		return BISECT_FAILED;
 
 	fp = fopen(filename, "r");
@@ -1246,13 +1342,39 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
+	const char *reset_when_found_arg;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
 	int is_first_run = 1;
+	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
+	bool reset_when_found_arg_seen = false;
 
 	if (bisect_next_check(terms, NULL))
 		return BISECT_FAILED;
 
+	if (argc && !strcmp(argv[0], "--reset-when-found")) {
+		reset_when_found = RESET_WHEN_FOUND_TO_ORIGINAL;
+		reset_when_found_arg_seen = true;
+	} else if (argc && skip_prefix(argv[0], "--reset-when-found=",
+				    &reset_when_found_arg)) {
+		if (parse_reset_when_found(reset_when_found_arg,
+					   &reset_when_found))
+			return BISECT_FAILED;
+		reset_when_found_arg_seen = true;
+	}
+
+	if (reset_when_found != RESET_WHEN_FOUND_NONE &&
+	    refs_ref_exists(get_main_ref_store(the_repository), "BISECT_HEAD"))
+		return error(_("options '%s' and '%s' cannot be used together"),
+			     "--reset-when-found", "--no-checkout");
+
+	if (reset_when_found_arg_seen) {
+		write_file(git_path_bisect_reset_when_found(), "%s\n",
+			   reset_when_found_mode_name(reset_when_found));
+		argc--;
+		argv++;
+	}
+
 	if (!argc) {
 		error(_("bisect run failed: no command provided."));
 		return BISECT_FAILED;
@@ -1327,7 +1449,6 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 			res = BISECT_OK;
 		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
 			printf(_("bisect found first '%s' commit\n"), terms->term_bad);
-			res = BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'git bisect %s'"
 				" exited with error code %d"), new_state, res);
@@ -1344,10 +1465,15 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED,
 			     struct repository *repo UNUSED)
 {
+	int res;
+
 	if (argc > 1)
 		return error(_("'%s' requires either no argument or a commit"),
 			     "git bisect reset");
-	return bisect_reset(argc ? argv[0] : NULL, false);
+	res = bisect_reset(argc ? argv[0] : NULL, false);
+	if (res)
+		return res;
+	return bisect_clean_state();
 }
 
 static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
@@ -1489,7 +1615,8 @@ int cmd_bisect(int argc,
 		    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
 			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
 				       options, argv[0]);
-		res = bisect_state(&terms, argc, argv);
+		else
+			res = bisect_state(&terms, argc, argv);
 		free_terms(&terms);
 	} else {
 		argc--;
@@ -1497,5 +1624,15 @@ int cmd_bisect(int argc,
 		res = fn(argc, argv, prefix, repo);
 	}
 
+	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
+		enum reset_when_found_mode mode;
+
+		if (read_reset_when_found(&mode))
+			res = BISECT_FAILED;
+		else if (mode != RESET_WHEN_FOUND_NONE &&
+			 bisect_reset_when_found(mode))
+			res = BISECT_FAILED;
+	}
+
 	return is_bisect_success(res) ? 0 : -res;
 }
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 338df4f886..a7588222a8 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -43,6 +43,42 @@ test_bisect_usage () {
 	test_cmp expect actual
 }
 
+test_bisect_state_file () {
+	local file &&
+	file=$(git rev-parse --git-path "$1") &&
+	test_path_is_file "$file"
+}
+
+test_bisect_state_missing () {
+	local file &&
+	file=$(git rev-parse --git-path "$1") &&
+	test_path_is_missing "$file"
+}
+
+bisect_start_and_finish () {
+	git bisect start "$1" $HASH4 $HASH2 &&
+	git bisect bad
+}
+
+bisect_run_reset_when_found () {
+	write_script test_script.sh <<-\EOF &&
+	! grep Another hello >/dev/null
+	EOF
+	git bisect start $HASH4 $HASH2 &&
+	git bisect run "$1" ./test_script.sh >my_bisect_log.txt &&
+	test_grep "$HASH3 is the first .bad. commit" my_bisect_log.txt &&
+	test_bisect_state_missing BISECT_RUN
+}
+
+test_reset_when_found_fails () {
+	local pattern="$1" &&
+	local state_file="$2" &&
+	shift 2 &&
+	test_must_fail "$@" 2>err &&
+	test_grep -- "$pattern" err &&
+	test_bisect_state_missing "$state_file"
+}
+
 test_expect_success 'bisect usage' "
 	test_bisect_usage 1 git bisect reset extra1 extra2 <<-\EOF &&
 	error: 'git bisect reset' requires either no argument or a commit
@@ -453,6 +489,91 @@ test_expect_success '"git bisect run" simple case' '
 	git bisect reset
 '
 
+test_expect_success '"git bisect start --reset-when-found" defaults to original' '
+	test_when_finished "git bisect reset && git checkout main" &&
+	git checkout main &&
+	bisect_start_and_finish --reset-when-found &&
+	actual=$(git rev-parse HEAD) &&
+	test "$HASH4" = "$actual" &&
+	actual=$(git branch --show-current) &&
+	test main = "$actual" &&
+	test_bisect_state_missing BISECT_START &&
+
+	bisect_start_and_finish --reset-when-found=original &&
+	actual=$(git rev-parse HEAD) &&
+	test "$HASH4" = "$actual" &&
+	actual=$(git branch --show-current) &&
+	test main = "$actual" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '"git bisect start --reset-when-found=found" leaves first bad checked out' '
+	test_when_finished "git bisect reset && git checkout main" &&
+	bisect_start_and_finish --reset-when-found=found &&
+	actual=$(git rev-parse HEAD) &&
+	test "$HASH3" = "$actual" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '"git bisect run --reset-when-found" defaults to original' '
+	test_when_finished "git bisect reset && git checkout main" &&
+	bisect_run_reset_when_found --reset-when-found &&
+	actual=$(git rev-parse HEAD) &&
+	test "$HASH4" = "$actual" &&
+	actual=$(git branch --show-current) &&
+	test main = "$actual" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '"git bisect run --reset-when-found=found" leaves first bad checked out' '
+	test_when_finished "git bisect reset && git checkout main" &&
+	bisect_run_reset_when_found --reset-when-found=found &&
+	actual=$(git rev-parse HEAD) &&
+	test "$HASH3" = "$actual" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '--reset-when-found rejects an unknown reset target' '
+	test_when_finished "git bisect reset && git checkout main" &&
+	test_reset_when_found_fails \
+		"invalid value for.*--reset-when-found.*unknown" BISECT_START \
+		git bisect start --reset-when-found=unknown $HASH4 $HASH2 &&
+
+	git bisect start $HASH4 $HASH2 &&
+	test_reset_when_found_fails \
+		"invalid value for.*--reset-when-found.*unknown" \
+		BISECT_RESET_WHEN_FOUND \
+		git bisect run --reset-when-found=unknown true
+'
+
+test_expect_success '--reset-when-found cannot be used with --no-checkout' '
+	test_when_finished "git bisect reset" &&
+	test_reset_when_found_fails \
+		"options .*--reset-when-found.* and .*--no-checkout.* cannot be used together" BISECT_START \
+		git bisect start --reset-when-found=original --no-checkout $HASH4 $HASH2 &&
+
+	git bisect start --no-checkout $HASH4 $HASH2 &&
+	test_reset_when_found_fails \
+		"options .*--reset-when-found.* and .*--no-checkout.* cannot be used together" BISECT_RESET_WHEN_FOUND \
+		git bisect run --reset-when-found=found true
+'
+
+test_expect_success 'without --reset-when-found the bisection state is kept' '
+	test_when_finished "git bisect reset" &&
+	git bisect start $HASH4 $HASH2 &&
+	git bisect bad &&
+	test_bisect_state_file BISECT_START
+'
+
+test_expect_success '--reset-when-found does not leak into a later bisection' '
+	test_when_finished "git bisect reset && git checkout main" &&
+	bisect_start_and_finish --reset-when-found &&
+
+	git bisect start $HASH4 $HASH2 &&
+	git bisect bad &&
+	test_bisect_state_file BISECT_START
+'
+
 # We want to automatically find the commit that
 # added "Ciao" into hello.
 test_expect_success '"git bisect run" with more complex "git bisect start"' '
-- 
gitgitgadget
