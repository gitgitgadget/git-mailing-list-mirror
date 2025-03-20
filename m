Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F9F22154A
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471061; cv=none; b=fplK7O19fhCvq44lWtQmw51qZitJUw+r0GLTJgxvbZVGiBhCY8XRj3imL9vYgVjmSeRC7MQo+IqXQuTu/BYaNrbXeTUCUrzcqRbRmcDwYPQmkpD7ZB03otnu49FCgpYbAI8r/vbp6Ks4m9CGRseBIy46NAhQUm2j10EqHgDKEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471061; c=relaxed/simple;
	bh=/JawMaBuA2N//XUfGktfFPsvBuKouOJxz2G/R0pJviA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YkpBWgSJx1yLICACxYon/e2xcN7pBxpakuTFhyVBkbQfimKVLQjydwmZYuOtAeJ6luJ3IMrC/Yk6oi4z2heQWw57JsBvAJLbPKJvZ6QiFAqlSwc6jqPZJOYASlU1nj7xYKCIDz+wheBLRPm4c2zN54TZNN+gVZ3Z1E9pZsygxHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kcmjy6Nb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kcmjy6Nb"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so162119366b.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 04:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742471057; x=1743075857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AcduWtAlZmNVr/5zLc8cRUg64xXAyQuTJhL3+OnQiE=;
        b=Kcmjy6NbWkTcb5cuaX+fgkWb82cQEqeflEgPIKRCk+QDBtNDq3xoXEwzNoyVYL82fY
         IxZRn6vlRbtegU3S+AEDWnN7oDB3s0NpC4ZfhxsVSXwrP8P7uWX3pflA1NElocTi/9Ql
         V86GDcbIIrO/QMTtQRjzwUE+r+qyGs+32bLA3oKgvYMtkBvUtVsom93vS9OpMRdw8q60
         hZwWPNYLI+XYT+emPTIuHLE049FLPvUP2wIeh86F0Iooxlf+KsrmkEdJn2M0ncEtnu4j
         cyzfZaw0D4/B6hKWrQ8B5CKfbDn93CsV9a7fpWDjHXhmVNQ+GGPDIr/zl+HCbSMlR4ey
         6W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471057; x=1743075857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AcduWtAlZmNVr/5zLc8cRUg64xXAyQuTJhL3+OnQiE=;
        b=TBr18tcjYlXIdCKr/NLcxXYAeVbTFqepcv2fSw0YZuKI5eBoa/JUUZtyABKfc8TTtJ
         iSq/6Nb2bQByDdXHPjoJLf2MM3fLIbH3GgB+PZQJJi+hp+PDYPepgxIr5hq6qdQmof3I
         TBjX63zf/y3VKsMNPs6LwaMRfKckilS5w6eIeFor3QP9d1xm6UtWSbX66fYafl85MvJ9
         iB7wNwe+4byGESAz4siga7StKLIE6fNe6BGLVC+vhSCX3hNvEYkZ1kXZi84RrN8uu6Qs
         vdC2a4RPktZIHNaXVz8miKIANz1xe6rTsM31s9TvjCQdMlmKlRr2azRZkA7dGRgLHCEZ
         uzuQ==
X-Gm-Message-State: AOJu0YyIzMfDBFg7wwaRe4QpoCBlC4rThqAT0biHhw6erdWN/EZEvrFu
	adPW+MqGfz1biEyEkSn4EvO1jNR5xtyxPoJAKovtJBZAuUK93eow
