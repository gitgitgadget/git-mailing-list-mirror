From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/5] remote-bzr: add support for older versions
Date: Wed,  9 Apr 2014 13:50:02 -0500
Message-ID: <1397069404-7451-4-git-send-email-felipe.contreras@gmail.com>
References: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 21:00:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXxjd-0006Qj-50
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 21:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934174AbaDITA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 15:00:26 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:40349 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933354AbaDITAW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 15:00:22 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so3207439obc.16
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FVwqbM1o9PU+rNSh9ncLbSdnpTR4+dpx/r3Pj9Iea7U=;
        b=z0a1JofVx3vgSTkFjZgUYAsmX5iZO9vlY0IX9aW3U17C3UH1VuuJrb9citPztO0G5x
         v35xz9auhzkSMOXxChm05cGiKu5C3vy/7xyOeuzK4s2RhdlQ0eunr8qfOJjyuwAMdt8x
         VOBw3qzlKn8BCVoBmlBUuWsWgFCrDs0Ykfxr7XjrCRzQKr+Pi6vFMIvc+pgEyiS6d+aH
         Wmp6FPUO1Rz5l1LdwzTnHnzZc6KgHJ7NgB91E1pVhjB2PT4sMe1ttc9/SIlc07IDL4sH
         Nz0ZeMszaYSs2qDxt4wF70/vAWOkZlAvZC8cR70Ofcmu/ke7PXSmCl8kMIkn+GVYdbXG
         NBHg==
X-Received: by 10.182.158.135 with SMTP id wu7mr9992872obb.28.1397070022370;
        Wed, 09 Apr 2014 12:00:22 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id la3sm2857162obb.19.2014.04.09.12.00.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Apr 2014 12:00:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245991>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 332aba7..7f354c8 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -759,7 +759,7 @@ def clone(path, remote_branch):
 def get_remote_branch(name):
     remote_branch = bzrlib.branch.Branch.open(branches[name],
                                               possible_transports=transports)
-    if isinstance(remote_branch.user_transport, bzrlib.transport.local.LocalTransport):
+    if isinstance(remote_branch.bzrdir.root_transport, bzrlib.transport.local.LocalTransport):
         return remote_branch
 
     branch_path = os.path.join(dirname, 'clone', name)
@@ -842,7 +842,7 @@ def get_repo(url, alias):
     if not wanted:
         try:
             repo = origin.open_repository()
-            if not repo.user_transport.listable():
+            if not repo.bzrdir.root_transport.listable():
                 # this repository is not usable for us
                 raise bzrlib.errors.NoRepositoryPresent(repo.bzrdir)
         except bzrlib.errors.NoRepositoryPresent:
-- 
1.9.1+fc1
