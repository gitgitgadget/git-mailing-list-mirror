Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255743A6B8E
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126887; cv=none; b=ESVYxTKXrHyPGgsOjlHQLYWIoPPgKk/uWNbkUbfpQbFZGId5r4JqKJg6ck8le7SRSJZPwZVuk8IQel+38XS31Y8jT5jHhf5ynY/zRgAPWB8Bx8LyssNDQPRq3Paw6d6PYJoE2Gg1sU4yapfBlVmchSSC27L41GS5vnX/ddHBMJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126887; c=relaxed/simple;
	bh=Ek6A1H8MxERHEXe4Z/4i5LDuKant1qrAWNsSRBZu9M4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/zc0pSCHdjIp19EHV8fB6l7NLA9gDw+njsaXdxHTw2PJ5n/ppwCmclIviwc2pmDqvRUdGC2K8FkLxwL2FxlJb8Z8yY+JkJHM5gtj5nNvfol3uE5eVnfbOljeztvTZ8DUvVKIRaaXeIgGSYiNYgNsypuq+bjsFqdsHAhc+x1IVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MzOLnNU+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GP449+YO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MzOLnNU+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GP449+YO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FA4DEC00EA;
	Wed, 10 Jun 2026 17:28:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 17:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1781126883; x=
	1781213283; bh=pSFu/7M8bayZZCU/7iaWT25Rku7HICNSTYKSi/edNi8=; b=M
	zOLnNU+5Nd78rMmQjGBtr0OfzSi8O+O4MYFrPIWPbz/hn+ETnBrkwi0dFWQ38zoK
	9pgI2pYY/nL+jAlUZU1oJsmrOHGGYoaAYO7e4tQ3ShW3/rxFcaVIOW8zb70SaLWP
	qDNDV3YnbbfSB+JdkCy3JxxKTuCg1tYeqFVViD/VO0ODvdK2oUIomqIgToO5X/yO
	3RcNgUAaP0HzK4W9BfrX/VnbHhE69ZVi4NlKpgSV6PMWqBMKf3FqdSERTJIeGlQv
	evOxM149/JBjYyUXThIyTjcMwzOSi+oLiXPiR13ked0XtdU22xe0xzlqrjeFWl0D
	zHPCJtEIj3QBRCIIWroPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1781126883; x=1781213283; bh=pSFu/7M8bayZZCU/7iaWT25Rku7H
	ICNSTYKSi/edNi8=; b=GP449+YOkRS2zdqIiFO/wUHwypfnOBB1rSE7BT7MPkzO
	G/bIJKAvDFBLZtFQohdI4/lk5kBlyJ5mSrxKsnhZuCT8UPjt0mJbXlqVtVaJNrni
	UqJF6XKvBgdVX7pWpSUiTe9kzWWAVpJh9hmQlydi89nQ32OUytFK+anOgQOhx8Gp
	TWBpNKUY6jFUFSXXACMnfV9qrN76BBnvPioZ24qd+tD+B0PKdtzjeU7eiwUTcf4R
	l6aswjBXmGXD5Sqr2tde0ez648JFTpUq5KpVUyhS05+vzdhDwapeYg+3lH/9PdDG
	j3mSSbM2k7V06iO2IRn8IMJLXxrsKYlfHfy9gUyAKA==
X-ME-Sender: <xms:49YpakAw7aS5yifB01toSLr8C49PA07OQ9QzfXHW_D0XeKQAJZeJ2g>
    <xme:49Ypasiq6iUoL4FwO9iUPT9WUoJnJ-Lomxkafi70L4kmAk-dB28nhVYDraZNQ4c-P
    eq5z-6s6CRn4UG7EY0NF0Ducus_phvF5fWNYhNluQ9zsHRRmneT>
