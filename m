Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2145940D59C
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806883; cv=none; b=CDzh7VpyHigA8ivY0gnzdTk5bsmWiSNTDB5RjEEh1yHpUzGgrrtexk0jmNQimHk+uEWNcj7IR2wjohr1DQVzJxifc8IG3QqUqsL/LnKmStzrUvMeydRIAEV9Muw5e97jvotVW3K12RX3c3mN9XXO/y6LOYQztQ0om3n7XhN+I/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806883; c=relaxed/simple;
	bh=JqvqOWYUbmiOrF0woXVRqmZr+zL3i7xeZwx078OshFM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xnz9p9r8tnnMCqhH25ljPJRjz/4pL5OhOtgTBEManFfw8wqbxnjq45DYk47v+6eK9e3JmNEMPF7GgOvs2PDIMbbTiSoVkLqIF50oryRaXE4YAC1NwsbmeTj8eRwMcBjmBoIAR8TS9o1XfZvxgiLge+6b/gw3PviNP9foZj4YRmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=orsGGlwc; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orsGGlwc"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b83459526so8046686d6.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 05:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806880; x=1792411680; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HBwrSwake7CPxGoPxZsTGRKCGDMVDzOOAoLoUpDp3ys=;
        b=orsGGlwcYi57IWCghgC3aQiGOdv4gR6zkWo5ciBA+QiexZjufRhrg0Z+dxcSV8BUXl
         Jo5u16/l5+kEfbs0bhj/Gl2bBNwmRb0Irwc4038gJJ1vnkZD8PAocpH3tIWaSoreFdzm
         r0uT3rXhWa/iiasHLDLqqQA78XWOChkcEHkotNyrBOe6aqQERyW7qR3992Q+08QA8PxS
         Dh4Cv5KNnv22gkrsBSMo0Fghp/crF9rkEY/2Z9vUW284Jp/ulfzPINPfpQTAFDr68eW3
         xCFumSdfkR9dkzAFkhvYHSQwJCvMxYQUU3+/3txmb73khDBN70/GdcR0osh/IrekYyCq
         t6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806880; x=1792411680;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HBwrSwake7CPxGoPxZsTGRKCGDMVDzOOAoLoUpDp3ys=;
        b=dj05lauBEue63PddGQKpgqq62YyorFS0PWqsB+7QOk76FFHN5u45xaJl+hmbFyKczD
         OKXPvMGxf8j6Z4/N+w00nFg8sPBz6p3X6HPqQMIUthabpPfKMKU9fDQUJiONn4qHVJMW
         Ma4AgrsDqj4P1vGcD8RmiIoCYHP3bfd+0hl9j/WqdTa5GyTfLSOl1DHPs+pcNuWs99Lh
         Ivl/La0QEyFiKInRLwZ/gsubpEudyKjwsLGY2h8Cw9obEv7gqyHeIZPwhoNMfpMuJY3G
         e7CAtQ/kuVA6bparfGpL6QJ37IHF5LnSJ6mRDDRvFo86g8mhEkUTsps8aWLW/9Nwn5i1
         UuVQ==
X-Gm-Message-State: AFq9FYKYD3XCpUC1Ot6J7zSZQzpmXxfDq2pwBo9wv7CU2joc5ryi6r4H
	DYX/z2iD1ePF2YhuOIOpX/auAQbvzxbGcCFJZSDR/YgTB0m98loCJpHBLlFin5TE
X-Gm-Gg: AYBFou0v1T/gNdgECWHE2RpgUAmylMDFoePST2CPELNT0Nm/kIYkYPOopdrADAwopMr
	deouSzP5UqLaWG3WUpP33sFAco49fbRH6GHyBZaSdctM+4/k9YGINke5ElpjtAe5tbjy0m2OaV6
	SjOTXdX3PgO8VB/pV2EW2uFM44q+PeL5IXi2+t8vu+kibJuToWlZRJIXeiA7UgA7eplRQ5G1nxg
	odu7NUjFYs1kUxXXmhzySFZ/eENeArffu2p80e2nVQfOKEWZUINYOUe+OLhdEVwW5zCo9Obr9NJ
	GeriQ3YDfc1MSFjtZG4LbFADEvUeE10IGiY8/lanJcZpa+KymElTrNdoUGaaeM9bg/RWxeoF4oG
	bp2WJsS/p/MU0FvD5U7VVt9NIBhREEd9RiPdMyAW4SlH3z0zjCi6gYufDC7q/7NaXX0CKrTfJ6b
	mNrLI69pZF9Kwgi25fLVzG76DCRMEMelgSfH9oOsZyrkeGIReMc16Ss/B4T/dwnpmSmR5N9pMBg
	IzB8xP2bNkK
