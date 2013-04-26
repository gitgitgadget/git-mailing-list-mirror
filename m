From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 5/9] remote-hg: use hashlib instead of hg sha1 util
Date: Fri, 26 Apr 2013 16:12:35 -0500
Message-ID: <1367010759-17928-6-git-send-email-felipe.contreras@gmail.com>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 23:14:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpyE-0007Ij-V3
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757491Ab3DZVON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:14:13 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:59745 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452Ab3DZVOK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:14:10 -0400
Received: by mail-ob0-f178.google.com with SMTP id 16so3876407obc.23
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=spLs22Chc7x2/nejkNudazHcHcBN2QeLo8VtaCNbwSU=;
        b=KXRcLzxn67sar89MrnpeaKwYdb8IXcWTjbxnHc5ePQHJBgv+9uxCIZI8tiV/q1002l
         G4sE34WrTKFq9xZq/rwHtcaAU2k5Xoj+gxkKkGZJ/tpMB4PzuQzSIlKsuAfwhugACTVI
         K9p2lZu4ZGCrcoXSKZ5gQebVpMFr9EXHsAeiH9V2jpByugmRcR2R2dVG164itaZD8dJO
         hPBczld5SFHl4J8vfFgl58whaBaewclrdP7YNz6L4syu/c84Gnmqklaq7MIHVPyZTvJc
         0OUb8Op38pt//xzEF0W8VOrOU8AVSoH2w152Y6m8IIGdYVP9Cg0SzZNQt5zt02Wcft0X
         bMNQ==
X-Received: by 10.182.129.101 with SMTP id nv5mr22839707obb.56.1367010850030;
        Fri, 26 Apr 2013 14:14:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jv10sm9735068oeb.3.2013.04.26.14.14.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 14:14:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222586>

To be in sync with remote-bzr.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 80b3606..06920f2 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -22,7 +22,7 @@ import shutil
 import subprocess
 import urllib
 import atexit
-import urlparse
+import urlparse, hashlib
 
 #
 # If you want to switch to hg-git compatibility mode:
@@ -933,7 +933,7 @@ def main(args):
 
     if alias[4:] == url:
         is_tmp = True
-        alias = util.sha1(alias).hexdigest()
+        alias = hashlib.sha1(alias).hexdigest()
     else:
         is_tmp = False
 
-- 
1.8.2.1.1031.g2ee5873
