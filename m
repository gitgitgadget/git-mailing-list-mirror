From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 9/9] git-svn: 0.9.1: add --version and copyright/license (GPL v2+) information
Date: Mon, 20 Feb 2006 10:57:29 -0800
Message-ID: <11404618492226-git-send-email-normalperson@yhbt.net>
References: <11404618491275-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 19:58:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBGEP-0001UO-Kv
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 19:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWBTS5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 13:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWBTS5f
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 13:57:35 -0500
Received: from hand.yhbt.net ([66.150.188.102]:61371 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932638AbWBTS5a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 13:57:30 -0500
Received: from untitled (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A07B77DC005;
	Mon, 20 Feb 2006 10:57:29 -0800 (PST)
In-Reply-To: <11404618491275-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16496>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

372473c658e9f48323430af003f8a1a887989edf
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 3a59454..a32ce15 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -1,4 +1,6 @@
 #!/usr/bin/env perl
+# Copyright (C) 2006, Eric Wong <normalperson@yhbt.net>
+# License: GPL v2 or later
 use warnings;
 use strict;
 use vars qw/	$AUTHOR $VERSION
@@ -6,7 +8,7 @@ use vars qw/	$AUTHOR $VERSION
 		$GIT_SVN_INDEX $GIT_SVN
 		$GIT_DIR $REV_DIR/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
-$VERSION = '0.9.0';
+$VERSION = '0.9.1';
 $GIT_DIR = $ENV{GIT_DIR} || "$ENV{PWD}/.git";
 $GIT_SVN = $ENV{GIT_SVN_ID} || 'git-svn';
 $GIT_SVN_INDEX = "$GIT_DIR/$GIT_SVN/index";
@@ -31,7 +33,7 @@ use File::Spec qw//;
 my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{6,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
-	$_find_copies_harder, $_l);
+	$_find_copies_harder, $_l, $_version);
 
 GetOptions(	'revision|r=s' => \$_revision,
 		'no-ignore-externals' => \$_no_ignore_ext,
@@ -41,6 +43,7 @@ GetOptions(	'revision|r=s' => \$_revisio
 		'help|H|h' => \$_help,
 		'find-copies-harder' => \$_find_copies_harder,
 		'l=i' => \$_l,
+		'version|V' => \$_version,
 		'no-stop-on-copy' => \$_no_stop_copy );
 my %cmd = (
 	fetch => [ \&fetch, "Download new revisions from SVN" ],
@@ -66,6 +69,7 @@ foreach (keys %cmd) {
 	}
 }
 usage(0) if $_help;
+version() if $_version;
 usage(1) unless (defined $cmd);
 svn_check_ignore_externals();
 $cmd{$cmd}->[0]->(@ARGV);
@@ -91,6 +95,11 @@ and want to keep them separate.
 	exit $exit;
 }
 
+sub version {
+	print "git-svn version $VERSION\n";
+	exit 0;
+}
+
 sub rebuild {
 	$SVN_URL = shift or undef;
 	my $repo_uuid;
-- 
1.2.0.gdee6
