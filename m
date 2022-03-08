Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11149C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347557AbiCHOkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347447AbiCHOkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:40:20 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9579338D89
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:39:22 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q14so13326098wrc.4
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ZINxVotkxL7gjUqZkY66ahdYJIPcbX203NQVs5E7eSc=;
        b=BLu0TMjRmaHKD054c/Ojcf7tgFpfhzID/pKtCw2T6xUfbo0O2WCkM5Br/PiSEfckOW
         9U2myYa8T8lkJ0uay9H6bo9izw1RBi2QnVKwuS/SoNZz6zAuLWBV1r+ZgPNsbxsVyQPN
         xKYBRujctvvgUoXt9xQ+ryc76SONAfVj1KTnp2ZDBnVN8cUvb998Swhy0GEYjxdVfG9k
         FOuKzgTGK6maScajb56UD71c1wHDr3pgh964t1tZlBmg2MRsC5EprrttylpCYfx5YMDd
         khVGsH/3Pic+fU3j6iwzN+qOoOwI+u2aOC94y0acB1WMQDdPOL2PD8nTXy9b4qee+hvu
         Bx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ZINxVotkxL7gjUqZkY66ahdYJIPcbX203NQVs5E7eSc=;
        b=fApnwf4dw9Ys9JljLMEOgQ5E0H/aHFAl4LDMQQsFqoKGgLftn5PFiQ/Vg48inLsfDL
         kwJmijBMD6ajldwq8ipvb+wbdMEkl9Z21qJoJD/k8eUfHbhILY7tSY5uSHCI2cd4D/UQ
         r91WKVhxA03ccpEllGr+Tw6is+27v9zDN5Bv7yooODAIaiyhv+eyNLs8UPOGTtURT+8Q
         Ikb849Y/NBW3MZpd/vgnh/DA4oOYpKhdu+z9pK1/343ANe34I9Kq1DRNLAI6fkORBR1X
         k5p+Oag0vGMNt2GJAz1tjHDkOrWhyGVxLlOH83W+tr8nYIKBGyokNF+LKWq1TnXwC8BB
         znxQ==
X-Gm-Message-State: AOAM533r8dX7DgzCTZ27mf7RNg1zKlQ5DwaUFNiYyc7AZzsq2EOFyLwu
        SbMf7AlUcmeTJL+Kcv0AMbBbwH6wrl0=
X-Google-Smtp-Source: ABdhPJxrvyduiuFwWZ7FERnEA3ng+VsgU582X8hRyLhkHOVI7kv0vkuIRX/vqnabmlMB9GRwqV8HOA==
X-Received: by 2002:a5d:43ca:0:b0:1f0:7925:b6c1 with SMTP id v10-20020a5d43ca000000b001f07925b6c1mr12291894wrr.241.1646750360667;
        Tue, 08 Mar 2022 06:39:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm2683021wmb.48.2022.03.08.06.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:39:20 -0800 (PST)
Message-Id: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 14:39:07 +0000
Subject: [PATCH v3 00/12] Partial bundles
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While discussing bundle-URIs [1], it came to my attention that bundles have
no way to specify an object filter, so bundles cannot be used with partial
clones.

[1]
https://lore.kernel.org/git/7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com/

This series provides a way to fix that by adding a 'filter' capability to
the bundle file format and allowing one to create a partial bundle with 'git
bundle create --filter=blob:none '.

There are a couple things that I want to point out about this implementation
that could use some high-level feedback:

 1. I moved the '--filter' parsing into setup_revisions() instead of adding
    another place to parse it. This works for 'git bundle' but it also
    allows it to be parsed successfully in commands such as 'git diff' which
    doesn't make sense. Options such as '--objects' are already being parsed
    there, and they don't make sense either, so I want some thoughts on
    this.

 2. If someone uses 'git clone partial.bdl partial' where 'partial.bdl' is a
    filtered bundle, then the clone will fail with a message such as

fatal: missing blob object '9444604d515c0b162e37e59accd54a0bac50ed2e' fatal:
remote did not send all necessary objects

This might be fine. We don't expect users to clone partial bundles or fetch
partial bundles into an unfiltered repo and these failures are expected. It
is possible that we could put in custom logic to fail faster by reading the
bundle header for a filter.

Generally, the idea is to open this up as a potential way to bootstrap a
clone of a partial clone using a set of precomputed partial bundles.


