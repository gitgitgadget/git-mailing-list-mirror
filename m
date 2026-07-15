Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE863CCA12
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149341; cv=none; b=d+Gs6tu1RDA2stBashQBmQ/cDLZx/49+I/LNcFrQVL2n3+o6ZXfQlFaRhBwC0jKYK6H/7majKVPwp+Iuv8H2AZCyjpiY9jrzUPXD8JW3Wpfujyf7OaMBEQ3Du7IEn59vYkskqC5heC5gvekoYVnfYKotgRcUATDj7gR71DA69eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149341; c=relaxed/simple;
	bh=WH98V4F3UsfTesygejLTfaEuL5wWMD+1rzcJFX3T8N0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VzsS1vzRbnTg8ovTP0eqYKLAPdiSXnpnHefoFN8xR3ej1GihpNqekhLWNclhigF5SfmmlMpH1pM61NucXgoYejeNcpGwagtsd9jhoCAS/ROAbIs2wY5yeOuxCUHQrteii54pNJ7HDoe5VFAZKnTadqAdLt0D2J4/da0OXOk4w2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeEwB7FZ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeEwB7FZ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso9322906d6.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149335; x=1784754135; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cZ8ljA+M+uZs9H4RZhxtGEzUINvpTAfnhFd298P2EdY=;
        b=JeEwB7FZBl7rkdB+iX+yil1Sn1ausdSyi26vh2SNeNbcsi2sXNlWyEhSS95UFOumE9
         gZ1UcFfZXK7HN4kbbsVBSygmADbo4hasltoyXjbvfNuV1Hgzoc/jYwGup/23FLG/VidY
         Xorc6+9L8GSZYz/2dVrKBmZff/D1Xy04flcTz6/2wfYGGm9607GZzmd8JySEwKdW5zBg
         1BG+oyPVdYbXNuoXPIXi7bXKCoY6VSF+5tOa+whASJCJY2E/aUnoukSild78hhh6PfqZ
         LuRW2wpD/nK19ZvSE+YDadS+q3Ab57pzCr+YlF78z5RZyy6Iylss9V3UrpULVGrDVOcq
         GV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149335; x=1784754135;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cZ8ljA+M+uZs9H4RZhxtGEzUINvpTAfnhFd298P2EdY=;
        b=DGAEXwEdl52CExlMddhAP8pvCk/5DejpEhfZo++yW6kwfbO19zZ47UdSg3Was3Km1K
         dUcowGuJz+llIe5ZQloXjcDhPlROn16nm+0jeBUnTLMEwxA8Mw5Tvl5XfKGGs3Euz4HH
         jsCzZHQVWYMYwf8m3MTY+7KtPJAwAhqnshymPqaGCN3v/J45x8XT13qKfQwv3xO6e1SF
         SXr7F3RA/x1cnwXMeIaX1ikrl0ZZoYoMR59foiK3L6LvsMMUYMOt4V7rCBd8Gj3/+Mcj
         TAXJLII9E/xJbAEvFTi4JaGgpbMqIZMh51h5F8uam5p77Z8JfZOjq0OZKenbqJ4SVlhO
         w4Fg==
X-Gm-Message-State: AOJu0YzpWixAcwCXLdwrOYIrkxkSqQiKHtYajJnq0RcgBB0r+6oxfv0s
	yLgWRWlIs8QniTjL94SWegWDFYZ6OygdGgWGKgoqE6cSt35/mccuM7E/rSHYuA==
X-Gm-Gg: AfdE7ckw/C9Zgj914p2cmFrv+Cy8cn+y4Xd79zgAsgfpUAKpiLWfltJ8294GoK4nrLm
	9AuKwKmrUEzehO2DSgPDTX2p8gI7FwqO1Bfpos4Mo+YL0Wik8Dqag1aSEWnWPlEtYbCE1jaOnmK
	gjM3e9O+C8DbKzpSRD26QzYePeaA5rTs6keQsxerrI/eEpx8KroDtBPedj8SUQHDBUlEmHATYTa
	403o72dY3NrBDkZvsooyqSpTaz9WhD0bzIyu0hOAVl5j9Fi91xFVYfywhWRh0jyRq+gx+ZMHVuD
	YobSj+32Kjpv24+2K3XLy2faTGjIJnMeOTGITyQ1Ipoh+LSfnWhwXtMHjSg0oZIw+att7msDxxw
	JyJ3HjkajVHCuRBUw+8v9tllWydxWcwodNOxNRkVFC+p+fVBUYS0+g25Wji1TBpUfgKB2pO6l4F
	has/QnVw==
X-Received: by 2002:a05:6214:5e0a:b0:8fd:6e22:6631 with SMTP id 6a1803df08f44-9076548adb7mr13472496d6.29.1784149334458;
        Wed, 15 Jul 2026 14:02:14 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.193.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4b91sm203234496d6.19.2026.07.15.14.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:02:13 -0700 (PDT)
Message-Id: <d003bc1f15d83a211bcd683ac9bae2680f77fed0.1784149323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
References: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
	<pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 21:01:58 +0000
Subject: [PATCH v5 5/9] diff: add long-running diff process via
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
normally.  A new "Which features consult the diff process"
documentation section lays out which features use the tool's hunks,
which compute independently, and why; the summary formats such as
--stat still use the builtin diff for now.

The handshake negotiates version=1 and capability=hunks.  Per-file
requests send command=hunks, pathname, the old and new blob object
names as old-oid/new-oid, and both file contents as packetized data.
The tool responds with hunk lines and a status packet (success,
error, or abort).  On error, Git warns and falls back to the builtin
diff algorithm for that file.  On abort, Git silently falls back for
the current file and stops sending further requests to the tool for
the remainder of the session.

old-oid/new-oid name the two blobs so a tool can cache its analysis
keyed on the pair.  A side's oid is sent only when the content the
tool receives is that raw blob: it is omitted under textconv, which
rewrites the bytes, and for a working-tree side with no stored
object, so an oid that is sent always names the bytes the tool
receives.  This is where the process protocol diverges from
diff.<driver>.command, which never composes with textconv (the
command replaces the whole diff and always gets the raw blob).  Tools
ignore unknown request keys, so old tools skip them.

