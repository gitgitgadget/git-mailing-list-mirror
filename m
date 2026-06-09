Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6135B362154
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040926; cv=none; b=CGkwjaxRlD79HOHJuwzBFaBfAXTXiUFlTjw9lEdxiV5bSYYBtRVH0qFKIryvQwzH9kWdODzyGed377tnetUv3oRsITs12355nBJPQcXZN8ysanUkCpdY74+pOud9ccSRIDgKqk95Vgwr0atsQFTCPF9G9Za0Z2eWT4BmykDNIpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040926; c=relaxed/simple;
	bh=g+UhVXtQS+4DpoLq8fUloaCHIYpkzEzsNT6/kEmqPe0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i2NV4he+PumU95OWlAmqaaAHwYvlWYROyWaPhn1SkqsTr7RKd/oSS+cABz3QfzJg3zTmXzOmR2en3SuBRAA8CAysWr1oWEU6prrVhkcrAH5Z+pEjlZrAJTBXqiBf6pCywYHE22mxOOLNb82zWWfEnTEjYPrJo2QHGTP7cnXRjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dZmIorhc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G6VYzCQS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dZmIorhc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G6VYzCQS"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 802CA1D00095;
	Tue,  9 Jun 2026 17:35:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 09 Jun 2026 17:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1781040923; x=1781127323; bh=MZvRu1A/FlfbiWRqd4DhCblA5PFmZo4m
	h7MVka8ohTs=; b=dZmIorhcHlTr9FZhUJLAbUkHIZO/2fAlCZk2lrtF/sDohf5S
	g7njkRgOAGi0cm3EMlBQ0+XVTglUjIZsDTQmjFjRLTw+MUGfQ2ndTrvpEC/kMxbq
	6Fu8qRO0bhpv5cRw1a69VT9iVAK9YMd70uwlATyXCayMxTJnQgpDu5xR0TRIiRMn
	lArdl7HvErbAAiqwdW1SFKADVWEPrS2ECTmdZTEdfRWgyOW9s/d3zrGyHe5owGtb
	VaIxI3WHP04+oJ5c2bN6pLoHb6kdTZc1/W7N7GaKBa0XoRWgUViSw2g45mQgaeuX
	xxoVbCvFiqVlcBEOLpJ8HBVsdIpkqSeloO2Ghw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781040923; x=
	1781127323; bh=MZvRu1A/FlfbiWRqd4DhCblA5PFmZo4mh7MVka8ohTs=; b=G
	6VYzCQS0DBCXqFW4XkOl+LkJl59vyi+bc9w8XFAIqtaoVGc+yt2+gtBi6SdPXaYE
	5jHyF8GgTKysIz0vJNj51o8FDKxEK4l2C3iBB/tT5xUylfhWm+ZacpqDdF/cue5d
	jA383iAtkWVoxf/p3nv3+7ojg9cv/5BsVAyvoiSw+IDm1+v1qoGvODDZoP4dE0Rx
	L/Mfz+ybC00yZNa+p359503Zv+MiHYTcNW2rHsfUzyB4BREcr6eFYv64iTf+GKz4
	TQBmDGJGUG4FIb1boxm0tcYZ0DO1Wzv+7fVRKblNl3bqdh6nlHpYr/k7IlbxYzi/
	sJlNDeiZyZwPnPWz/ndYw==
X-ME-Sender: <xms:G4coapMd-irkhDWEGUgtaP4-E96pKx3pX8T8eAqTyEPZWMJ1SJjRig>
    <xme:G4coah9JKJnY2jFjT17EyCUROIH3BaXT78cyYT4mzWt0OpP_PRw1bsQn2d8HO8NOO
    GeXGGpjszhA4IkfJ9sAQRy3yXvViAHNoqKL99cslGMsXfg3IUVG>
X-ME-Received: <xmr:G4coal7yteZMrMZmiETcDFBIRzNq6rgPfixHCUhKjJL4NwTyK_L0HyXmob1Iesd4lExyKUMHRtikbMIqIQLbC0OPxYC7id7V5CtN>
X-ME-Proxy-Cause: dmFkZTF911+b2T61Lue+ChUJnglq7qszKgURF6v4bJT02U2H4u7eIi0SDfbpl8l2SKbOUT
    CLztJDRhthAeb//+/oKA6xmyOMZB2/UgevFHx7y24yDKpLnQLGCo384pD565/BnoYLWUzw
    HIBUDNFoA9O1mdGs+fZLxaWx6YXfe0BzKuS5rpAroU13qojY2cKeAWjENQT45SzIPAyrd8
    6376jpaHF6qF0GnYoZVfeRP1rPm9I3nl7/JGbm5a3+Ix05I0XnT9q5rdYdv1E3Rv8vN52U
    xt5Ab0mneHo16TLKXqZXz8QV7gBDQhvSL+FeoBjsGdaAnns6YUmFJCO0rcdV7EEw+zr9Da
    pf1HUl2+xdgXE1IgRtKUxS4dHyK8/kp7uYDfJvVuYmgbgPud4q0bkW+D8EA8Np6osu2dkX
    wQXBlWAeOq9R+qG357klqIcXGmOKt4gyF+zt5p++E6at05RrtKyactGqaz6phdc2McS7UQ
    pwuckMBoLNruvj1FVdRjm/kcZQz2y2hU8jv/yMQmH9vrdyu/7+uJS+oeBmq0lxHog+5M0s
    SphN+3Oo2faP5/vfO17SnCGaNMKkVIGsjAq1oKbZ5QayLBuZ4UpBWTym5sp7ubCF491A0E
    edWU1x2Cx/s3wx6C3aXL5LcjCqJDNmnzmWk9lWkSjqSdOUbRhLewymzTGoaQ
