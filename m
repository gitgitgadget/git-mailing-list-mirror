Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B71B07AE
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672463; cv=none; b=SnV5h49OpIngw7//C+M3DFRfvPUASEN/OhYjzbTwIsXeLn0C+kURNRdBG7rCPLqASlc7/gUiEGs/4ZrEoBx375zx/GFBTJNJg4Jmy++DNNemAfr70LLHZf40HgkwZL6yIQHx3LWNpdzSTDKCnX4j8osacWd4BTIhqv7LUyJ4A0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672463; c=relaxed/simple;
	bh=+aHq/0mhg3mqmhS9d2qjcyWfrd49Ck2gOcmj77QlhX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPkYwRokpxVRmI5fX+axUEjgfG1lPxCa6mf9vqTM1tMyr5jIPKVdSsUm84eGBOHyX0e+VIucpfcbOoPj0Xtx8lAd2a/fm+ti3erSkgTnDnhJA9mAepsPMhNTGV21ttVOQH+rTn8RBT/agytwxgSy0LgFM/2oyfGttZjV5BwAPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRJhcHnJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRJhcHnJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e83d65e5so21448275ad.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 08:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672460; x=1741277260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P97hX1r72VErTTUpW28u0qQ0ZvGnJob0r/Tm2EjItaM=;
        b=CRJhcHnJhMRmbDDwCZ08AqvYqJStAGqk7/uiVteAlMhuH4AQgBpMMUW3iU4jkkLf44
         iNXe/ppGr37CndfQB8i3qjnafFbmoj/H4s6EgqdrWZuW4xSA8ykzB0Bj4nrn/Qz7jUmi
         7X8XtVUHF6/LyQ4DzlSOEkH2ot8vkZVhP6ZaFF6LVllokawsEiNiWRiZrnaIvG3JC82B
         HebWb3zhr6cVIs66d9t3/GEEYmGBxqY2101rEnMYnbNdEhYIWr56FMeRa8o/5kUmV+Hu
         1MIMbZGwetv6hAYjjr1oXH4ersYD/hmJMBZy/h6/mKlk1YAaRFBccx7xc5a3VsNdLy68
         Jo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672460; x=1741277260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P97hX1r72VErTTUpW28u0qQ0ZvGnJob0r/Tm2EjItaM=;
        b=JMjKoJu+o/qb5YQICWY4DF9GDZIbTZkijl1mHTqi60yT7GmRQUb/al6NnB1stFJb6n
         WWfpGYwT/ujlwN2i7LQ/HE28DJ4vXx5gRliYxGxzXbsGb+jvfN2k5BUtJhGWrsqVgJ1i
         eyz4OYm2ghIFEqVZG6iyhAwQuItviECkY5CXhas+0lom3aqT4+QgDULo7WnNTaBBAJ/Q
         j90Yf1vFp7T1WMGpNNf2HYUVyk2NkedEdmgMDOKtpL1tRuX1vUlpHvME4qmGRij+Osb+
         5OAVobcvfdhO2n4kMFpQISXjliCvmZuqukOlsYqW6n+yzBoCyzPk1ZmHERx0yb+ZGNOf
         pUlA==
X-Gm-Message-State: AOJu0YwP4glskvJ7Yq3foz9ZuTKukFiLAznjBg9LhqZ41I1j9nZ5JtQb
	JINCLZHnB1h4TAvs2V8Q8POUWglAewvmrRdQwbWOyKFhzDjAFtiYxwE2Xg==
X-Gm-Gg: ASbGncvVoBhkPsc/GEYi9agpeoxF21U1Q1pVM9A0f8reQ4jw1Jbn1OTeyhzvTb/iJuY
	i1eJvUkCKRkdeCMJaTBks2J7d/+hMrHYhHHCJVA8u8hPBypTyBDB1SOCG4l2uYfs8nPfRfgXDOe
	1C4K7liL7B83dKSbSUonpbtnk0iXwda1VDKJ++AIPEm8Cal1PbuQVQLWW+tw4IXqUPh5EVRb34F
	QWRj2nYNZ/oB6uYtjQxBV5VWk6MzeM8GK+sG2rZDVGnNdm42kRU59E21Lo4Z/UlCyTMs9+JnIrN
	7MVasojTdEeXmUZJj8hSHQ==
X-Google-Smtp-Source: AGHT+IF1voJ8VXR70YkPT6FfJOD5VtSzTJ8ksScAOVPF0/pk4izrGLZeJTBEOvfORkIoek+OAbMcmg==
X-Received: by 2002:a17:902:dac8:b0:220:ee5e:6bb with SMTP id d9443c01a7336-22320082bfdmr115759755ad.20.1740672459051;
        Thu, 27 Feb 2025 08:07:39 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee7de1a49esm1658200a12.17.2025.02.27.08.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:07:38 -0800 (PST)
Date: Fri, 28 Feb 2025 00:07:48 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 9/9] builtin/fsck: add `git refs verify` child process
Message-ID: <Z8CN1K51oJliGCO9@ArchLinux>
References: <Z8CMx7O19PMs9sVY@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8CMx7O19PMs9sVY@ArchLinux>