X-ME-Received: <xmr:49YpalNdAw-LmrZJRW5KTbCp08Nt1K6qSgI9lhUA7gvjpjnSe4gEh11h9if-vYUJiMg9X1_qtBEldZdUu50QI_wuPZiNnVw_r_Of>
X-ME-Proxy-Cause: dmFkZTFzl90RM0G1HsFmUTYOZo16wtE2WcEMVTVVxZ2FSwD9fpqwvykICupYWXryVbYuLz
    7f6s9TK9j32xp55YNiqj41dqbQuCscQlFOuwOCmt9AscqWse0BT8aZ6UXCS/SZVWwAX8w8
    zIHlHaTdh/itplRHsFRohSkVNGNBAV+yDj6YK3qU+d4Zcn6uVt0kO2evEakRwFELudAcSA
    oGRy6eeSP30siWEsSCSbpjXFjnGjjGwP/rIpGQNv0iYreZ1tTIOHHgk8cm1I1sUmpzbvJ4
    b4w67hFd0sGXMmvvdjB2SdfOcKWN7f7Qm64g+9j38miwI0Qa+dfI/SiBdte7CKaotVZrjH
    sHgVcD7bw3J+6GS5qFsTQHX2ZGPlhbF7jUcFVoz6KCPPoyXFgWoXYUGro3ZtdJ79leSb+h
    wv5527WscCnsalruwiUsBOMswnrfGptxRjAsWWCXRxHtz0XAl02WpyxdNV/SKl0Je3COc9
    Y7Rv83iW1Da8x3fHuLiYg56KL7Db06ugBq0ejtwEvqiXXA6y0TldTbMcNtZImSLgYbrWNk
    Hv1BVDd4IJfVoefjjNAX81dl+BKfRkEubpREPVqpjYvy9Z4Sb6nmOIni00GD9MUiV7+STD
    O1X0WjTI0RZh7zTWFRWbXFs5lsEhsUepuIamqMmRdNk4IsT7NQKrxDBrWyvg
X-ME-Proxy: <xmx:49Ypal6XpZRGlH-lDcBoMZPFh20Y-MazbhFdOBGL1bJJbgxeF6jTtg>
    <xmx:49Ypar1k7giOMsnw6VkM9CR0N20jfCn90S94qlZgWnJAVMHHzxzxSQ>
    <xmx:49Ypauad1l2ebIWdnqmoqbs7ZgGnCXU-28MvllwPawkyjQv6paXM4Q>
    <xmx:49YparCR2qUxgpOUq4pk5a8mutYYpwrspCOkWiaQl0K5TKrUbDvVlA>
    <xmx:49YpanZe33QKpQf1vGtckGCKfYUrHPbXMMqKZ0Bx2JzjwxFiVRbSRjYI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:28:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2] update-ref: add --rename option
Date: Wed, 10 Jun 2026 14:28:00 -0700
Message-ID: <20260610212800.2892146-1-gitster@pobox.com>
X-Mailer: git-send-email 2.54.0-615-g639a4a7340
In-Reply-To: <xmqqv7brz9ba.fsf@gitster.g>
References: <xmqqv7brz9ba.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a "--rename" option to "git update-ref" with the syntax:

 $ git update-ref --rename <old-refname> <new-refname>

It renames <old-refname> together with its reflog to <new-refname>
(even when used on a local branch ref, the current value and the
reflog of the ref are the only things that are renamed).  As the
command is a low-level plumbing command, attempts to rename branches
are not warned, but we document it to draw attention of unsuspecting
users and protect them from burning themselves.

Because the "--stdin" mode wants to operate on its refs in a
reference transaction, and the API function refs_rename_ref() does
not work well as part of a transaction, it is currently not possible
to add a corresponding "rename" verb to the "--stdin" mode before
the underlying API learns to rename refs atomically inside a
transaction.  It hence is left for a future refactoring.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The initial draft I sent had a warning when the command is used
   to rename local branches, but that is unusual for plumbing
   commands that should do one thing it is designed for consistently
   well without being chatty.  This version only has words of warning
   in the documentation.

 Documentation/git-update-ref.adoc |  9 +++++++++
 builtin/update-ref.c              | 32 +++++++++++++++++++++++++++++--
 t/t1400-update-ref.sh             | 24 +++++++++++++++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
