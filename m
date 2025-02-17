Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711EA1494DF
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806090; cv=none; b=kdr/dJ39yotLh6zGn9+I5uTspEt35M5XkW+2xjD2Oi6Xa5EgChimfm+9adTWBjAycrxJMDssKvceZinhUtJROhXLjVfG0ENyH9KnKdoK+YVDN4gzDXWSjCiU5VX7vUT66HOIJaekojSgkHxrBiybR661dVow1G8dp/qJtbg5kdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806090; c=relaxed/simple;
	bh=Qh0YSBHEPeXoUzs3AKbmcG1jcMVVd5IlYWsw2tKo0Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdXK7c5vYeQlpANJGBTFbZh14JC8SYsOAKaseWypU1qz54WTHFj/CDIMKgsZAEOJzunbTVCWacSu649cPwscSDifOmDI8XNQxE6uw1EyjsUgln1eEyAC9cywjtX9qLKglv6xaf8DndLtfjZv6xju0wof6toCSNA8YZACj0yQ9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKuFtiIr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKuFtiIr"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f61b01630so84877215ad.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 07:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739806087; x=1740410887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vW1zpNm8XDfJyLunfLa0a0anS0MrLtVXbN0Ucda3m4Y=;
        b=TKuFtiIrWkcITIFu7VPE2mGLp7j0YNhbFG1cg29M3BFK9HuLlZFhPHvUFyuuiHjki9
         o3qPkDIdl+SzAKOM9RqcAkOFAELZRr/pQcRT+fByaHtuYlTMry2Yrz62FqACH7JEWPdm
         DXKFvuXBmLoUfqh3CFPhf25j5XUuNfDyrULrjGOvmX2gOuMdm+OBsBdIzid2CHm1W6K6
         WDnPfiZ8KWe0iJtbIhAISmZcOEflpvG9RskSOejMhsqpKdgJ9TszNlPuKc4jv1jGMg64
         MBVUnpfj404+4m2BX3p9wwe2U8ob/8Vtwh7tYxxRrs2iD2n1aXBHxK7k4dhzuYQDZYnC
         JlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739806087; x=1740410887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vW1zpNm8XDfJyLunfLa0a0anS0MrLtVXbN0Ucda3m4Y=;
        b=a86S3jQUQlRUjFz/pL2/cmYmKKUCVf7OiquOlJBv5W0qcDnTLLZPO1v94gAY50vjG3
         0SJ/TwkWN+cGmdTGYpuUhCiL4mFo6adyivycbGxy8jS9v4NemB18YiovPS54DlLmeoVk
         WvU4SkYegukbQOAcHLogljy9wyuahP9KO8eaDm2w0RSK/DUtp8UCMKnTnjU/vLF7BXq8
         uzLVV/TRAxVk8IQzkg2NEPTFT88YlA8LUQmkY1ScLDM9GjQGJMDw0r9dmvdT8rJL5iLB
         h2rcL/2N8xK2Z2CdzMN2PIisijYhFi1oynWBVxsPDJsFT8N9NzrbnQnFclrgwnymeqnj
         jmHw==
X-Gm-Message-State: AOJu0Yz6oC4PyrCUMzqkkuNwyaSCq97LBPpbcfqaHstmCv2ZmgXoLwoN
	SpR0lgKmJg6+6HNVhjZW43mPZdWq7CeQI9ixrMEE0CBO4U4gGwv9Fr0F3w==
X-Gm-Gg: ASbGncu375z30+XaFz1BGnNNptRoZtLv7lF+KJbvjy/802GEQpOFrekDxcyvF9aHvFL
	5HbcjUqI7w0KzVnXfptl5xTMTMgtGsyyBTutrMWzH5mcZhtKhnX2pkP3yA5TidntWMjnmHdEvl3
	z/2kgovSNRDhHfe3Ov/R7qArW53Wbv8V35USTgcyBgllzEZIwFIwZGZnNugUcMGIiQ3qHBstAif
	GcoXUq9KmlpELZs5g9pDuBocf04ldH3aSN4O1MorKlIeJwH9ULBZkRFebiVWS7P0AhFXTUJuDSk
	U893f52Y99o=
