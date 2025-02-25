Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C5C2690FB
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489720; cv=none; b=oiM2kJPTPQJHgRnVCQgeIB2ulqG+2Z870zQ32HotdOlQXL3cWpaaeWtHWSawCcIeUT5lENI7rQf4cZCI3vUlXoxgJ/0+r5ZOZb720sQDyuZtZDVfkgkFR20VqO8aDfM6BWSg3AbiL6Xs1mEhPQ3qQV/uJC+2irVSnUrv2dfFBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489720; c=relaxed/simple;
	bh=HOt5klsXveqjXI7FvJixxV7FTi5vs390BvPChM0tLqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCQ9BmQVjyPzgJW1fn7VdfGyeBfTg0oB5sKSFlk7jcCP0nuuPnixcEerzrA/0quQzaDxbMk3oRGZVN2huObLgz96jnsSOlLs+rr64Mp5+Xh+nlGL4qM7AlAhyFgwtkCV5DAH5xsPapgg+mJg8ykhCDWhxcW1Eg/I6FNu9bD8pQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ7jYj0I; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ7jYj0I"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2212a930001so39184525ad.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 05:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489718; x=1741094518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkSQSgV+yPru8b7qwmjDdQtnz76oZC5o0v/SzXOEchI=;
        b=VJ7jYj0IVuKo0mTYwrMCzcRGkGpcVE6SYZVnOlHLAZm/7caV+mQaJWtxQETTRi/GLo
         oVp23yiShcEGZf+/tik02SEXazGqRdpwzPfP9I5k3DauwiYVZbKUqathfg61V+4klWxN
         V/c+BdRn34kHlf3uUjLZIH7EGjdv6ekn50kiMCaZtWYsPkPZvEyuYqrCNhag6M1gLNKv
         wfnqn3Nowj8LKSz47L+wzNcoSAPurgD3TmxPdhHK+sW61lYKCgXv6Qsc/Yd6LUtfGTd4
         Sw/Un5Wsu05fbrhQV+sSudsDDrax7rFiNlZD789mKxkGXmKqBzJgevvpJrID3TFh21pC
         gsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489718; x=1741094518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkSQSgV+yPru8b7qwmjDdQtnz76oZC5o0v/SzXOEchI=;
        b=UEAz8j+8W4ZhAkbPN9AqrNDg5eHFc+R6TZEbcPyn+DeBpgYb6HuFXzSgQH1jLpHWed
         +iz2tAwdLxvsmj4/IQgaXj33XK1B+5fXaJ6VmkjQH1f5qZBJN5/9DH2HOVq+/Xz1Z30p
         Jz5mryAW4YcHXUBHi+dDbUbFnxNgOqklqRSZxCD2Jn/ur8l60y+iByPzmJrXqD/p2c7r
         63V82a9od4RQzTKUZ5hZi4PuXY9hMXx1UfEWgiE/VYsDsUJsKAEM8Cuq/c1TMGbYcj96
         vQ5fBm7UlPkRha8KHZoYSZPi90iH5Wqd2U4Tg4V3MQIvPLsylWBUmom0/X4hmrX4/77n
         xmgQ==
X-Gm-Message-State: AOJu0YyJkwp6+SIdA39ugKMFxF0znyAsIrLL7JwueErwoXziyN7nQotO
	k3V6ELFsOH2obtLWZNtTPB8D1+kxxT5zD2B7XONrZtt5g7ShVBDIfc8MgQ==
X-Gm-Gg: ASbGncvu42EdquoMeGQIOqvMobVTUSW24yAg7o+PLwOwtW25KvhXG63SPcAALztAGVX
	xUmVdmHwdBOu8wi1seNr/OjRK1GYJwcX/kaPaPHBT6wc9pauznf1I2IdKxgPPP1KCjxTZPLaiGL
	zORUWuaeIAtjUFn+FdPV9NfmrzLwwGMpNDM9l2PbUNk7yb7NmoEBrIq2HGKU54dIYAyF2aSQ/vF
	Mh6aABY00f7RhiWG3bL6mPHDaCwaH1te4vX8CqH8pSpgnCIuIo5W1W3Dt/RvkyEfpFYrZAVKc2G
	uC//dF7oTPVqSUl/6nhQAA==
X-Google-Smtp-Source: AGHT+IE3J15VKak6lipU8MNo16ICTY/JiD9SrQQIETE/06uxFpUOR4DyYVPx28ahboH+vKBf3qvZ1w==
X-Received: by 2002:a17:902:ce82:b0:221:283:5884 with SMTP id d9443c01a7336-221a10df197mr283411115ad.29.1740489717982;
        Tue, 25 Feb 2025 05:21:57 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a00093esm13833645ad.18.2025.02.25.05.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:21:57 -0800 (PST)
Date: Tue, 25 Feb 2025 21:22:05 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 7/9] packed-backend: add "packed-refs" entry consistency
 check
Message-ID: <Z73D_eE8dnzfAcBD@ArchLinux>
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
index a74ee57776..dd3f7ab255 100644
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

