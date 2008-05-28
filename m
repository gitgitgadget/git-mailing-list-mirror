From: "John J. Franey" <jjfraney@gmail.com>
Subject: [DOC-PATCH] Clarify description of <repository> argument to
	pull/fetch for naming remotes.
Date: Wed, 28 May 2008 10:59:34 -0400
Message-ID: <1211986774.9160.12.camel@isidore.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 28 17:00:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1N8g-0004dt-Dd
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 17:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbYE1O7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 10:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbYE1O7h
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 10:59:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:26200 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbYE1O7h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 10:59:37 -0400
Received: by wx-out-0506.google.com with SMTP id h29so2321449wxd.4
        for <git@vger.kernel.org>; Wed, 28 May 2008 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=tydiQz8ROJmWbdqTVgfikqTX52y3SO8bJlMSGnqq5uM=;
        b=s+IO5hnq85fhAAxSJbPkx0vzo7fPHLCGzC5Xfi5T0E7mqyagRjPXYxm6X5kmqg3wI2An87PPScBQIRJeEkA4kXZuhJ61tRSx7T8C3Lln9PBP8jIu/WkIg6D9JjLHvMtpKtP5LofYEvu9gc/5s/0DiZGcOlGIl7+2C735f74yxbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=odgbNIcHzGBE+lKwFEUSAcTJs1vw+x4CnLugbRjUGFH0aOyNN5RB1NcG8hgngVvZ1Kox+4ZET563VRggfQmFat3+QOoZO3wb6m6Zx7tILCKC797vrIBjYWaGr4MsI1eVX2qqwWOCVHW2rB7WGlDVInmUJjxw81E0d27m4ZcciXo=
Received: by 10.70.33.8 with SMTP id g8mr3387325wxg.27.1211986775926;
        Wed, 28 May 2008 07:59:35 -0700 (PDT)
Received: from ?192.168.2.102? ( [70.21.168.140])
        by mx.google.com with ESMTPS id h37sm28819583wxd.35.2008.05.28.07.59.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 May 2008 07:59:35 -0700 (PDT)
X-Mailer: Evolution 2.22.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83097>



Signed-off-by: John J. Franey <jjfraney@gmail.com>
---
 Here is proposal for the git-fetch(1) and git-pull(1)
 man pages.  As a newbie, I found the original a bit
 too awkward to understand readily.  I hope this is
 helpful.

 Alter description of <repository> in OPTIONS section to
 explicitly state that a 'remote name' is accepted.

 Rewrite REMOTES section to more directly identify the
 different kinds of remotes permitted.

 Documentation/pull-fetch-param.txt |    4 ++-
 Documentation/urls-remotes.txt     |   65 ++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index b6eb7fc..cbee369 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -1,6 +1,8 @@
 <repository>::
 	The "remote" repository that is the source of a fetch
-	or pull operation.  See the section <<URLS,GIT URLS>> below.
+	or pull operation.  This parameter can be either a URL
+	(see the section <<URLS,GIT URLS>> below) or the name
+	of a remote (see the section <<REMOTES,REMOTES>> below).
 
 <refspec>::
 	The canonical format of a <refspec> parameter is
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index 5dd1f83..31e542d 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -1,11 +1,21 @@
 include::urls.txt[]
 
-REMOTES
--------
+REMOTES[[REMOTES]]
+------------------
 
-In addition to the above, as a short-hand, the name of a
-file in `$GIT_DIR/remotes` directory can be given; the
-named file should be in the following format:
+The name of one of the following can be used instead of a URL as <repository> argument:
+
+* a file in the `$GIT_DIR/remotes` directory,
+* a remote in the git configuration file: `$GIT_DIR/config`, or
+* a file in the `$GIT_DIR/branches` directory.
+
+
+
+Named files in `$GIT_DIR/remotes`
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If <repository> is the name of a file in the `$GIT_DIR/remotes` directory,
+the file should have the following format:
 
 ------------
 	URL: one of the above URL format
@@ -14,15 +24,16 @@ named file should be in the following format:
 
 ------------
 
-Then such a short-hand is specified in place of
-<repository> without <refspec> parameters on the command
-line, <refspec> specified on `Push:` lines or `Pull:`
-lines are used for `git-push` and `git-fetch`/`git-pull`,
-respectively.  Multiple `Push:` and `Pull:` lines may
+`Push:` lines are used by `git-push` and
+`Pull:` lines are used by `git-pull` and `git-fetch`.
+Multiple `Push:` and `Pull:` lines may
 be specified for additional branch mappings.
 
-Or, equivalently, in the `$GIT_DIR/config` (note the use
-of `fetch` instead of `Pull:`):
+Named remote in configuration file
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If <repository> is the name of a remote entry in the git configuration file,
+the entry might look like this:
 
 ------------
 	[remote "<remote>"]
@@ -32,24 +43,22 @@ of `fetch` instead of `Pull:`):
 
 ------------
 
-The name of a file in `$GIT_DIR/branches` directory can be
-specified as an older notation short-hand; the named
-file should contain a single line, a URL in one of the
-above formats, optionally followed by a hash `#` and the
-name of remote head (URL fragment notation).
-`$GIT_DIR/branches/<remote>` file that stores a <url>
-without the fragment is equivalent to have this in the
-corresponding file in the `$GIT_DIR/remotes/` directory.
+Note the use of `fetch` instead of `Pull:` (a distinction from the format described above).
+See linkgit:git-remote[1] or linkgit:git-config[1] for details.
 
-------------
-	URL: <url>
-	Pull: refs/heads/master:<remote>
-
-------------
+Named file in `$GIT_DIR/branches`
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-while having `<url>#<head>` is equivalent to
+If <repository> is the name of a file in the `$GIT_DIR/branches` directory,
+the file should have the following format,
+on a single line:
 
 ------------
-	URL: <url>
-	Pull: refs/heads/<head>:<remote>
+	<url>#<head>
 ------------
+
+This line contains a URL in one of the above formats,
+optionally followed by a hash `#` and the
+name of remote head (URL fragment notation).
+'master' is default in case the hash and remote head are omitted.
+
-- 
1.5.4.3
