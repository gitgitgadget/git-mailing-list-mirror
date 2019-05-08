Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB021F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfEHPxz (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:53:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35802 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfEHPxy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:53:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so4698705edr.2
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0ay1OwqMXDNzHrxRUO+Eyr9+cg6irR7gpIuycBbKZLI=;
        b=obB9+JavDe0FJfP32bBaHMjKB3qt0A2fYSks9R7BAoU5Au38g04k5GVihE9yPtY7cJ
         1yRhNvWVSLD/TmS4oWyhCcggy0GDz7FcwuRWSS7Dq8t9hqcM6VnUtuWMupdlhcKHJJcX
         GwuQk90hm1jGqCYWxO1l8N0uhJS4T15y6pWO/5uijW7pzuCaPfUoowT1kM1gaogT1jZz
         HzH0eBWtgKBFec5e6a3yIqUcjsYbV+mNI/ffvgHBgjsw1j097YhFDVCJ0QRhzNGuI+Mm
         yVDdwy+8VrEWNx2/BBwUqETm7/HdZG8RsBmKd2duiDj0QKFodzfUejIXRnrf63Kc0joM
         2Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0ay1OwqMXDNzHrxRUO+Eyr9+cg6irR7gpIuycBbKZLI=;
        b=sWXG/dHWre8CviVCHaSqETZhvPTuZzdV6Xnny0EtQt6e8fgeccJS3hD8S5wD6BzqBM
         2q5KdERbqrIFyDUQ3kl56tj2D18IFBAl7H1/mmUNJFGql49moX5K7bc9Lpd3FDdGbZ6M
         9ftgmAdLChSK/P9Bt+t0728M/bBtRvb9IbnfOwew2Gw7wRPFi+6ygeh1KUQY8yR1z9en
         sygNKlTN7V8Kr3FbsKwOzSkDsQfjEpBgFe8wvcMtbwY+DuFuJ61dfVLEzrttSpzRM2N3
         9RdMkJkxhR2A9sJbT3Wtr8ZEFZrLyAUfUeSJIioyEF+cZ3mzNJ/qgcVTl3kUN7Ltv1IR
         PV8w==
X-Gm-Message-State: APjAAAWzyzyyUledeDuzbxUY8BY80tLHgEhp9UDeOoes4iCymqiGGIYQ
        qle7cYspvnkJudgE89foGajZsa0rxks=
X-Google-Smtp-Source: APXvYqyC0xlNKr2AjRtmhaJSGtHO5AkUhr9mwxdYRXZa4hizZRSsAK9K5GTMWWgKb9OYPC8beBO6uA==
X-Received: by 2002:a50:b33d:: with SMTP id q58mr40341764edd.46.1557330832947;
        Wed, 08 May 2019 08:53:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r20sm775513edx.46.2019.05.08.08.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:52 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:52 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:35 GMT
Message-Id: <54817ef50b857257d826d1880714400ee4019980.1557330827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 06/17] commit-graph: extract fill_oids_from_packs()
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

The write_commit_graph() method is too complex, so we are
extracting methods one by one.

This extracts fill_oids_from_packs() that reads the given
pack-file list and fills the oid list in the context.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 83 ++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 58f0f0ae34..80c7069aaa 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -867,6 +867,51 @@ int write_commit_graph_reachable(const char *obj_dir, unsigned int flags)
 	return result;
 }
 
+static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
+				struct string_list *pack_indexes)
+{
+	uint32_t i;
+	struct strbuf progress_title = STRBUF_INIT;
+	struct strbuf packname = STRBUF_INIT;
+	int dirlen;
+
+	strbuf_addf(&packname, "%s/pack/", ctx->obj_dir);
+	dirlen = packname.len;
+	if (ctx->report_progress) {
+		strbuf_addf(&progress_title,
+			    Q_("Finding commits for commit graph in %d pack",
+			       "Finding commits for commit graph in %d packs",
+			       pack_indexes->nr),
+			    pack_indexes->nr);
+		ctx->progress = start_delayed_progress(progress_title.buf, 0);
+		ctx->progress_done = 0;
+	}
+	for (i = 0; i < pack_indexes->nr; i++) {
+		struct packed_git *p;
+		strbuf_setlen(&packname, dirlen);
+		strbuf_addstr(&packname, pack_indexes->items[i].string);
+		p = add_packed_git(packname.buf, packname.len, 1);
+		if (!p) {
+			error(_("error adding pack %s"), packname.buf);
+			return 1;
+		}
+		if (open_pack_index(p)) {
+			error(_("error opening index for %s"), packname.buf);
+			return 1;
+		}
+		for_each_object_in_pack(p, add_packed_commits, ctx,
+					FOR_EACH_OBJECT_PACK_ORDER);
+		close_pack(p);
+		free(p);
+	}
+
+	stop_progress(&ctx->progress);
+	strbuf_reset(&progress_title);
+	strbuf_release(&packname);
+
+	return 0;
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -916,42 +961,8 @@ int write_commit_graph(const char *obj_dir,
 	}
 
 	if (pack_indexes) {
-		struct strbuf packname = STRBUF_INIT;
-		int dirlen;
-		strbuf_addf(&packname, "%s/pack/", obj_dir);
-		dirlen = packname.len;
-		if (ctx->report_progress) {
-			strbuf_addf(&progress_title,
-				    Q_("Finding commits for commit graph in %d pack",
-				       "Finding commits for commit graph in %d packs",
-				       pack_indexes->nr),
-				    pack_indexes->nr);
-			ctx->progress = start_delayed_progress(progress_title.buf, 0);
-			ctx->progress_done = 0;
-		}
-		for (i = 0; i < pack_indexes->nr; i++) {
-			struct packed_git *p;
-			strbuf_setlen(&packname, dirlen);
-			strbuf_addstr(&packname, pack_indexes->items[i].string);
-			p = add_packed_git(packname.buf, packname.len, 1);
-			if (!p) {
-				error(_("error adding pack %s"), packname.buf);
-				res = 1;
-				goto cleanup;
-			}
-			if (open_pack_index(p)) {
-				error(_("error opening index for %s"), packname.buf);
-				res = 1;
-				goto cleanup;
-			}
-			for_each_object_in_pack(p, add_packed_commits, ctx,
-						FOR_EACH_OBJECT_PACK_ORDER);
-			close_pack(p);
-			free(p);
-		}
-		stop_progress(&ctx->progress);
-		strbuf_reset(&progress_title);
-		strbuf_release(&packname);
+		if ((res = fill_oids_from_packs(ctx, pack_indexes)))
+			goto cleanup;
 	}
 
 	if (commit_hex) {
-- 
gitgitgadget

