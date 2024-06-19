Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0295F15B0F5
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834298; cv=none; b=MesEc05JM5kqwj3YXKdx/P2hFamSLrq2HQQ1DAfsEutX/sM+HLH3yfTQ0v5t91Lgd81PWAo/LU3Tc+p+C9vTiTD4Y3TXd1DqPFkSZ+TKCqtXRmNH3gkR3zte2ZIshY9Q9lgsz7CPquRIjY0tC5LWKpOqYaE/cEFXAK+gSz5oSck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834298; c=relaxed/simple;
	bh=SxYuvvKaoxzWFs2m+LWd3LTdcn92m5SClq8aPMrayPk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RlNfIyW3PQSJCOS4gqLkFY7sMuuLOPlSK1SQPVHOIWHD4RL93MgkkwHSReP/LcdV+1/K50GI+avb32Y3iRzecNNTCADOhJBCxUifqmwrWFdMokI/Hi0tSih3MK5p2Em7C+/D7j3cubCEwuZj4uWye5oj8EmN5NHqATjuMfuZVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS5HYCP3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS5HYCP3"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42172ed3597so1646455e9.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834294; x=1719439094; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGKQqxC2lOCg+N5VQXQOAgfNgIOmU5SVsKzh7ojag6I=;
        b=gS5HYCP3b+M4FmjmXVp17nF2RsRW6+OF4P3eSID0cP+1ANN/QREHcnDkgIH8zAoGMC
         7Q4QlFiw/93W3KJdciGEWB2Or9DCkTFJ33hFTEtwCX4TiAeSHLxlpk46UI5Hu3De6sCP
         bvqoycZ0KBLmT/5AlrLKCw24/OiITkF4gNAJYAUm4sLKpXsLaLpImNz5fLhUnlQrYiyd
         onpk+M33P1DUGTRkIqB+t8WtvCsB7G6PnjM5VYAPSApT9zDAGlKnukz6mMmeN0PitbeO
         u5N2p1JTjdyfxnM8pSPJ980ps5DUdQKbq4P+3DFaq0pTxln3DfASnlj1VRegJKZ4tWR4
         psoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834294; x=1719439094;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGKQqxC2lOCg+N5VQXQOAgfNgIOmU5SVsKzh7ojag6I=;
        b=WilcLHh0Gnib32543OzxJC5o1ZAsVhhGncdTOUEGTCst5BRcQWfeAm8GhwiZDw14gf
         NpQIecFgZ0V8r8H/Umw2fgTgyfCyLoerFx7TQvvU55ysdmxllKs38QUmjXdk5Epu+Mbq
         9d5TUSIKdETdD9M0teYo0h1nh+/w/WdaoW0pjjjWi170t3bsarsx3jiqZeZtFyAPZKih
         DUvhbySsWPPg7UtuCJ6muNIk+Ky3vn4p2pDL0ZcDrGnO6N1xBdXvbokWsv36qyDJfBT5
         6jtHQ4ywheFuhSh0ltuyFhPcH4wdpmw7+G3bn6XPUB7Nrq09eU2La7xVVgqDwYdsHcvA
         ohRg==
X-Gm-Message-State: AOJu0YxcF8jJPoT51v/9bCeGeTvMTrTEjyO2LtidLkY3RvJBqCHqj5ye
	2ocu9GeiQmEKCT3cKB/MgG3uawz5uP0brXZCdyavQgXQOCKQlMkM6OYH2Q==
X-Google-Smtp-Source: AGHT+IGANyQRXvOad1+aldmfUuWWSfrdPNgunL4yWoe2y91kik9m7hU5XGIIqiH5TvE3cuNyJzRm6g==
X-Received: by 2002:a05:600c:3556:b0:421:81eb:7d5c with SMTP id 5b1f17b1804b1-4246f5dbe0emr59512425e9.18.1718834293557;
        Wed, 19 Jun 2024 14:58:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d21226asm3683925e9.47.2024.06.19.14.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:12 -0700 (PDT)
Message-Id: <f5473764236be36c6e23714ce99c533ba83ac18e.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:57:52 +0000
Subject: [PATCH v2 04/17] update-index: generalize 'read_index_info'
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Move 'read_index_info()' into a new header 'index-info.h' and generalize the
function to call a provided callback for each parsed line. Update
'update-index.c' to use this generalized 'read_index_info()', adding the
callback 'apply_index_info()' to verify the parsed line and update the index
according to its contents.

