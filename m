From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 09/13] send-email: Remove horrible mix of tabs and spaces
Date: Mon, 13 Apr 2009 13:23:53 -0500
Message-ID: <1239647037-15381-10-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:36:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQzq-0003D7-Rx
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbZDMSdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbZDMSdc
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:33:32 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:14479 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbZDMSdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:33:31 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2241660wff.4
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TeT5ztSt6XzSRZNJ/cqj4jzJMkZAsZGsMKcwQSqIrXw=;
        b=Q7K+SkdC9XGfVEhJ+9NUCC8WhXoTDA1jEWHZ0pk5I8ZX+vL6P1UaVnn7Ym1kU9mdIj
         jc50hZ5RYP+3MCwBzQcdT6lvKgNaXBKbPyvAQM6/b5D3DigOHfO51J2QC32/0lUCwR7k
         lFCCAfp71l7fhtVVWUtt3tsXhkYUXveA/2HvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JilncmM9PxndbTaC03dB57+4Nj+VcYwc4VUpnnXyEKdoQ10/0wMR/VT7iS0d530Vhl
         Xqg3FD29OH4y0a/A5hzNqtLiWUTUxU9aIKlUVjnRBjxbOuevHo8++Znms/51GYNHL49K
         CReL0J6ZlOClL1OyBga4KCmUA5pbY+IDXq0rA=
Received: by 10.114.88.1 with SMTP id l1mr3294283wab.62.1239647610539;
        Mon, 13 Apr 2009 11:33:30 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.33.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:33:29 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116470>

For the most part, I ran a search for all the lines
that match:

    ^[\t]*[ ]+

and then I manually replaced the offending text with
an appropriate number of tabs.

While scanning through the file, I also tried to format
some of the code so as to obviate future mixing; I also
fixed one horrendously egregious section of code, where
someone was trying to be unnecessarily compact.

Currently, no lines match the following:

    [\t]+[ ]+
    [ ]+[\t]+

So, it should be reasonably clean.

The whole file is still horrendous.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |  273 ++++++++++++++++++++++++++++++---------------------
 1 files changed, 163 insertions(+), 110 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6b4b257..0ff72f6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -16,6 +16,9 @@
 #    and second line is the subject of the message.
 #
 
+# Please do not mix tabs spaces across lines that share a relationship
+# in terms of layout. Currently, all indentation is expected to use tabs.
+
 use strict;
 use warnings;
 use Term::ReadLine;
@@ -116,19 +119,20 @@ sub format_2822_time {
 		die ("local time offset greater than or equal to 24 hours\n");
 	}
 
-	return sprintf("%s, %2d %s %d %02d:%02d:%02d %s%02d%02d",
-		       qw(Sun Mon Tue Wed Thu Fri Sat)[$localtm[6]],
-		       $localtm[3],
-		       qw(Jan Feb Mar Apr May Jun
-			  Jul Aug Sep Oct Nov Dec)[$localtm[4]],
-		       $localtm[5]+1900,
-		       $localtm[2],
-		       $localtm[1],
-		       $localtm[0],
-		       ($offset >= 0) ? '+' : '-',
-		       abs($offhour),
-		       $offmin,
-		       );
+	return sprintf(
+		"%s, %2d %s %d %02d:%02d:%02d %s%02d%02d",
+		qw(Sun Mon Tue Wed Thu Fri Sat)[$localtm[6]],
+		$localtm[3],
+		qw(Jan Feb Mar Apr May Jun
+		Jul Aug Sep Oct Nov Dec)[$localtm[4]],
+		$localtm[5]+1900,
+		$localtm[2],
+		$localtm[1],
+		$localtm[0],
+		($offset >= 0) ? '+' : '-',
+		abs($offhour),
+		$offmin,
+	);
 }
 
 my $have_email_valid = eval { require Email::Valid; 1 };
