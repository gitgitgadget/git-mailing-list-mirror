Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0763F3043C4
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680866; cv=none; b=DWbg9csplyw1Ldtaq11/oRGKTzdA0D3JDQTCKOTx4uh002NupCfaL5FalF8vwVrVG683rkqCd3OIn4frVF+3PBhjKgAV9HvzBpDBEhpN/C61h68gwBlvRToYJ2ZiaZrp2vNphkeWXBeY4chIgHgakXNQhFxH+dDXGaBGFttOZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680866; c=relaxed/simple;
	bh=F8x6axZIWRjikXVFOTHfAHbMnRLY07UjXfonOEUQFvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQlmifT0KQW+bJ6fq6rHqyDmY9uOYHbmTGXXUzU1xyBrQ3IJoEM3f5tXQMnLDkNhxY+NXR/lsyCVI2iSAw2iSOj+TtWoqeMXSTrvayuvNBl8oJzmKAKhnszAGDrUxCL8pWVv+uNtb5slMBj6ZlzvcZKRJANoK4ZgaI1gDTx/p2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/nwkAH3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/nwkAH3"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e75fb6b2e2so2001039f8f.3
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757680862; x=1758285662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCRB8i1a9oEXrPvD/X+Kycjxr5Co/apBKrrdLvyHDkI=;
        b=d/nwkAH3gDNxaM794cArqh1/K+r2MDtvhPvATly/MWTbtQbEjlvIRh3/lpPG6uPuB4
         tYH8rhSjFSot3rGcv65jdI0W9yi77aKleq5+yOZavNwQpqsqZLM7ehtI8sqQrDzGpmmG
         EOJvqap+PWNj5kGyIswL5gVadB+hmCktHOFT7QIPJ6lxFNAAkZ1zBKSjLmOCaiXqe3gD
         K6cKQJkOk3Sbfc2ve7KOi1tHofYUQOpTJKAoculyuc194j8NkscQNB01IKIAHuId1SJx
         JkbgDx4bBter9gzCJ+5Uo8WYkcNVRThfZ77h3r9pfkTqFlfmn2+UxuVjYuzv8Md9PoYm
         jITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680862; x=1758285662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCRB8i1a9oEXrPvD/X+Kycjxr5Co/apBKrrdLvyHDkI=;
        b=kVYw/+a4iU5IniM3tj0JSIgZ+plG6Aus+iuiu8EXt62UO8zOLVxKHXPd8iMBC+bRBH
         BDGPzQinKgrFM2ogNn8XH+OLllkw4v8Z5x7SPD64RPRs1pNAom0gcYx3zrnIi5M3XXbi
         lSF1Mcw6dPmtDtpGWZiZkpFfekjAPuhyTo5NDJpIrzn5Zge1rgdB5BFLra32pN9RdV47
         UIx6unpD7lL4qTfaNaTRkEaDaccdEyChYWB2QifFEAaCgj6O13RJYHud7UTbrBtdup4E
         WQVYUO3OJipfpSJqISt7KWvuFAARHjx0dK5VReHKjtrsLUG1gQ5iIs/MM6r665J56CDj
         b3Qw==
X-Gm-Message-State: AOJu0Yxdw4yWqOvImVqKZ+59MLNeBJbRDqr7LXggNl7DGee/NeAxeSdQ
	4qILB1WoXqyxfec+Tpwz33TVwmk6jTPNCK7I8mRTl9qbG49VeBNvXWHxHF/oAQ==
X-Gm-Gg: ASbGncstB5+8A5fSHso/92yYDx7pOzgH8ZsBt1Bde91boOE0NnT4jLzVjQXAUlBAnGK
	DgzpgQJrm8shmWhnyK0HKCrDj2fVtdf4Aka63/d6aeqMGx/P6wpjgm9xpPMN3qX0WUspJ0P0ylT
	MAWzefanlXNXV7PoZvzvkN8vWH9/oZ4JwJWMv8gTrXx63yuHX+BBRebxeXYRkWjgsWpIxJO93aZ
	UVZzJOgx3MtYS6i+qLfrwXe0zmlkQ1nRSFiVMQ0YbNYix5vOxdbQliVSVpP+cH4u582tzmJ25g/
	zJWALOcklwItkeiYVNGGEwXsXppB9Cn4tzDq76HZ5rdPCou9WWnDb6+IjOF/fw2NqmmDfIvsANd
	JJTEch5erW7JIKS93Nc3k4S7OtPdVeMieruTMom13PZSF3GfieGZC08S4a22io71oL8V1zWWCZl
	UoXgQwYSYbhBIfMJ8=
