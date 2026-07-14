Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43539150A
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030988; cv=none; b=jzbNlH9uGnzUqOyzmjHHThdHSTMxQd10ItU4txxN8z7q2SgksXlJHgvj7OTyeIZw1Q1nWdOQQt93PCHhfReQMGDHAnVApWvhohDh09qHzQXU58UX6BfidC8xzety9BzQFjZ+c2cZmcGcxbLXirHQty3gBm7m9iMXSkZJxhPbMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030988; c=relaxed/simple;
	bh=jUhovxAa5ZxXxbm/qdyjXPPY4tfsgeqkKDolY0Tc34c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5A5pfW+ptW7kSLcRG73WF0eDKQpge0Av0LBAjwRj+8ohexlR7Jtouv+MFeQ2vCqHz1vflRPTqHWM6J0A58UlofIIgLpf4P3pC+il0h5xRnX6rBQ2D3KYxRmev7NnnetEOnkTVoMiS79ohLZ0yk21X5Ic9yLHDaMScHq54iYVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVzst4B4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVzst4B4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47df440fcd5so2346229f8f.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030985; x=1784635785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dY5vmmnTYG8EsYyRXIz7lhHkbJ1u1liy/LSz/GDX41Y=;
        b=OVzst4B412ptJjrBeXw8mUDp0TKv+pEc3yx/IVqFfPgMyFqghs9t8Q7ZUdv4JBzhEX
         HJJYTU6nPPwhEpOkFrLjktOrpxo4Mui6ObVKITxN+bdwwwKVm4rn1z1UCLrVyXDeHB91
         Ue0g9DC7QEsMg0lMsPyxfPc+3LF6wU8oTyJg4dtSIOtuAPiFngniuRzlPmQw7vuYjFGp
         ImsWDaLfn/IPe5XR1hhqgEzAuaFhLd+R6ogNqDDBDHyKABqRhFxd/m+u8ZCmyeHHmCXa
         wwpQHKycENk+eMFNqVt1OLSunVBSYLkC3Zr62NGst6DFM5By676TOllR6zb61iPLtEhV
         Ugmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030985; x=1784635785;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dY5vmmnTYG8EsYyRXIz7lhHkbJ1u1liy/LSz/GDX41Y=;
        b=E6YPCDEs7UDWFW51d7j6RSbIBUYEIAiXfMlqvO7ibq2ZniRtxxOnu1PZUnf9Tz9CkW
         jLwfXVOSb5Oky5LCWRSOjXKhUBWjrXU0A56n5c5wIMeHDWvCRRz10LU6UWHSzwU6EvOc
         AVUEEMI0+LNczdakSzIzm9mMXqI56nhZonp32ag22QAqtz5LdSmJcaLutoHWfdro/KYR
         IjnfoiXEHTA9xmPzvej2Vu1cJspWl3/ZfjLLh79Ispb8xS9/vEsxPNznY1TGiPy90e99
         5Ud5w8EcyVSch1H4WWV64oibz/iBWV5TqerX5+0pe3YX0pQarE4DAVN1P63+/sjLg5m9
         bN3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrHr3cXZlEy904aT/H19uUfLpLTM7N7h14t7T8IoF+u20BojNrgWu/yKMr/CnvK83hs0Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JJFw5XmhpTH0dElg7vexs6r7H2GkezO2ay0BBLpLG2k6KS1B
	S604o3TCaS2luPdEWh7PN0lTidSVSqXspAiqOtinrX6J1rql5WS1jzU4
X-Gm-Gg: AfdE7cmomajWfgJ65vNExrBLYYHQ7Dq4Nb065/KzOT/WMMLYoAgTnwutE6knX7iXnmC
	h/Sa/m4/aCJ3vtwVpUya1i3zNeZ9GUMSSHws4meOYYoee/pkTb+nofAgjUmcd0qWP6THUFe++ci
	LCRpLSWA8aovYTO7A1hNlRJJw+CeM2+Hx8uRhscj8fLfL1SfViV2O+7DtYznSpPzTCgkahnWZ5d
	sEbIYYl7pIJJdg1L/phS7HEl1qEX3fozvgbxIseABAzKxIXd9w+3HCGWPYaRDS/oPcMEXucmG9D
	qt7s0QsjIglUURIaoCuMtr61/EibGbmyJTtBTuBPXv0C6ippxYiFbfGYuQ3oC+D+vsXDLN8zHMP
	93/zIXai02G9qZE1nRW8MYK1UuC2Mgr05PS2iMo+jlGPHINirA9X1n4wDSXZ5RmZGNlTA+ScqkG
	AkzI1OA5JmQz+Ao3niws0/KcrArjzvqsNkp3K2FcFdpdPeSBhZbyadcwVPELA5pWDOxNlG6ro80
	h2qFZMCvYFyhhEjRwxOGdhfZzY88LPj3BgrQ4+9/eczaUr+doNJtnHau1CwW+W35clomYH4siFE
	08p6RGgN/07w9BU4rPnGCp6bWd/1lJBjn9Pfry6+KMB8AlIb9Pie0unVMwRl0S+aKnyt2KzKQh4
	Ri0SCTmYU5A==
X-Received: by 2002:a05:6000:400a:b0:46f:7d90:8114 with SMTP id ffacd0b85a97d-47f2dcb50e7mr15601372f8f.14.1784030985263;
        Tue, 14 Jul 2026 05:09:45 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c89e5sm7749939f8f.34.2026.07.14.05.09.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:09:44 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v12 3/7] graph: add a 2 commit buffer for lookahead
Date: Tue, 14 Jul 2026 14:09:34 +0200
Message-ID: <20260714-ps-pre-commit-indent-v12-3-d50938e006df@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
References: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
 <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
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
