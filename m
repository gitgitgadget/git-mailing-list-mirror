Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2855B30DD2F
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418389; cv=none; b=IDy5DJWrUIm4bcU7eiIs1oIvK3foN0hDUPv2aKupFmXW+g0MC5D2xFxjcdnkIrR+VG7KMJ0iWE3U4kTMu48e2wNTLopfhhzthFx5Qp5gp6G5V6k1nK/hzL/oI34t5Xerhk0SQLukBInPg5+6S/lsDxBoxDY6NTWxhF0//aJqXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418389; c=relaxed/simple;
	bh=Q+lZuWMj/0JJFcOXh8KPcsIiCi26NpmusWBVbuZmA0M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M73IUbbNMgM+MizoCs6Fe0BzqT8WfiknPXdKgaVcBm7bnAaopABHMSuPXCsf7GjzF9FidAYNjoLAieBJh5u5yPCahnFZFPjQZQ4UtCwtqKzWool5O36NQDI+E0gqZuos05nfekV06sA6hCFcWRqS6PqKUU98RywS1R9VRQ5SvC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q84CWvka; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q84CWvka"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso4554218b3a.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783418387; x=1784023187; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxlLOptu4x4oA1uLCylVRCkkwhPmFFwLVIR0PIjoCBo=;
        b=Q84CWvkaCoMG3TyCpyv6NliwtV4gXDhDDbM15kCcUnxV+WUVjFZOBoiZTgng+qV/6M
         jawSLX2UMTiRX5eLsCWFakbqp5F69J2lLX5UrklmpnuVyJ7ltknLGNcze+O/BjfVyZzW
         th+y7rQTwCnOTn7dDRCM7N9oiZCbmvUS8Xjc7gy5aOufU8jTIA9nXs1DABwWjs+98ngD
         tgd3S+Hq6R/MPFJfyMRTmX2iibTyfcVY/3oU+8iVv3QMQN/ihweh25hfRl1fARW0lz46
         yLjIwQUTryDl5sIHbWY8klG2qVLYbh234YnX/Fm2Zmr4jveeT5Du7DB41JO0uznGBWTY
         20qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783418387; x=1784023187;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HxlLOptu4x4oA1uLCylVRCkkwhPmFFwLVIR0PIjoCBo=;
        b=QTyrXDPppgH86aN4nnpoofiGUNgkGvCtgDTyUaRsqIwE16WfAGJf4iRgJo28QYN8oF
         C6QDEbLHjOGeBMfe8WbFKIUFmb0/RHq8KVXED8ht+HVDFB5ZR6Aez71FD07K5JMwwXq+
         OjUBKquU3rCu5pbevIADDeHXO00KoAryQKr6KGPm2myBT6gxMe5eXh6lce9LOElHQtjO
         fjoeDpnfmh6XKM61/cp8IB9EUMMZ0r3ZvUtaWwL04YmXLIU++u3vt7JU/raXbbpfLVzU
         H8tOFFlHnrfh8eY8+69ZaitPCCCMIgqkBfv8yXdQudxjqXP05kKd9rQZQk+2g35RYeDG
         3K8g==
X-Gm-Message-State: AOJu0YxciX60T3ZwnCzwmnXXxQwk2hnlOzcwms35/z5weYVTdO8MSqIx
	IwKq4cxYFhVPmQIG/C1x+XWN30GhxJEM9Um5nBSakxrnhp5RmqTbDvjXSyXvoYn5
