Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81782770C
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 04:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738209965; cv=none; b=qLgFzur/9BuMjUBXXx+zKyrUuFwTnfP0ziULubvKtYAThNXZHs8FRHF0Om6RKa3Bj5+dKI8G61WlmEJYsT7ws/QV8dxIZxZQ8Mo/1vSqgctDRlPtUD0/68tWSU4BzWWppP0yOopTBeRtQJRjPjoW4HNwouNYlU11cXo9MvZK5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738209965; c=relaxed/simple;
	bh=UkLzD1y8krICV0EmpOHrMqZqwry2yIarf7MtlO50xiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OO0ul4lnNJwOSQ6tgdT+RNJcz4mGl/d/UMtEyl0P9ZOUCUMgosx80407kRYy+KDfx1reh3PvlnDTbFTfnu2Njh7HxhkEGgPdldJdABUOOXl/K8XkuepB7vx47lu1wuoaxk0dpUm2THsGunG8Ja2wva00kxiDM03GoKONZnP9jto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjjdP1xw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjjdP1xw"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so401767a91.3
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738209963; x=1738814763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySgrcBhoJ9k2KuUU3ZPcumBnsMGEpq+xgLyUMjjwrJU=;
        b=bjjdP1xwIFN5EQPZtejFSvUr/4IFnIlbWVlOnP0gK9/FwysPtLTYZ4xk/PKHVW+YIf
         XwCbzex4EuVq9k77ZvkLQBJoOOSne5jcvIIVHOC1PttHu+mI1sugJ+Qq/cp1rtq3oAQn
         2u6sFD/gqoWWQ9RAa7LSz0TlQtuw4orHx/B7BF4RBGRegQF82e2psDMUm9cePiDmOXKS
         hVf+qlK1lQz5Ho3eTytkjahAdk0VzeiYDxqLvdXI3Cpz6f/WZ9OZZvhGbF+DajSIAnpN
         u1XeU60HUhc800trfm+SdhNFKkfC5IQdJtVrl4N0PwFdnQo3ST/N47y6303qceAgH6FV
         LcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738209963; x=1738814763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySgrcBhoJ9k2KuUU3ZPcumBnsMGEpq+xgLyUMjjwrJU=;
        b=mpASpbiOL9UEBM5F1QXGRXjsXKUtdsisEv3dxHd4SExtUJxOrnb2rL8guQQ8n6QZW+
         3bEe3/6FGgYyUidHVvQ4cChjnL9VgGnbfhf+rIXdsSJp+NkvJnFgh5SVSsVRFC9mbdl7
         NiR97KUwDzy7DvWie95JVZ27OvIpSvvvM3OLSjPKGUwgN8hARKo110EFm+n+c+rqkipP
         HKVhMsCG9kVAlBsH1ya5SHQRK7qMRgGFeA+x4ntATfHQMPz2apBDc5UvWZI5Jc3d2WWu
         aYk7G/PWzjxkMk1DEkFlFAuOCZaEbx00Q7nrg5s444SVThJZOTpZQ1xGPQYlcxq1vSh4
         hiVw==
X-Gm-Message-State: AOJu0YypfqdUvcTzMfw2UugkIzjPeKHUa2Qqasc873H0vTFCGjsHS6bt
	9xYjGX4G/WzuR7ssyqYXrOXa9NxKkXVQkIpEWwKLGp1YM75SVv39R+Bk8wZn
X-Gm-Gg: ASbGncvVnJgcALGpTLJM6DxAM7DIH37TL2ZfsdJ9hqttVtAwpyRcR1hWZg2AIraau1A
	uTAqkbrOiZtA6B7e/F3o6GxigDRVjHVkaWHsrXANBNwNl/A+ig4uT4QC1Kljiz9fFKyzbzezPb9
	VS+4bviqj0D2wd+KUZvCG9jieNnDF6iCTXdx0qUBLTueRo1ZmtTmp3LvOi3MeV4Yxlinx2sAqvA
	B7ou3kpMl0VBwrGQHfjJcG9ZFK5dfCNdYndsUwFIXsrOKx1sQR+kjEJXQQIxq3yZ/yGTg==
