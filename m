From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] send-email: Much readable error output
Date: Sat, 27 Dec 2014 17:09:37 +0600
Message-ID: <1419678577-19340-1-git-send-email-kuleshovmail@gmail.com>
References: <1419595599-19974-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 27 12:10:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4pG0-0000wf-E0
	for gcvg-git-2@plane.gmane.org; Sat, 27 Dec 2014 12:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbaL0LJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2014 06:09:59 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:37801 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbaL0LJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2014 06:09:49 -0500
Received: by mail-la0-f50.google.com with SMTP id pn19so9586641lab.37
        for <git@vger.kernel.org>; Sat, 27 Dec 2014 03:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N13WsCVV3WbMebn3FV6AsNFFE5KjqQ24RKP+rzsUb+A=;
        b=P7FGr5kvFkhjYRs8PTmbXP94hKYaDX9qe8neoBTXUtBJ0F6bO5sZEW5+obSALtQZZC
         RYQkiB9SmB0yazctDvyx4UAe7s0tvvL3OxG+8Dt0Y7JxbDPxfEId9Cq4aZnmraRz2TNU
         8sP+/qgZM3GeLO9Ohkc2RKartWPPS4AvSJEyeb/IX95phNdPtNDx8d382wSiC9W1AJ/3
         HOw/fgpnv7Umr9Pp4LMHs+X2SbH0m9FcnxFFVL8TO66Bc4shnlx1Lb12RnF7I1xe5/YD
         29HUcW1AO8gfkXyyx7pgd3nWbmMqqh91+qr/PSO7hSani/hLRuCTqSY49DXvUH80/UiP
         d+MQ==
X-Received: by 10.152.234.35 with SMTP id ub3mr47645794lac.70.1419678587611;
        Sat, 27 Dec 2014 03:09:47 -0800 (PST)
Received: from localhost.localdomain ([95.59.103.148])
        by mx.google.com with ESMTPSA id 1sm4792224lal.20.2014.12.27.03.09.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Dec 2014 03:09:46 -0800 (PST)
X-Mailer: git-send-email 2.2.1.202.g98acd41.dirty
In-Reply-To: <1419595599-19974-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261835>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 git-send-email.perl | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 82c6fea..eb02ef9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -38,7 +38,7 @@ sub new {
 }
 sub readline {
 	my $self = shift;
-	die "Cannot use readline on FakeTerm: $$self";
+	die "Cannot use readline on FakeTerm: $$self\n";
 }
 package main;
 
@@ -185,13 +185,13 @@ sub do_edit {
 		map {
 			system('sh', '-c', $editor.' "$@"', $editor, $_);
 			if (($? & 127) || ($? >> 8)) {
-				die("the editor exited uncleanly, aborting everything");
+				die("the editor exited uncleanly, aborting everything\n");
 			}
 		} @_;
 	} else {
 		system('sh', '-c', $editor.' "$@"', $editor, @_);
 		if (($? & 127) || ($? >> 8)) {
-			die("the editor exited uncleanly, aborting everything");
+			die("the editor exited uncleanly, aborting everything\n");
 		}
 	}
 }
@@ -546,7 +546,7 @@ while (defined(my $f = shift @ARGV)) {
 		@ARGV = ();
 	} elsif (-d $f and !is_format_patch_arg($f)) {
 		opendir my $dh, $f
-			or die "Failed to opendir $f: $!";
+			or die "Failed to opendir $f: $!\n";
 
 		push @files, grep { -f $_ } map { catfile($f, $_) }
 				sort readdir $dh;
@@ -591,7 +591,7 @@ sub get_patch_subject {
 		return "GIT: $1\n";
 	}
 	close $fh;
-	die "No subject line in $fn ?";
+	die "No subject line in $fn ?\n";
 }
 
 if ($compose) {
@@ -601,7 +601,7 @@ if ($compose) {
 		tempfile(".gitsendemail.msg.XXXXXX", DIR => $repo->repo_path()) :
 		tempfile(".gitsendemail.msg.XXXXXX", DIR => "."))[1];
 	open my $c, ">", $compose_filename
-		or die "Failed to open for writing $compose_filename: $!";
+		or die "Failed to open for writing $compose_filename: $!\n";
 
 
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
@@ -1205,7 +1205,7 @@ X-Mailer: git-send-email $gitversion
 		$_ = ask("Send this email? ([y]es|[n]o|[q]uit|[a]ll): ",
 		         valid_re => qr/^(?:yes|y|no|n|quit|q|all|a)/i,
 		         default => $ask_default);
-		die "Send this email reply required" unless defined $_;
+		die "Send this email reply required\n" unless defined $_;
 		if (/^n/i) {
 			return 0;
 		} elsif (/^q/i) {
@@ -1231,7 +1231,7 @@ X-Mailer: git-send-email $gitversion
 	} else {
 
 		if (!defined $smtp_server) {
-			die "The required SMTP server is not properly defined."
+			die "The required SMTP server is not properly defined.\n"
 		}
 
 		if ($smtp_encryption eq 'ssl') {
@@ -1274,11 +1274,11 @@ X-Mailer: git-send-email $gitversion
 		}
 
 		if (!$smtp) {
-			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
-			    "VALUES: server=$smtp_server ",
-			    "encryption=$smtp_encryption ",
-			    "hello=$smtp_domain",
-			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
+			die "Unable to initialize SMTP properly. Check config and use --smtp-debug.\n",
+			    "VALUES: server=$smtp_server\n\t",
+			    "encryption=$smtp_encryption\n\t",
+			    "hello=$smtp_domain\n\t",
+			    defined $smtp_server_port ? "port=$smtp_server_port\n" : "\n";
 		}
 
 		smtp_auth_maybe or die $smtp->message;
@@ -1321,7 +1321,7 @@ $subject = $initial_subject;
 $message_num = 0;
 
 foreach my $t (@files) {
-	open my $fh, "<", $t or die "can't open file $t";
+	open my $fh, "<", $t or die "can't open file $t\n";
 
 	my $author = undef;
 	my $sauthor = undef;
@@ -1543,7 +1543,7 @@ sub recipients_cmd {
 
 	my @addresses = ();
 	open my $fh, "-|", "$cmd \Q$file\E"
-	    or die "($prefix) Could not execute '$cmd'";
+	    or die "($prefix) Could not execute '$cmd'\n";
 	while (my $address = <$fh>) {
 		$address =~ s/^\s*//g;
 		$address =~ s/\s*$//g;
@@ -1554,7 +1554,7 @@ sub recipients_cmd {
 		       $what, $address, $cmd) unless $quiet;
 		}
 	close $fh
-	    or die "($prefix) failed to close pipe to '$cmd'";
+	    or die "($prefix) failed to close pipe to '$cmd'\n";
 	return @addresses;
 }
 
@@ -1581,7 +1581,7 @@ sub apply_transfer_encoding {
 	$message = MIME::Base64::decode($message)
 		if ($from eq 'base64');
 
-	die "cannot send message as 7bit"
+	die "cannot send message as 7bit\n"
 		if ($to eq '7bit' and $message =~ /[^[:ascii:]]/);
 	return $message
 		if ($to eq '7bit' or $to eq '8bit');
@@ -1589,7 +1589,7 @@ sub apply_transfer_encoding {
 		if ($to eq 'quoted-printable');
 	return MIME::Base64::encode($message, "\n")
 		if ($to eq 'base64');
-	die "invalid transfer encoding";
+	die "invalid transfer encoding\n";
 }
 
 sub unique_email_list {
-- 
2.2.1.202.g98acd41.dirty
