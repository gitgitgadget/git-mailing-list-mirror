Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E70D2FB
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 04:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738209989; cv=none; b=BonWJWk2lk/KJbXvwNXl2P7MP0LA2SnAPnUWFeF3ZEr9bX8imxgzK5Bwy6JGeXAyFksdtP+tMw6MMUzxfe+AlNvQF5S6LG89u82oNvO9/jHpWrcmFmJXZVSfzhOKn1bMRlyxTuR0iI359mROntlLy3ewpQci2hU66vXX305Xu2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738209989; c=relaxed/simple;
	bh=5KydgSDNSFGJGhWACXwjH3/gwtzRk9KeT7dcjPeL3kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJzSOUcayzBTE6svFhZ3euZmohRHwiHzdxcH7a6+14jsOOPFVFc83V2WFFN5U49vQLMDcXIjrUUOIx3S1DluLe5Kjaqi1ovt5gztlT74SDxhX2gMZBINtwm+fRjgi+6/Q1K3P9SM2jZ24mSkh5v44Bp81+65Ml/c4zOhFhIoMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YISn+S/h; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YISn+S/h"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so5912055ad.0
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738209986; x=1738814786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1MEYpqdY2b8II3p/oeipdjqI0geKxZFR3eUllLO6lA=;
        b=YISn+S/hB0bk64xkvPuC7BmqAP8MIrCoX0X0c0w2vf+1ZGCyYmT6KQCDPSvAuCPUnL
         uBI3gvFAI2OVwY9y61S+l4e7KA/pH3766EL9lHLnET5HCYZlGTLzztCxyUYPfpJDss/9
         ehclT6+FvS6uVb6q+WpHAjQIVteNHLm8KxmhDuwRkbXjgLdlgwkNHQa1oopgfPI4FFUF
         4HebWdTqxZOc+PjC7GhPVVTR6Ik5n2hwtKnaK4ewjCEQRJEBb5QLVbzS25zcXI4PHkmI
         5XPrsqecU/Qzxh9NfWbDS332uRIWG/Q7OWMNxG9gyiQbOjgcAC2DJJNFuKy0pIfgO4oy
         PYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738209986; x=1738814786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1MEYpqdY2b8II3p/oeipdjqI0geKxZFR3eUllLO6lA=;
        b=RSjfg+U3+R/zyhOKHoz83yH569PqnTVJAG1Yf0xw804ef3d+4q7oN/21u1h0poL9Q5
         FtQPsxsaC1+huk9Pdv315nScjUa3AYxRMY4ufVeMi29DcJakBayJ1PrBM8AhITcj8gEU
         Q4MscjKBKHdm9k9Bt4hrLq385u0oA3xeptAVIz/ykvvOH/URJvBYRzFkeCPHB/Q+NqPK
         STa+o9cZnX6crn9DmjcychhhuC4mylmDV56o/5nSL6iaryD/n6vdRoHpa/EQE45BQlrT
         2J5vYn81aOSRMBYXWJJpBP9SrCHZBPBdV074UCSVhDCiGgrYCdsarC8VrBrXIDzTCE2O
         LnJg==
X-Gm-Message-State: AOJu0Yzqs7rCrlybCyq0SytLnSm4n2tyCBNB8Qn8epsvNCF/W9wL/AIA
	M5cAmrQr/Kl9He9nYt3hPzl6ihu+jS7Wbygd/MrsB0XURElUEpKRkkelGuDA
X-Gm-Gg: ASbGncvdFOrRsCZMt4vL5dzjvdRD26b++QWZBsSMb5GJLHX2fsNOJpIUlnFSDP+5fdn
	8b0yAWXF33TOr9j5FfZOd+gCgViUm/G89FyreQR0TvUncGnK8+rUExibyBB/cgX3yC/Ux5RyYuT
	JYa6ShNU9aMMAzVceC6G13uc2wa+Gv8p+y8D4EVT/pqWHInA2kZWVfa0J7oBkFSVhWakYxsbsIY
	NRYZrrqiT6wnm66wGuK+bTuRUmP0/P8wJD4p/krgQiK2a0REh+OsvpDhW5iznMForckpw==
X-Google-Smtp-Source: AGHT+IHQUYhU91WlwaVB2oFWpyxmMSZfSlQXOBvuXz3K4XtV/r+y8F8I3uUXtH38i+Zozq6fOqfSuA==
X-Received: by 2002:a17:902:c409:b0:215:5935:7eef with SMTP id d9443c01a7336-21dd7d78cafmr93711785ad.22.1738209986427;
        Wed, 29 Jan 2025 20:06:26 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-acebb3414a4sm349556a12.0.2025.01.29.20.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 20:06:25 -0800 (PST)
Date: Thu, 30 Jan 2025 12:07:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 6/8] packed-backend: add "packed-refs" entry consistency
 check
Message-ID: <Z5r7Hlk_VS0jYU74@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5r6ZnLH3Ee8IQnN@ArchLinux>

"packed-backend.c::next_record" will parse the ref entry to check the
consistency. This function has already checked the following things:

1. Parse the main line of the ref entry, if the oid is not correct. It
   will die the program. And then it will check whether the next
   character of the oid is space. Then it will check whether the refname
   is correct.