index 37a5019a8b..0c27efaa52 100644
--- a/Documentation/git-update-ref.adoc
+++ b/Documentation/git-update-ref.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
+git update-ref [-m <reason>] [--no-deref] --rename <old-refname> <new-refname>
 git update-ref [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
 git update-ref [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
 
@@ -39,6 +40,14 @@ the result of following the symbolic pointers.
 With `-d`, it deletes the named <ref> after verifying that it
 still contains <old-oid>.
 
+With `--rename`, it renames <old-refname> together with its reflog to
+<new-refname>.  The command fails if <old-refname> does not exist, or
+if <new-refname> already exists.  Because `git update-ref` does not
+update active worktree `HEAD` symbolic references or `.git/config`
+tracking settings when you rename a local branch in the `refs/heads/`
+hierarchy, think twice before using this command to rename a local
+branch (use `git branch -m` instead).
+
 With `--stdin`, update-ref reads instructions from standard input and
 performs all modifications together.  Specify commands of the form:
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2d68c40ecb..65ee8af08c 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -15,6 +15,7 @@
 static const char * const git_update_ref_usage[] = {
 	N_("git update-ref [<options>] -d <refname> [<old-oid>]"),
 	N_("git update-ref [<options>]    <refname> <new-oid> [<old-oid>]"),
+	N_("git update-ref [<options>] --rename <old-refname> <new-refname>"),
 	N_("git update-ref [<options>] --stdin [-z] [--batch-updates]"),
 	NULL
 };
@@ -756,13 +757,14 @@ int cmd_update_ref(int argc,
 {
 	const char *refname, *oldval;
 	struct object_id oid, oldoid;
-	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
+	int delete = 0, rename = 0, no_deref = 0, read_stdin = 0, end_null = 0;
 	int create_reflog = 0;
 	unsigned int flags = 0;
 
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
+		OPT_BOOL( 0 , "rename", &rename, N_("rename the reference")),
 		OPT_BOOL( 0 , "no-deref", &no_deref,
 					N_("update <refname> not the one it points to")),
 		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
@@ -787,7 +789,7 @@ int cmd_update_ref(int argc,
 	}
 
 	if (read_stdin) {
-		if (delete || argc > 0)
+		if (delete || rename || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
@@ -800,6 +802,32 @@ int cmd_update_ref(int argc,
 	if (end_null)
 		usage_with_options(git_update_ref_usage, options);
 
+	if (rename) {
+		const char *oldref, *newref;
+
+		if (delete || argc != 2)
+			usage_with_options(git_update_ref_usage, options);
+
+		oldref = argv[0];
+		newref = argv[1];
+
+		if (check_refname_format(oldref, 0))
+			die("invalid ref format: %s", oldref);
+		if (check_refname_format(newref, 0))
+			die("invalid ref format: %s", newref);
+
+		if (!refs_ref_exists(get_main_ref_store(the_repository), oldref))
+			die("no ref named '%s'", oldref);
+
+		if (refs_ref_exists(get_main_ref_store(the_repository), newref))
+			die("ref '%s' already exists", newref);
+
+		if (refs_rename_ref(get_main_ref_store(the_repository),
+				    oldref, newref, msg))
+			die("rename failed");
+		return 0;
+	}
+
 	if (delete) {
 		if (argc < 1 || argc > 2)
 			usage_with_options(git_update_ref_usage, options);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b2858a9061..4330cad282 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2455,4 +2455,28 @@ test_expect_success 'dangling symref overwritten without old oid' '
 	test_must_fail git rev-parse --verify refs/heads/does-not-exist
 '
 
+test_expect_success '--rename fails if old-refname does not exist' '
+	test_must_fail git update-ref --rename refs/tags/no-such-ref refs/tags/new-ref 2>err &&
+	test_grep "no ref named .refs/tags/no-such-ref." err
+'
+
+test_expect_success '--rename fails if new-refname does exist' '
+	git update-ref refs/tags/existing HEAD &&
+	git update-ref refs/tags/old-ref HEAD &&
+	test_must_fail git update-ref --rename refs/tags/old-ref refs/tags/existing 2>err &&
+	test_grep "ref .refs/tags/existing. already exists" err
+'
+
+test_expect_success '--rename moves old-refname and its reflog to new-refname' '
+	test_config core.logallrefupdates always &&
+	git update-ref -m "old tag" refs/tags/old-tag HEAD &&
+	git update-ref -m "to new" --rename refs/tags/old-tag refs/tags/new-tag 2>err &&
+	test_must_be_empty err &&
+	git show-ref --exists refs/tags/new-tag &&
+	test_must_fail git show-ref --exists refs/tags/old-tag &&
+	git log -g refs/tags/new-tag >output &&
+	test_grep "old tag" output &&
+	test_grep "to new" output
+'
+
 test_done

Range-diff against v1:
1:  79af0ef7d1 ! 1:  00cd13fda7 update-ref: add --rename option
    @@ Commit message
     
          $ git update-ref --rename <old-refname> <new-refname>
     
    -    It renames <old-refname> together with its reflog to <new-refname>.
    +    It renames <old-refname> together with its reflog to <new-refname>
    +    (even when used on a local branch ref, the current value and the
    +    reflog of the ref are the only things that are renamed).  As the
    +    command is a low-level plumbing command, attempts to rename branches
    +    are not warned, but we document it to draw attention of unsuspecting
    +    users and protect them from burning themselves.
     
    -    The command warns to use "git branch --rename" instead if old or new
    -    refname falls inside refs/heads/. We issue this warning (but perform
    -    the rename anyway) because "git update-ref" acts as a low-level
    -    plumbing utility: unlike "git branch", it does not update active
    -    worktree "HEAD" symbolic references or ".git/config" branch tracking
    -    configuration.
    -
    -    Note that we do not add a corresponding "rename" verb to the "--stdin"
    -    mode in this commit. While adding a "rename SP <oldref> SP <newref> LF"
    -    command to the batch stream would be useful, operations in "--stdin"
    -    mode are executed within an atomic "ref_transaction". Reference renaming
    -    is currently implemented at the backend level via standalone, non-transactional
    -    calls (e.g. "refs_rename_ref()"). Supporting renames in a batch transaction
    -    would require extending "struct ref_transaction" and the reference storage
    -    backend APIs to coordinate ref and reflog moves atomically, which is
    -    left for a future refactoring.
    +    Because the "--stdin" mode wants to operate on its refs in a
    +    reference transaction, and the API function refs_rename_ref() does
    +    not work well as part of a transaction, it is currently not possible
    +    to add a corresponding "rename" verb to the "--stdin" mode before
    +    the underlying API learns to rename refs atomically inside a
    +    transaction.  It hence is left for a future refactoring.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ Documentation/git-update-ref.adoc: the result of following the symbolic pointers
      still contains <old-oid>.
      
     +With `--rename`, it renames <old-refname> together with its reflog to
    -+<new-refname>. If either <old-refname> or <new-refname> falls inside
    -+`refs/heads/`, a warning will be issued to use `git branch --rename`
    -+instead, because `git update-ref` does not update active worktree
    -+`HEAD` symbolic references or `.git/config` tracking settings. It
    -+fails if <old-refname> does not exist, or if <new-refname> already
    -+exists.
    ++<new-refname>.  The command fails if <old-refname> does not exist, or
    ++if <new-refname> already exists.  Because `git update-ref` does not
    ++update active worktree `HEAD` symbolic references or `.git/config`
    ++tracking settings when you rename a local branch in the `refs/heads/`
    ++hierarchy, think twice before using this command to rename a local
    ++branch (use `git branch -m` instead).
     +
      With `--stdin`, update-ref reads instructions from standard input and
      performs all modifications together.  Specify commands of the form:
    @@ builtin/update-ref.c: int cmd_update_ref(int argc,
     +		if (check_refname_format(newref, 0))
     +			die("invalid ref format: %s", newref);
     +
    -+		if (starts_with(oldref, "refs/heads/") ||
    -+		    starts_with(newref, "refs/heads/"))
    -+			warning(_("You may want 'git branch --rename' instead?"));
    -+
     +		if (!refs_ref_exists(get_main_ref_store(the_repository), oldref))
     +			die("no ref named '%s'", oldref);
     +
    @@ t/t1400-update-ref.sh: test_expect_success 'dangling symref overwritten without
     +	test_grep "ref .refs/tags/existing. already exists" err
     +'
     +
    -+test_expect_success '--rename warns if old or new refname falls inside refs/heads/' '
    -+	git update-ref refs/heads/old-branch HEAD &&
    -+	git update-ref --rename refs/heads/old-branch refs/heads/new-branch 2>err &&
    -+	test_grep "branch --rename. instead" err &&
    -+	git rev-parse --verify refs/heads/new-branch &&
    -+	test_must_fail git rev-parse --verify refs/heads/old-branch
    -+'
    -+
     +test_expect_success '--rename moves old-refname and its reflog to new-refname' '
    -+	git update-ref -m "initial tag" refs/tags/old-tag HEAD &&
    -+	git update-ref --rename refs/tags/old-tag refs/tags/new-tag 2>err &&
    ++	test_config core.logallrefupdates always &&
    ++	git update-ref -m "old tag" refs/tags/old-tag HEAD &&
    ++	git update-ref -m "to new" --rename refs/tags/old-tag refs/tags/new-tag 2>err &&
     +	test_must_be_empty err &&
    -+	git rev-parse --verify refs/tags/new-tag &&
    -+	test_must_fail git rev-parse --verify refs/tags/old-tag &&
    -+	git log -g refs/tags/new-tag
    ++	git show-ref --exists refs/tags/new-tag &&
    ++	test_must_fail git show-ref --exists refs/tags/old-tag &&
    ++	git log -g refs/tags/new-tag >output &&
    ++	test_grep "old tag" output &&
    ++	test_grep "to new" output
     +'
     +
      test_done
-- 
2.54.0-615-g639a4a7340

