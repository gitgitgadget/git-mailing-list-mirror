Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B4391F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeJFEc3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:32:29 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:51765 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJFEc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:32:29 -0400
Received: by mail-it1-f201.google.com with SMTP id u2-v6so3742840ith.1
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Lp0eSAdRXCT9/FhKMrpAha2q1c+QYgylCXEowJj2B4Y=;
        b=hVTnPduh/43zBCoq4n7TtObgQSJnzwtto+o1zzr2B9RH15NaQLEKiMVY1+pb61Hnr4
         xB0TzygYQjTjPLjWgk7BM0e/xI1FqGUzXsaWfKuA+elE7NJlAfyPnGLuTRKxXV/fsIHn
         1wprKDe1rdIvmhKikEvpa+fbodFhlN3ks68BZ5vcP4/i4ds9inlr6M+gl1WvPjT6y2ut
         t0pB2iuVAVSoQADq83LCTbIVQ/kNtzcav6mR1mCCC/6zqHMQul7Jb6Oo1c/faC6okABs
         mD099XFEWC61lAn7YAQT9ofF9ecmwfPb9IOLzVOaN/WyL/lRVAiZ0I5cH3SKrkpqERfK
         4ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Lp0eSAdRXCT9/FhKMrpAha2q1c+QYgylCXEowJj2B4Y=;
        b=DOjPlfjXGA/N1TACI8+/49z69wEdTizAdUGWfznUMI963/oa9PNntUnmqWrXUMBa1i
         CVF5xLZG1jllq6E6EzM/5DaX4jV5XXihfilzegZxW1dhVTyVkfBKhe/5hlMeWNiVlOgg
         6bC3iy8HGWBOVK1otLUeAgI2S73+7BTCXUtfFEwM0wlmzNzEg7YXMAVgVKDlYfSueQGg
         LbI+6OUZlMubyE7FCeu01uOyxoUUgR7Gnw4TECZV9KliWBdFn2HgnKhm9f65xGIDdCzz
         cuwyqe8wW3trKl00UFfHoKmxJB46tvmQKs5ipVlrWr7lwXkGDDizePty2jj+0/ZCgmol
         Prdw==
X-Gm-Message-State: ABuFfog48NkxytsSdWGatGfWhcbbJ3dq2Yr2aA7Z/nJtNWaeWvyEmT+G
        l0jZ6qf2qRqBnAMOyNJBU/W2LJ+m1BG2VobeO9xG01reNK890a3J0IoLf7HvZEKIQKqiJWSiqET
        wgGTH0v+CpQO8izbZKpt/1I+/1furs0NhXQlM4hZB/LpNqgcp02AUNkHUGDo=
X-Google-Smtp-Source: ACcGV61rBFT19pEkZly/KS1vfxBsydk7Dpg2GXJm/2OgOce+NHdaNjvB1YEUOf5eRjv29DXHHNIpwAALZ1Uw
X-Received: by 2002:a24:ee43:: with SMTP id b64-v6mr13588310iti.3.1538775114980;
 Fri, 05 Oct 2018 14:31:54 -0700 (PDT)
Date:   Fri,  5 Oct 2018 14:31:27 -0700
In-Reply-To: <cover.1538774738.git.matvore@google.com>
Message-Id: <6ca50a28e292f32127ea706a2aef39f834ac7702.1538774738.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1538774738.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v11 8/8] list-objects-filter: implement filter tree:0
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach list-objects the "tree:0" filter which allows for filtering
out all tree and blob objects (unless other objects are explicitly
specified by the user). The purpose of this patch is to allow smaller
partial clones.

The name of this filter - tree:0 - does not explicitly specify that
it also filters out all blobs, but this should not cause much confusion
because blobs are not at all useful without the trees that refer to
them.

I also considered only:commits as a name, but this is inaccurate because
it suggests that annotated tags are omitted, but actually they are
included.

