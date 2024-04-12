Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87753373
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915965; cv=none; b=hFSEJM7bHJQtDllNlVMnU60BuJ1kR5LSR3Pd+Jwr/h7MIinlAZFGzPBryLBpl8Iho5ivpNQR68F7eko17BF4VftU9QpgX6Tzt1culz8bVung3YcJLq92R4yCiLqsEtqTp9NuOOVQKnhUHHKmGsqIMdXpkhV7xE/Je9bgXw7wEc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915965; c=relaxed/simple;
	bh=3NrmtR3rKpwMbAW4C52M6pu9wC5/xrn/55U/DVJiFvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssw7ZpzvesnhA2y3dH9ZWgGWd7f6Xak8DPLBiguTOBjubU9E3rnCVUylyiB3aQMGkixIjd422Q3WEkzfRD9d5M+VoyjOMgqFmCRjMow2j4XMQ2soG/R77xX3q9Gi9cXoe+9G5NyA3MCPNLrJij7zwAQIZaPXbhUqALOdzmlcHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn644sU/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn644sU/"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so999174a12.2
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712915961; x=1713520761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK2sjj03Q9An4nxlyyFUBDx9sq4Y16Ay4hpRN1KWrLY=;
        b=fn644sU/E/+agh2yfsEWivSgLbu6gMBKn9q1jyxWR6ZcAw6Vq6nZy8iDfoqzgQCBPc
         yyfroWQ1m1Fkz5pwZUZ7VvQrMDM9XN9/GYylMpp3/aLmNMeSf+eC4XQOAzXIcMKrNdE+
         KfkqNPrtHgzOEIJVcL39fvPzdGLAU9PU8LyH5+HM7Vf9qWDitMqr+0bff8nuNYz9EL8Y
         DtwOaDGEY3McAHtTQ4HbC5u6c/Xw3s2YdivuMMYPe04NdPJceTD6v4lrLEiiXPjPT4hH
         uUuBZGYCQ7fY+IFkkjAzRyWmGpDR6o2WEsFvoU+F4DGGxDGMiJP7rtJEEHKuvpIVfl/a
         GKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915961; x=1713520761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK2sjj03Q9An4nxlyyFUBDx9sq4Y16Ay4hpRN1KWrLY=;
        b=hoMSY9yNDH5Fq0hyfg943SkwKx84tUcpIi8sQzACscLtc5+Isc+6ZBpdypJWPgD4ic
         FBpiAkMfiisRzMCbeqhPLOak9NDAYBQBBTPJ9GKPRxZQuD46Jx7wSqwHKX619PxSQU7c
         vjt60svR+Gwoavr5Cwwort1sd3pGPYTr5mBxe5dzYLn3VtnOqeLAuiMa5SD4nMr1KgTL
         /P37RFnWKIDaHC2oAQRJqms72FJo7QwH4Sel3IBEjpxkcUGCXsynj0mT8WnTwfxv6UjB
         oxNGAT6XhomiSlkLK5EAdM0ouGHk9xEDh2cmupWMyh1tYV7c7xoM5w3jbETa63BwJJxs
         1PBA==
X-Forwarded-Encrypted: i=1; AJvYcCVZRbIyOE7DSPQB+/2f6E9FxM2gPXjrOOS+kRf71769+mDQJWdIm/+IdDPxn9pApKwHY0Xmrk0eyvoOvPjJZNqCLxb5
X-Gm-Message-State: AOJu0YzrfCB0foOl5emGR53lSgvRee+19B2K/BQgaJ4gGTuzUVUYEZyh
	6wZB0nvq/vF4pBr+e27mEERIk33gZTYppT4tVcwLva6zbL6H8UrFxCwiag==
X-Google-Smtp-Source: AGHT+IEHdPqVb+mvvTSEoXgYEaHYrflU5I4nIsFTZzvOGs02NO8u6+gUulzZMjrnXWumd+5x8qOJ5g==
X-Received: by 2002:a50:9b1a:0:b0:56d:f3a7:60e with SMTP id o26-20020a509b1a000000b0056df3a7060emr1594294edi.22.1712915961192;
        Fri, 12 Apr 2024 02:59:21 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:355c:c013:66aa:c838])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b0056e67f9f4c3sm1498552edb.72.2024.04.12.02.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:59:20 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 2/7] update-ref: add support for symref-verify
