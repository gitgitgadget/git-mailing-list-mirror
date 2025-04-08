Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CEA26561E
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102296; cv=none; b=obkD4KEtqkrOyGwXnjKTzqqxsX2XqYpkxr6adfp8bgM9age/Alg1ILsBHA2BjNoCYi7kwctFeJcwl9b8bFquiQGjUbBEHok94aMkSF1fy+sOlAzh81txwsVBgHXazkK/dTPrYbrjKkgb/zjKyLEIWgTsIffM8YBUmYGwSZr4MAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102296; c=relaxed/simple;
	bh=GOLDyL2UuWO5tr/Lh3G8n9hhZbTo/LaiHQrs+klWYgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cG4UGwkbzknFH9ih9ErUs+l8I4hIC80+qMhskgxPtZyGf9CzlzP+H7Fi4w+gsTjnlpOgb7WzZBeqbmFAVdpMcJI6PA7KKohWwI61UVp3ebuwpP0uz4+ZV1OIIrScezCLjjlL2Re5FbgIlDlZ2jScg8JE3GdoiEQnFBQEPoU6/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRyeyC4q; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRyeyC4q"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso11679598a12.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 01:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102292; x=1744707092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rgy/mFxXU3f2JfMEIA1qGcNl6sNQ6ACr5ekqjJ/4joA=;
        b=RRyeyC4qNsx1W8DfbsAK5uZTpWGXyNc7LbdC7VtANVTFKrpPg17BW/jR3gqTvv1aL7
         6vRNNArlLsW/Xj+SCYkL2YSjmjkJzxPCqikZhk4vdsPoW07JqyAURsBWRrs11cgGd8Ip
         16iXd14lqkPy6Udc+rCU+KGI1SVYjhtMFIpo4H8WAZoP5t74uzpk41XqtZIwgGaLC1KZ
         Z/33qJizwQUb0kfW5MOYCe0Nzq36DmmvdqKWPcERwsMYFCsb4s7LET4GZMX/62wElpCD
         nDGV1UphB1p88hVzLsd2Z5wfvREJPAb/mqkiKD3te8ZhBvkDMCGb2NE0NByfl+kOHVMe
         xHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102292; x=1744707092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rgy/mFxXU3f2JfMEIA1qGcNl6sNQ6ACr5ekqjJ/4joA=;
        b=SdFFJZ7A4AnkcpUXAkcI46WIzHcEjqQ/cIK3ZKG6hi1lFWhflr50hfeQjSGrtBXuDh
         +4OwUJRqCxmAvdYWMh9XDI1c0bAJeOvuBloaqgHfSRuJL1Gh5Z8XJ2T89B9TUKrdK9XG
         rZmAhBSlAqLQgZGvB/hV9qBsw7Xq1+SGGf5Kyhj8gj/uLm18juR3a4YneEieX64HoL2I
         7e7KwX3XzoiO51QbrDGva2kWU0VA48y2Z6vCZu2L9oRdn2pOej3csLWHY3qzsQjiSgoT
         B7vDzqSGwtMMWiAsTnAGBMXuc7ehBq38h5jm52hMahIpziPvDkYVc7pbb59jxcr4VzEl
         B1Yg==
X-Gm-Message-State: AOJu0YxnXPFbElupUMgK0UQrlafUlZ/JwqzteeZHekknYuNS6R+jximB
	FQxXgjqNV/arFtsN5CFcCd3cFidq2J4/GUchCnhSMzObr6TRKN/K
X-Gm-Gg: ASbGncu+oVm2fsxbepYFX6BEJ1TtC5MMv3hTq+H1SPlQ1E7URHIWFbAO2a01Lzw9y5T
	YnALxg9B/zDAGIf7lsrMd/JeM+0TYlkR7664v6GLBST8ErjijOiu+6SJXyvA/YRPzAMS+TxOrA0
	1G03dPmCGRz0r9y9zMMLAn+4w0xaKNuvUOVxV8GEORP2GpdhKzX1+gFMu3oh8Nu/cVMTnKF3J27
	69v8Fon+9BKAca3tIHl01aV2A7X91gRStquVsbw/HSdumrPb2SZXumfh3I9mVqsXNNwNAM68/p8
	vyllQICyq7n732LjKoFm5FzhJvQyyhA10gwYj7+Ni8Uu4HzT1XXLCyaOig==
X-Google-Smtp-Source: AGHT+IGQoIRLHlOK6+6WlN/4Plcrob/nctACvvCcCPc0zfZUDRS1zjTwkFQK32zXvt5pRftaIslX8w==
X-Received: by 2002:a17:907:7f8b:b0:ac1:ecb0:ca98 with SMTP id a640c23a62f3a-ac81a8790cdmr190545066b.26.1744102291987;
        Tue, 08 Apr 2025 01:51:31 -0700 (PDT)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c804sm890801366b.15.2025.04.08.01.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:51:31 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	ps@pks.im,
	jn.avila@free.fr,
	gitster@pobox.com
