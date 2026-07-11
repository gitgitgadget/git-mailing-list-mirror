Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECD392825
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783777088; cv=none; b=HChsLvNuL+8CjfE3PHwzhdpdyMVyITxP1L9G8mOJQc4T9Q/oq3uI38vYZZtOzeCSS4I6+KJIZde5EUd7Mz0F44RnKO4RfK7CXtITHMZhT5WsMGeJcSZruvKS62vh3GtRKh3UdI03vAWq7h4rSmv2Iqahe/TbY2woSaImIkDMwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783777088; c=relaxed/simple;
	bh=jUhovxAa5ZxXxbm/qdyjXPPY4tfsgeqkKDolY0Tc34c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5CTqJgMXVz0Y3YlWolT1ASw+KET+U6r6ozY7sysASK76ZItEFgGaHJQbjEnV0soMq1e8uK6ktcHkOw2xF4meTX9xu6nzeN8stcVCFJHTCvTCNZelE3KMdcUOV+DzhaZLXd3HhSiE9fxGS+3HQevRILBQmbMmSD8cp+GZEfdNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFCvds+I; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFCvds+I"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso14790805e9.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783777085; x=1784381885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dY5vmmnTYG8EsYyRXIz7lhHkbJ1u1liy/LSz/GDX41Y=;
        b=qFCvds+I3UetvrMD3d4aKrTkkLxMuWt3TxOm6jCzyvbQb+791rtH/zuG/aurt1Ph7M
         HiZhg82XBT0g2wCcMyOqvGcm7x0OE3Sq5NFNTGaJVwpptnnGE01H7WdyzVGqIAg1uGs4
         HdB4iAZq1q6gemiApVZpV5clTXLinuqj5T++iU2qy410j0OslgYhcmlYsbQCBgpJ0Q5L
         mMXlmibvDCrOdB927rQ9l7BHXZCAge0mdVJlDLNETsQGaQVAhyo9QOp5sciJRopHLjWu
         vEF8TuduXi0CJG105EcU2q6WQCVAzjM1MG6Y2aQ5win9KiucqqZMvCGhd9dbAYODVx3L
         rQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783777085; x=1784381885;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dY5vmmnTYG8EsYyRXIz7lhHkbJ1u1liy/LSz/GDX41Y=;
        b=o814dmEsbUQCSh1KXaOoJOoJU5kwCwsod3cHkcRUwcNPWEQeyepLSaMvgNzrdJbi8f
         VILVByrZdEPn872MgEYLjyDQxTQGCZEoT8V9bTQDk1xQiDcEi/mkRn+Vc3jxc+yrNoMj
         nGlvHcf+CsGaCiFvZBIB4fzejZ4YpqrXcC8dq+FFL10Q8xInT/4Ma63gghEc5NZQLlSc
         pnlwhtAmf4NrMXnOSentyaVNcw6u8oWAuJKuafjCZsAQpRJ9lkVjucsUyKmY/r+/xJ9p
         y/DJg7lZui7L79zfgnKyvYBmdHeMwLocjGfMGslaDkGKNsWuWl1AXb9vpSAX6HPCTJn5
         xdPw==
X-Gm-Message-State: AOJu0YwRm7u6522Xh2omy7zTAA2qt5GF5cwXmSmLT4FZB8C8msrEHxvz
	ZqRrbf4nrAq4JKFJnsRnClAOvlfZaL/eimVg3oB+Vu44r6w3ih3TALEpXg7O8LmA
X-Gm-Gg: AfdE7clQrVx8eveSeGO/J6pPW4eHH09N86e0shgtUHgewGQqxmBMBvEeKNNOLwLlqih
	BoxKXiDciK+uZvPiXETuDGtuXCsqog0U4khLTPIqdqgz56To7kHDuw5LyQ5BQLdW29v1LSyJplO
	MiMNdMQtQi2Zb+whw6vvjowO36AdEz4URtk38DZUN02RlhVJeoS/GWxZ1/KScBCwzO7Avbn5/yn
	x49F+l5v+FdGR+BqBipLVXYkX+XoYepEgjQbsZAX3GpoqY3eUYTd1R/75Z89c+9jqqo0MpppdHD
	Ab169R8+Q6s5yNgRRNy5o4Kf7FMZzfmDXEMtX6YuTg9esRDuxEKjeJB+4C3PG0/hJtWx8GodfoO
	ThLJVjODfCeWvI6/gzdSuqOA0QaZjPOl2uRLQZzpw14wHK0lvt0Jr3nf4sHlq09uwBuetDlGvr6
	Zr1WrG3FsoGcXUNgC+ZKlD00UIeHoR4FxtbIAHhM8y4MKx50AiGl5pAv8v2419ulp+I4ob+OuKV
	pGM4U6t7G2dL9/MwbBmoVwtdfkpN+ZJc5RE5bgjnkKAaaMGc5Z5iVnQqH4vMmwGjsdS+1qatGJ9
	YdM0CgaHOu5eIgtAhTDk+TNa2HZsxeuiznobPFSSRNnKIH7zq/fNrmINlX/z3xQXt9/rw6uq3Rt
	G7whY78G1Pg==
X-Received: by 2002:a05:600c:154a:b0:493:f73d:cc6d with SMTP id 5b1f17b1804b1-493f8824ba6mr28602605e9.24.1783777084980;
        Sat, 11 Jul 2026 06:38:04 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4f09f89sm220999015e9.10.2026.07.11.06.38.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 06:38:04 -0700 (PDT)
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
Subject: [PATCH v9 3/4] graph: add a 2 commit buffer for lookahead
Date: Sat, 11 Jul 2026 15:37:52 +0200
Message-ID: <20260711-ps-pre-commit-indent-v9-3-eab6676e82f7@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
References: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In a subsequent commit the graph renderer needs to know if the next
commit is a visual root or if it is the last commit to be shown. This
requires peeking 2 commits ahead.