Date: Fri, 12 Apr 2024 11:59:03 +0200
Message-ID: <20240412095908.1134387-3-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412095908.1134387-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

In the previous commit, we added the required base for adding symref
support in transactions provided by the 'git-update-ref(1)'. This commit
introduces the 'symref-verify' command which is similar to the existing
'verify' command for regular refs.

The 'symref-verify' command allows users to verify if a provided <ref>
contains the provided <old-ref> without changing the <ref>. If <old-ref>
is not provided, the command will verify that the <ref> doesn't exist.
Since we're checking for symbolic refs, this command will only work with
the 'no-deref' mode. This is because any dereferenced symbolic ref will
point to an object and not a ref and the regular 'verify' command can be
used in such situations.

This commit adds all required helper functions required to also
introduce the other symref commands, namely create, delete, and update.
We also add tests to test the command in both the regular stdin mode and
also with the '-z' flag.

When the user doesn't provide a <old-ref> we need to check that the
provided <ref> doesn't exist. And to do this, we take over the existing
understanding that <old-oid> when set to its zero value, it refers to
the ref not existing. While this seems like a mix of contexts between
using <*-ref> and <*-oid>, this actually works really well, especially
considering the fact that we want to eventually also introduce

    symref-update SP <ref> SP <new-ref> [SP (<old-oid> | <old-rev>)] LF

and here, we'd allow the user to update a regular <ref> to a symref and
use <old-oid> to check the <ref>'s oid. This can be extrapolated to the
user using this to create a symref when provided a zero <old-oid>. Which
will work given how we're setting it up.

We also disable the reference-transaction hook for symref-updates which
will be tackled in its own commit.

Add required tests for 'symref-verify' while also adding reflog checks for
the pre-existing 'verify' tests.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  7 +++
 builtin/update-ref.c             | 82 ++++++++++++++++++++++++++++----
 refs.c                           | 37 +++++++++++---
 refs.h                           |  1 +
 refs/files-backend.c             | 46 +++++++++++++++++-
 refs/refs-internal.h             |  7 +++
 refs/reftable-backend.c          | 23 ++++++++-
 t/t1400-update-ref.sh            | 80 ++++++++++++++++++++++++++++++-
 8 files changed, 262 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 374a2ebd2b..749aaa7892 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
 	verify SP <ref> [SP <old-oid>] LF
+	symref-verify SP <ref> [SP <old-ref>] LF
 	option SP <opt> LF
 	start LF
 	prepare LF
@@ -86,6 +87,7 @@ quoting:
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
 	verify SP <ref> NUL [<old-oid>] NUL
+	symref-verify SP <ref> [NUL <old-ref>] NUL
 	option SP <opt> NUL
 	start NUL
 	prepare NUL
@@ -117,6 +119,11 @@ verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
 
+symref-verify::
+	Verify symbolic <ref> against <old-ref> but do not change it.
+	If <old-ref> is missing, the ref must not exist.  Can only be
+	used in `no-deref` mode.
+
 option::
 	Modify the behavior of the next command naming a <ref>.
 	The only valid option is `no-deref` to avoid dereferencing
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 21fdbf6ac8..4ae6bdcb12 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -76,6 +76,30 @@ static char *parse_refname(const char **next)
 	return strbuf_detach(&ref, NULL);
 }
 
+
+
+/*
+ * Wrapper around parse_refname which skips the next delimiter.
+ */
+static char *parse_next_refname(const char **next)
+{
+        if (line_termination) {
+                /* Without -z, consume SP and use next argument */
+                if (!**next || **next == line_termination)
+                        return NULL;
+                if (**next != ' ')
+                        die("expected SP but got: %s", *next);
+        } else {
+                /* With -z, read the next NUL-terminated line */
+                if (**next)
+                        return NULL;
+        }
+        /* Skip the delimiter */
+        (*next)++;
+
+        return parse_refname(next);
+}
+
 /*
  * The value being parsed is <old-oid> (as opposed to <new-oid>; the
  * difference affects which error messages are generated):
@@ -297,11 +321,48 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
 		die("verify %s: extra input: %s", refname, next);
 
 	if (ref_transaction_verify(transaction, refname, &old_oid,
-				   update_flags, &err))
+				   NULL, update_flags, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	strbuf_release(&err);
+}
+
+static void parse_cmd_symref_verify(struct ref_transaction *transaction,
+                                    const char *next, const char *end)
+{
+	struct strbuf err = STRBUF_INIT;
+	struct object_id old_oid;
+	char *refname, *old_ref;
+
+	if (!(update_flags & REF_NO_DEREF))
+		die("symref-verify: cannot operate with deref mode");
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("symref-verify: missing <ref>");
+
+	/*
+	 * old_ref is optional, but we want to differentiate between
+	 * a NULL and zero value.
+	 */
+	old_ref = parse_next_refname(&next);
+	if (!old_ref)
+		old_oid = *null_oid();
+	else if (read_ref(old_ref, NULL))
+		die("symref-verify %s: invalid <old-ref>", refname);
+
+	if (*next != line_termination)
+		die("symref-verify %s: extra input: %s", refname, next);
+
+	if (ref_transaction_verify(transaction, refname, old_ref ? NULL : &old_oid,
+				   old_ref, update_flags | REF_SYMREF_UPDATE, &err))
 		die("%s", err.buf);
 
 	update_flags = default_flags;
 	free(refname);
