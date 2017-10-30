Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2650C202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 22:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbdJ3Wfs (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 18:35:48 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44467 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbdJ3Wfp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 18:35:45 -0400
Received: by mail-wr0-f196.google.com with SMTP id z55so14202340wrz.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0z3h223s2RZSSN9FVn6u3EzQAXb/RiUHRgWYruJfwW4=;
        b=mcBEFasR0IN/lJPa8LUpuqx5tki9FvORNkOW+flRXJPdzM/DlZpVlv8c2C4Ha9r9LR
         6XPeDYG1n0J8rRcjOB1fwNiN3u6jNftcVi64s4Q/WzQlSG+T2GhEZspCscD0B7Uvqfd0
         BSOec/CQHeW5vF5ASTL+vIqTGTvhJD7vS27UhXDhNbT1JJ//Iw8kgGfLdUMe0cHDcTv6
         8+AkmNvg11SmM/QEVqmeWVAFEgdWIglhgLdD1kwrsLKOl2HjPuwMr9WZbKiwL9679cCe
         6rVrJyaAhhJqhgOcQiKoRWsTTM9pcZEn02WZhffeg4CTciiqW3+XQTPlin9HpM6C4MUp
         NpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0z3h223s2RZSSN9FVn6u3EzQAXb/RiUHRgWYruJfwW4=;
        b=CbkLLLtzYO9b6QXDk4yjfkPRFhOGSudB26hMFb+XqWFyjOHl8JvH4ahySoH9WakPc4
         gMt0eMbNj2Qc/E3N6LDL/L5icwQqA2yLr/VSZZn3imsA9sf1kHSHqwMDmu63sZbaJYq9
         KTmgsZIKs1uRXxMOhWGxhO2FmwPB6068267SBgvJCzgHWN5qAGJ5s1m7yAje+E2EPHad
         Td3zzMfKly6zpJq/lhIR9bYTsB+y7Ziw2ODdid4J0ezL5L5MoizVGLC1l3YY6WlibmDw
         +wMeZPcRJG7DCRdxMlLG6w0nZOShxBBed60s6BfAHSUAbrfdmBSpNJPdeL+wR/pkQ8MP
         7LJQ==
X-Gm-Message-State: AMCzsaVbVPoZAMmdS1EKPraiU5gXRIXd7m7U7WP3se/STm9Kql8E+nNf
        SJDNwxNexi4hktyiqKJ2ysU0Ng==
X-Google-Smtp-Source: ABhQp+Tq5305hY33T6INk+WNnBQzXEJpR8dTlfyj4QLrvqYifCR6aPmJcv5LVnQJfiCC76GeIoTfgQ==
X-Received: by 10.223.156.138 with SMTP id d10mr9041678wre.214.1509402944300;
        Mon, 30 Oct 2017 15:35:44 -0700 (PDT)
Received: from localhost.localdomain (AMarseille-654-1-544-80.w92-158.abo.wanadoo.fr. [92.158.136.80])
        by smtp.gmail.com with ESMTPSA id k69sm353676wmg.45.2017.10.30.15.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 15:35:43 -0700 (PDT)
From:   Payre Nathan <second.payre@gmail.com>
X-Google-Original-From: Payre Nathan <nathan.payre@etu.univ-lyon1.fr>
To:     git@vger.kernel.org
Cc:     matthieu.moy@univ-lyon1.fr, timothee.albertin@etu.univ-lyon1.fr,
        daniel.bensoussan--bohm@etu.univ-lyon1.fr,
        Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH 2/2] send-email: quote-email quotes the message body
Date:   Mon, 30 Oct 2017 23:34:44 +0100
Message-Id: <20171030223444.5052-3-nathan.payre@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.14.1.731.g083517f57
In-Reply-To: <20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr>
References: <20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tom Russello <tom.russello@grenoble-inp.org>

---
 Documentation/git-send-email.txt |  4 +-
 git-send-email.perl              | 80 ++++++++++++++++++++++++++++++++++++++--
 t/t9001-send-email.sh            | 19 +++++++++-
 3 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 710b5ff32..329af66af 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -107,7 +107,9 @@ Only necessary if --compose is also set.  If --compose
 is not set, this will be prompted for.
 
 --quote-email=<email_file>::
-	Fill appropriately header fields for the reply to the given email.
+	Fill appropriately header fields for the reply to the given email and quote
+	the message body in the cover letter if `--compose` is set or otherwise
+	after the triple-dash in the first patch given.
 
 --subject=<string>::
 	Specify the initial subject of the email thread.
diff --git a/git-send-email.perl b/git-send-email.perl
index 665c47d15..6f6995c9d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,6 +26,7 @@ use Text::ParseWords;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catdir catfile);
+use File::Copy;
 use Error qw(:try);
 use Cwd qw(abs_path cwd);
 use Git;
@@ -57,7 +58,8 @@ git send-email --dump-aliases
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
-    --quote-email           <file> * Populate header fields appropriately.
+    --quote-email           <file> * Populate header fields appropriately and
+                                     quote the message body.
     --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
@@ -654,12 +656,15 @@ if (@files) {
 	usage();
 }
 