X-Google-Smtp-Source: AGHT+IFHCl5ubRKP4X1qA7i8N9yTDW8YvpoxoQoklD1b54WLgN2VmZiEVxe2zTTGbf6b/Iun5G1MhA==
X-Received: by 2002:a05:6000:1786:b0:3e4:24a1:808f with SMTP id ffacd0b85a97d-3e7659f37famr3134056f8f.36.1757680861414;
        Fri, 12 Sep 2025 05:41:01 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d7ff9sm6374075f8f.51.2025.09.12.05.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:40:59 -0700 (PDT)
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
Subject: [PATCH v2 2/2] fast-import: add '--signed-commits=<mode>' option
Date: Fri, 12 Sep 2025 14:40:42 +0200
Message-ID: <20250912124042.2523683-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.195.gf8f8f06677
In-Reply-To: <20250912124042.2523683-1-christian.couder@gmail.com>
References: <20250912124042.2523683-1-christian.couder@gmail.com>
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
 builtin/fast-import.c              |  41 ++++++++---
 t/meson.build                      |   1 +
 t/t9305-fast-import-signatures.sh  | 106 +++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 8 deletions(-)
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
index 2c35f9345d..890f05de4d 100644
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
@@ -2817,19 +2819,39 @@ static void parse_new_commit(const char *arg)
 	if (!committer)
 		die("Expected committer but didn't get one");
 
-	/* Process signatures (up to 2: one "sha1" and one "sha256") */
 	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
 		struct signature_data sig = { NULL, NULL, STRBUF_INIT };
 
-		parse_one_signature(&sig, v);
+		if (signed_commit_mode == SIGN_ABORT)
+			die(_("encountered signed commit; use "
+			      "--signed-commits=<mode> to handle it"));
 
-		if (!strcmp(sig.hash_algo, "sha1"))
-			store_signature(&sig_sha1, &sig, "SHA-1");
-		else if (!strcmp(sig.hash_algo, "sha256"))
-			store_signature(&sig_sha256, &sig, "SHA-256");
-		else
-			BUG("parse_one_signature() returned unknown hash algo");
+		parse_one_signature(&sig, v);
 
+		switch (signed_commit_mode) {
+		case SIGN_ABORT:
+			BUG("SIGN_ABORT should be handled before calling parse_one_signature()");
+			break;
+		case SIGN_WARN_VERBATIM:
+			warning(_("importing a commit signature verbatim"));
+			/* fallthru */
+		case SIGN_VERBATIM:
+			if (!strcmp(sig.hash_algo, "sha1"))
+				store_signature(&sig_sha1, &sig, "SHA-1");
+			else if (!strcmp(sig.hash_algo, "sha256"))
+				store_signature(&sig_sha256, &sig, "SHA-256");
+			else
+				die(_("parse_one_signature() returned unknown hash algo"));
+			break;
+		case SIGN_WARN_STRIP:
+			warning(_("stripping a commit signature"));
+			/* fallthru */
+		case SIGN_STRIP:
+			/* Just discard signature data */
+			strbuf_release(&sig.data);
+			free(sig.hash_algo);
+			break;
+		}
 		read_next_command();
 	}
 
@@ -3501,6 +3523,9 @@ static int parse_one_option(const char *option)
 		option_active_branches(option);
 	} else if (skip_prefix(option, "export-pack-edges=", &option)) {
 		option_export_pack_edges(option);
+	} else if (skip_prefix(option, "signed-commits=", &option)) {
+		if (parse_sign_mode(option, &signed_commit_mode))
+			usagef(_("unknown --signed-commits mode '%s'"), option);
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
index 0000000000..c2b4271658
--- /dev/null
+++ b/t/t9305-fast-import-signatures.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+
+test_description='git fast-import --signed-commits=<mode>'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success 'set up unsigned initial commit and import repo' '
+	test_commit first &&
+	git init new
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
+	git -C explicit-sha256 cat-file -p $SHA1_B >out &&
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
2.51.0.195.gf8f8f06677

