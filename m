Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C92E2DF3
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012722; cv=none; b=CK8+f0q29EAsk2zP/rE0dMS9tXV7/1teQMlBAswZCdtNePeHr+BT8y4R4nNKabOCxQoGUOO7KB6Oe3g3xiyPr8N27+WGezl0d3EzMJt3M/eR/OYk4TgBr356ttbrjqNoEZgIHqW7qoECbJVRnYTotgcIsKwMW5cd3L4klsOOnXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012722; c=relaxed/simple;
	bh=82FUfiWHVUY7/i1W9JSCjmwyxOR7HPm1c2b4Cl9EZOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpSwKR0q4AlgCiwO0lF5RAZ/KkHXQELWWbKQ6Ef3iYnfGGSh2nIU/NYvA+WqXxFJ1w1ATxVEOAz+HMKD9Uggb5XDXNAja9Gb4OBhrDyoiBVn1xuYPitp2LqC5ukiU5dMQGGckkOqeMrW7MWp0GIpelmU0uWypdiGTJoL7vWcgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxOe7NU5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxOe7NU5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so9363965e9.0
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 05:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760012718; x=1760617518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9ojGqNS4OAQZMbkfabEe7HcXcOXhO5bEnjjZaC/mTg=;
        b=RxOe7NU5cJoqEw9/gFi0XWBMu8zsrFE/TFYAizdF2v2cQ1ob2FNZH9M2PznymPpNgd
         BMR/q1ETHqwRO/FOAiCRZfuqXyMi7pf78fIfx9BSRvWbSeYSCRBbnNNnus0xSxDyH+BX
         2jpYIw/iqsaQ2464Vw+LmiA2f5IPJFdpWefPe48JxRRuwdKCiyl1M3Kh9vanBQYI0V6Z
         5veBYu4Q/Va3hZQjN1GAn52yRPrB3QPRp7gNv16Z0orOiHqxaYa2PQffWRZpU0VRHYm5
         QoPOeHoVUHjaZsq0AGkYcAnlnoGfec6nStgEYmGKxzdyj3Tk9NOiE39GmwYA9OMJvgEW
         /58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012718; x=1760617518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9ojGqNS4OAQZMbkfabEe7HcXcOXhO5bEnjjZaC/mTg=;
        b=HoHJdW0WBrmC3AVrbp3yHH+ORhPaT8DT1LyJB6YRlbRJPeUqaHUIZ55I5AOfZT6+03
         GgcBnurVf1Y4yLsQ+kMm3JVBSnEgSNjm0fLGIgR70ZFCFGuOyQ/EhMTqB5zsoagZV963
         QDFuCwsMjiR9Yo0jQ9E9xNy9VTSEKOkWE0hd48NvTF4S7yG79JAlH9J6jvplnlEu76wa
         pvqIZiDubtISmbakVAIvmZ0jkhaINlLKbYVGgVR/VkR98LXJ5jKzFIz9vWhXHGcM95o6
         9h0l99hHMwVkwkk9uqav1VXqhIsQUHlrfUBPB6k9nXwDnoq4I6CpXBZOIGupUxDPCTuC
         7SwA==
X-Gm-Message-State: AOJu0YxM28ioYqqQQdNpbNC/5LiOqoHa9SFW6adPzV4Jg8DiGhDClQSF
	hsIjf4Mp/lOn9RSBjp15NCo0GyvsyAzJa4KKiZ9Rgdb9mgE7Q0Nk3ZGJIxqZSvxM
X-Gm-Gg: ASbGnctX98RfnrGSlihXzBz3Uh551bOQnECoopmIQ0CD0hyoJSs6eAXOnOlbCz+kxGe
	iz1kSjUeKSZrQQC/YR/y5BE2eRRVTRVCDzxZG5O2WcqH/3haSVSAaIE4fMhsgPbIThmia1esGzi
	qUqUNUEiX7NRctMA4ojP6eV1tiXs0gDvYclaWKOcMNOPQIPgZ8UD5b0fXvqCkgVoqUoAXmQ8Kgp
	LiIc4rnD3/jZb9/C7uFAS9HSkV3nHaiT5yS1Ing32t37ZdtFinrApYIV+lIUUIr38xtOAPq9V1J
	MxXE8M+WAkzfmLh51RwwBCf+UAar+FdLM72VxaREcV7Hs4EizeKIaJWoLf3DTCO7lZqUhc15aMa
	LJ/kdIGCUNjOOtlO/tU9PbqhOllvF/SXVcwIZ6dZS9yKsSD26jRNqsxqznNh4Uvqk11+Nbab/to
	jII2fgiR7w
