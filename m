Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22C1AA1E4
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672454; cv=none; b=CXIKR/cPoY+XyKFoEKSXOPkqzzOJ5gp3hv7HPlK9Xu/5L4yyYhRtUqKTWuPimbC7ldLpTq47C8rbqGgVU7QAauBUqG3EIQQKJEIL0Hdbkho2ji+aAxzXY6sb5JvytD3mHsPrly3fcyHD08TTeIRpCeQPWSCYp2cm/3+sfsAr4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672454; c=relaxed/simple;
	bh=oMFLmtBYTpXTk8Isckr1bJyoE1dOgyw+CHHnluX6v+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KngYx9hi40cPImUR5StqhhpjlgI0Nxviu7McRMehPp6NPa+/53WeCOVTKrExI1fpIgLRi+qspk19QBByPHQKRZ+rwK6dPW9ekqAlkVHNM3GJlbMUBPqCjyahFZ4MHHMM6mSeqIe0oRp+ZkvDGqFkUf0WDtQZlx43cY3hKAaNAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY8VAlyl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY8VAlyl"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2234daaf269so30456385ad.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 08:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672451; x=1741277251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtS3K8MsJ8h6ADMf9zWtcFvjzC2ofUMuVF9UdYxfBKU=;
        b=kY8VAlyl5r7sajAuBB5Y3alMg2V73IoIUJeN9q4EGg8BebQdEuM1IBCA3QXvxMWEhJ
         5c1jJPgjMPaV4fjnGEZEj0CsSuW6hnQsiR73uY0burZsImmoBaHCg/ibhQTvt/uTmf4g
         //IBubtTw7Kyt8tlneqeNKIB/04r3d5+WJe2fqu5rV3QJkTWK2ONe8wH6cxC1oqJ+6pV
         tHeeozZecSeW1n2qUKcOq6PZdWnqcwCuaJLG45XNGZ+EkiE0aRXVJbISKp0HQ84yNULP
         FS6Aqn+qFohZMKDsWKbB9h5D/VdeLPpmOORjueJHaH7C2iggSuYh+A6SvOnlqpxBxKxg
         GkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672451; x=1741277251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtS3K8MsJ8h6ADMf9zWtcFvjzC2ofUMuVF9UdYxfBKU=;
        b=VT2dXs4Oz2CEBulWqrtNf0Z+t4Uv4tOGD9rmY5MfJl/RlcA/6Tx35Fcsp3z/A2IftR
         rzXr1UzEZ00fJUWu4rDWYVFnm+LEEQAXSA6wmGBDbpRa0rDLpSXJfaJB8RLNeFvDbycB
         8EPfL9J6hhac2txfEToPlN2+NU1IsPITPT7+KArz0Plqm9sr9mepL5PqV/dZtvFP0B9x
         BkLynzB6qKowvY0y09szBs7YiL6HMkyjHeFdAW72VrUfleXIXEM+vpyPfMic4VltykWd
         RzVbRxTTnM2+vKtXU8mYOORAVgHWrTiyUvOltUCrpl0SWBHw09uhaDe2iKrYCH4CduiK
         Vbhg==
X-Gm-Message-State: AOJu0YyGXOGaJdkijbOsXB53yrdXpYL1n73lS+SGY5OcfxPx7F3roYQU
	1ve6GJ0tTEuE2FliJ2z78gc44jJdavG48eIKhcy/Pn3UIZe6tIjgJDxFIw==
X-Gm-Gg: ASbGncvSAjmY9r/ELI233nBsdfAgteuT1KWYNl//a7ypFesLuSCX2GgPnFETHFvdoqU
	YqJH7FbZOV6EN9sgUhCB4njlM7ZgqCErQZ3EEysQSUe4hqPitb3ROeF3X+EGZ3dW5yOiibm0O3h
	ZABIdwrsBxe8VgesKzNgmHpfKWeHy58Tz8ZvOk3lxMf3mWht2iHkqg5SaCuvFxOO7xkY8Mg+kUk
	sglI5RkNK/zJshNSTu79xYc0vXQMraeaoQnRJnji1M15Wh0COfr/FvapK4KbZ5/l8JVP74CEEPG
	sRWuRCjrzXKcniVZy9AVFQ==
X-Google-Smtp-Source: AGHT+IEH24W5qxQ62Er6Ut5PerUtvMfDXD1S4+K1DHzPdOQOsqjgoCqdyy7xadbnj2B9dXDIWSV4MQ==
X-Received: by 2002:a17:903:3ba4:b0:223:5a6e:b10 with SMTP id d9443c01a7336-2235a6e0e8amr28646605ad.27.1740672451108;
        Thu, 27 Feb 2025 08:07:31 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501f9e46sm16715585ad.53.2025.02.27.08.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:07:30 -0800 (PST)
Date: Fri, 28 Feb 2025 00:07:40 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 8/9] packed-backend: check whether the "packed-refs" is
 sorted
Message-ID: <Z8CNzNlWdBN0t0ox@ArchLinux>
References: <Z8CMx7O19PMs9sVY@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8CMx7O19PMs9sVY@ArchLinux>

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
 refs/packed-backend.c          | 116 ++++++++++++++++++++++++++++-----
 t/t0602-reffiles-fsck.sh       |  87 +++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 16 deletions(-)

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
index ef20300fd3..813e5020e4 100644
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
@@ -1957,6 +2037,7 @@ static int packed_fsck(struct ref_store *ref_store,
 	struct packed_ref_store *refs = packed_downcast(ref_store,
 							REF_STORE_READ, "fsck");
 	struct strbuf packed_ref_content = STRBUF_INIT;
+	unsigned int sorted = 0;
 	struct stat st;
 	int ret = 0;
 	int fd = -1;
@@ -2004,8 +2085,11 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	ret = packed_fsck_ref_content(o, ref_store, packed_ref_content.buf,
+	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
 				      packed_ref_content.buf + packed_ref_content.len);
+	if (!ret && sorted)
+		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
+					     packed_ref_content.buf + packed_ref_content.len);
 
 cleanup:
 	if (fd >= 0)
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index a88c792ce1..767e2bd4a0 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -743,4 +743,91 @@ test_expect_success 'packed-refs content should be checked' '
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

