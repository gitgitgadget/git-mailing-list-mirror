Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 949921F406
	for <e@80x24.org>; Sun, 13 May 2018 05:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeEMFwn (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:43 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32945 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeEMFwa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:30 -0400
Received: by mail-lf0-f65.google.com with SMTP id h9-v6so12381315lfi.0
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZ1UVhHWQ3Ac3ofryy7DaI9VFGyAaYVVRkcgCQnks6U=;
        b=X/LgpsOX4RSIGdUvo9bnxjpt9s/BzL+ptlroDP/vcAVXytaRTSKZuwU+dsmyxPZRXM
         rbsOaMFtcbsJ5z+AS1cbR572doW6q2U5T7qoZOM5ehA9aN43BsaCloaygubjN08SebuJ
         JZ5XqDQXsTaznh7GQANt/lg6xGThzlozZxFsovJUFa8mFhQhQTiYYwaCwXYAkCUY5bgh
         4I1agkFBHlZIJhteCBwLH8WR+yiE+2EZ9cCsHJurTvCA9X1CimK6kUm5dL6fxadC6BWk
         DssgKS508QgPHtFyHwbZ2vJR3cHrLYEPqJEd4yRBIAgtwGyZV5tflPQiaANrqv0F5tzg
         iGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZ1UVhHWQ3Ac3ofryy7DaI9VFGyAaYVVRkcgCQnks6U=;
        b=tAjBUyjZfi5mhHUQ2M35TSu7+yBW3lBS+mpPJ5hNtxGI9KRBzMnh2LBq7cmfmXCAvW
         tbj9DfKeuBNEf9cB4YoTNO7Hl7Mq39YukLQqqWtAchPmpxG+HA5W+X3DbkJe8dqYP3St
         isrGZOB8+iNHrrxLfqvW7+QsFEmtZN94591fmPtfCNedvnU9eZZ4vCThaNP/9Arc3RVX
         hL0UJfzFacEP5QmlkgMy1kDnLOZG9XGwIMApt7FCcbDue/QUk2baZEZsCewzzYtoGprC
         /6mep9+yjZKOa/Y8NzVKnGDZKT47B1jlhgl6D5BHxcK7BUHn2D476z/+98WxNx52WL26
         B7fA==
X-Gm-Message-State: ALKqPweLRybNk3Lm/rz/+Ku6nsPUAF+/XsaemQB6LK/gsWqV/x0rof3X
        DUKovpbCtDxf3epVC74itFegGQ==
X-Google-Smtp-Source: AB8JxZq/nb/I9qMXx3mbdhB4tWXpQb1jtgoj98E4j3RXVgYmu7kz5lP+yfUZ+sEf0uPYIAKG37Hw5g==
X-Received: by 2002:a2e:9e10:: with SMTP id e16-v6mr1914367ljk.108.1526190748298;
        Sat, 12 May 2018 22:52:28 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 13/14] merge: use commit-slab in merge remote desc instead of commit->util
Date:   Sun, 13 May 2018 07:52:07 +0200
Message-Id: <20180513055208.17952-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513055208.17952-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180513055208.17952-1-pclouds@gmail.com>
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

