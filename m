Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E91DD0EF
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778652; cv=none; b=fykyVImAbVhEIpg/UbG1FfPhcjQgftUImKtNE1a7C/D/sFaSuMreUaNEEPNqy9Nr3tR7aNbv6vFHIT88TsYOfAdjt4g74r7cuNr0MrWinihOr7y9I1RGgQ52CQ0YP+DCGtg4zqtF3oA/1JE7j7rKDDAARULLyCWjrj0W0+S5WsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778652; c=relaxed/simple;
	bh=4+X6zwzD5GcAj+yDwApSvN4jOtrCTfE2EoDyeoPjfjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBR3ipl33FLenxdpyUaZ3Ab0vOqSrb8HC+Qj0jTeGH9bsmFhorXpDIjCyXeemiJeynZGhQMTvSsbyBQh2LYYyCC4UrNRf3ZKNuz746GTy/O2KiaO7LzKfiozgrlDI8YCciSSm0GGtNS4QuwNkfeASzulXRSgMu3BfSxwCTA4gic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qqy/mvpE; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqy/mvpE"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fc13355a5bso1191565eaf.3
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 13:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740778648; x=1741383448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iL8xyT79Z45q71m81W5VYqHXlIcCTVtGev5cKil9HzA=;
        b=Qqy/mvpECoVHKLFOpyBsB4QlbuQ7/mUIRhd/MgeS+Kl7dQIFHkafnIaCFDRomlipmo
         MSosjTYtVMqSm5dEP8bobMlk0O5lXbbm3mMK4x/fHLicMs27RrhhiaEI84YtVngnZCl5
         rGmIznX+ERneLnQ1dtm8kF1mIHeUB6wpT0d1UtS/7StRFEVGil/JWuG5FdHRYGwPMYXV
         rFvqhcKZbhBeCbRwLJOP+hFeq9UrFQQiWm2gmEXCpGRCYFQe1qbfcoe3We+8qub9L1sB
         O1PRLVrq5J2jIb3ruFP7AYgV/6mPv/6tgSjshFt6iUKrEdLm3UH3jWn5Ep1koZQ+myba
         mO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740778648; x=1741383448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iL8xyT79Z45q71m81W5VYqHXlIcCTVtGev5cKil9HzA=;
        b=UFzaF7oQT44onBAPaBt/d9nru5Zvy13UTa3GKyp61zIuNLu7R0KHD16eeGOn9s3td8
         qOV/kiTr6XmdAiwXBuAGcxyGLLsDKPT6wVAOQEAjYUPuH7+1WQi16Eg9aM5LSoqBhGpH
         lc+WPRYZEIE6WhF0VUVfZwXxtznMDscF1ZW5M1/QdQwhjuZPf4198cKKKyTShzzKDrmN
         tqDRjdq/npMYrawS5c66pO35SE0Y2LueAk1ReqRSSiTEQP2dxuhfn8Biob/olk2NJvDZ
         L/ajxPHo9Z7b2Qhw99V9zrLbVZBYtc1YMPN7T0Vxl53v9e1Z7733LqPLiT8bwKVY8laB
         Ehaw==
X-Gm-Message-State: AOJu0Yz0N7j3vPqYRX830ef8UjqnUQy50cykScmC9iTOlpjoO1x2HpVm
	DbIK2zhtqjitmTASRrGRPceDpZj5wcJv0fRMqodOtGDsVEyqOY2PSGtwUKup
X-Gm-Gg: ASbGncv4waNp8Ek+rM7oELpSohZTyu/F8sq0NPAFCGyTHn/x09B2po9rfSGoIE4fZdi
	tjLhDswg2r3N22iATEcQ2rvLW4B05mhUT18D2ZRg2iDDCNmsNlMX34BvHmvmQ1oVPhWZxxRwstD
	B6rYv3rfxFTnDUVJSUz3IRXDcWUDIRjpZgiAxUx4Sebx3IC+Y4yqSpbVTzLMGN4r7Q47DV8tt71
	M6QOZJNYu49OSqbymUbqw6c/Wkm3pdySqjT2a9j4L5lMo3jeA4+KDgnU3Z04ZFRv4QnEFiSr+re
	e065X5ZYImWtrPzVqGFPb3TSTgfR/CY0RfbhR+q6bu7exzc9wDB7
