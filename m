Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47EAC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 13:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjAWNGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 08:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAWNGS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 08:06:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5499414E83
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 05:06:13 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id az20so30344299ejc.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 05:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJe/jM2Tr0OvKkYiqpGvd2SyyvQmqvHC1tzBdygcyeY=;
        b=nLNSCQ95fhVDG5t0DW1+48h7MrOztWaqugeTebbylzTkBzBGeISi+YoFFnl41j5ioW
         4OrAGdcre/By/M98H+nOrc4Hy01ru3fci4Hi6/G1c+OdDvw8maFpiuhjFh4Z2jOApGnZ
         bHbo7dBoaSwQEd83lVwQA8wy5uJYa2gIa/iS5pV7R9XIlNvbTBbYrUYc9dKc7oyEXvkZ
         M1n6TtOumcRFreFWUlMnG6zuWG4CSi+TjGitQeESyFT79owMbQruP/A5Zdxasf/aJziK
         G15iKZjluXmofsCcRBU6XCe9KJCOiAhErnJ3r7OkUc6TmHKFSWjDX3i2mLfcV27+6qdD
         AEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJe/jM2Tr0OvKkYiqpGvd2SyyvQmqvHC1tzBdygcyeY=;
        b=Tlm1sM7ij5Uqhr7jNV7B4TOr2R+iGKQ4OmvKxNZOAvx7pLluBi/sWD2pmIyJZitEF/
         HbBofRaQrLmVQMzc4QLbZ4vJ8TFxmJmo/N6dDmrL86Fxr5PqkQxmGinK74pHsOxXNADH
         1OgcfKcKac0cvY1hbWiBwv8IXnqFYEjFxYADZPMJhfQ721L2qeP5rSqciUUGPTxFVDDx
         4nN5edQnKxlocN5gIW3/r5YQB/uhrBiZdzckSE+Hz8pMDK4Up/Q0O94S4UsiTbpi6vkc
         /E2a9wiAf52WJVuX053sbKPUs0I1WTSuwsjd1v1U6amiOwaMW2kC9EckXDLXziZCV2Kw
         Ef9g==
X-Gm-Message-State: AFqh2kpe64dXNdTPFb7hCxxucK6GOc5/iZVne+n9qb6u3TvBqEgoZcxt
        nrz64Z4SFKPYo4z9LAoLote16mbnG3c=
X-Google-Smtp-Source: AMrXdXt3EtSmdb4bxyrMdfLsdHogBmQ6xhWbxiZk/M3xIXNDPXXTZMnq83FSNW8knXjCTGEUxRgmsQ==
X-Received: by 2002:a17:906:9bd4:b0:7b5:73aa:9984 with SMTP id de20-20020a1709069bd400b007b573aa9984mr24743870ejc.14.1674479171379;
        Mon, 23 Jan 2023 05:06:11 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007aee7ca1199sm22333398ejc.10.2023.01.23.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:06:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pJwWX-0008eC-1e;
        Mon, 23 Jan 2023 14:06:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
Date:   Mon, 23 Jan 2023 14:00:41 +0100
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
Message-ID: <230123.865ycxtn7i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 23 2023, William Sprent via GitGitGadget wrote:

> From: William Sprent <williams@unity3d.com>
>
> There is currently no way to ask git the question "which files would be
> part of a sparse checkout of commit X with sparse checkout patterns Y".
> One use-case would be that tooling may want know whether sparse checkouts
> of two commits contain the same content even if the full trees differ.
> Another interesting use-case would be for tooling to use in conjunction
> with 'git update-index --index-info'.

Rather than commenting on individual points, I checked this out and
produced something squashable on-top, it fixes various issues (some
aspects of which still remain):

 * You need to wrap your code at 79 chars (and some of that could be
   helped by picking less verbose identifiers & variable names,
   e.g. just use "context" rather than "read_tree_context" in
   cmd_ls_tree(), it has no other "context"...)
 * You're making the memory management aroind init_sparse_filter_data()
   needlessly hard, just put it on the stack instead. That also allows
   for init-ing most of it right away, or via a macro in the assignment.
 * You have a stray refactoring of dir.c in your proposed change, this
   changes it back, let's leave that sort of thing out.
 * You're adding a function that returns an enum, but you declare it as
   returning "int", let's retain that type in the header & declaration.


diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 46a815fc7dc..68d6ef675f2 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -372,36 +372,37 @@ struct sparse_filter_data {
 	struct ls_tree_options *options;
 };
 
