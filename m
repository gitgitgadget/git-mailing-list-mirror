Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F0327BFB
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781951836; cv=none; b=nbX0TjEbg3b4MD586sz7oTewNEZbFnCxeO6dWpKPFwRI/YUkMMNVOeZMajVfeacJfjf3vMa7ADAL8J/XFF2rlMRIIVZHZ9s5jvybwoGLcf2x4LPRzef7ce7Onfhh5lM+sFO0WZBP54zpJkP5tF4j9JnVrnCanAJEt1DjsPFweKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781951836; c=relaxed/simple;
	bh=A6kWwKrX0anzDXnVbPtQdwnWrbYlbg5Uu4fzOf1bxzI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jAIn7tQ2moPGZNcv4t9zev9gEVhiXt4mMFyddHTBXcvkGzWvfpKYW5llj3T78kh1S+kltYJ+7jvWTlSYhTe5DV132EEqx+WRdWQnbxUmyGbCSjW9MKLQY1mNmM66+bepGaJlYnG9MTQfi1NEP8TYmZRRtEj6i7vMjT/BxIvozm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3Ygx9YV; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3Ygx9YV"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-137eb0d76beso2771083c88.0
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781951834; x=1782556634; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9JtSgidC4YEAg0R9qF/k9XSaNX3tA0y6IjqMZXv+i8=;
        b=N3Ygx9YVfDjJccpwZ2Z12plaFhPLfSqUU3H9VCTXg7as5rGcVt6wQ4ZQb6CJjMPd0n
         gflt95OQkUpgbGFhYOB2F1YhqUUN4fFXyV9JmX7TQuKNei/HgSqq9ZjBNp6eeAbHUkUy
         tvsskpyIZVjRqoKiPvst6j/BKNAZ8Xr1wiSI/l+kwdxsSuK2mrIhpPEZ5r4wO2pbWBBo
         4Rf8tRC4mKOptSmbMjoM1JKnxKumjgLmz+1iFnVhRMfQmiEeE6gtR30Hb9b0zP2s3zM4
         mfyNGM1nV82YZbZNAyXBfwixmER6sMcKDhSTDWcvHzVKooaXoORo8Gh9qc0jDKjbOfm1
         wJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781951834; x=1782556634;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z9JtSgidC4YEAg0R9qF/k9XSaNX3tA0y6IjqMZXv+i8=;
        b=lcO/F3bnkxGDT0QHX7TLJN60P6AzY8odYMizPXWIWz63TXRDdVMOShLxyNq+R6D1Yq
         a4dMCV/SWiR0op9i0qHPkq3eKxXkHXw33aHndM3MzUzFumiFQKMJVTeAv3rSB7HsAz3Y
         WbpXzTxSqrdF1ehz3DMox105O+XKnCXiFRziWGN50TA9oCUbKmSYfFdRlojmj3efhgzm
         UUsCkIjHFAUOB3/f61vOcx8pN9JteVm0o/G0fxetlhHZGS9lxAHOgjTH8GnMAXrup4AU
         ReJFTFCDtrDVTRieEgw3jpmu8Q1HtiGU2gO4oPxQakOcfLHLVx8fRrKjDZLFBoX03hu9
         woUQ==
X-Gm-Message-State: AOJu0Yz3rUaXSemmJPNyI4L+9zza+zIsQUWMt2MWBdIbKjKG7Xz98Iht
	kvCZLqdbRnCk1mpou1Lz53TLL8+LZSqhXwIu9vWEJq2wipkgT2GDJ4D41TJmOVWv
X-Gm-Gg: AfdE7clNGwyiWLvJlF18id1OzBSXXV2QYGrgHla2IYV0FTODO1tvsJJNQncg+5WAtJH
	jDMAg4IxUGnffU1XfTlXtfk28lpntDnHmHMsBWNzr2AubDd1H8h1ZKmRryl5BF/1491MljssTGa
	jkE/NapXdht1zygMyyNJEm6k6AFAUT4cZVqTFPK1LHvrKfzOuFg7+XLfN+QQwCZkCDFptZcYRLS
	C1mY+X49GGb70wCZzkEdQl6nm2BWFOUwrCx8zUFKaYiauJtErksmOoVS5nNlYaMJNfFfbIt9epi
	tXGHKuT0mKtSwa9GqItS3yn6Cxas30nnZAtsWcrBZAulyvKLN+egANNGL5YLHXErqEhCSN4RaAF
	vpwsUgp2QwIxbxeeDgGXhLeBiRenITOSYVwQnPpsOe+1Jzr07p7blh8JYnCu3aay2R5dhzU+2p+
	NvmIxeCf+RJL2BZ0On
X-Received: by 2002:a05:7022:c85:b0:128:d396:f2ea with SMTP id a92af1059eb24-139a30731e9mr2464037c88.11.1781951834066;
        Sat, 20 Jun 2026 03:37:14 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.54.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be5c5desm3342207eec.28.2026.06.20.03.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 03:37:13 -0700 (PDT)
Message-Id: <9cbfc67d724d91b9abc3621f03a3c97208c76a70.1781951820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jun 2026 10:36:59 +0000
Subject: [PATCH/RFC 6/6] Documentation/technical: add paint-down-to-common doc
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add a technical document describing the paint_down_to_common()
algorithm used for merge-base computation.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/paint-down-to-common.adoc       | 130 ++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 Documentation/technical/paint-down-to-common.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2699f0b24a..f8dea4b395 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -129,6 +129,7 @@ TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
 TECH_DOCS += technical/packfile-uri
 TECH_DOCS += technical/pack-heuristics
