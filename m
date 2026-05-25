Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0C1C5F27
	for <git@vger.kernel.org>; Mon, 25 May 2026 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733813; cv=none; b=Z8xL+ZecL+Jf5/q1AvIreG/o9DLJNdGdJ3UKaPq05tqiC6qbUfYEEqHs7PRgMZZSqVvj//Vz5SAgt/hpZGBGHm1v7FMMZ6Vja5mgME/f0mrb8yDGvUJi4AD4qy31PVL7g6rI+SG/bH5mt1uxWCSG6KnhJgdlAXMhbI4d3tIlmp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733813; c=relaxed/simple;
	bh=TmDID6F4NFddS13Pp58dzNYdcJlsRFrzHTJoI8dFNEE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o2LadWpQcdot5Yz0Dzl2z3/72uezS6zCMzyFCXYcDO0TdZ11kJYLCVHYRqz0FBwjuNeykwy0fJqn56muwLs13gV3XZImpacPksFeecoIa4IleZUSjdde4mMMq7qcPsEhJTYiqWAjTTZruGmAn6f9+Z3fgDphr0ZaYQtBwltkFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEMEo06M; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEMEo06M"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9106ea78cd8so1553409485a.3
        for <git@vger.kernel.org>; Mon, 25 May 2026 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779733804; x=1780338604; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2P+sUKj637kQo/7dTWHYxnD1AO54VJ90e8jzngeA4cI=;
        b=WEMEo06Mx7LyY/sW4l+TPVAEnWBT6ilv+sRWZW5CXr43qShGgs1Q+tZjy0g1h3U06b
         Oj3rEkjtGFqdFmgPHnEcIa2Py9nLPVaNHSYYIAG4n3EXYnmV5bagPvtFPHY5IO+l8Fyt
         PSaw9/w9CMo7r25hmozK+m58VBGsSB1b+vB5TKLBBBAFWlniQ4/vSPFgKoC8SB0Vz24y
         4FxU2q3lJL0yvZJigo/7peREjnf7RpQ7aweMMxaTLut9lCICpEPoKlLusfms1z9yP8MP
         3dL1ca4tKH2QBJMOpGRRwRe+TJakMf55SCffyfi7onTRKJ+pFnMgBzpQnleRwn2DXd9p
         Sf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779733804; x=1780338604;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2P+sUKj637kQo/7dTWHYxnD1AO54VJ90e8jzngeA4cI=;
        b=o/3dkSDuL2LWTS7+pj+hIyvGZYhNLjarZIt6xcbkdXW7smbF4PFidrxYotpNTyuMLK
         k+B+1a6uhDHjyWl2El2bZnE3CVWB3qmGzRTJ5w4xWnDP5n919yUeglRbhcEEYuOBW94I
         knvoGdelWFzEvJHulir/Ae1HGVCSCUlptRoj2eVXWiCx5W8HzGp0vesXpPUyoKZnZPyJ
         LUzN2QuOCAVH1xb1BogZF/iQT6rwp8pFhqPg2Ap49hhpTljAq3V/ON4sNkWstSUpoUlE
         nPpe+ypM7cK89VOKqm2f7d+1CuFTlRaOmR+vurfmiQ9c0cT+pWbnFe8CcF4Boe8EXHBx
         DPdQ==
X-Gm-Message-State: AOJu0YztgYR7wvgGk3WoqeWXklRbImCWMS7FR/SUAVwj8GqnFAFmIZEP
	rFIz6cTxWibI3OlKxGOzWEHyPqo/SaKVCf1iXZlbNlvh3zScAcamVlFfkinsi0QB