X-Gm-Gg: AfdE7cndl72ORzcfuuK9DFMbR4wnwxUXKAde8BqcJIGPjw8mlKA8/l2YOBmeR6K4Vlv
	K413SxyMEk/v/4n5lnLFdc8m56yz28Jh9TejbIwGisnpeG90BJVQDOh3Lclea3IClB9IKj8yu8M
	V9yl7rMS5a2HtEDJwYyd/4T0rj2SM3j6K2Wxz2U+PG6Ouv0ehp1W875NHJX0D+4vW/eY4e2Nf6y
	ALh3T8kfc3DQONgxpI1eoJ1xnNW8DWT8/WhATmkcYS5vVtF8nmfp3MemX0Wi5n3OH5yl29qGTus
	/dALFGSnwBFiKE38BbAhb0qayA2pyzWPTNbIP7FpV2ttUZmZXq5YpgdAKnEhwW6T3p/YVmEPk34
	ADS5XW0Kbh4L7t0E6M8ntNMEebkRv8b7+hO5UZ6N5UyDquZL4UM21XB92J/6bqPd29VpLR6M7VN
	6sry8oULbNwWdxc+18EYp0NzrY
X-Received: by 2002:a05:6a00:b84:b0:848:2f84:730 with SMTP id d2e1a72fcca58-8482f841593mr1861679b3a.67.1783418387422;
        Tue, 07 Jul 2026 02:59:47 -0700 (PDT)
Received: from [127.0.0.1] ([52.241.30.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b975a0sm5212625b3a.14.2026.07.07.02.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:59:46 -0700 (PDT)
Message-Id: <b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Jul 2026 09:59:42 +0000
Subject: [PATCH 1/2] commit-graph: add trace2 instrumentation for generation
 DFS
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

Add a step counter and trace2_data_intmax call to
compute_reachable_generation_numbers() to make the cost of
the generation number DFS observable.  This exposes a
regression introduced in 199d452758 (commit-graph: fix
"filling in" topological levels, 2025-04-07) where
incremental commit-graph writes re-walk the entire commit
ancestry instead of reading topo levels from lower graph
layers.

Add a test that demonstrates the problem: with a two-layer
split commit-graph, writing a new incremental layer for a
commit whose parent is in the base layer walks all the way
down to the root (7 steps for 5 base commits) instead of
reading the existing topo level and stopping immediately
(1 step).

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-graph.c                |  5 +++++
 t/t5324-split-commit-graph.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 801471a098..4e39a048c4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1653,6 +1653,7 @@ static void compute_reachable_generation_numbers(
 {
 	int i;
 	struct commit_list *list = NULL;
+	intmax_t steps = 0;
 
 	for (i = 0; i < info->commits->nr; i++) {
 		struct commit *c = info->commits->items[i];
@@ -1671,6 +1672,7 @@ static void compute_reachable_generation_numbers(
 			int all_parents_computed = 1;
 			timestamp_t max_gen = 0;
 
+			steps++;
 			for (parent = current->parents; parent; parent = parent->next) {
 				repo_parse_commit(info->r, parent->item);
 				gen = info->get_generation(parent->item, info->data);
@@ -1694,6 +1696,9 @@ static void compute_reachable_generation_numbers(
 			}
 		}
 	}
+
+	trace2_data_intmax("commit-graph", info->r,
+			   "generation-dfs-steps", steps);
 }
 
 static timestamp_t get_topo_level(struct commit *c, void *data)
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 49a057cc2e..f9c57760f4 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -718,6 +718,34 @@ test_expect_success 'write generation data chunk when commit-graph chain is repl
 	)
 '
 
+test_expect_success 'incremental write reads topo levels from all layers' '
+	git init topo-from-lower &&
+	(
+		cd topo-from-lower &&
+
+		for i in $(test_seq 5)
+		do
+			test_commit base-$i || return 1
+		done &&
+		git commit-graph write --reachable &&
+
+		test_commit extra &&
+		git commit-graph write --reachable --split=no-merge &&
+
+		git checkout base-3 &&
+		test_commit new-branch &&
+
+		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+			git commit-graph write --reachable --split=no-merge &&
+
+		# BUG: topo levels from lower graph layers are not
+		# propagated, so the DFS re-walks from base-3 down to
+		# the root (7 steps) instead of reading topo levels
+		# from the existing graph (1 step).
+		test_trace2_data commit-graph generation-dfs-steps 7 <trace.txt
+	)
+'
+
 test_expect_success 'temporary graph layer is discarded upon failure' '
 	git init layer-discard &&
 	(
-- 
gitgitgadget

