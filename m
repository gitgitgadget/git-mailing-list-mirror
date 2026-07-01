Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7E1FC110
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923838; cv=none; b=iqPEKxgoh/rzGEo9UapjGEBv0CqEFZ/y5SqysMhx9bL2ypTE7U3PiKLKscGjkfrBMVLE0+9KDmb08jTAoVEE3G5KroV2ntPn23A2rIJfvH+qlG+lAQTZlHNh/VHc8cdiMgUdsj47E/mJ1UPidQOTCDxlRX+C8YIuk/aszmljOX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923838; c=relaxed/simple;
	bh=0N64zid334U2w7OjMaEA0o5z8RWvIi0Tccp2DkRGocE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E5KGj2KNvyKZf98p+4J03xWOqM2rjEw08QjP4cToh6oy8GFX8up4/H3kquvkMXPFtHHmle8NZ5yzbJpmFaLpyw3NxVBG2g2+ckMC5qh0SNcxpMUtlaCWQuNrBopsfSUNTzy6R32zGp8hnt99eThHTZmoRMkgUEuYOudqGTBPvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rsqj3dET; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rsqj3dET"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c9f10fa7a3so7650395ad.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923836; x=1783528636; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=109eqHLNsacWA6brIlJmW/TIus5Lwxevei4CFhmWFG4=;
        b=Rsqj3dET+sRO8GRhTqoRf/MOA1G4EBDuFTTNG+/fIrZhxL60VOXWPNLmO0aovShBJw
         zAglFzUcTKU1Jwk83RYr2OJMk//0t1RuOTZHfTranOTwjcDixdES8gWmxwH8bCV5U2U5
         vIZQdLoMRBsNlgCDaxKpjq4MxWvz+AHNdrrJmzqzlwxf5vRG1+S7p3ZDgwd3lLz/ySg+
         dTuLqnQQOxIPn9s2JJbKoKXJGtNU8GF74767C/CFeU5IA1dYnZB6r8G578qLiOVp7+W/
         qxzXfDV+nvCVom2BU9aCqnt7vjGF8MSdySVvbLzEspPB2gfLBWqTvdibSTWKzllQEsaz
         N4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923836; x=1783528636;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=109eqHLNsacWA6brIlJmW/TIus5Lwxevei4CFhmWFG4=;
        b=Ue/uLXLsp5DKeh7sLaFJHOGPFP14ZIgnGDqQ72ANQaSAxeTyEFV3AwvFxhjW65L3x8
         4rV8TuQH94Tp6KCQzt/6LfzLOIAYMiCsOyPeIJZmXJwqqaI+wXwLZ/hdeaSmSrI7LzCn
         frhfopHYi4dNuS/JRuKxs4VFJ6K8jYdpJYuf9Aydecm8g3nvvRtPuq0nI4V36FUXxszy
         qeF8TXB7ycp8A1jBPm8whsE0R6a1NzPD29tMXwUzvbDMpIUuBVG00007XkueGI/TjUUx
         1B89QXezYyMUnwwJaYiZ/h3Tz14Qsf9Vnu5tYLF2x80+/zeTHgJTKE9C8UfXTiC1/YDc
         AlNw==
X-Gm-Message-State: AOJu0YzGbegNW/S7GJ/ITiM1KVJdwsK8Dddryp4SIjt4qmlVHH2+ivlA
	2PUEobNWxbEFdAipZY0g0Zd/YfvH0B5EuyYq7SQQSdxQ8j0FWOCo79lpU+cLkA==
X-Gm-Gg: AfdE7cnlETBf6spCesinAqg35JS6x572sC/nKSO/GVGzpJiCIKMNQVLK/JDSMzwJTiE
	HZI7/TEpsfu4UmipSGh0Len4qOlRRhWb9s5F37S8WUqaRbwpqtyM0kLBihNIkYgyYx+DbdDdDwL
	GmP4pxRRli+uJVNvs5QZES2P7ynUcIcc9lrk3+QqtGiO/HOUKTtDDanQ48wRMKxvjRxO1qaXtNg
	f/RkD+NNAS80EXSKAq5ZQ3PzSbgSpE4WU/4TiKlbIHyBOjYwPacSOksR4zSvWfjzW28zwSRIoE9
	Y5BMbLTBNk7J5Lh0W3zB8HgeAYCVUW8y5qEmkNngniPjrBEjd9hqfcvpvLwKRj4ntNSImF4Nn+s
	DVzb8m9cVKhsg18jdvDoh8+HgMVUwdwKevSqkWivHaaoLP/GaJG3SW2lpM1kv7FwVZ0hJDoV1dG
	kY7vvvw2zXumUZH2Y=
X-Received: by 2002:a05:6a21:3987:b0:3bf:7f0b:2f6e with SMTP id adf61e73a8af0-3bfed477bc0mr2648178637.46.1782923835775;
        Wed, 01 Jul 2026 09:37:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.198.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb10645sm82096a12.4.2026.07.01.09.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:37:15 -0700 (PDT)
Message-Id: <be00f5aaa163d18a36bfa399346370e03322bbe2.1782923832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
	<pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 16:37:02 +0000
