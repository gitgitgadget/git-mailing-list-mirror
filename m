Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA99DC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C62F22DD3
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbhASX2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbhASXZq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:25:46 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD78C061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:41 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a13so10068368qvv.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qYZDl7R5nKb2oLIyeoqdTbFfpmVafMEGT2uCwITQx1Q=;
        b=hcfc7Iu5jxxqROkGWPzPHBGdtxzihCFaCiMoTCNeLhC0yGqGe+qaJpWiG/yUnE4GDf
         XmKOfkXhljnvP7ox2ju976QtiCQV2QuU+MxE95ECrK2NaDXWIpbRmjl2aqX/QyAbZGGy
         3lmm96GNoIBs0FCYpGkbJvtoqq6iH1QEmVm7TNPhH2yK/a+SjA9KPAeO8Fr0PFDUpXVj
         n2juyj5Y/Q7QXigdMPSz/FctDY7mXV8fSRcE+3Mv+p5L76h8q5tiWQezL1HxKAsC9uor
         TYzgX0OSC7GsvI75/zp7qjFbvzQkfF35ClDY836TsdsCWvRF83P17FegRqSoWUgsmisO
         gIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qYZDl7R5nKb2oLIyeoqdTbFfpmVafMEGT2uCwITQx1Q=;
        b=DJzsvVaLUW31b/DlUNi9uXdnCkLFpSI8Bj1I9/Q87VxHRcxN0/+z7TUdMvL7huGogH
         MeAFkNJnVs8oe991RG4ucd77pVODnkbysE2TD7NING2mjMJ3cKKzlWlXEyXMJGYfJFY/
         HeXpysCAaPPhm8qh5YtZe+HvUreynXNM/k9up24WUtUj0tlayep457ddUysNi7hswqX5
         +LTFykoBU5QMp/5yD8fk5XF3TjGVh+MeNST5iz4hn/pE4vUVvgx1DsSzFRewIi+e88ko
         A7lWkGKFvVCoS+tLH9eiAFlmqp1B8Zcktuz1proNLBb75p0eCvu8MNF39cS1tMUb6Ma7
         Anxg==
X-Gm-Message-State: AOAM530gOMvfjue4IDLMoq2LHKhpiEWV0P1IKu1Ae0F9weSVKbBGtI80
        MKUm3w4jqy/KE3rLopqD4BlKXrwfwhEW1Q==
X-Google-Smtp-Source: ABdhPJywb/0Jakapi0zbXRMe24FTvNHCoklzdtNLE0Py8hATHCKEDWiRJGk1eIFSfsrf2R8aCvOQ8g==
X-Received: by 2002:ad4:57ab:: with SMTP id g11mr7069562qvx.38.1611098680582;
        Tue, 19 Jan 2021 15:24:40 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id m21sm98575qtq.52.2021.01.19.15.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:24:40 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:24:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 10/10] builtin/repack.c: add '--geometric' option
Message-ID: <f853087216cc7f1af8d376b5a8a9c86086ef8df0.1611098616.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Often it is useful to both:

  - have relatively few packfiles in a repository, and

  - avoid having so few packfiles in a repository that we repack its
    entire contents regularly

This patch implements a '--geometric=<n>' option in 'git repack'. This
allows the caller to specify that they would like each pack to be at
least a factor times as large as the previous largest pack (by object
count).

Concretely, say that a repository has 'n' packfiles, labeled P1, P2,
..., up to Pn. Each packfile has an object count equal to 'objects(Pn)'.
With a geometric factor of 'r', it should be that:

  objects(Pi) > r*objects(P(i-1))

for all i in [1, n], where the packs are sorted by

  objects(P1) <= objects(P2) <= ... <= objects(Pn).

Since finding a true optimal repacking is NP-hard, we approximate it
along two directions:

  1. We assume that there is a cutoff of packs _before starting the
     repack_ where everything to the right of that cut-off already forms
     a geometric progression (or no cutoff exists and everything must be
     repacked).

  2. We assume that everything smaller than the cutoff count must be
     repacked. This forms our base assumption, but it can also cause
     even the "heavy" packs to get repacked, for e.g., if we have 6
     packs containing the following number of objects:

       1, 1, 1, 2, 4, 32

     then we would place the cutoff between '1, 1' and '1, 2, 4, 32',
     rolling up the first two packs into a pack with 2 objects. That
     breaks our progression and leaves us:

       2, 1, 2, 4, 32
         ^

     (where the '^' indicates the position of our split). To restore a
     progression, we move the split forward (towards larger packs)
     joining each pack into our new pack until a geometric progression
     is restored. Here, that looks like:

       2, 1, 2, 4, 32  ~>  3, 2, 4, 32  ~>  5, 4, 32  ~> ... ~> 9, 32
         ^                   ^                ^                   ^

This has the advantage of not repacking the heavy-side of packs too
often while also only creating one new pack at a time. Another wrinkle
is that we assume that loose, indexed, and reflog'd objects are
insignificant, and lump them into any new pack that we create. This can
lead to non-idempotent results.

