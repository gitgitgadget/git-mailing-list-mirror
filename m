Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695C3B14A3
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939503; cv=none; b=TmGZR0qc4aoeWmTkHk1xh9cm86Yda9VJ3s6r8XqUKnYjJTwS8cW66/20tdL86Snp2ZxkEsJqDEn1D69tz637cdhuKMl+chQSCuzlZ4z2QAuAlHnHBDAbi7Fvy5Zdw4R60j8PPrLzJyOz0WCNIdQEyyLpEpRaJ6H2rAMUaKp+nnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939503; c=relaxed/simple;
	bh=jUhovxAa5ZxXxbm/qdyjXPPY4tfsgeqkKDolY0Tc34c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uw15JMzKhqaBhT1CtQBTPHOTrqz/Q5qSvej9pcHd1Tka0+3GflUp2bzbggCc6R0alAVye+spI3PavGB9FUbWoYx6GNPeIXCYCBHxo1Ig58O6Xshb3gFx9tZDH014949f/9aXUdBggOD82zmYSlqisvvczZfRhMUmEnWIJDmrMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUgv8Jri; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUgv8Jri"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b1710405so15282835e9.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 03:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783939500; x=1784544300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dY5vmmnTYG8EsYyRXIz7lhHkbJ1u1liy/LSz/GDX41Y=;
        b=PUgv8JrilIAxXJiITSgrUZzvQ0I1t21kyyO1GHW+mjiBcBAZf8AK6Uw99tO3MtMlsE
         9hQOGHKlKCWJYCDQHTdpwQdKOp53IWnycyvqETEjpZP0bn4crHP/ld3Qc114Mj1peEEK
         Qa+kscW1xNahA+PD/Mtkie62I6XHXfa1h81JAyO74jxvR9Se98bA93aldTr1NrXzygMr
         6bb44paxJIEYVYBQyufRx+UbZAk/1W/aEh643QLcbS0GDJsFdVRjL1tFXYzBLZpPP0qB
         eX+Lq72oIlxtCIgOC+y6+5ITlQz+N29sWs8XJNEnA2tHmRFz+WHkk0fnuUNtFoE2YIrk
         s3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939500; x=1784544300;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dY5vmmnTYG8EsYyRXIz7lhHkbJ1u1liy/LSz/GDX41Y=;
        b=qJ4LRq9rzdteEj5nY9BeMMEPjMA73Q5UmswHTInVTT9GVQfHb9QcIelRpD+whwniUh
         js1Ibh9MWD1zFYYuRHYzg5SZWqHn+3gljR3vtdYgXjhpv6hc/CpXRyX4nhIZ5Mrjk3yI
         Zt84j/xUiRoK7GIdn40+8eIWggKDpu8I23WBOI4hCG9qDG5j4EvQGqLhydsJcnSlAiEY
         M8sthPGTMnHFjt3KW5OpFVDgewC0LZHyQmcr6KMMOAVnY+dyJ70D9U3BAtT9dJq8pzZj
         NS4RFVDWd30MuR3Rk/cmgD8C5XPBKehArGZyc+iS40TeyxKk+pMAlW//FDAJ+NtxVaSQ
         Mp6w==
X-Gm-Message-State: AOJu0YxH8QejKMztgwAUCAFid2qoUHQeYTu4X72ojlVkr+/67oU13uqe
	Q7MUnnb5RsD8rW0macxgCGZmehILB6OHIynzfPAZLOEQbYmptI1wE3trxfq5+5P7
X-Gm-Gg: AfdE7clhMJ8OOPKHb5qcHJTfT4seqQcjg2pjq8X62+Nwqw6ooVmvVd9QV7ll7rRADKV
	79yGfxFNPD0iv4t64MEJOhKChPTHpyeRkiJl/83xKuWiBY9XNx8tzDgWmAXuwXzRGoqOIj4e5Kq
	VnzcB3lvJFEZGd7s44Bv2/hF/4+kMF/gB6CwJBB6dAknIBmE08p+kU8SAzHur9Dncvy9S9Q4kJF
	EwhQHWxbbzmQVzmEFHIVKb92mWTdKz5emiVN42c+v9GAunHeInWFNSb0UCWu12OFGmn8qn+TKPm
	KQWMpRXIdrMqHJPizr/BbaWYslCbOiO4fAife7zCl5jiT0ru88x3mlYb9DGvE+GZpECW0FmkYV3
	y47M3nCy1KAN0aixyEZ4Hk+OCAXpR3zVyNmaY7rD5J6GAjaQIve6+NGQ97nhzs6a1dbxsGER4Js
	nVdji2Br7hST4fKHD2LP7Nqn7ZdK53kVXBEzRSiQLlW8h/Yaaf2XJyElZgjuD3QnypK7n0nxYKm
	edyG/r25SihTjvsoTwhYJgL6LuZpZ81WMCaWqKoxZRwnZgMVgr6dD4sHO8/uHcDHpP6YUsSNlmM
	fqNNtK9YmYqs5XK36rrCHjO1GDQEPZfM8mv8nVUaV/pgu6pz/qCoTeQesAcSki9q0olh30gasub
	HWyn2RyPiwGihxPUB39Ne
X-Received: by 2002:a05:600c:3acf:b0:493:cfc8:12e7 with SMTP id 5b1f17b1804b1-493f881d44fmr82293475e9.25.1783939499969;
        Mon, 13 Jul 2026 03:44:59 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm318564645e9.9.2026.07.13.03.44.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 03:44:59 -0700 (PDT)
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
Subject: [PATCH v10 3/7] graph: add a 2 commit buffer for lookahead
Date: Mon, 13 Jul 2026 12:44:38 +0200
Message-ID: <20260713-ps-pre-commit-indent-v10-3-82ddab26bc96@gmail.com>
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
