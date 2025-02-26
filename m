Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB5C84A2B
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577808; cv=none; b=ZH31zbWs9kEOIFOkIOgXb4lUeW+MCboz5kl44ZnIvejj/0x7YcvG8+bIeDFGKW66bEYaTOZn9Tjmz+q52hA330a2nsSazflpBl7OsIYuHYf/cOCCLU/NlTUBHOgEWDi+66dn8yR41sDqZLmzowBvg6Uw5HS4NJkB2Y5qwUwiw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577808; c=relaxed/simple;
	bh=BgMWZaz0waGjfQ+acAtJPqVUH8HRL8HUlY772yXUf+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gnkd0nmzqDzTy2E1xNqspSFYLZ50eYgrcziZxi6K43W3uIvCJyNH5Ke5Fa0nGEz3RD3wzyWFA12k7hsQjeUgP4L9g/zRVkBnnGZ/KGCoMkAx+ct2KAmD0smEJDXh8jSI9YoZ2O2qfBC/x/o+UZZWkJh5dABLJ3KID/5GlNH8Gto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6NOmXIQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6NOmXIQ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fbf77b2b64so13625749a91.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 05:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740577804; x=1741182604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cCRnXhlIBy9kxJdFEvVm7Zei2EMNOIDE+Q6hVs9UerM=;
        b=K6NOmXIQCI10pHO4FT65w3wmHy1iIsw+ulNMoYk8DA7Lp5XPj4NqKoobJ0GleKwUvc
         QoPus/AOfqDWnKAz+xzsoCtKxcyJidkcIPqQFwT9WwjSrVKzvWfjQ5Exy861bJoSMloN
         Gqj716RmgpXREnREgRN9t3EDKj8ZkS2lkVhRvxFE68LhaPSQ460S6FCCU/xZ3YjSAR4b
         uD/hhB2k992uvm2+bDX1DUiVSZE9X2hErstP/VayOCogj57Q/HlM4YNvJk/4p1rpljwO
         zTw/ROAmYtdG7cmuwA4zP4YSVBbX2PxZRTnro/hoU/TQNZibWL3XTLUPjRJSlyP6yH7/
         IV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577804; x=1741182604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCRnXhlIBy9kxJdFEvVm7Zei2EMNOIDE+Q6hVs9UerM=;
        b=O3zmZKJFBE9LHqoy0qJsFz/7vybPDzitHYjFijtRP8tReZwQwZCqYgNyIioG/elIK9
         Q2IG67A0jxAJAZkym3tIehpp6f3029T2PKAVDqx+l6Mg0bLj9lOXXIvJIE1GzkUGnSKM
         fzFzwT2pSsRLzFAIsjFpWAQp0LCT/gwjKpeod8yjDgccTFdPTHDkj0sDqdQG0ORExrA/
         b87Fy8a7xaV1oC0ksolE8eMksNR21+znsFa1Wz5axlWSy2OIW2JW21XjpQ/fqIp6PY51
         DZ3GsyJokgVUIzE4OCJDvvthA5HO+mozLvEM4CEEk05WSB8EHQd15DuvRGkl4JO26DvF
         Syhg==
X-Gm-Message-State: AOJu0Yw757VM12R+NTd+GvjA3N/xMMc7WtaKXhce9d04NjtrI4GEfQSI
	9h1kf0tPHMjhgheW2YVGO4EavO/nHgkJpN1uKpG3BVRDjKaaiyQlOe7Oyg==
X-Gm-Gg: ASbGncs/vtdfCjKrOszjoMLomeA9bHh2q6dADyqiP80V5eZ4ghCXBXKSgtQutHSCXYZ
	AZuO6xhxnsYKSz7MerfDPWTja8ozJXE9vMy+Bute/deu2K8v9pWw8MenM3RG9QZ1lhrEdk06vrY
	z9Ei5F3MGIaWY/dS/UfxDSABGAcFfspYojNWNvOtOxb24MHx6Seq3tcPKZnQfqw678clkc1Tz3+
	G7oBSnenoYPBAyZsLS5kWP3xyjvu8yHsBf6vnHfHBcnxac4K2DVfzOMdGSfwoJB6PtT2o7OOis3
	O/udOYRi819v8uPuQKfY9g==