Subject: [PATCH v6 8/8] update-ref: add --batch-updates flag for stdin mode
Date: Tue,  8 Apr 2025 10:51:12 +0200
Message-ID: <20250408085120.614893-9-karthik.188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408085120.614893-1-karthik.188@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250408085120.614893-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

When updating multiple references through stdin, Git's update-ref
command normally aborts the entire transaction if any single update
fails. This atomic behavior prevents partial updates. Introduce a new
batch update system, where the updates the performed together similar
but individual updates are allowed to fail.

Add a new `--batch-updates` flag that allows the transaction to continue
even when individual reference updates fail. This flag can only be used
in `--stdin` mode and builds upon the batch update support added to the
refs subsystem in the previous commits. When enabled, failed updates are
reported in the following format:

  rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF

Update the documentation to reflect this change and also tests to cover
different scenarios where an update could be rejected.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.adoc |  14 +-
 builtin/update-ref.c              |  66 ++++++++-
 t/t1400-update-ref.sh             | 233 ++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
index 9e6935d38d..9310ce9768 100644
--- a/Documentation/git-update-ref.adoc
+++ b/Documentation/git-update-ref.adoc
@@ -7,8 +7,10 @@ git-update-ref - Update the object name stored in a ref safely
 
 SYNOPSIS
 --------
-[verse]
-'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z])
+[synopsis]
+git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
+git update-ref [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
+git update-ref [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
 
 DESCRIPTION
 -----------
@@ -57,6 +59,14 @@ performs all modifications together.  Specify commands of the form:
 With `--create-reflog`, update-ref will create a reflog for each ref
 even if one would not ordinarily be created.
 
+With `--batch-updates`, update-ref executes the updates in a batch but allows
+individual updates to fail due to invalid or incorrect user input, applying only
+the successful updates. However, system-related errors—such as I/O failures or
+memory issues—will result in a full failure of all batched updates. Any failed
+updates will be reported in the following format:
+
+	rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF
+
 Quote fields containing whitespace as if they were strings in C source
 code; i.e., surrounded by double-quotes and with backslash escapes.
 Use 40 "0" characters or the empty string to specify a zero value.  To
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1d541e13ad..111d6473ad 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "hash.h"
+#include "hex.h"
 #include "refs.h"
 #include "object-name.h"
 #include "parse-options.h"
@@ -13,7 +14,7 @@
 static const char * const git_update_ref_usage[] = {
 	N_("git update-ref [<options>] -d <refname> [<old-oid>]"),
 	N_("git update-ref [<options>]    <refname> <new-oid> [<old-oid>]"),
-	N_("git update-ref [<options>] --stdin [-z]"),
+	N_("git update-ref [<options>] --stdin [-z] [--batch-updates]"),
 	NULL
 };
 
@@ -565,6 +566,49 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 	report_ok("abort");
 }
 
+static void print_rejected_refs(const char *refname,
+				const struct object_id *old_oid,
+				const struct object_id *new_oid,
+				const char *old_target,
+				const char *new_target,
+				enum ref_transaction_error err,
+				void *cb_data UNUSED)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *reason = "";
+
+	switch (err) {
+	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
+		reason = "refname conflict";
+		break;
+	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
+		reason = "reference already exists";
+		break;
+	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
+		reason = "reference does not exist";
+		break;
+	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
+		reason = "incorrect old value provided";
+		break;
+	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
+		reason = "invalid new value provided";
+		break;
+	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
+		reason = "expected symref but found regular ref";
+		break;
+	default:
+		reason = "unkown failure";
+	}
+
+	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
+		    new_oid ? oid_to_hex(new_oid) : new_target,
+		    old_oid ? oid_to_hex(old_oid) : old_target,
+		    reason);
+
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+}
+
 static void parse_cmd_commit(struct ref_transaction *transaction,
 			     const char *next, const char *end UNUSED)
 {
@@ -573,6 +617,10 @@ static void parse_cmd_commit(struct ref_transaction *transaction,
 		die("commit: extra input: %s", next);
 	if (ref_transaction_commit(transaction, &error))
 		die("commit: %s", error.buf);
+
+	ref_transaction_for_each_rejected_update(transaction,
+						 print_rejected_refs, NULL);
+
 	report_ok("commit");
 	ref_transaction_free(transaction);
 }
@@ -609,7 +657,7 @@ static const struct parse_cmd {
 	{ "commit",        parse_cmd_commit,        0, UPDATE_REFS_CLOSED },
 };
 
-static void update_refs_stdin(void)
+static void update_refs_stdin(unsigned int flags)
 {
 	struct strbuf input = STRBUF_INIT, err = STRBUF_INIT;
 	enum update_refs_state state = UPDATE_REFS_OPEN;
@@ -617,7 +665,7 @@ static void update_refs_stdin(void)
 	int i, j;
 
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  0, &err);
+						  flags, &err);
 	if (!transaction)
 		die("%s", err.buf);
 
