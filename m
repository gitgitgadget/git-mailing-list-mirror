Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25B3B7767
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606127; cv=none; b=SOHntJanMe3adJWe1SIjsYMS5Ul9La4f6UVDy8xWPjyEe0FwWOLhVeZVP+RfovgL6lwWQZT0cLRlij1ekSz/eC6iJY+kDUhcgpFN+1SnvY4NW46/PP9hN/bRnDCpwiBtLqQGRMqGt/TJ/g0vlo/1o/NY5KNJ6p/A7ANMqzyCcm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606127; c=relaxed/simple;
	bh=BmOqBo42jFklb/aXGSwqiZW5lGVJCqzuceCQYktADCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTiZAiSwqDwWI9FU6DWZFMxZ/9GL/3qb6fY9/b0TK8G1UEmGrijabW4wOmUYBVG1J0fyeH1UrcNdwdtywV+qlLFZ0HSuSKA3LCeFzZdb+KIOcXduAIQhr46dutj2fsx5yPtXY8vPs9hoqQjtSCQSq4LoSF9dWqzh2jrME2oI7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mP3IYkHt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP3IYkHt"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1957953a91.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785606123; x=1786210923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ktuXZ0th2gGgTBFFZgIdyKIoy0IBSoRnylMYy+hxgow=;
        b=mP3IYkHtOCMoYEfc8l5iuV/MhTSbX8EXscZwWSjf8JR/T4wrnCc0bKStnHVd0APUEd
         4JxPkmcDgW+QdkA1sKwhkoqPy9E2Ji6UmulWByFC+NaXF88F0kBOZAYtjJmAoEzPS/wz
         G1M0Wws4kQH2ATK8PDC6+zCb76NKbkFWoYBvpp6Cta45n4GzONEY1PYzP9OHnBYprqwS
         vMw25CePkgEDcIndx2aekDkA5vZAuK2a2ghvpRgQ048tpARWnQrJ0wlThSpJUYrp3Y+0
         1UPBVLqG5N8dFNHzLhi8++Vk+3VS5qRrInjxDdt5xvXYkFRpUV+x5GasY5lcWj56CxI8
         q9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785606123; x=1786210923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ktuXZ0th2gGgTBFFZgIdyKIoy0IBSoRnylMYy+hxgow=;
        b=s5I7W3C10OjoAe9uhDOjKqlEbbHC5TCxNRf2PD0s79VgK9o9dj1WrOSUVPekgZ6nYK
         MRmbd+wlPTfuk4+LfYpsEPRtdFSj+MpiFGqb9FOfTvE97R3vANJBxUOGLC4dZSFbExFF
         86KBrheH/CMmlycf88fU3ftJK6Ls0up9ZXVa140zadwandWEEd4FmkVADoGlqeEakZ/a
         z6kaEkWn+3lioxaG6DM2x/E9BzTIWEZPV4qz4GViIjt+X//PyChxSwY0oeAbP+DREL+U
         Y2uNYls0QxlHjWZBMwwC81ckTb+rSYIS36eJ2ydzW9bWsVfdEYyxczVdPT4pNA4k22Ys
         7NDA==
X-Gm-Message-State: AOJu0YzwVgJvhKAprFl/alIW1eohrPz6otPhcD4N92hSHbuZHr/0cbRq
	UfKorvaGNgwqlkbkoEE+nOcRI3Qympex4Dvx0v3/H+6z7h6yZLCOrIgNaXc/bg==
X-Gm-Gg: AR+sD12fpEiJUsWGOBJ86UgDM5RFyIkSHe2XW6NFz8o9iTKIRrUtswtok45NaJVl0FU
	VxYyyk/Sjk03M9cWUE/r5A4rAOfMTT4LORgSGOkZ9aKY6PArmXz5girWfNYiWCGKzATeuuQevZF
	YxP6EQlfxf/e9lpA0x8SPyZ13KyVVacGnmd6Q1WCAd6LYi5AL7lqFKg0Wc2pSboa6Sa3eu0Y9Md
	IA8+XHtVJD8LiKcdFaQwXsrR8avujxLzFAbUA4qPE9mq03ujv0qISTNDVJQQ7e5LD+UKw02fVNs
	6gFaJ/C2vjAuNZqDh2h2IR3tBgQcIRpwQL1YVcNwvbSf8hYBX2eWEOZh4/r3hq4WpJC/NpoSz0T
	VAw0in3RkllfSk9EE6WITVXbCLyQWQjtk/rTIGzGUTu7qwbs/Jurog3K7yfzInfCiTYKuyJmqrj
	uaftYQQ/5G8pyv0aDFYtNWHqHmhSB3K5ZuXbVwX9Jw4gLT3D7lx9vx8ugQKaM1Hsr4DwHnMmZ9D
	gJF+ysfeJR6AFWc5S3mvYrDepb/eI5KsuupyickOVSONRUsAmSTPKsCH//s7CYqCZ6OVIBQGUyF
	U37hmvG18Ealh5V/5tjDCAxijje5lpD+/FLkvn/zcvOvD7XpDz+K9xgJ
X-Received: by 2002:a17:903:1a4d:b0:2cc:df15:91de with SMTP id d9443c01a7336-2d0524a2b59mr41031895ad.42.1785606121577;
        Sat, 01 Aug 2026 10:42:01 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e5b0sm17792849eec.1.2026.08.01.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:42:00 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC PATCH v7 03/10] diff-hunks: add the store format, library, and command
Date: Sat,  1 Aug 2026 10:41:46 -0700
Message-ID: <20260801174156.2998808-4-mmontalbo@gmail.com>
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

Blame and "git log --stat" recover hunk coordinates by diffing blob
pairs, and recompute them on every run.  Add a cache of those
coordinates at $GIT_DIR/objects/info/diff-hunks, beside the
commit-graph, so a later run can look them up instead of decompressing
the blobs and running xdiff again.

The store is a single chunk-format file (see gitformat-chunk(5)): an
8-byte header, a DHIX index of fixed-size entries sorted by key, a DHDT
segment of hunk records, and a trailing hash checksum.  An entry is
keyed by the two blob object ids and the xdl_opts the pair was diffed
under, so a stored result is served only where that exact key recurs,
independent of path.  A zero-context diff trims unchanged lines from
hunk edges and can pick a different but equally valid set of hunks than
an untrimmed diff, so a recording caller stores a pair only when its
trimmed and untrimmed diffs are identical; such an entry answers any
consumer at any context, and the rare divergent pair is always
computed.  Identical hunk blocks are interned once and shared across
keys.

The library provides a reader (repo_diff_hunks_store and _replay, gated
by core.diffHunks), loaded once and cached on the object database as the
commit-graph is, and a writer that accumulates entries and flushes them
in one atomic pass.  An absent, corrupt, or disabled store reads as all
misses.  A record with no hunks is invalid too: replaying it would claim
the pair equivalent, which the store never asserts, so it reads as a
miss.

Ordinary reads are diagnostic-free.  Loading parses the chunk table
through read_table_of_contents_quiet(), new in chunk-format, which
prints nothing on a malformed table and takes the repository's hash
algorithm rather than the_hash_algo, so the file is bounds-checked under
the algorithm it is keyed by.

The flush closes the repository's mmapped store and forgets that loading
was attempted before committing the lockfile.  A warming run that also
reads may hold the file it is replacing mapped, and the rename must not
land on a live mapping, which Windows refuses; a read after the flush
then observes the committed file.  commit-graph closes its graph before
committing for the same reason.

Writing is off by default, enabled per run by GIT_DIFF_HUNKS_WRITE or
persistently by diffHunks.write, the environment winning.  A writer
seeds from the existing store, so a flush merges rather than replaces.
The seed's checksum is verified first: a corrupt store is discarded, not
rewritten with a fresh checksum verify could no longer catch.  An entry
that fails the shared diff_provider_check_hunk() or names no blob is
dropped with a warning, since it would only ever read as a miss.  A seed
that discarded or dropped anything forces the flush even when the
warming run computed nothing new.  The writer fsyncs through a new
diff-hunks core.fsync component.

"git diff-hunks" inspects and manages the file: "verify" checks the
checksum, chunk table, sort order, entry bounds, and every entry's hunk
sequence against that shared check, so a store whose entries could only
read as misses fails verify; "clear" removes the file.  Later patches
wire the readers and the writer into the diff and blame paths.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 .gitignore                              |   1 +
 Documentation/Makefile                  |   1 +
 Documentation/config.adoc               |   2 +
 Documentation/config/core.adoc          |  10 +-
 Documentation/config/diff-hunks.adoc    |   8 +
 Documentation/git-diff-hunks.adoc       | 146 ++++
 Documentation/gitformat-diff-hunks.adoc | 129 ++++
 Documentation/meson.build               |   2 +
 Makefile                                |   2 +
 builtin.h                               |   1 +
 builtin/diff-hunks.c                    |  53 ++
 chunk-format.c                          |  62 +-
 chunk-format.h                          |  14 +
 command-list.txt                        |   2 +
 diff-hunks.c                            | 916 ++++++++++++++++++++++++
 diff-hunks.h                            | 117 +++
 environment.c                           |   1 +
 git.c                                   |   1 +
 meson.build                             |   2 +
 odb.c                                   |   2 +
 odb.h                                   |   4 +
 repo-settings.c                         |   1 +
 repo-settings.h                         |   1 +
 write-or-die.h                          |   7 +-
 24 files changed, 1467 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/config/diff-hunks.adoc
 create mode 100644 Documentation/git-diff-hunks.adoc
 create mode 100644 Documentation/gitformat-diff-hunks.adoc
 create mode 100644 builtin/diff-hunks.c
 create mode 100644 diff-hunks.c
 create mode 100644 diff-hunks.h

diff --git a/.gitignore b/.gitignore
index 4da58c6754..4173111c01 100644
--- a/.gitignore
+++ b/.gitignore
@@ -56,6 +56,7 @@
 /git-diagnose
 /git-diff
 /git-diff-files
