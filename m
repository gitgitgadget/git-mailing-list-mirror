Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A27252903
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196365; cv=none; b=gEpEjnrVr08wrcI5mbdU+m4/Wg6/Ll9Rqx12On9krfD6lrR7MgAnKNpqhVEZvWXJHqOgTqVbrD/FffYVmCmOw7PhVothMQ0Nt+jl+d+ubpRocQmQv555JxkIiNsiMLM/cRCOzjNb1w3/u2rYs+c6g5xWO1/gSTmUv/ljYdSFSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196365; c=relaxed/simple;
	bh=3ZwXA3U9aBbIgH+h2/BZZyfOW9CNUXCKFrjKBtSDF/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhvBXPSvb6Wd8o4ZfeXze5B7bOmPm6lbHnX1+fWl7cY63i05rm/mquyQH8do2dmfN4+p7KT41e1H89C1p0cFg98TLXeV2eQx3rsxUY095h8p6Gc0/kOzMYImO1C/XD9/y2WscLD2MWxnZrqXH94SRQhsXS2ZFDCSqlEVlrU/by0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFyiaoRh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFyiaoRh"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e57c81d5d0so3728962a12.2
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 09:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741196361; x=1741801161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWGEkBMpYgm5pb4UtFBa+nVSflMdDrKFEKrx9XdC/dI=;
        b=CFyiaoRhx0a/T4ev3AzYddrbITtXZiFHQuXHM3VSZ2b49xp2jMEnyPZSI4E7lPKT+8
         zZr5t3Y7ZwZkVQWBwWwfP6mFnp0bl3+91WEBqgdOErJNupDJTa6qPvfrhgHZkf78xMtW
         /Kmmef+eKqFjm+HDVDlnyy8G3Ui42gelQafPuopEoMc3PI7TRElFDxJc/fI7xaHMwP2j
         eVX41qQ+CbFNFumlCQFZPkR+cRGbotgZpBK6v6JuwWtK6J2GdHLRyA6c1vNA+IDuLxer
         010rAu+dytq4F3BKK+mx2mEcs+LazuBknl61nkTu0p6XjEe0RdKMi0LMo1HnLqrIb6jC
         bZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196361; x=1741801161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWGEkBMpYgm5pb4UtFBa+nVSflMdDrKFEKrx9XdC/dI=;
        b=wNCGLLMt1uOEssn0dKvbPP0jr3KO9pwRqm5sarEXfarb6pQXr6NZmZfC+u44JgqvLB
         UB3dYoa272HRiaMVCeyzROhlCWJjF93k970yI9ELp6jlYQREn85inWprk4EKUv4oFN/v
         TvJKnleSwCywFGwFhef3lgbLPFPmsqDNyFgdi144LXKz3eIBPZI/oC6yLPH0N5BBALz4
         Gzc7sVUwgZTaTMnaWHYcoMC1T37prtSZ+zC9XEFPOVcU14wQ3x8NOiM9JyX3AGH4znn7
         lT/RRUah/pvSmQboxsylkDJ0AZ0hYqg1vF2pXE4ypIwSNGt/YP/5hIWF/cB4djAHIzDH
         piIw==
X-Gm-Message-State: AOJu0YyspSDZ7cYFT9P6svhvWSwsYipU/0gjIgSXyLPkyfo8kLRkSohb
	hjs9vEQH0gUpS2rLP10TmRMHHGmz9PPrAiw9XIk9ZRhosTlIJINjI+Xaj+U2
X-Gm-Gg: ASbGncvE06a6ESJTwaRdWvVFa7KcUN6Qbg1eYja/5fL4r4UJiSPzxjIx0mnur1Nrz+u
	ncOtz7styHh6eZd0JoFe44xthIAM8gRG6WbHXD1KxI+Db48dyPq2Xn/tnHbG5C4TIw93s8GG2Q/
	W3/BVH9RW/Vx4tnQbNWNhXLhX6Ehjr1hu4eN9f9CkxrS/E3/SJna51GZ10Pc0TVn+b1Q1unNxdH
	uHv7RXLf9SCgPE6Q3AEw6gbWRqSwBGM0s5Hi4iDtxM6QVQLbCu5IPo0La7oy/84cdUUgu9XRF02
	UAbSX7qIdxq6edFTMQjOQNgh1dBHZGz3BL78H6l9j+5IdWhYzA==
X-Google-Smtp-Source: AGHT+IEMjtVsWDRVALK/zZWGYkSQRiBbb548M/qTwEj0gI/Y0kcFUmloU/C5IlOK42/N6YYgR0bX/w==
X-Received: by 2002:a05:6402:34cd:b0:5e5:2d5c:4f32 with SMTP id 4fb4d7f45d1cf-5e59f4b69f9mr8869791a12.28.1741196360598;
        Wed, 05 Mar 2025 09:39:20 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8a90:b290:3a5b:4dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3a8e2f53sm946851866b.115.2025.03.05.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:39:20 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 05 Mar 2025 18:39:03 +0100
