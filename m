Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412D312807
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773365989; cv=none; b=oPD1fowcgT4DMuhFCVioNUuQ+MgpgOe+4xm4TMUH0JiMoG6fbgmVDlU4PRtfao26VDJ9bCDkArtiv5EHsDpfTQjTXIH0HWjrX2rVbSfft9dW2RY5qkgLsVnCK7HCUNjfq5UT63Nj0buc43Zw5jFbvKQC5F2Wr9xLhF3bsDlvXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773365989; c=relaxed/simple;
	bh=BzhZNe/6LiamrDTfhWpFiy39YLvnafH5jJyrIorLkMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuuxojWe1lFyoCXZOAbYqNbT+2I8DUdabEk0Rl3mVTg31P1g1limdAdIkxhz2nFr/1g5IJhvPI/PEkSeJFOj0Y4kpOSfeonu8J+LNgmbKNi3U4bfy0HLtxPsSRH6Tnjs0Dgi9DpikS1/FbAAnDdMJdGxL9S6Qy/Mto4VpOS+9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSjISDtN; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSjISDtN"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-466ec4c6846so592967b6e.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 18:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773365987; x=1773970787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOcYIiT2w02JGty0qvITYWj0UVQgcOeV89wZkfAOqgQ=;
        b=kSjISDtNP0FtUewLQSYtdOkQfANy6m0RvXRVHTnxjL3kN0/eRIlUoZu3vMunTfiiVu
         4zCRha+Mugkn8cbsGPsazcfsMjktNb/rI4iprjGtAotAMdmyYe+5klsFgmNVLP2fbNz7
         7vZhlFjkwSKp+E26LO1BfWmWp1Y+ZXriNkuRaIXGOCOauN8tjLGYsbM+IR63PQ34eMpm
         UP9kUkbso1rqQCQh0AI+h5oUdCWM/XiK1rZ3rIwhsH8opNffJz6/HE62A/UFtYxBD6Qd
         lideEEPR4nmqduFM0wZg0AFU3K0/XY9pujFXzxexCipbgaHXSf11MbVkuI/iKA3MU5a0
         4uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773365987; x=1773970787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bOcYIiT2w02JGty0qvITYWj0UVQgcOeV89wZkfAOqgQ=;
        b=bMnksDRSSBLDVA3h9YJDcvcgH+zHWMENzhzrXIgm4C2IPiwU5YfA/yA1yD6kyYYr9k
         wPEHyuvpjnwg7k7FBF3am07ypakDYjd1hpTmXSKuAs9g41awDx3Zw9pwOf248L0T12Ks
         +YLQAmUBMCO5oWPl4gDFTIKRVBBUxWYks3X05g0bbjhn6x8beCNRui6BtprrSnT4Hofz
         Knmer40HB1Jc89ZaOnA+vMz/QHUVHJ99GOGS1H09U6czWU7a3KfsGIHOtoC935hXE4Gh
         ZxOPxqniaxH+CyMj4MVWLDFasXnF26DscJnClA7QhzsPggUA/yxnRKLOM943n3OajVmR
         tBPg==
X-Gm-Message-State: AOJu0Yx3YPBEOXCKVcMPGmbWMsTuGkmq1eX+FxElhIDzp3WstzTvbwUs
	WXAZDhV3IZKH2UR3Bt8fKM0tLB+G7Yx/H+X896bYKYtOF3fWUX5+JoCUgH/ibw==
X-Gm-Gg: ATEYQzy7gihJWZ0drOg/b7xAA4tKvUu+NZPMXAFVG9wrHf2ENukHCo6glXTwardlAb9
	Vn6UpmpZrIi/iAQDttqU89HyJeGSg6tdRLXzw1Eor2C1Ny7cVJr/j4RaNX3/t/MrTL7Dnh6A2WJ
	3X56DXyehb8Gqu0MHH8yDjV8iRU9kHKEG0AQlXq/q0CtKmw1WuDR0f6ZatePTN7+YuUclJmFUux
	XLCUidd2BK551tgv9wZdAHwgFZYEe3xHaeqxohk+BnnHnq3bhaOw2OE56dE8EfKpHr6JgHpw17o
	lDNBlO1a15ZfX4t5TJevfK/RvebJBGHVFfMOrAIo5p6tW3nP1uF37J5AEYc42jxGle4wfDD1LFi
	Ynrm4FglxWA246aBaPURJF97PZfFOIA8odv+DR4pwewjSIFlIZXNvwC9wgEKShZ14i1fTfB+DW8
	XPdgzx/wR6++udvZQ/iEzIcA/tNPP2hlk=
X-Received: by 2002:a05:6808:16a6:b0:45f:13fe:4a2d with SMTP id 5614622812f47-46757052b11mr845947b6e.4.1773365986842;
        Thu, 12 Mar 2026 18:39:46 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342c084asm3897154b6e.12.2026.03.12.18.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 18:39:46 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v6 2/3] gpg-interface: allow sign_buffer() to use default signing key
Date: Thu, 12 Mar 2026 20:39:37 -0500
Message-ID: <20260313013938.2742124-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260313013938.2742124-1-jltobler@gmail.com>
References: <20260312192228.481134-1-jltobler@gmail.com>
 <20260313013938.2742124-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `sign_commit_to_strbuf()` helper in "commit.c" provides fallback
logic to get the default configured signing key when a key is not
provided and handles generating the commit signature accordingly. This
signing operation is not really specific to commits as any arbitrary
buffer can be signed. Also, in a subsequent commit, this same logic is
reused by git-fast-import(1) when signing commits with invalid
signatures.

