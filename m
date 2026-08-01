Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A13B6360
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606145; cv=none; b=Mkrarg1TGM0Bb103TSkUTX+kDPzwBsHY8aW4V/FR38Vcx1d139Q1H7QywvmdgOrlZodn6xvPne1aBT48Jyi7IeFdc50iwXcua2y2VRcchRFCWHX0WlgA2jCQIUFyKQdMCuXqETQOE2tGovELa5p5uXxSmG9hKg88lg9n7EnDQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606145; c=relaxed/simple;
	bh=hcSDxQR7So+pFUI0DVM6XvEAG1BOMkTWAuuWxu1BZpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8xK5M2MwmkckFL0ZCg9mUzdrcvr5/ysGEFPgbDyzg0+t62EpaoWcYRgMrjrSDnZGheg2KE3IFQPaRyf2+sXi43oEFGz9NxhxQjqDd9lXZpkskP51g5wIKyX2rLjQFh//6+79UkcgNf4COpWzkzyJaGKql0+fEHSt72Gnt2Q6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgoAejeN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgoAejeN"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf27856f9cso20964805ad.2
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785606140; x=1786210940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=meW6q5li0UObQnQoyoGpMBW/mrIhbon9wH2FjJIfBRw=;
        b=kgoAejeNWCQrBuDiWNhMVb3QtO9QamkVdJCZaMfR+wDopU/2OqYAzafERf45dJnCGC
         cpwdFy6FiO28gChLYi62UXCEQAcliuFcmp7lI3wsz7j4wggKzkntCN13Aawgu578/cZ6
         L5iTaiTHHjTqndd1tguX7o8wcakjsAYEKdkiJJIoMnZGbNJkGDdIaMYa7/fwpU/Fjxt0
         /pEJeIXBY2XFYAoIeZTJKyy/8oz0g3v5EB5ukfGNgyJXUT/xSekAs9ZMgACRfDSWCY5x
         qDa9La6wibJ7mYu4fxSBcZL48MzI9WrUPUUr5Ty35GUheUqWN3VmeYJgW1NyS4knWbj+
         SXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785606140; x=1786210940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=meW6q5li0UObQnQoyoGpMBW/mrIhbon9wH2FjJIfBRw=;
        b=nhShF29m+mAK38Ibag876S1NgQy9fSMxzddF6PPSxppYxibO4fQkHsw5UiGUui3Mfd
         oSlwJaQYvthpCEA1THXyN0Usjo0/W4O7m3w+XZm8tYSUGLyRp+B4m81etbDxMJtJz+Mq
         oBBuXQTX+o5KKNBrmGg8vNw4kYgeQf505/D11WAh6HQXYA9732dW145+SW/8mVtl6LvB
         mKT9PKU9cEmKWNkQMoTt1LXOoayM3t89qhut1EMHlneVAt+BSiT/jJUG5l0eY76+c0r4
         OJ0c+S/5ZcZQkW5mlTTPi8KMlzVNc8Yr/hT8xV1Yf5tVss35mROg/ARMkPIAAxIobYTq
         KjUA==
X-Gm-Message-State: AOJu0Yy1LMV9u4Apoceq0xqt0i1qno6efcEtWr0UJXgEdrDZyZ6jJ7vZ
	1jC8VgOlJEuyW+lp6wI70J5pFfKvwlsBmrqxP6fZH1mVSuwej7r295WBPWhg3g==
X-Gm-Gg: AR+sD11jxuZMRJZdXymwwQcpSR71v1bzt4vs32z8Q08iWEoK30QLpjZY6/Y7W/uHbQo
	Qq2fyyCnghQ/cbzflBp29zMK0F7amOgUh/lSyS+JTxih1O3cAmxcYztz8BrsLTc/livVunieX1d
	XopKGFRGigSOeXO1Aw9al9fPzyv4N6HDgSgh4DOycliOUY1hdNDTXbmaMjJtEXA+FmV/ylz/Ody
	PQHMcS+Hg29ljVjc/BY55uby1URabLedHjZrb9JRSHHPJDvFCTEV11oo4UdgPNt1TAgZ6VOxxKs
	oIaw8hnqm7jtFTNS1mEqhQOnJgzymLYh3xWfgdfzyQJB6bS36vg3Wyu9a2d148/UP2sifjW81NX
	qZ/saoCwwwVIFfjMMO0hp6Q++O/p++JJnbC9NZ8qOJFwHgjgZyPPD8WMs/a4cvr7FOMSEwtSbMt
	0tDfbgTU0decNEdRrcEeoVJHELGKemcg+fbCIhMMG9HfTFRT8c3Y6JrLuxj1oln6uIulWtr4RL3
	0W7NVFuVrlm7P9G0r0aEbbm6DaDz7r/1DGoHV49siO3M5aZ/nI/L0l1MVFK4vocxR15Ggn9too+
	I+9hCuQfm2EINoZXEugPQrrhDY88Nv9DocYFOna1InUb1Q==
X-Received: by 2002:a05:6a20:431e:b0:3c3:8ce8:1fd with SMTP id adf61e73a8af0-3c92a8e2d9fmr3745740637.73.1785606137986;
        Sat, 01 Aug 2026 10:42:17 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4fdb80sm14097476c88.15.2026.08.01.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:42:17 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC PATCH v7 10/10] diff: consult oid-only hunk providers via diff.<driver>.process
Date: Sat,  1 Aug 2026 10:41:53 -0700
Message-ID: <20260801174156.2998808-11-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801174156.2998808-1-mmontalbo@gmail.com>
References: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
 <20260801174156.2998808-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The provider chain so far holds the diff-hunks store in front of the
terminal builtin computation.  Open it to external processes: a pair on
a path whose driver configures diff.<driver>.process is answered by a
long-running process speaking a pkt-line protocol (following the filter
process protocol), registered at the head of the chain and consulted
before the store and before any blob is loaded.

