From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] Add git version to gitweb output
Date: Wed, 21 Jun 2006 11:25:53 +0200
Message-ID: <1150881955505-git-send-email-jnareb@gmail.com>
References: <1150881954924-git-send-email-jnareb@gmail.com> <115088195576-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 21 11:26:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsyyM-0008Fb-F0
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 11:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWFUJ0D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 05:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWFUJ0B
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 05:26:01 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:62678 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932500AbWFUJZ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 05:25:58 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5L9PYRM013057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Jun 2006 11:25:34 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5L9Pts7006940;
	Wed, 21 Jun 2006 11:25:55 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5L9PthG006939;
	Wed, 21 Jun 2006 11:25:55 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <115088195576-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22247>

Add git-core binaries used version as the comment at the beginning of HTML
output, just below the comment with version of git web interface version.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>


---

 gitweb/gitweb.cgi |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

4434b02e9a56cf5d1939021b950bbe54240a413d
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 89224e6..87ec565 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -29,6 +29,14 @@ my $projectroot = "/home/kay/public_html
 # location of the git-core binaries
 my $gitbin = "/usr/bin";
 
+# version of the git-core binaries
+my $git_version = qx($gitbin/git --version);
+if ($git_version =~ m/git version (.*)$/) {
+	$git_version = $1;
+} else {
+	$git_version = "unknown";
+}
+
 # location for temporary files needed for diffs
 my $git_temp = "/tmp/gitweb";
 
@@ -288,11 +296,12 @@ sub git_header_html {
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
 <!-- git web interface v$version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
+<!-- git core binaries version $git_version -->
 <head>
 <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
 <meta name="robots" content="index, nofollow"/>
-<link rel="stylesheet" type="text/css" href="$stylesheet"/>
 <title>$title</title>
+<link rel="stylesheet" type="text/css" href="$stylesheet"/>
 $rss_link
 </head>
 <body>
@@ -816,7 +825,7 @@ sub git_get_project_config {
 	$key =~ s/^gitweb\.//;
 	return if ($key =~ m/\W/);
 
-	my $val = qx(git-repo-config --get gitweb.$key);
+	my $val = qx($gitbin/git-repo-config --get gitweb.$key);
 	return ($val);
 }
 
-- 
1.3.0
