Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C86931F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751048AbeELIAs (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:00:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33726 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeELIAp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id h9-v6so10060432lfi.0
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZ1UVhHWQ3Ac3ofryy7DaI9VFGyAaYVVRkcgCQnks6U=;
        b=kx1yKvb3HyTc24WuX+pIneg1FQPX5cTRBrUpP20x+EMs4XSbMA8CC3iMqSG7h6FytJ
         T3npPW8gDMvqicALODcGSl9vvgKHjsswqOLb1zAiGO12sk+hGvXd5f/g8Ena/mS8s69T
         dibbM1Y7C8tgtzmXI/awcUKkkUx3EEWwdQ89nR1pYdCUgFmE5/KvE/1vm08lpsW0RCSa
         z3bp8eNziWwteJcZij9eZ7+eBwlJKkuKXYzcwN4EXASo8Ma5mrDzjc7kIrQ6ZhZQtRG3
         Ej3ebO1R1mI0wL12djk+PgXzDs9QAGCEAtxOisw7NG6iJkOOwbLAD8PNGXpLShz2g0sl
         1cyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZ1UVhHWQ3Ac3ofryy7DaI9VFGyAaYVVRkcgCQnks6U=;
        b=kUwQ9n6NGpjyVNvXL9ayiPSV7CZPnzTnPnBT76TiwnAM+apDHxP8Xuc0i75wvOl8Mb
         Bi98NsPtlzzFQmHlKmNhN+/UOp6jvn1PrCuYBVXj5Td9PepedgJvnoOURk0+xdDE4Qxn
         saJhKiT6JpkRovnQVpTZe5uBZTXHOdu586n2jbf9QmtQ8SzpZZ4rCEQkBW9WUd1t/EPu
         XCCOd5mjczWYRgAWmhjdJsHKbDM9bznfTfP3aI093qJaNAZQJzkBzKxjLhKPu9nsxUtk
         5AtmyqTyt7XyMWn5EAM4XJiZkIPVUwdWSDH8cnZpymzsIwSdhHHiEUjDf0O4FhiNDZIk
         NFvA==
X-Gm-Message-State: ALKqPweokbqg1sxCb7u8vTI4ZoTkpyu1vP7aysyor9W+GBbpssAXO0cK
        isjPvpOVJHCOTszn9vhsauQ3sQ==
X-Google-Smtp-Source: AB8JxZpU6AASUVcImyRlK/TzWdwEf3gUqAkdliPn0Q+q2hiHSJfDshzJyevq1uRxqScUC5TYYmh84Q==
X-Received: by 2002:a2e:8993:: with SMTP id c19-v6mr535846lji.123.1526112043267;
        Sat, 12 May 2018 01:00:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/12] merge: use commit-slab in merge remote desc instead of commit->util
Date:   Sat, 12 May 2018 10:00:27 +0200
Message-Id: <20180512080028.29611-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/merge.c   | 25 +++++++++++++------------
 commit.c          | 12 ++++++++++--
 commit.h          |  2 +-
 merge-recursive.c |  8 +++++---
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9db5a2cf16..fc55bc264b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -443,6 +443,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	struct object_id branch_head;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf bname = STRBUF_INIT;
+	struct merge_remote_desc *desc;
 	const char *ptr;
 	char *found_ref;
 	int len, early;
@@ -515,16 +516,13 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		strbuf_release(&truname);
 	}
 
-	if (remote_head->util) {
-		struct merge_remote_desc *desc;
-		desc = merge_remote_util(remote_head);
-		if (desc && desc->obj && desc->obj->type == OBJ_TAG) {
-			strbuf_addf(msg, "%s\t\t%s '%s'\n",
-				    oid_to_hex(&desc->obj->oid),
-				    type_name(desc->obj->type),
-				    remote);
-			goto cleanup;
-		}
+	desc = merge_remote_util(remote_head);
+	if (desc && desc->obj && desc->obj->type == OBJ_TAG) {
+		strbuf_addf(msg, "%s\t\t%s '%s'\n",
+			    oid_to_hex(&desc->obj->oid),
+			    type_name(desc->obj->type),
+			    remote);
+		goto cleanup;
 	}
 
 	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
@@ -932,8 +930,11 @@ static void write_merge_heads(struct commit_list *remoteheads)
 	for (j = remoteheads; j; j = j->next) {
 		struct object_id *oid;
 		struct commit *c = j->item;
-		if (c->util && merge_remote_util(c)->obj) {
-			oid = &merge_remote_util(c)->obj->oid;
+		struct merge_remote_desc *desc;
+
+		desc = merge_remote_util(c);
+		if (desc && desc->obj) {
+			oid = &desc->obj->oid;
 		} else {
 			oid = &c->object.oid;
 		}
diff --git a/commit.c b/commit.c
index 57049118a5..8202067cd5 100644
--- a/commit.c
+++ b/commit.c
@@ -1574,13 +1574,21 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	return result;
 }
 
+define_commit_slab(merge_desc_slab, struct merge_remote_desc *);
+struct merge_desc_slab merge_desc_slab = COMMIT_SLAB_INIT(1, merge_desc_slab);
+
+struct merge_remote_desc *merge_remote_util(struct commit *commit)
+{
+	return *merge_desc_slab_at(&merge_desc_slab, commit);
+}
+
 void set_merge_remote_desc(struct commit *commit,
 			   const char *name, struct object *obj)
 {
 	struct merge_remote_desc *desc;
 	FLEX_ALLOC_STR(desc, name, name);
 	desc->obj = obj;
-	commit->util = desc;
+	*merge_desc_slab_at(&merge_desc_slab, commit) = desc;
 }
 
 struct commit *get_merge_parent(const char *name)
@@ -1592,7 +1600,7 @@ struct commit *get_merge_parent(const char *name)
 		return NULL;
 	obj = parse_object(&oid);
 	commit = (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
-	if (commit && !commit->util)
+	if (commit && !merge_remote_util(commit))
 		set_merge_remote_desc(commit, name, obj);
 	return commit;
 }
diff --git a/commit.h b/commit.h
index e57ae4b583..838f6a6b26 100644
--- a/commit.h
+++ b/commit.h
@@ -303,7 +303,7 @@ struct merge_remote_desc {
 	struct object *obj; /* the named object, could be a tag */
 	char name[FLEX_ARRAY];
 };
-#define merge_remote_util(commit) ((struct merge_remote_desc *)((commit)->util))
+extern struct merge_remote_desc *merge_remote_util(struct commit *);
 extern void set_merge_remote_desc(struct commit *commit,
 				  const char *name, struct object *obj);
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 0c0d48624d..5537f01f8e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -223,10 +223,12 @@ static void output(struct merge_options *o, int v, const char *fmt, ...)
 
 static void output_commit_title(struct merge_options *o, struct commit *commit)
 {
+	struct merge_remote_desc *desc;
+
 	strbuf_addchars(&o->obuf, ' ', o->call_depth * 2);
-	if (commit->util)
-		strbuf_addf(&o->obuf, "virtual %s\n",
-			merge_remote_util(commit)->name);
+	desc = merge_remote_util(commit);
+	if (desc)
+		strbuf_addf(&o->obuf, "virtual %s\n", desc->name);
 	else {
 		strbuf_add_unique_abbrev(&o->obuf, &commit->object.oid,
 					 DEFAULT_ABBREV);
-- 
2.17.0.705.g3525833791