+	free(old_ref);
 	strbuf_release(&err);
 }
 
@@ -380,15 +441,16 @@ static const struct parse_cmd {
 	unsigned args;
 	enum update_refs_state state;
 } command[] = {
-	{ "update",  parse_cmd_update,  3, UPDATE_REFS_OPEN },
-	{ "create",  parse_cmd_create,  2, UPDATE_REFS_OPEN },
-	{ "delete",  parse_cmd_delete,  2, UPDATE_REFS_OPEN },
-	{ "verify",  parse_cmd_verify,  2, UPDATE_REFS_OPEN },
-	{ "option",  parse_cmd_option,  1, UPDATE_REFS_OPEN },
-	{ "start",   parse_cmd_start,   0, UPDATE_REFS_STARTED },
-	{ "prepare", parse_cmd_prepare, 0, UPDATE_REFS_PREPARED },
-	{ "abort",   parse_cmd_abort,   0, UPDATE_REFS_CLOSED },
-	{ "commit",  parse_cmd_commit,  0, UPDATE_REFS_CLOSED },
+	{ "update",        parse_cmd_update,        3, UPDATE_REFS_OPEN },
+	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
+	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
+	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
+	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
+	{ "start",         parse_cmd_start,         0, UPDATE_REFS_STARTED },
+	{ "prepare",       parse_cmd_prepare,       0, UPDATE_REFS_PREPARED },
+	{ "abort",         parse_cmd_abort,         0, UPDATE_REFS_CLOSED },
+	{ "commit",        parse_cmd_commit,        0, UPDATE_REFS_CLOSED },
 };
 
 static void update_refs_stdin(void)
diff --git a/refs.c b/refs.c
index 967c81167e..124b294c9f 100644
--- a/refs.c
+++ b/refs.c
@@ -19,6 +19,7 @@
 #include "object-store-ll.h"
 #include "object.h"
 #include "path.h"
+#include "string.h"
 #include "tag.h"
 #include "submodule.h"
 #include "worktree.h"
@@ -29,6 +30,7 @@
 #include "date.h"
 #include "commit.h"
 #include "wildmatch.h"
+#include "wrapper.h"
 
 /*
  * List of all available backends
@@ -1217,6 +1219,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 	for (i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
+		free((void *)transaction->updates[i]->old_ref);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -1242,10 +1245,19 @@ struct ref_update *ref_transaction_add_update(
 
 	update->flags = flags;
 
-	if (flags & REF_HAVE_NEW)
-		oidcpy(&update->new_oid, new_oid);
-	if (flags & REF_HAVE_OLD)
-		oidcpy(&update->old_oid, old_oid);
+	/*
+	 * The ref values are to be considered over the oid values when we're
+	 * doing symref operations.
+	 */
+	if (update->flags & REF_SYMREF_UPDATE) {
+		if (old_ref)
+			update->old_ref = xstrdup(old_ref);
+	} else {
+		if (flags & REF_HAVE_NEW)
+			oidcpy(&update->new_oid, new_oid);
+		if (flags & REF_HAVE_OLD)
+			oidcpy(&update->old_oid, old_oid);
+	}
 	update->msg = normalize_reflog_message(msg);
 	return update;
 }
