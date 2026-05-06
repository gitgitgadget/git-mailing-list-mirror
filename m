Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DFA3B7B7D
	for <git@vger.kernel.org>; Wed,  6 May 2026 22:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107422; cv=none; b=gbzez11r92cm0fbuLrw7KYaCbQdyrtHE2DPyeP2POjtEE/QyaTf87zwV7A4AMd3QhGgFF8bL0xXgK1u/cSmWpUSharfrwAwFsE+rOLPUThay8CuZXjQIvtPwH3RACWHj15BRSrJkUU0qJzThjnLbiLfBiIaIXsU0Afmu9EYDess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107422; c=relaxed/simple;
	bh=ZSVjn8Is3kusDjExTPyeEXrSkUyYtOBwsvdIZ464If0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XQ76jhyxNsqrGlZuKrjb5bFZpdW7uwJHcaLwZRfVq5vK7Cb8nWFeUZi6INirih4xrqWc6aDF66N/vU2fIzFemOGzQV4TNLgrkFO2imnzQLwU6nedlCLbBJ3iC8rh8h7GEMkqXrqq9dk8oTW251yblQLPU2QYwtPBmpcK1KT7A1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARtlvjkG; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARtlvjkG"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1309f4ee97fso390812c88.1
        for <git@vger.kernel.org>; Wed, 06 May 2026 15:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778107413; x=1778712213; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgbmVITyoH/Qv7RB8aYnkURsMgpmSxab7liiMqhPrAo=;
        b=ARtlvjkGLKUcjkfBpWByka5uMortK9JSQgu5/88uQGNgaRZNWQe8Nu/S7WaN8e3btD
         wsFif0QFTVyq9OLVtuI0PPb/aoJ58GCL44R3fD2v3/F2xMufq0LXtQmTjCb4hTQCQJDp
         IpslxEELicqs2AceAEipz8JXi77hMtbH5pFIQ0kQn+I/q909UNctiIKfWyRmYdhF+rOD
         jqou1M1lZjy7G0Q7NkdqUK+l9BhhLGg/aBgyLSLOOsC/SmClowSbw3h9Dq3eA57ITxmN
         W8W5+rSabxveVTdP7x3oFlabMXD7TLuVN0e3I/HqE/isHr11b3MUmGSupVjwLU0bkVnN
         LPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778107413; x=1778712213;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BgbmVITyoH/Qv7RB8aYnkURsMgpmSxab7liiMqhPrAo=;
        b=nT5roe0//Bv4FPQ2ykdQsYv2a0aTXLZI6YGfGHXwshy7aL8FlamN7gJhqFnc/YKrty
         v0tHtcZeJTNiLgctS3VKoj82E4V2bkst0l2816PMBsM8gPLPEbjIz4jlhjUXAr/rSxms
         f+Scvpt9fAe++/kDYs8sZJ9BumBs/32MmFWvqp63NysUn7jIC2Ll2zsmQ93id7XDt8xj
         l5nHaVAo+6cwBnsayhOvSxoroAY1XbjfYGnDfjJQ8u04qdrqzX1eSUlp8HUhk3faGUcV
         JRHjAq/exzrS02LFDC8a4iBl2duA3OHWi6S2WJ9Wp2f7GwNVo6CJ47lv+rge6CX5USpZ
         2jRQ==
X-Gm-Message-State: AOJu0YxdGaP9tubOO/GtcX9OSLJ062Vf5NL/ksNKh/iSPmPblR0pIddW
	ZmdNn6auqyTHY0B4aO+FXx8LecQtkRtNsDsm5152e5IEsCIx/VWTWEbuNoNiLw==
