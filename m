Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977967581F
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130301; cv=none; b=Yw0xjWB4czS3RJkW9Q+vzdYEVWv7GT2/u5PDFBARKws6nuWzyoDmV1OFxn7JG4eAAlbtSrmsNs0uxg8vidbeHydmmNDknawBkNVGOCQq4a/FSoys5dTicmEnnlmeUtIkP362awj4Un7N3MyAetLwky77yLtJpVrkhO7h6ZhqEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130301; c=relaxed/simple;
	bh=bCBK4+Mj0szw2NZ/CD7kOc6CzbtdIpdljoCW0GoTyMg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KnDrVlg6HifmM9oYz2lNLZg+FD4of/sYvvLJmC9vfaOOfsJAwNf0CHZHLLu9taWogFC6tJMoBd0G+64a82Cg1JzPlwblfytU8zBITqJry+ffsrspqO4tR4+BQg86byyaBhT9LGr8Xij8Te38eQW5BPlqLXiSRxIfF4ek3+Z9KUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/9kjle6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/9kjle6"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35f2d723ef0so876681f8f.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130295; x=1718735095; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WUpad7JaJbJFbFg5yzlOkze/LhAKbg5r2VoNW+B2vY=;
        b=Q/9kjle6PWEIfhpbopPcd5YuNfyHQRH+9eWtLJHJk6M3b47anOJ5V8OOr5HrWD7cFg
         GtdBTykv7c7Wab/8FjiEsRTs8dbWLjNasibBYbypbzN3gkvhKXhnFv5X/9tVgutrabqT
         ifRhS6suaVFEO0cLbWdBvI4m4c5wl/XTzqvDN7kRcZUqFcJ3kjKB/hAdz0IoFqgliSne
         PN3GLLYakgz2XC9XynrRYvjTxFRLcHTKFBOxUWq+jKtYa+s2iEROozBVbeLg9qF8R/yh
         XS2eYPy7z/2wi+e7pqHSUaTTZpI32oJS6SiPI2OZWtlysgZy18hDTclVoN2Tbc8CjKDo
         BYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130295; x=1718735095;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WUpad7JaJbJFbFg5yzlOkze/LhAKbg5r2VoNW+B2vY=;
        b=lyc0v9jFH4KZt/d43I7v5ZZPSp6VNrhCepaN+pgAJEuTjwDy0xUe0HBPNw8CpsWkik
         PPmciwUuNBF1EWw2vOxKMQHHi/LTMw35CGvi7UwdGnDfHqTlEZtmd9pBjqzhVzIUCcod
         Vw1qJJmyIFW/qPZLunYzDYxegyCzFuW0rD3trvdG5Ry8Uaq3D5y9UCR0PbvuMJoRwrJG
         5bwRIkR8StqO9X5aT0Ob6G1rQDIQMzeiT7XX/3J99toTwKnzQh1070JAhGtr7mFevwgm
         wIVdupxL0aaJ+HITw9BaY2WDu8AQOV2MLzdJ/+WYRTo2CKMGdm3TuTHxQUFzzlL39doU
         XQlg==
X-Gm-Message-State: AOJu0YzVc9HK8xXJuPmjl7qGr44F78TjyPURR7KC2QdtU72sHx1sVMA4
	g9+9jpHP5oRq994i4SC3Y6IiMjh6yzPm0ZvVLbmztOQz7fQxJCuhugdZEA==
X-Google-Smtp-Source: AGHT+IFqZrNT45Oujnwtb7d1n47DFC0epvXSKTHBSUrmCgHETaObRxuvArC+HQCh/bRbeVLLoB7aWg==
X-Received: by 2002:a5d:554f:0:b0:35f:1c9b:ff06 with SMTP id ffacd0b85a97d-35f1c9bffdamr5640977f8f.56.1718130295459;
        Tue, 11 Jun 2024 11:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f27600519sm4976505f8f.32.2024.06.11.11.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:55 -0700 (PDT)
Message-Id: <8d1e1eaa70b96779416f2f48a862d31a730c4521.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:39 +0000
Subject: [PATCH 07/16] mktree: use read_index_info to read stdin lines
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

