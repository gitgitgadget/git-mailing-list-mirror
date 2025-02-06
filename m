Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A951F60A
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821483; cv=none; b=pEu/b+FwWoF+s6X+T04OWDpwEhonGDVvB/BrNku0x6DKJLoMWMy9TObYghLcp9Y3YCc+sda/Y0kiOiLrriTK+wnzrow2cse62Qkw9bIZoU/4Fm2cj01teAyOOUTeozE723WPeh/XiSyhiC8U3/HAOcd5vdaFFUUyAa7ferX47yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821483; c=relaxed/simple;
	bh=zY+FQ25a97zTdGt9/RkWu2Nt2ZD1SMg5KaTyMqO0wDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvN8yaLrZk9n9R63tAHBAKaVBbGjlLJiPLa4INWBwodVFNIolg+pTUZ8GwerEpALnnAEzlxuzgqZldE/fkXWJcq7m8UYIo5X+jh7R6bmOlnbRmzYh2bGuPmI70QBsml2kh4ManOJDk0YRKff9adnpqOMZXDEQ+RtF/SJ0gKQ3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imbrvRRW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imbrvRRW"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f42992f608so718056a91.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 21:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738821480; x=1739426280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tMypgULqhjYOPFr4x7VBSGXLenm5Qf+EYmP6BmvI/Y=;
        b=imbrvRRWjXDGwNtVdqPsMgmhCCTtFHzjxT0jbuSsAVz4zZaYm6BtNH/bEwL0QTdq1S
         woawbgZG1HfRiAcjteu0nrp3ToJcVlfj84+w2FilwaYxWazxoOV8wo+/ZxB9RWykXsQv
         ycRigrRABK//0+Sa+CZaG3rpmCt9KOJksZk27mVFAXUnGSAZm3PoKp76dLCBTg1sdcC/
         PlnekUNxi7ZdRlTnpRSrkycvCafOhiicsLfqR3HR7RuoWdcbb/3SIWSnz0B0qNvmP0z3
         +DIDXxt/VhbDErFcq9kfHXOR2UocOnAtlIbrbnks4qSU47KXK96i/8Tt5kxcIZgxPDPu
         rJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821480; x=1739426280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tMypgULqhjYOPFr4x7VBSGXLenm5Qf+EYmP6BmvI/Y=;
        b=tDmX02w2Z5SnbUQM66fpQka+BWkcKysgQWjd02tG8Br2xu6BTmbI2GInYT18LV/SVZ
         Ecgbldeq25dmjG46E102FZySsc0LPdLOaZp5aWVF4fEJBweeXAGvyKMdSelQyntZPbMw
         Nl4UrnpJowoh/Jx6/qs1494Jl8qETGSU+kwYr7YqsJtYkBq853oc2MF1wifgShmY9oRb
         vVNm6l3/YgKF35pJxSgkJuyUHnhvKNIxry58WPsw2LJYCkDVxEqXAVm+D0+27VdFbjCQ
         iTa9TahSTJtXaQo+ra/Xmn3MnXaMpZUdywEyQEjWXtBe/5B2y2/VL7ByNvMt8d9XozYb
         PBgw==
X-Gm-Message-State: AOJu0Yx4Y7a0/Po3OKbgAJH6Waro2YobYHn7ZrUhoDq1btyCZSDg+Rt0
	v8Dmi/CQX/h2Z1o4ouIVXviISJAXPj2S4H9PvkMCx54ISfhmGuevomQ6Fg==
X-Gm-Gg: ASbGncsLEZGtHmeIfbmXG323rZq1mPTHW847UXI3TXflyPYR4gS2C8mNS2J9lDY96gf
	0LhwNqMU+iexb3lmO/uAfUniXmpTD6ULFgEFgy/NjAq+35ymyOrqWzkz15Y0s0hyS9FmRpvGXln
	lh1vz3EAZkngPSNNiLrp9HJY1cJ091/jp7XeckXxvNY81SazVHwsus3teZo+JGEAc0cWhXzguwP
	qlJnjnCorvmwYWsNM5/TI0QrqT1/s7QnB2ja7UXB+iLWlOzstvI9QvGOIm6cbgkbu1/OQ==
X-Google-Smtp-Source: AGHT+IGICMU9GdRklbZP5Gcqxr3fx50VN1PWiZpx3cdlYfOZeIydejz7Y9TdzQLLNpGQnmRthKXsfw==
X-Received: by 2002:a05:6a00:400b:b0:72f:590f:2853 with SMTP id d2e1a72fcca58-730351057d0mr9333399b3a.9.1738821479686;
        Wed, 05 Feb 2025 21:57:59 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73048bf143dsm445192b3a.118.2025.02.05.21.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:57:59 -0800 (PST)
Date: Thu, 6 Feb 2025 13:59:40 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 6/8] packed-backend: add "packed-refs" entry consistency
 check
Message-ID: <Z6RPzIGD-fSwIEPV@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6RPJI10-2QkwyqH@ArchLinux>

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
 Documentation/fsck-msgids.txt |  3 ++
 fsck.h                        |  1 +
 refs/packed-backend.c         | 95 ++++++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh      | 42 ++++++++++++++++
 4 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 11906f90fd..02a7bf0503 100644
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
index c8bb93bb18..658f6bc7da 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1809,10 +1809,83 @@ static int packed_fsck_ref_header(struct fsck_options *o,
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
+	/*
+	 * Skip the '^' and parse the peeled oid.
+	 */
+	start++;
+	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo))
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "'%.*s' has invalid peeled oid",
+				       (int)(eol - start), start);
+
+	if (p != eol)
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "has trailing garbage after peeled oid '%.*s'",
+				       (int)(eol - p), p);
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
+	if (parse_oid_hex_algop(start, &oid, &p, ref_store->repo->hash_algo))
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "'%.*s' has invalid oid",
+				       (int)(eol - start), start);
+
+	if (p == eol || !isspace(*p))
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "has no space after oid '%s' but with '%.*s'",
+				       oid_to_hex(&oid), (int)(eol - p), p);
+
+	p++;
+	strbuf_reset(refname);
+	strbuf_add(refname, p, eol - p);
+	if (refname_contains_nul(refname))
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
+				       "refname '%s' contains NULL binaries",
+				       refname->buf);
+
+	if (check_refname_format(refname->buf, 0))
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_REF_NAME,
+				       "has bad refname '%s'", refname->buf);
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
 	unsigned long line_number = 1;
 	const char *eol;
 	int ret = 0;
@@ -1826,6 +1899,26 @@ static int packed_fsck_ref_content(struct fsck_options *o,
 		line_number++;
 	}
 
+	while (start < eof) {
+		strbuf_reset(&packed_entry);
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
+		ret |= packed_fsck_ref_main_line(o, ref_store, &packed_entry, &refname, start, eol);
+		start = eol + 1;
+		line_number++;
+		if (start < eof && *start == '^') {
+			strbuf_reset(&packed_entry);
+			strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
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
@@ -1873,7 +1966,7 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	ret = packed_fsck_ref_content(o, packed_ref_content.buf,
+	ret = packed_fsck_ref_content(o, ref_store, packed_ref_content.buf,
 				      packed_ref_content.buf + packed_ref_content.len);
 
 cleanup:
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index da321f16c6..3ab6b5bba5 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -664,4 +664,46 @@ test_expect_success 'packed-refs header should be checked' '
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

