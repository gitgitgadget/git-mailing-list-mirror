Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E62690FB
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489729; cv=none; b=PsuVMpohfUNVwvIo2FLhT7v7cGtadH+pF7iXQaotFMH9Dw2g0EhyMRFtKgM8bkA+50O2ZPgCuGStNi4bZoZoh21kfYBd5mOLH86ggY9L+J0+vZifzfZCANp4VM8SnMzT0tWfA80bykX7PUAQaqLqKu07dLnipKJIsm8gzuM1FJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489729; c=relaxed/simple;
	bh=FLawI1IqemeQ0C3qJhwMcQD0vQO/C6K/5LuerCpJOJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKJE9dmUp3HElHQP2EPbCVikEwPI17CgcuoaUzfdyEvrANM3kuYUWBVOx5ugGIAwBke2Tacl8qkXH39EU5Zo1W9NRzEOj54G2ksMWAcxJbfuKMiBL7t1C0TR+Uh3wYwP1EvQ7Vw/ffnTGJJLL3SLGzM4luAeYHblWWWDqeGJoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nslXSsss; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nslXSsss"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc3027c7aeso11101025a91.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 05:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489727; x=1741094527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1BBMBraoYNVNsUG7OjdlmFnM3Vqo840s8IXBSAZAE0=;
        b=nslXSsssRbrX5MkAHXHAB3Heib+2gdN4m4DdsKVVMCdaaNwgeE/oR5ZZSOozVVDjEW
         cMJQ1vHSaqQSch8zOnIYZ6oy3oIw9ufrf0Z5u9Zl0xW7FIR2mlpX/UezEBKwwC5Tykqu
         aLZ5+Fch5VRmm1AD7MKpkxiYv2RooLUYCZfyI07yGxsY2JoDA126c9qpqvZBzKupqBM8
         d68VkpIaPrT4gqtRoJvF9VQTVSjDDpIdV9whudOwi8WaaIuzetGDHr8swLcANZgPWT/Z
         pyJ7dye1HHfBcR/S78EHilrnYurUgMeyG/q+WrBrAQ0qhH0+dcTMzk3eFoQaVy92+5vB
         YO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489727; x=1741094527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1BBMBraoYNVNsUG7OjdlmFnM3Vqo840s8IXBSAZAE0=;
        b=Ncny0U6YOGNAmjWmltOjb4/4zBq+g4jG1bJNgUF2p5IJF37dnhSgNZsafv9vAq+bqB
         yr2WxOP4Js35joPTrFUDLpyc8gmcQIItwrdFYF/5XX6wTN9irQI8tlyn4Rk4YRQmCvOl
         s245Q3pH8PheHd0RqSgeguWRAP04hNiF+l4coku6dNzZOZOFDEhUvtEYa95SjMzKGrhp
         e6BTDIHnyozf4hrIwwNXCFRIHyRGQPPUJYBRvpwZEPLZBfYgcYKptNwRiygU1yBbLOyx
         X8m+pwDJWLUEuvBCvD5+B/2mM29ujXZlvrGswMbkeU6EJNPvbLfp00WXQ+mxukufQuse
         hgpA==
X-Gm-Message-State: AOJu0YyH9skCrvrRnVTfMZOZ4kHQPa+wLarW6TkcWcDIgWJ/Y4ygoc/x
	Cv5YhY9pLPh0zjc5rkblIt0NZxsLK36gjaT70qnfPe2vVYB7Fqzfts8+vg==
X-Gm-Gg: ASbGncuFKaT53KDmm/ZKRJqGcdlJhtouI/iYwdCDGZOzpGUVmR21kf+s1wlaLG/HmmS
	yATapMOFwLkdHblT1lkDTmmR7IuX2k2+7/p292QKgYV2IgJcxYYH9QHj4qciIthfO4yk7JYgCSG
	/KLuszuZdp5O8vbslSz27JkLiOtt3VjcTxV2br9mPNreqsb5zowbtsE5N/vjm4hYbbDcyykxah1
	Nz9p1JfdydRHqERaTPKhy1LJ+/1oCVIkrqeyUY9qUCpcg2zwf/1QEHgLvAGmtqdVTmaxfGsdzcE
	O8neR4IK/2fzTZoxsQnOsQ==
