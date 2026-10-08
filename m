Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6283D171C
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791492507; cv=none; b=JRInWF+ZteeqTwxCmDFBFPrdw6uoD16v4sd6FHAuf6qTH+HGPuwQAughaDRb2VZ1lVJV3oyDl9eyaldqe4bDI1rSpOwUG7vLf1xUng4bydLZrLkIlxNn2TUpRm9MKBB3RBiTRHBrOHQWg2dz1WBH3S7TkZ3Hi+fNGV2FeZ8jWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791492507; c=relaxed/simple;
	bh=Pmhgm3fshMPk7/lExuPcdj9yOFLDWKxYIEJ9fdQ8a70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjTidBYYaUMWKNFgA12J+0X4FcuXYcQzyR2N5+vO61PucqZaL/HE3uooOE4asR3KkpbSQMwJKae8KKAWhHWXt/HLonboZTNkoFDB8LtcqekXjHwbmYzDVoiE7DSMpor9yhvPgLhtpUN/VzwVmCZ5A1H9mB00oDwaN24YoliEBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws/Mc5R0; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws/Mc5R0"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33e623bd651so205379eec.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791492505; x=1792097305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gT9mohBo4Ae/WFSElwYmpqnniu1xe2PN2DuHIbwp7jo=;
        b=Ws/Mc5R05O6YV1av1FbW1Mcl8goIj3u4Lh/rWZoOp4nSS2hxDWFjlp8gefgQ8oNZfz
         kuqXDDwJs2j4I4eb+zAJOIkc+iUggAABFsJsx1WHwom7jGqx3bOllfFSixS86gNNfGZW
         aip3hDX1swRXvEFWAuclf28cOujiM36q2PrXQw2H9mWqoQpTMz28aLbDnEV98uV03Wgm
         w+CVHL+wptR9o8gdi/bqkwaT1261DILQzoal08UZoU5pLuGO9teqarA1qFynUHEC3Xru
         ltCNYt6IjFbfaIKjKl+7eClBTL/zdqLTf4dUsWaMTs7wpqYaJZ/4+AoFPck5VTy+6lA3
         SOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791492505; x=1792097305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gT9mohBo4Ae/WFSElwYmpqnniu1xe2PN2DuHIbwp7jo=;
        b=QLqQKaAHoEpEmiDyJyBDJSm6FL4rAZFumJth2NzvUf4XR6iMmQe9GseIzNrvavL09I
         yVRoFv4tGy5TlQMSL384b494Sk9oeXeF06WzZNmj4A7JrHjd++r1HLev7DqQAozaZfuC
         h+VlBOYzInojvgtnwnFJls8Jv6hSfdv9G9MpEvZmLabGc3Ff7meo4gv/IOMdoMVZ+qTp
         P3fhtgd43OEWhqVZy6U4hKhV9pHJzynVYHnikV/TwHxEFBvkr9huzQ8fDC9wZXvcfavb
         CfXzZ1ZXODziL0Q+uM++7IcD6G7TqEO03Hlzik+WZZnc/a7QEDZruwtimX2cVPhlHD8D
         NuHQ==
X-Gm-Message-State: AFq9FYKn0PkSiawrLuunok68zkv/P9M2U7MK0vLKNq5aDEzwfufduY+A
	V0yNEOOPIjOt+INIQhgqdmuzUeO226SFGaTq2ATAXP4EqjlMxJY7452+Phs4fg==
X-Gm-Gg: AYBFou02nC5BFXIHZ4y7fjAlVW51CwbbjEUKjHWc1xq6ygEm7i7QtIf6h7yzsbbbK1u
	lxfDZiyxWBlQWUOPD6WTxuC7sxwSYrvHezcfvI3RvtZPGvRA5FbjuhHz1nnDlNUZO95sqspJTZ4
	dZ8xEk+14NvnUb8qUE4hcX6dQFVdqrAnaYy3MTrnXmr9uaylJMxriDnswnVqaa5H3hhcqRetdSO
	QqFGES1YjkaAS7V3ZYjMOhAnxXmt0bCh2MDdzZJC0dS9xpOUM3qg99URXRAdRlEiqOWe5cBIY0h
	bn88SEoa+gcefg9H7Y+TbNUjGZ74kWbpnxUcUeKazlBginw3fd14Y2kOgBttoBKEeLS3zAApUYn
	1oDm2NZLCguV4rcaHjBmVujGVmaKZ95SY083AQdHE6K8XvNA/LfDCu8L9Wb2PVEx0yf6rC8i+tG
	J5jDFHZgwxRpxFUBHZPCP1dxoqhfXJDVgeyHsimWuIhIMuTgpxht/ifajUUHsix698sFqEL5AoF
	H9VzsNDUhiHnnSMm+MlDZ4F8V3N17Eez7KudHxLXK/W0nM4CY83xvzaifVk