X-Received: by 2002:ad4:5ca3:0:b0:91b:8afd:84e2 with SMTP id 6a1803df08f44-91b8afd8f30mr21275216d6.39.1791806879665;
        Mon, 12 Oct 2026 05:07:59 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.13.57])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b937cbf3fsm2234226d6.49.2026.10.12.05.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:07:58 -0700 (PDT)
Message-Id: <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 12:07:53 +0000
Subject: [PATCH v3 0/4] connected: add incremental connectivity check
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
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>

This series adds an incremental mode for the connectivity check, gated
behind transfer.connectivityCheck=incremental (no expected changes unless
you opt in).

The intent is to solve the problem of the connectivity check slowing down as
the number of reachable objects from the boundary grows.

It relates to the RFC I sent out earlier:

[RFC] check_connected: toward incoming-proportional cost
https://lore.kernel.org/git/CAL71e4Nf=-zCrfN7ghEVGq11irajJhtdxYZgKe0Ycux0qs1ZvQ@mail.gmail.com/



Design
======

The verifier runs inside the same rev-list subprocess that check_connected()
already spawns, triggered by a new internal flag --verify-trees-incremental.
After get_revision() collects the incoming commits, the verifier processes
them in topological order (ancestors before descendants).

The idea is to keep a set of trusted objects, shared across the incoming
commits, that grows over time. We visit the new/untrusted commit trees and
do a comparison walk over the trees of their parents. Entries discovered on
the trusted parent side are remembered as trusted, which lets later
verification skip matching objects and avoid descending into unchanged
subtrees.

More algorithmic details are in
Documentation/technical/connectivity-check.adoc.


Benchmarks
==========

I'll just mention a short summary here, to avoid repeating what's already in
the commit message. The incremental mode is faster than the full mode when
there are few commits to verify and when the active object tree is large. In
the happy case, the work tracks the changed paths and their comparison trees
rather than the full reachable object closure, which substantially reduces
the dependence on total repository size. I've seen speedups up to around 20x
for the synthetic perf tests.

Running against a large real-world repo (3.4 GB boundary closure), the
numbers are more dramatic. All timings use rev-list directly with --not
HEADN, isolating the tree verification cost from the boundary-finding cost:

commits    full  incr.  speedup   full RSS  incr. RSS
      1    1.9s  0.01s    190x      3.4 GB     14 MB
     10    1.9s  0.04s     48x      3.4 GB    125 MB
    100    1.9s  0.37s      5x      3.4 GB    1.1 GB


The full mode takes ~1.9s regardless of commit count because it is dominated
by walking the boundary closure. Incremental scales with the number of
incoming commits and the paths they touch. Memory follows the same pattern:
incremental uses a fraction of the full mode's RSS for small pushes,
converging only when many commits are verified.

There are also regression cases in the synthetic fixtures. With long
incoming histories, the extra parent-tree scans accumulate; in the synthetic
fixture incremental is about 1.5x slower at 10000 commits. Per-commit
changes have less impact than expected: even when every directory is
touched, incremental remains competitive; bypassing the object cache for
tree reads likely helps here.

I cannot establish how common these regression cases are. In the cases I
have tested, however, the regression has remained modest; I have not been
able to provoke a substantially larger slowdown. My feeling is that this is
an acceptable tradeoff behind the opt-in config, since the target case
(small pushes to large repos) sees the largest speedup, while the regression
appears with long incoming histories.

A safety net for this regression could be to dynamically disable the
incremental mode if the number of incoming commits is too large, but this is
left out of the initial version to avoid overly speculative code.

Deepening fetches currently fall back to the full check because the full
check omits --not --all for deepening -- there is no existing-reference
boundary at which the walk can stop. An incremental approach is possible
here too -- using the old shallow roots as the trusted boundary and walking
the deepened ancestry forward -- but that is a separate change and left for
future work. Deepening is also less common than regular fetch and
receive-pack, where the speedup matters most.


Test coverage
=============