Updates in v3
=============

 * 'struct bundle_header' now has 'filter' embedded statically, using
   filter.choice to indicate if it is an empty filter.

 * list-objects.c is now more robust to NULL function pointers.


Updates in v2
=============

Thanks for the reviews, Jeff, Junio, and Ævar!

 * Commit message typos and grammar are improved.

 * Grammar in MyFirstObjectWalk.txt is improved.

 * Unnecessary line wrapping is unwrapped.

 * Final test to check unbundled repo is made more rigorous.

 * The new 'filter' capability is added to
   Documentation/technical/bundle-format.txt

 * Expanded docs for 'git bundle verify'.

 * Moved API docs gently_parse_list_objects_filter() to header.

 * Test name swaps '' with "" to evaluate $filter.

 * Added a new patch that helps git clone <bundle> fail gracefully when
   <bundle> is has a filter capability.

Thanks, -Stolee

Derrick Stolee (11):
  index-pack: document and test the --promisor option
  revision: put object filter into struct rev_info
  pack-objects: use rev.filter when possible
  pack-bitmap: drop filter in prepare_bitmap_walk()
  list-objects: consolidate traverse_commit_list[_filtered]
  MyFirstObjectWalk: update recommended usage
  bundle: parse filter capability
  rev-list: move --filter parsing into revision.c
  bundle: create filtered bundles
  bundle: unbundle promisor packs
  clone: fail gracefully when cloning filtered bundle

Ævar Arnfjörð Bjarmason (1):
  list-objects: handle NULL function pointers

 Documentation/MyFirstObjectWalk.txt       | 44 +++++--------
 Documentation/git-bundle.txt              |  4 +-
 Documentation/git-index-pack.txt          |  8 +++
 Documentation/technical/bundle-format.txt | 11 +++-
 builtin/clone.c                           | 13 ++++
 builtin/pack-objects.c                    |  9 +--
 builtin/rev-list.c                        | 29 +++------
 bundle.c                                  | 76 +++++++++++++++++++----
 bundle.h                                  |  2 +
 list-objects-filter-options.c             | 17 +----
 list-objects-filter-options.h             | 20 ++++++
 list-objects.c                            | 52 +++++++++-------
 list-objects.h                            | 12 +++-
 pack-bitmap.c                             | 24 ++++---
 pack-bitmap.h                             |  2 -
 reachable.c                               |  2 +-
 revision.c                                | 11 ++++
 revision.h                                |  4 ++
 t/t5300-pack-object.sh                    |  4 +-
 t/t6020-bundle-misc.sh                    | 74 ++++++++++++++++++++++
 20 files changed, 290 insertions(+), 128 deletions(-)


base-commit: 45fe28c951c3e70666ee4ef8379772851a8e4d32
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1159%2Fderrickstolee%2Fbundle%2Fpartial-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1159/derrickstolee/bundle/partial-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1159

