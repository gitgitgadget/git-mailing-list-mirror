Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6E30DEB8
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763354118; cv=none; b=nTduoovObi/vUhi8Uild7WpdVbUusrkrIrbpf/sc/sNCCNtL+vCmTPKS/fgiPWuL7+GUpEDiooHdOD9EBhtVMYQMkLHn0J3PMHWzftii7gJSiMGegpUBXrcdZhGQBtaAhsa8/KX7uVWseQka3ScBmAZLLFV3Lo1dUVSEP42XDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763354118; c=relaxed/simple;
	bh=vaVRuRbmzVydPlK3f5jnUweq2RdFmtNzWZh9797nYr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxQh91UxAfBcvSh1iQ2zN81KtJfXctnYSJBx2k3C2WvK+949E8axC61Hf+OBMtg/an9lcoUPtpYfcjQXxtvlq5WOtrrVqD8KnCvWi8znQpImQCMdBhOtehejWSB46LJhZUmn5b3Pctuu8RdKVcjVUiGM2ZNGznRTT95JQK/2wQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+aeHrVa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+aeHrVa"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so2738270f8f.1
        for <git@vger.kernel.org>; Sun, 16 Nov 2025 20:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763354114; x=1763958914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OahB7xI33QZcty/pYZqg1FaFEiShOYPuhZ+pmhlyQ5U=;
        b=Y+aeHrVaCdMdMQC/eAiAdrW41ji6TiT6PnjWYUw0EBLeJaU6Z477CuoZ+sJmzWoTt/
         YwwgN0yTokcGGO5IfOrzEaJenNmA5WeET0kvEsHc6MKMr1RQlwcj4nsfJ4YYTVx4vtAJ
         zqDtoAJzy+1lXGrmo7AF+nH907UMC1fnP6eWfSCBU1ZdJXgzkqAXdWol6e5UD57w3jSg
         eZ+Z0opwkJ+K+2J+zQ4jr8xE7aBaDYRSpTp8Nkb4vZ+Uo8JAzvqWB5VsN0JtXDg/DG3N
         goN1KWt/lU5USLpG7qvmY1xHKxVy1ouvArNKrcVOzT2QAPw8rlP0yeRXw3x2xVUe7KSV
         oGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763354114; x=1763958914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OahB7xI33QZcty/pYZqg1FaFEiShOYPuhZ+pmhlyQ5U=;
        b=PaDgxMkf6GTlFn2KNIYcIjEiL/z/hBcl5JIWEEDtiwv4Sg5FSfPJ4UiJC24pcfnzvX
         cr0H1oymK3Zl2J8hlFd5V61D1kfAIjar61H6pamnEOSxrGc95b53V+Rv4eQqpXVJMOwM
         frIJmNjlEUm4IzBN3f3/j04C1BSoYGVY48j0EnR80OyFQ0tUa3wHPm3IxBb9gkuWP9Vy
         J+o4/Q9mpRce+x6KdBPGZ+3mp2/oE7rKyc+bH6Dfrye7pCJRfQ6ST89kBHCO0SnPfGTp
         JgQ4UqYdCGY8brfk95X/+9had70als9QGCdJPZ9S5tL7Tri79yurqbz7TbuEgn8/uHq/
         brLQ==
X-Gm-Message-State: AOJu0Yz+iuX4aJ5IThBQYjEAua8BhjXbnTbBY6Xe9VM78ZaVmVBiKc8b
	Am6U8pJaDqIJzOWf398pQydldUZlhBeb6LuRI22xyPf5HPpLOSqC1aO7h2Q9Sw==
X-Gm-Gg: ASbGncv3hRdg8iY75qgGEAsK4FOqNrxI8YKQJjiIMHCoPxqgOYZkZbyRZa6VNDBwPyW
	+Plu/d1rrsN7EoRf0TFuWtGrpEKQfgrGIMdKK0aCm2vjPveU6hUJuecLv5p0Ta2yOvogsDqvve8
	Nr7veGTAdBAMyCVjg5cXmjS/b+JI/eK33+g5Pp3rBMxa+afC0aXA0c1rYNOd7gvovXhjecq/v9R
	DX6j8f6pu29W+roiISRlZSp49FgS6sPYnzLmbT2725CarvO4ATNNxyXO04NsejO5HhlvapnTA9d
	RfwF1+h7LoOqh5glsRTg5l63qV9lY45/WxTTmsiMW6cn8WGREXzGZwfqfdl2jsU5mQYC6c7AH/r
	mRsXHaS5Jb5l9bXwUfsjBDDj5hdQE3R3uRbHxRY60+I2TKykaOb4ap1rb9j9aoW19O+2XDigFWk
	bAmlc/eJkZDQFJzd7F02kcGzYSPuvaW5bDhwIN+F3mL7ZxwR1n
