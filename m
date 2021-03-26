Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49648C433E4
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6CA61A49
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCZKhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 06:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZKhA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 06:37:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6DC0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:36:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so2720433wmi.3
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxAd/wAjnEerUZSW3pCLd9DpQGnc9iMa8X/PBzxEmAw=;
        b=IHecP3iOHOZsQyyyn26UpDvVAMp31apyv0GPwmEsH7i3atz/H6m3iyowbdWxrOGW2b
         bHxNG7VbJUtMttujht8GTLcTYFBitFJSYoakfZX+0zXc54jhc23g8J/JfjC4826jaPNc
         t1UdOJlqSgt42P9rsaLo3LAnN3n42BWbGLlWwvq85BvKHfWClhIcM/lIyN9GrV9N9aHg
         74dcwzJyHrDt5QjGf/SFO81+aWL0PKK8KsBq5+ONt6FlVsRSs+9yXYnXDEOtEjGZ0F44
         3mSDGpwP/UQEycmT16vFDAtONZw7rl2I4SYwbWAQprxH3n+Ctb5sBC/gEK+Z18Nli/mA
         MdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxAd/wAjnEerUZSW3pCLd9DpQGnc9iMa8X/PBzxEmAw=;
        b=ZpBd9T2DFtcKx2QXNnUjKypG3jLtaPKYRERTRib7hM7VXv8hQSNhKkOjbvFg+5AVzW
         EimWkfUFFPgcBo15+1b4VdyOgkrg/XyN0vnuWte1L+mKCUgiwyErV1WCt8aQZQEZpR24
         IG9r7nHEtfQaWILm0Q3hmRhnVScPmDjBPQQCkJ1dfdvIt6vQLYawOF1okby5d9wgRshh
         +iyyDxHmHzm8rKWREKJUkWPsuUPqXtQN0ZyP6eHwq39AT1cOxkDeX3YMjZL5BiapdgCg
         cMkPrqm/W/6tb9duMUdroge/TPaeoDt8tHhUyNv5OHU+NPJyNCWPfqcpRicpteZ3ejtz
         epDA==
X-Gm-Message-State: AOAM530aDJCBAkpnG9ohwRzt86CHJQ2pmX1EmEy3J166sk3pijGZwBs2
        yWt6+3INPOWVXSw+GqFUuK3k6csqojOjbg==
X-Google-Smtp-Source: ABdhPJzZg7Rl9TXzpoWs/pHVyUaoZEAJhuLsk7vJHk0CRduLbD3FHBPD/K0iZhElkCSEDXEfD/GElw==
X-Received: by 2002:a05:600c:2946:: with SMTP id n6mr12357842wmd.52.1616755018011;
        Fri, 26 Mar 2021 03:36:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o2sm1752563wmr.10.2021.03.26.03.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 03:36:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] doc lint: fix bugs in, simplify and improve lint script
Date:   Fri, 26 Mar 2021 11:36:49 +0100
Message-Id: <patch-4.6-5c8e8f21495-20210326T103454Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.419.gfc6e4cae13
In-Reply-To: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The lint-gitlink.perl script added in ab81411ced (ci: validate
"linkgit:" in documentation, 2016-05-04) was more complex than it
needed to be. It:

 - Was using File::Find to recursively find *.txt files in
   Documentation/, let's instead use the Makefile as a source of truth
   for *.txt files, and pass it down to the script.

 - We now don't lint linkgit:* in RelNotes/* or technical/*, which we
   shouldn't have been doing in the first place anyway.

 - When the doc-diff script was added in beb188e22a (add a script to
   diff rendered documentation, 2018-08-06) we started sometimes having
   a "git worktree" under "documentation". This tree contains a full
   checkout of git.git, as a result the "lint" script would recurse into
   that, and lint any *.txt file found in that entire repository.

   In practice the only in-tree "linkgit" outside of the
   Documentation/ tree is contrib/contacts/git-contacts.txt and
   contrib/subtree/git-subtree.txt, so this wouldn't emit any errors

Now we instead simply trust the Makefile to give us *.txt files, and
since the Makefile also knows what sections each page should be in we
don't have to open the files ourselves and try to parse that out. As a
bonus this will also catch bugs with the section line in the file
being incorrect.

The structure of the new script is mostly based on
t/check-non-portable-shell.pl. As an added bonus it will also use
pos() to print where the problems it finds are, e.g. given an issue
like:

    diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
    [...]
     and line numbers.  git-cherry therefore detects when commits have been
    -"copied" by means of linkgit:git-cherry-pick[1], linkgit:git-am[1] or
    -linkgit:git-rebase[1].
    +"copied" by means of linkgit:git-cherry-pick[2], linkgit:git-am[3] or
    +linkgit:git-rebase[4].

We'll now emit:

    git-cherry.txt:20: error: git-cherry-pick[2]: wrong section (should be 1), shown with 'HERE' below:
    git-cherry.txt:20:      "copied" by means of linkgit:git-cherry-pick[2]' <-- HERE
    git-cherry.txt:20: error: git-am[3]: wrong section (should be 1), shown with 'HERE' below:
    git-cherry.txt:20:      "copied" by means of linkgit:git-cherry-pick[2], linkgit:git-am[3]' <-- HERE
    git-cherry.txt:21: error: git-rebase[4]: wrong section (should be 1), shown with 'HERE' below:
    git-cherry.txt:21:      linkgit:git-rebase[4]' <-- HERE

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile          |  14 ++++-
 Documentation/lint-gitlink.perl | 108 +++++++++++++++-----------------
 2 files changed, 65 insertions(+), 57 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 7313956d73f..6bfd8c75772 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -4,6 +4,7 @@ MAN5_TXT =
 MAN7_TXT =
 HOWTO_TXT =
 INCLUDE_TARGETS_TXT =
