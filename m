Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A42E888A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948076; cv=none; b=eGMc7/vIZvwNjWZLpoQg3ETVejJAlk5ws99VRmXExhLg83BEz2//GnyhA7o2J5GNKra0Ngn4mEyluY60+N+HY2Nz2xNKijtpdluPYJ/67Zg3KRSnjspg4qBrWsnqiB4ZSvxBCyN2Jb2iRYbwoWf4Eyyr5bpELEOfNaPgLzWN/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948076; c=relaxed/simple;
	bh=fblye2b+z1jwkfIc2p9Ys7J3NItAph4uDEgrIuqT+c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7e8MOExszSTklqMMuY6DgtqLV8mWD9NFvf61W1mYMmHy938sZMEPyX1dPxOAMOTcoXDn67fSQg3tmSDkFAaoyQwCQXuM4uh1A7ZjAjQBKGLQ6+fPFBzrmsi07i8dq+a1xlPgcFKNhQcaj0F3c5lk8nFHdEsc2HdbpwHVcMoKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxZhCpEz; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxZhCpEz"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e17e5de00so491068066b.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 06:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790948073; x=1791552873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2WnZ0QC2AyRQs+3Q3SbhUef5BFZ+s42iaYpxyEKoXnU=;
        b=oxZhCpEzmHKu9gSnoTSyXVw6YdcHmEb3aEH1bRkFvCX+qYswDcydGC1NVKNW2PhFkT
         NkuP1zAGGoyTsIFpCAYqoHZRTxy3DkQzWcQn7avyZ1i9os8SKxYFbZokqg56Dy057YMx
         NnF3j5we/IF8GFRRoXNSHHQjWD+9T5FFLarczfteBniT7Ix+JWYPcDb0DdXyahqKSjbn
         oLwykWyfHchukuAB6K5/AOVrh8hKUtrCcPC67Vd08ckGHKtDj2ddb/GQiIZt1KB4Ap9O
         1mIAupPc2kOsz6dNAb+uwWSESzYuf/zi7AhCTHsjBZO6dumRs4cyPyKGe6SPk2H/B6sS
         IXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790948073; x=1791552873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2WnZ0QC2AyRQs+3Q3SbhUef5BFZ+s42iaYpxyEKoXnU=;
        b=Mh/O6pY+0IyEiJn860IuIwwnWTxtdSXNaQTcmNzX2+iJbXn9HxmW68TCPROl8I61Z5
         9FkDNRPXsv5Og/OnjfW2QWDPrd0vEy89bQGLgn9/xGfM7MoLVQh7DusFzGcY2H97R92a
         EtbfdNpSvIoh2dvJrgqtUmGqYSih9WNAf7KuXVV3stqxfKL5Hd82CLYF1lasRV4hbCu2
         sF9aV4LgZeWWK8owH+HleU2eUw4LJzTI2IiGzgLeh6NRUJOPSwS26XSs0F5UoGYp5sEY
         0AHYy4oBTZaeGLyW5gbfp4R1lTJKxI3i799YAQaKU8T8Dal365ARDg3qekycONEoNvw2
         NVsg==
X-Gm-Message-State: AFuF++lTO9alH1bQxl8MG7DoT8bmizs0qP+xTwM2WkwxPGm8SBkzmY1h
	uYzMjXdRxSpJiYcWdiuGXTwxA+UaRVtJsQBIJpjJFFTZKlzc2m+Co69cJEGnhYw0UmA=
X-Gm-Gg: AYBFou1OYzkN0I/+lZkw0JFbnnaVP0QNJyvfXDGv0lf28jNtpLCLFTFoqgVNs7L2djc
	yCfpDKPsRoD3kWzqtxYAd7rzUWrEgkHvqgoY3bgOaDl+T3izTQLzPDaeOu1R+YxUkXtL4dQyuLr
	iCD4A8LOWJO5l6CZBsAZeUtP+UhyHJClhvOLR//P4cSRB7FIVpzVf9+C4hIDzFXt6PIcKUEbxZR
	jwjDFWuGYfok1gJ1gnHyZnyBGgaeROHUGm2FCDPTSJZaJf9Wi1fYssRpNYfzIMAw2Ujt9fzFiqd
	kxGQcmF0GvEBk60YD/OlLjeATGJjOy65B1iBYRGp41RU5wjQqKmAAgt3YVMdQQ9FkpCPJ0bBTB7
	1JbP2Li2s/8Hr1okUCbAq2PFG8PXN2fUxKBTnlnQXDJdDcAdVqGcgeTdSJBfBYYjUy3T5Rz3PI9
	NwU59H+Lizht9UjoHzTo10nnBfRCcmPOVrXirrBPXURWYwalDZEImPh18g8OPkIghZmF3bbIWaX
	CWbbmZNBkpcR4OdRzqAw5gK6kyqMEGOxSmB7KwyAro/MjdzJzXgiFZlH6MPMw4AxILBU6MQBJOe
	G1sWNcKKtSZkDsAKsAd3QX6etIsF4yE=
