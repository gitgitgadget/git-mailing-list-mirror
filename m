Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F37C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 09:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345528AbiCHJyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 04:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345518AbiCHJyV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 04:54:21 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D8334BB2
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 01:53:24 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bi12so24814938ejb.3
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 01:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=AMenn7NZpeemA7dfQ7v2tIdNRp87UmJbvMpj3j8l5AI=;
        b=j1BK7KDx+nwqa+Ak33RVNtMhOBi7Vf6xL4LF51jHbxpT91fMSSiB/O9hosAz45oNX8
         K3l2ykV3ow48yIb2hzo6VseNGoEPgShYOPJmYKZchNKKrmrD8zUDNp9WLnr0qaDdSqtf
         dp6iQOvD486Vi6iy2sIfNSqqi7SfWVHnOaXI7FL3AkN6uriDHwjpsB6C0y8oGe0jOd9B
         YKWgfvPro93Eh3k5SeN4wMPhOsQuGKvFgcmWhTE+nnL3qL7pkK4CwOi1UWiAkwcVOfJr
         Xexy+l+t7JevMip2Ts8y5eWe1+inCHbPFKnbtL6Yi6lBxF70nbgwh+18ty284CmJChYl
         939A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=AMenn7NZpeemA7dfQ7v2tIdNRp87UmJbvMpj3j8l5AI=;
        b=HOv6fLSFAE3yKzkxA++ONii9OBTEEMK9Ne9Oa64yFADBKWOF6OGMEvZPmvy1H66Gz4
         s1IVaTRTH1sGulOKPYfYYUxlksBkwNmBaTUZiYMUJ/BbftjtCF3m3IozQms8HA91jqI6
         PyViHc4qYKMnXR91rP/7TxBbpcXiZu0xfnAq29Qm2IQH7CHtZL2ntw+yY+bH9N+Qfux9
         4DKyAw6x4CD8QJCJXG0x5azODxrBgxyQ0Sy0BS4v/dHDNcqp7aZ87Du7jIc/rla1P3Pw
         Vpulkqz2Ne02hpcS91fkg+riB6C7y169A46y7X7/rMdCZT2b7vKS9U/varNLMu5eVEQq
         I3AQ==
X-Gm-Message-State: AOAM5320lufOFcQyf1AByoatpakPmtsTrJQPcY4E9KVJ8GTgyhZ1L+ZZ
        gDmXgZ3nNjpVJ0Dpl9SbMsdG16hitj2gHQ==
X-Google-Smtp-Source: ABdhPJy3G3/1EmxRqb3FuTAQkDenmq5fG/qbx/sTum5kIpqbNbYqqjvS2Jygj5kgn35NSOz1aD+ztQ==
X-Received: by 2002:a17:907:334c:b0:6cd:76b7:3948 with SMTP id yr12-20020a170907334c00b006cd76b73948mr13570101ejb.55.1646733202784;
        Tue, 08 Mar 2022 01:53:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm7504923edj.49.2022.03.08.01.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:53:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRWWv-001kNg-91;
        Tue, 08 Mar 2022 10:53:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 07/12] bundle: safely handle --objects option
Date:   Tue, 08 Mar 2022 10:37:27 +0100
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
 <19694d5b255227f2314456118c2c7fc986ae52a0.1646689840.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <19694d5b255227f2314456118c2c7fc986ae52a0.1646689840.git.gitgitgadget@gmail.com>
