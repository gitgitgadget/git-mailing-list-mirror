From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/4] gitweb: Change parse_commits signature to allow for multiple options
Date: Tue, 26 Feb 2008 13:22:06 +0100
Message-ID: <1204028528-18941-3-git-send-email-jnareb@gmail.com>
References: <1204028528-18941-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 13:23:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTyqN-000223-CA
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 13:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbYBZMW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 07:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYBZMW2
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 07:22:28 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:55675 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbYBZMW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 07:22:26 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2857234fkz.5
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 04:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RvPaplffLTciVWfj1Ep+vYLRAkzLPRX/7jjpPXDwyjs=;
        b=D/BS8P4H6tliTFbQYtPYrWOOIAkoBgR7G6EJCYOLGLRHYviH9wFJ9Z2GnCXs9HEnyJq9IcFONVcBUDFnRPwebTzK/C8r+imGeBc4yhLtvR4blIFCPmHDu67mMk10NZNKtJk8Q87G4AS577W8DEp2uZbawDfHj6FFhFmDSaG1Ne8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lYs2RSyaQE49qoVUY0F7YaIFPiBwgeYTc5G4XCs/SS8Gf3uDv1HKmix8DoWfInC0TVKOqpO8BJSaUO/8eWrDiLIhPplk5BhHZEZUugczbieqaViRgJNMH3phyoF/a4OUQXXyNqIW10E+/3dyKkd0D8FNj6uPDeYMYbkjDbULFao=
Received: by 10.82.126.5 with SMTP id y5mr8639686buc.37.1204028545804;
        Tue, 26 Feb 2008 04:22:25 -0800 (PST)
Received: from localhost.localdomain ( [83.8.218.226])
        by mx.google.com with ESMTPS id b36sm10964128ika.2.2008.02.26.04.22.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Feb 2008 04:22:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1QCMBqR018968;
	Tue, 26 Feb 2008 13:22:11 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1QCMAPw018967;
	Tue, 26 Feb 2008 13:22:10 +0100
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1204028528-18941-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75129>

Change order of parameters in parse_commits() to have $filename
before @args (extra options), to allow for multiple extra options,
for example both '--grep=<pattern>' and '--fixed-strings'.

Change all callers to follow new calling convention.

This is part of commit b98f0a7c in http://repo.or.cz/git/gitweb.git
  gitweb: Clearly distinguish regexp / exact match searches
by Petr "Pasky" Baudis.

Signed-off-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The paragraph starting with "This is part of commit..." can be now,
I think, safely removed, as the rest of mentioned commit is now fourth
(last) part of this patch series.


BTW. I'm not quite sure about authorship and DCO (signoff) for this
patch. It was a part of commit by pasky, but this commit was not
written by him. I have written it based on parts of mentioned commit,
following variable naming and such; therefore I assumed authorship for
this commit.

Original commit was signed off by pasky, and IMHO this signoff applies
also to the part of it, therefore I have used also pasky signoff.


 gitweb/gitweb.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fc95e2c..3b4b15a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2079,7 +2079,7 @@ sub parse_commit {
 }
 
 sub parse_commits {
-	my ($commit_id, $maxcount, $skip, $arg, $filename) = @_;
+	my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
 	my @cos;
 
 	$maxcount ||= 1;
@@ -2089,7 +2089,7 @@ sub parse_commits {
 
 	open my $fd, "-|", git_cmd(), "rev-list",
 		"--header",
-		($arg ? ($arg) : ()),
+		@args,
 		("--max-count=" . $maxcount),
 		("--skip=" . $skip),
 		@extra_options,
@@ -5172,7 +5172,7 @@ sub git_history {
 		$ftype = git_get_type($hash);
 	}
 
-	my @commitlist = parse_commits($hash_base, 101, (100 * $page), "--full-history", $file_name);
+	my @commitlist = parse_commits($hash_base, 101, (100 * $page), $file_name, "--full-history");
 
 	my $paging_nav = '';
 	if ($page > 0) {
@@ -5255,7 +5255,7 @@ sub git_search {
 			$greptype = "--committer=";
 		}
 		$greptype .= $search_regexp;
-		my @commitlist = parse_commits($hash, 101, (100 * $page), $greptype);
+		my @commitlist = parse_commits($hash, 101, (100 * $page), undef, $greptype);
 
 		my $paging_nav = '';
 		if ($page > 0) {
@@ -5507,7 +5507,7 @@ sub git_feed {
 
 	# log/feed of current (HEAD) branch, log of given branch, history of file/directory
 	my $head = $hash || 'HEAD';
-	my @commitlist = parse_commits($head, 150, 0, undef, $file_name);
+	my @commitlist = parse_commits($head, 150, 0, $file_name);
 
 	my %latest_commit;
 	my %latest_date;
-- 
1.5.4.2
