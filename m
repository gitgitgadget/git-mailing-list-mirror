Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B45C43217
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiBXKJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiBXKJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:09:43 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805BC28A12D
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:13 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x194-20020a627ccb000000b004e103c5f726so1087430pfc.8
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Txi60ETKS8WiURrpOogef4iTcsrXpKm1FqsfDJ/toW8=;
        b=Xq+0/ZqyqvERqtf9nZgvrldLNr5RkqNYwZou3wq2BKOxkr23/MdvaQc3gMLu6eJKvq
         fBY0z6ThY1LUZbjgjueJpFeG6y0h+bl0YykQjq8CfBJjMBtyaTt5stwKdN6Rd+m2DpsO
         YWBqro1WEXAi+l7XdnnP7KlFvcUp2QRp2CVxAycFNhSrxaaTo8sE7Gtimg9DATtyl5Oj
         Wnr4+PJrDXPNq75T609QHna/sNwqaFPH8v3Y7D9OifLGxj+a6WWaPVUnYT2cWmBdCXlR
         OercDc7I+B1aDhEiLsIYnL1cqumjDxCQXx+tMeuef5cnYQ35yDcH/xoIZ+Nn6dL4+8DU
         l+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Txi60ETKS8WiURrpOogef4iTcsrXpKm1FqsfDJ/toW8=;
        b=KYohHw5ws5DW+ygoenYokZKy5SqVPDO+2QcKJIMiAYRHpDiTlWdgJi3yDccJK8zyL/
         OneQTzB1Eyd1c8XvYIxj6dJtC7GI4RBXK5Lya3atQ5cYTphGNWhasNJpOOepd7fwlUN7
         u9FELjBlD3pd9+jv2F85c387fDBK6/WLK/OrRP74yElpURw6Ro2pYh2sE+pblsgjULG6
         U5rVSslrtoh+fi0z6E7LSMHMLEiFtaCU1KUEFKJmKNmiC/uoQroNQclmO//P91bp/cCG
         fg6WOvMXxcSgFY8XUhhA6nCPjhkdnuPQYXSEhW9vJlkREe4smnAbGUgA29QS4qmV1xRa
         /Ckg==
X-Gm-Message-State: AOAM532Y1WFGVMEWrQYua0AnrVAKMT74GQOIGQyd8ht0ggVOjcZybsZO
        s9je8Ix1KQBikTQPhPZFSzpmubkqlFn3PAt5ZNC5a70QeI6k8b77OAHli6wL2+g6eXqx5wMKBTx
        Ub44KEZbrBZh5+nqxO8gzeNRpcqX501cdCT8hNnHDGl8dZ4etNy0NrEsKzkL2t2M=
X-Google-Smtp-Source: ABdhPJwM1mYfmhNg4K0l2fwvPAHV+cu/8uSgyX/Z8kKOijrA6d9HJLhgpIGnpCndVcOKRMjfUauu7MKslO1mWQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:88d2:0:b0:4f3:5d00:58d8 with SMTP id
 k18-20020aa788d2000000b004f35d0058d8mr2204134pff.5.1645697352868; Thu, 24 Feb
 2022 02:09:12 -0800 (PST)
Date:   Thu, 24 Feb 2022 18:08:42 +0800
In-Reply-To: <20220224100842.95827-1-chooglen@google.com>
Message-Id: <20220224100842.95827-11-chooglen@google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 10/10] submodule: fix latent check_has_commit() bug
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
index d60f877b1f..71495e67f5 100644
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
@@ -962,7 +942,8 @@ static int check_has_commit(const struct object_id *oid, void *data)
 
 	if (repo_submodule_init(&subrepo, cb->repo, cb->path, cb->super_oid)) {
 		cb->result = 0;
-		goto cleanup;
+		/* subrepo failed to init, so don't clean it up. */
+		return 0;
 	}
 
 	type = oid_object_info(&subrepo, oid, NULL);
@@ -998,18 +979,6 @@ static int submodule_has_commits(struct repository *r,
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