X-Gm-Gg: Acq92OGt3UpLgifBJiWfuvb2Sa2rilxZnMjsCqFBEorCMpEeyqdsOhwRW6ujCTkQqSF
	WXS0ZMVgE+uTPzjhfn0D2ZLD4qsszVtkGOzXqnfHR+quSZlRPNdK4gYK9rSqFkjgMbYpfFl0jfH
	i648B06m/h9qr9gueyST2/a/tEzeUEXlqlHTvtuuc91Ki2UhsX19oGAQhcOd1DWyU8jXusnqTDU
	5KtHSPqYNBpC0zIyh05cM00T0OK6CyvRpV5itc5eTjiSZDLC7l+GKLtjm2fU/pJLWmnrYCDT6o1
	FMdXfI695hJOgvw3OWUx7Gex6dz5YFearyMv5hNd5P+cMFbSMoK68Ed2z3XTIs4uX9YGBy2RiY0
	jkHpkFLcaNbQKkY/rmRDYWXrvmDHY8n61+1egT3FMky+ePgECu5RDI0bcETlgfBdNPWlPIT2kHF
	Lwp/9rfHOnEKhucCXAFUMK/O+T+HM=
X-Received: by 2002:a05:620a:1a1c:b0:912:8fd0:4a5d with SMTP id af79cd13be357-914b49c54f3mr2345431985a.55.1779733803850;
        Mon, 25 May 2026 11:30:03 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.180.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8cc660sm1122855285a.5.2026.05.25.11.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 11:30:03 -0700 (PDT)
Message-Id: <c25647c6e571e293fc994e0620ca37709f680f8a.1779733799.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
	<pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 18:29:57 +0000
Subject: [PATCH v2 3/4] diff: add long-running diff process via
 diff.<driver>.process
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Add support for external diff processes that communicate via the
long-running process protocol (pkt-line over stdin/stdout).

A diff process is configured per userdiff driver:

    [diff "cdiff"]
        process = /path/to/diff-tool

The tool provides custom line-matching: it receives file pairs
and returns hunks that reference original line numbers.  Unlike
textconv, which transforms the displayed content, the diff
output shows the actual file while the tool controls which
lines are marked as changed.

The handshake negotiates version=1 and capability=hunks.  Per-file
requests send command=hunks, pathname, and both file contents as
packetized data.  The tool responds with hunk lines and a status
packet.  On error, git falls back to the builtin diff algorithm
with a warning.

Zero hunks with status=success means the tool considers the
files equivalent.  Git skips diff output for that file.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/config/diff.adoc   |   8 +
 Documentation/gitattributes.adoc |  40 ++++
 Makefile                         |   1 +
 diff-process.c                   | 206 +++++++++++++++++++
 diff-process.h                   |  28 +++
 diff.c                           |  23 +++
 t/.gitattributes                 |   1 +
 t/t4080-diff-process.sh          | 338 +++++++++++++++++++++++++++++++
 8 files changed, 645 insertions(+)
 create mode 100644 diff-process.c
 create mode 100644 diff-process.h
 create mode 100755 t/t4080-diff-process.sh

diff --git a/Documentation/config/diff.adoc b/Documentation/config/diff.adoc
index 1135a62a0a..4ab5f60df6 100644
--- a/Documentation/config/diff.adoc
+++ b/Documentation/config/diff.adoc
@@ -218,6 +218,14 @@ endif::git-diff[]
 	Set this option to `true` to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
 
+`diff.<driver>.process`::
+	The command to run as a long-running diff process.
+	The tool communicates via the pkt-line protocol and returns
+	hunks that are fed into Git's diff and blame pipelines.
+	If the tool returns zero hunks, the file is treated as
+	unchanged for both diff output and blame attribution.
+	See linkgit:gitattributes[5] for details.
+
 `diff.indentHeuristic`::
 	Set this option to `false` to disable the default heuristics
 	that shift diff hunk boundaries to make patches easier to read.
diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index f20041a323..962896a0b4 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -821,6 +821,46 @@ NOTE: If `diff.<name>.command` is defined for path with the
 (see above), and adding `diff.<name>.algorithm` has no effect, as the
 algorithm is not passed to the external diff driver.
 
