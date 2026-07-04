Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B343A0EA2
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783155243; cv=none; b=bkKLim4VOvtuj7+Db6tFEdH844SLb/yBvkjg2IfTFnA+8IFJumpeCoGDCgHo+eln28cdXXnZzypq2M/5ZflFpJF9ReVeqMMVxmnJ5wSgX45G1u0cQNzlYki+i6fQ4p/E1plJ8hbFHywyktEOMW/B0+Go3vRAl2IIrkyJglKvJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783155243; c=relaxed/simple;
	bh=5t3zbhkbdN1KX6dftGJ4ict/ykD93wVG0RFniQ7N9C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SA/E1BHlTCW9IZrdPHGoXpkgWi/anJhhxL6OXbdA2s0BKJJkymlpNApLgqiyrm1HZRI7PG1MP3wjOyOK/e9noFH9PjM6Z0ZHbQH/HA8ZJuZ/8PydMjuF4CegRNmaEnZ+xrXb11Ylk4hRPKA0VdKnnalIhdvWzMGRHquQlAt6XpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1pXagMO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1pXagMO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so9702445e9.1
        for <git@vger.kernel.org>; Sat, 04 Jul 2026 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783155240; x=1783760040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22Pwenx+UlL21GDLkqWiax3EzrT8eYcU/Ce+5ec6X/g=;
        b=i1pXagMONtz3dWCnoW5kfaHCziK/R5OLyQlG2mnnM/iG7fAEnwA96QkS+vTTau12Ox
         1e8Umbu3U0jv0oYLEuTdSOf8wqImUeuXKHnGLUR9omkprQ6BSgNbB9pEuvE8A7NEEFJQ
         Fm4UruWYw/9TuhsvHX/K69LToM51jF78bjMq/rhWSxs2P3Jr9mBYvOt7oKm3fxLvAxDI
         AA11GMyoviuKuw+ydhoncDh/7EASG7zY/xkFimW2diOyCbx5xACQGNPw5vGnybGd017c
         U6t8wEWH1YYutwXy7wfuSDS4DF/BCwIQLN2KARySPZdfCvQBHUzwol5MB4PTyPUdELcO
         p4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783155240; x=1783760040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=22Pwenx+UlL21GDLkqWiax3EzrT8eYcU/Ce+5ec6X/g=;
        b=F4yu3kLFXkBMX7QIh/bbXoxTgnpNce3ioN/DZpElgFUVnPIRqNYvLydr5+MsOB61mm
         DWLODDmnx1aHVupUgyBDjgJBUXrE/YlQQhArCNiETjqqjII1ojlPmFPJIcYnVN9gSGf4
         An7PUCTSP7LPgwtTamjMz+VnkavLuakuf3pxfvwBULs/Fhx+dXNmKDJk+6CotmHVTA0m
         jFoVgWriKvCse8IAX0W8XYUajx7VuBFDlRjQjcHfaBtob7p69oULJyLtB9PSVV8OwHTH
         8tJj5avvG/fHoMjsRUv1Fa5BnnIqAkBqGoxo7E3CpZ4MqI0cC6oG0/RA8NGerYcZH8bN
         vPyQ==
X-Gm-Message-State: AOJu0YyT2KP3Lp4657GuH548JzcmDxwhZXmlZ6eax+zNytqxOB8zxjr2
	h/r1Gqr+e6vVkcL6IaXVbfu/8eQcsDDHIQZkSyqepplB3mwq4SBHszxQku6MHGn3
