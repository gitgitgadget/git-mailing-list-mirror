Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35A63D891F
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939508; cv=none; b=FafTMQiMa7EumGiWEIyDaRW6abA2BcyRoaltWeXFrgD0Xe59aRjvzn8SK4cbbwcWEn7LRKlIXhZkpVBMuv57hfo6J88A2QteRjb0WRiTDG8YZfIt78qDEHFOOho/e2WWTN6Qhz4n0J+BvohEI+/vj2gH7bJ+HY0oxetoi+KMSS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939508; c=relaxed/simple;
	bh=OjKplq/8uX1lLdTKG+gGTiT84L1WMMTmBuf9O6Iw0Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpUtkf6qbVtbQiWBa81VlKOqBz8kUb0IKYO+G3iR7xEqf2HMd8ODdyBk+pat3t1s+BYLyrII7et3Fo9hcmvIBFXkhSPCE2giOSldBaPzcCfaghvSSTK5U/TXSVSZuYDebu2FszSFtpzuFe9JgRDIwkd1rKkics8RZ9jDHEl47XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWra7WqW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWra7WqW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso11186955e9.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 03:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783939505; x=1784544305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gfouj1eb0Dv/RXnyOxK1pyu6aLxwoPWQWiRc+NG3v2M=;
        b=PWra7WqWgg7xCy7YhVWjvFnPIpUOyhtlaW5kemsgmkrSHAcLUR57YtmdEocHbh5fL8
         hd6c55IwbvrNkzW/JZ7oNgRpEJ0DS+EYf10dNq2TiC9pupYn5V1JmBqkHcI7aJArFm0q
         In5s2AVlLgpo4sI8edq/B7gQTecaIZaaaOkIrcYBBWjObE7smGbzATaQLsYVnni2kAKv
         qARH4uFEh6vOwdIscTnQ5viNLgEE+0+KcQc0huqoNOWiHxOh7xTgDYiIEuueEfmm0BYC
         735891UsN3lns802dLy6qGw1z4l0EFvZwqWBU0/QigRCh1aeVNgN8C2GsTfT7qEdKSzJ
         1hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939505; x=1784544305;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gfouj1eb0Dv/RXnyOxK1pyu6aLxwoPWQWiRc+NG3v2M=;
        b=rLAKGHmEkeiP1DzOjOXK+UPM4TfBc4YhA1OnIDh/v/tHdVnqqe4c6Wba/3DSuYJJCo
         BhI+Rb8T1PEp+rh5uuoGzzT9zYT2x4NbrNBX4fU+p9Xq/NW/o/Dh/xbUYpK+xwkdJTgX
         4fSfH5G8EgbTkBJbhbDbh+LbQXJO8m8cDidRTqgZeneRqsvl3EmJ3HrnO06RwzsA/TaQ
         ZCx2qOiLabDI0AZkH5alpzRY4HuZyruTFD+akZvG7KvYIDp8D8X9N/GxP8ZVxxdKgNuJ
         wvopNqB6B8HPxxiM1nAjk+zx+NZoYdaPTO1fzRMKRmSamK0+p00bKj8FuaXeldh+A8hl
         N9+w==
X-Gm-Message-State: AOJu0YwdSnoxOjYr2/qqfMB0veYTFdtZhE8qHh1LXSH6c5KGzQba9PNV
	fAqgBiL9NcgLihUubjLOnXiswNm8yWwtX1jhokrpWGjA3i5VRJg5hr/oqlPsVLEy