Remove the `sign_commit_to_strbuf()` helper from "commit.c" and extend
`sign_buffer()` in "gpg-interface.c" to support using the default key as
a fallback when the `SIGN_BUFFER_USE_DEFAULT_KEY` flag is provided. Call
sites are updated accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/tag.c   |  4 ++--
 commit.c        | 19 +++++--------------
 gpg-interface.c | 13 +++++++++++--
 gpg-interface.h | 12 ++++++++++--
 send-pack.c     |  2 +-
 5 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index aeb04c487f..540d783c67 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -167,7 +167,7 @@ static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
 	char *keyid = get_signing_key();
 	int ret = -1;
 
-	if (sign_buffer(buffer, &sig, keyid))
+	if (sign_buffer(buffer, &sig, keyid, 0))
 		goto out;
 
 	if (compat) {
@@ -176,7 +176,7 @@ static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
 		if (convert_object_file(the_repository ,&compat_buf, algo, compat,
 					buffer->buf, buffer->len, OBJ_TAG, 1))
 			goto out;
-		if (sign_buffer(&compat_buf, &compat_sig, keyid))
+		if (sign_buffer(&compat_buf, &compat_sig, keyid, 0))
 			goto out;
 		add_header_signature(&compat_buf, &sig, algo);
 		strbuf_addbuf(&compat_buf, &compat_sig);
diff --git a/commit.c b/commit.c
index d16ae73345..1b9b2d4499 100644
--- a/commit.c
+++ b/commit.c
@@ -1148,18 +1148,6 @@ int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct gi
 	return 0;
 }
 
-static int sign_commit_to_strbuf(struct strbuf *sig, struct strbuf *buf, const char *keyid)
-{
-	char *keyid_to_free = NULL;
-	int ret = 0;
-	if (!keyid || !*keyid)
-		keyid = keyid_to_free = get_signing_key();
-	if (sign_buffer(buf, sig, keyid))
-		ret = -1;
-	free(keyid_to_free);
-	return ret;
-}
-
 int parse_signed_commit(const struct commit *commit,
 			struct strbuf *payload, struct strbuf *signature,
 			const struct git_hash_algo *algop)
@@ -1737,7 +1725,8 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		oidcpy(&parent_buf[i++], &p->item->object.oid);
 
 	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
-	if (sign_commit && sign_commit_to_strbuf(&sig, &buffer, sign_commit)) {
+	if (sign_commit && sign_buffer(&buffer, &sig, sign_commit,
+				       SIGN_BUFFER_USE_DEFAULT_KEY)) {
 		result = -1;
 		goto out;
 	}
@@ -1769,7 +1758,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		free_commit_extra_headers(compat_extra);
 		free(mapped_parents);
 
-		if (sign_commit && sign_commit_to_strbuf(&compat_sig, &compat_buffer, sign_commit)) {
+		if (sign_commit && sign_buffer(&compat_buffer, &compat_sig,
+					       sign_commit,
+					       SIGN_BUFFER_USE_DEFAULT_KEY)) {
 			result = -1;
 			goto out;
 		}
diff --git a/gpg-interface.c b/gpg-interface.c
index 87fb6605fb..dca192d5c4 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -973,11 +973,20 @@ const char *gpg_trust_level_to_str(enum signature_trust_level level)
 	return sigcheck_gpg_trust_level[level].display_key;
 }
 
-int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
+int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
+		const char *signing_key, enum sign_buffer_flags flags)
 {
+	char *keyid_to_free = NULL;
+	int ret = 0;
+
 	gpg_interface_lazy_init();
 
-	return use_format->sign_buffer(buffer, signature, signing_key);
+	if ((flags & SIGN_BUFFER_USE_DEFAULT_KEY) && (!signing_key || !*signing_key))
+		signing_key = keyid_to_free = get_signing_key();
+
+	ret = use_format->sign_buffer(buffer, signature, signing_key);
+	free(keyid_to_free);
+	return ret;
 }
 
 /*
diff --git a/gpg-interface.h b/gpg-interface.h
index 789d1ffac4..37f3ac42db 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -74,6 +74,15 @@ int parse_signature(const char *buf, size_t size, struct strbuf *payload, struct
  */
 size_t parse_signed_buffer(const char *buf, size_t size);
 
+/* Flags for sign_buffer(). */
+enum sign_buffer_flags {
+	/*
+	 * Use the default configured signing key as returned by `get_signing_key()`
+	 * when the provided "signing_key" is NULL or empty.
+	 */
+	SIGN_BUFFER_USE_DEFAULT_KEY = (1 << 0),
+};
+
 /*
  * Create a detached signature for the contents of "buffer" and append
  * it after "signature"; "buffer" and "signature" can be the same
@@ -81,8 +90,7 @@ size_t parse_signed_buffer(const char *buf, size_t size);
  * at the end.  Returns 0 on success, non-zero on failure.
  */
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
-		const char *signing_key);
-
+		const char *signing_key, enum sign_buffer_flags flags);
 
 /*
  * Returns corresponding string in lowercase for a given member of
diff --git a/send-pack.c b/send-pack.c
index 67d6987b1c..07ecfae4de 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -391,7 +391,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 	if (!update_seen)
 		goto free_return;
 
-	if (sign_buffer(&cert, &cert, signing_key))
+	if (sign_buffer(&cert, &cert, signing_key, 0))
 		die(_("failed to sign the push certificate"));
 
 	packet_buf_write(req_buf, "push-cert%c%s", 0, cap_string);
-- 
2.53.0.381.g628a66ccf6