X-ME-Proxy: <xmx:G4coag3vus0bq3Ys1-8-sPh28F8moxLHKb09kinXEZya8OCIHq8gSg>
    <xmx:G4coakD0HxuERzHQ6uqm52oePP0A_-EQRvGxDcN0y6HtKfSpWhP1oA>
    <xmx:G4coaq1qpIpcyON25Tu24g0HnB96U93cdF9VNWefqhCIId19dohzNA>
    <xmx:G4coamuM6fja_zVu4HrwIzi02ocxTUEADaePUK5P52p10UCEfYVNOA>
    <xmx:G4coaklxxDeTcpJuQnx8xx-XdmCSGfAD927e50SlfJaz8XaWJTt_6k82>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 17:35:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] update-ref: add --rename option
Date: Tue, 09 Jun 2026 14:35:21 -0700
Message-ID: <xmqqv7brz9ba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add a "--rename" option to "git update-ref" with the syntax:

 $ git update-ref --rename <old-refname> <new-refname>

It renames <old-refname> together with its reflog to <new-refname>.

The command warns to use "git branch --rename" instead if old or new
refname falls inside refs/heads/. We issue this warning (but perform
the rename anyway) because "git update-ref" acts as a low-level
plumbing utility: unlike "git branch", it does not update active
worktree "HEAD" symbolic references or ".git/config" branch tracking
configuration.

Note that we do not add a corresponding "rename" verb to the "--stdin"
mode in this commit. While adding a "rename SP <oldref> SP <newref> LF"
command to the batch stream would be useful, operations in "--stdin"
mode are executed within an atomic "ref_transaction". Reference renaming
is currently implemented at the backend level via standalone, non-transactional
calls (e.g. "refs_rename_ref()"). Supporting renames in a batch transaction
would require extending "struct ref_transaction" and the reference storage
backend APIs to coordinate ref and reflog moves atomically, which is
left for a future refactoring.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/git-update-ref.adoc |  9 ++++++++
 builtin/update-ref.c              | 36 +++++++++++++++++++++++++++++--
 t/t1400-update-ref.sh             | 29 +++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
index 37a5019a8b..a622f2512b 100644
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
+<new-refname>. If either <old-refname> or <new-refname> falls inside
+`refs/heads/`, a warning will be issued to use `git branch --rename`
+instead, because `git update-ref` does not update active worktree
+`HEAD` symbolic references or `.git/config` tracking settings. It
+fails if <old-refname> does not exist, or if <new-refname> already
+exists.
+
 With `--stdin`, update-ref reads instructions from standard input and
 performs all modifications together.  Specify commands of the form:
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2d68c40ecb..1ae2dac6c5 100644
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
@@ -800,6 +802,36 @@ int cmd_update_ref(int argc,
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
+		if (starts_with(oldref, "refs/heads/") ||
+		    starts_with(newref, "refs/heads/"))
+			warning(_("You may want 'git branch --rename' instead?"));
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
index b2858a9061..fcb986d485 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2455,4 +2455,33 @@ test_expect_success 'dangling symref overwritten without old oid' '
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
+test_expect_success '--rename warns if old or new refname falls inside refs/heads/' '
+	git update-ref refs/heads/old-branch HEAD &&
+	git update-ref --rename refs/heads/old-branch refs/heads/new-branch 2>err &&
+	test_grep "branch --rename. instead" err &&
+	git rev-parse --verify refs/heads/new-branch &&
+	test_must_fail git rev-parse --verify refs/heads/old-branch
+'
+
+test_expect_success '--rename moves old-refname and its reflog to new-refname' '
+	git update-ref -m "initial tag" refs/tags/old-tag HEAD &&
+	git update-ref --rename refs/tags/old-tag refs/tags/new-tag 2>err &&
+	test_must_be_empty err &&
+	git rev-parse --verify refs/tags/new-tag &&
+	test_must_fail git rev-parse --verify refs/tags/old-tag &&
+	git log -g refs/tags/new-tag
+'
+
 test_done
-- 
2.54.0-618-gdfae347457