X-Gm-Gg: AfdE7cmk+y01jCOOPfYGAyiBGAptWeNXbkLb9BZUBzMejDXlyYOTELIjuLP/yxM/8fW
	7h+LTS3fRYL3Gy3EnwyWc1pWSsj5Oma71l7bf0O+w5ot93Wo02OhIBILA4z+hDWiq73/2hWNKc9
	wcv1A4Hi6RCvy1rsQ4CJSRg+T17P9XPeLsTog5khDmXw5zIjoO2sUtiH0VzctCQVMTwCJ5TddsZ
	7MHV4wh4VrY5xO352Ubs5e85dwR8v9FfUGLRme6Blzl6RUQXoQlCy6P/OgET91K2LQ/IZTgNhPw
	vuEq8eWWG45ceKdPhT1CAGmQxNtfXLaq0LXgZvvQzHQ6JH0oMYoS6XXJg14apv4uqJzOCjKU4sf
	lbtLOPJdkxF0s6BHJ4wXMr3wiWj2eMvhGhFtAGAIpU3N6x3A9NvnP+6dVFTDCOrSZrGvKnR6DWy
	Z//yYS3+ar+rOhl31HiKW9YsZ05sMIP+c2w4xFIApgsKrUt9KLLz/u6HylcAMV85Rklditrz9fh
	HnC2m8cnp+qaY7CwkO+MlZxHLzc7EUjGOkEXqqN2ychc+bc9p+B6Z3CCeT1j7FP9L/S0cG5l6xl
	CzAJ9OJgLVEkyNKtljxX8Wx/QiFx3GWK6b43dwTNzyozlpUeEPra+b8CVyJY5sJkXPWpbDepZy8
	SvSZYCybmQw==
X-Received: by 2002:a05:600c:1f8d:b0:493:c3cb:409e with SMTP id 5b1f17b1804b1-493d11df0ffmr29508355e9.15.1783155239835;
        Sat, 04 Jul 2026 01:53:59 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef23feasm214141535e9.2.2026.07.04.01.53.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Jul 2026 01:53:59 -0700 (PDT)
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
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v7 2/3] graph: add a 2 commit buffer for lookahead
Date: Sat,  4 Jul 2026 10:52:34 +0200
Message-ID: <20260704-ps-pre-commit-indent-v7-2-a94706cc8376@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
References: <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
 <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
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

Commits are pre-fetched at get_revision_internal() where they are also
marked as SHOWN.

Update graph_is_interesting() so it considers commits inside the
lookahead as interesting as well.

Helped-by: Kristofer Karlsson <krka@spotify.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c    | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 graph.h    | 17 +++++++++++++++++
 revision.c | 17 ++++++++++++++++-
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index 842282685f..300ae67669 100644
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
+	 * get_revision() and will be shown in the future. They already
+	 * have the SHOWN flag set by get_revision_internal(), but the
+	 * graph still needs to treat them as interesting parents.
+	 */
+	for (int i = 0; i < graph->lookahead_nr; i++)
+		if (graph->lookahead[i] == commit)
+			return 1;
 	/*
 	 * If revs->boundary is set, commits whose children have
 	 * been shown are always interesting, even if they have the
@@ -763,6 +783,33 @@ static int graph_needs_pre_commit_line(struct git_graph *graph)
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
+	graph->lookahead[0] = graph->lookahead[1];
+	graph->lookahead[1] = NULL;
+	graph->lookahead_nr--;
+	return c;
+}
+
+int graph_get_lookahead_room(struct git_graph *graph)
+{
+	return 2 - graph->lookahead_nr;
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
index 3fd1dcb2e9..281603b020 100644
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
+ * graph_lookahead_room() returns > 0.
+ */
+void graph_push_lookahead(struct git_graph *graph, struct commit *c);
+
 #endif /* GRAPH_H */
diff --git a/revision.c b/revision.c
index e91d7e1f11..58351aeeff 100644
--- a/revision.c
+++ b/revision.c
@@ -4699,12 +4699,27 @@ struct commit *get_revision(struct rev_info *revs)
 				for (p = c->parents; p; p = p->next)
 					p->item->object.flags |= CHILD_SHOWN;
 		}
+	} else if (revs->graph) {
+		c = graph_pop_lookahead(revs->graph);
+		if (!c)
+			c = get_revision_internal(revs);
+
 	} else {
 		c = get_revision_internal(revs);
 	}
 
-	if (c && revs->graph)
+	if (c && revs->graph) {
+		if (!revs->max_count_stage && !revs->reverse_output_stage) {
+			while (graph_get_lookahead_room(revs->graph)) {
+				struct commit *next = get_revision_internal(revs);
+				if (!next)
+					break;
+				graph_push_lookahead(revs->graph, next);
+			}
+		}
 		graph_update(revs->graph, c);
+	}
+
 	if (!c) {
 		free_saved_parents(revs);
 		commit_list_free(revs->previous_parents);

-- 
2.54.0
