Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9E21F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfEHPxx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:53:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35795 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfEHPxw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:53:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so4698593edr.2
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o5ihOxM7HtDO1LAqn6SqgiqUqnM47+LCtyPyIIP1Vzk=;
        b=sxXjGSzfc5dQ+wrK3T0hqsqzTI/bT8B7UfkY6yMml82TUZl+ZN0sX9iTIUJDdhzxFS
         dsAf1f1FlTyYPBPBkqeoGWS24vTLxvLb2yakPGHyrKT491pVES7d8SlT5ZJNeA/B/Uxj
         uDRDiJvhHjvOkglP29vy1RYID8qvVKujktt34PIuqvGoWgbxKOYiL/R95thJhUARONsU
         qqCdtYuorglTSGCW3mins2qxaRMavRJ+wD1XGhaXEBzxIgPkZEkDSS7AIIAz/0sHAO8A
         R7xickW5YLxym2emIiG22/TfAFT/NrRqYmlVdNSN/9g3A0SnarYQ33T/1pM/AjXOrivJ
         Exig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o5ihOxM7HtDO1LAqn6SqgiqUqnM47+LCtyPyIIP1Vzk=;
        b=E1q8WnohHrLtiaETV8E4IC6RuuNzfHxt93Tm6uXM+/a8AP4X2zXzb+UJ78duQnImtu
         MGAgi/mYEIArME5KOoUKMVlNZgBk74dFkh44yA8mockgsxpgexZufg68kqlTTEUILhfV
         zT8UiDbinLBT0nMtBBK9RabaAiMkos7tppZWw5+t4Ybgy/c9dmrsNaEdoq6pIvnjYiBw
         j5VATgIqBv8LOpJHnTki5GypW1+SWqRlpu18stwDsp6Jluw6ImMBBfM70BiEQa06K/B+
         U482Jmihrp583JxMvhJth1Ie6sOxcA0X+udHi1q5XJMtVAl6GwwaAGYYCet4VUCJhgxb
         vRFQ==
X-Gm-Message-State: APjAAAVO0O+04aUDHODZd5fbI+twfJyWd+0Ug/NvqzWArW1wgh47/tie
        fVOmFCZZ7ESlm0dVNApDi6lP0Zfe2dg=
X-Google-Smtp-Source: APXvYqwz7Tj479XYyoT6HjkSTQRYdsn1otzcJ2QRl24oRjpCTT+UfqsIrXSzv7QcTV5bavUTDzs97g==
X-Received: by 2002:a17:906:9c9:: with SMTP id r9mr4659088eje.197.1557330830635;
        Wed, 08 May 2019 08:53:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d61sm301254edc.22.2019.05.08.08.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:50 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:50 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:32 GMT
Message-Id: <9299a7fe255a80f3775747a4bc00b1a81d3356f3.1557330826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 03/17] commit-graph: collapse parameters into flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() and write_commit_graph_reachable() methods
currently take two boolean parameters: 'append' and 'report_progress'.
We will soon expand the possible options to send to these methods, so
instead of complicating the parameter list, first simplify it.

Collapse these parameters into a 'flags' parameter, and adjust the
callers to provide flags as necessary.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c | 8 +++++---
 builtin/commit.c       | 2 +-
 builtin/gc.c           | 4 ++--
 commit-graph.c         | 9 +++++----
 commit-graph.h         | 8 +++++---
 5 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 2e86251f02..828b1a713f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -142,6 +142,7 @@ static int graph_write(int argc, const char **argv)
 	struct string_list *commit_hex = NULL;
 	struct string_list lines;
 	int result;
+	int flags = COMMIT_GRAPH_PROGRESS;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -166,11 +167,13 @@ static int graph_write(int argc, const char **argv)
 		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
+	if (opts.append)
+		flags |= COMMIT_GRAPH_APPEND;
 
 	read_replace_refs = 0;
 
 	if (opts.reachable)
-		return write_commit_graph_reachable(opts.obj_dir, opts.append, 1);
+		return write_commit_graph_reachable(opts.obj_dir, flags);
 
 	string_list_init(&lines, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
@@ -190,8 +193,7 @@ static int graph_write(int argc, const char **argv)
 	result = write_commit_graph(opts.obj_dir,
 				    pack_indexes,
 				    commit_hex,
-				    opts.append,
-				    1);
+				    flags);
 
 	UNLEAK(lines);
 	return result;
diff --git a/builtin/commit.c b/builtin/commit.c
index b9ea7222fa..b001ef565d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1670,7 +1670,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-	    write_commit_graph_reachable(get_object_directory(), 0, 0))
+	    write_commit_graph_reachable(get_object_directory(), 0))
 		return 1;
 
 	repo_rerere(the_repository, 0);
diff --git a/builtin/gc.c b/builtin/gc.c
index 3984addf73..df2573f124 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -665,8 +665,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	}
 
 	if (gc_write_commit_graph &&
-	    write_commit_graph_reachable(get_object_directory(), 0,
-					 !quiet && !daemonized))
+	    write_commit_graph_reachable(get_object_directory(),
+					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0))
 		return 1;
 
 	if (auto_gc && too_many_loose_objects())
diff --git a/commit-graph.c b/commit-graph.c
index ee487a364b..8bbd50658c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -851,15 +851,14 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
-int write_commit_graph_reachable(const char *obj_dir, int append,
-				 int report_progress)
+int write_commit_graph_reachable(const char *obj_dir, unsigned int flags)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
 	int result;
 
 	for_each_ref(add_ref_to_list, &list);
 	result = write_commit_graph(obj_dir, NULL, &list,
-				    append, report_progress);
+				    flags);
 
 	string_list_clear(&list, 0);
 	return result;
@@ -868,7 +867,7 @@ int write_commit_graph_reachable(const char *obj_dir, int append,
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       int append, int report_progress)
+		       unsigned int flags)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -887,6 +886,8 @@ int write_commit_graph(const char *obj_dir,
 	struct strbuf progress_title = STRBUF_INIT;
 	unsigned long approx_nr_objects;
 	int res = 0;
+	int append = flags & COMMIT_GRAPH_APPEND;
+	int report_progress = flags & COMMIT_GRAPH_PROGRESS;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
diff --git a/commit-graph.h b/commit-graph.h
index d15670bf46..70f4caf0c7 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -65,12 +65,14 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
  */
 int generation_numbers_enabled(struct repository *r);
 
-int write_commit_graph_reachable(const char *obj_dir, int append,
-				  int report_progress);
+#define COMMIT_GRAPH_APPEND     (1 << 0)
+#define COMMIT_GRAPH_PROGRESS   (1 << 1)
+
+int write_commit_graph_reachable(const char *obj_dir, unsigned int flags);
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       int append, int report_progress);
+		       unsigned int flags);
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
-- 
gitgitgadget

