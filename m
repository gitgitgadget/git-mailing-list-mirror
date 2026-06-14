Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4A3290C7
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781463575; cv=none; b=eAeU9Y1VynRF0IZcb7gR/YWOrgOMTC7TtvHTAjJZdQlZmHzGnSXaTTcF0GQ7z20dXzysU224r2UceFMKN1hTDWsuxmlPbX4/fsmNXSPNxx7P9JakNTxXZdJsObofhH+I74vpIn55xBmDWDlmWDPTs+snbCe4RWHyfJ/FbJEIZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781463575; c=relaxed/simple;
	bh=j9jPdGFxmkhMof7uKzGYgSasvqO+5AUKsRyLhlPYi3c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Bw/eOvfV97jz8541H4Sn8xrwkAr84SYWKbMWO5ErY9tn3wGI7h2CpRTd4NsZnFkkz4EDZgyAiwhuOhqV87qw49ENBuBE4IGCD8ekYix5ar3gV9hWbtt+Rl5Td2MeKv+/qgRRXwT4XrFKOWvOO7AODPaQHCF4nZQpgkmacVTPih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/oUDgUC; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/oUDgUC"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso5993749eec.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781463571; x=1782068371; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR5hvAoV28wHnRct1dR1mHc9U3fPo64xXV1Qc+iyS78=;
        b=g/oUDgUCiQU9/3pDU3ojIFmbGbOjnzTru3buOGdNAaMHOPxia+1a1+eFbdGQRuyhnn
         gGbKCMzZwcud7oAMFQddPs6kjmL3VENLpcCwjdlnn2iyZMRPUTAXSwnR15nHIqqCRKkq
         ftF7h64HbfqGk4i/TNDFW5EoHeMxZj1iki9P84T5JpDZVbN96hOYmN+OSIgDVKF7V2cU
         oLfJSS8TlEsyo9klbsxY2JWz9F4an+mgXi4wvDbQC/AY+lpTCaz+d9obGZnFfHzcB4/z
         8ouzQFqwQDfooRO2Qrs4MkogQVU19lPyzicC3dNoc5vS5+vXrmOHSBBqEOPG+gSnxXu7
         1g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781463571; x=1782068371;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sR5hvAoV28wHnRct1dR1mHc9U3fPo64xXV1Qc+iyS78=;
        b=BovwbhtZ4zX+iFenmHZotq62cf2J1lvsTI5POzt/DjuhRUPPGXklepk+KA9/LRUdT6
         n9PCE4MUCeuVCeQapDARM2yILQ+IAH8o6Ba7YSM2lSGTpYQd+M9orImR2cn3/zMdQAqu
         O+1Yd6ka+zOjXSbAgbMuLA+mPcaoe4p6cRgML2ZddAl/hAyDj1iEKrOD7AbFvbv349Eq
         +M6+kOJ0YE2D4iY45g7+goGFVpfoffcTtd8OGE04WqyEZBubc9kBmLs/KTDCqYtfG2W+
         BnZ/wwYLkBzORg/N9rFf567YVeHTTzVYnhUpvIWYvROrG6u6u/xpxYXS6ahAsNR9GokX
         uKoA==
X-Gm-Message-State: AOJu0YwfYkvxQeJIiEDjJgtyqZ40/eFO7lYefohjrf3AmTm/p7XduOKk
	HUjoqonaf0v6oTHRz4NvSO6hZJpqJzbdgKe6aSDOQyuF98mE0L3zFEYifzAAYw==
