Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13F38DDD
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040564; cv=none; b=JSM2VQWHkD5ciaf0t1N945Z68fC9yoZFU0UNSQ5FjoBuLxiPFIK12nNlPN/p4NEp+E5uvk+5N2OapMhfqtSmdljWG34urBiMxHrCf2HZIr4MB5/GJWjlAyGv/qknoqm1XdUWBzxoWLvVW2XocM0bAtfEAs6sYemzOKyKJhz+Syk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040564; c=relaxed/simple;
	bh=Xl7PKSdw0Q5KjHyhVvm595HCHLJgvqm7A+VipYRRVbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RURxqo9Q0OmRLanf7mf6YmP7dGdl8GfKFG7pMhSfFBYb3nGu4yfm5BeDnZYwBQHxoJC3yKsz71FXCKXxVoX3f3Yb6T7U3PSkLUOiHi1xU7byyiG1m49MzO4b5xl4TjQCuHGaiYH4G6bZaIhEjpVg2cKvDfQd9wIpmCxSZRIFeJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxBofkjL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxBofkjL"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-515a68d45faso5259181e87.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 23:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712040561; x=1712645361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnlZHsaVcL9W4hSL9oIM+l/KpP+j9+a8+PEjQ6j9g+A=;
        b=CxBofkjL+sZbdEF67nD/wVbRBOPJh804Xtdsa4fKfvtqYiQtB+/HZgMnTQvc7tC3le
         QlJv6mBVoTe5xd23JdwC+42oCs1w0KZx03GCy6QUv2UlGuddk2Hl2Dm+s6JDY4UlGv4X
         GgCzM6CxFwThBRNrAzgfo74ub0r4sfePsnzx3HbgXeeAavERQM43VZsnPcgVNBrn0Ip1
         frZQq4YQrneQMsoDGQ4Z7vJRnMBq5zytDaVG+dQFVxxwkKqBBVagbydDIlNXh8PXrJAt
         mTAuu1jseV1KRpxbDebIr8eXS3jGp/xzZ6e1ItOSoA/sNM6qaj4R6XL7oAukyK2RzzvD
         +nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712040561; x=1712645361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnlZHsaVcL9W4hSL9oIM+l/KpP+j9+a8+PEjQ6j9g+A=;
        b=SVgQ/VAguHCPrEF30MsQzt8nDtooX8FuKSj7gPd9sN4aR6q8zedrMeVpKseg+LNoPA
         9hMoODLedY6vHsuXkN/WXeQuWzbBzE3rXiXF8yue0QMHLKx07BrXC1iebfgQt/XCP1Ry
         oMyx/+hJWtBypvNCAi3uaTKd8TzHJvf4XBROUQhYIyO7HMmsRmmM/taBkmYgYDB901X1
         ABP9Kbvy8lrqqBvjRhLcTCytiCszo7pBhiZszkAdQ1i+77Bfla4l4LGrDw/2tkwChoY6
         chOXzbhUfgkpEsVL+ZT2xYXzBn0AJAqdu0+qdfaTZoebNuYPfZhANLE8IQRARtGXM2yI
         5gKw==
X-Forwarded-Encrypted: i=1; AJvYcCXpJl+bGKLx5MBDtylMybABsBRi4Tmv+/T5vzmkk/9esrq/QNbvGTbTC1ozYW8iqYIscwPhrkCGRjmkAF7MuHNWTML7
X-Gm-Message-State: AOJu0YypR2555v2NlEN6CAS2zmSr4jAxm5JuXKW/b47CHqWmNZ35ukVs
	uCWRKBVozofJ7q599vl7K/IpreaX1ljvjQanD/6Met5D9G0EQmhU
