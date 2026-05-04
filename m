Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558833E4C7A
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914519; cv=none; b=l+7MUHBdOQh8Pk/Qc5YYrUgxS+ijtQZj8KFiogqUudqymf1m+wba9kTpQLP5zDBlwyYdQtf+KogYguIX0toIIl+fDXKObqep6oW0YHtIg+0pJkueOHRKnYm8d7pJde0so1Yy32gvp3ICNwBrKmoGx/kss875t/mF57ZIof/xg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914519; c=relaxed/simple;
	bh=pewfZXQySmLP9PgqkybgdC0FHEe4AWZEuRdR7E7OI3Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BLoN+kZfG4LioC/MsqoJgO3QTD415CfzhE64EkHNgYwpQKADe9C1kQqrPDKbu/T3i0whsnaoOPqgQ+tQG6Ao1Hyz07+6DziumnMntJbe8yCYeiu4kxxEnGm0uL4A/gLmphTdzW0eZenL8CDhgv/I5UZbj7jpX5caR8x6VFg5VOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3+7UV8+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3+7UV8+"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8dbbc6c16b2so557500885a.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914516; x=1778519316; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZOWmtOiCy+qQAVoehJEJnvyJBE7fdTTfnBA2g8JJnM=;
        b=V3+7UV8+njtRydpt8dL4rn/YBCi+IHN4iHy5ddZELBjmNp/D5983ZonAgBeJwe131B
         Cd6ZLJc9uR/AJmcm4mYa5NTMNH6EE48BqffmLQDSFMIqFpLQV8gLxYJK8h4AoEKfNy6h
         NWx2y23/teWeUoA6jvtlUFfST9mlfv7PAGXyzoKINo5+2KgO0FPuiqopfClUVoDw4Gdf
         XPmEGG1ATyj/YDsas6InwGETXZ+rlcl7QoJKvpkIysJ2nIfE6SoyD42fU6a+kUnvvU03
         5p400IRBPXq/zXNsl7FEl87l/2GLCmSnzYX/0VR9/pNvZkWtuD5G9tF5WgV2xUsb1zYi
         VmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914516; x=1778519316;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZOWmtOiCy+qQAVoehJEJnvyJBE7fdTTfnBA2g8JJnM=;
        b=jZkq2yczKCuAxbKl0ieJPy1e3Bjlx4J9F9lOEyq+3/Gdp532R2Ru88dOfB+ArejsKi
         5EikSkeY9fe19KUGWTaa27cS7QtHvYbL92K6fwiZoybUwXVmE+RrdV6nZFpt6+d27Tjy
         lCMXgpZcdI1awQiWsSI96T4x1UCxf7gsrFKwILi2XD54t1HWXjKIqKiGRcQuRGjZ/Oyn
         ZrrUscfAHdZL/xX7yudyqq3bPAL/muq704SNETOJ4vY9JcbtaNwBvyAcCFnxmk7ywzR1
         KpzcP2xUFOEhR6Ws2HR41N4IzK/YvVqU83c56uHBh8ERhYSoaYbz6KnWdjbPR4GjNA7f
         flVg==
X-Gm-Message-State: AOJu0YyLS/v2Kbc41jyNkrEJ8Wi72nPWjtM5SsX2kN17m9/B4BRN6yfQ
	7YFKZ/qdO0hTJCNkKmRE0zNcUM3kYzd94+pNRiPKbdkoYaJM11pUWPYPAmyBOtd7
X-Gm-Gg: AeBDieuVCUb5dmPfaOIYDn3pOmcB83DIclvEIpLlqMY93OKchqtZc40JlfTB5tJsu0s
	2hE6qvdvdT1oi0rwzGJhtRBBYPMvZvZTjCXh+IDTXQBTfUOHqVArffHzlclIEhGqKbPpwmbKNAN
	Ho33AJongd4uI8Rmfe3P7peh142ksRsLED6Q8rqkxiDSfxo/ivhv7YM0Z3eRIWYCsP8SvLlUZbK
	iz6ajfpWEzORzvnqjPz3000bl/YEt1sDgt+anU+7IJnrBCFfknr1stoyhsHbdQEOzrti6Vfs4Lo
	EoifIN+v6wx3N7A2dWiVTyWHqCRl0iEF/za1yzd3ceG502ZKWqSo6x91/EooY8+iqu+0t/dJnn3
	eRT+J2B/9caq0IncGDH7gig9y6+s3twGmNXFaSsPysFwwXw6Z8sJlhS/w6f2OUJfy5VKuzYsn2H
	6/W3vKm+cQqDMFXbSJiN2P8wbTiXmGqmB/oaB/