At now, we have already implemented the ref consistency checks for both
"files-backend" and "packed-backend". Although we would check some
redundant things, it won't cause trouble. So, let's integrate it into
the "git-fsck(1)" command to get feedback from the users. And also by
calling "git refs verify" in "git-fsck(1)", we make sure that the new
added checks don't break.

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git refs verify" command. In order to provide
the user interface create a progress which makes the total task be 1.
It's hard to know how many loose refs we will check now. We might
improve this later.

Then, introduce the option to allow the user to disable checking ref
database consistency. Put this function in the very first execution
sequence of "git-fsck(1)" due to that we don't want the existing code of
"git-fsck(1)" which would implicitly check the consistency of refs to
die the program.

Last, update the test to exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/git-fsck.adoc |  7 ++++++-
 builtin/fsck.c              | 33 ++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh    | 39 +++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fsck.adoc b/Documentation/git-fsck.adoc
index 8f32800a83..11203ba925 100644
--- a/Documentation/git-fsck.adoc
+++ b/Documentation/git-fsck.adoc
@@ -12,7 +12,7 @@ SYNOPSIS
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
 	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
-	 [--[no-]name-objects] [<object>...]
+	 [--[no-]name-objects] [--[no-]references] [<object>...]
 
 DESCRIPTION
 -----------
@@ -104,6 +104,11 @@ care about this output and want to speed it up further.
 	progress status even if the standard error stream is not
 	directed to a terminal.
 
+--[no-]references::
+	Control whether to check the references database consistency
+	via 'git refs verify'. See linkgit:git-refs[1] for details.
+	The default is to check the references database.
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7a4dcb0716..f4f395cfbd 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -50,6 +50,7 @@ static int verbose;
 static int show_progress = -1;
 static int show_dangling = 1;
 static int name_objects;
+static int check_references = 1;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
@@ -905,11 +906,37 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	return res;
 }
 
+static void fsck_refs(struct repository *r)
+{
+	struct child_process refs_verify = CHILD_PROCESS_INIT;
+	struct progress *progress = NULL;
+
+	if (show_progress)
+		progress = start_progress(r, _("Checking ref database"), 1);
+
+	if (verbose)
+		fprintf_ln(stderr, _("Checking ref database"));
+
+	child_process_init(&refs_verify);
+	refs_verify.git_cmd = 1;
+	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
+	if (verbose)
+		strvec_push(&refs_verify.args, "--verbose");
+	if (check_strict)
+		strvec_push(&refs_verify.args, "--strict");
+
+	if (run_command(&refs_verify))
+		errors_found |= ERROR_REFS;
+
+	display_progress(progress, 1);
+	stop_progress(&progress);
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
 	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
 	   "         [--[no-]dangling] [--[no-]progress] [--connectivity-only]\n"
-	   "         [--[no-]name-objects] [<object>...]"),
+	   "         [--[no-]name-objects] [--[no-]references] [<object>...]"),
 	NULL
 };
 
@@ -928,6 +955,7 @@ static struct option fsck_opts[] = {
 				N_("write dangling objects in .git/lost-found")),
 	OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 	OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for reachable objects")),
+	OPT_BOOL(0, "references", &check_references, N_("check reference database consistency")),
 	OPT_END(),
 };
 
@@ -970,6 +998,9 @@ int cmd_fsck(int argc,
 	git_config(git_fsck_config, &fsck_obj_options);
 	prepare_repo_settings(the_repository);
 
+	if (check_references)
+		fsck_refs(the_repository);
+
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(the_repository,
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 767e2bd4a0..9d1dc2144c 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -830,4 +830,43 @@ test_expect_success 'packed-ref without sorted trait should not be checked' '
 	)
 '
 
+test_expect_success '--[no-]references option should apply to fsck' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	(
+		cd repo &&
+		test_commit default &&
+		for trailing_content in " garbage" "    more garbage"
+		do
+			printf "%s" "$(git rev-parse HEAD)$trailing_content" >$branch_dir_prefix/branch-garbage &&
+			git fsck 2>err &&
+			cat >expect <<-EOF &&
+			warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
+			EOF
+			rm $branch_dir_prefix/branch-garbage &&
+			test_cmp expect err || return 1
+		done &&
+
+		for trailing_content in " garbage" "    more garbage"
+		do
+			printf "%s" "$(git rev-parse HEAD)$trailing_content" >$branch_dir_prefix/branch-garbage &&
+			git fsck --references 2>err &&
+			cat >expect <<-EOF &&
+			warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
+			EOF
+			rm $branch_dir_prefix/branch-garbage &&
+			test_cmp expect err || return 1
+		done &&
+
+		for trailing_content in " garbage" "    more garbage"
+		do
+			printf "%s" "$(git rev-parse HEAD)$trailing_content" >$branch_dir_prefix/branch-garbage &&
+			git fsck --no-references 2>err &&
+			rm $branch_dir_prefix/branch-garbage &&
+			test_must_be_empty err || return 1
+		done
+	)
+'
+
 test_done
-- 
2.48.1

