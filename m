From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 06:20:41 -0500
Message-ID: <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 13:22:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKFn-0003mh-RG
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758060Ab3DYLWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:22:15 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:54597 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757999Ab3DYLWO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:22:14 -0400
Received: by mail-oa0-f49.google.com with SMTP id j1so2637317oag.22
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=8CCgJdQ2q7ATTpMIFxBPVFwnwtbd87xXLVZycvIbeHc=;
        b=0trQF3AB2X+6RCTI3YZ1tKAQFY2+5IEjzjKIK61RFjiAdlWJ+SA5GskzI3k64qkKIH
         RSuotnP4gh6074tuU+eufvuA2KQtoKEDdjufr72Xk3P00ydszboasJfER+pgsqtAJqNC
         c+pAn8P9KrWihNvmAB/iDnoaPHbfZgNvoBYuLq86qACURKzI8gNd+c+/bZvEeYAq4c9p
         3BCf8LmviprsRa6MVXhtNd+YXrIb7Suq0G3oNVVEINx7PYKHdNI2AsV1kjKFrerZhQ/D
         Lkl/svCNM8g26HMgUmq6z7+WjsB9Nw2IdHy3ih/eqiJGI+CmRLPMr1hioUPNbDo6/5iS
         BMFQ==
X-Received: by 10.60.54.163 with SMTP id k3mr15817833oep.139.1366888934013;
        Thu, 25 Apr 2013 04:22:14 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id xz9sm3189720oeb.5.2013.04.25.04.22.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 04:22:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222369>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index aa7bc97..82bf7c7 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -94,7 +94,7 @@ class Marks:
         return self.last_mark
 
     def is_marked(self, rev):
-        return self.marks.has_key(rev)
+        return rev in self.marks
 
     def new_mark(self, rev, mark):
         self.marks[rev] = mark
@@ -224,7 +224,7 @@ def export_files(tree, files):
             else:
                 mode = '100644'
 
-            # is the blog already exported?
+            # is the blob already exported?
             if h in filenodes:
                 mark = filenodes[h]
                 final.append((mode, mark, path))
@@ -521,7 +521,7 @@ def c_style_unescape(string):
     return string
 
 def parse_commit(parser):
-    global marks, blob_marks, bmarks, parsed_refs
+    global marks, blob_marks, parsed_refs
     global mode
 
     parents = []
@@ -555,7 +555,7 @@ def parse_commit(parser):
             mark = int(mark_ref[1:])
             f = { 'mode' : m, 'data' : blob_marks[mark] }
         elif parser.check('D'):
-            t, path = line.split(' ')
+            t, path = line.split(' ', 1)
             f = { 'deleted' : True }
         else:
             die('Unknown file command: %s' % line)
@@ -643,6 +643,7 @@ def do_export(parser):
                 wt = repo.bzrdir.open_workingtree()
                 wt.update()
         print "ok %s" % ref
+
     print
 
 def do_capabilities(parser):
-- 
1.8.2.1