X-Gm-Gg: AfdE7cmjGBwzdwgJPaf9KeCG8k/zscDcJ6IfdgR+a2YvqV3JqvjlKCD6jR5JWT5w0k0
	kQXBnFsO2Smx+9MHq/ji4pZPT0UvgzQUfWTTHBZ+vQXL/SGkOkHMEcN71NHsv6VeMAK5w9NLWcr
	EVkkLpi0idigXAgi0tpRmrYjd9gZWDqHFyHxRsucHHvZWf+cFEbS26hJsqzW0qo2KLW/1Ni8mrK
	VPak5i5HyPAkopVOALWthFUFNqPzjxL4KMixjKQiuOKy63nGoYuTYwegW2va4t2P0XrhbFKaVXB
	GP9/jiSGFNX3vh3SUDVzPITQ845Q7WJfgzO/x8SKAO+L6zlHe1EiSYYJGZG7h9U/BtnAYnEQ0jQ
	114YUlf9chkcnzwwmcMUrLCDSr+Y9BfHJrhUVp9zwKaWncogg0/UEJyMc/NK4+u2nUWdMCHVs71
	TwdOg4KY7cJZAP0GXsM4U07F4hn5v8HuanMPzypNkTCOgzMPq9qwJQlmI24fI1QpQ1eCDkl4bC6
	O+Ao9zVzfVC2JFf72mzTTWdUK5GEdOBIxNnIyN5gSolMQEdSl4n+5AGVbA4Lp5k0AXCZnBMZKBd
	KMWMJSi++K63Lr55gGOpjF7svx4cPeQDuj7xZXSSgZIIe0f+kQvxGCcbfclcAZCbSlM1TRU/BfF
	kKxDWWjAwPA==
X-Received: by 2002:a05:600c:528d:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-493f881d39cmr93242935e9.24.1783939504786;
        Mon, 13 Jul 2026 03:45:04 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm318564645e9.9.2026.07.13.03.45.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 03:45:04 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v10 7/7] graph: add --[no-]graph-indent and log.graphIndent
Date: Mon, 13 Jul 2026 12:44:42 +0200
Message-ID: <20260713-ps-pre-commit-indent-v10-7-82ddab26bc96@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
References: <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Some users may prefer to not have graph indentation.

Add "log.graphIndent" config variable to graph_read_config() to read the
default preference. By default is graph indentation is true.

Add --graph-indent and --no-graph-indent options to overwrite the
default preference.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/config/log.adoc       |  4 +++
 Documentation/rev-list-options.adoc |  8 ++++++
 graph.c                             | 10 +++++--
 revision.c                          |  9 +++++++
 revision.h                          |  2 ++
 t/t4218-log-graph-indentation.sh    | 52 +++++++++++++++++++++++++++++++++++++
 6 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index 757a7be196..f7dfce69b5 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -59,6 +59,10 @@ This is the same as the `--decorate` option of the `git log`.
 	A list of colors, separated by commas, that can be used to draw
 	history lines in `git log --graph`.
 
+`log.graphIndent`::
+	If `true`, indent visual roots when rendering the graphs with `--graph`.
+	Set true by default. It can be overriden with `--[no-]graph-indent`.
+
 `log.showRoot`::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index eaee6ee839..af74f10bb4 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1269,6 +1269,14 @@ This implies the `--topo-order` option by default, but the
 	By default it is set to 0 (no limit), zero and negative values
 	are ignored and treated as no limit.
 
+`--no-graph-indent`::
+`--graph-indent`::
+	When used with `--graph`, indent visual roots (commits with no parents
+	or whose parents are not shown) to differentiate them from commits that
+	are vertically adjacent but unrelated. Enabled by default. Use
+	`--no-graph-indent` to disable or set `graph.indent` to set a deafault
+	preference.
+
 ifdef::git-rev-list[]
 `--count`::
 	Print a number stating how many commits would have been
diff --git a/graph.c b/graph.c
index c14be934a0..28bef1b88f 100644
--- a/graph.c
+++ b/graph.c
@@ -419,6 +419,8 @@ void graph_setup_line_prefix(struct diff_options *diffopt)
 
 static void graph_read_config(struct rev_info *revs)
 {
+	int val;
+
 	if (!column_colors) {
 		char *string;
 		if (repo_config_get_string(revs->repo, "log.graphcolors", &string)) {
@@ -435,6 +437,9 @@ static void graph_read_config(struct rev_info *revs)
 						custom_colors.nr - 1);
 		}
 	}
+
+	if (!repo_config_get_bool(revs->repo, "log.graphIndent", &val))
+		revs->no_graph_indent = !val;
 }
 
 struct git_graph *graph_init(struct rev_info *opt)