X-Google-Smtp-Source: AGHT+IEB33cHSVRI/iuu1X+yRxJVJR9NIGk86Yeh0R7lvSbKxZSNXYI8dLy9JSP9cw9ysowtsPI92w==
X-Received: by 2002:a05:6820:2908:b0:5fc:f3b8:78c2 with SMTP id 006d021491bc7-5feb355dff6mr3138680eaf.3.1740778648514;
        Fri, 28 Feb 2025 13:37:28 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5feaad46205sm783589eaf.36.2025.02.28.13.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 13:37:27 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v5 3/4] builtin: introduce diff-pairs command
Date: Fri, 28 Feb 2025 15:33:45 -0600
Message-ID: <20250228213346.1335224-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250228213346.1335224-1-jltobler@gmail.com>
References: <20250228002604.3859939-1-jltobler@gmail.com>
 <20250228213346.1335224-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through git-diff(1), a single diff can be generated from a pair of blob
revisions directly. Unfortunately, there is not a mechanism to compute
batches of specific file pair diffs in a single process. Such a feature
is particularly useful on the server-side where diffing between a large
set of changes is not feasible all at once due to timeout concerns.

To facilitate this, introduce git-diff-pairs(1) which acts as a backend
passing its NUL-terminated raw diff format input from stdin through diff
machinery to produce various forms of output such as patch or raw.

The raw format was originally designed as an interchange format and
represents the contents of the diff_queued_diff list making it possible
to break the diff pipeline into separate stages. For example,
git-diff-tree(1) can be used as a frontend to compute file pairs to
queue and feed its raw output to git-diff-pairs(1) to compute patches.
With this, batches of diffs can be progressively generated without
having to recompute renames or retrieve object context. Something like
the following:

	git diff-tree -r -z -M $old $new |
	git diff-pairs -p -z

should generate the same output as `git diff-tree -p -M`. Furthermore,
each line of raw diff formatted input can also be individually fed to a
separate git-diff-pairs(1) process and still produce the same output.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 .gitignore                        |   1 +
 Documentation/git-diff-pairs.adoc |  56 +++++++++
 Documentation/meson.build         |   1 +
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/diff-pairs.c              | 193 ++++++++++++++++++++++++++++++
 command-list.txt                  |   1 +
 git.c                             |   1 +
 meson.build                       |   1 +
 t/meson.build                     |   1 +
 t/t4070-diff-pairs.sh             |  81 +++++++++++++
 11 files changed, 338 insertions(+)
 create mode 100644 Documentation/git-diff-pairs.adoc
 create mode 100644 builtin/diff-pairs.c
 create mode 100755 t/t4070-diff-pairs.sh

diff --git a/.gitignore b/.gitignore
index 08a66ca508..04c444404e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -55,6 +55,7 @@
 /git-diff
 /git-diff-files
 /git-diff-index
+/git-diff-pairs
 /git-diff-tree
 /git-difftool
 /git-difftool--helper
