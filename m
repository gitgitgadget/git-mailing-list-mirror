Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207B3A256C
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389335; cv=none; b=ou0VvbZRX/Yxf/0cxVWwbKZ/b/n49BdJeeW6P2hI7HSsUzum61plRju9l8dTlAbcDz7a77pmVFQVsmccw7NsQCsgyhKvxUz5NHYnR5W2pllcjV4/ZFl0DF8i2pZqdx0kTJLK/PZmksMcevGivhZ1ctvjrY7lKKnLasaRSEGGnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389335; c=relaxed/simple;
	bh=k3GNZCP03lCA/aU+5eN0BMp2XgkXv3shORoRXtbAXdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbf+BGxuTta6f7ujPF0UqPQ+riMHdog5Xo0cwb4vIqAFoWKuAs+Jh5NpxAm01E3aZz8vXyb94HuTP3l6nxVG+7k248owbFmowaHlTSdp58m1M9DLLTLbWEOtDDhZKRT6V4O35Q3OM5ubaHa3YfNlw6sJP+/0KEYi5erUUiCXuls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVHgiEOM; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVHgiEOM"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-467161c4ba7so217305b6e.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774389333; x=1774994133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB7qEirQI68/xV7sM+xUMpBcaJxtFIUVbjqO6rW/1Oo=;
        b=NVHgiEOMxJe3WzJ3KuodVNBN6GVylpGYYYv2jayUg82x7kAyS0gQ4paqUAQj5ehIpX
         Q3UIZqsduLXz89KBw4cJUWHO3IHO56n7SBWvWczV+6RVhAZXyiQ6kPnX//WSVbaA7KqW
         SxcdWNcAlJyrizcP2poIWBURwiRIKxeyNFbpFxp1MPmTcbVj94rGcqJZbyCjE8HAwAEC
         X1U59GucBgvhRfDTPmEZLb+HOS+QP55RaHA/gJBY2/tqv3kOuEEWKg01URRUkUajNlcV
         GpnEOEQYQBZERK7XmrayjhGHPgWtQFLY/XXoqpiJpXRXtD/iGq37euW+0Zzuo32NhmX0
         5Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389333; x=1774994133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iB7qEirQI68/xV7sM+xUMpBcaJxtFIUVbjqO6rW/1Oo=;
        b=mx1ZvRU8paASmuOLtJ8WKl7lk85LJwIRyGvfe0ZtK7ZSaa72p/y/DiHiPINsTm2F6+
         PV3PM8xY2ylkjJT5qRwdqx1vPBywAJaB5HAU4rmYs8Xac/7U7nS1Bw7Oi9fIv3fAnQLl
         iqSNy01uJ3+1YhQrMDPcsF3bzWHdpil/VJih+s0b6S6ugazLFK1R9jx4KwC4pEKvyLkK
         T4MycPLDyAfCkGaV3p74UEg6AoPXTFKxU/+Pp9kK19dcoK87S662mGQ3zQ+1vlyqZ338
         ciA3pqeghSzlWijBlgG+lgQT4pyZWznQMcx2VJqpl5ZHGCTexq/7t1PEp6Q5W9+vvg5m
         GGhA==
X-Gm-Message-State: AOJu0YwWOmswRXhxAL8ZAyNb5X1QjOeCB0ts2S6IXHU9PWx0QPo6ZxMN
	VPoNDVJv3DFlPqmYhEfX7Ya6phti8LwO85TDRS3c3OiENJpZXyMcJ4fzqGoT3Q==
X-Gm-Gg: ATEYQzxsfbIjeEdkyaQBnPWnn9PP+fdr4VB0p1kukgBwe6de++zQlsberDaZ3vFSKkJ
	HQoVj9tQogh+umJIR8AihctJOF4BR7oH2TlUErhYbkFwSJSMycEDIIrH4WkJXoGEqCdwlshjsLE
	LtBDQpxru4u4TnAaS8KRIUa0pnQRmMG0ocn2QGiO29EeSYkIHGnyMXRYn6JQALBxtY2K0Z6DXM+
	YuK0Q41uyNvzKGRgmopVaWs1pWU6jXUhMq9jCfh2Ap8150CLeDQ0tL6qlZ8AflVd79bVQZN7+8W
	MfDFqYuC9UXfj7Yuoz9J2zGXj/D0blRlQcGf8ZtGFG8Lg26n6q9l7Hte37QVpX4fF4SfkKQe+sa
	vPLMOIYhOuURoaNDs4YpPuMu+gzWKqFhVVnj0MWUhH/3AI8Mo0Gali2BQPXA3TZiB+jzIvg+bYR
	InDpjVWqA8DiVkhvEWkuTD/TZhxbyOpKPUJFqmNPKhMA==