+Using an external diff process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+An external tool can provide content-aware line matching by
+setting `diff.<name>.process` to the command that runs
+the tool.  The tool is a long-running process that communicates via
+the pkt-line protocol (described in
+Documentation/technical/long-running-process-protocol.adoc).
+
+------------------------
+*.c diff=cdiff
+------------------------
+
+----------------------------------------------------------------
+[diff "cdiff"]
+  process = /path/to/diff-process-tool
+----------------------------------------------------------------
+
+The tool receives file pairs and returns hunk descriptors indicating
+which lines changed.  Git feeds these hunks into its standard diff
+pipeline, so all output features (word diff, function context,
+color) work normally.
+
+If the tool fails or returns an error, Git silently falls back to
+the builtin diff algorithm.  If the tool returns invalid hunks
+(out of bounds, overlapping), Git also falls back silently.
+
+The handshake negotiates `version=1` and `capability=hunks`.
+Per-file requests send `command=hunks` and `pathname=<path>`,
+followed by the old and new file content as packetized data.
+The tool responds with lines of the form
+`hunk <old_start> <old_count> <new_start> <new_count>`
+(1-based line numbers), a flush packet, and `status=success`.
+
+If the tool returns zero hunks with `status=success`, Git treats
+the file as having no changes and produces no diff output.
+
+Tools should ignore unknown keys in the per-file request to
+remain forward-compatible.
+
 Defining a custom hunk-header
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/Makefile b/Makefile
index cedc234173..22900368dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1142,6 +1142,7 @@ LIB_OBJS += diff-delta.o
 LIB_OBJS += diff-merges.o
 LIB_OBJS += diff-lib.o
 LIB_OBJS += diff-no-index.o
+LIB_OBJS += diff-process.o
 LIB_OBJS += diff.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
