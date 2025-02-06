Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940231F60A
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821447; cv=none; b=D9DB2x++j+0/xM0Gx6oX3G8gBgT5/mtDYdIYWaA6M7z2GiwtJ2VLo2cND3CgDR1q4QYE0GOuDLhsJUt7jG6Tgx9M1xS4JVzflKkmrrI5OfXwsFPF7RDj3GW+f/1QxzP/iGIjXUP+LzFY2oR1VuQhE4cDcUgckwm5jrxW5qFVHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821447; c=relaxed/simple;
	bh=gPBfsbwXkeoIiqnOuTz9Bbjo9k2anmZmkafcdQgkwKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLjobrZvsxeg/4+5ImjxBJPu9kEkDIr5SRYJDhXpH0gh6GjApI6XKn/FjrDeG51R0u8nfzrewYNu/OvltJ0LWY1uBs1H0VDnV2vobg+3GO37/p0NVJW0OD7xk3mV+jg3QWgiOBk6rsgSOcc8804/A4VkaAUZb3hZ588jjU0iaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia5cY5x/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia5cY5x/"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f05693a27so7928545ad.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 21:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738821444; x=1739426244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mc2Eab1ktUMhP2/CIDAlLxjTUidXxsJnONji6g8e9c4=;
        b=ia5cY5x/Om41SkplXldWHW9JT4KitKY+VVW2v4tY+Udz4qxhn/3qppA/MwXFlR4oz9
         7nuem6nrQ7xXlcrtkba1e0Z6Z0v+ksLmJ58IfrLTI6aPkFt3avalr8S6EadfmlPtSZAa
         jME9t1diJ1lSN/uaKh5pkgyMr7OaoaGx2prn/gavlzHtKjOW1cuzYaGALl3S5sKtqNIk
         NASSNJQn9q8/MRSf65SchsaZc9RnPvEO+pkFNl6p6AcIETY/TQwYR4bB67mSSOyPEIUM
         9l/rb5Nx8P8Alumy6fbqxloD3VHj7Yn9cN60g4/NCQTSB13Cf1+QlwqbFUHMqWTbE/Di
         AddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821444; x=1739426244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc2Eab1ktUMhP2/CIDAlLxjTUidXxsJnONji6g8e9c4=;
        b=LhSVVMOj4XQIsi71I1c+jE1JqMCsENBy9CvCvq0ppAGzqmY4B9PcSkWo1a9DjvtmBy
         uCk8fd7zLbRWzPOPTs66QO9QqTst9G1494W72xHkEpW5Vnn3P0Y4CXTkwZHw4JXbK/sK
         HELSPy4I1HFcuNPIkiKD/9j2KNaUFAsLLAgxJ0EGF3NE7nUDc+cGh4F8U5CSStD4qfnj
         2kK18S74XSrr5BdRhPgEklp6nAf1COgIontXOnLqcUkWSGLHy+rhxZ2GkfyB/1MnVGmn
         FVU1dDlKsWZnrxK2Ehq/sCAHd0K4Vdu0IhdUJtzWR6r3wc8WMpOaETBvdBeJiMLuqjBB
         9wZg==
X-Gm-Message-State: AOJu0Yx5zE2Slh9sPB7IhN221yQfpSEz+clfjZ+z1SsxduTvMCZDMvhv
	dORbxGW8W0jUjhQcu6VX5boTtetd72PICoblzqg67ml9XGIDNn1xjx4+6g==
X-Gm-Gg: ASbGncvLiOwYfoi5hd9ZegI0iJBFiuhVSB2eqBynnYJIrJDXRWu8lAZvJGxFHOmVfiK
	8A9cAa1VnFICwD86DYRWFh0Ycsybb5aK0VXpG9hTl2R1/tZ+y5hRr9e4sAd7ycoiWKSOWuc8Qyg
	6adi37RD1FIHfF179zrtCAoFUs5z1vzyAxdnF0Ci72con3CI/+aZyT6mM+6d2SpEAvFuE7zTpjo
	6GgadN5OLHN9kIru+T8bt/Qa+cbxtfZUIAgQ0CQtbhViZAQ3iLP3NRuObAp3hrKwnXcbw==