@@ -685,7 +733,7 @@ static void update_refs_stdin(void)
 			 */
 			state = cmd->state;
 			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-								  0, &err);
+								  flags, &err);
 			if (!transaction)
 				die("%s", err.buf);
 
@@ -701,6 +749,8 @@ static void update_refs_stdin(void)
 		/* Commit by default if no transaction was requested. */
 		if (ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
+		ref_transaction_for_each_rejected_update(transaction,
+						 print_rejected_refs, NULL);
 		ref_transaction_free(transaction);
 		break;
 	case UPDATE_REFS_STARTED:
@@ -727,6 +777,8 @@ int cmd_update_ref(int argc,
 	struct object_id oid, oldoid;
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
 	int create_reflog = 0;
+	unsigned int flags = 0;
+
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -735,6 +787,8 @@ int cmd_update_ref(int argc,
 		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
 		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
 		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
+		OPT_BIT('0', "batch-updates", &flags, N_("batch reference updates"),
+			REF_TRANSACTION_ALLOW_FAILURE),
 		OPT_END(),
 	};
 
@@ -756,8 +810,10 @@ int cmd_update_ref(int argc,
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
-		update_refs_stdin();
+		update_refs_stdin(flags);
 		return 0;
+	} else if (flags & REF_TRANSACTION_ALLOW_FAILURE) {
+		die("--batch-updates can only be used with --stdin");
 	}
 
 	if (end_null)
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 29045aad43..d29d23cb89 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2066,6 +2066,239 @@ do
 		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
 	'
 
+	test_expect_success "stdin $type batch-updates" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit commit &&
+			head=$(git rev-parse HEAD) &&
+
+			format_command $type "update refs/heads/ref1" "$head" "$Z" >stdin &&
+			format_command $type "update refs/heads/ref2" "$head" "$Z" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates with invalid new_oid" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref1 $head &&
+			git update-ref refs/heads/ref2 $head &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref2" "$(test_oid 001)" "$head" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual &&
+			test_grep -q "invalid new value provided" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates with non-commit new_oid" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			head_tree=$(git rev-parse HEAD^{tree}) &&
+			git update-ref refs/heads/ref1 $head &&
+			git update-ref refs/heads/ref2 $head &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref2" "$head_tree" "$head" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual &&
+			test_grep -q "invalid new value provided" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates with non-existent ref" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref1 $head &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref2" "$old_head" "$head" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			test_must_fail git rev-parse refs/heads/ref2 &&
+			test_grep -q "reference does not exist" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates with dangling symref" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref1 $head &&
+			git symbolic-ref refs/heads/ref2 refs/heads/nonexistent &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref2" "$old_head" "$head" >>stdin &&
+			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			test_must_fail git rev-parse refs/heads/ref2 &&
+			test_grep -q "reference does not exist" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates with regular ref as symref" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref1 $head &&
+			git update-ref refs/heads/ref2 $head &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "symref-update refs/heads/ref2" "$old_head" "ref" "refs/heads/nonexistent" >>stdin &&
+			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual &&
+			test_grep -q "expected symref but found regular ref" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates with invalid old_oid" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref1 $head &&
+			git update-ref refs/heads/ref2 $head &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref2" "$old_head" "$Z" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual &&
+			test_grep -q "reference already exists" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates with incorrect old oid" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref1 $head &&
+			git update-ref refs/heads/ref2 $head &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref2" "$head" "$old_head" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual &&
+			test_grep -q "incorrect old value provided" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates refname conflict" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref/foo $head &&
+
+			format_command $type "update refs/heads/ref/foo" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref/foo >actual &&
+			test_cmp expect actual &&
+			test_grep -q "refname conflict" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates refname conflict new ref" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref/foo $head &&
+
+			format_command $type "update refs/heads/foo" "$old_head" "" >stdin &&
+			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/foo >actual &&
+			test_cmp expect actual &&
+			test_grep -q "refname conflict" stdout
+		)
+	'
 done
 
 test_expect_success 'update-ref should also create reflog for HEAD' '
-- 
2.48.1

