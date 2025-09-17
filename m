Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649C2FFDDA
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132890; cv=none; b=hRcxCczGOh5FM1rDmDLxFvmaijwGDEPIidmxvOwK/phpJZ/mqMh5xMSuKIa48Eb9zp905XYYYFmn/4dAREWdbRI5bjsdhoL5h5YP0MmgJiLuWTZ+i/yefh7Tj6JEeLlesq6E4YR1EDcLpCSG1uXEbiPjLW87ud7stuEPxZ77wgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132890; c=relaxed/simple;
	bh=AQhmk5CbLqUJ3pukhpZyK4d0fXSZLgVkBaon4OjfxiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WF0TpJvmZSTQH2zw63SdjLGKYtoQxNQnfo2GR/H+h1utZXAq1CS8Kn9vnGb6vUuwCA2REhdP8yyypRP6BIwbT00GqcJ/ZyypQnWkxLh/kgccFVcILDQcy1YTAer5BIKPxlvb+IBnr9xs4WHDNJNI/7xm/rpdN3MZ4pAnqzdLehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZudFwjHq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZudFwjHq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so645915e9.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758132887; x=1758737687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n27uexhzw7xtgGIlsrIYogOXX3R3KRcgDPjZ5vUNdoI=;
        b=ZudFwjHqXEojbUcGjYfF/Wa4fzkEm01ondwd/fle/IlHPN16L1ffV4Bo7f6HFAmk45
         5lkOPedKpaywAAvytjfNwW+YvVs6oaTnM1SYsPh/chKYWR0z4fZXi2JV2k7iqzark+83
         +q960wrPUqiuc9O4K2CPYUkgSTGGAGkeRv7IL+ZK/xMPwShV7+1QsyBraMvYB4u87yMo
         +mbm3grXiYTeNpHv0I9z9UHGDSiuNqemNkEtboIpcHj7W1qaYtmD63UheXrPafHQn7Y/
         6s67FC7X/ZqESoejK1CMQTdG9QKi2yOFnzHH2YquG+5oAFKy88vtVIAeNca+s5UtvBJL
         912g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132887; x=1758737687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n27uexhzw7xtgGIlsrIYogOXX3R3KRcgDPjZ5vUNdoI=;
        b=E5j6MOotyaxitPXi7iGQ0v+Ys90iSDSp33oMW+M2n4PqT9bVcFyIV0GVSJO7JOCYyr
         VRa1M3EM7V1h8OZpPseaFAuH6/VrHYIbZIKflCcaLAFiOk1KX/crcyaQyd/OF31sSu7i
         Hm4DPafTVxH0QMoekZO24QAaw/Mof6zxpoJCiJZUr8Pf57S2KlZtHtZF3cFuxFE7U8MB
         EKVOV1yJj3AuqYmHvIgNQVOVNbqjdcaJNKLw9Cfy/UUM14fxH/UaN25YqaPKSEpeyB74
         0/nPNepAdVx7vXtjj6jMM26oxVwTIO0tD0gW24BRc7PLXqBNMRca1CmAG+anEFlJXLIk
         LfqQ==
X-Gm-Message-State: AOJu0YzPdwk6zqv2+khA4ffWLqF5hRRM9AYef8G1adX1E1QtbQ/1iSno
	Z+L5+xBLlnrgCoXPQqVXcl9IkIkUQG1gOJRB1bjQOzUGoR/v5C28dw+IVQipdA==
X-Gm-Gg: ASbGncsl+gWzvW5MXN3q9iQda1F5ND5spUHN+RnHH5in0aut71QFnJdMnSNYK0Wxg+p
	dfG6zDmRcKDbTdYV/51cnkJ/TsJMq6GhMc4/8vWGlyk9uEFrddUTQTDCUAVGgKitl0Pr9AjE41H
	FFuTe0FjLXSHKuyqA58HRZhbBXo9z6jw+EVBAjmJCpEN5XElP1D6bWshuwBzFeE8nhgjW5zkddc
	IMlwQvDy5RckdLv0HT1UwOdiyuvDdV3qwLazaZwmLLKRU0gABzqwZzayT5wxjJJXMsZwu6NaVvI
	fdZrqXXVUOz/xuqL10JvylbC+J+fZdsm47Dd0pPmj6caW/wPqL0iUyT57J0R+wubdYIrY4cWPCt
	ciONm+uI5H+xf+WDxrj0FoNEgRh4qObkVN+YHrmSJjBlQjPRoZO2NlcdSk1hAtkldNrJkf7R1aU
	YGiBEc
