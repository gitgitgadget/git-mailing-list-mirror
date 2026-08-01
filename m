Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885133B6379
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606120; cv=none; b=oKWmm6BVie9jlCpStF+F/2B/CYDZIYfKUS/mfHfKXP+m1TW7vsXKOYikke8tmoLamNZMkKpbspHCEfZbcBcTBBzFprHBOsi7bPnXKQGrrvc9LqS7LErfsjsCqxpwnjDRg/OoPoPn5hbUiZpFSUGl4gi5pRAU/nBBMpSgDqhrT8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606120; c=relaxed/simple;
	bh=CK0WlGCiLgLBSgeU4pXsjmHYPpcwSMneAFveT49mmS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1ljF5ovzmeU7JcsNqYH+nFCOLjOXSsNEjsqaoOaz0Trk09ga3IBCCL9sO6n+INy+IgAOKJoM/SZ71XFi8u4UXdADAnrpXB668krhxPgSN2rF0DIrJpO3oB2/VmtgZ9riHUHeF0Hw5YkiQTqwOUi10AT5nf+Rud9xmEF4rhzRe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbqVNs6c; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbqVNs6c"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1825444a12.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785606118; x=1786210918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YAZQ9yPxugESN3fO0HNjrJfCdhspM4NNHGUnslwD5bo=;
        b=DbqVNs6cqJL+i+w/AL/KJJSabtmUeTF8AdZ7qiMiqMU8+t5cI0Jm0djpCG2h8vnoXx
         MqCkTh4+DxCprUuyJfASQaZqqVUI+ulhM1Fx61X9R48S/fFaUGMU/WNE9BM6eV9DvnEA
         Fr3IKMGzjhKJLlRPQGyZ6dzn+UKZ463AwPA/RHt+GYtvObcJACKLJf6/t+qo8ZcWGYPy
         ncJE79/0LiS1RoDr5Bw62PV6Lv247E23z66I4+e2m+RBilNLnqKIqOdRPpQPtTveciNW
         qnM65MpD1vuT/KMUk1EbqED1JXExqBxc/R7TGn25AZKh9jbjck8RyxaT+D18T2MGRldP
         Tzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785606118; x=1786210918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YAZQ9yPxugESN3fO0HNjrJfCdhspM4NNHGUnslwD5bo=;
        b=kk4Il5bXmY0YoHs6OknbWx8gaNbgENA2qzkLnAxaY52ivF1d0PSOHyIetvXDMNwQvw
         iUhHIA/mbR4vZqdfEgkDuaEUpqW/szMd3hR4K5aMLYux4VPDUTA6hffjkJPAe0pr3QQO
         ZTc9lkKkNpQFgjn6pPsS+6uOCzOSoMx+/sFfdiXWdpcvwFBR6J7mKrFtTKUNiGk8ptvM
         hyCYVX1yudFoJ4v6DWDtnbr1Rwyf0TbmPWnOvUhNBnlq2X5W4SvH0NW+dHUlSxglcjK0
         Kl+MVqFMhgvFNkS7hYd0PdM4xF4BmhYM2hfaouc1S1oFg6DsxR6ZmVAKZqPLEzqdVAIa
         nIGQ==
X-Gm-Message-State: AOJu0YypdHKjWY8np6INfm1+nzT0TPCHNuHXKwIfLThHHaTdQxEcnx+x
	ZRNgxN2JJjqjJ8nGkghBdXiONoBrTPc8tFhuogeLnz6o3APXc4MLeH/UopOXrw==
