Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979220AF88
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489706; cv=none; b=Zc721h+1X1NeUV+0gNe/Uz0e1ZRyLxonSFHCUVaWmYuvtpZWV+ST8zClceXB+fnVjrQYkeukWFtPtap2erXNEjO2OuJmpBJ9uL/XEmIdgrLAomMx8Q9/sPScRhOwEylXswb6zG86pFaoUXt0zZ9l0MHvTkhC6sv2EzajkODHni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489706; c=relaxed/simple;
	bh=7D4pyMk43CFyX4TRC0Q3lWp57ydTVz6uDa7zDP8VRGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/SgPD/NWwPtnBCS0i/KUxVuBI1vXY2t3RkPulJ+u1Lk4lqIt7jsdLFK4Mh+Uqwk/58XyfFtw+ymz6P9+/jnoevhk+TXAO1WzKN7MwrQi3EdGoeCfU8OiCRo2vtyZCYn54UEbhwomXC4wEZgZDZeS8zWuXQrDiaNAPN2edJR+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HASzTHwe; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HASzTHwe"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso11261258a91.3
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 05:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489702; x=1741094502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7AH97J9VkX6zmmeh4ntf0OO0BnIyRiq2aYVrrWC6hOE=;
        b=HASzTHweIhDJTaoboljTVajm3T1HhFQJdUrzWbkHB2J4wEu1wzdKqB08HJkmNnuhsK
         bndTDMHur6rLAS5p3QJdhqTiwUyOm82OrRy5P+8P0mKmHze8OJH+BeuWZevI8M9VSA6v
         ZZij3PvqkKyo8W0P1UgmrtGMYHNmGWxQVF0GWmjmkvmquoS3HoOzyrSLeAnKuMGuMj+b
         ZY9Yrz0fvWAMYAqVdGYSCW2EOt5RBIwRkbO/f2/DouXhtx8lsW4Yyzgj+xVlVM84u9Ai
         BKfW1zX/NicReeIPyyOYZIbCKBHAQ1PbMH/gsaF/Gj0odtbIXKHgq633l++ZjQzuJEe8
         NAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489702; x=1741094502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AH97J9VkX6zmmeh4ntf0OO0BnIyRiq2aYVrrWC6hOE=;
        b=E3LIQGBsHxN4MCmG7wopeoosI114iOE/5lR4F1c6awKwYFSuO6o2SxveQ/Z/1xzb6J
         5DinKRRdfek3Y1u4oTZeNbdKTJhUCCkYnA6CocbzZMOFNcq0R1ztWBNEcKPkCkeLTwxm
         HCSmdxufwyMZHneIWPJXmIYjxKXhpaBt2aTh+PbpVYHwTWWcbAgcd5hNNtNOLqxFAjo+
         OQTy/4+G5rSv0BZIoRug8ITS1Nbsonzj2IxeuOnK3FIFABrwwK8Jujwcuoud0UQ75H7l
         uDYJZeUczq4+xNZHBp+p4mAAd84BuQZFSIp2KekiPdtwa3CwN0BOOZaI0WtNYFN6TCtO
         lmMg==
X-Gm-Message-State: AOJu0YxRDT4CSN9VbJxS9NsLiOxPofBLr2surYCegawWnpaj6uMlH3eZ
	Jykl5+hkcTtp0JU5b4ydM4DzM1Q6+1GYFSokeBHkaZRXsSSSyg+2l7DuoQ==
X-Gm-Gg: ASbGncuRxtJqZinioCFlA8DCtVfLmuCoLO0qQ99M/Nb1OK1PrwSrFNjCHK7PkQO2zla
	OGCh6ky0zDxV5srN7PKFUh4ipSJBcExjGJaEsKhlrcAtX2UBr7c7yoW14mquzDBEMauj/6xrHTH
	wVssiYTMGlHex3vL6aSfMm1ewh2rnRI168ruw4QVR4Xs2zNP1qGhxTsyq6Qa8zqi89WJq4r+qO2
	1cK+ntS4igmlhYsE/kDhFL/OOWYQnpZ1ef2Sgax2hq0nKWyQ2iDB0EqWvytz4BrhHhqFAUVlmwQ
	pfThdjmqfGg5hx6yaP9+xQ==
X-Google-Smtp-Source: AGHT+IE6tkC25JHgBrx9a6pebbRsisXyoOjmAAgNzXW8azv11Wcfl98wYOuRxm7bDMBHB9dPGhDgyQ==
X-Received: by 2002:a17:90b:1a89:b0:2ee:c9b6:c267 with SMTP id 98e67ed59e1d1-2fce78a8a38mr31445315a91.9.1740489702036;
        Tue, 25 Feb 2025 05:21:42 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a000a2csm13935485ad.32.2025.02.25.05.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:21:41 -0800 (PST)
Date: Tue, 25 Feb 2025 21:21:49 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 5/9] packed-backend: add "packed-refs" header consistency
 check
Message-ID: <Z73D7Qug4lgA8owW@ArchLinux>
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
 Documentation/fsck-msgids.adoc |  8 +++
 fsck.h                         |  2 +
 refs/packed-backend.c          | 94 ++++++++++++++++++++++++++++++++++
 t/t0602-reffiles-fsck.sh       | 52 +++++++++++++++++++
 4 files changed, 156 insertions(+)

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
index 9dabb5e556..4891c86a5a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1749,13 +1749,78 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
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
+	int fd;
 	int ret = 0;
 
 	if (!is_main_worktree(wt))
@@ -1784,7 +1849,36 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
+	/*
+	 * There is a chance that "packed-refs" file is removed or converted to
+	 * a symlink after filetype check and before open. So we need to avoid
+	 * this race condition by opening the file.
+	 */
+	fd = open_nofollow(refs->path, O_RDONLY);
+	if (fd < 0) {
+		if (errno == ENOENT)
+			goto cleanup;
+
+		if (errno == ELOOP) {
+			struct fsck_ref_report report = { 0 };
+			report.path = "packed-refs";
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_BAD_REF_FILETYPE,
+					      "not a regular file");
+			goto cleanup;
+		}
+	}
+
+	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
+		ret = error_errno(_("unable to read %s"), refs->path);
+		goto cleanup;
+	}
+
+	ret = packed_fsck_ref_content(o, packed_ref_content.buf,
+				      packed_ref_content.buf + packed_ref_content.len);
+
 cleanup:
+	strbuf_release(&packed_ref_content);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index e65ca341cd..e055c36e74 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -639,4 +639,56 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
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

