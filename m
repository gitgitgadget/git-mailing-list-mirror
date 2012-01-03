From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Wed, 04 Jan 2012 00:24:57 +0100
Message-ID: <4F038E49.9080809@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de> <7vzke4ve
 bl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 00:25:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiDj6-0001ax-HZ
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 00:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399Ab2ACXY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 18:24:59 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:35942 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754087Ab2ACXY6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2012 18:24:58 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 025C823A46;
	Wed,  4 Jan 2012 00:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=4TJf+v6SL6PQ+K0YORcib1TlWis=; b=Dk+N9fDX4JU1lIsRDAT7I2B7zEcN
	xhDHilLd4MFEL5F0HvyBLkPpSqLrgnJkhinvSjjZSqxQLY7p/L3FwVGjYWwIsx3x
	2s9WbykeJ0VLdgPgB8C4NRDkb/6OOdfJQWrsaS3gHiRClvMss5jNMMg4buozZ8PH
	BsiMqKQCZ/KBf6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=SBjjL/BpK86cW3JN8mhjkgkq+W97y1CdHCzSWyaScbLBSWbAK88rRwR
	gY4/RL6Vo9QpxMu7cA1mxAyKE/u/cRXjtuGUCrirXBhwvw2adKZFAbgdubXC3VPT
	Q2SydHN2iAprxMeM0cE1tX7wA68wQM+B+ULcDGuCFjQQ9hlKF2Bs=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id A750423A36;
	Wed,  4 Jan 2012 00:24:55 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25662966; Wed, 04 Jan 2012 00:24:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vzke4vebl.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187903>

git-svn reads usernames and other user queries from an interactive
terminal. This cause GUIs (w/o STDIN connected) to hang waiting forever
for git-svn to complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).
git-core already asks for username using *_ASKPASS tools, this commit
also enables git-svn to do so.

This change extends the Git::prompt method, so that it can also be used
for non password queries (e.g. usernames), and makes use of it instead
of using hand-rolled prompt-response code that only works with the
interactive terminal.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 git-svn.perl |   19 ++++++++-----------
 perl/Git.pm  |   27 ++++++++++++++++-----------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ade88ae..be713f5 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4356,17 +4356,16 @@ sub ssl_server_trust {
 	        map $cert_info->$_, qw(hostname valid_from valid_until
 	                               issuer_dname fingerprint);
 	my $choice;
-prompt:
-	print STDERR $may_save ?
+	my $options = $may_save ?
 	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
 	      "(R)eject or accept (t)emporarily? ";
-	STDERR->flush;
-	$choice = lc(substr(<STDIN> || 'R', 0, 1));
-	if ($choice =~ /^t$/i) {
+prompt:
+	$choice = lc(substr(Git::prompt($options) || 'R', 0, 1));
+	if ($choice eq 't') {
 		$cred->may_save(undef);
-	} elsif ($choice =~ /^r$/i) {
+	} elsif ($choice eq 'r') {
 		return -1;
-	} elsif ($may_save && $choice =~ /^p$/i) {
+	} elsif ($may_save && $choice eq 'p') {
 		$cred->may_save($may_save);
 	} else {
 		goto prompt;
@@ -4404,9 +4403,7 @@ sub username {
 	if (defined $_username) {
 		$username = $_username;
 	} else {
-		print STDERR "Username: ";
-		STDERR->flush;
-		chomp($username = <STDIN>);
+		$username = Git::prompt("Username: ");
 	}
 	$cred->username($username);
 	$cred->may_save($may_save);
@@ -4415,7 +4412,7 @@ sub username {

 sub _read_password {
 	my ($prompt, $realm) = @_;
-	my $password = Git::prompt($prompt);
+	my $password = Git::prompt($prompt, 1);
 	$password;
 }

diff --git a/perl/Git.pm b/perl/Git.pm
index 46f11a8..33e68c4 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -512,18 +512,19 @@ C<git --html-path>). Useful mostly only internally.
 sub html_path { command_oneline('--html-path') }


-=item prompt ( PROMPT )
+=item prompt ( PROMPT , ISPASSWORD )

 Query user C<PROMPT> and return answer from user.

 If an external helper is specified via GIT_ASKPASS or SSH_ASKPASS, it
 is used to interact with the user; otherwise the prompt is given to
 and the answer is read from the terminal.
+If C<ISPASSWORD> is true, the terminal disables echo.

 =cut

 sub prompt {
-	my ($prompt) = @_;
+	my ($prompt, $isPassword) = @_;
 	my $ret;
 	if (!defined $ret) {
 		$ret = _prompt($ENV{'GIT_ASKPASS'}, $prompt);
@@ -532,18 +533,22 @@ sub prompt {
 		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
 	}
 	if (!defined $ret) {
-		$ret = '';
 		print STDERR $prompt;
 		STDERR->flush;
-		require Term::ReadKey;
-		Term::ReadKey::ReadMode('noecho');
-		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
-			last if $key =~ /[\012\015]/; # \n\r
-			$ret .= $key;
+		if ($isPassword) {
+			$ret = '';
+			require Term::ReadKey;
+			Term::ReadKey::ReadMode('noecho');
+			while (defined(my $key = Term::ReadKey::ReadKey(0))) {
+				last if $key =~ /[\012\015]/; # \n\r
+				$ret .= $key;
+			}
+			Term::ReadKey::ReadMode('restore');
+			print STDERR "\n";
+			STDERR->flush;
+		} else {
+			chomp($ret = <STDIN>);
 		}
-		Term::ReadKey::ReadMode('restore');
-		print STDERR "\n";
-		STDERR->flush;
 	}
 	return $ret;
 }
-- 
1.7.8.msysgit.0
