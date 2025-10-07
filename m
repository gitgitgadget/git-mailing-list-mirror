Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0BC2DF150
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840251; cv=none; b=qwR5WqbxuUttNW4hpI2+JMyBSNpkDFD7GNtFFWSojtlXXl/E7VPtn8seJIplazRj8AhGyS/x3X3LvK+alGBLYqroc5DrDQYBfV9yZm0rpwa4nOrHJFPOmQGzGE3CKFMyyf3Gu+4vFexVM3IplYmMiYbF//dnJiozF5KqnvjeHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840251; c=relaxed/simple;
	bh=GXSMq2JpRGaP04jK5oGV5B5yklLdhdR9GHGK+8N68CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8Qz4Yh2O4QU8r5SyZxiAVeZaPx0qHUAISsRr5glFQv/3ub5sPdy1RvbbBBb75jlNy9QdvI0Lbn8PdO7gD3nCZautN1i3kLE9zo592tKvz3pO2f8ZZGk6E3i1fTQ0IfWTFYrx8OY5h20cA7aTk8FNsNuIM/hmNtsjDkztzV8iFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnXtldAH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnXtldAH"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso670121f8f.2
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759840245; x=1760445045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwI713T4WixKxAtDpn3baE2CYTkvqRGJbIA5Bsrysuw=;
        b=ZnXtldAHcy7NGkt7aRvn7WkaJjHrTHAOFnGKihnYnihdj0AqUYBqxk7/vizxzib3ca
         HOlb4ztCM2HqnbvnS60le6qxD3HmJRDlJ3EwpFz28CBa9NuP4pQr3ItQmAJB4JYKCLsw
         9NYN2CIxdVoiyXnEnanzgNacUNfAvNC3MzQ8l89CCTpijp2nWtyENyqtuhBiZ1mlkPX2
         CJldirpK9sRi+Zm76hHpdQdSPgwgekUuV2ejwVS4xrQ4PP2ex0kSbSudK2Fa+xHKbukK
         +eofoRuDwylB0AyX3EypHieqhNpg9MFpWSVEebjiQYYcg9WIdJ70se2iztyHIgNTRcxM
         5EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840245; x=1760445045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwI713T4WixKxAtDpn3baE2CYTkvqRGJbIA5Bsrysuw=;
        b=Vk8aY10xtW2auwv8roLcCAD/GNgGxAYzG/05i6ojO/++9KRZKcNySNuv8sF+vzHl7V
         zF0sYrxHy9kYdOvXOYKrFSslWSF4Kh6gCv/MUXnXb4wNUoaXSWGQ1uNcSmxoktp2NZty
         kStrCn/iMyR25/g2m51VhPR8s4dr7+aTcQ2jn5F8UuRtE7ZT3zYdr3SgWiMe8NshiXvz
         7RuW3Kp7sCbZHnotnxcmcA0/RoUbMerwBryUQsMiO8VHNzlojxQ366wwQc/6YJtk8iFo
         KJsUOPsQ0oVa/6DqYOh0CCoraR514IkN8nTzeS6O8GAHIpCC8AWdgbX0bGICYLi6WyZt
         lcdQ==
X-Gm-Message-State: AOJu0Yx24olqQJ3K7Fr98vFzk9iUPcRnuYMF5E6dUWtKJcFnJlUyF9dP
	JmuEd/jPb9WEXLR/Ooo8EtKbYw9DbKf8vQK5cZt17G/4KjUdxRVPx6rU4Fgu94Uj
X-Gm-Gg: ASbGncvjWoZb2ymVir51VA1BnRLFFg91JlotF7UmF62Y8JUT85GOLOz8X7jJ1abgYnc
	oH6C1QOaZONPp8nsr1xyAycOZzR6Sy97eUpbXDvvgv/+AxqtXj3ieeTl14eK+YlzuHtSbyAAZCq
	FbpbF31l8z8zFvGYsubvSvpfBCSvRlTXrwQo99zmADnTk/1lcrKo52+lXlws4/gCRNzbmnQ9RBZ
	HHi00sL/YQcfasHVmBFI0YR9A2Ds3gqEUwYgmWE+HV5bPl88Zub3RSUgIEpQurpW8hpDD3iDs95
	qw7wj5Lx3Bi1YTH6XksaUBW6ZjTXfnkOAmEDKuJYhMI+r5rrtrx9Lqu83sDuukS2swfKWIkMwA2
	wbVd4KSzkJMwO/GsTTSu53nzVjziLYcLtZw4nWyocX+3fpMrpXs9nI61Gc5rcYnhr1wR3i7ngdE
	reMcjUKwZl
X-Google-Smtp-Source: AGHT+IEzD25FndBNJErjj0hW/dxZxqETU9yynXzU0yBXIVKgFu4ZL/7ih/JBXq8nXEDl9ZYPq5gUZA==
X-Received: by 2002:a05:6000:2087:b0:3ec:d80d:e59b with SMTP id ffacd0b85a97d-4256713ee4bmr11333172f8f.10.1759840244833;
        Tue, 07 Oct 2025 05:30:44 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm25476185f8f.43.2025.10.07.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:30:44 -0700 (PDT)
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
Subject: [PATCH 5/5] fast-import: add '--signed-tags=<mode>' option
Date: Tue,  7 Oct 2025 14:29:58 +0200
Message-ID: <20251007122958.1089680-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251007122958.1089680-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
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
index 2010e78475..668c926db5 100644
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
+		die("encountered signed tag; use "
+		    "--signed-tags=<mode> to handle it");
+	case SIGN_WARN_VERBATIM:
+		warning(_("importing a tag signature verbatim for tag '%s'"), name);
+			/* fallthru */
+	case SIGN_VERBATIM:
+		/* Nothing to do, the signature will be put into the imported tag. */
+		break;
+
+	/* Second, modes that remove the signature */
+	case SIGN_WARN_STRIP:
+		warning(_("stripping a tag signature for tag '%s'"), name);
+			/* fallthru */
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