Subject: [PATCH v3 8/8] update-ref: add --allow-partial flag for stdin mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-245-partially-atomic-ref-updates-v3-8-0c64e3052354@gmail.com>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
In-Reply-To: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16579;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=3ZwXA3U9aBbIgH+h2/BZZyfOW9CNUXCKFrjKBtSDF/U=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfIjEFrb+DJWjWe+LyxqOAaeGDBRuSJjDph6
 CXntIe2ivbB0IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnyIxBAAoJED7VnySO
 Rox/fF8L+wbTREE9V4LVg3edEIJsmlaQNKpVroGRpDJoiAnF3qrLhbdSJ+NNA2Nkc4o0SzGj/VK
 Xp8WrzZst+3sti19LBgzQmHIzMRZkWknqOs0e2cuicKlaio2UGpW9Zq1ppaK4z07koMfWcfGjeD
 yEHuN/hwMnKyOgDJan3LWQp9JSzRUoCW27KoKCqRsqrNJx1XlV8odm+ahmHUthtlCDYAKDLLZNe
 UcEg6bJLn4CNjymDVgZqJpiCzwYS5npqpQ+V37uA9Bsha3H3EOFkYuHSAS5R8jm11Hpk1l87RI4
 +AISWLqD2dAsduD3j8lQYnuoHYKMtbUFdpNyfE/ebTayYY7H0kN4JS456A26AoqG7LSaVMlDWTI
 t4LmjQJ3vFfVohqAzwHHh+mUZQ7stHlVPHfvO7thrKpYPMTG0anEwUS3LVpGfgfJNXKF2eZgRzu
 VmBdlouUdbNmOKaCP6A1LIFKPBfsI45mSTJP81VMBVNWTEY7yZmUGeBYftNtbYpERJJfrprgHp5
 wA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When updating multiple references through stdin, Git's update-ref
command normally aborts the entire transaction if any single update
fails. While this atomic behavior prevents partial updates by default,
there are cases where applying successful updates while reporting
failures is desirable.

Add a new `--allow-partial` flag that allows the transaction to continue
even when individual reference updates fail. This flag can only be used
in `--stdin` mode and builds upon the partial transaction support added
to the refs subsystem. When enabled, failed updates are reported in the
following format:

  rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF

Update the documentation to reflect this change and also tests to cover
different scenarios where an update could be rejected.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.adoc |  17 ++-
 builtin/update-ref.c              |  67 ++++++++++-
 t/t1400-update-ref.sh             | 233 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 309 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
index 9e6935d38d..bcf38850a4 100644
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
+               [-m <reason>] [--no-deref] --stdin [-z] [--allow-partial]
 
 DESCRIPTION
 -----------
@@ -57,6 +59,17 @@ performs all modifications together.  Specify commands of the form:
 With `--create-reflog`, update-ref will create a reflog for each ref
 even if one would not ordinarily be created.
 
+With `--allow-partial`, update-ref continues executing the transaction even if
+some updates fail due to invalid or incorrect user input, applying only the
+successful updates. Errors resulting from user-provided input are treated as
+non-system-related and do not cause the entire transaction to be aborted.
+However, system-related errors—such as I/O failures or memory issues—will still
+result in a full failure. Additionally, errors like F/D conflicts are batched
+for performance optimization and will also cause a full failure. Any failed
+updates will be reported in the following format:
+
+	rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF
+
 Quote fields containing whitespace as if they were strings in C source
 code; i.e., surrounded by double-quotes and with backslash escapes.
 Use 40 "0" characters or the empty string to specify a zero value.  To
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1d541e13ad..66bd3cb44f 100644
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
+	N_("git update-ref [<options>] --stdin [-z] [--allow-partial]"),
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
+		OPT_BIT('0', "allow-partial", &flags, N_("allow partial transactions"),
+			REF_TRANSACTION_ALLOW_PARTIAL),
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
+	} else if (flags & REF_TRANSACTION_ALLOW_PARTIAL)
+		die("--allow-partial can only be used with --stdin");
 
 	if (end_null)
 		usage_with_options(git_update_ref_usage, options);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 29045aad43..62a82f4af6 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2066,6 +2066,239 @@ do
 		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
 	'
 
+	test_expect_success "stdin $type allow-partial" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit commit &&
+			head=$(git rev-parse HEAD) &&
+
+			format_command $type "update refs/heads/ref1" "$head" "$Z" >stdin &&
+			format_command $type "update refs/heads/ref2" "$head" "$Z" >>stdin &&
+			git update-ref $type --stdin --allow-partial <stdin &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "stdin $type allow-partial with invalid new_oid" '
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
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
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
+	test_expect_success "stdin $type allow-partial with non-commit new_oid" '
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
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
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
+	test_expect_success "stdin $type allow-partial with non-existent ref" '
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
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			test_must_fail git rev-parse refs/heads/ref2 &&
+			test_grep -q "reference does not exist" stdout
+		)
+	'
+
+	test_expect_success "stdin $type allow-partial with dangling symref" '
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
+			git update-ref $type --no-deref --stdin --allow-partial <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			test_must_fail git rev-parse refs/heads/ref2 &&
+			test_grep -q "reference does not exist" stdout
+		)
+	'
+
+	test_expect_success "stdin $type allow-partial with regular ref as symref" '
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
+			git update-ref $type --no-deref --stdin --allow-partial <stdin >stdout &&
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
+	test_expect_success "stdin $type allow-partial with invalid old_oid" '
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
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
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
+	test_expect_success "stdin $type allow-partial with incorrect old oid" '
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
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
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
+	test_expect_success "stdin $type allow-partial refname conflict" '
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
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref/foo >actual &&
+			test_cmp expect actual &&
+			test_grep -q "refname conflict" stdout
+		)
+	'
+
+	test_expect_success "stdin $type allow-partial refname conflict new ref" '
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
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
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

