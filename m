Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5462343BD
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913840; cv=none; b=lsBGOuxDRFgS12UeDHwuevT8KNlD7g9zbzvfCBWTITwF9OQAMj6RVt1AZoz9gpsH72fGm6VRF7fq3qJZSk5+4s+V1lAvnmZ480czOJDDDS7TFyjJzJZaCJ8//fSzI5GBiQMdajw8MukjHDJ1dQGb1JGcTKEPIkLLRu8RPpIDlbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913840; c=relaxed/simple;
	bh=Rsph4tSVjiPiv8HHMM8Oyy3vTEC8cV89ownDrzSQkrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4P2km3gpeGK6Rv2YymnuuNSTSx9kYG8iEhHXrJCB1ZpIGWnsmyzY8nyly3loKTPCCOu0klDwdSdIRMZNHqU7bKxNnJOE8q+NOxNIulZ2hHLhMByyGaBkmb8yjgFpk5p6Ryq/mp3FPZSwIQw8bZSxmZeTTVrTkek9wlcIJj/vNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBY32bhq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBY32bhq"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166360285dso32002465ad.1
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 23:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738913837; x=1739518637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+lPadWeLrvjhfYUEVhJHPQqcpr8sjrf+fJ2NVgwUAU=;
        b=mBY32bhqh2cRTMbj5Kgm81vv/JdU7mQWBJVoJJFrAQnkS+fiF2nldE+tX2Tu7UBD4t
         0zvN95xlrVk0gpYsBmvYwc3GmscYLUVKIkNQcCxImp/JyiCA4i+0MLI3ufVMJkfb7Ilg
         9BI7outI7D4yyCNLJRKpYbOna0LEg0g5D89H0di0K5XrzIytFclSksxHQ3LpS47kmhlr
         5Z/M1aAD38QHDYj+DTYACMFwAXUKug7VU8OVRVsJAIuTCHBWJYxoeIN+iJJQF7JOe2hZ
         4tAQMZc2NbM6rrReUyku+heaw39nf1TIj0Upkz+Qa9Ietr5urFvcKGUN8y3fLFK3+yrF
         9Sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913837; x=1739518637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+lPadWeLrvjhfYUEVhJHPQqcpr8sjrf+fJ2NVgwUAU=;
        b=WllkfNS8ysOPCvxMpWFqgQXcEHPhGdoDeZqTyijBCkl6Jp/FNrV8SzH3DRT3MhIgP6
         nQ2c7g4Ny9UcasFoaU3UyeG7AlIJA44RDgRGJim3Xf5XJm3Y8/2MVN6bqp4GFZ8xgo4i
         1ORHPd9QVBDlbpaCLMf7Tje+IrTCG6/Ng8nApvRkmaHTLixDbq0+D5p09zftejGH8dL4
         UmKCdfWFf6MipqqMp3c385h0LlGHx+EgsKow/qbJnUJNrRwP60TKrjVF5PFIcUQPq5BK
         kljGv1J2mIdjOcjb7jT82qwTen9EXjXIkoRgpGBRJADDOEG8La6t1lWbuzEmEnA8qRt5
         rM6g==
X-Gm-Message-State: AOJu0YxKZPdRQKN1yAFQ0B2JwEc1v40pTNlgsvPXPJ6/e70a7hIsARYf
	fiSQ+E4zCSptMSxOFWXg0y9U2JiGoLo/eEFd9U6MuUbL/08kH+kkXVT/GY6V
X-Gm-Gg: ASbGncvcroJFNL/0JvCxhpiREMugFCAsTeXY09IFbw4licBnQR8jGOzjGp3BeWOm6uF
	mW2a+MTNDrEEhdxa+LR217DNZqs5SDnRFeyn/tO3QPcE3w87cWveMBw+6SkLukbkkN9XzLTDhMk
	dF8TwXoPHW0cleFR9kivHPG553xYoCkOyJzWt9WsuZTQCNx+Zf4A19ZjdGChrHRmFE+vKFEFUJx
	pOuDtReUiSzemmp27R2QY0tUfoihMZaYqIMHMvENwjeHr0a0+pkMLHi2anvu/i699fadx78foj8
	hbZl+6KnMABdebgc0BhgQQ==
