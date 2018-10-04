Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7641F453
	for <e@80x24.org>; Thu,  4 Oct 2018 23:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeJEF5a (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 01:57:30 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53538 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeJEF5a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 01:57:30 -0400
Received: by mail-pg1-f201.google.com with SMTP id z8-v6so5492206pgp.20
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 16:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SBm7rigYT/BwHKx7cs96cvxw21DKmxxnkRFoxQi9oB4=;
        b=DHOWWiB6N9uLmU/Ib4znndyuwid8/7SYnf4yr7f+CjanseV8fCWQ6RVg2nNBomyR7m
         k5UIffgCXL/KK4jKK9lysUQnpkAIdFzaMCAlAUpQQGFYFeX1k/d0sPu1szMgEzCx+4Gd
         j1BahQwtJtI6ZIVnA7WBkZkzfOO0y3lKiqomgIhAMLmR7JqUW454BVnCoa9JZ3NBQGDX
         jDJQEnxBNa9hrn1iKzJSu1Yge2UgaADLiGr89kamGataorbCkO98s1E/aqH3ejW92H01
         VzOBCWzHVy8uy8gbTGOW9GbjcU30al43GXEv9N68HWqFVAv8rzmz9VdepyIXcZU0x4ce
         hj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SBm7rigYT/BwHKx7cs96cvxw21DKmxxnkRFoxQi9oB4=;
        b=CvbUOzq8sgDfCGOlRfeZcltA8mB7ON80X4XrZ53YH+Fu6QTBi4yostXam6UdVR25WV
         ht7hpDBitAMxEedefNa3poTWMxOZWpvGX9YDWVWgoW36TobZHQWk0iHdkmlvkQwIe4zV
         55pqlt3IDMbrJjl0UMrBFqG/e6HEjv1oWP5Qvp0jEqiWEIH0qL1HDbTfyTbPZpwUsalW
         4YgMVCI1eCwhwiQdww6OqcC4AUZj2iV56yIqVmmQhOpr5m0hVpZLR4SXr3CyWirb/dKH
         cQxqcscExXt1PEEjTuZYeMJRqSQOyz0b+qi7OTn3A2ncMMWxCy5JmCnUKwsfpF4Rmugu
         Wvaw==
X-Gm-Message-State: ABuFfogmf+nCi/KI2NJnf5t2lluSqJVjbmARFaM75Epi+urfNyYrNSoa
        PY7ZDePrN3+0P8aNYHjr+CtfTXdYkYdkk8GWTfC603jiRsb21d5PMt9XrBMPAzc0X5d3did3MR1
        6dJBIotoCmT3ehksFnxbMYWKLGzs07E2L1TMNvwbOyrdKzb3uJ+n9/snTOVfaRbc=
X-Google-Smtp-Source: ACcGV63B/bYvarCa1kxVIK8tLyMgqneQ9kEtoCetnyXjrJUvkQRv4bwX1QhMJBoFbsC8yZd67VCw9Zkn7IXZ+g==
X-Received: by 2002:a62:12ca:: with SMTP id 71-v6mr3911090pfs.55.1538694109911;
 Thu, 04 Oct 2018 16:01:49 -0700 (PDT)
Date:   Thu,  4 Oct 2018 16:01:29 -0700
In-Reply-To: <cover.1538693039.git.steadmon@google.com>
Message-Id: <60b9daad5c5132811875b6094abf4d87852e4263.1538693039.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1538693039.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [RFC PATCH 2/2] fuzz: Add fuzz testing for packfile indices.
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore      |  1 +
 Makefile        |  5 ++++-
 fuzz-pack-idx.c | 13 +++++++++++++
 packfile.c      | 44 +++++++++++++++++++++++++-------------------
 packfile.h      | 13 +++++++++++++
 5 files changed, 56 insertions(+), 20 deletions(-)
 create mode 100644 fuzz-pack-idx.c

diff --git a/.gitignore b/.gitignore
index 87a28b3115..64b3377d40 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,6 @@
 /fuzz_corpora
 /fuzz-pack-headers
+/fuzz-pack-idx
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
diff --git a/Makefile b/Makefile
index 10bb82b115..f7e6be8f19 100644
--- a/Makefile
+++ b/Makefile
@@ -685,6 +685,7 @@ SCRIPTS = $(SCRIPT_SH_INS) \
 ETAGS_TARGET = TAGS
 
 FUZZ_OBJS += fuzz-pack-headers.o
+FUZZ_OBJS += fuzz-pack-idx.o
 
 FUZZ_PROGRAMS += $(patsubst %.o,%,$(FUZZ_OBJS))
 
@@ -3071,7 +3072,7 @@ cover_db_html: cover_db
 
 ### Fuzz testing
 #
-.PHONY: fuzz-clean fuzz-objs fuzz-compile
+.PHONY: fuzz-clean fuzz-objs fuzz-compile fuzz-all
 
 FUZZ_CFLAGS = $(CFLAGS) -fsanitize-coverage=trace-pc-guard -fsanitize=address
 FUZZ_LDFLAGS = $(FUZZ_CFLAGS)
@@ -3089,3 +3090,5 @@ fuzz-compile:
 $(FUZZ_PROGRAMS): fuzz-compile
 	clang++ $(FUZZ_LDFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) $(XDIFF_OBJS) \
 		$(EXTLIBS) git.o $@.o /usr/lib/llvm-4.0/lib/libFuzzer.a -o $@
+
+fuzz-all: $(FUZZ_PROGRAMS)
diff --git a/fuzz-pack-idx.c b/fuzz-pack-idx.c
new file mode 100644
index 0000000000..0c3d777aac
--- /dev/null
+++ b/fuzz-pack-idx.c
@@ -0,0 +1,13 @@
+#include "object-store.h"
+#include "packfile.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	struct packed_git p;
+
+	load_idx("fuzz-input", GIT_SHA1_RAWSZ, (void *)data, size, &p);
+
+	return 0;
+}
diff --git a/packfile.c b/packfile.c
index 841b36182f..86074a76e9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -80,10 +80,8 @@ void pack_report(void)
 static int check_packed_git_idx(const char *path, struct packed_git *p)
 {
 	void *idx_map;
-	struct pack_idx_header *hdr;
 	size_t idx_size;
-	uint32_t version, nr, i, *index;
-	int fd = git_open(path);
+	int fd = git_open(path), ret;
 	struct stat st;
 	const unsigned int hashsz = the_hash_algo->rawsz;
 
@@ -101,16 +99,32 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 	idx_map = xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	hdr = idx_map;
+	ret = load_idx(path, hashsz, idx_map, idx_size, p);
+
+	if (ret)
+		munmap(idx_map, idx_size);
+
+	return ret;
+}
+
+int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
+	     size_t idx_size, struct packed_git *p)
+{
+	struct pack_idx_header *hdr = idx_map;
+	uint32_t version, nr, i, *index;
+
+	if (idx_size < 4 * 256 + hashsz + hashsz)
+		return error("index file %s is too small", path);
+	if (idx_map == NULL)
+		return error("empty data");
+
 	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(hdr->idx_version);
-		if (version < 2 || version > 2) {
-			munmap(idx_map, idx_size);
+		if (version < 2 || version > 2)
 			return error("index file %s is version %"PRIu32
 				     " and is not supported by this binary"
 				     " (try upgrading GIT to a newer version)",
 				     path, version);
-		}
 	} else
 		version = 1;
 
