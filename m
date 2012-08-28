From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v7 14/16] Add a svnrdump-simulator replaying a dump file for testing
Date: Tue, 28 Aug 2012 10:49:48 +0200
Message-ID: <1346143790-23491-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 10:52:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HWs-0002Rb-HE
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 10:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab2H1Ivw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 04:51:52 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51578 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab2H1Ivb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 04:51:31 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1533185bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Hb8Cgb6Z77mXKHLZKzitn6/eB8VQNUegPAANACIB+gc=;
        b=VD6henji7ac92HfxSMkIlvYxMoTL7V9EfkbyoquG+ZA1GZwEWOEsDKckC/uOwp3D7Q
         NeYPBKH4Jei5Uf/XwXNBuyNMSfAY/XasibtrEHZl6dU7VgG7QOAj17rpq0jpp2IUqaMF
         oPFyEO4YwRPIFExH90ZdY4oWbH1qIQeWsPjZ1ag2d/OezdYt0wKR3zvF1/bb8yocKr8Q
         Xk5kDsN4FYI3w2PO2NziSZJ9eo2ETCJGbZAiCO19416cl1aN6+MQN5ZV9WS/YZMM1mgG
         zHSBbTqaEwz1Ecc5GX2Cie7BA/VcWDlMuQqXMtcwMK+SSuNE5tF259/82d8dCOuHkZfe
         l0tQ==
Received: by 10.204.129.23 with SMTP id m23mr4717669bks.28.1346143890431;
        Tue, 28 Aug 2012 01:51:30 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id m9sm12047800bkm.10.2012.08.28.01.51.28
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 01:51:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346143790-23491-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204412>

To ease testing without depending on a reachable svn server, this
compact python script mimics parts of svnrdumps behaviour.  It
requires the remote url to start with sim://.

Start and end revisions are evaluated.  If the requested revision
doesn't exist, as it is the case with incremental imports, if no new
commit was added, it returns 1 (like svnrdump).

To allow using the same dump file for simulating multiple incremental
imports, the highest revision can be limited by setting the environment
variable SVNRMAX to that value. This simulates the situation where
higher revs don't exist yet.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/svn-fe/svnrdump_sim.py |   53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 contrib/svn-fe/svnrdump_sim.py

diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
new file mode 100755
index 0000000..1cfac4a
--- /dev/null
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -0,0 +1,53 @@
+#!/usr/bin/python
+"""
+Simulates svnrdump by replaying an existing dump from a file, taking care
+of the specified revision range.
+To simulate incremental imports the environment variable SVNRMAX can be set
+to the highest revision that should be available.
+"""
+import sys, os
+
+
+def getrevlimit():
+        var = 'SVNRMAX'
+        if os.environ.has_key(var):
+                return os.environ[var]
+        return None
+
+def writedump(url, lower, upper):
+        if url.startswith('sim://'):
+                filename = url[6:]
+                if filename[-1] == '/': filename = filename[:-1] #remove terminating slash
+        else:
+                raise ValueError('sim:// url required')
+        f = open(filename, 'r');
+        state = 'header'
+        wroterev = False
+        while(True):
+                l = f.readline()
+                if l == '': break
+                if state == 'header' and l.startswith('Revision-number: '):
+                        state = 'prefix'
+                if state == 'prefix' and l == 'Revision-number: %s\n' % lower:
+                        state = 'selection'
+                if not upper == 'HEAD' and state == 'selection' and l == 'Revision-number: %s\n' % upper:
+                        break;
+
+                if state == 'header' or state == 'selection':
+                        if state == 'selection': wroterev = True
+                        sys.stdout.write(l)
+        return wroterev
+
+if __name__ == "__main__":
+        if not (len(sys.argv) in (3, 4, 5)):
+                print "usage: %s dump URL -rLOWER:UPPER"
+                sys.exit(1)
+        if not sys.argv[1] == 'dump': raise NotImplementedError('only "dump" is suppported.')
+        url = sys.argv[2]
+        r = ('0', 'HEAD')
+        if len(sys.argv) == 4 and sys.argv[3][0:2] == '-r':
+                r = sys.argv[3][2:].lstrip().split(':')
+        if not getrevlimit() is None: r[1] = getrevlimit()
+        if writedump(url, r[0], r[1]): ret = 0
+        else: ret = 1
+        sys.exit(ret)
-- 
1.7.9.5
