From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/8] remote-bzr: trivial cleanups
Date: Thu, 16 May 2013 03:36:45 -0500
Message-ID: <1368693407-21267-7-git-send-email-felipe.contreras@gmail.com>
References: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 10:38:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UctiA-0000W1-Po
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab3EPIiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:38:50 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:43478 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab3EPIio (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:38:44 -0400
Received: by mail-ob0-f178.google.com with SMTP id v19so3136498obq.9
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=TuRKChMbxcDnlbODwzhN4LRtGS6scx7SOm6F7CeKo5I=;
        b=y2vp1865Srfdiv1oXDz0keOtqpToiThmyPLZ7CEIQ+EA5fikMm6AzcMCGPHJ1mEDAk
         Fz7A/Adg+Db48aVRx72L/HLsAbRcW1BZTEIgDKmykKV6OC+XUJXNiS4mQ8oMEypAjm1n
         vFvM/kBn9qFfweSn4vCCpHxdI6Tw67Y7CiRkS0BwwcyhwAiX87iFpkAstkgz7+DCbnZY
         RFbJrIOTASlwHOD54YOk3xuMOKlinmQBow5vvbblma9b/dHKlRqXVu/tlyt6ZkOtyciI
         n5R+RCTb1pr8dMe04E1uBxsO4HPvFZrnBS13vz9/fFtzvOieayjgbzjoiePvY4mRfIl6
         6HJQ==
X-Received: by 10.182.66.81 with SMTP id d17mr19624084obt.29.1368693523980;
        Thu, 16 May 2013 01:38:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm7130046oez.4.2013.05.16.01.38.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 01:38:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224505>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index fdc2e69..dd3d71c 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -814,7 +814,7 @@ def find_branches(repo, wanted):
         except bzrlib.errors.NotBranchError:
             continue
         else:
-            yield name, branch
+            yield name, branch.base
 
 def get_repo(url, alias):
     global dirname, peer, branches
@@ -851,12 +851,12 @@ def get_repo(url, alias):
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
@@ -866,12 +866,12 @@ def get_repo(url, alias):
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
1.8.3.rc2.542.g24820ba