X-Google-Smtp-Source: AGHT+IFnHpid4akV0CbUbNHwice3lXlgPijPKdejNh33sH60BjE7xa+rKQF7feQPl83FTE774mCjeg==
X-Received: by 2002:a05:6000:26ca:b0:429:d3c9:b8af with SMTP id ffacd0b85a97d-42b58dc1c93mr11825115f8f.25.1763354114208;
        Sun, 16 Nov 2025 20:35:14 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85627sm25115284f8f.16.2025.11.16.20.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 20:35:13 -0800 (PST)
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
Subject: [PATCH v2 3/3] fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
Date: Mon, 17 Nov 2025 05:34:50 +0100
Message-ID: <20251117043450.322644-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.rc2.6.g1f299c9613
In-Reply-To: <20251117043450.322644-1-christian.couder@gmail.com>
References: <20251105061918.3688870-1-christian.couder@gmail.com>
 <20251117043450.322644-1-christian.couder@gmail.com>
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

Note that as far as signature handling goes:

  * Since fast-export doesn't know what changes filter-repo may make
to the stream, it can't know whether the signatures will still be
valid.

  * Since filter-repo doesn't know what history canonicalizations
fast-export performed (and it performs a few), it can't know whether
the signatures will still be valid.

  * Therefore, fast-import is the only process in the pipeline that
can know whether a specified signature remains valid.

Having invalid signatures in a rewritten repository could be
confusing, so users rewritting history might prefer to simply
discard signatures that are invalid at the fast-import step.

For example a common use case is to rewrite only "recent" history.
While specifying commit ranges corresponding to "recent" commits
could work, users worry about getting it wrong and want to just
automatically rewrite everything, expecting older commit signatures
to be untouched.

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

[1]: https://github.com/newren/git-filter-repo

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-import.adoc | 29 +++++++++----
 builtin/fast-export.c              | 38 ++++++++++++----
 builtin/fast-import.c              | 59 ++++++++++++++++++++++---
 gpg-interface.c                    |  2 +
 gpg-interface.h                    |  1 +
 t/t9305-fast-import-signatures.sh  | 69 +++++++++++++++++++++++++++++-
 6 files changed, 174 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index b74179a6c8..479c4081da 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -66,15 +66,26 @@ fast-import stream! This option is enabled automatically for
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
+  will strip them and display a warning. The validation is performed
+  in the same way as linkgit:git-verify-commit[1] does it.
 
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 0421360ab7..e3fc34b311 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -797,10 +797,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	       (int)(committer_end - committer), committer);
 	if (signatures.nr) {
 		switch (signed_commit_mode) {
-		case SIGN_ABORT:
-			die(_("encountered signed commit %s; use "
-			      "--signed-commits=<mode> to handle it"),
-			    oid_to_hex(&commit->object.oid));
+
+		/* Exporting modes */
 		case SIGN_WARN_VERBATIM:
 			warning(_("exporting %"PRIuMAX" signature(s) for commit %s"),
 				(uintmax_t)signatures.nr, oid_to_hex(&commit->object.oid));
@@ -811,12 +809,25 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 				print_signature(item->string, item->util);
 			}
 			break;
+
+		/* Stripping modes */
 		case SIGN_WARN_STRIP:
 			warning(_("stripping signature(s) from commit %s"),
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
@@ -935,16 +946,16 @@ static void handle_tag(const char *name, struct tag *tag)
 		size_t sig_offset = parse_signed_buffer(message, message_size);
 		if (sig_offset < message_size)
 			switch (signed_tag_mode) {
-			case SIGN_ABORT:
-				die(_("encountered signed tag %s; use "
-				      "--signed-tags=<mode> to handle it"),
-				    oid_to_hex(&tag->object.oid));
+
+			/* Exporting modes */
 			case SIGN_WARN_VERBATIM:
 				warning(_("exporting signed tag %s"),
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case SIGN_VERBATIM:
 				break;
+
+			/* Stripping modes */
 			case SIGN_WARN_STRIP:
 				warning(_("stripping signature from tag %s"),
 					oid_to_hex(&tag->object.oid));
@@ -952,6 +963,17 @@ static void handle_tag(const char *name, struct tag *tag)
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
index cb0d2f635e..78052d33ed 100644
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
index f680ed38c0..10853b517d 100644
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
index ead1ed6967..789d1ffac4 100644
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
index c2b4271658..022dae02e4 100755
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
@@ -103,4 +103,71 @@ test_expect_success GPG 'strip both OpenPGP signatures with --signed-commits=war
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
2.52.0.rc2.6.g1f299c9613

