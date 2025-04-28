Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833521F416A
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871891; cv=none; b=lP2BOsCg8nXA9xlyiE2PTXyqsrTr99yIhO0AMZ9xcCAejsmACSwXZGfbmO8/Cx0fWVWn9Q8VbsxZrj9QJGKJsjS+LXLPA49I/A68VAqcb7WuP+YIejG2NBpKYc9mT3k97b160S7qt4iTqjJNDlHvcOj+0TNWxms2vxsYB6UqQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871891; c=relaxed/simple;
	bh=n9bIg4ACLPIPXg/BpArN6lu81QLXoY/+8ZGmaDESIIA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pgf4gK9n125CVlH7rCTwwMm+7KkwSbjPR3gRuLewd8hkoXMNFGbnIzf0IDRTKkPQIbHfVPjJSzp3dGgCU+0JQBFaa+MNyqpQ+p68VYkje5RXt9RJ5XNNV3QgupxYQJw1a4wfKhfoFJG59FJv7Y3ZHpq+oJCaT/j5kF7om/soHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx7v+VZD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx7v+VZD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394a823036so50567415e9.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745871887; x=1746476687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30P4hcVn/ZWnffCvxzz841pqK8BBXNnUzuYM/evJd0Q=;
        b=Qx7v+VZDe1sYNuW8DQ3MmK7AjJ8eAj5ZRo68lzHsX4rHYwDOiPBVVezAiKP1Ktm4bk
         90zojrQFLHVEZWbQ1ZBi3+vgdqE1BcdkDgaj5ZVKtOdt0jpjo+SXooqHav9u385nztG5
         iwpHsRu0mR80NS4myX22P0kZcIOPhAnreQPf+lOr8/y9b3fmZMEQjzfdtJYDxEGPENoq
         Okou+mihoEz3rKqMzf83jKFKQ/ixgkyxGJkwy8HDo6cNcUbD/OI2Tj7V6nYW67I9ojJf
         qx1G1IR05FDkC0xJibc1U9n6q4Cn3vr9ZSooCUpfzueu0W9qJ0vA2TRU65Qha5sZXOLO
         PRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871887; x=1746476687;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30P4hcVn/ZWnffCvxzz841pqK8BBXNnUzuYM/evJd0Q=;
        b=wNPa1PWQKgfRezhopDf0ZJP/1u/bJqvr6GiDgBs+Y/dcWjv+EXXyUwQgaauHLP6wnG
         a4lHcAO5rspBRDkNnM7kapL3Vdkdoe4U7U9pqlc/4lbXTxB71yxXLNGQDVlE4yxKAoiB
         duuU30BRaaUrTGrS/c+px1tgG5gc3sZjJ46X1K33doBUrO6nzc+i312csjvRPA174Exh
         G4eGYfz/EZHsa5MQh3eElPhAeU3/a5Py6rPd0xDzko0eCgOreMmXlHuP+4n36V2FaaB8
         gAIbtYDMUqnYeQCFni2hOhWNHaDJ+u8IGKhtqWDJ9ZZrVj06AWJ+XmgdtcOGWu6STWuI
         w1yQ==
X-Gm-Message-State: AOJu0YzvVGvaVOv9OxMR5JN7QK0kPK+NWl7as15uhU+cpkySXzHDTYTW
	6t+DmntBkJpWUvGgUzH6TWxfXrwWkPOqIkkmQFpNpkc2jGkXZ/9ZOrLcSA==
X-Gm-Gg: ASbGnctcoLvuunJpIc4b/o5Z/fKYbjC9AEGTcz5YeTvl94a65RDPzaA6dHeBDxvF+qM
	WHDHNETzv6KWIILGWrlriMEL/t9Q0y/9Na8n6yGTkwJg6g6aCHvFjPYHLvtZiWOFgcYnJ63FPlO
	vzumPqEJ0eZzX+l3LtH1exFcHFvlkdw1tE8aSicL0qFfexDz/QoeT26li6e4YZxkYnPtjM+AxAx
	CuK4Ss84g9a0BFZ5dea8dQ+Un5PEMqMft24JWG0mtFxE9/BSib6gR4BrheCs+zsQpr5Kcb69iPY
	s4pxIfMqqSdLUI2tLL6pO/qgplfZNe6OW1EPddskwg==
