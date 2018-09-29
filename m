Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A941F453
	for <e@80x24.org>; Sat, 29 Sep 2018 19:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeI3BkZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:40:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39816 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeI3BkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:40:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id 5-v6so8700329lju.6
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 12:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eDaz944Md18kLFfnZS3EhOlwiserwQ2TRsWkWypeW4=;
        b=IhSf99prFanbZGCJ4xFnccIVHVH/i/Op+UcaMonAlPzz0mbpbN4yyZ2ae4SYzw8k9r
         vVIzaG0GMKXhb4+wPqzTN1V3tBHWRF0QCK/bS4SaqWBCDjUQhZHQreGH0y4dFpKxZx42
         nDad/YYpO3n8kgqR4vMR/t9epp3XE3DgWITRdbwtqVrPLb3sOtDB89VYCkHfPX5rfvLg
         NPMFxvNUex4w0V/19vYLdMFhGqNhcJ4Usynm0r640tdn1OVn3+b69AVk6n9q+5mxtYSs
         AdvjcIsvDptVLLSjEiXZBEwCfH4q2X7P2EsyXb8DDEPELpgaeq9azNrAvNb3iEzPKLRf
         s17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eDaz944Md18kLFfnZS3EhOlwiserwQ2TRsWkWypeW4=;
        b=MzGrg/E/p41jW9rZWlvYLqzuZF350rRFdsWgDDptNLBqQNLyNiMZXE0zgwCZc0Fh1D
         jOLTA9lpEdM/WxRlB7h3Sro/A0QuQDzQ7f1rXOW8bM1lOyO3uVZlGcQtRbIrh9HG2Ybf
         uzx9alBcoFUffYF21ON90V8UCoNVPg/Uv86F7ySWIz2Cns7V+h6WjvWMAUlI1JnxbOaY
         Y9sBnO33pJ5pIYxEJPkvSUpcUw5vHZTGCqsVMHM8qZB/ADi2w8PIOZ8Ji5IJQz9Hg5Dm
         jWi7taeg8favVqSJqD/2Z4nvSE8J9x16caZM1HuppKGoYApMDVOBxq4Z5dIldVE6eWB1
         RL1Q==
X-Gm-Message-State: ABuFfojbbYe1hRFlSCYhPUZepQkWJcQ6apcHqvafYpZ+bJl6GC4gA+3Y
        M8NBNuOSKYKk2Mo7q9GR08E=
X-Google-Smtp-Source: ACcGV61JgFzujwr3HT7gtthBaza8bbManxDMRGLLKE7tCBayhCxjeVlXKYriFwmyUBG9EQ/FMCFNCA==
X-Received: by 2002:a2e:7c18:: with SMTP id x24-v6mr2480263ljc.174.1538248248052;
        Sat, 29 Sep 2018 12:10:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c14-v6sm1638494lfi.23.2018.09.29.12.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:10:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 5/8] revision.c: better error reporting on ref from different worktrees
Date:   Sat, 29 Sep 2018 21:10:26 +0200
Message-Id: <20180929191029.13994-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
In-Reply-To: <20180929191029.13994-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
 <20180929191029.13994-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of the new ref aliases to pass refs from another worktree
around and access them from the current ref store instead. This does
not change any functionality, but when a problem arises, we would like
the reported messages to mention full ref aliases, like this:

    fatal: bad object worktrees/ztemp/HEAD
    warning: reflog of 'main-worktree/HEAD' references pruned commits

instead of

    fatal: bad object HEAD
    warning: reflog of 'HEAD' references pruned commits

which does not really tell where the refs are from.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 21 +++++++++++++--------
 worktree.c | 32 +++++++++++++++++++++++++++++---
 worktree.h | 14 ++++++++++++++
 3 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/revision.c b/revision.c
index 63aae722c1..8ce660e3b1 100644
--- a/revision.c
+++ b/revision.c
@@ -1177,7 +1177,7 @@ struct all_refs_cb {
 	int warned_bad_reflog;
 	struct rev_info *all_revs;
 	const char *name_for_errormsg;
-	struct ref_store *refs;
+	struct worktree *wt;
 };
 
 int ref_excluded(struct string_list *ref_excludes, const char *path)