@@ -192,29 +196,29 @@ my ($validate, $confirm);
 my (@suppress_cc);
 
 my %config_bool_settings = (
-    "thread" => [\$thread, 1],
-    "chainreplyto" => [\$chain_reply_to, 1],
-    "suppressfrom" => [\$suppress_from, undef],
-    "signedoffbycc" => [\$signed_off_by_cc, undef],
-    "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
-    "validate" => [\$validate, 1],
+	"thread" => [\$thread, 1],
+	"chainreplyto" => [\$chain_reply_to, 1],
+	"suppressfrom" => [\$suppress_from, undef],
+	"signedoffbycc" => [\$signed_off_by_cc, undef],
+	"signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
+	"validate" => [\$validate, 1],
 );
 
 my %config_settings = (
-    "smtpserver" => \$smtp_server,
-    "smtpserverport" => \$smtp_server_port,
-    "smtpuser" => \$smtp_authuser,
-    "smtppass" => \$smtp_authpass,
-    "to" => \@to,
-    "cc" => \@initial_cc,
-    "cccmd" => \$cc_cmd,
-    "aliasfiletype" => \$aliasfiletype,
-    "bcc" => \@bcclist,
-    "aliasesfile" => \@alias_files,
-    "suppresscc" => \@suppress_cc,
-    "envelopesender" => \$envelope_sender,
-    "multiedit" => \$multiedit,
-    "confirm"   => \$confirm,
+	"smtpserver" => \$smtp_server,
+	"smtpserverport" => \$smtp_server_port,
+	"smtpuser" => \$smtp_authuser,
+	"smtppass" => \$smtp_authpass,
+	"to" => \@to,
+	"cc" => \@initial_cc,
+	"cccmd" => \$cc_cmd,
+	"aliasfiletype" => \$aliasfiletype,
+	"bcc" => \@bcclist,
+	"aliasesfile" => \@alias_files,
+	"suppresscc" => \@suppress_cc,
+	"envelopesender" => \$envelope_sender,
+	"multiedit" => \$multiedit,
+	"confirm"   => \$confirm,
 );
 
 # Handle Uncouth Termination
@@ -245,37 +249,38 @@ $SIG{INT}  = \&signal_handler;
 # Begin by accumulating all the variables (defined above), that we will end up
 # needing, first, from the command line:
 
-my $rc = GetOptions("sender|from=s" => \$sender,
-                    "in-reply-to=s" => \$initial_reply_to,
-		    "subject=s" => \$initial_subject,
-		    "to=s" => \@to,
-		    "cc=s" => \@initial_cc,
-		    "bcc=s" => \@bcclist,
-		    "chain-reply-to!" => \$chain_reply_to,
-		    "smtp-server=s" => \$smtp_server,
-		    "smtp-server-port=s" => \$smtp_server_port,
-		    "smtp-user=s" => \$smtp_authuser,
-		    "smtp-pass:s" => \$smtp_authpass,
-		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
-		    "smtp-encryption=s" => \$smtp_encryption,
-		    "identity=s" => \$identity,
-		    "annotate" => \$annotate,
-		    "compose" => \$compose,
-		    "quiet" => \$quiet,
-		    "cc-cmd=s" => \$cc_cmd,
-		    "suppress-from!" => \$suppress_from,
-		    "suppress-cc=s" => \@suppress_cc,
-		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
-		    "confirm=s" => \$confirm,
-		    "dry-run" => \$dry_run,
-		    "envelope-sender=s" => \$envelope_sender,
-		    "thread!" => \$thread,
-		    "validate!" => \$validate,
-		    "format-patch!" => \$format_patch,
-	 );
+my $rc = GetOptions(
+	"sender|from=s" => \$sender,
+	"in-reply-to=s" => \$initial_reply_to,
+	"subject=s" => \$initial_subject,
+	"to=s" => \@to,
+	"cc=s" => \@initial_cc,
+	"bcc=s" => \@bcclist,
+	"chain-reply-to!" => \$chain_reply_to,
+	"smtp-server=s" => \$smtp_server,
+	"smtp-server-port=s" => \$smtp_server_port,
+	"smtp-user=s" => \$smtp_authuser,
+	"smtp-pass:s" => \$smtp_authpass,
+	"smtp-ssl" => sub { $smtp_encryption = 'ssl' },
+	"smtp-encryption=s" => \$smtp_encryption,
+	"identity=s" => \$identity,
+	"annotate" => \$annotate,
+	"compose" => \$compose,
+	"quiet" => \$quiet,
+	"cc-cmd=s" => \$cc_cmd,
+	"suppress-from!" => \$suppress_from,
+	"suppress-cc=s" => \@suppress_cc,
+	"signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
+	"confirm=s" => \$confirm,
+	"dry-run" => \$dry_run,
+	"envelope-sender=s" => \$envelope_sender,
+	"thread!" => \$thread,
+	"validate!" => \$validate,
+	"format-patch!" => \$format_patch,
+);
 
 unless ($rc) {
-    usage();
+	usage();
 }
 
 die "Cannot run git format-patch from outside a repository\n"