The protocol starts with the smallest request that can carry an answer:
object names alone.  A request is the pathname and the pair's
old-oid/new-oid, with no content.  The process answers with hunk lines,
with a zero-hunk success that asserts the blobs equivalent (trailing
newlines included), or with status=need-content, on which the pair
falls through to the builtin answer.  This serves the two shapes that
need no content pushed to them: a cache keyed on the blob pair, and a
process that fetches the blobs itself (for example over "git cat-file
--batch").  A pair whose side is not a stored blob carries a NULL id;
the provider sends no request and passes it.  Because Git holds no
content for the exchange, the answer is used as sent: hunks are
validated for order, overlap, lockstep alignment, and magnitude, then
replayed without the normalization xdiff applies to diffs it computes
itself.  The magnitude bound is the blobs' sizes, read from the object
database without loading content: a blob of N bytes holds at most N
lines.

Because the process's answer is authoritative, it outranks the store,
and its head-of-chain position says so.  A pair the process answers
never reaches the store and is never recorded, so nothing it produces
enters the store, which holds the builtin answer only.  A request it
does not answer, whether need-content, a missing capability, or a
missing id, passes down the chain to the builtin answer, which is what
the store serves, so the store may serve such a pair and a warming run
may record it.  Entries recorded before a process was configured are
not purged; a pair the process answers ignores them, and "git diff-hunks
clear" discards them.

The provider gates itself per request.  The driver is looked up by the
old-side path, so a renamed file resolves to the same driver, and by
the repository-relative path, so a diff.relative run from a
subdirectory names the pair the same way.  Options the process is never
told about select no process: the whitespace-ignoring options, -I,
--anchored, and an algorithm forced by option or configuration (blame
routes its algorithm through xdl_opts, so --histogram is covered).  The
request gains its last field, the path; the consumers change only by
filling it, and neither names the process.

The provider's state is its repository's pool of running processes,
keyed by the configured command, so drivers sharing a command share a
process, a submodule speaks to its own, and releasing the provider
(from repo_clear()) stops them.  The pool owns a copy of each command
string, so an entry outlives a config re-read.  A command that fails
stays as an entry that is not retried: its request and every later one
pass, so the store may serve the path for the rest of the command.

A protocol error in a response never kills the command.  The response
is read through a packet reader gentle about framing, so an error takes
one path: a single warning, the process stopped and marked failed, and
the builtin diff for the rest of the command.  That covers garbage
bytes, a truncated response, an empty packet, a bare status, and an
unrecognized status.  Semantically invalid coordinates cost only their
pair: the response is drained, the pair is computed, and the process
stays alive.  A path the protocol cannot carry (an embedded newline, or
one too long for a packet) falls back per path rather than costing the
command its process.  The handshake keeps one fatal check: a process
that announces a capability Git did not request aborts the command, as
the long-running filter protocol does.

Consulting is allowed per command, following the allow_textconv
precedent.  "git diff", "git log" and "git show", and "git blame" set
allow_diff_process; the plumbing diff commands and the interactive-patch
machinery never set it, so scripted and staging output stays builtin.
The options adjust the flag:

- --no-ext-diff clears it and --ext-diff sets it;
- --diff-process and --no-diff-process set and clear it alone, leaving
  external diff drivers as they were;
- format-patch clears it unconditionally, so a generated patch applies
  for recipients without the process;
- range-diff passes --no-ext-diff to the "git log" it compares.

git blame and the summary formats consult the process.  For blame, a
pair reported equivalent emits no hunks, so the whole commit passes to
its parent.  In the stat formats such a pair sums to a zero-count entry,
which the "nothing changed" rule omits, as under -w.  The subprocess is
long-running: one startup cost across a traversal, one round-trip per
consulted pair.  Answers travel in struct xdl_hunk, new in
xdiff-interface.h, holding xdiff's 1-based coordinates; nothing feeds
them back to xdiff, since only coordinate consumers consult.

A content-carrying request is the natural extension: it would serve
sides that are not stored blobs and processes that want content pushed
to them, and bring patch output and log -L's range tracking to the same
answer.  As it stands, a process's answers show in blame and the summary
formats while patch output stays builtin.

t4080 exercises the protocol, the per-command gate, and the error paths:

- each adversarial response shape warns and falls back to builtin, the
  request log proving which failures disable the process and which keep
  it alive (a malformed hunk line, coordinates past the blob size, a
  count overflowing strtol(), overlapping or misaligned hunks, an
  unrecognized status, a bare status, an empty packet, a mid-response
  crash, and raw garbage);
- a capability-less process and status=abort degrade without noise, and
  a failed start warns once and returns the path to the store;
- a trailing token on a hunk line is ignored, pinning field
  appendability;
- positive consults for git diff, git show, and diff-tree under
  --ext-diff and --diff-process; textconv output and gitlink sides are
  never identified; a diff.relative run consults by the repo-relative
  path;
- the equivalence answer is pinned from both consumers, and a warming
  run past a deferring process records the pair for a later read.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/config/diff.adoc           |   6 +
 Documentation/diff-algorithm-option.adoc |   3 +
 Documentation/diff-options.adoc          |  15 +-
 Documentation/gitattributes.adoc         | 160 ++++++
 Makefile                                 |   2 +
 blame.c                                  |  10 +-
 builtin/blame.c                          |   1 +
 builtin/diff.c                           |   1 +
 builtin/log.c                            |  11 +-
 diff-process.c                           | 669 +++++++++++++++++++++++
 diff-provider-internal.h                 |   1 +
 diff-provider.c                          |  12 +-
 diff-provider.h                          |  39 +-
 diff.c                                   |  42 +-
 diff.h                                   |   9 +
 meson.build                              |   1 +
 range-diff.c                             |   6 +
 t/helper/meson.build                     |   1 +
 t/helper/test-diff-process-backend.c     | 349 ++++++++++++
 t/helper/test-tool.c                     |   1 +
 t/helper/test-tool.h                     |   1 +
 t/meson.build                            |   1 +
 t/t4080-diff-process.sh                  | 593 ++++++++++++++++++++
 xdiff-interface.h                        |  12 +
 24 files changed, 1916 insertions(+), 30 deletions(-)
 create mode 100644 diff-process.c
 create mode 100644 t/helper/test-diff-process-backend.c
 create mode 100755 t/t4080-diff-process.sh

diff --git a/Documentation/config/diff.adoc b/Documentation/config/diff.adoc
index 1135a62a0a..349bdbe492 100644
--- a/Documentation/config/diff.adoc
+++ b/Documentation/config/diff.adoc
@@ -218,6 +218,12 @@ endif::git-diff[]
 	Set this option to `true` to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
 
+`diff.<driver>.process`::
+	The command to run as a long-running process that answers
+	which line ranges changed between two blobs.  See
+	linkgit:gitattributes[5] for the protocol and when it is
+	consulted.
+
 `diff.indentHeuristic`::
 	Set this option to `false` to disable the default heuristics
 	that shift diff hunk boundaries to make patches easier to read.
diff --git a/Documentation/diff-algorithm-option.adoc b/Documentation/diff-algorithm-option.adoc
index 8e3a0b63d7..16e6fc7261 100644
--- a/Documentation/diff-algorithm-option.adoc
+++ b/Documentation/diff-algorithm-option.adoc
@@ -18,3 +18,6 @@
 For instance, if you configured the `diff.algorithm` variable to a
 non-default value and want to use the default one, then you
 have to use `--diff-algorithm=default` option.
++
+Explicitly choosing a diff algorithm on the command line also
+bypasses `diff.<driver>.process` (see linkgit:gitattributes[5]).
diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index c8242e2462..cf359d88b4 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -833,7 +833,20 @@ endif::git-format-patch[]
 	to use this option with linkgit:git-log[1] and friends.
 
 `--no-ext-diff`::
-	Disallow external diff drivers.
+	Disallow external diff drivers and processes, including
+	`diff.<driver>.command` and `diff.<driver>.process`
+	(see linkgit:gitattributes[5]).
+
+`--diff-process`::
+`--no-diff-process`::
+	Allow (or forbid) consulting a diff process configured with
+	++diff.++__<driver>__++.process++ (see linkgit:gitattributes[5]),
+	leaving external diff drivers unaffected.  `git diff`, `git log`,
+	`git show`, and `git blame` allow consulting by default; the
+	plumbing diff commands forbid it unless this option or
+	`--ext-diff` is given.  linkgit:git-format-patch[1] accepts the
+	option but ignores it: a generated patch is always based on the
+	builtin diff.
 
 `--textconv`::
 `--no-textconv`::
diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index da773e2924..dd4fa0ad2d 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -832,6 +832,166 @@ NOTE: If `diff.<name>.command` is defined for path with the
 (see above), and adding `diff.<name>.algorithm` has no effect, as the
 algorithm is not passed to the external diff driver.
 
+Answering diffs from a long-running process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Unlike `diff.<name>.command`, which replaces the textual patch, the
+process configured in `diff.<name>.process` feeds hunks back into
+Git's own machinery:
+it answers "which line ranges changed between these two blobs", and
+Git's output is produced from that answer.  A process is started
+lazily, once per configured command string and per repository, and
+consulted over a pkt-line protocol (following the long-running filter
+process protocol; see the "Long Running Filter Process" section above
+for the filter analogue).
+
+The process is asked by object names alone: a request carries the
+pathname and the `old-oid`/`new-oid` of the blob pair, and no content.
+The pathname is the repository-relative old-side (preimage) path, not
+the shortened display path a `--relative` diff shows, so a driver
+scoped to a directory matches whatever directory the command runs from.
+This suits a process that keeps a persistent cache keyed on the pair, and
+a process that fetches the blobs itself (for example via
+`git cat-file --batch`) to compute its own notion of the changed
+lines.  Pairs with a side that is not a stored blob (a working-tree
+file, textconv output) are not sent; Git computes those itself.
+
+The exchange opens with a handshake: Git announces its role and
+version, the process replies in kind, and then Git lists the
+capabilities it supports and the process replies with the ones it
+implements.  A process that announces a capability Git did not list
+aborts the command.
+
+-----------------------
+packet:          git> git-diff-client
+packet:          git> version=1
+packet:          git> 0000
+packet:          git< git-diff-server
+packet:          git< version=1
+packet:          git< 0000
+packet:          git> capability=hunks-by-oid
+packet:          git> 0000
+packet:          git< capability=hunks-by-oid
+packet:          git< 0000
+-----------------------
+
+After the handshake, each request and response looks like:
+
+-----------------------
+packet:          git> command=hunks-by-oid
+packet:          git> pathname=path/file.c
+packet:          git> old-oid=<hex>
+packet:          git> new-oid=<hex>
+packet:          git> 0000
+packet:          git< hunk <old_start> <old_count> <new_start> <new_count>
+packet:          git< 0000
+packet:          git< status=success
+packet:          git< 0000
+-----------------------
+
+Start values are 1-based and counts are non-negative; a count of 0
+describes a pure insertion or deletion at the 1-based line the change
+sits before (a start of 0 is accepted for an empty file side).  Hunks
+must be listed in order, must not overlap, and must keep the unchanged
+runs between them the same length on both sides; Git validates this
+and, with a warning, falls back to its builtin diff on a response
+that violates these rules.
+
+A `status=success` response with zero hunks asserts that the blobs are
+equivalent, including their trailing newlines.  A process that cannot
+answer a pair from its object names (or cannot rule out a
+trailing-newline-only difference) responds `status=need-content`, and
+Git produces that pair's diff itself.  An asserted equivalence makes
+the pair vanish from the summary formats, but the pair still counts
+as changed for `--exit-code`, the same way a whitespace-only pair
+does under `-w`.
+
+The status names the disposition of the whole request.  Git
+understands three: `success` (the hunk lines are the answer),
+`need-content` (Git produces this pair's diff itself), and `abort`, which
+withdraws the capability the request used: Git stops sending
+`hunks-by-oid` requests to that process for the rest of the command,
+while the process stays alive for request forms negotiated under
+other capabilities.  Any other status is a protocol error: Git warns,
+stops the process, and uses the builtin diff for the remainder of the
+command.
+
+Every response has the same shape whatever its status: zero or more
+hunk lines, a flush packet, and a status packet terminated with a
+flush packet.  A response that carries no hunks, `need-content`
+included, still begins with the empty hunk section's flush packet; a
+bare status packet is a protocol error:
+
+-----------------------
+packet:          git< 0000
+packet:          git< status=need-content
+packet:          git< 0000
+-----------------------
+
+The process must read the entire request before it responds; Git
+writes the whole request before it reads the response.
+
+The protocol extends without breaking deployed processes: a process
+must ignore request keys it does not recognize, and Git ignores
+trailing space-separated tokens after the last field of a hunk line,
+so a later protocol version can append request keys and hunk fields.
+New request forms arrive as capabilities, which a process may decline
+to announce; announcing a capability Git did not request aborts the
+command, as it does under the long-running filter process protocol.
+
+There is no shutdown handshake: Git's side of the pipes closes when
+the command exits, and the process should exit when it reads EOF.  No
+flush point is guaranteed, so a process that maintains persistent
+state (such as a cache) should persist as it answers rather than at
+exit.  Git applies no timeout to a response; a process that hangs
+hangs the command, as with the long-running filter processes.
+
+`git blame` and the `--stat`, `--numstat`, and `--shortstat` formats
+consult the process; the textual patch and `git log -L` range
+tracking are produced by the builtin machinery, so a process whose
+answers deliberately differ from the builtin diff shows that
+difference only in blame and those formats.  `--dirstat=lines` routes
+through the diffstat path and consults; the other `--dirstat` modes do
+not.  A merge's `--stat` (including under `--cc`) is computed against
+the first parent, so it consults like any other stat; the combined
+patch itself compares one merge result against all of its parents at
+once, which the pairwise request above does not express, so that patch
+uses the builtin diff, and extending the protocol to combined diffs is
+left for future work.  A content-carrying extension of this
+protocol would bring patch output and `git log -L` range tracking to
+the same answer.
+
+Consulting is allowed per command, as with textconv: `git diff`,
+`git log` (`git whatchanged` included) and `git show`, and
+`git blame` consult a configured process; the plumbing diff commands
+do not unless `--ext-diff` or `--diff-process` is given explicitly,
+and the interactive-patch commands (`git add -p` and friends), which
+build the hunks they present from plumbing output, always stage from
+the builtin diff.  `git range-diff` generates the patches it
+compares with `--no-ext-diff`.  `--diff-process` and
+`--no-diff-process` allow or forbid only the consulting;
+`--no-ext-diff` disables all external diff mechanisms, this one
+included.  Options the process is never told about never select it:
+with the whitespace-ignoring options, `--ignore-matching-lines`, and
+`--anchored`, the pair is answered as when no process is configured.
+`--diff-algorithm` (or a configured `diff.algorithm`) forces a builtin
+algorithm and bypasses the process the same way.  A per-path
+++diff.++__<driver>__++.algorithm++ does so for `git diff` and the stat
+formats, which build their diff parameters from it; `git blame` builds
+its parameters from its own diff options, so a per-driver algorithm
+does not by itself keep blame from consulting the process.
+`git format-patch` never
+consults the process, so generated patches are always based on the
+builtin diff and apply for recipients without the process.  On a
+path whose driver has a process, the process is consulted before the
+diff-hunks store (see linkgit:git-diff-hunks[1]): a pair the process
+answers is never served from the store and never recorded into it.
+A pair the process does not answer, for example with
+`status=need-content`, gets the builtin diff, so the store may serve
+it and a warming run may record it: the store holds builtin results,
+and for such a pair the builtin result is what would be computed
+anyway.
+
 Defining a custom hunk-header
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/Makefile b/Makefile
index 11a06934b3..853e3cdacd 100644
--- a/Makefile
+++ b/Makefile
@@ -819,6 +819,7 @@ TEST_BUILTINS_OBJS += test-csprng.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delete-gpgsig.o
 TEST_BUILTINS_OBJS += test-delta.o
+TEST_BUILTINS_OBJS += test-diff-process-backend.o
 TEST_BUILTINS_OBJS += test-dir-iterator.o
 TEST_BUILTINS_OBJS += test-drop-caches.o
 TEST_BUILTINS_OBJS += test-dump-cache-tree.o
@@ -1151,6 +1152,7 @@ LIB_OBJS += diff-delta.o
 LIB_OBJS += diff-merges.o
 LIB_OBJS += diff-lib.o
 LIB_OBJS += diff-no-index.o
+LIB_OBJS += diff-process.o
 LIB_OBJS += diff-provider.o
 LIB_OBJS += diff.o
 LIB_OBJS += diffcore-break.o
diff --git a/blame.c b/blame.c
index 7d7671ef5d..3189bcdaba 100644
--- a/blame.c
+++ b/blame.c
@@ -2010,17 +2010,25 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	 * compute.  The working-tree/--contents pseudo-commit (marked by
 	 * its null commit id) holds a blob that is not a stored object,
 	 * so its pairs withhold identity too: no id may be sent that
-	 * names bytes a provider cannot look up.
+	 * names bytes a process cannot look up.
 	 */
 	provider_usable = !sb->reverse && !ignore_diffs &&
 		!is_null_oid(&target->commit->object.oid) &&
 		!blame_textconv_active(sb, target->path) &&
 		!blame_textconv_active(sb, parent->path);
 
+	/*
+	 * Look up the driver by the parent (old) path, as builtin_diff()
+	 * does with name_a, so a renamed file resolves to the same driver
+	 * across diff and blame.  A process that reports a pair
+	 * equivalent emits no hunks, so blame passes the whole commit
+	 * through and looks past it.
+	 */
 	if (provider_usable) {
 		req.old_oid = &parent->blob_oid;
 		req.new_oid = &target->blob_oid;
 	}
+	req.path = parent->path;
 	req.diffopt = &sb->revs->diffopt;
 	if (diff_provider_emit_hunks(&req, blame_diff_fill, &fill_data,
 				     blame_chunk_cb, &d) == DIFF_PROVIDER_ERROR)
diff --git a/builtin/blame.c b/builtin/blame.c
index 7891d82ae6..13e3ff9e36 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1025,6 +1025,7 @@ int cmd_blame(int argc,
 	repo_init_revisions(the_repository, &revs, NULL);
 	revs.date_mode = blame_date_mode;
 	revs.diffopt.flags.allow_textconv = 1;
+	revs.diffopt.flags.allow_diff_process = 1;
 	revs.diffopt.flags.follow_renames = 1;
 
 	save_commit_buffer = 0;
diff --git a/builtin/diff.c b/builtin/diff.c
index a2ad63ac8c..a39ffe69a4 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -510,6 +510,7 @@ int cmd_diff(int argc,
 	init_diffstat_widths(&rev.diffopt);
 	rev.diffopt.flags.allow_external = 1;
 	rev.diffopt.flags.allow_textconv = 1;
+	rev.diffopt.flags.allow_diff_process = 1;
 
 	/* If this is a no-index diff, just run it and exit there. */
 	if (no_index)
diff --git a/builtin/log.c b/builtin/log.c
index 0b72477f56..59ecd34334 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -209,6 +209,7 @@ static void cmd_log_init_defaults(struct rev_info *rev,
 	init_diffstat_widths(&rev->diffopt);
 	rev->diffopt.flags.recursive = 1;
 	rev->diffopt.flags.allow_textconv = 1;
+	rev->diffopt.flags.allow_diff_process = 1;
 	rev->abbrev_commit = cfg->default_abbrev_commit;
 	rev->show_root_diff = cfg->default_show_root;
 	rev->subject_prefix = cfg->fmt_patch_subject_prefix;
@@ -2226,11 +2227,15 @@ int cmd_format_patch(int argc,
 		die(_("unrecognized argument: %s"), argv[1]);
 
 	/*
-	 * A patch generated by format-patch carries the builtin diffstat,
-	 * not one served from a local store, so its counts do not depend
-	 * on whether the sender warmed the store.
+	 * Patches generated by format-patch must be based on the builtin
+	 * diff so recipients without the store or the process can apply
+	 * them, and so the emitted diffstat does not depend on the sender's
+	 * local cache: the precomputed-hunks store is not consulted for the
+	 * diffstat, and the diff process is not consulted even when
+	 * --ext-diff enables the external diff command.
 	 */
 	rev.diffopt.flags.no_precomputed_hunks = 1;
+	rev.diffopt.flags.allow_diff_process = 0;
 
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME)
 		die(_("--name-only does not make sense"));
diff --git a/diff-process.c b/diff-process.c
new file mode 100644
index 0000000000..121903a6c8
--- /dev/null
+++ b/diff-process.c
@@ -0,0 +1,669 @@
+/*
+ * The process provider of the hunk provider interface: consult a
+ * long-running external process via the pkt-line protocol for the
+ * hunks of a blob pair.  The process answers from the pair's object
+ * names alone: it can serve a persistent cache keyed on the pair, or
+ * fetch the blobs from the repository itself (e.g. via "git cat-file
+ * --batch") and compute its own notion of which lines changed.  The
+ * provider sits at the head of its repository's chain and gates
+ * itself per request; its state is the repository's pool of running
+ * processes, one per configured command, stopped when the provider
+ * is released.
+ *
+ * Protocol: pkt-line over stdin/stdout, following the pattern of
+ * the long-running filter process protocol (see convert.c).
+ *
+ * Handshake:
+ *   git> git-diff-client / version=1 / flush
+ *   process< git-diff-server / version=1 / flush
+ *   git> capability=hunks-by-oid / flush
+ *   process< capability=hunks-by-oid / flush
+ *
+ * Per-pair, when both sides are stored blobs:
+ *   git> command=hunks-by-oid / pathname=<path>
+ *   git> old-oid=<hex> / new-oid=<hex> / flush
+ *   process< hunk <old_start> <old_count> <new_start> <new_count>
+ *   process< ... / flush
+ *   process< status=success / flush
+ *
+ * No content is sent.  Because Git holds no content for the exchange,
+ * the answer is used as the process sent it: the hunks are not re-run
+ * through xdiff's compaction, and a status=success response with zero
+ * hunks asserts that the blobs are equivalent, including their
+ * trailing newlines.  A process that cannot answer from the object names
+ * (or cannot rule out a trailing-newline-only difference) responds
+ * status=need-content; the pair then gets the builtin answer, served
+ * from the diff-hunks store or computed.  A later
+ * protocol extension can define a content-carrying request for such
+ * processes and for sides that are not stored blobs.
+ */
+
+#include "git-compat-util.h"
+#include "diff.h"
+#include "diff-provider-internal.h"
+#include "gettext.h"
+#include "hex.h"
+#include "odb.h"
+#include "repository.h"
+#include "sigchain.h"
+#include "userdiff.h"
+#include "sub-process.h"
+#include "pkt-line.h"
+#include "strbuf.h"
+
+#define CAP_OID_HUNKS (1u << 0)
+
+/*
+ * The provider's state: the repository's diff processes, keyed by
+ * their command string, so drivers that configure the same command
+ * share one process.  An entry whose process failed stays in the
+ * pool with the failed bit set, so the command is not retried while
+ * the entry lives; the pool and its entries last until the provider
+ * is released.
+ */
+struct diff_process_state {
+	struct hashmap subprocesses;
+};
+
+struct diff_subprocess {
+	struct subprocess_entry subprocess;
+	/*
+	 * Owns the string subprocess.cmd and the hashmap key borrow: the
+	 * entry outlives the userdiff config a re-read may replace.
+	 */
+	char *cmd;
+	unsigned int supported_capabilities;
+	unsigned failed : 1;
+};
+
+static int start_diff_process_fn(struct subprocess_entry *subprocess)
+{
+	static int versions[] = { 1, 0 };
+	static struct subprocess_capability capabilities[] = {
+		{ "hunks-by-oid", CAP_OID_HUNKS },
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
+/*
+ * The pool entry for a command, or NULL when its process fails to
+ * start here: the failure leaves a failed entry in the pool, so only
+ * the request that observed it maps it to an error and later
+ * requests pass the provider by.
+ */
+static struct diff_subprocess *get_or_launch_process(
+		struct diff_process_state *state,
+		struct userdiff_driver *drv)
+{
+	struct subprocess_entry *running;
+	struct diff_subprocess *entry;
+
+	running = subprocess_find_entry(&state->subprocesses, drv->process);
+	if (running) {
+		entry = container_of(running, struct diff_subprocess,
+				     subprocess);
+		return entry->failed ? NULL : entry;
+	}
+
+	entry = xcalloc(1, sizeof(*entry));
+	entry->cmd = xstrdup(drv->process);
+	if (subprocess_start_command(&entry->subprocess, entry->cmd,
+				     start_diff_process_fn))
+		entry->failed = 1;
+	hashmap_entry_init(&entry->subprocess.ent, strhash(entry->cmd));
+	hashmap_add(&state->subprocesses, &entry->subprocess.ent);
+	if (entry->failed) {
+		warning(_("diff process '%s' failed to start;"
+			  " using the builtin diff"), drv->process);
+		return NULL;
+	}
+	return entry;
+}
+
+/*
+ * A hunk in the diff process's presentation coordinates: the line
+ * numbering it reports over the protocol.  Kept distinct from struct
+ * xdl_hunk (xdiff's coordinates) so that only translated hunks ever
+ * reach a consumer; diff_process_hunk_to_xdl() is the single
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
+ * "moved" marker) without an older Git rejecting the line, mirroring
+ * the request-side rule that processes ignore unknown keys.
+ *
+ * A value that overflows strtol() is not a parse failure: the line is
+ * well-formed, so the stream stays in protocol sync.  It is reported
+ * through *out_of_range, and the caller skips the pair the same way
+ * it skips any other out-of-range coordinate.
+ */
+static int parse_hunk_field(const char **line, long *out, int is_last,
+			    int *out_of_range)
+{
+	const char *p = *line;
+	char *end;
+
+	if (!isdigit((unsigned char)*p))
+		return -1;
+	errno = 0;
+	*out = strtol(p, &end, 10);
+	if (end == p)
+		return -1;
+	if (errno == ERANGE)
+		*out_of_range = 1;
+	else if (errno)
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
+			   struct diff_process_hunk *presented,
+			   int *out_of_range)
+{
+	*out_of_range = 0;
+	/* Format: "hunk <old_start> <old_count> <new_start> <new_count>" */
+	if (!skip_prefix(line, "hunk ", &line))
+		return -1;
+	if (parse_hunk_field(&line, &presented->old_start, 0, out_of_range) ||
+	    parse_hunk_field(&line, &presented->old_count, 0, out_of_range) ||
+	    parse_hunk_field(&line, &presented->new_start, 0, out_of_range) ||
+	    parse_hunk_field(&line, &presented->new_count, 1, out_of_range))
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
+ * any consumer of these coordinates may assume 1-based starts.
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
+/*
+ * Validate the process's hunks (already in xdiff coordinates) before they
+ * bypass the diff algorithm.  The content-independent rules (in-order,
+ * non-overlapping, lockstep-aligned, int32-bounded coordinates) are the
+ * provider interface's shared rule, diff_provider_check_hunk(); this
+ * function adds the two checks that need the blobs' line counts (a hunk
+ * past the end of a file, the run after the last hunk) and the
+ * per-rule diagnostics naming the process.  On a bad response we warn
+ * and the caller falls back to the builtin diff.  Returns 0 if valid,
+ * -1 (after warning) otherwise.
+ *
+ * old_lines/new_lines bound the line count of each side, or are
+ * negative when no bound is known.  An oid-only answer arrives without
+ * content, so its caller passes upper bounds derived from the blobs'
+ * byte sizes, which caps coordinate magnitude but cannot support the
+ * run-after-the-last-hunk check: that one compares exact line counts,
+ * so it runs only when lines_exact is set, which no caller does today.
+ * It is kept for a content-carrying request, whose loaded buffers
+ * would provide exact counts.
+ */
+static int validate_external_hunks(const struct xdl_hunk *hunks, size_t nr,
+				   long old_lines, long new_lines,
+				   int lines_exact,
+				   const char *process, const char *path)
+{
+	struct diff_provider_hunks_check c = { 0 };
+	size_t i;
+
+	for (i = 0; i < nr; i++) {
+		const struct xdl_hunk *h = &hunks[i];
+
+		if (old_lines >= 0 &&
+		    (h->old_count > old_lines - h->old_start + 1 ||
+		     h->new_count > new_lines - h->new_start + 1)) {
+			warning(_("diff process '%s' returned a hunk past the "
+				  "end of '%s'; using the builtin diff"),
+				process, path);
+			return -1;
+		}
+		switch (diff_provider_check_hunk(&c, h->old_start,
+						  h->old_count, h->new_start,
+						  h->new_count)) {
+		case DIFF_PROVIDER_HUNKS_OK:
+			break;
+		case DIFF_PROVIDER_HUNKS_RANGE:
+			warning(_("diff process '%s' returned out-of-range "
+				  "coordinates for '%s'; using the builtin diff"),
+				process, path);
+			return -1;
+		case DIFF_PROVIDER_HUNKS_OVERLAP:
+			warning(_("diff process '%s' returned overlapping hunks "
+				  "for '%s'; using the builtin diff"),
+				process, path);
+			return -1;
+		case DIFF_PROVIDER_HUNKS_MISALIGNED:
+			warning(_("diff process '%s' returned hunks that leave "
+				  "'%s' misaligned; using the builtin diff"),
+				process, path);
+			return -1;
+		}
+	}
+	if (lines_exact &&
+	    old_lines - c.prev_old_end != new_lines - c.prev_new_end) {
+		warning(_("diff process '%s' returned hunks that leave '%s' "
+			  "misaligned; using the builtin diff"),
+			process, path);
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * The most lines a blob can hold, from its size alone: every line,
+ * even an empty one, costs at least one byte, so a blob of N bytes
+ * holds at most N lines.  Returns -1 when the size is unavailable,
+ * leaving the response bounded only by the shared int32 rule.  A size
+ * beyond INT32_MAX clamps to it, which loses nothing: a coordinate
+ * that large fails the shared rule anyway.  In a partial clone the
+ * size lookup must not fetch the blob from the promisor remote:
+ * validating an answer that exists to avoid loading content must not
+ * itself download that content, so a missing blob reads as size
+ * unavailable instead.
+ */
+static long blob_line_cap(struct repository *r, const struct object_id *oid)
+{
+	unsigned long size;
+	struct object_info oi = OBJECT_INFO_INIT;
+
+	oi.sizep = &size;
+	if (odb_read_object_info_extended(r->objects, oid, &oi,
+					  OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
+		return -1;
+	if (size > INT32_MAX)
+		return INT32_MAX;
+	return (long)size;
+}
+
+/*
+ * The driver whose process a consultation for path would ask, or NULL
+ * when none applies (no driver, process not allowed, or xpp carries
+ * options the process is never told about).  Needs no content, so
+ * the driver is picked before any blob is loaded.
+ */
+static struct userdiff_driver *diff_process_driver(struct diff_options *diffopt,
+						   const char *path,
+						   const xpparam_t *xpp)
+{
+	struct userdiff_driver *drv;
+
+	if (!diffopt || !path)
+		return NULL;
+	if (!diffopt->flags.allow_diff_process || diffopt->ignore_driver_algorithm)
+		return NULL;
+	/*
+	 * Whitespace-ignoring, regex-ignore (-I) and anchored options
+	 * change which lines count as different, but the process is never
+	 * told about them, so its hunks could not honor them.  A forced
+	 * diff algorithm (an option or configured algorithm setting)
+	 * requests a specific builtin computation, which an
+	 * authoritative answer would override.  Rather than silently
+	 * override the user's request, fall back to the builtin diff,
+	 * which does honor these flags.  Key this off xpp (the
+	 * parameters this diff actually runs with) rather than diffopt,
+	 * so a caller like blame, which keeps its algorithm and
+	 * whitespace flags outside diffopt, is covered without a
+	 * separate guard of its own.
+	 */
+	if ((xpp->flags & (XDF_WHITESPACE_FLAGS | XDF_IGNORE_BLANK_LINES |
+			   XDF_DIFF_ALGORITHM_MASK)) ||
+	    xpp->ignore_regex_nr || xpp->anchors_nr)
+		return NULL;
+
+	/*
+	 * A path the protocol cannot carry never selects a process: an
+	 * embedded newline would let the rest of the path forge further
+	 * request keys, and the pathname must fit one packet.  Passing
+	 * here keeps the cost local to the path; a failed write would
+	 * instead cost the whole command its process.
+	 */
+	if (strchr(path, '\n') ||
+	    strlen(path) > LARGE_PACKET_DATA_MAX - strlen("pathname=\n"))
+		return NULL;
+
+	drv = userdiff_find_by_path(diffopt->repo->index, path);
+	if (!drv || !drv->process)
+		return NULL;
+	return drv;
+}
+
+/*
+ * Without content there is no size-derived bound on a response, so cap
+ * accumulation at a constant instead.  A response that exceeds the
+ * cap is a protocol error: the process is disabled for the rest of
+ * the command and the caller falls back to the builtin diff.
+ */
+#define OID_HUNKS_MAX (1 << 20)
+
+enum diff_process_result {
+	DIFF_PROCESS_ERROR = -1, /* failed; caller falls back to builtin */
+	DIFF_PROCESS_OK = 0,     /* the process supplied hunks */
+	DIFF_PROCESS_SKIP,       /* process did not apply: use builtin */
+	DIFF_PROCESS_EQUIVALENT, /* process says files are equivalent */
+};
+
+/*
+ * Ask drv's diff process to answer the request from the blob pair's
+ * object ids alone (the "hunks-by-oid" capability): no content is
+ * loaded or sent.  On DIFF_PROCESS_OK the process's hunks are emitted
+ * through hunk_cb in 0-based emission coordinates, validated for order,
+ * overlap, and lockstep alignment first; because Git holds no content,
+ * the answer is used as the process sent it, without xdiff's compaction.
+ * DIFF_PROCESS_EQUIVALENT means the process asserts the pair equal.
+ * DIFF_PROCESS_SKIP covers everything that should fall through to the
+ * builtin computation: a missing capability, a missing object id, a
+ * status=need-content answer, or an invalid response.
+ */
+static enum diff_process_result diff_process_query_hunks(
+		struct diff_process_state *state,
+		struct userdiff_driver *drv,
+		const struct diff_provider_request *req,
+		xdl_emit_hunk_consume_func_t hunk_cb,
+		void *cb_data)
+{
+	const char *path = req->path;
+	struct diff_subprocess *entry;
+	struct child_process *process;
+	int fd_in, fd_out;
+	struct packet_reader reader;
+	struct strbuf status = STRBUF_INIT;
+	struct xdl_hunk *hunks = NULL;
+	struct diff_process_hunk presented;
+	struct xdl_hunk hunk;
+	size_t nr_hunks = 0, alloc_hunks = 0, i;
+	int bad_coords = 0;
+	long old_cap, new_cap;
+	enum diff_process_result res;
+
+	if (!req->old_oid || !req->new_oid)
+		return DIFF_PROCESS_SKIP;
+
+	entry = get_or_launch_process(state, drv);
+	if (!entry)
+		return DIFF_PROCESS_ERROR;
+	if (!(entry->supported_capabilities & CAP_OID_HUNKS))
+		return DIFF_PROCESS_SKIP;
+
+	process = subprocess_get_child_process(&entry->subprocess);
+	fd_in = process->in;
+	fd_out = process->out;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	if (packet_write_fmt_gently(fd_in, "command=hunks-by-oid\n") ||
+	    packet_write_fmt_gently(fd_in, "pathname=%s\n", path) ||
+	    packet_write_fmt_gently(fd_in, "old-oid=%s\n",
+				    oid_to_hex(req->old_oid)) ||
+	    packet_write_fmt_gently(fd_in, "new-oid=%s\n",
+				    oid_to_hex(req->new_oid)) ||
+	    packet_flush_gently(fd_in))
+		goto comm_error;
+
+	packet_reader_init(&reader, fd_out, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_GENTLE_ON_READ_ERROR);
+	for (;;) {
+		enum packet_read_status rs = packet_reader_read(&reader);
+		int out_of_range;
+
+		if (rs == PACKET_READ_FLUSH)
+			break;
+		/*
+		 * Only a hunk line may precede the flush.  EOF and a
+		 * malformed frame end the session; an empty packet, which
+		 * a length-only read cannot tell from a flush, would
+		 * truncate the hunk section here and leave the status
+		 * section to poison the next request, so it is a protocol
+		 * error too.
+		 */
+		if (rs != PACKET_READ_NORMAL || !reader.pktlen)
+			goto comm_error;
+		if (parse_hunk_line(reader.line, &presented,
+				    &out_of_range) < 0)
+			goto comm_error;
+		if (bad_coords)
+			continue;
+		if (out_of_range ||
+		    diff_process_hunk_to_xdl(&presented, &hunk) < 0) {
+			/*
+			 * Semantically invalid coordinates in a well-formed
+			 * response: the stream stays in protocol sync, so
+			 * drain the rest and fall back for this file while
+			 * keeping the process alive, the same treatment
+			 * validate_external_hunks() failures receive.
+			 */
+			bad_coords = 1;
+			continue;
+		}
+		if (nr_hunks >= OID_HUNKS_MAX) {
+			warning(_("diff process '%s' sent too many hunks"
+				  " for '%s'; disabling it for the"
+				  " remainder of this command"),
+				drv->process, path);
+			goto disable;
+		}
+		ALLOC_GROW(hunks, nr_hunks + 1, alloc_hunks);
+		hunks[nr_hunks++] = hunk;
+	}
+
+	if (subprocess_read_status_gently(fd_out, &status))
+		goto comm_error;
+
+	if (!strcmp(status.buf, "success")) {
+		if (bad_coords) {
+			warning(_("diff process '%s' returned out-of-range "
+				  "coordinates for '%s'; using the builtin diff"),
+				drv->process, path);
+			res = DIFF_PROCESS_SKIP;
+			goto out;
+		}
+		if (!nr_hunks) {
+			res = DIFF_PROCESS_EQUIVALENT;
+			goto out;
+		}
+		/*
+		 * Bound the coordinates by the blobs' sizes, read from the
+		 * object database without loading content.  Either both
+		 * bounds hold or neither is applied: a partial bound would
+		 * misclassify a response that the other side's size would
+		 * have caught.
+		 */
+		old_cap = blob_line_cap(req->repo, req->old_oid);
+		new_cap = blob_line_cap(req->repo, req->new_oid);
+		if (old_cap < 0 || new_cap < 0)
+			old_cap = new_cap = -1;
+		if (validate_external_hunks(hunks, nr_hunks, old_cap, new_cap,
+					    0, drv->process, path) < 0) {
+			res = DIFF_PROCESS_SKIP;
+			goto out;
+		}
+		/*
+		 * Replay in the coordinates a hunk consumer receives from
+		 * xdiff's emission: 0-based starts.  The answer is used as
+		 * the process sent it; with no content in hand it cannot be
+		 * re-run through xdiff's compaction.
+		 */
+		for (i = 0; i < nr_hunks; i++)
+			hunk_cb(hunks[i].old_start - 1, hunks[i].old_count,
+				hunks[i].new_start - 1, hunks[i].new_count,
+				cb_data);
+		res = DIFF_PROCESS_OK;
+		goto out;
+	}
+	if (!strcmp(status.buf, "need-content")) {
+		/*
+		 * The process cannot answer this pair from its object names;
+		 * the caller computes the diff itself.
+		 */
+		res = DIFF_PROCESS_SKIP;
+		goto out;
+	}
+	if (!strcmp(status.buf, "abort")) {
+		/* The process withdrew: stop asking it for this session. */
+		entry->supported_capabilities &= ~CAP_OID_HUNKS;
+		res = DIFF_PROCESS_SKIP;
+		goto out;
+	}
+	/*
+	 * An unrecognized status is a protocol error, not a per-pair
+	 * failure: this Git did not request anything it does not know,
+	 * so the process is answering some other protocol, and asking
+	 * it again would warn on every pair of the traversal.
+	 */
+	warning(_("diff process '%s' sent unrecognized status '%s' for "
+		  "'%s'; disabling it for the remainder of this command"),
+		drv->process, status.buf, path);
+	goto disable;
+out:
+	free(hunks);
+	strbuf_release(&status);
+	sigchain_pop(SIGPIPE);
+	return res;
+
+comm_error:
+	warning(_("diff process '%s' failed for '%s'; disabling it"
+		  " for the remainder of this command"),
+		drv->process, path);
+disable:
+	subprocess_stop_command(&entry->subprocess);
+	entry->failed = 1;
+	free(hunks);
+	strbuf_release(&status);
+	sigchain_pop(SIGPIPE);
+	return DIFF_PROCESS_ERROR;
+}
+
+/*
+ * The process outranks every later provider through its chain
+ * position: when it answers, the walk ends, so no later provider
+ * serves the pair, and an answered pair is never recorded.  When it
+ * does not answer (it defers with need-content, lacks the
+ * capability, or failed), the caller computes the builtin diff for
+ * that pair.  The store holds builtin results and nothing else, so
+ * an identity answer for such a pair equals what the caller would
+ * compute.  Every non-answer is therefore a pass: a refusal would
+ * suppress that equal answer, and would keep a warming run from
+ * recording the builtin result the caller computes anyway.
+ */
+static enum diff_provider_disposition
+diff_process_consult(struct diff_provider *provider,
+		     const struct diff_provider_request *req,
+		     diff_provider_fill_fn fill UNUSED, void *fill_data UNUSED,
+		     xdl_emit_hunk_consume_func_t hunk_cb, void *cb_data)
+{
+	struct diff_process_state *state = provider->state;
+	struct userdiff_driver *drv;
+	struct subprocess_entry *running;
+
+	drv = diff_process_driver(req->diffopt, req->path, req->xpp);
+	if (!drv)
+		return DIFF_PROVIDER_DISP_PASS;
+	running = subprocess_find_entry(&state->subprocesses, drv->process);
+	if (running && container_of(running, struct diff_subprocess,
+				    subprocess)->failed)
+		return DIFF_PROVIDER_DISP_PASS;
+
+	switch (diff_process_query_hunks(state, drv, req,
+					 hunk_cb, cb_data)) {
+	case DIFF_PROCESS_OK:
+	case DIFF_PROCESS_EQUIVALENT:
+		return DIFF_PROVIDER_DISP_ANSWERED;
+	case DIFF_PROCESS_SKIP:
+	case DIFF_PROCESS_ERROR:
+		break;
+	}
+	return DIFF_PROVIDER_DISP_PASS;
+}
+
+static void diff_process_release(struct diff_provider *provider)
+{
+	struct diff_process_state *state = provider->state;
+	struct hashmap_iter iter;
+	struct diff_subprocess *entry;
+
+	/* A failed entry's process is already stopped or never ran. */
+	hashmap_for_each_entry(&state->subprocesses, &iter, entry,
+			       subprocess.ent) {
+		if (!entry->failed)
+			subprocess_stop_command(&entry->subprocess);
+		free(entry->cmd);
+	}
+	hashmap_clear_and_free(&state->subprocesses,
+			       struct diff_subprocess, subprocess.ent);
+	free(state);
+}
+
+struct diff_provider *diff_process_provider_new(void)
+{
+	struct diff_process_state *state = xcalloc(1, sizeof(*state));
+	struct diff_provider *p = xcalloc(1, sizeof(*p));
+
+	hashmap_init(&state->subprocesses, cmd2process_cmp, NULL, 0);
+	p->consult = diff_process_consult;
+	p->release = diff_process_release;
+	p->state = state;
+	return p;
+}
diff --git a/diff-provider-internal.h b/diff-provider-internal.h
index 8ad3e481e7..cba1fa271a 100644
--- a/diff-provider-internal.h
+++ b/diff-provider-internal.h
@@ -93,6 +93,7 @@ struct diff_provider {
  * diff-provider.c holds itself.  Each call returns a fresh provider
  * for one repository's chain.
  */
+struct diff_provider *diff_process_provider_new(void);
 struct diff_provider *diff_hunks_store_provider_new(void);
 
 /*
diff --git a/diff-provider.c b/diff-provider.c
index 66a9909eaa..c8aaf8e857 100644
--- a/diff-provider.c
+++ b/diff-provider.c
@@ -41,11 +41,11 @@ static struct diff_provider *builtin_provider_new(void)
 
 /*
  * The repository's chain, assembled on first walk.  The composition
- * is fixed, and the order is the authority resolution: the store is
- * consulted before the builtin computation, the terminal provider,
- * so the chain always ends in an implementor that can answer.
- * Nothing is decided per repository here; each provider gates itself
- * per request.
+ * is fixed, and the order is the authority resolution: the process
+ * outranks the store, and the builtin computation is the terminal
+ * provider, so the chain always ends in an implementor that can
+ * answer.  Nothing is decided per repository here; each provider
+ * gates itself per request.
  */
 static struct diff_provider *provider_chain(struct repository *r)
 {
@@ -53,6 +53,8 @@ static struct diff_provider *provider_chain(struct repository *r)
 
 	if (*tail)
 		return *tail;
+	*tail = diff_process_provider_new();
+	tail = &(*tail)->next;
 	*tail = diff_hunks_store_provider_new();
 	tail = &(*tail)->next;
 	*tail = builtin_provider_new();
diff --git a/diff-provider.h b/diff-provider.h
index c5478b5700..061e1c2f5c 100644
--- a/diff-provider.h
+++ b/diff-provider.h
@@ -11,19 +11,23 @@
  * its content is loaded.
  *
  * A hunk provider answers a consumer's request from the pair's
- * identity (its blob object ids) and the parameters that determine
- * the diff; a request no provider answers falls through to the
- * consumer's own computation.  A provider is either authoritative for
- * its requests, meaning its answer may deliberately differ from the
- * builtin diff, or not, meaning its answer must reproduce the builtin
- * result exactly.  The interface resolves that authority through a
- * provider chain owned by the repository, built on first consultation
- * and released by repo_clear(): chain order is the resolution, and
- * the builtin computation itself is the chain's terminal provider.  A
- * consumer never names a provider; it reads the outcome below.
- * Every answer a provider serves from identity passes the shared
- * coordinate check (diff-provider-internal.h) before any consumer
- * sees it.
+ * identity, its blob object ids and the settings that determine the
+ * diff, before any content is loaded; a request no provider answers
+ * falls through to the consumer's own computation.  Two providers implement this
+ * interface with different authority.  The diff-hunks store
+ * (diff-hunks.h) is in-process and not authoritative: it may only
+ * reproduce the builtin result, so it never asserts a pair
+ * equivalent, and it stands aside wherever a process outranks it.  A
+ * process configured in diff.<driver>.process (diff-process.c) is
+ * authoritative for its paths: its answer may deliberately differ
+ * from the builtin diff, including asserting a pair equivalent.  The
+ * interface resolves that authority through a provider chain owned
+ * by the repository, built on first consultation and released by
+ * repo_clear(): chain order is the resolution, and the builtin
+ * computation itself is the chain's terminal provider.  A consumer
+ * never names a provider; it reads the outcome below.  Every answer a
+ * provider serves from identity passes the shared coordinate check
+ * (diff-provider-internal.h) before any consumer sees it.
  */
 
 struct diff_options;
@@ -95,14 +99,17 @@ enum diff_provider_outcome {
  * name the blobs whose bytes are diffed; pass NULL for a side whose
  * bytes are not a stored blob (a working-tree file, textconv output,
  * a gitlink), so no provider answers from an id it cannot look up.
- * diffopt carries the diff settings that live outside xpp; xpp
- * carries the parameters the diff runs with.  Each provider gates
- * itself on the fields that concern it.
+ * path names the file the pair is diffed as; a provider selected by
+ * path applies only where it is set.  diffopt carries the diff
+ * settings that live outside xpp; xpp carries the parameters the
+ * diff runs with.  Each provider gates itself on the fields that
+ * concern it.
  */
 struct diff_provider_request {
 	struct repository *repo;
 	const struct object_id *old_oid;
 	const struct object_id *new_oid;
+	const char *path;
 	struct diff_options *diffopt;
 	const xpparam_t *xpp;
 };
diff --git a/diff.c b/diff.c
index 0d4cb3fcfd..ea79d80c26 100644
--- a/diff.c
+++ b/diff.c
@@ -4377,6 +4377,13 @@ static int diffstat_from_hunks(struct diff_options *o,
 			   &one->oid : NULL,
 		.new_oid = (two->oid_valid && !S_ISGITLINK(two->mode)) ?
 			   &two->oid : NULL,
+		/*
+		 * Attribute lookup and the process protocol need the
+		 * repo-relative path; the display name a caller passes
+		 * around may be stripped of o->prefix and would miss a
+		 * driver scoped to a directory.
+		 */
+		.path = one->path,
 		.diffopt = o,
 		.xpp = &xpp,
 	};
@@ -4491,12 +4498,14 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 	else if (may_differ) {
 		/*
-		 * Serve or record via the diff-hunks store. A "log -L"
+		 * Serve from a hunk provider (the process, then the store),
+		 * or record into the store on a warming run. A "log -L"
 		 * range-scoped stat is not the whole-pair diff the store
 		 * keys, so it neither reads nor records. Otherwise diff
 		 * normally.
 		 */
-		if (p->line_ranges || !diffstat_from_hunks(o, one, two, data)) {
+		if (p->line_ranges ||
+		    !diffstat_from_hunks(o, one, two, data)) {
 			/* Crazy xdl interfaces.. */
 			xpparam_t xpp;
 			xdemitconf_t xecfg;
@@ -6252,6 +6261,27 @@ static int diff_opt_submodule(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_ext_diff(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	options->flags.allow_external = !unset;
+	options->flags.allow_diff_process = !unset;
+	return 0;
+}
+
+static int diff_opt_diff_process(const struct option *opt,
+				 const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	options->flags.allow_diff_process = !unset;
+	return 0;
+}
+
 static int diff_opt_textconv(const struct option *opt,
 			     const char *arg, int unset)
 {
@@ -6582,8 +6612,12 @@ struct option *add_diff_options(const struct option *opts,
 			 N_("exit with 1 if there were differences, 0 otherwise")),
 		OPT_BOOL(0, "quiet", &options->flags.quick,
 			 N_("disable all output of the program")),
-		OPT_BOOL(0, "ext-diff", &options->flags.allow_external,
-			 N_("allow an external diff helper to be executed")),
+		OPT_CALLBACK_F(0, "ext-diff", options, NULL,
+			       N_("allow an external diff helper to be executed"),
+			       PARSE_OPT_NOARG, diff_opt_ext_diff),
+		OPT_CALLBACK_F(0, "diff-process", options, NULL,
+			       N_("allow a configured diff process to be consulted"),
+			       PARSE_OPT_NOARG, diff_opt_diff_process),
 		OPT_CALLBACK_F(0, "textconv", options, NULL,
 			       N_("run external text conversion filters when comparing binary files"),
 			       PARSE_OPT_NOARG, diff_opt_textconv),
diff --git a/diff.h b/diff.h
index 380a258878..e0b58a8105 100644
--- a/diff.h
+++ b/diff.h
@@ -173,6 +173,15 @@ struct diff_flags {
 	 */
 	unsigned allow_external;
 
+	/**
+	 * Allows diff.<driver>.process to be consulted.  Set by the
+	 * porcelain commands whose output may reflect a diff process
+	 * (diff, log, show, blame) and by --ext-diff or --diff-process;
+	 * plumbing does not set it by default, so its output stays
+	 * builtin.  Cleared by --no-ext-diff or --no-diff-process.
+	 */
+	unsigned allow_diff_process;
+
 	/**
 	 * For communication between the calling program and the options parser;
 	 * tell the calling program to signal the presence of difference using
diff --git a/meson.build b/meson.build
index 391d9da93c..6d6ac8e753 100644
--- a/meson.build
+++ b/meson.build
@@ -356,6 +356,7 @@ libgit_sources = [
   'diff-merges.c',
   'diff-lib.c',
   'diff-no-index.c',
+  'diff-process.c',
   'diff-provider.c',
   'diff.c',
   'diffcore-break.c',
diff --git a/range-diff.c b/range-diff.c
index 8e2dd2eb19..3cadbcd7e1 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -52,6 +52,12 @@ static int read_patches(const char *range, struct string_list *list,
 	int ret = -1;
 
 	strvec_pushl(&cp.args, "log", "--no-color", "-p",
+		     /*
+		      * The patches being compared must be the builtin
+		      * diff's: an external diff command or diff process
+		      * could change either side of the comparison.
+		      */
+		     "--no-ext-diff",
 		     "--reverse", "--date-order", "--decorate=no",
 		     "--no-prefix", "--submodule=short",
 		     /*
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
index 0000000000..b0bb78d9f3
--- /dev/null
+++ b/t/helper/test-diff-process-backend.c
@@ -0,0 +1,349 @@
+/*
+ * Test process implementing the diff process protocol (diff.<driver>.process).
+ *
+ * Speaks the long-running process protocol over stdin/stdout and
+ * answers command=hunks-by-oid requests from the blob object names
+ * alone; no content is exchanged.  The --mode= switch selects the
+ * response shape:
+ *
+ *   oid-fixed         packet: git< hunk 5 2 5 2
+ *   oid-equal         packet: git< status=success (zero hunks: equivalent)
+ *   oid-need-content  packet: git< status=need-content
+ *   oid-empty         packet: git< hunk 0 0 1 2 (empty old side)
+ *
+ * and the adversarial shapes the protocol error paths are tested
+ * with:
+ *
+ *   oid-trailing        a hunk line with a trailing token to ignore
+ *   oid-malformed       a hunk line that does not parse
+ *   oid-huge            coordinates far past the end of any test blob
+ *   oid-erange          a count too large for any long
+ *   oid-overlap         two hunks out of order
+ *   oid-misaligned      two hunks whose unchanged runs differ in length
+ *   oid-badstart        a start of 0 paired with a nonzero count
+ *   oid-unknown-status  status=frobnicate
+ *   oid-abort           status=abort
+ *   oid-bare-status     a status packet without the hunk-section flush
+ *   oid-empty-packet    an empty packet (0004) inside the hunk section
+ *   oid-crash           one hunk line, then exit with no flush or status
+ *   oid-garbage         raw non-pkt-line bytes, then exit
+ *   cap-none            handshake announcing no capability at all
+ *
+ * Success responses end with:
+ *
+ *   packet:          git< 0000
+ *   packet:          git< status=success
+ *   packet:          git< 0000
+ *
+ * Each request is logged to --log as:
+ *
+ *   command=<cmd> pathname=<path> old-oid=<hex> new-oid=<hex>
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
+	MODE_OID_FIXED,
+	MODE_OID_EQUAL,
+	MODE_OID_NEED_CONTENT,
+	MODE_OID_EMPTY,
+	MODE_OID_TRAILING,
+	MODE_OID_MALFORMED,
+	MODE_OID_HUGE,
+	MODE_OID_ERANGE,
+	MODE_OID_OVERLAP,
+	MODE_OID_MISALIGNED,
+	MODE_OID_BADSTART,
+	MODE_OID_UNKNOWN_STATUS,
+	MODE_OID_ABORT,
+	MODE_OID_BARE_STATUS,
+	MODE_OID_EMPTY_PACKET,
+	MODE_OID_CRASH,
+	MODE_OID_GARBAGE,
+	MODE_CAP_NONE,
+};
+
+static enum mode parse_mode(const char *s)
+{
+	if (!strcmp(s, "oid-fixed"))
+		return MODE_OID_FIXED;
+	if (!strcmp(s, "oid-equal"))
+		return MODE_OID_EQUAL;
+	if (!strcmp(s, "oid-need-content"))
+		return MODE_OID_NEED_CONTENT;
+	if (!strcmp(s, "oid-empty"))
+		return MODE_OID_EMPTY;
+	if (!strcmp(s, "oid-trailing"))
+		return MODE_OID_TRAILING;
+	if (!strcmp(s, "oid-malformed"))
+		return MODE_OID_MALFORMED;
+	if (!strcmp(s, "oid-huge"))
+		return MODE_OID_HUGE;
+	if (!strcmp(s, "oid-erange"))
+		return MODE_OID_ERANGE;
+	if (!strcmp(s, "oid-overlap"))
+		return MODE_OID_OVERLAP;
+	if (!strcmp(s, "oid-misaligned"))
+		return MODE_OID_MISALIGNED;
+	if (!strcmp(s, "oid-badstart"))
+		return MODE_OID_BADSTART;
+	if (!strcmp(s, "oid-unknown-status"))
+		return MODE_OID_UNKNOWN_STATUS;
+	if (!strcmp(s, "oid-abort"))
+		return MODE_OID_ABORT;
+	if (!strcmp(s, "oid-bare-status"))
+		return MODE_OID_BARE_STATUS;
+	if (!strcmp(s, "oid-empty-packet"))
+		return MODE_OID_EMPTY_PACKET;
+	if (!strcmp(s, "oid-crash"))
+		return MODE_OID_CRASH;
+	if (!strcmp(s, "oid-garbage"))
+		return MODE_OID_GARBAGE;
+	if (!strcmp(s, "cap-none"))
+		return MODE_CAP_NONE;
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
+static void send_status(const char *status)
+{
+	packet_flush(1);
+	packet_write_fmt(1, "%s\n", status);
+	packet_flush(1);
+}
+
+static void command_loop(enum mode mode)
+{
+	for (;;) {
+		char *command = NULL, *pathname = NULL;
+		char *old_oid = NULL, *new_oid = NULL;
+
+		if (!read_request_header(&command, &pathname,
+					 &old_oid, &new_oid))
+			break; /* EOF: Git closed its end */
+
+		if (!command || strcmp(command, "hunks-by-oid"))
+			die("unexpected command: '%s'",
+			    command ? command : "(none)");
+
+		if (logfile) {
+			fprintf(logfile,
+				"command=%s pathname=%s old-oid=%s new-oid=%s\n",
+				command,
+				pathname ? pathname : "(none)",
+				old_oid ? old_oid : "(none)",
+				new_oid ? new_oid : "(none)");
+			fflush(logfile);
+		}
+
+		switch (mode) {
+		case MODE_OID_FIXED:
+			packet_write_fmt(1, "hunk 5 2 5 2\n");
+			send_status("status=success");
+			break;
+		case MODE_OID_EQUAL:
+			send_status("status=success");
+			break;
+		case MODE_OID_EMPTY:
+			/*
+			 * An empty old side: the "git diff" convention
+			 * addresses it with a start of 0 and a count of 0.
+			 * Claims two lines added, fewer than the builtin
+			 * would show, so the answer is observable.
+			 */
+			packet_write_fmt(1, "hunk 0 0 1 2\n");
+			send_status("status=success");
+			break;
+		case MODE_OID_TRAILING:
+			/*
+			 * Git must ignore trailing space-separated tokens
+			 * on a hunk line (the appendability rule), so this
+			 * must behave exactly like oid-fixed.
+			 */
+			packet_write_fmt(1, "hunk 5 2 5 2 moved=yes\n");
+			send_status("status=success");
+			break;
+		case MODE_OID_MALFORMED:
+			packet_write_fmt(1, "hunk five two 5 2\n");
+			send_status("status=success");
+			break;
+		case MODE_OID_HUGE:
+			/*
+			 * In-range for int32 (and for a 32-bit long), so
+			 * only the blob-size bound can reject it.
+			 */
+			packet_write_fmt(1, "hunk 1 1000000000 1 1000000000\n");
+			send_status("status=success");
+			break;
+		case MODE_OID_ERANGE:
+			/* Overflows strtol() even where long is 64-bit. */
+			packet_write_fmt(1, "hunk 1 99999999999999999999 1 1\n");
+			send_status("status=success");
+			break;
+		case MODE_OID_OVERLAP:
+			packet_write_fmt(1, "hunk 3 2 3 2\n");
+			packet_write_fmt(1, "hunk 2 2 2 2\n");
+			send_status("status=success");
+			break;
+		case MODE_OID_MISALIGNED:
+			packet_write_fmt(1, "hunk 2 1 2 1\n");
+			packet_write_fmt(1, "hunk 5 1 6 1\n");
+			send_status("status=success");
+			break;
+		case MODE_OID_BADSTART:
+			/*
+			 * A start of 0 names an empty side, so a nonzero
+			 * count beside it names no line; the coordinate is
+			 * rejected per pair while the process stays alive.
+			 */
+			packet_write_fmt(1, "hunk 0 2 1 2\n");
+			send_status("status=success");
+			break;
+		case MODE_OID_UNKNOWN_STATUS:
+			send_status("status=frobnicate");
+			break;
+		case MODE_OID_ABORT:
+			send_status("status=abort");
+			break;
+		case MODE_OID_BARE_STATUS:
+			/* No hunk-section flush: a protocol violation. */
+			packet_write_fmt(1, "status=success\n");
+			packet_flush(1);
+			break;
+		case MODE_OID_EMPTY_PACKET:
+			/*
+			 * An empty packet is not a flush; inside the hunk
+			 * section it is a protocol violation.
+			 */
+			if (write(1, "0004", 4) < 0)
+				die_errno("write empty packet");
+			send_status("status=success");
+			break;
+		case MODE_OID_CRASH:
+			packet_write_fmt(1, "hunk 5 2 5 2\n");
+			exit(0);
+		case MODE_OID_GARBAGE:
+			if (write(1, "@@@@ not a pkt-line @@@@", 24) < 0)
+				die_errno("write garbage");
+			exit(0);
+		default:
+			send_status("status=need-content");
+			break;
+		}
+
+		free(command);
+		free(pathname);
+		free(old_oid);
+		free(new_oid);
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
+	if (mode != MODE_CAP_NONE)
+		packet_write_fmt(1, "capability=hunks-by-oid\n");
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
+	enum mode mode = MODE_OID_FIXED;
+	struct option options[] = {
+		OPT_STRING(0, "mode", &mode_str, "mode",
+			   "response shape (default oid-fixed);"
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
index 3f45b09dd6..a76edfbf81 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -518,6 +518,7 @@ integration_tests = [
   't4072-diff-max-depth.sh',
   't4073-diff-stat-name-width.sh',
   't4074-diff-shifted-matched-group.sh',
+  't4080-diff-process.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
new file mode 100755
index 0000000000..a8efa19416
--- /dev/null
+++ b/t/t4080-diff-process.sh
@@ -0,0 +1,593 @@
+#!/bin/sh
+
+test_description='diff.<driver>.process: oid-only hunk requests'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+# See t/helper/test-diff-process-backend.c for the process implementation
+# and available --mode= options.
+
+BACKEND="test-tool diff-process-backend"
+
+test_expect_success 'setup' '
+	echo "*.c diff=cdiff" >.gitattributes &&
+	git add .gitattributes &&
+
+	# 10 lines, changes at 5-6 and 9-10 between the two commits.
+	cat >pair.c <<-\EOF &&
+	line1
+	line2
+	line3
+	line4
+	original5
+	original6
+	line7
+	line8
+	line9
+	line10
+	EOF
+	git add pair.c &&
+	git commit -m "add pair.c" &&
+
+	cat >pair.c <<-\EOF &&
+	line1
+	line2
+	line3
+	line4
+	changed5
+	changed6
+	line7
+	line8
+	changed9
+	changed10
+	EOF
+	git add pair.c &&
+	git commit -m "change pair.c"
+'
+
+test_expect_success 'an oid-capable process answers blame by object names alone' '
+	test_when_finished "rm -f backend.log" &&
+	ORIG=$(git rev-parse --short HEAD~1) &&
+	CHANGE=$(git rev-parse --short HEAD) &&
+	# The process reports only lines 5-6 as changed, so blame attributes
+	# lines 9-10 to the original commit even though the builtin diff
+	# would show them as changed.
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		blame pair.c >actual &&
+	sed -n "9p" actual >line9 &&
+	sed -n "10p" actual >line10 &&
+	test_grep "$ORIG" line9 &&
+	test_grep "$ORIG" line10 &&
+	sed -n "5p" actual >line5 &&
+	test_grep "$CHANGE" line5 &&
+	test_grep "command=hunks-by-oid pathname=pair.c" backend.log
+'
+
+test_expect_success 'an oid-capable process answers --numstat by object names alone' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		log -1 --format= --numstat -- pair.c >actual &&
+	printf "2\t2\tpair.c\n" >expect &&
+	test_cmp expect actual &&
+	test_grep "command=hunks-by-oid pathname=pair.c" backend.log
+'
+
+test_expect_success 'need-content falls through to the builtin diff' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-need-content --log=backend.log" \
+		log -1 --format= --numstat -- pair.c >actual &&
+	printf "4\t4\tpair.c\n" >expect &&
+	test_cmp expect actual &&
+	test_grep "command=hunks-by-oid pathname=pair.c" backend.log
+'
+
+test_expect_success 'a warmed hunk store does not override process hunks' '
+	test_when_finished "git diff-hunks clear" &&
+	ORIG=$(git rev-parse --short HEAD~1) &&
+	GIT_DIFF_HUNKS_WRITE=1 git log -2 --stat -- pair.c >/dev/null &&
+
+	# Control: without a process, blame is served from the store.
+	git blame --show-stats pair.c >stats &&
+	test_grep "num precomputed hits: 1" stats &&
+
+	# The store holds the builtin hunks, but a process-capable driver
+	# makes the process authoritative, so blame must reflect the
+	# process hunks (only lines 5-6), not a store hit.
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed" \
+		blame pair.c >actual &&
+	sed -n "9p" actual >line9 &&
+	test_grep "$ORIG" line9
+'
+
+test_expect_success 'a worktree side is not asked by object names' '
+	test_when_finished "rm -f backend.log && git checkout -- pair.c" &&
+	echo "worktree edit" >>pair.c &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		diff --numstat -- pair.c >actual &&
+	printf "1\t0\tpair.c\n" >expect &&
+	test_cmp expect actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'diff process bypassed by --no-ext-diff' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		log -1 --format= --numstat --no-ext-diff -- pair.c >actual &&
+	printf "4\t4\tpair.c\n" >expect &&
+	test_cmp expect actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'format-patch keeps its diffstat off the process' '
+	test_when_finished "rm -f backend.log" &&
+	# format-patch emits a diffstat, and a diffstat consults the
+	# process, but the gate keeps it builtin so a generated patch
+	# applies for recipients without the process.
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		format-patch -1 --stdout --stat -- pair.c >actual &&
+	test_grep "^+changed9" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'format-patch --ext-diff keeps its diffstat off the process' '
+	test_when_finished "rm -f backend.log" &&
+	# The gate holds even when --ext-diff enables the external command.
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		format-patch -1 --stdout --ext-diff --stat -- pair.c >actual &&
+	test_grep "^+changed9" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'diff process not consulted by plumbing diff commands' '
+	test_when_finished "rm -f backend.log && git checkout -f HEAD -- pair.c" &&
+	# diff-tree diffs the two commits, a real pair a defeated gate would
+	# consult the process for.
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		diff-tree --numstat HEAD >actual &&
+	test_grep "pair.c" actual &&
+	# diff-index needs a change to diff, or there is no pair and a
+	# missing log proves nothing; stage one and diff it against HEAD.
+	echo "staged change" >>pair.c &&
+	git add pair.c &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		diff-index --cached --numstat HEAD -- pair.c >actual &&
+	test_grep "pair.c" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'add -p stages from the builtin diff with a process configured' '
+	test_when_finished "rm -f backend.log" &&
+	cat >gate.c <<-\EOF &&
+	int gate(void) { return 1; }
+	EOF
+	git add gate.c &&
+	git commit -m "add gate.c" &&
+	cat >gate.c <<-\EOF &&
+	int gate(void) { return 2; }
+	EOF
+	# add -p builds its hunks from patch text, which is not a provider
+	# consumer today, so a configured process cannot shape what it
+	# offers. This pins that interactive patch stays builtin for the
+	# current consumers, rather than exercising the plumbing gate.
+	test_write_lines y |
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		add -p gate.c &&
+	git diff --cached -- gate.c >staged &&
+	test_grep "return 2" staged &&
+	test_path_is_missing backend.log &&
+	git commit -m "gate.c v2"
+'
+
+test_expect_success 'blame withholds identity for the working-tree pair' '
+	test_when_finished "rm -f backend.log && git checkout -- pair.c" &&
+	echo "uncommitted" >>pair.c &&
+	wt=$(git hash-object pair.c) &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		blame pair.c >actual &&
+	# The dirty working-tree side is not a stored blob: no request
+	# may name its bytes by object id.
+	test_grep ! "new-oid=$wt" backend.log
+'
+
+test_expect_success 'a replaced blob makes the process step aside' '
+	new_blob=$(git rev-parse HEAD:pair.c) &&
+	test_when_finished "rm -f backend.log && git replace -d $new_blob" &&
+	# Replacing the new-side blob redirects the content the diff reads
+	# under the id the process would be sent, so a raw-id request would
+	# name bytes other than the ones diffed. Identity is withheld: the
+	# process is not consulted and the builtin computes the pair from
+	# the replaced content.
+	repl=$(printf "just one line\n" | git hash-object -w --stdin) &&
+	git replace "$new_blob" "$repl" &&
+	git log -1 --format= --numstat -- pair.c >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		log -1 --format= --numstat -- pair.c >actual &&
+	test_cmp expect actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'an equivalence answer omits the pair from the stat' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-equal --log=backend.log" \
+		log -1 --format= --numstat -- pair.c >actual &&
+	# An equivalent pair sums to a zero-count entry, and the stat
+	# code omits zero-count modified entries, the same way a
+	# whitespace-only pair prints nothing under -w. The builtin
+	# diff would print nonzero counts here, and the log proves the
+	# process was consulted.
+	test_must_be_empty actual &&
+	test_grep "command=hunks-by-oid pathname=pair.c" backend.log
+'
+
+test_expect_success 'blame passes equivalent pairs through to the boundary' '
+	ORIG=$(git rev-parse --short ":/add pair.c") &&
+	# The process asserts every consulted pair equal, so no line is
+	# ever treated as changed: every line passes through to the
+	# commit that added the file, marked as the blame boundary.
+	git -c diff.cdiff.process="$BACKEND --mode=oid-equal" \
+		blame pair.c >actual &&
+	sed -n "5p" actual >line5 &&
+	test_grep "^\^$ORIG" line5 &&
+	sed -n "10p" actual >line10 &&
+	test_grep "^\^$ORIG" line10
+'
+
+test_expect_success 'a warming run records a pair the process defers' '
+	test_when_finished "git diff-hunks clear" &&
+	git diff-hunks clear &&
+	# The process owns the path but defers this pair with
+	# need-content, so the pair gets the builtin diff; that is the
+	# result the store holds, so the warming run records it and a
+	# later read is served from the store.
+	GIT_DIFF_HUNKS_WRITE=1 git -c core.diffHunks=true \
+		-c diff.cdiff.process="$BACKEND --mode=oid-need-content" \
+		log -1 --format= --stat -- pair.c >/dev/null &&
+	git -c core.diffHunks=true blame --show-stats pair.c >stats 2>&1 &&
+	test_grep "num precomputed hits: 1" stats
+'
+
+# The protocol error paths: each adversarial response shape must warn,
+# fall back to the builtin output, and either keep the process alive
+# (a per-pair rejection) or disable it for the rest of the command (a
+# protocol error).  The request log tells the two apart: the log walk
+# below consults two pairs (gate.c first, then pair.c), so a disabled
+# process shows one logged request and a live one shows two.
+
+test_expect_success 'a malformed hunk line disables the process for the command' '
+	test_when_finished "rm -f backend.log err" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-malformed --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "disabling it for the remainder" err &&
+	test_line_count = 1 backend.log
+'
+
+test_expect_success 'coordinates past the blob size skip the pair, process stays alive' '
+	test_when_finished "rm -f backend.log err" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-huge --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "past the end" err &&
+	test_line_count = 2 backend.log
+'
+
+test_expect_success 'a count that overflows long skips the pair, process stays alive' '
+	test_when_finished "rm -f backend.log err" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-erange --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "out-of-range coordinates" err &&
+	test_line_count = 2 backend.log
+'
+
+test_expect_success 'overlapping hunks are rejected per pair' '
+	test_when_finished "rm -f backend.log err" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-overlap --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "overlapping hunks" err &&
+	test_line_count = 2 backend.log
+'
+
+test_expect_success 'misaligned hunks are rejected per pair' '
+	test_when_finished "rm -f backend.log err" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-misaligned --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "misaligned" err &&
+	test_line_count = 2 backend.log
+'
+
+test_expect_success 'a start of zero with a nonzero count is rejected per pair' '
+	test_when_finished "rm -f backend.log err" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	# A start of 0 names an empty side, so a nonzero count beside it
+	# names no line; the coordinate is rejected and the pair falls back
+	# to the builtin diff while the process stays alive.
+	git -c diff.cdiff.process="$BACKEND --mode=oid-badstart --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "out-of-range coordinates" err &&
+	test_line_count = 2 backend.log
+'
+
+test_expect_success 'an unrecognized status disables the process for the command' '
+	test_when_finished "rm -f backend.log err" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-unknown-status --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "unrecognized status .frobnicate." err &&
+	test_line_count = 1 backend.log
+'
+
+test_expect_success 'status=abort withdraws the capability without a warning' '
+	test_when_finished "rm -f backend.log err" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-abort --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep ! "disabling" err &&
+	test_line_count = 1 backend.log
+'
+
+test_expect_success 'a bare status without the hunk-section flush is a protocol error' '
+	test_when_finished "rm -f backend.log err" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-bare-status --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "disabling it for the remainder" err &&
+	test_line_count = 1 backend.log
+'
+
+test_expect_success 'an empty packet in the hunk section is a protocol error' '
+	test_when_finished "rm -f backend.log err" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-empty-packet --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "disabling it for the remainder" err &&
+	test_line_count = 1 backend.log
+'
+
+test_expect_success 'a process that dies mid-response fails the command over to builtin' '
+	test_when_finished "rm -f backend.log err" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-crash --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "disabling it for the remainder" err &&
+	test_line_count = 1 backend.log
+'
+
+test_expect_success 'garbage bytes on stdout fail the command over to builtin' '
+	test_when_finished "rm -f backend.log err" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-garbage --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "disabling it for the remainder" err &&
+	test_line_count = 1 backend.log
+'
+
+test_expect_success 'a process announcing no capability is never asked' '
+	test_when_finished "rm -f backend.log" &&
+	git log --format= --numstat -- "*.c" >expect &&
+	git -c diff.cdiff.process="$BACKEND --mode=cap-none --log=backend.log" \
+		log --format= --numstat -- "*.c" >actual &&
+	test_cmp expect actual &&
+	test_must_be_empty backend.log
+'
+
+test_expect_success 'a trailing token on a hunk line is ignored' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-trailing --log=backend.log" \
+		log -1 --format= --numstat -- pair.c >actual &&
+	printf "2\t2\tpair.c\n" >expect &&
+	test_cmp expect actual &&
+	test_grep "command=hunks-by-oid pathname=pair.c" backend.log
+'
+
+test_expect_success 'a failed start warns once and the store may serve the path' '
+	git init failrepo &&
+	(
+		cd failrepo &&
+		echo "*.c diff=cdiff" >.gitattributes &&
+		git add .gitattributes &&
+		test_commit f1 f.c "one" &&
+		test_commit f2 f.c "one
+two" &&
+		test_commit f3 f.c "one
+two
+three" &&
+		GIT_DIFF_HUNKS_WRITE=1 git log --format= --stat -- f.c >/dev/null &&
+		# The command has no shell metacharacters, so it fails at
+		# exec time; a shell-wrapped command would fail at the
+		# handshake, which the gentle handshake in the base
+		# (061a68e443) likewise degrades to the builtin diff.
+		git blame f.c >expect &&
+		git -c diff.cdiff.process=/does-not-exist-diff-backend \
+			blame f.c >actual 2>err &&
+		test_cmp expect actual &&
+		# One warning even though the blame consults two pairs.
+		test $(grep -c "failed to start" err) = 1 &&
+		# A failure is a non-answer like any other: the request
+		# that observes it and every later request pass to the
+		# store, so the warmed store serves both pairs.
+		git -c diff.cdiff.process=/does-not-exist-diff-backend \
+			blame --show-stats f.c >stats 2>&1 &&
+		test_grep "num precomputed hits: 2" stats
+	)
+'
+
+test_expect_success 'the store serves a pair the process defers' '
+	test_when_finished "git diff-hunks clear" &&
+	git diff-hunks clear &&
+	GIT_DIFF_HUNKS_WRITE=1 git log --format= --stat -- pair.c >/dev/null &&
+	git blame pair.c >expect &&
+	# need-content defers the pair to the builtin diff, which is
+	# what the store holds, so the walk continues past the process
+	# and the store serves the pair.
+	git -c diff.cdiff.process="$BACKEND --mode=oid-need-content" \
+		blame pair.c >actual &&
+	test_cmp expect actual &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-need-content" \
+		blame --show-stats pair.c >stats 2>&1 &&
+	test_grep "num precomputed hits: 1" stats
+'
+
+test_expect_success 'git diff between commits consults the process' '
+	test_when_finished "rm -f backend.log" &&
+	ORIG=$(git rev-parse ":/add pair.c") &&
+	CHANGE=$(git rev-parse ":/change pair.c") &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		diff --numstat $ORIG $CHANGE -- pair.c >actual &&
+	printf "2\t2\tpair.c\n" >expect &&
+	test_cmp expect actual &&
+	test_grep "command=hunks-by-oid pathname=pair.c" backend.log
+'
+
+test_expect_success 'git show consults the process' '
+	test_when_finished "rm -f backend.log" &&
+	CHANGE=$(git rev-parse ":/change pair.c") &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		show --format= --numstat $CHANGE -- pair.c >actual &&
+	printf "2\t2\tpair.c\n" >expect &&
+	test_cmp expect actual &&
+	test_grep "command=hunks-by-oid pathname=pair.c" backend.log
+'
+
+test_expect_success 'diff-tree --ext-diff consults the process' '
+	test_when_finished "rm -f backend.log" &&
+	CHANGE=$(git rev-parse ":/change pair.c") &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		diff-tree --ext-diff --no-commit-id --numstat $CHANGE >actual &&
+	printf "2\t2\tpair.c\n" >expect &&
+	test_cmp expect actual &&
+	test_grep "command=hunks-by-oid pathname=pair.c" backend.log
+'
+
+test_expect_success '--no-diff-process forbids consulting alone' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		log -1 --no-diff-process --format= --numstat -- pair.c >actual &&
+	printf "4\t4\tpair.c\n" >expect &&
+	test_cmp expect actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success '--diff-process allows plumbing to consult' '
+	test_when_finished "rm -f backend.log" &&
+	CHANGE=$(git rev-parse ":/change pair.c") &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		diff-tree --diff-process --no-commit-id --numstat $CHANGE >actual &&
+	printf "2\t2\tpair.c\n" >expect &&
+	test_cmp expect actual &&
+	test_grep "command=hunks-by-oid pathname=pair.c" backend.log
+'
+
+test_expect_success 'a forced blame diff algorithm bypasses the process' '
+	test_when_finished "rm -f backend.log" &&
+	CHANGE=$(git rev-parse --short ":/change pair.c") &&
+	# The process would attribute lines 9-10 to the original commit
+	# (see the oid-fixed blame test above); a forced builtin
+	# algorithm must produce the builtin attribution and never start
+	# the process.
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		blame --histogram pair.c >actual &&
+	sed -n "9p" actual >line9 &&
+	test_grep "$CHANGE" line9 &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'textconv output is never identified to the process' '
+	test_when_finished "rm -f backend.log" &&
+	echo "*.tcv diff=tcv" >>.gitattributes &&
+	git add .gitattributes &&
+	git commit -m tcv-attr &&
+	test_config diff.tcv.textconv cat &&
+	test_commit tcv1 file.tcv "alpha" &&
+	test_commit tcv2 file.tcv "alpha
+beta" &&
+	git blame file.tcv >expect &&
+	git -c diff.tcv.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		blame file.tcv >actual &&
+	test_cmp expect actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'a gitlink side is never identified to the process' '
+	test_when_finished "rm -f backend.log" &&
+	echo "sub diff=cdiff" >>.gitattributes &&
+	git add .gitattributes &&
+	git commit -m sub-attr &&
+	C1=$(git rev-parse HEAD) &&
+	C2=$(git rev-parse HEAD~1) &&
+	git update-index --add --cacheinfo 160000,$C1,sub &&
+	git commit -m sub-1 &&
+	git update-index --add --cacheinfo 160000,$C2,sub &&
+	git commit -m sub-2 &&
+	git -c diff.cdiff.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+		log -1 --format= --numstat -- sub >actual &&
+	printf "1\t1\tsub\n" >expect &&
+	test_cmp expect actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'a relative diff consults by the repo-relative path' '
+	test_when_finished "rm -f backend.log" &&
+	echo "reldir/*.rel diff=rdrv" >>.gitattributes &&
+	git add .gitattributes &&
+	git commit -m rel-attr &&
+	mkdir reldir &&
+	test_write_lines line1 line2 line3 line4 original5 original6 \
+		line7 line8 line9 line10 >reldir/x.rel &&
+	git add reldir/x.rel &&
+	git commit -m "add x.rel" &&
+	test_write_lines line1 line2 line3 line4 changed5 changed6 \
+		line7 line8 changed9 changed10 >reldir/x.rel &&
+	git add reldir/x.rel &&
+	git commit -m "change x.rel" &&
+	# diff.relative strips the prefix from the displayed name; the
+	# driver lookup and the request pathname must still use the
+	# repo-relative path, or the directory-scoped attribute above
+	# would not match and the process would never be consulted.
+	# The process runs at the repository root, so its log lands there.
+	(
+		cd reldir &&
+		git -c diff.relative=true \
+			-c diff.rdrv.process="$BACKEND --mode=oid-fixed --log=backend.log" \
+			log -1 --format= --numstat -- x.rel
+	) >actual &&
+	printf "2\t2\tx.rel\n" >expect &&
+	test_cmp expect actual &&
+	test_grep "command=hunks-by-oid pathname=reldir/x.rel" backend.log
+'
+
+test_expect_success 'an empty file side is answered with a start of zero' '
+	test_when_finished "rm -f backend.log" &&
+	>empty.c &&
+	git add empty.c &&
+	git commit -m "add empty.c" &&
+	printf "x\ny\nz\n" >empty.c &&
+	git add empty.c &&
+	git commit -m "fill empty.c" &&
+	# The process addresses the empty old side with a start of 0 and a
+	# count of 0, and claims two of the three added lines. The answer is
+	# used as sent, so the stat shows the two lines it named, not the
+	# three the builtin would.
+	git -c diff.cdiff.process="$BACKEND --mode=oid-empty --log=backend.log" \
+		log -1 --format= --numstat -- empty.c >actual &&
+	printf "2\t0\tempty.c\n" >expect &&
+	test_cmp expect actual &&
+	test_grep "command=hunks-by-oid pathname=empty.c" backend.log
+'
+
+test_done
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 71e5dffefb..23db1d2a46 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -6,6 +6,18 @@
 
 struct object_database;
 
+/*
+ * Hunk descriptor for externally computed diffs, in xdiff's own
+ * coordinates: line numbers are 1-based and a hunk's start is the
+ * first line it covers.  A caller translates any external "empty side"
+ * idiom (such as git diff's start-0/count-0) to a 1-based start before
+ * storing hunks in this struct.
+ */
+struct xdl_hunk {
+	long old_start, old_count;
+	long new_start, new_count;
+};
+
 /*
  * xdiff isn't equipped to handle content over a gigabyte;
  * we make the cutoff 1GB - 1MB to give some breathing
-- 
2.54.0

