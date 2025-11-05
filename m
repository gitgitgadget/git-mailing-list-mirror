Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4A176ADE
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 06:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762323589; cv=none; b=natvxmv0R1TtCEphn8xJcXXfYUKfKORnEvq+odxd8gMmJ6BhIvwKkw3R38Cq+3QD8vtjAO49LX9LXWn/VCE1AtZFV1ijO0lh5EV9raldLCprrTemkfRQHnEkkhaC7Irlj9eePAbdhlPhnAWQb864lcJrYv4/I692ZWmGwybnL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762323589; c=relaxed/simple;
	bh=ybvNxhm8K+XyNfxMWw0SijeS7bZcEQ+u83gfoN2aLag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8kwRMYUiiLVF3OchgDGyHnfXbjkzRr1RrRZr4vYwE2YPS5HVuZciGcFwL84+40GbJtnBVbc01FHNksXSgttJVsCq9p4t7X6g9+fhHPlg0Hz9rSNvDbb7AmOHZLy+T7yJEiut9pizewEuFxMUjB79brj2TmP4ksF3+T7nXqFlzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAiPpeyp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAiPpeyp"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso5318674f8f.2
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 22:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762323585; x=1762928385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqge8apSxkOp++s7SptcGAeaBrYLdly9EHywIyPff6M=;
        b=PAiPpeypr1S8Ro/zNw5ZtBhYg0CRraJfhnX7USZaohGx5GaxhGHSFzLq0aDqvmEwiO
         lgJ/hQxyMlbS+R+zsew+RAx61SxWyAhnp29PGTKNlEBhyvqo4T6oDRjDPwChJz4C1vcy
         Tv/MsSKLEPin8nv+5XTxhj+oCFtQdc5vYR3M2pXjPElN1CrZ/wQJk5mbJ7vMgXllvNGO
         K2TRD6N7WUQZaXGO/M+1Y/COqSzrsoK8GVrelfeN/NBprXlBTzfCBQe2bqTO4E6T7/Zp
         xBJZQ/2blqwVe4xa72NQ2xyDCeN9PNKvVJKNjdI5dHuUgUj98W+kE/mCUkrGRckxqgZj
         N+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762323585; x=1762928385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqge8apSxkOp++s7SptcGAeaBrYLdly9EHywIyPff6M=;
        b=J92iZorx/ihp94msN1ZyW220E+4Y6iK3xat30DeUs/4keFpLvZEh4FtU4MOPhgxfnI
         /rrrU092cZRYiZ5LFnyN4jzEeh+JuCrjIHzBwhh/4s4TNLj1wF1dhz/hQ1oDkE1KnFb+
         nhtdlCd2zkIpMydeDiHarKPShPyu750R5CMxsyQrbdM6mX+v1O3FXVqRCdrN1yJoK/+s
         mYE6+LFhcnHwsyrJw+LUMNZwssgQ19XtUfgtM11nQVWan+76VvKlDpLzJIvu9Xkkkrcv
         Yv9vjsUyIqluKuFUjkxGkypU78C6bygP77W4yVZS9dM9fpZMgyp45DRaQm5Z6bAQKlSc
         UEgQ==
X-Gm-Message-State: AOJu0YxvSoUfsmqU4Uk3Z1jU4BUwDsG0r0oNABgHzSPjfggnrk8C6mYM
	rvpI1OTiRkb6e5DMj5peGqf04OXUo+O+qkB6tRH199FxGWwaKyz24xIPcT9kDg==
X-Gm-Gg: ASbGncuaA1+8xfjerpQ1oXJ70giKCD8w+4pd4hux1oy9ydKbcrrwpDKB7ECA/nQJZmc
	/+irp55q5QqsLFIEj9tbSNFIiIbaQIBnCjm5dDhgS+34SSNtWU3cR8NdKUUGwNvReHvjt/oIUs2
	gIIEg1oXy3PtvAK8h0SqDLBaFtRsDJPurPe8WXXuI0etdGxWtucC7jM4xY1Uab6XucqWsYvcTCQ
	zY6tpwR3wQZRmr3MPoRzh1v21CxIbcOTiZk0dWISwROYb/zKapjai/c+gaTq0/xRx1EtSwrACpH
	UXC8YV8WzfPATkNh/6u54InwyKbPoKfs+32jO/VsNJ3hgh6orVYZuNBEDrx3cNCpNA05UmKH8DC
	8LzDXPl4xESOy539Khn0f00xOr9gHODhJuCk6b17sfAM6lXyCzabKxqoeS+Qd6jGSTcutla1G+A
	JjIwaRsxMuaaJ+bQtxsi5Z+1g33eU=