diff --git a/diff-process.c b/diff-process.c
new file mode 100644
index 0000000000..801ac9e22e
--- /dev/null
+++ b/diff-process.c
@@ -0,0 +1,206 @@
+/*
+ * Diff process backend: communicates with a long-running external
+ * tool via the pkt-line protocol to obtain custom line-matching
+ * results.  Unlike textconv, which transforms the displayed content,
+ * hunks from a diff process reference original line numbers and
+ * the display shows the actual file content.
+ *
+ * Protocol: pkt-line over stdin/stdout, following the pattern of
+ * the long-running filter process protocol (see convert.c).
+ *
+ * Handshake:
+ *   git> git-diff-client / version=1 / flush
+ *   tool< git-diff-server / version=1 / flush
+ *   git> capability=hunks / flush
+ *   tool< capability=hunks / flush
+ *
+ * Per-file:
+ *   git> command=hunks / pathname=<path> / flush
+ *   git> <old content packetized> / flush
+ *   git> <new content packetized> / flush
+ *   tool< hunk <old_start> <old_count> <new_start> <new_count>
+ *   tool< ... / flush
+ *   tool< status=success / flush
+ *
+ * Zero hunks with status=success means the tool considers the
+ * files equivalent.  Git will skip the diff for that file.
+ */
+
+#include "git-compat-util.h"
+#include "diff-process.h"
+#include "userdiff.h"
+#include "sub-process.h"
+#include "pkt-line.h"
+#include "strbuf.h"
+#include "xdiff/xdiff.h"
+
+#define CAP_HUNKS (1u << 0)
+
+struct diff_subprocess {
+	struct subprocess_entry subprocess;
+	unsigned int supported_capabilities;
+};
+
+static int subprocess_map_initialized;
+static struct hashmap subprocess_map;
+
+static int start_diff_process_fn(struct subprocess_entry *subprocess)
+{
+	static int versions[] = { 1, 0 };
+	static struct subprocess_capability capabilities[] = {
+		{ "hunks", CAP_HUNKS },
+		{ NULL, 0 }
+	};
+	struct diff_subprocess *entry =
+		(struct diff_subprocess *)subprocess;
+
+	/* Uses dying pkt-line variant, same as convert.c filters. */
+	return subprocess_handshake(subprocess, "git-diff",
+				    versions, NULL,
+				    capabilities,
+				    &entry->supported_capabilities);
+}
+
+static struct diff_subprocess *find_or_start_process(const char *cmd)
+{
+	struct diff_subprocess *entry;
+
+	if (!subprocess_map_initialized) {
+		subprocess_map_initialized = 1;
+		hashmap_init(&subprocess_map, cmd2process_cmp, NULL, 0);
+	}
+
+	entry = (struct diff_subprocess *)
+		subprocess_find_entry(&subprocess_map, cmd);
+	if (entry)
+		return entry;
+
+	entry = xcalloc(1, sizeof(*entry));
+	if (subprocess_start(&subprocess_map, &entry->subprocess,
+			     cmd, start_diff_process_fn)) {
+		free(entry);
+		return NULL;
+	}
+
+	return entry;
+}
+
+static int send_file_content(int fd, const char *buf, long size)
+{
+	int ret;
+
+	if (size > 0)
+		ret = write_packetized_from_buf_no_flush(buf, size, fd);
+	else
+		ret = 0;
+	if (ret)
+		return ret;
+	return packet_flush_gently(fd);
+}
+
+static int parse_hunk_line(const char *line, struct xdl_hunk *hunk)
+{
+	char *end;
+
+	/* Format: "hunk <old_start> <old_count> <new_start> <new_count>" */
+	if (!skip_prefix(line, "hunk ", &line))
+		return -1;
+
+	hunk->old_start = strtol(line, &end, 10);
+	if (end == line || *end != ' ')
+		return -1;
+	line = end;
+
+	hunk->old_count = strtol(line, &end, 10);
+	if (end == line || *end != ' ')
+		return -1;
+	line = end;
+
+	hunk->new_start = strtol(line, &end, 10);
+	if (end == line || *end != ' ')
+		return -1;
+	line = end;
+
+	hunk->new_count = strtol(line, &end, 10);
+	if (end == line || *end != '\0')
+		return -1;
+
+	return 0;
+}
+
+int diff_process_get_hunks(struct userdiff_driver *drv,
+			   const char *path,
+			   const char *old_buf, long old_size,
+			   const char *new_buf, long new_size,
+			   struct xdl_hunk **hunks_out,
+			   size_t *nr_hunks_out)
+{
+	struct diff_subprocess *backend;
+	struct child_process *process;
+	int fd_in, fd_out;
+	struct strbuf status = STRBUF_INIT;
+	struct xdl_hunk *hunks = NULL;
+	struct xdl_hunk hunk;
+	size_t nr_hunks = 0, alloc_hunks = 0;
+	int len;
+	char *line;
+
+	if (!drv || !drv->process)
+		return -1;
+
+	backend = find_or_start_process(drv->process);
+	if (!backend)
+		return -1;
+
+	if (!(backend->supported_capabilities & CAP_HUNKS))
+		return -1;
+
+	process = subprocess_get_child_process(&backend->subprocess);
+	fd_in = process->in;
+	fd_out = process->out;
+
+	/* Send request */
+	if (packet_write_fmt_gently(fd_in, "command=hunks\n") ||
+	    packet_write_fmt_gently(fd_in, "pathname=%s\n", path) ||
+	    packet_flush_gently(fd_in))
+		goto error;
+
+	/* Send old file content */
+	if (send_file_content(fd_in, old_buf, old_size))
+		goto error;
+
+	/* Send new file content */
+	if (send_file_content(fd_in, new_buf, new_size))
+		goto error;
+
+	/* Read hunks until flush packet */
+	while ((len = packet_read_line_gently(fd_out, NULL, &line)) >= 0 &&
+	       line) {
+		if (parse_hunk_line(line, &hunk) < 0)
+			goto error;
+		ALLOC_GROW(hunks, nr_hunks + 1, alloc_hunks);
+		hunks[nr_hunks++] = hunk;
+	}
+	if (len < 0)
+		goto error;
+
+	/* Read status */
+	if (subprocess_read_status(fd_out, &status))
+		goto error;
+
+	if (strcmp(status.buf, "success")) {
+		if (!strcmp(status.buf, "abort"))
+			backend->supported_capabilities &= ~CAP_HUNKS;
+		goto error;
+	}
+
+	*hunks_out = hunks;
+	*nr_hunks_out = nr_hunks;
+	strbuf_release(&status);
+	return 0;
+
+error:
+	free(hunks);
+	strbuf_release(&status);
+	return -1;
+}
diff --git a/diff-process.h b/diff-process.h
new file mode 100644
index 0000000000..4c84951e02
--- /dev/null
+++ b/diff-process.h
@@ -0,0 +1,28 @@
+#ifndef DIFF_PROCESS_H
+#define DIFF_PROCESS_H
+
+struct userdiff_driver;
+struct xdl_hunk;
+
+/*
+ * Query a diff process for hunks describing the changes
+ * between old_buf and new_buf.
+ *
+ * The backend is a long-running subprocess configured via
+ * diff.<driver>.process.  It receives file content via
+ * pkt-line and returns hunks with 1-based line numbers.
+ *
+ * On success, sets *hunks_out and *nr_hunks_out to a newly allocated
+ * array (caller must free) and returns 0.
+ *
+ * On failure, returns -1.  The caller should fall back to the
+ * builtin diff algorithm.
+ */
+int diff_process_get_hunks(struct userdiff_driver *drv,
+			   const char *path,
+			   const char *old_buf, long old_size,
+			   const char *new_buf, long new_size,
+			   struct xdl_hunk **hunks_out,
+			   size_t *nr_hunks_out);
+
+#endif /* DIFF_PROCESS_H */
diff --git a/diff.c b/diff.c
index 397e38b41c..1aeb0f319e 100644
--- a/diff.c
+++ b/diff.c
@@ -25,6 +25,7 @@
 #include "utf8.h"
 #include "odb.h"
 #include "userdiff.h"
