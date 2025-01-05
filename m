Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E831EA80
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736085040; cv=none; b=Ax6lLIe47s14myvNqBsimX7X6Qgfb7sjHjSfrGMJ24r7y4wjKGtENaYEKC7yxMe7PT6h/u8nERLc1wmSDvYpfNLVuPRvpQKF40H7IZZIp2ccyoQnzP4Ceu80apN2/I2vzJyUb5ltmMpPNNWA1yi8885VvRrNIWagTByb8RFD/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736085040; c=relaxed/simple;
	bh=VvRxamiKwuKPhhV8sNfkQ8WSiJCGSXgZ5ZL8Rycyloc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4AoVVxOuWqx/fZ/BQtQx7X9nlffr3G4FykWKZBoTJqnTEnuSr/tbFScleDMxRG3N0HLb2F9ECH7oS+WaVf5jwfrUVaClMLS/D42bPfn1MiYRuujWakTbxYyMKkT6VXpIMNheprVPkUgU3gS2AAIC2b0bCe7a6jL6nApbPKdlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hnf1TClo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnf1TClo"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso15200051a91.2
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 05:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736085038; x=1736689838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxGuNZP1trsHqydU8+fTfXhvbua/VZ9m1ONmU6l+Mwg=;
        b=Hnf1TCloC/XviX0yhq+d7PM9bSBf6OfJ0pz6xZ+VLEt4MPgmzTIKAF+cdUbnCQe5kY
         Bq+CE8oTVXXSxzwa+lDcG2KDvmlqtPDE05lZcnhzCVt5Le4dYgwv/ppOQpeaw3ZiZrSn
         mqNZFHDWs0ngq5DhncYDRdoGzDOpIly9J8Kf933PCVZc95bZWLkTIlTRywr8bValZeV2
         HxdhfDyly99ON6K6aUmQsVKJQfVMI646Mvp/rNMFYHpNSldORmmPANK2dUlE9ppNIK9u
         nRXAZ1Qpdrg7VrkurBZyujQsfwC0d6pesuDGsbypVwwNaUFJt3yss4k+hgRits9aiBbp
         ZepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736085038; x=1736689838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxGuNZP1trsHqydU8+fTfXhvbua/VZ9m1ONmU6l+Mwg=;
        b=u5qp9MlpbB7sqwRpWSE/fsckK6SOwfYXKuxaGr4eTd7TtLlImALcErxycDVU54Ogla
         w63EuhfFd2xcRzUgproQIG57odzMYNN9Z77orTHJWtNQwUkIkdxWu3WUe6EfVz7dkdAV
         Buwt2P08zrqSgJQzgLpjbE0lQVDNoI+kQaZLnykhNEN6FKBsSd1D//QMBuUdQ+lSaizR
         wpxPAdnA6DOb+wLxk+HxYzYRZDyY11Gm0Ix1sJBKrBvcU42AGWeQOF3kF5VdsTyuqxcF
         D1g8KjGBJZ39Vg6ZYMJqFDru8mKAk0Hjs9VUMac5FOoNPFBr1jFXgrOgkwl4Bhz/o8An
         alBg==
X-Gm-Message-State: AOJu0YyCy7h13GTnl/c703t4VkBB45D24+p/1STn1UPljzS40ad78m6g
	hhFLzmvpLH+IXeryhx/zafUDZhvilpxwHkwMqq/fbGjBl4/LYN2DrWsUGw==
X-Gm-Gg: ASbGncslJLSjcRh5sJgyEBmKatV0s3hFRB2g8m8IksPiGXcUZoWk9Jq0/MBQeEQfkNr
	b72PTjntfWkq7QddqQJ0loDR/QtqfLhbvmin5vJMT490ubFPB0+LAO/kk2A5UNbczZ7apfz/ndq
	vLCzuLzRYH0XUS3sEz4sYcIZHh68bpEpkJNJa+JAZNMWDoVFfY+BjE7T12u9NMNInklktiPaTys
	2Cauuei6nMctF+KMbbm4QVa7RPh9nLSfbQ=