X-Google-Smtp-Source: AGHT+IGluZCO6M2H6unGmRzO4bdMpAVaARWZm+5qBtu0dSfER3IVROK7J2+uQnS8ipfcnxtx3DfXcw==
X-Received: by 2002:a05:6000:420a:b0:39c:f0d:9146 with SMTP id ffacd0b85a97d-3a08ad779f7mr93280f8f.45.1745871887359;
        Mon, 28 Apr 2025 13:24:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e461casm12281792f8f.74.2025.04.28.13.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:24:47 -0700 (PDT)
Message-Id: <41aac8e782fdd9e2a19c6fadd27807782fc36203.1745871885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1906.v2.git.1745871885.gitgitgadget@gmail.com>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
	<pull.1906.v2.git.1745871885.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Apr 2025 20:24:43 +0000
Subject: [PATCH v2 1/3] test-tool: add pack-deltas helper
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
Cc: gitster@pobox.com,
    peff@peff.net,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When trying to demonstrate certain behavior in tests, it can be helpful
to create packfiles that have specific delta structures. 'git
pack-objects' uses various algorithms to select deltas based on their
compression rates, but that does not always demonstrate all possible
packfile shapes. This becomes especially important when wanting to test
'git index-pack' and its ability to parse certain pack shapes.

We have prior art in t/lib-pack.sh, where certain delta structures are
produced by manually writing certain opaque pack contents. However,
producing these script updates is cumbersome and difficult to do as a
contributor.

Instead, create a new test-tool, 'test-tool pack-deltas', that reads a
list of instructions for which objects to include in a packfile and how
those objects should be written in delta form.

At the moment, this only supports REF_DELTAs as those are the kinds of
deltas needed to exercise a bug in 'git index-pack'.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Makefile                    |   1 +
 t/helper/meson.build        |   1 +
 t/helper/test-pack-deltas.c | 148 ++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 5 files changed, 152 insertions(+)
 create mode 100644 t/helper/test-pack-deltas.c

