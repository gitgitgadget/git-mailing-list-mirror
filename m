Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA99409619
	for <git@vger.kernel.org>; Fri, 29 May 2026 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087713; cv=none; b=sLC/HCKja/+SeFVH5TjdrvsJAwxzfDDSh2pF20flD/gaYtkMWbYCBa04GdEc+csHXJdDxA4AtNCcpCRVyQmwmfI1ybcALTHIXSHY4oXFAyPU2w+l2my5bYz5lkh9aCuP/TqZMMTKqYSC87+Yn5JASnPmV5lWkPBzXwEMqqjCgq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087713; c=relaxed/simple;
	bh=35Dd6yLBL0t8Otbw23mJL7gWw70kNKMzuhKhlBBdpH4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tkZFXSc+E33L4VF+c9quCKsJ2HhEZYtjsDoM2N/ZmRVV60UVVBMm5l+ibWSrQN+Inlsn6syUvzvyHC+hyZwbxY8ZJhKnHtATZT2sjiA3DG+YyDMeW5vCOYmHC36lzFLZ0FMMgAjgPPnriGzhGTn8MIX7T051jX4GXwLJyfvhpss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRjPyaSy; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRjPyaSy"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304ffa40c5dso436769eec.1
        for <git@vger.kernel.org>; Fri, 29 May 2026 13:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780087710; x=1780692510; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DM+H+tOPcPnUliZqY9Cqq7gGE9ndWJjMqM7xhTCBKLI=;
        b=BRjPyaSyLzmtEKWDZsu1YGv/Fir96WBDrG6CRB4PM1Gwp7oe5y35lZNWvh72m7djXR
         HPzsCh4pcsSUF/omGnG0r6W6F/FXpRPEzQb5vIm1vyCZpSmFWiW+2CHZdMfiX1FYwVB/
         doJekJlEqDSgM2grKJueBHprwtSI1S0QSgRcmvC4NFI2m83bD5MQcqbCLF8+TQibnZ+a
         oKfXpPGLVWh/JX8Ve0Ey1UR4jAj4jBj9uRbEo95G4czMFmJO4bfkRL1vGXeuLY3pgu/u
         oZaBp7/I4PfA4f/a68/L0vmtoXufonYtU/L4jwTgTpYhM226d4p8vc9zBm2mhLx6UE16
         yyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087710; x=1780692510;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DM+H+tOPcPnUliZqY9Cqq7gGE9ndWJjMqM7xhTCBKLI=;
        b=GGVpwwpe5Pp/fLwnorjfoTQcvz1/pPRqfXXLhz4z1SbomawIEGKaSrCkee56dWJHqG
         2cgCk/eCi7EAlsU+9WPleOM6ZRuybvxTqnN0XNGO8Mth8WuuuarqTBkgQKVsTCP+zvRb
         KBtyfsxLYF4AE+8UsCEgZ3won2g5XNJCCLC8SufPastizV8ZSIfBdX5+ez6AZVHxzw+a
         gkvTPYYzDE7oRYZbUe6lw+AQOh/jDi77zmHzDJ7wD8XpnK0eO8IOY2/QxuNaH8KEcWL/
         1x/OqcZMWfJN4B7BFgKyUXCH3WmvBxouMNc0QsAJeExk6cgPVGevKAiWsXEOsAX8b3OR
         ZCbQ==
X-Gm-Message-State: AOJu0Yx0vzHd9Y/IXByyamSGKi98MXV/HdrU3Sr6AcPcuFSxtvOFKCti
	XucaRvgxBNzNRAop1Ijt9b4F07+QjA89QMVyj9YrxFKdm8lj+JXnD3ys+a+dRA==
X-Gm-Gg: Acq92OEJAJ3f9EhnVyYVK80bwixydJALnzHMSpGft3P0/VP5gQkWHIjDcrrAH3C+87b
	KpfklUGqPTYakHtfQim/YgMJKxgh1AjbrSLdbUZzL6U62uIMHmGe8aFatXpx5oXeixrkDUAnIhP
	6WRZuPCiM+zoZ4AUA4b9af3UGPtVuaK3Nb+J+7VOy9IPj2HfSUptRs4hAowCbDA+OhpNV4oEa+9
	KG9sXqlAyiXfKmxKTYXmszr0b4Kc6kadp+c0h2rCrCp7KBknybzzUdOfq3V7/F26sdNsrD4GPrK
	3veAc7NOlfi7G5RPdS6Hd758jnaeIbfZ7nMT73aF1ppO7FstXe47ZNkWaqWEzNgJ38I4SFaQotR
	SOMvmSKsDIsoQKLK/A6ckuqaVgCzVZ1lxGVRTkEbSqA1R97CBFMq0N62G/cG95LZonhMdqSC9jX
	R1yhrmgfwJg8rCkGBviqo+byoYGmZf8XKZjJXzWw==
