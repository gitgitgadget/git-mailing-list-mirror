From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Tue, 29 Jan 2013 20:13:40 +0100
Message-ID: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 20:14:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Ge3-0007bS-2N
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 20:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab3A2TOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 14:14:38 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:37633 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542Ab3A2TOg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 14:14:36 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so562888wge.10
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 11:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=TFpg6jqu3GjmNkpdWSuE2lYZJ4w+3SP52cS6rUdPmsk=;
        b=m9J5zHaSK0nQ/uOZnlwNlTF3oxQY/WFqCcLAyRcJLcZ3TNhM6YCRB1buVvuwQmys1f
         8LIghldC2/VMIi4eHWdnlljO2XurWSNtNKv/LQx4iAD3EkY6kMJAK7aUlJrcCTBpWQ4C
         hJ6yf8KaeRpKFh6z8g7j+0uRH1pCgS3rswaLetHxRW2Gt4NmLLALcTxOcXJyEfSc89ub
         2W/GkLjwOyZdloXHNBoWmIHg0Ycu/IVy+MWcagM7sdZCbmmD7QtNQD5Ht7iFkRTqDyFU
         WdI1kzw13S2EoyxUGDfWkTpcsq90350kXGUa+BnhAc/t9G3Io4D4ZkOIXuNW+AiPs6A9
         8hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=TFpg6jqu3GjmNkpdWSuE2lYZJ4w+3SP52cS6rUdPmsk=;
        b=hKQQH7NB21J9I5rI6vrMwErMgUs9qIjuS4JA1kNZQ2Qg8iwIPJdq8O5qiEpWBAW9mM
         gfyb+2fkmHcxFS2Pme11McmPQdTZo1ILsyJVaizX3GCxkrSZdK3RQ3TtR3HhKoDDlraB
         +RWaluqYmnUQyxZkXvxrRc8DsOZDaDTpHHcgQStfE2S8DJSqmfL/uRqELGlcok9j65fj
         Hp1quw9t5RmfUnz9tB/CUWAgRGE6UU5YxJVXP18553sVox49HRZAZB2voeTa+lQy7lvJ
         WJaiB0vrMvuMTc2s2eL6cYm3HuQMSGE7AuXQi8uXPSeFepjxnjYUVul365lRkLd+hN2j
         JYwQ==
X-Received: by 10.194.238.5 with SMTP id vg5mr4435340wjc.40.1359486874935;
        Tue, 29 Jan 2013 11:14:34 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:11cb:a088:c857:76de])
        by mx.google.com with ESMTPS id bd7sm5177450wib.8.2013.01.29.11.14.32
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 11:14:34 -0800 (PST)
X-Mailer: git-send-email 1.8.1
X-Gm-Message-State: ALoCoQlQX0W74L14cx6uMQut13ccuzBw9eH2HHj6Yg6u9TZBsGVczPedCj6VGOFoTrxscRj7Sa3AFc4FOA1Z4n1E1myKoN8HMumWeloSOUwE5rIIcnNUm/xgu4KG12Z5qqIt/jrmZ8lwDeCVnXxvx7KlYVnKPnv8dluEKIaSJOgD7aBgmnKOhOHhYuDofszJfT8tI4Md+KpgYedPkoSAFS/BBoHxgj9W/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214958>

From: Michal Nazarewicz <mina86@mina86.com>

Make git-send-email read password from a ~/.authinfo file instead of
requiring it to be stored in git configuration, passed as command line
argument or typed in.

There are various other applications that use this file for
authentication information so letting users use it for git-send-email
is convinient.  Furthermore, some users store their ~/.gitconfig file
in a public repository and having to store password there makes it
easy to publish the password.

Not to introduce any new dependencies, ~/.authinfo file is parsed only
if Text::CSV Perl module is installed.  If it's not, a notification is
printed and the file is ignored.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 Documentation/git-send-email.txt | 15 +++++++--
 git-send-email.perl              | 69 +++++++++++++++++++++++++++++++++-------
 2 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index eeb561c..b83576e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -158,14 +158,25 @@ Sending
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
 	argument is specified, then the empty string is used as
-	the password. Default is the value of 'sendemail.smtppass',
-	however '--smtp-pass' always overrides this value.
+	the password. Default is the value of 'sendemail.smtppass'
+	or value read from '~/.authinfo' file, however '--smtp-pass'
+	always overrides this value.
 +
 Furthermore, passwords need not be specified in configuration files
 or on the command line. If a username has been specified (with
 '--smtp-user' or a 'sendemail.smtpuser'), but no password has been
 specified (with '--smtp-pass' or 'sendemail.smtppass'), then the
 user is prompted for a password while the input is masked for privacy.
++
+The '~/.authinfo' file is read if Text::CSV Perl module is installed
+on the system; if it's missing, a notification message will be printed
+and the file ignored altogether.  The file should contain a line with
+the following format:
++
+  machine <domain> port <port> login <user> password <pass>
++
+Contrary to other tools, 'git-send-email' does not support symbolic
+port names like 'imap' thus `<port>` must be a number.
 
 --smtp-server=<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
diff --git a/git-send-email.perl b/git-send-email.perl
index be809e5..d824098 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1045,6 +1045,62 @@ sub maildomain {
 	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
 }
 
+
+sub read_password_from_stdin {
+	my $line;
+
+	system "stty -echo";
+
+	do {
+		print "Password: ";
+		$line = <STDIN>;
+		print "\n";
+	} while (!defined $line);
+
+	system "stty echo";
+
+	chomp $line;
+	return $line;
+}
+
+sub read_password_from_authinfo {
+	my $fd;
+	if (!open $fd, '<', $ENV{'HOME'} . '/.authinfo') {
+		return;
+	}
+
+	if (!eval { require Text::CSV; 1 }) {
+		print STDERR "Text::CSV missing, won't read ~/.authinfo\n";
+		close $fd;
+		return;
+	}
+
+	my $csv = Text::CSV->new( { sep_char => ' ' } );
+	my $password;
+	while (my $line = <$fd>) {
+		chomp $line;
+		$csv->parse($line);
+		my %row = $csv->fields();
+		if (defined $row{'machine'} &&
+		    defined $row{'login'} &&
+		    defined $row{'port'} &&
+		    defined $row{'password'} &&
+		    $row{'machine'} eq $smtp_server &&
+		    $row{'login'} eq $smtp_authuser &&
+		    $row{'port'} eq $smtp_server_port) {
+			$password = $row{'password'};
+			last;
+		}
+	}
+
+	close $fd;
+	return $password;
+}
+
+sub read_password {
+	return read_password_from_authinfo || read_password_from_stdin;
+}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -1194,18 +1250,7 @@ X-Mailer: git-send-email $gitversion
 			};
 
 			if (!defined $smtp_authpass) {
-
-				system "stty -echo";
-
-				do {
-					print "Password: ";
-					$_ = <STDIN>;
-					print "\n";
-				} while (!defined $_);
-
-				chomp($smtp_authpass = $_);
-
-				system "stty echo";
+				$smtp_authpass = read_password
 			}
 
 			$auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
-- 
1.8.1