@@ -999,7 +1004,8 @@ static void graph_peek_next_visible(struct git_graph *graph,
 static int graph_needs_pre_root_line(struct git_graph *graph)
 {
 	return graph->commit_in_columns && graph->is_visual_root &&
-	       graph->num_columns > 0 && !graph->visual_root_cascade;
+	       graph->num_columns > 0 && !graph->visual_root_cascade &&
+	       !graph->revs->no_graph_indent;
 }
 
 void graph_update(struct git_graph *graph, struct commit *commit)
@@ -1344,7 +1350,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 
 		if (col_commit == graph->commit) {
 			seen_this = 1;
-			if (graph->is_visual_root) {
+			if (graph->is_visual_root && !graph->revs->no_graph_indent) {
 				int depth = graph->visual_root_depth;
 				/*
 				 * Each visual column is 2 characters wide.
diff --git a/revision.c b/revision.c
index 258c3cf782..215cf11071 100644
--- a/revision.c
+++ b/revision.c
@@ -2627,6 +2627,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->graph = NULL;
 	} else if (skip_prefix(arg, "--graph-lane-limit=", &optarg)) {
 		revs->graph_max_lanes = parse_count(optarg);
+	} else if (!strcmp(arg, "--graph-indent")) {
+		revs->no_graph_indent = 0;
+		revs->graph_indent_set = 1;
+	} else if (!strcmp(arg, "--no-graph-indent")) {
+		revs->no_graph_indent = 1;
+		revs->graph_indent_set = 1;
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
 	} else if (!strcmp(arg, "--no-encode-email-headers")) {
@@ -3201,6 +3207,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->graph_max_lanes > 0 && !revs->graph)
 		die(_("the option '%s' requires '%s'"), "--graph-lane-limit", "--graph");
 
+	if (revs->graph_indent_set > 0 && !revs->graph)
+		die(_("the option '%s' requires '%s'"), "--[no-]graph-indent", "--graph");
+
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
diff --git a/revision.h b/revision.h
index 569b3fa1cb..49e1380b80 100644
--- a/revision.h
+++ b/revision.h
@@ -314,6 +314,8 @@ struct rev_info {
 	/* Display history graph */
 	struct git_graph *graph;
 	int graph_max_lanes;
+	int no_graph_indent;
+	unsigned int graph_indent_set;
 
 	/* special limits */
 	int skip_count;
diff --git a/t/t4218-log-graph-indentation.sh b/t/t4218-log-graph-indentation.sh
index d4c850c0d4..b69730e7ba 100755
--- a/t/t4218-log-graph-indentation.sh
+++ b/t/t4218-log-graph-indentation.sh
@@ -540,4 +540,56 @@ test_expect_success 'visual root cascading gets wrapped after 4 columns' '
 	EOF
 '
 
+test_expect_success '--no-graph-indent disables indentation' '
+	lib_test_check_graph --no-graph-indent _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
+	* 67_A
+	* 66_A
+	* 65_A
+	* 64_A
+	* 63_A
+	* 62_A
+	* 61_A
+	* 60_A
+	* 59_A
+	* 58_B
+	* 58_A
+	EOF
+'
+
+test_expect_success 'log.graphIndent config disables indentation' '
+	test_config log.graphIndent false &&
+	lib_test_check_graph _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
+	* 67_A
+	* 66_A
+	* 65_A
+	* 64_A
+	* 63_A
+	* 62_A
+	* 61_A
+	* 60_A
+	* 59_A
+	* 58_B
+	* 58_A
+	EOF
+'
+
+test_expect_success '--graph-indent forces indentation when graph.indent is unset' '
+	test_config log.graphIndent false &&
+	lib_test_check_graph --graph-indent _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
+	* 67_A
+	  * 66_A
+	    * 65_A
+	      * 64_A
+	* 63_A
+	  * 62_A
+	    * 61_A
+	      * 60_A
+	  * 59_A
+	* 58_B
+	* 58_A
+	EOF
+'
+
+# graph.indent true and no --option is the default state.
+
 test_done

-- 
2.54.0
