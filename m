Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4D32D441
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343356; cv=none; b=QMwig2lh0cAPu3fZgjg50SA5fdAL3qCkXRBKczYfKcFfS48iq7adcHyo0rcnPYhCC6riUZH8S6H+b54ntkxrBlqMUBCh6FcAS8zseNkSZ019JpkfDpiM4vgDfwB/aRSxdWajO7wDZVt1h5XbehmB3y3R6BkeqF3v5IFhKNrrPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343356; c=relaxed/simple;
	bh=5UtCq996DoexFMINf8L3T0ivs+RE/ZdUMuBg5fFKc14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6q1UVb3q3Q87GEK9btNwlkri2/18ldUUzqUEDMbouKBq1zl2ijcgZcoieH0nzOBhdDFdKgTQAUJ+nmbeYVzMqI8hzX7graSFeoYWhwiY271koJSwaVFpyOdqHrozqNja0xi2D/LdHbA/qsgZiq9b0FyXkYqGZ1+cs0UYhR+GCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdJaBcLz; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdJaBcLz"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40429b1d8baso609201fac.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773343353; x=1773948153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lB4yYuKogNi0AHP//j6yLA+bbcOi47HFR7m94Uq+uQA=;
        b=UdJaBcLzMJlyXcHiB5Q+BNko3V7E5PTsA6iFujlW50prXB1VTlxCViPzrbOmbqHxnD
         EFANs0VD8bGV3/d0mQ5IAw5YMv511OAcVsJKzDBNe/OY7Xr7uJoRiG1Y8YemGQabLKZ2
         OZ8VPT6pNmorWoZZzChdPLeD/K9eX11zrytqvHoHR/Mzr+JYPb/wa9BM2xhWEjKkV3pj
         KD37tk95ZxJpV6/9H83yXPr34OXx13+Z2sgQWTC0awjaqToqrIJM5LjUIVU1KPiFczGR
         UahHOEPnUIdyLH1x3TS16uUbK+pjJWzniFbMnzSdTfsQZmoDTYJswJ/pjNBcoSB4vMp1
         NRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773343353; x=1773948153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lB4yYuKogNi0AHP//j6yLA+bbcOi47HFR7m94Uq+uQA=;
        b=xUeDFSIexjfWgbv6NLIxO9SSkUBK+No06SRDHa6CmyDgktNhJ0ZHSMul6WwId8Z69U
         RqBJsGbjVEdI1fruHWAM1tc+xzCfNkg0QBPzM7JXRGM+20A0yO58IC9/xtbry1SMQ0Oi
         DRWKU9QrNYc3jxAdrFZao+xvwg3qWDJQor9kp3R8iJp7oVZaipPUx+ZLKemqEQ+r4/Gu
         xDXBH+cl5VoODFWJw8XODT9TqQcOBpS0cMqOn+zTrJ6PVgEFpAqicMbGIpQIOK5OLkyj
         XCxmPtb7WE1lSpZhjSlle8QOyBfJszFMZkCi+PzhiSr0To479nGWrjEmAifwGWnnSaYc
         1IcA==
X-Gm-Message-State: AOJu0YwYnhX+7qptSfBx0SRxtjVeQKF17mq7vPmiO7XJ/wBZfFkBck/v
	8e/SED4ka06dLFq+ngftrYmwXeFDfbt9QNJ8cV4gG0JP2aWi6qpLEtF84O6hsw==
X-Gm-Gg: ATEYQzwlr8WqZoZY2wEQ5YlFohs0geztNZxjNxeeP2pm4XZMjE4M3ZJPSdhNdxrHaCu
	lRsJ+Fs6GSluAOwvl+QdatwQ9rLAGKUrtkGjHQwLDh5rapq8LdkHc7fbA++MvSN7gyELjWYEh5v
	fZI8jz+Y6EX4VRMA1/Phx0bGfTIrnpZCG4ZCHM3y6tQmIUcIFYD/4oosmxZz21LC1ktVPKfnZRB
	BXnq8X+/6gI86yQzYKEhe0SlNlec2VIbR9us6IIHDfayhCUSq4BBC67/sU95WdZxCWwtvGYrhW6
	E63n6u+9gyWs/WcvBnjll6r0iMmKYZaXY+BW+BCNIjyZ37KM0nm7YOFgNXfd0dW8Lb1DFP+QLG1
	TEtLC8cDlD/FoVHGWo2Pnse+5+Sabtz39QkPoXuU6CsJsTN5YgLVghTkD1GdZp+ywlWqan04nlJ
	bOpPMX0/YYuIvRP8J1GNYAu7QdHVKRkwM=
