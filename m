Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D038CFFF
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552464; cv=none; b=jzbC0/1gjs9XkF00Al4f285oBApJTqijc1plHdKO/1PQcPmVGeJDoB1hXxroR3QURAHEYYNDHlQl58R+cPSSkImt8SHKQo+Ffr56rFIQWHv2ycVRX5hdREtIRgmCQ0CA3iWKxtNXQ0MM5H/hzOdth4XlP4Us/lXh3ShYi1CzXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552464; c=relaxed/simple;
	bh=bk+2Dti9hk2AXjB7eJ+9SCWkb7H/10/cl0uxbq9+HtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5JI/hmzSUaT6sShl9hYvEyavpvxoTUfQLUXhOwJjRCvCjYq5yskfwrqo4fSoA0C/fePqAelbDxAbZB5c63AOBvNTzfUwBnLBdN5XeRnEXTnv7HH/Xsjdm52obKzHxLIYycIT0kl1JBVqHBuLZ7PUtxx/sWXpVqmtRaVGMBD7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTWpeWW9; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTWpeWW9"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d75ed779bfso1135656a34.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774552462; x=1775157262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOdPYpFvjB6qbh2bPXaJdXwqZfrxaEASiaPndky/PHc=;
        b=OTWpeWW96HAS3l/821I5gq6RM9hSglXuu+6U9a1nu6njI9LY4HoRySmlE5Z0ylNizn
         s4lE2F3GPUAvpKoz55ATS0BIKN/nFmLJdmIOLhZ89PRJ6q25H6xkdCsqngcbzsKIju4Y
         q9p6XsRqx+CfbOMpu+hrngOZxpxMQD7blwhecoNjGTKefLuC0+l0Trz2dfNkoCzSgQH7
         HM47GFDOKRxHXGtxPLPlTU3KVez0J6QYqQFiBD9r8gS4j7SN6wEme06hA6fkqVzTSnSr
         /l4TBZmM0WiJoD3qDIFBMCBzrQW7OK85yVDxo88yk4c0EtpplgKP1DZob/ggzVFT7ioO
         MXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774552462; x=1775157262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QOdPYpFvjB6qbh2bPXaJdXwqZfrxaEASiaPndky/PHc=;
        b=sDV500Ll3s7ppy7FwNjh2dPGnIOYkgXZ6GffIxS5ubeP1uuwbh2kDLIqv2SWlGojl0
         elFJCgdcIPh78zEkJr6gVYG3fZJfkOL/OaXhqSG1JdTWSrNib0Rdj7JVKKtQlzPTb1SJ
         UPGPDWJWX7d/0aZhEjXbMr53HhxBm86TzbLDA3R8NdX9eKMfPkZWEQha6IhtIqNfzdnH
         B/wnRyKqwZsKpjEN51CTCfIXZVPUuN9A1/BNKPN1KFSNcwJS/PCasvWdDIK7PzCoS5rA
         bOghryYeL6vmcvLMbzMJzHc3G/iDGuVkv58gK4OZq49uwi9HP3Hn6InU8Hkk594jDgW7
         mwDA==
X-Gm-Message-State: AOJu0Yy1/UH/JsZeyCYvLBw/j7p1bpSlkAei+H5NKAijdrGTSnN3rf6l
	b17Ki60WWKnve+uFxzGljkfQemdmvtLw/hs0ml9+zdaA36HrCINT9+QGkp/H2w==
X-Gm-Gg: ATEYQzzLhlLblRv58iqcrO+rudvlhhSocBXgJhY8+LFkZ8892KmS2Gmc0roGPomF6Mm
	4qJ3I8xS/eaebOrVV66VfShpDxEnZxZdyHCw8cmRSJVbWOVx0r1H9uiM0m6SK6AjsHYSFkE1Cwg
	D3wMZK2Cvvpy7EhrGl/Rf6ucyNdaEAjNlIme+hqz9c9Dyguar3g8soY9jfPGw3G321o0/vgVTjv
	7xmGWz6FE5/oUsprLOYvwI86cXTyjGU0C60kTNca//lqkGiGW3ZtUsdU0PYKimwA2Jq9RH9bq3l
	d6AC2WY9UtC6tBiO9+Vi9aZ/EwYXRsxJZ6OZDV3/KEzYFSjuSKs+kjyvl/O6TXpG7AmhaOoECQ8
	CN2ypXqVk18wbM+GQIp6epd9mremlVNyDjWNOhRbcBEFcWAxEMbgREbnaOAMKDQ9xquP9qQTWge
	TLJdg28//qFjGrlh3XTzNDjGHSqnxY06Y=
X-Received: by 2002:a05:6830:8d2:b0:7d7:f584:f381 with SMTP id 46e09a7af769-7d9d67fa510mr4906433a34.14.1774552462155;
        Thu, 26 Mar 2026 12:14:22 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e71f5ab2sm2946689a34.18.2026.03.26.12.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 12:14:21 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/5] fast-import: add 'abort-if-invalid' mode to '--signed-commits=<mode>'
Date: Thu, 26 Mar 2026 14:14:11 -0500
Message-ID: <20260326191414.3783974-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260326191414.3783974-1-jltobler@gmail.com>
References: <20260326191414.3783974-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The '--signed-commits=<mode>' option for git-fast-import(1) configures
how signed commits are handled when encountered. In cases where an
invalid commit signature is encountered, a user may wish to abort the
operation entirely. Introduce an 'abort-if-invalid' mode to do so.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-fast-import.adoc |  2 ++
 builtin/fast-export.c              |  2 +-
 builtin/fast-import.c              | 10 +++++++++-
 gpg-interface.c                    |  2 ++
 gpg-interface.h                    |  1 +
 t/t9305-fast-import-signatures.sh  | 10 +++++++++-
 6 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index b3f42d4637..288f2b2a7e 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -90,6 +90,8 @@ already trusted to run their own code.
   commit signatures and replaces invalid signatures with newly created ones.
   Valid signatures are left unchanged. If `<keyid>` is provided, that key is
   used for signing; otherwise the configured default signing key is used.