Suggested-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.txt |  11 +++
 builtin/repack.c             | 165 ++++++++++++++++++++++++++++++++++-
 t/t7703-repack-geometric.sh  |  81 +++++++++++++++++
 3 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100755 t/t7703-repack-geometric.sh

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 92f146d27d..b1ffcfd974 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -165,6 +165,17 @@ depth is 4095.
 	Pass the `--delta-islands` option to `git-pack-objects`, see
 	linkgit:git-pack-objects[1].
 
+-g=<factor>::
+--geometric=<factor>::
+	Arrange resulting pack structure so that each successive pack
+	contains at least `<factor>` times the number of objects as the
+	next-largest pack.
++
+`git repack` ensures this by determining a "cut" of packfiles that need to be
+repacked into one in order to ensure a geometric progression. It picks the
+smallest set of packfiles such that as many of the larger packfiles (by count of
+objects contained in that pack) may be left intact.
+
 Configuration
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 664863111b..083088ae1f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -298,6 +298,116 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
 
+struct pack_geometry {
+	struct packed_git **pack;
+	uint32_t pack_nr, pack_alloc;
+	uint32_t split;
+};
+
+static uint32_t geometry_pack_weight(struct packed_git *p)
+{
+	if (open_pack_index(p))
+		die(_("cannot open index for %s"), p->pack_name);
+	return p->num_objects;
+}
+
+static int geometry_cmp(const void *va, const void *vb)
+{
+	uint32_t aw = geometry_pack_weight(*(struct packed_git **)va),
+		 bw = geometry_pack_weight(*(struct packed_git **)vb);
+
+	if (aw < bw)
+		return -1;
+	if (aw > bw)
+		return 1;
+	return 0;
+}
+
+static void init_pack_geometry(struct pack_geometry **geometry_p)
+{
+	struct packed_git *p;
+	struct pack_geometry *geometry;
+
+	*geometry_p = xcalloc(1, sizeof(struct pack_geometry));
+	geometry = *geometry_p;
+
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		ALLOC_GROW(geometry->pack,
+			   geometry->pack_nr + 1,
+			   geometry->pack_alloc);
+
+		geometry->pack[geometry->pack_nr] = p;
+		geometry->pack_nr++;
+	}
+
+	QSORT(geometry->pack, geometry->pack_nr, geometry_cmp);
+}
+
+static void split_pack_geometry(struct pack_geometry *geometry, int factor)
+{
+	uint32_t i;
+	uint32_t split;
+	off_t total_size = 0;
+
+	split = geometry->pack_nr - 1;
+
+	/*
+	 * First, count the number of packs (in descending order of size) which
+	 * already form a geometric progression.
+	 */
+	for (i = geometry->pack_nr - 1; i > 0; i--) {
+		struct packed_git *ours = geometry->pack[i];
+		struct packed_git *prev = geometry->pack[i - 1];
+		if (geometry_pack_weight(ours) >= factor * geometry_pack_weight(prev))
+			split--;
+		else
+			break;
+	}
+
+	if (split) {
+		/*
+		 * Move the split one to the right, since the top element in the
+		 * last-compared pair can't be in the progression. Only do this
+		 * when we split in the middle of the array (otherwise if we got
+		 * to the end, then the split is in the right place).
+		 */
+		split++;
+	}
+
+	/*
+	 * Then, anything to the left of 'split' must be in a new pack. But,
+	 * creating that new pack may cause packs in the heavy half to no longer
+	 * form a geometric progression.
+	 *
+	 * Compute an expected size of the new pack, and then determine how many
+	 * packs in the heavy half need to be joined into it (if any) to restore
+	 * the geometric progression.
+	 */
+	for (i = 0; i < split; i++)
+		total_size += geometry_pack_weight(geometry->pack[i]);
+	for (i = split; i < geometry->pack_nr; i++) {
+		struct packed_git *ours = geometry->pack[i];
+		if (geometry_pack_weight(ours) < factor * total_size) {
+			split++;
+			total_size += geometry_pack_weight(ours);
+		} else
+			break;
+	}
+
+	geometry->split = split;
+}
+
+static void clear_pack_geometry(struct pack_geometry *geometry)
+{
+	if (!geometry)
+		return;
+
+	free(geometry->pack);
+	geometry->pack_nr = 0;
+	geometry->pack_alloc = 0;
+	geometry->split = 0;
+}
+
 static void handle_loose_and_reachable(struct child_process *cmd,
 				       const char *unpack_unreachable,
 				       int pack_everything,
@@ -326,6 +436,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_packs = STRING_LIST_INIT_DUP;
+	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
 	int i, ext, ret;
 	FILE *out;
@@ -338,6 +449,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	int no_update_server_info = 0;
 	struct pack_objects_args po_args = {NULL};
+	int geometric_factor = 0;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -378,6 +490,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("do not repack this pack")),
+		OPT_INTEGER('g', "geometric", &geometric_factor,
+			    N_("find a geometric progression with factor <N>")),
 		OPT_END()
 	};
 
@@ -404,6 +518,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
 		die(_(incremental_bitmap_conflict_error));
 
+	if (geometric_factor) {
+		init_pack_geometry(&geometry);
+		split_pack_geometry(geometry, geometric_factor);
+	}
+
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
 