X-Gm-Gg: AeBDievREbOWOk6oxze8gl2POn1Ovs7/15m3p73Hvg/9E4DBdPkSR0+LDXeN6XfQ3Ih
	TfUdTNcJUcqc+diw2485YRQDkygRAfawypEk4WIljZeMDS5vGp8vOd5sECf7X2mnsqknoFCpfxx
	Szgqem3iEVfvXOpYJ0MD8YHMjBeXkkzlL/clxs6xwGZizD1KYi8Tl/ue4g1XZdT8AlAp90EcXiq
	+dX+JYxXwFyHL0lY9P5Hk8ynQFXqs8puG8RH23ZWnU+m3MjK9+4LV/+RKqefGU8w76gj2ZMYHRK
	Qx7qij5o7GKGh6yjLiwRB4+8eHnokev4/W4ic7Xv/AIinZH+U8gHakvxHP+EFueaq82/Vmc4dE8
	NvqfuXc4l3Jl8deJ1hWQYRsCfEWW8ea+ZyrWzkV0DPHodAz84uf898Ob84UB3d+yD/2NForWKKW
	U4QTzqvNIEW6XsK8JMuOJnp3wgsaef+0owZTQJ2Q==
X-Received: by 2002:a05:7022:221d:b0:130:73ed:215 with SMTP id a92af1059eb24-1319cc24f33mr2727693c88.16.1778107412576;
        Wed, 06 May 2026 15:43:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1321e00e146sm3487120c88.0.2026.05.06.15.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:43:31 -0700 (PDT)
Message-Id: <72c486312cde9a9fd2dedb60bc43c5c3e40a0d64.1778107405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
References: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 May 2026 22:43:23 +0000
Subject: [PATCH/RFC 4/5] test-tool: add a "historian" subcommand for building
 merge fixtures
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
Cc: Elijah Newren <newren@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The merge-replay tests added in a follow-up commit need a way to set
up specific topologies with full control over blob contents, parent
order, and per-side trees. Sequencing plumbing commands or driving
plain `git fast-import` from shell quickly becomes unreadable for
the kinds of scenarios that exercise non-trivial merge resolution
(textual conflicts, semantic edits outside the conflict region,
intentional limitations such as new content on one side).

Add a small `test-tool historian` subcommand that reads a tight,
shell-quoted, one-line-per-object DSL and feeds an equivalent stream
to a `git fast-import` child process. Each blob and commit is given
a logical name; the helper allocates fast-import marks on first use
and emits a lightweight tag for every commit so tests can refer to
the resulting object via `refs/tags/<name>`.

The DSL has just two directives:

  blob NAME LINE...
  commit NAME BRANCH SUBJECT [from=NAME] [merge=NAME]... [PATH=BLOB]...

A blob's content is the listed lines joined with `\n` (and a final
`\n`); a commit's tree is exactly the listed PATH=BLOB pairs (the
helper emits a `deleteall` so nothing leaks in from the implicit
parent). Token splitting is delegated to `split_cmdline()` so quoted
arguments work as in shell. Marks for parent references and file
contents go through the same `strintmap`-backed name resolver, which
keeps the helper itself trivially small: blob writing, tree
construction, commit creation and merge-base computation are all
handled by `git fast-import`.

Note that the DSL reserves the names `from` and `merge` (with a
trailing `=`) for parent specification; a tree path called `from` or
`merge` cannot be expressed via this helper. That is acceptable here
because every input is a tightly controlled test fixture and the
filenames are chosen by the test author.

The helper trusts its caller: malformed input results in a
fast-import error rather than a friendly diagnostic.

Wire the new subcommand into the Makefile and meson build, register
it in `t/helper/test-tool.{c,h}`.

Assisted-by: Claude Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                  |   1 +
 t/helper/meson.build      |   1 +
 t/helper/test-historian.c | 189 ++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c      |   1 +
 t/helper/test-tool.h      |   1 +
 5 files changed, 193 insertions(+)
 create mode 100644 t/helper/test-historian.c