X-Received: by 2002:a17:906:ef0b:b0:c2a:fcb7:62f2 with SMTP id a640c23a62f3a-c2e4ad13e6cmr227840266b.19.1790948072656;
        Fri, 02 Oct 2026 06:34:32 -0700 (PDT)
Received: from P7820 (92-184-96-218.mobile.fr.orangecustomers.net. [92.184.96.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cd25986sm91689866b.27.2026.10.02.06.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:34:32 -0700 (PDT)
From: Guillaume Chauvel <guillaume.chauvel@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Guillaume Chauvel <guillaume.chauvel@gmail.com>
Subject: Re: [PATCH 2/2] packfile: fix corruption due to stale delta base cache entries
Date: Fri,  2 Oct 2026 15:34:05 +0200
Message-ID: <20261002133405.1284-1-guillaume.chauvel@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.1
In-Reply-To: <20261002-pks-packfile-stale-delta-base-cache-v1-2-7592a3e31ae0@pks.im>
References: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im> <20261002-pks-packfile-stale-delta-base-cache-v1-2-7592a3e31ae0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 02, 2026 at 09:34:07AM +0200, Patrick Steinhardt wrote:
> Note that the added test reliably reproduces the above bug on my machine
> that uses NixOS at c59305bab206 (cosmic-applets: add missing runtime
> dependency (#566040), 2026-10-01) with glibc 2.44-25. But as we rely on
> specific allocation behaviour of glibc it is very likely that the test
> will not work on other platforms.

What about forcing the address reuse in the test for deterministic
behavior ?
A test helper can close a pack and move a second packed_git, whose
delta base sits at the same offset, into its memory.

This was written with the help of AI tools.
To apply on top of [PATCH 1/2].

-- >8 --
 Makefile                         |  1 +
 packfile.c                       | 13 ++++++
 t/helper/meson.build             |  1 +
 t/helper/test-delta-base-cache.c | 92 ++++++++++++++++++++++++++++++++++++++++
 t/helper/test-pack-deltas.c      | 22 +++++++++-
 t/helper/test-tool.c             |  1 +
 t/helper/test-tool.h             |  1 +
 t/meson.build                    |  1 +
 t/t5336-pack-delta-base-cache.sh | 46 ++++++++++++++++++++
 9 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-delta-base-cache.c
 create mode 100755 t/t5336-pack-delta-base-cache.sh

diff --git a/Makefile b/Makefile
index c649c93c51..771ca00e33 100644
--- a/Makefile
+++ b/Makefile
@@ -818,6 +818,7 @@ TEST_BUILTINS_OBJS += test-crontab.o
 TEST_BUILTINS_OBJS += test-csprng.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delete-gpgsig.o
+TEST_BUILTINS_OBJS += test-delta-base-cache.o
 TEST_BUILTINS_OBJS += test-delta.o
 TEST_BUILTINS_OBJS += test-dir-iterator.o
 TEST_BUILTINS_OBJS += test-drop-caches.o
diff --git a/packfile.c b/packfile.c
index af1b837974..365c54c7dc 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1253,6 +1253,18 @@ void clear_delta_base_cache(void)
 	}
 }
 
+static void delta_base_cache_evict_entry(struct packed_git *p)
+{
+	struct list_head *lru, *tmp;
+
+	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
+		struct delta_base_cache_entry *entry =
+			list_entry(lru, struct delta_base_cache_entry, lru);
+		if (entry->key.p == p)
+			release_delta_base_cache(entry);
+	}
+}
+
 void close_pack(struct packed_git *p)
 {
 	close_pack_windows(p);
@@ -1261,6 +1273,7 @@ void close_pack(struct packed_git *p)
 	close_pack_revindex(p);
 	close_pack_mtimes(p);
 	oidset_clear(&p->bad_objects);
+	delta_base_cache_evict_entry(p);
 }
 
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 3235f10ab8..225c46a88c 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -11,6 +11,7 @@ test_tool_sources = [
   'test-csprng.c',
   'test-date.c',
   'test-delete-gpgsig.c',
+  'test-delta-base-cache.c',
   'test-delta.c',
   'test-dir-iterator.c',
   'test-drop-caches.c',
diff --git a/t/helper/test-delta-base-cache.c b/t/helper/test-delta-base-cache.c
new file mode 100644
index 0000000000..54a0d43f2e
--- /dev/null
+++ b/t/helper/test-delta-base-cache.c
@@ -0,0 +1,92 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-tool.h"
+#include "hex.h"
+#include "object-file.h"
+#include "packfile.h"
+#include "setup.h"
+
+static off_t delta_base_offset(struct packed_git *pack,
+			       const struct object_id *oid)
+{
+	struct pack_window *window = NULL;
+	off_t offset, pos, base;
+	size_t size;
+	int type;
+
+	offset = find_pack_entry_one(oid, pack);
+	if (!offset)
+		die("object is missing from pack: %s", oid_to_hex(oid));
+	pos = offset;
+	type = unpack_object_header(pack, &window, &pos, &size);
+	if (type != OBJ_OFS_DELTA && type != OBJ_REF_DELTA)
+		die("object is not stored as a delta: %s", oid_to_hex(oid));
+	base = get_delta_base(pack, &window, &pos, type, offset);
+	unuse_pack(&window);
+	if (!base)
+		die("cannot locate delta base for %s", oid_to_hex(oid));
+	return base;
+}
+
+int cmd__delta_base_cache(int argc, const char **argv)
+{
+	struct packed_git *first, *second;
+	struct object_id first_oid, second_oid, actual_oid;
+	enum object_type type;
+	size_t size;
+	void *data;
+
+	if (argc != 5)
+		usage("test-tool delta-base-cache <first.idx> <first-delta> "
+		      "<second.idx> <second-delta>");
+
+	setup_git_directory(the_repository);
+
+	if (get_oid_hex(argv[2], &first_oid) || get_oid_hex(argv[4], &second_oid))
+		die("invalid object ID");
+	if (strlen(argv[1]) != strlen(argv[3]))
+		die("pack index paths must have the same length");
+
+	first = add_packed_git(the_repository, argv[1], strlen(argv[1]), 1);
+	second = add_packed_git(the_repository, argv[3], strlen(argv[3]), 1);
+	if (!first || !second || open_pack_index(first) || open_pack_index(second))
+		die("cannot open pack indexes");
+
+	if (delta_base_offset(first, &first_oid) !=
+	    delta_base_offset(second, &second_oid))
+		die("delta bases have different pack offsets");
+
+	data = unpack_entry(the_repository, first,
+			    find_pack_entry_one(&first_oid, first), NULL, NULL);
+	if (!data)
+		die("cannot unpack first object");
+	free(data);
+
+	close_pack(first);
+
+	/*
+	 * Simulate the allocator handing the address of the closed pack to
+	 * a new one. The resources of "second" now belong to "first".
+	 */
+	memcpy(first, second, sizeof(*first) + strlen(second->pack_name) + 1);
+	free(second);
+
+	data = unpack_entry(the_repository, first,
+			    find_pack_entry_one(&second_oid, first), &type, &size);
+	if (!data)
+		die("cannot unpack second object");
+	hash_object_file(the_repository->hash_algo, data, size, type, &actual_oid);
+	free(data);
+	close_pack(first);
+	free(first);
+
+	/*
+	 * The test checked that applying the second object's delta to the
+	 * first pack's base does not give the second object, so a stale
+	 * cache entry shows up as an object ID mismatch.
+	 */
+	if (!oideq(&actual_oid, &second_oid))
+		return error("second object differs after pack reuse");
+
+	return 0;
+}
diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index 959705feca..6cd5a7a7d8 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -43,6 +43,26 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	return stream.total_out;
 }
 
+static void write_full(struct hashfile *f, struct object_id *oid)
+{
+	unsigned char header[MAX_PACK_OBJECT_HEADER];
+	unsigned long compressed_size, hdrlen;
+	size_t size;
+	enum object_type type;
+	void *buf = odb_read_object(the_repository->objects,
+				    oid, &type, &size);
+
+	if (!buf)
+		die("unable to read %s", oid_to_hex(oid));
+
+	compressed_size = do_compress(&buf, cast_size_t_to_ulong(size));
+	hdrlen = encode_in_pack_object_header(header, sizeof(header),
+					      type, size);
+	hashwrite(f, header, hdrlen);
+	hashwrite(f, buf, compressed_size);
+	free(buf);
+}
+
 static void write_ref_delta(struct hashfile *f,
 			    struct object_id *oid,
 			    struct object_id *base)
@@ -136,7 +156,7 @@ int cmd__pack_deltas(int argc, const char **argv)
 		else if (!strcmp(type_str, "OFS_DELTA"))
 			die("OFS_DELTA not implemented");
 		else if (!strcmp(type_str, "FULL"))
-			die("FULL not implemented");
+			write_full(f, &content_oid);
 		else
 			die("unknown pack type: %s", type_str);
 	}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b71a22b43b..83b2e99344 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -22,6 +22,7 @@ static struct test_cmd cmds[] = {
 	{ "date", cmd__date },
 	{ "delete-gpgsig", cmd__delete_gpgsig },
 	{ "delta", cmd__delta },
+	{ "delta-base-cache", cmd__delta_base_cache },
 	{ "dir-iterator", cmd__dir_iterator },
 	{ "drop-caches", cmd__drop_caches },
 	{ "dump-cache-tree", cmd__dump_cache_tree },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f2885b33d5..8c95a1dada 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -14,6 +14,7 @@ int cmd__crontab(int argc, const char **argv);
 int cmd__csprng(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
+int cmd__delta_base_cache(int argc, const char **argv);
 int cmd__delete_gpgsig(int argc, const char **argv);
 int cmd__dir_iterator(int argc, const char **argv);
 int cmd__drop_caches(int argc, const char **argv);
diff --git a/t/meson.build b/t/meson.build
index 3ca7b27104..7d01040a07 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -639,6 +639,7 @@ integration_tests = [
   't5333-pseudo-merge-bitmaps.sh',
   't5334-incremental-multi-pack-index.sh',
   't5335-compact-multi-pack-index.sh',
+  't5336-pack-delta-base-cache.sh',
   't5351-unpack-large-objects.sh',
   't5400-send-pack.sh',
   't5401-update-hooks.sh',
diff --git a/t/t5336-pack-delta-base-cache.sh b/t/t5336-pack-delta-base-cache.sh
new file mode 100755
index 0000000000..2abc12559a
--- /dev/null
+++ b/t/t5336-pack-delta-base-cache.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='delta base cache lifetime across pack closure'
+
+. ./test-lib.sh
+
+# The delta base cache is keyed by (packed_git pointer, base offset).
+# Reading B from A-B.pack caches A.
+# The helper then closes that pack and, since B has the same offset
+# as A, reuses its packed_git structure for B-C.pack to reproduce
+# the same cache key. If closing the pack leaves A in the cache,
+# reading C would use A instead of B as its delta base, which the
+# helper detects by checking the resulting object ID.
+test_expect_success 'delta base cache entries do not outlive their pack' '
+	test-tool genrandom cache-data 1024 >common &&
+	{ printf "a0" && cat common; } >a &&
+	{ printf "b1" && cat common; } >b &&
+	{ printf "c1" && cat common; } >c &&
+	A=$(git hash-object -w a) &&
+	B=$(git hash-object -w b) &&
+	C=$(git hash-object -w c) &&
+
+	# Applying the B-to-C delta to A must not give C. Otherwise the
+	# helper could not detect a stale cache entry from the object ID.
+	test-tool delta -d b c b-c.delta &&
+	test-tool delta -p a b-c.delta stale &&
+	! cmp -s c stale &&
+
+	test-tool pack-deltas --num-objects=2 >A-B.pack <<-EOF &&
+	FULL $A
+	REF_DELTA $B $A
+	EOF
+	test-tool pack-deltas --num-objects=2 >B-C.pack <<-EOF &&
+	FULL $B
+	REF_DELTA $C $B
+	EOF
+
+	git index-pack -o A-B.idx A-B.pack &&
+	git index-pack -o B-C.idx B-C.pack &&
+
+	test-tool delta-base-cache \
+		A-B.idx $B \
+		B-C.idx $C
+'
+
+test_done