X-Google-Smtp-Source: AGHT+IE22+uZrPAw8nOy3+xHZQtfgNfU671N4bmVkbFXmxYL4FUS09xUdARuUsAQ9wwLy6KivxH3Cg==
X-Received: by 2002:a17:90b:3b88:b0:2ee:c4f2:a76d with SMTP id 98e67ed59e1d1-2fce86d0e7dmr24532803a91.21.1740489726974;
        Tue, 25 Feb 2025 05:22:06 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a0b0dcfsm13664575ad.236.2025.02.25.05.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:22:06 -0800 (PST)
Date: Tue, 25 Feb 2025 21:22:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 8/9] packed-backend: check whether the "packed-refs" is
 sorted
Message-ID: <Z73EBmp3VT1ahS96@ArchLinux>
References: <Z73DTwr9RicKMINe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73DTwr9RicKMINe@ArchLinux>

When there is a "sorted" trait in the header of the "packed-refs" file,
it means that each entry is sorted increasingly by comparing the
refname. We should add checks to verify whether the "packed-refs" is
sorted in this case.

Update the "packed_fsck_ref_header" to know whether there is a "sorted"
trail in the header. It may seem that we could record all refnames
during the parsing process and then compare later. However, this is not
a good design due to the following reasons:

1. Because we need to store the state across the whole checking
   lifetime, we would consume a lot of memory if there are many entries
   in the "packed-refs" file.
2. We cannot reuse the existing compare function "cmp_packed_ref_records"
   which cause repetition.

Because "cmp_packed_ref_records" needs an extra parameter "struct
snaphost", extract the common part into a new function
"cmp_packed_ref_records" to reuse this function to compare.

Then, create a new function "packed_fsck_ref_sorted" to parse the file
again and user the new fsck message "packedRefUnsorted(ERROR)" to report
to the user if the file is not sorted.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.adoc |   3 +
 fsck.h                         |   1 +
 refs/packed-backend.c          | 118 ++++++++++++++++++++++++++++-----
 t/t0602-reffiles-fsck.sh       |  87 ++++++++++++++++++++++++
 4 files changed, 192 insertions(+), 17 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 02a7bf0503..9601fff228 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -187,6 +187,9 @@
 	(ERROR) The "packed-refs" file contains an entry that is
 	not terminated by a newline.
 
+`packedRefUnsorted`::
+	(ERROR) The "packed-refs" file is not sorted.
+
 `refMissingNewline`::
 	(INFO) A loose ref that does not end with newline(LF). As
 	valid implementations of Git never created such a loose ref