X-Google-Smtp-Source: AGHT+IHAFgH38Nd8u0Zdtlbi1WszTet6wBMJZKbSZLRrW3upQDxloxFZr9dRKUBxB8axCKlXpMHSBw==
X-Received: by 2002:a05:6000:210c:b0:429:b751:792b with SMTP id ffacd0b85a97d-429e33064femr1054355f8f.32.1762323584549;
        Tue, 04 Nov 2025 22:19:44 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5f8csm8225944f8f.23.2025.11.04.22.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 22:19:43 -0800 (PST)
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
Subject: [PATCH 3/3] fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
Date: Wed,  5 Nov 2025 07:19:18 +0100
Message-ID: <20251105061918.3688870-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.3.gf264cd25e5
In-Reply-To: <20251105061918.3688870-1-christian.couder@gmail.com>
References: <20251105061918.3688870-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tools like `git filter-repo`[1] use `git fast-export` and
`git fast-import` to rewrite repository history. When rewriting
history using one such tool though, commit signatures might become
invalid because the commits they sign changed due to the changes
in the repository history made by the tool between the fast-export
and the fast-import steps.

Having invalid signatures in a rewritten repository could be
confusing, so users rewritting history might prefer to simply
discard signatures that are invalid at the fast-import step.

To let them do that, let's add a new 'strip-if-invalid' mode to the
`--signed-commits=<mode>` option of `git fast-import`.

It would be interesting for the `--signed-tags=<mode>` option to
have this mode too, but we leave that for a future improvement.

It might also be possible for `git fast-export` to have such a mode
in its `--signed-commits=<mode>` and `--signed-tags=<mode>`
options, but the use cases for it are much less clear, so we also
leave that for possible future improvements.

For now let's just die() if 'strip-if-invalid' is passed to these
options where it hasn't been implemented yet.

While at it, let's also mark for translation some error messages
linked to the `--signed-commits=<mode>` and `--signed-tags=<mode>`
in `git fast-export`.

[1]: https://github.com/newren/git-filter-repo

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-import.adoc |  28 ++++---
 builtin/fast-export.c              |  46 ++++++++---
 builtin/fast-import.c              |  59 +++++++++++++--
 gpg-interface.c                    |   2 +
 gpg-interface.h                    |   1 +
 t/t9305-fast-import-signatures.sh  | 118 ++++++++++++++++++++++++++++-
 6 files changed, 226 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index b74179a6c8..c9e49497cd 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -66,15 +66,25 @@ fast-import stream! This option is enabled automatically for
 remote-helpers that use the `import` capability, as they are
 already trusted to run their own code.
 
---signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
-	Specify how to handle signed tags.  Behaves in the same way
-	as the same option in linkgit:git-fast-export[1], except that
-	default is 'verbatim' (instead of 'abort').
-
---signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
-	Specify how to handle signed commits.  Behaves in the same way
-	as the same option in linkgit:git-fast-export[1], except that
-	default is 'verbatim' (instead of 'abort').
+`--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)`::
+	Specify how to handle signed tags. Behaves in the same way as
+	the `--signed-commits=<mode>` below, except that the
+	`strip-if-invalid` mode is not yet supported. Like for signed
+	commits, the default mode is `verbatim`.
+
+`--signed-commits=<mode>`::
+	Specify how to handle signed commits. The following <mode>s
+	are supported:
++
+* `verbatim`, which is the default, will silently import commit
+  signatures.
+* `warn-verbatim` will import them, but will display a warning.
+* `abort` will make this program die when encountering a signed
+  commit.
+* `strip` will silently make the commits unsigned.
+* `warn-strip` will make them unsigned, but will display a warning.
+* `strip-if-invalid` will check signatures and, if they are invalid,
+  will strip them and display a warning.
 
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 7adbc55f0d..1ad195b639 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -797,12 +797,10 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	       (int)(committer_end - committer), committer);
 	if (signatures.nr) {
 		switch (signed_commit_mode) {
-		case SIGN_ABORT:
-			die("encountered signed commit %s; use "
-			    "--signed-commits=<mode> to handle it",
-			    oid_to_hex(&commit->object.oid));
+
+		/* Exporting modes */
 		case SIGN_WARN_VERBATIM:
-			warning("exporting %"PRIuMAX" signature(s) for commit %s",
+			warning(_("exporting %"PRIuMAX" signature(s) for commit %s"),
 				(uintmax_t)signatures.nr, oid_to_hex(&commit->object.oid));
 			/* fallthru */
 		case SIGN_VERBATIM:
@@ -811,12 +809,25 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 				print_signature(item->string, item->util);
 			}
 			break;
+
+		/* Stripping modes */
 		case SIGN_WARN_STRIP:
-			warning("stripping signature(s) from commit %s",
+			warning(_("stripping signature(s) from commit %s"),
 				oid_to_hex(&commit->object.oid));
 			/* fallthru */
 		case SIGN_STRIP:
 			break;
+
+		/* Aborting modes */
+		case SIGN_ABORT:
+			die(_("encountered signed commit %s; use "
+			      "--signed-commits=<mode> to handle it"),
+			    oid_to_hex(&commit->object.oid));
+		case SIGN_STRIP_IF_INVALID:
+			die(_("'strip-if-invalid' is not a valid mode for "
+			      "git fast-export with --signed-commits=<mode>"));
+		default:
+			BUG("invalid signed_commit_mode value %d", signed_commit_mode);
 		}
 		string_list_clear(&signatures, 0);
 	}
@@ -934,23 +945,34 @@ static void handle_tag(const char *name, struct tag *tag)
 		size_t sig_offset = parse_signed_buffer(message, message_size);
 		if (sig_offset < message_size)
 			switch (signed_tag_mode) {
-			case SIGN_ABORT:
-				die("encountered signed tag %s; use "
-				    "--signed-tags=<mode> to handle it",
-				    oid_to_hex(&tag->object.oid));
+
+			/* Exporting modes */
 			case SIGN_WARN_VERBATIM:
-				warning("exporting signed tag %s",
+				warning(_("exporting signed tag %s"),
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case SIGN_VERBATIM:
 				break;
+
+			/* Stripping modes */
 			case SIGN_WARN_STRIP:
-				warning("stripping signature from tag %s",
+				warning(_("stripping signature from tag %s"),
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case SIGN_STRIP:
 				message_size = sig_offset;
 				break;
+
+			/* Aborting modes */
+			case SIGN_ABORT:
+				die(_("encountered signed tag %s; use "
+				      "--signed-tags=<mode> to handle it"),
+				    oid_to_hex(&tag->object.oid));
+			case SIGN_STRIP_IF_INVALID:
+				die(_("'strip-if-invalid' is not a valid mode for "
+				      "git fast-export with --signed-tags=<mode>"));
+			default:
+				BUG("invalid signed_commit_mode value %d", signed_commit_mode);
 			}
 	}
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 493de57ef6..e2c6894461 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2772,7 +2772,7 @@ static void add_gpgsig_to_commit(struct strbuf *commit_data,
 {
 	struct string_list siglines = STRING_LIST_INIT_NODUP;
 
-	if (!sig->hash_algo)
+	if (!sig || !sig->hash_algo)
 		return;
 
 	strbuf_addstr(commit_data, header);
@@ -2827,6 +2827,45 @@ static void finalize_commit_buffer(struct strbuf *new_data,
 	strbuf_addbuf(new_data, msg);
 }
 
+static void handle_strip_if_invalid(struct strbuf *new_data,
+				    struct signature_data *sig_sha1,
+				    struct signature_data *sig_sha256,
+				    struct strbuf *msg)
+{
+	struct strbuf tmp_buf = STRBUF_INIT;
+	struct signature_check signature_check = { 0 };
+	int ret;
+
+	/* Check signature in a temporary commit buffer */
+	strbuf_addbuf(&tmp_buf, new_data);
+	finalize_commit_buffer(&tmp_buf, sig_sha1, sig_sha256, msg);
+	ret = verify_commit_buffer(tmp_buf.buf, tmp_buf.len, &signature_check);
+
+	if (ret) {
+		const char *signer = signature_check.signer ?
+			signature_check.signer : _("unknown");
+		const char *subject;
+		int subject_len = find_commit_subject(msg->buf, &subject);
+
+		if (subject_len > 100)
+			warning(_("stripping invalid signature for commit '%.100s...'\n"
+				  "  allegedly by %s"), subject, signer);
+		else if (subject_len > 0)
+			warning(_("stripping invalid signature for commit '%.*s'\n"
+				  "  allegedly by %s"), subject_len, subject, signer);
+		else
+			warning(_("stripping invalid signature for commit\n"
+				  "  allegedly by %s"), signer);
+
+		finalize_commit_buffer(new_data, NULL, NULL, msg);
+	} else {
+		strbuf_swap(new_data, &tmp_buf);
+	}
+
+	signature_check_clear(&signature_check);
+	strbuf_release(&tmp_buf);
+}
+
 static void parse_new_commit(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
@@ -2878,6 +2917,7 @@ static void parse_new_commit(const char *arg)
 			warning(_("importing a commit signature verbatim"));
 			/* fallthru */
 		case SIGN_VERBATIM:
+		case SIGN_STRIP_IF_INVALID:
 			import_one_signature(&sig_sha1, &sig_sha256, v);
 			break;
 
@@ -2962,7 +3002,11 @@ static void parse_new_commit(const char *arg)
 			"encoding %s\n",
 			encoding);
 
-	finalize_commit_buffer(&new_data, &sig_sha1, &sig_sha256, &msg);
+	if (signed_commit_mode == SIGN_STRIP_IF_INVALID &&
+	    (sig_sha1.hash_algo || sig_sha256.hash_algo))
+		handle_strip_if_invalid(&new_data, &sig_sha1, &sig_sha256, &msg);
+	else
+		finalize_commit_buffer(&new_data, &sig_sha1, &sig_sha256, &msg);
 
 	free(author);
 	free(committer);
@@ -2984,9 +3028,6 @@ static void handle_tag_signature(struct strbuf *msg, const char *name)
 	switch (signed_tag_mode) {
 
 	/* First, modes that don't change anything */
-	case SIGN_ABORT:
-		die(_("encountered signed tag; use "
-		      "--signed-tags=<mode> to handle it"));
 	case SIGN_WARN_VERBATIM:
 		warning(_("importing a tag signature verbatim for tag '%s'"), name);
 		/* fallthru */
@@ -3003,7 +3044,13 @@ static void handle_tag_signature(struct strbuf *msg, const char *name)
 		strbuf_setlen(msg, sig_offset);
 		break;
 
-	/* Third, BUG */
+	/* Third, aborting modes */
+	case SIGN_ABORT:
+		die(_("encountered signed tag; use "
+		      "--signed-tags=<mode> to handle it"));
+	case SIGN_STRIP_IF_INVALID:
+		die(_("'strip-if-invalid' is not a valid mode for "
+		      "git fast-import with --signed-tags=<mode>"));
 	default:
 		BUG("invalid signed_tag_mode value %d from tag '%s'",
 		    signed_tag_mode, name);
diff --git a/gpg-interface.c b/gpg-interface.c
index d1e88da8c1..fe653b2464 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1146,6 +1146,8 @@ int parse_sign_mode(const char *arg, enum sign_mode *mode)
 		*mode = SIGN_WARN_STRIP;
 	else if (!strcmp(arg, "strip"))
 		*mode = SIGN_STRIP;
+	else if (!strcmp(arg, "strip-if-invalid"))
+		*mode = SIGN_STRIP_IF_INVALID;
 	else
 		return -1;
 	return 0;
diff --git a/gpg-interface.h b/gpg-interface.h
index 50487aa148..71dde8cb80 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -111,6 +111,7 @@ enum sign_mode {
 	SIGN_VERBATIM,
 	SIGN_WARN_STRIP,
 	SIGN_STRIP,
+	SIGN_STRIP_IF_INVALID,
 };
 
 /*
diff --git a/t/t9305-fast-import-signatures.sh b/t/t9305-fast-import-signatures.sh
index c2b4271658..db77ace472 100755
--- a/t/t9305-fast-import-signatures.sh
+++ b/t/t9305-fast-import-signatures.sh
@@ -79,7 +79,7 @@ test_expect_success GPG 'setup a commit with dual OpenPGP signatures on its SHA-
 	echo B >explicit-sha256/B &&
 	git -C explicit-sha256 add B &&
 	test_tick &&
-	git -C explicit-sha256 commit -S -m "signed" B &&
+	git -C explicit-sha256 commit -S -m "signed commit" B &&
 	SHA256_B=$(git -C explicit-sha256 rev-parse dual-signed) &&
 
 	# Create the corresponding SHA-1 commit
@@ -103,4 +103,120 @@ test_expect_success GPG 'strip both OpenPGP signatures with --signed-commits=war
 	test_line_count = 2 out
 '
 
+test_expect_success GPG 'import commit with no signature with --signed-commits=strip-if-invalid' '
+	git fast-export main >output &&
+	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
+	test_must_be_empty log
+'
+
+test_expect_success GPG 'keep valid OpenPGP signature with --signed-commits=strip-if-invalid' '
+	rm -rf new &&
+	git init new &&
+
+	git fast-export --signed-commits=verbatim openpgp-signing >output &&
+	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
+	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
+	test $OPENPGP_SIGNING = $IMPORTED &&
+	git -C new cat-file commit "$IMPORTED" >actual &&
+	test_grep -E "^gpgsig(-sha256)? " actual &&
+	test_must_be_empty log
+'
+
+test_expect_success GPG 'strip signature invalidated by message change with --signed-commits=strip-if-invalid' '
+	rm -rf new &&
+	git init new &&
+
+	git fast-export --signed-commits=verbatim openpgp-signing >output &&
+
+	# Change the commit message, which invalidates the signature.
+	# The commit message length should not change though, otherwise the
+	# corresponding `data <length>` command would have to be changed too.
+	sed "s/OpenPGP signed commit/OpenPGP forged commit/" output >modified &&
+
+	git -C new fast-import --quiet --signed-commits=strip-if-invalid <modified >log 2>&1 &&
+
+	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
+	test $OPENPGP_SIGNING != $IMPORTED &&
+	git -C new cat-file commit "$IMPORTED" >actual &&
+	test_grep ! -E "^gpgsig" actual &&
+	test_grep "stripping invalid signature" log
+'
+
+test_expect_success GPG 'keep valid dual OpenPGP signatures with --signed-commits=strip-if-invalid' '
+	rm -rf new &&
+	git init new &&
+
+	git -C explicit-sha256 fast-export --signed-commits=verbatim dual-signed >output &&
+	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
+
+	git -C new cat-file commit refs/heads/dual-signed >actual &&
+	test_grep -E "^gpgsig " actual &&
+	test_grep -E "^gpgsig-sha256 " actual &&
+	test_must_be_empty log &&
+
+	IMPORTED=$(git -C new rev-parse refs/heads/dual-signed) &&
+	if test "$GIT_DEFAULT_HASH" = "sha1"
+	then
+		test $SHA1_B = $IMPORTED
+	else
+		test $SHA256_B = $IMPORTED
+	fi
+'
+
+test_expect_success GPG 'strip both invalid dual OpenPGP signatures with --signed-commits=strip-if-invalid' '
+	rm -rf new &&
+	git init new &&
+
+	git -C explicit-sha256 fast-export --signed-commits=verbatim dual-signed >output &&
+
+	# Change the commit message, which invalidates the signature.
+	# The commit message length should not change though, otherwise the
+	# corresponding `data <length>` command would have to be changed too.
+	sed "s/signed commit/forged commit/" output >modified &&
+
+	git -C new fast-import --quiet --signed-commits=strip-if-invalid <modified >log 2>&1 &&
+
+	git -C new cat-file commit refs/heads/dual-signed >actual &&
+	test_grep ! -E "^gpgsig " actual &&
+	test_grep ! -E "^gpgsig-sha256 " actual &&
+
+	IMPORTED=$(git -C new rev-parse refs/heads/dual-signed) &&
+	if test "$GIT_DEFAULT_HASH" = "sha1"
+	then
+		test $SHA1_B != $IMPORTED
+	else
+		test $SHA256_B != $IMPORTED
+	fi &&
+
+	test_grep "stripping invalid signature" log
+'
+
+test_expect_success GPGSM 'keep valid X.509 signature with --signed-commits=strip-if-invalid' '
+	rm -rf new &&
+	git init new &&
+
+	git fast-export --signed-commits=verbatim x509-signing >output &&
+	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
+	IMPORTED=$(git -C new rev-parse --verify refs/heads/x509-signing) &&
+	test $X509_SIGNING = $IMPORTED &&
+	git -C new cat-file commit "$IMPORTED" >actual &&
+	test_grep -E "^gpgsig(-sha256)? " actual &&
+	test_must_be_empty log
+'
+
+test_expect_success GPGSSH 'keep valid SSH signature with --signed-commits=strip-if-invalid' '
+	rm -rf new &&
+	git init new &&
+
+	test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+
+	git fast-export --signed-commits=verbatim ssh-signing >output &&
+	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
+	IMPORTED=$(git -C new rev-parse --verify refs/heads/ssh-signing) &&
+	test $SSH_SIGNING = $IMPORTED &&
+	git -C new cat-file commit "$IMPORTED" >actual &&
+	test_grep -E "^gpgsig(-sha256)? " actual &&
+	test_must_be_empty log
+'
+
 test_done
-- 
2.52.0.rc0.3.gf264cd25e5

