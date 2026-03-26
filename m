Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F3A38F64E
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552466; cv=none; b=JGU5EfA+QOx6IqsdxCZ+22LMjvv0oyR56VfgVmpHlrWAoeH+57tkhJNAflsnouOtp77mcofj0QKRd64g0jtY7hpKMvOQfLe2nrxyMkC2kGD6mVRzb80hjh2TtHA7TribW7ww+xsOVveLdjsNKeR5srKp7Sd7jKkOxoyV7fGF2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552466; c=relaxed/simple;
	bh=S6DUcbDQbRYSFWZ5vWIs5RyZjPx8xNM+vAgGd+zh75c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+M6hgq6xn2PsazFL5HuZ4FNsRKW42D29UxQvICEUAUKl5e3ZCJ84JrtD4KlPjPWDEniHLuY5havOPs+ZugSOliuoQNAklAp1/EefbrqBhWix6w50RW1cy0CC3/sQpxphSlnaovHH9rTPkd6HaS8YGbNVHH7QIJZWV67LKDxfdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+M2mNKz; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+M2mNKz"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d91f82d819so1184696a34.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774552463; x=1775157263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxgVnyeHrZvVotBlamZ7LPnCRTVR6WtvIXhMVxXmt2M=;
        b=m+M2mNKzIRNmcNB7Wo4cvgpfhum1g3C78nsvglAp4lKKOAj3VsJk+iT4hLt4kwXGQi
         W9euG3D6u2eVU6KWRlYSSrOtCXrYnTYq8ZmUylR5NnbvhYCEWq5OCCGiTov4wve0Uebl
         wmg5vg5hsHLJ05/Gmy0/4hIhif9fBd/IgwSs2sDIS4Jo2eGRY4/Dn88N4NW4FK8Bw+La
         2/1hK6H/Ys/kBR6zeBE4cCe6RzuthQgj3THB0ZSyFmq7/IQo857dEfV2vXPhQ/zyc6/A
         4lbq4H8d//J0r4PGfCFBbiuvBP/rqiBX+EfzvfyHXUqSGnqBfxl4x/pUJXSS9tat4E8q
         Zmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774552463; x=1775157263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uxgVnyeHrZvVotBlamZ7LPnCRTVR6WtvIXhMVxXmt2M=;
        b=hX7QiUWEg7iwIINMWyQ9JqIMrAAwCoQHxMkphR1D8ciokEiEVyiTxvcOWIgOu3Mokx
         KsjLSikhaOJPH1Ih/yklAGG8M3nWlNOEjm8w61paCE/Xyl6siBfizmLnHUAIcWpiYVZz
         9Ehv5HnCJziSjPSNMcwUfL910HmO8/8Jh4ycs/q07rspO48noaU7HDS+zAdcnqwjtGtX
         FPs7ya/K++oY/RXg/poj2wwn0b+HgRR67nycMNq0YD+PPTD1modm+yhWHltllZen/761
         WHZdDM2lHV8GOVy/EMF/e6aIAuRRJz9fvBXZZn4D68j5QRyX5n9leORE8SCfHY+emid+
         vQOg==
X-Gm-Message-State: AOJu0Yy3XPy503j0eO07BiQsc+ypu+Ps+VBE44iRU29ZW0496KvUobnG
	UqDX3zCPfhKkYh8JZWkjGkvdejKMvUT0p3Mm3fMsrLersEy77Yz6aujAYuXBOw==
X-Gm-Gg: ATEYQzxueZQV0Lood3D+J7slVYp66+gy/qeLO5im+Ijujv2knpOR+/EjxmdulGZBId9
	SmheVyYGg8ftF32eEnVv1sU5sU/HcnbhqJMx71r3BRm9Svpi3nTPDLMc6S5Q18Lse+XgWfuDEeL
	uimAQ7oX28wx0oxE0EwbSTBMqItW3jQHJ1OAIxsaFj/Z3I+TWdNY2QzWuecLX6pcs78NsEs4lJL
	S2mhmMISFEgf2TT7kjLchmKbIm1Y64848Lz1ToCYE4zdeMRijkOBJcMyMOQze6o+lAYWeP+GHQL
	WqhtIM0EVt8CmmWGaWdbvwa/wWCV2mKr7rgiQSmyVHCl+KEnA3Wb4WHalvtmSv1yZQtYz1vrViT
	2lFlwPP3QSE+nZ1CWpyAjfT5B0jkqDBEeynUT4KGkqd5PmvsJTaJRfhYHCwO63VQMNqC7BRtNNU
	/RQStnE7bmQ43hsJFJuQ9oZ5FHKo2MO4c=
X-Received: by 2002:a05:6830:81d4:b0:7d7:ddc2:540e with SMTP id 46e09a7af769-7d9d6620842mr5011200a34.6.1774552463165;
        Thu, 26 Mar 2026 12:14:23 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e71f5ab2sm2946689a34.18.2026.03.26.12.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 12:14:22 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/5] fast-import: add 'strip-if-invalid' mode to '--signed-tags=<mode>'
Date: Thu, 26 Mar 2026 14:14:12 -0500
Message-ID: <20260326191414.3783974-4-jltobler@gmail.com>
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

