Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7053A7584
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389335; cv=none; b=Xpt//qlnMyT1AReiciB6WZVFa/NI/e9m3NsnYawRmtWEGm637K+g5SsMO6ia1GjLEiG9UUb2mfHJ9IrzmggLBvZ7ah70Prvvvmp04r+/zpTeHiPkOwOtm+c5qNBSMqOPnyZUkEiY8wSjuJ4Un453lrfzYRRNcemRNyxfE3NQ0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389335; c=relaxed/simple;
	bh=S6DUcbDQbRYSFWZ5vWIs5RyZjPx8xNM+vAgGd+zh75c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C85UlI/fNSkokS4Sfbckjg6BOGDbXpuKrrEKY2lG72FjY4sQ1jm8SC+iCUOvmlle/MGkEt9IvzE+gJq79y/8MdWYX+t55fZ2lgIviXkuVxv9Ef8bXytaiGt3PTQKoVmKgwkLRwYjGxkH40QpBPK4vRwIVVBnzj3zOGiPsgLHVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7lTqljn; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7lTqljn"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-41708f6c3feso1018483fac.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 14:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774389332; x=1774994132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxgVnyeHrZvVotBlamZ7LPnCRTVR6WtvIXhMVxXmt2M=;
        b=V7lTqljndNJZlmf31Qdo34YqF2sdMR4XirDCFJiZyYSaQ31nyxObcrpDPnD5RoYNTS
         Tv1jSle/h3D939HtOpWml61CjtoSt5eX+ivNQGjlL2BMR2ToziC2iggoMkxhxHgvjP0E
         R0LEoIiFcQrrDQIRpUrAqza4WdPBI+wCuCE2GlmtnI+1ij+1LLtToPef/plaCOBsROeZ
         vGIqEMs/vL4BcFUWoonahWh4XTgtBzFTftWw8griisV9mXKvc6mEA8AonTyaxMPDFjnr
         pOoP/0rWOyPeK1AjDCGgHrYINpy9oH/AG8QgGyryg1vnDn7SjnNyKDl8Hn/k5G9TUpRu
         8zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389332; x=1774994132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uxgVnyeHrZvVotBlamZ7LPnCRTVR6WtvIXhMVxXmt2M=;
        b=d0g13IuEvH4Mzl/EEPkOntOjFrWpP5WXBCsonJU7SjfV+hFvejbRm/iFq1R5VFYXAT
         WIN6FquAhpRgw3nOIW+4XMKPh3R+YDfK20okMVkCPz1VmCE6Lgtf2TWWy7oZGF4Z8g9U
         MI2TDkrwMs4VUAQIO68VOzVc5h5bFso/ZQrUeWlYngIc9RNPsga2sRFJhd6Vj7kau8cI
         GJH8+JlmRkYlvJvEG2Iiwe1tx6GCOWEz7VBA0R4OCWoJ043cbXy0M/qJ6b48VJiTNZST
         0hYQ1SmFv/7IeR8FPjxPxQXZqOjfq87HKZLk2V0NSZK1JLayG3P16fKe2qIFjq4GmBmr
         UFXA==
X-Gm-Message-State: AOJu0YyR8WeGFo1VzMfgItJysB5xTKQ3/HNx56kII/+OhGJkBbQugnZ8
	FFCW5ZStXgPGzjtSYaDXC9cjAJ4FYKHt+s4DVFEwdUpQBg4ImX/bG1/PsbSr5Q==
X-Gm-Gg: ATEYQzzWnTJJn88otuC2ndcc7Ns/qgMYvdH4T8lYK/cTIIEkkmtZbghyNa4pefSC62C
	oH7ynV5Mm9A7QsOyktuSIsMo0/SN6jHx9l9R9G0JIIHqo5SvHDZk1PyZwk5XUm1kdJzK8iTdkyX
	mXxjbriLlbzFBAJSrR3Aiiq7j3DhIAavcJkWsDGTbNf7W6Kt8ZgNsdfny0xlKSDhuAihAjag36q
	tK/kE6mohdYP2zC111J800hjGIhlyfkN71Ue94q4HhhkIRRZUU+WRaY122c9o9z8zLmT3Z91Yzc
	9qxdfTxAZUexEx7gyQSFf0NVoV1xBrjZ84TVhqiv2ksXORRAHzD+1Ij1C2L9twl2h+wqNOyY5Cn
	m5lh7vFCF8iKE6ccS1J6umB5xd7zMaFPAAHWu8bmlblti8GOAJnPjIX732MeWp8zA5I7eNbi3ZU
	ppccyfNXUVO03Gi78mkk39vR0IPsnAjDuPs8d5qLXvyQ==