2. If the next line starts with '^', it will continue to parse the oid
   of the peeled oid content and check whether the last character is
   '\n'.

We can iterate each line by using the "packed_fsck_ref_next_line"
function. Then, create a new fsck message "badPackedRefEntry(ERROR)" to
report to the user when something is wrong.

Create two new functions "packed_fsck_ref_main_line" and
"packed_fsck_ref_peeled_line" for case 1 and case 2 respectively. Last,
update the unit test to exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  3 ++
 fsck.h                        |  1 +
 refs/packed-backend.c         | 98 ++++++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh      | 42 +++++++++++++++
 4 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 34375a3143..2a7ec7592e 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
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
index 3107a0093d..40126242a4 100644
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
index 870c8e7aaa..271c740728 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1819,10 +1819,86 @@ static int packed_fsck_ref_header(struct fsck_options *o, const char *start, con
 	return 0;
 }
 
+static int packed_fsck_ref_peeled_line(struct fsck_options *o,
+				       struct ref_store *ref_store,
+				       struct strbuf *packed_entry,
+				       const char *start, const char *eol)
+{
+	struct fsck_ref_report report = { 0 };
+	struct object_id peeled;
+	const char *p;
+
+	report.path = packed_entry->buf;
+
+	start++;
+	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo)) {
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "'%.*s' has invalid peeled oid",
+				       (int)(eol - start), start);
+	}
+
+	if (p != eol) {
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "has trailing garbage after peeled oid '%.*s'",
+				       (int)(eol - p), p);
+	}
+
+	return 0;
+}
+
+static int packed_fsck_ref_main_line(struct fsck_options *o,
+				     struct ref_store *ref_store,
+				     struct strbuf *packed_entry,
+				     struct strbuf *refname,
+				     const char *start, const char *eol)
+{
+	struct fsck_ref_report report = { 0 };
+	struct object_id oid;
+	const char *p;
+
+	report.path = packed_entry->buf;
+
+	if (parse_oid_hex_algop(start, &oid, &p, ref_store->repo->hash_algo)) {
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "'%.*s' has invalid oid",
+				       (int)(eol - start), start);
+	}
+
+	if (p == eol || !isspace(*p)) {
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "has no space after oid '%s' but with '%.*s'",
+				       oid_to_hex(&oid), (int)(eol - p), p);
+	}
+
+	p++;
+	strbuf_reset(refname);
+	strbuf_add(refname, p, eol - p);
+	if (refname_contains_nul(refname)) {
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "refname '%s' contains NULL binaries",
+				       refname->buf);
+	}
+
+	if (check_refname_format(refname->buf, 0)) {
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_REF_NAME,
+				       "has bad refname '%s'", refname->buf);
+	}
+
+	return 0;
+}
+
 static int packed_fsck_ref_content(struct fsck_options *o,
+				   struct ref_store *ref_store,
 				   const char *start, const char *eof)
 {
 	struct strbuf packed_entry = STRBUF_INIT;
+	struct strbuf refname = STRBUF_INIT;
 	int line_number = 1;
 	const char *eol;
 	int ret = 0;
@@ -1843,6 +1919,26 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 				       "missing header line");
 	}
 
+	while (start < eof) {
+		strbuf_reset(&packed_entry);
+		strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
+		ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
+		ret |= packed_fsck_ref_main_line(o, ref_store, &packed_entry, &refname, start, eol);
+		start = eol + 1;
+		line_number++;
+		if (start < eof && *start == '^') {
+			strbuf_reset(&packed_entry);
+			strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
+			ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
+			ret |= packed_fsck_ref_peeled_line(o, ref_store, &packed_entry,
+							   start, eol);
+			start = eol + 1;
+			line_number++;
+		}
+	}
+
+	strbuf_release(&packed_entry);
+	strbuf_release(&refname);
 	strbuf_release(&packed_entry);
 	return ret;
 }
@@ -1890,7 +1986,7 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	ret = packed_fsck_ref_content(o, packed_ref_content.buf,
+	ret = packed_fsck_ref_content(o, ref_store, packed_ref_content.buf,
 				      packed_ref_content.buf + packed_ref_content.len);
 
 cleanup:
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index a7b46b6cb9..e4b4a58684 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -685,4 +685,46 @@ test_expect_success 'packed-refs header should be checked' '
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
+		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
+		printf "%s\n" "$short_oid refs/heads/branch-1" >>.git/packed-refs &&
+		printf "%sx\n" "$branch_1_oid" >>.git/packed-refs &&
+		printf "%s   refs/heads/bad-branch\n" "$branch_2_oid" >>.git/packed-refs &&
+		printf "%s refs/heads/branch.\n" "$branch_2_oid" >>.git/packed-refs &&
+		printf "%s refs/tags/annotated-tag-3\n" "$tag_1_oid" >>.git/packed-refs &&
+		printf "^%s\n" "$short_oid" >>.git/packed-refs &&
+		printf "%s refs/tags/annotated-tag-4.\n" "$tag_2_oid" >>.git/packed-refs &&
+		printf "^%s garbage\n" "$tag_2_peeled_oid" >>.git/packed-refs &&
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