X-Google-Smtp-Source: AGHT+IHfFofTZmdOo69In4P+XC4awzs665SfsrcSGS19l6P34MiOBAkOIkejPNJvLxgwNjE/iUCNGg==
X-Received: by 2002:a05:6a00:4643:b0:725:f1e9:5334 with SMTP id d2e1a72fcca58-7323c751ab9mr37060224b3a.8.1739806087243;
        Mon, 17 Feb 2025 07:28:07 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73250dd701bsm6703895b3a.131.2025.02.17.07.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:28:06 -0800 (PST)
Date: Mon, 17 Feb 2025 23:28:05 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 6/8] packed-backend: add "packed-refs" entry consistency
 check
Message-ID: <Z7NVhRckykx13PHq@ArchLinux>
References: <Z7NU5fZfc8vfSvZ0@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NU5fZfc8vfSvZ0@ArchLinux>

"packed-backend.c::next_record" will parse the ref entry to check the
consistency. This function has already checked the following things:

1. Parse the main line of the ref entry to inspect whether the oid is
   not correct. Then, check whether the next character is oid. Then
   check the refname.
2. If the next line starts with '^', it would continue to parse the
   peeled oid and check whether the last character is '\n'.

As we decide to implement the ref consistency check for "packed-refs",
let's port these two checks and update the test to exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.adoc |   3 +
 fsck.h                         |   1 +
 refs/packed-backend.c          | 122 ++++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh       |  44 ++++++++++++
 4 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 11906f90fd..02a7bf0503 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -16,6 +16,9 @@
 `badObjectSha1`::
 	(ERROR) An object has a bad sha1.
 
+`badPackedRefEntry`::
+	(ERROR) The "packed-refs" file contains an invalid entry.
+
 `badPackedRefHeader`::
 	(ERROR) The "packed-refs" file contains an invalid
 	header.
diff --git a/fsck.h b/fsck.h
index 67e3c97bc0..14d70f6653 100644
--- a/fsck.h
+++ b/fsck.h
@@ -30,6 +30,7 @@ enum fsck_msg_type {
 	FUNC(BAD_EMAIL, ERROR) \
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
+	FUNC(BAD_PACKED_REF_ENTRY, ERROR) \
 	FUNC(BAD_PACKED_REF_HEADER, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
 	FUNC(BAD_REF_CONTENT, ERROR) \
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 5edd2136bb..c7138aefff 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1812,9 +1812,114 @@ static int packed_fsck_ref_header(struct fsck_options *o,
 	return 0;
 }
 
+static int packed_fsck_ref_peeled_line(struct fsck_options *o,
+				       struct ref_store *ref_store,
+				       unsigned long line_number,
+				       const char *start, const char *eol)
+{
+	struct strbuf packed_entry = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	struct object_id peeled;
+	const char *p;
+	int ret = 0;
+
+	/*
+	 * Skip the '^' and parse the peeled oid.
+	 */
+	start++;
+	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo)) {
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				      "'%.*s' has invalid peeled oid",
+				      (int)(eol - start), start);
+		goto cleanup;
+	}
+
+	if (p != eol) {
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				      "has trailing garbage after peeled oid '%.*s'",
+				      (int)(eol - p), p);
+		goto cleanup;
+	}
+
+cleanup:
+	strbuf_release(&packed_entry);
+	return ret;
+}
+
+static int packed_fsck_ref_main_line(struct fsck_options *o,
+				     struct ref_store *ref_store,
+				     unsigned long line_number,
+				     struct strbuf *refname,
+				     const char *start, const char *eol)
+{
+	struct strbuf packed_entry = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	struct object_id oid;
+	const char *p;
+	int ret = 0;
+
+	if (parse_oid_hex_algop(start, &oid, &p, ref_store->repo->hash_algo)) {
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				      "'%.*s' has invalid oid",
+				      (int)(eol - start), start);
+		goto cleanup;
+	}
+
+	if (p == eol || !isspace(*p)) {
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				      "has no space after oid '%s' but with '%.*s'",
+				      oid_to_hex(&oid), (int)(eol - p), p);
+		goto cleanup;
+	}
+
+	p++;
+	strbuf_reset(refname);
+	strbuf_add(refname, p, eol - p);
+	if (refname_contains_nul(refname)) {
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				      "refname '%s' contains NULL binaries",
+				      refname->buf);
+	}
+
+	if (check_refname_format(refname->buf, 0)) {
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_REF_NAME,
+				      "has bad refname '%s'", refname->buf);
+	}
+
+cleanup:
+	strbuf_release(&packed_entry);
+	return ret;
+}
+
 static int packed_fsck_ref_content(struct fsck_options *o,
+				   struct ref_store *ref_store,
 				   const char *start, const char *eof)
 {
+	struct strbuf refname = STRBUF_INIT;
 	unsigned long line_number = 1;
 	const char *eol;
 	int ret = 0;
@@ -1827,6 +1932,21 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 		line_number++;
 	}
 