@@ -1214,7 +1214,7 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 	cb->all_revs = revs;
 	cb->all_flags = flags;
 	revs->rev_input_given = 1;
-	cb->refs = NULL;
+	cb->wt = NULL;
 }
 
 void clear_ref_exclusion(struct string_list **ref_excludes_p)
@@ -1277,15 +1277,20 @@ static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
-static int handle_one_reflog(const char *refname,
+static int handle_one_reflog(const char *refname_in_wt,
 			     const struct object_id *oid,
 			     int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
+	struct strbuf refname = STRBUF_INIT;
+
 	cb->warned_bad_reflog = 0;
-	cb->name_for_errormsg = refname;
-	refs_for_each_reflog_ent(cb->refs, refname,
+	strbuf_worktree_ref(cb->wt, &refname, refname_in_wt);
+	cb->name_for_errormsg = refname.buf;
+	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+				 refname.buf,
 				 handle_one_reflog_ent, cb_data);
+	strbuf_release(&refname);
 	return 0;
 }
 
@@ -1300,8 +1305,8 @@ static void add_other_reflogs_to_pending(struct all_refs_cb *cb)
 		if (wt->is_current)
 			continue;
 
-		cb->refs = get_worktree_ref_store(wt);
-		refs_for_each_reflog(cb->refs,
+		cb->wt = wt;
+		refs_for_each_reflog(get_worktree_ref_store(wt),
 				     handle_one_reflog,
 				     cb);
 	}
@@ -1314,7 +1319,7 @@ void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 
 	cb.all_revs = revs;
 	cb.all_flags = flags;
-	cb.refs = get_main_ref_store(the_repository);
+	cb.wt = NULL;
 	for_each_reflog(handle_one_reflog, &cb);
 
 	if (!revs->single_worktree)
diff --git a/worktree.c b/worktree.c
index b0d0b5426d..ec1a5bc511 100644
--- a/worktree.c
+++ b/worktree.c
@@ -487,6 +487,28 @@ int submodule_uses_worktrees(const char *path)
 	return ret;
 }
 
+void strbuf_worktree_ref(const struct worktree *wt,
+			 struct strbuf *sb,
+			 const char *refname)
+{
+	if (wt && !wt->is_current) {
+		if (is_main_worktree(wt))
+			strbuf_addstr(sb, "main/");
+		else
+			strbuf_addf(sb, "worktrees/%s/", wt->id);
+	}
+	strbuf_addstr(sb, refname);
+}
+
+const char *worktree_ref(const struct worktree *wt, const char *refname)
+{
+	static struct strbuf sb = STRBUF_INIT;
+
+	strbuf_reset(&sb);
+	strbuf_worktree_ref(wt, &sb, refname);
+	return sb.buf;
+}
+
 int other_head_refs(each_ref_fn fn, void *cb_data)
 {
 	struct worktree **worktrees, **p;
@@ -495,13 +517,17 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 	worktrees = get_worktrees(0);
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
-		struct ref_store *refs;
+		struct object_id oid;
+		int flag;
 
 		if (wt->is_current)
 			continue;
 
-		refs = get_worktree_ref_store(wt);
-		ret = refs_head_ref(refs, fn, cb_data);
+		if (!refs_read_ref_full(get_main_ref_store(the_repository),
+					worktree_ref(wt, "HEAD"),
+					RESOLVE_REF_READING,
+					&oid, &flag))
+			ret = fn(worktree_ref(wt, "HEAD"), &oid, flag, cb_data);
 		if (ret)
 			break;
 	}
diff --git a/worktree.h b/worktree.h
index df3fc30f73..0016eb9e88 100644
--- a/worktree.h
+++ b/worktree.h
@@ -108,4 +108,18 @@ extern const char *worktree_git_path(const struct worktree *wt,
 				     const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
+/*
+ * Return a refname suitable for access from the current ref store.
+ */
+void strbuf_worktree_ref(const struct worktree *wt,
+			 struct strbuf *sb,
+			 const char *refname);
+
+/*
+ * Return a refname suitable for access from the current ref
+ * store. The result may be destroyed at the next call.
+ */
+const char *worktree_ref(const struct worktree *wt,
+			 const char *refname);
+
 #endif
-- 
2.19.0.341.g3acb95d729