+my $message_quoted;
 if ($quote_email) {
 	my $error = validate_patch($quote_email);
 	die "fatal: $quote_email: $error\nwarning: no patches were sent\n"
 		if $error;
 
 	my @header = ();
+	my $date;
+	my $recipient;
 
 	open my $fh, "<", $quote_email or die "can't open file $quote_email";
 
@@ -691,7 +696,8 @@ if ($quote_email) {
 			}
 			$initial_subject = $prefix_re . $subject_re;
 		} elsif (/^From:\s+(.*)$/i) {
-			push @initial_to, $1;
+			$recipient = $1;
+			push @initial_to, $recipient;
 		} elsif (/^To:\s+(.*)$/i) {
 			foreach my $addr (parse_address_line($1)) {
 				if (!($addr eq $initial_sender)) {
@@ -713,9 +719,28 @@ if ($quote_email) {
 			$initial_reply_to = $1;
 		} elsif (/^References:\s+(.*)/i) {
 			$initial_references = $1;
+		} elsif (/^Date: (.*)/i) {
+			$date = $1;
 		}
 	}
 	$initial_references = $initial_references . $initial_reply_to;
+
+	my $tpl_date = $date && "On $date, " || '';
+	$message_quoted = $tpl_date . $recipient . " wrote:\n";
+
+	# Quote the message body
+	while (<$fh>) {
+		# Turn crlf line endings into lf-only
+		s/\r//g;
+		my $space = "";
+		if (/^[^>]/) {
+			$space = " ";
+		}
+		$message_quoted .= ">" . $space . $_;
+	}
+	if (!$compose) {
+		$annotate = 1;
+	}
 }
 
 sub get_patch_subject {
@@ -743,6 +768,9 @@ if ($compose) {
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_reply_to = $initial_reply_to || '';
+	my $tpl_quote = $message_quoted &&
+		"\nGIT: Please, trim down irrelevant sections in the quoted message\n".
+		"GIT: to keep your email concise.\n" . $message_quoted || '';
 
 	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
 From $tpl_sender # This line is ignored.
@@ -756,7 +784,7 @@ EOT2
 From: $tpl_sender
 Subject: $tpl_subject
 In-Reply-To: $tpl_reply_to
-
+$tpl_quote
 EOT3
 	for my $f (@files) {
 		print $c get_patch_subject($f);
@@ -821,9 +849,53 @@ EOT3
 		$compose = -1;
 	}
 } elsif ($annotate) {
-	do_edit(@files);
+	if ($quote_email) {
+		my $quote_email_filename = ($repo ?
+			tempfile(".gitsendemail.msg.XXXXXX",
+				DIR => $repo->repo_path()) :
+			tempfile(".gitsendemail.msg.XXXXXX",
+				DIR => "."))[1];
+
+		# Insertion in a temporary file to keep the original file clean
+		# in case of cancellation/error.
+		do_insert_quoted_message($quote_email_filename, $files[0]);
+
+		my $tmp = $files[0];
+		$files[0] = $quote_email_filename;
+
+		do_edit(@files);
+
+		# Erase the original patch if the edition went well
+		move($quote_email_filename, $tmp);
+		$files[0] = $tmp;
+	} else {
+		do_edit(@files);
+	}
 }
 
+sub do_insert_quoted_message {
+	my $tmp_file = shift;
+	my $original_file = shift;
+
+	open my $c, "<", $original_file
+	or die "Failed to open $original_file: " . $!;
+
+	open my $c2, ">", $tmp_file
+		or die "Failed to open $tmp_file: " . $!;
+
+	# Insertion after the triple-dash
+	while (<$c>) {
+		print $c2 $_;
+		last if (/^---$/);
+	}
+	print $c2 $message_quoted;
+	while (<$c>) {
+		print $c2 $_;
+	}
+
+	close $c;
+	close $c2;
+}
 sub ask {
 	my ($prompt, %arg) = @_;
 	my $valid_re = $arg{valid_re};
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ce12a1164..7c29c829d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1941,7 +1941,7 @@ test_expect_success $PREREQ 'Fields with --quote-email are correct' '
 		--quote-email=email \
 		--from="Example <nobody@example.com>" \
 		--smtp-server="$(pwd)/fake.sendmail" \
-		-1 \
+		-2 \
 		2>errors &&
 	grep "From: Example <nobody@example.com>" msgtxt1 &&
 	grep "In-Reply-To: <author_123456@example.com>" msgtxt1 &&
@@ -1961,6 +1961,17 @@ test_expect_success $PREREQ 'Fields with --quote-email are correct' '
 	echo "$ref_adr" | grep -v "References: <author_123456@example.com>"
 '
 
+test_expect_success $PREREQ 'correct quoted message with --quote-email' '
+	msg_quoted=$(grep -A 3 "^---$" msgtxt1) &&
+	echo "$msg_quoted" | grep "On Sat, 12 Jun 2010 15:53:58 +0200, author@example.com wrote:" &&
+	echo "$msg_quoted" | grep "> Have you seen my previous email?" &&
+	echo "$msg_quoted" | grep ">> Previous content"
+'
+
+test_expect_success $PREREQ 'second patch body is not modified by --quote-email' '
+	! grep "Have you seen my previous email?" msgtxt2
+'
+
 test_expect_success $PREREQ 'Fields with --quote-email and --compose are correct' '
 	clean_fake_sendmail &&
 	git send-email \
@@ -2000,4 +2011,10 @@ test_expect_success $PREREQ 'Re: written only once with --quote-email and --comp
 	grep "Subject: Re: subject goes here" msgtxt3
 '
 
+test_expect_success $PREREQ 'correct quoted message with --quote-email and --compose' '
+	grep "> On Sat, 12 Jun 2010 15:53:58 +0200, author@example.com wrote:" msgtxt3 &&
+	grep ">> Have you seen my previous email?" msgtxt3 &&
+	grep ">>> Previous content" msgtxt3
+'
+
 test_done
-- 
2.14.2

