Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441322071
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739509174; cv=none; b=kc2iKmvYTMhaJmA61MgotPKoZ3z6xyq5mC7BKMZEmPeZaLr+Xlq9fwxu8pAffuzIpyTco7MgM6BH3QqsCTYtsjJbohoyShjWvdu1eT+mrFgYXwKFfqTc+82cq4/2JMKgQbQuvph3AaurJavUqIxxWqe5udsDD4SXk0L71UVRpes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739509174; c=relaxed/simple;
	bh=GyRDBQRu8dqqQsFxIEBdlzUpxxgK4m9X0l9krBfTdr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glk9qovcBDor1H/q5q0vfu4O3WFRugc0pFwGKM6OiwZZ4pTC0u+4RmCtWVvG+gKaUG/6/NgzombTNsN/WtbJcb5+2070ylzEZ/e4D4ivefkrShJyWjijMu2fZnaawK7CLpkvgrONbOzc2kXk6ecvQJfMkHWKS3+MjPNpi/h9pu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+MY5kOL; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+MY5kOL"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fb2a6360efso12277797b3.0
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739509171; x=1740113971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgoFDMJFqLrwpEy5c7lw++17FKEsQAjW/XXdnX8ba/g=;
        b=K+MY5kOLddLCTq3w+rn78QoH76K2esY2zySBO3H3G53dpeA8INCqiRX+11oR5ZEkIN
         zL889UkaAckEH2Kjp6FwXHmOkR2no3s6szMr/kvPWxEz+BPMt8XsanlFwEP44tpZo1Jo
         ScrW5ngaj6LxKgZZ7QZ5l+CNBAkbF9JGY7lMXgjdV/2stcfiIiu+nK5o6U3wo6SyrGAu
         lDZ+kyqp1MVzBEgmtSfFvBIDHH+l2Cg8NCUEt19al/b4QWZD0uln4hQz5lN3a6K7SvKv
         BXd/A6OEgylJBs1/GpeRYka+JgMxzM6a1Vqiun3/JpPm3asXD2VDwRyiuAjw18cYb14j
         K/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739509171; x=1740113971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgoFDMJFqLrwpEy5c7lw++17FKEsQAjW/XXdnX8ba/g=;
        b=OWxGtw19TbAvfDaJ1f2OlDT4IYZNKCnVN8jCxRe8JXt8gSfj530qc6cnGVxgxvVfQ/
         cryaQ7+1Gjs4fyOl/GWm0FtMKqi5ZLbZv3UjUIFfmVv6cfL3+Q8e8Z3UyO/lvjd7t+e2
         4sM1fiA5LFfiQQanMvfIJxk30iAZB7Ml6CR4BSW5HHXyc/7a4pTuDvErUISZ52rrYQmG
         7+D6gbVUPua7mVmuWTmScp6dofg8CDvbdypKCZVBPh8B4p/QCwr8/9Nmnx5vhNHsRLYg
         LOCM6YAEXZEBR5RVX5W9D2P0b3EA8LvQNiuJ0kCP0BQ7qE2i2YyrkgKJggcGtQZxwzEr
         fgEg==
X-Gm-Message-State: AOJu0YwYkSZTo+8Kd+c49+MtFpzQrlKmSJipPpXNxHx0+SRFjnTeR421
	I5pS0JgIRqp/4JEv8i5ueiuXLY7+Z/FiPztkkY6BeegWP/6vU60cWGibXr4W
X-Gm-Gg: ASbGncurmA1qc3wTBMLMYX6LSCgWY2vx2Zsa3VMaz/jRVeNqTG+MXCVPKf77sFEUABd
	0mj2HohJc5qdF8/l8erjs4epCtiNxyYDhCfAKeIO0RXsVJKRR5twlt+3nLGO2vrxaYNlOfP64p5
	zaot/rJcS40e9Xv2+1IEFjepQP1Ijb5DF9Rs7opKc9PNajj28qg2X/4mRNmU51bbV9Pq5ao30tT
	xkq8csfe8zfwo+8ZNDRIY/MK/HAWBe1SKvg3+gKofgiWEdKxB3D/toRuCulm+EMDhUORg==
X-Google-Smtp-Source: AGHT+IH7Jb2q8eVxkdCP+hFSHXhMW/nuae/OBIncmB6CwZtPzP/iPe9WxVZxkApHUQ1wXy2yKpySjw==
X-Received: by 2002:a05:6902:1107:b0:e57:3a77:99b9 with SMTP id 3f1490d57ef6-e5da04b35a1mr7754278276.41.1739509170717;
        Thu, 13 Feb 2025 20:59:30 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e5dadeca97bsm789537276.32.2025.02.13.20.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:59:29 -0800 (PST)
Date: Fri, 14 Feb 2025 12:59:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 7/8] packed-backend: check whether the "packed-refs" is
 sorted
Message-ID: <Z67NrPT9j5C6pzP8@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z67LkxAFIAeaYr0U@ArchLinux>

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
 Documentation/fsck-msgids.txt |   3 +
 fsck.h                        |   1 +
 refs/packed-backend.c         | 116 +++++++++++++++++++++++++++++-----
 t/t0602-reffiles-fsck.sh      |  87 +++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 16 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 02a7bf0503..9601fff228 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
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
index 5d1dcfec6f..391efced54 100644
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
@@ -1914,8 +1934,68 @@ static int packed_fsck_ref_main_line(struct fsck_options *o,
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
@@ -1925,7 +2005,7 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 
 	ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
 	if (*start == '#') {
-		ret |= packed_fsck_ref_header(o, start, eol);
+		ret |= packed_fsck_ref_header(o, start, eol, sorted);
 
 		start = eol + 1;
 		line_number++;
@@ -1956,6 +2036,7 @@ static int packed_fsck(struct ref_store *ref_store,
 	struct packed_ref_store *refs = packed_downcast(ref_store,
 							REF_STORE_READ, "fsck");
 	struct strbuf packed_ref_content = STRBUF_INIT;
+	unsigned int sorted = 0;
 	int ret = 0;
 	int fd;
 
@@ -1992,8 +2073,11 @@ static int packed_fsck(struct ref_store *ref_store,
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
index 058a783cb7..f305428f12 100755
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

