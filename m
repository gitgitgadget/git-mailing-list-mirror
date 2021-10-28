Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A111C433FE
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EDE8610C8
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhJ1Sdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhJ1Sdq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:33:46 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70FDC061745
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:19 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id c2-20020a63d5020000b029023ae853b72cso3688776pgg.18
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EPlHpmpm6K/ELW8suEF1UN7ZtD11QnXri6Lmaof06IQ=;
        b=Fpm4CcAcEPzH3gbSOAAIsl91LBZSkkceTw90+USWUKVnbKPBPn6G00z6TVM/dzLnmh
         MLCOF7L4A+2ya9f0Gfvf8KOhGhMjfxrAa7AZG+QI6+Bt7yDTnrcWs6Rk32jFpllHlXPT
         zSiCa53VCNlyuSzedeqx1MR9A8yoo4QqmffvAUFIQMAc+R+mjSOAM1sbinAu41YfxGy0
         upFHcomeHejpOTHtjeFCwBKt73q8dNe5TDOG5kQ1kOnZtiEdZZi8jma2UfZeNOVuAs6u
         jHSkck6IbuyiEDvalBge4JJp0SXE8fVgF3qH59RtrTJJyVFde5WXh8Yso8FX8zihAuNa
         R8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EPlHpmpm6K/ELW8suEF1UN7ZtD11QnXri6Lmaof06IQ=;
        b=BfsaC9U97h1kT4WZF+nV2B4nobE/ZyIo+hWPXAIuJQow8JkyMiHXHFRQABJAGnOhx4
         WBldwF2s8UL4obas47PoNpFqFCPuXkQFW1sgwz/ZARfto6NdcHPBuzCJWwi977Iu+ViV
         PaXQ+hDx5Cmh7NrLVsoTFU0vG6BmlRpz4wVtxgzNN0j8n4btUfYI3hZXEp6gpXWJvC2V
         5gnNaAe89SHQDUe/d5sJ74SfgAuKG5wh3lUtrGotxvgooJM7oSsKg8YJZnV0Tudx0bWx
         C80WhTpKy6G55pKusWWhOjNf4yP5X7MtuwOR64L6t7Ogh+vm3P+wYVxRNLBB+86HDeXK
         VqjQ==
X-Gm-Message-State: AOAM532J/wvnkFyAAdt4IhjO974V4gO2bMaRj4X3+HsBuFgzBolwnIB8
        A+PwHD+hVtov2eZ3KizZ4fNtdklVkafm8KX+DHhxDRV5qWX9SIT756ZIPwglUzmIJWQo8EScCBA
        iyLSTeoukYKRJvevL2JsEDKGbMMxjxaosD5uI6BXuJvFR9jDoQhF+KRnts8MslZc=
X-Google-Smtp-Source: ABdhPJyTrlIeBfscXFQZe77rPCL/Lj66jiEc4MsOBI2yMoupF+4IJPD0OvyUYWkVYgCbwpbv9yLGxpRN0ZJhrg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1348:b0:47c:e8f1:69a3 with SMTP
 id k8-20020a056a00134800b0047ce8f169a3mr6024593pfu.86.1635445878746; Thu, 28
 Oct 2021 11:31:18 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:31:00 -0700
In-Reply-To: <20211028183101.41013-1-chooglen@google.com>
Message-Id: <20211028183101.41013-6-chooglen@google.com>
Mime-Version: 1.0
References: <20211019224339.61881-1-chooglen@google.com> <20211028183101.41013-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 5/6] remote: die if branch is not found in repository
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit, we would like external-facing functions to be
able to accept "struct repository" and "struct branch" as a pair. This
is useful for functions like pushremote_for_branch(), which need to take
values from the remote_state and branch, even if branch == NULL.
However, a caller may supply an unrelated repository and branch, which
is not supported behavior.

To prevent misuse, add a die_on_missing_branch() helper function that
dies if a given branch is not from a given repository. Speed up the
existence check by using a new branches_hash hashmap to remote_state,
and use the hashmap to remove the branch array iteration in
make_branch().

Like read_config(), die_on_missing_branch() is only called from
non-static functions; static functions are less prone to misuse because
they have strong conventions for keeping remote_state and branch in
sync.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 remote.h |  2 ++
 2 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 88697e7e6d..2b5166dee0 100644
--- a/remote.c
+++ b/remote.c
@@ -166,17 +166,66 @@ static void add_merge(struct branch *branch, const char *name)
 	branch->merge_name[branch->merge_nr++] = name;
 }
 