+* `abort-if-invalid` will make this program die when encountering a signed
+  commit that is unable to be verified.
 
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a30fb90b6e..2eb43a28da 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -65,7 +65,7 @@ static int parse_opt_sign_mode(const struct option *opt,
 		return 0;
 
 	if (parse_sign_mode(arg, val, NULL) || (*val == SIGN_STRIP_IF_INVALID) ||
-	    (*val == SIGN_SIGN_IF_INVALID))
+	    (*val == SIGN_SIGN_IF_INVALID) || (*val == SIGN_ABORT_IF_INVALID))
 		return error(_("unknown %s mode: %s"), opt->long_name, arg);
 
 	return 0;
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9fc6c35b74..08ea27242d 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2892,6 +2892,9 @@ static void handle_signature_if_invalid(struct strbuf *new_data,
 	ret = verify_commit_buffer(tmp_buf.buf, tmp_buf.len, &signature_check);
 
 	if (ret) {
+		if (mode == SIGN_ABORT_IF_INVALID)
+			die(_("aborting due to invalid signature"));
+
 		warn_invalid_signature(&signature_check, msg->buf, mode);
 
 		if (mode == SIGN_SIGN_IF_INVALID) {
@@ -2983,6 +2986,7 @@ static void parse_new_commit(const char *arg)
 		case SIGN_VERBATIM:
 		case SIGN_STRIP_IF_INVALID:
 		case SIGN_SIGN_IF_INVALID:
+		case SIGN_ABORT_IF_INVALID:
 			import_one_signature(&sig_sha1, &sig_sha256, v);
 			break;
 
@@ -3068,7 +3072,8 @@ static void parse_new_commit(const char *arg)
 			encoding);
 
 	if ((signed_commit_mode == SIGN_STRIP_IF_INVALID ||
-	     signed_commit_mode == SIGN_SIGN_IF_INVALID) &&
+	     signed_commit_mode == SIGN_SIGN_IF_INVALID ||
+	     signed_commit_mode == SIGN_ABORT_IF_INVALID) &&
 	    (sig_sha1.hash_algo || sig_sha256.hash_algo))
 		handle_signature_if_invalid(&new_data, &sig_sha1, &sig_sha256,
 					    &msg, signed_commit_mode);
@@ -3115,6 +3120,9 @@ static void handle_tag_signature(struct strbuf *msg, const char *name)
 	case SIGN_ABORT:
 		die(_("encountered signed tag; use "
 		      "--signed-tags=<mode> to handle it"));
+	case SIGN_ABORT_IF_INVALID:
+		die(_("'abort-if-invalid' is not a valid mode for "
+		      "git fast-import with --signed-tags=<mode>"));
 	case SIGN_STRIP_IF_INVALID:
 		die(_("'strip-if-invalid' is not a valid mode for "
 		      "git fast-import with --signed-tags=<mode>"));
diff --git a/gpg-interface.c b/gpg-interface.c
index d517425034..dafd5371fa 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1164,6 +1164,8 @@ int parse_sign_mode(const char *arg, enum sign_mode *mode, const char **keyid)
 		*mode = SIGN_WARN_STRIP;
 	} else if (!strcmp(arg, "strip")) {
 		*mode = SIGN_STRIP;
+	} else if (!strcmp(arg, "abort-if-invalid")) {
+		*mode = SIGN_ABORT_IF_INVALID;
 	} else if (!strcmp(arg, "strip-if-invalid")) {
 		*mode = SIGN_STRIP_IF_INVALID;
 	} else if (!strcmp(arg, "sign-if-invalid")) {
diff --git a/gpg-interface.h b/gpg-interface.h
index a365586ce1..3d95f5ec14 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -115,6 +115,7 @@ void print_signature_buffer(const struct signature_check *sigc,
 /* Modes for --signed-tags=<mode> and --signed-commits=<mode> options. */
 enum sign_mode {
 	SIGN_ABORT,
+	SIGN_ABORT_IF_INVALID,
 	SIGN_WARN_VERBATIM,
 	SIGN_VERBATIM,
 	SIGN_WARN_STRIP,
diff --git a/t/t9305-fast-import-signatures.sh b/t/t9305-fast-import-signatures.sh
index 18707b3f6c..5667693afd 100755
--- a/t/t9305-fast-import-signatures.sh
+++ b/t/t9305-fast-import-signatures.sh
@@ -103,7 +103,7 @@ test_expect_success RUST,GPG 'strip both OpenPGP signatures with --signed-commit
 	test_line_count = 2 out
 '
 
-for mode in strip-if-invalid sign-if-invalid
+for mode in strip-if-invalid sign-if-invalid abort-if-invalid
 do
 	test_expect_success GPG "import commit with no signature with --signed-commits=$mode" '
 		git fast-export main >output &&
@@ -135,6 +135,14 @@ do
 		# corresponding `data <length>` command would have to be changed too.
 		sed "s/OpenPGP signed commit/OpenPGP forged commit/" output >modified &&
 
+		if test "$mode" = abort-if-invalid
+		then
+			test_must_fail git -C new fast-import --quiet \
+				--signed-commits=$mode <modified >log 2>&1 &&
+			test_grep "aborting due to invalid signature" log &&
+			return 0
+		fi &&
+
 		git -C new fast-import --quiet --signed-commits=$mode <modified >log 2>&1 &&
 
 		IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
-- 
2.53.0.381.g628a66ccf6

