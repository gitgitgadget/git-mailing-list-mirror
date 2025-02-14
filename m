Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0175198A11
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508794; cv=none; b=uiUM2a4gDkiCgkKvKm/XAzoiI7LsFdsdQEqSYL+UljrwM9CYC2YWHXvweT2EUd4SD2hjrm307mkG/pwLySYoJ0ZJDaRCHGRbyFDSDAUwCHGEcgfClp1SZOLkQVsShQ22ruXs2MbUHreGvS3AUEfA18G2/rarr7f2hmKPnoDG5R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508794; c=relaxed/simple;
	bh=Dq0fFNqhuZ8Mf1OZq3oGBtBNi86EQjfKyt6RIrUBA2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luUB8dLJuJ2TB/Vk/BOIyI5G4+jdBW7xrcg5WdasQqNzuxD+y2w/74+yjMv6o4N5lKfdY4JAm2JwpQgQGwGnqdIpsQi3ZJy/ascKEq/aejCQODqExvsFHKNfVkipoW4VxZr4gpx+T55VTRO3cIQITvRjU7AS0gVwpX003ex3FSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLzaZbt0; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLzaZbt0"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f88509dad2so15426717b3.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739508791; x=1740113591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6DzM86FhImPk2pyLp6YfFF0PKNAyeH8MQS6ZXzi6qM=;
        b=OLzaZbt0Mu3io3K8CLJlb3947PBT6BS7Bn5bxAumsvfOiLBu19YuC8GKg8rAQdi5im
         jMYK4Pj70Ozx1BOXEfA+Yxsc1xnkymH2YI45/3cskCKakqoAUtHJLMmu8O2S1qkC6BEr
         xrFwQ8ywViluh4kgTya/WPmVs95WQFymDFWbKBfhIZo3yUJfCGahQbiTZlquSgXn4pfH
         x2xUmk2GENkDeq+Ysu5bcKGoWYH21kTLz8eNLnNVjdRx+zZwegHzC0dmJnQ/d29vFxIm
         GOKFzfd0IQ0LweQ7WDcaEgyEUmN9deTVInyPE2ky4hLCjv2zbRvqx3bnXoBq7ZJb5Zou
         AyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508791; x=1740113591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6DzM86FhImPk2pyLp6YfFF0PKNAyeH8MQS6ZXzi6qM=;
        b=AtEh6X5NuiuCl8ziOATfC7Vn/vR+mUhe4925ITNCChRt1UXlkPH5i5h3gvGZlQiw6T
         zXocBjhSvfnwrpDGj74sqr/AcIVAxSjFkfKpeJHT3L0KaVUuWWsyb/bocSEH8ylm4SkG
         PILX2aSaBq4rO25a3WpE22PQfU4I8Zyz63yO7TZiOHWfzNxEhiyZ/VIRQEptXdG9NURZ
         4AwI9s/ix2tTcHxiFgU/9BvM6VOX//4+VIQnGR9+a8Um698KSQy3mn+NlTRBFBI7ogyl
         L9Xt4wylYPhypqSBpbq1UqONnVhIoa1vLcBDaDVWeA25KucJCrmA+WRF5XWT2i6fMvow
         m2Ng==
X-Gm-Message-State: AOJu0YyynqYGxCmo6Nc9JSdjKeNwmVJZx6UuP81FAHso4Tp68zc98bxU
	kb9+zWM3THhUj9re0gBXMCE+0jOdgQYdHeH7qYhGsYXKMIlRSWqnsFLB252k
X-Gm-Gg: ASbGncup5xiRogsSdEvvpEVPNRc74TbSrI+1/CSoCQQ9lLQCp45E441aNTRA/RXBO05
	otzAla08VrRdzo7IvB8Od42x7NwWlKAa+qnUStVpIRoQsx/WQy9FXlJPbvqplBiW/kXxfbd5aEu
	khexRxifNg3HGLjLy81BNThAQAkLW0k4GV+/wvtf80/zrahxWZKKbzfDgaycNDSu7vZIlyLzthm
	TVTjcaQTJN2PpzIlKL1SfFQWdhWBf3bMiWOMZdfqy64JexLq2NGEvewJELET3ncw1BUSA==
X-Google-Smtp-Source: AGHT+IFXB5wyTU4EOPLvpiEpMIgnBjkngkmXr4lguP1OycEm4kkyO/XTLtXrt5fmDMquV/v9jAENbg==
X-Received: by 2002:a05:690c:b96:b0:6ef:77e3:efe6 with SMTP id 00721157ae682-6fb1f5a69e0mr109044877b3.13.1739508791020;
        Thu, 13 Feb 2025 20:53:11 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fb360a7502sm6200957b3.64.2025.02.13.20.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:53:09 -0800 (PST)
Date: Fri, 14 Feb 2025 12:53:05 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 6/8] packed-backend: add "packed-refs" entry consistency
 check
Message-ID: <Z67MMWCk4fA3hkTk@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z67LkxAFIAeaYr0U@ArchLinux>

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
 Documentation/fsck-msgids.txt |   3 +
 fsck.h                        |   1 +
 refs/packed-backend.c         | 121 +++++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh      |  44 +++++++++++++
 4 files changed, 168 insertions(+), 1 deletion(-)

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
index 692e315e41..5d1dcfec6f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1812,9 +1812,113 @@ static int packed_fsck_ref_header(struct fsck_options *o,
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
@@ -1827,6 +1931,21 @@ static int packed_fsck_ref_content(struct fsck_options *o,
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
 
@@ -1873,7 +1992,7 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	ret = packed_fsck_ref_content(o, packed_ref_content.buf,
+	ret = packed_fsck_ref_content(o, ref_store, packed_ref_content.buf,
 				      packed_ref_content.buf + packed_ref_content.len);
 
 cleanup:
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 30be1982df..058a783cb7 100755
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

