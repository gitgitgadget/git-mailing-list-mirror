Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD3520D0A
	for <e@80x24.org>; Fri,  2 Jun 2017 00:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdFBAPQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 20:15:16 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34871 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFBAPN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 20:15:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id n23so40807206pfb.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 17:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=w3o0Ss+F74vNN4DbvB9+I6UlH3NrLU6vhCPUp3HmiPw=;
        b=ixe1eMQP1M2vObFwRvqiD4ilpx+Db6Ylv4ECuCcP0SrCnINyoYf5e5tYA6M73zkKf2
         sWGtmiiX9MSUEHdhvUJBSNT50F5mY45tudusGOW3Cyv4rdmuo9WOkHpwMHPP4E9zW1nd
         E70NgcEWVoLJ5gIa/uyecf48jSAaIVet+GOcPYapuYZ1dmY18yQBFS35pdCpbXN2UkJN
         Tnm0gIPdN+YFemm7dA7s2XzS9iz1nCwiCmV+ZOxVTNoA/A/qJo68Zj2HT1LKzyb/tzz5
         T3+3ArB8VcOtHOYLilU8vZfvC+Bb7WI4uwIJEePxlGVFiLExJV43LaIS+yZvME0k+UAI
         cqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=w3o0Ss+F74vNN4DbvB9+I6UlH3NrLU6vhCPUp3HmiPw=;
        b=sJq6nK7m1KEgB27t6Wu1oPoT0nXHvV5rUJHTwAMHZabQ5aJYv0eBD6bouoZf+HYojC
         U/RSNWwDxgXuZVCh9vmkiPT3T69v7+ol+3hDDrseoZUlAN2AtuMAh3H8Z++V/h40rHFW
         9oT01duknES75vqvYoK0VZUrKpzetfDDO51z6ycgFjHbr9g3QvJbqwQmGOjVKN4U4tNZ
         9OwKIA9gTLmRNHsVJxtKKVUtb0T6EY7OZidBpvIg/iMnh9F3YVKHFB5yvqUu2/XEOABy
         aa9OTAq0b1xNiakaAfMPsjlSntkQqE78nuELzyzNiJq6tFEeNf2qsmULJmB/f5gijfA/
         QH1g==
X-Gm-Message-State: AODbwcDY0JPIMjTZ0/cQcme+ayn9qSMKEK80BUWNU9912oAazJ+pPbeb
        UFl6J0AUPRhd/58Vkc9c1Q==
X-Received: by 10.98.7.149 with SMTP id 21mr3712319pfh.54.1496362512348;
        Thu, 01 Jun 2017 17:15:12 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id s23sm38046377pfg.81.2017.06.01.17.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 17:15:10 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@jeffhostetler.com
Subject: [WIP 2/2] pack-objects: support --blob-size-limit
Date:   Thu,  1 Jun 2017 17:14:55 -0700
Message-Id: <07c7139d1cbc2b3acf73c4df14d3cf1dde955720.1496361873.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd-goog
In-Reply-To: <cover.1496361873.git.jonathantanmy@google.com>
References: <cover.1496361873.git.jonathantanmy@google.com>
In-Reply-To: <cover.1496361873.git.jonathantanmy@google.com>
References: <cover.1496361873.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of an effort to improve Git support for very large repositories
in which clients typically have only a subset of all version-controlled
blobs, teach pack-objects to support --blob-size-limit, packing only
blobs below that size limit unless the blob corresponds to a file whose
name starts with ".git". upload-pack will eventually be taught to use
this new parameter if needed to exclude certain blobs during a fetch or
clone, potentially drastically reducing network consumption when serving
these very large repositories.

Since any excluded blob should not act as a delta base, I did this by
avoiding such oversized blobs from ever going into the "to_pack" data
structure, which contains both preferred bases (which do not go into the
final packfile but can act as delta bases) and the objects to be packed
(which go into the final packfile and also can act as delta bases). To
that end, add_object_entry() has been modified to exclude the
appropriate non-preferred-base objects. (Preferred bases, regardless of
size, still enter "to_pack" - they are something that the client
indicates that it has, not something that the server needs to serve, so
no exclusion occurs.) Any such exclusions are recorded and sent after
the packfile.

I have taken the opportunity to rename the "exclude" parameter to
"preferred_base" to avoid confusion between the concept of "excluding an
object from to_pack" and "including an object in to_pack which will be
excluded in the final pack generation".

The other method in which objects are added to "to_pack",
add_object_entry_from_bitmap(), has not been modified - thus packing in
the presence of bitmaps still packs all blobs regardless of size. See
the documentation update in this commit for the rationale.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-pack-objects.txt |  19 +++++-
 builtin/pack-objects.c             | 115 +++++++++++++++++++++++++++++++++++--
 t/t5300-pack-object.sh             |  71 +++++++++++++++++++++++
 3 files changed, 199 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 8973510a4..c4257cacc 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
-	[--revs [--unpacked | --all]] [--stdout | base-name]
+	[--revs [--unpacked | --all]]
+	[--stdout [--blob-size-limit=<n>] | base-name]
 	[--shallow] [--keep-true-parents] < object-list
 
 