X-Google-Smtp-Source: AGHT+IH3CkYBtGApabUhTuCwrHEnCJkDmnaqWJbZ7n2uCmqRLAOALcqU1vUEfUZ3sQfr7a1eOCgRzg==
X-Received: by 2002:a05:6512:4c1:b0:515:d4fb:907f with SMTP id w1-20020a05651204c100b00515d4fb907fmr6057777lfq.27.1712040560304;
        Mon, 01 Apr 2024 23:49:20 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:c3e0:2f8a:1ead:1494])
        by smtp.gmail.com with ESMTPSA id n7-20020a509347000000b0056c24df7a78sm6582774eda.5.2024.04.01.23.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 23:49:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v2 1/2] update-ref: use {old,new}-oid instead of {old,new}value
Date: Tue,  2 Apr 2024 08:49:14 +0200
Message-ID: <20240402064915.191104-2-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402064915.191104-1-knayak@gitlab.com>
References: <20240401144542.88027-1-knayak@gitlab.com>
 <20240402064915.191104-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The `git-update-ref` command is used to modify references. The usage of
{old,new}value in the documentation refers to the OIDs. This is fine
since the command only works with regular references which hold OIDs.
But if the command is updated to support symrefs, we'd also be dealing
with {old,new}-refs.

To improve clarity around what exactly {old,new}value mean, let's rename
it to {old,new}-oid.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt | 58 ++++++++++++++++----------------
 builtin/update-ref.c             | 26 +++++++-------
 t/t1400-update-ref.sh            | 34 +++++++++----------
 3 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 0561808cca..374a2ebd2b 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -8,21 +8,21 @@ git-update-ref - Update the object name stored in a ref safely
 SYNOPSIS
 --------
 [verse]
-'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<oldvalue>] | [--create-reflog] <ref> <newvalue> [<oldvalue>] | --stdin [-z])
+'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z])
 
 DESCRIPTION
 -----------