X-Google-Smtp-Source: AGHT+IF9o5YvQ0Brgxk8LHXITarFA4YER+BoUSVgMQZB3wX72QQFyYyyRVKaaZI9CNGG+JVZLwQQcA==
X-Received: by 2002:a05:600c:1e8c:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-46fa9a8efbcmr51663565e9.2.1760012718373;
        Thu, 09 Oct 2025 05:25:18 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07cbasm84831475e9.7.2025.10.09.05.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:25:17 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Todd Zullinger <tmz@pobox.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 5/5] fast-import: add '--signed-tags=<mode>' option
Date: Thu,  9 Oct 2025 14:24:57 +0200
Message-ID: <20251009122457.1273701-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251009122457.1273701-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251009122457.1273701-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, eaaddf5791 (fast-import: add '--signed-commits=<mode>'
option, 2025-09-17) added support for controlling how signed commits
are handled by `git fast-import`, but there is no option yet to
decide about signed tags.

To remediate that, let's add a '--signed-tags=<mode>' option to
`git fast-import` too.

With this, both `git fast-export` and `git fast-import` have both
a '--signed-tags=<mode>' and a '--signed-commits=<mode>' supporting
the same <mode>s.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-import.adoc |  5 ++
 builtin/fast-import.c              | 43 ++++++++++++++++
 t/meson.build                      |  1 +
 t/t9306-fast-import-signed-tags.sh | 80 ++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+)
 create mode 100755 t/t9306-fast-import-signed-tags.sh

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 85ed7a7270..b74179a6c8 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -66,6 +66,11 @@ fast-import stream! This option is enabled automatically for
 remote-helpers that use the `import` capability, as they are
 already trusted to run their own code.
 
+--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
+	Specify how to handle signed tags.  Behaves in the same way
+	as the same option in linkgit:git-fast-export[1], except that
+	default is 'verbatim' (instead of 'abort').
+
 --signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
 	Specify how to handle signed commits.  Behaves in the same way
 	as the same option in linkgit:git-fast-export[1], except that
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 2010e78475..60d6faa465 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -188,6 +188,7 @@ static int global_argc;
 static const char **global_argv;
 static const char *global_prefix;
 
+static enum sign_mode signed_tag_mode = SIGN_VERBATIM;
 static enum sign_mode signed_commit_mode = SIGN_VERBATIM;
 
 /* Memory pools */
@@ -2961,6 +2962,43 @@ static void parse_new_commit(const char *arg)
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
 