@@ -231,6 +232,22 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	With this option, parents that are hidden by grafts are packed
 	nevertheless.
 
+--blob-size-limit=<n>::
+	This option can only be used with --stdout. If specified, a blob
+	of at least this size will not be packed unless a to-be-packed
+	tree has that blob with a filename beginning with ".git".
+	The size can be suffixed with "k", "m", or "g", and may be "0".
++
+If specified, after printing the packfile, pack-objects will print the
+count of excluded blobs (8 bytes) . Subsequently, for each excluded blob
+in hash order, pack-objects will print its hash (20 bytes) and its size
+(8 bytes). All numbers are in network byte order.
++
+If pack-objects cannot efficiently determine, for an arbitrary blob,
+that no to-be-packed tree has that blob with a filename beginning with
+".git" (for example, if bitmaps are used to calculate the objects to be
+packed), it will pack all blobs regardless of size.
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1062d8fe2..aaf7e92b0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -77,6 +77,8 @@ static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
 
+static long blob_size_limit = -1;
+
 /*
  * stats
  */
@@ -776,6 +778,50 @@ static const char no_split_warning[] = N_(
 "disabling bitmap writing, packs are split due to pack.packSizeLimit"
 );
 
+struct oversized_blob {
+	struct hashmap_entry entry;
+	struct object_id oid;
+	unsigned long size;
+};
+struct hashmap oversized_blobs;
+
+static int oversized_blob_cmp_fn(const void *b1, const void *b2,
+				 const void *keydata)
+{
+	const struct object_id *oid2 = keydata ? keydata : 
+		&((const struct oversized_blob *) b2)->oid;
+	return oidcmp(&((const struct oversized_blob *) b1)->oid, oid2);
+}
+
+static int oversized_blob_cmp(const void *b1, const void *b2)
+{
+	return oidcmp(&(*(const struct oversized_blob **) b1)->oid,
+		      &(*(const struct oversized_blob **) b2)->oid);
+}
+
+static void write_oversized_info(void)
+{
+	struct oversized_blob **obs = xmalloc(oversized_blobs.size *
+					      sizeof(*obs));
+	struct hashmap_iter iter;
+	struct oversized_blob *ob;
+	int i = 0;
+	uint64_t size_network;
+
+	for (ob = hashmap_iter_first(&oversized_blobs, &iter);
+	     ob;
+	     ob = hashmap_iter_next(&iter))
+		obs[i++] = ob;
+	QSORT(obs, oversized_blobs.size, oversized_blob_cmp);
+	size_network = htonll(oversized_blobs.size);
+	write_in_full(1, &size_network, sizeof(size_network));
+	for (i = 0; i < oversized_blobs.size; i++) {
+		write_in_full(1, &obs[i]->oid, sizeof(obs[i]->oid));
+		size_network = htonll(obs[i]->size);
+		write_in_full(1, &size_network, sizeof(size_network));
+	}
+}
+
 static void write_pack_file(void)
 {
 	uint32_t i = 0, j;
@@ -822,7 +868,11 @@ static void write_pack_file(void)
 		 * If so, rewrite it like in fast-import
 		 */
 		if (pack_to_stdout) {
-			sha1close(f, sha1, CSUM_CLOSE);
+			sha1close(f, sha1, 0);
+			write_in_full(1, sha1, sizeof(sha1));
+			if (blob_size_limit >= 0) {
+				write_oversized_info();
+			}
 		} else if (nr_written == nr_remaining) {
 			sha1close(f, sha1, CSUM_FSYNC);
 		} else {
@@ -1069,17 +1119,58 @@ static const char no_closure_warning[] = N_(
 "disabling bitmap writing, as some objects are not being packed"
 );
 
+/*
+ * Returns 1 and records this blob in oversized_blobs if the given blob does
+ * not meet any defined blob size limits.  Blobs that appear as a tree entry
+ * whose basename begins with ".git" are never considered oversized.
+ *
+ * If the tree entry corresponding to the given blob is unknown, pass NULL as
+ * name. In this case, this function will always return 0 to avoid false
+ * positives.
+ */
+static int oversized(const unsigned char *sha1, const char *name) {
+	const char *last_slash, *basename;
+	unsigned long size;
+	unsigned int hash;
+
+	if (blob_size_limit < 0 || !name)
+		return 0;
+
+	last_slash = strrchr(name, '/');
+	basename = last_slash ? last_slash + 1 : name;
+	if (starts_with(basename, ".git"))
+		return 0;
+
+	sha1_object_info(sha1, &size);
+	if (size < blob_size_limit)
+		return 0;
+	
+	if (!oversized_blobs.tablesize)
+		hashmap_init(&oversized_blobs, oversized_blob_cmp_fn, 0);
+	hash = sha1hash(sha1);
+	if (!hashmap_get_from_hash(&oversized_blobs, hash, sha1)) {
+		struct oversized_blob *ob = xmalloc(sizeof(*ob));
+		hashmap_entry_init(ob, hash);
+		hashcpy(ob->oid.hash, sha1);
+		ob->size = size;
+		hashmap_add(&oversized_blobs, ob);
+	}
+	return 1;
+}
+
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
-			    const char *name, int exclude)
+			    const char *name, int preferred_base)
 {
 	struct packed_git *found_pack = NULL;
 	off_t found_offset = 0;
 	uint32_t index_pos;
+	struct hashmap_entry entry;
 
-	if (have_duplicate_entry(sha1, exclude, &index_pos))
+	if (have_duplicate_entry(sha1, preferred_base, &index_pos))
 		return 0;
 
-	if (ignore_object(sha1, exclude, &found_pack, &found_offset)) {
+	if (ignore_object(sha1, preferred_base, &found_pack, &found_offset) ||
+	    (!preferred_base && type == OBJ_BLOB && oversized(sha1, name))) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
 			warning(_(no_closure_warning));
@@ -1088,8 +1179,17 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		return 0;
 	}
 
+	/*
+	 * Ensure that we do not report this blob as oversized if we are going
+	 * to use it, be it in the returned pack or as a preferred base
+	 */
+	if (oversized_blobs.tablesize) {
+		hashmap_entry_init(&entry, sha1hash(sha1));
+		free(hashmap_remove(&oversized_blobs, &entry, sha1));
+	}
+
 	create_object_entry(sha1, type, pack_name_hash(name),
-			    exclude, name && no_try_delta(name),
+			    preferred_base, name && no_try_delta(name),
 			    index_pos, found_pack, found_offset);
 
 	display_progress(progress_state, nr_result);
@@ -2947,6 +3047,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("use a bitmap index if available to speed up counting objects")),
 		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
 			 N_("write a bitmap index together with the pack index")),