@@ -120,10 +134,8 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 		index += 2;  /* skip index header */
 	for (i = 0; i < 256; i++) {
 		uint32_t n = ntohl(index[i]);
-		if (n < nr) {
-			munmap(idx_map, idx_size);
+		if (n < nr)
 			return error("non-monotonic index %s", path);
-		}
 		nr = n;
 	}
 
@@ -135,10 +147,8 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 		 *  - hash of the packfile
 		 *  - file checksum
 		 */
-		if (idx_size != 4*256 + nr * (hashsz + 4) + hashsz + hashsz) {
-			munmap(idx_map, idx_size);
+		if (idx_size != 4 * 256 + nr * (hashsz + 4) + hashsz + hashsz)
 			return error("wrong index v1 file size in %s", path);
-		}
 	} else if (version == 2) {
 		/*
 		 * Minimum size:
@@ -157,20 +167,16 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 		unsigned long max_size = min_size;
 		if (nr)
 			max_size += (nr - 1)*8;
-		if (idx_size < min_size || idx_size > max_size) {
-			munmap(idx_map, idx_size);
+		if (idx_size < min_size || idx_size > max_size)
 			return error("wrong index v2 file size in %s", path);
-		}
 		if (idx_size != min_size &&
 		    /*
 		     * make sure we can deal with large pack offsets.
 		     * 31-bit signed offset won't be enough, neither
 		     * 32-bit unsigned one will be.
 		     */
-		    (sizeof(off_t) <= 4)) {
-			munmap(idx_map, idx_size);
+		    (sizeof(off_t) <= 4))
 			return error("pack too large for current definition of off_t in %s", path);
-		}
 	}
 
 	p->index_version = version;
diff --git a/packfile.h b/packfile.h
index 442625723d..6c4037605d 100644
--- a/packfile.h
+++ b/packfile.h
@@ -164,4 +164,17 @@ extern int has_pack_index(const unsigned char *sha1);
  */
 extern int is_promisor_object(const struct object_id *oid);
 
+/*
+ * Expose a function for fuzz testing.
+ *
+ * load_idx() parses a block of memory as a packfile index and puts the results
+ * into a struct packed_git.
+ *
+ * This function should not be used directly. It is exposed here only so that we
+ * have a convenient entry-point for fuzz testing. For real uses, you should
+ * probably use open_pack_index() or parse_pack_index() instead.
+ */
+extern int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
+		    size_t idx_size, struct packed_git *p);
+
 #endif
-- 
2.19.0.605.g01d371f741-goog