+static void handle_tag_signature(struct strbuf *msg, const char *name)
+{
+	size_t sig_offset = parse_signed_buffer(msg->buf, msg->len);
+
+	/* If there is no signature, there is nothing to do. */
+	if (sig_offset >= msg->len)
+		return;
+
+	switch (signed_tag_mode) {
+
+	/* First, modes that don't change anything */
+	case SIGN_ABORT:
+		die(_("encountered signed tag; use "
+		      "--signed-tags=<mode> to handle it"));
+	case SIGN_WARN_VERBATIM:
+		warning(_("importing a tag signature verbatim for tag '%s'"), name);
+		/* fallthru */
+	case SIGN_VERBATIM:
+		/* Nothing to do, the signature will be put into the imported tag. */
+		break;
+
+	/* Second, modes that remove the signature */
+	case SIGN_WARN_STRIP:
+		warning(_("stripping a tag signature for tag '%s'"), name);
+		/* fallthru */
+	case SIGN_STRIP:
+		/* Truncate the buffer to remove the signature */
+		strbuf_setlen(msg, sig_offset);
+		break;
+
+	/* Third, BUG */
+	default:
+		BUG("invalid signed_tag_mode value %d from tag '%s'",
+		    signed_tag_mode, name);
+	}
+}
+
 static void parse_new_tag(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
@@ -3024,6 +3062,8 @@ static void parse_new_tag(const char *arg)
 	/* tag payload/message */
 	parse_data(&msg, 0, NULL);
 
+	handle_tag_signature(&msg, t->name);
+
 	/* build the tag object */
 	strbuf_reset(&new_data);
 
@@ -3544,6 +3584,9 @@ static int parse_one_option(const char *option)
 	} else if (skip_prefix(option, "signed-commits=", &option)) {
 		if (parse_sign_mode(option, &signed_commit_mode))
 			usagef(_("unknown --signed-commits mode '%s'"), option);
+	} else if (skip_prefix(option, "signed-tags=", &option)) {
+		if (parse_sign_mode(option, &signed_tag_mode))
+			usagef(_("unknown --signed-tags mode '%s'"), option);
 	} else if (!strcmp(option, "quiet")) {
 		show_stats = 0;
 		quiet = 1;
diff --git a/t/meson.build b/t/meson.build
index 11376b9e25..cb8c2b4b30 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1036,6 +1036,7 @@ integration_tests = [
   't9303-fast-import-compression.sh',
   't9304-fast-import-marks.sh',
   't9305-fast-import-signatures.sh',
+  't9306-fast-import-signed-tags.sh',
   't9350-fast-export.sh',
   't9351-fast-export-anonymize.sh',
   't9400-git-cvsserver-server.sh',
diff --git a/t/t9306-fast-import-signed-tags.sh b/t/t9306-fast-import-signed-tags.sh
new file mode 100755
index 0000000000..363619e7d1
--- /dev/null
+++ b/t/t9306-fast-import-signed-tags.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+
+test_description='git fast-import --signed-tags=<mode>'
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
+test_expect_success 'import no signed tag with --signed-tags=abort' '
+	git fast-export --signed-tags=verbatim >output &&
+	git -C new fast-import --quiet --signed-tags=abort <output
+'
+
+test_expect_success GPG 'set up OpenPGP signed tag' '
+	git tag -s -m "OpenPGP signed tag" openpgp-signed first &&
+	OPENPGP_SIGNED=$(git rev-parse --verify refs/tags/openpgp-signed) &&
+	git fast-export --signed-tags=verbatim openpgp-signed >output
+'
+
+test_expect_success GPG 'import OpenPGP signed tag with --signed-tags=abort' '
+	test_must_fail git -C new fast-import --quiet --signed-tags=abort <output
+'
+
+test_expect_success GPG 'import OpenPGP signed tag with --signed-tags=verbatim' '
+	git -C new fast-import --quiet --signed-tags=verbatim <output >log 2>&1 &&
+	IMPORTED=$(git -C new rev-parse --verify refs/tags/openpgp-signed) &&
+	test $OPENPGP_SIGNED = $IMPORTED &&
+	test_must_be_empty log
+'
+
+test_expect_success GPGSM 'setup X.509 signed tag' '
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+
+	git tag -s -m "X.509 signed tag" x509-signed first &&
+	X509_SIGNED=$(git rev-parse --verify refs/tags/x509-signed) &&
+	git fast-export --signed-tags=verbatim x509-signed >output
+'
+
+test_expect_success GPGSM 'import X.509 signed tag with --signed-tags=warn-strip' '
+	git -C new fast-import --quiet --signed-tags=warn-strip <output >log 2>&1 &&
+	test_grep "stripping a tag signature for tag '\''x509-signed'\''" log &&
+	IMPORTED=$(git -C new rev-parse --verify refs/tags/x509-signed) &&
+	test $X509_SIGNED != $IMPORTED &&
+	git -C new cat-file -p x509-signed >out &&
+	test_grep ! "SIGNED MESSAGE" out
+'
+
+test_expect_success GPGSSH 'setup SSH signed tag' '
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
+
+	git tag -s -m "SSH signed tag" ssh-signed first &&
+	SSH_SIGNED=$(git rev-parse --verify refs/tags/ssh-signed) &&
+	git fast-export --signed-tags=verbatim ssh-signed >output
+'
+
+test_expect_success GPGSSH 'import SSH signed tag with --signed-tags=warn-verbatim' '
+	git -C new fast-import --quiet --signed-tags=warn-verbatim <output >log 2>&1 &&
+	test_grep "importing a tag signature verbatim for tag '\''ssh-signed'\''" log &&
+	IMPORTED=$(git -C new rev-parse --verify refs/tags/ssh-signed) &&
+	test $SSH_SIGNED = $IMPORTED
+'
+
+test_expect_success GPGSSH 'import SSH signed tag with --signed-tags=strip' '
+	git -C new fast-import --quiet --signed-tags=strip <output >log 2>&1 &&
+	test_must_be_empty log &&
+	IMPORTED=$(git -C new rev-parse --verify refs/tags/ssh-signed) &&
+	test $SSH_SIGNED != $IMPORTED &&
+	git -C new cat-file -p ssh-signed >out &&
+	test_grep ! "SSH SIGNATURE" out
+'
+
+test_done
-- 
2.51.0.438.g6987fc0bae