X-Received: by 2002:a05:6871:7c10:b0:417:1bb9:c00 with SMTP id 586e51a60fabf-417b91f0be3mr285982fac.20.1773343353181;
        Thu, 12 Mar 2026 12:22:33 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6e82cdsm6159987fac.18.2026.03.12.12.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:22:32 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 0/3] fast-import: add mode to re-sign invalid commit signatures
Date: Thu, 12 Mar 2026 14:22:25 -0500
Message-ID: <20260312192228.481134-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260311173147.2336432-1-jltobler@gmail.com>
References: <20260311173147.2336432-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

With c20f112e51 (fast-import: add 'strip-if-invalid' mode to
--signed-commits=<mode>, 2025-11-17), it became possible to remove
invalid signatures from commits via git-fast-import(1) while maintaining
valid commit signatures. Building upon this functionality, a user may
want to re-sign these invalid commit signatures. This series introduces
the `sign-if-invalid` mode to do so accordingly.

The newly added mode in this series currently ignores
`extensions.compatObjectFormat` when generating the new signatures. From
my understanding, to generate the compatibility structure would also
require us to reconstruct the compatibility object for the object being
signed. I think this would be possible to do, but would require getting
the mapped OIDs for the commit parents and tree. I'm not completely sure
of a good way to go about this yet though. I'm also not completely
certain if this is something that should be addressed as part of this
series, or could be done later down the road. So for now I've opted to
delay its implementation. I'm open going down the other route if that is
preferred though.

The first commit is a simple cleanup for something I noticed while
reading though commit signing code. The second commit actually
introduces the new `--signed-commits` mode.

Changes since V4:
- Instead of introducing a separate `sign_buffer_with_key()` helper,
  extend `sign_buffer()` to support a SIGN_BUFFER_USE_DEFAULT_KEY flag.
- Fixed message in die().

Changes since V3:
- Rename the `re-sign-if-invalid` mode to `sign-if-invalid`. The
  "if-invalid" already implies the signatures was previously signed
  making "re-sign" redundant.

Changes since V2:
- Adapted commit message in second patch to improve clarity.
- Fixed typos.
- Renamed SIGN_RESIGN_IF_INVALID to SIGN_RE_SIGN_IF_INVALID.
- Created separate helper function to handle printing invalid signature
  warnings.

Changes since V1:
- Improved commit messages and comments to better explain why
  interoperability mode is not currently supported.
- Clarified documentation for re-sign-if-invalid mode.
- Renamed `handle_invalid_signature()` to `handle_signature_if_invalid()`.
- Added warning messages specific to commit resigning.
- Fixed some small typos.
- Added support for explicitly specifying the signing key ID via
  `--signed-commits=re-sign-if-invalid[=<keyid>]` similar to how it can
  specified in git-commit(1).
- We now die() as unsupported when attempting to re-sign an invalid
  commit signature in interoperability mode.
- We now die() when failing to re-sign a commit.

Thanks,
-Justin

Justin Tobler (3):
  commit: remove unused forward declaration
  gpg-interface: allow sign_buffer() to use default signing key
  fast-import: add mode to sign commits with invalid signatures

 Documentation/git-fast-import.adoc |   4 +
 builtin/fast-export.c              |   8 +-
 builtin/fast-import.c              | 101 ++++++++++++++++-----
 builtin/tag.c                      |   4 +-
 commit.c                           |  19 ++--
 commit.h                           |   2 -
 gpg-interface.c                    |  36 +++++---
 gpg-interface.h                    |  19 +++-
 send-pack.c                        |   2 +-
 t/t9305-fast-import-signatures.sh  | 140 ++++++++++++++++++-----------
 10 files changed, 229 insertions(+), 106 deletions(-)

