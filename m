Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325124219E8
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769255; cv=none; b=S7pKMRWTcoo8RJAb66nJiwnzcRdeOT5auWHHmG/Th6osFgyn187jIxJkAEBA5C1NNA4DV8Hq/SA16kiZjz0Y5uXgOK+C4pkNXOnEOVTWhxoZ7YO39DQIK4Dt7CVLGcskvLw9f7kAq/F+6f29nA9LMZ5xDGRidz+crTRmYegYMCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769255; c=relaxed/simple;
	bh=SD7/ZgM2i98RMCSLSNuX39n/0IySJ1wllGO7snKY4aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wg/dcOTGWj7DIsGNbPEe74cnihutg7C7fa0LaYrz/0Hod39Ixdms/TxWcGdH4cpYNnq2efvVwD6WlBbvatYNamk9nKMEXcSEV6SxU1+j5RDLHR0+dgMszjFgHuhQg9lnVk62VIL0ZgV7O+TxyEE5N8UNG+GnWkRM/XdoBl8KC9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdJB/9ao; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdJB/9ao"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-90d13fa59e8so341779485a.2
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769253; x=1779374053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEs2aZhogZg4tN+4ubJl0mkvPc66Av1s8PxhInkroaE=;
        b=gdJB/9aoytc0eG+NMcvfuVutyaLgFJvhbk7lLUXyfy8mds4y/GRYtLQ/cuo3ES7N9a
         s93ClJIGkftYnetxZKA8WkCEPrTe3iCiBkSMRu6CIA3Hjo/A0vYlZpfl6SSOaoOnQuAQ
         Gu5nPgSLHVUMo80jkv8T4nq/85vbT1U+gTCsNYelqWKmFaicDvtO4SbRkKy45FS5v33L
         mBE0X76c+01/+t6ILMHp4zTC6ry5d0+qeM+CG/jCdFhJ4dX5uWlyo6r+DwejhoZN/3pC
         NA6zRVZoqqNPp+xCtVufMQE20dxC9XtMKGvSgmXAPHxGEaofuWJZk1PaILm4Bld/LRtD
         1ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769253; x=1779374053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hEs2aZhogZg4tN+4ubJl0mkvPc66Av1s8PxhInkroaE=;
        b=JUgi1KKSGQFzp4q1ULmltjnIi36XDRYQeVbH3wNobql2gR89oOaOhvystBz5sAkDU0
         wViLYmp6gWQjPe/9Iv9RjhwBubAzdZEdhXLZ6VaVUy0TOr/FLhGaOyWwv2jJz/IcmzsT
         qkenTWuEH1CmZOJnfsefqkDhXUVu5sg23xPHRXEYqpor7BqgAKoJQCi8B+rgGKOPIR8a
         Jc8jKkiKRP9EeGLlPayuCu/ZOGjDHsI3yk8I5+TTrExNOZWjymzB4nou7AmDOnHkkOf/
         pbrbUXYGY18mRXTBYKGvJn6TXNNK2LGo5TC93Qro2RHln7VOR5uT+xUiz3BhEWhzt7xt
         uymg==
X-Gm-Message-State: AOJu0YzCU04ItQCe0mMnIhtrWIhwi8+TOpT5rvk9+i0tnDWGj0SG8F3d
	PNaMORkoIc0GdKhHrkzXTRuTPLuhD5mEj74oUIJoiBPxMNDJckuGbzolja3Xig==
X-Gm-Gg: Acq92OGb60uepL/HHok6fRlgoH2OpaRuDiWJFxE8ch8No9c4NML01ThSh2f8GeUD9Ce
	+fGLa1ztBgm5J85Pv89Wal0k9CgX8wBowV+3GwYd6bBmJMTMFMJIcPpgPEiMjhdi1MvNvLIfpF3
	46oBTpI0uZRpICgYg2O9vshKnhBw6sYjUeqIcvinrfJxKqq4wp2CLVKzm94D4N/Rs3Gbz4xnj4K
	fEPHG1eOVE0bIkVcFLCa2zrpml5ENAxHs/liv9NgucpzQAeAbnWzj3mYB6hnsU8YemQHNnM0y55
	dLkQJjP39AaZsMAq0V78g77qVHS/eZ7zfBVJHKlNzmk8BZ/qGtSnNvqf7H3mAh2j5O51mxOZIDJ
	Ot297Nrc3bJK97GXp/2YXBcO6gV4ucuDilmfejioO/lLI/guEqWyy/TBU22AzWaYvi6eolp5jfT
	4VGV7pDK77nZKyzbzhcw==