@@ -1280,6 +1292,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
 
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
+	flags |= (new_ref ? REF_HAVE_NEW : 0) | (old_ref ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, new_ref, old_ref, msg);
@@ -1318,14 +1331,17 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 int ref_transaction_verify(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
+			   const char *old_ref,
 			   unsigned int flags,
 			   struct strbuf *err)
 {
-	if (!old_oid)
+	if (flags & REF_SYMREF_UPDATE && !old_ref && !old_oid)
+		BUG("verify called with old_ref set to NULL");
+	if (!(flags & REF_SYMREF_UPDATE) && !old_oid)
 		BUG("verify called with old_oid set to NULL");
 	return ref_transaction_update(transaction, refname,
 				      NULL, old_oid,
-				      NULL, NULL,
+				      NULL, old_ref,
 				      flags, NULL, err);
 }
 
@@ -2342,6 +2358,9 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
+		if (update->flags & REF_SYMREF_UPDATE)
+			continue;
+
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s %s %s\n",
 			    oid_to_hex(&update->old_oid),
@@ -2795,3 +2814,9 @@ int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg
 {
 	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
+
+int null_new_value(struct ref_update *update) {
+	if (update->flags & REF_SYMREF_UPDATE && update->new_ref)
+		return 0;
+	return is_null_oid(&update->new_oid);
+}
diff --git a/refs.h b/refs.h
index 645fe9fdb8..a988e672ff 100644
--- a/refs.h
+++ b/refs.h
@@ -772,6 +772,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 int ref_transaction_verify(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
+			   const char *old_ref,
 			   unsigned int flags,
 			   struct strbuf *err);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e4d0aa3d41..8421530bde 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2411,6 +2411,37 @@ static const char *original_update_refname(struct ref_update *update)
 	return update->refname;
 }
 