Most correctness cases in t5413-connectivity-check.sh are run in both full
and incremental modes to check semantic equivalence. Selected cases
additionally assert trace2 tree/blob counts for the incremental mode, to
verify that unchanged portions of the object graph are actually skipped. It
covers:

 * Corruption detection: missing blobs, missing trees, type mismatches,
   malformed trees (unparseable, mid-tree corruption)
 * Tree optimization: trace2 assertions confirm unchanged subtrees are
   skipped, subtree moves, merge parent boundaries
 * Root commits (no parents -- verifies full tree closure)
 * Partial clones: missing promised blobs, missing promised trees,
   verification of local commits
 * Replacement objects (with and without GIT_NO_REPLACE_OBJECTS)
 * Shallow boundaries
 * Deepening fetches (falls back to full check)
 * Integration: real push, fetch, and clone

Most tests call git rev-list directly with the appropriate flags;
integration tests exercise the full check_connected() path through push,
fetch, and clone.


Alternatives considered
=======================

My first prototype ran the verifier in-process inside connected.c. This
required a second rev-list subprocess just for boundary finding, _nofetch
variants of several object-reading functions to prevent lazy fetches in
partial clones, explicit shallow-file plumbing, and careful avoidance of
die() in all code paths reachable from the verifier. The result worked but
was fragile and touched many files.

Moving the verifier into the rev-list subprocess eliminated all of those
problems: in partial clones the existing --exclude-promisor-objects handling
already disables lazy fetching, die() is isolated by the process boundary,
shallow and replacement semantics are established before the verifier runs,
and error routing comes for free via stderr.

So while I liked the idea of being less reliant on checking within a
subprocess, making that work ended up being a lot more complex.


Next steps
==========

This series only addresses tree verification; the other significant cost is
finding the commit boundary, especially for repos with many refs. I already
have some prototypes for optimizing that too, and if this ends up landing,
that would be something I would start polishing up.


Changes since v2
================

Addresses Patrick's review (thanks!).

 * Split from 2 commits to 4: documentation, perf test baseline, config
   plumbing + rev-list flag, then the incremental implementation.
 * Documentation rewrites: added unreachable-objects caveat, removed code
   references to reduce staleness risk, replaced three-phase list with
   cost-focused prose, rewrote trust model to explicitly describe boundary
   mechanism and inductive argument, and several smaller clarifications.
 * Extracted tree_oid variable in verify_commit_tree() to avoid calling
   get_commit_tree_oid(commit) twice.
 * Rebased onto latest master to resolve a meson.build conflict (t5412 was
   taken by another topic). Renumbered test and perf files to t5413/p5413.


Changes since v1
================

 * Guard against get_commit_tree_oid() returning NULL in
   verify_commit_tree(), dying with a clear message instead of a NULL
   dereference. (Thanks Junio for catching this)
 * Set fetch_if_missing = 0 in the rev-list early option parse when
   --verify-trees-incremental is seen, and add a BUG() assertion in
   verify_commits_incremental() to catch any future caller that forgets.
   This makes the lazy-fetch protection explicit rather than relying solely
   on --exclude-promisor-objects having set it earlier. (Thanks again to
   Junio)
 * Add a test that verifies promised blobs are not lazy-fetched during the
   incremental check.
 * Reuse the existing 3-argument type-mismatch format string to avoid adding
   new strings for localization.

Thanks, Kristofer

Kristofer Karlsson (4):
  Documentation: describe connectivity checking
  p5413: add perf tests for connectivity check
  connected: add transfer.connectivityCheck config and rev-list flag
  connected: add incremental connectivity check via rev-list

 Documentation/config/transfer.adoc            |  20 +
 Documentation/rev-list-options.adoc           |   6 +
 .../technical/connectivity-check.adoc         | 255 +++++++
 Makefile                                      |   1 +
 builtin/rev-list.c                            |  19 +
 connected.c                                   |  24 +
 meson.build                                   |   1 +
 t/meson.build                                 |   1 +
 ...enerate-repo-p5413-connectivity-check.perl |  44 ++
 t/perf/p5413-connectivity-check.sh            |  92 +++
 t/t5413-connectivity-check.sh                 | 680 ++++++++++++++++++
 tree-verify.c                                 | 316 ++++++++
 tree-verify.h                                 |  15 +
 13 files changed, 1474 insertions(+)
 create mode 100644 Documentation/technical/connectivity-check.adoc
 create mode 100644 t/perf/generate-repo-p5413-connectivity-check.perl
 create mode 100755 t/perf/p5413-connectivity-check.sh
 create mode 100755 t/t5413-connectivity-check.sh
 create mode 100644 tree-verify.c
 create mode 100644 tree-verify.h


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2211%2Fspkrka%2Ftree-diff-connectivity-v1-clean-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2211/spkrka/tree-diff-connectivity-v1-clean-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2211