@@ -404,29 +409,55 @@ sub split_addrs {
 my %aliases;
 my %parse_alias = (
 	# multiline formats can be supported in the future
-	mutt => sub { my $fh = shift; while (<$fh>) {
-		if (/^\s*alias\s+(\S+)\s+(.*)$/) {
-			my ($alias, $addr) = ($1, $2);
-			$addr =~ s/#.*$//; # mutt allows # comments
-			 # commas delimit multiple addresses
-			$aliases{$alias} = [ split_addrs($addr) ];
-		}}},
-	mailrc => sub { my $fh = shift; while (<$fh>) {
-		if (/^alias\s+(\S+)\s+(.*)$/) {
-			# spaces delimit multiple addresses
-			$aliases{$1} = [ split(/\s+/, $2) ];
-		}}},
-	pine => sub { my $fh = shift; my $f='\t[^\t]*';
-	        for (my $x = ''; defined($x); $x = $_) {
+	mutt => sub {
+
+		my $fh = shift;
+
+		while (<$fh>) {
+			if (/^\s*alias\s+(\S+)\s+(.*)$/) {
+				my ($alias, $addr) = ($1, $2);
+				$addr =~ s/#.*$//; # mutt allows # comments
+				# commas delimit multiple addresses
+				$aliases{$alias} = [ split_addrs($addr) ];
+			}
+		}
+	},
+
+	mailrc => sub {
+
+		my $fh = shift;
+
+		while (<$fh>) {
+			if (/^alias\s+(\S+)\s+(.*)$/) {
+				# spaces delimit multiple addresses
+				$aliases{$1} = [ split(/\s+/, $2) ];
+			}
+		}
+	},
+
+	pine => sub {
+
+		my $fh = shift;
+		my $f='\t[^\t]*';
+
+		for (my $x = ''; defined($x); $x = $_) {
 			chomp $x;
-		        $x .= $1 while(defined($_ = <$fh>) && /^ +(.*)$/);
+			$x .= $1 while(defined($_ = <$fh>) && /^ +(.*)$/);
 			$x =~ /^(\S+)$f\t\(?([^\t]+?)\)?(:?$f){0,2}$/ or next;
 			$aliases{$1} = [ split_addrs($2) ];
-		}},
-	gnus => sub { my $fh = shift; while (<$fh>) {
-		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
-			$aliases{$1} = [ $2 ];
-		}}}
+		}
+	},
+
+	gnus => sub {
+
+		my $fh = shift;
+
+		while (<$fh>) {
+			if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
+				$aliases{$1} = [ $2 ];
+			}
+		}
+	}
 );
 
 if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
@@ -571,10 +602,11 @@ EOT
 		} elsif (/^\n$/) {
 			$in_body = 1;
 			if ($need_8bit_cte) {
-				print C2 "MIME-Version: 1.0\n",
-					 "Content-Type: text/plain; ",
-					   "charset=utf-8\n",
-					 "Content-Transfer-Encoding: 8bit\n";
+				print C2
+					"MIME-Version: 1.0\n",
+					"Content-Type: text/plain; ",
+					"charset=utf-8\n",
+					"Content-Transfer-Encoding: 8bit\n";
 			}
 		} elsif (/^MIME-Version:/i) {
 			$need_8bit_cte = 0;
@@ -583,8 +615,8 @@ EOT
 			my $subject = $initial_subject;
 			$_ = "Subject: " .
 				($subject =~ /[^[:ascii:]]/ ?
-				 quote_rfc2047($subject) :
-				 $subject) .
+				quote_rfc2047($subject) :
+				$subject) .
 				"\n";
 		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
 			$initial_reply_to = $1;