-Given two arguments, stores the <newvalue> in the <ref>, possibly
+Given two arguments, stores the <new-oid> in the <ref>, possibly
 dereferencing the symbolic refs.  E.g. `git update-ref HEAD
-<newvalue>` updates the current branch head to the new object.
+<new-oid>` updates the current branch head to the new object.
 
-Given three arguments, stores the <newvalue> in the <ref>,
+Given three arguments, stores the <new-oid> in the <ref>,
 possibly dereferencing the symbolic refs, after verifying that
-the current value of the <ref> matches <oldvalue>.
-E.g. `git update-ref refs/heads/master <newvalue> <oldvalue>`
-updates the master branch head to <newvalue> only if its current
-value is <oldvalue>.  You can specify 40 "0" or an empty string
-as <oldvalue> to make sure that the ref you are creating does
+the current value of the <ref> matches <old-oid>.
+E.g. `git update-ref refs/heads/master <new-oid> <old-oid>`
+updates the master branch head to <new-oid> only if its current
+value is <old-oid>.  You can specify 40 "0" or an empty string
+as <old-oid> to make sure that the ref you are creating does
 not exist.
 
 It also allows a "ref" file to be a symbolic pointer to another
@@ -56,15 +56,15 @@ ref symlink to some other tree, if you have copied a whole
 archive by creating a symlink tree).
 
 With `-d` flag, it deletes the named <ref> after verifying it
-still contains <oldvalue>.
+still contains <old-oid>.
 
 With `--stdin`, update-ref reads instructions from standard input and
 performs all modifications together.  Specify commands of the form:
 
-	update SP <ref> SP <newvalue> [SP <oldvalue>] LF
-	create SP <ref> SP <newvalue> LF
-	delete SP <ref> [SP <oldvalue>] LF
-	verify SP <ref> [SP <oldvalue>] LF
+	update SP <ref> SP <new-oid> [SP <old-oid>] LF
+	create SP <ref> SP <new-oid> LF
+	delete SP <ref> [SP <old-oid>] LF
+	verify SP <ref> [SP <old-oid>] LF
 	option SP <opt> LF
 	start LF
 	prepare LF
@@ -82,10 +82,10 @@ specify a missing value, omit the value and its preceding SP entirely.
 Alternatively, use `-z` to specify in NUL-terminated format, without
 quoting:
 
-	update SP <ref> NUL <newvalue> NUL [<oldvalue>] NUL
-	create SP <ref> NUL <newvalue> NUL
-	delete SP <ref> NUL [<oldvalue>] NUL
-	verify SP <ref> NUL [<oldvalue>] NUL
+	update SP <ref> NUL <new-oid> NUL [<old-oid>] NUL
+	create SP <ref> NUL <new-oid> NUL
+	delete SP <ref> NUL [<old-oid>] NUL
+	verify SP <ref> NUL [<old-oid>] NUL
 	option SP <opt> NUL
 	start NUL
 	prepare NUL
@@ -100,22 +100,22 @@ recognizes as an object name.  Commands in any other format or a
 repeated <ref> produce an error.  Command meanings are:
 
 update::
-	Set <ref> to <newvalue> after verifying <oldvalue>, if given.
-	Specify a zero <newvalue> to ensure the ref does not exist
-	after the update and/or a zero <oldvalue> to make sure the
+	Set <ref> to <new-oid> after verifying <old-oid>, if given.
+	Specify a zero <new-oid> to ensure the ref does not exist
+	after the update and/or a zero <old-oid> to make sure the
 	ref does not exist before the update.
 
 create::
-	Create <ref> with <newvalue> after verifying it does not
-	exist.  The given <newvalue> may not be zero.
+	Create <ref> with <new-oid> after verifying it does not
+	exist.  The given <new-oid> may not be zero.
 
 delete::
-	Delete <ref> after verifying it exists with <oldvalue>, if
-	given.  If given, <oldvalue> may not be zero.
+	Delete <ref> after verifying it exists with <old-oid>, if
+	given.  If given, <old-oid> may not be zero.
 
 verify::
-	Verify <ref> against <oldvalue> but do not change it.  If
-	<oldvalue> is zero or missing, the ref must not exist.
+	Verify <ref> against <old-oid> but do not change it.  If
+	<old-oid> is zero or missing, the ref must not exist.
 
 option::
 	Modify the behavior of the next command naming a <ref>.
@@ -141,7 +141,7 @@ abort::
 	Abort the transaction, releasing all locks if the transaction is in
 	prepared state.
 
-If all <ref>s can be locked with matching <oldvalue>s
+If all <ref>s can be locked with matching <old-oid>s
 simultaneously, all modifications are performed.  Otherwise, no
 modifications are performed.  Note that while each individual
 <ref> is updated or deleted atomically, a concurrent reader may
@@ -161,7 +161,7 @@ formatted as:
 
 Where "oldsha1" is the 40 character hexadecimal value previously
 stored in <ref>, "newsha1" is the 40 character hexadecimal value of
-<newvalue> and "committer" is the committer's name, email address
+<new-oid> and "committer" is the committer's name, email address
 and date in the standard Git committer ident format.
 
 Optionally with -m:
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 61338a01ec..e46afbc46d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -9,8 +9,8 @@
 #include "repository.h"
 
 static const char * const git_update_ref_usage[] = {
-	N_("git update-ref [<options>] -d <refname> [<old-val>]"),
-	N_("git update-ref [<options>]    <refname> <new-val> [<old-val>]"),
+	N_("git update-ref [<options>] -d <refname> [<old-oid>]"),
+	N_("git update-ref [<options>]    <refname> <new-oid> [<old-oid>]"),
 	N_("git update-ref [<options>] --stdin [-z]"),
 	NULL
 };
@@ -77,14 +77,14 @@ static char *parse_refname(const char **next)
 }
 
 /*
- * The value being parsed is <oldvalue> (as opposed to <newvalue>; the
+ * The value being parsed is <old-oid> (as opposed to <new-oid>; the
  * difference affects which error messages are generated):
  */
 #define PARSE_SHA1_OLD 0x01
 
 /*
  * For backwards compatibility, accept an empty string for update's
- * <newvalue> in binary mode to be equivalent to specifying zeros.
+ * <new-oid> in binary mode to be equivalent to specifying zeros.
  */
 #define PARSE_SHA1_ALLOW_EMPTY 0x02
 
@@ -140,7 +140,7 @@ static int parse_next_oid(const char **next, const char *end,
 				goto invalid;
 		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
 			/* With -z, treat an empty value as all zeros: */
-			warning("%s %s: missing <newvalue>, treating as zero",
+			warning("%s %s: missing <new-oid>, treating as zero",
 				command, refname);
 			oidclr(oid);
 		} else {
@@ -158,14 +158,14 @@ static int parse_next_oid(const char **next, const char *end,
 
  invalid:
 	die(flags & PARSE_SHA1_OLD ?
-	    "%s %s: invalid <oldvalue>: %s" :
-	    "%s %s: invalid <newvalue>: %s",
+	    "%s %s: invalid <old-oid>: %s" :
+	    "%s %s: invalid <new-oid>: %s",
 	    command, refname, arg.buf);
 
  eof:
 	die(flags & PARSE_SHA1_OLD ?
-	    "%s %s: unexpected end of input when reading <oldvalue>" :
-	    "%s %s: unexpected end of input when reading <newvalue>",
+	    "%s %s: unexpected end of input when reading <old-oid>" :
+	    "%s %s: unexpected end of input when reading <new-oid>",
 	    command, refname);
 }
 
@@ -194,7 +194,7 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 
 	if (parse_next_oid(&next, end, &new_oid, "update", refname,
 			   PARSE_SHA1_ALLOW_EMPTY))
-		die("update %s: missing <newvalue>", refname);
+		die("update %s: missing <new-oid>", refname);
 
 	have_old = !parse_next_oid(&next, end, &old_oid, "update", refname,
 				   PARSE_SHA1_OLD);
@@ -225,10 +225,10 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 		die("create: missing <ref>");
 
 	if (parse_next_oid(&next, end, &new_oid, "create", refname, 0))
-		die("create %s: missing <newvalue>", refname);
+		die("create %s: missing <new-oid>", refname);
 
 	if (is_null_oid(&new_oid))
-		die("create %s: zero <newvalue>", refname);
+		die("create %s: zero <new-oid>", refname);
 
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
@@ -260,7 +260,7 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 		have_old = 0;
 	} else {
 		if (is_null_oid(&old_oid))
-			die("delete %s: zero <oldvalue>", refname);
+			die("delete %s: zero <old-oid>", refname);
 		have_old = 1;
 	}
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6ebc3ef945..ec3443cc87 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -622,7 +622,7 @@ test_expect_success 'stdin fails create with no ref' '
 test_expect_success 'stdin fails create with no new value' '
 	echo "create $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $a: missing <newvalue>" err
+	grep "fatal: create $a: missing <new-oid>" err
 '
 
 test_expect_success 'stdin fails create with too many arguments' '
@@ -640,7 +640,7 @@ test_expect_success 'stdin fails update with no ref' '
 test_expect_success 'stdin fails update with no new value' '
 	echo "update $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update $a: missing <newvalue>" err
+	grep "fatal: update $a: missing <new-oid>" err
 '
 
 test_expect_success 'stdin fails update with too many arguments' '
@@ -765,21 +765,21 @@ test_expect_success 'stdin update ref fails with wrong old value' '
 test_expect_success 'stdin update ref fails with bad old value' '
 	echo "update $c $m does-not-exist" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update $c: invalid <oldvalue>: does-not-exist" err &&
+	grep "fatal: update $c: invalid <old-oid>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin create ref fails with bad new value' '
 	echo "create $c does-not-exist" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $c: invalid <newvalue>: does-not-exist" err &&
+	grep "fatal: create $c: invalid <new-oid>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin create ref fails with zero new value' '
 	echo "create $c " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $c: zero <newvalue>" err &&
+	grep "fatal: create $c: zero <new-oid>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -803,7 +803,7 @@ test_expect_success 'stdin delete ref fails with wrong old value' '
 test_expect_success 'stdin delete ref fails with zero old value' '
 	echo "delete $a " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: delete $a: zero <oldvalue>" err &&
+	grep "fatal: delete $a: zero <old-oid>" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -1027,7 +1027,7 @@ test_expect_success 'stdin -z fails create with no ref' '
 test_expect_success 'stdin -z fails create with no new value' '
 	printf $F "create $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $a: unexpected end of input when reading <newvalue>" err
+	grep "fatal: create $a: unexpected end of input when reading <new-oid>" err
 '
 
 test_expect_success 'stdin -z fails create with too many arguments' '
@@ -1045,27 +1045,27 @@ test_expect_success 'stdin -z fails update with no ref' '
 test_expect_success 'stdin -z fails update with too few args' '
 	printf $F "update $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
+	grep "fatal: update $a: unexpected end of input when reading <old-oid>" err
 '
 
 test_expect_success 'stdin -z emits warning with empty new value' '
 	git update-ref $a $m &&
 	printf $F "update $a" "" "" >stdin &&
 	git update-ref -z --stdin <stdin 2>err &&
-	grep "warning: update $a: missing <newvalue>, treating as zero" err &&
+	grep "warning: update $a: missing <new-oid>, treating as zero" err &&
 	test_must_fail git rev-parse --verify -q $a
 '
 
 test_expect_success 'stdin -z fails update with no new value' '
 	printf $F "update $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a: unexpected end of input when reading <newvalue>" err
+	grep "fatal: update $a: unexpected end of input when reading <new-oid>" err
 '
 
 test_expect_success 'stdin -z fails update with no old value' '
 	printf $F "update $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
+	grep "fatal: update $a: unexpected end of input when reading <old-oid>" err
 '
 
 test_expect_success 'stdin -z fails update with too many arguments' '
@@ -1083,7 +1083,7 @@ test_expect_success 'stdin -z fails delete with no ref' '
 test_expect_success 'stdin -z fails delete with no old value' '
 	printf $F "delete $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete $a: unexpected end of input when reading <oldvalue>" err
+	grep "fatal: delete $a: unexpected end of input when reading <old-oid>" err
 '
 
 test_expect_success 'stdin -z fails delete with too many arguments' '
@@ -1101,7 +1101,7 @@ test_expect_success 'stdin -z fails verify with too many arguments' '
 test_expect_success 'stdin -z fails verify with no old value' '
 	printf $F "verify $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: verify $a: unexpected end of input when reading <oldvalue>" err
+	grep "fatal: verify $a: unexpected end of input when reading <old-oid>" err
 '
 
 test_expect_success 'stdin -z fails option with unknown name' '
@@ -1160,7 +1160,7 @@ test_expect_success 'stdin -z update ref fails with wrong old value' '
 test_expect_success 'stdin -z update ref fails with bad old value' '
 	printf $F "update $c" "$m" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $c: invalid <oldvalue>: does-not-exist" err &&
+	grep "fatal: update $c: invalid <old-oid>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -1178,14 +1178,14 @@ test_expect_success 'stdin -z create ref fails with bad new value' '
 	git update-ref -d "$c" &&
 	printf $F "create $c" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $c: invalid <newvalue>: does-not-exist" err &&
+	grep "fatal: create $c: invalid <new-oid>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin -z create ref fails with empty new value' '
 	printf $F "create $c" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $c: missing <newvalue>" err &&
+	grep "fatal: create $c: missing <new-oid>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -1209,7 +1209,7 @@ test_expect_success 'stdin -z delete ref fails with wrong old value' '
 test_expect_success 'stdin -z delete ref fails with zero old value' '
 	printf $F "delete $a" "$Z" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete $a: zero <oldvalue>" err &&
+	grep "fatal: delete $a: zero <old-oid>" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
-- 
2.43.GIT