Range-diff vs v2:

 1:  97c11449ae ! 1:  19ea8cb534 Documentation: describe connectivity checking
     @@ Documentation/technical/connectivity-check.adoc (new)
      +
      +A repository is connected when every object reachable from its
      +references is available locally (with exceptions noted below).
     ++The reverse does not hold: objects that exist in the object
     ++database but are not reachable from any reference may be
     ++incomplete or lack a connected closure.
      +
      +The connectivity check maintains this invariant when references
     -+are updated.  It trusts the existing connected state and verifies
     -+that the new reference tips do not introduce references to
     -+unavailable objects.  Verification is permitted to stop when it
     -+reaches objects already reachable from trusted existing
     -+references, since their closure is already connected.  These
     -+trusted references include local references and references from
     -+alternate object stores.
     ++are updated.  It trusts that all objects reachable from existing
     ++reference tips are already fully connected and verifies that the
     ++new reference tips do not introduce references to unavailable
     ++objects.  Verification is permitted to stop when it reaches
     ++objects already reachable from existing references, since their
     ++closure is already connected.  These trusted references include
     ++local references and references from alternate object stores.
      +
      +Without this check, a truncated or corrupted transfer could leave
      +a repository in a state where later history walks encounter
     @@ Documentation/technical/connectivity-check.adoc (new)
      +Full connectivity check
      +-----------------------
      +
     -+`check_connected()` (see `connected.c`) normally performs the
     -+connectivity check using a `rev-list` subprocess, feeding the
     -+new reference tips via stdin.  A normal invocation is roughly:
     ++The full connectivity check runs a `rev-list` subprocess, feeding
     ++the new reference tips via stdin.  A normal invocation is roughly:
      +
      +    git rev-list --objects --stdin --not --all --quiet
      +        --alternate-refs [--exclude-promisor-objects]
      +
     -+When promisor remotes are configured, `check_connected()` first
     -+attempts a fast path based on promisor packfiles.  If it falls
     -+back to the `rev-list` check, `--exclude-promisor-objects` is
     -+added so that the traversal does not trigger on-demand fetches.
     ++When promisor remotes are configured, a fast path based on
     ++promisor packfiles is attempted first.  If it falls back to
     ++the `rev-list` check, `--exclude-promisor-objects` is added so
     ++that the traversal does not trigger on-demand fetches.
      +
      +Consider the following graph after a fetch, where all reference
      +tips point directly to commits.  For simplicity, only local
     @@ Documentation/technical/connectivity-check.adoc (new)
      +B1 is an ancestor of B2, which happens when incoming branches
      +fork at different depths in the existing history.
      +
     -+The check proceeds in three phases:
     ++The `--not --all` arguments establish the trust boundary: the
     ++incoming set is the commits reachable from the new tips but not
     ++from any existing reference.
      +
     -+1. Walk from the incoming tips (T1, T2) against the trusted
     -+   refs (L1, L2) to find the incoming set ({N1, N2, N3, T1, T2}).
     -+
     -+2. Walk the trees of the boundary commits (B1, B2) and mark
     -+   those objects uninteresting.  These trees are already trusted
     -+   because their commits are on the already-connected side.
     -+
     -+3. Walk the trees of each incoming commit and verify that every
     -+   referenced object is connected, stopping at objects already
     -+   marked uninteresting in phase 2.
     ++The traversal then walks the trees of the boundary commits and
     ++marks those objects uninteresting.  Trees of incoming commits
     ++are verified against these marks, stopping at objects already
     ++covered.  The cost of marking boundary trees uninteresting
     ++dominates when the boundary commits have large trees, even when
     ++the incoming changes are small.
      +
      +Deepening fetches
      +~~~~~~~~~~~~~~~~~
     @@ Documentation/technical/connectivity-check.adoc (new)
      +
      +When a new reference points to a non-commit object, such as a
      +tag, tree, or blob, that object is not part of the commit walk.
     -+These non-commit tips are handled by the subsequent object
     -+traversal.
     ++These non-commit tips are verified during the tree and blob
     ++traversal that follows the commit walk within the same rev-list
     ++invocation.
 -:  ---------- > 2:  211794c925 p5413: add perf tests for connectivity check
 -:  ---------- > 3:  cdf28f1df6 connected: add transfer.connectivityCheck config and rev-list flag
 2:  6ad528f4bb ! 4:  efaada0b6a connected: add incremental connectivity check via rev-list
     @@ Commit message
          existing-reference boundary, and traversal instead follows the
          effective shallow boundary.
      
     -    p5412 results (median of 3), scaling one dimension at a time.
     +    p5413 results (median of 3), scaling one dimension at a time.
          Each fixture is a repository with a flat tree of many
          directories containing 100 files each.  The incoming set is a
          chain of commits on top of the existing history, with each
     @@ Commit message
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     - ## Documentation/config/transfer.adoc ##
     -@@
     -+transfer.connectivityCheck::
     -+	Choose which algorithm to use for the connectivity check
     -+	performed during object transfer operations such as
     -+	linkgit:git-fetch[1] and linkgit:git-receive-pack[1].
     -+	The connectivity check verifies that all objects reachable
     -+	from the incoming tips are available locally or, in a partial
     -+	clone, promised by a promisor remote.
     -+	The variants are as follows:
     -++
     -+--
     -+`full` (default);;
     -+	Walk the full object closure of the boundary commits.
     -+`incremental`;;
     -+	Verify incoming commits by diffing their trees against parent
     -+	trees, recursively descending only into entries that differ.
     -+	The largest benefits occur when incoming commits change a
     -+	small fraction of a large tree closure.
     -+	Falls back to `full` for deepening fetches.
     -+--
     -+
     - transfer.credentialsInUrl::
     - 	A configured URL can contain plaintext credentials in the form
     - 	`<protocol>://<user>:<password>@<domain>/<path>`. You may want
     -
     - ## Documentation/rev-list-options.adoc ##
     -@@ Documentation/rev-list-options.adoc: we cannot get their Object ID though, an error will be raised.
     - 	stronger than `--missing=allow-promisor` because it limits the
     - 	traversal, rather than just silencing errors about missing
     - 	objects.
     -+
     -+`--verify-trees-incremental`::
     -+	(For internal use only.)  Verify tree connectivity
     -+	incrementally by comparing each commit's tree against its
     -+	parent trees.  Used by `check_connected()` when
     -+	`transfer.connectivityCheck` is set to `incremental`.
     - endif::git-rev-list[]
     - 
     - `--no-walk[=(sorted|unsorted)]`::
     -
       ## Documentation/technical/connectivity-check.adoc ##
     -@@ Documentation/technical/connectivity-check.adoc: When a new reference points to a non-commit object, such as a
     - tag, tree, or blob, that object is not part of the commit walk.
     - These non-commit tips are handled by the subsequent object
     - traversal.
     +@@ Documentation/technical/connectivity-check.adoc: tag, tree, or blob, that object is not part of the commit walk.
     + These non-commit tips are verified during the tree and blob
     + traversal that follows the commit walk within the same rev-list
     + invocation.
      +
      +Incremental connectivity check
      +------------------------------
     @@ Documentation/technical/connectivity-check.adoc: When a new reference points to
      +`transfer.connectivityCheck=incremental`, avoids traversing the
      +full tree walk of the boundary commits.  Instead, it verifies
      +each incoming commit's tree against the already-trusted trees of
     -+its parents.
     ++its parent commits.
     ++
     ++The same `--not --all` boundary as the full check identifies the
     ++incoming commits.  The incremental mode reuses this boundary but
     ++replaces what happens afterwards: rather than walking boundary
     ++trees to mark objects uninteresting, it compares each incoming
     ++commit's tree against its parents' trees, processing commits in
     ++topological order (ancestors first).
      +
      +Trust model
      +~~~~~~~~~~~
      +
      +A tree is trusted when its transitive object closure is known to
     -+be connected.  Trees reachable from commits on the
     -+already-connected side of the boundary are therefore trusted.
     ++be connected.
      +
     -+Incoming commits are processed with ancestors before descendants.
     -+Once an incoming commit's tree has been verified, it is trusted
     -+and can be used as a comparison base for later descendants.
     ++Every parent of an incoming commit is either on the
     ++already-connected side of the `--not --all` boundary (a boundary
     ++parent whose tree is trusted by definition) or is an earlier
     ++incoming commit that was already verified due to the topological
     ++processing order.  In both cases the parent's tree is trusted, so
     ++all parent trees can be unconditionally used as comparison bases.
      +
     -+This gives an inductive correctness argument: every parent of the
     -+commit currently being verified is either already connected or is
     -+an earlier incoming commit whose tree has already been verified.
     ++Once an incoming commit's tree has been verified, it is trusted
     ++and can serve as a comparison base for later descendants.  This
     ++gives an inductive correctness argument: the base case is the
     ++trust boundary established by `--not --all`, and the inductive
     ++step is that verifying a commit extends the trusted set.
      +
      +Tree states
      +~~~~~~~~~~~
     @@ Documentation/technical/connectivity-check.adoc: When a new reference points to
      +during recursive descent.  If no comparison base is available,
      +the new subtree is verified from scratch.
      +
     -+Worked example
     -+~~~~~~~~~~~~~~
     ++Example
     ++~~~~~~~
      +
      +Consider a commit that changes one file under `lib/` and moves an
      +unchanged subtree from `src/` to `dev/`:
     @@ builtin/rev-list.c: int cmd_rev_list(int argc,
       	int ret = 0;
       
      @@ builtin/rev-list.c: int cmd_rev_list(int argc,
     - 		if (!strcmp(arg, "--exclude-promisor-objects")) {
       			repo->fetch_if_missing = 0;
       			revs.exclude_promisor_objects = 1;
     -+		} else if (!strcmp(arg, "--verify-trees-incremental")) {
     + 		} else if (!strcmp(arg, "--verify-trees-incremental")) {
      +			verify_trees_incremental = 1;
     -+			repo->fetch_if_missing = 0;
     + 			repo->fetch_if_missing = 0;
       		} else if (skip_prefix(arg, "--missing=", &arg)) {
       			parse_missing_action_value(repo, arg);
     - 		} else if (!strcmp(arg, "-z")) {
     -@@ builtin/rev-list.c: int cmd_rev_list(int argc,
     - 
     - 		if (!strcmp(arg, "--exclude-promisor-objects"))
     - 			continue; /* already handled above */
     -+		if (!strcmp(arg, "--verify-trees-incremental"))
     -+			continue; /* already handled above */
     - 		if (skip_prefix(arg, "--missing=", &arg))
     - 			continue; /* already handled above */
     - 
      @@ builtin/rev-list.c: int cmd_rev_list(int argc,
       
       	prepare_maximal_independent(&revs);
     @@ builtin/rev-list.c: int cmd_rev_list(int argc,
       		mark_edges_uninteresting(&revs, show_edge, 0);
       
      
     - ## connected.c ##
     -@@
     - #define USE_THE_REPOSITORY_VARIABLE
     - 
     - #include "git-compat-util.h"
     -+#include "config.h"
     - #include "gettext.h"
     - #include "hex.h"
     - #include "odb.h"
     -@@ connected.c: static int check_connected_promisor(oid_iterate_fn fn,
     - 	return 1;
     - }
     - 
     -+static int incremental_check_applicable(struct check_connected_options *opt)
     -+{
     -+	const char *algorithm = NULL;
     -+
     -+	if (repo_config_get_string_tmp(the_repository,
     -+				       "transfer.connectivitycheck",
     -+				       &algorithm))
     -+		return 0;
     -+	if (!strcasecmp(algorithm, "full"))
     -+		return 0;
     -+	if (strcasecmp(algorithm, "incremental"))
     -+		die(_("unknown transfer.connectivityCheck algorithm '%s'"),
     -+		    algorithm);
     -+
     -+	if (opt->is_deepening_fetch)
     -+		return 0;
     -+
     -+	return 1;
     -+}
     -+
     - /*
     -  * If we feed all the commits we want to verify to this command
     -  *
     -@@ connected.c: int check_connected(oid_iterate_fn fn, void *cb_data,
     - 	if (opt->progress)
     - 		strvec_pushf(&rev_list.args, "--progress=%s",
     - 			     _("Checking connectivity"));
     -+	if (incremental_check_applicable(opt))
     -+		strvec_push(&rev_list.args,
     -+			    "--verify-trees-incremental");
     - 
     - 	rev_list.git_cmd = 1;
     - 	if (opt->env)
     -
       ## meson.build ##
      @@ meson.build: libgit_sources = [
         'transport-helper.c',
     @@ meson.build: libgit_sources = [
      
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
     -   't5409-colorize-remote-messages.sh',
         't5410-receive-pack.sh',
         't5411-proc-receive-hook.sh',
     -+  't5412-connectivity-check.sh',
     +   't5412-receive-report-hook.sh',
     ++  't5413-connectivity-check.sh',
         't5500-fetch-pack.sh',
         't5501-fetch-push-alternates.sh',
         't5502-quickfetch.sh',
      
     - ## t/perf/generate-repo-p5412-connectivity-check.perl (new) ##
     + ## t/perf/p5413-connectivity-check.sh ##
      @@
     -+#!/usr/bin/perl
     -+#
     -+# Generate a fast-import stream for p5412 connectivity check benchmarks.
     -+#
     -+# Usage: generate-repo-p5412-connectivity-check.perl
     -+#            <dirs> <files_per_dir> <commits> [<hot_dirs>] [<files_per_commit>]
     -+#
     -+# Creates one initial commit with dirs*files_per_dir files, then
     -+# <commits> additional commits each modifying <files_per_commit>
     -+# files in directories chosen round-robin from 1..<hot_dirs>.
     -+
     -+use strict;
     -+use warnings;
     -+
     -+my ($nd, $nf, $nc, $hot, $fpc) = @ARGV;
     -+$hot = $nd if !$hot || $hot > $nd;
     -+$fpc = 1   if !$fpc;
     -+
     -+sub data {
     -+	printf "data %d\n%s\n", length($_[0]), $_[0];
     -+}
     -+
     -+# Initial tree: one commit with nd*nf files.
     -+printf "commit refs/heads/main\n";
     -+printf "committer perf <perf\@test.com> now\n";
     -+data("initial");
     -+for my $d (1..$nd) {
     -+	for my $f (1..$nf) {
     -+		printf "M 100644 inline d-%04d/f-%03d\n", $d, $f;
     -+		data(sprintf "%03d%03d", $d, $f);
     -+	}
     -+}
     -+
     -+# Subsequent commits (auto-chained by fast-import).
     -+for my $i (1..$nc) {
     -+	printf "commit refs/heads/main\n";
     -+	printf "committer perf <perf\@test.com> now\n";
     -+	data(sprintf "change-%03d", $i);
     -+	for my $j (0..$fpc-1) {
     -+		my $d = (($i + $j) % $hot) + 1;
     -+		printf "M 100644 inline d-%04d/f-001\n", $d;
     -+		data(sprintf "c%d-%d", $i, $j);
     -+	}
     -+}
     -
     - ## t/perf/p5412-connectivity-check.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     + #!/bin/sh
     + 
     +-test_description='performance of connectivity check
      +test_description='performance of connectivity check modes
     -+
     + 
     +-Benchmark the rev-list connectivity check, avoiding pack transfer
     +-noise.
      +Compare the default and incremental rev-list connectivity modes
      +directly, avoiding pack transfer noise.
     -+
     -+Each repository has a flat tree of many directories with 100 files
     -+in each.  Three axes are scaled independently: tree size, commit
     -+count, and files changed per commit.'
     -+
     -+. ./perf-lib.sh
     -+
     -+test_perf_fresh_repo
     -+
     -+generate="$TEST_DIRECTORY/perf/generate-repo-p5412-connectivity-check.perl"
     -+
     -+# $1=dirs  $2=files_per_dir  $3=commits  $4=hot_dirs (optional, default=all)
     -+# $5=files_per_commit (optional, default=1)
     -+test_perf_conn () {
     -+	local nd="$1" nf="$2" nc="$3" hot="${4:-$1}" fpc="${5:-1}"
     -+	local total=$(($nd * $nf))
     -+	local name="repo-${nd}d-${nf}f-${nc}c-${hot}h-${fpc}fpc"
     -+	local label="${total} files, ${nc} commits"
     -+	if test "$hot" -lt "$nd"
     -+	then
     -+		label="$label (${hot} hot dirs)"
     -+	fi
     -+	if test "$fpc" -gt 1
     -+	then
     -+		label="$label (${fpc} files/commit)"
     -+	fi
     -+
     -+	test_expect_success "setup $label" '
     -+		if test -d '"$name"'
     -+		then
     -+			true
     -+		else
     -+			git init '"$name"' &&
     -+			"$PERL_PATH" '"$generate"' '"$nd"' '"$nf"' '"$nc"' '"$hot"' '"$fpc"' |
     -+			git -C '"$name"' fast-import --date-format=now --quiet &&
     -+			(
     -+				cd '"$name"' &&
     -+				git rev-parse main~'"$nc"' >../'"${name}"'_old &&
     -+				git rev-parse main >../'"${name}"'_new &&
     -+				git update-ref refs/heads/main \
     -+					$(cat ../'"${name}"'_old) &&
     -+				git repack -ad &&
     -+				git config gc.auto 0
     -+			)
     -+		fi
     -+	'
     -+
     + 
     + Each repository has a flat tree of many directories with 100 files
     + in each.  Three axes are scaled independently: tree size, commit
     +@@ t/perf/p5413-connectivity-check.sh: test_perf_conn () {
     + 		fi
     + 	'
     + 
     +-	test_perf "$label" '
      +	test_perf "$label (full)" '
     -+		cat '"${name}"'_new |
     -+		git -C '"$name"' rev-list \
     -+			--objects --stdin --not --all --quiet \
     -+			--exclude-promisor-objects
     -+	'
     + 		cat '"${name}"'_new |
     + 		git -C '"$name"' rev-list \
     + 			--objects --stdin --not --all --quiet \
     + 			--exclude-promisor-objects
     + 	'
      +
      +	test_perf "$label (incremental)" '
      +		cat '"${name}"'_new |
     @@ t/perf/p5412-connectivity-check.sh (new)
      +			--objects --stdin --not --all --quiet \
      +			--exclude-promisor-objects
      +	'
     -+}
     -+
     -+# Scaling tree size (10 commits, 10 files/commit).
     -+test_perf_conn   50 100 10   50 10
     -+test_perf_conn  500 100 10  500 10
     -+test_perf_conn 2000 100 10 2000 10
     -+test_perf_conn 8000 100 10 8000 10
     -+
     -+# Scaling commit count (200K files, 10 files/commit).
     -+test_perf_conn 2000 100    1 2000 10
     -+test_perf_conn 2000 100   10 2000 10
     -+test_perf_conn 2000 100  100 2000 10
     -+test_perf_conn 2000 100   500 2000 10
     -+test_perf_conn 2000 100  3000 2000 10
     -+test_perf_conn 2000 100  5000 2000 10
     -+test_perf_conn 2000 100 10000 2000 10
     -+
     -+# Scaling files per commit (200K files, 10 commits).
     -+test_perf_conn 2000 100 10 2000   1
     -+test_perf_conn 2000 100 10 2000  10
     -+test_perf_conn 2000 100 10 2000  100
     -+test_perf_conn 2000 100 10 2000  500
     -+test_perf_conn 2000 100 10 2000 1000
     -+test_perf_conn 2000 100 10 2000 2000
     -+
     -+test_done
     + }
     + 
     + # Scaling tree size (10 commits, 10 files/commit).
      
     - ## t/t5412-connectivity-check.sh (new) ##
     + ## t/t5413-connectivity-check.sh (new) ##
      @@
      +#!/bin/sh
      +
     @@ tree-verify.c (new)
      +			       struct verify_state *vs)
      +{
      +	struct oid_array base_trees = OID_ARRAY_INIT;
     ++	const struct object_id *tree_oid;
      +	struct commit_list *p;
      +
      +	/*
     @@ tree-verify.c (new)
      +	 * first due to the topological processing order.
      +	 */
      +	for (p = commit->parents; p; p = p->next) {
     -+		const struct object_id *tree_oid;
      +		parse_commit_or_die(p->item);
      +		tree_oid = get_commit_tree_oid(p->item);
      +		if (!tree_oid)
     @@ tree-verify.c (new)
      +		oid_array_append(&base_trees, tree_oid);
      +	}
      +
     -+	if (!get_commit_tree_oid(commit))
     ++	tree_oid = get_commit_tree_oid(commit);
     ++	if (!tree_oid)
      +		die(_("unable to load root tree for commit %s"),
      +		    oid_to_hex(&commit->object.oid));
     -+	verify_tree(repo, get_commit_tree_oid(commit),
     -+		    &base_trees, vs, 0);
     ++	verify_tree(repo, tree_oid, &base_trees, vs, 0);
      +	oid_array_clear(&base_trees);
      +}
      +

-- 
gitgitgadget