+		OPT_MAGNITUDE(0, "blob-size-limit", &blob_size_limit,
+			      N_("exclude and report blobs not smaller than this limit")),
 		OPT_END(),
 	};
 
@@ -3022,6 +3124,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		die("--keep-unreachable and --unpack-unreachable are incompatible.");
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
+	
+	if (blob_size_limit >= 0 && !pack_to_stdout)
+		die("if --blob-size-limit is specified, --stdout must also be specified");
 
 	/*
 	 * "soft" reasons not to use bitmaps - for on-disk repack by default we want
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 43a672c34..d12280cbf 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -421,6 +421,77 @@ test_expect_success 'index-pack <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
+unpack() {
+	perl -e '$/ = undef; $input = <>; print unpack("H2" x length($input), $input)'
+}
+
+rcut() {
+	perl -e '$/ = undef; $_ = <>; s/.{'$1'}$//s; print $_'
+}
+
+test_expect_success '--blob-size-limit works with multiple excluded' '
+	rm -rf server &&
+	git init server &&
+	printf a > server/a &&
+	printf b > server/b &&
+	printf c-very-long-file > server/c &&
+	printf d-very-long-file > server/d &&
+	git -C server add a b c d &&
+	git -C server commit -m x &&
+
+	git -C server rev-parse HEAD >objects &&
+	git -C server pack-objects --revs --stdout --blob-size-limit=10 <objects >out &&
+	unpack <out >actual &&
+
+	# Check that the excluded hashes are included, sorted, at the end
+	if [ $(git hash-object server/c) \< $(git hash-object server/d) ]
+	then
+		printf "0000000000000002%s0000000000000010%s0000000000000010$" \
+			$(git hash-object server/c) \
+			$(git hash-object server/d) >expect
+	else
+		printf "0000000000000002%s0000000000000010%s0000000000000010$" \
+			$(git hash-object server/d) \
+			$(git hash-object server/c) >expect
+	fi &&
+	grep $(cat expect) actual &&
+
+	# Ensure that only the small blobs are in the packfile
+	rcut 64 <out >my.pack &&
+	git index-pack my.pack &&
+	git verify-pack -v my.idx >objectlist &&
+	grep $(git hash-object server/a) objectlist &&
+	grep $(git hash-object server/b) objectlist &&
+	! grep $(git hash-object server/c) objectlist &&
+	! grep $(git hash-object server/d) objectlist
+'
+
+test_expect_success '--blob-size-limit never excludes special files' '
+	rm -rf server &&
+	git init server &&
+	printf a-very-long-file > server/a &&
+	printf a-very-long-file > server/.git-a &&
+	printf b-very-long-file > server/b &&
+	git -C server add a .git-a b &&
+	git -C server commit -m x &&
+
+	git -C server rev-parse HEAD >objects &&
+	git -C server pack-objects --revs --stdout --blob-size-limit=10 <objects >out &&
+	unpack <out >actual &&
+
+	# Check that the excluded hash is included at the end
+	printf "0000000000000001%s0000000000000010$" \
+		$(git hash-object server/b) >expect &&
+	grep $(cat expect) actual &&
+
+	# Ensure that the .git-a blob is in the packfile, despite also
+	# appearing as a non-.git file
+	rcut 36 <out >my.pack &&
+	git index-pack my.pack &&
+	git verify-pack -v my.idx >objectlist &&
+	grep $(git hash-object server/a) objectlist
+'
+
 #
 # WARNING!
 #
-- 
2.13.0.506.g27d5fe0cd-goog