X-Google-Smtp-Source: AGHT+IFXgTDEMoKqqpty65Z/gTYCIrLl7VWKbDcOHN1+AmTw8Wpap1BDDLP7EfCGvfy9V31ko9oxww==
X-Received: by 2002:a17:90b:2d44:b0:2ee:df57:b194 with SMTP id 98e67ed59e1d1-2f452e3c70amr74177858a91.21.1736085038128;
        Sun, 05 Jan 2025 05:50:38 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4be2b1f43sm13987109a91.17.2025.01.05.05.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 05:50:36 -0800 (PST)
Date: Sun, 5 Jan 2025 21:50:31 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/10] packed-backend: check whether the "packed-refs" is
 sorted
Message-ID: <Z3qOJ_ixuoE4yTut@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qNUizvHJLgMx1y@ArchLinux>

We will always try to sort the "packed-refs" increasingly by comparing
the refname. So, we should add checks to verify whether the "packed-refs"
is sorted.

It may seem that we could add a new "struct strbuf refname" into the
"struct fsck_packed_ref_entry" and during the parsing process, we could
store the refname into the entry and then we could compare later.
However, this is not a good design due to the following reasons:

1. Because we need to store the state across the whole checking
   lifetime, we would consume a lot of memory if there are many entries
   in the "packed-refs" file.
2. The most important is that we cannot reuse the existing compare
   functions which cause repetition.

So, instead of storing the "struct strbuf", let's use the existing
structure "struct snaphost_record". And thus we could use the existing
function "cmp_packed_ref_records".

However, this function need an extra parameter for "struct snaphost".
Extract the common part into a new function "cmp_packed_ref_records" to
reuse this function to compare.

Then, create a new function "packed_fsck_ref_sorted" to use the new fsck
message "packedRefUnsorted(ERROR)" to report to the user.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  3 ++
 fsck.h                        |  1 +
 refs/packed-backend.c         | 78 ++++++++++++++++++++++++++++++-----
 t/t0602-reffiles-fsck.sh      | 40 ++++++++++++++++++
 4 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 2a7ec7592e..7a11d35c5e 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -190,6 +190,9 @@
 `packedRefMissingHeader`::
 	(INFO) The "packed-refs" file does not contain the header.
 
+`packedRefUnsorted`::
+	(ERROR) The "packed-refs" file is not sorted.
+
 `refMissingNewline`::
 	(INFO) A loose ref that does not end with newline(LF). As
 	valid implementations of Git never created such a loose ref
diff --git a/fsck.h b/fsck.h
index 4fca304b72..1be7402eb9 100644
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
index d83ce2838f..df65fec5a5 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -300,14 +300,8 @@ struct snapshot_record {
 	size_t len;
 };
 