X-Google-Smtp-Source: AGHT+IH4u2S4hjHVyGwwr7m48ONJKVAuXrw18VDVDX4t8mDGzR5/zWgOBSgzgPgnfIJnUnxefaFJ8A==
X-Received: by 2002:a17:902:f550:b0:21f:6dd:bee4 with SMTP id d9443c01a7336-21f17ebab4amr92313825ad.33.1738821443757;
        Wed, 05 Feb 2025 21:57:23 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3683eb02sm3895725ad.153.2025.02.05.21.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:57:23 -0800 (PST)
Date: Thu, 6 Feb 2025 13:59:04 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 4/8] packed-backend: add "packed-refs" header consistency
 check
Message-ID: <Z6RPqE64ScsjzUg7@ArchLinux>
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

In "packed-backend.c::create_snapshot", if there is a header (the line
which starts with '#'), we will check whether the line starts with "#
pack-refs with:". As we are going to implement the header consistency
check, we should port this check into "packed_fsck".

However, we need to consider other situations and discuss whether we
need to add checks.

1. If the header does not exist, we should not report an error to the
   user. This is because in older Git version, we never write header in
   the "packed-refs" file. Also, we do allow no header in "packed-refs"
   in runtime.
2. If the header content does not start with "# packed-ref with:", we
   should report an error just like what "create_snapshot" does. So,
   create a new fsck message "badPackedRefHeader(ERROR)" for this.
3. If the header content is not the same as the constant string
   "PACKED_REFS_HEADER". This is expected because we make it extensible
   intentionally. So, there is no need to report.

As we have analyzed, we only need to check the case 2 in the above. In
order to do this, read the "packed-refs" file via "strbuf_read". Like
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
 Documentation/fsck-msgids.txt |  8 ++++
 fsck.h                        |  2 +
 refs/packed-backend.c         | 73 +++++++++++++++++++++++++++++++++++
 t/t0602-reffiles-fsck.sh      | 25 ++++++++++++
 4 files changed, 108 insertions(+)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index b14bc44ca4..11906f90fd 100644
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
index 6401cecd5f..683cfe78dc 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1749,12 +1749,76 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
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
+static int packed_fsck_ref_header(struct fsck_options *o,
+				  const char *start, const char *eol)
+{
+	if (!starts_with(start, "# pack-refs with:")) {
+		struct fsck_ref_report report = { 0 };
+		report.path = "packed-refs.header";
+
+		return fsck_report_ref(o, &report,
+				       FSCK_MSG_BAD_PACKED_REF_HEADER,
+				       "'%.*s' does not start with '# pack-refs with:'",
+				       (int)(eol - start), start);
+	}
+
+	return 0;
+}
+
+static int packed_fsck_ref_content(struct fsck_options *o,
+				   const char *start, const char *eof)
+{
+	struct strbuf packed_entry = STRBUF_INIT;
+	unsigned long line_number = 1;
+	const char *eol;
+	int ret = 0;
+
+	strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
+	ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
+	if (*start == '#') {
+		ret |= packed_fsck_ref_header(o, start, eol);
+
+		start = eol + 1;
+		line_number++;
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
 
@@ -1786,7 +1850,16 @@ static int packed_fsck(struct ref_store *ref_store,
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
index 42c8d4ca1e..da321f16c6 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -639,4 +639,29 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
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
+				  "# pack-refs with a: peeled fully-peeled"
+		do
+			printf "%s\n" "$bad_header" >.git/packed-refs &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: packed-refs.header: badPackedRefHeader: '\''$bad_header'\'' does not start with '\''# pack-refs with:'\''
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