Switching to using a callback to validate the parsed entry in 'update-index'
results in a slight change to the error message indicating a file could not
be removed from the index. The original implementation uses the raw, quoted
pathname in the error message, whereas the callback (without access to the
raw pathname) uses the unquoted value. However, this change makes the failed
removal message consistent with all other error messages in the function,
and that consistency is likely more beneficial than not to a user.

The motivation for this change is to consolidate the already-similar input
parsing logic in 'git update-index' and 'git mktree', avoiding code
duplication and the associated maintenance burden. The input formats
accepted by 'update-index' are a superset of those accepted by 'mktree', so
in a later commit we can replace the input parsing of the latter with
'read_index_info()' without breaking existing usage.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-update-index.txt   |  16 +---
 Documentation/index-info-formats.txt |  13 +++
 Makefile                             |   1 +
 builtin/update-index.c               | 129 +++++++--------------------
 index-info.c                         |  90 +++++++++++++++++++
 index-info.h                         |  11 +++
 t/t2107-update-index-basic.sh        |  27 ++++++
 7 files changed, 177 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/index-info-formats.txt
 create mode 100644 index-info.c
 create mode 100644 index-info.h

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 7128aed5405..e52aecb845d 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -278,21 +278,9 @@ USING --INDEX-INFO
 
 `--index-info` is a more powerful mechanism that lets you feed
 multiple entry definitions from the standard input, and designed
-specifically for scripts.  It can take inputs of three formats:
+specifically for scripts.  It can take inputs in the following formats:
 
-    . mode SP type SP sha1          TAB path
-+
-This format is to stuff `git ls-tree` output into the index.
-
-    . mode         SP sha1 SP stage TAB path
-+
-This format is to put higher order stages into the
-index file and matches 'git ls-files --stage' output.
-
-    . mode         SP sha1          TAB path
-+
-This format is no longer produced by any Git command, but is
-and will continue to be supported by `update-index --index-info`.
+include::index-info-formats.txt[]
 
 To place a higher stage entry to the index, the path should
 first be removed by feeding a mode=0 entry for the path, and
diff --git a/Documentation/index-info-formats.txt b/Documentation/index-info-formats.txt
new file mode 100644
index 00000000000..037ebd24321
--- /dev/null
+++ b/Documentation/index-info-formats.txt
@@ -0,0 +1,13 @@
+    . mode SP type SP sha1          TAB path
++
+This format is to use `git ls-tree` output.
+
+    . mode         SP sha1 SP stage TAB path
++
+This format allows higher order stages to appear and
+matches 'git ls-files --stage' output.
+
+    . mode         SP sha1          TAB path
++
+This format is no longer produced by any Git command, but is
+and will continue to be supported.
diff --git a/Makefile b/Makefile
index 2f5f16847ae..db9604e59c3 100644
--- a/Makefile
+++ b/Makefile
@@ -1037,6 +1037,7 @@ LIB_OBJS += hex.o
 LIB_OBJS += hex-ll.o
 LIB_OBJS += hook.o
 LIB_OBJS += ident.o
+LIB_OBJS += index-info.o
 LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
diff --git a/builtin/update-index.c b/builtin/update-index.c
index d343416ae26..fddf59b54c1 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -11,6 +11,7 @@
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
+#include "index-info.h"
 #include "lockfile.h"
 #include "quote.h"
 #include "cache-tree.h"
@@ -509,100 +510,29 @@ static void update_one(const char *path)
 	report("add '%s'", path);
 }
 