The name "tree:0" allows later filtering based on depth, i.e. "tree:1"
would filter out all but the root tree and blobs. In order to avoid
confusion between 0 and capital O, the documentation was worded in a
somewhat round-about way that also hints at this future improvement to
the feature.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/rev-list-options.txt     |  5 +++
 list-objects-filter-options.c          | 13 +++++++
 list-objects-filter-options.h          |  1 +
 list-objects-filter.c                  | 49 ++++++++++++++++++++++++++
 t/t5317-pack-objects-filter-objects.sh | 28 +++++++++++++++
 t/t5616-partial-clone.sh               | 42 ++++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh    | 15 ++++++++
 7 files changed, 153 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7b273635d..5f1672913 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -731,6 +731,11 @@ the requested refs.
 +
 The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
 specification contained in <path>.
++
+The form '--filter=tree:<depth>' omits all blobs and trees whose depth
+from the root tree is >= <depth> (minimum depth if an object is located
+at multiple depths in the commits traversed). Currently, only <depth>=0
+is supported, which omits all blobs and trees.
 
 --no-filter::
 	Turn off any previous `--filter=` argument.
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index d259bdb2c..e8da2e858 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -49,6 +49,19 @@ static int gently_parse_list_objects_filter(
 			return 0;
 		}
 