X-Received: by 2002:a05:7301:7e01:b0:351:8cd9:7a53 with SMTP id 5a478bee46e88-3537dc98f7bmr134955eec.0.1791492505148;
        Thu, 08 Oct 2026 13:48:25 -0700 (PDT)
Received: from WF-A7VVAKE ([2605:a601:9a29:ec00:9c8c:3311:1812:c51c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm433930eec.28.2026.10.08.13.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:48:24 -0700 (PDT)
From: Curtis Allen Smith <curtis.allen.smith@gmail.com>
To: git@vger.kernel.org
Cc: Curtis Allen Smith <curtis.allen.smith@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 1/2] read-cache: do not trust a size change when conversion is active
Date: Thu,  8 Oct 2026 14:45:03 -0600
Message-ID: <20261008204603.1988-2-curtis.allen.smith@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.1
In-Reply-To: <20261008204603.1988-1-curtis.allen.smith@gmail.com>
References: <20261008204603.1988-1-curtis.allen.smith@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git status" can report a file as modified while "git diff" and
"git add", which both run the clean filter, agree its contents are
unchanged:

	git init t && cd t
	printf '* text eol=lf\n' >.gitattributes
	printf 'one\ntwo\nthree\n' >file.txt
	git add . && git commit -m init

	printf 'one\r\ntwo\r\nthree\r\n' >file.txt

	git status --short      # ->  M file.txt
	git diff                # -> empty
	git add file.txt        # -> stages nothing

Three commands that answer the same question answer it differently,
and the two that consult the conversion are the ones that get it
right.

ie_modified() declares a path modified as soon as ie_match_stat()
reports DATA_CHANGED, which it does whenever the size of the file in
the working tree differs from the size recorded in the index, and it
returns without ever reading the file.  That shortcut is sound only
while the working tree file and the blob are the same bytes.  When it
was written in 2005 they were, and a size mismatch really was a proof
of a content change.  Conversion removed that premise: core.autocrlf
arrived in 2007 and the "text" and "eol" attributes in 2010, and
making the two representations differ in their bytes while agreeing on
their content is precisely what they are for.  The shortcut was never
re-examined against the feature layered on top of it.

The same function already handles the comparable case correctly.  When
only the mtime changed, it falls through to ce_modified_check_fs(),
reads the file, applies the conversion, and answers "unchanged" when
that is the truth.  Git is therefore already willing to pay for a
conversion-aware check here; the size branch is the only place where a
difference in the bytes on disk is taken to be a difference in
content.

So fall through to that same check when the size changed and the path
is subject to conversion.  Paths without conversion take the early
return exactly as before, and a repository that uses no conversion is
unaffected.

Hashing is the expensive part of that check -- Git's collision
detecting SHA-1 runs at about 800 MB/s on the machine used below --
and it is avoidable most of the time.  Contents that are equal
necessarily have equal length, so ce_compare_data() now compares the
length of the converted file against the size of the blob, which costs
an object header lookup, and hashes only when the two agree.  A file
that was really edited almost always changes length and is rejected
without being hashed.  The file this commit is about has exactly the
length of its blob, so it is hashed, found equal, and the index then
records its new size, after which it is not read again.

When the end-of-line conversion is the only one that applies, even
the conversion can be skipped.  "git add" either keeps such a file as
it is or turns each CRLF into LF, so the converted length is one of
two numbers, and a scan for CR gives both.  If neither is the size of
the blob, the file is modified, and it is neither converted nor
hashed.

In a repository of 200 files of 1 MB each under "* text=auto" with
every file modified, these take "git status" from 517ms to 26ms; with
10000 files of 2.6 KB, from 142ms to 49ms.

The inconsistency is a chronic annoyance for anyone sharing a tree
between Windows and Unix with normalized line endings.  Any tool that
rewrites unchanged files in native line endings -- javadoc, code
generators, formatters, a good number of editors -- changes the size
of every file it touches and flags the whole output tree as modified
with empty diffs.  The documented remedy, "git add --renormalize",
does not stick: the next checkout, stash or branch switch rewrites the
checkout-form bytes and the recorded sizes along with them, and the
next run of the tool flags everything again.

Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
---
 read-cache.c    | 129 ++++++++++++++++++++++++++++++++++++++++++++++--
 t/t0020-crlf.sh |  45 +++++++++++++++++
 2 files changed, 171 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c4cf08a3a..8875706d8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -9,6 +9,7 @@
 
 #include "git-compat-util.h"
 #include "config.h"
+#include "convert.h"
 #include "date.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -228,6 +229,99 @@ int fake_lstat(const struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
+/*
+ * Count the CRs in "buf" that are immediately followed by an LF.
+ */
+static size_t count_crlf(const char *buf, size_t len)
+{
+	const char *end = buf + len;
+	size_t n = 0;
+
+	while ((buf = memchr(buf, '\r', end - buf))) {
+		if (++buf < end && *buf == '\n')
+			n++;
+	}
+	return n;
+}
+
+/*
+ * Compare an open file to the blob recorded for it, converting the file
+ * the way "git add" would.  Contents that are equal necessarily have
+ * equal length, so when the converted length differs from the size of
+ * the blob the file is modified and there is no need to hash it, and
+ * hashing is by far the most expensive part of this comparison.
+ *
+ * Only the case this can help is handled here: a regular file whose
+ * conversion Git performs itself.  A path driven by an external filter
+ * is left to index_fd(), which streams it into the filter.
+ *
+ * Returns 1 if the file differs, 0 if it matches, -1 if it could not be
+ * read.  Does not close "fd".
+ */
+static int ce_compare_converted_data(struct index_state *istate,
+				     const struct cache_entry *ce,
+				     struct stat *st, int fd)
+{
+	struct strbuf raw = STRBUF_INIT;
+	struct strbuf converted = STRBUF_INIT;
+	struct object_info oi = OBJECT_INFO_INIT;
+	struct object_id oid;
+	struct conv_attrs ca;
+	enum object_type type;
+	size_t blob_size;
+	const char *buf;
+	size_t len;
+	int have_size, match = -1;
+
+	oi.typep = &type;
+	oi.sizep = &blob_size;
+	have_size = (odb_read_object_info_extended(istate->repo->objects,
+						   &ce->oid, &oi,
+						   OBJECT_INFO_SKIP_FETCH_OBJECT |
+						   OBJECT_INFO_QUICK) == ODB_READ_OK &&
+		     type == OBJ_BLOB);
+
+	if (strbuf_read(&raw, fd, st->st_size) < 0)
+		goto out;
+
+	/*
+	 * When the end-of-line conversion is the only one, "git add"
+	 * either keeps the file as it is or turns every CRLF into LF
+	 * ("text=auto" refuses to convert a file with a lone CR, so
+	 * stripping all CRs comes to the same thing).  The converted
+	 * length is therefore one of two values, and if neither is the
+	 * size of the blob the file is modified without converting it.
+	 */
+	convert_attrs(istate, &ca, ce->name);
+	if (have_size && !ca.drv && !ca.ident &&
+	    !ca.working_tree_encoding &&
+	    raw.len != blob_size &&
+	    raw.len - count_crlf(raw.buf, raw.len) != blob_size) {
+		match = 1;
+		goto out;
+	}
+
+	buf = raw.buf;
+	len = raw.len;
+	if (convert_to_git(istate, ce->name, raw.buf, raw.len, &converted, 0)) {
+		buf = converted.buf;
+		len = converted.len;
+	}
+
+	if (have_size && len != blob_size) {
+		match = 1;
+		goto out;
+	}
+
+	hash_object_file(istate->repo->hash_algo, buf, len, OBJ_BLOB, &oid);
+	match = !oideq(&oid, &ce->oid);
+
+out:
+	strbuf_release(&raw);
+	strbuf_release(&converted);
+	return match;
+}
+
 static int ce_compare_data(struct index_state *istate,
 			   const struct cache_entry *ce,
 			   struct stat *st)
@@ -237,9 +331,16 @@ static int ce_compare_data(struct index_state *istate,
 
 	if (fd >= 0) {
 		struct object_id oid;
-		if (!index_fd(istate, &oid, fd, st, OBJ_BLOB, ce->name, 0))
+
+		if (S_ISREG(st->st_mode) &&
+		    would_convert_to_git(istate, ce->name) &&
+		    !would_convert_to_git_filter_fd(istate, ce->name)) {
+			match = ce_compare_converted_data(istate, ce, st, fd);
+			close(fd);
+		} else if (!index_fd(istate, &oid, fd, st, OBJ_BLOB, ce->name, 0)) {
 			match = !oideq(&oid, &ce->oid);
-		/* index_fd() closed the file descriptor already */
+			/* index_fd() closed the file descriptor already */
+		}
 	}
 	return match;
 }
@@ -438,6 +539,27 @@ int ie_match_stat(struct index_state *istate,
 	return changed;
 }
 
+/*
+ * A difference between the size of the file in the working tree and the
+ * size recorded for it in the index proves that the contents changed
+ * only as long as the two are byte-for-byte comparable.  That stops
+ * being true as soon as the path is run through a clean filter:
+ * rewriting a file with CRLF endings under "text eol=lf", for example,
+ * changes its size in the working tree without changing the blob Git
+ * would record for it.  For such a path the only way to tell is to read
+ * the contents and convert them, which is what we already do when only
+ * the mtime changed.
+ */
+static int size_change_is_conclusive(struct index_state *istate,
+				     const struct cache_entry *ce,
+				     struct stat *st)
+{
+	if (!S_ISREG(st->st_mode))
+		return 1;
+
+	return !would_convert_to_git(istate, ce->name);
+}
+
 int ie_modified(struct index_state *istate,
 		const struct cache_entry *ce,
 		struct stat *st, unsigned int options)
@@ -480,7 +602,8 @@ int ie_modified(struct index_state *istate,
 	     */
 	    (!S_ISLNK(st->st_mode) || ce->ce_stat_data.sd_size != MAX_PATH) &&
 #endif
-	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0))
+	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0) &&
+	    size_change_is_conclusive(istate, ce, st))
 		return changed;
 
 	changed_fs = ce_modified_check_fs(istate, ce, st);
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index fd1cae09e..88b728d50 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -397,4 +397,49 @@ test_expect_success 'New CRLF file gets LF in repo' '
 	test_cmp alllf alllf2
 '
 