Replace the custom input parsing of 'mktree' with 'read_index_info()', which
handles not only the 'ls-tree' output format it already handles but also the
other formats compatible with 'update-index'. This lends some consistency
across the commands (avoiding the need for two similar implementations for
input parsing) and adds flexibility to mktree.

Update 'Documentation/git-mktree.txt' to reflect the more permissive input
format.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-mktree.txt |  17 +++--
 builtin/mktree.c             | 139 ++++++++++++-----------------------
 t/t1010-mktree.sh            |  66 +++++++++++++++++
 3 files changed, 125 insertions(+), 97 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 383f09dd333..507682ed23e 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -3,7 +3,7 @@ git-mktree(1)
 
 NAME
 ----
-git-mktree - Build a tree-object from ls-tree formatted text
+git-mktree - Build a tree-object from formatted tree entries
 
 
 SYNOPSIS
@@ -13,15 +13,13 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads standard input in non-recursive `ls-tree` output format, and creates
-a tree object.  The order of the tree entries is normalized by mktree so
-pre-sorting the input is not required.  The object name of the tree object
-built is written to the standard output.
+Reads entry information from stdin and creates a tree object from those entries.
+The object name of the tree object built is written to the standard output.
 
 OPTIONS
 -------
 -z::
-	Read the NUL-terminated `ls-tree -z` output instead.
+	Input lines are separated with NUL rather than LF.
 
 --missing::
 	Allow missing objects.  The default behaviour (without this option)
@@ -35,6 +33,13 @@ OPTIONS
 	optional.  Note - if the `-z` option is used, lines are terminated
 	with NUL.
 
+INPUT FORMAT
+------------
+Tree entries may be specified in any of the formats compatible with the
+`--index-info` option to linkgit:git-update-index[1]. The order of the tree
+entries is normalized by `mktree` so pre-sorting the input by path is not
+required.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 15bd908702a..5530257252d 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -6,6 +6,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
+#include "index-info.h"
 #include "quote.h"
 #include "strbuf.h"
 #include "tree.h"
@@ -93,123 +94,80 @@ static const char *mktree_usage[] = {
 	NULL
 };
 
