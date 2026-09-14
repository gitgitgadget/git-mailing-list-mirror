Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E41420477
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379287; cv=none; b=Jbn8WDbVi90yYouhVy2eObQysw6eghO2SqxpjpLojVM7nYjhEU02yjovS+wO5IuZpV1Ro5s4da471VyCrcgD6sGGgwFN4Lchc3HgPFq/CCAz/utDwcmU/A4LRuXjIZeWtFbuVuYWAtMIzJSqnECt6jN0Pd976H/o8reRJiUfu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379287; c=relaxed/simple;
	bh=FL2taUCR0JXcE5FJvrU/m1VPKlQGdG00wN5LGW2abUA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fsxZo4VATENn/d1HpChnbWkqOFSTbjpd/P2N31TfKwSZqGwGiH2m6kh/IJM3YAkbocL1McUmfgc2a3SBxsiwJXvvwrExG9oPJXhU7tThla3Jw4HM74Kq315JiuTbIJ4KK6Zn7ROtv8lnc/S7TQa7NG/IU+x6I5TZhzjrXvhYCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzqmUhGA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzqmUhGA"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so2377485a12.2
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789379282; x=1789984082; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jFzH3WOreg2BX4KwUpUer1TzLELWkhWoD76oxGFxHBw=;
        b=FzqmUhGAF3Ty1bbFOvCU8ZmQ19DeDMt990qoK6hldTJSkY1wX45N9KTH2Yaa6RMY3t
         yhXw+USlOZaDazZpD9Ol3RHuA2YsAmQep0oEvHTS2ru1ZdwuT2yLVJejLyAPglGvYh+a
         RXbErDZJa6up4FqmLm4X6IQpriS0eQLusiEUWptkstvHCixNFRrgAXGf16JLng1xX1wz
         0Tg9aH4hQlfeiUGm6h/LkrWA4C44okKF6w9RON1pBTIUCAppsaukw4OIa0XDqNgf7vBU
         IO2wcuqNGY6Wlx4kXKUOUTVmMtVnz0hkVsU4JMVOiWlHBpjfqmulcMg50YPC9Z/af4cM
         GiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789379282; x=1789984082;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jFzH3WOreg2BX4KwUpUer1TzLELWkhWoD76oxGFxHBw=;
        b=R/jwisSLLROBvuoFonPZfYEwJWLrHA6M0FDB1YJ8n++glKV8hg9rpcOJWaHvZ/MOXp
         pzK64gnrBHPK88tw+QQEuNtYK5GZXo7vEIYRt6pDKUtlExET3WYhWem1OsrCpb4X+ulm
         CBHoUEPWscL+KXjXb2BNkjKe52UoWM/BesIuqG4qjVY56EO7TKAQ+WVefyJkuXCXISfT
         qYLoZK2eZg1Zk/75t08jDHXbq1lo7yUQbr7+VqRhFGLzwyCcseGPpVvlpiaboA6SJxcI
         PYS9Kr/jPQqGuF/9z47dnmtEZGDp5+SWah9TbGUWAfwlhsNHLyQzzgVBQgCnPYXaZUyi
         LTFQ==
X-Gm-Message-State: AFuF++kx2bgmu7oiB6c+HkkMP3didierOVEuOKbbN56z0yhaY+ZB3CvR
	SYnnrYc9ywQac8uBBgX+8Ri7AXZt28//KL9HWlcV2F5NnLPDRxiw/agTzwyKSQ==
X-Gm-Gg: AYBFou3P7Ve6XrFYWaCKmocoLeVaF9YlAS1m6mAhfIqKXGsQA4iUGBYhkbIYVwBd223
	3llUJ+xJ8FNYHUSKIqRqO5e4kN7ppv9TM38IZq/3LH34MZoTpWum3khYMZ5W+a9OpC/Bhzu7Uj9
	DitXrVFng4qJD6v1pc6tI6ivELV07tlUF/0A03NWNgveK545xRd5dRVwzqUq0wHQGF4ap5EVJ7u
	u4S5AFADEO7K4IROqoSba4PWZ58poTB9xCFFgAyaJnUGKwdVj9kL+5sxFiR2epUZ4fPgjR6ZxXr
	qYQbZO1GJdPYjAdRV3vFGCvbDu5VAoAZzsL+GweGhS8JB7UjOksXwK6nEzPN7g4v4rizBAJy/i8
	lK/R4vjVuCLiYr0FOZ1ARV2BRPaGoNs8qfGrplA4ThyyddWPoHvFRGJ9BNXf/YykUuuCHEjDlJj
	nJs8QsT1tQXzGRUcc8JWpyvmVdSP2jJwpzu+cES9Mv49VDUINdzvvzM5AATRlF+XtH01iiz0fal
	b7zLP9sQ1P72lY=
X-Received: by 2002:a05:6a20:e290:b0:3da:6bdd:2308 with SMTP id adf61e73a8af0-3db4053d966mr3670696637.18.1789379281735;
        Mon, 14 Sep 2026 02:48:01 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm25158149c88.3.2026.09.14.02.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:48:01 -0700 (PDT)
Message-Id: <ebe6c90cc58b9e1f64c9bec4a18e8cb3ce9be1b2.1789379276.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 09:47:56 +0000
Subject: [PATCH 2/2] connected: add incremental connectivity check via
 rev-list
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

The full connectivity check uses rev-list to find commits
reachable from the incoming tips but not from the
already-connected side, then walks their object closure.  Commit
traversal stops at the connectivity boundary, but trees and blobs
reachable from that boundary still need to be walked so they can
be marked uninteresting, allocating a struct object for each one.
On repositories where the boundary commits have large trees, the
connectivity check for small incoming changes visits and tracks
more objects than needed.

Add an alternative connectivity check that verifies incoming
commits incrementally against their parents.

The verifier processes incoming commits with ancestors first and
compares each new tree against its trusted parent trees.  Entries
already seen on the trusted side are skipped by OID, so unchanged
subtrees need not remain at the same path to be recognized.
Changed subtrees are recursively compared against same-path parent
subtrees, and new subtrees without a comparison base are verified
from scratch.

See Documentation/technical/connectivity-check.adoc for the trust
invariants and detailed algorithm.

The incremental check runs as an internal
--verify-trees-incremental mode in rev-list.  After the normal
revision walk identifies the incoming commits, the verifier
consumes them before the usual object traversal; any pending
non-commit tips are still handled by the existing traversal.

Partial-clone semantics are preserved: objects promised by a
promisor remote are accepted as connected, and on-demand fetching
is prevented by excluding promisor objects from traversal.  The
new mode is selected by transfer.connectivityCheck=incremental,
with full remaining the default.  Deepening fetches fall back to
the full check because they do not have the normal
existing-reference boundary, and traversal instead follows the
effective shallow boundary.

p5412 results (median of 3), scaling one dimension at a time.
Each fixture is a repository with a flat tree of many
directories containing 100 files each.  The incoming set is a
chain of commits on top of the existing history, with each
commit changing files in different directories round-robin.
The three axes vary the total repository tree size, the number
of incoming commits, and the number of files changed per
incoming commit.

Scaling tree size (10 incoming commits, 10 files/commit):

    files    full  incr.  full/incr
      5K    0.01s  0.01s    1.0x
     50K    0.04s  0.01s    4.0x
    200K    0.15s  0.01s   15.0x
    800K    0.61s  0.03s   20.3x

The full mode must walk the trees of boundary commits, which
grows with overall tree size.  Incremental still scans the
root trees, but avoids descending into unchanged subtrees,
so it grows much more slowly with repository size.

Scaling incoming commit count (200K files, 10 files/commit):

    commits    full  incr.  full/incr
          1    0.14s  0.01s   14.0x
         10    0.15s  0.01s   15.0x
        100    0.19s  0.05s    3.8x
        500    0.32s  0.27s    1.2x
       3000    1.23s  1.52s    0.8x
       5000    1.88s  2.43s    0.8x
      10000    3.72s  5.36s    0.7x

With many commits the per-commit overhead of scanning both
the new and parent root trees accumulates and incremental
becomes slower.  Breakeven is between 500 and 3000 commits
and the ratio stabilizes near 0.7x for this fixture.

