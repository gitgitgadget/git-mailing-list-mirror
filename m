Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71021F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbeHIA4A (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:56:00 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:56823 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbeHIA4A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:56:00 -0400
Received: by mail-it0-f73.google.com with SMTP id g4-v6so24828itf.6
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y7a6X46x8F7MlojQvSFkOa3T30hCbA6SCFF+IE72gBM=;
        b=TQt1V/NmuP1tzJxi5jxq2ymSFdPdOrtktuQjyv44Co276MYL4R0WfX7V3N6W4BTR/e
         S2Cwtf2NM4sJFX9LOJbwYrI/Ve1jXwIDYzYtJtuzSYcw0+Puv3VsDTIVh0prnqm6AzZr
         FMimy9Jrz3H4ci/yk8Hvy8CfeOts7NIxz1tXgrpGUOw498hMGqqR2bF8b2cbJadfJCtT
         +pi83sUQcbYGdXA7dgpfGwKtXpuuLVtUNpvhWzCUDUMPc8wF/Bq2xM3U6ptHdhwp9iey
         UE8TcJrk10mAa1qUlYArPNFOYNvQ9Ojk89pTNupf0NMatsNTG+g0Ui7465WiureoU6Px
         m7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y7a6X46x8F7MlojQvSFkOa3T30hCbA6SCFF+IE72gBM=;
        b=NPxFv8xp9+8LNCXuyRBDVVjxu9JP3+LdylqUPJyeMAgrEi/ElJMG5h6M68chpyqHWt
         ME6NsUQ9LFMB9mWe45GoA3iS1OwU8u6zT2T6qLUvRfGR/059LIS71cGCYg8mNpO1MEYa
         tvaQ9M0P3gVGMjgYuYCazbn3qMmg1dejc/p+hJ6OSDYEoSowIwnnAscKsXcpV+SySpcV
         P6hcvxUeBIhl/FtcUcJNcoQcvnhQQR/BEgaELEuZEXCnogBUR0noDfxcBB/rzhYDzeaE
         MFlF0YMzyI7RJ1T5yBzk83sDanGp5g4zDJL6e4VuQ3dBrhK6353yf+Y+hmgtEL8gr0qH
         4iOw==
X-Gm-Message-State: AOUpUlE+YkqHVmGsFBtbeTAFzMvC8v7ClhMaxBV+mcx6KdbWDz4cM/y3
        v4URbhWWQ69HYNdGIkUc9BSeS3/olfdMyWA6PCtXZtbvqXUGRi3aCdhkfsyV+skezrZxJxrZT+Z
        j7a65ZLfhdvK7ikSCofqEFqbRkRSpHB1iQi3H9rrWvRDMxsf2jSOJdsFQmNExeuBE9CoIwdABC1
        3K
X-Google-Smtp-Source: AA+uWPzLRrjKlJ8dnq+YraI8uF2sbqrC4JgB3GIwPBh+KE/dBdxhTATStWxew1UcBot/bwxGYlUvVA0FF5mPJVauJGmM
X-Received: by 2002:a24:ad4f:: with SMTP id a15-v6mr10544itj.42.1533767655527;
 Wed, 08 Aug 2018 15:34:15 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:34:06 -0700
In-Reply-To: <cover.1533767314.git.jonathantanmy@google.com>
Message-Id: <3dab08e467c23f2c0785e34c3a8703d809b6479a.1533767314.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1533672584.git.jonathantanmy@google.com> <cover.1533767314.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v2 2/2] repack: repack promisor objects if -a or -A is set
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, repack does not touch promisor packfiles at all, potentially
causing the performance of repositories that have many such packfiles to
drop. Therefore, repack all promisor objects if invoked with -a or -A.

This is done by an additional invocation of pack-objects on all promisor
objects individually given, which takes care of deduplication and allows
the resulting packfiles to respect flags such as --max-pack-size.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-repack.txt |  5 +++
 builtin/repack.c             | 83 +++++++++++++++++++++++++++++++++--
 t/t0410-partial-clone.sh     | 85 +++++++++++++++++++++++++++++++-----
 3 files changed, 158 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index d90e7907f..d05625096 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -40,6 +40,11 @@ OPTIONS
 Note that users fetching over dumb protocols will have to fetch the
 whole new pack in order to get any contained object, no matter how many
 other objects in that pack they already have locally.
