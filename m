Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F221F1517
	for <git@vger.kernel.org>; Mon, 26 May 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255628; cv=none; b=GzoUWGRsEg1u2PsJeT0FmusupXQ91q6pblmLcadowZemX1h7EpUDRUPLovtb5ZlZLEonannJw0pWTwFic3qPHQ6ZRyYxvziilnxlRhCPhOlLmdDOh/3cl4n3pJ8Qfe0qIQZtDImZh+1eC+5s+0tZdf7/RpHQfVkZuQhV0SAXi8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255628; c=relaxed/simple;
	bh=x9epfnHKYPoCXQscCVdGMf8TpUs0dqkZv0dUtVAsAkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoPyHofe3/K7+ZwMypH1oPv5QwGaBvTsLjEanvvJvog+vKStp4jNLvFepwiXYdvSAOiMRb19M+i5d3eRRc0nT4t/gwIr6ZyrLMMBLMGoP1fxO9fhxX+L8JftILeWkfUTsB5CPJx4gJHh/CmCMx150dRPrSqv3vd7o8wwbn3IHJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asQLTvZy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asQLTvZy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a35c894313so2084426f8f.2
        for <git@vger.kernel.org>; Mon, 26 May 2025 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255624; x=1748860424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE63EYeuFDVtj2J7wu8J6TC6kO6O4uA2CP7eRRYWhqw=;
        b=asQLTvZy+vTrNmgL4LCgL5luJ5rsVmUwK7olxL8gt/uQiz5xR8flWMvdVDYr3LqGQN
         vrrCEfWUfSgcRpqcOXoabYq84yFpldiSTuxb7FsigJGAM0ocSs8I1Vf0nPLK9YKpkqxf
         mtAL15nYmqHDMvGvTmWe0FfDdX5TdYoIQxvAMb/s1U33R8ZjAHajduye4HMgssHDlcNG
         5Gu2OMOAfTyipCnl0zhReMgp3Lhlx2izqUdD9ztkduNkZ/iOHGu652Tv0TDr12Rvk8nH
         4bI6IFhIKYpqypGOGcmoxsN1BWNa0qmpCQhdC8doXLw8Ynmt0xUL4hA2pKHIbC4HIS0f
         8gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255624; x=1748860424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kE63EYeuFDVtj2J7wu8J6TC6kO6O4uA2CP7eRRYWhqw=;
        b=QoA/E8aS+HaBFdRdI1yZdqWxUnzHo7FxZio2NFlmqu+DktSKojwBd6R7R7hwF9AtvA
         rI6v4N8PzYQxKiHYBFfksVVaz5nZeEA7ddvdJ9emtDmI6uDcmErWPlk3+LLrnDqzQeIV
         H+esa0BkFuzr5yDjdruc1o1JE6yeDJlzaB5jXqM3k2MhryLp316r83dr7TK/ARimQmMn
         pIr6hwh2stp0nmrMJ6z9kjKcATysh+mWZ4y3o4+VDMiFIa+YlgmhYwbTU1KbPwzt67ct
         X/VqgdMh0HaNieMtQ8AazLvmy42E31BT8qRUGeKp2Kn+gRAZ+XD++j/FhzcM4hG1WGS6
         iU4g==
X-Gm-Message-State: AOJu0Yy+vc0WyrADM+zvMjs0MdSerL70lGkp+SPKUbmPVMsr8ukgtWFS
	XUxbT02iqThsN0ARFAZHBB5Mo8M0RVGLnehrrO5pKLU3SzV/CjNk0BRtYPCFGXFy
X-Gm-Gg: ASbGnct6EB72h9c4WbktDhczjsrJdGKcpR4IUiLHq+9qRSnx6AN+01EzvEkBA7hfBFW
	Upgyj4sb0F02g8uxlXrfjs05jjXg0LJNz5Vc7ym6GClYaAKkhQ+9FLiq0/9b2DVYfACl/AxKSKj
	ym7cqSIGCWY1Xb5iLYlga3jNn6kE7YkWOc/X/6SAnMmpzUfMv7eOeqGI5vRMGXTPPUOXHhqbnZD
	BM5rKAW2USN7eH/Uo8WqfGrNAmtH/HiUM3vm4MttByKLASCcQa20yV2jChFaSy0ppngpIg5vnph
	+WLYr6OpX3fOZuD0rCD1rKLvC0M9RdTthtHeDWVzCDC7L7PdMA1bdHc63oNyqXrVfEudCag9aO+
	pzG2u/Hn5Xrvy0jHN20QhKmkgG8VMmnF8PoTf4fKqwsyIWjQ=