X-Gm-Gg: ASbGncvG3jNbTb06Amql/j53UBcIB9FQh2A3pRT188wqLarfAaiWWyZoH+5kH3HIMO/
	RMqm/TVL/0Pw4zwdf05vf/D8IuId0UJ9N6bzeoA5vaQSkpVtviGIIac5AvZrYn6ceg+Ftx1TzhL
	/dnpB7VSf7cgIv0XsEXyPjMnL8OTsvqTj6D8xTP7oMTahnXX9KHCFCKlgjLE8hp7Jk2b3YF1uws
	s0/EFSm6Vd3rfJ2ULTC6TCKKFfUcXZI+aZMc8CAvIarTseQa/QyUzN1YVoMnrPLdTMjclxJk6XJ
	u2Yrn+4d85Jhh/iYLSIr4A23TA8h7HL/v162Ek6KzBzkPN1ELwg=
X-Google-Smtp-Source: AGHT+IGvioVn1nYGUKR3Uok0znF8SeMW7wEMyUpLdKHbNz+D8Kj3yBvXHW5lYol/xY/gGIIUOIMbPA==
X-Received: by 2002:a17:907:ec0d:b0:ac3:bd68:24e4 with SMTP id a640c23a62f3a-ac3bd6830damr752844266b.53.1742471056399;
        Thu, 20 Mar 2025 04:44:16 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b4f3:1c64:be3f:2632])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0077sm1167298866b.93.2025.03.20.04.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:44:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 20 Mar 2025 12:44:03 +0100
Subject: [PATCH v4 8/8] update-ref: add --batch-updates flag for stdin mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250320-245-partially-atomic-ref-updates-v4-8-3dcc1b311dc9@gmail.com>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
In-Reply-To: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16388;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=/JawMaBuA2N//XUfGktfFPsvBuKouOJxz2G/R0pJviA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfb/4hyaDE0tAx9qNjI8SB8M2SIDPey5WLP8
 yBn4SM7baYII4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn2/+IAAoJED7VnySO
 Rox/VBML/2+P8DOFI5JzKbBFkkcl+QMMsbGTv6debfdC/o6U1xNa7njaWiNZ8R4n/74kJwpDhAW
 DO29+MTTYcRAKmQ1JUyCp6g03Ou8hd/t3sPc4fn/jkZCtG9l2Dts4xUyXbuCKHRlTD6jihz59Rq
 HsiapeyNOh5YABE5rK3biDYc0BL5yP29wVZakEsSCP+YVCbSH0xhODFrntH0u13dytWYWBC8unT
 HY24fpSbP7kpvuFpPvSAXAKC4EOyyTdMDqtNFrtxccKom9Sa458Rm6C+oRquHb4Dpo4bRifyL0n
 H7xSPw1BjyBHwhM5zC0cOM1vdJHfcRZS0trJK8e9EWsI9tXM8i8ocgJbW9e3RDfptfyNDNaQ17w
 HQNbMJqVCv9IV6vCHJgve2ihLM9EhPlsozRkd2MTHJl6z2HMS1GzRYsXDNdaT6UsY/nzHmMg87d
 pJ/y+p8NPyzSYm0ScJNPwUlfsd0riTO/4+jf5gDapbDs+mcq08YSqcSr/87+77x80/25wggDTQ6
 wA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

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
 Documentation/git-update-ref.adoc |  14 ++-
 builtin/update-ref.c              |  67 ++++++++++-
 t/t1400-update-ref.sh             | 233 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
index 9e6935d38d..5be2c16776 100644
--- a/Documentation/git-update-ref.adoc
+++ b/Documentation/git-update-ref.adoc
@@ -7,8 +7,10 @@ git-update-ref - Update the object name stored in a ref safely
 
 SYNOPSIS
 --------
-[verse]
-'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z])
+[synopsis]
+git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
+	       [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
+               [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
 
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
index 1d541e13ad..97e14b279e 100644
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
 
@@ -756,9 +810,10 @@ int cmd_update_ref(int argc,
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
-		update_refs_stdin();
+		update_refs_stdin(flags);
 		return 0;
-	}
+	} else if (flags & REF_TRANSACTION_ALLOW_FAILURE)
+		die("--batch-updates can only be used with --stdin");
 
 	if (end_null)
 		usage_with_options(git_update_ref_usage, options);
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

