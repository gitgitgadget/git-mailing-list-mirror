Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BB1C3B186
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 19:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2532082F
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 19:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUFUIrso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgBLTTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:19:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37663 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgBLTTS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 14:19:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so3897048wme.2
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 11:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bjca4lUKYkiBa+OMZiYnhehzASik8aKDOv7oz8rTvNk=;
        b=JUFUIrsoBLB+gTPlmDi3OGsmamJuIgvIdFcENBC4XBJJTcCDsO4BfGFVGx0uZ9fVBe
         Aqj5+YwT5p9idQhAVylNnLc5AP6STf3jPfivyuNYaqmaGouZ3r378RcYbvQCjF5xSrBE
         hgNzUCrrS7PmE6kPsjOl7/x83dyN9DHgA01chugKTlBiwKCmogCasDcFFJn34s5NWuGR
         f0+ht4VzCRGTLLIEuSz4xbrK6Hrd6gYAvaeBmHvvX0uGAufLHH2U+XXDk85ZZncICeBq
         mnEsnEYUMNr8WcaD5rSVNQBWxabRvGHhxhu8Daft7eP2JSxBKx8LYz0gr3qltYFWVbyP
         da4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bjca4lUKYkiBa+OMZiYnhehzASik8aKDOv7oz8rTvNk=;
        b=gcGF1WedJgxjsFX3A4NHIt2o9VIRj92O963LM+FrZOqKsEKgGTDb7gORHDjbGqCw+e
         MZgRxb3H4Y4LX/R8cgOGXarM3x9Jy2XcSBzT9Nn1mMRejCcLfKthu/7YIVgkAvldA5CT
         RDdTLVEycmvItjHvRibVn4v0IurbdWridoF/bosRytfqB83/sAF002vUtwH0hhDuI3Hg
         +fTJTyhgEmFWMOaSVQOoCNndlzoHOoJoXbQwti/3mI0chGA1G5A9Jh5ECo0/Wrae7wfk
         f9/BbdNQrOyO5YUV2lGnLb6KCPTBBagJm/3HJt7rrjR5FGLXgEUoUaamgeW1B/UIhxgI
         qkPg==
X-Gm-Message-State: APjAAAUCMGHTEzth6rgKZFP+h2laW9vqMaiWnFq2AbW2VJsQ2YgD/x2F
        F2mL8enOAR/sZvW2O/+3g4kR0Zky
X-Google-Smtp-Source: APXvYqzPZRY+pvqjk8auJ5qOooRIJcFCkb7zj9uDzE+7y9PMzoZ3Arm5FgZo7L4QqkgljywbMX22uA==
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr642571wme.26.1581535155466;
        Wed, 12 Feb 2020 11:19:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f11sm1818796wml.3.2020.02.12.11.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 11:19:14 -0800 (PST)
Message-Id: <a8202cc5353d274f6278f2350ae1371af0a093d5.1581535151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.545.git.1581535151.gitgitgadget@gmail.com>
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
From:   "Parth Gala via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Feb 2020 19:19:10 +0000
Subject: [PATCH 4/5] object.c: clear_object_flags() accept 'r' as parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Parth Gala <parthpgala@gmail.com>,
        Parth Gala <parthpgala@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Parth Gala <parthpgala@gmail.com>

'clear_object_flags()' and its callers are modified to enable
passing 'r' as an argument to 'clear_object_flags()'.

Signed-off-by: Parth Gala <parthpgala@gmail.com>
---
 builtin/log.c | 3 ++-
 object.c      | 6 +++---
 object.h      | 2 +-
 revision.c    | 3 ++-
 shallow.c     | 3 ++-
 upload-pack.c | 2 +-
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 83a4a6188e..b163d2fbdf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1592,6 +1592,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
 	struct commit **list = NULL;
+	struct repository *r = the_repository;
 	struct rev_info rev;
 	struct setup_revision_opt s_r_opt;
 	int nr = 0, total, i;
@@ -1998,7 +1999,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (base_commit) {
 		struct commit *base = get_base_commit(base_commit, list, nr);
 		reset_revision_walk();
-		clear_object_flags(UNINTERESTING);
+		clear_object_flags(r, UNINTERESTING);
 		prepare_bases(&bases, base, list, nr);
 	}
 
diff --git a/object.c b/object.c
index 0a7a278c88..804488c8dd 100644
--- a/object.c
+++ b/object.c
@@ -432,12 +432,12 @@ void object_array_remove_duplicates(struct object_array *array)
 	}
 }
 
-void clear_object_flags(unsigned flags)
+void clear_object_flags(struct repository *r, unsigned flags)
 {
 	int i;
 
-	for (i=0; i < the_repository->parsed_objects->obj_hash_size; i++) {
-		struct object *obj = the_repository->parsed_objects->obj_hash[i];
+	for (i=0; i < r->parsed_objects->obj_hash_size; i++) {
+		struct object *obj = r->parsed_objects->obj_hash[i];
 		if (obj)
 			obj->flags &= ~flags;
 	}
diff --git a/object.h b/object.h
index 92af2ead8f..bfc95e062a 100644
--- a/object.h
+++ b/object.h
@@ -185,7 +185,7 @@ void object_array_remove_duplicates(struct object_array *array);
  */
 void object_array_clear(struct object_array *array);
 
-void clear_object_flags(unsigned flags);
+void clear_object_flags(struct repository *, unsigned flags);
 
 /*
  * Clear the specified object flags from all in-core commit objects.
diff --git a/revision.c b/revision.c
index 8136929e23..ac32ecf2e2 100644
--- a/revision.c
+++ b/revision.c
@@ -3086,7 +3086,8 @@ static void set_children(struct rev_info *revs)
 
 void reset_revision_walk(void)
 {
-	clear_object_flags(SEEN | ADDED | SHOWN | TOPO_WALK_EXPLORED | TOPO_WALK_INDEGREE);
+	struct repository *r = the_repository;
+	clear_object_flags(r, SEEN | ADDED | SHOWN | TOPO_WALK_EXPLORED | TOPO_WALK_INDEGREE);
 }
 
 static int mark_uninteresting(const struct object_id *oid,
diff --git a/shallow.c b/shallow.c
index 4537d98482..d32adbe088 100644
--- a/shallow.c
+++ b/shallow.c
@@ -180,6 +180,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 {
 	struct commit_list *result = NULL, *p;
 	struct commit_list *not_shallow_list = NULL;
+	struct repository *r = the_repository;
 	struct rev_info revs;
 	int both_flags = shallow_flag | not_shallow_flag;
 
@@ -187,7 +188,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	 * SHALLOW (excluded) and NOT_SHALLOW (included) should not be
 	 * set at this point. But better be safe than sorry.
 	 */
-	clear_object_flags(both_flags);
+	clear_object_flags(r, both_flags);
 
 	is_repository_shallow(the_repository); /* make sure shallows are read */
 
diff --git a/upload-pack.c b/upload-pack.c
index daea9059f0..e296f2cfa8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1472,7 +1472,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	struct object_array have_obj = OBJECT_ARRAY_INIT;
 	struct object_array want_obj = OBJECT_ARRAY_INIT;
 
-	clear_object_flags(ALL_FLAGS);
+	clear_object_flags(r, ALL_FLAGS);
 
 	git_config(upload_pack_config, NULL);
 
-- 
gitgitgadget