X-Gm-Gg: AR+sD13mzs33g8lQj0VLbG7IC2zFGGsEmChWS8qu8d2R4cIZd/QaNrF7wi+phJ3cZ+p
	+cIQEQooqIEuWp6SzolZIv0MzxK7Qr7KOPkBRmBZ7pXM+C1OWIoRpghc1DCi0aTLudkcMZC3iVt
	vBSS9jlFM9CflvyA9kk+3y/kdqVmqzjdZ/M2uogD8d4XJbm/E0qI8inmrSySJqtbmZAQL+2PpTl
	IdLD737Xjca7R6K8Gztfj7BpArst3Qr6mv/Ql/wdSyy/i8MBMrf0EvA8TG2BGUn0FDOJJvah5Gv
	p4gCh34fetMzbzOjIr+NZnfjz3tVo2TN3o1pKHIrI1ekPi+ubQ98mQKkqOQtxW1RHA7yF2Etw5l
	4vGqE8rC2RQiTWtlSkEQrIxZ7UrbewnwImHHZ+4A4hXCbJztGn5A9vAotDZjkkgWHQ/5MhUN/6/
	Lk8xBKLibPJOFFiG13pvWNP87go9LtAzi6zFstQ2Wp7l4fRq1XjkntNX39CUNeswVW8CgMXqiCy
	qCxkEgjThR3zgbGX1vVKCuvVMFXGI3Ka3Ny7vfqSWA0mFfB1hMtjCTU1ancpvDq2FVhhdS3wEKA
	VKlCM6c94v2B6G9fWX419P191Tgg+weFYDv8atPofY9qmw==
X-Received: by 2002:a05:6a20:9e46:b0:3b4:605c:2163 with SMTP id adf61e73a8af0-3c92a53ee79mr4068380637.4.1785606117596;
        Sat, 01 Aug 2026 10:41:57 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb50dsm25470957c88.10.2026.08.01.10.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:41:56 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC PATCH v7 0/10] diff: add provider interface and initial providers
Date: Sat,  1 Aug 2026 10:41:43 -0700
Message-ID: <20260801174156.2998808-1-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
References: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every in-process diff in Git reduces, at one point, to a single
question: given two blobs and the settings the diff runs under, which
line ranges changed?  The answer is the diff's hunks: for each change,
the position and length of the range on the old side and on the new.
Each consumer asks in its own shape:

- blame diffs each suspect's blob against its parent's, taking only the
  coordinates through xdiff's hunk callback;
- the stat formats keep only the added and deleted counts;
- patch output emits from the hunks, with xdiff interleaving context and
  content around them;
- log -L maps the tracked range across each commit from the coordinates.

In every case the answer is computed the same way: load both blobs and
run xdiff.  That is the only source, so nothing that already holds the
answer, or that would answer differently on purpose, can supply it
instead.  Sometimes that is what we want, which is why patch-id and
format-patch stay on the builtin computation throughout: patch-id needs
identical hashes on every machine, and a format-patch must apply for
recipients who share none of the sender's configuration.  Other times
another source would be useful.

This RFC sketches a direction.  The unified series shows one interface
carrying two example providers and their interaction; it is not shaped
to merge as one topic.  If the direction holds, the work returns as
separate reviewable series (see Roadmap).  The two examples are
demonstrations, each an RFC on its own: diff.<driver>.process, the RFC
cooking as mm/diff-process-hunks, lets a configured external process
answer with its own notion of which lines changed, and the diff-hunks
store, new in this thread, remembers what xdiff computed and serves it
back.  One is authoritative and external, one a cache and in-process.

Three pieces:

- A hunk provider interface (diff-provider.h) is the point of the
  series.  A provider is an alternate source for the answer: asked with
  the pair's object ids and the diff settings, before any blob is
  loaded, it may supply the hunks in place of the builtin computation.
  A miss falls through to that computation, and every answer passes one
  shared validity check first.  The providers form a chain the
  repository owns, built on first consultation and released in
  repo_clear(), so provider state such as a running process never
  outlives its repository.  Chain order is the authority, and the
  terminal provider is the builtin computation itself, so the interface
  never exists without an implementor: patch 02 ships it answering every
  request the way the consumers did before.  A consumer states its
  request in one struct and reads one set of outcomes (answered,
  unanswered, or failed); it never names a provider, and a provider
  added later maps onto those outcomes inside the interface, so consumer
  code is written once.  Because every diff now walks the chain even
  with no store or process configured, the default path was measured
  against the pre-series base and runs within noise (a 5000-commit
  log --stat and a long-history blame, ratio 1.00 either way).