X-Google-Smtp-Source: AGHT+IGksGwVb5TyA3uLCqnusAGhSOOlvZy6RkvdUh3veDQVdfFNqd8+iYxJrPbrhropm+2xbER4Ng==
X-Received: by 2002:a05:600c:4511:b0:45d:e326:96fb with SMTP id 5b1f17b1804b1-462066563e4mr34142635e9.30.1758132886400;
        Wed, 17 Sep 2025 11:14:46 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464eadd7e11sm6956915e9.0.2025.09.17.11.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 11:14:44 -0700 (PDT)
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
Subject: [PATCH v3 2/2] fast-import: add '--signed-commits=<mode>' option
Date: Wed, 17 Sep 2025 20:14:27 +0200
Message-ID: <20250917181427.3193500-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.195.ge34f015aea.dirty
In-Reply-To: <20250917181427.3193500-1-christian.couder@gmail.com>
References: <20250912124042.2523683-1-christian.couder@gmail.com>
 <20250917181427.3193500-1-christian.couder@gmail.com>
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

The code responsible for consuming a signature is refactored into
the import_one_signature() and discard_one_signature() functions,
which makes it easier to follow the logic and add new modes in the
future.

In the 'strip' and 'warn-strip' modes, we deliberately use
discard_one_signature() to discard the signature without parsing it.
This ensures that even malformed signatures, which would cause the
parser to fail, can be successfully stripped from a commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-import.adoc |   5 ++
 builtin/fast-import.c              |  63 ++++++++++++++---
 t/meson.build                      |   1 +
 t/t9305-fast-import-signatures.sh  | 106 +++++++++++++++++++++++++++++
 4 files changed, 165 insertions(+), 10 deletions(-)
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
index 2c35f9345d..2010e78475 100644
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
@@ -2752,6 +2754,15 @@ static void parse_one_signature(struct signature_data *sig, const char *v)
 	parse_data(&sig->data, 0, NULL);
 }
 
+static void discard_one_signature(void)
+{
+	struct strbuf data = STRBUF_INIT;
+
+	read_next_command();
+	parse_data(&data, 0, NULL);
+	strbuf_release(&data);
+}
+
 static void add_gpgsig_to_commit(struct strbuf *commit_data,
 				 const char *header,
 				 struct signature_data *sig)
@@ -2785,6 +2796,22 @@ static void store_signature(struct signature_data *stored_sig,
 	}
 }
 
+static void import_one_signature(struct signature_data *sig_sha1,
+				 struct signature_data *sig_sha256,
+				 const char *v)
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
+		die(_("parse_one_signature() returned unknown hash algo"));
+}
+
 static void parse_new_commit(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
@@ -2817,19 +2844,32 @@ static void parse_new_commit(const char *arg)
 	if (!committer)
 		die("Expected committer but didn't get one");
 
-	/* Process signatures (up to 2: one "sha1" and one "sha256") */
 	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
-		struct signature_data sig = { NULL, NULL, STRBUF_INIT };
-
-		parse_one_signature(&sig, v);
+		switch (signed_commit_mode) {
+
+		/* First, modes that don't need the signature to be parsed */
+		case SIGN_ABORT:
+			die("encountered signed commit; use "
+			    "--signed-commits=<mode> to handle it");
+		case SIGN_WARN_STRIP:
+			warning(_("stripping a commit signature"));
+			/* fallthru */
+		case SIGN_STRIP:
+			discard_one_signature();
+			break;
 
-		if (!strcmp(sig.hash_algo, "sha1"))
-			store_signature(&sig_sha1, &sig, "SHA-1");
-		else if (!strcmp(sig.hash_algo, "sha256"))
-			store_signature(&sig_sha256, &sig, "SHA-256");
-		else
-			BUG("parse_one_signature() returned unknown hash algo");
+		/* Second, modes that parse the signature */
+		case SIGN_WARN_VERBATIM:
+			warning(_("importing a commit signature verbatim"));
+			/* fallthru */
+		case SIGN_VERBATIM:
+			import_one_signature(&sig_sha1, &sig_sha256, v);
+			break;
 
+		/* Third, BUG */
+		default:
+			BUG("invalid signed_commit_mode value %d", signed_commit_mode);
+		}
 		read_next_command();
 	}
 
@@ -3501,6 +3541,9 @@ static int parse_one_option(const char *option)
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
2.51.0.195.ge34f015aea.dirty