X-Google-Smtp-Source: AGHT+IFzLPrUD+L4tfqI+k12+U6d6u3tESe23+gv1uV1vDdYxCm9jF9g1eA+9tdXII/v0MvgFtKtaA==
X-Received: by 2002:a17:90b:3a0e:b0:2ee:b2fe:eeeb with SMTP id 98e67ed59e1d1-2f83ac66135mr6911636a91.22.1738209962566;
        Wed, 29 Jan 2025 20:06:02 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de331f0d6sm3918065ad.219.2025.01.29.20.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 20:06:02 -0800 (PST)
Date: Thu, 30 Jan 2025 12:07:34 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 4/8] packed-backend: add "packed-refs" header consistency
 check
Message-ID: <Z5r7BuEJvjwQ9f4G@ArchLinux>
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

In "packed-backend.c::create_snapshot", if there is a header (the line
which starts with '#'), we will check whether the line starts with "#
pack-refs with:". As we are going to implement the header consistency
check, we should port this check into "packed_fsck".

However, the above check is not enough, this is because "git pack-refs"
will always write "PACKED_REFS_HEADER" which is a constant string to the
"packed-refs" file. So, we should check the following things for the
header.

1. If the header does not exist, we may report an error to the user
   because it should exist, but we do allow no header in "packed-refs"
   file. So, create a new fsck message "packedRefMissingHeader(INFO)" to
   warn the user and also keep compatibility.
2. If the header content does not start with "# packed-ref with:", we
   should report an error just like what "create_snapshot" does. So,
   create a new fsck message "badPackedRefHeader(ERROR)" for this.
3. If the header content is not the same as the constant string
   "PACKED_REFS_HEADER", ideally, we should report an error to the user.
   However, we allow other contents as long as the header content starts
   with "# packed-ref with:". To keep compatibility, create a new fsck
   message "unknownPackedRefHeader(INFO)" to warn about this. We may
   tighten this rule in the future.

In order to achieve above checks, read the "packed-refs" file via
"strbuf_read". Like what "create_snapshot" and other functions do, we
could split the line by finding the next newline in the buffer. When we
cannot find a newline, we could report an error.

So, create a function "packed_fsck_ref_next_line" to find the next
newline and if there is no such newline, use
"packedRefEntryNotTerminated(ERROR)" to report an error to the user.

Then, parse the first line to apply the above three checks. Update the
test to excise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt | 16 +++++++
 fsck.h                        |  4 ++
 refs/packed-backend.c         | 89 +++++++++++++++++++++++++++++++++++
 t/t0602-reffiles-fsck.sh      | 46 ++++++++++++++++++
 4 files changed, 155 insertions(+)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index b14bc44ca4..34375a3143 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -16,6 +16,10 @@
 `badObjectSha1`::
 	(ERROR) An object has a bad sha1.
 
+`badPackedRefHeader`::
+	(ERROR) The "packed-refs" file contains an invalid
+	header.
+
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
@@ -176,6 +180,13 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`packedRefEntryNotTerminated`::
+	(ERROR) The "packed-refs" file contains an entry that is
+	not terminated by a newline.
+
+`packedRefMissingHeader`::
+	(INFO) The "packed-refs" file does not contain the header.
+
 `refMissingNewline`::
 	(INFO) A loose ref that does not end with newline(LF). As
 	valid implementations of Git never created such a loose ref
@@ -208,6 +219,11 @@
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
+`unknownPackedRefHeader`::
+	(INFO) The "packed-refs" header starts with "# pack-refs with:"
+	but the remaining content is not the same as what `git pack-refs`
+	would write.
+
 `unknownType`::
 	(ERROR) Found an unknown object type.
 
diff --git a/fsck.h b/fsck.h
index a44c231a5f..3107a0093d 100644
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
@@ -90,6 +92,8 @@ enum fsck_msg_type {
 	FUNC(REF_MISSING_NEWLINE, INFO) \
 	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO) \
 	FUNC(TRAILING_REF_CONTENT, INFO) \