diff --git a/Makefile b/Makefile
index cedc234173..b38678b484 100644
--- a/Makefile
+++ b/Makefile
@@ -832,6 +832,7 @@ TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-hexdump.o
+TEST_BUILTINS_OBJS += test-historian.o
 TEST_BUILTINS_OBJS += test-json-writer.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 675e64c010..704edd1e1f 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -29,6 +29,7 @@ test_tool_sources = [
   'test-hash.c',
   'test-hashmap.c',
   'test-hexdump.c',
+  'test-historian.c',
   'test-json-writer.c',
   'test-lazy-init-name-hash.c',
   'test-match-trees.c',
diff --git a/t/helper/test-historian.c b/t/helper/test-historian.c
new file mode 100644
index 0000000000..2250d420c0
--- /dev/null
+++ b/t/helper/test-historian.c
@@ -0,0 +1,189 @@
+/*
+ * Build a small history out of a tiny declarative input. Used by tests
+ * that need specific merge topologies without long sequences of
+ * plumbing commands or fragile shell helpers.
+ *
+ * The historian reads stdin line by line and emits an equivalent
+ * stream to a `git fast-import` child process. It also allocates marks
+ * for named objects so tests can refer to commits and blobs by name.
+ *
+ * Input directives (one per line, shell-style quoting):
+ *
+ *	blob NAME LINE1 LINE2 ...
+ *	    Each LINE becomes a content line in the blob; lines are
+ *	    joined with '\n' and the blob ends with a final '\n'. With
+ *	    no LINEs, the blob is empty.
+ *
+ *	commit NAME BRANCH SUBJECT [from=PARENT] [merge=PARENT]... [PATH=BLOB]...
+ *	    Creates a commit on refs/heads/BRANCH using the listed
+ *	    file=blob mappings as the entire tree (no inheritance from
+ *	    parents). Up to one `from=` and any number of `merge=`
+ *	    parents may be given. `from=` defaults to the current branch
+ *	    tip; if BRANCH has no tip yet, the commit becomes a root.
+ *
+ * Each `commit NAME` directive also creates a lightweight tag
+ * `refs/tags/NAME` so tests can `git rev-parse NAME`.
+ *
+ * This helper trusts its caller; malformed input results in fast-import
+ * errors. That is fine because test scripts feed it tightly controlled
+ * input.
+ */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "alias.h"
+#include "run-command.h"
+#include "setup.h"
+#include "strbuf.h"
+#include "strmap.h"
+#include "strvec.h"
+
+static int next_mark = 1;
+
+static int resolve_mark(struct strintmap *names, const char *name)
+{
+	int n = strintmap_get(names, name);
+	if (!n) {
+		n = next_mark++;
+		strintmap_set(names, name, n);
+	}
+	return n;
+}
+
+static void emit_data(FILE *out, const char *data, size_t len)
+{
+	fprintf(out, "data %"PRIuMAX"\n", (uintmax_t)len);
+	fwrite(data, 1, len, out);
+	fputc('\n', out);
+}
+
+static void emit_blob(FILE *out, struct strintmap *names,
+		      int argc, const char **argv)
+{
+	struct strbuf content = STRBUF_INIT;
+	int n = resolve_mark(names, argv[1]);
+	int i;
+
+	for (i = 2; i < argc; i++) {
+		strbuf_addstr(&content, argv[i]);
+		strbuf_addch(&content, '\n');
+	}
+
+	fprintf(out, "blob\nmark :%d\n", n);
+	emit_data(out, content.buf, content.len);
+	strbuf_release(&content);
+}
+
+static void emit_tag(FILE *out, const char *name, int mark)
+{
+	fprintf(out, "reset refs/tags/%s\nfrom :%d\n\n", name, mark);
+}
+
+static void emit_commit(FILE *out, struct strintmap *names,
+			int argc, const char **argv, int seq)
+{
+	int n = resolve_mark(names, argv[1]);
+	const char *branch = argv[2];
+	const char *subject = argv[3];
+	const char *rest;
+	int i;
+
+	fprintf(out, "commit refs/heads/%s\nmark :%d\n", branch, n);
+	fprintf(out, "author A <a@e> %d +0000\n", 1700000000 + seq);
+	fprintf(out, "committer A <a@e> %d +0000\n", 1700000000 + seq);
+	emit_data(out, subject, strlen(subject));
+
+	/*
+	 * fast-import requires `from` and `merge` to precede all file
+	 * operations; emit them first regardless of argv ordering.
+	 */
+	for (i = 4; i < argc; i++) {
+		if (skip_prefix(argv[i], "from=", &rest))
+			fprintf(out, "from :%d\n", resolve_mark(names, rest));
+		else if (skip_prefix(argv[i], "merge=", &rest))
+			fprintf(out, "merge :%d\n", resolve_mark(names, rest));
+	}
+
+	/*
+	 * The PATH=BLOB list is the entire tree; wipe whatever the
+	 * implicit parent contributed before re-applying it.
+	 */
+	fprintf(out, "deleteall\n");
+	for (i = 4; i < argc; i++) {
+		const char *eq;
+		size_t key_len;
+		char *path;
+
+		if (skip_prefix(argv[i], "from=", &rest) ||
+		    skip_prefix(argv[i], "merge=", &rest))
+			continue;
+		eq = strchr(argv[i], '=');
+		if (!eq)
+			die("bad commit spec '%s'", argv[i]);
+		key_len = eq - argv[i];
+		path = xmemdupz(argv[i], key_len);
+		fprintf(out, "M 100644 :%d %s\n",
+			resolve_mark(names, eq + 1), path);
+		free(path);
+	}
+
+	fputc('\n', out);
+	emit_tag(out, argv[1], n);
+}
+
+int cmd__historian(int argc, const char **argv UNUSED)
+{
+	struct child_process fi = CHILD_PROCESS_INIT;
+	struct strintmap names = STRINTMAP_INIT;
+	struct strbuf line = STRBUF_INIT;
+	int seq = 0;
+	int ret = 0;
+	FILE *fi_in;
+
+	if (argc != 1)
+		die("usage: test-tool historian <input");
+
+	setup_git_directory();
+
+	strvec_pushl(&fi.args, "fast-import", "--quiet", "--force", NULL);
+	fi.git_cmd = 1;
+	fi.in = -1;
+	fi.no_stdout = 1;
+	if (start_command(&fi))
+		die("failed to start git fast-import");
+	fi_in = xfdopen(fi.in, "w");
+
+	while (strbuf_getline_lf(&line, stdin) != EOF) {
+		const char **a = NULL;
+		int n;
+
+		strbuf_trim(&line);
+		if (!line.len || line.buf[0] == '#')
+			continue;
+
+		n = split_cmdline(line.buf, &a);
+		if (n < 0)
+			die("split_cmdline failed: %s",
+			    split_cmdline_strerror(n));
+
+		if (n >= 2 && !strcmp(a[0], "blob"))
+			emit_blob(fi_in, &names, n, a);
+		else if (n >= 4 && !strcmp(a[0], "commit"))
+			emit_commit(fi_in, &names, n, a, seq++);
+		else
+			die("unknown directive: %s", a[0]);
+
+		free(a);
+	}
+
+	if (fclose(fi_in))
+		die_errno("close fast-import stdin");
+	if (finish_command(&fi))
+		ret = 1;
+
+	strbuf_release(&line);
+	strintmap_clear(&names);
+	return ret;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index a7abc618b3..28bde98ce1 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -39,6 +39,7 @@ static struct test_cmd cmds[] = {
 	{ "hashmap", cmd__hashmap },
 	{ "hash-speed", cmd__hash_speed },
 	{ "hexdump", cmd__hexdump },
+	{ "historian", cmd__historian },
 	{ "json-writer", cmd__json_writer },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "match-trees", cmd__match_trees },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7f150fa1eb..78cec8594a 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -32,6 +32,7 @@ int cmd__getcwd(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
 int cmd__hexdump(int argc, const char **argv);
+int cmd__historian(int argc, const char **argv);
 int cmd__json_writer(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
-- 
gitgitgadget