Range-diff against v4:
1:  0d00b72ee0 = 1:  0d00b72ee0 commit: remove unused forward declaration
2:  87f590f1f8 ! 2:  7a0deed77b gpg-interface: introduce sign_buffer_with_key()
    @@ Metadata
     Author: Justin Tobler <jltobler@gmail.com>
     
      ## Commit message ##
    -    gpg-interface: introduce sign_buffer_with_key()
    +    gpg-interface: allow sign_buffer() to use default signing key
     
         The `sign_commit_to_strbuf()` helper in "commit.c" provides fallback
         logic to get the default configured signing key when a key is not
    @@ Commit message
         reused by git-fast-import(1) when signing commits with invalid
         signatures.
     
    -    Move the `sign_commit_to_strbuf()` helper from "commit.c" to
    -    "gpg-interface.c" and rename it to `sign_buffer_with_key()`. Also export
    -    this function so it can be used by "commit.c" and
    -    "builtin/fast-import.c" in the subsequent commit.
    +    Remove the `sign_commit_to_strbuf()` helper from "commit.c" and extend
    +    `sign_buffer()` in "gpg-interface.c" to support using the default key as
    +    a fallback when the `SIGN_BUFFER_USE_DEFAULT_KEY` flag is provided. Call
    +    sites are updated accordingly.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    + ## builtin/tag.c ##
    +@@ builtin/tag.c: static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
    + 	char *keyid = get_signing_key();
    + 	int ret = -1;
    + 
    +-	if (sign_buffer(buffer, &sig, keyid))
    ++	if (sign_buffer(buffer, &sig, keyid, 0))
    + 		goto out;
    + 
    + 	if (compat) {
    +@@ builtin/tag.c: static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
    + 		if (convert_object_file(the_repository ,&compat_buf, algo, compat,
    + 					buffer->buf, buffer->len, OBJ_TAG, 1))
    + 			goto out;
    +-		if (sign_buffer(&compat_buf, &compat_sig, keyid))
    ++		if (sign_buffer(&compat_buf, &compat_sig, keyid, 0))
    + 			goto out;
    + 		add_header_signature(&compat_buf, &sig, algo);
    + 		strbuf_addbuf(&compat_buf, &compat_sig);
    +
      ## commit.c ##
     @@ commit.c: int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct gi
      	return 0;
    @@ commit.c: int commit_tree_extended(const char *msg, size_t msg_len,
      
      	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
     -	if (sign_commit && sign_commit_to_strbuf(&sig, &buffer, sign_commit)) {
    -+	if (sign_commit && sign_buffer_with_key(&buffer, &sig, sign_commit)) {
    ++	if (sign_commit && sign_buffer(&buffer, &sig, sign_commit,
    ++				       SIGN_BUFFER_USE_DEFAULT_KEY)) {
      		result = -1;
      		goto out;
      	}
    @@ commit.c: int commit_tree_extended(const char *msg, size_t msg_len,
      		free(mapped_parents);
      
     -		if (sign_commit && sign_commit_to_strbuf(&compat_sig, &compat_buffer, sign_commit)) {
    -+		if (sign_commit && sign_buffer_with_key(&compat_buffer, &compat_sig, sign_commit)) {
    ++		if (sign_commit && sign_buffer(&compat_buffer, &compat_sig,
    ++					       sign_commit,
    ++					       SIGN_BUFFER_USE_DEFAULT_KEY)) {
      			result = -1;
      			goto out;
      		}
     
      ## gpg-interface.c ##
    -@@ gpg-interface.c: int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
    - 	return use_format->sign_buffer(buffer, signature, signing_key);
    +@@ gpg-interface.c: const char *gpg_trust_level_to_str(enum signature_trust_level level)
    + 	return sigcheck_gpg_trust_level[level].display_key;
      }
      
    -+int sign_buffer_with_key(struct strbuf *buffer, struct strbuf *signature,
    -+			 const char *signing_key)
    -+{
    +-int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
    ++int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
    ++		const char *signing_key, enum sign_buffer_flags flags)
    + {
     +	char *keyid_to_free = NULL;
     +	int ret = 0;
    -+	if (!signing_key || !*signing_key)
    ++
    + 	gpg_interface_lazy_init();
    + 
    +-	return use_format->sign_buffer(buffer, signature, signing_key);
    ++	if (flags & SIGN_BUFFER_USE_DEFAULT_KEY && (!signing_key || !*signing_key))
     +		signing_key = keyid_to_free = get_signing_key();
    -+	if (sign_buffer(buffer, signature, signing_key))
    -+		ret = -1;
    ++
    ++	ret = use_format->sign_buffer(buffer, signature, signing_key);
     +	free(keyid_to_free);
     +	return ret;
    -+}
    -+
    + }
    + 
      /*
    -  * Strip CR from the line endings, in case we are on Windows.
    -  * NEEDSWORK: make it trim only CRs before LFs and rename
     
      ## gpg-interface.h ##
    +@@ gpg-interface.h: int parse_signature(const char *buf, size_t size, struct strbuf *payload, struct
    +  */
    + size_t parse_signed_buffer(const char *buf, size_t size);
    + 
    ++/* Flags for sign_buffer(). */
    ++enum sign_buffer_flags {
    ++	/*
    ++	 * Use the default configured signing key as returned by `get_signing_key()`
    ++	 * when the provided "signing_key" is NULL or empty.
    ++	 */
    ++	SIGN_BUFFER_USE_DEFAULT_KEY = (1 << 0),
    ++};
    ++
    + /*
    +  * Create a detached signature for the contents of "buffer" and append
    +  * it after "signature"; "buffer" and "signature" can be the same
     @@ gpg-interface.h: size_t parse_signed_buffer(const char *buf, size_t size);
    +  * at the end.  Returns 0 on success, non-zero on failure.
    +  */
      int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
    - 		const char *signing_key);
    - 
    -+/*
    -+ * Similar to `sign_buffer()`, but uses the default configured signing key as
    -+ * returned by `get_signing_key()` when the provided "signing_key" is NULL or
    -+ * empty. Returns 0 on success, non-zero on failure.
    -+ */
    -+int sign_buffer_with_key(struct strbuf *buffer, struct strbuf *signature,
    -+			 const char *signing_key);
    +-		const char *signing_key);
    +-
    ++		const char *signing_key, enum sign_buffer_flags flags);
      
      /*
       * Returns corresponding string in lowercase for a given member of
    +
    + ## send-pack.c ##
    +@@ send-pack.c: static int generate_push_cert(struct strbuf *req_buf,
    + 	if (!update_seen)
    + 		goto free_return;
    + 
    +-	if (sign_buffer(&cert, &cert, signing_key))
    ++	if (sign_buffer(&cert, &cert, signing_key, 0))
    + 		die(_("failed to sign the push certificate"));
    + 
    + 	packet_buf_write(req_buf, "push-cert%c%s", 0, cap_string);
3:  8b01ad1570 ! 3:  e659971e84 fast-import: add mode to sign commits with invalid signatures
    @@ builtin/fast-import.c: static void handle_strip_if_invalid(struct strbuf *new_da
     +			 * in interoperability mode is currently unsupported.
     +			 */
     +			if (the_repository->compat_hash_algo)
    -+				die(_("signing signatures in interoperability mode is unsupported"));
    ++				die(_("signing commits in interoperability mode is unsupported"));
     +
     +			strbuf_addstr(&payload, signature_check.payload);
    -+			if (sign_buffer_with_key(&payload, &signature, signed_commit_keyid))
    ++			if (sign_buffer(&payload, &signature, signed_commit_keyid,
    ++					SIGN_BUFFER_USE_DEFAULT_KEY))
     +				die(_("failed to sign commit object"));
     +			add_header_signature(new_data, &signature, the_hash_algo);
     +

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
2.53.0.381.g628a66ccf6