X-Received: by 2002:a05:6870:c350:b0:409:7e70:299f with SMTP id 586e51a60fabf-41ca6d6a4abmr775664fac.9.1774389331666;
        Tue, 24 Mar 2026 14:55:31 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c149103b0sm12391697fac.5.2026.03.24.14.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 14:55:31 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/4] fast-import: add 'strip-if-invalid' mode to '--signed-tags=<mode>'
Date: Tue, 24 Mar 2026 16:55:11 -0500
Message-ID: <20260324215513.764739-3-jltobler@gmail.com>
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

With c20f112e51 (fast-import: add 'strip-if-invalid' mode to
--signed-commits=<mode>, 2025-11-17), git-fast-import(1) learned to
verify commit signatures during import and strip signatures that fail
verification. Extend the same behavior to signed tag objects by
introducing a 'strip-if-invalid' mode for the '--signed-tags' option.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-fast-import.adoc |  7 ++-
 builtin/fast-import.c              | 40 +++++++++++++---
 t/t9306-fast-import-signed-tags.sh | 73 ++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 288f2b2a7e..d68bc52b7e 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -66,11 +66,10 @@ fast-import stream! This option is enabled automatically for
 remote-helpers that use the `import` capability, as they are
 already trusted to run their own code.
 
-`--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)`::
+`--signed-tags=<mode>`::
 	Specify how to handle signed tags. Behaves in the same way as
-	the `--signed-commits=<mode>` below, except that the
-	`strip-if-invalid` mode is not yet supported. Like for signed
-	commits, the default mode is `verbatim`.
+	the `--signed-commits=<mode>` below. Like for signed commits,
+	the default mode is `verbatim`.
 
 `--signed-commits=<mode>`::
 	Specify how to handle signed commits. The following <mode>s
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 08ea27242d..5e89829aea 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3089,7 +3089,34 @@ static void parse_new_commit(const char *arg)
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
 
