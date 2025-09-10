Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A9A1EF09D
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491756; cv=none; b=EUteC6b5wdog48ZEEgARMLVZBgbINaOoZSV/yHvw3/EUz0G/gGRV+ePAjlGrGZ+aFoRQYWQUDZAg9DFEbsmtvkervzerXngioTc8usRd6D7V0ZmWwuKcF/XoA7LuFY4PVsiQiIKbAwXtp1ZDQBM2OHLOyaXGErW3a61RDRY9SPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491756; c=relaxed/simple;
	bh=hDeGvpdMh+qhRLin6NuqTjGW81MLUn09+rwuipQmBV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrCSy0Kzu5ZKBv1EE5wTo5UgMN0zsTa57HuIXHY90JFGaFi2n7eGaMSfOMVVai1sZSBK1xOc6siBNr/wipq5pbSnYZfQ8MjFPcSrebub+A7nz9iDKpXbB6FM5W65wN/DcmgMlO3gjg9DqGIPvi1IUfpyBe+U7aFy4kb41sKSlhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1g3wyeo; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1g3wyeo"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso5416757f8f.3
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 01:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757491752; x=1758096552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V256A90CNAcgng2ATYNReANVdyhPcjbgasBaaC/m1ic=;
        b=K1g3wyeoBXkTX73dPowGz+TY843fXhEibiLdm/ggtTk2T+tS3lrLoRJm8qLX4iPNeM
         noHjORaT+PHqetw4nelZgvcA/5cxysWaLWwi9+yleh0t7XT8i7WQDFGlDMQuHwo49S++
         zr6+fiWsR6ZSmyuVT4vP4sqMI7i4I0IGNso2zrzB1Rlwp2CW+VuPCmaTcJGxxJd6NNrR
         JgJ57kki4xj8wtv5CXfFsLSb7rH2hKWdE7bWBtqGO8NPDPrh0ABHbD0uFDv7VmADKq4r
         Q4MsEZPdJx5C4aPjWsOruzR63Uxb3NSlsGAIpR4I9lsD4IHNDThqg79B98qYz7OU0x6y
         20QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491752; x=1758096552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V256A90CNAcgng2ATYNReANVdyhPcjbgasBaaC/m1ic=;
        b=K/WX0lyrCq5BYyZYdE21Pa/SyqIfvbN9RKpOhU6k1rMYDV+ElMxP6f6Lry0Yt6deM+
         QGiUK61zBPaSQoQhr4WsIiqaxGy0VHf4gpRUpQZ5A94zRaQ+S/bDza3WTjaFr7o/oGMm
         MnctWmywlJhoaQOkH3mAWCdm5vi65+gqh7ifmT5mcZ2c0XumHzZFwvxeZyYWbtumtZuL
         ERBlrGZEludzVNMzhLqQWHoPC0FOUYPz822Z9vLbcSRog41oXmiIeU6sMp+xDGhGxPuL
         5bZbgpyspvd6UFdgMR1/MHiTiC42S8+2ctlLNy2aqv1/tq25jtsrH/LN8nVTif3HuakU
         krpQ==
X-Gm-Message-State: AOJu0YwCk9DdyZ4h8KxRDU1geS3MncSiALb9uXRDDeUM5XigsfwhJ2Kq
	PPaCRhNJo/s9RCZKMxiT/GbDAZaKpRlc6UZvp9r21mcF+BOAR21jb/k4V6DZ7g==
X-Gm-Gg: ASbGncvtpjTeh03ImY5VoHC07oA1BzhnJD0Bo9ZHA+pz44FTxQuD613ZMRUBrfkz8S+
	vSD5qANcBCb7j1y+X8u4O4hZMg9Q8WItE/dAYU+Ryrddi9nMwz85L6MVa/4Ri2saeajA8OxsvSo
	SvAmMOIrM5iAjsU8gGiDRQ4JGJoCQXPV1/hhnm4MYPR3wY7mncWeT2Uiixt0heR43B3G3A893yV
	NAZYzExQECmhs9MV4/V7FLd2WWEfCEu6FB1TBc+EdoHAxFjE+CLHzBeJkmEMgdDz3J5YzSjnz9K
	GvtbJ/Y/6If9j8EsLNU6yHhdg1tR6DpFDRzAEyL9zKdbm1DUn+S0U/xG4yO+tK2MGxgnOkAglpo
	qkjYCHbeh8bykSu77uWSVwvf3iWq1RT9UhXdHsBTgdbS/91O4QP18auA+uvyL+aJC+41kHSG7rQ
	zjRZ5M