+	} else if (skip_prefix(arg, "tree:", &v0)) {
+		unsigned long depth;
+		if (!git_parse_ulong(v0, &depth) || depth != 0) {
+			if (errbuf) {
+				strbuf_addstr(
+					errbuf,
+					_("only 'tree:0' is supported"));
+			}
+			return 1;
+		}
+		filter_options->choice = LOFC_TREE_NONE;
+		return 0;
+
 	} else if (skip_prefix(arg, "sparse:oid=", &v0)) {
 		struct object_context oc;
 		struct object_id sparse_oid;
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 0000a61f8..af64e5c66 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -10,6 +10,7 @@ enum list_objects_filter_choice {
 	LOFC_DISABLED = 0,
 	LOFC_BLOB_NONE,
 	LOFC_BLOB_LIMIT,
+	LOFC_TREE_NONE,
 	LOFC_SPARSE_OID,
 	LOFC_SPARSE_PATH,
 	LOFC__COUNT /* must be last */
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 5f8b1a002..09b2b05d5 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -79,6 +79,54 @@ static void *filter_blobs_none__init(
 	return d;
 }
 
+/*
+ * A filter for list-objects to omit ALL trees and blobs from the traversal.
+ * Can OPTIONALLY collect a list of the omitted OIDs.
+ */
+struct filter_trees_none_data {
+	struct oidset *omits;
+};
+
+static enum list_objects_filter_result filter_trees_none(
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data_)
+{
+	struct filter_trees_none_data *filter_data = filter_data_;
+
+	switch (filter_situation) {
+	default:
+		BUG("unknown filter_situation: %d", filter_situation);
+
+	case LOFS_BEGIN_TREE:
+	case LOFS_BLOB:
+		if (filter_data->omits)
+			oidset_insert(filter_data->omits, &obj->oid);
+		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
+
+	case LOFS_END_TREE:
+		assert(obj->type == OBJ_TREE);
+		return LOFR_ZERO;
+
+	}
+}
+
+static void* filter_trees_none__init(
+	struct oidset *omitted,
+	struct list_objects_filter_options *filter_options,
+	filter_object_fn *filter_fn,
+	filter_free_fn *filter_free_fn)
+{
+	struct filter_trees_none_data *d = xcalloc(1, sizeof(*d));
+	d->omits = omitted;
+
+	*filter_fn = filter_trees_none;
+	*filter_free_fn = free;
+	return d;
+}
+
 /*
  * A filter for list-objects to omit large blobs.
  * And to OPTIONALLY collect a list of the omitted OIDs.
@@ -371,6 +419,7 @@ static filter_init_fn s_filters[] = {
 	NULL,
 	filter_blobs_none__init,
 	filter_blobs_limit__init,
+	filter_trees_none__init,
 	filter_sparse_oid__init,
 	filter_sparse_path__init,
 };
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 9839b48c1..510d3537f 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -72,6 +72,34 @@ test_expect_success 'get an error for missing tree object' '
 	grep -q "bad tree object" bad_tree
 '
 
+test_expect_success 'setup for tests of tree:0' '
+	mkdir r1/subtree &&
+	echo "This is a file in a subtree" >r1/subtree/file &&
+	git -C r1 add subtree/file &&
+	git -C r1 commit -m subtree
+'
+
+test_expect_success 'verify tree:0 packfile has no blobs or trees' '
+	git -C r1 pack-objects --rev --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r1 index-pack ../commitsonly.pack &&
+	git -C r1 verify-pack -v ../commitsonly.pack >objs &&
+	! grep -E "tree|blob" objs
+'
+
+test_expect_success 'grab tree directly when using tree:0' '
+	# We should get the tree specified directly but not its blobs or subtrees.
+	git -C r1 pack-objects --rev --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
+	HEAD:
+	EOF
+	git -C r1 index-pack ../commitsonly.pack &&
+	git -C r1 verify-pack -v ../commitsonly.pack >objs &&
+	awk "/tree|blob/{print \$1}" objs >trees_and_blobs &&
+	git -C r1 rev-parse HEAD: >expected &&
+	test_cmp expected trees_and_blobs
+'
+
 # Test blob:limit=<n>[kmg] filter.
 # We boundary test around the size parameter.  The filter is strictly less than
 # the value, so size 500 and 1000 should have the same results, but 1001 should
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index bbbe7537d..53fbf7db8 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -154,6 +154,48 @@ test_expect_success 'partial clone with transfer.fsckobjects=1 uses index-pack -
 	grep "git index-pack.*--fsck-objects" trace
 '
 
+test_expect_success 'use fsck before and after manually fetching a missing subtree' '
+	# push new commit so server has a subtree
+	mkdir src/dir &&
+	echo "in dir" >src/dir/file.txt &&
+	git -C src add dir/file.txt &&
+	git -C src commit -m "file in dir" &&
+	git -C src push -u srv master &&
+	SUBTREE=$(git -C src rev-parse HEAD:dir) &&
+
+	rm -rf dst &&
+	git clone --no-checkout --filter=tree:0 "file://$(pwd)/srv.bare" dst &&
+	git -C dst fsck &&
+
+	# Make sure we only have commits, and all trees and blobs are missing.
+	git -C dst rev-list --missing=allow-any --objects master \
+		>fetched_objects &&
+	awk -f print_1.awk fetched_objects |
+	xargs -n1 git -C dst cat-file -t >fetched_types &&
+
+	sort -u fetched_types >unique_types.observed &&
+	echo commit >unique_types.expected &&
+	test_cmp unique_types.expected unique_types.observed &&
+
+	# Auto-fetch a tree with cat-file.
+	git -C dst cat-file -p $SUBTREE >tree_contents &&
+	grep file.txt tree_contents &&
+
+	# fsck still works after an auto-fetch of a tree.
+	git -C dst fsck &&
+
+	# Auto-fetch all remaining trees and blobs with --missing=error
+	git -C dst rev-list --missing=error --objects master >fetched_objects &&
+	test_line_count = 70 fetched_objects &&
+
+	awk -f print_1.awk fetched_objects |
+	xargs -n1 git -C dst cat-file -t >fetched_types &&
+
+	sort -u fetched_types >unique_types.observed &&
+	printf "blob\ncommit\ntree\n" >unique_types.expected &&
+	test_cmp unique_types.expected unique_types.observed
+'
+
 test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
 	rm -rf src dst &&
 	git init src &&
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index ccbc64413..c8e3d87c4 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -229,6 +229,21 @@ test_expect_success 'rev-list W/ --missing=print and --missing=allow-any for tre
 	test_must_be_empty rev_list_err
 '
 
+# Test tree:0 filter.
+
+test_expect_success 'verify tree:0 includes trees in "filtered" output' '
+	git -C r3 rev-list --quiet --objects --filter-print-omitted \
+		--filter=tree:0 HEAD >revs &&
+
+	awk -f print_1.awk revs |
+	sed s/~// |
+	xargs -n1 git -C r3 cat-file -t >unsorted_filtered_types &&
+
+	sort -u unsorted_filtered_types >filtered_types &&
+	printf "blob\ntree\n" >expected &&
+	test_cmp expected filtered_types
+'
+
 # Delete some loose objects and use rev-list, but WITHOUT any filtering.
 # This models previously omitted objects that we did not receive.
 
-- 
2.19.0.605.g01d371f741-goog