When the tool returns no hunks followed by status=success, Git
treats the file as having no changes and produces no diff output.
This also means --exit-code reports no changes for that file.

The subprocess is stored on the userdiff_driver struct and
launched on first use.  If the process fails to start, the
handshake fails, or a communication error occurs mid-stream,
the failure is cached on the driver to avoid retrying and
re-warning on every subsequent file.

Git falls back to the builtin diff (rather than consulting the
tool) when an option the tool cannot honor is in effect: the
whitespace-ignoring flags, --ignore-blank-lines, -I<regex>, and
--anchored.  The bypass keys off the effective diff parameters (xpp)
rather than diffopt, so a later caller whose flags live elsewhere is
covered uniformly.  A change that only adds or removes the trailing
newline is likewise not expressible as hunks, so it too uses the
builtin diff.  The hunk parser ignores unknown trailing fields on a
hunk line for response forward-compatibility.

Hunk accumulation is bounded by the combined byte count of the two
files, so a misbehaving tool that floods hunk lines cannot grow
memory without bound before validation runs.

diff_process_fill_hunks() is the sole public entry point.  It
handles driver lookup, flag checks, subprocess management, and
error reporting, returning an enum that lets callers distinguish
"hunks populated" from "files equivalent" from "not applicable"
from "tool failure."

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/config/diff.adoc       |   5 +
 Documentation/gitattributes.adoc     | 249 +++++++++++
 Makefile                             |   2 +
 diff-process.c                       | 491 ++++++++++++++++++++
 diff-process.h                       |  49 ++
 diff.c                               |  21 +
 diff.h                               |   3 +
 meson.build                          |   1 +
 t/helper/meson.build                 |   1 +
 t/helper/test-diff-process-backend.c | 381 ++++++++++++++++
 t/helper/test-tool.c                 |   1 +
 t/helper/test-tool.h                 |   1 +
 t/meson.build                        |   1 +
 t/t4080-diff-process.sh              | 645 +++++++++++++++++++++++++++
 userdiff.h                           |   3 +
 15 files changed, 1854 insertions(+)
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
index 2c4fbfd7f1..f4ca4a8c7e 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -831,6 +831,255 @@ NOTE: If `diff.<name>.command` is defined for path with the
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
+the diff process feeds results back into the standard pipeline.  If
+both are configured for a path, `diff.<name>.command` takes precedence
+for the patch output it replaces; the summary formats, `git blame`,
+and `git log -L` never run the command and still consult the process.
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
+described below).  The tool replies with "git-diff-server", the
+version it supports, and the capabilities it supports.
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
+packet:          git> old-oid=<hex>
+packet:          git> new-oid=<hex>
+packet:          git> 0000
+packet:          git> OLD_CONTENT
+packet:          git> 0000
+packet:          git> NEW_CONTENT
+packet:          git> 0000
+-----------------------
+
+The optional `old-oid` and `new-oid` keys give the object names of the
+old and new blobs, so a tool can cache its analysis keyed on the pair.
+A side's key is sent only when the content for that side is the raw
+blob it names: it is omitted when the content is textconv-transformed,
+and for a working-tree side that has no stored object.  A tool that
+does not recognize these keys ignores them.
+
+The tool is expected to respond with zero or more hunk lines,
+a flush packet, and a status packet terminated with a flush packet.
+Each hunk line has the form:
+
+  `hunk <old_start> <old_count> <new_start> <new_count>`
+
+where `<old_start>` and `<old_count>` identify a range of lines in
+the old file, and `<new_start>` and `<new_count>` identify the
+replacement range in the new file.  The four fields are separated by
+single spaces.  Start values are 1-based and counts are non-negative.
+For example, `hunk 3 2 3 4` means that 2 lines starting at line 3 in
+the old file were replaced by 4 lines starting at line 3 in the new
+file.  An `<old_count>` of 0 means no lines were removed (pure
+insertion); a `<new_count>` of 0 means no lines were added (pure
+deletion).  For a side with a count of 0 (a pure insertion or
+deletion) the start is the 1-based line the change sits before,
+ranging from 1 to one past the last line (the line count plus 1, to
+place the change at the end of the file); like every start it must
+keep the unchanged runs aligned on both sides (see below), so for a
+given change it takes one specific value, not an arbitrary one.  A
+start of 0 is also accepted and treated as 1, matching the
+empty-file-side form `git diff` emits (e.g. `hunk 0 0 1 5` for a newly
+added file).  A nonzero range must not extend beyond the end of the
+file.  Git ignores any extra
+whitespace-separated tokens after `<new_count>`, so a future protocol
+version can append fields to a hunk line (for example a "moved"
+marker) without older tools rejecting it.
+
+Lines are delimited by newlines.  A file `"foo\nbar\n"` and a
+file `"foo\nbar"` both have 2 lines.
+
+Hunks must be listed in order and must not overlap.  Any line not
+covered by a hunk is treated as unchanged and is paired, in order,
+with the unchanged lines on the other side.  Each run of unchanged
+lines between two hunks (and the run before the first hunk and
+after the last) must therefore be the same length on both sides,
+not merely equal in total.  For the hunks `1 3 1 5` and `10 2 12 2`
+below, lines 4-9 of the old file and lines 6-11 of the new file are
+both the six unchanged lines between the two hunks.  A response that
+balances only the total unchanged count but misaligns one of these
+runs is rejected, and Git falls back to the builtin diff.
+
+Git does not check that the lines a hunk leaves unchanged are
+byte-for-byte identical between the two sides; it pairs them by
+position and shows the new side as context.  A tool may therefore
+report lines that differ textually (a pure reformatting, say) as
+unchanged, and the diff reflects that judgment.  This is
+the point of a semantic backend, but it means a misbehaving tool can
+produce a diff whose context does not match the old blob; as with
+`git diff -w`, such a patch may not apply against the old content.
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
+as changed and feeds them into the standard diff pipeline.  Git may
+still slide or regroup those changes against matching context for
+display, exactly as it compacts its own diffs, so the tool controls
+which lines are reported as changed, not the precise hunk boundaries.
+Patch output features (word diff, function context, color) work
+normally.  Summary formats such as `--stat` still compute their counts
+with the builtin diff for now; see "Which features consult the diff
+process" below for the full picture and the reasoning behind it.
+
+If no hunk lines precede the flush, followed by "success", Git
+treats the files as having no changes: `git diff` produces no output,
+`git diff --exit-code` and `--quiet` report success even though the
+stored blobs differ, and `git blame` skips the commit, attributing
+lines to earlier commits.
+The one exception is a change that only adds or removes the file's
+trailing newline: it cannot be expressed as line hunks, so when the
+line content otherwise matches Git keeps the builtin diff for that
+file (preserving the `\ No newline at end of file` marker) instead of
+treating the two sides as equal.
+
+-----------------------
+packet:          git< 0000
+packet:          git< status=success
+packet:          git< 0000
+-----------------------
+
+If the tool returns well-formed but invalid hunks (out of bounds,
+overlapping, or with misaligned unchanged runs), Git warns and falls
+back to the builtin diff for that file; the tool stays available for
+subsequent files.  A malformed hunk line, by contrast (bad syntax, a
+nonzero count paired with a start of 0, or more hunks than the file
+has lines), is a protocol violation: Git stops the process and does
+not send it further requests, as described below.
+
+In case the tool cannot or does not want to process the content,
+it is expected to respond with an "error" status.  Git warns and
+falls back to the builtin diff algorithm for this file, treating any
+status other than "success" or "abort" the same way.  The tool
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
+Which features consult the diff process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The diff process answers a single question: given two blobs, which
+line ranges differ?  Whether a particular feature consults it follows
+from whether that is the question the feature is really asking.
+
+Features that ask "which lines changed" use the tool's hunks in place
+of the builtin algorithm:
+
+- `git diff` patch output, together with everything layered on it:
+  word diff, function context (`-W`), `--color-moved`, the `@@` hunk
+  headers, and the `-L` line-range display.  These operate on the
+  lines the patch step already emitted, so they reflect the tool's
+  hunks without any further negotiation.
+- `git blame`: a commit whose change the tool reports as equivalent is
+  skipped, and its lines are attributed to an earlier commit.
+
+Features that ask a different question do not consult the process, by
+design:
+
+- The pickaxe `-G<regex>` searches the textual diff for a pattern; it
+  asks "does this string appear in the diff," not "did these lines
+  change."  (`-S` runs at an earlier stage and is likewise unaffected.)
+- `git patch-id` must produce a stable hash for `git rebase` and
+  cherry-pick detection; deriving it from a configured tool would make
+  equal patches hash differently from machine to machine.
+- The merge machinery (`git merge-tree`, `rerere`) computes merge
+  content and conflict signatures rather than display output, so the
+  tool's hunks must not alter its results.
+- `git range-diff` diffs patch text, not source blobs, so source-file
+  hunks do not apply to it.
+- `--check` reports whitespace errors in added lines using the builtin
+  diff's notion of which lines are added, not the tool's.  It can
+  therefore flag (and exit non-zero on) a line the tool treats as
+  unchanged and that `git diff` shows as context.  Whitespace breakage
+  is a property of the literal bytes, so `--check` keeps the builtin
+  partition deliberately; a future change could wire it to the tool if
+  matching `git diff` exactly became desirable.
+- `--raw`, `--name-only`, and `--name-status` compare object ids at
+  the tree level and never run a line-level diff at all.
+
+Some features ask "which lines changed" but still use the builtin
+algorithm for now, and may consult the process in a later change: the
+summary formats (`--stat`, `--numstat`, `--shortstat`); `git log -L`'s
+commit selection and parent range propagation (as distinct from its
+display, which is covered above); and combined diffs (`--cc` and merge
+diffs), whose protocol would have to be extended from a single old/new
+pair to one comparison per merge parent.
+
+`--diff-algorithm` bypasses the process entirely, for every feature
+listed above.  The whitespace-ignoring options (`-w`,
+`--ignore-space-change`, `--ignore-blank-lines`, and the like),
+`-I<regex>`, and `--anchored` also bypass it for the affected files:
+the tool is never told about these options, so it could not honor
+them, and Git falls back to the builtin diff, which does.
+
 Defining a custom hunk-header
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/Makefile b/Makefile
index 1cec251f43..1314c10463 100644
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
index 0000000000..4c748fdd2a
--- /dev/null
+++ b/diff-process.c
@@ -0,0 +1,491 @@
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
+ *   git> command=hunks / pathname=<path> / [old-oid=<hex>] / [new-oid=<hex>] / flush
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
+#include "hex.h"
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
+/*
+ * A hunk in the diff process's presentation coordinates: the line
+ * numbering it reports over the protocol.  Kept distinct from struct
+ * xdl_hunk (xdiff's coordinates) so that only translated hunks ever
+ * reach the diff algorithm; diff_process_hunk_to_xdl() is the single
+ * crossing point.
+ */
+struct diff_process_hunk {
+	long old_start, old_count;
+	long new_start, new_count;
+};
+
+/*
+ * Parse one non-negative decimal field of a hunk line into *out and
+ * advance *line past it.  Fields must be plain decimal with no leading
+ * whitespace or sign (isdigit() takes an unsigned char to stay defined
+ * for high-bit bytes).  The first three fields are followed by a single
+ * space; the last (is_last) is followed by end-of-string or a space.
+ * Trailing space-separated tokens after the last field are allowed and
+ * ignored, so a future protocol version can append fields (e.g. a
+ * "moved" marker) without older tools rejecting the line -- mirroring
+ * the request-side rule that tools ignore unknown keys.
+ */
+static int parse_hunk_field(const char **line, long *out, int is_last)
+{
+	const char *p = *line;
+	char *end;
+
+	if (!isdigit((unsigned char)*p))
+		return -1;
+	errno = 0;
+	*out = strtol(p, &end, 10);
+	if (errno || end == p)
+		return -1;
+	if (is_last) {
+		if (*end != '\0' && *end != ' ')
+			return -1;
+	} else {
+		if (*end != ' ')
+			return -1;
+		end++;
+	}
+	*line = end;
+	return 0;
+}
+
+static int parse_hunk_line(const char *line,
+			   struct diff_process_hunk *presented)
+{
+	/* Format: "hunk <old_start> <old_count> <new_start> <new_count>" */
+	if (!skip_prefix(line, "hunk ", &line))
+		return -1;
+	if (parse_hunk_field(&line, &presented->old_start, 0) ||
+	    parse_hunk_field(&line, &presented->old_count, 0) ||
+	    parse_hunk_field(&line, &presented->new_start, 0) ||
+	    parse_hunk_field(&line, &presented->new_count, 1))
+		return -1;
+	return 0;
+}
+
+/*
+ * Translate a hunk from the diff process's presentation coordinates
+ * into xdiff's.
+ *
+ * Protocol starts are already 1-based positions (the line a change
+ * sits before), the same numbering xdiff uses, so the only adjustment
+ * is for an empty file side: "git diff" addresses it with a start of 0
+ * and a count of 0 (e.g. "0 0 1 5" adds five lines to an empty old
+ * side), and since xdiff uses start-1 as an array index that 0 becomes
+ * 1 here.  This is NOT the full inverse of xdl_emit_hunk_hdr()
+ * (xdiff/xutils.c): that emitter shifts a count-0 range to start-1 for
+ * the displayed "@@" header, but the protocol keeps the unshifted
+ * 1-based position for a mid-file insert or delete.  This is the single
+ * point where presentation coordinates become xdiff coordinates, so
+ * xdl_populate_hunks_from_external() may assume 1-based starts.
+ *
+ * Returns -1 for a start of 0 paired with a nonzero count, which names
+ * no line in either coordinate system.  (parse_hunk_line() already
+ * guarantees non-negative starts and counts.)
+ */
+static int diff_process_hunk_to_xdl(const struct diff_process_hunk *presented,
+				    struct xdl_hunk *xdl)
+{
+	long old_start = presented->old_start;
+	long new_start = presented->new_start;
+
+	if ((!old_start && presented->old_count) ||
+	    (!new_start && presented->new_count))
+		return -1;
+	if (!old_start)
+		old_start = 1;
+	if (!new_start)
+		new_start = 1;
+
+	xdl->old_start = old_start;
+	xdl->old_count = presented->old_count;
+	xdl->new_start = new_start;
+	xdl->new_count = presented->new_count;
+	return 0;
+}
+
+static enum diff_process_result get_hunks(
+		struct userdiff_driver *drv,
+		const char *path,
+		const char *old_buf, long old_size,
+		const char *new_buf, long new_size,
+		const struct object_id *oid_a,
+		const struct object_id *oid_b,
+		struct xdl_hunk **hunks_out,
+		size_t *nr_hunks_out)
+{
+	struct diff_subprocess *backend;
+	struct child_process *process;
+	int fd_in, fd_out;
+	struct strbuf status = STRBUF_INIT;
+	struct xdl_hunk *hunks = NULL;
+	struct diff_process_hunk presented;
+	struct xdl_hunk hunk;
+	size_t nr_hunks = 0, alloc_hunks = 0;
+	size_t max_hunks;
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
+	    packet_write_fmt_gently(fd_in, "pathname=%s\n", path))
+		goto comm_error;
+	/*
+	 * old-oid/new-oid let the tool key a cache on the blob pair.  A
+	 * side is sent only when its content is the raw blob (the caller
+	 * passes NULL otherwise, e.g. for textconv'd content), so an oid
+	 * that is present always names the bytes the tool receives.
+	 */
+	if (oid_a &&
+	    packet_write_fmt_gently(fd_in, "old-oid=%s\n", oid_to_hex(oid_a)))
+		goto comm_error;
+	if (oid_b &&
+	    packet_write_fmt_gently(fd_in, "new-oid=%s\n", oid_to_hex(oid_b)))
+		goto comm_error;
+	if (packet_flush_gently(fd_in))
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
+	/*
+	 * Hunks are non-overlapping and each useful hunk covers at least
+	 * one line, so a valid response cannot contain more hunks than the
+	 * two files have lines, which is bounded by their byte sizes.  Cap
+	 * the accumulation accordingly so a misbehaving tool that floods
+	 * hunk lines cannot drive unbounded memory growth before validation.
+	 */
+	max_hunks = (size_t)old_size + (size_t)new_size + 1;
+
+	/* Read hunks until flush packet */
+	while ((len = packet_read_line_gently(fd_out, NULL, &line)) >= 0 &&
+	       line) {
+		if (parse_hunk_line(line, &presented) < 0)
+			goto comm_error;
+		if (diff_process_hunk_to_xdl(&presented, &hunk) < 0)
+			goto comm_error;
+		if (nr_hunks >= max_hunks) {
+			warning(_("diff process '%s' sent too many hunks"
+				  " for '%s'"), drv->process, path);
+			goto comm_error;
+		}
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
+/*
+ * Whether exactly one of the two blobs ends in a newline.  A change
+ * that only adds or removes the trailing newline is not expressible as
+ * line hunks, so a tool comparing lines reports the files as equal.
+ */
+static int eof_newline_differs(const mmfile_t *a, const mmfile_t *b)
+{
+	int a_nl = a->size > 0 && a->ptr[a->size - 1] == '\n';
+	int b_nl = b->size > 0 && b->ptr[b->size - 1] == '\n';
+	return a_nl != b_nl;
+}
+
+/*
+ * Number of lines in a blob, matching xdiff's record count: one per
+ * newline, plus one more if the last line has no trailing newline.
+ */
+static long count_lines(const char *buf, long size)
+{
+	long lines = 0, i;
+
+	for (i = 0; i < size; i++)
+		if (buf[i] == '\n')
+			lines++;
+	if (size > 0 && buf[size - 1] != '\n')
+		lines++;
+	return lines;
+}
+
+/*
+ * Validate the tool's hunks (already in xdiff coordinates) against the
+ * two blobs before they bypass the diff algorithm.  Each hunk must fit
+ * within its file, the hunks must be ordered and non-overlapping, and
+ * the unchanged run before each hunk (and after the last) must be the
+ * same length on both sides -- xdl_build_script() walks the two files
+ * in lockstep over unchanged lines, so a mismatched gap desynchronizes
+ * it and yields a corrupt diff even when the totals balance.  This is
+ * the git layer's job so xdiff stays diagnostic-free; on a bad response
+ * we warn and the caller falls back to the builtin diff.  Returns 0 if
+ * valid, -1 (after warning) otherwise.
+ */
+static int validate_external_hunks(const struct xdl_hunk *hunks, size_t nr,
+				   long old_lines, long new_lines,
+				   const char *process, const char *path)
+{
+	size_t i;
+	long prev_old_end = 0, prev_new_end = 0;
+
+	for (i = 0; i < nr; i++) {
+		const struct xdl_hunk *h = &hunks[i];
+
+		if (h->old_count > old_lines - h->old_start + 1 ||
+		    h->new_count > new_lines - h->new_start + 1) {
+			warning(_("diff process '%s' returned a hunk past the "
+				  "end of '%s'; using the builtin diff"),
+				process, path);
+			return -1;
+		}
+		if (h->old_start < prev_old_end || h->new_start < prev_new_end) {
+			warning(_("diff process '%s' returned overlapping hunks "
+				  "for '%s'; using the builtin diff"),
+				process, path);
+			return -1;
+		}
+		if (h->old_start - prev_old_end != h->new_start - prev_new_end) {
+			warning(_("diff process '%s' returned hunks that leave "
+				  "'%s' misaligned; using the builtin diff"),
+				process, path);
+			return -1;
+		}
+		prev_old_end = h->old_start + h->old_count;
+		prev_new_end = h->new_start + h->new_count;
+	}
+	if (old_lines - prev_old_end != new_lines - prev_new_end) {
+		warning(_("diff process '%s' returned hunks that leave '%s' "
+			  "misaligned; using the builtin diff"),
+			process, path);
+		return -1;
+	}
+	return 0;
+}
+
+enum diff_process_result diff_process_fill_hunks(
+		struct diff_options *diffopt,
+		const char *path,
+		const mmfile_t *file_a,
+		const mmfile_t *file_b,
+		const struct object_id *oid_a,
+		const struct object_id *oid_b,
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
+	/*
+	 * Whitespace-ignoring, regex-ignore (-I) and anchored options
+	 * change which lines count as different, but the tool is never
+	 * told about them, so its hunks could not honor them.  Rather
+	 * than silently override the user's request, fall back to the
+	 * builtin diff, which does honor these flags.  Key this off xpp
+	 * (the parameters this diff actually runs with) rather than
+	 * diffopt, so a caller like blame that keeps its flags outside
+	 * diffopt is covered without a separate guard of its own.
+	 */
+	if ((xpp->flags & (XDF_WHITESPACE_FLAGS | XDF_IGNORE_BLANK_LINES)) ||
+	    xpp->ignore_regex_nr || xpp->anchors_nr)
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
+			oid_a, oid_b,
+			&ext_hunks, &nr);
+	if (res == DIFF_PROCESS_OK) {
+		if (!nr) {
+			free(ext_hunks);
+			/*
+			 * Zero hunks means the tool considers the line
+			 * content identical, but it cannot express a
+			 * trailing-newline-only change.  When that is the
+			 * actual difference, fall back to the builtin diff
+			 * so the "\ No newline at end of file" marker is
+			 * preserved instead of reporting the files equal.
+			 */
+			if (eof_newline_differs(file_a, file_b))
+				return DIFF_PROCESS_SKIP;
+			return DIFF_PROCESS_EQUIVALENT;
+		}
+		if (validate_external_hunks(ext_hunks, nr,
+					    count_lines(file_a->ptr, file_a->size),
+					    count_lines(file_b->ptr, file_b->size),
+					    drv->process, path) < 0) {
+			free(ext_hunks);
+			return DIFF_PROCESS_SKIP;
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
index 0000000000..8d00dafe1d
--- /dev/null
+++ b/diff-process.h
@@ -0,0 +1,49 @@
+#ifndef DIFF_PROCESS_H
+#define DIFF_PROCESS_H
+
+#include "xdiff/xdiff.h"
+
+struct diff_options;
+struct object_id;
+
+enum diff_process_result {
+	DIFF_PROCESS_ERROR = -1, /* failed; caller falls back to builtin */
+	DIFF_PROCESS_OK = 0,     /* hunks populated in xpp */
+	DIFF_PROCESS_SKIP,       /* process did not apply: use builtin */
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
+ * Returns DIFF_PROCESS_EQUIVALENT when the tool returns no hunks and
+ * the blobs are not a trailing-newline-only change (files are
+ * considered identical); caller should skip diff/blame.
+ * Returns DIFF_PROCESS_SKIP when no process applies; caller
+ * should use the builtin diff algorithm.
+ * Returns DIFF_PROCESS_ERROR on tool failure (already warned);
+ * caller should fall back to the builtin diff algorithm.
+ *
+ * oid_a/oid_b, when non-NULL, are sent to the tool as old-oid/new-oid
+ * so it can key a cache on the blob pair.  Pass NULL for a side whose
+ * content is not the raw blob (e.g. textconv'd) or whose object name is
+ * unknown, so any oid that is sent always names the bytes the tool
+ * receives.
+ */
+enum diff_process_result diff_process_fill_hunks(
+		struct diff_options *diffopt,
+		const char *path,
+		const mmfile_t *file_a,
+		const mmfile_t *file_b,
+		const struct object_id *oid_a,
+		const struct object_id *oid_b,
+		xpparam_t *xpp);
+
+#endif /* DIFF_PROCESS_H */
diff --git a/diff.c b/diff.c
index 2a9d0d8687..af31072858 100644
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
@@ -4055,6 +4056,25 @@ static void builtin_diff(const char *name_a,
 		xpp.ignore_regex_nr = o->ignore_regex_nr;
 		xpp.anchors = o->anchors;
 		xpp.anchors_nr = o->anchors_nr;
+
+		/*
+		 * Send the blob oids only for a side whose content is the
+		 * raw blob: textconv rewrites the bytes, and a working-tree
+		 * side has no stored oid, so pass NULL there rather than an
+		 * oid that would not name what the tool receives.
+		 */
+		if (diff_process_fill_hunks(o, name_a, &mf1, &mf2,
+					    (textconv_one || !one->oid_valid) ? NULL : &one->oid,
+					    (textconv_two || !two->oid_valid) ? NULL : &two->oid,
+					    &xpp)
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
@@ -4135,6 +4155,7 @@ static void builtin_diff(const char *name_a,
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
index 0000000000..c2ec532c4a
--- /dev/null
+++ b/t/helper/test-diff-process-backend.c
@@ -0,0 +1,381 @@
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
+ *   packet:          git> [old-oid=<hex>]   (omitted for textconv/worktree)
+ *   packet:          git> [new-oid=<hex>]
+ *   packet:          git> 0000
+ *   packet:          git> OLD_CONTENT
+ *   packet:          git> 0000
+ *   packet:          git> NEW_CONTENT
+ *   packet:          git> 0000
+ *
+ * Response varies by --mode (default: whole-file):
+ *
+ *   whole-file   packet: git< hunk <1|0> <old_lines> <1|0> <new_lines>
+ *                (start is 0 for an empty side, matching git diff)
+ *   fixed-hunk   packet: git< hunk 5 2 5 2
+ *   no-hunks     (no hunk packets)
+ *   bad-hunk     packet: git< hunk 999 1 999 1
+ *   bad-parse    packet: git< garbage not a hunk
+ *   bad-sync     packet: git< hunk 1 2 1 1
+ *   bad-gap      packet: git< hunk 1 1 3 1
+ *   bad-start    packet: git< hunk 0 1 1 1
+ *   multi-hunk   packet: git< hunk 5 2 5 2
+ *                packet: git< hunk 9 2 9 2
+ *   insert       packet: git< hunk 3 0 3 2   (mid-file count-0 insertion)
+ *   flood        packet: git< hunk 1 1 1 1   (x100000)
+ *   overlap      packet: git< hunk 1 5 1 5
+ *                packet: git< hunk 3 2 3 2
+ *   no-cap       (omits capability=hunks during handshake)
+ *   error        (status=error instead of status=success)
+ *   abort        (status=abort instead of status=success)
+ *   crash        exit(1) before sending any response
+ *
+ * All success modes (not error/abort/crash) end with:
+ *
+ *   packet:          git< 0000
+ *   packet:          git< status=success
+ *   packet:          git< 0000
+ *
+ * Each request is logged to --log as:
+ *
+ *   command=<cmd> pathname=<path> old-oid=<hex> new-oid=<hex> old=<first line> new=<first line>
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
+	MODE_BAD_GAP,
+	MODE_BAD_START,
+	MODE_MULTI_HUNK,
+	MODE_INSERT,
+	MODE_FLOOD,
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
+	if (!strcmp(s, "bad-gap"))
+		return MODE_BAD_GAP;
+	if (!strcmp(s, "bad-start"))
+		return MODE_BAD_START;
+	if (!strcmp(s, "multi-hunk"))
+		return MODE_MULTI_HUNK;
+	if (!strcmp(s, "insert"))
+		return MODE_INSERT;
+	if (!strcmp(s, "flood"))
+		return MODE_FLOOD;
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
+static int read_request_header(char **command, char **pathname,
+			       char **old_oid, char **new_oid)
+{
+	int first = 1;
+	char *line;
+
+	*command = *pathname = *old_oid = *new_oid = NULL;
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
+		else if (skip_prefix(line, "old-oid=", &value))
+			*old_oid = xstrdup(value);
+		else if (skip_prefix(line, "new-oid=", &value))
+			*new_oid = xstrdup(value);
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
+	case MODE_BAD_GAP:
+		/*
+		 * Globally balanced (1 changed line on each side, so the
+		 * total unchanged counts match) but the gap before the
+		 * change differs between sides: old line 1 vs new line 3.
+		 * Exercises the per-gap lockstep-alignment check.
+		 */
+		packet_write_fmt(1, "hunk 1 1 3 1\n");
+		break;
+	case MODE_BAD_START:
+		/*
+		 * A start of 0 is valid only for an empty (count 0) range;
+		 * pairing it with a nonzero count names no line in either
+		 * the protocol's or xdiff's coordinates, so the translation
+		 * rejects it and git falls back to the builtin diff.
+		 */
+		packet_write_fmt(1, "hunk 0 1 1 1\n");
+		break;
+	case MODE_MULTI_HUNK:
+		/*
+		 * Two valid, non-overlapping, gap-aligned hunks.  Exercises
+		 * the accepting branch of the per-gap lockstep check with a
+		 * non-zero previous-hunk end (the realistic two-region case).
+		 */
+		packet_write_fmt(1, "hunk 5 2 5 2\n");
+		packet_write_fmt(1, "hunk 9 2 9 2\n");
+		break;
+	case MODE_INSERT:
+		/*
+		 * A mid-file pure insertion (count 0 on the old side) in the
+		 * protocol's 1-based-position form: 2 lines inserted before
+		 * old line 3.  Exercises the count-0 path, which uses the
+		 * unshifted position (not git diff's "-3,0" display start).
+		 */
+		packet_write_fmt(1, "hunk 3 0 3 2\n");
+		break;
+	case MODE_FLOOD: {
+		/*
+		 * Emit far more hunks than any small file has lines, so Git
+		 * trips its accumulation cap and falls back before reading
+		 * them all.
+		 */
+		int i;
+		for (i = 0; i < 100000; i++)
+			packet_write_fmt(1, "hunk 1 1 1 1\n");
+		break;
+	}
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
+		char *old_oid = NULL, *new_oid = NULL;
+		struct strbuf obuf = STRBUF_INIT;
+		struct strbuf nbuf = STRBUF_INIT;
+
+		if (!read_request_header(&command, &pathname,
+					 &old_oid, &new_oid))
+			break; /* EOF: Git closed its end */
+
+		read_packetized_to_strbuf(0, &obuf, 0);
+		read_packetized_to_strbuf(0, &nbuf, 0);
+
+		if (logfile) {
+			fprintf(logfile,
+				"command=%s pathname=%s old-oid=%s new-oid=%s"
+				" old=%.*s new=%.*s\n",
+				command ? command : "(none)",
+				pathname ? pathname : "(none)",
+				old_oid ? old_oid : "(none)",
+				new_oid ? new_oid : "(none)",
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
+		free(old_oid);
+		free(new_oid);
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
+			   "response shape (default whole-file);"
+			   " see the file header for the full list of modes"),
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
index 3219264fe7..6afbfa6a87 100644
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
index 0000000000..3b75df082e
--- /dev/null
+++ b/t/t4080-diff-process.sh
@@ -0,0 +1,645 @@
+#!/bin/sh
+
+test_description='diff process via long-running process'
+
+TEST_PASSES_SANITIZE_LEAK=true
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
+	# one.c/two.c: two-file pair for error/abort/startup-failure tests.
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
+test_expect_success 'diff process accepts valid multi-hunk output' '
+	# multi-hunk reports both changed regions (5-6 and 9-10) as two
+	# gap-aligned hunks.  This exercises the accepting branch of the
+	# per-gap lockstep check (non-zero previous-hunk end) and must
+	# produce a correct two-region diff with the lines between the
+	# hunks kept as context.
+	git -c diff.cdiff.process="$BACKEND --mode=multi-hunk" \
+		diff boundary.c >actual 2>stderr &&
+	test_grep "^-OLD5" actual &&
+	test_grep "^+NEW5" actual &&
+	test_grep "^-OLD9" actual &&
+	test_grep "^+NEW9" actual &&
+	test_grep "^ line7" actual &&
+	test_grep "^ line8" actual &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process accepts a mid-file count-0 insertion' '
+	# insert mode reports "hunk 3 0 3 2": a pure insertion (count 0 on
+	# the old side) in the protocol 1-based-position form.  Exercises
+	# the count-0 hunk path that the other valid-hunk modes (full
+	# replacements, equal-count modifies) never hit.  Empty stderr is
+	# the discriminator: a mishandled count-0 start would be rejected
+	# by the lockstep check and warn.
+	cat >insert.c <<-\EOF &&
+	a
+	b
+	c
+	d
+	e
+	EOF
+	git add insert.c &&
+	git commit -m "add insert.c" &&
+	cat >insert.c <<-\EOF &&
+	a
+	b
+	X
+	Y
+	c
+	d
+	e
+	EOF
+	git -c diff.cdiff.process="$BACKEND --mode=insert" \
+		diff insert.c >actual 2>stderr &&
+	test_grep "^+X" actual &&
+	test_grep "^+Y" actual &&
+	test_grep "^ c" actual &&
+	test_must_be_empty stderr
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
+test_expect_success 'diff process equivalent commit: --exit-code and --quiet agree' '
+	# A committed blob pair (not a worktree file) whose oids differ but
+	# the tool reports equivalent.  --exit-code and --quiet must agree
+	# with the shown diff (empty) and report success, not fall back to
+	# the byte-level "oids differ" answer.
+	cat >ecq.c <<-\EOF &&
+	alpha
+	EOF
+	git add ecq.c &&
+	git commit -m "ecq v1" &&
+	cat >ecq.c <<-\EOF &&
+	beta
+	EOF
+	git add ecq.c &&
+	git commit -m "ecq v2" &&
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
+		diff --exit-code HEAD^ HEAD -- ecq.c &&
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
+		diff --quiet HEAD^ HEAD -- ecq.c
+'
+
+test_expect_success 'diff process falls back for trailing-newline-only change' '
+	test_when_finished "rm -f backend.log" &&
+	printf "a\nb\nc\n" >eofnl.c &&
+	git add eofnl.c &&
+	git commit -m "add eofnl.c" &&
+	printf "a\nb\nc" >eofnl.c &&
+	# Same lines, only the final newline removed.  The tool reports
+	# no hunks (it sees identical lines), but that change is not
+	# expressible as hunks, so git falls back to the builtin diff
+	# rather than treating the files as equivalent.
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
+		diff eofnl.c >actual 2>stderr &&
+	test_grep "No newline at end of file" actual &&
+	test_grep "pathname=eofnl.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process falls back for added file (empty old side)' '
+	test_when_finished "rm -f backend.log" &&
+	printf "x\ny\nz\n" >addnl.c &&
+	git add addnl.c &&
+	# The empty old side has no trailing newline while the new side
+	# does, so the newline fallback shows the addition rather than
+	# letting no-hunks suppress the whole new file.
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
+		diff --cached addnl.c >actual 2>stderr &&
+	test_grep "^+x" actual &&
+	test_grep "pathname=addnl.c" backend.log &&
+	test_must_be_empty stderr
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
+test_expect_success 'diff process bypassed under whitespace-ignoring flags' '
+	test_when_finished "rm -f backend.log" &&
+	printf "a\nb\nc\n" >wsbypass.c &&
+	git add wsbypass.c &&
+	git commit -m "add wsbypass.c" &&
+	printf "a\n  b  \nc\n" >wsbypass.c &&
+	# The tool is never told about these options and could not honor
+	# them, so git bypasses the process for each (covering the whole
+	# XDF_WHITESPACE_FLAGS | XDF_IGNORE_BLANK_LINES mask, not just -w).
+	for opt in -w -b --ignore-space-at-eol --ignore-blank-lines
+	do
+		rm -f backend.log &&
+		git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+			diff $opt wsbypass.c >actual 2>stderr &&
+		test_path_is_missing backend.log &&
+		test_must_be_empty stderr ||
+		return 1
+	done &&
+	# -w additionally suppresses the whitespace-only change via the
+	# builtin diff that now runs.
+	git -c diff.cdiff.process="$BACKEND" diff -w wsbypass.c >actual &&
+	test_must_be_empty actual
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
+	test_grep "hunk past the end" stderr
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
+	test_grep "misaligned" stderr
+'
+
+test_expect_success 'diff process fallback on misaligned hunk gap' '
+	# bad-gap reports hunk 1 1 3 1 on boundary.c: one changed line
+	# on each side, so the total unchanged counts match, but the
+	# unchanged run before the change differs (old line 1 vs new
+	# line 3).  A global count check would accept this and emit a
+	# corrupt diff; the per-gap lockstep check rejects it and git
+	# falls back to the builtin algorithm.
+	git -c diff.cdiff.process="$BACKEND --mode=bad-gap" \
+		diff boundary.c >actual 2>stderr &&
+	# The builtin fallback shows both changed regions as additions
+	# (a corrupt-accepted hunk would show NEW5 only as context).
+	test_grep "^+NEW5" actual &&
+	test_grep "^+NEW9" actual &&
+	test_grep "misaligned" stderr
+'
+
+test_expect_success 'diff process fallback on overlapping hunks' '
+	# boundary.c has 10 lines, so both hunks are in bounds
+	# but they overlap at lines 3-4, triggering the ordering check.
+	git -c diff.cdiff.process="$BACKEND --mode=overlap" \
+		diff boundary.c >actual 2>stderr &&
+	test_grep "NEW5" actual &&
+	test_grep "overlapping hunks" stderr
+'
+
+test_expect_success 'diff process fallback on malformed hunk line' '
+	git -c diff.cdiff.process="$BACKEND --mode=bad-parse" \
+		diff boundary.c >actual 2>stderr &&
+	test_grep "^-OLD5" actual &&
+	test_grep "^+NEW5" actual
+'
+
+test_expect_success 'diff process fallback on start 0 with nonzero count' '
+	# bad-start reports hunk 0 1 1 1.  A start of 0 is valid only for
+	# an empty (count 0) range, so the presentation-to-xdiff
+	# translation rejects it and git falls back to the builtin diff
+	# instead of handing xdiff an out-of-range start.
+	git -c diff.cdiff.process="$BACKEND --mode=bad-start" \
+		diff boundary.c >actual 2>stderr &&
+	test_grep "^-OLD5" actual &&
+	test_grep "^+NEW5" actual &&
+	test_grep "diff process.*failed" stderr
+'
+
+test_expect_success 'diff process caps a flood of hunks and falls back' '
+	# flood emits far more hunks than the file has lines.  Git must
+	# stop accumulating and fall back to the builtin diff rather than
+	# grow memory without bound.
+	git -c diff.cdiff.process="$BACKEND --mode=flood" \
+		diff boundary.c >actual 2>stderr &&
+	test_grep "^-OLD5" actual &&
+	test_grep "too many hunks" stderr
+'
+
+test_expect_success 'diff process skipped when tool omits capability' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=no-cap --log=backend.log" \
+		diff boundary.c >actual 2>stderr &&
+	# Builtin diff runs: all changes appear, including lines 9-10
+	# that a tool-provided hunk would have narrowed away.
+	test_grep "^-OLD5" actual &&
+	test_grep "^-OLD9" actual &&
+	# The process launched (creating the log) but was
+	# never sent a per-file request, so no hunks command is logged.
+	test_path_is_file backend.log &&
+	test_grep ! "command=hunks" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process receives old-oid and new-oid for a blob pair' '
+	test_when_finished "rm -f backend.log" &&
+	cat >oidpair.c <<-\EOF &&
+	int f(void) { return 1; }
+	EOF
+	git add oidpair.c &&
+	git commit -m "oidpair v1" &&
+	old=$(git rev-parse HEAD:oidpair.c) &&
+
+	cat >oidpair.c <<-\EOF &&
+	int f(void) { return 2; }
+	EOF
+	git add oidpair.c &&
+	git commit -m "oidpair v2" &&
+	new=$(git rev-parse HEAD:oidpair.c) &&
+
+	# Both sides are stored blobs, so their object names are sent.
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff HEAD^ HEAD -- oidpair.c >actual 2>stderr &&
+	test_grep "old-oid=$old new-oid=$new" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process omits old-oid and new-oid for textconv content' '
+	test_when_finished "rm -f backend.log" &&
+	write_script oidcat <<-\EOF &&
+	cat "$1"
+	EOF
+	cat >oidtc.c <<-\EOF &&
+	alpha
+	EOF
+	git add oidtc.c &&
+	git commit -m "oidtc v1" &&
+	cat >oidtc.c <<-\EOF &&
+	beta
+	EOF
+	git add oidtc.c &&
+	git commit -m "oidtc v2" &&
+
+	# textconv rewrites the bytes, so the raw-blob object name that
+	# would otherwise identify each side is omitted.
+	git -c diff.cdiff.textconv="./oidcat" \
+	    -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff HEAD^ HEAD -- oidtc.c >actual 2>stderr &&
+	test_grep "pathname=oidtc.c" backend.log &&
+	test_grep "old-oid=(none) new-oid=(none)" backend.log &&
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