+/git-diff-hunks
 /git-diff-index
 /git-diff-pairs
 /git-diff-tree
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2699f0b24a..170fcee66e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -33,6 +33,7 @@ MAN5_TXT += gitattributes.adoc
 MAN5_TXT += gitformat-bundle.adoc
 MAN5_TXT += gitformat-chunk.adoc
 MAN5_TXT += gitformat-commit-graph.adoc
+MAN5_TXT += gitformat-diff-hunks.adoc
 MAN5_TXT += gitformat-index.adoc
 MAN5_TXT += gitformat-loose.adoc
 MAN5_TXT += gitformat-pack.adoc
diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index 1ef72de62f..8a172d52f3 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -472,6 +472,8 @@ include::config/credential.adoc[]
 
 include::config/diff.adoc[]
 
+include::config/diff-hunks.adoc[]
+
 include::config/difftool.adoc[]
 
 include::config/extensions.adoc[]
diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index a0ebf03e2e..9595619c61 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -670,12 +670,13 @@ but risks losing recent work in the event of an unclean system shutdown.
 * `pack` hardens objects added to the repo in packfile form.
 * `pack-metadata` hardens packfile bitmaps and indexes.
 * `commit-graph` hardens the commit-graph file.
+* `diff-hunks` hardens the diff-hunks store.
 * `index` hardens the index when it is modified.
 * `objects` is an aggregate option that is equivalent to
   `loose-object,pack`.
 * `reference` hardens references modified in the repo.
 * `derived-metadata` is an aggregate option that is equivalent to
-  `pack-metadata,commit-graph`.
+  `pack-metadata,commit-graph,diff-hunks`.
 * `committed` is an aggregate option that is currently equivalent to
   `objects`. This mode sacrifices some performance to ensure that work
   that is committed to the repository with `git commit` or similar commands
@@ -750,6 +751,13 @@ core.commitGraph::
 	to parse the graph structure of commits. Defaults to true. See
 	linkgit:git-commit-graph[1] for more information.
 
+core.diffHunks::
+	If true, then Git will consult the diff-hunks store (if it
+	exists) to skip recomputing diff hunk coordinates in commands
+	such as `git log --stat` and linkgit:git-blame[1]. This controls
+	only reading; writing the store is controlled by `diffHunks.write`.
+	See linkgit:git-diff-hunks[1] for more information. Defaults to true.
+
 core.useReplaceRefs::
 	If set to `false`, behave as if the `--no-replace-objects`
 	option was given on the command line. See linkgit:git[1] and