Commits are pre-fetched in get_revision() through next_commit_to_show()
where they are also marked as SHOWN, regardless the source they come
from.

Update graph_is_interesting() so it considers commits inside the
lookahead buffer as interesting as well.

Helped-by: Kristofer Karlsson <krka@spotify.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c    | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 graph.h    | 17 +++++++++++++++++
 revision.c | 18 ++++++++++++++++--
 3 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/graph.c b/graph.c
index 842282685f..89ebcf7540 100644
--- a/graph.c
+++ b/graph.c
@@ -315,6 +315,14 @@ struct git_graph {
 	 * diff_output_prefix_callback().
 	 */
 	struct strbuf prefix_buf;
+
+	/*
+	 * Lookahead buffer: up to 2 pre-fetched commits that will be shown.
+	 * Populated by get_revision() so graph_peek_next_visible() can use
+	 * actual walk results instead of peeking at rev_info internals.
+	 */
+	struct commit *lookahead[2];
+	int lookahead_nr;
 };
 
 static inline int graph_needs_truncation(struct git_graph *graph, int lane)
@@ -388,6 +396,9 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
+	graph->lookahead[0] = NULL;
+	graph->lookahead[1] = NULL;
+	graph->lookahead_nr = 0;
 	/*
 	 * Start the column color at the maximum value, since we'll
 	 * always increment it for the first commit we output.
@@ -456,6 +467,15 @@ static void graph_ensure_capacity(struct git_graph *graph, int num_columns)
  */
 static int graph_is_interesting(struct git_graph *graph, struct commit *commit)
 {
+	/*
+	 * Commits in the lookahead buffer have been pre-fetched by
+	 * get_revision() and will be shown in the future. They already have
+	 * the SHOWN flag set when they were pre-fetched but the graph still
+	 * needs to treat them as interesting parents.
+	 */
+	for (int i = 0; i < graph->lookahead_nr; i++)
+		if (graph->lookahead[i] == commit)
+			return 1;
 	/*
 	 * If revs->boundary is set, commits whose children have
 	 * been shown are always interesting, even if they have the
@@ -763,6 +783,37 @@ static int graph_needs_pre_commit_line(struct git_graph *graph)
 	       graph->expansion_row < graph_num_expansion_rows(graph);
 }
 
+struct commit *graph_pop_lookahead(struct git_graph *graph)
+{
+	struct commit *c;
+
+	if (!graph->lookahead_nr)
+		return NULL;
+
+	c = graph->lookahead[0];
+	if (!c)
+		BUG("lookahead buffer has %d entries but the first one is NULL",
+		    graph->lookahead_nr);
+
+	graph->lookahead[0] = graph->lookahead[1];
+	graph->lookahead[1] = NULL;
+	graph->lookahead_nr--;
+	return c;
+}
+
+int graph_get_lookahead_room(struct git_graph *graph)
+{
+	return (int)ARRAY_SIZE(graph->lookahead) - graph->lookahead_nr;
+}
+
+void graph_push_lookahead(struct git_graph *graph, struct commit *c)
+{
+	if (!graph_get_lookahead_room(graph))
+		BUG("pushing into lookahead buffer when it is already full");
+
+	graph->lookahead[graph->lookahead_nr++] = c;
+}
+
 void graph_update(struct git_graph *graph, struct commit *commit)
 {
 	struct commit_list *parent;
diff --git a/graph.h b/graph.h
index 3fd1dcb2e9..1193711fb8 100644
--- a/graph.h
+++ b/graph.h
@@ -262,4 +262,21 @@ void graph_show_commit_msg(struct git_graph *graph,
 			   FILE *file,
 			   struct strbuf const *sb);
 
+/*
+ * Pop the first commit from the graph's lookahead buffer.
+ * Returns NULL if the buffer is empty.
+ */
+struct commit *graph_pop_lookahead(struct git_graph *graph);
+
+/*
+ * Returns how many more commits can be added to the lookahead buffer.
+ */
+int graph_get_lookahead_room(struct git_graph *graph);
+
+/*
+ * Push a commit into the lookahead buffer. Must only be called when
+ * graph_get_lookahead_room() returns > 0.
+ */
+void graph_push_lookahead(struct git_graph *graph, struct commit *c);
+
 #endif /* GRAPH_H */
diff --git a/revision.c b/revision.c
index 288935943f..258c3cf782 100644
--- a/revision.c
+++ b/revision.c
@@ -4715,10 +4715,24 @@ struct commit *get_revision(struct rev_info *revs)
 		return c;
 	}
 
-	c = next_commit_to_show(revs);
+	if (revs->graph) {
+		c = graph_pop_lookahead(revs->graph);
+		if (!c)
+			c = next_commit_to_show(revs);
+	} else {
+		c = next_commit_to_show(revs);
+	}
 
-	if (c && revs->graph)
+	if (c && revs->graph) {
+		while (graph_get_lookahead_room(revs->graph)) {
+			struct commit *next = next_commit_to_show(revs);
+			if (!next)
+				break;
+			graph_push_lookahead(revs->graph, next);
+		}
 		graph_update(revs->graph, c);
+	}
+
 	if (!c) {
 		free_saved_parents(revs);
 		commit_list_free(revs->previous_parents);

-- 
2.54.0