-static int cmp_packed_ref_records(const void *v1, const void *v2,
-				  void *cb_data)
+static int cmp_packed_refname(const char *r1, const char *r2)
 {
-	const struct snapshot *snapshot = cb_data;
-	const struct snapshot_record *e1 = v1, *e2 = v2;
-	const char *r1 = e1->start + snapshot_hexsz(snapshot) + 1;
-	const char *r2 = e2->start + snapshot_hexsz(snapshot) + 1;
-
 	while (1) {
 		if (*r1 == '\n')
 			return *r2 == '\n' ? 0 : -1;
@@ -322,6 +316,17 @@ static int cmp_packed_ref_records(const void *v1, const void *v2,
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
@@ -1775,13 +1780,17 @@ struct fsck_packed_ref_entry {
 	int has_peeled;
 	struct object_id oid;
 	struct object_id peeled;
+
+	struct snapshot_record record;
 };
 
-static struct fsck_packed_ref_entry *create_fsck_packed_ref_entry(int line_number)
+static struct fsck_packed_ref_entry *create_fsck_packed_ref_entry(int line_number,
+								  const char *start)
 {
 	struct fsck_packed_ref_entry *entry = xcalloc(1, sizeof(*entry));
 	entry->line_number = line_number;
 	entry->has_peeled = 0;
+	entry->record.start = start;
 	return entry;
 }
 
@@ -1980,6 +1989,50 @@ static int packed_fsck_ref_oid(struct fsck_options *o, struct ref_store *ref_sto
 	return ret;
 }
 
+static int packed_fsck_ref_sorted(struct fsck_options *o,
+				  struct ref_store *ref_store,
+				  struct fsck_packed_ref_entry **entries,
+				  int nr)
+{
+	size_t hexsz = ref_store->repo->hash_algo->hexsz;
+	struct strbuf packed_entry = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	struct strbuf refname1 = STRBUF_INIT;
+	struct strbuf refname2 = STRBUF_INIT;
+	int ret = 0;
+
+	for (int i = 1; i < nr; i++) {
+		const char *r1 = entries[i - 1]->record.start + hexsz + 1;
+		const char *r2 = entries[i]->record.start + hexsz + 1;
+
+		if (cmp_packed_refname(r1, r2) >= 0) {
+			const char *err_fmt =
+				"refname '%s' is not less than next refname '%s'";
+			const char *eol;
+			eol = memchr(entries[i - 1]->record.start, '\n',
+				     entries[i - 1]->record.len);
+			strbuf_add(&refname1, r1, eol - r1);
+			eol = memchr(entries[i]->record.start, '\n',
+				     entries[i]->record.len);
+			strbuf_add(&refname2, r2, eol - r2);
+
+			strbuf_addf(&packed_entry, "packed-refs line %d",
+				    entries[i - 1]->line_number);
+			report.path = packed_entry.buf;
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_PACKED_REF_UNSORTED,
+					      err_fmt, refname1.buf, refname2.buf);
+			goto cleanup;
+		}
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
 				   const char *start, const char *eof)
@@ -2009,7 +2062,7 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 	ALLOC_ARRAY(entries, entry_alloc);
 	while (start < eof) {
 		struct fsck_packed_ref_entry *entry
-			= create_fsck_packed_ref_entry(line_number);
+			= create_fsck_packed_ref_entry(line_number, start);
 		ALLOC_GROW(entries, entry_nr + 1, entry_alloc);
 		entries[entry_nr++] = entry;
 
@@ -2025,16 +2078,19 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 			start = eol + 1;
 			line_number++;
 		}
+		entry->record.len = start - entry->record.start;
 	}
 
 	/*
 	 * If there is anything wrong during the parsing of the "packed-refs"
 	 * file, we should not check the object of the refs.
 	 */
-	if (ret)
+	if (ret) {
 		o->safe_object_check = 0;
-	else
+	} else {
 		ret |= packed_fsck_ref_oid(o, ref_store, entries, entry_nr);
+		ret |= packed_fsck_ref_sorted(o, ref_store, entries, entry_nr);
+	}
 
 	free_fsck_packed_ref_entries(entries, entry_nr);
 	return ret;
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index faa7c80356..800a19e4e6 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -765,4 +765,44 @@ test_expect_success 'packed-refs objects should be checked' '
 	done
 '
 
+test_expect_success 'packed-ref sorted should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cd repo &&
+	test_commit default &&
+	git branch branch-1 &&
+	git branch branch-2 &&
+	git tag -a annotated-tag-1 -m tag-1 &&
+
+	branch_1_oid=$(git rev-parse branch-1) &&
+	branch_2_oid=$(git rev-parse branch-2) &&
+	tag_1_oid=$(git rev-parse annotated-tag-1) &&
+	tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
+
+	refname1="refs/heads/main" &&
+	refname2="refs/heads/foo" &&
+	refname3="refs/tags/foo" &&
+
+	printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
+	printf "%s %s\n" "$branch_2_oid" "$refname1" >>.git/packed-refs &&
+	printf "%s %s\n" "$branch_1_oid" "$refname2" >>.git/packed-refs &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: packed-refs line 2: packedRefUnsorted: refname '\''$refname1'\'' is not less than next refname '\''$refname2'\''
+	EOF
+	rm .git/packed-refs &&
+	test_cmp expect err &&
+
+	printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
+	printf "%s %s\n" "$tag_1_oid" "$refname3" >>.git/packed-refs &&
+	printf "^%s\n" "$tag_1_peeled_oid" >>.git/packed-refs &&
+	printf "%s %s\n" "$branch_2_oid" "$refname2" >>.git/packed-refs &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: packed-refs line 2: packedRefUnsorted: refname '\''$refname3'\'' is not less than next refname '\''$refname2'\''
+	EOF
+	rm .git/packed-refs &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.47.1

