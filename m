From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/3] The "curl" executable is no longer required
Date: Sun, 15 Jun 2008 12:16:01 +0200
Message-ID: <200806151216.01886.johan@herland.net>
References: <200806120920.31161.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 12:17:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7pJ6-00048b-Q6
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 12:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029AbYFOKRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 06:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754197AbYFOKRA
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 06:17:00 -0400
Received: from smtp.getmail.no ([84.208.20.33]:62359 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761AbYFOKRA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 06:17:00 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2I0080Z1WBY300@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 12:16:59 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00LQO1UQKK90@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 12:16:02 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00IHA1UPQTH0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 12:16:02 +0200 (CEST)
In-reply-to: <200806120920.31161.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85076>

git-clone.sh was the last user of the "curl" executable. Relevant git
commands now use libcurl instead. This should be reflected in the
install requirements.

Signed-off-by: Johan Herland <johan@herland.net>
---

I haven't tested the RPM spec change, but it seems fairly straightforward...

 INSTALL     |    8 ++++----
 git.spec.in |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/INSTALL b/INSTALL
index 9888f25..4a4e13f 100644
--- a/INSTALL
+++ b/INSTALL
@@ -67,10 +67,10 @@ Issues of note:
 	  that come with git (git includes the one from Mozilla, and has
 	  its own PowerPC and ARM optimized ones too - see the Makefile).
 
-	- "libcurl" and "curl" executable.  git-http-fetch and
-	  git-fetch use them.  If you do not use http
-	  transfer, you are probably OK if you do not have
-	  them.
+	- libcurl library; git-http-fetch and git-fetch use them.  You
+	  might also want the "curl" executable for debugging purposes.
+	  If you do not use http transfer, you are probably OK if you
+	  do not have them.
 
 	- expat library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional.
diff --git a/git.spec.in b/git.spec.in
index 97a26be..d946bb1 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -12,7 +12,7 @@ BuildRequires:	zlib-devel >= 1.2, openssl-devel, 
curl-devel, expat-devel, gettex
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 
 Requires:	perl-Git = %{version}-%{release}
-Requires:	zlib >= 1.2, rsync, curl, less, openssh-clients, expat
+Requires:	zlib >= 1.2, rsync, less, openssh-clients, expat
 Provides:	git-core = %{version}-%{release}
 Obsoletes:	git-core <= 1.5.4.2
 Obsoletes:	git-p4
-- 
1.5.6.rc2.128.gf64ae