X-Google-Smtp-Source: AGHT+IE8e7TGLTpDc9IERqU+rrct2axWqkze0YbRB0p8ubotc6K3vS2MHyX5AyDzmwrhIy4oau3WKQ==
X-Received: by 2002:a05:6000:2312:b0:3d3:494b:4e5d with SMTP id ffacd0b85a97d-3e629f1faf0mr10874566f8f.0.1757491751579;
        Wed, 10 Sep 2025 01:09:11 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df820d686sm17965735e9.10.2025.09.10.01.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:09:10 -0700 (PDT)
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
Subject: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
Date: Wed, 10 Sep 2025 10:08:39 +0200
Message-ID: <20250910080839.2142651-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.195.g61112aeac3
In-Reply-To: <20250910080839.2142651-1-christian.couder@gmail.com>
References: <20250910080839.2142651-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A '--signed-commits=<mode>' option is already available when using
`git fast-export` to decide what should be done at export time about
commit signatures. At import time though, there is no option, or
other way, in `git fast-import` to decide about commit signatures.

To remediate that, let's add a '--signed-commits=<mode>' option to
`git fast-import` too.

For now the supported <mode>s are the same as those supported by
`git fast-export`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-import.adoc |   5 ++
 builtin/fast-import.c              |  55 +++++++++++----
 t/meson.build                      |   1 +
 t/t9305-fast-import-signatures.sh  | 108 +++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+), 12 deletions(-)
 create mode 100755 t/t9305-fast-import-signatures.sh

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 3144ffcdb6..90f242d058 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -66,6 +66,11 @@ OPTIONS
 	remote-helpers that use the `import` capability, as they are
 	already trusted to run their own code.
 
+--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
+	Specify how to handle signed commits.  Behaves in the same way
+	as the same option in linkgit:git-fast-export[1], except that
+	default is 'verbatim' (instead of 'abort').
+
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 2c35f9345d..f932dd2c65 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -188,6 +188,8 @@ static int global_argc;
 static const char **global_argv;
 static const char *global_prefix;
 
+static enum sign_mode signed_commit_mode = SIGN_VERBATIM;
+
 /* Memory pools */
 static struct mem_pool fi_mem_pool = {
 	.block_alloc = 2*1024*1024 - sizeof(struct mp_block),
@@ -2785,6 +2787,23 @@ static void store_signature(struct signature_data *stored_sig,
 	}
 }
 
+/* Process signatures (up to 2: one "sha1" and one "sha256") */
+static void import_signature(struct signature_data *sig_sha1,
+			     struct signature_data *sig_sha256,
+			     const char *v)
+{
+	struct signature_data sig = { NULL, NULL, STRBUF_INIT };
+
+	parse_one_signature(&sig, v);
+
+	if (!strcmp(sig.hash_algo, "sha1"))
+		store_signature(sig_sha1, &sig, "SHA-1");
+	else if (!strcmp(sig.hash_algo, "sha256"))
+		store_signature(sig_sha256, &sig, "SHA-256");
+	else
+		BUG("parse_one_signature() returned unknown hash algo");
+}
+
 static void parse_new_commit(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
@@ -2817,19 +2836,28 @@ static void parse_new_commit(const char *arg)
 	if (!committer)
 		die("Expected committer but didn't get one");
 
-	/* Process signatures (up to 2: one "sha1" and one "sha256") */
 	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
-		struct signature_data sig = { NULL, NULL, STRBUF_INIT };
-
-		parse_one_signature(&sig, v);
-
-		if (!strcmp(sig.hash_algo, "sha1"))
-			store_signature(&sig_sha1, &sig, "SHA-1");
-		else if (!strcmp(sig.hash_algo, "sha256"))
-			store_signature(&sig_sha256, &sig, "SHA-256");
-		else
-			BUG("parse_one_signature() returned unknown hash algo");
-
+		struct strbuf data = STRBUF_INIT;
+		switch (signed_commit_mode) {
+		case SIGN_ABORT:
+			die("encountered signed commit; use "
+			    "--signed-commits=<mode> to handle it");
+		case SIGN_WARN_VERBATIM:
+			warning("importing a commit signature");
+			/* fallthru */
+		case SIGN_VERBATIM:
+			import_signature(&sig_sha1, &sig_sha256, v);
+			break;
+		case SIGN_WARN_STRIP:
+			warning("stripping a commit signature");
+			/* fallthru */
+		case SIGN_STRIP:
+			/* Read signature data and discard it */
+			read_next_command();
+			parse_data(&data, 0, NULL);
+			strbuf_release(&data);
+			break;
+		}
 		read_next_command();
 	}
 