X-Google-Smtp-Source: AGHT+IHufl9JKVsuTVZnct0ZAVP57q1lIwoagvvMIj7wjf+/ENJK2nEW06E7wqLAIqF/pv2bsLgdcw==
X-Received: by 2002:a05:6000:1886:b0:3a3:7085:cb2d with SMTP id ffacd0b85a97d-3a4cb4b83e4mr6681531f8f.40.1748255623793;
        Mon, 26 May 2025 03:33:43 -0700 (PDT)
Received: from christian--20230123--2G7D3.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d26caf92sm5071512f8f.66.2025.05.26.03.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:33:42 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 6/6] verify-commit: add a --summary flag
Date: Mon, 26 May 2025 12:33:14 +0200
Message-ID: <20250526103314.1542316-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.614.g649fb04ae6
In-Reply-To: <20250526103314.1542316-1-christian.couder@gmail.com>
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <20250526103314.1542316-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current outputs, with `--raw`, `--verbose` or by default, from
`git verify-commit` are all quite verbose and do not make it easy to
quickly assess signature status.

Let's add a new `--summary` option to `git verify-commit` that prints
a concise, one-line summary of the signature verification to standard
output.

This compact format is useful for scripts and tools that need to
quickly parse signature verification results, while still being
human-readable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-verify-commit.adoc | 17 ++++++++++++++++-
 builtin/verify-commit.c              |  4 +++-
 gpg-interface.c                      | 11 +++++++++++
 gpg-interface.h                      |  6 ++++++
 t/t7510-signed-commit.sh             | 24 ++++++++++++++++++++++++
 t/t7528-signed-commit-ssh.sh         | 28 ++++++++++++++++++++++++++++
 6 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-verify-commit.adoc b/Documentation/git-verify-commit.adoc
index 6a208a0c2a..fb038ae0cf 100644
--- a/Documentation/git-verify-commit.adoc
+++ b/Documentation/git-verify-commit.adoc
@@ -8,7 +8,7 @@ git-verify-commit - Check the signature of commits
 SYNOPSIS
 --------
 [verse]
-'git verify-commit' [-v | --verbose] [--raw] <commit>...
+'git verify-commit' [-v | --verbose] [--raw] [--summary] <commit>...
 
 DESCRIPTION
 -----------
@@ -38,6 +38,21 @@ OPTIONS
 	error instead of the normal human-readable output. The format
 	of this output is specific to the signature format being used.
 
+--summary::
+	Print a one-line human-readable summary of the signature check
+	to standard output in the format: `STATUS FORMAT ALGORITHM`.
++
+STATUS is the result character (e.g., G, B, E, U, N, ...) shown by the
+"%G?" pretty format specifier. See the "Pretty Formats" section in
+linkgit:git-log[1].
++
+FORMAT indicates the signature format (`openpgp`, `x509`, or `ssh`) or
+`?` if unknown.
++
+ALGORITHM is the hash algorithm used for GPG/GPGSM signatures
+(e.g. `sha1`, `sha256`, ...), or the key type for SSH signatures
+(`RSA`, `ECDSA`, `ED25519`, ...), or `?` if unknown.
+
 -v::
 --verbose::
 	Print the contents of the commit object before validating it.
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 5f749a30da..54b5b7d360 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -14,7 +14,7 @@
 #include "gpg-interface.h"
 
 static const char * const verify_commit_usage[] = {
-		N_("git verify-commit [-v | --verbose] [--raw] <commit>..."),
+		N_("git verify-commit [-v | --verbose] [--raw] [--summary] <commit>..."),
 		NULL
 };
 
@@ -27,6 +27,7 @@ static int run_gpg_verify(struct commit *commit, unsigned flags)
 
 	ret = check_commit_signature(commit, &signature_check);
 	print_signature_buffer(&signature_check, flags);
+	print_signature_summary(&signature_check, flags);
 
 	signature_check_clear(&signature_check);
 	return ret;
