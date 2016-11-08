Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176772022A
	for <e@80x24.org>; Tue,  8 Nov 2016 12:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933255AbcKHMMH (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 07:12:07 -0500
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:43138 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932503AbcKHMLw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 07:11:52 -0500
Received: (qmail 6958 invoked from network); 8 Nov 2016 12:11:50 -0000
Received: (qmail 9910 invoked from network); 8 Nov 2016 12:11:50 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Nov 2016 12:11:50 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 13/16] i18n: send-email: mark warnings and errors for translation
Date:   Tue,  8 Nov 2016 11:08:20 -0100
Message-Id: <20161108120823.11204-14-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.11.0.rc0.23.g8236252
In-Reply-To: <20161108120823.11204-1-vascomalmeida@sapo.pt>
References: <20161108120823.11204-1-vascomalmeida@sapo.pt>
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark warnings, errors and other messages for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-send-email.perl | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 78eb59b21..982c6c076 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -118,20 +118,20 @@ sub format_2822_time {
 	my $localmin = $localtm[1] + $localtm[2] * 60;
 	my $gmtmin = $gmttm[1] + $gmttm[2] * 60;
 	if ($localtm[0] != $gmttm[0]) {
-		die "local zone differs from GMT by a non-minute interval\n";
+		die __("local zone differs from GMT by a non-minute interval\n");
 	}
 	if ((($gmttm[6] + 1) % 7) == $localtm[6]) {
 		$localmin += 1440;
 	} elsif ((($gmttm[6] - 1) % 7) == $localtm[6]) {
 		$localmin -= 1440;
 	} elsif ($gmttm[6] != $localtm[6]) {
-		die "local time offset greater than or equal to 24 hours\n";
+		die __("local time offset greater than or equal to 24 hours\n");
 	}
 	my $offset = $localmin - $gmtmin;
 	my $offhour = $offset / 60;
 	my $offmin = abs($offset % 60);
 	if (abs($offhour) >= 24) {
-		die ("local time offset greater than or equal to 24 hours\n");
+		die __("local time offset greater than or equal to 24 hours\n");
 	}
 
 	return sprintf("%s, %2d %s %d %02d:%02d:%02d %s%02d%02d",
@@ -199,13 +199,13 @@ sub do_edit {
 		map {
 			system('sh', '-c', $editor.' "$@"', $editor, $_);
 			if (($? & 127) || ($? >> 8)) {
-				die("the editor exited uncleanly, aborting everything");
+				die(__("the editor exited uncleanly, aborting everything"));
 			}
 		} @_;
 	} else {
 		system('sh', '-c', $editor.' "$@"', $editor, @_);
 		if (($? & 127) || ($? >> 8)) {
-			die("the editor exited uncleanly, aborting everything");
+			die(__("the editor exited uncleanly, aborting everything"));
 		}
 	}
 }
@@ -299,7 +299,7 @@ my $help;
 my $rc = GetOptions("h" => \$help,
                     "dump-aliases" => \$dump_aliases);
 usage() unless $rc;
-die "--dump-aliases incompatible with other options\n"
+die __("--dump-aliases incompatible with other options\n")
     if !$help and $dump_aliases and @ARGV;
 $rc = GetOptions(
 		    "sender|from=s" => \$sender,
@@ -362,7 +362,7 @@ unless ($rc) {
     usage();
 }
 
-die "Cannot run git format-patch from outside a repository\n"
+die __("Cannot run git format-patch from outside a repository\n")
 	if $format_patch and not $repo;
 
 # Now, let's fill any that aren't set in with defaults:
@@ -617,7 +617,7 @@ while (defined(my $f = shift @ARGV)) {
 }
 
 if (@rev_list_opts) {
-	die "Cannot run git format-patch from outside a repository\n"
+	die __("Cannot run git format-patch from outside a repository\n")
 		unless $repo;
 	push @files, $repo->command('format-patch', '-o', tempdir(CLEANUP => 1), @rev_list_opts);
 }
@@ -638,7 +638,7 @@ if (@files) {
 		print $_,"\n" for (@files);
 	}
 } else {
-	print STDERR "\nNo patch files specified!\n\n";
+	print STDERR __("\nNo patch files specified!\n\n");
 	usage();
 }
 
@@ -730,7 +730,7 @@ EOT
 			$sender = $1;
 			next;
 		} elsif (/^(?:To|Cc|Bcc):/i) {
-			print "To/Cc/Bcc fields are not interpreted yet, they have been ignored\n";
+			print __("To/Cc/Bcc fields are not interpreted yet, they have been ignored\n");
 			next;
 		}
 		print $c2 $_;
@@ -739,7 +739,7 @@ EOT
 	close $c2;
 
 	if ($summary_empty) {
-		print "Summary email is empty, skipping it\n";
+		print __("Summary email is empty, skipping it\n");
 		$compose = -1;
 	}
 } elsif ($annotate) {
@@ -1314,7 +1314,7 @@ Message-Id: $message_id
 		$_ = ask(__("Send this email? ([y]es|[n]o|[q]uit|[a]ll): "),
 		         valid_re => qr/^(?:yes|y|no|n|quit|q|all|a)/i,
 		         default => $ask_default);
-		die "Send this email reply required" unless defined $_;
+		die __("Send this email reply required") unless defined $_;
 		if (/^n/i) {
 			return 0;
 		} elsif (/^q/i) {
@@ -1340,7 +1340,7 @@ Message-Id: $message_id
 	} else {
 
 		if (!defined $smtp_server) {
-			die "The required SMTP server is not properly defined."
+			die __("The required SMTP server is not properly defined.")
 		}
 
 		if ($smtp_encryption eq 'ssl') {
@@ -1425,10 +1425,10 @@ Message-Id: $message_id
 		}
 		print $header, "\n";
 		if ($smtp) {
-			print "Result: ", $smtp->code, ' ',
+			print __("Result: "), $smtp->code, ' ',
 				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
 		} else {
-			print "Result: OK\n";
+			print __("Result: OK\n");
 		}
 	}
 
@@ -1701,7 +1701,7 @@ sub apply_transfer_encoding {
 	$message = MIME::Base64::decode($message)
 		if ($from eq 'base64');
 
-	die "cannot send message as 7bit"
+	die __("cannot send message as 7bit")
 		if ($to eq '7bit' and $message =~ /[^[:ascii:]]/);
 	return $message
 		if ($to eq '7bit' or $to eq '8bit');
@@ -1709,7 +1709,7 @@ sub apply_transfer_encoding {
 		if ($to eq 'quoted-printable');
 	return MIME::Base64::encode($message, "\n")
 		if ($to eq 'base64');
-	die "invalid transfer encoding";
+	die __("invalid transfer encoding");
 }
 
 sub unique_email_list {
-- 
2.11.0.rc0.23.g8236252

