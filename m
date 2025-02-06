Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B913C80E
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821509; cv=none; b=en9j9B9NrG/PjjCzcvgV45rqxTXeBRqPf8Qp7aQ0iCQkmRSsMHFe16tDZcP2xnW3iXl7izvyL+m9KAdK6q8S3OO1WNt5rupVzhT/w1k0Z0J866irLLRS0MO9Wvok2yIBld1P/6UlHc4Dal79kRXxUcrOgcsy6b/J8ouULLnrqeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821509; c=relaxed/simple;
	bh=sCHTY907ZcUJdidd3z1mE+0s0riA1TYdk6sIyEuL+OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuE3QXIwrZ419RlFt4+kjpS0N7jTD4dQp+frEUPjduML7yxnkaomsaHGK6ygN6oZWQK0gKLHXmB9ZgxlOszhYySiLo8l6onRGXfbc0Cq93ZopA9C04iDkBGK/aVbpQG21JuI7IHIQRreWPqsVeNUbS5PZQWJ+C28+o4iimGJnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dok0tPLu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dok0tPLu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21628b3fe7dso9918305ad.3
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 21:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738821507; x=1739426307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKzLIbC2fKixEovH6wh792J66Eu8I7gLyeAj7XJqT1Y=;
        b=dok0tPLumFLYyCVGMmswbzwakGhKnkdMD+Twee87qP/mRv8TEiAOUx/Pa44YWEjnXM
         cMltoLSWDVyKmManrnN3Banlhop752k0lCUbRdFNByAMaYeioAk2ub+Bilyhd//Mpi7Q
         wEI02HsogIgIf3Rj0JwaObTLbLuQCPmfP/68phq+HFrV8CJMQ/va0Kva+3WMGGoqlJ93
         m1PdeppdXOqyx1Ak5hnPT4OrAQbS3r4zce8U0C0cJy7+udaMFDC2fKNrggBzj956S3f1
         EdU8cvgpoTHewUNLj+JeU7cqoya4oyBIjK/roRB/8WrLFuK06p6KuDxlVsr6fercQ10T
         Mnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821507; x=1739426307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKzLIbC2fKixEovH6wh792J66Eu8I7gLyeAj7XJqT1Y=;
        b=OrXLw2BtaBJtf9K7xFmKHfTAT3bLOmFhtzyIVsTkjauXIFiVhLH3P7GrCewPEHxq39
         9xiXF1E7x4KpoxhkFt1HL8Bnx902gLK7U7NvIljksXVdIOaLHSgtgKz1kPfEpv97wXCE
         AmuPl+hLpvXCspIfIXV2Rmo+pjAhyB0Oyy1u6HrRhAXEJcC0DbZBz3jzQJNGVzFFRqrP
         4NK3kRHYXuwro1InHxEk/z2vHMPIxprjM4wdoSYeIH7Ab6M2/ZVQ+EiFy+qZJngiah5s
         jlloiUiHk4AdoZuFbimWaU/5ao7X4qsqJVnOzXumJhlcy5hSuiqsZAXbKzKKVtahR4As
         Onrw==
X-Gm-Message-State: AOJu0Yyx/LsVPv4UfIXuWvrpWFxFUHvPTrH98i14KTfBGnMjGtmkrIeI
	ZeDU4yt+vXdqJ9ZfL082Q9jd6tt4JPZFhJxBwV5VSvcog4rglmVlW5d6Sg==
X-Gm-Gg: ASbGnctnWrET7TgC/EWLpZNj6iPuV7AV/ndEpN3mjqN1HzBbCI5t+RL245yZyIyu/ke
	LztmTC6GNWyjGtNYxZkqnIR++1JjWsdOe8i9YLLPNs44tgk5TnHo7hZCZ4KQO7J72XoTdSvLfRG
	PL94+pPnAArAvfDtvKlwPQcpCjxP6ayN+jfVXIz3MCtoWO48pqdx+midJihHFqZN5dMcbaJITsE
	Z5PgXxwAGn+SblxFICrbxBN2m10er2ONLcJ8+TJ3zzkDeCjvZY7RE2OALTapn1RUWQrHA==
X-Google-Smtp-Source: AGHT+IGh6zRH/rPGEFLUFt/7shixQXeooq8PTxHqTSp8nkBb4JW+EG9dViIq8TcYXguaAXw2MFVxWQ==
X-Received: by 2002:a17:902:d508:b0:215:9379:4650 with SMTP id d9443c01a7336-21f17edf7d4mr86479155ad.42.1738821506710;
        Wed, 05 Feb 2025 21:58:26 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3650ce93sm4107345ad.51.2025.02.05.21.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:58:26 -0800 (PST)
Date: Thu, 6 Feb 2025 14:00:07 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 8/8] builtin/fsck: add `git refs verify` child process
Message-ID: <Z6RP50d7eRsKRCG6@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6RPJI10-2QkwyqH@ArchLinux>

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

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/git-fsck.txt |  6 +++++-
 builtin/fsck.c             | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 5b82e4605c..9bd433028f 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
 	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
-	 [--[no-]name-objects] [<object>...]
+	 [--[no-]name-objects] [--[no-]references] [<object>...]
 
 DESCRIPTION
 -----------
@@ -104,6 +104,10 @@ care about this output and want to speed it up further.
 	progress status even if the standard error stream is not
 	directed to a terminal.
 
+--[no-]references::
+	Control whether to check the references database consistency
+	via 'git refs verify'. See linkgit:git-refs[1] for details.
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
-- 
2.48.1

