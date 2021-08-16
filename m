Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C4FC432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E592060F46
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhHPVKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhHPVKq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:10:46 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0388C06179A
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:13 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id gw9-20020a0562140f0900b0035decb1dfecso8915259qvb.5
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V30LOZoLbytDYm0Esw3hFJf6PP/OMkBwrAJOMroobms=;
        b=ZkqQUjwpPnWPldxRY9K8KEJbzTGTR3kCFNvN9F7Tq5bDt5mVKhbDY1i79n75ZO61gO
         JzyQrJGJ31SxeA1MY8Grhjfhyrq2FJy02DFY/gxdmTH2ol5R9oxE+gPTlMXx23jOLaww
         3xiOXkpNwvasUr+JriE2cvcTGIVSqdthnn3HVANxJEmiBMTlfZ5vT0HthrqM9kuxAvML
         Kqqf3b7C30YmL2CM/GlhJxy7+731R119bS0umIu1yyhgPaop8Da4dPHmaZKUUHv5F8I5
         ZGo1VXU03feaeA8LtB5sgbqWzSWnmQtZqbyHCiw8kb5blTdppjaiz7fOsAQbtJ7zLyAs
         NtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V30LOZoLbytDYm0Esw3hFJf6PP/OMkBwrAJOMroobms=;
        b=Lzsuf+haFXbaPp5Odg5yjvgdpdpH0ghfrn4WTq5O6J2PmVZ9CqvWqqwHpZdkWRp/2m
         mHi8rFkAhr6iQXK2vB2xwqFvMn+yMgo4Gb+OuCzBo4+JDgcW08rATsoNLMGXQ0B6TzOF
         1ZTc5+87dnGC3ZapodQwtncKNDFUVkS8TSKrzLRp7OF1pTeQrflPcGeBkq6qb4kkW4DR
         S1axleiK7SP/HYmXuIjPcU87aUzU1ERS1mTnP5YC31qeFomm7cIMoAgEOSAPak2RZOI3
         IAxl76aNu4UezDuncJHjsOyNntefSYyhVC3wbuRNvHJIL1Lx03Sex7VI9U0yLjw687JP
         RrZw==
X-Gm-Message-State: AOAM5332K62ACHM+0hmkGZ2tO+T+jvvoisp4TGJ28naVy0UL+3by7DGn
        IjOHx+xpH7qOlvGVJ9AwGxbgE85f1CRstWVo/QWSLBTTJ/xxM+tC6x+nrwIZzqeZqg06vo6VUAq
        vqArAjToI6X/YrD+tCLmPjEdkwXKmD1yP+S0ne0Pdt/eiBUQ30277t+/ilwRyCsGUWBAr1yqPD9
        9D
X-Google-Smtp-Source: ABdhPJy9XxVW8y2COQLlGG3JntcWxJtrMRo/cUcPQ6COfKU5c7qcB8sDEYExN28d3UfN72p0SjnDdyzhU2ZffNt50wxE
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:9ce:: with SMTP id
 dp14mr58622qvb.42.1629148212807; Mon, 16 Aug 2021 14:10:12 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:09:57 -0700
In-Reply-To: <cover.1629148153.git.jonathantanmy@google.com>
Message-Id: <8b866185315d14196d191fbafebbd7887b675004.1629148153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1629148153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v3 7/8] submodule-config: pass repo upon blob config read
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reading the config of a submodule, if reading from a blob, read
using an explicitly specified repository instead of by adding the
submodule's ODB as an alternate and then reading an object from
the_repository.

This makes the "grep --recurse-submodules with submodules without
.gitmodules in the working tree" test in t7814 work when
GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB is true.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 config.c           | 20 +++++++++++++-------
 config.h           |  3 +++
 submodule-config.c |  5 +++--
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/config.c b/config.c
index f33abeab85..f401c1d24e 100644
--- a/config.c
+++ b/config.c
@@ -1796,6 +1796,7 @@ int git_config_from_mem(config_fn_t fn,
 
 int git_config_from_blob_oid(config_fn_t fn,
 			      const char *name,
+			      struct repository *repo,
 			      const struct object_id *oid,
 			      void *data)
 {
@@ -1804,7 +1805,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	unsigned long size;
 	int ret;
 
-	buf = read_object_file(oid, &type, &size);
+	buf = repo_read_object_file(repo, oid, &type, &size);
 	if (!buf)
 		return error(_("unable to load config blob object '%s'"), name);
 	if (type != OBJ_BLOB) {
@@ -1820,14 +1821,15 @@ int git_config_from_blob_oid(config_fn_t fn,
 }
 
 static int git_config_from_blob_ref(config_fn_t fn,
+				    struct repository *repo,
 				    const char *name,
 				    void *data)
 {
 	struct object_id oid;
 
-	if (get_oid(name, &oid) < 0)
+	if (repo_get_oid(repo, name, &oid) < 0)
 		return error(_("unable to resolve config blob '%s'"), name);
-	return git_config_from_blob_oid(fn, name, &oid, data);
+	return git_config_from_blob_oid(fn, name, repo, &oid, data);
 }
 
 char *git_system_config(void)
@@ -1958,12 +1960,16 @@ int config_with_options(config_fn_t fn, void *data,
 	 * If we have a specific filename, use it. Otherwise, follow the
 	 * regular lookup sequence.
 	 */
-	if (config_source && config_source->use_stdin)
+	if (config_source && config_source->use_stdin) {
 		return git_config_from_stdin(fn, data);
-	else if (config_source && config_source->file)
+	} else if (config_source && config_source->file) {
 		return git_config_from_file(fn, config_source->file, data);
-	else if (config_source && config_source->blob)
-		return git_config_from_blob_ref(fn, config_source->blob, data);
+	} else if (config_source && config_source->blob) {
+		struct repository *repo = config_source->repo ?
+			config_source->repo : the_repository;
+		return git_config_from_blob_ref(fn, repo, config_source->blob,
+						data);
+	}
 
 	return do_git_config_sequence(opts, fn, data);
 }
diff --git a/config.h b/config.h
index a2200f3111..147f5e0490 100644
--- a/config.h
+++ b/config.h
@@ -49,6 +49,8 @@ const char *config_scope_name(enum config_scope scope);
 struct git_config_source {
 	unsigned int use_stdin:1;
 	const char *file;
+	/* The repository if blob is not NULL; leave blank for the_repository */
+	struct repository *repo;
 	const char *blob;
 	enum config_scope scope;
 };
@@ -136,6 +138,7 @@ int git_config_from_mem(config_fn_t fn,
 			const char *buf, size_t len,
 			void *data, const struct config_options *opts);
 int git_config_from_blob_oid(config_fn_t fn, const char *name,
+			     struct repository *repo,
 			     const struct object_id *oid, void *data);
 void git_config_push_parameter(const char *text);
 void git_config_push_env(const char *spec);
diff --git a/submodule-config.c b/submodule-config.c
index 2026120fb3..f95344028b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -649,9 +649,10 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 			config_source.file = file;
 		} else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0 ||
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
+			config_source.repo = repo;
 			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
 			if (repo != the_repository)
-				add_to_alternates_memory(repo->objects->odb->path);
+				add_submodule_odb_by_path(repo->objects->odb->path);
 		} else {
 			goto out;
 		}
@@ -702,7 +703,7 @@ void gitmodules_config_oid(const struct object_id *commit_oid)
 
 	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
 		git_config_from_blob_oid(gitmodules_cb, rev.buf,
-					 &oid, the_repository);
+					 the_repository, &oid, the_repository);
 	}
 	strbuf_release(&rev);
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

