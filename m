Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84BE30D3FA
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479291; cv=none; b=uKNsh5YfCg/aqBoA8rIqRJsTeIp4G9kg6hsx/B+KCSaHxa+qfv5TXyx1dQc2oAAi8pitbzBB5oFnqj7w6yyqJJ4puo+f8AfU0M8lf3+wDgtg7tqb7slAH+vvqow3wrIfSfJMLv2DGYeVl4o97HsCAA76sjQBF6E+ibh2dUf5tjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479291; c=relaxed/simple;
	bh=dR63eSWee6QM6AFxDKc9EsotT7DOCJIbKaNFdhJAG6g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OV6EdLQTlM059arMIdLNuS7AXaxh7xprnW01mfr8IS5LhRSRYAg6cceE3HNTHWVnFESbZacgeCihmxRbm2aWiVWc4dw4/dvV790pMqRPBdTb0Jy/xRjzHvUHqEhzgV7x282iHQnVgu/gEYL1o+21AMXSQWiVbA28yViSxW/30AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCIynOrO; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCIynOrO"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-662dc387b7aso1144133d50.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 06:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782479289; x=1783084089; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVAkuNSa6NuBhbVHLflA5aobrLeeRfR8LBud2P0XpuQ=;
        b=WCIynOrODCE6Pgrp2zOiK4Xv3vaLk1mUFVRxD17yk/AzhjxLu+nKdCoU1MhMes0AqU
         jAKL2Cy3N2YZAsB1MX2J9mkHhSN8RVfIavU096d9BV697rWk85r4aWqAxJ/xj5PlAzyG
         QofBrfdv4yq86Q6izYmtVTj0ruLnmC+MaG/acxKSqKaYVLYh3Cg0UbZ6ofclkIfSe0eV
         7LYai8+BubxBcFlKyp6ZMvF2KAJwSeCDFQ8z0bWZXqBUHYMrZ4nGDn9MvCNQGUqDmHHc
         kWJAkDQfSHpGiBnDro7G0aaffthydC5pqWVM2sA44YCQdFFqMlE6FfEHOWu5XkV0VNo0
         4jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479289; x=1783084089;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iVAkuNSa6NuBhbVHLflA5aobrLeeRfR8LBud2P0XpuQ=;
        b=SMjdwJ6epqN7Fr0HNZINo7tpZ7vc4sDdgxXpiLQiYp3x3AC6+wfXZoEIbj2WS2ndZq
         urqPCKsbPuwE6/awWhSUL98M6UKNgvXr3gBYhfHbZnD+++N8Cd7FxHF+S/YeiQmfI8fr
         d7M6m2zqCKNJIGS0KA/Dyo71Kuz6g4YqDozlmKEKGGHyc6qj44405tH5whNjNaiz+FTy
         AZmEPoo/Un0j2Q6oS0QUlokKZWpHGD7GRenNWcaH9CYDSQgnQmxCxyPNkGmeGBOPQjHf
         YOOWyS7RKNPryl+hvsw1AUf5aWpEgLUF+1wt6FWPfTGOWI4+GcDkmT7OYty31asCMzjT
         EoHw==
X-Gm-Message-State: AOJu0Ywb1WskGk8sR6OHrRzBzKmib94qTc0g3WRGtzEP1JyQSR5NntOK
	OG1iqVQDsoDhcJRb8H+HWHIo4wBRN7Nd2dPDrFkLwa/3PYbrzBT9x41FsnSJTQ==
X-Gm-Gg: AfdE7cn/W3Az44N7dRJx7MEX/srKrChBEa0YudqfpdaUMvcQziJv3p+hQpd+k2nOdD/
	ZxrIj0f9+YhRHe3SLPKnxZN1UNQkVoyl46T7bIR2X3NtzAzMwfLW7mpE8U46F1VkFOgka/031RA
	0WzeyTUQIMPfkTsQmU6SNnliLq3n4u2toF2F3bp1JbOxsyorZpn3l+Tuq/myWJD80YIDqA3RXDA
	Jy9Wo+JMx279RF06GXGg8wwHY+oXEs2xWFbnpHmhT/uaxYS4vycpk6UovEvKu6yYxK8qKStERdN
	C+s+bM7jxvDbMisI/kn1ElnnoAPTP34CBKHsIhCin8pHub5NiQ4GQnIgKHdRZ8lqbvrTiDSUyoK
	wofOESBg4kwvjQiKSkFY0DjVFoTqP8mRlP52b2Crm9rhYMoRtmtm2LdfcZdsEpvWYXzPUxfQS+r
	qxCZORFmQxUAEauQ==
X-Received: by 2002:a05:690e:134d:b0:65e:41a4:54c8 with SMTP id 956f58d0204a3-66487f07497mr5656570d50.56.1782479288703;
        Fri, 26 Jun 2026 06:08:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.47.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f5ff5e6sm210539876d6.12.2026.06.26.06.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:08:08 -0700 (PDT)
Message-Id: <2593866bce5d359f204c68925a94e14e9a807e1e.1782479286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
	<pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jun 2026 13:07:58 +0000
Subject: [PATCH v3 1/8] Documentation/technical: add paint-down-to-common doc
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
algorithm used for merge-base computation, covering the paint
walk, generation number regions, and termination conditions.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/paint-down-to-common.adoc       | 114 ++++++++++++++++++
 commit-reach.c                                |   6 +-
 4 files changed, 121 insertions(+), 1 deletion(-)
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
index 0000000000..c10d5d2887
--- /dev/null
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -0,0 +1,114 @@
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
+The walk uses a `nonstale_queue` wrapper around `prio_queue` that
+tracks `max_nonstale`: the lowest-priority non-stale commit enqueued
+so far. Once that commit is dequeued, every remaining entry is known
+to be STALE and the loop terminates. Specifically, the main loop
+ends when one of the following conditions holds:
+
+  1. The queue is empty.
+  2. `max_nonstale` has been dequeued, meaning the queue only contains
+     STALE entries.
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

