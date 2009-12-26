From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH] Smart-http documentation: add example of how to execute from userdir
Date: Sat, 26 Dec 2009 12:07:35 -0500
Message-ID: <1261847255-13970-1-git-send-email-tarmigan+git@gmail.com>
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 26 18:08:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOa83-0005Qh-6C
	for gcvg-git-2@lo.gmane.org; Sat, 26 Dec 2009 18:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbZLZRIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2009 12:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbZLZRIa
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 12:08:30 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:57105 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbZLZRI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 12:08:29 -0500
Received: by qyk30 with SMTP id 30so4337657qyk.33
        for <git@vger.kernel.org>; Sat, 26 Dec 2009 09:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=lQzmsLyf44x1eHCmCK+GSwiSeJhXQkQbzHVii62T8bM=;
        b=UrVHeTbohzDUu+CzVv3WS5NaIj/GlyzKkL7QNMN8xOoa9AWkRRHqfc0r40dh8P9Ss1
         KPgfUTwkO/GuHP6+byDguNI2fqwsx7Ywq0OlSW+ku4SW3V+kO2cG0IGBJ4fnLkGQTdKF
         Fo7bxG9dHH0YefRNh1KQDIg4xA16ikzh/lv1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=wrPFNBjFOnN8ZxK4gmQhOGB1xBxpecfTbzyoUVUqqH8ymy0sGxRy8ga3bCZyhVslyo
         3xOSbEJzLWnJsF4wSneh9bpqvwdsM11xYejaing2B4YImBAxjq0luFfAZ73a+bjZ4w0k
         LpDQwJcUu5SDeeFBF8SuVci7y2pE26fCcMGjc=
Received: by 10.224.84.197 with SMTP id k5mr587475qal.204.1261847308812;
        Sat, 26 Dec 2009 09:08:28 -0800 (PST)
Received: from localhost.localdomain (c-69-141-151-64.hsd1.nj.comcast.net [69.141.151.64])
        by mx.google.com with ESMTPS id 6sm27647064qwd.36.2009.12.26.09.08.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Dec 2009 09:08:28 -0800 (PST)
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135691>

Smart-http may be an attactive and easy way for people to setup git
hosting on shared servers whose primary web server configuration they
do not control.  To facilite this, provide an example of how it may be
done.

cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 Documentation/git-http-backend.txt |   40 ++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 67aec06..0cca5ba 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -60,8 +60,8 @@ automatically by the web server.
 
 EXAMPLES
 --------
-All of the following examples map 'http://$hostname/git/foo/bar.git'
-to '/var/www/git/foo/bar.git'.
+Unless otherwise noted, the following examples map
+'http://$hostname/git/foo/bar.git' to '/var/www/git/foo/bar.git'.
 
 Apache 2.x::
 	Ensure mod_cgi, mod_alias, and mod_env are enabled, set
@@ -144,6 +144,42 @@ ScriptAliasMatch \
 ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ----------------------------------------------------------------
 
+In the following example, a repository at
+'/home/$username/devel/foo/bar.git' will be accessible at
+'http://$hostname/\~$username/cgi-bin/git/foo/bar.git'
+
+From UserDir on Apache 2.x::
+       One way to configure 'git-http-backend' to execute and serve
+       from a user directory (for example, on a shared hosting
+       provider), is to have a symbolic link that points from the cgi
+       directory to the 'git-http-backend' executable in libexec.  The
+       advantage of the symblic link is that any updates to the
+       installed version of 'git-http-backend' also update the version
+       that is run in the userdir.  Depending on the configuration of
+       the server, the symbolic link may be able to point to a global
+       installation of git.  If, for security reasons, the server is
+       configured to follow symbolic links only if the owner matches,
+       an installation of git into the user directory may be required.
+       In that case, install git as that user into \~/bin, \~/libexec
+       etc.  Then create a symlink named 'git' in the cgi-bin
+       directory that points to
+       \~/libexec/git-core/git-http-backend. Put the following in
+       \~/public_html/cgi-bin/.htaccess:
++
+----------------------------------------------------------------
+SetHandler cgi-script
+Options +SymLinksIfOwnerMatch
+SetEnv GIT_PROJECT_ROOT /home/$username/devel
+----------------------------------------------------------------
++
+Also add any needed authentication to the .htaccess file as discussed
+in earlier examples.
++
+If the web server does not follow any symbolic links, the
+'git-http-backend' executable may be copied into the cgi-bin directory
+and renamed to 'git' to acheive the same effect, but it will also need
+to be manually updated whenever a new version of 'git-http-backend' is
+installed.
 
 ENVIRONMENT
 -----------
-- 
1.6.6
