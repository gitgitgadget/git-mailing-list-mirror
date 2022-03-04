Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3DDC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbiCDA7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbiCDA7N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:59:13 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99134EFFBD
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:58:26 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id j10-20020a17090a7e8a00b001bbef243093so6385004pjl.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vdbgcs2Fpier1UCS12yHjFqUWjg8CLpnX1fa82efzXc=;
        b=rITIIE9rx1FtRoIslcKG/QabqGlI0T4Ebh7q4jb15+gkLyURlc5olx+nstkTpJKHxj
         BYqyaWdwV0usmuDLt2bdWvdBFuVIjbys5tjmGmlFNHk3qLs34kZ2N4mqOfwjqHmfVH9D
         qQMwZkhk1lK6W8r9dUtjFxScwCAJHreokfMsSRHCyPzzbhWZ/pJsgwMZryaQ3m+CKvFj
         wLuKszfQ8qQT/RsAG+Jm2UX+x+t5NbEWM51MMKMO196bT/hOAxwG0jP14QrOSTHQM52O
         fh09i/ZcX6acKFHB1XPczspoNwbhOWlQLzJ1T72EIZbHrM3ItlfOPSMDZPEdx5gUBGN8
         pZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vdbgcs2Fpier1UCS12yHjFqUWjg8CLpnX1fa82efzXc=;
        b=6RVrS4ERwCtVzGQR0522Z8NBTYMzQ2UkEcfOVXKmCKOIhzOI1mkKyqn/g5fhtMaHvC
         MnOolpmBlMTurZ6jQnOXsWr856KTHslN7CP6HnVBZaPvz4M4yPwRDvOezVJPe6/sheM5
         3bsr7Ia7TDgOwQaLBBO8HOhjtTVXwDfZqQwyN3hgThyxbXGgT1cHGxW9TfpfFjMEka2B
         DzUDbcyrN0ocRyla/yVrVAT1vP2bDN06bm2tuaqoIaPfUcSuJnXoYRyPrl3gkUmFO3iP
         dMfbYRlN5EcGF5P6+tKQHXZq27ff+DxSZ3yi1Bf6jeCQxqx0DkIh1TImZ6ueECHIscQQ
         duqg==
X-Gm-Message-State: AOAM530GridOmeRd/ELPWmWdUVlK5kZn3yNWkhdYCSGh9hIbYgmWkhNR
        RDGkWldvGqMETZWZVZcubvZhOxJLnhvyx8ZYvi/u4EGMnLVJTnTvVSXW66g/5mpSLXvRdr/g743
        jz3NH4L7tovzxT2HvQJ0ODBPiQ2n4oRULK3WMfdbr8tRozhFvq2dp54YnmseG7ZY=
X-Google-Smtp-Source: ABdhPJzRVHWI3zph0hRG8AwZkd70/PDAO2+OwbeS6N/BlcL7D45ZhY3mIcT5E0OXJP1KMos7nfUh7ApXKGYxtw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:88c6:0:b0:37c:4e10:1a1f with SMTP id
 l189-20020a6388c6000000b0037c4e101a1fmr6231344pgd.162.1646355505910; Thu, 03
 Mar 2022 16:58:25 -0800 (PST)
Date:   Thu,  3 Mar 2022 16:57:57 -0800
In-Reply-To: <20220304005757.70107-1-chooglen@google.com>
Message-Id: <20220304005757.70107-11-chooglen@google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com> <20220304005757.70107-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 10/10] submodule: fix latent check_has_commit() bug
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When check_has_commit() is called on a missing submodule, initialization
of the struct repository fails, but it attempts to clear the struct
anyway (which is a fatal error). This bug is masked by its only caller,
submodule_has_commits(), first calling add_submodule_odb(). The latter
fails if the submodule does not exist, making submodule_has_commits()
exit early and not invoke check_has_commit().

Fix this bug, and because calling add_submodule_odb() is no longer
necessary as of 13a2f620b2 (submodule: pass repo to
check_has_commit(), 2021-10-08), remove that call too.

This is the last caller of add_submodule_odb(), so remove that
function. (Submodule ODBs are still added as alternates via
add_submodule_odb_by_path().)

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 35 ++---------------------------------
 submodule.h |  9 ++++-----
 2 files changed, 6 insertions(+), 38 deletions(-)

diff --git a/submodule.c b/submodule.c
index 1f5f39ce18..6e6b2d04e4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -167,26 +167,6 @@ void stage_updated_gitmodules(struct index_state *istate)
 
 static struct string_list added_submodule_odb_paths = STRING_LIST_INIT_NODUP;
 
-/* TODO: remove this function, use repo_submodule_init instead. */
-int add_submodule_odb(const char *path)
-{
-	struct strbuf objects_directory = STRBUF_INIT;
-	int ret = 0;
-
-	ret = strbuf_git_path_submodule(&objects_directory, path, "objects/");
-	if (ret)
-		goto done;
-	if (!is_directory(objects_directory.buf)) {
-		ret = -1;
-		goto done;
-	}
-	string_list_insert(&added_submodule_odb_paths,
-			   strbuf_detach(&objects_directory, NULL));
-done:
-	strbuf_release(&objects_directory);
-	return ret;
-}
-
 void add_submodule_odb_by_path(const char *path)
 {
 	string_list_insert(&added_submodule_odb_paths, xstrdup(path));
@@ -971,7 +951,8 @@ static int check_has_commit(const struct object_id *oid, void *data)
 
 	if (repo_submodule_init(&subrepo, cb->repo, cb->path, cb->super_oid)) {
 		cb->result = 0;
-		goto cleanup;
+		/* subrepo failed to init, so don't clean it up. */
+		return 0;
 	}
 
 	type = oid_object_info(&subrepo, oid, NULL);
@@ -1007,18 +988,6 @@ static int submodule_has_commits(struct repository *r,
 		.super_oid = super_oid
 	};
 
-	/*
-	 * Perform a cheap, but incorrect check for the existence of 'commits'.
-	 * This is done by adding the submodule's object store to the in-core
-	 * object store, and then querying for each commit's existence.  If we
-	 * do not have the commit object anywhere, there is no chance we have
-	 * it in the object store of the correct submodule and have it
-	 * reachable from a ref, so we can fail early without spawning rev-list
-	 * which is expensive.
-	 */
-	if (add_submodule_odb(path))
-		return 0;
-
 	oid_array_for_each_unique(commits, check_has_commit, &has_commit);
 
 	if (has_commit.result) {
diff --git a/submodule.h b/submodule.h
index 61bebde319..40c1445237 100644
--- a/submodule.h
+++ b/submodule.h
@@ -103,12 +103,11 @@ int submodule_uses_gitfile(const char *path);
 int bad_to_remove_submodule(const char *path, unsigned flags);
 
 /*
- * Call add_submodule_odb() to add the submodule at the given path to a list.
- * When register_all_submodule_odb_as_alternates() is called, the object stores
- * of all submodules in that list will be added as alternates in
- * the_repository.
+ * Call add_submodule_odb_by_path() to add the submodule at the given
+ * path to a list. When register_all_submodule_odb_as_alternates() is
+ * called, the object stores of all submodules in that list will be
+ * added as alternates in the_repository.
  */
-int add_submodule_odb(const char *path);
 void add_submodule_odb_by_path(const char *path);
 int register_all_submodule_odb_as_alternates(void);
 
-- 
2.33.GIT

