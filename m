Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFDB82D99
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643956; cv=none; b=euo1fuxwSXBvvgoMBiHo8eRuulVXeHKJFq9rZzg3WN7YpTYU+v9vTCcyz8a3rdd7S6521laufw98NQKmHcC+mF6kEk0VhjJMYS8mVGSTMcDDHn2yK5Z2WQ596yN5aqUv5bSj7nqmzuSvaYBGMMW9Xc0GUuJVGW2VuWdmZV75Dx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643956; c=relaxed/simple;
	bh=rGST2sjM/6eLnyVV7OdJzN84q56mShw82wVPcuZoaz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SsmWA4TCvxwc8Mf/IUndgdcbV3NlLnXKDtd0VtUOZOscrfoIGLLTryqP2gtQsVyQUU8EViSPA96pKHQKIc2t09kdoPV8YnGZjhXvOlShpkWtaEtmmrEIQPWFkNIlK5MP/gCG7tXlk8OsDxI02btvrMXWg9K8n15NNxxprinCpAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YdklmNyi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YdklmNyi"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6083fbe9923so5828797b3.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 15:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708643953; x=1709248753; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgUngpLUP+TJtqUQh6KXItA/Q1wQ1cfSAOJSqQawPbM=;
        b=YdklmNyiLx6OFKFOwb240WQm4oxuzo5+8Vc3PjGiDPLHLfTCCKg30MzoB3zlFIs5Sc
         kbTDDydsbwcXdHYJVCv17jM4T19L5Z9CxkmAl5yxxpAmCeaN9AnPWJXT/BBU1Ehgm23c
         QV7WEZyx5Px89x2WlG/GgnEXiDRS/qNDEk53oue5lEbPEvNhzBXLR5so4oWtMUgEnHhq
         xyKdqTBJ5GyA68jOQNF6E7qk1R1chu7wwL2tyRcpZWqFoKM+y6uuiw78X3SUlvnTBIY4
         mwSc1nDKUcrZOW2k+EdCE6d6KenkmZDuQYOnkiYMavNm2hLH0hLHvgQ4SUl480/1TJik
         q4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708643953; x=1709248753;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgUngpLUP+TJtqUQh6KXItA/Q1wQ1cfSAOJSqQawPbM=;
        b=D20iDC2Pb6Bva8PhSngwBaPSZHItH3QenM1oQDtwUtmFMdY53PMiQJQIhusiq4iuol
         JEMR5QV4fB16HPeqp6SLLpAxLIHSkjwFsSnpT9VUYQ4Jqo1PkYs8LwOwesrV/JPSuj8U
         cp2E1J72FX1xaU93uZJdyP2u82d5u/pz95o/QOOu+8UFazTV3iAhwSIUjPFJkg8K5FTU
         E8OnJilEmcCqyz2B22mtZwUsxRNl15zqoVPVNTnyi4AF8nJMH9TXTSnk3lcJC+yXi8mn
         LEDw2VFCMJmKc8JMnux5fOD8wUnSnkDHqo9Kz73DnJGyjRBJ1TZktqEDnKHM0eByDHDG
         8n+Q==
X-Gm-Message-State: AOJu0YwY7LFdIweN9/RLAdCv3Hgv20BMe0zP/UvxN52NoBnPp50OCwz9
	zVaPBhhNrTVw8sfh7JWyaFWcF4gkOoo06lJmZmvgdgPhE3Qdooj/AF///oNSvVXh27C55q6WGE3
	YLYNbM8Seu2X4I7S7Dw0h6n2KSUCJsy9RTLIZ2W+9stmolxhdLYYzcbK0t8lDptMSQTIGgQ5aJn
	VLCxTOO1iwD4EQOO2YTbatfJH3FKROdqsS9JFnCq8=
X-Google-Smtp-Source: AGHT+IFaUCPzNgsiubWqTlpwoZYhDgKAGQiTM44IgC8PJEJZ8/anV/TLOAXRs9vwWfxHMKfsprXBF9sYuRC9jg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:4ac4:71c0:92c1:4c83])
 (user=steadmon job=sendgmr) by 2002:a0d:e681:0:b0:607:d016:d85c with SMTP id
 p123-20020a0de681000000b00607d016d85cmr151019ywe.9.1708643953284; Thu, 22 Feb
 2024 15:19:13 -0800 (PST)
Date: Thu, 22 Feb 2024 15:19:07 -0800
In-Reply-To: <cover.1708643825.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1708643825.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <55241dacc5f84c76bd661ab376deadec2c78f4f6.1708643825.git.steadmon@google.com>
Subject: [PATCH 2/2] commit-graph: suggest removing corrupt graphs
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There are various ways the commit graph can be corrupted. When we detect
these, we issue an error(), BUG(), or die(). However, this doesn't help
the user correct the problem.

Since the commit graph can be regenerated from scratch, it may make
sense to just delete corrupt graphs. Suggest running the new
`git commit-graph clear` command in relevant error/BUG/die messages.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 commit-graph.c          | 16 +++++++++++++---
 commit-reach.c          |  4 +++-
 t/t5318-commit-graph.sh |  4 ++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index ca84423042..0d5474852c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -418,6 +418,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	if (graph_signature != GRAPH_SIGNATURE) {
 		error(_("commit-graph signature %X does not match signature %X"),
 		      graph_signature, GRAPH_SIGNATURE);
+		error(_("try running: git commit-graph clear"));
 		return NULL;
 	}
 