@@ -616,8 +648,10 @@ sub ask {
 	my $resp;
 	my $i = 0;
 	return defined $default ? $default : undef
-		unless defined $term->IN and defined fileno($term->IN) and
-		       defined $term->OUT and defined fileno($term->OUT);
+		unless defined $term->IN
+			and defined fileno($term->IN)
+			and defined $term->OUT
+			and defined fileno($term->OUT);
 	while ($i++ < 10) {
 		$resp = $term->readline($prompt);
 		if (!defined $resp) { # EOF
@@ -637,8 +671,12 @@ sub ask {
 my $prompting = 0;
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter || '';
-	$sender = ask("Who should the emails appear to be from? [$sender] ",
-	              default => $sender);
+
+	$sender = ask(
+		"Who should the emails appear to be from? [$sender] ",
+		default => $sender
+	);
+
 	print "Emails will be sent from: ", $sender, "\n";
 	$prompting++;
 }
@@ -666,7 +704,8 @@ sub expand_aliases {
 
 if ($thread && !defined $initial_reply_to && $prompting) {
 	$initial_reply_to = ask(
-		"Message-ID to be used as In-Reply-To for the first email? ");
+		"Message-ID to be used as In-Reply-To for the first email? "
+	);
 }
 if (defined $initial_reply_to) {
 	$initial_reply_to =~ s/^\s*<?//;
@@ -806,18 +845,22 @@ sub sanitize_address
 sub send_message
 {
 	my @recipients = unique_email_list(@to);
-	@cc = (grep { my $cc = extract_valid_address($_);
-		      not grep { $cc eq $_ } @recipients
-		    }
-	       map { sanitize_address($_) }
-	       @cc);
+
+	@cc = (grep
+		{
+			my $cc = extract_valid_address($_);
+			not grep { $cc eq $_ } @recipients
+		}
+		map { sanitize_address($_) } @cc
+	);
+
 	my $to = join (",\n\t", @recipients);
 	@recipients = unique_email_list(@recipients,@cc,@bcclist);
 	@recipients = (map { extract_valid_address($_) } @recipients);
 	my $date = format_2822_time($time++);
 	my $gitversion = '@@GIT_VERSION@@';
 	if ($gitversion =~ m/..GIT_VERSION../) {
-	    $gitversion = Git::version();
+		$gitversion = Git::version();
 	}
 
 	my $cc = join(", ", unique_email_list(@cc));
@@ -866,9 +909,13 @@ X-Mailer: git-send-email $gitversion
 			print "    To retain the current behavior, but squelch this message,\n";
 			print "    run 'git config --global sendemail.confirm auto'.\n\n";
 		}
-		$_ = ask("Send this email? ([y]es|[n]o|[q]uit|[a]ll): ",
-		         valid_re => qr/^(?:yes|y|no|n|quit|q|all|a)/i,
-		         default => $ask_default);
+
+		$_ = ask(
+			"Send this email? ([y]es|[n]o|[q]uit|[a]ll): ",
+			valid_re => qr/^(?:yes|y|no|n|quit|q|all|a)/i,
+			default => $ask_default
+		);
+
 		die "Send this email reply required" unless defined $_;
 		if (/^n/i) {
 			return 0;
@@ -903,9 +950,13 @@ X-Mailer: git-send-email $gitversion
 		}
 		else {
 			require Net::SMTP;
-			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
-						 ? "$smtp_server:$smtp_server_port"
-						 : $smtp_server);
+
+			$smtp ||= Net::SMTP->new(
+				(defined $smtp_server_port)
+					? "$smtp_server:$smtp_server_port"
+					: $smtp_server
+			);
+
 			if ($smtp_encryption eq 'tls') {
 				require Net::SMTP::SSL;
 				$smtp->command('STARTTLS');
@@ -1002,7 +1053,7 @@ foreach my $t (@files) {
 			chomp($header[$#header]);
 			s/^\s+/ /;
 			$header[$#header] .= $_;
-	    } else {
+		} else {
 			push(@header, $_);
 		}
 	}
@@ -1120,9 +1171,9 @@ foreach my $t (@files) {
 			}
 			else {
 				push @xh,
-				  'MIME-Version: 1.0',
-				  "Content-Type: text/plain; charset=$author_encoding",
-				  'Content-Transfer-Encoding: 8bit';
+					'MIME-Version: 1.0',
+					"Content-Type: text/plain; charset=$author_encoding",
+					'Content-Transfer-Encoding: 8bit';
 			}
 		}
 	}
@@ -1130,7 +1181,9 @@ foreach my $t (@files) {
 	$needs_confirm = (
 		$confirm eq "always" or
 		($confirm =~ /^(?:auto|cc)$/ && @cc) or
-		($confirm =~ /^(?:auto|compose)$/ && $compose && $message_num == 1));
+		($confirm =~ /^(?:auto|compose)$/ && $compose && $message_num == 1)
+	);
+
 	$needs_confirm = "inform" if ($needs_confirm && $confirm_unconfigured && @cc);
 
 	@cc = (@initial_cc, @cc);
-- 
1.6.2.2.479.g2aec