-static void init_sparse_filter_data(struct sparse_filter_data **d, struct ls_tree_options *options,
-	const char *sparse_oid_name, read_tree_fn_t fn)
+static void init_sparse_filter_data(struct sparse_filter_data *d,
+				    const char *sparse_oid_name)
 {
 	struct object_id sparse_oid;
 	struct object_context oc;
 
-	(*d) = xcalloc(1, sizeof(**d));
-	(*d)->fn = fn;
-	(*d)->pl.use_cone_patterns = core_sparse_checkout_cone;
-	(*d)->options = options;
-	strbuf_init(&(*d)->full_path_buf, 0);
-
 	if (get_oid_with_context(the_repository, sparse_oid_name, GET_OID_BLOB,
 			&sparse_oid, &oc))
-		die(_("unable to access sparse blob in '%s'"), sparse_oid_name);
-	if (add_patterns_from_blob_to_list(&sparse_oid, "", 0, &(*d)->pl) < 0)
+		die(_("unable to access sparse blob in '%s'"),
+		    sparse_oid_name);
+	if (add_patterns_from_blob_to_list(&sparse_oid, "", 0, &d->pl) < 0)
 		die(_("unable to parse sparse filter data in %s"),
 		    oid_to_hex(&sparse_oid));
 }
 
-static void free_sparse_filter_data(struct sparse_filter_data *d)
+static void release_sparse_filter_data(struct sparse_filter_data *d)
 {
 	clear_pattern_list(&d->pl);
 	strbuf_release(&d->full_path_buf);
-	free(d);
 }
 
-static int path_matches_sparse_checkout_patterns(struct strbuf *full_path, struct pattern_list *pl, int dtype)
+static int path_matches_sparse_checkout_patterns(struct strbuf *full_path,
+						 struct pattern_list *pl,
+						 int dtype)
 {
-	enum pattern_match_result match = recursively_match_path_with_sparse_patterns(full_path->buf, the_repository->index, dtype, pl);
+	enum pattern_match_result match;
+
+	match = recursively_match_path_with_sparse_patterns(full_path->buf,
+							    the_repository->index,
+							    dtype, pl);
+
 	return match > 0;
 }
 
@@ -436,7 +437,10 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	struct ls_tree_options options = { 0 };
 	char *sparse_oid_name = NULL;
 	void *read_tree_context = NULL;
-	struct sparse_filter_data *sparse_filter_data = NULL;
+	struct sparse_filter_data sparse_filter_data = {
+		.options = &options,
+		.full_path_buf = STRBUF_INIT,
+	};
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &options.ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -542,16 +546,17 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	}
 
 	if (sparse_oid_name) {
-		init_sparse_filter_data(&sparse_filter_data, &options, sparse_oid_name, fn);
-		read_tree_context = sparse_filter_data;
+		sparse_filter_data.fn = fn;
+		init_sparse_filter_data(&sparse_filter_data, sparse_oid_name);
+		read_tree_context = &sparse_filter_data;
 		fn = filter_sparse;
 	} else
 		read_tree_context = &options;
 
-	ret = !!read_tree(the_repository, tree, &options.pathspec, fn, read_tree_context);
+	ret = !!read_tree(the_repository, tree, &options.pathspec, fn,
+			  read_tree_context);
 	clear_pathspec(&options.pathspec);
-	if (sparse_filter_data)
-		free_sparse_filter_data(sparse_filter_data);
+	release_sparse_filter_data(&sparse_filter_data);
 
 	return ret;
 }
diff --git a/dir.c b/dir.c
index 122ebced08e..57ec6404901 100644
--- a/dir.c
+++ b/dir.c
@@ -1457,10 +1457,10 @@ int init_sparse_checkout_patterns(struct index_state *istate)
 	return 0;
 }
 
-int recursively_match_path_with_sparse_patterns(const char *path,
-						struct index_state *istate,
-						int dtype,
-						struct pattern_list *pl)
+enum pattern_match_result recursively_match_path_with_sparse_patterns(const char *path,
+								      struct index_state *istate,
+								      int dtype,
+								      struct pattern_list *pl)
 {
 	enum pattern_match_result match = UNDECIDED;
 	const char *end, *slash;
@@ -1470,7 +1470,8 @@ int recursively_match_path_with_sparse_patterns(const char *path,
 	 * never returns UNDECIDED, so we will execute only one iteration in
 	 * this case.
 	 */
-	for (end = path + strlen(path); end > path && match == UNDECIDED;
+	for (end = path + strlen(path);
+	     end > path && match == UNDECIDED;
 	     end = slash) {
 		for (slash = end - 1; slash > path && *slash != '/'; slash--)
 			; /* do nothing */
diff --git a/dir.h b/dir.h
index d186d271606..3c65e68ca40 100644
--- a/dir.h
+++ b/dir.h
@@ -403,10 +403,10 @@ int path_in_sparse_checkout(const char *path,
 int path_in_cone_mode_sparse_checkout(const char *path,
 				      struct index_state *istate);
 
-int recursively_match_path_with_sparse_patterns(const char *path,
-						struct index_state *istate,
-						int dtype,
-						struct pattern_list *pl);
+enum pattern_match_result recursively_match_path_with_sparse_patterns(const char *path,
+								      struct index_state *istate,
+								      int dtype,
+								      struct pattern_list *pl);
 
 struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 				  struct index_state *istate,
