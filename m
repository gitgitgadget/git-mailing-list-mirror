Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647A13FBA4
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982754; cv=none; b=FnZ+iInyqCCEq3JGyRS7foyrMaKPuvIfo7gggRThWNr6sX4lyb64MTjwfy6wTLaKaebUdXhxRG5yO6H7wzkpPlvYd1Ozs1hUAFbAbFwxpL1fbErDf4uOsXwqJCAiEfKBaHZMWZ9eFESoZ1nkRxGksrR+QvgDzHx0jHCQrV6uowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982754; c=relaxed/simple;
	bh=jqyG4k6QoSe/rM2JYdtFF5bQ8xDmiob9C2aSd6tIi/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swWfSxycc7ICRmcpLvcCP3mUYaSV/WJdJMP3gFfUomsR09Ot6ZUzK/DeFMTztIVLU9YobhQFrZlfe9yOIdi3Kw/63mmUiw5GZro5Y+y0XVLTXLJI3K7N67sEQBzBUKS968DPkmHHVLcqkWskGspxHhaf2xIsW+uW3juA2+aH2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ub+l2Utm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub+l2Utm"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c1922096cso5274516a12.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711982750; x=1712587550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlf3Pmtq5xdW1peefRFhL/kmFVmqWBJT4l6v3gnZb7A=;
        b=Ub+l2UtmNOPP1HYjwQwJZ6MxVkvUxbLNro89r4h7tjzvYejd5I0s07rioa3gnUiELU
         5M9MXtjNrlbds2Gs90ujCgWoUcsoDhgtkq69MQMNOcHYEwK1uS+ZUoXlu0slvWFXVfgD
         wTRkMgBoKBOhh7KLBfihWjoHtjRCO5PqMv0eEKY5eHuVYI9v80OE6ST0VbbAcsc6OBwM
         S4VN8gFSzKcmEQwmfDIenov/XtuCuKIvEsFrdhjHdF2pWeJWEH4Z9jWRBRYxeSArc8xu
         uoolt6SRNug5NQdF7fpOYTGkEOo02kZ7jt1mlDE5FkZYkocLB5s/XPcbnVK5rYQMPC70
         BaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711982750; x=1712587550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlf3Pmtq5xdW1peefRFhL/kmFVmqWBJT4l6v3gnZb7A=;
        b=PPiCwqXrudFWZ24iOASb3Q950UznDf2yx3cTgK+uaYRy7FrbnUTsJHZeOWrT3R2DlU
         I+loaqK/hRY7EMvH4ocR7bXUsxJ2u8ndLsU6nXvKZs86WgX1fuxvLjexoTMPDSVkweYj
         IheWKdEh0txu3Q0PE9Vxf9iMlYpD2nbp/FQ1YLdCxRxgaY+1wv4gmbZAABsYyykbm+Wd
         qWDYipTpDnO7jAGcbhWm72HFxKJxCJaV4F3Z3k34ZNWljckY/O7tv7N6E5SN3SE/Cwv0
         taLgIjEi5V3tXU0XFBtRqrn3E8OZH71v+BLJeaocgauldyAZcuMgV3vI3+1tPBUF4DGd
         J6vw==
X-Gm-Message-State: AOJu0YxwRacsVL5qPK3W2f+PfYQqIfA6Ojy9UAEbZ4G0mdl5N1VrJ6VL
	tcBwgc+NNIbDnpKZKM2saXqPyUuzgJCdw/0UhoeYqo4GyM+d/pMmyUnho63LWvc=
X-Google-Smtp-Source: AGHT+IGrP1lZKgYlqu5+5AQ9Cvu+bd3OpHQS3ImrMk4eMRKCK8yT1crI4mCkt0VDanJNnI/OB7C8qA==
X-Received: by 2002:a50:8d1d:0:b0:56c:4057:be4d with SMTP id s29-20020a508d1d000000b0056c4057be4dmr5504221eds.37.1711982750122;
        Mon, 01 Apr 2024 07:45:50 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:c9f:8d5a:d89b:4ac])
        by smtp.gmail.com with ESMTPSA id n7-20020a509347000000b0056c24df7a78sm5751170eda.5.2024.04.01.07.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 07:45:49 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	chris.torek@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/2] update-ref: use {old,new}-oid instead of {old,new}value
Date: Mon,  1 Apr 2024 16:45:41 +0200
Message-ID: <20240401144542.88027-2-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401144542.88027-1-knayak@gitlab.com>
References: <20240401144542.88027-1-knayak@gitlab.com>
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
 2 files changed, 42 insertions(+), 42 deletions(-)

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
 
-- 
2.43.GIT