+test_expect_success 'status does not report a CRLF-only rewrite as modified' '
+	git init eol-status &&
+	(
+		cd eol-status &&
+		echo "* text eol=lf" >.gitattributes &&
+		printf "one\ntwo\nthree\n" >file.txt &&
+		git add .gitattributes file.txt &&
+		git commit -m initial &&
+
+		# a generator rewrites the file with CRLF, same content
+		printf "one\r\ntwo\r\nthree\r\n" >file.txt &&
+		git status --porcelain -uno >actual &&
+		test_must_be_empty actual &&
+		git diff --exit-code &&
+
+		# a real change is still reported
+		printf "one\r\ntwo\r\nfour\r\n" >file.txt &&
+		git status --porcelain -uno >actual &&
+		echo " M file.txt" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'status sizes a text file by its CRLF pairs, not its CRs' '
+	git init eol-status-lone-cr &&
+	(
+		cd eol-status-lone-cr &&
+		echo "* text eol=lf" >.gitattributes &&
+		printf "one\rtwo\nthree\n" >file.txt &&
+		git add .gitattributes file.txt &&
+		git commit -m initial &&
+
+		# "git add" keeps the lone CR and drops the others
+		printf "one\rtwo\r\nthree\r\n" >file.txt &&
+		git status --porcelain -uno >actual &&
+		test_must_be_empty actual &&
+
+		# the converted length matches the blob, the content does not
+		printf "one\rtwo\nthrEE\r\n" >file.txt &&
+		git status --porcelain -uno >actual &&
+		echo " M file.txt" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.53.0