diff --git a/fsck.h b/fsck.h
index 14d70f6653..19f3cb2773 100644
--- a/fsck.h
+++ b/fsck.h
@@ -56,6 +56,7 @@ enum fsck_msg_type {
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
 	FUNC(MULTIPLE_AUTHORS, ERROR) \
 	FUNC(PACKED_REF_ENTRY_NOT_TERMINATED, ERROR) \
+	FUNC(PACKED_REF_UNSORTED, ERROR) \
 	FUNC(TREE_NOT_SORTED, ERROR) \
 	FUNC(UNKNOWN_TYPE, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index dd3f7ab255..75f28e283a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -300,14 +300,9 @@ struct snapshot_record {
 	size_t len;
 };
 
-static int cmp_packed_ref_records(const void *v1, const void *v2,
-				  void *cb_data)
-{
-	const struct snapshot *snapshot = cb_data;
-	const struct snapshot_record *e1 = v1, *e2 = v2;
-	const char *r1 = e1->start + snapshot_hexsz(snapshot) + 1;
-	const char *r2 = e2->start + snapshot_hexsz(snapshot) + 1;
 
+static int cmp_packed_refname(const char *r1, const char *r2)
+{
 	while (1) {
 		if (*r1 == '\n')
 			return *r2 == '\n' ? 0 : -1;
@@ -322,6 +317,17 @@ static int cmp_packed_ref_records(const void *v1, const void *v2,
 	}
 }
 
+static int cmp_packed_ref_records(const void *v1, const void *v2,
+				  void *cb_data)
+{
+	const struct snapshot *snapshot = cb_data;
+	const struct snapshot_record *e1 = v1, *e2 = v2;
+	const char *r1 = e1->start + snapshot_hexsz(snapshot) + 1;
+	const char *r2 = e2->start + snapshot_hexsz(snapshot) + 1;
+
+	return cmp_packed_refname(r1, r2);
+}
+
 /*
  * Compare a snapshot record at `rec` to the specified NUL-terminated
  * refname.
@@ -1797,19 +1803,33 @@ static int packed_fsck_ref_next_line(struct fsck_options *o,
 }
 
 static int packed_fsck_ref_header(struct fsck_options *o,
-				  const char *start, const char *eol)
+				  const char *start, const char *eol,
+				  unsigned int *sorted)
 {
-	if (!starts_with(start, "# pack-refs with: ")) {
+	struct string_list traits = STRING_LIST_INIT_NODUP;
+	char *tmp_line;
+	int ret = 0;
+	char *p;
+
+	tmp_line = xmemdupz(start, eol - start);
+	if (!skip_prefix(tmp_line, "# pack-refs with: ", (const char **)&p)) {
 		struct fsck_ref_report report = { 0 };
 		report.path = "packed-refs.header";
 
-		return fsck_report_ref(o, &report,
-				       FSCK_MSG_BAD_PACKED_REF_HEADER,
-				       "'%.*s' does not start with '# pack-refs with: '",
-				       (int)(eol - start), start);
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_HEADER,
+				      "'%.*s' does not start with '# pack-refs with: '",
+				      (int)(eol - start), start);
+		goto cleanup;
 	}
 
-	return 0;
+	string_list_split_in_place(&traits, p, " ", -1);
+	*sorted = unsorted_string_list_has_string(&traits, "sorted");
+
+cleanup:
+	free(tmp_line);
+	string_list_clear(&traits, 0);
+	return ret;
 }
 
 static int packed_fsck_ref_peeled_line(struct fsck_options *o,
@@ -1915,8 +1935,68 @@ static int packed_fsck_ref_main_line(struct fsck_options *o,
 	return ret;
 }
 
+static int packed_fsck_ref_sorted(struct fsck_options *o,
+				  struct ref_store *ref_store,
+				  const char *start, const char *eof)
+{
+	size_t hexsz = ref_store->repo->hash_algo->hexsz;
+	struct strbuf packed_entry = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	struct strbuf refname1 = STRBUF_INIT;
+	struct strbuf refname2 = STRBUF_INIT;
+	unsigned long line_number = 1;
+	const char *former = NULL;
+	const char *current;
+	const char *eol;
+	int ret = 0;
+
+	if (*start == '#') {
+		eol = memchr(start, '\n', eof - start);
+		start = eol + 1;
+		line_number++;
+	}
+
+	for (; start < eof; line_number++, start = eol + 1) {
+		eol = memchr(start, '\n', eof - start);
+
+		if (*start == '^')
+			continue;
+
+		if (!former) {
+			former = start + hexsz + 1;
+			continue;
+		}
+
+		current = start + hexsz + 1;
+		if (cmp_packed_refname(former, current) >= 0) {
+			const char *err_fmt =
+				"refname '%s' is less than previous refname '%s'";
+
+			eol = memchr(former, '\n', eof - former);
+			strbuf_add(&refname1, former, eol - former);
+			eol = memchr(current, '\n', eof - current);
+			strbuf_add(&refname2, current, eol - current);
+
+			strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+			report.path = packed_entry.buf;
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_PACKED_REF_UNSORTED,
+					      err_fmt, refname2.buf, refname1.buf);
+			goto cleanup;
+		}
+		former = current;
+	}
+
+cleanup:
+	strbuf_release(&packed_entry);
+	strbuf_release(&refname1);
+	strbuf_release(&refname2);
+	return ret;
+}
+
 static int packed_fsck_ref_content(struct fsck_options *o,
 				   struct ref_store *ref_store,
+				   unsigned int *sorted,
 				   const char *start, const char *eof)
 {
 	struct strbuf refname = STRBUF_INIT;
@@ -1926,7 +2006,7 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 
 	ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
 	if (*start == '#') {
-		ret |= packed_fsck_ref_header(o, start, eol);
+		ret |= packed_fsck_ref_header(o, start, eol, sorted);
 
 		start = eol + 1;
 		line_number++;
@@ -1957,9 +2037,10 @@ static int packed_fsck(struct ref_store *ref_store,
 	struct packed_ref_store *refs = packed_downcast(ref_store,
 							REF_STORE_READ, "fsck");
 	struct strbuf packed_ref_content = STRBUF_INIT;
+	unsigned int sorted = 0;
 	struct stat st;
-	int fd;
 	int ret = 0;
+	int fd;
 
 	if (!is_main_worktree(wt))
 		goto cleanup;
@@ -2012,8 +2093,11 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	ret = packed_fsck_ref_content(o, ref_store, packed_ref_content.buf,
+	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
 				      packed_ref_content.buf + packed_ref_content.len);
+	if (!ret && sorted)
+		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
+					     packed_ref_content.buf + packed_ref_content.len);
 
 cleanup:
 	strbuf_release(&packed_ref_content);
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 7421cc1e7f..28dc8dcddc 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -735,4 +735,91 @@ test_expect_success 'packed-refs content should be checked' '
 	)
 '
 
+test_expect_success 'packed-ref with sorted trait should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+		git branch branch-1 &&
+		git branch branch-2 &&
+		git tag -a annotated-tag-1 -m tag-1 &&
+		branch_1_oid=$(git rev-parse branch-1) &&
+		branch_2_oid=$(git rev-parse branch-2) &&
+		tag_1_oid=$(git rev-parse annotated-tag-1) &&
+		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
+		refname1="refs/heads/main" &&
+		refname2="refs/heads/foo" &&
+		refname3="refs/tags/foo" &&
+
+		cat >.git/packed-refs <<-EOF &&
+		# pack-refs with: peeled fully-peeled sorted
+		EOF
+		git refs verify 2>err &&
+		rm .git/packed-refs &&
+		test_must_be_empty err &&
+
+		cat >.git/packed-refs <<-EOF &&
+		# pack-refs with: peeled fully-peeled sorted
+		$branch_2_oid $refname1
+		EOF
+		git refs verify 2>err &&
+		rm .git/packed-refs &&
+		test_must_be_empty err &&
+
+		cat >.git/packed-refs <<-EOF &&
+		# pack-refs with: peeled fully-peeled sorted
+		$branch_2_oid $refname1
+		$branch_1_oid $refname2
+		$tag_1_oid $refname3
+		EOF
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs line 3: packedRefUnsorted: refname '\''$refname2'\'' is less than previous refname '\''$refname1'\''
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err &&
+
+		cat >.git/packed-refs <<-EOF &&
+		# pack-refs with: peeled fully-peeled sorted
+		$tag_1_oid $refname3
+		^$tag_1_peeled_oid
+		$branch_2_oid $refname2
+		EOF
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs line 4: packedRefUnsorted: refname '\''$refname2'\'' is less than previous refname '\''$refname3'\''
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'packed-ref without sorted trait should not be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+		git branch branch-1 &&
+		git branch branch-2 &&
+		git tag -a annotated-tag-1 -m tag-1 &&
+		branch_1_oid=$(git rev-parse branch-1) &&
+		branch_2_oid=$(git rev-parse branch-2) &&
+		tag_1_oid=$(git rev-parse annotated-tag-1) &&
+		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
+		refname1="refs/heads/main" &&
+		refname2="refs/heads/foo" &&
+		refname3="refs/tags/foo" &&
+
+		cat >.git/packed-refs <<-EOF &&
+		# pack-refs with: peeled fully-peeled
+		$branch_2_oid $refname1
+		$branch_1_oid $refname2
+		EOF
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
 test_done
-- 
2.48.1