+	FUNC(UNKNOWN_PACKED_REF_HEADER, INFO) \
+	FUNC(PACKED_REF_MISSING_HEADER, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6401cecd5f..883189f3a1 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1749,12 +1749,92 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
+static int packed_fsck_ref_next_line(struct fsck_options *o,
+				     struct strbuf *packed_entry, const char *start,
+				     const char *eof, const char **eol)
+{
+	int ret = 0;
+
+	*eol = memchr(start, '\n', eof - start);
+	if (!*eol) {
+		struct fsck_ref_report report = { 0 };
+
+		report.path = packed_entry->buf;
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
+	}
+
+	return ret;
+}
+
+static int packed_fsck_ref_header(struct fsck_options *o, const char *start, const char *eol)
+{
+	const char *err_fmt = NULL;
+	int fsck_msg_id = -1;
+
+	if (!starts_with(start, "# pack-refs with:")) {
+		err_fmt = "'%.*s' does not start with '# pack-refs with:'";
+		fsck_msg_id = FSCK_MSG_BAD_PACKED_REF_HEADER;
+	} else if (strncmp(start, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER))) {
+		err_fmt = "'%.*s' is an unknown packed-refs header";
+		fsck_msg_id = FSCK_MSG_UNKNOWN_PACKED_REF_HEADER;
+	}
+
+	if (err_fmt && fsck_msg_id >= 0) {
+		struct fsck_ref_report report = { 0 };
+		report.path = "packed-refs.header";
+
+		return fsck_report_ref(o, &report, fsck_msg_id, err_fmt,
+				       (int)(eol - start), start);
+
+	}
+
+	return 0;
+}
+
+static int packed_fsck_ref_content(struct fsck_options *o,
+				   const char *start, const char *eof)
+{
+	struct strbuf packed_entry = STRBUF_INIT;
+	int line_number = 1;
+	const char *eol;
+	int ret = 0;
+
+	strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
+	ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
+	if (*start == '#') {
+		ret |= packed_fsck_ref_header(o, start, eol);
+
+		start = eol + 1;
+		line_number++;
+	} else {
+		struct fsck_ref_report report = { 0 };
+		report.path = "packed-refs";
+
+		ret |= fsck_report_ref(o, &report,
+				       FSCK_MSG_PACKED_REF_MISSING_HEADER,
+				       "missing header line");
+	}
+
+	strbuf_release(&packed_entry);
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
 	int ret = 0;
 	int fd;
 
@@ -1786,7 +1866,16 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
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
index 42c8d4ca1e..a7b46b6cb9 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -639,4 +639,50 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
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
+		printf "$(git rev-parse main) refs/heads/main\n" >.git/packed-refs &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: packed-refs: packedRefMissingHeader: missing header line
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err &&
+
+		for bad_header in "# pack-refs wit: peeled fully-peeled sorted " \
+				"# pack-refs with traits: peeled fully-peeled sorted " \
+				"# pack-refs with a: peeled fully-peeled"
+		do
+			printf "%s\n" "$bad_header" >.git/packed-refs &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: packed-refs.header: badPackedRefHeader: '\''$bad_header'\'' does not start with '\''# pack-refs with:'\''
+			EOF
+			rm .git/packed-refs &&
+			test_cmp expect err || return 1
+		done &&
+
+		for unknown_header in "# pack-refs with: peeled fully-peeled sorted garbage" \
+				"# pack-refs with: peeled" \
+				"# pack-refs with: peeled peeled-fully sort"
+		do
+			printf "%s\n" "$unknown_header" >.git/packed-refs &&
+			git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: packed-refs.header: unknownPackedRefHeader: '\''$unknown_header'\'' is an unknown packed-refs header
+			EOF
+			rm .git/packed-refs &&
+			test_cmp expect err || return 1
+		done
+	)
+'
+
 test_done
-- 
2.48.1