Message-ID: <220308.86h788ydm6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 07 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> Since 'git bundle' uses setup_revisions() to specify the object walk,
> some options do not make sense to include during the pack-objects child
> process. Further, these options are used for a call to
> traverse_commit_list() which would then require a callback which is
> currently NULL.
>
> By populating the callback we prevent a segfault in the case of adding
> the --objects flag. This is really a redundant statement because the
> command is constructing a pack-file containing all objects in the
> discovered commit range.
>
> Adding --objects to a 'git bundle' command might cause a slower command,
> but at least it will not have a hard failure when the user supplies this
> option. We can also disable walking trees and blobs in advance of this
> walk.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle.c               | 10 +++++++++-
>  t/t6020-bundle-misc.sh | 12 ++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/bundle.c b/bundle.c
> index a0bb687b0f4..dc56db9a50a 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -451,6 +451,12 @@ struct bundle_prerequisites_info {
>  	int fd;
>  };
>  
> +
> +static void ignore_object(struct object *obj, const char *v, void *data)
> +{
> +	/* Do nothing. */
> +}
> +
>  static void write_bundle_prerequisites(struct commit *commit, void *data)
>  {
>  	struct bundle_prerequisites_info *bpi = data;
> @@ -544,7 +550,9 @@ int create_bundle(struct repository *r, const char *path,
>  		die("revision walk setup failed");
>  	bpi.fd = bundle_fd;
>  	bpi.pending = &revs_copy.pending;
> -	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
> +
> +	revs.blob_objects = revs.tree_objects = 0;
> +	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
>  	object_array_remove_duplicates(&revs_copy.pending);
>  
>  	/* write bundle refs */
> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> index b13e8a52a93..6522401617d 100755
> --- a/t/t6020-bundle-misc.sh
> +++ b/t/t6020-bundle-misc.sh
> @@ -475,4 +475,16 @@ test_expect_success 'clone from bundle' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'unfiltered bundle with --objects' '
> +	git bundle create all-objects.bdl \
> +		--all --objects &&
> +	git bundle create all.bdl \
> +		--all &&
> +
> +	# Compare the headers of these files.
> +	head -11 all.bdl >expect &&
> +	head -11 all-objects.bdl >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

Re this comment on v1: https://lore.kernel.org/git/220307.86fsntzsda.gmgdl@evledraar.gmail.com/

This series also passes your tests with this on top:
	
	diff --git a/bundle.c b/bundle.c
	index 3846108f7a6..1f022f53336 100644
	--- a/bundle.c
	+++ b/bundle.c
	@@ -468,11 +468,6 @@ struct bundle_prerequisites_info {
	 };
	 
	 
	-static void ignore_object(struct object *obj, const char *v, void *data)
	-{
	-	/* Do nothing. */
	-}
	-
	 static void write_bundle_prerequisites(struct commit *commit, void *data)
	 {
	 	struct bundle_prerequisites_info *bpi = data;
	@@ -598,7 +593,7 @@ int create_bundle(struct repository *r, const char *path,
	 	 */
	 	revs.filter = NULL;
	 	revs.blob_objects = revs.tree_objects = 0;
	-	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
	+	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
	 	object_array_remove_duplicates(&revs_copy.pending);
	 
	 	/* write bundle refs */
	diff --git a/list-objects.c b/list-objects.c
	index 9422625b39e..d44a1db2262 100644
	--- a/list-objects.c
	+++ b/list-objects.c
	@@ -227,7 +227,7 @@ static void process_tag(struct traversal_context *ctx,
	 					       ctx->filter);
	 	if (r & LOFR_MARK_SEEN)
	 		tag->object.flags |= SEEN;
	-	if (r & LOFR_DO_SHOW)
	+	if (r & LOFR_DO_SHOW && ctx->show_object)
	 		ctx->show_object(&tag->object, name, ctx->show_data);
	 }
	 

Aside from whether that's a good idea, doesn't that at least point to
missing test coverage here, see traverse_non_commits() and other paths
in list-objects.c that'll call ctx->show_object().

I think an actually sensible patch for this is the below, i.e. the API
is conflating "do show" with "should we show AND we have a callback?":
	
	diff --git a/bundle.c b/bundle.c
	index 3846108f7a6..1f022f53336 100644
	--- a/bundle.c
	+++ b/bundle.c
	@@ -468,11 +468,6 @@ struct bundle_prerequisites_info {
	 };
	 
	 
	-static void ignore_object(struct object *obj, const char *v, void *data)
	-{
	-	/* Do nothing. */
	-}
	-
	 static void write_bundle_prerequisites(struct commit *commit, void *data)
	 {
	 	struct bundle_prerequisites_info *bpi = data;
	@@ -598,7 +593,7 @@ int create_bundle(struct repository *r, const char *path,
	 	 */
	 	revs.filter = NULL;
	 	revs.blob_objects = revs.tree_objects = 0;
	-	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
	+	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
	 	object_array_remove_duplicates(&revs_copy.pending);
	 
	 	/* write bundle refs */
	diff --git a/list-objects.c b/list-objects.c
	index 9422625b39e..1725cb252a9 100644
	--- a/list-objects.c
	+++ b/list-objects.c
	@@ -21,6 +21,22 @@ struct traversal_context {
	 	struct filter *filter;
	 };
	 
	+static void show_commit(struct traversal_context *ctx, struct commit *commit,
	+			void *data)
	+{
	+	if (!ctx->show_commit)
	+		return;
	+	ctx->show_commit(commit, data);
	+}
	+
	+static void show_object(struct traversal_context *ctx, struct object *object,
	+			const char *path, void *data)
	+{
	+	if (!ctx->show_object)
	+		return;
	+	ctx->show_object(object, path, data);
	+}
	+
	 static void process_blob(struct traversal_context *ctx,
	 			 struct blob *blob,
	 			 struct strbuf *path,
	@@ -60,7 +76,7 @@ static void process_blob(struct traversal_context *ctx,
	 	if (r & LOFR_MARK_SEEN)
	 		obj->flags |= SEEN;
	 	if (r & LOFR_DO_SHOW)
	-		ctx->show_object(obj, path->buf, ctx->show_data);
	+		show_object(ctx, obj, path->buf, ctx->show_data);
	 	strbuf_setlen(path, pathlen);
	 }
	 
	@@ -194,7 +210,7 @@ static void process_tree(struct traversal_context *ctx,
	 	if (r & LOFR_MARK_SEEN)
	 		obj->flags |= SEEN;
	 	if (r & LOFR_DO_SHOW)
	-		ctx->show_object(obj, base->buf, ctx->show_data);
	+		show_object(ctx, obj, base->buf, ctx->show_data);
	 	if (base->len)
	 		strbuf_addch(base, '/');
	 
	@@ -210,7 +226,7 @@ static void process_tree(struct traversal_context *ctx,
	 	if (r & LOFR_MARK_SEEN)
	 		obj->flags |= SEEN;
	 	if (r & LOFR_DO_SHOW)
	-		ctx->show_object(obj, base->buf, ctx->show_data);
	+		show_object(ctx, obj, base->buf, ctx->show_data);
	 
	 	strbuf_setlen(base, baselen);
	 	free_tree_buffer(tree);
	@@ -228,7 +244,7 @@ static void process_tag(struct traversal_context *ctx,
	 	if (r & LOFR_MARK_SEEN)
	 		tag->object.flags |= SEEN;
	 	if (r & LOFR_DO_SHOW)
	-		ctx->show_object(&tag->object, name, ctx->show_data);
	+		show_object(ctx, &tag->object, name, ctx->show_data);
	 }
	 
	 static void mark_edge_parents_uninteresting(struct commit *commit,
	@@ -402,7 +418,7 @@ static void do_traverse(struct traversal_context *ctx)
	 		if (r & LOFR_MARK_SEEN)
	 			commit->object.flags |= SEEN;
	 		if (r & LOFR_DO_SHOW)
	-			ctx->show_commit(commit, ctx->show_data);
	+			show_commit(ctx, commit, ctx->show_data);
	 
	 		if (ctx->revs->tree_blobs_in_commit_order)
	 			/*

I think that'll do what you want, and also seems to set us up for safer
API use going forward, i.e. we have a couple of NULL-passing callers
already.