Range-diff vs v2:

  1:  a1eb4dceb0b =  1:  a1eb4dceb0b index-pack: document and test the --promisor option
  2:  3a88c99d9bc =  2:  3a88c99d9bc revision: put object filter into struct rev_info
  3:  d5edb193229 =  3:  d5edb193229 pack-objects: use rev.filter when possible
  4:  888774f6f28 =  4:  888774f6f28 pack-bitmap: drop filter in prepare_bitmap_walk()
  5:  bcb76a065bf =  5:  bcb76a065bf list-objects: consolidate traverse_commit_list[_filtered]
  6:  efc03168818 =  6:  efc03168818 MyFirstObjectWalk: update recommended usage
  7:  19694d5b255 !  7:  782182a26e3 bundle: safely handle --objects option
     @@
       ## Metadata ##
     -Author: Derrick Stolee <derrickstolee@github.com>
     +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## Commit message ##
     -    bundle: safely handle --objects option
     +    list-objects: handle NULL function pointers
      
     -    Since 'git bundle' uses setup_revisions() to specify the object walk,
     -    some options do not make sense to include during the pack-objects child
     -    process. Further, these options are used for a call to
     -    traverse_commit_list() which would then require a callback which is
     -    currently NULL.
     +    If a caller to traverse_commit_list() specifies the options for the
     +    --objects flag but does not specify a show_object function pointer, the
     +    result is a segfault. This is currently visible by running 'git bundle
     +    create --objects HEAD'.
      
     -    By populating the callback we prevent a segfault in the case of adding
     -    the --objects flag. This is really a redundant statement because the
     -    command is constructing a pack-file containing all objects in the
     -    discovered commit range.
     +    We could fix this problem by supplying a no-op callback in
     +    builtin/bundle.c, but that only solves the problem for one builtin,
     +    leaving this segfault open for other callers.
      
     -    Adding --objects to a 'git bundle' command might cause a slower command,
     -    but at least it will not have a hard failure when the user supplies this
     -    option. We can also disable walking trees and blobs in advance of this
     -    walk.
     +    Replace all callers of the show_commit and show_object function pointers
     +    in list-objects.c to be local methods show_commit() and show_object()
     +    which check that the given contex has non-NULL functions before passing
     +    the necessary data. One extra benefit is that it reduces duplication
     +    due to passing ctx->show_data to every caller.
      
     +    Test that this segfault no longer occurs for 'git bundle'.
     +
     +    Co-authored-by: Derrick Stolee <derrickstolee@github.com>
     +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## bundle.c ##
     -@@ bundle.c: struct bundle_prerequisites_info {
     - 	int fd;
     - };
     - 
     -+
     -+static void ignore_object(struct object *obj, const char *v, void *data)
     -+{
     -+	/* Do nothing. */
     -+}
     -+
     - static void write_bundle_prerequisites(struct commit *commit, void *data)
     - {
     - 	struct bundle_prerequisites_info *bpi = data;
      @@ bundle.c: int create_bundle(struct repository *r, const char *path,
       		die("revision walk setup failed");
       	bpi.fd = bundle_fd;
       	bpi.pending = &revs_copy.pending;
     --	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
      +
      +	revs.blob_objects = revs.tree_objects = 0;
     -+	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
     + 	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
       	object_array_remove_duplicates(&revs_copy.pending);
       
     - 	/* write bundle refs */
     +
     + ## list-objects.c ##
     +@@ list-objects.c: struct traversal_context {
     + 	struct filter *filter;
     + };
     + 
     ++static void show_commit(struct traversal_context *ctx,
     ++			struct commit *commit)
     ++{
     ++	if (!ctx->show_commit)
     ++		return;
     ++	ctx->show_commit(commit, ctx->show_data);
     ++}
     ++
     ++static void show_object(struct traversal_context *ctx,
     ++			struct object *object,
     ++			const char *name)
     ++{
     ++	if (!ctx->show_object)
     ++		return;
     ++	ctx->show_object(object, name, ctx->show_data);
     ++}
     ++
     + static void process_blob(struct traversal_context *ctx,
     + 			 struct blob *blob,
     + 			 struct strbuf *path,
     +@@ list-objects.c: static void process_blob(struct traversal_context *ctx,
     + 	if (r & LOFR_MARK_SEEN)
     + 		obj->flags |= SEEN;
     + 	if (r & LOFR_DO_SHOW)
     +-		ctx->show_object(obj, path->buf, ctx->show_data);
     ++		show_object(ctx, obj, path->buf);
     + 	strbuf_setlen(path, pathlen);
     + }
     + 
     +@@ list-objects.c: static void process_tree(struct traversal_context *ctx,
     + 	if (r & LOFR_MARK_SEEN)
     + 		obj->flags |= SEEN;
     + 	if (r & LOFR_DO_SHOW)
     +-		ctx->show_object(obj, base->buf, ctx->show_data);
     ++		show_object(ctx, obj, base->buf);
     + 	if (base->len)
     + 		strbuf_addch(base, '/');
     + 
     +@@ list-objects.c: static void process_tree(struct traversal_context *ctx,
     + 	if (r & LOFR_MARK_SEEN)
     + 		obj->flags |= SEEN;
     + 	if (r & LOFR_DO_SHOW)
     +-		ctx->show_object(obj, base->buf, ctx->show_data);
     ++		show_object(ctx, obj, base->buf);
     + 
     + 	strbuf_setlen(base, baselen);
     + 	free_tree_buffer(tree);
     +@@ list-objects.c: static void process_tag(struct traversal_context *ctx,
     + 	if (r & LOFR_MARK_SEEN)
     + 		tag->object.flags |= SEEN;
     + 	if (r & LOFR_DO_SHOW)
     +-		ctx->show_object(&tag->object, name, ctx->show_data);
     ++		show_object(ctx, &tag->object, name);
     + }
     + 
     + static void mark_edge_parents_uninteresting(struct commit *commit,
     +@@ list-objects.c: static void do_traverse(struct traversal_context *ctx)
     + 		if (r & LOFR_MARK_SEEN)
     + 			commit->object.flags |= SEEN;
     + 		if (r & LOFR_DO_SHOW)
     +-			ctx->show_commit(commit, ctx->show_data);
     ++			show_commit(ctx, commit);
     + 
     + 		if (ctx->revs->tree_blobs_in_commit_order)
     + 			/*
      
       ## t/t6020-bundle-misc.sh ##
      @@ t/t6020-bundle-misc.sh: test_expect_success 'clone from bundle' '
  8:  898a7d94513 !  8:  025f38290f5 bundle: parse filter capability
     @@ bundle.c: void bundle_header_release(struct bundle_header *header)
       {
       	string_list_clear(&header->prerequisites, 1);
       	string_list_clear(&header->references, 1);
     -+	list_objects_filter_release(header->filter);
     -+	free(header->filter);
     ++	list_objects_filter_release(&header->filter);
       }
       
       static int parse_capability(struct bundle_header *header, const char *capability)
     @@ bundle.c: static int parse_capability(struct bundle_header *header, const char *
       		return 0;
       	}
      +	if (skip_prefix(capability, "filter=", &arg)) {
     -+		CALLOC_ARRAY(header->filter, 1);
     -+		parse_list_objects_filter(header->filter, arg);
     ++		parse_list_objects_filter(&header->filter, arg);
      +		return 0;
      +	}
       	return error(_("unknown capability '%s'"), capability);
     @@ bundle.c: int verify_bundle(struct repository *r,
       	req_nr = revs.pending.nr;
       	setup_revisions(2, argv, &revs, NULL);
       
     -+	revs.filter = header->filter;
     ++	revs.filter = &header->filter;
      +
       	if (prepare_revision_walk(&revs))
       		die(_("revision walk setup failed"));
     @@ bundle.c: int verify_bundle(struct repository *r,
       			  r->nr);
       		list_refs(r, 0, NULL);
      +
     -+		if (header->filter) {
     ++		if (header->filter.choice != LOFC_DISABLED) {
      +			printf_ln("The bundle uses this filter: %s",
     -+				  list_objects_filter_spec(header->filter));
     ++				  list_objects_filter_spec(&header->filter));
      +		}
      +
       		r = &header->prerequisites;
     @@ bundle.c: int verify_bundle(struct repository *r,
      
       ## bundle.h ##
      @@
     + #include "strvec.h"
       #include "cache.h"
       #include "string-list.h"
     ++#include "list-objects-filter-options.h"
       
     -+struct list_objects_filter_options;
     -+
       struct bundle_header {
       	unsigned version;
       	struct string_list prerequisites;
       	struct string_list references;
       	const struct git_hash_algo *hash_algo;
     -+	struct list_objects_filter_options *filter;
     ++	struct list_objects_filter_options filter;
       };
       
       #define BUNDLE_HEADER_INIT \
  9:  aaa15d7d512 =  9:  2c8e8a6c2a5 rev-list: move --filter parsing into revision.c
 10:  82d93fc62e2 ! 10:  470b6f73e28 bundle: create filtered bundles
     @@ bundle.c: int create_bundle(struct repository *r, const char *path,
      +	 */
      +	revs.filter = NULL;
       	revs.blob_objects = revs.tree_objects = 0;
     - 	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
     + 	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
       	object_array_remove_duplicates(&revs_copy.pending);
      
       ## t/t6020-bundle-misc.sh ##
 11:  ef17691a6b7 ! 11:  e85ca2770a3 bundle: unbundle promisor packs
     @@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
       	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
       
      +	/* If there is a filter, then we need to create the promisor pack. */
     -+	if (header->filter)
     ++	if (header->filter.choice != LOFC_DISABLED)
      +		strvec_push(&ip.args, "--promisor=from-bundle");
      +
       	if (extra_index_pack_args) {
 12:  382b9502f6b ! 12:  805e1d11722 clone: fail gracefully when cloning filtered bundle
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      +	if (is_bundle) {
      +		struct bundle_header header = { 0 };
      +		int fd = read_bundle_header(path, &header);
     -+		int has_filter = !!header.filter;
     ++		int has_filter = header.filter.choice != LOFC_DISABLED;
      +
      +		if (fd > 0)
      +			close(fd);

-- 
gitgitgadget