X-Received: by 2002:a05:7300:a887:b0:304:df0e:9db0 with SMTP id 5a478bee46e88-304fa4fcd06mr790630eec.15.1780087709378;
        Fri, 29 May 2026 13:48:29 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.227.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c154fsm2114193eec.3.2026.05.29.13.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:48:28 -0700 (PDT)
Message-Id: <d044fa0ee5c9cda7dfe4f663f34443103521ef43.1780087700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
	<pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 May 2026 20:48:17 +0000
Subject: [PATCH v3 4/6] diff: add long-running diff process via
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
and returns hunks that reference line numbers in the content.
When textconv is also configured, the tool receives the
textconv-transformed content.  The tool controls which lines
are marked as changed while the display shows the file content.
Patch output features (word diff, function context, color) work
normally; summary formats like --stat use their own diff path
and are not affected.

The handshake negotiates version=1 and capability=hunks.  Per-file
requests send command=hunks, pathname, and both file contents as
packetized data.  The tool responds with hunk lines and a status
packet (success, error, or abort).  On error, Git warns and falls
back to the builtin diff algorithm for that file.  On abort, Git
silently falls back for the current file and stops sending further
requests to the tool for the remainder of the session.

When the tool returns no hunks followed by status=success, Git
treats the file as having no changes and produces no diff output.
This also means --exit-code reports no changes for that file.

The subprocess is stored on the userdiff_driver struct and
launched on first use.  If the process fails to start, the
handshake fails, or a communication error occurs mid-stream,
the failure is cached on the driver to avoid retrying and
re-warning on every subsequent file.

diff_process_fill_hunks() is the sole public entry point.  It
handles driver lookup, flag checks, subprocess management, and
error reporting, returning an enum that lets callers distinguish
"hunks populated" from "files equivalent" from "not applicable"
from "tool failure."

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/config/diff.adoc   |   5 +
 Documentation/gitattributes.adoc | 139 ++++++++
 Makefile                         |   1 +
 diff-process.c                   | 288 +++++++++++++++++
 diff-process.h                   |  39 +++
 diff.c                           |  13 +
 diff.h                           |   3 +
 meson.build                      |   1 +
 t/.gitattributes                 |   1 +
 t/meson.build                    |   1 +
 t/t4080-diff-process.sh          | 538 +++++++++++++++++++++++++++++++
 userdiff.h                       |   3 +
 12 files changed, 1032 insertions(+)
 create mode 100644 diff-process.c
 create mode 100644 diff-process.h
 create mode 100755 t/t4080-diff-process.sh

diff --git a/Documentation/config/diff.adoc b/Documentation/config/diff.adoc
index 1135a62a0a..ac0635bb3b 100644
--- a/Documentation/config/diff.adoc
+++ b/Documentation/config/diff.adoc
@@ -218,6 +218,11 @@ endif::git-diff[]
 	Set this option to `true` to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
 
+`diff.<driver>.process`::
+	The command to run as a long-running diff process that
+	provides hunks to Git's diff pipeline.
+	See linkgit:gitattributes[5] for details.
+
 `diff.indentHeuristic`::
 	Set this option to `false` to disable the default heuristics
 	that shift diff hunk boundaries to make patches easier to read.
diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index f20041a323..1700bd8e97 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -821,6 +821,145 @@ NOTE: If `diff.<name>.command` is defined for path with the
 (see above), and adding `diff.<name>.algorithm` has no effect, as the
 algorithm is not passed to the external diff driver.
 