X-Google-Smtp-Source: AGHT+IEzXBpPGfMOzuSoh1vAKKYkqgQXvt2jLjKH3C5bQ7fGi/EA3ElGMkHueKWTJWHnDS7lx6KFKg==
X-Received: by 2002:a05:6a21:2d05:b0:1e1:bf3d:a190 with SMTP id adf61e73a8af0-1ee03b0c3c9mr5481533637.30.1738913837222;
        Thu, 06 Feb 2025 23:37:17 -0800 (PST)
Received: from [127.0.0.2] ([2401:4900:33b7:4cb0:4dd3:85f0:5c4b:b677])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aee79casm2115063a12.44.2025.02.06.23.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:37:16 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 07 Feb 2025 08:34:41 +0100
Subject: [PATCH 6/6] update-ref: add --allow-partial flag for stdin mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-245-partially-atomic-ref-updates-v1-6-e6a3690ff23a@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15257;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=Rsph4tSVjiPiv8HHMM8Oyy3vTEC8cV89ownDrzSQkrE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeluBvV+lXY4+Gs4b8NKMGRx6IOP2CpMpo4N
 0kS8U4T4aJYLYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnpbgbAAoJED7VnySO
 Rox/+YIL/3y417+f2BKwjPygNU8aTuGrRMjv4pS9YlHqfqLeWmgXweuzZfbh+giQiCUn+JTrcUw
 RFTBdjrioKaQ/yICGLC1cYSMDGk92n4AI9YNJCaB0tRiXgOOVEu8Z6tL7WttRvMPn8BIi/Qd6ZT
 gV2trJC3uJNlGMZC9GjGZKwQEaCy3gelDr5n4mzX1bIv2+b8/B1lCdrbdDDeiyCuEXy0o2d8O7S
 sfNN2fUbcR6TRv7ngK4kTjsT6u1Ue+rGUhE8CR5tO6f8sP3DzKZljAp8ZwVl2YZdDFOotUtwTod
 +RRtuKRMYjzncOyXYBZlSD6MLFLi/b2+T+npFHRlmVxk7mK9ycS6XxEXF+NYrsvwXyg4zP0pLJA
 vpyxuwaaw5wZx0yqQkXRzGmY/BJFW+cnRvJoF7hO0DkZu3sHHuaMyr8hYIOQjNyPqV/ukZci0vq
 9FE78tlYaE40JZ9pV2urjYHcIhh0WoUmrlP2BE7jbl1pgOwAT3PB++HoJm1V0XY3ZXezdsjcei6
 6I=
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

or with `-z`:

  rejected NUL (<old-oid> | <old-target>) NUL (<new-oid> | <new-target>) NUL <rejection-reason> NUL

Update the documentation to reflect this change and also tests to cover
different scenarios where an update could be rejected.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  12 ++-
 builtin/update-ref.c             |  53 +++++++++--
 t/t1400-update-ref.sh            | 191 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 9e6935d38d031b4890135e0cce36fffcc349ac1d..529d3c15404cdc13216219fba6f56dde91f4909c 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref safely
 SYNOPSIS
 --------
 [verse]
-'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z])
+'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z] [--allow-partial])
 
 DESCRIPTION
 -----------
@@ -57,6 +57,12 @@ performs all modifications together.  Specify commands of the form:
 With `--create-reflog`, update-ref will create a reflog for each ref
 even if one would not ordinarily be created.
 
+With `--allow-partial`, update-ref will process the transaction even if
+some of the updates fail, allowing remaining updates to be applied.
+Failed updates will be printed in the following format:
+
+	rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF
+
 Quote fields containing whitespace as if they were strings in C source
 code; i.e., surrounded by double-quotes and with backslash escapes.
 Use 40 "0" characters or the empty string to specify a zero value.  To
@@ -82,6 +88,10 @@ quoting:
 In this format, use 40 "0" to specify a zero value, and use the empty
 string to specify a missing value.
 
+With `-z`, `--allow-partial` will print rejections in the following form:
+
+	rejected NUL (<old-oid> | <old-target>) NUL (<new-oid> | <new-target>) NUL <rejection-reason> NUL
+
 In either format, values can be specified in any form that Git
 recognizes as an object name.  Commands in any other format or a
 repeated <ref> produce an error.  Command meanings are:
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 4d35bdc4b4b57937112e6c4c9740420b1f1771e5..83dcb7d8d73f423226c36b61374c86c6b29ec756 100644
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
 
