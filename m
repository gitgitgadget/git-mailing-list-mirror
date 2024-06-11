Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3C7441E
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130297; cv=none; b=O98Z9TubZha2nfNuCJS1LYOtkepwYXpiq9zmFnadLQ9wOi9F+3jAJo1EwXvHB6ZJHorMX1mN/e0kPE3wYuBbCQx/cDC4i3v7epCofNJQkZ4pGeFvU7uVW3TrnQ3XzzzeGQlPr3PYMF+M0YIvtqzo8oRkxjFA/QoqkRc+oPZaM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130297; c=relaxed/simple;
	bh=kWwvRTjg9Hemaz0ymKYMG4JoE9jb1NA6f1/ya6Sp99s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b2TBoH5r59yKxvvJG9Ka8C6o+0IV9olyTRzcGo9QqJ2kr7s2VcGcPLtCn9oDlZ2aeScP+g2zGSs8Fk3BVu/wmTfH9eSw4VOAFDN7/8UM0xGJ521aaJgg5HnPHTWxJbT2rAWJBYgEE9R9TXzssTCTPV6YeG83OMCyBY7QJkk3euw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na5E3rWU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na5E3rWU"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebed33cbadso19634941fa.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130293; x=1718735093; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKqRbGm/RW+V6fq9cVwuHYuiNBW4lFAV7W6d0xw6R6M=;
        b=Na5E3rWUWkKavbNVE6aKfC3eIQDsnbgsNU7NttISmqUNyyK2SOQ6xwBwb9wRh1b9m3
         L3WVmgsqO2euZ4F2+TfhnbHoAzIbM7Hp4rRGW1pVTQ+PsfhRsySJ2MHVoxQ9gD+GG/jv
         Iy2YBXZLxx1nD1Qd3XVrBmPARQN35xPuz5A2pm9i2Fz/B+KaskZTpPBjfQjBC+s/F/ox
         GaNprYWC6hoKExDmwWLMFXSw1VDT3XAk+rBdz8IeHbMQcFUY/vIWBTl7RRtoFFwshxHF
         +R9rwwNwFbMKxUxBCWO86SOeKzpkTKgPrAfGCxdSubkFuHU1pHii0j2r/xbsr8JAzWCQ
         Q9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130293; x=1718735093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKqRbGm/RW+V6fq9cVwuHYuiNBW4lFAV7W6d0xw6R6M=;
        b=XOSzhVj+8n4j52aA/Dj/GkHVb+RVQDOFU0vq8qqU0mVhFKmHVoYd50wwizE1hmILjG
         WQPDcD/YyF6+SNOush2btzCHko4EBtJpbJpw+U2TLiMSnmYU6fm0duUGjB+Njzooahxl
         h18o7zBsSvMkbFZt3QIQwuHr8tBPfmD7a2QMkuQ/D+0uWndCqeP0PZ52IrvwbCoee+gr
         8shWQ1spAozjIR41Lys4Xenls0DVIrfnnmmRaicMH+x7ofq1mPpnCg4o5qwfS4dH7sO+
         j6FfVHdpHiDkrpk48kadC5kZRNazeGXzLMpGcJKfVNI+CmOrydND7BgXNs28sRX47hQh
         pZZg==
X-Gm-Message-State: AOJu0Yx2StNFypNaho6sN8OD3M2O45mvWZkCuDUM6uzFzjj3hWRhKlMG
	2jZkFx3206ug5K5Y9uFBz/Wf6435p9z1tFy5sAO0EnAMFZp7KThOGRH0Bg==
X-Google-Smtp-Source: AGHT+IF2AFmN76jNhi6Rdm+FY4mbp8+vfH7a8jzqRUvbrxE45X6ZDhNvUz+49NtmGjgTqHfK3QU+8g==
X-Received: by 2002:a2e:9096:0:b0:2eb:1de9:bede with SMTP id 38308e7fff4ca-2eb1de9c5e2mr52514251fa.51.1718130293261;
        Tue, 11 Jun 2024 11:24:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422760ce994sm12242195e9.13.2024.06.11.11.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:52 -0700 (PDT)
Message-Id: <9d0689e9c285b375b0067760929011038c085d65.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:36 +0000
Subject: [PATCH 04/16] update-index: generalize 'read_index_info'
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Move 'read_index_info()' into a new header 'index-info.h' and generalize the
function to call a provided callback for each parsed line. Update
'update-index.c' to use this generalized 'read_index_info()', adding the
callback 'apply_index_info()' to verify the parsed line and update the index
according to its contents.

The input parsing done by 'read_index_info()' is similar to, but more
flexible than, the parsing done in 'mktree' by 'mktree_line()' (handling not
only 'git ls-tree' output but also the outputs of 'git apply --index-info'
and 'git ls-files --stage' outputs). To make 'mktree' more flexible, a later
patch will replace mktree's custom parsing with 'read_index_info()'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Makefile                      |   1 +
 builtin/update-index.c        | 116 ++++++++--------------------------
 index-info.c                  |  91 ++++++++++++++++++++++++++
 index-info.h                  |  11 ++++
 t/t2107-update-index-basic.sh |  27 ++++++++
 5 files changed, 155 insertions(+), 91 deletions(-)
 create mode 100644 index-info.c
 create mode 100644 index-info.h

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
index d343416ae26..77df380cb54 100644
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
@@ -849,6 +779,7 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 	const char *arg, int unset)
 {
 	int *nul_term_line = opt->value;
+	int ret;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
@@ -856,7 +787,10 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
 	allow_add = allow_replace = allow_remove = 1;
-	read_index_info(*nul_term_line);
+	ret = read_index_info(*nul_term_line, apply_index_info, NULL);
+	if (ret)
+		return -1;
+
 	return 0;
 }
 
diff --git a/index-info.c b/index-info.c
new file mode 100644
index 00000000000..0b68e34c361
--- /dev/null
+++ b/index-info.c
@@ -0,0 +1,91 @@
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
+		ret = error("malformed input line '%s'", buf.buf);
+		break;
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
index cc72ead79f3..29696ade0d0 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -142,4 +142,31 @@ test_expect_success '--index-version' '
 	test_must_be_empty actual
 '
 
+test_expect_success '--index-info fails on malformed input' '
+	# empty line
+	echo "" |
+	test_must_fail git update-index --index-info 2>err &&
+	grep "malformed input line" err &&
+
+	# bad whitespace
+	printf "100644 $EMPTY_BLOB A" |
+	test_must_fail git update-index --index-info 2>err &&
+	grep "malformed input line" err &&
+
+	# invalid stage value
+	printf "100644 $EMPTY_BLOB 5\tA" |
+	test_must_fail git update-index --index-info 2>err &&
+	grep "malformed input line" err &&
+
+	# invalid OID length
+	printf "100755 abc123\tA" |
+	test_must_fail git update-index --index-info 2>err &&
+	grep "malformed input line" err &&
+
+	# bad quoting
+	printf "100644 $EMPTY_BLOB\t\"A" |
+	test_must_fail git update-index --index-info 2>err &&
+	grep "bad quoting of path name" err
+'
+
 test_done
-- 
gitgitgadget