@@ -60,6 +61,7 @@ int cmd_verify_commit(int argc,
 	const struct option verify_commit_options[] = {
 		OPT__VERBOSE(&verbose, N_("print commit contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
+		OPT_BIT(0, "summary", &flags, N_("print concise signature verification summary"), GPG_VERIFY_SUMMARY),
 		OPT_END()
 	};
 
diff --git a/gpg-interface.c b/gpg-interface.c
index 182e579769..fc198715c4 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -153,6 +153,7 @@ void signature_check_clear(struct signature_check *sigc)
 	FREE_AND_NULL(sigc->key);
 	FREE_AND_NULL(sigc->fingerprint);
 	FREE_AND_NULL(sigc->primary_key_fingerprint);
+	FREE_AND_NULL(sigc->format_name);
 	FREE_AND_NULL(sigc->sig_algo);
 }
 
@@ -756,6 +757,8 @@ int check_signature(struct signature_check *sigc,
 	if (!fmt)
 		die(_("bad/incompatible signature '%s'"), signature);
 
+	sigc->format_name = xstrdup(fmt->name);
+
 	if (parse_payload_metadata(sigc))
 		return 1;
 
@@ -782,6 +785,14 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 		fputs(output, stderr);
 }
 
+void print_signature_summary(const struct signature_check *sigc, unsigned flags)
+{
+	if (flags & GPG_VERIFY_SUMMARY)
+		printf("%c %s %s\n", sigc->result,
+		       sigc->format_name ? sigc->format_name : "?",
+		       sigc->sig_algo ? sigc->sig_algo : "?");
+}
+
 size_t parse_signed_buffer(const char *buf, size_t size)
 {
 	size_t len = 0;
diff --git a/gpg-interface.h b/gpg-interface.h
index 2b7701ca2c..a9565757f6 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -6,6 +6,7 @@ struct strbuf;
 #define GPG_VERIFY_VERBOSE	(1<<0)
 #define GPG_VERIFY_RAW		(1<<1)
 #define GPG_VERIFY_OMIT_STATUS	(1<<2)
+#define GPG_VERIFY_SUMMARY	(1<<3)
 
 enum signature_trust_level {
 	TRUST_UNDEFINED,
@@ -43,6 +44,9 @@ struct signature_check {
 	char *fingerprint;
 	char *primary_key_fingerprint;
 
+	/* "openpgp", "x509", "ssh" */
+	char *format_name;
+
 	/* hash algo for GPG/GPGSM, key type for SSH */
 	char *sig_algo;
 
@@ -95,5 +99,7 @@ int check_signature(struct signature_check *sigc,
 		    const char *signature, size_t slen);
 void print_signature_buffer(const struct signature_check *sigc,
 			    unsigned flags);
+void print_signature_summary(const struct signature_check *sigc,
+			     unsigned flags);
 
 #endif
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 39677e859a..47f40862f3 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -232,6 +232,30 @@ test_expect_success GPG2 'bare signature' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'verify signatures with --summary' '
+	# GPG-signed commit
+	git verify-commit --summary sixth-signed >actual &&
+	test_grep "^G openpgp sha1" actual &&
+
+	# Non-signed commit
+	test_must_fail git verify-commit --summary seventh-unsigned >actual 2>&1 &&
+	test_grep "^N ? ?" actual &&
+
+	# Trusted signature with alternate key (hash used might depend on the OS)
+	git verify-commit --summary eighth-signed-alt >actual &&
+	test_grep -E "^G openpgp sha(256|512)" actual &&
+
+	# Bad signature
+	test_must_fail git verify-commit --summary $(cat forged1.commit) >actual 2>err &&
+	test_grep "^B openpgp ?" actual
+'
+
+test_expect_success GPG '--summary and --raw work together' '
+	git verify-commit --summary --raw sixth-signed >actual 2>err &&
+	test_grep "^G openpgp sha1" actual &&
+	test_grep "GOODSIG" err
+'
+
 test_expect_success GPG 'show good signature with custom format' '
 	cat >expect <<-\EOF &&
 	G
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 065f780636..3d0e7d7859 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -277,6 +277,34 @@ test_expect_success GPGSSH 'detect fudged signature with NUL' '
 	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual2
 '
 
+test_expect_success GPGSSH 'verify-commit --summary outputs format and key type for SSH signatures' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+
+	# SSH-signed commit with ED25519 key
+	git verify-commit --summary sixth-signed >actual &&
+	test_grep "^G ssh ED25519" actual &&
+
+	# SSH-signed commit with ECDSA key
+	git verify-commit --summary thirteenth-signed-ecdsa >actual &&
+	test_grep "^G ssh ECDSA" actual &&
+
+	# Non-signed commit
+	test_must_fail git verify-commit --summary seventh-unsigned >actual 2>&1 &&
+	test_grep "^N ? ?" actual &&
+
+	# Bad signature
+	test_must_fail git verify-commit --summary $(cat forged1.commit) >actual 2>err &&
+	test_grep "^B ssh ?" actual
+'
+
+test_expect_success GPGSSH '--summary and --raw work together' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+
+	git verify-commit --summary --raw sixth-signed >actual 2>err &&
+	test_grep "^G ssh ED25519" actual &&
+	test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" err
+'
+
 test_expect_success GPGSSH 'amending already signed commit' '
 	test_config gpg.format ssh &&
 	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
-- 
2.49.0.609.g63c55177e5