-static void handle_tag_signature(struct strbuf *msg, const char *name)
+static void handle_tag_signature_if_invalid(struct strbuf *buf,
+					    struct strbuf *msg,
+					    size_t sig_offset)
+{
+	struct strbuf signature = STRBUF_INIT;
+	struct strbuf payload = STRBUF_INIT;
+	struct signature_check sigc = { 0 };
+
+	strbuf_addbuf(&payload, buf);
+	strbuf_addch(&payload, '\n');
+	strbuf_add(&payload, msg->buf, sig_offset);
+	strbuf_add(&signature, msg->buf + sig_offset, msg->len - sig_offset);
+
+	sigc.payload_type = SIGNATURE_PAYLOAD_TAG;
+	sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
+
+	if (!check_signature(&sigc, signature.buf, signature.len))
+		goto out;
+
+	strbuf_setlen(msg, sig_offset);
+
+out:
+	signature_check_clear(&sigc);
+	strbuf_release(&signature);
+	strbuf_release(&payload);
+}
+
+static void handle_tag_signature(struct strbuf *buf, struct strbuf *msg, const char *name)
 {
 	size_t sig_offset = parse_signed_buffer(msg->buf, msg->len);
 
@@ -3115,6 +3142,9 @@ static void handle_tag_signature(struct strbuf *msg, const char *name)
 		/* Truncate the buffer to remove the signature */
 		strbuf_setlen(msg, sig_offset);
 		break;
+	case SIGN_STRIP_IF_INVALID:
+		handle_tag_signature_if_invalid(buf, msg, sig_offset);
+		break;
 
 	/* Third, aborting modes */
 	case SIGN_ABORT:
@@ -3123,9 +3153,6 @@ static void handle_tag_signature(struct strbuf *msg, const char *name)
 	case SIGN_ABORT_IF_INVALID:
 		die(_("'abort-if-invalid' is not a valid mode for "
 		      "git fast-import with --signed-tags=<mode>"));
-	case SIGN_STRIP_IF_INVALID:
-		die(_("'strip-if-invalid' is not a valid mode for "
-		      "git fast-import with --signed-tags=<mode>"));
 	case SIGN_SIGN_IF_INVALID:
 		die(_("'sign-if-invalid' is not a valid mode for "
 		      "git fast-import with --signed-tags=<mode>"));
@@ -3198,8 +3225,6 @@ static void parse_new_tag(const char *arg)
 	/* tag payload/message */
 	parse_data(&msg, 0, NULL);
 
-	handle_tag_signature(&msg, t->name);
-
 	/* build the tag object */
 	strbuf_reset(&new_data);
 
@@ -3211,6 +3236,9 @@ static void parse_new_tag(const char *arg)
 	if (tagger)
 		strbuf_addf(&new_data,
 			    "tagger %s\n", tagger);
+
+	handle_tag_signature(&new_data, &msg, t->name);
+
 	strbuf_addch(&new_data, '\n');
 	strbuf_addbuf(&new_data, &msg);
 	free(tagger);
diff --git a/t/t9306-fast-import-signed-tags.sh b/t/t9306-fast-import-signed-tags.sh
index 363619e7d1..fd43b0b52a 100755
--- a/t/t9306-fast-import-signed-tags.sh
+++ b/t/t9306-fast-import-signed-tags.sh
@@ -77,4 +77,77 @@ test_expect_success GPGSSH 'import SSH signed tag with --signed-tags=strip' '
 	test_grep ! "SSH SIGNATURE" out
 '
 
+for mode in strip-if-invalid
+do
+	test_expect_success GPG "import tag with no signature with --signed-tags=$mode" '
+		test_when_finished rm -rf import &&
+		git init import &&
+
+		git fast-export --signed-tags=verbatim >output &&
+		git -C import fast-import --quiet --signed-tags=$mode <output >log 2>&1 &&
+		test_must_be_empty log
+	'
+
+	test_expect_success GPG "keep valid OpenPGP signature with --signed-tags=$mode" '
+		test_when_finished rm -rf import &&
+		git init import &&
+
+		git fast-export --signed-tags=verbatim openpgp-signed >output &&
+		git -C import fast-import --quiet --signed-tags=$mode <output >log 2>&1 &&
+		IMPORTED=$(git -C import rev-parse --verify refs/tags/openpgp-signed) &&
+		test $OPENPGP_SIGNED = $IMPORTED &&
+		git -C import cat-file tag "$IMPORTED" >actual &&
+		test_grep -E "^-----BEGIN PGP SIGNATURE-----" actual &&
+		test_must_be_empty log
+	'
+
+	test_expect_success GPG "handle signature invalidated by message change with --signed-tags=$mode" '
+		test_when_finished rm -rf import &&
+		git init import &&
+
+		git fast-export --signed-tags=verbatim openpgp-signed >output &&
+
+		# Change the tag message, which invalidates the signature. The tag
+		# message length should not change though, otherwise the corresponding
+		# `data <length>` command would have to be changed too.
+		sed "s/OpenPGP signed tag/OpenPGP forged tag/" output >modified &&
+
+		git -C import fast-import --quiet --signed-tags=$mode <modified >log 2>&1 &&
+
+		IMPORTED=$(git -C import rev-parse --verify refs/tags/openpgp-signed) &&
+		test $OPENPGP_SIGNED != $IMPORTED &&
+		git -C import cat-file tag "$IMPORTED" >actual &&
+		test_grep ! -E "^-----BEGIN PGP SIGNATURE-----" actual &&
+		test_must_be_empty log
+	'
+
+	test_expect_success GPGSM "keep valid X.509 signature with --signed-tags=$mode" '
+		test_when_finished rm -rf import &&
+		git init import &&
+
+		git fast-export --signed-tags=verbatim x509-signed >output &&
+		git -C import fast-import --quiet --signed-tags=$mode <output >log 2>&1 &&
+		IMPORTED=$(git -C import rev-parse --verify refs/tags/x509-signed) &&
+		test $X509_SIGNED = $IMPORTED &&
+		git -C import cat-file tag x509-signed >actual &&
+		test_grep -E "^-----BEGIN SIGNED MESSAGE-----" actual &&
+		test_must_be_empty log
+	'
+
+	test_expect_success GPGSSH "keep valid SSH signature with --signed-tags=$mode" '
+		test_when_finished rm -rf import &&
+		git init import &&
+
+		test_config -C import gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+
+		git fast-export --signed-tags=verbatim ssh-signed >output &&
+		git -C import fast-import --quiet --signed-tags=$mode <output >log 2>&1 &&
+		IMPORTED=$(git -C import rev-parse --verify refs/tags/ssh-signed) &&
+		test $SSH_SIGNED = $IMPORTED &&
+		git -C import cat-file tag ssh-signed >actual &&
+		test_grep -E "^-----BEGIN SSH SIGNATURE-----" actual &&
+		test_must_be_empty log
+	'
+done
+
 test_done
-- 
2.53.0.381.g628a66ccf6