@@ -3501,6 +3529,9 @@ static int parse_one_option(const char *option)
 		option_active_branches(option);
 	} else if (skip_prefix(option, "export-pack-edges=", &option)) {
 		option_export_pack_edges(option);
+	} else if (skip_prefix(option, "signed-commits=", &option)) {
+		if (parse_sign_mode(option, &signed_commit_mode))
+			die("unknown --signed-commits mode '%s'", option);
 	} else if (!strcmp(option, "quiet")) {
 		show_stats = 0;
 		quiet = 1;
diff --git a/t/meson.build b/t/meson.build
index 82af229be3..08ad6938e2 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1032,6 +1032,7 @@ integration_tests = [
   't9302-fast-import-unpack-limit.sh',
   't9303-fast-import-compression.sh',
   't9304-fast-import-marks.sh',
+  't9305-fast-import-signatures.sh',
   't9350-fast-export.sh',
   't9351-fast-export-anonymize.sh',
   't9400-git-cvsserver-server.sh',
diff --git a/t/t9305-fast-import-signatures.sh b/t/t9305-fast-import-signatures.sh
new file mode 100755
index 0000000000..5a52691b29
--- /dev/null
+++ b/t/t9305-fast-import-signatures.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+
+test_description='git fast-import --signed-commits=<mode>'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success 'set up unsigned initial commit and import repo' '
+	test_commit first &&
+	mkdir new &&
+	git --git-dir=new/.git init
+'
+
+test_expect_success GPG 'set up OpenPGP signed commit' '
+	git checkout -b openpgp-signing main &&
+	echo "Content for OpenPGP signing." >file-sign &&
+	git add file-sign &&
+	git commit -S -m "OpenPGP signed commit" &&
+	OPENPGP_SIGNING=$(git rev-parse --verify openpgp-signing)
+'
+
+test_expect_success GPG 'import OpenPGP signature with --signed-commits=verbatim' '
+	git fast-export --signed-commits=verbatim openpgp-signing >output &&
+	git -C new fast-import --quiet --signed-commits=verbatim <output >log 2>&1 &&
+	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
+	test $OPENPGP_SIGNING = $IMPORTED &&
+	test_must_be_empty log
+'
+
+test_expect_success GPGSM 'set up X.509 signed commit' '
+	git checkout -b x509-signing main &&
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+	echo "Content for X.509 signing." >file-sign &&
+	git add file-sign &&
+	git commit -S -m "X.509 signed commit" &&
+	X509_SIGNING=$(git rev-parse HEAD)
+'
+
+test_expect_success GPGSM 'import X.509 signature fails with --signed-commits=abort' '
+	git fast-export --signed-commits=verbatim x509-signing >output &&
+	test_must_fail git -C new fast-import --quiet --signed-commits=abort <output
+'
+
+test_expect_success GPGSM 'import X.509 signature with --signed-commits=warn-verbatim' '
+	git -C new fast-import --quiet --signed-commits=warn-verbatim <output >log 2>&1 &&
+	IMPORTED=$(git -C new rev-parse --verify refs/heads/x509-signing) &&
+	test $X509_SIGNING = $IMPORTED &&
+	test_grep "importing a commit signature" log
+'
+
+test_expect_success GPGSSH 'set up SSH signed commit' '
+	git checkout -b ssh-signing main &&
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
+	echo "Content for SSH signing." >file-sign &&
+	git add file-sign &&
+	git commit -S -m "SSH signed commit" &&
+	SSH_SIGNING=$(git rev-parse HEAD)
+'
+
+test_expect_success GPGSSH 'strip SSH signature with --signed-commits=strip' '
+	git fast-export --signed-commits=verbatim ssh-signing >output &&
+	git -C new fast-import --quiet --signed-commits=strip <output >log 2>&1 &&
+	IMPORTED=$(git -C new rev-parse --verify refs/heads/ssh-signing) &&
+	test $SSH_SIGNING != $IMPORTED &&
+	git -C new cat-file commit "$IMPORTED" >actual &&
+	test_grep ! -E "^gpgsig" actual &&
+	test_must_be_empty log
+'
+
+test_expect_success GPG 'setup a commit with dual OpenPGP signatures on its SHA-1 and SHA-256 formats' '
+	# Create a signed SHA-256 commit
+	git init --object-format=sha256 explicit-sha256 &&
+	git -C explicit-sha256 config extensions.compatObjectFormat sha1 &&
+	git -C explicit-sha256 checkout -b dual-signed &&
+	test_commit -C explicit-sha256 A &&
+	echo B >explicit-sha256/B &&
+	git -C explicit-sha256 add B &&
+	test_tick &&
+	git -C explicit-sha256 commit -S -m "signed" B &&
+	SHA256_B=$(git -C explicit-sha256 rev-parse dual-signed) &&
+
+	# Create the corresponding SHA-1 commit
+	SHA1_B=$(git -C explicit-sha256 rev-parse --output-object-format=sha1 dual-signed) &&
+
+	# Check that the resulting SHA-1 commit has both signatures
+	echo $SHA1_B | git -C explicit-sha256 cat-file --batch >out &&
+	test_grep -E "^gpgsig " out &&
+	test_grep -E "^gpgsig-sha256 " out
+'
+
+test_expect_success GPG 'strip both OpenPGP signatures with --signed-commits=warn-strip' '
+	git -C explicit-sha256 fast-export --signed-commits=verbatim dual-signed >output &&
+	test_grep -E "^gpgsig sha1 openpgp" output &&
+	test_grep -E "^gpgsig sha256 openpgp" output &&
+	git -C new fast-import --quiet --signed-commits=warn-strip <output >log 2>&1 &&
+	git -C new cat-file commit refs/heads/dual-signed >actual &&
+	test_grep ! -E "^gpgsig " actual &&
+	test_grep ! -E "^gpgsig-sha256 " actual &&
+	test_grep "stripping a commit signature" log >out &&
+	test_line_count = 2 out
+'
+
+test_done
-- 
2.51.0.195.g61112aeac3