X-Google-Smtp-Source: AGHT+IFgT+r6MhD1ywHlcRztU6gaPxwDGducHJJNYooFaIkY9ZufXZ+Ukk8cWfgTOCtiFvrEQ0wSCw==
X-Received: by 2002:a17:90b:5547:b0:2f9:9ddd:68b9 with SMTP id 98e67ed59e1d1-2fe7e39f0c1mr4573543a91.26.1740577803908;
        Wed, 26 Feb 2025 05:50:03 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee6f8c06b3sm725868a12.30.2025.02.26.05.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:50:03 -0800 (PST)
Date: Wed, 26 Feb 2025 21:50:12 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 5/9] packed-backend: add "packed-refs" header consistency
 check
Message-ID: <Z78cFPZvptoJfReH@ArchLinux>
References: <Z78bmBSrDR20GY6g@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78bmBSrDR20GY6g@ArchLinux>

In "packed-backend.c::create_snapshot", if there is a header (the line
which starts with '#'), we will check whether the line starts with "#
pack-refs with: ". However, we need to consider other situations and
discuss whether we need to add checks.

1. If the header does not exist, we should not report an error to the
   user. This is because in older Git version, we never write header in
   the "packed-refs" file. Also, we do allow no header in "packed-refs"
   in runtime.
2. If the header content does not start with "# packed-ref with: ", we
   should report an error just like what "create_snapshot" does. So,
   create a new fsck message "badPackedRefHeader(ERROR)" for this.
3. If the header content is not the same as the constant string
   "PACKED_REFS_HEADER". This is expected because we make it extensible
   intentionally and runtime "create_snapshot" won't complain about
   unknown traits. In order to align with the runtime behavior. There is
   no need to report.

As we have analyzed, we only need to check the case 2 in the above. In
order to do this, use "open_nofollow" function to get the file
descriptor and then read the "packed-refs" file via "strbuf_read". Like
what "create_snapshot" and other functions do, we could split the line
by finding the next newline in the buffer. When we cannot find a
newline, we could report an error.

So, create a function "packed_fsck_ref_next_line" to find the next
newline and if there is no such newline, use
"packedRefEntryNotTerminated(ERROR)" to report an error to the user.

Then, parse the first line to apply the checks. Update the test to
exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.adoc |  8 ++++
 fsck.h                         |  2 +
 refs/packed-backend.c          | 73 ++++++++++++++++++++++++++++++++++
 t/t0602-reffiles-fsck.sh       | 52 ++++++++++++++++++++++++
 4 files changed, 135 insertions(+)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index b14bc44ca4..11906f90fd 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -16,6 +16,10 @@
 `badObjectSha1`::
 	(ERROR) An object has a bad sha1.
 
+`badPackedRefHeader`::
+	(ERROR) The "packed-refs" file contains an invalid
+	header.
+
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
@@ -176,6 +180,10 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`packedRefEntryNotTerminated`::
+	(ERROR) The "packed-refs" file contains an entry that is
+	not terminated by a newline.
+
 `refMissingNewline`::
 	(INFO) A loose ref that does not end with newline(LF). As
 	valid implementations of Git never created such a loose ref
