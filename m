Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0CFE1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 15:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeDOPgh (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 11:36:37 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37809 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbeDOPgd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 11:36:33 -0400
Received: by mail-lf0-f66.google.com with SMTP id m200-v6so18598853lfm.4
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jEk/so7QVOZ6iAruifNIUC9H8T81uu5wc6Azg2dOTgw=;
        b=pv8MS9DemAQ1mUlyoAaZk4nbApcICDGC+4KINOJFZgN4HgWNunF5wU2w33RcC6wkqJ
         9TQ1s3gEnUGsJsr2IjHFzJ5lK6bPHu/V3RMQS+2iq2VkZBbxpBI13n4rk4scS4ZkMTsQ
         FiL5hMiQoLgmsZGHUr4dLS9nI8IBD6IBxRYTHeNxOe0pxVYI6kwKMpdLu3/4uZDO6JE4
         EXY0FOTCPEH9wKoZkt0712k1HuamD3RseqJgbsGvy4EWzDFKhDgA3NIyEVbR/huZJOaz
         DjnDkReS5nQr18g9BQ/ToI+dVgrKvzk7ceWNrV38HJifHpf+255XtbqXji5GTWoLLuaU
         h28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jEk/so7QVOZ6iAruifNIUC9H8T81uu5wc6Azg2dOTgw=;
        b=oZDEWPHXj4fPFnfY/AbH+1tKzY+isYsTN7p94Wz0LDEUb0obmFn/cSnEUj7e4xBMLt
         3drXzHgQUx7Zo0KhVovsPYSo302IAnvv8sd3TctBtSy1ig0Sq51fLQQ779trIL8rrYsx
         thRE53Ur5kcS4OC+LOLuNelGC6Sq6/EnJ647zOnTPqQHL+mGkkNexVeAd9BhyjEN+/52
         fSoy+i041tY3o9OresMoHlyjZIiRHezl0G4RKSZpZhiZ+EiAaDNIFnlSaZKv5zu6MsU3
         CdraXzc5b9eSHeIcj3tLEZmiwFzhiVbG98mOkfJDLwDSFMqwtFXBmNsa/jIDS0fiArCp
         OYFw==
X-Gm-Message-State: ALQs6tAiAbyFTbRuDvtnZkMp7S7bueUWJbvMa0V21GrO9/OhvRLRRAV/
        AHc9IoKsX95D5oOq0pBkYWWYVA==
X-Google-Smtp-Source: AIpwx4/r0BSm6edczI6mUZjlSBIyTH72xRRb+sCt7/rl/T+E+EoTjYp6fUTIjG1vyqiuAGT7KUZGuA==
X-Received: by 2002:a19:d9d4:: with SMTP id s81-v6mr12205324lfi.49.1523806591943;
        Sun, 15 Apr 2018 08:36:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w10sm826176lji.47.2018.04.15.08.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 08:36:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>
Subject: [PATCH v2 2/7] repack: add --keep-pack option
Date:   Sun, 15 Apr 2018 17:36:13 +0200
Message-Id: <20180415153618.32019-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180415153618.32019-1-pclouds@gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com>
 <20180415153618.32019-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We allow to keep existing packs by having companion .keep files. This
is helpful when a pack is permanently kept. In the next patch, git-gc
just wants to keep a pack temporarily, for one pack-objects
run. git-gc can use --keep-pack for this use case.

A note about why the pack_keep field cannot be reused and
pack_keep_in_core has to be added. This is about the case when
--keep-pack is specified together with either --keep-unreachable or
--unpack-unreachable, but --honor-pack-keep is NOT specified.

In this case, we want to exclude objects from the packs specified on
command line, not from ones with .keep files. If only one bit flag is
used, we have to clear pack_keep on pack files with the .keep file.

But we can't make any assumption about unreachable objects in .keep
packs. If "pack_keep" field is false for .keep packs, we could
potentially pull lots of unreachable objects into the new pack, or
unpack them loose. The safer approach is ignore all packs with either
.keep file or --keep-pack.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-pack-objects.txt |  9 ++++-
 Documentation/git-repack.txt       |  9 ++++-
 builtin/pack-objects.c             | 63 ++++++++++++++++++++++++------
 builtin/repack.c                   | 21 ++++++++--
 object-store.h                     |  1 +
 t/t7700-repack.sh                  | 25 ++++++++++++
 6 files changed, 110 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 81bc490ac5..403524652a 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
-	[--revs [--unpacked | --all]]
+	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
 	[--stdout [--filter=<filter-spec>] | base-name]
 	[--shallow] [--keep-true-parents] < object-list
 
@@ -126,6 +126,13 @@ base-name::
 	has a .keep file to be ignored, even if it would have
 	otherwise been packed.
 
+--keep-pack=<pack-name>::
+	This flag causes an object already in the given pack to be
+	ignored, even if it would have otherwise been
+	packed. `<pack-name>` is the the pack file name without
+	leading directory (e.g. `pack-123.pack`). The option could be
+	specified multiple times to keep multiple packs.
+
 --incremental::
 	This flag causes an object already in a pack to be ignored
 	even if it would have otherwise been packed.
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ae750e9e11..ce497d9d12 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [--window=<n>] [--depth=<n>] [--threads=<n>]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
 
 DESCRIPTION
 -----------
@@ -133,6 +133,13 @@ other objects in that pack they already have locally.
 	with `-b` or `repack.writeBitmaps`, as it ensures that the
 	bitmapped packfile has the necessary objects.
 
+--keep-pack=<pack-name>::
+	Exclude the given pack from repacking. This is the equivalent
+	of having `.keep` file on the pack. `<pack-name>` is the the
+	pack file name without leading directory (e.g. `pack-123.pack`).
+	The option could be specified multiple times to keep multiple
+	packs.
+
 --unpack-unreachable=<when>::
 	When loosening unreachable objects, do not bother loosening any
 	objects older than `<when>`. This can be used to optimize out
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4bdae5a1d8..9b9a6d6268 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -30,6 +30,7 @@
 #include "list.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "dir.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -55,7 +56,8 @@ static int pack_loose_unreachable;
 static int local;
 static int have_non_local_packs;
 static int incremental;
-static int ignore_packed_keep;
+static int ignore_packed_keep_on_disk;
+static int ignore_packed_keep_in_core;
 static int allow_ofs_delta;
 static struct pack_idx_option pack_idx_opts;
 static const char *base_name;
@@ -982,13 +984,16 @@ static int want_found_object(int exclude, struct packed_git *p)
 	 * Otherwise, we signal "-1" at the end to tell the caller that we do
 	 * not know either way, and it needs to check more packs.
 	 */
-	if (!ignore_packed_keep &&
+	if (!ignore_packed_keep_on_disk &&
+	    !ignore_packed_keep_in_core &&
 	    (!local || !have_non_local_packs))
 		return 1;
 
 	if (local && !p->pack_local)
 		return 0;
-	if (ignore_packed_keep && p->pack_local && p->pack_keep)
+	if (p->pack_local &&
+	    ((ignore_packed_keep_on_disk && p->pack_keep) ||
+	     (ignore_packed_keep_in_core && p->pack_keep_in_core)))
 		return 0;
 
 	/* we don't know yet; keep looking for more packs */
@@ -2675,7 +2680,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 		struct object_id oid;
 		struct object *o;
 
-		if (!p->pack_local || p->pack_keep)
+		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
 		if (open_pack_index(p))
 			die("cannot open pack index");
@@ -2738,7 +2743,8 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 					get_packed_git(the_repository);
 
 	while (p) {
-		if ((!p->pack_local || p->pack_keep) &&
+		if ((!p->pack_local || p->pack_keep ||
+				p->pack_keep_in_core) &&
 			find_pack_entry_one(oid->hash, p)) {
 			last_found = p;
 			return 1;
@@ -2781,7 +2787,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 	struct object_id oid;
 
 	for (p = get_packed_git(the_repository); p; p = p->next) {
-		if (!p->pack_local || p->pack_keep)
+		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
 
 		if (open_pack_index(p))
@@ -2807,7 +2813,8 @@ static int pack_options_allow_reuse(void)
 {
 	return pack_to_stdout &&
 	       allow_ofs_delta &&
-	       !ignore_packed_keep &&
+	       !ignore_packed_keep_on_disk &&
+	       !ignore_packed_keep_in_core &&
 	       (!local || !have_non_local_packs) &&
 	       !incremental;
 }
@@ -2916,6 +2923,32 @@ static void get_object_list(int ac, const char **av)
 	oid_array_clear(&recent_objects);
 }
 
+static void add_extra_kept_packs(const struct string_list *names)
+{
+	struct packed_git *p;
+
+	if (!names->nr)
+		return;
+
+	for (p = get_packed_git(the_repository); p; p = p->next) {
+		const char *name = basename(p->pack_name);
+		int i;
+
+		if (!p->pack_local)
+			continue;
+
+		for (i = 0; i < names->nr; i++)
+			if (!fspathcmp(name, names->items[i].string))
+				break;
+
+		if (i < names->nr) {
+			p->pack_keep_in_core = 1;
+			ignore_packed_keep_in_core = 1;
+			continue;
+		}
+	}
+}
+
 static int option_parse_index_version(const struct option *opt,
 				      const char *arg, int unset)
 {
@@ -2955,6 +2988,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	struct argv_array rp = ARGV_ARRAY_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
+	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
 			    N_("do not show progress meter"), 0),
@@ -3019,8 +3053,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("create thin packs")),
 		OPT_BOOL(0, "shallow", &shallow,
 			 N_("create packs suitable for shallow fetches")),
-		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep,
+		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep_on_disk,
 			 N_("ignore packs that have companion .keep file")),
+		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
+				N_("ignore this pack")),
 		OPT_INTEGER(0, "compression", &pack_compression_level,
 			    N_("pack compression level")),
 		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
@@ -3148,19 +3184,20 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress && all_progress_implied)
 		progress = 2;
 
-	if (ignore_packed_keep) {
+	add_extra_kept_packs(&keep_pack_list);
+	if (ignore_packed_keep_on_disk) {
 		struct packed_git *p;
 		for (p = get_packed_git(the_repository); p; p = p->next)
 			if (p->pack_local && p->pack_keep)
 				break;
 		if (!p) /* no keep-able packs found */
-			ignore_packed_keep = 0;
+			ignore_packed_keep_on_disk = 0;
 	}
 	if (local) {
 		/*
-		 * unlike ignore_packed_keep above, we do not want to
-		 * unset "local" based on looking at packs, as it
-		 * also covers non-local objects
+		 * unlike ignore_packed_keep_on_disk above, we do not
+		 * want to unset "local" based on looking at packs, as
+		 * it also covers non-local objects
 		 */
 		struct packed_git *p;
 		for (p = get_packed_git(the_repository); p; p = p->next) {
diff --git a/builtin/repack.c b/builtin/repack.c
index 7bdb40142f..6c636e159e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -86,7 +86,8 @@ static void remove_pack_on_signal(int signo)
  * have a corresponding .keep or .promisor file. These packs are not to
  * be kept if we are going to pack everything into one file.
  */
-static void get_non_kept_pack_filenames(struct string_list *fname_list)
+static void get_non_kept_pack_filenames(struct string_list *fname_list,
+					const struct string_list *extra_keep)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -97,6 +98,14 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
 
 	while ((e = readdir(dir)) != NULL) {
 		size_t len;
+		int i;
+
+		for (i = 0; i < extra_keep->nr; i++)
+			if (!fspathcmp(e->d_name, extra_keep->items[i].string))
+				break;
+		if (extra_keep->nr > 0 && i < extra_keep->nr)
+			continue;
+
 		if (!strip_suffix(e->d_name, ".pack", &len))
 			continue;
 
@@ -148,7 +157,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_packs = STRING_LIST_INIT_DUP;
 	struct strbuf line = STRBUF_INIT;
-	int ext, ret, failed;
+	int i, ext, ret, failed;
 	FILE *out;
 
 	/* variables to be filled by option parsing */
@@ -160,6 +169,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	const char *depth = NULL;
 	const char *threads = NULL;
 	const char *max_pack_size = NULL;
+	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	int no_reuse_delta = 0, no_reuse_object = 0;
 	int no_update_server_info = 0;
 	int quiet = 0;
@@ -200,6 +210,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("maximum size of each packfile")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
+		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
+				N_("do not repack this pack")),
 		OPT_END()
 	};
 
@@ -230,6 +242,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--keep-true-parents");
 	if (!pack_kept_objects)
 		argv_array_push(&cmd.args, "--honor-pack-keep");
+	for (i = 0; i < keep_pack_list.nr; i++)
+		argv_array_pushf(&cmd.args, "--keep-pack=%s",
+				 keep_pack_list.items[i].string);
 	argv_array_push(&cmd.args, "--non-empty");
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
@@ -254,7 +269,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_push(&cmd.args, "--write-bitmap-index");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		get_non_kept_pack_filenames(&existing_packs);
+		get_non_kept_pack_filenames(&existing_packs, &keep_pack_list);
 
 		if (existing_packs.nr && delete_redundant) {
 			if (unpack_unreachable) {
diff --git a/object-store.h b/object-store.h
index fef33f345f..0a4dbb74d3 100644
--- a/object-store.h
+++ b/object-store.h
@@ -71,6 +71,7 @@ struct packed_git {
 	int pack_fd;
 	unsigned pack_local:1,
 		 pack_keep:1,
+		 pack_keep_in_core:1,
 		 freshened:1,
 		 do_not_close:1,
 		 pack_promisor:1;
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 38247afbec..6162e2a8e6 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -4,6 +4,12 @@ test_description='git repack works correctly'
 
 . ./test-lib.sh
 
+commit_and_pack() {
+	test_commit "$@" >/dev/null &&
+	SHA1=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
+	echo pack-${SHA1}.pack
+}
+
 test_expect_success 'objects in packs marked .keep are not repacked' '
 	echo content1 > file1 &&
 	echo content2 > file2 &&
@@ -196,5 +202,24 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
 	git cat-file -t $H1
 '
 
+test_expect_success 'repack --keep-pack' '
+	test_create_repo keep-pack &&
+	(
+		cd keep-pack &&
+		P1=$(commit_and_pack 1) &&
+		P2=$(commit_and_pack 2) &&
+		P3=$(commit_and_pack 3) &&
+		P4=$(commit_and_pack 4) &&
+		ls .git/objects/pack/*.pack >old-counts &&
+		test_line_count = 4 old-counts &&
+		git repack -a -d --keep-pack $P1 --keep-pack $P4 &&
+		ls .git/objects/pack/*.pack >new-counts &&
+		grep -q $P1 new-counts &&
+		grep -q $P4 new-counts &&
+		test_line_count = 3 new-counts &&
+		git fsck
+	)
+'
+
 test_done
 
-- 
2.17.0.367.g5dd2e386c3