Scaling files per incoming commit (200K files, 10 commits):

    files/commit    full  incr.  full/incr
               1    0.14s  0.01s   14.0x
              10    0.15s  0.01s   15.0x
             100    0.16s  0.04s    4.0x
             500    0.23s  0.14s    1.6x
            1000    0.34s  0.28s    1.2x
            2000    0.70s  0.63s    1.1x

Breakeven is around 1000 files/commit.  At 2000 files/commit
(every directory touched), incremental remains slightly faster;
bypassing the object cache for tree reads likely helps here.

For small repositories both modes are fast enough that the
difference is difficult to measure reliably.

Selected peak RSS measurements from the same fixtures:

    case                        full    incr.  ratio
    200K files, 10 commits      31 MB    12 MB   0.4x
    800K files, 10 commits     110 MB    26 MB   0.2x
    200K files, 5000 commits   155 MB   151 MB   1.0x

Incremental uses substantially less memory when it can prune
most of the boundary tree walk.  In the long-history case the
two modes visit similar object sets and memory converges.

The regression cases in the CPU benchmarks are in wall-clock
time rather than memory, primarily from scanning some trees
more than once.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Documentation/config/transfer.adoc            |  20 +
 Documentation/rev-list-options.adoc           |   6 +
 .../technical/connectivity-check.adoc         | 134 ++++
 Makefile                                      |   1 +
 builtin/rev-list.c                            |  18 +
 connected.c                                   |  24 +
 meson.build                                   |   1 +
 t/meson.build                                 |   1 +
 ...enerate-repo-p5412-connectivity-check.perl |  44 ++
 t/perf/p5412-connectivity-check.sh            |  92 +++
 t/t5412-connectivity-check.sh                 | 655 ++++++++++++++++++
 tree-verify.c                                 | 306 ++++++++
 tree-verify.h                                 |  15 +
 13 files changed, 1317 insertions(+)
 create mode 100644 t/perf/generate-repo-p5412-connectivity-check.perl
 create mode 100755 t/perf/p5412-connectivity-check.sh
 create mode 100755 t/t5412-connectivity-check.sh
 create mode 100644 tree-verify.c
 create mode 100644 tree-verify.h

diff --git a/Documentation/config/transfer.adoc b/Documentation/config/transfer.adoc
index f1ce50f4a6..b9939d3bde 100644
--- a/Documentation/config/transfer.adoc
+++ b/Documentation/config/transfer.adoc
@@ -1,3 +1,23 @@
+transfer.connectivityCheck::
+	Choose which algorithm to use for the connectivity check
+	performed during object transfer operations such as
+	linkgit:git-fetch[1] and linkgit:git-receive-pack[1].
+	The connectivity check verifies that all objects reachable
+	from the incoming tips are available locally or, in a partial
+	clone, promised by a promisor remote.
+	The variants are as follows:
++
+--
+`full` (default);;
+	Walk the full object closure of the boundary commits.
+`incremental`;;
+	Verify incoming commits by diffing their trees against parent
+	trees, recursively descending only into entries that differ.
+	The largest benefits occur when incoming commits change a
+	small fraction of a large tree closure.
+	Falls back to `full` for deepening fetches.
+--
+
 transfer.credentialsInUrl::
 	A configured URL can contain plaintext credentials in the form
 	`<protocol>://<user>:<password>@<domain>/<path>`. You may want
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index fd831f0ec6..7964b691c4 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1089,6 +1089,12 @@ we cannot get their Object ID though, an error will be raised.
 	stronger than `--missing=allow-promisor` because it limits the
 	traversal, rather than just silencing errors about missing
 	objects.
+
+`--verify-trees-incremental`::
+	(For internal use only.)  Verify tree connectivity
+	incrementally by comparing each commit's tree against its
+	parent trees.  Used by `check_connected()` when
+	`transfer.connectivityCheck` is set to `incremental`.
 endif::git-rev-list[]
 
 `--no-walk[=(sorted|unsorted)]`::
diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
index d20bff6af6..0a8f370546 100644
--- a/Documentation/technical/connectivity-check.adoc
+++ b/Documentation/technical/connectivity-check.adoc
@@ -107,3 +107,137 @@ When a new reference points to a non-commit object, such as a
 tag, tree, or blob, that object is not part of the commit walk.
 These non-commit tips are handled by the subsequent object
 traversal.
+
+Incremental connectivity check
+------------------------------
+
+The incremental mode, selected by
+`transfer.connectivityCheck=incremental`, avoids traversing the
+full tree walk of the boundary commits.  Instead, it verifies
+each incoming commit's tree against the already-trusted trees of
+its parents.
+
+Trust model
+~~~~~~~~~~~
+
+A tree is trusted when its transitive object closure is known to
+be connected.  Trees reachable from commits on the
+already-connected side of the boundary are therefore trusted.
+
+Incoming commits are processed with ancestors before descendants.
+Once an incoming commit's tree has been verified, it is trusted
+and can be used as a comparison base for later descendants.
+
+This gives an inductive correctness argument: every parent of the
+commit currently being verified is either already connected or is
+an earlier incoming commit whose tree has already been verified.
+
+Tree states
+~~~~~~~~~~~
+
+The verifier tracks tree OIDs in three states:
+
+untrusted::
+	The tree has not yet been established as connected.  This
+	is the implicit state of an OID not present in the state
+	map.
+
+trusted::
+	The tree is known to have a connected transitive closure,
+	but its direct entries have not yet been published into the
+	verifier's trusted object sets.
+
+expanded::
+	The tree is trusted and its direct non-gitlink entries
+	have also been published into the trusted object sets.
+
+State transitions are monotonic: a tree may move from untrusted
+to trusted to expanded, but never backwards.  An untrusted tree
+that is successfully verified goes directly to expanded.
+
+Blobs require only trusted/untrusted state: a blob becomes
+trusted when it is found in a trusted tree or when its existence
+and type have been verified directly.
+
+The trusted/expanded distinction is an optimization.  An expanded
+parent does not need to be reread merely to publish entries that
+are already trusted, though it may still be read when same-path
+subtree bases are needed for recursive comparison.
+
+Algorithm
+~~~~~~~~~
+
+At a high level:
+
+    verify(commits):
+        sort topologically (ancestors first)
+        for each commit:
+            mark parent root trees as trusted
+            verify_tree(commit.tree, parent root trees)
+
+    verify_tree(tree, base_trees):
+        if tree already trusted: return
+        read tree, collect entries not already trusted
+        for each available base tree:
+            publish its entries as trusted
+            record same-path subtrees as bases
+        for each collected entry:
+            if now trusted: skip
+            if blob: verify blob connectivity and type
+            if tree: verify_tree(entry, its recorded bases)
+        mark tree as expanded
+
+The important ordering within `verify_tree` is that entries from
+the new tree are collected before the base trees are scanned, but
+are processed only afterwards.  Trust learned from any base can
+therefore eliminate work before recursive verification begins.
+
+Same-path parent subtrees are passed down as comparison bases
+during recursive descent.  If no comparison base is available,
+the new subtree is verified from scratch.
+
+Worked example
+~~~~~~~~~~~~~~
+
+Consider a commit that changes one file under `lib/` and moves an
+unchanged subtree from `src/` to `dev/`:
+
+    Parent tree              New tree
+    +-- src/   (aaa)         +-- dev/   (aaa)
+    +-- lib/   (bbb)         +-- lib/   (ccc)
+         +-- foo.c (ddd)          +-- foo.c (ddd)
+         +-- bar.c (eee)          +-- bar.c (fff)
+
+Scanning the parent makes `aaa` trusted even though it moved from
+`src/` to `dev/`, so that subtree is skipped.  The changed `ccc`
+subtree is compared against its same-path parent `bbb`; scanning
+`bbb` makes `ddd` and `eee` trusted, leaving only the new `fff`
+blob to be checked.
+
+This illustrates two properties:
+
+* Trust is OID-based rather than path-based.  An unchanged subtree
+  is recognized after a move.
+
+* Same-path parent subtrees provide recursive comparison bases.
+  These bases improve pruning efficiency but are not required for
+  correctness; a new subtree can always be verified from scratch.
+
+Multiple parents
+~~~~~~~~~~~~~~~~
+
+For a merge commit, root trees from all parents are comparison
+bases.  When several parents contain a same-path subtree, each
+matching subtree is collected as a recursive comparison base.
+
+Entries published from any trusted parent become globally trusted,
+so a matching tree or blob entry present in any parent can be
+skipped while verifying the merge tree.
+
+Missing comparison bases
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+A promised base tree may not be locally available for comparison.
+In that case the verifier skips that base and verifies the new
+subtree without it.  The missing comparison can reduce pruning but
+does not affect correctness.
diff --git a/Makefile b/Makefile
index d4b775953d..aa5b4e2b84 100644
--- a/Makefile
+++ b/Makefile
@@ -1357,6 +1357,7 @@ LIB_OBJS += trailer.o
 LIB_OBJS += transport-helper.o
 LIB_OBJS += transport.o
 LIB_OBJS += tree-diff.o