Subject: [PATCH v5 01/10] Documentation/technical: add paint-down-to-common
 doc
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

Add a technical document describing the paint_down_to_common()
algorithm used for merge-base computation, covering the paint
walk, generation number regions, and termination conditions.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/paint-down-to-common.adoc       | 177 ++++++++++++++++++
 commit-reach.c                                |   6 +-
 4 files changed, 184 insertions(+), 1 deletion(-)
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
index 0000000000..ff015c5c8f
--- /dev/null
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -0,0 +1,177 @@
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
+The walk uses a priority queue ordered by generation number
+(highest first), breaking ties by commit date. Each step dequeues
+the highest-priority commit (this is when we say a commit is
+"visited") and propagates its paint flags to its parents, enqueuing
+them if they gained new flags. When a commit receives both PARENT1
+and PARENT2, it is a merge-base candidate. A candidate gains the
+STALE flag so its ancestors propagate staleness -- any deeper common
+ancestor is necessarily redundant.
+
+NOTE: When the commit-graph uses only topological levels (generation
+number v1) and the caller passes `min_generation = 0`, a legacy
+fallback replaces the generation-ordered comparator with a pure
+commit-date comparator. This breaks the ordering invariants
+described below -- see <<date-ordering-fallback>>.
+
+[[generation-regions]]
+INFINITY and finite generation regions
+--------------------------------------
+
+The properties in this section assume generation-number ordering (the
+default comparator). They do NOT hold when the date-ordering fallback
+is active -- see <<date-ordering-fallback>>.
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
+The walk uses a `nonstale_queue` wrapper around `prio_queue` that
+tracks `max_nonstale`: the lowest-priority non-stale commit enqueued
+so far. Once that commit is dequeued, every remaining entry is known
+to be STALE and the loop terminates. Specifically, the main loop
+ends when one of the following conditions holds:
+
+  1. The queue is empty.
+  2. `max_nonstale` has been dequeued, meaning the queue only contains
+     STALE entries.
+  3. Generation cutoff: the dequeued commit's generation is below
+     a caller-supplied `min_generation` threshold.
+  4. Single result: the caller only needs one merge base, one has
+     been found, and the walk has entered the finite-generation
+     region.
+
+Stale entry condition
+~~~~~~~~~~~~~~~~~~~~~
+Once all queued entries are stale, no new merge-base candidates can
+be discovered -- that requires at least one non-stale commit from
+each side meeting. Continuing the walk could still invalidate
+existing candidates by proving one is an ancestor of another, but
+`remove_redundant()` handles that as a post-processing step, so it
+is safe to exit early.
+
+Generation cutoff
+~~~~~~~~~~~~~~~~~
+Some callers (notably `remove_redundant()`) supply a `min_generation`
+threshold -- the minimum generation of the input commits. No merge
+base can have a generation below this threshold, so the walk
+terminates as soon as it dequeues such a commit.
+
+Single result
+~~~~~~~~~~~~~
+When only one merge base is needed, the walk is in the
+finite-generation region, and the queue uses generation ordering,
+the first candidate found is necessarily the highest-generation
+common ancestor. No remaining commit in the queue can be a
+descendant of this candidate (generation ordering guarantees
+children are visited first), so it cannot be redundant and the walk
+can stop immediately.
+
+This optimization is NOT safe when the date-ordering fallback is
+active, because commit-date order can visit a deeper ancestor
+before a shallower one -- see <<date-ordering-fallback>>.
+
+[[date-ordering-fallback]]
+Date-ordering fallback
+----------------------
+
+When `min_generation` is zero and the commit-graph does not contain
+corrected commit dates (generation number v1, which stores only
+topological levels), `paint_down_to_common()` replaces the default
+generation-ordered comparator with `compare_commits_by_commit_date`.
+
+This was introduced as a performance heuristic: topological levels
+are coarser than commit dates, so date ordering can reach merge
+bases in fewer steps when timestamps are well-behaved. However,
+commit dates are not required to be monotonic -- a parent can have
+a later date than its child (clock skew, rebases, etc.) -- so the
+queue may visit commits out of topological order.
+
+This disables optimizations that depend on generation ordering:
+
+  1. *Single result*: the first merge-base candidate found may not
+     be the shallowest, because a deeper ancestor with a higher
+     commit date can be dequeued first.
+
+  2. *Side-exhaustion* (see subsequent commits): one paint side can
+     appear to drain from the queue while commits from that side are
+     still waiting with lower dates, causing premature termination.
+
+Related documentation
+---------------------
+
+  - `Documentation/technical/commit-graph.adoc` -- generation numbers
+    and the reachability closure property.
diff --git a/commit-reach.c b/commit-reach.c
index 5df471a313..a9483759e0 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -96,7 +96,11 @@ static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
 	return commit;
 }
 
-/* all input commits in one and twos[] must have been parsed! */
+/*
+ * See Documentation/technical/paint-down-to-common.adoc
+ *
+ * All input commits in one and twos[] must have been parsed!
+ */
 static int paint_down_to_common(struct repository *r,
 				struct commit *one, int n,
 				struct commit **twos,
-- 
gitgitgadget

