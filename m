Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E29C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiCIQDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiCIQDA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:03:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB0A179A3E
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:02:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id h127-20020a1c2185000000b00389d0a5c511so318508wmh.5
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3AlRxdtCHh8EZhdx7bYcK7Q5bS3qwIH9q69ubfXY1Gg=;
        b=EBoAjyh9/aqdKjFqKc1mVxW/l+IdloS+E82SeZZhDvzH7b3sj2BMlUiv+IhhDS6ses
         xMrfP4bv4YpCHa47oPzJQmvK9tWdi+nZJNxEc8TiPmkpisvZ3sdkT4MRxBwt3iz6mVkm
         LlT3IaiKeXZGducOumbHRVOGuD22moo3kRb3NwGx8Q+ZwUcRFvAqT/vqrAHFeBdS1rnY
         vwFPjgB1GVzfAaaE89twKw5+SeR8pSUV0l4umKXijq7l/kII9ueLvxEojIC7lFbfjzgH
         wg6myM/0HuG3w39iY/uldx5LzmHkWbBgaILPiW8N3vSkD8N6QDM1O0ihGO8YvhAov0xV
         0lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=3AlRxdtCHh8EZhdx7bYcK7Q5bS3qwIH9q69ubfXY1Gg=;
        b=FZlEnXxb0LRygt9i6lCFIBjFhXhV0tU9/wLXCF2ZQXyl/mPEdpxbNFw/xKAlRzfBDN
         B5Ox8nLQl4rbHFGigwkV4O32v2vGT8cLEwISD1o1VKCkRTlZWY19SW7Ma2d+iGosdvN7
         F5O4DllNTIwDDrfKIvjvlK55XUWwMnv9qdXeDREYr1FQy1Xp1R8wizxglglMTHn7iXIJ
         BwxoCAosLncn35x7aH6VVOWSNEaae1i5YcgF3NbfIAqjFyijb70hBy8YinOLca7PSUJ8
         4fQdvtupKfTdxOkuyefsTJOThCiDBwBqZjARRe3d3HVsbkxuB/m62IHkNKrpEP9T9cmm
         ozvg==
X-Gm-Message-State: AOAM532M3ph0fBCe4du1ClKMc2sMkA4uc1c3VoNAPT6oJ7z/QBNQaXvv
        vz7eCnrnkLr9UNduKqFtinpo8T/0D6s=
X-Google-Smtp-Source: ABdhPJxhVbdcFe6WSTnNJcaQBQtS6KoL+VWCubH4ivGa6ebDK5w9c9PqwvngUa2RHFdRlb8AkxrTjQ==
X-Received: by 2002:a1c:7919:0:b0:389:79c5:fe83 with SMTP id l25-20020a1c7919000000b0038979c5fe83mr7986051wme.173.1646841714831;
        Wed, 09 Mar 2022 08:01:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm7139284wmj.18.2022.03.09.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:01:54 -0800 (PST)
Message-Id: <7287aaec598149a05fd459bc250a8b93c1f119fe.1646841704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:01:38 +0000
Subject: [PATCH v4 08/13] list-objects: handle NULL function pointers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

If a caller to traverse_commit_list() specifies the options for the
--objects flag but does not specify a show_object function pointer, the
result is a segfault. This is currently visible by running 'git bundle
create --objects HEAD'.

We could fix this problem by supplying a no-op callback in
builtin/bundle.c, but that only solves the problem for one builtin,
leaving this segfault open for other callers.

Replace all callers of the show_commit and show_object function pointers
in list-objects.c to call helper functions show_commit() and
show_object() which check that the given context has non-NULL functions
before passing the necessary data. One extra benefit is that it reduces
duplication due to passing ctx->show_data to every caller.

Test that this segfault no longer occurs for 'git bundle'.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c               |  2 ++
 list-objects.c         | 27 ++++++++++++++++++++++-----
 t/t6020-bundle-misc.sh | 12 ++++++++++++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/bundle.c b/bundle.c
index a0bb687b0f4..7ba60a573d7 100644
--- a/bundle.c
+++ b/bundle.c
@@ -544,6 +544,8 @@ int create_bundle(struct repository *r, const char *path,
 		die("revision walk setup failed");
 	bpi.fd = bundle_fd;
 	bpi.pending = &revs_copy.pending;
+
+	revs.blob_objects = revs.tree_objects = 0;
 	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
 	object_array_remove_duplicates(&revs_copy.pending);
 
diff --git a/list-objects.c b/list-objects.c
index 117f734398c..250d9de41cb 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -21,6 +21,23 @@ struct traversal_context {
 	struct filter *filter;
 };
 
+static void show_commit(struct traversal_context *ctx,
+			struct commit *commit)
+{
+	if (!ctx->show_commit)
+		return;
+	ctx->show_commit(commit, ctx->show_data);
+}
+
+static void show_object(struct traversal_context *ctx,
+			struct object *object,
+			const char *name)
+{
+	if (!ctx->show_object)
+		return;
+	ctx->show_object(object, name, ctx->show_data);
+}
+
 static void process_blob(struct traversal_context *ctx,
 			 struct blob *blob,
 			 struct strbuf *path,
@@ -60,7 +77,7 @@ static void process_blob(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, path->buf, ctx->show_data);
+		show_object(ctx, obj, path->buf);
 	strbuf_setlen(path, pathlen);
 }
 
@@ -194,7 +211,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data);
+		show_object(ctx, obj, base->buf);
 	if (base->len)
 		strbuf_addch(base, '/');
 
@@ -210,7 +227,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data);
+		show_object(ctx, obj, base->buf);
 
 	strbuf_setlen(base, baselen);
 	free_tree_buffer(tree);
@@ -228,7 +245,7 @@ static void process_tag(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		tag->object.flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(&tag->object, name, ctx->show_data);
+		show_object(ctx, &tag->object, name);
 }
 
 static void mark_edge_parents_uninteresting(struct commit *commit,
@@ -402,7 +419,7 @@ static void do_traverse(struct traversal_context *ctx)
 		if (r & LOFR_MARK_SEEN)
 			commit->object.flags |= SEEN;
 		if (r & LOFR_DO_SHOW)
-			ctx->show_commit(commit, ctx->show_data);
+			show_commit(ctx, commit);
 
 		if (ctx->revs->tree_blobs_in_commit_order)
 			/*
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index b13e8a52a93..df5ff561fa5 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -475,4 +475,16 @@ test_expect_success 'clone from bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'unfiltered bundle with --objects' '
+	git bundle create all-objects.bdl \
+		--all --objects &&
+	git bundle create all.bdl \
+		--all &&
+
+	# Compare the headers of these files.
+	sed -n -e "/^$/q" -e "p" all.bdl >expect &&
+	sed -n -e "/^$/q" -e "p" all-objects.bdl >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