+LIB_OBJS += tree-verify.o
 LIB_OBJS += tree-walk.o
 LIB_OBJS += tree.o
 LIB_OBJS += unpack-trees.o
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 6b596231ab..7741fdec9f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -28,6 +28,7 @@
 #include "commit-reach.h"
 #include "quote.h"
 #include "strbuf.h"
+#include "tree-verify.h"
 
 struct rev_list_info {
 	struct rev_info *revs;
@@ -706,6 +707,7 @@ int cmd_rev_list(int argc,
 	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
 	int filter_provided_objects = 0;
+	int verify_trees_incremental = 0;
 	const char *show_progress = NULL;
 	int ret = 0;
 
@@ -748,6 +750,8 @@ int cmd_rev_list(int argc,
 		if (!strcmp(arg, "--exclude-promisor-objects")) {
 			repo->fetch_if_missing = 0;
 			revs.exclude_promisor_objects = 1;
+		} else if (!strcmp(arg, "--verify-trees-incremental")) {
+			verify_trees_incremental = 1;
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(repo, arg);
 		} else if (!strcmp(arg, "-z")) {
@@ -822,6 +826,8 @@ int cmd_rev_list(int argc,
 
 		if (!strcmp(arg, "--exclude-promisor-objects"))
 			continue; /* already handled above */
+		if (!strcmp(arg, "--verify-trees-incremental"))
+			continue; /* already handled above */
 		if (skip_prefix(arg, "--missing=", &arg))
 			continue; /* already handled above */
 
@@ -935,6 +941,18 @@ int cmd_rev_list(int argc,
 
 	prepare_maximal_independent(&revs);
 
+	if (verify_trees_incremental) {
+		struct commit *commit;
+		struct commit_list *new_commits = NULL;
+
+		while ((commit = get_revision(&revs)) != NULL)
+			commit_list_insert(commit, &new_commits);
+
+		verify_commits_incremental(repo, &new_commits,
+					   revs.exclude_promisor_objects);
+		commit_list_free(new_commits);
+	}
+
 	if (revs.tree_objects)
 		mark_edges_uninteresting(&revs, show_edge, 0);
 
diff --git a/connected.c b/connected.c
index 929b9bd28d..e3dcd8e2b0 100644
--- a/connected.c
+++ b/connected.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "config.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb.h"
@@ -67,6 +68,26 @@ static int check_connected_promisor(oid_iterate_fn fn,
 	return 1;
 }
 
+static int incremental_check_applicable(struct check_connected_options *opt)
+{
+	const char *algorithm = NULL;
+
+	if (repo_config_get_string_tmp(the_repository,
+				       "transfer.connectivitycheck",
+				       &algorithm))
+		return 0;
+	if (!strcasecmp(algorithm, "full"))
+		return 0;
+	if (strcasecmp(algorithm, "incremental"))
+		die(_("unknown transfer.connectivityCheck algorithm '%s'"),
+		    algorithm);
+
+	if (opt->is_deepening_fetch)
+		return 0;
+
+	return 1;
+}
+
 /*
  * If we feed all the commits we want to verify to this command
  *
@@ -133,6 +154,9 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	if (opt->progress)
 		strvec_pushf(&rev_list.args, "--progress=%s",
 			     _("Checking connectivity"));
+	if (incremental_check_applicable(opt))
+		strvec_push(&rev_list.args,
+			    "--verify-trees-incremental");
 
 	rev_list.git_cmd = 1;
 	if (opt->env)
diff --git a/meson.build b/meson.build
index 0a95d90d21..d94dedc26c 100644
--- a/meson.build
+++ b/meson.build
@@ -562,6 +562,7 @@ libgit_sources = [
   'transport-helper.c',
   'transport.c',
   'tree-diff.c',
+  'tree-verify.c',
   'tree-walk.c',
   'tree.c',
   'unpack-trees.c',
diff --git a/t/meson.build b/t/meson.build
index 7f53cca7d1..19a8246c44 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -652,6 +652,7 @@ integration_tests = [
   't5409-colorize-remote-messages.sh',
   't5410-receive-pack.sh',
   't5411-proc-receive-hook.sh',
+  't5412-connectivity-check.sh',
   't5500-fetch-pack.sh',
   't5501-fetch-push-alternates.sh',
   't5502-quickfetch.sh',
diff --git a/t/perf/generate-repo-p5412-connectivity-check.perl b/t/perf/generate-repo-p5412-connectivity-check.perl
new file mode 100644
index 0000000000..9546996280
--- /dev/null
+++ b/t/perf/generate-repo-p5412-connectivity-check.perl
@@ -0,0 +1,44 @@
+#!/usr/bin/perl
+#
+# Generate a fast-import stream for p5412 connectivity check benchmarks.
+#
+# Usage: generate-repo-p5412-connectivity-check.perl
+#            <dirs> <files_per_dir> <commits> [<hot_dirs>] [<files_per_commit>]
+#
+# Creates one initial commit with dirs*files_per_dir files, then
+# <commits> additional commits each modifying <files_per_commit>
+# files in directories chosen round-robin from 1..<hot_dirs>.
+
+use strict;
+use warnings;
+
+my ($nd, $nf, $nc, $hot, $fpc) = @ARGV;
+$hot = $nd if !$hot || $hot > $nd;
+$fpc = 1   if !$fpc;
+
+sub data {
+	printf "data %d\n%s\n", length($_[0]), $_[0];
+}
+
+# Initial tree: one commit with nd*nf files.
+printf "commit refs/heads/main\n";
+printf "committer perf <perf\@test.com> now\n";
+data("initial");
+for my $d (1..$nd) {
+	for my $f (1..$nf) {
+		printf "M 100644 inline d-%04d/f-%03d\n", $d, $f;
+		data(sprintf "%03d%03d", $d, $f);
+	}
+}
+
+# Subsequent commits (auto-chained by fast-import).
+for my $i (1..$nc) {
+	printf "commit refs/heads/main\n";
+	printf "committer perf <perf\@test.com> now\n";
+	data(sprintf "change-%03d", $i);
+	for my $j (0..$fpc-1) {
+		my $d = (($i + $j) % $hot) + 1;
+		printf "M 100644 inline d-%04d/f-001\n", $d;
+		data(sprintf "c%d-%d", $i, $j);
+	}
+}
diff --git a/t/perf/p5412-connectivity-check.sh b/t/perf/p5412-connectivity-check.sh
new file mode 100755
index 0000000000..827643a847
--- /dev/null
+++ b/t/perf/p5412-connectivity-check.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description='performance of connectivity check modes
+
+Compare the default and incremental rev-list connectivity modes
+directly, avoiding pack transfer noise.
+
+Each repository has a flat tree of many directories with 100 files
+in each.  Three axes are scaled independently: tree size, commit
+count, and files changed per commit.'
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+generate="$TEST_DIRECTORY/perf/generate-repo-p5412-connectivity-check.perl"
+
+# $1=dirs  $2=files_per_dir  $3=commits  $4=hot_dirs (optional, default=all)
+# $5=files_per_commit (optional, default=1)
+test_perf_conn () {
+	local nd="$1" nf="$2" nc="$3" hot="${4:-$1}" fpc="${5:-1}"
+	local total=$(($nd * $nf))
+	local name="repo-${nd}d-${nf}f-${nc}c-${hot}h-${fpc}fpc"
+	local label="${total} files, ${nc} commits"
+	if test "$hot" -lt "$nd"
+	then
+		label="$label (${hot} hot dirs)"
+	fi
+	if test "$fpc" -gt 1
+	then
+		label="$label (${fpc} files/commit)"
+	fi
+
+	test_expect_success "setup $label" '
+		if test -d '"$name"'
+		then
+			true
+		else
+			git init '"$name"' &&
+			"$PERL_PATH" '"$generate"' '"$nd"' '"$nf"' '"$nc"' '"$hot"' '"$fpc"' |
+			git -C '"$name"' fast-import --date-format=now --quiet &&
+			(
+				cd '"$name"' &&
+				git rev-parse main~'"$nc"' >../'"${name}"'_old &&
+				git rev-parse main >../'"${name}"'_new &&
+				git update-ref refs/heads/main \
+					$(cat ../'"${name}"'_old) &&
+				git repack -ad &&
+				git config gc.auto 0
+			)
+		fi
+	'
+
+	test_perf "$label (full)" '
+		cat '"${name}"'_new |
+		git -C '"$name"' rev-list \
+			--objects --stdin --not --all --quiet \
+			--exclude-promisor-objects
+	'
+
+	test_perf "$label (incremental)" '
+		cat '"${name}"'_new |
+		git -C '"$name"' rev-list --verify-trees-incremental \
+			--objects --stdin --not --all --quiet \
+			--exclude-promisor-objects
+	'
+}
+
+# Scaling tree size (10 commits, 10 files/commit).
+test_perf_conn   50 100 10   50 10
+test_perf_conn  500 100 10  500 10
+test_perf_conn 2000 100 10 2000 10
+test_perf_conn 8000 100 10 8000 10
+
+# Scaling commit count (200K files, 10 files/commit).
+test_perf_conn 2000 100    1 2000 10
+test_perf_conn 2000 100   10 2000 10
+test_perf_conn 2000 100  100 2000 10
+test_perf_conn 2000 100   500 2000 10
+test_perf_conn 2000 100  3000 2000 10
+test_perf_conn 2000 100  5000 2000 10
+test_perf_conn 2000 100 10000 2000 10
+
+# Scaling files per commit (200K files, 10 commits).
+test_perf_conn 2000 100 10 2000   1
+test_perf_conn 2000 100 10 2000  10
+test_perf_conn 2000 100 10 2000  100
+test_perf_conn 2000 100 10 2000  500
+test_perf_conn 2000 100 10 2000 1000
+test_perf_conn 2000 100 10 2000 2000
+
+test_done
diff --git a/t/t5412-connectivity-check.sh b/t/t5412-connectivity-check.sh
new file mode 100755
index 0000000000..e276085e83
--- /dev/null
+++ b/t/t5412-connectivity-check.sh
@@ -0,0 +1,655 @@
+#!/bin/sh
+
+test_description='connectivity check (transfer.connectivityCheck)'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_oid_cache <<-\EOF
+missing sha1:0000000000000000000000000000000000000001
+missing sha256:0000000000000000000000000000000000000000000000000000000000000001
+EOF
+
+set_connectivity_check () {
+	git -C "$1" config transfer.connectivityCheck "$2"
+}
+
+# Run a connectivity check via rev-list directly.  Uses $mode
+# (set by the enclosing for-loop) to choose full or incremental.
+check_connected () {
+	flags= &&
+	if test "$mode" = incremental
+	then
+		flags=--verify-trees-incremental
+	fi &&
+	printf '%s\n' "$@" |
+	git rev-list $flags \
+		--objects --stdin --not --all --quiet \
+		--exclude-promisor-objects
+}
+
+# Run git with a temporary index, leaving the real index untouched.
+tmpgit () {
+	GIT_INDEX_FILE=.git/tmp-idx git "$@"
+}
+
+# Create a commit with one file changed, without modifying HEAD,
+# index, or worktree.  Prints the new commit OID on stdout.
+# Usage: commit_with_change <parent> <path> <content>
+commit_with_change () {
+	new_blob=$(echo "$3" | git hash-object -w --stdin) &&
+	tmpgit read-tree "$1" &&
+	tmpgit update-index --replace \
+		--cacheinfo "100644,$new_blob,$2" &&
+	new_tree=$(tmpgit write-tree) &&
+	rm -f .git/tmp-idx &&
+	git commit-tree "$new_tree" -p "$1" -m "modify $2"
+}
+
+# Check OIDs and optionally verify trace2 counts.
+# Usage: check_connected_trace <trace-file> <trees> <blobs> <oid>...
+# An empty string for <trees> or <blobs> skips that assertion.
+check_connected_trace () {
+	trace_file=$1 trees=$2 blobs=$3 &&
+	shift 3 &&
+	test_env GIT_TRACE2_EVENT="$(pwd)/$trace_file" \
+		check_connected "$@" &&
+	if test "$mode" != incremental
+	then
+		return
+	fi &&
+	if test -n "$trees"
+	then
+		test_trace2_data_singular connectivity trees_loaded "$trees" \
+			<"$trace_file"
+	fi &&
+	if test -n "$blobs"
+	then
+		test_trace2_data_singular connectivity blobs_checked "$blobs" \
+			<"$trace_file"
+	fi
+}
+
+# Shared setup: a repo with several root-level files and nested dirs.
+# The unchanged/ subtree (10 dirs x 10 files = 100 blobs, 11 trees)
+# acts as a canary: any test asserting small tree/blob counts would
+# fail dramatically if incremental accidentally walked into it.
+
+test_expect_success 'setup main repo' '
+	git init main-repo &&
+	(
+		cd main-repo &&
+		for i in $(test_seq 1 5)
+		do
+			echo "file $i" >"file-$i.txt" || return 1
+		done &&
+		git add file-*.txt &&
+		git commit -m "initial" &&
+
+		mkdir -p a/b/c &&
+		echo deep >a/b/c/deep.txt &&
+		echo other >a/other.txt &&
+		git add a/b/c/deep.txt a/other.txt &&
+		git commit -m "add nested dirs" &&
+
+		for i in $(test_seq 1 10)
+		do
+			d="unchanged/dir-$i" &&
+			mkdir -p "$d" &&
+			for j in $(test_seq 1 10)
+			do
+				echo "$i $j" >"$d/file-$j.txt" || return 1
+			done
+		done &&
+		git add unchanged/ &&
+		git commit -m "add unchanged canary subtree"
+	)
+'
+
+test_expect_success 'setup replacement object repo' '
+	git init replace-test &&
+	(
+		cd replace-test &&
+
+		test_commit --no-tag original file.txt &&
+		original=$(git rev-parse HEAD) &&
+		orig_blob=$(git rev-parse HEAD:file.txt) &&
+
+		# Orphan replacement commit with a different tree
+		replacement_tree=$(echo replaced | git hash-object -w --stdin |
+			xargs -I{} git mktree <<-EOF
+			100644 blob {}	file.txt
+			EOF
+		) &&
+		replacement=$(git commit-tree -m "replacement" \
+			"$replacement_tree") &&
+
+		git replace "$original" "$replacement" &&
+
+		# Remove the original blob so only the replacement
+		# tree is complete.
+		rm .git/objects/$(test_oid_to_path "$orig_blob") &&
+
+		# Drop branch and HEAD so --not --all does not
+		# exclude the original commit.
+		git update-ref -d refs/heads/main &&
+		git update-ref -d HEAD &&
+
+		echo "$original" >.git/test-oid
+	)
+'
+
+missing_oid=$(test_oid missing)
+original_oid=$(cat replace-test/.git/test-oid)
+
+for mode in full incremental
+do
+
+# Corruption detection: craft broken object graphs and verify detection.
+# All tests use main-repo without modifying its refs or worktree.
+
+test_expect_success "$mode: rejects commit with missing blob" '
+	(
+		cd main-repo &&
+		bad_tree=$(printf "100644 blob ${missing_oid}\tfile.txt\n" |
+			git mktree --missing) &&
+		bad_commit=$(git commit-tree "$bad_tree" -p HEAD -m "bad") &&
+		test_expect_code 128 check_connected "$bad_commit" 2>err &&
+		test_grep "missing blob object" err
+	)
+'
+
+test_expect_success "$mode: rejects commit with missing subtree" '
+	(
+		cd main-repo &&
+		bad_tree=$(printf "40000 tree ${missing_oid}\tdir\n" |
+			git mktree --missing) &&
+		bad_commit=$(git commit-tree "$bad_tree" -p HEAD -m "bad") &&
+		test_expect_code 128 check_connected "$bad_commit" 2>err &&
+		test_grep "bad tree object" err
+	)
+'
+
+test_expect_success "$mode: verifies direct tree tip" '
+	(
+		cd main-repo &&
+		bad_tree=$(printf "100644 blob ${missing_oid}\tfile.txt\n" |
+			git mktree --missing) &&
+		test_expect_code 128 check_connected "$bad_tree" 2>err &&
+		test_grep "missing blob object" err
+	)
+'
+
+test_expect_success "$mode: verifies direct blob tip" '
+	(
+		cd main-repo &&
+		blob_oid=$(echo "hello" | git hash-object -w --stdin) &&
+		check_connected "$blob_oid"
+	)
+'
+
+test_expect_success "$mode: rejects missing direct blob tip" '
+	(
+		cd main-repo &&
+		test_expect_code 128 check_connected \
+			"$missing_oid" 2>err
+	)
+'
+
+test_expect_success PERL_TEST_HELPERS \
+	"$mode: rejects blob OID reused as tree entry" '
+	(
+		cd main-repo &&
+
+		blob_oid=$(git rev-parse HEAD:file-1.txt) &&
+		bin_oid=$(echo "$blob_oid" | hex2oct) &&
+
+		bad_tree=$(printf "40000 subdir\0$bin_oid" |
+			git hash-object -t tree -w --stdin) &&
+		bad_commit=$(git commit-tree -p HEAD -m "child" "$bad_tree") &&
+
+		test_expect_code 128 check_connected "$bad_commit" 2>err &&
+		test_grep "not a tree" err
+	)
+'
+
+test_expect_success PERL_TEST_HELPERS \
+	"$mode: rejects tree OID reused as blob entry" '
+	(
+		cd main-repo &&
+
+		tree_oid=$(git rev-parse HEAD:a) &&
+		bin_oid=$(echo "$tree_oid" | hex2oct) &&
+
+		bad_tree=$(printf "100644 fakefile\0$bin_oid" |
+			git hash-object -t tree -w --stdin) &&
+		bad_commit=$(git commit-tree -p HEAD -m "child" "$bad_tree") &&
+
+		test_expect_code 128 check_connected "$bad_commit" 2>err &&
+		test_grep "not a blob" err
+	)
+'
+
+test_expect_success "$mode: checks multiple tips" '
+	(
+		cd main-repo &&
+		c1=$(commit_with_change HEAD file-1.txt "tip-a") &&
+		c2=$(commit_with_change HEAD file-2.txt "tip-b") &&
+		git tag -a -m "tagged" multi-tag "$c1" &&
+		tag_oid=$(git rev-parse multi-tag) &&
+		git tag -d multi-tag &&
+		check_connected "$c2" "$tag_oid"
+	)
+'
+
+# Tree-diff optimization: verify trace2 counts.
+
+test_expect_success "$mode: handles root commit (no parents)" '
+	(
+		cd main-repo &&
+		blob_oid=$(echo "root-content" | git hash-object -w --stdin) &&
+		tree_oid=$(printf "100644 blob %s\tfile.txt\n" \
+			"$blob_oid" | git mktree) &&
+		root_oid=$(git commit-tree "$tree_oid" -m "root") &&
+
+		# No parent trees, so the full tree is verified.
+		# 1 tree loaded (root), 1 blob checked.
+		check_connected_trace trace-root.txt 1 1 "$root_oid"
+	)
+'
+
+test_expect_success "$mode: handles single file change" '
+	(
+		cd main-repo &&
+		oid=$(commit_with_change HEAD file-1.txt "changed") &&
+
+		# 2 trees loaded (new root + parent root), 1 blob checked.
+		check_connected_trace trace-flat.txt 2 1 "$oid"
+	)
+'
+
+test_expect_success "$mode: handles nested change" '
+	(
+		cd main-repo &&
+		oid=$(commit_with_change HEAD a/b/c/deep.txt "deep-changed") &&
+		# 4 new trees + 4 parent trees = 8 loaded, 1 blob checked.
+		check_connected_trace trace-nested.txt 8 1 "$oid"
+	)
+'
+
+test_expect_success "$mode: handles change-then-revert" '
+	(
+		cd main-repo &&
+		c1=$(commit_with_change HEAD file-1.txt "revert-tmp") &&
+		c2=$(commit_with_change "$c1" file-1.txt "file 1") &&
+		c3=$(commit_with_change "$c2" file-1.txt "revert-final") &&
+
+		# c1: new root + parent root = 2 loads.  c2: root matches
+		# HEAD (already trusted), skipped.  c3: new root + parent
+		# already expanded = 1 load.  Total: 3 trees, 2 blobs.
+		check_connected_trace trace-revert.txt 3 2 "$c3"
+	)
+'
+
+test_expect_success "$mode: handles subtree moved to another path" '
+	(
+		cd main-repo &&
+		moved_tree=$(git ls-tree HEAD |
+			sed "s/	a$/	moved/" |
+			git mktree) &&
+		moved=$(git commit-tree "$moved_tree" -p HEAD -m move) &&
+		# New root + parent root scanned, but the moved subtree
+		# (same OID) is trusted and not descended into.
+		check_connected_trace trace-move.txt 2 0 "$moved"
+	)
+'
+
+test_expect_success "$mode: handles multi-parent merge" '
+	(
+		cd main-repo &&
+		left=$(commit_with_change HEAD file-1.txt left) &&
+		right=$(commit_with_change HEAD file-2.txt right) &&
+		git update-ref refs/heads/left "$left" &&
+		git update-ref refs/heads/right "$right" &&
+		left_blob=$(git rev-parse "$left:file-1.txt") &&
+		right_blob=$(git rev-parse "$right:file-2.txt") &&
+		tmpgit read-tree HEAD &&
+		tmpgit update-index --replace \
+			--cacheinfo "100644,$left_blob,file-1.txt" &&
+		tmpgit update-index --replace \
+			--cacheinfo "100644,$right_blob,file-2.txt" &&
+		merge_tree=$(tmpgit write-tree) &&
+		rm -f .git/tmp-idx &&
+		merge=$(git commit-tree "$merge_tree" \
+			-p "$left" -p "$right" -m merge) &&
+		# Both parent root trees are scanned as bases, so
+		# blobs from each parent are trusted without ODB checks.
+		check_connected_trace trace-merge.txt 3 0 "$merge" &&
+		git update-ref -d refs/heads/left &&
+		git update-ref -d refs/heads/right
+	)
+'
+
+test_expect_success "$mode: handles merge with incoming and boundary parents" '
+	(
+		cd main-repo &&
+		# parent1 is incoming (not a ref), HEAD is boundary.
+		parent1=$(commit_with_change HEAD file-1.txt merge-inc) &&
+		merge=$(git commit-tree \
+			"$(git rev-parse "$parent1^{tree}")" \
+			-p "$parent1" -p HEAD -m merge-mixed) &&
+		# parent1 verified first (topo order): 2 trees, 1 blob.
+		# merge tree = parent1 tree (already trusted): 0 extra.
+		check_connected_trace trace-merge-inc.txt 2 1 "$merge"
+	)
+'
+
+test_expect_success "$mode: handles gitlink entries (submodules)" '
+	(
+		cd main-repo &&
+		tmpgit read-tree HEAD &&
+		tmpgit update-index --add \
+			--cacheinfo "160000,$missing_oid,my-submodule" &&
+		gitlink_tree=$(tmpgit write-tree) &&
+		rm -f .git/tmp-idx &&
+		gitlink_commit=$(git commit-tree "$gitlink_tree" -p HEAD \
+			-m "add gitlink") &&
+
+		# Gitlink entries are skipped -- the missing submodule
+		# commit OID does not cause a failure.
+		check_connected_trace trace-gitlink.txt 2 0 "$gitlink_commit"
+	)
+'
+
+test_expect_success "$mode: handles file-to-directory transition" '
+	(
+		cd main-repo &&
+
+		# Parent: "foo" is a blob at root.
+		blob_a=$(echo "file-content" | git hash-object -w --stdin) &&
+		tmpgit read-tree HEAD &&
+		tmpgit update-index --add \
+			--cacheinfo "100644,$blob_a,foo" &&
+		parent_tree=$(tmpgit write-tree) &&
+		rm -f .git/tmp-idx &&
+		parent=$(git commit-tree "$parent_tree" -p HEAD \
+			-m "add foo as file") &&
+
+		# Child: "foo" becomes a directory (foo/bar.txt).
+		blob_b=$(echo "dir-content" | git hash-object -w --stdin) &&
+		tmpgit read-tree "$parent" &&
+		tmpgit update-index --remove foo &&
+		tmpgit update-index --add \
+			--cacheinfo "100644,$blob_b,foo/bar.txt" &&
+		child_tree=$(tmpgit write-tree) &&
+		rm -f .git/tmp-idx &&
+		child=$(git commit-tree "$child_tree" -p "$parent" \
+			-m "foo: file to directory") &&
+		check_connected_trace trace-f2d.txt "" "" "$child"
+	)
+'
+
+test_expect_success "$mode: handles directory-to-file transition" '
+	(
+		cd main-repo &&
+
+		# Parent: "bar/baz.txt" exists (bar is a directory).
+		blob_a=$(echo "nested" | git hash-object -w --stdin) &&
+		tmpgit read-tree HEAD &&
+		tmpgit update-index --add \
+			--cacheinfo "100644,$blob_a,bar/baz.txt" &&
+		parent_tree=$(tmpgit write-tree) &&
+		rm -f .git/tmp-idx &&
+		parent=$(git commit-tree "$parent_tree" -p HEAD \
+			-m "add bar as directory") &&
+
+		# Child: "bar" becomes a plain file.
+		blob_b=$(echo "flat" | git hash-object -w --stdin) &&
+		tmpgit read-tree "$parent" &&
+		tmpgit update-index --remove bar/baz.txt &&
+		tmpgit update-index --add \
+			--cacheinfo "100644,$blob_b,bar" &&
+		child_tree=$(tmpgit write-tree) &&
+		rm -f .git/tmp-idx &&
+		child=$(git commit-tree "$child_tree" -p "$parent" \
+			-m "bar: directory to file") &&
+		check_connected_trace trace-d2f.txt "" "" "$child"
+	)
+'
+
+# Replacement objects.
+
+test_expect_success "$mode: accepts with replacement objects" '
+	(
+		cd replace-test &&
+		check_connected "$original_oid"
+	)
+'
+
+test_expect_success "$mode: rejects without replacement objects" '
+	(
+		cd replace-test &&
+		GIT_NO_REPLACE_OBJECTS=1 &&
+		export GIT_NO_REPLACE_OBJECTS &&
+		test_expect_code 128 check_connected \
+			"$original_oid" 2>err &&
+		test_grep "missing blob object" err
+	)
+'
+
+test_expect_success "$mode: accepts missing promised blob" '
+	test_when_finished "rm -rf prom-src prom-server.git prom-client" &&
+	git init prom-src &&
+	test_commit -C prom-src --no-tag base file.txt original &&
+	test_commit -C prom-src --no-tag "add file2" file2.txt extra &&
+	git clone --bare prom-src prom-server.git &&
+	git -C prom-server.git config uploadpack.allowfilter true &&
+	git -C prom-server.git config uploadpack.allowanysha1inwant true &&
+	git clone --no-checkout --filter=blob:none \
+		"file://$(pwd)/prom-server.git" prom-client &&
+	(
+		cd prom-client &&
+		promised_blob=$(git rev-parse HEAD:file2.txt) &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$promised_blob" &&
+		new_tree=$(printf "100644 blob %s\tnewname.txt\n" \
+			"$promised_blob" |
+			git mktree --missing) &&
+		new_commit=$(git commit-tree "$new_tree" \
+			-p HEAD -m "reuse promised blob") &&
+		check_connected "$new_commit" &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$promised_blob"
+	)
+'
+
+test_expect_success "$mode: accepts missing promised tree" '
+	test_when_finished "rm -rf prom-tree-src prom-tree-server.git prom-tree-client" &&
+	git init prom-tree-src &&
+	mkdir -p prom-tree-src/a/b &&
+	test_commit -C prom-tree-src --no-tag "nested dirs" a/b/file.txt deep &&
+	git clone --bare prom-tree-src prom-tree-server.git &&
+	git -C prom-tree-server.git config uploadpack.allowfilter true &&
+	git -C prom-tree-server.git config uploadpack.allowanysha1inwant true &&
+	git clone --no-checkout --filter=tree:1 \
+		"file://$(pwd)/prom-tree-server.git" prom-tree-client &&
+	(
+		cd prom-tree-client &&
+		promised_tree=$(git ls-tree HEAD -- a |
+			awk "{print \$3}") &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$promised_tree" &&
+		new_tree=$(printf "40000 tree %s\trenamed\n" \
+			"$promised_tree" |
+			git mktree --missing) &&
+		new_commit=$(git commit-tree "$new_tree" \
+			-p HEAD -m "reuse promised tree") &&
+		check_connected "$new_commit" &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$promised_tree"
+	)
+'
+
+test_expect_success "$mode: verifies new subtree when parent subtree is promised" '
+	test_when_finished "rm -rf prom-base-src prom-base-server.git prom-base-client" &&
+	git init prom-base-src &&
+	mkdir -p prom-base-src/a &&
+	test_commit -C prom-base-src --no-tag "base" a/file.txt deep &&
+	git clone --bare prom-base-src prom-base-server.git &&
+	git -C prom-base-server.git config uploadpack.allowfilter true &&
+	git -C prom-base-server.git config uploadpack.allowanysha1inwant true &&
+	git clone --no-checkout --filter=tree:1 \
+		"file://$(pwd)/prom-base-server.git" prom-base-client &&
+	(
+		cd prom-base-client &&
+		parent_subtree=$(git ls-tree HEAD -- a |
+			awk "{print \$3}") &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$parent_subtree" &&
+		new_blob=$(echo "local-content" | git hash-object -w --stdin) &&
+		new_subtree=$(printf "100644 blob %s\tfile.txt\n" \
+			"$new_blob" | git mktree) &&
+		new_root=$(printf "40000 tree %s\ta\n" \
+			"$new_subtree" | git mktree) &&
+		new_commit=$(git commit-tree "$new_root" \
+			-p HEAD -m "replace promised subtree") &&
+		check_connected "$new_commit" &&
+		test_must_fail env GIT_NO_LAZY_FETCH=1 \
+			git cat-file -e "$parent_subtree"
+	)
+'
+
+test_expect_success "$mode: verifies local commit in partial clone" '
+	test_when_finished "rm -rf pc-src pc-server.git pc-client" &&
+	git init pc-src &&
+	test_commit -C pc-src --no-tag base file.txt &&
+	git clone --bare pc-src pc-server.git &&
+	git -C pc-server.git config uploadpack.allowfilter true &&
+	git -C pc-server.git config uploadpack.allowanysha1inwant true &&
+	git clone --filter=blob:none \
+		"file://$(pwd)/pc-server.git" pc-client &&
+	(
+		cd pc-client &&
+		local_commit=$(commit_with_change HEAD file.txt local-content) &&
+		check_connected "$local_commit"
+	)
+'
+
+test_expect_success "$mode: respects shallow boundary" '
+	test_when_finished "rm -rf shallow-src shallow" &&
+	git init shallow-src &&
+	test_commit -C shallow-src --no-tag base file content-1 &&
+	mkdir shallow-src/sub &&
+	test_commit -C shallow-src --no-tag change sub/other content-2 &&
+	git clone --depth=1 "file://$(pwd)/shallow-src" shallow &&
+	(
+		cd shallow &&
+		tip=$(git rev-parse HEAD) &&
+		git for-each-ref --format="delete %(refname)" |
+			git update-ref --no-deref --stdin &&
+		check_connected "$tip"
+	)
+'
+
+test_expect_success "$mode: deepening fetch succeeds" '
+	test_when_finished "rm -rf deepen-src deepen-server.git deepen-client" &&
+	git init deepen-src &&
+	test_commit -C deepen-src --no-tag c1 file.txt &&
+	test_commit -C deepen-src --no-tag c2 file.txt &&
+	test_commit -C deepen-src --no-tag c3 file.txt &&
+	git clone --bare deepen-src deepen-server.git &&
+	git clone --depth=1 "file://$(pwd)/deepen-server.git" deepen-client &&
+	set_connectivity_check deepen-client $mode &&
+	test -f deepen-client/.git/shallow &&
+	GIT_TRACE2_EVENT="$(pwd)/deepen-trace.txt" \
+		git -C deepen-client fetch --deepen=2 origin main &&
+	# Incremental falls back to full for deepening fetches,
+	# so the trees_loaded event should not appear.
+	test_grep ! trees_loaded deepen-trace.txt
+'
+
+test_expect_success "$mode: malformed tree detected" '
+	(
+		cd main-repo &&
+		echo abc >malformed-tree &&
+		malformed_tree=$(git hash-object --literally -t tree -w \
+			malformed-tree) &&
+		malformed_commit=$(git commit-tree "$malformed_tree" \
+			-p HEAD -m malformed) &&
+		test_expect_code 128 check_connected \
+			"$malformed_commit" 2>err
+	)
+'
+
+test_expect_success PERL_TEST_HELPERS \
+	"$mode: mid-tree corruption detected" '
+	(
+		cd main-repo &&
+		# Build a tree with one valid entry followed by garbage.
+		blob_oid=$(echo "valid" | git hash-object -w --stdin) &&
+		bin_oid=$(echo "$blob_oid" | hex2oct) &&
+		printf "100644 good\0${bin_oid}GARBAGE" >corrupt-mid-tree &&
+		corrupt_tree=$(git hash-object --literally -t tree -w \
+			corrupt-mid-tree) &&
+		corrupt_commit=$(git commit-tree "$corrupt_tree" \
+			-p HEAD -m "mid-tree corruption") &&
+		test_expect_code 128 check_connected \
+			"$corrupt_commit" 2>err &&
+		test_grep "too-short tree object" err
+	)
+'
+
+done
+
+# Algorithm selection.
+
+test_expect_success 'invalid transfer.connectivityCheck is rejected' '
+	test_when_finished "rm -rf invalid-cfg-src invalid-cfg-dst" &&
+	git init invalid-cfg-src &&
+	test_commit -C invalid-cfg-src --no-tag base file.txt &&
+	git clone invalid-cfg-src invalid-cfg-dst &&
+	test_commit -C invalid-cfg-src --no-tag update file.txt updated &&
+	git -C invalid-cfg-dst config transfer.connectivityCheck bogus &&
+	test_must_fail git -C invalid-cfg-dst fetch origin main 2>err &&
+	test_grep "unknown transfer.connectivityCheck" err
+'
+
+test_expect_success 'push uses incremental when configured' '
+	test_when_finished "rm -rf int-src int-dst.git" &&
+	git init int-src &&
+	test_commit -C int-src --no-tag base file.txt &&
+	git clone --bare int-src int-dst.git &&
+	test_commit -C int-src --no-tag update file.txt updated &&
+	set_connectivity_check int-dst.git incremental &&
+	GIT_TRACE2_EVENT="$(pwd)/push-trace.txt" \
+		git -C int-src push ../int-dst.git main &&
+	test_trace2_data_singular connectivity trees_loaded 2 \
+		<push-trace.txt
+'
+
+test_expect_success 'fetch uses incremental when configured' '
+	test_when_finished "rm -rf fetch-src fetch-dst" &&
+	git init fetch-src &&
+	test_commit -C fetch-src --no-tag base file.txt &&
+	git clone fetch-src fetch-dst &&
+	test_commit -C fetch-src --no-tag update file.txt updated &&
+	set_connectivity_check fetch-dst incremental &&
+	GIT_TRACE2_EVENT="$(pwd)/fetch-trace.txt" \
+		git -C fetch-dst fetch origin main &&
+	test_trace2_data_singular connectivity trees_loaded 2 \
+		<fetch-trace.txt
+'
+
+test_expect_success 'clone respects transfer.connectivityCheck' '
+	test_when_finished "rm -rf clone-src clone-dst" &&
+	git init clone-src &&
+	test_commit -C clone-src --no-tag base file.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/clone-trace.txt" \
+		git -c transfer.connectivityCheck=incremental \
+		clone --no-local clone-src clone-dst &&
+	test_trace2_data_singular connectivity trees_loaded 0 \
+		<clone-trace.txt
+'
+
+test_done
diff --git a/tree-verify.c b/tree-verify.c
new file mode 100644
index 0000000000..16acc9b16d
--- /dev/null
+++ b/tree-verify.c
@@ -0,0 +1,306 @@
+#include "git-compat-util.h"
+#include "commit.h"
+#include "gettext.h"
+#include "hex.h"
+#include "khash.h"
+#include "object.h"
+#include "odb.h"
+#include "oid-array.h"
+#include "oidset.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "tree-verify.h"
+#include "packfile.h"
+#include "trace2.h"
+
+enum tree_state {
+	TREE_UNTRUSTED = 0,
+	TREE_TRUSTED   = 1,
+	TREE_EXPANDED  = 2,
+};
+
+KHASH_INIT(oid_tree, struct object_id, unsigned char, 1,
+	   oidhash_by_value, oideq_by_value)
+
+static enum tree_state tree_map_get(kh_oid_tree_t *m,
+				    const struct object_id *oid)
+{
+	khint_t pos = kh_get_oid_tree(m, *oid);
+	if (pos == kh_end(m))
+		return TREE_UNTRUSTED;
+	return kh_val(m, pos);
+}
+
+static void tree_map_add(kh_oid_tree_t *m, const struct object_id *oid,
+			 enum tree_state state)
+{
+	int added;
+	khint_t pos = kh_put_oid_tree(m, *oid, &added);
+	if (added)
+		kh_val(m, pos) = state;
+	else if (state > kh_val(m, pos))
+		kh_val(m, pos) = state;
+}
+
+struct work_item {
+	struct name_entry entry;
+	struct oid_array parent_trees;
+};
+
+struct verify_state {
+	kh_oid_tree_t *trees;
+	struct oidset trusted_blobs;
+	int trees_loaded;
+	int blobs_checked;
+	int exclude_promisor_objects;
+};
+
+/*
+ * Merge-walk the work list against one base tree entry, recording
+ * same-path parent subtrees as recursive comparison bases.
+ * Returns the updated work-list cursor.
+ */
+static size_t collect_subtree_bases(struct work_item *work, size_t nr_work,
+				    size_t wi, const struct name_entry *entry)
+{
+	while (wi < nr_work) {
+		int cmp = base_name_compare(
+			work[wi].entry.path, work[wi].entry.pathlen,
+			work[wi].entry.mode,
+			entry->path, entry->pathlen,
+			entry->mode);
+		if (cmp > 0)
+			break;
+		if (cmp < 0) {
+			wi++;
+			continue;
+		}
+		if (S_ISDIR(work[wi].entry.mode) &&
+		    S_ISDIR(entry->mode))
+			oid_array_append(&work[wi].parent_trees,
+					 &entry->oid);
+		return wi + 1;
+	}
+	return wi;
+}
+
+static void verify_blob(struct repository *repo,
+			const struct object_id *oid,
+			struct verify_state *vs)
+{
+	int type;
+
+	if (oidset_contains(&vs->trusted_blobs, oid))
+		return;
+
+	vs->blobs_checked++;
+	type = odb_read_object_info(repo->objects, oid, NULL);
+	if (type == OBJ_BLOB) {
+		oidset_insert(&vs->trusted_blobs, oid);
+		return;
+	}
+	if (type >= 0)
+		die(_("object %s is a %s, not a blob"),
+		    oid_to_hex(oid), type_name(type));
+	if (vs->exclude_promisor_objects &&
+	    is_promisor_object(repo, oid))
+		return;
+	die(_("missing blob object '%s'"), oid_to_hex(oid));
+}
+
+static void *read_tree_object(struct object_database *odb,
+			      const struct object_id *oid,
+			      size_t *sizep)
+{
+	enum object_type type;
+	void *buf = odb_read_object(odb, oid, &type, sizep);
+
+	if (buf && type != OBJ_TREE) {
+		free(buf);
+		die(_("object %s is a %s, not a tree"),
+		    oid_to_hex(oid), type_name(type));
+	}
+	return buf;
+}
+
+static void verify_tree(struct repository *repo,
+			const struct object_id *new_tree_oid,
+			const struct oid_array *base_trees,
+			struct verify_state *vs, int depth)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct work_item *work = NULL;
+	size_t nr_work = 0, alloc_work = 0;
+	int need_subtree_bases = 0;
+	size_t i, tree_size;
+	void *tree_buf;
+
+	if (depth > repo->settings.max_allowed_tree_depth)
+		die(_("exceeded maximum allowed tree depth"));
+
+	if (tree_map_get(vs->trees, new_tree_oid) >= TREE_TRUSTED)
+		return;
+
+	tree_buf = read_tree_object(repo->objects, new_tree_oid, &tree_size);
+	if (!tree_buf) {
+		if (vs->exclude_promisor_objects &&
+		    is_promisor_object(repo, new_tree_oid))
+			return;
+		die(_("bad tree object %s"),
+		    oid_to_hex(new_tree_oid));
+	}
+
+	vs->trees_loaded++;
+	init_tree_desc(&desc, new_tree_oid, tree_buf, tree_size);
+
+	while (tree_entry(&desc, &entry)) {
+		if (S_ISGITLINK(entry.mode))
+			continue;
+		if (S_ISDIR(entry.mode)) {
+			if (tree_map_get(vs->trees, &entry.oid) >= TREE_TRUSTED)
+				continue;
+			need_subtree_bases = 1;
+		} else {
+			if (oidset_contains(&vs->trusted_blobs, &entry.oid))
+				continue;
+		}
+		ALLOC_GROW(work, nr_work + 1, alloc_work);
+		memset(&work[nr_work], 0, sizeof(work[nr_work]));
+		work[nr_work].entry = entry;
+		nr_work++;
+	}
+
+	if (!nr_work) {
+		free(tree_buf);
+		goto done;
+	}
+
+	for (i = 0; base_trees && i < base_trees->nr; i++) {
+		const struct object_id *base_oid = &base_trees->oid[i];
+		int expanded = tree_map_get(vs->trees, base_oid) >= TREE_EXPANDED;
+		struct tree_desc base_desc;
+		struct name_entry scan_entry;
+		size_t wi = 0, base_size;
+		void *base_buf;
+
+		if (expanded && !need_subtree_bases)
+			continue;
+
+		base_buf = read_tree_object(repo->objects, base_oid,
+					    &base_size);
+		if (!base_buf) {
+			if (vs->exclude_promisor_objects &&
+			    is_promisor_object(repo, base_oid))
+				continue;
+			die(_("bad tree object %s"),
+			    oid_to_hex(base_oid));
+		}
+
+		vs->trees_loaded++;
+		init_tree_desc(&base_desc, base_oid, base_buf, base_size);
+
+		while (tree_entry(&base_desc, &scan_entry)) {
+			if (S_ISGITLINK(scan_entry.mode))
+				continue;
+
+			if (need_subtree_bases)
+				wi = collect_subtree_bases(work, nr_work,
+							   wi, &scan_entry);
+
+			if (!expanded) {
+				if (S_ISDIR(scan_entry.mode))
+					tree_map_add(vs->trees,
+						     &scan_entry.oid,
+						     TREE_TRUSTED);
+				else
+					oidset_insert(&vs->trusted_blobs,
+						      &scan_entry.oid);
+			}
+		}
+
+		if (!expanded)
+			tree_map_add(vs->trees, base_oid, TREE_EXPANDED);
+
+		free(base_buf);
+	}
+
+	for (i = 0; i < nr_work; i++) {
+		if (S_ISDIR(work[i].entry.mode))
+			verify_tree(repo, &work[i].entry.oid,
+				    &work[i].parent_trees, vs,
+				    depth + 1);
+		else
+			verify_blob(repo, &work[i].entry.oid, vs);
+	}
+
+	free(tree_buf);
+
+done:
+	tree_map_add(vs->trees, new_tree_oid, TREE_EXPANDED);
+	for (i = 0; i < nr_work; i++)
+		oid_array_clear(&work[i].parent_trees);
+	free(work);
+}
+
+static void verify_commit_tree(struct repository *repo,
+			       struct commit *commit,
+			       struct verify_state *vs)
+{
+	struct oid_array base_trees = OID_ARRAY_INIT;
+	struct commit_list *p;
+
+	/*
+	 * Parent trees are trusted: boundary parents are already
+	 * connected, and earlier incoming parents were verified
+	 * first due to the topological processing order.
+	 */
+	for (p = commit->parents; p; p = p->next) {
+		const struct object_id *tree_oid;
+		parse_commit_or_die(p->item);
+		tree_oid = get_commit_tree_oid(p->item);
+		tree_map_add(vs->trees, tree_oid, TREE_TRUSTED);
+		oid_array_append(&base_trees, tree_oid);
+	}
+
+	verify_tree(repo, get_commit_tree_oid(commit),
+		    &base_trees, vs, 0);
+	oid_array_clear(&base_trees);
+}
+
+void verify_commits_incremental(struct repository *repo,
+				struct commit_list **commits,
+				int exclude_promisor_objects)
+{
+	struct verify_state vs = { 0 };
+	struct commit_list *iter;
+	unsigned nr_before;
+
+	vs.trees = kh_init_oid_tree();
+	vs.exclude_promisor_objects = exclude_promisor_objects;
+
+	/*
+	 * Ancestors must be verified before descendants so that parent
+	 * trees can be trusted without re-verification.  Sort explicitly
+	 * rather than relying on the caller's ordering.
+	 *
+	 * sort_in_topological_order() silently drops cycle members,
+	 * so explicitly check if the size has changed.
+	 */
+	nr_before = commit_list_count(*commits);
+	sort_in_topological_order(commits, REV_SORT_IN_GRAPH_ORDER);
+	if (commit_list_count(*commits) < nr_before)
+		die(_("cycle detected in incoming commit graph"));
+
+	*commits = commit_list_reverse(*commits);
+
+	for (iter = *commits; iter; iter = iter->next)
+		verify_commit_tree(repo, iter->item, &vs);
+
+	kh_destroy_oid_tree(vs.trees);
+	oidset_clear(&vs.trusted_blobs);
+	trace2_data_intmax("connectivity", repo,
+			   "trees_loaded", vs.trees_loaded);
+	trace2_data_intmax("connectivity", repo,
+			   "blobs_checked", vs.blobs_checked);
+}
diff --git a/tree-verify.h b/tree-verify.h
new file mode 100644
index 0000000000..6aadadff70
--- /dev/null
+++ b/tree-verify.h
@@ -0,0 +1,15 @@
+#ifndef TREE_VERIFY_H
+#define TREE_VERIFY_H
+
+struct commit_list;
+struct repository;
+
+/*
+ * Verify trees of commits incrementally against their parents.
+ * Dies on verification failure.
+ */
+void verify_commits_incremental(struct repository *repo,
+				struct commit_list **commits,
+				int exclude_promisor_objects);
+
+#endif /* TREE_VERIFY_H */
-- 
gitgitgadget