+#include "diff-process.h"
 #include "submodule.h"
 #include "hashmap.h"
 #include "mem-pool.h"
@@ -3991,6 +3992,7 @@ static void builtin_diff(const char *name_a,
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
 		struct emit_callback ecbdata;
+		struct xdl_hunk *ext_hunks = NULL;
 		unsigned ws_rule;
 		const struct userdiff_funcname *pe;
 
@@ -4031,6 +4033,26 @@ static void builtin_diff(const char *name_a,
 		xpp.ignore_regex_nr = o->ignore_regex_nr;
 		xpp.anchors = o->anchors;
 		xpp.anchors_nr = o->anchors_nr;
+
+		if (!o->ignore_driver_algorithm &&
+		    one->driver && one->driver->process) {
+			size_t ext_hunks_nr = 0;
+			if (!diff_process_get_hunks(
+				    one->driver, name_a,
+				    mf1.ptr, mf1.size,
+				    mf2.ptr, mf2.size,
+				    &ext_hunks, &ext_hunks_nr)) {
+				if (!ext_hunks_nr)
+					goto free_ab_and_return;
+				xpp.external_hunks = ext_hunks;
+				xpp.external_hunks_nr = ext_hunks_nr;
+			} else {
+				warning(_("diff process failed for '%s',"
+					  " falling back to builtin diff"),
+					name_a);
+			}
+		}
+
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
@@ -4111,6 +4133,7 @@ static void builtin_diff(const char *name_a,
 		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
 					 &ecbdata, &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
+		free(ext_hunks);
 		if (o->word_diff)
 			free_diff_words_data(&ecbdata);
 		if (textconv_one)
diff --git a/t/.gitattributes b/t/.gitattributes
index 7664c6e027..de97920cab 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -23,3 +23,4 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
 /t8005/*.txt eol=lf
 /t9*/*.dump eol=lf
 /t0040*.sh whitespace=-indent-with-non-tab
+/t4080-diff-process.sh whitespace=-indent-with-non-tab
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
new file mode 100755
index 0000000000..083e48e872
--- /dev/null
+++ b/t/t4080-diff-process.sh
@@ -0,0 +1,338 @@
+#!/bin/sh
+
+test_description='diff process via long-running process'
+
+. ./test-lib.sh
+
+if test_have_prereq PYTHON
+then
+	PYTHON_PATH=$(command -v python3) || PYTHON_PATH=$(command -v python)
+fi
+
+#
+# A single parametric diff process.
+# Usage: diff-process-backend --mode=<mode> [--log=<path>]
+#
+# Modes:
+#   whole-file  - report all lines as changed (default)
+#   fixed-hunk  - always report hunk 5 2 5 2
+#   bad-hunk    - report out-of-bounds hunk 999 1 999 1
+#   zero-hunk   - return zero hunks (files considered equivalent)
+#   error       - return status=error for every request
+#   abort       - return status=abort for every request
+#   crash       - read one request then exit without responding
+#
+setup_backend () {
+	cat >"$TRASH_DIRECTORY/diff-process-backend.py" <<-\PYEOF
+	import sys, os
+
+	def read_pkt():
+	    hdr = sys.stdin.buffer.read(4)
+	    if len(hdr) < 4: return None
+	    length = int(hdr, 16)
+	    if length == 0: return ""
+	    data = sys.stdin.buffer.read(length - 4)
+	    return data.decode().rstrip("\n")
+
+	def write_pkt(line):
+	    data = (line + "\n").encode()
+	    sys.stdout.buffer.write(f"{len(data)+4:04x}".encode() + data)
+	    sys.stdout.buffer.flush()
+
+	def write_flush():
+	    sys.stdout.buffer.write(b"0000")
+	    sys.stdout.buffer.flush()
+
+	def read_content():
+	    chunks = []
+	    while True:
+	        hdr = sys.stdin.buffer.read(4)
+	        if len(hdr) < 4: break
+	        length = int(hdr, 16)
+	        if length == 0: break
+	        chunks.append(sys.stdin.buffer.read(length - 4))
+	    return b"".join(chunks)
+
+	mode = "whole-file"
+	logfile = None
+	for arg in sys.argv[1:]:
+	    if arg.startswith("--mode="):
+	        mode = arg[7:]
+	    elif arg.startswith("--log="):
+	        logfile = open(arg[6:], "a")
+
+	def log(msg):
+	    if logfile:
+	        logfile.write(msg + "\n")
+	        logfile.flush()
+
+	# Handshake
+	assert read_pkt() == "git-diff-client"
+	assert read_pkt() == "version=1"
+	read_pkt()
+	write_pkt("git-diff-server")
+	write_pkt("version=1")
+	write_flush()
+	while True:
+	    p = read_pkt()
+	    if p == "": break
+	write_pkt("capability=hunks")
+	write_flush()
+
+	log("ready")
+
+	while True:
+	    cmd = None
+	    pathname = None
+	    while True:
+	        p = read_pkt()
+	        if p is None: sys.exit(0)
+	        if p == "": break
+	        if p.startswith("command="): cmd = p.split("=",1)[1]
+	        if p.startswith("pathname="): pathname = p.split("=",1)[1]
+	    if cmd is None: sys.exit(0)
+	    old = read_content()
+	    new = read_content()
+	    log(f"command={cmd} pathname={pathname}")
+
+	    if mode == "error":
+	        write_flush()
+	        write_pkt("status=error")
+	        write_flush()
+	        continue
+
+	    if mode == "abort":
+	        write_flush()
+	        write_pkt("status=abort")
+	        write_flush()
+	        continue
+
+	    if mode == "crash":
+	        sys.exit(1)
+
+	    if cmd == "hunks":
+	        if mode == "fixed-hunk":
+	            write_pkt("hunk 5 2 5 2")
+	        elif mode == "bad-hunk":
+	            write_pkt("hunk 999 1 999 1")
+	        elif mode == "zero-hunk":
+	            pass
+	        else:
+	            ol = len(old.split(b"\n"))
+	            nl = len(new.split(b"\n"))
+	            write_pkt(f"hunk 1 {ol} 1 {nl}")
+	        write_flush()
+	        write_pkt("status=success")
+	        write_flush()
+	    else:
+	        write_flush()
+	        write_pkt("status=error")
+	        write_flush()
+	PYEOF
+	write_script diff-process-backend <<-SHEOF
+	exec "$PYTHON_PATH" "$TRASH_DIRECTORY/diff-process-backend.py" "\$@"
+	SHEOF
+}
+
+BACKEND="./diff-process-backend"
+
+test_expect_success PYTHON 'setup' '
+	setup_backend &&
+	echo "*.c diff=cdiff" >.gitattributes &&
+	git add .gitattributes &&
+	git commit -m "initial"
+'
+
+test_expect_success PYTHON 'diff process hunk boundaries affect output' '
+	cat >boundary.c <<-\EOF &&
+	line1
+	line2
+	line3
+	line4
+	OLD5
+	OLD6
+	line7
+	line8
+	OLD9
+	OLD10
+	EOF
+	git add boundary.c &&
+	git commit -m "add boundary.c" &&
+
+	cat >boundary.c <<-\EOF &&
+	line1
+	line2
+	line3
+	line4
+	NEW5
+	NEW6
+	line7
+	line8
+	NEW9
+	NEW10
+	EOF
+
+	# The file has changes at lines 5-6 and 9-10, but fixed-hunk
+	# only reports lines 5-6 as changed.  Lines 9-10 should not
+	# appear as changed in the output.
+	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk" \
+		diff boundary.c >actual &&
+	test_grep "^-OLD5" actual &&
+	test_grep "^-OLD6" actual &&
+	test_grep "^+NEW5" actual &&
+	test_grep "^+NEW6" actual &&
+	! test_grep "^-OLD9" actual &&
+	! test_grep "^-OLD10" actual &&
+	! test_grep "^+NEW9" actual &&
+	! test_grep "^+NEW10" actual
+'
+
+test_expect_success PYTHON 'diff process fallback on tool error status' '
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --mode=error --log=backend.log" \
+		diff boundary.c >actual &&
+	# Fallback produces the full builtin diff (both change regions).
+	test_grep "^-OLD5" actual &&
+	test_grep "^+NEW5" actual &&
+	test_grep "^-OLD9" actual &&
+	test_grep "^+NEW9" actual &&
+	# Tool was contacted (it replied with error, not crash).
+	test_grep "command=hunks pathname=boundary.c" backend.log
+'
+
+test_expect_success PYTHON 'diff process fallback on bad hunks' '
+	git -c diff.cdiff.process="$BACKEND --mode=bad-hunk" \
+		diff boundary.c >actual &&
+	test_grep "^-OLD5" actual &&
+	test_grep "^+NEW5" actual &&
+	test_grep "^-OLD9" actual &&
+	test_grep "^+NEW9" actual
+'
+
+test_expect_success PYTHON 'diff process fallback on tool crash' '
+	git -c diff.cdiff.process="$BACKEND --mode=crash" \
+		diff boundary.c >actual &&
+	test_grep "^-OLD5" actual &&
+	test_grep "^+NEW5" actual &&
+	test_grep "^-OLD9" actual &&
+	test_grep "^+NEW9" actual
+'
+
+test_expect_success PYTHON 'diff process abort disables for session' '
+	cat >abort1.c <<-\EOF &&
+	int first(void) { return 1; }
+	EOF
+	cat >abort2.c <<-\EOF &&
+	int second(void) { return 2; }
+	EOF
+	git add abort1.c abort2.c &&
+	git commit -m "add abort files" &&
+
+	cat >abort1.c <<-\EOF &&
+	int first(void) { return 10; }
+	EOF
+	cat >abort2.c <<-\EOF &&
+	int second(void) { return 20; }
+	EOF
+
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --mode=abort --log=backend.log" \
+		diff -- abort1.c abort2.c >actual &&
+	# Both files should still produce diff output via fallback.
+	test_grep "return 10" actual &&
+	test_grep "return 20" actual &&
+	# The tool aborts on the first file and git clears its
+	# capability.  The second file never contacts the tool,
+	# so the log should have exactly one entry, not two.
+	test_grep "command=hunks" backend.log >matches &&
+	test_line_count = 1 matches
+'
+
+test_expect_success PYTHON 'diff process handles multiple files' '
+	cat >multi1.c <<-\EOF &&
+	int one(void) { return 1; }
+	EOF
+	cat >multi2.c <<-\EOF &&
+	int two(void) { return 2; }
+	EOF
+	git add multi1.c multi2.c &&
+	git commit -m "add multi files" &&
+
+	cat >multi1.c <<-\EOF &&
+	int one(void) { return 10; }
+	EOF
+	cat >multi2.c <<-\EOF &&
+	int two(void) { return 20; }
+	EOF
+
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff -- multi1.c multi2.c >actual &&
+	test_grep "return 10" actual &&
+	test_grep "return 20" actual &&
+	test_grep "pathname=multi1.c" backend.log &&
+	test_grep "pathname=multi2.c" backend.log
+'
+
+test_expect_success PYTHON 'diff process with --word-diff' '
+	cat >worddiff.c <<-\EOF &&
+	int value(void) { return 1; }
+	EOF
+	git add worddiff.c &&
+	git commit -m "add worddiff.c" &&
+
+	cat >worddiff.c <<-\EOF &&
+	int value(void) { return 999; }
+	EOF
+
+	git -c diff.cdiff.process="$BACKEND" \
+		diff --word-diff worddiff.c >actual &&
+	test_grep "\[-1;-\]" actual &&
+	test_grep "{+999;+}" actual
+'
+
+test_expect_success PYTHON 'diff process bypassed by --diff-algorithm' '
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --diff-algorithm=patience worddiff.c >actual &&
+	test_grep "return 999" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success PYTHON 'diff process works with git log -p' '
+	cat >logtest.c <<-\EOF &&
+	int logfunc(void) { return 1; }
+	EOF
+	git add logtest.c &&
+	git commit -m "add logtest.c" &&
+
+	cat >logtest.c <<-\EOF &&
+	int logfunc(void) { return 2; }
+	EOF
+	git add logtest.c &&
+	git commit -m "change logtest.c" &&
+
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		log -1 -p -- logtest.c >actual &&
+	test_grep "return 2" actual &&
+	test_grep "command=hunks pathname=logtest.c" backend.log
+'
+
+test_expect_success PYTHON 'diff process zero hunks suppresses diff output' '
+	cat >zerohunk.c <<-\EOF &&
+	int zero(void) { return 0; }
+	EOF
+	git add zerohunk.c &&
+	git commit -m "add zerohunk.c" &&
+
+	cat >zerohunk.c <<-\EOF &&
+	int zero(void) { return 999; }
+	EOF
+
+	git -c diff.cdiff.process="$BACKEND --mode=zero-hunk" \
+		diff zerohunk.c >actual &&
+	test_must_be_empty actual
+'
+
+test_done
-- 
gitgitgadget