X-Received: by 2002:a05:620a:6ccc:b0:8cf:bad7:20c5 with SMTP id af79cd13be357-902e2f0c149mr54222485a.25.1777914515755;
        Mon, 04 May 2026 10:08:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.231.101.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9027c2baea8sm290678985a.45.2026.05.04.10.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:08:35 -0700 (PDT)
Message-Id: <afa74a3a2b9caf9989055a9311309f590729d6c1.1777914508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
	<pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 17:08:22 +0000
Subject: [PATCH v2 05/11] test-tool: add a helper to synthesize large
 packfiles
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To test Git's behavior with very large pack files, we need a way to
generate such files quickly.

A naive approach using only readily-available Git commands would take
over 10 hours for a 4GB pack file, which is prohibitive.

Side-stepping Git's machinery and actual zlib compression by writing
uncompressed content with the appropriate zlib header makes things
much faster. The fastest method using this approach generates many
small, unreachable blob objects and takes about 1.5 minutes for 4GB.
However, this cannot be used because we need to test git clone, which
requires a reachable commit history.

Generating many reachable commits with small, uncompressed blobs takes
about 4 minutes for 4GB. But this approach 1) does not reproduce the
issues we want to fix (which require individual objects larger than
4GB) and 2) is comparatively slow because of the many SHA-1
calculations.

The approach taken here generates a single large blob (filled with NUL
bytes), along with the trees and commits needed to make it reachable.
This takes about 2.5 minutes for 4.5GB, which is the fastest option
that produces a valid, clonable repository with an object large enough
to trigger the bugs we want to test.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                   |   1 +
 compat/zlib-compat.h       |   2 +
 t/helper/meson.build       |   1 +
 t/helper/test-synthesize.c | 250 +++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c       |   1 +
 t/helper/test-tool.h       |   1 +
 6 files changed, 256 insertions(+)
 create mode 100644 t/helper/test-synthesize.c

diff --git a/Makefile b/Makefile
index cedc234173..85405cb5b8 100644
--- a/Makefile
+++ b/Makefile
@@ -872,6 +872,7 @@ TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-submodule.o
 TEST_BUILTINS_OBJS += test-subprocess.o
+TEST_BUILTINS_OBJS += test-synthesize.o
 TEST_BUILTINS_OBJS += test-trace2.o
 TEST_BUILTINS_OBJS += test-truncate.o
 TEST_BUILTINS_OBJS += test-userdiff.o
diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index ac08276622..5078c5ef6c 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -7,6 +7,8 @@
 # define z_stream_s zng_stream_s
 # define gz_header_s zng_gz_header_s
 