+ALL_TXT =
 TECH_DOCS =
 ARTICLES =
 SP_ARTICLES =
@@ -49,6 +50,13 @@ HOWTO_TXT += $(wildcard howto/*.txt)
 INCLUDE_TARGETS_TXT += $(wildcard *.txt)
 INCLUDE_TARGETS_TXT += $(wildcard config/*.txt)
 
+# For linting
+ALL_TXT += $(MAN1_TXT)
+ALL_TXT += $(MAN5_TXT)
+ALL_TXT += $(MAN7_TXT)
+ALL_TXT += $(HOWTO_TXT)
+ALL_TXT += $(INCLUDE_TARGETS_TXT)
+
 ifdef MAN_FILTER
 MAN_TXT = $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
 else
@@ -477,7 +485,11 @@ print-man1:
 	@for i in $(MAN1_TXT); do echo $$i; done
 
 lint-docs::
-	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl
+	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl \
+		--section=1 $(MAN1_TXT) \
+		--section=5 $(MAN5_TXT) \
+		--section=7 $(MAN7_TXT)	\
+		--to-lint $(ALL_TXT)
 
 ifeq ($(wildcard po/Makefile),po/Makefile)
 doc-l10n install-l10n::
diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index 35230875c24..d42f154e024 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -2,72 +2,68 @@
 
 use strict;
 use warnings;
-use File::Find;
-use Getopt::Long;
 
-my $basedir = ".";
-GetOptions("basedir=s" => \$basedir)
-	or die("Cannot parse command line arguments\n");
+# Parse arguments, a simple state machine for input like:
+#
+# --section=1 git.txt git-add.txt [...] --to-lint git-add.txt a-file.txt [...]
+my %TXT;
+my %SECTION;
+my $section;
+my $lint_these = 0;
+for my $arg (@ARGV) {
+	if (my ($sec) = $arg =~ /^--section=(\d+)$/s) {
+		$section = $sec;
+		next;
+	} elsif ($arg eq '--to-lint') {
+		$lint_these = 1;
+		next;
+	}
 
-my $found_errors = 0;
+	my ($name) = $arg =~ /^(.*?)\.txt$/s;
+	if ($lint_these) {
+		$TXT{$name} = $arg;
+		next;
+	}
 
-sub report {
-	my ($where, $what, $error) = @_;
-	print "$where: $error: $what\n";
-	$found_errors = 1;
+	$SECTION{$name} = $section;
 }
 
-sub grab_section {
-	my ($page) = @_;
-	open my $fh, "<", "$basedir/$page.txt";
-	my $firstline = <$fh>;
-	chomp $firstline;
-	close $fh;
-	my ($section) = ($firstline =~ /.*\((\d)\)$/);
-	return $section;
+my $exit_code = 0;
+sub report {
+	my ($pos, $line, $target, $msg) = @_;
+	substr($line, $pos) = "' <-- HERE";
+	$line =~ s/^\s+//;
+	print "$ARGV:$.: error: $target: $msg, shown with 'HERE' below:\n";
+	print "$ARGV:$.:\t$line\n";
+	$exit_code = 1;
 }
 
-sub lint {
-	my ($file) = @_;
-	open my $fh, "<", $file
-		or return;
-	while (<$fh>) {
-		my $where = "$file:$.";
-		while (s/linkgit:((.*?)\[(\d)\])//) {
-			my ($target, $page, $section) = ($1, $2, $3);
+@ARGV = sort values %TXT;
+while (<>) {
+	my $line = $_;
+	while ($line =~ m/linkgit:((.*?)\[(\d)\])/g) {
+		my $pos = pos $line;
+		my ($target, $page, $section) = ($1, $2, $3);
 
-			# De-AsciiDoc
-			$page =~ s/{litdd}/--/g;
+		# De-AsciiDoc
+		$page =~ s/{litdd}/--/g;
 
-			if ($page !~ /^git/) {
-				report($where, $target, "nongit link");
-				next;
-			}
-			if (! -f "$basedir/$page.txt") {
-				report($where, $target, "no such source");
-				next;
-			}
-			my $real_section = grab_section($page);
-			if ($real_section != $section) {
-				report($where, $target,
-					"wrong section (should be $real_section)");
-				next;
-			}
+		if (!exists $TXT{$page}) {
+			report($pos, $line, $target, "link outside of our own docs");
+			next;
+		}
+		if (!exists $SECTION{$page}) {
+			report($pos, $line, $target, "link outside of our sectioned docs");
+			next;
+		}
+		my $real_section = $SECTION{$page};
+		if ($section != $SECTION{$page}) {
+			report($pos, $line, $target, "wrong section (should be $real_section)");
+			next;
 		}
 	}
-	close $fh;
-}
-
-sub lint_it {
-	lint($File::Find::name) if -f && /\.txt$/;
-}
-
-if (!@ARGV) {
-	find({ wanted => \&lint_it, no_chdir => 1 }, $basedir);
-} else {
-	for (@ARGV) {
-		lint($_);
-	}
+	# this resets our $. for each file
+	close ARGV if eof;
 }
 
-exit $found_errors;
+exit $exit_code;
-- 
2.31.0.419.gfc6e4cae13

