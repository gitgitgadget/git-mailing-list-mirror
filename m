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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E68EC432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01668610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhHMVGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbhHMVGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 17:06:06 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B67C0612A4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:39 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id y3-20020a17090a8b03b02901787416b139so8546916pjn.4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7kZt6VPgSJmAAiy//C/YH8WyL+5qNm6bYvonnO1LYZ8=;
        b=CiP9R5Hduaah5vW6kXGqsibXR12vwjzsZGrSXXtjeHMa7bJpzX1Bu/ry32GrjCdTrW
         s4wCzRQSEkzXS1t+fYE/nF7kii9cXqk+aEJo0kjPNETMEzRNv3dQXyN4ic5TQsB+GFLM
         OqSRX28727LtwG4ycK2x7aesZMrw9W4g2XNQNnrd8LCAXd3V6izsOO2CBEx2yQ0z3r+o
         +70fbjAznDGlzSAu8TmncaiHUIRn1/NBM+ev1TeD5P7v06lmHe0t/Z6XiKmhT0wmXO2/
         b2Ccbg1MX24acCTFiZwG2W7rm8mvB45riAzu8sco5PXuHxZtP8Ne9AUqel20zWDWgTXU
         pDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7kZt6VPgSJmAAiy//C/YH8WyL+5qNm6bYvonnO1LYZ8=;
        b=UGyVveM3WVdFHAGAsgUHoVE7hpTRYaA0X9A2Ega3B84/wDrSlA4cYiJ/+z8tPr9qhN
         Qy6faEdgGFXT/r41BFKKRG8glGUpzuhdY8rzFI6Qi4nno3I9GER5cKgy2PcUsdoELo4Q
         YsM2qcvDK06O8BFn3lAWGnh/hssbXs6T+p3SymDaLXrT2ePH0jLMPzm/x7raaN3iWpiS
         Lik0orWpzHYo2LrD8l03ZN8Ee0J9lFLrgFLU0Je26xID7FVE5O+Li3SAtrr6fShW5oZy
         OpjFB2CVLz7wpyIBhpYxQDL4TjxN1wl3ZHnOBvYm9KjzimUBX1FeeUxMyfs4dF2WKFYe
         bRJQ==
X-Gm-Message-State: AOAM533fiqSZmWnBcPEMllwBRlzxcA6N2VE67BzTY7XUgWuLVRkH7hY0
        3KzUYsGBoNR7P+Syk7xbBH2qVMYKDwmnd1Kso6WVIAIWCb19KaSxBL+jYqNK8rd+rgKCaVgfHLb
        kcJI//ciQAf6BizSHzbZkJAg083+qWvZw+mh35KV+LG/ZBPwhQMXio/VR8su9JJVcR+l04gPKNs
        xN
X-Google-Smtp-Source: ABdhPJy/UG7xBHgFT5KBa5JwMEhv8syKyf7+9mQNxPY3IRJfjwHPR8G2Bxi44TbqcqQcL9qUQDZGGMZQSat2cCj0IFAF
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:b40b:b029:12b:997f:5677 with
 SMTP id x11-20020a170902b40bb029012b997f5677mr3526110plr.11.1628888738646;
 Fri, 13 Aug 2021 14:05:38 -0700 (PDT)
Date:   Fri, 13 Aug 2021 14:05:22 -0700
In-Reply-To: <cover.1628888668.git.jonathantanmy@google.com>
Message-Id: <94db10a4e5943d689113693c64633ddffa5508cc.1628888668.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1628888668.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 7/8] submodule-config: pass repo upon blob config read
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reading the config of a submodule, if reading from a blob, read
using an explicitly specified repository instead of by adding the
submodule's ODB as an alternate and then reading an object from
the_repository.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 config.c           | 18 ++++++++++++------
 config.h           |  3 +++
 submodule-config.c |  5 +++--
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index f33abeab85..a85c12e6cc 100644
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
@@ -1820,6 +1821,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 }
 
 static int git_config_from_blob_ref(config_fn_t fn,
+				    struct repository *repo,
 				    const char *name,
 				    void *data)
 {
@@ -1827,7 +1829,7 @@ static int git_config_from_blob_ref(config_fn_t fn,
 
 	if (get_oid(name, &oid) < 0)
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