@@ -439,17 +558,41 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			handle_loose_and_reachable(&cmd, unpack_unreachable,
 						   pack_everything,
 						   keep_unreachable);
+	} else if (geometry) {
+		strvec_push(&cmd.args, "--keep-pack-stdin");
+		strvec_push(&cmd.args, "--honor-pack-keep");
+		strvec_push(&cmd.args, "--assume-kept-packs-closed");
+		if (delete_redundant)
+			handle_loose_and_reachable(&cmd, unpack_unreachable,
+						   pack_everything,
+						   keep_unreachable);
 	} else {
 		strvec_push(&cmd.args, "--unpacked");
 		strvec_push(&cmd.args, "--incremental");
 	}
 
-	cmd.no_stdin = 1;
+	if (geometry)
+		cmd.in = -1;
+	else
+		cmd.no_stdin = 1;
 
 	ret = start_command(&cmd);
 	if (ret)
 		return ret;
 
+	if (geometry) {
+		FILE *in = xfdopen(cmd.in, "w");
+		/*
+		 * Tell 'git pack-objects' to avoid tampering with the structure
+		 * with the packs that already form a geometric progression.
+		 *
+		 * Everything else will get picked up by the reachability walk.
+		 */
+		for (i = geometry->split; i < geometry->pack_nr; i++)
+			fprintf(in, "%s\n", pack_basename(geometry->pack[i]));
+		fclose(in);
+	}
+
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		if (line.len != the_hash_algo->hexsz)
@@ -517,6 +660,25 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			if (!string_list_has_string(&names, sha1))
 				remove_redundant_pack(packdir, item->string);
 		}
+
+		if (geometry) {
+			struct strbuf buf = STRBUF_INIT;
+
+			uint32_t i;
+			for (i = 0; i < geometry->split; i++) {
+				struct packed_git *p = geometry->pack[i];
+				if (string_list_has_string(&names,
+							   hash_to_hex(p->hash)))
+					continue;
+
+				strbuf_reset(&buf);
+				strbuf_addstr(&buf, pack_basename(p));
+				strbuf_strip_suffix(&buf, ".pack");
+
+				remove_redundant_pack(packdir, buf.buf);
+			}
+			strbuf_release(&buf);
+		}
 		if (!po_args.quiet && isatty(2))
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
@@ -538,6 +700,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
 	string_list_clear(&existing_packs, 0);
+	clear_pack_geometry(geometry);
 	strbuf_release(&line);
 
 	return 0;
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
new file mode 100755
index 0000000000..39cef892f8
--- /dev/null
+++ b/t/t7703-repack-geometric.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description='git repack --geometric works correctly'
+
+. ./test-lib.sh
+
+GIT_TEST_MULTI_PACK_INDEX=0
+
+objdir=.git/objects
+midx=$objdir/pack/multi-pack-index
+
+test_expect_success '--geometric with an intact progression' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		# These packs already form a geometric progression.
+		test_commit_bulk --start=1 1 && # 3 objects
+		test_commit_bulk --start=2 2 && # 6 objects
+		test_commit_bulk --start=4 4 && # 12 objects
+
+		find $objdir/pack -name "*.pack" | sort >expect &&
+		GIT_TEST_MULTI_PACK_BITMAP=0 git repack --geometric 2 -d &&
+		find $objdir/pack -name "*.pack" | sort >actual &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--geometric with small-pack rollup' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		test_commit_bulk --start=1 1 && # 3 objects
+		test_commit_bulk --start=2 1 && # 3 objects
+		find $objdir/pack -name "*.pack" | sort >small &&
+		test_commit_bulk --start=3 4 && # 12 objects
+		test_commit_bulk --start=7 8 && # 24 objects
+		find $objdir/pack -name "*.pack" | sort >before &&
+
+		GIT_TEST_MULTI_PACK_BITMAP=0 git repack --geometric 2 -d &&
+
+		# Three packs in total; two of the existing large ones, and one
+		# new one.
+		find $objdir/pack -name "*.pack" | sort >after &&
+		test_line_count = 3 after &&
+		comm -3 small before | tr -d "\t" >large &&
+		grep -qFf large after
+	)
+'
+
+test_expect_success '--geometric with small- and large-pack rollup' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		# size(small1) + size(small2) > size(medium) / 2
+		test_commit_bulk --start=1 1 && # 3 objects
+		test_commit_bulk --start=2 1 && # 3 objects
+		test_commit_bulk --start=2 3 && # 7 objects
+		test_commit_bulk --start=6 9 && # 27 objects &&
+
+		find $objdir/pack -name "*.pack" | sort >before &&
+
+		GIT_TEST_MULTI_PACK_BITMAP=0 git repack --geometric 2 -d &&
+
+		find $objdir/pack -name "*.pack" | sort >after &&
+		comm -12 before after >untouched &&
+
+		# Two packs in total; the largest pack from before running "git
+		# repack", and one new one.
+		test_line_count = 1 untouched &&
+		test_line_count = 2 after
+	)
+'
+
+test_done
-- 
2.30.0.138.g6d7191ea01