+struct branches_hash_key {
+	const char *str;
+	int len;
+};
+
+static int branches_hash_cmp(const void *unused_cmp_data,
+			     const struct hashmap_entry *eptr,
+			     const struct hashmap_entry *entry_or_key,
+			     const void *keydata)
+{
+	const struct branch *a, *b;
+	const struct branches_hash_key *key = keydata;
+
+	a = container_of(eptr, const struct branch, ent);
+	b = container_of(entry_or_key, const struct branch, ent);
+
+	if (key)
+		return strncmp(a->name, key->str, key->len) ||
+		       a->name[key->len];
+	else
+		return strcmp(a->name, b->name);
+}
+
+static struct branch *find_branch(struct remote_state *remote_state,
+				  const char *name, size_t len)
+{
+	struct branches_hash_key lookup;
+	struct hashmap_entry lookup_entry, *e;
+
+	if (!len)
+		len = strlen(name);
+
+	lookup.str = name;
+	lookup.len = len;
+	hashmap_entry_init(&lookup_entry, memhash(name, len));
+
+	e = hashmap_get(&remote_state->branches_hash, &lookup_entry, &lookup);
+	if (e)
+		return container_of(e, struct branch, ent);
+
+	return NULL;
+}
+
+static void die_on_missing_branch(struct repository *repo,
+				  struct branch *branch)
+{
+	/* branch == NULL is always valid because it represents detached HEAD. */
+	if (branch &&
+	    branch != find_branch(repo->remote_state, branch->name, 0))
+		die("branch %s was not found in the repository", branch->name);
+}
+
 static struct branch *make_branch(struct remote_state *remote_state,
 				  const char *name, size_t len)
 {
 	struct branch *ret;
-	int i;
 
-	for (i = 0; i < remote_state->branches_nr; i++) {
-		if (!strncmp(name, remote_state->branches[i]->name, len) &&
-		    !remote_state->branches[i]->name[len])
-			return remote_state->branches[i];
-	}
+	ret = find_branch(remote_state, name, len);
+	if (ret)
+		return ret;
 
 	ALLOC_GROW(remote_state->branches, remote_state->branches_nr + 1,
 		   remote_state->branches_alloc);
@@ -185,6 +234,9 @@ static struct branch *make_branch(struct remote_state *remote_state,
 	ret->name = xstrndup(name, len);
 	ret->refname = xstrfmt("refs/heads/%s", ret->name);
 
+	hashmap_entry_init(&ret->ent, memhash(name, len));
+	if (hashmap_put_entry(&remote_state->branches_hash, ret, ent))
+		BUG("hashmap_put overwrote entry after hashmap_get returned NULL");
 	return ret;
 }
 
@@ -500,6 +552,8 @@ static const char *remotes_remote_for_branch(struct remote_state *remote_state,
 const char *remote_for_branch(struct branch *branch, int *explicit)
 {
 	read_config(the_repository);
+	die_on_missing_branch(the_repository, branch);
+
 	return remotes_remote_for_branch(the_repository->remote_state, branch,
 					 explicit);
 }
@@ -524,6 +578,8 @@ remotes_pushremote_for_branch(struct remote_state *remote_state,
 const char *pushremote_for_branch(struct branch *branch, int *explicit)
 {
 	read_config(the_repository);
+	die_on_missing_branch(the_repository, branch);
+
 	return remotes_pushremote_for_branch(the_repository->remote_state,
 					     branch, explicit);
 }
@@ -534,6 +590,8 @@ static struct remote *remotes_remote_get(struct remote_state *remote_state,
 const char *remote_ref_for_branch(struct branch *branch, int for_push)
 {
 	read_config(the_repository);
+	die_on_missing_branch(the_repository, branch);
+
 	if (branch) {
 		if (!for_push) {
 			if (branch->merge_nr) {
@@ -1879,6 +1937,8 @@ static const char *branch_get_push_1(struct remote_state *remote_state,
 const char *branch_get_push(struct branch *branch, struct strbuf *err)
 {
 	read_config(the_repository);
+	die_on_missing_branch(the_repository, branch);
+
 	if (!branch)
 		return error_buf(err, _("HEAD does not point to a branch"));
 
@@ -2652,6 +2712,7 @@ struct remote_state *remote_state_new(void)
 	memset(r, 0, sizeof(*r));
 
 	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
+	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
 	return r;
 }
 
diff --git a/remote.h b/remote.h
index 85a730b8ef..b205830ac3 100644
--- a/remote.h
+++ b/remote.h
@@ -46,6 +46,7 @@ struct remote_state {
 	struct branch **branches;
 	int branches_alloc;
 	int branches_nr;
+	struct hashmap branches_hash;
 
 	struct branch *current_branch;
 	const char *pushremote_name;
@@ -292,6 +293,7 @@ int remote_find_tracking(struct remote *remote, struct refspec_item *refspec);
  * branch_get(name) for "refs/heads/{name}", or with branch_get(NULL) for HEAD.
  */
 struct branch {
+	struct hashmap_entry ent;
 
 	/* The short name of the branch. */
 	const char *name;
-- 
2.33.GIT