-static void read_index_info(int nul_term_line)
+static int apply_index_info(unsigned int mode, struct object_id *oid, int stage,
+			    const char *path_name, void *cbdata UNUSED)
 {
-	const int hexsz = the_hash_algo->hexsz;
-	struct strbuf buf = STRBUF_INIT;
-	struct strbuf uq = STRBUF_INIT;
-	strbuf_getline_fn getline_fn;
+	if (!verify_path(path_name, mode)) {
+		fprintf(stderr, "Ignoring path %s\n", path_name);
+		return 0;
+	}
 
-	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
-	while (getline_fn(&buf, stdin) != EOF) {
-		char *ptr, *tab;
-		char *path_name;
-		struct object_id oid;
-		unsigned int mode;
-		unsigned long ul;
-		int stage;
-
-		/* This reads lines formatted in one of three formats:
-		 *
-		 * (1) mode         SP sha1          TAB path
-		 * The first format is what "git apply --index-info"
-		 * reports, and used to reconstruct a partial tree
-		 * that is used for phony merge base tree when falling
-		 * back on 3-way merge.
-		 *
-		 * (2) mode SP type SP sha1          TAB path
-		 * The second format is to stuff "git ls-tree" output
-		 * into the index file.
-		 *
-		 * (3) mode         SP sha1 SP stage TAB path
-		 * This format is to put higher order stages into the
-		 * index file and matches "git ls-files --stage" output.
+	if (!mode) {
+		/* mode == 0 means there is no such path -- remove */
+		if (remove_file_from_index(the_repository->index, path_name))
+			die("git update-index: unable to remove %s", path_name);
+	}
+	else {
+		/* mode ' ' sha1 '\t' name
+		 * ptr[-1] points at tab,
+		 * ptr[-41] is at the beginning of sha1
 		 */
-		errno = 0;
-		ul = strtoul(buf.buf, &ptr, 8);
-		if (ptr == buf.buf || *ptr != ' '
-		    || errno || (unsigned int) ul != ul)
-			goto bad_line;
-		mode = ul;
-
-		tab = strchr(ptr, '\t');
-		if (!tab || tab - ptr < hexsz + 1)
-			goto bad_line;
-
-		if (tab[-2] == ' ' && '0' <= tab[-1] && tab[-1] <= '3') {
-			stage = tab[-1] - '0';
-			ptr = tab + 1; /* point at the head of path */
-			tab = tab - 2; /* point at tail of sha1 */
-		}
-		else {
-			stage = 0;
-			ptr = tab + 1; /* point at the head of path */
-		}
-
-		if (get_oid_hex(tab - hexsz, &oid) ||
-			tab[-(hexsz + 1)] != ' ')
-			goto bad_line;
-
-		path_name = ptr;
-		if (!nul_term_line && path_name[0] == '"') {
-			strbuf_reset(&uq);
-			if (unquote_c_style(&uq, path_name, NULL)) {
-				die("git update-index: bad quoting of path name");
-			}
-			path_name = uq.buf;
-		}
-
-		if (!verify_path(path_name, mode)) {
-			fprintf(stderr, "Ignoring path %s\n", path_name);
-			continue;
-		}
-
-		if (!mode) {
-			/* mode == 0 means there is no such path -- remove */
-			if (remove_file_from_index(the_repository->index, path_name))
-				die("git update-index: unable to remove %s",
-				    ptr);
-		}
-		else {
-			/* mode ' ' sha1 '\t' name
-			 * ptr[-1] points at tab,
-			 * ptr[-41] is at the beginning of sha1
-			 */
-			ptr[-(hexsz + 2)] = ptr[-1] = 0;
-			if (add_cacheinfo(mode, &oid, path_name, stage))
-				die("git update-index: unable to update %s",
-				    path_name);
-		}
-		continue;
-
-	bad_line:
-		die("malformed index info %s", buf.buf);
+		if (add_cacheinfo(mode, oid, path_name, stage))
+			die("git update-index: unable to update %s", path_name);
 	}
-	strbuf_release(&buf);
-	strbuf_release(&uq);
+
+	return 0;
 }
 
 static const char * const update_index_usage[] = {
@@ -848,16 +778,23 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 	struct parse_opt_ctx_t *ctx, const struct option *opt,
 	const char *arg, int unset)
 {
-	int *nul_term_line = opt->value;
+	int ret = 0;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
-	if (ctx->argc != 1)
-		return error("option '%s' must be the last argument", opt->long_name);
-	allow_add = allow_replace = allow_remove = 1;
-	read_index_info(*nul_term_line);
-	return 0;
+	if (ctx->argc != 1) {
+		ret = error("option '%s' must be the last argument", opt->long_name);
+	} else {
+		int *nul_term_line = opt->value;
+
+		allow_add = allow_replace = allow_remove = 1;
+		ret = read_index_info(*nul_term_line, apply_index_info, NULL);
+		if (ret)
+			ret = -1;
+	}
+
+	return ret;
 }
 
 static enum parse_opt_result stdin_callback(
diff --git a/index-info.c b/index-info.c
new file mode 100644
index 00000000000..8ccaac5487b
--- /dev/null
+++ b/index-info.c
@@ -0,0 +1,90 @@
+#include "git-compat-util.h"
+#include "index-info.h"
+#include "hash.h"
+#include "hex.h"
+#include "strbuf.h"
+#include "quote.h"
+
+int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
+{
+	const int hexsz = the_hash_algo->hexsz;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf uq = STRBUF_INIT;
+	strbuf_getline_fn getline_fn;
+	int ret = 0;
+
+	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
+	while (getline_fn(&buf, stdin) != EOF) {
+		char *ptr, *tab;
+		char *path_name;
+		struct object_id oid;
+		unsigned int mode;
+		unsigned long ul;
+		int stage;
+
+		/* This reads lines formatted in one of three formats:
+		 *
+		 * (1) mode         SP sha1          TAB path
+		 * The first format is what "git apply --index-info"
+		 * reports, and used to reconstruct a partial tree
+		 * that is used for phony merge base tree when falling
+		 * back on 3-way merge.
+		 *
+		 * (2) mode SP type SP sha1          TAB path
+		 * The second format is to stuff "git ls-tree" output
+		 * into the index file.
+		 *
+		 * (3) mode         SP sha1 SP stage TAB path
+		 * This format is to put higher order stages into the
+		 * index file and matches "git ls-files --stage" output.
+		 */
+		errno = 0;
+		ul = strtoul(buf.buf, &ptr, 8);
+		if (ptr == buf.buf || *ptr != ' '
+		    || errno || (unsigned int) ul != ul)
+			goto bad_line;
+		mode = ul;
+
+		tab = strchr(ptr, '\t');
+		if (!tab || tab - ptr < hexsz + 1)
+			goto bad_line;
+
+		if (tab[-2] == ' ' && '0' <= tab[-1] && tab[-1] <= '3') {
+			stage = tab[-1] - '0';
+			ptr = tab + 1; /* point at the head of path */
+			tab = tab - 2; /* point at tail of sha1 */
+		} else {
+			stage = 0;
+			ptr = tab + 1; /* point at the head of path */
+		}
+
+		if (get_oid_hex(tab - hexsz, &oid) ||
+			tab[-(hexsz + 1)] != ' ')
+			goto bad_line;
+
+		path_name = ptr;
+		if (!nul_term_line && path_name[0] == '"') {
+			strbuf_reset(&uq);
+			if (unquote_c_style(&uq, path_name, NULL)) {
+				ret = error("bad quoting of path name");
+				break;
+			}
+			path_name = uq.buf;
+		}
+
+		ret = fn(mode, &oid, stage, path_name, cbdata);
+		if (ret) {
+			ret = -1;
+			break;
+		}
+
+		continue;
+
+	bad_line:
+		die("malformed input line '%s'", buf.buf);
+	}
+	strbuf_release(&buf);
+	strbuf_release(&uq);
+
+	return ret;
+}
diff --git a/index-info.h b/index-info.h
new file mode 100644
index 00000000000..d650498325a
--- /dev/null
+++ b/index-info.h
@@ -0,0 +1,11 @@
+#ifndef INDEX_INFO_H
+#define INDEX_INFO_H
+
+#include "hash.h"
+
+typedef int (*each_index_info_fn)(unsigned int, struct object_id *, int, const char *, void *);
+
+/* Iterate over parsed index info from stdin */
+int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata);
+
+#endif /* INDEX_INFO_H */
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index cc72ead79f3..794a5b1a184 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -142,4 +142,31 @@ test_expect_success '--index-version' '
 	test_must_be_empty actual
 '
 
+test_expect_success '--index-info fails on malformed input' '
+	# empty line
+	echo "" |
+	test_must_fail git update-index --index-info 2>err &&
+	test_grep "malformed input line" err &&
+
+	# bad whitespace
+	printf "100644 $EMPTY_BLOB A" |
+	test_must_fail git update-index --index-info 2>err &&
+	test_grep "malformed input line" err &&
+
+	# invalid stage value
+	printf "100644 $EMPTY_BLOB 5\tA" |
+	test_must_fail git update-index --index-info 2>err &&
+	test_grep "malformed input line" err &&
+
+	# invalid OID length
+	printf "100755 abc123\tA" |
+	test_must_fail git update-index --index-info 2>err &&
+	test_grep "malformed input line" err &&
+
+	# bad quoting
+	printf "100644 $EMPTY_BLOB\t\"A" |
+	test_must_fail git update-index --index-info 2>err &&
+	test_grep "bad quoting of path name" err
+'
+
 test_done
-- 
gitgitgadget