+TECH_DOCS += technical/paint-down-to-common
 TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
 TECH_DOCS += technical/platform-support
diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
index ec07088c57..9ce11d5e48 100644
--- a/Documentation/technical/meson.build
+++ b/Documentation/technical/meson.build
@@ -18,6 +18,7 @@ articles = [
   'multi-pack-index.adoc',
   'packfile-uri.adoc',
   'pack-heuristics.adoc',
+  'paint-down-to-common.adoc',
   'parallel-checkout.adoc',
   'partial-clone.adoc',
   'platform-support.adoc',
diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
new file mode 100644
index 0000000000..e677cce84d
--- /dev/null
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -0,0 +1,130 @@
+Merge-Base Computation and paint_down_to_common()
+==================================================
+
+The function `paint_down_to_common()` in `commit-reach.c` computes merge
+bases by walking the commit graph backwards from two sets of tips and
+finding where their ancestry meets.
+
+Use cases
+---------
+
+Computing merge bases is used in two different ways:
+
+ 1. *Finding all merge bases* (`merge-base --all`, `merge-tree`,
+    `merge`, `rebase`). A merge base is a common ancestor that is
+    not itself an ancestor of another common ancestor.
+
+ 2. *Ancestry checks* (`in_merge_bases`, used by `merge-base
+    --is-ancestor`, `branch -d`, `fetch`). These ask: "is commit A
+    an ancestor of commit B?" If a common ancestor equals one of the
+    inputs, that input is necessarily the only merge base -- no other
+    common ancestor can be both as recent and not an ancestor of it.
+
+Both use cases share the same algorithm and implementation.
+
+Algorithm
+---------
+
+Given a commit `one` and a set of commits `twos[]`, the walk paints
+commits with two colors:
+
+  - PARENT1: reachable from `one`
+  - PARENT2: reachable from any commit in `twos[]`
+
+The walk uses a priority queue ordered by generation number (falling
+back to commit date when generation numbers are unavailable). Each
+step dequeues the highest-priority commit (this is when we say a
+commit is "visited") and propagates its paint flags to its parents,
+enqueuing them if they gained new flags. When a commit receives
+both PARENT1 and PARENT2, it is a merge-base candidate. A candidate
+gains the STALE flag so its ancestors propagate staleness -- any
+deeper common ancestor is necessarily redundant.
+
+INFINITY and finite generation regions
+--------------------------------------
+
+The commit-graph stores a generation number for each commit. Commits
+not in the commit-graph have generation `GENERATION_NUMBER_INFINITY`. The
+graph is closed under reachability: if a commit is in the graph, all
+its ancestors are too. This partitions the commit graph into two regions:
+
+....
+    +---------------------------------------+
+    |          INFINITY region              |
+    |  generation = INFINITY                |
+    |  queue order: heuristic (commit date) |
+    +---------------------------------------+
+                    |
+                    v
+    +---------------------------------------+
+    |          Finite region                |
+    |  generation = finite                  |
+    |  queue order: topological             |
+    +---------------------------------------+
+....
+
+When the commit-graph is enabled, the INFINITY region is typically
+very small -- it only contains commits added since the last
+commit-graph refresh.
+
+All reachable INFINITY-generation commits are visited before any
+finite-generation commit, because INFINITY is larger than any finite
+value. Once the walk crosses into the finite region, it stays there.
+
+In the finite region, generation ordering guarantees topological
+traversal: children are always visited before their parents. This
+means that paint on already-visited commits is final -- no future
+traversal step can add paint to them.
+
+In the INFINITY region, commit-date ordering can violate this: a
+parent with a later date can be visited before a child with an earlier
+date. Paint flags are therefore NOT final at visit time, and a
+commit visited with only one side's paint may later gain the other.
+
+Paint flags are only added, never removed. Since each flag can be set
+at most once per commit, the number of times a commit can be
+re-enqueued is bounded by the number of flag transitions.
+
+Termination
+-----------
+
+Termination happens when we can prove that no extra progress is
+possible. We are done with the main loop when one of the following
+conditions holds:
+
+  1. The queue is empty.
+  2. The queue only contains STALE entries.
+  3. Side-exhaustion: the walk has reached the finite region and one
+     of the sides is fully exhausted.
+
+The loop waits for all pending merge-base candidates to be popped
+and recorded before any early exit fires, so no separate drain phase
+is needed after termination.
+
+Stale entry condition
+~~~~~~~~~~~~~~~~~~~~~
+If all entries are stale we cannot find any new merge bases since
+that requires at least one enqueued side node meeting the other side.
+However, we could still invalidate merge bases (if there are more
+than one). This is unnecessary since `remove_redundant()` will clean
+that up as a post-process step.
+
+Side-exhaustion
+~~~~~~~~~~~~~~~
+A commit is *exclusive* to one side if it carries that side's paint
+but not the other (e.g. PARENT1 without PARENT2).
+
+If we have reached the finite region of the graph, no future
+traversal step can add paint to an already-visited commit. Thus if
+there are no exclusive PARENT2 commits in the queue, no additional
+PARENT2 paint can be introduced into the walk. Even if exclusive
+PARENT1 commits remain, no new merge-base candidates can be
+discovered. The same holds symmetrically for PARENT1.
+
+This invariant is only valid in the finite region of the graph.
+
+Related documentation
+---------------------
+
+  - `Documentation/technical/commit-graph.adoc` -- generation numbers
+    and the reachability closure property.
-- 
gitgitgadget