@@ -562,6 +563,30 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 	report_ok("abort");
 }
 
+static void print_rejected_refs(const char *refname,
+				const struct object_id *old_oid,
+				const struct object_id *new_oid,
+				const char *old_target,
+				const char *new_target,
+				const struct strbuf *reason,
+				void *cb_data UNUSED)
+{
+	struct strbuf sb = STRBUF_INIT;
+	char space = ' ';
+
+	if (!line_termination)
+		space = line_termination;
+
+	strbuf_addf(&sb, "rejected%c%s%c%s%c%c%s%c%s%c", space,
+		    refname, space, new_oid ? oid_to_hex(new_oid) : new_target,
+		    space, space, old_oid ? oid_to_hex(old_oid) : old_target,
+		    space, reason->buf, line_termination);
+
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+	fflush(stdout);
+}
+
 static void parse_cmd_commit(struct ref_transaction *transaction,
 			     const char *next, const char *end UNUSED)
 {
@@ -570,6 +595,10 @@ static void parse_cmd_commit(struct ref_transaction *transaction,
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
@@ -606,7 +635,7 @@ static const struct parse_cmd {
 	{ "commit",        parse_cmd_commit,        0, UPDATE_REFS_CLOSED },
 };
 
-static void update_refs_stdin(void)
+static void update_refs_stdin(unsigned int flags)
 {
 	struct strbuf input = STRBUF_INIT, err = STRBUF_INIT;
 	enum update_refs_state state = UPDATE_REFS_OPEN;
@@ -614,7 +643,7 @@ static void update_refs_stdin(void)
 	int i, j;
 
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  0, &err);
+						  flags, &err);
 	if (!transaction)
 		die("%s", err.buf);
 
@@ -682,7 +711,7 @@ static void update_refs_stdin(void)
 			 */
 			state = cmd->state;
 			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-								  0, &err);
+								  flags, &err);
 			if (!transaction)
 				die("%s", err.buf);
 
@@ -698,6 +727,8 @@ static void update_refs_stdin(void)
 		/* Commit by default if no transaction was requested. */
 		if (ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
+		ref_transaction_for_each_rejected_update(transaction,
+						 print_rejected_refs, NULL);
 		ref_transaction_free(transaction);
 		break;
 	case UPDATE_REFS_STARTED:
@@ -723,7 +754,8 @@ int cmd_update_ref(int argc,
 	const char *refname, *oldval;
 	struct object_id oid, oldoid;
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
-	int create_reflog = 0;
+	int create_reflog = 0, allow_partial = 0;
+
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -732,6 +764,7 @@ int cmd_update_ref(int argc,
 		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
 		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
 		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
+		OPT_BOOL('0', "allow-partial", &allow_partial, N_("allow partial transactions")),
 		OPT_END(),
 	};
 
@@ -749,13 +782,19 @@ int cmd_update_ref(int argc,
 	}
 
 	if (read_stdin) {
+		unsigned int flags = 0;
+
+		if (allow_partial)
+			flags |= REF_TRANSACTION_ALLOW_PARTIAL;
+
 		if (delete || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
-		update_refs_stdin();
+		update_refs_stdin(flags);
 		return 0;
-	}
+	} else if (allow_partial)
+		die("--allow-partial can only be used with --stdin");
 
 	if (end_null)
 		usage_with_options(git_update_ref_usage, options);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 29045aad43906fce3f64fb82ee98fb5f80d4796b..4f02f1974de4164442507a2eaec258edf6574f1f 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2066,6 +2066,197 @@ do
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
+			test_grep -q "trying to write ref ${SQ}refs/heads/ref2${SQ} with nonexistent object" stdout
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
+			test_grep -q "trying to write non-commit object $head_tree to branch ${SQ}refs/heads/ref2${SQ}" stdout
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
+			test_grep -q "unable to resolve reference" stdout
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
+			test_grep -q "reference is missing but expected $head" stdout
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
+			test_grep -q "expected symref with target ${SQ}refs/heads/nonexistent${SQ}: but is a regular ref" stdout
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
+			test_grep -q "${SQ}refs/heads/ref2${SQ}: is at $head but expected $old_head" stdout
+		)
+	'
 done
 
 test_expect_success 'update-ref should also create reflog for HEAD' '

-- 
2.47.0