++
+Promisor packfiles are repacked separately: if there are packfiles that
+have an associated ".promisor" file, these packfiles will be repacked
+into another separate pack, and an empty ".promisor" file corresponding
+to the new separate pack will be written.
 
 -A::
 	Same as `-a`, unless `-d` is used.  Then any unreachable
diff --git a/builtin/repack.c b/builtin/repack.c
index f8cae7d66..5c97dec3d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -8,6 +8,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "packfile.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -83,7 +84,7 @@ static void remove_pack_on_signal(int signo)
 
 /*
  * Adds all packs hex strings to the fname list, which do not
- * have a corresponding .keep or .promisor file. These packs are not to
+ * have a corresponding .keep file. These packs are not to
  * be kept if we are going to pack everything into one file.
  */
 static void get_non_kept_pack_filenames(struct string_list *fname_list,
@@ -111,8 +112,7 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 
 		fname = xmemdupz(e->d_name, len);
 
-		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)) &&
-		    !file_exists(mkpath("%s/%s.promisor", packdir, fname)))
+		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
 			string_list_append_nodup(fname_list, fname);
 		else
 			free(fname);
@@ -122,7 +122,7 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
-	const char *exts[] = {".pack", ".idx", ".keep", ".bitmap"};
+	const char *exts[] = {".pack", ".idx", ".keep", ".bitmap", ".promisor"};
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 	size_t plen;
@@ -179,6 +179,76 @@ static void prepare_pack_objects(struct child_process *cmd,
 	cmd->out = -1;
 }
 
+/*
+ * Write oid to the given struct child_process's stdin, starting it first if
+ * necessary.
+ */
+static int write_oid(const struct object_id *oid, struct packed_git *pack,
+		     uint32_t pos, void *data)
+{
+	struct child_process *cmd = data;
+
+	if (cmd->in == -1) {
+		if (start_command(cmd))
+			die("Could not start pack-objects to repack promisor objects");
+	}
+
+	xwrite(cmd->in, oid_to_hex(oid), GIT_SHA1_HEXSZ);
+	xwrite(cmd->in, "\n", 1);
+	return 0;
+}
+
+static void repack_promisor_objects(const struct pack_objects_args *args,
+				    struct string_list *names)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	FILE *out;
+	struct strbuf line = STRBUF_INIT;
+
+	prepare_pack_objects(&cmd, args);
+	cmd.in = -1;
+
+	/*
+	 * NEEDSWORK: Giving pack-objects only the OIDs without any ordering
+	 * hints may result in suboptimal deltas in the resulting pack. See if
+	 * the OIDs can be sent with fake paths such that pack-objects can use a
+	 * {type -> existing pack order} ordering when computing deltas instead
+	 * of a {type -> size} ordering, which may produce better deltas.
+	 */
+	for_each_packed_object(write_oid, &cmd,
+			       FOR_EACH_OBJECT_PROMISOR_ONLY);
+
+	if (cmd.in == -1)
+		/* No packed objects; cmd was never started */
+		return;
+
+	close(cmd.in);
+
+	out = xfdopen(cmd.out, "r");
+	while (strbuf_getline_lf(&line, out) != EOF) {
+		char *promisor_name;
+		int fd;
+		if (line.len != 40)
+			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
+		string_list_append(names, line.buf);
+
+		/*
+		 * pack-objects creates the .pack and .idx files, but not the
+		 * .promisor file. Create the .promisor file, which is empty.
+		 */
+		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
+					  line.buf);
+		fd = open(promisor_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+		if (fd < 0)
+			die_errno("unable to create '%s'", promisor_name);
+		close(fd);
+		free(promisor_name);
+	}
+	fclose(out);
+	if (finish_command(&cmd))
+		die("Could not finish pack-objects to repack promisor objects");
+}
+
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
 
@@ -191,6 +261,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		{".pack"},
 		{".idx"},
 		{".bitmap", 1},
+		{".promisor", 1},
 	};
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
@@ -293,6 +364,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs, &keep_pack_list);
 