- The diff-hunks store shows the non-authoritative side: an in-process
  cache at $GIT_DIR/objects/info/diff-hunks that may only reproduce the
  builtin diff, so serving from it never changes a command's output.  It
  is read by default and written only when a repository owner opts in,
  warming it as a side effect of diff work the command already does:

      GIT_DIFF_HUNKS_WRITE=1 git log --all --stat >/dev/null

  A warmed store then serves the stat formats and blame from stored
  coordinates instead of a fresh diff: on git.git a 5000-commit log
  --stat runs about 1.9x faster, and blame reads the same entries
  opportunistically (full numbers in [1]).  Its format and keying, what
  it may not serve, and how it handles corruption and staleness are in
  git-diff-hunks(1), gitformat-diff-hunks(5), and [2].  The interface
  point is small: a cache drops in as the provider that stands aside
  wherever an authoritative one answers.

- diff.<driver>.process shows the authoritative side: an external
  process, configured per driver, whose answers may deliberately differ
  from the builtin diff and outrank the store.  Git asks it for a pair by
  object names alone, so it answers before any blob is read, which suits
  a cache or a process that fetches the blobs itself.  Consulting is
  opt-in per command, following the allow_textconv precedent, and a pair
  the process cannot answer falls back to the builtin diff.  The
  protocol, the per-command gate, how failures are handled, and the
  versioning that lets it grow are in gitattributes(5) and footnotes [3]
  and [4].  The interface point, again, is small: an external,
  authoritative provider joins the same chain ahead of the cache, and
  neither consumer learns it is there.  A later content-carrying request
  would extend it to the pairs and consumers this identity-only form
  leaves on the builtin diff.

The series stops at the coordinates.  A consumer that needs the changed
text, such as patch output, would have only its hunk selection replaced,
with xdiff still emitting content from the blobs; that machinery is the
content enrichment sketched in the Roadmap.  Establishing the framework
on coordinates first keeps this series one design: the question, the
interface, and two providers answering by identity.

Shape of the series:

  01     documentation: how external diff drivers relate to the
         features layered on the diff
  02     the provider interface: the request and outcome types, the
         emit entry point, the shared validity check, and the
         repository-owned chain with its terminal builtin provider
  03     the store: on-disk format, library, and the diff-hunks command
  04     recording: the stat walk computes, sums, and records
         trim-stable pairs (writes gated off by default)
  05     reading: the consult entry point and the store's registration
         as a provider; the request gains the object ids and diff
         options
  06     blame reading through the interface's emit path
  07-09  process preparation: sub-process lifecycle split, a gentle
         status read for an optional process, and the
         diff.<driver>.process config
  10     the process provider, oid-only, at the head of the chain, with
         the per-command gate; the request gains the path

Roadmap:

This RFC asks whether the direction is right, not for these ten patches
to merge as one topic.  If it holds, the work returns in reviewable
pieces:

- the interface and the store (patches 01 through 06): a cache with
  measured numbers and no external-process machinery

- the process provider (patches 07 through 10) on the same interface

- the content enrichment (the content-carrying request, patch output and
  log -L consulting, and the xdiff machinery that feeds a provider's
  hunks into emission) once the identity-keyed framework settles.

Several design questions are left for those series.

mm/diff-process-hunks in seen would be dropped in favor of this thread
and its split.

The series applies on the line-log topic (mm/line-log-limited-ops)
rebased onto current master.  The topic rewrites the same
builtin_diffstat() region this series touches, and current master
includes 061a68e443 (sub-process: use gentle handshake to avoid die()
on startup failure), which this topic leans on: a process that dies
during the handshake degrades to the builtin diff like every other
failure.  A trial merge against seen shows no interaction with other
topics beyond the mm/diff-process-hunks replacement above.

The base (line-log topic on current master) and the full series are
available at:

  git fetch https://github.com/mmontalbo/git mm/line-log-stat-formats-followup
  git fetch https://github.com/mmontalbo/git mm/hunk-providers-oid-first

Changes since v6:

This is a restructuring, not an incremental reroll, so a range-diff
against v6 is unreadable; the map of what changed:

- The series now leads with the hunk provider interface and brings the
  diff-hunks store in as its in-process implementation (patches 02
  through 06, new to this thread).  It keeps only the identity-keyed
  half of the external diff process protocol from mm/diff-process-hunks.