+# define adler32(adler, buf, len) zng_adler32(adler, buf, len)
+
 # define crc32(crc, buf, len) zng_crc32(crc, buf, len)
 
 # define inflate(strm, bits) zng_inflate(strm, bits)
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 675e64c010..3235f10ab8 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -69,6 +69,7 @@ test_tool_sources = [
   'test-submodule-nested-repo-config.c',
   'test-submodule.c',
   'test-subprocess.c',
+  'test-synthesize.c',
   'test-tool.c',
   'test-trace2.c',
   'test-truncate.c',
diff --git a/t/helper/test-synthesize.c b/t/helper/test-synthesize.c
new file mode 100644
index 0000000000..3ce7078078
--- /dev/null
+++ b/t/helper/test-synthesize.c
@@ -0,0 +1,250 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "git-zlib.h"
+#include "hash.h"
+#include "hex.h"
+#include "object-file.h"
+#include "object.h"
+#include "pack.h"
+#include "parse-options.h"
+#include "parse.h"
+#include "repository.h"
+#include "setup.h"
+#include "strbuf.h"
+#include "write-or-die.h"
+
+#define BLOCK_SIZE 0xffff
+static const unsigned char zeros[BLOCK_SIZE];
+
+/*
+ * Write data as an uncompressed zlib stream.
+ * For data larger than 64KB, writes multiple uncompressed blocks.
+ * If data is NULL, writes zeros.
+ * Updates the pack checksum context.
+ */
+static void write_uncompressed_zlib(FILE *f, struct git_hash_ctx *pack_ctx,
+				    const void *data, size_t len,
+				    const struct git_hash_algo *algo)
+{
+	unsigned char zlib_header[2] = { 0x78, 0x01 }; /* CMF, FLG */
+	unsigned char block_header[5];
+	const unsigned char *p = data;
+	size_t remaining = len;
+	uint32_t adler = 1L; /* adler32 initial value */
+	unsigned char adler_buf[4];
+
+	/* Write zlib header */
+	fwrite_or_die(f, zlib_header, sizeof(zlib_header));
+	algo->update_fn(pack_ctx, zlib_header, 2);
+
+	/* Write uncompressed blocks (max 64KB each) */
+	do {
+		size_t block_len = remaining > BLOCK_SIZE ? BLOCK_SIZE : remaining;
+		int is_final = (block_len == remaining);
+		const unsigned char *block_data = data ? p : zeros;
+
+		block_header[0] = is_final ? 0x01 : 0x00;
+		block_header[1] = block_len & 0xff;
+		block_header[2] = (block_len >> 8) & 0xff;
+		block_header[3] = block_header[1] ^ 0xff;
+		block_header[4] = block_header[2] ^ 0xff;
+
+		fwrite_or_die(f, block_header, sizeof(block_header));
+		algo->update_fn(pack_ctx, block_header, 5);
+
+		if (block_len) {
+			fwrite_or_die(f, block_data, block_len);
+			algo->update_fn(pack_ctx, block_data, block_len);
+			adler = adler32(adler, block_data, block_len);
+		}
+
+		if (data)
+			p += block_len;
+		remaining -= block_len;
+	} while (remaining > 0);
+
+	/* Write adler32 checksum */
+	put_be32(adler_buf, adler);
+	fwrite_or_die(f, adler_buf, sizeof(adler_buf));
+	algo->update_fn(pack_ctx, adler_buf, 4);
+}
+
+/*
+ * Write an uncompressed object to the pack file.
+ * If `data == NULL`, it is treated like a buffer to NUL bytes.
+ * Updates the pack checksum context.
+ */
+static void write_pack_object(FILE *f, struct git_hash_ctx *pack_ctx,
+			      enum object_type type,
+			      const void *data, size_t len,
+			      struct object_id *oid,
+			      const struct git_hash_algo *algo)
+{
+	unsigned char pack_header[MAX_PACK_OBJECT_HEADER];
+	char object_header[32];
+	int pack_header_len, object_header_len;
+	struct git_hash_ctx ctx;
+
+	/* Write pack object header */
+	pack_header_len = encode_in_pack_object_header(pack_header,
+						       sizeof(pack_header),
+						       type, len);
+	fwrite_or_die(f, pack_header, pack_header_len);
+	algo->update_fn(pack_ctx, pack_header, pack_header_len);
+
+	/* Write the data as uncompressed zlib */
+	write_uncompressed_zlib(f, pack_ctx, data, len, algo);
+
+	algo->init_fn(&ctx);
+	object_header_len = format_object_header(object_header,
+						 sizeof(object_header),
+						 type, len);
+	algo->update_fn(&ctx, object_header, object_header_len);
+	if (data)
+		algo->update_fn(&ctx, data, len);
+	else {
+		for (size_t i = len / BLOCK_SIZE; i; i--)
+			algo->update_fn(&ctx, zeros, BLOCK_SIZE);
+		algo->update_fn(&ctx, zeros, len % BLOCK_SIZE);
+	}
+	algo->final_oid_fn(oid, &ctx);
+}
+
+/*
+ * Generate a pack file with a single large (>4GB) reachable object.
+ *
+ * Creates:
+ *   1. A large blob (all NUL bytes)
+ *   2. A tree containing that blob as "file"
+ *   3. A commit using that tree
+ *   4. The empty tree
+ *   5. A child commit using the empty tree
+ *
+ * This is useful for testing that Git can handle objects larger than 4GB.
+ */
+static int generate_pack_with_large_object(const char *path, size_t blob_size,
+					   const struct git_hash_algo *algo)
+{
+	FILE *f = xfopen(path, "wb");
+	struct git_hash_ctx pack_ctx;
+	unsigned char pack_hash[GIT_MAX_RAWSZ];
+	struct object_id blob_oid, tree_oid, commit_oid, empty_tree_oid, final_commit_oid;
+	struct strbuf buf = STRBUF_INIT;
+	const uint32_t object_count = 5;
+	struct pack_header pack_header = {
+		.hdr_signature = htonl(PACK_SIGNATURE),
+		.hdr_version = htonl(PACK_VERSION),
+		.hdr_entries = htonl(object_count),
+	};
+
+	algo->init_fn(&pack_ctx);
+
+	/* Write pack header */
+	fwrite_or_die(f, &pack_header, sizeof(pack_header));
+	algo->update_fn(&pack_ctx, &pack_header, sizeof(pack_header));
+
+	/* 1. Write the large blob */
+	write_pack_object(f, &pack_ctx, OBJ_BLOB, NULL, blob_size, &blob_oid, algo);
+
+	/* 2. Write tree containing the blob as "file" */
+	strbuf_addf(&buf, "100644 file%c", '\0');
+	strbuf_add(&buf, blob_oid.hash, algo->rawsz);
+	write_pack_object(f, &pack_ctx, OBJ_TREE, buf.buf, buf.len, &tree_oid, algo);
+
+	/* 3. Write commit using that tree */
+	strbuf_reset(&buf);
+	strbuf_addf(&buf,
+		    "tree %s\n"
+		    "author A U Thor <author@example.com> 1234567890 +0000\n"
+		    "committer C O Mitter <committer@example.com> 1234567890 +0000\n"
+		    "\n"
+		    "Large blob commit\n",
+		    oid_to_hex(&tree_oid));
+	write_pack_object(f, &pack_ctx, OBJ_COMMIT, buf.buf, buf.len, &commit_oid, algo);
+
+	/* 4. Write the empty tree */
+	write_pack_object(f, &pack_ctx, OBJ_TREE, "", 0, &empty_tree_oid, algo);
+
+	/* 5. Write final commit using empty tree, with previous commit as parent */
+	strbuf_reset(&buf);
+	strbuf_addf(&buf,
+		    "tree %s\n"
+		    "parent %s\n"
+		    "author A U Thor <author@example.com> 1234567890 +0000\n"
+		    "committer C O Mitter <committer@example.com> 1234567890 +0000\n"
+		    "\n"
+		    "Empty tree commit\n",
+		    oid_to_hex(&empty_tree_oid),
+		    oid_to_hex(&commit_oid));
+	write_pack_object(f, &pack_ctx, OBJ_COMMIT, buf.buf, buf.len, &final_commit_oid, algo);
+
+	/* Write pack trailer (checksum) */
+	algo->final_fn(pack_hash, &pack_ctx);
+	fwrite_or_die(f, pack_hash, algo->rawsz);
+	if (fclose(f))
+		die_errno(_("could not close '%s'"), path);
+
+	strbuf_release(&buf);
+
+	/* Print the final commit OID so caller can set up refs */
+	printf("%s\n", oid_to_hex(&final_commit_oid));
+
+	return 0;
+}
+
+static int cmd__synthesize__pack(int argc, const char **argv,
+				 const char *prefix UNUSED,
+				 struct repository *repo)
+{
+	int non_git;
+	int reachable_large = 0;
+	const struct git_hash_algo *algo;
+	size_t blob_size;
+	uintmax_t blob_size_u;
+	const char *path;
+	const char * const usage[] = {
+		"test-tool synthesize pack "
+		"--reachable-large <blob-size> <filename>",
+		NULL
+	};
+	struct option options[] = {
+		OPT_BOOL(0, "reachable-large", &reachable_large,
+			 N_("write a pack with a single reachable large blob")),
+		OPT_END()
+	};
+
+	setup_git_directory_gently(&non_git);
+	repo = the_repository;
+	algo = repo->hash_algo;
+
+	argc = parse_options(argc, argv, NULL, options, usage,
+			     PARSE_OPT_KEEP_ARGV0);
+	if (argc != 3 || !reachable_large)
+		usage_with_options(usage, options);
+
+	if (!git_parse_unsigned(argv[1], &blob_size_u,
+				maximum_unsigned_value_of_type(size_t)))
+		die(_("'%s' is not a valid blob size"), argv[1]);
+	blob_size = blob_size_u;
+	path = argv[2];
+
+	return !!generate_pack_with_large_object(path, blob_size, algo);
+}
+
+int cmd__synthesize(int argc, const char **argv)
+{
+	const char *prefix = NULL;
+	char const * const synthesize_usage[] = {
+		"test-tool synthesize pack <options>",
+		NULL,
+	};
+	parse_opt_subcommand_fn *fn = NULL;
+	struct option options[] = {
+		OPT_SUBCOMMAND("pack", &fn, cmd__synthesize__pack),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, prefix, options, synthesize_usage, 0);
+	return !!fn(argc, argv, prefix, NULL);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index a7abc618b3..b71a22b43b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -82,6 +82,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-config", cmd__submodule_config },
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
+	{ "synthesize", cmd__synthesize },
 	{ "trace2", cmd__trace2 },
 	{ "truncate", cmd__truncate },
 	{ "userdiff", cmd__userdiff },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7f150fa1eb..f2885b33d5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -75,6 +75,7 @@ int cmd__submodule(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
+int cmd__synthesize(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
 int cmd__truncate(int argc, const char **argv);
 int cmd__userdiff(int argc, const char **argv);
-- 
gitgitgadget