diff --git a/Documentation/git-diff-pairs.adoc b/Documentation/git-diff-pairs.adoc
new file mode 100644
index 0000000000..e31f2e2fbb
--- /dev/null
+++ b/Documentation/git-diff-pairs.adoc
@@ -0,0 +1,56 @@
+git-diff-pairs(1)
+=================
+
+NAME
+----
+git-diff-pairs - Compare the content and mode of provided blob pairs
+
+SYNOPSIS
+--------
+[synopsis]
+git diff-pairs -z [<diff-options>]
+
+DESCRIPTION
+-----------
+Show changes for file pairs provided on stdin. Input for this command must be
+in the NUL-terminated raw output format as generated by commands such as `git
+diff-tree -z -r --raw`. By default, the outputted diffs are computed and shown
+in the patch format when stdin closes.
+
+Usage of this command enables the traditional diff pipeline to be broken up
+into separate stages where `diff-pairs` acts as the output phase. Other
+commands, such as `diff-tree`, may serve as a frontend to compute the raw
+diff format used as input.
+
+Instead of computing diffs via `git diff-tree -p -M` in one step, `diff-tree`
+can compute the file pairs and rename information without the blob diffs. This
+output can be fed to `diff-pairs` to generate the underlying blob diffs as done
+in the following example:
+
+-----------------------------
+git diff-tree -z -r -M $a $b |
+git diff-pairs -z
+-----------------------------
+
+Computing the tree diff upfront with rename information allows patch output
+from `diff-pairs` to be progressively computed over the course of potentially
+multiple invocations.
+
+Pathspecs are not currently supported by `diff-pairs`. Pathspec limiting should
+be performed by the upstream command generating the raw diffs used as input.
+
+Tree objects are not currently supported as input and are rejected.
+
+Abbreviated object IDs in the `diff-pairs` input are not supported. Outputted
+object IDs can be abbreviated using the `--abbrev` option.
+
+OPTIONS
+-------
+
+include::diff-options.adoc[]
+
+include::diff-generate-patch.adoc[]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 1129ce4c85..ce990e9fe5 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -42,6 +42,7 @@ manpages = {
   'git-diagnose.adoc' : 1,
   'git-diff-files.adoc' : 1,
   'git-diff-index.adoc' : 1,
+  'git-diff-pairs.adoc' : 1,
   'git-difftool.adoc' : 1,
   'git-diff-tree.adoc' : 1,
   'git-diff.adoc' : 1,
diff --git a/Makefile b/Makefile
index bcf5ed3f85..56df7aed3f 100644
--- a/Makefile
+++ b/Makefile
@@ -1242,6 +1242,7 @@ BUILTIN_OBJS += builtin/describe.o
 BUILTIN_OBJS += builtin/diagnose.o
 BUILTIN_OBJS += builtin/diff-files.o
 BUILTIN_OBJS += builtin/diff-index.o
+BUILTIN_OBJS += builtin/diff-pairs.o
 BUILTIN_OBJS += builtin/diff-tree.o
 BUILTIN_OBJS += builtin/diff.o
 BUILTIN_OBJS += builtin/difftool.o
diff --git a/builtin.h b/builtin.h
index 89928ccf92..e6aad3a6a1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -153,6 +153,7 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix, struct reposit
 int cmd_diff_files(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff_index(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_diff_pairs(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_difftool(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_env__helper(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
new file mode 100644
index 0000000000..6be17c1abd
--- /dev/null
+++ b/builtin/diff-pairs.c
@@ -0,0 +1,193 @@
+#include "builtin.h"
+#include "config.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "gettext.h"
+#include "hash.h"
+#include "hex.h"
+#include "object.h"
+#include "parse-options.h"
+#include "revision.h"
+#include "strbuf.h"
+
+static unsigned parse_mode_or_die(const char *mode, const char **end)
+{
+	uint16_t ret;
+
+	*end = parse_mode(mode, &ret);
+	if (!*end)
+		die(_("unable to parse mode: %s"), mode);
+	return ret;
+}
+
+static void parse_oid_or_die(const char *hex, struct object_id *oid,
+			     const char **end, const struct git_hash_algo *algop)
+{
+	if (parse_oid_hex_algop(hex, oid, end, algop) || *(*end)++ != ' ')
+		die(_("unable to parse object id: %s"), hex);
+}
+
+int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
+		   struct repository *repo)
+{
+	struct strbuf path_dst = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf meta = STRBUF_INIT;
+	struct option *parseopts;
+	struct rev_info revs;
+	int line_term = '\0';
+	int ret;
+
+	const char * const builtin_diff_pairs_usage[] = {
+		N_("git diff-pairs -z [<diff-options>]"),
+		NULL
+	};
+	struct option builtin_diff_pairs_options[] = {
+		OPT_END()
+	};
+
+	repo_init_revisions(repo, &revs, prefix);
+
+	/*
+	 * Diff options are usually parsed implicitly as part of
+	 * setup_revisions(). Explicitly handle parsing to ensure options are
+	 * printed in the usage message.
+	 */
+	parseopts = add_diff_options(builtin_diff_pairs_options, &revs.diffopt);
+	show_usage_with_options_if_asked(argc, argv, builtin_diff_pairs_usage, parseopts);
+
+	repo_config(repo, git_diff_basic_config, NULL);
+	revs.disable_stdin = 1;
+	revs.abbrev = 0;
+	revs.diff = 1;
+
+	argc = parse_options(argc, argv, prefix, parseopts, builtin_diff_pairs_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_DASHDASH);
+
+	if (setup_revisions(argc, argv, &revs, NULL) > 1)
+		usagef(_("unrecognized argument: %s"), argv[0]);
+
+	/*
+	 * With the -z option, both command input and raw output are
+	 * NUL-delimited (this mode does not affect patch output). At present
+	 * only NUL-delimited raw diff formatted input is supported.
+	 */
+	if (revs.diffopt.line_termination)
+		usage(_("working without -z is not supported"));
+
+	if (revs.prune_data.nr)
+		usage(_("pathspec arguments not supported"));
+
+	if (revs.pending.nr || revs.max_count != -1 ||
+	    revs.min_age != (timestamp_t)-1 ||
+	    revs.max_age != (timestamp_t)-1)
+		usage(_("revision arguments not allowed"));
+
+	if (!revs.diffopt.output_format)
+		revs.diffopt.output_format = DIFF_FORMAT_PATCH;
+
+	/*
+	 * If rename detection is not requested, use rename information from the
+	 * raw diff formatted input. Setting skip_resolving_statuses ensures
+	 * diffcore_std() does not mess with rename information already present
+	 * in queued filepairs.
+	 */
+	if (!revs.diffopt.detect_rename)
+		revs.diffopt.skip_resolving_statuses = 1;
+
+	while (1) {
+		struct object_id oid_a, oid_b;
+		struct diff_filepair *pair;
+		unsigned mode_a, mode_b;
+		const char *p;
+		char status;
+
+		if (strbuf_getwholeline(&meta, stdin, line_term) == EOF)
+			break;
+
+		p = meta.buf;
+		if (*p != ':')
+			die(_("invalid raw diff input"));
+		p++;
+
+		mode_a = parse_mode_or_die(p, &p);
+		mode_b = parse_mode_or_die(p, &p);
+
+		if (S_ISDIR(mode_a) || S_ISDIR(mode_b))
+			die(_("tree objects not supported"));
+
+		parse_oid_or_die(p, &oid_a, &p, repo->hash_algo);
+		parse_oid_or_die(p, &oid_b, &p, repo->hash_algo);
+
+		status = *p++;
+
+		if (strbuf_getwholeline(&path, stdin, line_term) == EOF)
+			die(_("got EOF while reading path"));
+
+		switch (status) {
+		case DIFF_STATUS_ADDED:
+			pair = diff_queue_addremove(&diff_queued_diff,
+						    &revs.diffopt, '+', mode_b,
+						    &oid_b, 1, path.buf, 0);
+			if (pair)
+				pair->status = status;
+			break;
+
+		case DIFF_STATUS_DELETED:
+			pair = diff_queue_addremove(&diff_queued_diff,
+						    &revs.diffopt, '-', mode_a,
+						    &oid_a, 1, path.buf, 0);
+			if (pair)
+				pair->status = status;
+			break;
+
+		case DIFF_STATUS_TYPE_CHANGED:
+		case DIFF_STATUS_MODIFIED:
+			pair = diff_queue_change(&diff_queued_diff, &revs.diffopt,
+						 mode_a, mode_b, &oid_a, &oid_b,
+						 1, 1, path.buf, 0, 0);
+			if (pair)
+				pair->status = status;
+			break;
+
+		case DIFF_STATUS_RENAMED:
+		case DIFF_STATUS_COPIED: {
+				struct diff_filespec *a, *b;
+				unsigned int score;
+
+				if (strbuf_getwholeline(&path_dst, stdin, line_term) == EOF)
+					die(_("got EOF while reading destination path"));
+
+				a = alloc_filespec(path.buf);
+				b = alloc_filespec(path_dst.buf);
+				fill_filespec(a, &oid_a, 1, mode_a);
+				fill_filespec(b, &oid_b, 1, mode_b);
+
+				pair = diff_queue(&diff_queued_diff, a, b);
+
+				if (strtoul_ui(p, 10, &score))
+					die(_("unable to parse rename/copy score: %s"), p);
+
+				pair->score = score * MAX_SCORE / 100;
+				pair->status = status;
+				pair->renamed_pair = 1;
+			}
+			break;
+
+		default:
+			die(_("unknown diff status: %c"), status);
+		}
+	}
+
+	diffcore_std(&revs.diffopt);
+	diff_flush(&revs.diffopt);
+	ret = diff_result_code(&revs);
+
+	strbuf_release(&path_dst);
+	strbuf_release(&path);
+	strbuf_release(&meta);
+	release_revisions(&revs);
+	FREE_AND_NULL(parseopts);
+
+	return ret;
+}
diff --git a/command-list.txt b/command-list.txt
index c537114b46..b7ade3ab9f 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -96,6 +96,7 @@ git-diagnose                            ancillaryinterrogators
 git-diff                                mainporcelain           info
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
+git-diff-pairs                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
 git-difftool                            ancillaryinterrogators          complete
 git-fast-export                         ancillarymanipulators
diff --git a/git.c b/git.c
index 450d6aaa86..77c4359522 100644
--- a/git.c
+++ b/git.c
@@ -541,6 +541,7 @@ static struct cmd_struct commands[] = {
 	{ "diff", cmd_diff, NO_PARSEOPT },
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
+	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP | NO_PARSEOPT },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
diff --git a/meson.build b/meson.build
index bf95576f83..9e8b365d2a 100644
--- a/meson.build
+++ b/meson.build
@@ -540,6 +540,7 @@ builtin_sources = [
   'builtin/diagnose.c',
   'builtin/diff-files.c',
   'builtin/diff-index.c',
+  'builtin/diff-pairs.c',
   'builtin/diff-tree.c',
   'builtin/diff.c',
   'builtin/difftool.c',
diff --git a/t/meson.build b/t/meson.build
index 780939d49f..09c7bc2fad 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -500,6 +500,7 @@ integration_tests = [
   't4067-diff-partial-clone.sh',
   't4068-diff-symmetric-merge-base.sh',
   't4069-remerge-diff.sh',
+  't4070-diff-pairs.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
new file mode 100755
index 0000000000..0878ad0ad1
--- /dev/null
+++ b/t/t4070-diff-pairs.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description='basic diff-pairs tests'
+. ./test-lib.sh
+
+# This creates a diff with added, modified, deleted, renamed, copied, and
+# typechange entries. This includes a submodule to test submodule diff support.
+test_expect_success 'setup' '
+	test_config_global protocol.file.allow always &&
+	git init sub &&
+	test_commit -C sub initial &&
+
+	git init main &&
+	cd main &&
+	echo to-be-gone >deleted &&
+	echo original >modified &&
+	echo now-a-file >symlink &&
+	test_seq 200 >two-hundred &&
+	test_seq 201 500 >five-hundred &&
+	git add . &&
+	test_tick &&
+	git commit -m base &&
+	git tag base &&
+
+	git submodule add ../sub &&
+	echo now-here >added &&
+	echo new >modified &&
+	rm deleted &&
+	mkdir subdir &&
+	echo content >subdir/file &&
+	mv two-hundred renamed &&
+	test_seq 201 500 | sed s/300/modified/ >copied &&
+	rm symlink &&
+	git add -A . &&
+	test_ln_s_add dest symlink &&
+	test_tick &&
+	git commit -m new &&
+	git tag new
+'
+
+test_expect_success 'diff-pairs recreates --raw' '
+	git diff-tree -r -M -C -C -z base new >expect &&
+	git diff-pairs --raw -z >actual <expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff-pairs can create -p output' '
+	git diff-tree -p -M -C -C base new >expect &&
+	git diff-tree -r -M -C -C -z base new |
+	git diff-pairs -p -z >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff-pairs does not support normal raw diff input' '
+	git diff-tree -r base new |
+	test_must_fail git diff-pairs >out 2>err &&
+
+	echo "usage: working without -z is not supported" >expect &&
+	test_must_be_empty out &&
+	test_cmp expect err
+'
+
+test_expect_success 'diff-pairs does not support tree objects as input' '
+	git diff-tree -z base new |
+	test_must_fail git diff-pairs -z >out 2>err &&
+
+	echo "fatal: tree objects not supported" >expect &&
+	test_must_be_empty out &&
+	test_cmp expect err
+'
+
+test_expect_success 'diff-pairs does not support pathspec arguments' '
+	git diff-tree -r -z base new |
+	test_must_fail git diff-pairs -z -- new >out 2>err &&
+
+	echo "usage: pathspec arguments not supported" >expect &&
+	test_must_be_empty out &&
+	test_cmp expect err
+'
+
+test_done
-- 
2.49.0.rc0