-static void mktree_line(char *buf, int nul_term_line, int allow_missing,
-			struct tree_entry_array *arr)
+struct mktree_line_data {
+	struct tree_entry_array *arr;
+	int allow_missing;
+};
+
+static int mktree_line(unsigned int mode, struct object_id *oid,
+		       enum object_type obj_type, int stage UNUSED,
+		       const char *path, void *cbdata)
 {
-	char *ptr, *ntr;
-	const char *p;
-	unsigned mode;
-	enum object_type mode_type; /* object type derived from mode */
-	enum object_type obj_type; /* object type derived from sha */
+	struct mktree_line_data *data = cbdata;
+	enum object_type mode_type = object_type(mode);
 	struct object_info oi = OBJECT_INFO_INIT;
-	char *path, *to_free = NULL;
-	struct object_id oid;
+	enum object_type parsed_obj_type;
 
-	ptr = buf;
-	/*
-	 * Read non-recursive ls-tree output format:
-	 *     mode SP type SP sha1 TAB name
-	 */
-	mode = strtoul(ptr, &ntr, 8);
-	if (ptr == ntr || !ntr || *ntr != ' ')
-		die("input format error: %s", buf);
-	ptr = ntr + 1; /* type */
-	ntr = strchr(ptr, ' ');
-	if (!ntr || parse_oid_hex(ntr + 1, &oid, &p) ||
-	    *p != '\t')
-		die("input format error: %s", buf);
-
-	/* It is perfectly normal if we do not have a commit from a submodule */
-	if (S_ISGITLINK(mode))
-		allow_missing = 1;
-
-
-	*ntr++ = 0; /* now at the beginning of SHA1 */
-
-	path = (char *)p + 1;  /* at the beginning of name */
-	if (!nul_term_line && path[0] == '"') {
-		struct strbuf p_uq = STRBUF_INIT;
-		if (unquote_c_style(&p_uq, path, NULL))
-			die("invalid quoting");
-		path = to_free = strbuf_detach(&p_uq, NULL);
-	}
+	if (obj_type && mode_type != obj_type)
+		die("object type (%s) doesn't match mode type (%s)",
+		    type_name(obj_type), type_name(mode_type));
 
-	/*
-	 * Object type is redundantly derivable three ways.
-	 * These should all agree.
-	 */
-	mode_type = object_type(mode);
-	if (mode_type != type_from_string(ptr)) {
-		die("entry '%s' object type (%s) doesn't match mode type (%s)",
-			path, ptr, type_name(mode_type));
-	}
+	oi.typep = &parsed_obj_type;
 
-	/* Check the type of object identified by oid without fetching objects */
-	oi.typep = &obj_type;
-	if (oid_object_info_extended(the_repository, &oid, &oi,
+	if (oid_object_info_extended(the_repository, oid, &oi,
 				     OBJECT_INFO_LOOKUP_REPLACE |
 				     OBJECT_INFO_QUICK |
 				     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
-		obj_type = -1;
+		parsed_obj_type = -1;
 
-	if (obj_type < 0) {
-		if (allow_missing) {
-			; /* no problem - missing objects are presumed to be of the right type */
+	if (parsed_obj_type < 0) {
+		if (data->allow_missing || S_ISGITLINK(mode)) {
+			; /* no problem - missing objects & submodules are presumed to be of the right type */
 		} else {
-			die("entry '%s' object %s is unavailable", path, oid_to_hex(&oid));
-		}
-	} else {
-		if (obj_type != mode_type) {
-			/*
-			 * The object exists but is of the wrong type.
-			 * This is a problem regardless of allow_missing
-			 * because the new tree entry will never be correct.
-			 */
-			die("entry '%s' object %s is a %s but specified type was (%s)",
-				path, oid_to_hex(&oid), type_name(obj_type), type_name(mode_type));
+			die("entry '%s' object %s is unavailable", path, oid_to_hex(oid));
 		}
+	} else if (parsed_obj_type != mode_type) {
+		/*
+		 * The object exists but is of the wrong type.
+		 * This is a problem regardless of allow_missing
+		 * because the new tree entry will never be correct.
+		 */
+		die("entry '%s' object %s is a %s but specified type was (%s)",
+		    path, oid_to_hex(oid), type_name(parsed_obj_type), type_name(mode_type));
 	}
 
-	append_to_tree(mode, &oid, path, arr);
-	free(to_free);
+	append_to_tree(mode, oid, path, data->arr);
+	return 0;
 }
 
 int cmd_mktree(int ac, const char **av, const char *prefix)
 {
-	struct strbuf sb = STRBUF_INIT;
 	struct object_id oid;
 	int nul_term_line = 0;
-	int allow_missing = 0;
 	int is_batch_mode = 0;
-	int got_eof = 0;
 	struct tree_entry_array arr = { 0 };
-	strbuf_getline_fn getline_fn;
+	struct mktree_line_data mktree_line_data = { .arr = &arr };
+	int ret;
 
 	const struct option option[] = {
 		OPT_BOOL('z', NULL, &nul_term_line, N_("input is NUL terminated")),
-		OPT_BOOL(0, "missing", &allow_missing, N_("allow missing objects")),
+		OPT_BOOL(0, "missing", &mktree_line_data.allow_missing, N_("allow missing objects")),
 		OPT_BOOL(0, "batch", &is_batch_mode, N_("allow creation of more than one tree")),
 		OPT_END()
 	};
 
 	ac = parse_options(ac, av, prefix, option, mktree_usage, 0);
-	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
-
-	while (!got_eof) {
-		while (1) {
-			if (getline_fn(&sb, stdin) == EOF) {
-				got_eof = 1;
-				break;
-			}
-			if (sb.buf[0] == '\0') {
-				/* empty lines denote tree boundaries in batch mode */
-				if (is_batch_mode)
-					break;
-				die("input format error: (blank line only valid in batch mode)");
-			}
-			mktree_line(sb.buf, nul_term_line, allow_missing, &arr);
-		}
-		if (is_batch_mode && got_eof && arr.nr < 1) {
+
+	do {
+		ret = read_index_info(nul_term_line, mktree_line, &mktree_line_data);
+		if (ret < 0)
+			break;
+
+		/* empty lines denote tree boundaries in batch mode */
+		if (ret > 0 && !is_batch_mode)
+			die("input format error: (blank line only valid in batch mode)");
+
+		if (is_batch_mode && !ret && arr.nr < 1) {
 			/*
 			 * Execution gets here if the last tree entry is terminated with a
 			 * new-line.  The final new-line has been made optional to be
@@ -222,9 +180,8 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 			fflush(stdout);
 		}
 		clear_tree_entry_array(&arr); /* reset tree entry buffer for re-use in batch mode */
-	}
+	} while (ret > 0);
 
 	release_tree_entry_array(&arr);
-	strbuf_release(&sb);
-	return 0;
+	return !!ret;
 }
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 22875ba598c..9b2ab0c97ad 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -54,11 +54,36 @@ test_expect_success 'ls-tree output in wrong order given to mktree (2)' '
 	test_cmp tree.withsub actual
 '
 
+test_expect_success '--batch creates multiple trees' '
+	cat top >multi-tree &&
+	echo "" >>multi-tree &&
+	cat top.withsub >>multi-tree &&
+
+	cat tree >expect &&
+	cat tree.withsub >>expect &&
+	git mktree --batch <multi-tree >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'allow missing object with --missing' '
 	git mktree --missing <top.missing >actual &&
 	test_cmp tree.missing actual
 '
 
+test_expect_success 'mktree with invalid submodule OIDs' '
+	# non-existent OID - ok
+	printf "160000 commit $(test_oid numeric)\tA\n" >in &&
+	git mktree <in >tree.actual &&
+	git ls-tree $(cat tree.actual) >actual &&
+	test_cmp in actual &&
+
+	# existing OID, wrong type - error
+	tree_oid="$(cat tree)" &&
+	printf "160000 commit $tree_oid\tA" |
+	test_must_fail git mktree 2>err &&
+	grep "object $tree_oid is a tree but specified type was (commit)" err
+'
+
 test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
 	test_must_fail git mktree <all
 '
@@ -67,4 +92,45 @@ test_expect_success 'mktree refuses to read ls-tree -r output (2)' '
 	test_must_fail git mktree <all.withsub
 '
 
+test_expect_success 'mktree fails on malformed input' '
+	# empty line without --batch
+	echo "" |
+	test_must_fail git mktree 2>err &&
+	grep "blank line only valid in batch mode" err &&
+
+	# bad whitespace
+	printf "100644 blob $EMPTY_BLOB A" |
+	test_must_fail git mktree 2>err &&
+	grep "malformed input line" err &&
+
+	# invalid type
+	printf "100644 bad $EMPTY_BLOB\tA" |
+	test_must_fail git mktree 2>err &&
+	grep "invalid object type" err &&
+
+	# invalid OID length
+	printf "100755 blob abc123\tA" |
+	test_must_fail git mktree 2>err &&
+	grep "malformed input line" err &&
+
+	# bad quoting
+	printf "100644 blob $EMPTY_BLOB\t\"A" |
+	test_must_fail git mktree 2>err &&
+	grep "bad quoting of path name" err
+'
+
+test_expect_success 'mktree fails on mode mismatch' '
+	tree_oid="$(cat tree)" &&
+
+	# mode-type mismatch
+	printf "100644 tree $tree_oid\tA" |
+	test_must_fail git mktree 2>err &&
+	grep "object type (tree) doesn${SQ}t match mode type (blob)" err &&
+
+	# mode-object mismatch (no --missing)
+	printf "100644 $tree_oid\tA" |
+	test_must_fail git mktree 2>err &&
+	grep "object $tree_oid is a tree but specified type was (blob)" err
+'
+
 test_done
-- 
gitgitgadget