diff --git a/Documentation/config/diff-hunks.adoc b/Documentation/config/diff-hunks.adoc
new file mode 100644
index 0000000000..ad76d1c6a9
--- /dev/null
+++ b/Documentation/config/diff-hunks.adoc
@@ -0,0 +1,8 @@
+diffHunks.write::
+	If true, diff-producing commands (`git diff`, `git log`,
+	`git show`, or `git diff-tree` with a `--stat`, `--numstat`, or
+	`--shortstat` format) write the hunks
+	they compute to the diff-hunks store, filling it as a side effect.
+	The `GIT_DIFF_HUNKS_WRITE` environment variable overrides this for
+	a single invocation. Reading the store is controlled separately by
+	`core.diffHunks`. See linkgit:git-diff-hunks[1]. Defaults to false.
diff --git a/Documentation/git-diff-hunks.adoc b/Documentation/git-diff-hunks.adoc
new file mode 100644
index 0000000000..25cab2ea7d
--- /dev/null
+++ b/Documentation/git-diff-hunks.adoc
@@ -0,0 +1,146 @@
+git-diff-hunks(1)
+=================
+
+NAME
+----
+git-diff-hunks - Inspect and manage the diff-hunks store
+
+SYNOPSIS
+--------
+[synopsis]
+git diff-hunks verify
+git diff-hunks clear
+
+DESCRIPTION
+-----------
+
+The diff-hunks store is a cache of diff hunk coordinates, the line
+ranges that changed between two blobs, so that commands
+which need them, such as linkgit:git-blame[1] and `git log` and `git diff`
+with the `--stat`, `--numstat`, and `--shortstat` formats, can skip
+running the diff algorithm, and blame can skip loading the blob
+content. (The summary formats still test each pair for binariness,
+which can load the blobs.)
+
+The store is a single file, `$GIT_DIR/objects/info/diff-hunks`. Reading is
+enabled by default; writing is off by default. A `git diff`, `git log`,
+`git show`, or `git diff-tree` that produces one of the stat formats
+fills the store as a side effect, but only when writing is enabled for
+that run (see "WARMING THE STORE" below), so ordinary reads never
+modify the repository. When the store does not have the pair, holds a
+different object hash, the file is unreadable, or an object replacement
+redirects one of the blobs, the consumer falls back to computing the
+diff. A store only speeds up these commands; it never changes their
+output.
+
+`git diff-hunks` itself only inspects and manages the file. See
+linkgit:gitformat-diff-hunks[5] for the file format.
+
+WARMING THE STORE
+-----------------
+
+The store is filled by running ordinary commands with writing enabled.
+Turn writing on for a single invocation with the `GIT_DIFF_HUNKS_WRITE`
+environment variable, or persistently with the `diffHunks.write`
+configuration; the environment variable takes precedence. A repository
+owner warms the store by running the diff-producing commands they care
+about with writing on, for example:
+
+	GIT_DIFF_HUNKS_WRITE=1 git log --all --stat >/dev/null
+
+A `--stat` walk records one entry per blob pair;
+linkgit:git-blame[1] replays the coordinates and the summary formats
+sum the counts, so a single warming walk serves both.
+A warming run seeds from the existing store and rewrites the file
+with the newly computed pairs merged in, so a later run adds to what
+earlier runs recorded rather than discarding it.
+
+A walk records only the pairs it diffs. `git log --all --stat` diffs
+each commit against its first parent, so a blame that follows a
+merge's second parent computes those pairs itself: blame coverage is
+partial on history with merges. Warming with a walk that also diffs
+the other parents, for example `git log --all -m --stat`, raises
+blame coverage at the cost of a larger store and a longer warming
+run.
+
+COMMANDS
+--------
+
+`verify`::
+	Check the integrity of the store: the trailing hash checksum, the
+	chunk table of contents, the sort order of the index, and the
+	bounds of every entry. Exits with non-zero status if the store is
+	corrupt. An absent store is valid.
+
+`clear`::
+	Remove the store file.
+
+CORRECTNESS
+-----------
+
+A stored result is interchangeable with a freshly computed one because an
+entry is keyed by the inputs that determine the diff:
+
+* the object IDs of the old and new blob, so a result is used only for
+  the exact contents it was computed from; and
+* the diff algorithm and ignore flags (`xdl_opts`) the hunks were
+  computed under. A lookup whose `xdl_opts` differ from a stored entry
+  misses. This is why, for example, `blame -w` and
+  `--diff-algorithm=<algorithm>` (including a per-path
+  `diff.<driver>.algorithm`) do not reuse entries recorded under the
+  default settings: they change `xdl_opts`.
+
+The context length is not part of the key because only trim-stable
+pairs are recorded: pairs whose zero-context trimmed diff and untrimmed
+diff are identical, so one entry answers blame (zero context) and the
+summary formats (any context) alike. The rare pair where
+the zero-context trimming optimization picks a different but
+equally valid set of hunks is
+never recorded and is always computed.
+
+Some options shape the hunks in ways the key does not express, so a
+diff that uses them is excluded from the store in both directions:
+break detection (`-B`), `--ignore-matching-lines` (`-I`), and
+`--anchored`. `--ignore-blank-lines` is different: it is an ignore
+flag and therefore part of the key, but the summary formats exclude
+it anyway, because it coalesces hunks differently between the code
+path that emits text and the one that replays coordinates, so a
+served answer would not match a store-less run.
+linkgit:git-blame[1] additionally does not
+consult the store for reverse blame, ignored revisions, or paths with a
+textconv driver.
+
+The store carries a trailing hash checksum, but readers do not
+re-checksum it on every load. As with the commit-graph and
+multi-pack-index, the writer fsyncs the file (honoring `core.fsync`) and
+commits it atomically, so a committed store is intact; every offset and
+count is still bounds-checked as it is read. The checksum is verified by
+`git diff-hunks verify`, not on the read path, so structural corruption
+that fails a bounds check is read as an absent entry, while a record
+that stays within bounds but whose bytes were altered is served until
+`verify` detects the mismatch.
+
+CONFIGURATION
+-------------
+
+`core.diffHunks`::
+	Whether commands read the store. Defaults to true. See
+	linkgit:git-config[1].
+
+`diffHunks.write`::
+	Whether diff-producing commands write to the store. Defaults to
+	false. The `GIT_DIFF_HUNKS_WRITE` environment variable overrides it
+	for a single invocation. See linkgit:git-config[1].
+
+Writing the store honors the `core.fsync` configuration through the
+`diff-hunks` component; see linkgit:git-config[1].
+
+SEE ALSO
+--------
+linkgit:git-blame[1],
+linkgit:git-log[1],
+linkgit:gitformat-diff-hunks[5]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitformat-diff-hunks.adoc b/Documentation/gitformat-diff-hunks.adoc
new file mode 100644
index 0000000000..f75ab73dd9
--- /dev/null
+++ b/Documentation/gitformat-diff-hunks.adoc
@@ -0,0 +1,129 @@
+gitformat-diff-hunks(5)
+=======================
+
+NAME
+----
+gitformat-diff-hunks - Precomputed diff hunk store format
+
+SYNOPSIS
+--------
+[verse]
+$GIT_DIR/objects/info/diff-hunks
+
+DESCRIPTION
+-----------
+
+The diff-hunks store memoizes diff hunk coordinates so that commands
+that need them, such as `git log --stat` and linkgit:git-blame[1], can
+skip running the diff algorithm (and, for blame, loading the blob
+content; the summary formats still test each pair for binariness,
+which can load the blobs). See
+linkgit:git-diff-hunks[1] for how the store is filled and managed and the
+configuration that controls it.
+
+The store is a single file, `$GIT_DIR/objects/info/diff-hunks`, written
+in one pass and replaced atomically, so a reader sees either the old
+file or the complete new one.
+
+Entries are keyed by the object IDs of the blob pair that was diffed
+and by the diff algorithm and ignore flags (`xdl_opts`) the pair was
+diffed under. A blob pair fully determines the diff input, so an entry
+is valid regardless of which commits, branches, or index states the
+pair was encountered in, and identical diffs performed in different
+contexts share one entry. A reader whose `xdl_opts` differ from an
+entry does not match it and falls back to computing the diff.
+
+FILE FORMAT
+-----------
+
+All multi-byte integers are stored in network byte order. The file is an
+8-byte header, the chunk table of contents and chunk data described in
+linkgit:gitformat-chunk[5], and a trailing checksum.
+
+HEADER
+~~~~~~
+
+- 4-byte signature: `DHPF` (diff-hunks precomputed format)
+- 1-byte version number: currently 1
+- 1-byte hash version: 1 for SHA-1, 2 for SHA-256. A store whose hash
+  function differs from the repository's is ignored.
+- 1-byte number of chunks
+- 1-byte reserved
+
+CHUNK LOOKUP
+~~~~~~~~~~~~
+
+A table of contents in the format of linkgit:gitformat-chunk[5], listing
+the offset of each chunk. Both chunks below are required; a file missing
+either is treated as corrupt.
+
+CHUNK DATA
+~~~~~~~~~~
+
+DHIX (index)::
+	A sorted sequence of fixed-size entries. Each entry is the old
+	blob object ID, the new blob object ID, a 4-byte `xdl_opts`
+	value, and a 4-byte offset into the DHDT chunk. Entries are
+	sorted by old object ID, then new object ID, then `xdl_opts`,
+	so lookups can use binary search on the full key.
+
+DHDT (hunk data)::
+	For each index entry, at its offset: a 4-byte hunk count followed
+	by that many 16-byte hunk records. A hunk record is four 4-byte
+	values: old start, old count, new start, new count.
+	Starts are 0-based line numbers in the old and new blob; counts
+	are numbers of lines. The hunk count is at least 1: a record with
+	no hunks would claim the blob pair equivalent, which the store
+	never records, so readers treat such a record as invalid.
+	Identical hunk blocks are stored once:
+	distinct index entries whose recorded hunks are byte-for-byte
+	equal point at the same offset.
+
+TRAILER
+~~~~~~~
+
+A checksum of all preceding bytes, computed with the repository hash
+function.
+
+CORRECTNESS
+-----------
+
+Serving hunks from a valid store produces the same output as recomputing
+the diff. The diff of a blob pair is not unique: a zero context length
+triggers xdiff's common-tail trimming, which can pick a different but
+equally valid set of hunks than an untrimmed diff does. A pair is
+therefore recorded only when its trimmed and untrimmed diffs are
+identical, which is the common case. Such an entry answers any consumer
+at any context: git-blame replays its coordinates directly (it diffs at
+zero context), and diffstat sums its per-hunk line counts, which the
+context length does not change. The rare pair whose two diffs differ is
+never recorded, so every consumer computes it.
+
+A store that cannot be used is ignored, and the consumer falls back to
+computing the diff. Every offset and count read from the file is
+bounds-checked, so a store that is missing, truncated, of an unknown
+version, or of a different object hash does not change the diff output
+and does not produce a diagnostic; `git diff-hunks verify` is what
+reports corruption.
+
+The store is not re-checksummed on the read path. The writer fsyncs the
+file (honoring `core.fsync`) and commits it atomically, so a
+committed store is intact, the same trust model the commit-graph and
+multi-pack-index use. The trailing checksum is recomputed by
+`git diff-hunks verify` to detect corruption.
+
+The checksum detects corruption but does not prove who wrote the file. A
+reader trusts the coordinates in a store that passes its checks, so
+anything able to write a checksum-valid file at the store path can
+influence output, the same as it could by writing objects directly.
+
+LIMITATIONS
+-----------
+
+- Hunk counts, offsets, and line coordinates are 32-bit, capping the
+  hunk data at 4 GiB and a single entry at roughly 268 million hunks.
+  A result whose coordinates cannot be represented is not recorded.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f4854f802d..85f37da47e 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -41,6 +41,7 @@ manpages = {
   'git-describe.adoc' : 1,
   'git-diagnose.adoc' : 1,
   'git-diff-files.adoc' : 1,
+  'git-diff-hunks.adoc' : 1,
   'git-diff-index.adoc' : 1,
   'git-diff-pairs.adoc' : 1,
   'git-difftool.adoc' : 1,
@@ -175,6 +176,7 @@ manpages = {
   'gitformat-bundle.adoc' : 5,
   'gitformat-chunk.adoc' : 5,
   'gitformat-commit-graph.adoc' : 5,
+  'gitformat-diff-hunks.adoc' : 5,
   'gitformat-index.adoc' : 5,
   'gitformat-loose.adoc' : 5,
   'gitformat-pack.adoc' : 5,
diff --git a/Makefile b/Makefile
index 50c96807d6..11a06934b3 100644
--- a/Makefile
+++ b/Makefile
@@ -1159,6 +1159,7 @@ LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
 LIB_OBJS += diffcore-rotate.o
+LIB_OBJS += diff-hunks.o
 LIB_OBJS += dir-iterator.o
 LIB_OBJS += dir.o
 LIB_OBJS += editor.o
@@ -1421,6 +1422,7 @@ BUILTIN_OBJS += builtin/credential.o
 BUILTIN_OBJS += builtin/describe.o
 BUILTIN_OBJS += builtin/diagnose.o
 BUILTIN_OBJS += builtin/diff-files.o
+BUILTIN_OBJS += builtin/diff-hunks.o
 BUILTIN_OBJS += builtin/diff-index.o
 BUILTIN_OBJS += builtin/diff-pairs.o
 BUILTIN_OBJS += builtin/diff-tree.o
diff --git a/builtin.h b/builtin.h
index 4e47a4ebd3..7e64da9f43 100644
--- a/builtin.h
+++ b/builtin.h
@@ -175,6 +175,7 @@ int cmd_credential_store(int argc, const char **argv, const char *prefix, struct
 int cmd_describe(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diagnose(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff_files(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_diff_hunks(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff_index(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff_pairs(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/diff-hunks.c b/builtin/diff-hunks.c
new file mode 100644
index 0000000000..3aea2dad56
--- /dev/null
+++ b/builtin/diff-hunks.c
@@ -0,0 +1,53 @@
+#include "builtin.h"
+#include "config.h"
+#include "diff-hunks.h"
+#include "gettext.h"
+#include "parse-options.h"
+#include "repository.h"
+
+static const char * const diff_hunks_usage[] = {
+	N_("git diff-hunks verify"),
+	N_("git diff-hunks clear"),
+	NULL
+};
+
+static int cmd_diff_hunks_verify(int argc, const char **argv,
+				 const char *prefix UNUSED,
+				 struct repository *r)
+{
+	struct option options[] = { OPT_END() };
+
+	argc = parse_options(argc, argv, NULL, options, diff_hunks_usage, 0);
+	if (argc)
+		usage_with_options(diff_hunks_usage, options);
+	return diff_hunks_verify(r) ? 1 : 0;
+}
+
+static int cmd_diff_hunks_clear(int argc, const char **argv,
+				const char *prefix UNUSED,
+				struct repository *r)
+{
+	struct option options[] = { OPT_END() };
+
+	argc = parse_options(argc, argv, NULL, options, diff_hunks_usage, 0);
+	if (argc)
+		usage_with_options(diff_hunks_usage, options);
+	return diff_hunks_clear(r) ? 1 : 0;
+}
+
+int cmd_diff_hunks(int argc, const char **argv, const char *prefix,
+		   struct repository *repo)
+{
+	parse_opt_subcommand_fn *fn = NULL;
+	struct option options[] = {
+		OPT_SUBCOMMAND("verify", &fn, cmd_diff_hunks_verify),
+		OPT_SUBCOMMAND("clear", &fn, cmd_diff_hunks_clear),
+		OPT_END()
+	};
+
+	repo_config(repo, git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options, diff_hunks_usage, 0);
+
+	return fn(argc, argv, prefix, repo);
+}
diff --git a/chunk-format.c b/chunk-format.c
index 51b5a2c959..34ab2750f7 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -101,12 +101,14 @@ int write_chunkfile(struct chunkfile *cf, void *data)
 	return result;
 }
 
-int read_table_of_contents(struct chunkfile *cf,
-			   const unsigned char *mfile,
-			   size_t mfile_size,
-			   uint64_t toc_offset,
-			   int toc_length,
-			   unsigned expected_alignment)
+static int read_table_of_contents_1(struct chunkfile *cf,
+				    const unsigned char *mfile,
+				    size_t mfile_size,
+				    uint64_t toc_offset,
+				    int toc_length,
+				    unsigned expected_alignment,
+				    const struct git_hash_algo *algo,
+				    int quiet)
 {
 	int i;
 	uint32_t chunk_id;
@@ -121,12 +123,14 @@ int read_table_of_contents(struct chunkfile *cf,
 		chunk_offset = get_be64(table_of_contents + 4);
 
 		if (!chunk_id) {
-			error(_("terminating chunk id appears earlier than expected"));
+			if (!quiet)
+				error(_("terminating chunk id appears earlier than expected"));
 			return 1;
 		}
 		if (chunk_offset % expected_alignment != 0) {
-			error(_("chunk id %"PRIx32" not %d-byte aligned"),
-			      chunk_id, expected_alignment);
+			if (!quiet)
+				error(_("chunk id %"PRIx32" not %d-byte aligned"),
+				      chunk_id, expected_alignment);
 			return 1;
 		}
 
@@ -134,16 +138,18 @@ int read_table_of_contents(struct chunkfile *cf,
 		next_chunk_offset = get_be64(table_of_contents + 4);
 
 		if (next_chunk_offset < chunk_offset ||
-		    next_chunk_offset > mfile_size - the_hash_algo->rawsz) {
-			error(_("improper chunk offset(s) %"PRIx64" and %"PRIx64""),
-			      chunk_offset, next_chunk_offset);
+		    next_chunk_offset > mfile_size - algo->rawsz) {
+			if (!quiet)
+				error(_("improper chunk offset(s) %"PRIx64" and %"PRIx64""),
+				      chunk_offset, next_chunk_offset);
 			return -1;
 		}
 
 		for (i = 0; i < cf->chunks_nr; i++) {
 			if (cf->chunks[i].id == chunk_id) {
-				error(_("duplicate chunk ID %"PRIx32" found"),
-					chunk_id);
+				if (!quiet)
+					error(_("duplicate chunk ID %"PRIx32" found"),
+					      chunk_id);
 				return -1;
 			}
 		}
@@ -156,13 +162,39 @@ int read_table_of_contents(struct chunkfile *cf,
 
 	chunk_id = get_be32(table_of_contents);
 	if (chunk_id) {
-		error(_("final chunk has non-zero id %"PRIx32""), chunk_id);
+		if (!quiet)
+			error(_("final chunk has non-zero id %"PRIx32""), chunk_id);
 		return -1;
 	}
 
 	return 0;
 }
 
+int read_table_of_contents(struct chunkfile *cf,
+			   const unsigned char *mfile,
+			   size_t mfile_size,
+			   uint64_t toc_offset,
+			   int toc_length,
+			   unsigned expected_alignment)
+{
+	return read_table_of_contents_1(cf, mfile, mfile_size, toc_offset,
+					toc_length, expected_alignment,
+					the_hash_algo, 0);
+}
+
+int read_table_of_contents_quiet(struct chunkfile *cf,
+				 const unsigned char *mfile,
+				 size_t mfile_size,
+				 uint64_t toc_offset,
+				 int toc_length,
+				 unsigned expected_alignment,
+				 const struct git_hash_algo *algo)
+{
+	return read_table_of_contents_1(cf, mfile, mfile_size, toc_offset,
+					toc_length, expected_alignment,
+					algo, 1);
+}
+
 struct pair_chunk_data {
 	const unsigned char **p;
 	size_t *size;
diff --git a/chunk-format.h b/chunk-format.h
index 212a0a6af1..bc31302ed0 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -39,6 +39,20 @@ int read_table_of_contents(struct chunkfile *cf,
 			   int toc_length,
 			   unsigned expected_alignment);
 
+/*
+ * Like read_table_of_contents(), for a reader that treats a malformed
+ * table as an absent file rather than reporting it: nothing is printed
+ * on failure, and the trailing-checksum bound is computed with the
+ * given hash algorithm instead of the_hash_algo.
+ */
+int read_table_of_contents_quiet(struct chunkfile *cf,
+				 const unsigned char *mfile,
+				 size_t mfile_size,
+				 uint64_t toc_offset,
+				 int toc_length,
+				 unsigned expected_alignment,
+				 const struct git_hash_algo *algo);
+
 #define CHUNK_NOT_FOUND (-2)
 
 /*
diff --git a/command-list.txt b/command-list.txt
index 21b802c420..e7b241e6ad 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -95,6 +95,7 @@ git-describe                            mainporcelain
 git-diagnose                            ancillaryinterrogators
 git-diff                                mainporcelain           info
 git-diff-files                          plumbinginterrogators
+git-diff-hunks                          plumbingmanipulators
 git-diff-index                          plumbinginterrogators
 git-diff-pairs                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
@@ -223,6 +224,7 @@ gitfaq                                  guide
 gitformat-bundle                        developerinterfaces
 gitformat-chunk                         developerinterfaces
 gitformat-commit-graph                  developerinterfaces
+gitformat-diff-hunks                    developerinterfaces
 gitformat-index                         developerinterfaces
 gitformat-pack                          developerinterfaces
 gitformat-signature                     developerinterfaces
diff --git a/diff-hunks.c b/diff-hunks.c
new file mode 100644
index 0000000000..eeaaa2466a
--- /dev/null
+++ b/diff-hunks.c
@@ -0,0 +1,916 @@
+/*
+ * Precomputed diff hunks, keyed by diff input.
+ *
+ * A single store at .git/objects/info/diff-hunks maps an (old blob,
+ * new blob, xdl_opts) key to the hunk coordinates of diffing the pair.
+ * The key determines the diff result (only trim-stable pairs are
+ * recorded; see diff-hunks.h), so an entry is valid in any context it
+ * recurs in, independent of path. Reading is on by default
+ * (core.diffHunks); writing is off by default and enabled per run or
+ * by configuration (see diff_hunks_write_enabled), so an ordinary
+ * command populates the store only during a warming run the
+ * repository owner opts into.
+ *
+ * File layout:
+ *   Header:  "DHPF"(4) + version(1) + hash_version(1)
+ *            + num_chunks(1) + reserved(1)
+ *   Table of contents (chunk-format)
+ *   DHIX chunk: sorted entries, each
+ *       old_blob_oid, new_blob_oid, xdl_opts(4), hdat_offset(4)
+ *   DHDT chunk: per entry, num_hunks(4) followed by that many 16-byte hunks
+ *   Trailing hash checksum
+ */
+#include "git-compat-util.h"
+#include "chunk-format.h"
+#include "config.h"
+#include "csum-file.h"
+#include "diff-hunks.h"
+#include "diff-provider-internal.h"
+#include "gettext.h"
+#include "hash.h"
+#include "hashmap.h"
+#include "lockfile.h"
+#include "odb.h"
+#include "path.h"
+#include "repo-settings.h"
+#include "repository.h"
+#include "strbuf.h"
+#include "wrapper.h"
+
+#define DIFF_HUNKS_SIGNATURE 0x44485046 /* "DHPF" */
+/*
+ * Bump when the on-disk format changes, or when xdiff's emitted hunk
+ * coordinates change for a fixed (blobs, xdl_opts) key: an old store
+ * would otherwise serve stale hunks and change command output.
+ */
+#define DIFF_HUNKS_VERSION 1
+#define DIFF_HUNKS_HEADER_SIZE 8
+
+#define DIFF_HUNKS_CHUNKID_INDEX 0x44484958 /* "DHIX" */
+#define DIFF_HUNKS_CHUNKID_DATA 0x44484454 /* "DHDT" */
+
+/*
+ * Each hunk is 16 bytes on disk:
+ * old_start(4) old_count(4) new_start(4) new_count(4)
+ */
+#define DIFF_HUNKS_HUNK_SIZE (4 * sizeof(uint32_t))
+
+/*
+ * Result of a store lookup: num_hunks records encoded in the store's mmap,
+ * valid until the store is freed. Read them with nth_precomputed_hunk().
+ */
+struct precomputed_entry {
+	uint32_t num_hunks;
+	const unsigned char *hunk_data;
+};
+
+/* Decode a single hunk from the raw on-disk format. */
+static inline void decode_precomputed_hunk(const unsigned char *data,
+					   struct precomputed_hunk *h)
+{
+	h->old_start = get_be32(data);
+	h->old_count = get_be32(data + 4);
+	h->new_start = get_be32(data + 8);
+	h->new_count = get_be32(data + 12);
+}
+
+/* Decode the nth hunk of a lookup result into *h. */
+static inline void nth_precomputed_hunk(const struct precomputed_entry *e,
+					uint32_t n, struct precomputed_hunk *h)
+{
+	decode_precomputed_hunk(e->hunk_data + (size_t)n * DIFF_HUNKS_HUNK_SIZE, h);
+}
+
+/* Byte length of the (old_oid, new_oid, xdl_opts) lookup key. */
+static size_t store_index_key_size(const struct git_hash_algo *algo)
+{
+	return 2 * algo->rawsz + sizeof(uint32_t);
+}
+
+/* Index entry: the lookup key followed by the 4-byte offset into DHDT. */
+static size_t store_index_entry_size(const struct git_hash_algo *algo)
+{
+	return store_index_key_size(algo) + sizeof(uint32_t);
+}
+
+/*
+ * The smallest a valid store file can be: the header, a table of contents
+ * with one entry per chunk plus a terminating entry, and the trailing
+ * checksum.
+ */
+static size_t store_min_size(const struct git_hash_algo *algo,
+			     uint8_t num_chunks)
+{
+	size_t toc_size = (num_chunks + 1) * CHUNK_TOC_ENTRY_SIZE;
+
+	return DIFF_HUNKS_HEADER_SIZE + toc_size + algo->rawsz;
+}
+
+/*
+ * Decode an index entry's key into pointers to the two oids and the
+ * xdl_opts value (on-disk: old_oid, new_oid, then xdl_opts as a
+ * big-endian uint32).
+ */
+static void decode_store_index_key(const unsigned char *entry, unsigned int rawsz,
+			     const unsigned char **old_hash,
+			     const unsigned char **new_hash,
+			     uint32_t *xdl_opts)
+{
+	*old_hash = entry;
+	*new_hash = entry + rawsz;
+	*xdl_opts = get_be32(entry + 2 * rawsz);
+}
+
+/* The DHDT offset stored in an index entry, in the field after its key. */
+static uint32_t index_entry_hdat_offset(const unsigned char *entry, size_t keysz)
+{
+	return get_be32(entry + keysz);
+}
+
+static char *diff_hunks_store_path(struct repository *r)
+{
+	return xstrfmt("%s/info/diff-hunks", repo_get_object_directory(r));
+}
+
+struct diff_hunks_store {
+	const unsigned char *data;
+	size_t data_len;
+	const struct git_hash_algo *hash_algo;
+	const unsigned char *index;
+	uint32_t num_entries;
+	const unsigned char *hdat;
+	size_t hdat_size;
+};
+
+static void free_store(struct diff_hunks_store *s)
+{
+	if (!s)
+		return;
+	if (s->data)
+		munmap((void *)s->data, s->data_len);
+	free(s);
+}
+
+/*
+ * Open, mmap, and parse the store at fname. Returns the parsed store
+ * or NULL on any error. The diff output is unaffected either way;
+ * corruption is reported by verify, not treated as fatal here.
+ */
+static struct diff_hunks_store *load_store_at(
+		const struct git_hash_algo *repo_algo, const char *fname)
+{
+	struct diff_hunks_store *s;
+	struct chunkfile *cf;
+	int fd;
+	struct stat st;
+	void *data;
+	const unsigned char *p;
+	uint8_t num_chunks;
+	size_t index_size, entry_size, data_len;
+
+	fd = git_open(fname);
+	if (fd < 0)
+		return NULL;
+	if (fstat(fd, &st) || st.st_size < DIFF_HUNKS_HEADER_SIZE) {
+		close(fd);
+		return NULL;
+	}
+	data_len = xsize_t(st.st_size);
+	data = xmmap(NULL, data_len, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	p = data;
+
+	num_chunks = p[6];
+
+	/*
+	 * Reject a file that is not a readable store: wrong signature,
+	 * version, or object hash, or too small to hold the table of
+	 * contents that read_table_of_contents() walks (it dereferences
+	 * each entry before range-checking its offset).
+	 */
+	if (get_be32(p) != DIFF_HUNKS_SIGNATURE ||
+	    p[4] != DIFF_HUNKS_VERSION ||
+	    p[5] != oid_version(repo_algo) ||
+	    data_len < store_min_size(repo_algo, num_chunks)) {
+		munmap(data, data_len);
+		return NULL;
+	}
+
+	/*
+	 * The trailing checksum is not verified here: the writer fsyncs
+	 * and commits atomically, so a committed file is intact, and
+	 * every record is bounds-checked at read (see precomputed_entry_at).
+	 * The checksum is checked separately, by diff_hunks_verify().
+	 */
+
+	CALLOC_ARRAY(s, 1);
+	s->data = data;
+	s->data_len = data_len;
+	s->hash_algo = repo_algo;
+
+	cf = init_chunkfile(NULL);
+	if (read_table_of_contents_quiet(cf, p, data_len,
+					 DIFF_HUNKS_HEADER_SIZE, num_chunks, 1,
+					 repo_algo) ||
+	    pair_chunk(cf, DIFF_HUNKS_CHUNKID_INDEX, &s->index, &index_size) ||
+	    pair_chunk(cf, DIFF_HUNKS_CHUNKID_DATA, &s->hdat, &s->hdat_size)) {
+		free_chunkfile(cf);
+		goto corrupt;
+	}
+	free_chunkfile(cf);
+
+	entry_size = store_index_entry_size(s->hash_algo);
+	if (index_size % entry_size)
+		goto corrupt;
+	s->num_entries = index_size / entry_size;
+	return s;
+
+corrupt:
+	free_store(s);
+	return NULL;
+}
+
+static struct diff_hunks_store *diff_hunks_store_load(struct repository *r)
+{
+	struct diff_hunks_store *s;
+	char *fname;
+
+	prepare_repo_settings(r);
+	if (!r->settings.core_diff_hunks)
+		return NULL;
+
+	fname = diff_hunks_store_path(r);
+	s = load_store_at(r->hash_algo, fname);
+	free(fname);
+	return s;
+}
+
+struct diff_hunks_store *repo_diff_hunks_store(struct repository *r)
+{
+	if (!r->objects)
+		return NULL;
+	if (r->objects->diff_hunks_store_attempted)
+		return r->objects->diff_hunks_store;
+	r->objects->diff_hunks_store_attempted = 1;
+	r->objects->diff_hunks_store = diff_hunks_store_load(r);
+	return r->objects->diff_hunks_store;
+}
+
+void close_diff_hunks_store(struct object_database *o)
+{
+	if (!o->diff_hunks_store)
+		return;
+	free_store(o->diff_hunks_store);
+	o->diff_hunks_store = NULL;
+}
+
+/*
+ * Fill *out with the hunk record at offset in the data chunk, and return
+ * 1 if the record is in bounds, 0 otherwise. The read path does not
+ * re-verify the checksum, and a valid checksum would not bound the count
+ * anyway, so a read must call this and use *out only when it returns
+ * non-zero.
+ *
+ * A record is a be32 hunk count followed by that many DIFF_HUNKS_HUNK_SIZE
+ * hunks. "remaining" tracks the bytes from offset to the end of the data
+ * chunk: it must hold the count, and after the count is consumed it must
+ * hold every hunk. The bounds are written as subtraction and division
+ * (never addition or multiplication) so a crafted offset or count cannot
+ * overflow them.
+ */
+static int precomputed_entry_at(const struct diff_hunks_store *s,
+				uint32_t offset, struct precomputed_entry *out)
+{
+	size_t remaining;
+	uint32_t num_hunks;
+
+	if (offset >= s->hdat_size)
+		return 0;
+	remaining = s->hdat_size - offset;
+	if (remaining < sizeof(uint32_t))
+		return 0;
+
+	num_hunks = get_be32(s->hdat + offset);
+	remaining -= sizeof(uint32_t);
+	if (num_hunks > remaining / DIFF_HUNKS_HUNK_SIZE)
+		return 0;
+
+	out->num_hunks = num_hunks;
+	out->hunk_data = s->hdat + offset + sizeof(uint32_t);
+	return 1;
+}
+
+struct lookup_key {
+	const struct object_id *old_oid;
+	const struct object_id *new_oid;
+	int xdl_opts;
+	unsigned int rawsz;
+};
+
+/*
+ * The store's total order over (old_oid, new_oid, xdl_opts), defined
+ * once so the write-side sort (writer_entry_cmp) and the read-side
+ * search (store_bsearch_cmp) order the keys identically.
+ */
+static int cmp_store_index_key(const unsigned char *old_a, const unsigned char *new_a,
+			 uint32_t opts_a,
+			 const unsigned char *old_b, const unsigned char *new_b,
+			 uint32_t opts_b, unsigned int rawsz)
+{
+	int cmp = memcmp(old_a, old_b, rawsz);
+	if (!cmp)
+		cmp = memcmp(new_a, new_b, rawsz);
+	if (!cmp)
+		cmp = (opts_a > opts_b) - (opts_a < opts_b);
+	return cmp;
+}
+
+static int store_bsearch_cmp(const void *key, const void *entry_ptr)
+{
+	const struct lookup_key *k = key;
+	const unsigned char *old_hash, *new_hash;
+	uint32_t xdl_opts;
+
+	decode_store_index_key(entry_ptr, k->rawsz, &old_hash, &new_hash,
+			 &xdl_opts);
+	return cmp_store_index_key(k->old_oid->hash, k->new_oid->hash,
+			     (uint32_t)k->xdl_opts,
+			     old_hash, new_hash, xdl_opts, k->rawsz);
+}
+
+static int store_get_one(struct diff_hunks_store *s, const struct lookup_key *key,
+			 struct precomputed_entry *out)
+{
+	size_t entry_size = store_index_entry_size(s->hash_algo);
+	const unsigned char *found;
+
+	found = bsearch(key, s->index, s->num_entries, entry_size,
+			store_bsearch_cmp);
+	if (!found)
+		return 0;
+	return precomputed_entry_at(s,
+				    index_entry_hdat_offset(found, store_index_key_size(s->hash_algo)),
+				    out);
+}
+
+static int diff_hunks_store_get(struct diff_hunks_store *s,
+			 const struct object_id *old_oid,
+			 const struct object_id *new_oid,
+			 int xdl_opts,
+			 struct precomputed_entry *out)
+{
+	struct lookup_key key;
+
+	if (!s)
+		return 0;
+	/* The null OID names no blob and cannot key an entry. */
+	if (is_null_oid(old_oid) || is_null_oid(new_oid))
+		return 0;
+
+	key.old_oid = old_oid;
+	key.new_oid = new_oid;
+	key.xdl_opts = xdl_opts;
+	key.rawsz = s->hash_algo->rawsz;
+
+	return store_get_one(s, &key, out);
+}
+
+/*
+ * A recorded hunk sequence must satisfy the provider interface's
+ * shared check (diff_provider_check_hunk()) before it may be replayed:
+ * coordinates decode from be32 into long, which is 32-bit on some
+ * platforms, so a crafted value can decode negative or out of order.
+ * An entry that fails reads as a miss, so the caller recomputes.
+ */
+static int replayable_hunks(const struct precomputed_entry *e)
+{
+	struct diff_provider_hunks_check c = { 0 };
+	uint32_t i;
+
+	/*
+	 * Replaying a record with no hunks would assert the blob pair
+	 * equivalent, a claim the store must never make (the writer
+	 * refuses to record one), so such a record is invalid.
+	 */
+	if (!e->num_hunks)
+		return 0;
+	for (i = 0; i < e->num_hunks; i++) {
+		struct precomputed_hunk h;
+		nth_precomputed_hunk(e, i, &h);
+		if (diff_provider_check_hunk(&c, h.old_start, h.old_count,
+					      h.new_start, h.new_count))
+			return 0;
+	}
+	return 1;
+}
+
+int diff_hunks_replay(struct diff_hunks_store *s,
+		      const struct object_id *old_oid,
+		      const struct object_id *new_oid,
+		      int xdl_opts,
+		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
+{
+	struct precomputed_entry e;
+	uint32_t i;
+
+	if (!diff_hunks_store_get(s, old_oid, new_oid, xdl_opts, &e) ||
+	    !replayable_hunks(&e))
+		return 0;
+	for (i = 0; i < e.num_hunks; i++) {
+		struct precomputed_hunk h;
+		nth_precomputed_hunk(&e, i, &h);
+		hunk_func(h.old_start, h.old_count,
+			  h.new_start, h.new_count, cb_data);
+	}
+	return 1;
+}
+
+/* Validate one store file. Returns 0 if valid or absent, -1 on any error. */
+static int verify_store_at(struct repository *r, const char *fname)
+{
+	struct diff_hunks_store *s;
+	size_t entry_size;
+	uint32_t i;
+	int fd;
+	int ret = 0;
+
+	/*
+	 * A file that cannot be opened is not evidence of corruption:
+	 * report the open error, and reserve the corruption diagnostics
+	 * below for a file that was read and failed to parse.
+	 */
+	fd = git_open(fname);
+	if (fd < 0) {
+		if (errno == ENOENT)
+			return 0; /* absent is valid */
+		return error_errno(_("unable to open diff-hunks store %s"),
+				   fname);
+	}
+	close(fd);
+	s = load_store_at(r->hash_algo, fname);
+	if (!s)
+		return error(_("diff-hunks store failed to load (corrupt "
+			       "header or hash mismatch): %s"), fname);
+	if (!hashfile_checksum_valid(r->hash_algo, s->data, s->data_len)) {
+		error(_("diff-hunks store has incorrect checksum and is "
+			"likely corrupt: %s"), fname);
+		free_store(s);
+		return -1;
+	}
+
+	entry_size = store_index_entry_size(s->hash_algo);
+	for (i = 0; i < s->num_entries; i++) {
+		const unsigned char *ep = s->index + st_mult(entry_size, i);
+		size_t keysz = store_index_key_size(s->hash_algo);
+		uint32_t offset = index_entry_hdat_offset(ep, keysz);
+		struct precomputed_entry pe;
+
+		/*
+		 * Keyed by (old_oid, new_oid, xdl_opts), increasing.  memcmp
+		 * matches cmp_store_index_key's integer comparison of
+		 * xdl_opts because it is non-negative, so its big-endian
+		 * bytes order the same as its value.
+		 */
+		if (i > 0 && memcmp(ep - entry_size, ep, keysz) >= 0) {
+			error(_("diff-hunks entry %u not in sorted order"), i);
+			ret = -1;
+		}
+		if (!precomputed_entry_at(s, offset, &pe)) {
+			error(_("diff-hunks entry %u has out-of-bounds hunk "
+				"data"), i);
+			ret = -1;
+		} else if (!replayable_hunks(&pe)) {
+			error(_("diff-hunks entry %u holds an invalid hunk "
+				"sequence"), i);
+			ret = -1;
+		}
+	}
+
+	free_store(s);
+	return ret;
+}
+
+int diff_hunks_verify(struct repository *r)
+{
+	char *fname = diff_hunks_store_path(r);
+	int ret = 0;
+
+	if (verify_store_at(r, fname))
+		ret = -1;
+	free(fname);
+	return ret;
+}
+
+int diff_hunks_clear(struct repository *r)
+{
+	char *fname = diff_hunks_store_path(r);
+	int ret = 0;
+
+	if (unlink(fname) && errno != ENOENT)
+		ret = error_errno(_("unable to remove %s"), fname);
+	free(fname);
+	return ret;
+}
+
+struct writer_entry {
+	struct object_id old_oid;
+	struct object_id new_oid;
+	int xdl_opts;
+	uint32_t hdat_offset;
+};
+
+struct diff_hunks_writer {
+	struct repository *r;
+	struct writer_entry *entries;
+	size_t nr, alloc;
+	size_t seed_nr;		/* nr after seeding; finish skips a no-op flush */
+	unsigned force_flush : 1;	/* seed pruned: rewrite even a no-op warm */
+	struct strbuf hdat;
+	struct hashmap dedup;	/* hunk block content -> offset in hdat */
+};
+
+/* A record of one distinct hunk block already present in hdat. */
+struct dedup_entry {
+	struct hashmap_entry ent;
+	uint32_t offset;
+	uint32_t len;
+};
+
+static int dedup_cmp(const void *cmp_data,
+		     const struct hashmap_entry *a,
+		     const struct hashmap_entry *b,
+		     const void *keydata UNUSED)
+{
+	const struct diff_hunks_writer *writer = cmp_data;
+	const struct dedup_entry *ea = container_of(a, const struct dedup_entry, ent);
+	const struct dedup_entry *eb = container_of(b, const struct dedup_entry, ent);
+
+	if (ea->len != eb->len)
+		return 1;
+	return memcmp(writer->hdat.buf + ea->offset,
+		      writer->hdat.buf + eb->offset, ea->len);
+}
+
+static struct diff_hunks_writer *diff_hunks_writer_new(struct repository *r)
+{
+	struct diff_hunks_writer *w;
+
+	CALLOC_ARRAY(w, 1);
+	w->r = r;
+	strbuf_init(&w->hdat, 0);
+	hashmap_init(&w->dedup, dedup_cmp, w, 0);
+	return w;
+}
+
+static void strbuf_put_be32(struct strbuf *sb, uint32_t val)
+{
+	unsigned char buf[4];
+	put_be32(buf, val);
+	strbuf_add(sb, buf, 4);
+}
+
+/*
+ * The hunk block just appended at `start` is deduplicated: if an
+ * identical block is already in hdat, this copy is dropped and the
+ * earlier offset returned; otherwise it is kept and remembered.
+ * Distinct keys that diff to the same hunks then share one block.
+ */
+static uint32_t intern_block(struct diff_hunks_writer *w, size_t start)
+{
+	size_t len = w->hdat.len - start;
+	struct dedup_entry key, *found, *added;
+
+	hashmap_entry_init(&key.ent, memhash(w->hdat.buf + start, len));
+	key.offset = (uint32_t)start;
+	key.len = (uint32_t)len;
+
+	found = hashmap_get_entry(&w->dedup, &key, ent, NULL);
+	if (found) {
+		strbuf_setlen(&w->hdat, start);
+		return found->offset;
+	}
+
+	added = xmalloc(sizeof(*added));
+	hashmap_entry_init(&added->ent, key.ent.hash);
+	added->offset = key.offset;
+	added->len = key.len;
+	hashmap_add(&w->dedup, &added->ent);
+	return key.offset;
+}
+
+int diff_hunks_writer_add(struct diff_hunks_writer *w,
+			  const struct object_id *old_oid,
+			  const struct object_id *new_oid,
+			  int xdl_opts,
+			  const struct precomputed_hunk *hunks,
+			  size_t nr_hunks)
+{
+	struct writer_entry *e;
+	size_t i, block_start;
+
+	if (!w)
+		return 0;
+	/*
+	 * The block appended for this entry is sizeof(uint32_t) +
+	 * nr_hunks * DIFF_HUNKS_HUNK_SIZE bytes. Bound nr_hunks so that
+	 * length fits the uint32_t the dedup index records (and so the
+	 * count itself fits the uint32_t written to the store).
+	 */
+	if (!nr_hunks ||
+	    nr_hunks > (UINT32_MAX - sizeof(uint32_t)) / DIFF_HUNKS_HUNK_SIZE ||
+	    is_null_oid(old_oid) || is_null_oid(new_oid))
+		return 0;
+	if (w->hdat.len > UINT32_MAX)
+		return 0;
+	/*
+	 * Coordinates are stored as 32-bit values; a result that cannot
+	 * round-trip is dropped rather than silently truncated.
+	 */
+	for (i = 0; i < nr_hunks; i++)
+		if ((uintmax_t)hunks[i].old_start > (uintmax_t)INT32_MAX ||
+		    (uintmax_t)hunks[i].old_count > (uintmax_t)INT32_MAX ||
+		    (uintmax_t)hunks[i].new_start > (uintmax_t)INT32_MAX ||
+		    (uintmax_t)hunks[i].new_count > (uintmax_t)INT32_MAX)
+			return 0;
+
+	ALLOC_GROW(w->entries, w->nr + 1, w->alloc);
+	e = &w->entries[w->nr++];
+	oidcpy(&e->old_oid, old_oid);
+	oidcpy(&e->new_oid, new_oid);
+	e->xdl_opts = xdl_opts;
+
+	block_start = w->hdat.len;
+	strbuf_put_be32(&w->hdat, (uint32_t)nr_hunks);
+	for (i = 0; i < nr_hunks; i++) {
+		strbuf_put_be32(&w->hdat, hunks[i].old_start);
+		strbuf_put_be32(&w->hdat, hunks[i].old_count);
+		strbuf_put_be32(&w->hdat, hunks[i].new_start);
+		strbuf_put_be32(&w->hdat, hunks[i].new_count);
+	}
+	e->hdat_offset = intern_block(w, block_start);
+	return 1;
+}
+
+/*
+ * Seed the writer with fname's entries so a rewrite preserves them,
+ * setting *pruned when the rewrite will not carry the whole file
+ * forward: the file failed its checksum and was discarded outright, or
+ * individual entries were dropped because they failed the replayable
+ * check or the writer refused them (a key naming no blob).  A
+ * rewrite re-checksums, so corruption must not be carried forward:
+ * that would launder it into a checksum-valid file that verify can no
+ * longer catch.  This path already reads the whole file, so verify the
+ * checksum here (the reader keeps trusting committed files, without
+ * re-checksumming); an invalid
+ * entry reads as a miss anyway, so dropping it heals the store rather
+ * than losing anything a reader could use.
+ */
+static void diff_hunks_writer_seed(struct diff_hunks_writer *w,
+				   const char *fname, int *pruned)
+{
+	struct diff_hunks_store *s = load_store_at(w->r->hash_algo, fname);
+	unsigned int rawsz;
+	size_t entry_size, keysz;
+	struct precomputed_hunk *hunks = NULL;
+	size_t hunks_alloc = 0;
+	uint32_t i, dropped = 0;
+
+	if (!s)
+		return;
+	if (!hashfile_checksum_valid(w->r->hash_algo, s->data, s->data_len)) {
+		warning(_("diff-hunks store %s failed its checksum; "
+			  "discarding it"), fname);
+		free_store(s);
+		*pruned = 1;
+		return;
+	}
+	rawsz = s->hash_algo->rawsz;
+	entry_size = store_index_entry_size(s->hash_algo);
+	keysz = store_index_key_size(s->hash_algo);
+
+	for (i = 0; i < s->num_entries; i++) {
+		const unsigned char *ep = s->index + st_mult(entry_size, i);
+		const unsigned char *old_hash, *new_hash;
+		struct object_id old_oid, new_oid;
+		uint32_t xdl_opts, j;
+		struct precomputed_entry pe;
+
+		decode_store_index_key(ep, rawsz, &old_hash, &new_hash,
+				 &xdl_opts);
+		oidread(&old_oid, old_hash, s->hash_algo);
+		oidread(&new_oid, new_hash, s->hash_algo);
+		if (!precomputed_entry_at(s, index_entry_hdat_offset(ep, keysz), &pe) ||
+		    !replayable_hunks(&pe)) {
+			dropped++;
+			continue;
+		}
+		ALLOC_GROW(hunks, pe.num_hunks, hunks_alloc);
+		for (j = 0; j < pe.num_hunks; j++)
+			nth_precomputed_hunk(&pe, j, &hunks[j]);
+		if (!diff_hunks_writer_add(w, &old_oid, &new_oid,
+					   (int)xdl_opts, hunks, pe.num_hunks))
+			dropped++;
+	}
+	if (dropped) {
+		warning(Q_("diff-hunks store %s: dropping %u invalid entry",
+			   "diff-hunks store %s: dropping %u invalid entries",
+			   dropped), fname, dropped);
+		*pruned = 1;
+	}
+	free(hunks);
+	free_store(s);
+}
+
+/*
+ * Writing is off by default. It is enabled per invocation by the
+ * GIT_DIFF_HUNKS_WRITE environment variable, or persistently by the
+ * diffHunks.write config, with the environment variable winning when
+ * set. Only a warming run (a diff or log the repository owner chooses
+ * to run with writing on) enables it, so ordinary reads never mutate
+ * the store.
+ */
+static int diff_hunks_write_enabled(struct repository *r)
+{
+	const char *env = getenv("GIT_DIFF_HUNKS_WRITE");
+	int val;
+
+	if (env) {
+		/*
+		 * This is a warming opt-in, so an unparseable value must not
+		 * abort an ordinary read command: treat it as disabled.
+		 */
+		val = git_parse_maybe_bool(env);
+		return val < 0 ? 0 : val;
+	}
+	if (!repo_config_get_bool(r, "diffhunks.write", &val))
+		return val;
+	return 0;
+}
+
+struct diff_hunks_writer *diff_hunks_writer_maybe_new(struct repository *r)
+{
+	struct diff_hunks_writer *w;
+	char *fname;
+	int pruned;
+
+	if (!diff_hunks_write_enabled(r))
+		return NULL;
+	/*
+	 * Seed from the existing store so a flush merges with it rather
+	 * than replacing it: a later warm adds newly computed pairs
+	 * without discarding what earlier warms recorded.
+	 */
+	w = diff_hunks_writer_new(r);
+	fname = diff_hunks_store_path(r);
+	pruned = 0;
+	diff_hunks_writer_seed(w, fname, &pruned);
+	free(fname);
+	w->seed_nr = w->nr;
+	/*
+	 * A pruning seed means the file on disk holds material the
+	 * rewrite must not preserve; flush even if this warm computes
+	 * nothing new, so the store on disk is repaired rather than
+	 * left serving what the seed refused.
+	 */
+	w->force_flush = !!pruned;
+	return w;
+}
+
+static int writer_entry_cmp(const void *va, const void *vb, void *ctx)
+{
+	const struct writer_entry *a = va, *b = vb;
+	unsigned int rawsz = *(const unsigned int *)ctx;
+	return cmp_store_index_key(a->old_oid.hash, a->new_oid.hash,
+			     (uint32_t)a->xdl_opts,
+			     b->old_oid.hash, b->new_oid.hash,
+			     (uint32_t)b->xdl_opts,
+			     rawsz);
+}
+
+struct write_ctx {
+	struct diff_hunks_writer *w;
+	unsigned int rawsz;
+};
+
+static int write_index_chunk(struct hashfile *f, void *data)
+{
+	struct write_ctx *ctx = data;
+	size_t i;
+
+	for (i = 0; i < ctx->w->nr; i++) {
+		hashwrite(f, ctx->w->entries[i].old_oid.hash, ctx->rawsz);
+		hashwrite(f, ctx->w->entries[i].new_oid.hash, ctx->rawsz);
+		hashwrite_be32(f, ctx->w->entries[i].xdl_opts);
+		hashwrite_be32(f, ctx->w->entries[i].hdat_offset);
+	}
+	return 0;
+}
+
+static int write_data_chunk(struct hashfile *f, void *data)
+{
+	struct write_ctx *ctx = data;
+	hashwrite(f, ctx->w->hdat.buf, ctx->w->hdat.len);
+	return 0;
+}
+
+/* Sort, dedup, and write the accumulated entries to the file at fname. */
+static int diff_hunks_writer_flush(struct diff_hunks_writer *w, char *fname)
+{
+	struct lock_file lk = LOCK_INIT;
+	struct hashfile *f;
+	struct chunkfile *cf;
+	unsigned int rawsz = w->r->hash_algo->rawsz;
+	struct write_ctx ctx = { w, rawsz };
+	size_t entry_size;
+
+	QSORT_S(w->entries, w->nr, writer_entry_cmp, &rawsz);
+
+	/*
+	 * The same blob pair recurs across history (reverts, cherry-
+	 * picks); identical keys carry identical hunks, so keep one of
+	 * each. The index must stay duplicate-free for binary search.
+	 */
+	if (w->nr > 1) {
+		size_t kept = 1, i;
+		for (i = 1; i < w->nr; i++)
+			if (writer_entry_cmp(&w->entries[kept - 1],
+					      &w->entries[i], &rawsz))
+				w->entries[kept++] = w->entries[i];
+		w->nr = kept;
+	}
+
+	if (safe_create_leading_directories(w->r, fname)) {
+		error(_("unable to create directory for %s"), fname);
+		return -1;
+	}
+	if (hold_lock_file_for_update(&lk, fname, 0) < 0) {
+		error_errno(_("unable to lock %s"), fname);
+		return -1;
+	}
+	adjust_shared_perm(w->r, get_lock_file_path(&lk));
+	f = hashfd(w->r->hash_algo, get_lock_file_fd(&lk),
+		   get_lock_file_path(&lk));
+
+	entry_size = store_index_entry_size(w->r->hash_algo);
+	cf = init_chunkfile(f);
+	add_chunk(cf, DIFF_HUNKS_CHUNKID_INDEX, w->nr * entry_size,
+		  write_index_chunk);
+	add_chunk(cf, DIFF_HUNKS_CHUNKID_DATA, w->hdat.len, write_data_chunk);
+
+	hashwrite_be32(f, DIFF_HUNKS_SIGNATURE);
+	hashwrite_u8(f, DIFF_HUNKS_VERSION);
+	hashwrite_u8(f, oid_version(w->r->hash_algo));
+	hashwrite_u8(f, get_num_chunks(cf));
+	hashwrite_u8(f, 0); /* reserved */
+
+	write_chunkfile(cf, &ctx);
+	free_chunkfile(cf);
+
+	/*
+	 * fsync per the user's configuration (like commit-graph and the
+	 * multi-pack-index), then commit atomically. Readers trust the
+	 * committed file rather than re-checksumming it; diff_hunks_verify()
+	 * checks the checksum separately.
+	 */
+	finalize_hashfile(f, NULL, FSYNC_COMPONENT_DIFF_HUNKS,
+			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	/*
+	 * This same process may hold the current store mmapped (a warm
+	 * that also reads); the commit below renames over it, which must
+	 * never land on a live mapping (Windows refuses it).  Close the
+	 * store and clear the load-attempted flag first, so the next
+	 * read loads the committed file.
+	 */
+	if (w->r->objects) {
+		close_diff_hunks_store(w->r->objects);
+		w->r->objects->diff_hunks_store_attempted = 0;
+	}
+	if (commit_lock_file(&lk)) {
+		error_errno(_("unable to write %s"), fname);
+		return -1;
+	}
+	return 0;
+}
+
+static void diff_hunks_writer_free(struct diff_hunks_writer *w)
+{
+	if (!w)
+		return;
+	hashmap_clear_and_free(&w->dedup, struct dedup_entry, ent);
+	free(w->entries);
+	strbuf_release(&w->hdat);
+	free(w);
+}
+
+void diff_hunks_writer_finish(struct diff_hunks_writer *w)
+{
+	if (!w)
+		return;
+	/* Skip the flush when the warm recorded nothing beyond its seed. */
+	if (w->nr != w->seed_nr || w->force_flush) {
+		char *fname = diff_hunks_store_path(w->r);
+		diff_hunks_writer_flush(w, fname);
+		free(fname);
+	}
+	diff_hunks_writer_free(w);
+}
diff --git a/diff-hunks.h b/diff-hunks.h
new file mode 100644
index 0000000000..ef9ee3f417
--- /dev/null
+++ b/diff-hunks.h
@@ -0,0 +1,117 @@
+#ifndef DIFF_HUNKS_H
+#define DIFF_HUNKS_H
+
+#include "hash.h"
+#include "xdiff-interface.h"	/* xdl_emit_hunk_consume_func_t */
+
+struct object_id;
+struct repository;
+struct object_database;
+
+/*
+ * A persistent store of precomputed diff hunk coordinates, at
+ * .git/objects/info/diff-hunks. Entries are keyed by the two blobs diffed
+ * and the xdl_opts they were diffed under, so a cached result is valid
+ * in any context that key recurs in, independent of path. The xdl_opts
+ * key component mirrors the (always non-negative) diff_options field it
+ * projects from, and is serialized and compared as a 4-byte big-endian
+ * integer.
+ *
+ * The hunks a pair produces are not unique. They vary with the xdiff
+ * algorithm and ignore flags (xdl_opts, part of the key), and with
+ * whether the diff was trimmed: a zero-context diff runs
+ * trim_common_tail, which can pick a different but equally valid set of
+ * hunks than an untrimmed diff. The store holds one entry per key, so a
+ * pair is recorded only when its trimmed and untrimmed diffs are
+ * identical (the recording caller checks); such an entry serves a
+ * consumer at any context. The rare pair where the two diffs differ is
+ * never recorded and is always computed.
+ *
+ * The store is a cache: ordinary commands read it and fall back to
+ * computing the diff when it is absent, stale, or corrupt. It is filled
+ * as a side effect of diff and log runs, but only when writing is
+ * enabled (such a write-enabled run is a warming run); writing is off
+ * by default, so an ordinary command reads the store without recording
+ * into it.
+ */
+
+/*
+ * A hunk's coordinates. The type is long to match the xdiff emit
+ * callback; the values are a diff's line numbers and counts, always
+ * within the int32 range the on-disk format stores (see
+ * diff_hunks_writer_add()).
+ */
+struct precomputed_hunk {
+	long old_start;
+	long old_count;
+	long new_start;
+	long new_count;
+};
+
+/*
+ * The repository's store, loaded once on first use and cached on the
+ * object database. Returns NULL when reading is disabled
+ * (core.diffHunks=false), the store is absent, or it fails to parse
+ * (wrong signature, version, or object hash, or a corrupt structure).
+ * The lookup functions below accept a NULL store and treat it as
+ * empty (every lookup misses), so callers need not check for NULL.
+ * The object database owns the store; callers must not free it.
+ */
+struct diff_hunks_store *repo_diff_hunks_store(struct repository *r);
+
+/* Free the repository's cached store, at object-database teardown. */
+void close_diff_hunks_store(struct object_database *o);
+
+/*
+ * Replay the recorded hunks of an (old blob, new blob) pair diffed
+ * under xdl_opts through hunk_func. The sequence is validated before
+ * any callback runs: on a hit (return 1) every hunk is emitted, on a
+ * miss (return 0: absent pair, xdl_opts mismatch, or an entry that
+ * fails validation) nothing is emitted, so a caller may accumulate
+ * directly into its result.
+ */
+int diff_hunks_replay(struct diff_hunks_store *s,
+		      const struct object_id *old_oid,
+		      const struct object_id *new_oid,
+		      int xdl_opts,
+		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data);
+
+/*
+ * A warming run's writer: it accumulates the hunks it computes in memory
+ * and flushes them to the store in one pass at finish.
+ */
+struct diff_hunks_writer;
+
+/*
+ * Return a writer for a warming run, or NULL when writing is disabled
+ * (the default). diff_hunks_writer_add() tolerates a NULL writer, so a
+ * caller may attach the result unconditionally. Pair with
+ * diff_hunks_writer_finish().
+ */
+struct diff_hunks_writer *diff_hunks_writer_maybe_new(struct repository *r);
+
+/*
+ * Record a blob pair's hunks as computed under xdl_opts; a later lookup
+ * with a matching key is served these hunks. The caller must have
+ * checked that the pair's trimmed and untrimmed diffs are identical
+ * (see the top of this file), so the entry answers at any context.
+ * NULL-safe. Returns 1 when the entry was recorded, 0 when the writer
+ * refused it (no hunks, a null object id, or values the on-disk
+ * 32-bit fields cannot hold).
+ */
+int diff_hunks_writer_add(struct diff_hunks_writer *w,
+			  const struct object_id *old_oid,
+			  const struct object_id *new_oid,
+			  int xdl_opts,
+			  const struct precomputed_hunk *hunks,
+			  size_t nr_hunks);
+
+/* Flush the accumulated entries to the store and free the writer. NULL-safe. */
+void diff_hunks_writer_finish(struct diff_hunks_writer *w);
+
+/* Remove the store file. Returns 0 (incl. absent) or -1. */
+int diff_hunks_clear(struct repository *r);
+/* Validate the store. Returns 0 if valid/absent, -1 if corrupt. */
+int diff_hunks_verify(struct repository *r);
+
+#endif /* DIFF_HUNKS_H */
diff --git a/environment.c b/environment.c
index c663113e8a..a0e6d0b9b3 100644
--- a/environment.c
+++ b/environment.c
@@ -239,6 +239,7 @@ static const struct fsync_component_name {
 	{ "pack", FSYNC_COMPONENT_PACK },
 	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
 	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
+	{ "diff-hunks", FSYNC_COMPONENT_DIFF_HUNKS },
 	{ "index", FSYNC_COMPONENT_INDEX },
 	{ "objects", FSYNC_COMPONENTS_OBJECTS },
 	{ "reference", FSYNC_COMPONENT_REFERENCE },
diff --git a/git.c b/git.c
index e5f1811b6b..cb149e4b4e 100644
--- a/git.c
+++ b/git.c
@@ -566,6 +566,7 @@ static struct cmd_struct commands[] = {
 	{ "diagnose", cmd_diagnose, RUN_SETUP_GENTLY },
 	{ "diff", cmd_diff, NO_PARSEOPT },
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "diff-hunks", cmd_diff_hunks, RUN_SETUP },
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
 	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP | NO_PARSEOPT },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
diff --git a/meson.build b/meson.build
index 539a50f90e..391d9da93c 100644
--- a/meson.build
+++ b/meson.build
@@ -364,6 +364,7 @@ libgit_sources = [
   'diffcore-pickaxe.c',
   'diffcore-rename.c',
   'diffcore-rotate.c',
+  'diff-hunks.c',
   'dir-iterator.c',
   'dir.c',
   'editor.c',
@@ -633,6 +634,7 @@ builtin_sources = [
   'builtin/describe.c',
   'builtin/diagnose.c',
   'builtin/diff-files.c',
+  'builtin/diff-hunks.c',
   'builtin/diff-index.c',
   'builtin/diff-pairs.c',
   'builtin/diff-tree.c',
diff --git a/odb.c b/odb.c
index cf6e7938c0..b300cd522d 100644
--- a/odb.c
+++ b/odb.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "commit-graph.h"
 #include "config.h"
+#include "diff-hunks.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
@@ -1033,6 +1034,7 @@ void odb_close(struct object_database *o)
 	for (source = o->sources; source; source = source->next)
 		odb_source_close(source);
 	close_commit_graph(o);
+	close_diff_hunks_store(o);
 }
 
 static void odb_free_sources(struct object_database *o)
diff --git a/odb.h b/odb.h
index 7995bed97b..949d55668f 100644
--- a/odb.h
+++ b/odb.h
@@ -8,6 +8,7 @@
 #include "thread-utils.h"
 
 struct cached_object_entry;
+struct diff_hunks_store;
 struct list_objects_filter_options;
 struct odb_source_inmemory;
 struct packed_git;
@@ -76,6 +77,9 @@ struct object_database {
 	struct commit_graph *commit_graph;
 	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
 
+	struct diff_hunks_store *diff_hunks_store;
+	unsigned diff_hunks_store_attempted : 1; /* if loading has been attempted */
+
 	/*
 	 * This is meant to hold a *small* number of objects that you would
 	 * want odb_read_object() to be able to return, but yet you do not want
diff --git a/repo-settings.c b/repo-settings.c
index f3be3b8c5a..c3015356ba 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -77,6 +77,7 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
 	repo_cfg_bool(r, "pack.usepathwalk", &r->settings.pack_use_path_walk, 0);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
+	repo_cfg_bool(r, "core.diffhunks", &r->settings.core_diff_hunks, 1);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
 	repo_cfg_bool(r, "index.skiphash", &r->settings.index_skip_hash, r->settings.index_skip_hash);
 	repo_cfg_bool(r, "pack.readreverseindex", &r->settings.pack_read_reverse_index, 1);
diff --git a/repo-settings.h b/repo-settings.h
index e5253ead02..615a55cac4 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -22,6 +22,7 @@ struct repo_settings {
 	int core_commit_graph;
 	int commit_graph_generation_version;
 	int commit_graph_changed_paths_version;
+	int core_diff_hunks;
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;
 	int command_requires_full_index;
diff --git a/write-or-die.h b/write-or-die.h
index ff0408bd84..35ed324307 100644
--- a/write-or-die.h
+++ b/write-or-die.h
@@ -22,13 +22,15 @@ enum fsync_component {
 	FSYNC_COMPONENT_INDEX			= 1 << 4,
 	FSYNC_COMPONENT_REFERENCE		= 1 << 5,
 	FSYNC_COMPONENT_OBJECT_MAP		= 1 << 6,
+	FSYNC_COMPONENT_DIFF_HUNKS		= 1 << 7,
 };
 
 #define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
 				  FSYNC_COMPONENT_PACK)
 
 #define FSYNC_COMPONENTS_DERIVED_METADATA (FSYNC_COMPONENT_PACK_METADATA | \
-					   FSYNC_COMPONENT_COMMIT_GRAPH)
+					   FSYNC_COMPONENT_COMMIT_GRAPH | \
+					   FSYNC_COMPONENT_DIFF_HUNKS)
 
 #define FSYNC_COMPONENTS_DEFAULT ((FSYNC_COMPONENTS_OBJECTS | \
 				   FSYNC_COMPONENTS_DERIVED_METADATA) & \
@@ -46,7 +48,8 @@ enum fsync_component {
 			      FSYNC_COMPONENT_COMMIT_GRAPH | \
 			      FSYNC_COMPONENT_INDEX | \
 			      FSYNC_COMPONENT_REFERENCE | \
-			      FSYNC_COMPONENT_OBJECT_MAP)
+			      FSYNC_COMPONENT_OBJECT_MAP | \
+			      FSYNC_COMPONENT_DIFF_HUNKS)
 
 #ifndef FSYNC_COMPONENTS_PLATFORM_DEFAULT
 #define FSYNC_COMPONENTS_PLATFORM_DEFAULT FSYNC_COMPONENTS_DEFAULT
-- 
2.54.0