X-Gm-Gg: Acq92OFIoDc27ItsAC5GcexAZKKdisITSnczXFC9lr4sQWeWbbDA5/mapCOzJ7plXy9
	kdMN23CSrJsmXFpnyJs6tkFa+yiWQqH5Vrnp468BG+r6224SJKCPWHPqe/EFVPro5uMTXWo2TNl
	NuvVNcwgljr/s5no/xYHhyY1byAyRUp7rZBRFyb6m9cEmQqcsxjHawD9xqJIpBeG3BozMEY7hn2
	OpbvHidneH4NKuje3bXcaEJcvx6s6PrvYzCiT9rA87rO4IaPzzhVNJ0YLGUUkLe5w8gbz/EjSe6
	y9dCaGSC/FNF50GwTX05MYrVB1rW2a5VAIN84ojB+xQkuOKfwxu044E0Sp1MAR0oqJ51I88jr/o
	ms80Nz5Z244smTYCoaElDJyUaqPRGx9udNZwFxCcRsNOsp/Za3s+Wr6kHtIEnQFXO6mAUapvoJ1
	cVz6dAbUskdSQKwntJkzm+PYTX
X-Received: by 2002:a05:7301:100b:b0:304:df0e:9db2 with SMTP id 5a478bee46e88-308200b623emr6249020eec.24.1781463571060;
        Sun, 14 Jun 2026 11:59:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb8f8b2sm11894203eec.27.2026.06.14.11.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 11:59:30 -0700 (PDT)
Message-Id: <10b3980f5913dd70d52bd4009494e93b658762a9.1781463564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
References: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
	<pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 18:59:21 +0000
Subject: [PATCH v4 4/6] diff: add long-running diff process via
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>,
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
normally; --stat uses its own diff codepath and never consults
the diff process.

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

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/config/diff.adoc       |   5 +
 Documentation/gitattributes.adoc     | 143 +++++++++
 Makefile                             |   2 +
 diff-process.c                       | 297 ++++++++++++++++++
 diff-process.h                       |  39 +++
 diff.c                               |  13 +
 diff.h                               |   3 +
 meson.build                          |   1 +
 t/helper/meson.build                 |   1 +
 t/helper/test-diff-process-backend.c | 299 ++++++++++++++++++
 t/helper/test-tool.c                 |   1 +
 t/helper/test-tool.h                 |   1 +
 t/meson.build                        |   1 +
 t/t4080-diff-process.sh              | 432 +++++++++++++++++++++++++++
 userdiff.h                           |   3 +
 15 files changed, 1241 insertions(+)
 create mode 100644 diff-process.c
 create mode 100644 diff-process.h
 create mode 100644 t/helper/test-diff-process-backend.c
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
index bd76167a45..49ed11d069 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -821,6 +821,149 @@ NOTE: If `diff.<name>.command` is defined for path with the
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
+added (pure deletion).  A start value of 0 is accepted when
+the corresponding count is 0 (e.g., `hunk 0 0 1 5` for a newly
+added file), matching what `git diff` itself emits for empty
+file sides.
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
+If the tool returns invalid hunks (out of bounds, overlapping, or
+mismatched unchanged line counts), Git warns and falls back to the
+builtin diff algorithm.
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
index 0976a69b4c..5de4718b24 100644
--- a/Makefile
+++ b/Makefile
@@ -811,6 +811,7 @@ TEST_BUILTINS_OBJS += test-csprng.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delete-gpgsig.o
 TEST_BUILTINS_OBJS += test-delta.o
+TEST_BUILTINS_OBJS += test-diff-process-backend.o
 TEST_BUILTINS_OBJS += test-dir-iterator.o
 TEST_BUILTINS_OBJS += test-drop-caches.o
 TEST_BUILTINS_OBJS += test-dump-cache-tree.o
@@ -1140,6 +1141,7 @@ LIB_OBJS += diff-delta.o
 LIB_OBJS += diff-merges.o
 LIB_OBJS += diff-lib.o
 LIB_OBJS += diff-no-index.o
+LIB_OBJS += diff-process.o
 LIB_OBJS += diff.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