diff --git a/fsck.h b/fsck.h
index a44c231a5f..67e3c97bc0 100644
--- a/fsck.h
+++ b/fsck.h
@@ -30,6 +30,7 @@ enum fsck_msg_type {
 	FUNC(BAD_EMAIL, ERROR) \
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
+	FUNC(BAD_PACKED_REF_HEADER, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
@@ -53,6 +54,7 @@ enum fsck_msg_type {
 	FUNC(MISSING_TYPE, ERROR) \
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
 	FUNC(MULTIPLE_AUTHORS, ERROR) \
+	FUNC(PACKED_REF_ENTRY_NOT_TERMINATED, ERROR) \
 	FUNC(TREE_NOT_SORTED, ERROR) \
 	FUNC(UNKNOWN_TYPE, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3dd3fec459..b00fca6501 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1749,12 +1749,76 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
+static int packed_fsck_ref_next_line(struct fsck_options *o,
+				     unsigned long line_number, const char *start,
+				     const char *eof, const char **eol)
+{
+	int ret = 0;
+
+	*eol = memchr(start, '\n', eof - start);
+	if (!*eol) {
+		struct strbuf packed_entry = STRBUF_INIT;
+		struct fsck_ref_report report = { 0 };
+
+		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+		report.path = packed_entry.buf;
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_PACKED_REF_ENTRY_NOT_TERMINATED,
+				      "'%.*s' is not terminated with a newline",
+				      (int)(eof - start), start);
+
+		/*
+		 * There is no newline but we still want to parse it to the end of
+		 * the buffer.
+		 */
+		*eol = eof;
+		strbuf_release(&packed_entry);
+	}
+
+	return ret;
+}
+
+static int packed_fsck_ref_header(struct fsck_options *o,
+				  const char *start, const char *eol)
+{
+	if (!starts_with(start, "# pack-refs with: ")) {
+		struct fsck_ref_report report = { 0 };
+		report.path = "packed-refs.header";
+
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_HEADER,
+				       "'%.*s' does not start with '# pack-refs with: '",
+				       (int)(eol - start), start);
+	}
+
+	return 0;
+}
+
+static int packed_fsck_ref_content(struct fsck_options *o,
+				   const char *start, const char *eof)
+{
+	unsigned long line_number = 1;
+	const char *eol;
+	int ret = 0;
+
+	ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
+	if (*start == '#') {
+		ret |= packed_fsck_ref_header(o, start, eol);
+
+		start = eol + 1;
+		line_number++;
+	}
+
+	return ret;
+}
+
 static int packed_fsck(struct ref_store *ref_store,
 		       struct fsck_options *o,
 		       struct worktree *wt)
 {
 	struct packed_ref_store *refs = packed_downcast(ref_store,
 							REF_STORE_READ, "fsck");
+	struct strbuf packed_ref_content = STRBUF_INIT;
 	struct stat st;
 	int ret = 0;
 	int fd;
@@ -1797,9 +1861,18 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
+	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
+		ret = error_errno(_("unable to read '%s'"), refs->path);
+		goto cleanup;
+	}
+
+	ret = packed_fsck_ref_content(o, packed_ref_content.buf,
+				      packed_ref_content.buf + packed_ref_content.len);
+
 cleanup:
 	if (fd >= 0)
 		close(fd);
+	strbuf_release(&packed_ref_content);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 68b7d4999e..74d876984d 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -647,4 +647,56 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
 	)
 '
 
+test_expect_success 'packed-refs header should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		for bad_header in "# pack-refs wit: peeled fully-peeled sorted " \
+				  "# pack-refs with traits: peeled fully-peeled sorted " \
+				  "# pack-refs with a: peeled fully-peeled" \
+				  "# pack-refs with:peeled fully-peeled sorted"
+		do
+			printf "%s\n" "$bad_header" >.git/packed-refs &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: packed-refs.header: badPackedRefHeader: '\''$bad_header'\'' does not start with '\''# pack-refs with: '\''
+			EOF
+			rm .git/packed-refs &&
+			test_cmp expect err || return 1
+		done
+	)
+'
+
+test_expect_success 'packed-refs missing header should not be reported' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		printf "$(git rev-parse HEAD) refs/heads/main\n" >.git/packed-refs &&
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success 'packed-refs unknown traits should not be reported' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		printf "# pack-refs with: peeled fully-peeled sorted foo\n" >.git/packed-refs &&
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
 test_done
-- 
2.48.1