@@ -425,6 +426,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	if (graph_version != GRAPH_VERSION) {
 		error(_("commit-graph version %X does not match version %X"),
 		      graph_version, GRAPH_VERSION);
+		error(_("try running: git commit-graph clear"));
 		return NULL;
 	}
 
@@ -432,6 +434,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	if (hash_version != oid_version(the_hash_algo)) {
 		error(_("commit-graph hash version %X does not match version %X"),
 		      hash_version, oid_version(the_hash_algo));
+		error(_("try running: git commit-graph clear"));
 		return NULL;
 	}
 
@@ -447,6 +450,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 			 GRAPH_FANOUT_SIZE + the_hash_algo->rawsz) {
 		error(_("commit-graph file is too small to hold %u chunks"),
 		      graph->num_chunks);
+		error(_("try running: git commit-graph clear"));
 		free(graph);
 		return NULL;
 	}
@@ -459,14 +463,17 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 
 	if (read_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph)) {
 		error(_("commit-graph required OID fanout chunk missing or corrupted"));
+		error(_("try running: git commit-graph clear"));
 		goto free_and_return;
 	}
 	if (read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph)) {
 		error(_("commit-graph required OID lookup chunk missing or corrupted"));
+		error(_("try running: git commit-graph clear"));
 		goto free_and_return;
 	}
 	if (read_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_commit_data, graph)) {
 		error(_("commit-graph required commit data chunk missing or corrupted"));
+		error(_("try running: git commit-graph clear"));
 		goto free_and_return;
 	}
 
@@ -860,7 +867,8 @@ static void load_oid_from_graph(struct commit_graph *g,
 		BUG("NULL commit-graph");
 
 	if (pos >= g->num_commits + g->num_commits_in_base)
-		die(_("invalid commit position. commit-graph is likely corrupt"));
+		die(_("invalid commit position. The commit-graph is likely corrupt,\n"
+		      "try running:\n\tgit commit-graph clear"));
 
 	lex_index = pos - g->num_commits_in_base;
 
@@ -876,7 +884,8 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 	struct object_id oid;
 
 	if (pos >= g->num_commits + g->num_commits_in_base)
-		die("invalid parent position %"PRIu32, pos);
+		die("invalid parent position %"PRIu32". The commit-graph is likely corrupt,\n"
+		    "try running:\n\tgit commit-graph clear", pos);
 
 	load_oid_from_graph(g, pos, &oid);
 	c = lookup_commit(r, &oid);
@@ -897,7 +906,8 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 		g = g->base_graph;
 
 	if (pos >= g->num_commits + g->num_commits_in_base)
-		die(_("invalid commit position. commit-graph is likely corrupt"));
+		die(_("invalid commit position. commit-graph is likely corrupt,\n"
+		      "try running:\n\tgit commit-graph clear"));
 
 	lex_index = pos - g->num_commits_in_base;
 	commit_data = g->chunk_commit_data + st_mult(GRAPH_DATA_WIDTH, lex_index);
diff --git a/commit-reach.c b/commit-reach.c
index ecc913fc99..16765ce39b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -81,7 +81,9 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 		timestamp_t generation = commit_graph_generation(commit);
 
 		if (min_generation && generation > last_gen)
-			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
+			BUG("bad generation skip %"PRItime" > %"PRItime" at %s\n"
+			    "The commit graph is likely corrupt, try running:\n"
+			    "\tgit commit-graph clear",
 			    generation, last_gen,
 			    oid_to_hex(&commit->object.oid));
 		last_gen = generation;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 35354bddcb..f4553b1916 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -843,6 +843,7 @@ test_expect_success 'reader notices too-small oid fanout chunk' '
 	cat >expect.err <<-\EOF &&
 	error: commit-graph oid fanout chunk is wrong size
 	error: commit-graph required OID fanout chunk missing or corrupted
+	error: try running: git commit-graph clear
 	EOF
 	test_cmp expect.err err
 '
@@ -852,6 +853,7 @@ test_expect_success 'reader notices fanout/lookup table mismatch' '
 	cat >expect.err <<-\EOF &&
 	error: commit-graph OID lookup chunk is the wrong size
 	error: commit-graph required OID lookup chunk missing or corrupted
+	error: try running: git commit-graph clear
 	EOF
 	test_cmp expect.err err
 '
@@ -868,6 +870,7 @@ test_expect_success 'reader notices out-of-bounds fanout' '
 	cat >expect.err <<-\EOF &&
 	error: commit-graph fanout values out of order
 	error: commit-graph required OID fanout chunk missing or corrupted
+	error: try running: git commit-graph clear
 	EOF
 	test_cmp expect.err err
 '
@@ -877,6 +880,7 @@ test_expect_success 'reader notices too-small commit data chunk' '
 	cat >expect.err <<-\EOF &&
 	error: commit-graph commit data chunk is wrong size
 	error: commit-graph required commit data chunk missing or corrupted
+	error: try running: git commit-graph clear
 	EOF
 	test_cmp expect.err err
 '
-- 
2.44.0.rc0.258.g7320e95886-goog

