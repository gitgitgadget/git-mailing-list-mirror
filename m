From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/20] remote-bzr: cleanup CustomTree
Date: Thu, 25 Apr 2013 20:07:49 -0500
Message-ID: <1366938488-25425-2-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:09:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAN-0003R9-Ac
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591Ab3DZBJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:09:28 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:54982 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758382Ab3DZBJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:26 -0400
Received: by mail-ob0-f172.google.com with SMTP id v19so3103113obq.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=L+8+Aydx66AA/oo5sav32JqF0El09phi4CP4r+u45GA=;
        b=PG2GP9ZTjJEPCGoZe5MOObTHP04YgBGX4EP0AIaFVcGhxXtnKo0D3WigK8ue7u8acS
         qevQEqpLqH5Stw5eP6A+p1YtKytgqkfWqUUse5CqNxIIWp+FAY9o8cppU/ApXzDQv5/0
         oj2SqV3Sv/dX4qC9LrVebKCXbvfGfq3pG3KVqyqrkZDU2ueAjTN9gdMVkEsEn3syPYQ4
         HY8JL5g1CdoITQS09GBSu+x6LH4udbuueakGnOsVtKCZA+Y0SxZAhUbvX+abAp1D0V0V
         sNk38elREeG7OmTtK2GIckgLtitizoX9iwOLp55tdzNl8nrAnH1Vdmrt5UFpWYxp303n
         uSZw==
X-Received: by 10.60.140.129 with SMTP id rg1mr19542197oeb.125.1366938566193;
        Thu, 25 Apr 2013 18:09:26 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id fl7sm5863561obb.0.2013.04.25.18.09.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222484>

This code was not used at all.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index c19ed0e..7452a57 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -385,9 +385,6 @@ class CustomTree():
     def __init__(self, repo, revid, parents, files):
         global files_cache
 
-        self.repo = repo
-        self.revid = revid
-        self.parents = parents
         self.updates = {}
 
         def copy_tree(revid):
@@ -435,7 +432,7 @@ class CustomTree():
             if basename == '':
                 return None
             fid = bzrlib.generate_ids.gen_file_id(path)
-            d = add_entry(fid, dirname, 'directory')
+            add_entry(fid, dirname, 'directory')
             return fid
 
         def add_entry(fid, path, kind, mode = None):
@@ -458,7 +455,6 @@ class CustomTree():
                     (None, executable))
             self.files[path] = change[0]
             changes.append(change)
-            return change
 
         def update_entry(fid, path, kind, mode = None):
             dirname, basename = os.path.split(path)
@@ -480,7 +476,6 @@ class CustomTree():
                     (None, executable))
             self.files[path] = change[0]
             changes.append(change)
-            return change
 
         def remove_entry(fid, path, kind):
             dirname, basename = os.path.split(path)
@@ -495,7 +490,6 @@ class CustomTree():
                     (None, None))
             del self.files[path]
             changes.append(change)
-            return change
 
         for fid, f in self.updates.iteritems():
             path = f['path']
-- 
1.8.2.1.884.g3532a8d
