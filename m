From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Add git version to gitweb output
Date: Tue, 20 Jun 2006 15:59:59 +0000 (UTC)
Message-ID: <11508191591838-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 20 17:59:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsidX-0001lf-A9
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 17:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWFTP70 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 11:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWFTP70
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 11:59:26 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:46544 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1751360AbWFTP7Z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 11:59:25 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5KFwxcN023738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Jun 2006 17:59:00 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5KFxJBY012405;
	Tue, 20 Jun 2006 17:59:19 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5KFxJpO012404;
	Tue, 20 Jun 2006 17:59:19 +0200
To: git@vger.kernel.org
Date: wto, 20 cze 2006 17:59:19 +0200
X-Mailer: git-send-email 1.3.0
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22209>

---

 gitweb/gitweb.cgi |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

09a68749cb29e1f0add3ac9859c11cd0924f70c7
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
