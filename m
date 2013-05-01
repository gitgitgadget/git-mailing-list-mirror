From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/18] remote-bzr: cleanup CustomTree
Date: Tue, 30 Apr 2013 20:09:53 -0500
Message-ID: <1367370610-14250-2-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLaR-00073I-Jh
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933946Ab3EABLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:11:46 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:45288 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933306Ab3EABLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:11:34 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so210308yho.30
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=MgUcz8uviwQPgd8FvKBqSJmDjDF8YkteNLwFU057Z+I=;
        b=PDJi4l2TvDX4rYMA/cO6HqSTPyJkn7zb+VhDqB2VorRqSPOhMitJlwu8Qg/f6V7WtZ
         gDrVG6cdalbvlNNKLM36CPlIkXkpGplLEiNVZD17zZ7wqWKYLw/eyjl2mWIWhLcdg+3U
         kQXrmTEeY1IY/DQz/mymyV8bxwlcDndtgxBNgL2XZnc9TUjmd3drtwVDC1/K4m3qxp6R
         khE1L978lDlL2NC4vgIs18T0nveqKltUqyT9hHv2K+T+ifPdYUehE/NOPVwbPH+bvvG2
         g9NmWJzk9KsugcJMgUdlU7WZ5bzeEkNQ9P/CCVZv4VRhe1kT0Gf/NM+m5wKccRqUizMA
         4Iig==
X-Received: by 10.236.163.163 with SMTP id a23mr588081yhl.132.1367370693528;
        Tue, 30 Apr 2013 18:11:33 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i44sm1562405yhk.17.2013.04.30.18.11.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:11:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223045>

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
1.8.3.rc0.399.gc96a135