X-Received: by 2002:a05:6808:509e:b0:467:fb12:c9f6 with SMTP id 5614622812f47-46a0cdc14b5mr2980301b6e.14.1774389332987;
        Tue, 24 Mar 2026 14:55:32 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c149103b0sm12391697fac.5.2026.03.24.14.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 14:55:32 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 4/4] fast-import: add 'abort-if-invalid' mode to '--signed-tags=<mode>'
Date: Tue, 24 Mar 2026 16:55:13 -0500
Message-ID: <20260324215513.764739-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260324215513.764739-1-jltobler@gmail.com>
References: <20260324215513.764739-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In git-fast-import(1), the 'abort-if-invalid' mode for the
'--signed-commits' option verifies commit signatures during import and
aborts the entire operation when verification fails. Extend the same
behavior to signed tag objects by introducing an 'abort-if-invalid' mode
for the '--signed-tags' option.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/fast-import.c              |  7 ++++---
 t/t9306-fast-import-signed-tags.sh | 10 +++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 783e0e7ab4..cd1181023d 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3109,6 +3109,9 @@ static void handle_tag_signature_if_invalid(struct strbuf *buf,
 	if (!check_signature(&sigc, signature.buf, signature.len))
 		goto out;
 
+	if (signed_tag_mode == SIGN_ABORT_IF_INVALID)
+		die(_("aborting due to invalid signature"));
+
 	strbuf_setlen(msg, sig_offset);
 
 	if (signed_tag_mode == SIGN_SIGN_IF_INVALID) {
@@ -3156,6 +3159,7 @@ static void handle_tag_signature(struct strbuf *buf, struct strbuf *msg, const c
 		/* Truncate the buffer to remove the signature */
 		strbuf_setlen(msg, sig_offset);
 		break;
+	case SIGN_ABORT_IF_INVALID:
 	case SIGN_SIGN_IF_INVALID:
 	case SIGN_STRIP_IF_INVALID:
 		handle_tag_signature_if_invalid(buf, msg, sig_offset);
@@ -3165,9 +3169,6 @@ static void handle_tag_signature(struct strbuf *buf, struct strbuf *msg, const c
 	case SIGN_ABORT:
 		die(_("encountered signed tag; use "
 		      "--signed-tags=<mode> to handle it"));
-	case SIGN_ABORT_IF_INVALID:
-		die(_("'abort-if-invalid' is not a valid mode for "
-		      "git fast-import with --signed-tags=<mode>"));
 	default:
 		BUG("invalid signed_tag_mode value %d from tag '%s'",
 		    signed_tag_mode, name);
diff --git a/t/t9306-fast-import-signed-tags.sh b/t/t9306-fast-import-signed-tags.sh
index bb4c8008ef..ec2b241cdb 100755
--- a/t/t9306-fast-import-signed-tags.sh
+++ b/t/t9306-fast-import-signed-tags.sh
@@ -77,7 +77,7 @@ test_expect_success GPGSSH 'import SSH signed tag with --signed-tags=strip' '
 	test_grep ! "SSH SIGNATURE" out
 '
 
-for mode in strip-if-invalid sign-if-invalid
+for mode in strip-if-invalid sign-if-invalid abort-if-invalid
 do
 	test_expect_success GPG "import tag with no signature with --signed-tags=$mode" '
 		test_when_finished rm -rf import &&
@@ -112,6 +112,14 @@ do
 		# `data <length>` command would have to be changed too.
 		sed "s/OpenPGP signed tag/OpenPGP forged tag/" output >modified &&
 
+		if test "$mode" = abort-if-invalid
+		then
+			test_must_fail git -C import fast-import --quiet \
+				--signed-tags=$mode <modified >log 2>&1 &&
+			test_grep "aborting due to invalid signature" log &&
+			return 0
+		fi &&
+
 		git -C import fast-import --quiet --signed-tags=$mode <modified >log 2>&1 &&
 
 		IMPORTED=$(git -C import rev-parse --verify refs/tags/openpgp-signed) &&
-- 
2.53.0.381.g628a66ccf6