+/*
+ * Check whether the REF_HAVE_OLD and old_ref values stored in update
+ * are consistent with ref, which is the symbolic reference's current
+ * value. If everything is OK, return 0; otherwise, write an error
+ * message to err and return -1.
+ */
+static int check_old_ref(struct ref_update *update, char *ref,
+			 struct strbuf *err)
+{
+	if (!(update->flags & REF_HAVE_OLD) ||
+	    !strcmp(update->old_ref, ref))
+		return 0;
+
+	if (!strcmp(update->old_ref, ""))
+		strbuf_addf(err, "cannot lock ref '%s': "
+			    "reference already exists",
+			    original_update_refname(update));
+	else if (!strcmp(ref, ""))
+		strbuf_addf(err, "cannot lock ref '%s': "
+			    "reference is missing but expected %s",
+			    original_update_refname(update),
+			    update->old_ref);
+	else
+		strbuf_addf(err, "cannot lock ref '%s': "
+			    "is at %s but expected %s",
+			    original_update_refname(update),
+			    ref, update->old_ref);
+
+	return -1;
+}
+
 /*
  * Check whether the REF_HAVE_OLD and old_oid values stored in update
  * are consistent with oid, which is the reference's current value. If
@@ -2464,8 +2495,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			       struct strbuf *err)
 {
 	struct strbuf referent = STRBUF_INIT;
-	int mustexist = (update->flags & REF_HAVE_OLD) &&
-		!is_null_oid(&update->old_oid);
+	int mustexist = (update->flags & REF_HAVE_OLD) && !is_null_oid(&update->old_oid);
 	int ret = 0;
 	struct ref_lock *lock;
 
@@ -2514,6 +2544,18 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto out;
 				}
+			}
+
+			/*
+			 * For symref verification, we need to check the referent value
+			 * rather than the oid. If we're dealing with regular refs or we're
+			 * verifying a dereferenced symref, we then check the oid.
+			 */
+			if (update->flags & REF_SYMREF_UPDATE && update->old_ref) {
+				if (check_old_ref(update, referent.buf, err)) {
+					ret = TRANSACTION_GENERIC_ERROR;
+					goto out;
+				}
 			} else if (check_old_oid(update, &lock->old_oid, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto out;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4c5fe02687..21c6b940d8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -749,4 +749,11 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
  */
 struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store);
 
+/*
+ * Helper function to check if the new value is null, this
+ * takes into consideration that the update could be a regular
+ * ref or a symbolic ref.
+ */
+int null_new_value(struct ref_update *update);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6104471199..7a03922c7b 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -938,7 +938,28 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		 * individual refs. But the error messages match what the files
 		 * backend returns, which keeps our tests happy.
 		 */
-		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
+		if ((u->flags & REF_HAVE_OLD) &&
+		    (u->flags & REF_SYMREF_UPDATE) &&
+		    u->old_ref) {
+			if   (strcmp(referent.buf, u->old_ref)) {
+				if (!strcmp(u->old_ref, ""))
+					strbuf_addf(err, "cannot lock ref '%s': "
+						    "reference already exists",
+						    original_update_refname(u));
+				else if (!strcmp(referent.buf, ""))
+					strbuf_addf(err, "cannot lock ref '%s': "
+						    "reference is missing but expected %s",
+						    original_update_refname(u),
+						    u->old_ref);
+				else
+					strbuf_addf(err, "cannot lock ref '%s': "
+						    "is at %s but expected %s",
+						    original_update_refname(u),
+						    referent.buf, u->old_ref);
+				ret = -1;
+				goto done;
+			}
+		} else if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
 			if (is_null_oid(&u->old_oid))
 				strbuf_addf(err, _("cannot lock ref '%s': "
 					    "reference already exists"),
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index ec3443cc87..d8ffda4096 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -890,17 +890,23 @@ test_expect_success 'stdin update/create/verify combination works' '
 '
 
 test_expect_success 'stdin verify succeeds for correct value' '
+	test-tool ref-store main for-each-reflog-ent $m >before &&
 	git rev-parse $m >expect &&
 	echo "verify $m $m" >stdin &&
 	git update-ref --stdin <stdin &&
 	git rev-parse $m >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent $m >after &&
+	test_cmp before after
 '
 
 test_expect_success 'stdin verify succeeds for missing reference' '
+	test-tool ref-store main for-each-reflog-ent $m >before &&
 	echo "verify refs/heads/missing $Z" >stdin &&
 	git update-ref --stdin <stdin &&
-	test_must_fail git rev-parse --verify -q refs/heads/missing
+	test_must_fail git rev-parse --verify -q refs/heads/missing &&
+	test-tool ref-store main for-each-reflog-ent $m >after &&
+	test_cmp before after
 '
 
 test_expect_success 'stdin verify treats no value as missing' '
@@ -1641,4 +1647,74 @@ test_expect_success PIPE 'transaction flushes status updates' '
 	test_cmp expected actual
 '
 
+create_stdin_buf ()
+{
+	if test "$1" = "-z"
+	then
+		shift
+		printf "$F" "$@" >stdin
+	else
+		echo "$@" >stdin
+	fi
+}
+
+for type in "" "-z"
+do
+
+test_expect_success "stdin ${type} symref-verify fails without --no-deref" '
+	git symbolic-ref refs/heads/symref $a &&
+	create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
+	test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+	grep "fatal: symref-verify: cannot operate with deref mode" err
+'
+
+test_expect_success "stdin ${type} symref-verify fails with too many arguments" '
+	create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" "$a" &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err  &&
+	if test "$type" = "-z"
+	then
+		grep "fatal: unknown command: $a" err
+	else
+		grep "fatal: symref-verify refs/heads/symref: extra input:  $a" err
+	fi
+'
+
+test_expect_success "stdin ${type} symref-verify succeeds for correct value" '
+	git symbolic-ref refs/heads/symref >expect &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
+	create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
+	git update-ref --stdin ${type} --no-deref <stdin &&
+	git symbolic-ref refs/heads/symref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
+	test_cmp before after
+'
+
+test_expect_success "stdin ${type} symref-verify succeeds for missing reference" '
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
+	create_stdin_buf ${type} "symref-verify refs/heads/missing" &&
+	git update-ref --stdin ${type} --no-deref <stdin &&
+	test_must_fail git rev-parse --verify -q refs/heads/missing &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
+	test_cmp before after
+'
+
+test_expect_success "stdin ${type} symref-verify fails for wrong value" '
+	git symbolic-ref refs/heads/symref >expect &&
+	create_stdin_buf ${type} "symref-verify refs/heads/symref" "$b" &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
+	git symbolic-ref refs/heads/symref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "stdin ${type} symref-verify fails for mistaken null value" '
+	git symbolic-ref refs/heads/symref >expect &&
+	create_stdin_buf ${type} "symref-verify refs/heads/symref" &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
+	git symbolic-ref refs/heads/symref >actual &&
+	test_cmp expect actual
+'
+
+done
+
 test_done
-- 
2.43.GIT