- v6's gitattributes documentation, sub-process split, and userdiff
  config return close to their v6 form as patches 01, 07, and 09.  Patch
  08 is new: a gentle status read so a protocol error in an optional
  process degrades to the builtin diff instead of dying.
- v6's protocol patch returns as patch 10, reduced to the oid-only
  request, consulting through the interface, and carrying a per-command
  gate (v6's bypass patch folds into it).
- v6's blame and stat consults return as identity-keyed consults
  (patches 05, 06, and 10); their content legs, along with v6's xdiff
  external-hunks machinery, content-carrying request, and line-log
  consult, are withheld for the content enrichment.

Footnotes:

[1] Store numbers, measured with hyperfine against the same build with
    core.diffHunks=false.  The warm is a full cold build of the store;
    the blame speedup is file-dependent (see the coverage limitation):

    git.git (82,912 commits, --all)
      warm log --all --stat      20.9 s        store 28 MB, verify 39 ms
      log --stat -5000           1.91x    (1.38 s -> 0.72 s)
      blame diff.c               1.26x     (509 ms -> 403 ms)
      blame hit rate             54% (896 of 1653 pairs)

    linux (1,445,548 commits, --all)
      warm log --all --stat      714 s       store 298 MB, verify 415 ms
      log --stat -5000           1.43x    (2.29 s -> 1.60 s)
      blame kernel/sched/core.c  1.43x     (1.59 s -> 1.11 s)
      blame hit rate             74% (2414 of 3263 pairs)

[2] The store is its own file because nothing existing is addressed by a
    blob pair: notes attach to single objects, commit-graph chunks to
    commits.  One entry per pair, keyed by (old blob, new blob,
    xdl_opts) and recorded only when the pair's trimmed and untrimmed
    diffs agree, serves blame at zero context and the stat formats at
    any -U (divergent pairs are 0.4-0.5% of a warm and always compute).
    The writer fsyncs and commits atomically, and a reader bounds-checks
    every record and treats an unparsable file as absent; the trailing
    checksum is checked by git diff-hunks verify, not on every read, the
    same read-time trust the commit-graph and multi-pack-index take.
    There is deliberately no fsck integration, expiry, or background
    maintenance: the store is derivable at any time, so the recovery
    path is git diff-hunks clear and a re-warm.  New commits make it
    incomplete, not wrong; a later warm seeds from the file and pays
    only for what is new.

[3] Consulting the process is allowed per command, like textconv: git
    diff, git log and git show, and git blame consult it; the plumbing
    diff commands do not unless --ext-diff or --diff-process is given,
    and the interactive-patch machinery, format-patch, and range-diff
    stay builtin.  Options the process is never told about select no
    process, and an object id is sent only when it names the exact bytes
    diffed (a pair under an active object replacement is not sent).  The
    command comes from local configuration, as with filter.<name>
    .process: attributes select only a driver name, so cloning cannot
    cause a process to run.  gitattributes(5) has the full gate.

[4] The protocol is versioned and capability-negotiated, and extends
    without breaking deployed processes: a process ignores request keys
    it does not know, Git ignores trailing tokens on a hunk line so
    fields can be appended, and new request forms arrive as capabilities
    a process may decline.  Announcing a capability Git did not request
    aborts the command, the filter protocol's handshake rule.  The
    content-carrying request is the natural first extension; markers for
    formatting-only changes and function or token boundaries are
    candidates beyond it.

Michael Montalbo (10):
  gitattributes: document how external diff drivers relate to diff
    features
  diff: introduce a hunk provider interface
  diff-hunks: add the store format, library, and command
  diff: record precomputed hunks during stat output
  diff: read precomputed hunks for stat output
  blame: read precomputed hunks
  sub-process: separate process lifecycle from hashmap management
  sub-process: add a gentle status read
  userdiff: add diff.<driver>.process config
  diff: consult oid-only hunk providers via diff.<driver>.process

 .gitignore                               |    1 +
 Documentation/Makefile                   |    1 +
 Documentation/config.adoc                |    2 +
 Documentation/config/core.adoc           |   10 +-
 Documentation/config/diff-hunks.adoc     |    8 +
 Documentation/config/diff.adoc           |    6 +
 Documentation/diff-algorithm-option.adoc |    3 +
 Documentation/diff-options.adoc          |   15 +-
 Documentation/git-diff-hunks.adoc        |  146 +++
 Documentation/gitattributes.adoc         |  171 ++++
 Documentation/gitformat-diff-hunks.adoc  |  129 +++
 Documentation/meson.build                |    2 +
 Makefile                                 |    5 +
 blame.c                                  |   81 +-
 builtin.h                                |    1 +
 builtin/blame.c                          |    9 +-
 builtin/diff-hunks.c                     |   53 ++
 builtin/diff-tree.c                      |    3 +
 builtin/diff.c                           |   11 +
 builtin/log.c                            |   19 +
 chunk-format.c                           |   62 +-
 chunk-format.h                           |   14 +
 command-list.txt                         |    2 +
 diff-hunks.c                             | 1034 ++++++++++++++++++++++
 diff-hunks.h                             |  141 +++
 diff-process.c                           |  669 ++++++++++++++
 diff-provider-internal.h                 |  130 +++
 diff-provider.c                          |  190 ++++
 diff-provider.h                          |  159 ++++
 diff.c                                   |  294 +++++-
 diff.h                                   |   47 +
 environment.c                            |    1 +
 git.c                                    |    1 +
 meson.build                              |    4 +
 odb.c                                    |    2 +
 odb.h                                    |    4 +
 range-diff.c                             |    6 +
 repo-settings.c                          |    1 +
 repo-settings.h                          |    1 +
 repository.c                             |    3 +
 repository.h                             |    8 +
 sub-process.c                            |   52 +-
 sub-process.h                            |   19 +-
 t/helper/meson.build                     |    1 +
 t/helper/test-diff-process-backend.c     |  349 ++++++++
 t/helper/test-tool.c                     |    1 +
 t/helper/test-tool.h                     |    1 +
 t/meson.build                            |    3 +
 t/perf/p4218-diff-hunks.sh               |   48 +
 t/t4080-diff-process.sh                  |  593 +++++++++++++
 t/t4220-diff-hunks.sh                    |  819 +++++++++++++++++
 t/t4220/README                           |   55 ++
 t/t4220/trim-divergent-new               |  319 +++++++
 t/t4220/trim-divergent-old               |  316 +++++++
 userdiff.c                               |    7 +
 userdiff.h                               |    2 +
 write-or-die.h                           |    7 +-
 xdiff-interface.h                        |   12 +
 58 files changed, 5989 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/config/diff-hunks.adoc
 create mode 100644 Documentation/git-diff-hunks.adoc
 create mode 100644 Documentation/gitformat-diff-hunks.adoc
 create mode 100644 builtin/diff-hunks.c
 create mode 100644 diff-hunks.c
 create mode 100644 diff-hunks.h
 create mode 100644 diff-process.c
 create mode 100644 diff-provider-internal.h
 create mode 100644 diff-provider.c
 create mode 100644 diff-provider.h
 create mode 100644 t/helper/test-diff-process-backend.c
 create mode 100755 t/perf/p4218-diff-hunks.sh
 create mode 100755 t/t4080-diff-process.sh
 create mode 100755 t/t4220-diff-hunks.sh
 create mode 100644 t/t4220/README
 create mode 100644 t/t4220/trim-divergent-new
 create mode 100644 t/t4220/trim-divergent-old


base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
prerequisite-patch-id: 6270dea79c9f06530737cefa3e1a0a39a1be7877
prerequisite-patch-id: 46fcc16a7a2ed760a1134d2a92c87699f3ec7bdb
prerequisite-patch-id: c1e3da243003d060e429bc2196ae02b3453f01f9
prerequisite-patch-id: 4ad4e273494d4e8503706c21bfdc90a5d7ce116a
prerequisite-patch-id: f7fa1367756daafa83f4f030a5c7b6dc3dbb70d7
prerequisite-patch-id: 829e76c9fec655a07f9383086a35bff3290b1c74
prerequisite-patch-id: 5c5a0d61ae9b6d628d05f1eb5df046758f3111a8
-- 
2.54.0
