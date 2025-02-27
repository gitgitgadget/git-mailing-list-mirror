Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C51A83EF
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672430; cv=none; b=YHKpxkt+br/dzvJfX0j0Hxuts6WmBM265CKH+1fq414PlFQsHqwaU6SRzS8QYyUzrkC9QB8N9kIZgqRuNtxSOqQB/U2EiM4yC1aWetJS+eqzAzqwQ2i9EgYuyCE0WrtJ7K26MTWoEOGeAYUqBZ/bh6R7D3oKey4c37SqHJ9A1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672430; c=relaxed/simple;
	bh=yer8hRDE9/xXF31RGwM8gjqdChUBEbCekkf9hUtsPWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdRWHtk8x7yVG4XtyTpHJxtXaOS6tZNPh3/8catyxOoWZzn1JJqEFNXkf/d8zNtrAGJINxU70A4tIwOlc0iKL43tI+QqCLouWUXwGrCtw64mxDutqwNaQIrbKTzuGZDPPn/Dzaef2bCbHUQpfdlEEeREiX2XiApjgv3wsAuEA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHr5OS4k; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHr5OS4k"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2235c5818a3so17145675ad.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 08:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672428; x=1741277228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDdmuYja995Wp2rZSBvt4dR5Jh6geDb9SFaOwc0MhCs=;
        b=jHr5OS4kmFjuDMZIxkVNFRn+6icqr0KEWP1NvjideeCcmya7iY9yts+zH4PhS4s+9O
         mHgNt0SKGF2WUz8iUr0GgNh6SDRlC2ro+1wPR7HynHhimXxoINUvnk6IOQtOWnj6Pmd6
         1Z+YP5vWRGZmqVPuEVQ4bctnr7QeYxyTJi9iI4CNYngw1ZH1pZfvUqIAtKTdXO1kIAc4
         bYjwxmCO6h4H/HatFwH3aU1EU8Egp79UDqkgbAHY1i7ufd3D+bpD45ZH6deqGFVb9inD
         Z2FwJ94/L7lkoPlN6a6AXzQWl8rBpOgZUsbJd+ZJQydVEz/DrfS0s3lvolkMfJBEOhzT
         /E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672428; x=1741277228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDdmuYja995Wp2rZSBvt4dR5Jh6geDb9SFaOwc0MhCs=;
        b=d+vnC8GzoUWElAtJ/t7zR3J32dZG2bUXu009RiUz8TFT9uQ5WkLu/N4+Knmsbuuqj3
         g8DE4xe4IdsGQv/nFAKLE0g8fwzOVkED/9dpvKO3mIQpIDHqTTNxjfwzbayTP41Ls9/r
         RCHtHrE4igo42UViOElM2PZ1VGFQYvHf/Ytly8OEywynD6pZUgI9ozfhw1x7TzqrfLqH
         MzTX82BKtGWBUNomlb6qzUch8ZaThLN1U9gmvImhLGm/HwU+apKeWpfU5sZeEO++/vYC
         vVRcOrky/xXciAD0szo9wJfBdp5eBiN9/1vI8uRJB72vg8tpdq9R3oQkyXPhcMRdUWsO
         h/tg==
X-Gm-Message-State: AOJu0YyZV1bK7UAsBSVboXVhfwlhc0vlgrQNGTojr91M3DP8s25M1vjm
	MlnV17jd9x7UXcZiI5ydL4TErAuTVKhpIxMAr293/LsPFnozAcWJACvZSg==
X-Gm-Gg: ASbGncuM/GPYfYQZkeOTCEYcPK2KUBQQjJPLsMoonxFWQbb8zl8AAa+AtOJlWwKvTIy
	Sefv5gYau0jpg8Gr942mGT+rotFsApEOnyX3lPqESw6+6+EgW6UZcxFM9rcdi0rrIMISwWZtTNY
	u2FAjqYans7sZrkuQKT64+CxyBsmGN1Dj7eEsKyGTJz04OfqGPtvoVGth12lCFQwwhdtlGXpl2p
	ub20RU8iNDY9C0nkTgG8e8Uy8ugKLQipzs1LT+cK7/dwYVcI4qIHEXjvrEsPtdcw0G5s9mla+Ms
	6hZI/RlpruL1H2NvTtCINg==
X-Google-Smtp-Source: AGHT+IEK2sZsXkc9lT4j5c6+8NnuRB/b7FD6m+1Ea2A0V8ix18MP/9niAwjyvtwHoHAVpOmMhexYRA==
X-Received: by 2002:a05:6a00:992:b0:730:7d3f:8c79 with SMTP id d2e1a72fcca58-734791a2883mr16344059b3a.19.1740672427756;
        Thu, 27 Feb 2025 08:07:07 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7349fe48865sm1844341b3a.50.2025.02.27.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:07:07 -0800 (PST)
Date: Fri, 28 Feb 2025 00:07:17 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 7/9] packed-backend: add "packed-refs" entry consistency
 check
Message-ID: <Z8CNtcTbJrCbLXeT@ArchLinux>
References: <Z8CMx7O19PMs9sVY@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8CMx7O19PMs9sVY@ArchLinux>

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
index 9a90c52f70..ef20300fd3 100644
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
 
@@ -1884,7 +2004,7 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	ret = packed_fsck_ref_content(o, packed_ref_content.buf,
+	ret = packed_fsck_ref_content(o, ref_store, packed_ref_content.buf,
 				      packed_ref_content.buf + packed_ref_content.len);
 
 cleanup:
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 74d876984d..a88c792ce1 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -699,4 +699,48 @@ test_expect_success 'packed-refs unknown traits should not be reported' '
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