diff --git a/Makefile b/Makefile
index 13f9062a056..c4d21ccd3d1 100644
--- a/Makefile
+++ b/Makefile
@@ -821,6 +821,7 @@ TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-name-hash.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
+TEST_BUILTINS_OBJS += test-pack-deltas.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
diff --git a/t/helper/meson.build b/t/helper/meson.build
index d2cabaa2bcf..d4e8b26df8d 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -36,6 +36,7 @@ test_tool_sources = [
   'test-mktemp.c',
   'test-name-hash.c',
   'test-online-cpus.c',
+  'test-pack-deltas.c',
   'test-pack-mtimes.c',
   'test-parse-options.c',
   'test-parse-pathspec-file.c',
diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
new file mode 100644
index 00000000000..4caa024b1eb
--- /dev/null
+++ b/t/helper/test-pack-deltas.c
@@ -0,0 +1,148 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "delta.h"
+#include "git-zlib.h"
+#include "hash.h"
+#include "hex.h"
+#include "pack.h"
+#include "pack-objects.h"
+#include "parse-options.h"
+#include "setup.h"
+#include "strbuf.h"
+#include "string-list.h"
+
+static const char *usage_str[] = {
+	"test-tool pack-deltas --num-objects <num-objects>",
+	NULL
+};
+
+static unsigned long do_compress(void **pptr, unsigned long size)
+{
+	git_zstream stream;
+	void *in, *out;
+	unsigned long maxsize;
+
+	git_deflate_init(&stream, 1);
+	maxsize = git_deflate_bound(&stream, size);
+
+	in = *pptr;
+	out = xmalloc(maxsize);
+	*pptr = out;
+
+	stream.next_in = in;
+	stream.avail_in = size;
+	stream.next_out = out;
+	stream.avail_out = maxsize;
+	while (git_deflate(&stream, Z_FINISH) == Z_OK)
+		; /* nothing */
+	git_deflate_end(&stream);
+
+	free(in);
+	return stream.total_out;
+}
+
+static void write_ref_delta(struct hashfile *f,
+			    struct object_id *oid,
+			    struct object_id *base)
+{
+	unsigned char header[MAX_PACK_OBJECT_HEADER];
+	unsigned long size, base_size, delta_size, compressed_size, hdrlen;
+	enum object_type type;
+	void *base_buf, *delta_buf;
+	void *buf = repo_read_object_file(the_repository,
+					  oid, &type,
+					  &size);
+
+	if (!buf)
+		die("unable to read %s", oid_to_hex(oid));
+
+	base_buf = repo_read_object_file(the_repository,
+					 base, &type,
+					 &base_size);
+
+	if (!base_buf)
+		die("unable to read %s", oid_to_hex(base));
+
+	delta_buf = diff_delta(base_buf, base_size,
+			       buf, size, &delta_size, 0);
+
+	compressed_size = do_compress(&delta_buf, delta_size);
+
+	hdrlen = encode_in_pack_object_header(header, sizeof(header),
+					      OBJ_REF_DELTA, delta_size);
+	hashwrite(f, header, hdrlen);
+	hashwrite(f, base->hash, the_repository->hash_algo->rawsz);
+	hashwrite(f, delta_buf, compressed_size);
+
+	free(buf);
+	free(base_buf);
+	free(delta_buf);
+}
+
+int cmd__pack_deltas(int argc, const char **argv)
+{
+	int num_objects = -1;
+	struct hashfile *f;
+	struct strbuf line = STRBUF_INIT;
+	struct option options[] = {
+		OPT_INTEGER('n', "num-objects", &num_objects, N_("the number of objects to write")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     options, usage_str, 0);
+
+	if (argc || num_objects < 0)
+		usage_with_options(usage_str, options);
+
+	setup_git_directory();
+
+	f = hashfd(the_repository->hash_algo, 1, "<stdout>");
+	write_pack_header(f, num_objects);
+
+	/* Read each line from stdin into 'line' */
+	while (strbuf_getline_lf(&line, stdin) != EOF) {
+		const char *type_str, *content_oid_str, *base_oid_str = NULL;
+		struct object_id content_oid, base_oid;
+		struct string_list items = STRING_LIST_INIT_NODUP;
+		/*
+		 * Tokenize into two or three parts:
+		 * 1. REF_DELTA, OFS_DELTA, or FULL.
+		 * 2. The object ID for the content object.
+		 * 3. The object ID for the base object (optional).
+		 */
+		if (string_list_split_in_place(&items, line.buf, " ", 3) < 0)
+			die("invalid input format: %s", line.buf);
+
+		if (items.nr < 2)
+			die("invalid input format: %s", line.buf);
+
+		type_str = items.items[0].string;
+		content_oid_str = items.items[1].string;
+
+		if (get_oid_hex(content_oid_str, &content_oid))
+			die("invalid object: %s", content_oid_str);
+		if (items.nr >= 3) {
+			base_oid_str = items.items[2].string;
+			if (get_oid_hex(base_oid_str, &base_oid))
+				die("invalid object: %s", base_oid_str);
+		}
+		string_list_clear(&items, 0);
+
+		if (!strcmp(type_str, "REF_DELTA"))
+			write_ref_delta(f, &content_oid, &base_oid);
+		else if (!strcmp(type_str, "OFS_DELTA"))
+			die("OFS_DELTA not implemented");
+		else if (!strcmp(type_str, "FULL"))
+			die("FULL not implemented");
+		else
+			die("unknown pack type: %s", type_str);
+	}
+
+	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK,
+			  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+	strbuf_release(&line);
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 50dc4dac4ed..74812ed86d3 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -46,6 +46,7 @@ static struct test_cmd cmds[] = {
 	{ "mktemp", cmd__mktemp },
 	{ "name-hash", cmd__name_hash },
 	{ "online-cpus", cmd__online_cpus },
+	{ "pack-deltas", cmd__pack_deltas },
 	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
 	{ "parse-options-flags", cmd__parse_options_flags },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 6d62a5b53d9..2571a3ccfe8 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -39,6 +39,7 @@ int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__name_hash(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
+int cmd__pack_deltas(int argc, const char **argv);
 int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_options_flags(int argc, const char **argv);
-- 
gitgitgadget

