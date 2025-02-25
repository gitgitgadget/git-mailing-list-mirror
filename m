Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E0923A981
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526976; cv=none; b=BGQ1nEh9HfOg3zUxfcFJA6dytQjNJ9A8cRttDcyJWKHymA9m1abOvHxQsOre9eftmTzPSBlyPzcH+OPuaz1ZF9SZMH9rNmTIC4N0wrN9qrS+EHSPLnQrnfw9slAaEeQL6loovSmYhymMd+AOSS1hrrUu7+TsocBVxH1q07E8d8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526976; c=relaxed/simple;
	bh=7B9i44bSistVhySabwy6KWfftJcd7OXiezgJZ4TFRws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2ye0Oywonv8YGVM0gahGXNoFjo93fwOvNT4Z8WEsJEAEJHmfJlQqDRm8NL1rxRVNyNSKbI6j7ev2k3FI01k50p7oDptY4dnvmQuJ4UD/lVstev8TbTPJxXvnnObc+enNnzVihZGwGJSJK7/YKOsgDtvwYpOwHFPvRyDYIVldAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwzlLEf2; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwzlLEf2"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c11ddc865eso270136fac.3
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 15:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740526973; x=1741131773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGn6nf6jT0na+wUhQtCKWimm97GE+9muoJZ6n+4FfKQ=;
        b=HwzlLEf2v9m9JiXAQOWf3aOmG4ajE6HfmtEeQyipNFNgMtJQ4GTeJLr97LJIjv/Gbp
         ILL5YBYLFeIVNcMilPaB1uXGreDn1vWJf/ud/qJvpFB7+v1bUOpVJ5Ce4hcHvn3DBnSM
         NaxjbdS1wXYFDTICM6D8aweJysoTZYXng73SZJlQz8bkYA9j+c2n8qotoNWMEpxybePa
         wfdPWDs+6X/97fvyhsjQyCTjEGCGovnsIGuKtw4xz6sFWZ4niaA1AuJmuvPzZ9SDnDRT
         LNSqun1eBrWxQlfd+0bDZ89Ur0qJ30cf8w02FhSuj/vd5Hl82bdzcAFS6fQnWd1GRxdI
         4ZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740526973; x=1741131773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGn6nf6jT0na+wUhQtCKWimm97GE+9muoJZ6n+4FfKQ=;
        b=kmhSZEJLnE/mCNXUt09TeOAtqIF1D+NbOWZ2jl/YtDZK4mo14EC++eKHYToyUcXTL+
         QQOCQEe1RiM/A8b3Crlws5jJmeYdp5HxfDErprN79xG6xRZ5nR5UAW75dVdOwi8x0Zhq
         h/kUIbf4vk87m1CKEypUxfpBBufkFmd5W4z44H5QD1ABNe6MotbQ1LwAnx5lDJlByeut
         ccpUnsLyq8P31D88SEo2LA0+T1n7qjc6oOj1kyduQMfmWxDchg6V3B2m1K5OL/DzK4LJ
         YZ6gmvZzpgiZwuw2mFLDA/ZaIgY53vIzj2Ww7tcSZWmQ+dRnEbMT1KkgZ1CFg2e+Lk9u
         APzg==
X-Gm-Message-State: AOJu0YxVxkGy9168eicGI/4T/Iq9aQfm5m2EidwneUImrrjf6DCqY9PR
	DX9xCUpoG+JB0573zITyCUce6ZkfawuMLfslC02Mv8tpRPXhSqriSwGgAQoG
X-Gm-Gg: ASbGncvihVEDYTZG4Zsw6w/aMJAUpUT0Ajx5+GAdwTQl+pxBzDzIHpRB/U9XV9594Kx
	kNMDniJrys0xeOF1qpxscqEjD9tmut/gcwfTih6U4W/tvihmbreYudMHA3w3Uuhq1DB1Mx27UB7
	bcdtZ2B1FNPBZFoDhi8gTSzvF9hwFSB3GjIRWNUxaP3mKBLZX/gBoRbmQJnhozeeyqIeR2mKuLY
	xzFL6Gl2a/++asrAr2y4ly/8y2gSTlyne/9rEHyM32o9BP0tWlpAd3krSTwu7yDtQFAcsTOOBI6
	uxAp4O+6QgrrpaZgiqsbghcTlJu2brfC0w==
X-Google-Smtp-Source: AGHT+IHDRuqZXYQq+hA7VlUUOKlXGQUG+QomGYTrwVGWoPzlrHgcrnv3zw2JZfSFqWupPPuhiC2LWQ==
X-Received: by 2002:a05:6871:53ca:b0:29d:c624:7cad with SMTP id 586e51a60fabf-2c10f1c7570mr3362543fac.3.1740526972883;
        Tue, 25 Feb 2025 15:42:52 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c1113f5bc5sm609308fac.21.2025.02.25.15.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 15:42:52 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 2/3] builtin: introduce diff-pairs command