diff --git a/diff-process.c b/diff-process.c
new file mode 100644
index 0000000000..fec63cf233
--- /dev/null
+++ b/diff-process.c
@@ -0,0 +1,297 @@
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
+	/*
+	 * git diff emits start=0 when count=0 (empty file side).
+	 * Normalize to 1-based so downstream validation can assume start >= 1.
+	 */
+	if (!hunk->old_count && !hunk->old_start)
+		hunk->old_start = 1;
+	if (!hunk->new_count && !hunk->new_start)
+		hunk->new_start = 1;
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
index 5a584fa1d5..3d97a188b9 100644
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
@@ -4054,6 +4055,17 @@ static void builtin_diff(const char *name_a,
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
@@ -4134,6 +4146,7 @@ static void builtin_diff(const char *name_a,
 		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
 					 &ecbdata, &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
+		free(xpp.external_hunks);
 		if (o->word_diff)
 			free_diff_words_data(&ecbdata);
 		if (textconv_one)
diff --git a/diff.h b/diff.h
index bb5cddaf34..7dc157968d 100644
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
index 3247697f74..aa532f5200 100644
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
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 3235f10ab8..6abcda4afb 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -12,6 +12,7 @@ test_tool_sources = [
   'test-date.c',
   'test-delete-gpgsig.c',
   'test-delta.c',
+  'test-diff-process-backend.c',
   'test-dir-iterator.c',
   'test-drop-caches.c',
   'test-dump-cache-tree.c',
diff --git a/t/helper/test-diff-process-backend.c b/t/helper/test-diff-process-backend.c
new file mode 100644
index 0000000000..ad392694e6
--- /dev/null
+++ b/t/helper/test-diff-process-backend.c
@@ -0,0 +1,299 @@
+/*
+ * Test backend for the long-running diff process protocol
+ * (see diff-process.c and Documentation/gitattributes.adoc).
+ *
+ * Usage: test-tool diff-process-backend --mode=<mode> [--log=<path>]
+ *
+ * Implements the server side of the pkt-line handshake and a per-file
+ * response loop.  The --mode= switch selects the response shape
+ * (success, error, abort, crash, malformed hunks).
+ *
+ * Per-file request from Git:
+ *
+ *   packet:          git> command=hunks
+ *   packet:          git> pathname=<path>
+ *   packet:          git> 0000
+ *   packet:          git> OLD_CONTENT
+ *   packet:          git> 0000
+ *   packet:          git> NEW_CONTENT
+ *   packet:          git> 0000
+ *
+ * Response varies by --mode (default: whole-file):
+ *
+ *   whole-file   packet: git< hunk 1 <old_lines> 1 <new_lines>
+ *   fixed-hunk   packet: git< hunk 5 2 5 2
+ *   no-hunks     (no hunk packets)
+ *   bad-hunk     packet: git< hunk 999 1 999 1
+ *   bad-parse    packet: git< garbage not a hunk
+ *   bad-sync     packet: git< hunk 1 2 1 1
+ *   overlap      packet: git< hunk 1 5 1 5
+ *                packet: git< hunk 3 2 3 2
+ *   no-cap       (omits capability=hunks during handshake)
+ *   error        (status=error instead of status=success)
+ *   abort        (status=abort instead of status=success)
+ *   crash        exit(1) before sending any response
+ *
+ * All non-error/abort modes end with:
+ *
+ *   packet:          git< 0000
+ *   packet:          git< status=success
+ *   packet:          git< 0000
+ *
+ * Each request is logged to --log as:
+ *
+ *   command=<cmd> pathname=<path> old=<first line> new=<first line>
+ */
+
+#include "test-tool.h"
+#include "pkt-line.h"
+#include "parse-options.h"
+#include "strbuf.h"
+
+static FILE *logfile;
+
+enum mode {
+	MODE_WHOLE_FILE,
+	MODE_FIXED_HUNK,
+	MODE_NO_HUNKS,
+	MODE_BAD_HUNK,
+	MODE_BAD_PARSE,
+	MODE_BAD_SYNC,
+	MODE_OVERLAP,
+	MODE_NO_CAP,
+	MODE_ERROR,
+	MODE_ABORT,
+	MODE_CRASH,
+};
+
+static enum mode parse_mode(const char *s)
+{
+	if (!strcmp(s, "whole-file"))
+		return MODE_WHOLE_FILE;
+	if (!strcmp(s, "fixed-hunk"))
+		return MODE_FIXED_HUNK;
+	if (!strcmp(s, "no-hunks"))
+		return MODE_NO_HUNKS;
+	if (!strcmp(s, "bad-hunk"))
+		return MODE_BAD_HUNK;
+	if (!strcmp(s, "bad-parse"))
+		return MODE_BAD_PARSE;
+	if (!strcmp(s, "bad-sync"))
+		return MODE_BAD_SYNC;
+	if (!strcmp(s, "overlap"))
+		return MODE_OVERLAP;
+	if (!strcmp(s, "no-cap"))
+		return MODE_NO_CAP;
+	if (!strcmp(s, "error"))
+		return MODE_ERROR;
+	if (!strcmp(s, "abort"))
+		return MODE_ABORT;
+	if (!strcmp(s, "crash"))
+		return MODE_CRASH;
+	die("unknown --mode=%s", s);
+}
+
+/*
+ * Read "key=value" packets up to a flush, capturing "command" and
+ * "pathname".  Returns 1 if a request was read, 0 on EOF.
+ *
+ * The first packet uses the gentle variant so that a clean shutdown
+ * by Git (EOF) does not produce a spurious "the remote end hung up
+ * unexpectedly" on stderr.  Subsequent packets use the non-gentle
+ * variant: once inside a request, truncation is a protocol violation
+ * and dying loudly is the correct response.
+ */
+static int read_request_header(char **command, char **pathname)
+{
+	int first = 1;
+	char *line;
+
+	*command = *pathname = NULL;
+	for (;;) {
+		const char *value;
+
+		if (first) {
+			if (packet_read_line_gently(0, NULL, &line) < 0)
+				return 0;
+			first = 0;
+		} else {
+			line = packet_read_line(0, NULL);
+		}
+		if (!line)
+			break;
+		if (skip_prefix(line, "command=", &value))
+			*command = xstrdup(value);
+		else if (skip_prefix(line, "pathname=", &value))
+			*pathname = xstrdup(value);
+	}
+	return 1;
+}
+
+static size_t count_lines(const struct strbuf *buf)
+{
+	size_t lines = 0;
+
+	for (size_t i = 0; i < buf->len; i++)
+		if (buf->buf[i] == '\n')
+			lines++;
+
+	return lines + (buf->len > 0 && buf->buf[buf->len - 1] != '\n');
+}
+
+static void send_status(const char *status)
+{
+	packet_flush(1);
+	packet_write_fmt(1, "%s\n", status);
+	packet_flush(1);
+}
+
+static void respond(enum mode mode,
+		    const struct strbuf *old_buf,
+		    const struct strbuf *new_buf)
+{
+	switch (mode) {
+	case MODE_ERROR:
+		send_status("status=error");
+		return;
+	case MODE_ABORT:
+		send_status("status=abort");
+		return;
+	case MODE_CRASH:
+		exit(1);
+	case MODE_FIXED_HUNK:
+		packet_write_fmt(1, "hunk 5 2 5 2\n");
+		break;
+	case MODE_BAD_HUNK:
+		packet_write_fmt(1, "hunk 999 1 999 1\n");
+		break;
+	case MODE_BAD_PARSE:
+		packet_write_fmt(1, "garbage not a hunk\n");
+		break;
+	case MODE_BAD_SYNC:
+		packet_write_fmt(1, "hunk 1 2 1 1\n");
+		break;
+	case MODE_OVERLAP:
+		packet_write_fmt(1, "hunk 1 5 1 5\n");
+		packet_write_fmt(1, "hunk 3 2 3 2\n");
+		break;
+	case MODE_NO_HUNKS:
+		break;
+	case MODE_NO_CAP:
+	case MODE_WHOLE_FILE: {
+		size_t old_lines = count_lines(old_buf);
+		size_t new_lines = count_lines(new_buf);
+		/*
+		 * Match git diff output: start=0 when count=0
+		 * (empty file side), 1 otherwise.
+		 */
+		packet_write_fmt(1, "hunk %"PRIuMAX" %"PRIuMAX
+				 " %"PRIuMAX" %"PRIuMAX"\n",
+				 (uintmax_t)(old_lines ? 1 : 0),
+				 (uintmax_t)old_lines,
+				 (uintmax_t)(new_lines ? 1 : 0),
+				 (uintmax_t)new_lines);
+		break;
+	}
+	}
+	send_status("status=success");
+}
+
+static void command_loop(enum mode mode)
+{
+	for (;;) {
+		char *command = NULL, *pathname = NULL;
+		struct strbuf obuf = STRBUF_INIT;
+		struct strbuf nbuf = STRBUF_INIT;
+
+		if (!read_request_header(&command, &pathname))
+			break; /* EOF: Git closed its end */
+
+		read_packetized_to_strbuf(0, &obuf, 0);
+		read_packetized_to_strbuf(0, &nbuf, 0);
+
+		if (logfile) {
+			fprintf(logfile,
+				"command=%s pathname=%s old=%.*s new=%.*s\n",
+				command ? command : "(none)",
+				pathname ? pathname : "(none)",
+				(int)(strchrnul(obuf.buf, '\n') - obuf.buf),
+				obuf.buf,
+				(int)(strchrnul(nbuf.buf, '\n') - nbuf.buf),
+				nbuf.buf);
+			fflush(logfile);
+		}
+
+		respond(mode, &obuf, &nbuf);
+
+		free(command);
+		free(pathname);
+		strbuf_release(&obuf);
+		strbuf_release(&nbuf);
+	}
+}
+
+static void handshake(enum mode mode)
+{
+	char *line;
+
+	line = packet_read_line(0, NULL);
+	if (!line || strcmp(line, "git-diff-client"))
+		die("bad welcome: '%s'", line ? line : "(eof)");
+	line = packet_read_line(0, NULL);
+	if (!line || strcmp(line, "version=1"))
+		die("bad version: '%s'", line ? line : "(eof)");
+	if (packet_read_line(0, NULL))
+		die("expected flush after version");
+
+	packet_write_fmt(1, "git-diff-server\n");
+	packet_write_fmt(1, "version=1\n");
+	packet_flush(1);
+
+	/* Drain capabilities advertised by Git */
+	while ((line = packet_read_line(0, NULL)))
+		; /* drain */
+
+	/* Respond with our capabilities (or none for no-cap mode) */
+	if (mode != MODE_NO_CAP)
+		packet_write_fmt(1, "capability=hunks\n");
+	packet_flush(1);
+}
+
+static const char *const usage_str[] = {
+	"test-tool diff-process-backend --mode=<mode> [--log=<path>]",
+	NULL
+};
+
+int cmd__diff_process_backend(int argc, const char **argv)
+{
+	const char *mode_str = NULL, *log_path = NULL;
+	enum mode mode = MODE_WHOLE_FILE;
+	struct option options[] = {
+		OPT_STRING(0, "mode", &mode_str, "mode",
+			   "response shape: whole-file (default), fixed-hunk,"
+			   " no-hunks, bad-hunk, bad-sync, overlap, error,"
+			   " abort, crash"),
+		OPT_STRING(0, "log", &log_path, "path",
+			   "append per-request summary to this file"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options, usage_str, 0);
+	if (argc)
+		usage_with_options(usage_str, options);
+
+	if (mode_str)
+		mode = parse_mode(mode_str);
+
+	if (log_path) {
+		logfile = fopen(log_path, "a");
+		if (!logfile)
+			die_errno("failed to open log '%s'", log_path);
+	}
+
+	handshake(mode);
+	command_loop(mode);
+
+	if (logfile && fclose(logfile))
+		die_errno("error closing log");
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b71a22b43b..3c3f95269c 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -22,6 +22,7 @@ static struct test_cmd cmds[] = {
 	{ "date", cmd__date },
 	{ "delete-gpgsig", cmd__delete_gpgsig },
 	{ "delta", cmd__delta },
+	{ "diff-process-backend", cmd__diff_process_backend },
 	{ "dir-iterator", cmd__dir_iterator },
 	{ "drop-caches", cmd__drop_caches },
 	{ "dump-cache-tree", cmd__dump_cache_tree },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f2885b33d5..a5bb755516 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -15,6 +15,7 @@ int cmd__csprng(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
 int cmd__delete_gpgsig(int argc, const char **argv);
+int cmd__diff_process_backend(int argc, const char **argv);
 int cmd__dir_iterator(int argc, const char **argv);
 int cmd__drop_caches(int argc, const char **argv);
 int cmd__dump_cache_tree(int argc, const char **argv);
diff --git a/t/meson.build b/t/meson.build
index c5832fee05..027855ced7 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -512,6 +512,7 @@ integration_tests = [
   't4072-diff-max-depth.sh',
   't4073-diff-stat-name-width.sh',
   't4074-diff-shifted-matched-group.sh',
+  't4080-diff-process.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
new file mode 100755
index 0000000000..9bb579b564
--- /dev/null
+++ b/t/t4080-diff-process.sh
@@ -0,0 +1,432 @@
+#!/bin/sh
+
+test_description='diff process via long-running process'
+
+. ./test-lib.sh
+
+# See t/helper/test-diff-process-backend.c for the backend implementation
+# and available --mode= options.
+
+BACKEND="test-tool diff-process-backend"
+
+test_expect_success 'setup' '
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
+	# Used by: modified file, --exit-code, multiple drivers.
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
+test_expect_success 'diff process hunk boundaries affect output' '
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
+test_expect_success 'diff process works with modified file' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff -- newfile.c >actual 2>stderr &&
+	test_grep "return 99" actual &&
+	test_grep "pathname=newfile.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process works with added file (empty old side)' '
+	cat >added.c <<-\EOF &&
+	int added(void) { return 1; }
+	EOF
+	git add added.c &&
+
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --cached -- added.c >actual 2>stderr &&
+	test_grep "added" actual &&
+	test_grep "pathname=added.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process works with deleted file (empty new side)' '
+	git add added.c &&
+	git commit -m "commit added.c" &&
+	git rm added.c &&
+
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --cached -- added.c >actual 2>stderr &&
+	test_grep "deleted file" actual &&
+	test_grep "pathname=added.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process skipped for binary files' '
+	printf "\\0binary" >binary.c &&
+	git add binary.c &&
+	git commit -m "add binary" &&
+	printf "\\0changed" >binary.c &&
+
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff -- binary.c >actual &&
+	test_grep "Binary files" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'diff process not consulted for unmatched driver' '
+	echo "not tracked by cdiff" >unmatched.txt &&
+	git add unmatched.txt &&
+	git commit -m "add unmatched.txt" &&
+
+	echo "modified" >unmatched.txt &&
+
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff -- unmatched.txt >actual &&
+	test_grep "modified" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'multiple drivers use separate processes' '
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
+	test_when_finished "rm -f backend-c.log backend-h.log" &&
+	git -c diff.cdiff.process="$BACKEND --log=backend-c.log" \
+	    -c diff.hdiff.process="$BACKEND --log=backend-h.log" \
+		diff -- newfile.c multi.h >actual 2>stderr &&
+	test_grep "pathname=newfile.c" backend-c.log &&
+	test_grep "pathname=multi.h" backend-h.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process works alongside textconv' '
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
+	test_when_finished "rm -f backend.log" &&
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
+test_expect_success 'diff process with --word-diff' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --word-diff worddiff.c >actual 2>stderr &&
+	test_grep "\[-1;-\]" actual &&
+	test_grep "{+999;+}" actual &&
+	test_grep "pathname=worddiff.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process works with git log -p' '
+	# With no-hunks mode, the tool says the files are equivalent,
+	# so log -p should show the commit but no diff content.
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
+		log -1 -p -- logtest.c >actual 2>stderr &&
+	test_grep "change logtest.c" actual &&
+	test_grep ! "return 2" actual &&
+	test_grep "command=hunks pathname=logtest.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process no hunks suppresses diff output' '
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
+test_expect_success 'diff process no hunks with --exit-code returns success' '
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
+		diff --exit-code nohunks.c
+'
+
+test_expect_success 'diff process with --exit-code and hunks returns failure' '
+	test_expect_code 1 git -c diff.cdiff.process="$BACKEND" \
+		diff --exit-code newfile.c
+'
+
+#
+# Bypass mechanisms: flags and commands that skip the diff process.
+#
+
+test_expect_success 'diff process bypassed by --diff-algorithm' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --diff-algorithm=patience worddiff.c >actual &&
+	test_grep "return 999" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'diff process not used by --stat' '
+	test_when_finished "rm -f backend.log" &&
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
+test_expect_success 'diff process fallback on tool error status' '
+	test_when_finished "rm -f backend.log" &&
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
+test_expect_success 'diff process error keeps tool available for next file' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=error --log=backend.log" \
+		diff -- one.c two.c >actual 2>stderr &&
+	# Unlike abort, error keeps the tool available: both files
+	# are sent to the tool (and both fall back).
+	test_grep "pathname=one.c" backend.log &&
+	test_grep "pathname=two.c" backend.log &&
+	test_grep "return 10" actual &&
+	test_grep "return 20" actual &&
+	test_grep "diff process.*failed" stderr
+'
+
+test_expect_success 'diff process abort disables for session' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=abort --log=backend.log" \
+		diff -- one.c two.c >actual 2>stderr &&
+	# Both files should still produce diff output via fallback.
+	test_grep "return 10" actual &&
+	test_grep "return 20" actual &&
+	# The tool aborts on the first file and git clears its
+	# capability.  The second file never contacts the tool.
+	test_grep "pathname=one.c" backend.log &&
+	test_grep ! "pathname=two.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process fallback on tool crash' '
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
+test_expect_success 'diff process startup failure only warns once' '
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
+
+test_expect_success 'diff process fallback on bad hunks' '
+	git -c diff.cdiff.process="$BACKEND --mode=bad-hunk" \
+		diff boundary.c >actual 2>stderr &&
+	test_grep "^-OLD5" actual &&
+	test_grep "^+NEW5" actual &&
+	test_grep "^-OLD9" actual &&
+	test_grep "^+NEW9" actual &&
+	test_grep "exceeds.*lines" stderr
+'
+
+test_expect_success 'diff process fallback on mismatched unchanged totals' '
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
+	test_grep "changed" actual &&
+	test_grep "unchanged line count mismatch" stderr
+'
+
+test_expect_success 'diff process fallback on overlapping hunks' '
+	# boundary.c has 10 lines, so both hunks are in bounds
+	# but they overlap at lines 3-5, triggering the ordering check.
+	git -c diff.cdiff.process="$BACKEND --mode=overlap" \
+		diff boundary.c >actual 2>stderr &&
+	test_grep "NEW5" actual &&
+	test_grep "overlaps with previous" stderr
+'
+
+test_expect_success 'diff process fallback on malformed hunk line' '
+	git -c diff.cdiff.process="$BACKEND --mode=bad-parse" \
+		diff boundary.c >actual 2>stderr &&
+	test_grep "^-OLD5" actual &&
+	test_grep "^+NEW5" actual
+'
+
+test_expect_success 'diff process skipped when tool omits capability' '
+	git -c diff.cdiff.process="$BACKEND --mode=no-cap" \
+		diff boundary.c >actual 2>stderr &&
+	test_grep "^-OLD5" actual &&
+	test_grep "^+NEW5" actual &&
+	test_must_be_empty stderr
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