+	while (start < eof) {
+		ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
+		ret |= packed_fsck_ref_main_line(o, ref_store, line_number, &refname, start, eol);
+		start = eol + 1;
+		line_number++;
+		if (start < eof && *start == '^') {
+			ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
+			ret |= packed_fsck_ref_peeled_line(o, ref_store, line_number,
+							   start, eol);
+			start = eol + 1;
+			line_number++;
+		}
+	}
+
+	strbuf_release(&refname);
 	return ret;
 }
 
@@ -1892,7 +2012,7 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	ret = packed_fsck_ref_content(o, packed_ref_content.buf,
+	ret = packed_fsck_ref_content(o, ref_store, packed_ref_content.buf,
 				      packed_ref_content.buf + packed_ref_content.len);
 
 cleanup:
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index e055c36e74..7421cc1e7f 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -691,4 +691,48 @@ test_expect_success 'packed-refs unknown traits should not be reported' '
 	)
 '
 
+test_expect_success 'packed-refs content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+		git branch branch-1 &&
+		git branch branch-2 &&
+		git tag -a annotated-tag-1 -m tag-1 &&
+		git tag -a annotated-tag-2 -m tag-2 &&
+
+		branch_1_oid=$(git rev-parse branch-1) &&
+		branch_2_oid=$(git rev-parse branch-2) &&
+		tag_1_oid=$(git rev-parse annotated-tag-1) &&
+		tag_2_oid=$(git rev-parse annotated-tag-2) &&
+		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
+		tag_2_peeled_oid=$(git rev-parse annotated-tag-2^{}) &&
+		short_oid=$(printf "%s" $tag_1_peeled_oid | cut -c 1-4) &&
+
+		cat >.git/packed-refs <<-EOF &&
+		# pack-refs with: peeled fully-peeled sorted
+		$short_oid refs/heads/branch-1
+		${branch_1_oid}x
+		$branch_2_oid   refs/heads/bad-branch
+		$branch_2_oid refs/heads/branch.
+		$tag_1_oid refs/tags/annotated-tag-3
+		^$short_oid
+		$tag_2_oid refs/tags/annotated-tag-4.
+		^$tag_2_peeled_oid garbage
+		EOF
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs line 2: badPackedRefEntry: '\''$short_oid refs/heads/branch-1'\'' has invalid oid
+		error: packed-refs line 3: badPackedRefEntry: has no space after oid '\''$branch_1_oid'\'' but with '\''x'\''
+		error: packed-refs line 4: badRefName: has bad refname '\''  refs/heads/bad-branch'\''
+		error: packed-refs line 5: badRefName: has bad refname '\''refs/heads/branch.'\''
+		error: packed-refs line 7: badPackedRefEntry: '\''$short_oid'\'' has invalid peeled oid
+		error: packed-refs line 8: badRefName: has bad refname '\''refs/tags/annotated-tag-4.'\''
+		error: packed-refs line 9: badPackedRefEntry: has trailing garbage after peeled oid '\'' garbage'\''
+		EOF
+		test_cmp expect err
+	)
+'
+
 test_done
-- 
2.48.1