+		repack_promisor_objects(&po_args, &names);
+
 		if (existing_packs.nr && delete_redundant) {
 			if (unpack_unreachable) {
 				argv_array_pushf(&cmd.args,
@@ -440,6 +513,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	/* End of pack replacement. */
 
+	reprepare_packed_git(the_repository);
+
 	if (delete_redundant) {
 		int opts = 0;
 		string_list_sort(&names);
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 4984ca583..128130066 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -271,28 +271,91 @@ test_expect_success 'rev-list accepts missing and promised objects on command li
 	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
 '
 
-test_expect_success 'gc does not repack promisor objects' '
+test_expect_success 'gc repacks promisor objects separately from non-promisor objects' '
 	rm -rf repo &&
 	test_create_repo repo &&
-	test_commit -C repo my_commit &&
+	test_commit -C repo one &&
+	test_commit -C repo two &&
 
-	TREE_HASH=$(git -C repo rev-parse HEAD^{tree}) &&
-	HASH=$(printf "$TREE_HASH\n" | pack_as_from_promisor) &&
+	TREE_ONE=$(git -C repo rev-parse one^{tree}) &&
+	printf "$TREE_ONE\n" | pack_as_from_promisor &&
+	TREE_TWO=$(git -C repo rev-parse two^{tree}) &&
+	printf "$TREE_TWO\n" | pack_as_from_promisor &&
 
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
 	git -C repo gc &&
 
-	# Ensure that the promisor packfile still exists, and remove it
-	test -e repo/.git/objects/pack/pack-$HASH.pack &&
-	rm repo/.git/objects/pack/pack-$HASH.* &&
-
-	# Ensure that the single other pack contains the commit, but not the tree
+	# Ensure that exactly one promisor packfile exists, and that it
+	# contains the trees but not the commits
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	PROMISOR_PACKFILE=$(sed "s/.promisor/.pack/" <promisorlist) &&
+	git verify-pack $PROMISOR_PACKFILE -v >out &&
+	grep "$TREE_ONE" out &&
+	grep "$TREE_TWO" out &&
+	! grep "$(git -C repo rev-parse one)" out &&
+	! grep "$(git -C repo rev-parse two)" out &&
+
+	# Remove the promisor packfile and associated files
+	rm $(sed "s/.promisor//" <promisorlist).* &&
+
+	# Ensure that the single other pack contains the commits, but not the
+	# trees
 	ls repo/.git/objects/pack/pack-*.pack >packlist &&
 	test_line_count = 1 packlist &&
 	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
-	grep "$(git -C repo rev-parse HEAD)" out &&
-	! grep "$TREE_HASH" out
+	grep "$(git -C repo rev-parse one)" out &&
+	grep "$(git -C repo rev-parse two)" out &&
+	! grep "$TREE_ONE" out &&
+	! grep "$TREE_TWO" out
+'
+
+test_expect_success 'gc does not repack promisor objects if there are none' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo one &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo gc &&
+
+	# Ensure that only one pack exists
+	ls repo/.git/objects/pack/pack-*.pack >packlist &&
+	test_line_count = 1 packlist
+'
+
+repack_and_check () {
+	rm -rf repo2 &&
+	cp -r repo repo2 &&
+	git -C repo2 repack $1 -d &&
+	git -C repo2 fsck &&
+
+	git -C repo2 cat-file -e $2 &&
+	git -C repo2 cat-file -e $3
+}
+
+test_expect_success 'repack -d does not irreversibly delete promisor objects' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+
+	git -C repo commit --allow-empty -m one &&
+	git -C repo commit --allow-empty -m two &&
+	git -C repo commit --allow-empty -m three &&
+	git -C repo commit --allow-empty -m four &&
+	ONE=$(git -C repo rev-parse HEAD^^^) &&
+	TWO=$(git -C repo rev-parse HEAD^^) &&
+	THREE=$(git -C repo rev-parse HEAD^) &&
+
+	printf "$TWO\n" | pack_as_from_promisor &&
+	printf "$THREE\n" | pack_as_from_promisor &&
+	delete_object repo "$ONE" &&
+
+	repack_and_check -a "$TWO" "$THREE" &&
+	repack_and_check -A "$TWO" "$THREE" &&
+	repack_and_check -l "$TWO" "$THREE"
 '
 
 test_expect_success 'gc stops traversal when a missing but promised object is reached' '
-- 
2.18.0.597.ga71716f1ad-goog

