From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/8] remote-bzr: trivial cleanups
Date: Fri, 24 May 2013 21:24:24 -0500
Message-ID: <1369448666-17515-7-git-send-email-felipe.contreras@gmail.com>
References: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:26:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Bk-0006XS-Dt
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab3EYC0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:26:25 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46482 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab3EYC0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:26:23 -0400
Received: by mail-ob0-f174.google.com with SMTP id fb19so6264895obc.33
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QFFDJhoIJdHzGnrPn3SvN7bLpacbYpgnDsG5T2DQP9M=;
        b=Fd5gf3fVs59fRa9dr5/T4w0PvPZwLCsJRqDbyidP/h4HVP97wKeHxb3UpaWrhDL+QU
         j12szrVaMMuaO4PJhjoWOebuYI8QbTg4rV0/KCBlwscrUIk172XD2wfxRm5K30FLmNoV
         /b6FUAQ5sVRp7DirUuyBIkW/KmsHftx90nqLPpn8iJczPc33IHS42SQ/7PNGKS799dhW
         0niy6S29wImuZl8DgCcDqMTl46lNS3AMlZWiPlhMLtCRgJ1nREFSK8fGvq+P3x39KrEk
         HnbvzbWSwp89wg2uoVHHxJpLXYjiOsFJPyr/2+/Mf5VGEVcsAjVFcjCLc20SgbObrjn4
         IZCw==
X-Received: by 10.182.84.135 with SMTP id z7mr13741296oby.35.1369448782500;
        Fri, 24 May 2013 19:26:22 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm20570813oep.1.2013.05.24.19.26.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:26:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225410>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 80ed59f..34025c3 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -815,7 +815,7 @@ def find_branches(repo, wanted):
         except bzrlib.errors.NotBranchError:
             continue
         else:
-            yield name, branch
+            yield name, branch.base
 
 def get_repo(url, alias):
     global dirname, peer, branches
@@ -857,12 +857,12 @@ def get_repo(url, alias):
         # branch
 
         name = 'master'
-        remote_branch = origin.open_branch()
+        branch = origin.open_branch().base
 
         if not is_local:
-            peers[name] = remote_branch.base
+            peers[name] = branch
 
-        branches[name] = remote_branch.base
+        branches[name] = branch
 
         return origin
     else:
@@ -872,12 +872,12 @@ def get_repo(url, alias):
         # stupid python
         wanted = [e for e in wanted if e]
 
-        for name, remote_branch in find_branches(repo, wanted):
+        for name, branch in find_branches(repo, wanted):
 
             if not is_local:
-                peers[name] = remote_branch.base
+                peers[name] = branch
 
-            branches[name] = remote_branch.base
+            branches[name] = branch
 
         return origin
 
-- 
1.8.3.rc3.312.g47657de