Date: Tue, 25 Feb 2025 17:39:24 -0600
Message-ID: <20250225233925.1345086-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225233925.1345086-1-jltobler@gmail.com>
References: <20250212041825.2455031-1-jltobler@gmail.com>
 <20250225233925.1345086-1-jltobler@gmail.com>
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
represents the contents of the diff_queue_diff list making it possible
to break the diff pipeline into separate stages. For example,
git-diff-tree(1) can be used as a frontend to compute file pairs to
queue and feed its raw output to git-diff-pairs(1) to compute patches.
With this, batches of diffs can be progessively generated without having
to recompute rename detection or retrieve object context. Something like
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
 t/t4070-diff-pairs.sh             |  74 ++++++++++++
 11 files changed, 331 insertions(+)
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
index 0000000000..9472b10461
--- /dev/null
+++ b/builtin/diff-pairs.c
@@ -0,0 +1,193 @@
+#include "builtin.h"
+#include "commit.h"
+#include "config.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "gettext.h"
+#include "hex.h"
+#include "object.h"
+#include "parse-options.h"
+#include "revision.h"
+#include "strbuf.h"
+
+static unsigned parse_mode_or_die(const char *mode, const char **endp)
+{
+	uint16_t ret;
+
+	*endp = parse_mode(mode, &ret);
+	if (!*endp)
+		die(_("unable to parse mode: %s"), mode);
+	return ret;
+}
+
+static void parse_oid_or_die(const char *p, struct object_id *oid,
+			     const char **endp, const struct git_hash_algo *algop)
+{
+	if (parse_oid_hex_algop(p, oid, endp, algop) || *(*endp)++ != ' ')
+		die(_("unable to parse object id: %s"), p);
+}
+
+static void flush_diff_queue(struct diff_options *options)
+{
+	/*
+	 * If rename detection is not requested, use rename information from the
+	 * raw diff formatted input. Setting found_follow ensures diffcore_std()
+	 * does not mess with rename information already present in queued
+	 * filepairs.
+	 */
+	if (!options->detect_rename)
+		options->found_follow = 1;
+	diffcore_std(options);
+	diff_flush(options);
+}
+
+int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
+		   struct repository *repo)
+{
+	struct strbuf path_dst = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf meta = STRBUF_INIT;
+	struct rev_info revs;
+	int ret;
+
+	const char * const usage[] = {
+		N_("git diff-pairs -z [<diff-options>]"),
+		NULL
+	};
+	struct option options[] = {
+		OPT_END()
+	};
+	struct option *parseopts = add_diff_options(options, &revs.diffopt);
+
+	show_usage_with_options_if_asked(argc, argv, usage, parseopts);
+
+	repo_init_revisions(repo, &revs, prefix);
+	repo_config(repo, git_diff_basic_config, NULL);
+	revs.disable_stdin = 1;
+	revs.abbrev = 0;
+	revs.diff = 1;
+
+	if (setup_revisions(argc, argv, &revs, NULL) > 1)
+		usage_with_options(usage, parseopts);
+
+	/*
+	 * With the -z option, both command input and raw output are
+	 * NUL-delimited (this mode does not effect patch output). At present
+	 * only NUL-delimited raw diff formatted input is supported.
+	 */
+	if (revs.diffopt.line_termination) {
+		error(_("working without -z is not supported"));
+		usage_with_options(usage, parseopts);
+	}
+
+	if (revs.prune_data.nr) {
+		error(_("pathspec arguments not supported"));
+		usage_with_options(usage, parseopts);
+	}
+
+	if (revs.pending.nr || revs.max_count != -1 ||
+	    revs.min_age != (timestamp_t)-1 ||
+	    revs.max_age != (timestamp_t)-1) {
+		error(_("revision arguments not allowed"));
+		usage_with_options(usage, parseopts);
+	}
+
+	if (!revs.diffopt.output_format)
+		revs.diffopt.output_format = DIFF_FORMAT_PATCH;
+
+	while (1) {
+		struct object_id oid_a, oid_b;
+		struct diff_filepair *pair;
+		unsigned mode_a, mode_b;
+		const char *p;
+		char status;
+
+		if (strbuf_getline_nul(&meta, stdin) == EOF)
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
+		if (strbuf_getline_nul(&path, stdin) == EOF)
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
+		case DIFF_STATUS_COPIED:
+			{
+				struct diff_filespec *a, *b;
+				unsigned int score;
+
+				if (strbuf_getline_nul(&path_dst, stdin) == EOF)
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
+	flush_diff_queue(&revs.diffopt);
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
index 0000000000..2f511cc9c9
--- /dev/null
+++ b/t/t4070-diff-pairs.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description='basic diff-pairs tests'
+. ./test-lib.sh
+
+# This creates a diff with added, modified, deleted, renamed, copied, and
+# typechange entries. That includes one in a subdirectory for non-recursive
+# tests, and both exact and inexact similarity scores.
+test_expect_success 'setup' '
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
+	git diff-tree -r -M -C -C -z base new |
+	git diff-pairs --raw -z >actual &&
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
+	test_must_be_empty out &&
+	grep "error: working without -z is not supported" err
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
+	test_must_be_empty out &&
+	grep "error: pathspec arguments not supported" err
+'
+
+test_done
-- 
2.48.1