X-Received: by 2002:a05:620a:4044:b0:8cd:9665:9eff with SMTP id af79cd13be357-90f88f92239mr1302547385a.21.1778769252112;
        Thu, 14 May 2026 07:34:12 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm262768585a.19.2026.05.14.07.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:34:11 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com,
	j6t@kdbg.org,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 11/11] git-gui: add gui and pick as explicit subcommands
Date: Thu, 14 May 2026 10:33:22 -0400
Message-ID: <20260514143322.865587-12-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260514143322.865587-1-mlevedahl@gmail.com>
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui accepts subcommands blame | browser | citool, and assumes the
subcommand is 'gui' if none is actually given, But, git gui also has a
repository picker (choose_repository::pick) that can create a new
repository + worktree, or choose an existing one, switch to that, and
the run the gui. The user has no direct control over invoking the
picker, instead the picker is triggered by failure in the repository /
worktree discover process: this includes being started in a directory
not controlled by git, which is probably the intended use case.

The picker can appear when the user has no intention of creating a new
worktree, and the user cannot use the picker to create a new worktree
inside another.

So, add two new explicit subcommands:
    gui  - Run the gui if repository/worktree discovery succeeds, or die
           with an error message, but never run the picker.
    pick - First run the picker, regardless, then start the gui in
           the chosen worktree.

Nothing in this changes the prior behavior, the alternates above must be
explicitly selected to see any change.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 3a83dd5..c56aeef 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1021,6 +1021,7 @@ proc load_config {include_global} {
 ##
 ## feature option selection
 
+set run_picker_on_error 1
 if {[regexp {^git-(.+)$} [file tail $argv0] _junk subcommand]} {
 	unset _junk
 } else {
@@ -1030,6 +1031,7 @@ if {$subcommand eq {gui.sh}} {
 	set subcommand gui
 }
 if {$subcommand eq {gui} && [llength $argv] > 0} {
+	set run_picker_on_error 0
 	set subcommand [lindex $argv 0]
 	set argv [lrange $argv 1 end]
 }
@@ -1047,6 +1049,7 @@ blame {
 	disable_option multicommit
 	disable_option branch
 	disable_option transport
+	set run_picker_on_error 0
 }
 citool {
 	enable_option singlecommit
@@ -1055,6 +1058,7 @@ citool {
 	disable_option multicommit
 	disable_option branch
 	disable_option transport
+	set run_picker_on_error 0
 
 	while {[llength $argv] > 0} {
 		set a [lindex $argv 0]
@@ -1162,14 +1166,28 @@ proc pick_repo {} {
 	set picked 1
 }
 
+# run repository picker if explicitly requested
+switch -- $subcommand {
+	pick {
+		pick_repo
+		set subcommand gui
+		set run_picker_on_error 0
+	}
+}
+
 # find repository.
 if {[catch {
 	set _gitdir [git rev-parse --absolute-git-dir]
 } err]} {
 	if {[is_gitvars_error $err]} {
 		exit 1
-	} else {
+	}
+	if {$run_picker_on_error} {
 		pick_repo
+	} else {
+		catch {wm withdraw .}
+		error_popup [strcat [mc "Git directory not found:"] "\n\n$err"]
+		exit 1
 	}
 }
 
@@ -3051,7 +3069,7 @@ gui {
 	# fall through to setup UI for commits
 }
 default {
-	set err "[mc usage:] $argv0 \[{blame|browser|citool}\]"
+	set err "[mc usage:] $argv0 \[{blame|browser|citool|gui|pick}\]"
 	if {[tk windowingsystem] eq "win32"} {
 		wm withdraw .
 		tk_messageBox -icon error -message $err \
-- 
2.54.0.99.14