+Using an external diff process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+If `diff.<name>.process` is defined, Git sends the old and new file
+content to an external tool and receives back a list of changed
+regions (pairs of line ranges in the old and new file).  Git uses
+these instead of its builtin diff algorithm, but still controls
+all output formatting, so features like word diff, function context,
+color, and blame work normally.  This is achieved by using the
+long-running process protocol (described in
+Documentation/technical/long-running-process-protocol.adoc).
+Unlike `diff.<name>.command`, which replaces Git's output entirely,
+the diff process feeds results back into the standard pipeline.
+
+First, in `.gitattributes`, assign the `diff` attribute for paths.
+
+------------------------
+*.c diff=cdiff
+------------------------
+
+Then, define a "diff.<name>.process" configuration to specify
+the diff process command.
+
+----------------------------------------------------------------
+[diff "cdiff"]
+  process = /path/to/diff-process-tool
+----------------------------------------------------------------
+
+When Git encounters the first file that needs to be diffed, it starts
+the process and performs the handshake.  In the handshake, the welcome
+message sent by Git is "git-diff-client", only version 1 is supported,
+and the supported capability is "hunks" (the changed regions
+described below).
+
+For each file, Git sends a list of "key=value" pairs terminated with
+a flush packet, followed by the old and new file content as packetized
+data, each terminated with a flush packet.  The pathname is relative
+to the repository root.  When `diff.<name>.textconv` is also set,
+the tool receives the textconv-transformed content rather than the
+raw blob.  Git does not send binary files to the diff process.
+
+-----------------------
+packet:          git> command=hunks
+packet:          git> pathname=path/file.c
+packet:          git> 0000
+packet:          git> OLD_CONTENT
+packet:          git> 0000
+packet:          git> NEW_CONTENT
+packet:          git> 0000
+-----------------------
+
+The tool is expected to respond with zero or more hunk lines,
+a flush packet, and a status packet terminated with a flush packet.
+Each hunk line has the form:
+
+  `hunk <old_start> <old_count> <new_start> <new_count>`
+
+where `<old_start>` and `<old_count>` identify a range of lines in
+the old file, and `<new_start>` and `<new_count>` identify the
+replacement range in the new file.  Start values are 1-based and
+counts are non-negative.  Ranges must not extend beyond the end of
+the file.  For example, `hunk 3 2 3 4` means that 2 lines starting
+at line 3 in the old file were replaced by 4 lines starting at
+line 3 in the new file.  An `<old_count>` of 0 means no lines were
+removed (pure insertion); a `<new_count>` of 0 means no lines were
+added (pure deletion).
+
+Lines are delimited by newlines.  A file `"foo\nbar\n"` and a
+file `"foo\nbar"` both have 2 lines.
+
+Hunks must be listed in order and must not overlap.  Any line
+not covered by a hunk is treated as unchanged, so the total
+number of unchanged lines must be the same on both sides.
+For example, if the old file has 10 lines and the hunks cover
+4 of them (`old_count` values summing to 4), then 6 old lines
+are unchanged.  The new file must also have exactly 6 lines
+not covered by hunks, so the `new_count` values must sum to
+`new_file_lines - 6`.
+
+-----------------------
+packet:          git< hunk 1 3 1 5
+packet:          git< hunk 10 2 12 2
+packet:          git< 0000
+packet:          git< status=success
+packet:          git< 0000
+-----------------------
+
+If the tool responds with hunks and "success", Git marks those lines
+as changed and feeds them into the standard diff pipeline.  Patch
+output features (word diff, function context, color) work normally.
+Note that `--stat` and other summary formats use their own diff path
+and are not affected by the diff process.
+
+If no hunk lines precede the flush, followed by "success", Git
+treats the files as having no changes: `git diff` produces no output
+and `git blame` skips the commit, attributing lines to earlier commits.
+
+-----------------------
+packet:          git< 0000
+packet:          git< status=success
+packet:          git< 0000
+-----------------------
+
+If the tool returns invalid hunks (out of bounds, overlapping), Git
+silently falls back to the builtin diff algorithm.
+
+In case the tool cannot or does not want to process the content,
+it is expected to respond with an "error" status.  Git warns and
+falls back to the builtin diff algorithm for this file.  The tool
+remains available for subsequent files.
+
+-----------------------
+packet:          git< 0000
+packet:          git< status=error
+packet:          git< 0000
+-----------------------
+
+In case the tool cannot or does not want to process the content as
+well as any future content for the lifetime of the Git process, it
+is expected to respond with an "abort" status.  Git silently falls
+back to the builtin diff algorithm for this file and does not send
+further requests to the tool.
+
+-----------------------
+packet:          git< 0000
+packet:          git< status=abort
+packet:          git< 0000
+-----------------------
+
+If the tool dies during the communication or does not adhere to the
+protocol then Git will stop the process and fall back to the builtin
+diff algorithm.  Git warns once and does not restart the process for
+subsequent files.
+
+Tools should ignore unknown keys in the per-file request to remain
+forward-compatible.  Future versions of Git may send additional
+`command=` values; tools that receive an unrecognized command should
+respond with `status=error` rather than terminating.
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
index 0000000000..d2ef9463d7
--- /dev/null
+++ b/diff-process.c
@@ -0,0 +1,288 @@
+/*
+ * Diff process backend: communicates with a long-running external
+ * tool via the pkt-line protocol to obtain custom line-matching
+ * results.  The tool controls which lines are marked as changed
+ * while the display shows the file content (after any textconv
+ * transformation, if configured).
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
+ * When the tool returns no hunks with status=success, it considers
+ * the files equivalent.  Git will skip the diff for that file.
+ */
+
+#include "git-compat-util.h"
+#include "diff-process.h"
+#include "diff.h"
+#include "gettext.h"
+#include "repository.h"
+#include "sigchain.h"
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
+static int start_diff_process_fn(struct subprocess_entry *subprocess)
+{
+	static int versions[] = { 1, 0 };
+	static struct subprocess_capability capabilities[] = {
+		{ "hunks", CAP_HUNKS },
+		{ NULL, 0 }
+	};
+	struct diff_subprocess *entry =
+		container_of(subprocess, struct diff_subprocess, subprocess);
+
+	return subprocess_handshake(subprocess, "git-diff",
+				    versions, NULL,
+				    capabilities,
+				    &entry->supported_capabilities);
+}
+
+static struct diff_subprocess *get_or_launch_process(
+		struct userdiff_driver *drv)
+{
+	struct diff_subprocess *entry;
+
+	if (drv->diff_subprocess)
+		return drv->diff_subprocess;
+
+	entry = xcalloc(1, sizeof(*entry));
+	if (subprocess_start_command(&entry->subprocess, drv->process,
+				     start_diff_process_fn)) {
+		free(entry);
+		drv->diff_process_failed = 1;
+		return NULL;
+	}
+
+	drv->diff_subprocess = entry;
+	return entry;
+}
+
+static int send_file_content(int fd, const char *buf, long size)
+{
+	int ret = 0;
+
+	if (size < 0)
+		return -1;
+	if (size > 0)
+		ret = write_packetized_from_buf_no_flush(buf, size, fd);
+	if (ret)
+		return ret;
+	return packet_flush_gently(fd);
+}
+
+static int parse_hunk_line(const char *line, struct xdl_hunk *hunk)
+{
+	char *end;
+
+	/*
+	 * Format: "hunk <old_start> <old_count> <new_start> <new_count>"
+	 * All numbers must be non-negative decimal with no leading
+	 * whitespace or sign characters.
+	 */
+	if (!skip_prefix(line, "hunk ", &line))
+		return -1;
+
+	if (!isdigit(*line))
+		return -1;
+	errno = 0;
+	hunk->old_start = strtol(line, &end, 10);
+	if (errno || end == line || *end++ != ' ')
+		return -1;
+	line = end;
+
+	if (!isdigit(*line))
+		return -1;
+	errno = 0;
+	hunk->old_count = strtol(line, &end, 10);
+	if (errno || end == line || *end++ != ' ')
+		return -1;
+	line = end;
+
+	if (!isdigit(*line))
+		return -1;
+	errno = 0;
+	hunk->new_start = strtol(line, &end, 10);
+	if (errno || end == line || *end++ != ' ')
+		return -1;
+	line = end;
+
+	if (!isdigit(*line))
+		return -1;
+	errno = 0;
+	hunk->new_count = strtol(line, &end, 10);
+	if (errno || end == line || *end != '\0')
+		return -1;
+
+	return 0;
+}
+
+static enum diff_process_result get_hunks(
+		struct userdiff_driver *drv,
+		const char *path,
+		const char *old_buf, long old_size,
+		const char *new_buf, long new_size,
+		struct xdl_hunk **hunks_out,
+		size_t *nr_hunks_out)
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
+	backend = get_or_launch_process(drv);
+	if (!backend)
+		return DIFF_PROCESS_ERROR;
+
+	if (!(backend->supported_capabilities & CAP_HUNKS))
+		return DIFF_PROCESS_SKIP;
+
+	process = subprocess_get_child_process(&backend->subprocess);
+	fd_in = process->in;
+	fd_out = process->out;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	/* Send request */
+	if (packet_write_fmt_gently(fd_in, "command=hunks\n") ||
+	    packet_write_fmt_gently(fd_in, "pathname=%s\n", path) ||
+	    packet_flush_gently(fd_in))
+		goto comm_error;
+
+	/* Send old file content */
+	if (send_file_content(fd_in, old_buf, old_size))
+		goto comm_error;
+
+	/* Send new file content */
+	if (send_file_content(fd_in, new_buf, new_size))
+		goto comm_error;
+
+	/* Read hunks until flush packet */
+	while ((len = packet_read_line_gently(fd_out, NULL, &line)) >= 0 &&
+	       line) {
+		if (parse_hunk_line(line, &hunk) < 0)
+			goto comm_error;
+		ALLOC_GROW(hunks, nr_hunks + 1, alloc_hunks);
+		hunks[nr_hunks++] = hunk;
+	}
+	if (len < 0)
+		goto comm_error;
+
+	/* Read status */
+	if (subprocess_read_status(fd_out, &status))
+		goto comm_error;
+
+	if (!strcmp(status.buf, "success")) {
+		*hunks_out = hunks;
+		*nr_hunks_out = nr_hunks;
+		strbuf_release(&status);
+		sigchain_pop(SIGPIPE);
+		return DIFF_PROCESS_OK;
+	}
+
+	if (!strcmp(status.buf, "abort")) {
+		/*
+		 * The tool voluntarily withdrew: stop sending requests
+		 * but do not warn (this is not a failure).
+		 */
+		backend->supported_capabilities &= ~CAP_HUNKS;
+		free(hunks);
+		strbuf_release(&status);
+		sigchain_pop(SIGPIPE);
+		return DIFF_PROCESS_SKIP;
+	}
+
+	/* status=error or unknown status */
+	free(hunks);
+	strbuf_release(&status);
+	sigchain_pop(SIGPIPE);
+	return DIFF_PROCESS_ERROR;
+
+comm_error:
+	/*
+	 * Communication failure (broken pipe, malformed response).
+	 * Tear down the process and mark as failed so we do not
+	 * retry on every subsequent file.
+	 */
+	drv->diff_process_failed = 1;
+	drv->diff_subprocess = NULL;
+	subprocess_stop_command(&backend->subprocess);
+	free(backend);
+	free(hunks);
+	strbuf_release(&status);
+	sigchain_pop(SIGPIPE);
+	return DIFF_PROCESS_ERROR;
+}
+
+enum diff_process_result diff_process_fill_hunks(
+		struct diff_options *diffopt,
+		const char *path,
+		const mmfile_t *file_a,
+		const mmfile_t *file_b,
+		xpparam_t *xpp)
+{
+	struct userdiff_driver *drv;
+	struct xdl_hunk *ext_hunks = NULL;
+	size_t nr = 0;
+	enum diff_process_result res;
+
+	if (!diffopt || !path)
+		return DIFF_PROCESS_SKIP;
+	if (diffopt->flags.no_diff_process || diffopt->ignore_driver_algorithm)
+		return DIFF_PROCESS_SKIP;
+
+	drv = userdiff_find_by_path(diffopt->repo->index, path);
+	if (!drv || !drv->process)
+		return DIFF_PROCESS_SKIP;
+	if (drv->diff_process_failed)
+		return DIFF_PROCESS_SKIP;
+
+	res = get_hunks(drv, path,
+			file_a->ptr, file_a->size,
+			file_b->ptr, file_b->size,
+			&ext_hunks, &nr);
+	if (res == DIFF_PROCESS_OK) {
+		if (!nr) {
+			free(ext_hunks);
+			return DIFF_PROCESS_EQUIVALENT;
+		}
+		xpp->external_hunks = ext_hunks;
+		xpp->external_hunks_nr = nr;
+		return DIFF_PROCESS_OK;
+	}
+	if (res == DIFF_PROCESS_ERROR) {
+		warning(_("diff process '%s' failed for '%s',"
+			  " falling back to builtin diff"),
+			drv->process, path);
+		return DIFF_PROCESS_ERROR;
+	}
+	return DIFF_PROCESS_SKIP;
+}
diff --git a/diff-process.h b/diff-process.h
new file mode 100644
index 0000000000..d34b42f811
--- /dev/null
+++ b/diff-process.h
@@ -0,0 +1,39 @@
+#ifndef DIFF_PROCESS_H
+#define DIFF_PROCESS_H
+
+#include "xdiff/xdiff.h"
+
+struct diff_options;
+
+enum diff_process_result {
+	DIFF_PROCESS_ERROR = -1, /* tool failure: warned, fell back */
+	DIFF_PROCESS_OK = 0,     /* hunks populated in xpp */
+	DIFF_PROCESS_SKIP,       /* no process configured: use builtin */
+	DIFF_PROCESS_EQUIVALENT, /* tool says files are equivalent */
+};
+
+/*
+ * Consult the diff process configured for 'path' and populate
+ * xpp->external_hunks with the returned hunks.
+ *
+ * Handles driver lookup, flag checks (--no-ext-diff,
+ * --diff-algorithm), subprocess management, and error reporting.
+ *
+ * Returns DIFF_PROCESS_OK when hunks are populated in xpp.
+ * The caller owns xpp->external_hunks and must free() it.
+ *
+ * Returns DIFF_PROCESS_EQUIVALENT when the tool returns no hunks
+ * (files are considered identical); caller should skip diff/blame.
+ * Returns DIFF_PROCESS_SKIP when no process applies; caller
+ * should use the builtin diff algorithm.
+ * Returns DIFF_PROCESS_ERROR on tool failure (already warned);
+ * caller should fall back to the builtin diff algorithm.
+ */
+enum diff_process_result diff_process_fill_hunks(
+		struct diff_options *diffopt,
+		const char *path,
+		const mmfile_t *file_a,
+		const mmfile_t *file_b,
+		xpparam_t *xpp);
+
+#endif /* DIFF_PROCESS_H */
diff --git a/diff.c b/diff.c
index 397e38b41c..2d5ed6ea8c 100644
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
@@ -4031,6 +4032,17 @@ static void builtin_diff(const char *name_a,
 		xpp.ignore_regex_nr = o->ignore_regex_nr;
 		xpp.anchors = o->anchors;
 		xpp.anchors_nr = o->anchors_nr;
+
+		if (diff_process_fill_hunks(o, name_a,
+					    &mf1, &mf2, &xpp)
+		    == DIFF_PROCESS_EQUIVALENT) {
+			if (textconv_one)
+				free(mf1.ptr);
+			if (textconv_two)
+				free(mf2.ptr);
+			goto free_ab_and_return;
+		}
+
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
@@ -4111,6 +4123,7 @@ static void builtin_diff(const char *name_a,
 		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
 					 &ecbdata, &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
+		free(xpp.external_hunks);
 		if (o->word_diff)
 			free_diff_words_data(&ecbdata);
 		if (textconv_one)
diff --git a/diff.h b/diff.h
index 7eb84aadf4..d1e5a13e9e 100644
--- a/diff.h
+++ b/diff.h
@@ -173,6 +173,9 @@ struct diff_flags {
 	 */
 	unsigned allow_external;
 
+	/** Disables diff.<driver>.process. */
+	unsigned no_diff_process;
+
 	/**
 	 * For communication between the calling program and the options parser;
 	 * tell the calling program to signal the presence of difference using
diff --git a/meson.build b/meson.build
index 11488623bf..8a7370b38f 100644
--- a/meson.build
+++ b/meson.build
@@ -328,6 +328,7 @@ libgit_sources = [
   'diff-merges.c',
   'diff-lib.c',
   'diff-no-index.c',
+  'diff-process.c',
   'diff.c',
   'diffcore-break.c',
   'diffcore-delta.c',
diff --git a/t/.gitattributes b/t/.gitattributes
index 7664c6e027..de97920cab 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -23,3 +23,4 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
 /t8005/*.txt eol=lf
 /t9*/*.dump eol=lf
 /t0040*.sh whitespace=-indent-with-non-tab
+/t4080-diff-process.sh whitespace=-indent-with-non-tab
diff --git a/t/meson.build b/t/meson.build
index 7528e5cda5..f67208d7ee 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -510,6 +510,7 @@ integration_tests = [
   't4072-diff-max-depth.sh',
   't4073-diff-stat-name-width.sh',
   't4074-diff-shifted-matched-group.sh',
+  't4080-diff-process.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
new file mode 100755
index 0000000000..f159cd86d8
--- /dev/null
+++ b/t/t4080-diff-process.sh
@@ -0,0 +1,538 @@
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
+#   bad-sync    - report hunk with mismatched unchanged totals
+#   overlap     - report two overlapping hunks
+#   no-hunks   - return no hunks (files considered equivalent)
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
+	    old_first = old.split(b"\n")[0].decode(errors="replace") if old else ""
+	    new_first = new.split(b"\n")[0].decode(errors="replace") if new else ""
+	    log(f"command={cmd} pathname={pathname} old={old_first} new={new_first}")
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
+	        elif mode == "bad-sync":
+	            write_pkt("hunk 1 2 1 1")
+	        elif mode == "overlap":
+	            write_pkt("hunk 1 5 1 5")
+	            write_pkt("hunk 3 2 3 2")
+	        elif mode == "no-hunks":
+	            pass
+	        else:
+	            ol = old.count(b"\n")
+	            nl = new.count(b"\n")
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
+
+	# boundary.c: 10 lines, changes at 5-6 and 9-10.
+	# Used by: hunk boundaries, error fallback, crash, bad hunks, overlap.
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
+
+	# worddiff.c: single-line function, value changes 1 -> 999.
+	# Used by: word-diff, --diff-algorithm, --no-ext-diff, --stat.
+	cat >worddiff.c <<-\EOF &&
+	int value(void) { return 1; }
+	EOF
+	git add worddiff.c &&
+
+	# newfile.c: single-line function, value changes 42 -> 99.
+	# Used by: new file, --exit-code, multiple drivers.
+	cat >newfile.c <<-\EOF &&
+	int new_func(void) { return 42; }
+	EOF
+	git add newfile.c &&
+
+	# logtest.c: single-line function for log/format-patch tests.
+	# Needs two commits so log -1 has a diff.
+	cat >logtest.c <<-\EOF &&
+	int logfunc(void) { return 1; }
+	EOF
+	git add logtest.c &&
+
+	# two.c/one.c: two-file pair for error/abort/startup-failure tests.
+	cat >one.c <<-\EOF &&
+	int first(void) { return 1; }
+	EOF
+	cat >two.c <<-\EOF &&
+	int second(void) { return 2; }
+	EOF
+	git add one.c two.c &&
+
+	git commit -m "initial" &&
+
+	# Second commit for logtest.c (so log -1 has something to show).
+	cat >logtest.c <<-\EOF &&
+	int logfunc(void) { return 2; }
+	EOF
+	git add logtest.c &&
+	git commit -m "change logtest.c" &&
+
+	# Working tree modifications (not committed).
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
+	cat >worddiff.c <<-\EOF &&
+	int value(void) { return 999; }
+	EOF
+
+	cat >newfile.c <<-\EOF &&
+	int new_func(void) { return 99; }
+	EOF
+
+	cat >one.c <<-\EOF &&
+	int first(void) { return 10; }
+	EOF
+
+	cat >two.c <<-\EOF
+	int second(void) { return 20; }
+	EOF
+'
+
+#
+# Core behavior: the tool controls which lines are marked as changed.
+#
+
+test_expect_success PYTHON 'diff process hunk boundaries affect output' '
+	# The file has changes at lines 5-6 and 9-10, but fixed-hunk
+	# only reports lines 5-6 as changed.  Lines 9-10 should not
+	# appear as changed in the output.
+	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk" \
+		diff boundary.c >actual &&
+	test_grep "^-OLD5" actual &&
+	test_grep "^-OLD6" actual &&
+	test_grep "^+NEW5" actual &&
+	test_grep "^+NEW6" actual &&
+	test_grep ! "^-OLD9" actual &&
+	test_grep ! "^-OLD10" actual &&
+	test_grep ! "^+NEW9" actual &&
+	test_grep ! "^+NEW10" actual
+'
+
+test_expect_success PYTHON 'diff process works with new file' '
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff -- newfile.c >actual 2>stderr &&
+	test_grep "return 99" actual &&
+	test_grep "pathname=newfile.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success PYTHON 'diff process works with added file (empty old side)' '
+	cat >added.c <<-\EOF &&
+	int added(void) { return 1; }
+	EOF
+	git add added.c &&
+
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --cached -- added.c >actual 2>stderr &&
+	test_grep "added" actual &&
+	test_grep "pathname=added.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success PYTHON 'diff process skipped for binary files' '
+	printf "\\0binary" >binary.c &&
+	git add binary.c &&
+	git commit -m "add binary" &&
+	printf "\\0changed" >binary.c &&
+
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff -- binary.c >actual &&
+	test_grep "Binary files" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success PYTHON 'diff process not consulted for unmatched driver' '
+	echo "not tracked by cdiff" >unmatched.txt &&
+	git add unmatched.txt &&
+	git commit -m "add unmatched.txt" &&
+
+	echo "modified" >unmatched.txt &&
+
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff -- unmatched.txt >actual &&
+	test_grep "modified" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success PYTHON 'multiple drivers use separate processes' '
+	echo "*.h diff=hdiff" >>.gitattributes &&
+	git add .gitattributes &&
+
+	cat >multi.h <<-\EOF &&
+	int header(void) { return 1; }
+	EOF
+	git add multi.h &&
+	git commit -m "add multi.h" &&
+
+	cat >multi.h <<-\EOF &&
+	int header(void) { return 2; }
+	EOF
+
+	rm -f backend-c.log backend-h.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend-c.log" \
+	    -c diff.hdiff.process="$BACKEND --log=backend-h.log" \
+		diff -- newfile.c multi.h >actual 2>stderr &&
+	test_grep "pathname=newfile.c" backend-c.log &&
+	test_grep "pathname=multi.h" backend-h.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success PYTHON 'diff process works alongside textconv' '
+	write_script uppercase-filter <<-\EOF &&
+	tr "a-z" "A-Z" <"$1"
+	EOF
+
+	cat >textconv.c <<-\EOF &&
+	hello world
+	EOF
+	git add textconv.c &&
+	git commit -m "add textconv.c" &&
+
+	cat >textconv.c <<-\EOF &&
+	goodbye world
+	EOF
+
+	rm -f backend.log &&
+	git -c diff.cdiff.textconv="./uppercase-filter" \
+	    -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff -- textconv.c >actual 2>stderr &&
+	# The diff process receives textconv-transformed (uppercase) content.
+	test_grep "pathname=textconv.c" backend.log &&
+	test_grep "old=HELLO WORLD" backend.log &&
+	test_grep "new=GOODBYE WORLD" backend.log &&
+	test_must_be_empty stderr
+'
+
+#
+# Downstream features: word diff, log, equivalent files, exit code.
+#
+
+test_expect_success PYTHON 'diff process with --word-diff' '
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --word-diff worddiff.c >actual 2>stderr &&
+	test_grep "\[-1;-\]" actual &&
+	test_grep "{+999;+}" actual &&
+	test_grep "pathname=worddiff.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success PYTHON 'diff process works with git log -p' '
+	# With no-hunks mode, the tool says the files are equivalent,
+	# so log -p should show the commit but no diff content.
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
+		log -1 -p -- logtest.c >actual 2>stderr &&
+	test_grep "change logtest.c" actual &&
+	test_grep ! "return 2" actual &&
+	test_grep "command=hunks pathname=logtest.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success PYTHON 'diff process no hunks suppresses diff output' '
+	cat >nohunks.c <<-\EOF &&
+	int zero(void) { return 0; }
+	EOF
+	git add nohunks.c &&
+	git commit -m "add nohunks.c" &&
+
+	cat >nohunks.c <<-\EOF &&
+	int zero(void) { return 999; }
+	EOF
+
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
+		diff nohunks.c >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success PYTHON 'diff process no hunks with --exit-code returns success' '
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
+		diff --exit-code nohunks.c
+'
+
+test_expect_success PYTHON 'diff process with --exit-code and hunks returns failure' '
+	test_expect_code 1 git -c diff.cdiff.process="$BACKEND" \
+		diff --exit-code newfile.c
+'
+
+#
+# Bypass mechanisms: flags and commands that skip the diff process.
+#
+
+test_expect_success PYTHON 'diff process bypassed by --diff-algorithm' '
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --diff-algorithm=patience worddiff.c >actual &&
+	test_grep "return 999" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success PYTHON 'diff process not used by --stat' '
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --stat worddiff.c >actual &&
+	test_grep "worddiff.c" actual &&
+	test_path_is_missing backend.log
+'
+
+#
+# Error handling and fallback.
+#
+
+test_expect_success PYTHON 'diff process fallback on tool error status' '
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --mode=error --log=backend.log" \
+		diff boundary.c >actual 2>stderr &&
+	# Fallback produces the full builtin diff (both change regions).
+	test_grep "^-OLD5" actual &&
+	test_grep "^+NEW5" actual &&
+	test_grep "^-OLD9" actual &&
+	test_grep "^+NEW9" actual &&
+	# Tool was contacted (it replied with error, not crash).
+	test_grep "command=hunks pathname=boundary.c" backend.log &&
+	test_grep "diff process.*failed" stderr
+'
+
+test_expect_success PYTHON 'diff process error keeps tool available for next file' '
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --mode=error --log=backend.log" \
+		diff -- one.c two.c >actual 2>stderr &&
+	# Unlike abort, error keeps the tool available: both files
+	# are sent to the tool (and both fall back).
+	test_grep "pathname=one.c" backend.log &&
+	test_grep "pathname=two.c" backend.log &&
+	test_grep "return 10" actual &&
+	test_grep "return 20" actual
+'
+
+test_expect_success PYTHON 'diff process abort disables for session' '
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --mode=abort --log=backend.log" \
+		diff -- one.c two.c >actual &&
+	# Both files should still produce diff output via fallback.
+	test_grep "return 10" actual &&
+	test_grep "return 20" actual &&
+	# The tool aborts on the first file and git clears its
+	# capability.  The second file never contacts the tool.
+	test_grep "pathname=one.c" backend.log &&
+	test_grep ! "pathname=two.c" backend.log
+'
+
+test_expect_success PYTHON 'diff process fallback on tool crash' '
+	git -c diff.cdiff.process="$BACKEND --mode=crash" \
+		diff boundary.c >actual 2>stderr &&
+	test_grep "^-OLD5" actual &&
+	test_grep "^+NEW5" actual &&
+	test_grep "^-OLD9" actual &&
+	test_grep "^+NEW9" actual &&
+	# Crash is a communication failure, so a warning is emitted.
+	test_grep "diff process.*failed" stderr
+'
+
+test_expect_success PYTHON 'diff process startup failure only warns once' '
+	git -c diff.cdiff.process="/nonexistent/tool" \
+		diff -- one.c two.c >actual 2>stderr &&
+	# Both files produce diff output via fallback.
+	test_grep "return 10" actual &&
+	test_grep "return 20" actual &&
+	# Sentinel prevents repeated warnings: only one, not one per file.
+	test_grep "diff process.*failed" stderr >warnings &&
+	test_line_count = 1 warnings
+'
+
+test_expect_success PYTHON 'diff process fallback on bad hunks' '
+	git -c diff.cdiff.process="$BACKEND --mode=bad-hunk" \
+		diff boundary.c >actual 2>stderr &&
+	test_grep "^-OLD5" actual &&
+	test_grep "^+NEW5" actual &&
+	test_grep "^-OLD9" actual &&
+	test_grep "^+NEW9" actual &&
+	# Invalid hunks are caught by xdiff validation, not the
+	# protocol layer, so no warning is emitted.
+	test_must_be_empty stderr
+'
+
+test_expect_success PYTHON 'diff process fallback on mismatched unchanged totals' '
+	cat >synctest.c <<-\EOF &&
+	line1
+	line2
+	line3
+	EOF
+	git add synctest.c &&
+	git commit -m "add synctest.c" &&
+
+	cat >synctest.c <<-\EOF &&
+	line1
+	changed
+	line3
+	EOF
+
+	# bad-sync reports hunk 1 2 1 1: marks 2 old lines and 1 new
+	# line as changed, leaving 1 unchanged old vs 2 unchanged new.
+	# The synchronization invariant fails and git falls back.
+	git -c diff.cdiff.process="$BACKEND --mode=bad-sync" \
+		diff synctest.c >actual 2>stderr &&
+	test_grep "changed" actual
+'
+
+test_expect_success PYTHON 'diff process fallback on overlapping hunks' '
+	# boundary.c has 10 lines, so both hunks are in bounds
+	# but they overlap at lines 3-5, triggering the ordering check.
+	git -c diff.cdiff.process="$BACKEND --mode=overlap" \
+		diff boundary.c >actual 2>stderr &&
+	test_grep "NEW5" actual
+'
+
+test_done
diff --git a/userdiff.h b/userdiff.h
index 51c26e0d41..a98eabe377 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -3,6 +3,7 @@
 
 #include "notes-cache.h"
 
+struct diff_subprocess;
 struct index_state;
 struct repository;
 
@@ -33,6 +34,8 @@ struct userdiff_driver {
 	int textconv_want_cache;
 	const char *process;
 	char *process_owned;
+	struct diff_subprocess *diff_subprocess;
+	unsigned diff_process_failed : 1;
 };
 enum userdiff_driver_type {
 	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
-- 
gitgitgadget

