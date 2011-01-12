From: Andrew Garber <andrew@andrewgarber.com>
Subject: [PATCH] git-p4: correct indenting and formatting
Date: Tue, 11 Jan 2011 21:05:03 -0800
Message-ID: <1294808703-1848-1-git-send-email-andrew@andrewgarber.com>
Cc: Andrew Garber <andrew@andrewgarber.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 12 06:05:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcsu6-0007FE-LY
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 06:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780Ab1ALFFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 00:05:46 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:46681 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab1ALFFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 00:05:45 -0500
Received: by pxi15 with SMTP id 15so22047pxi.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 21:05:44 -0800 (PST)
Received: by 10.142.133.14 with SMTP id g14mr501416wfd.409.1294808744494;
        Tue, 11 Jan 2011 21:05:44 -0800 (PST)
Received: from localhost.localdomain (d206-116-116-32.bchsia.telus.net [206.116.116.32])
        by mx.google.com with ESMTPS id v19sm303047wfh.12.2011.01.11.21.05.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 21:05:43 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165004>

- replace tabs with appropriate number of spaces
- minor tweaks to code formatting
---
 contrib/fast-import/git-p4 |   71 +++++++++++++++++++++-----------------------
 1 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04ce7e3..449df2e 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -222,10 +222,10 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
     try:
         while True:
             entry = marshal.load(p4.stdout)
-	    if cb is not None:
-		cb(entry)
-	    else:
-		result.append(entry)
+            if cb is not None:
+                cb(entry)
+            else:
+                result.append(entry)
     except EOFError:
         pass
     exitCode = p4.wait()
@@ -445,8 +445,8 @@ def p4ChangesForPaths(depotPaths, changeRange):
 
     changes = {}
     for line in output:
-	changeNum = int(line.split(" ")[1])
-	changes[changeNum] = True
+        changeNum = int(line.split(" ")[1])
+        changes[changeNum] = True
 
     changelist = changes.keys()
     changelist.sort()
@@ -954,10 +954,9 @@ class P4Sync(Command):
     # - helper for streamP4Files
 
     def streamOneP4File(self, file, contents):
-	if file["type"] == "apple":
-	    print "\nfile %s is a strange apple file that forks. Ignoring" % \
-		file['depotFile']
-	    return
+        if file["type"] == "apple":
+            print "\nfile %s is a strange apple file that forks. Ignoring" % file['depotFile']
+            return
 
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
         if verbose:
@@ -1004,23 +1003,22 @@ class P4Sync(Command):
 
     # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
+        if marshalled.has_key('depotFile') and self.stream_have_file_info:
+            # start of a new file - output the old one first
+            self.streamOneP4File(self.stream_file, self.stream_contents)
+            self.stream_file = {}
+            self.stream_contents = []
+            self.stream_have_file_info = False
 
-	if marshalled.has_key('depotFile') and self.stream_have_file_info:
-	    # start of a new file - output the old one first
-	    self.streamOneP4File(self.stream_file, self.stream_contents)
-	    self.stream_file = {}
-	    self.stream_contents = []
-	    self.stream_have_file_info = False
-
-	# pick up the new file information... for the
-	# 'data' field we need to append to our array
-	for k in marshalled.keys():
-	    if k == 'data':
-		self.stream_contents.append(marshalled['data'])
-	    else:
-		self.stream_file[k] = marshalled[k]
+        # pick up the new file information... for the
+        # 'data' field we need to append to our array
+        for k in marshalled.keys():
+            if k == 'data':
+                self.stream_contents.append(marshalled['data'])
+            else:
+                self.stream_file[k] = marshalled[k]
 
-	self.stream_have_file_info = True
+        self.stream_have_file_info = True
 
     # Stream directly from "p4 files" into "git fast-import"
     def streamP4Files(self, files):
@@ -1052,23 +1050,22 @@ class P4Sync(Command):
             self.stream_contents = []
             self.stream_have_file_info = False
 
-	    # curry self argument
-	    def streamP4FilesCbSelf(entry):
-		self.streamP4FilesCb(entry)
+        # curry self argument
+        def streamP4FilesCbSelf(entry):
+            self.streamP4FilesCb(entry)
 
-	    p4CmdList("-x - print",
-		'\n'.join(['%s#%s' % (f['path'], f['rev'])
-                                                  for f in filesToRead]),
-	        cb=streamP4FilesCbSelf)
+        p4CmdList("-x - print",
+                  '\n'.join(['%s#%s' % (f['path'], f['rev']) for f in filesToRead]),
+                  cb=streamP4FilesCbSelf)
 
-            # do the last chunk
-            if self.stream_file.has_key('depotFile'):
-                self.streamOneP4File(self.stream_file, self.stream_contents)
+        # do the last chunk
+        if self.stream_file.has_key('depotFile'):
+            self.streamOneP4File(self.stream_file, self.stream_contents)
 
     def commit(self, details, files, branch, branchPrefixes, parent = ""):
         epoch = details["time"]
         author = details["user"]
-	self.branchPrefixes = branchPrefixes
+        self.branchPrefixes = branchPrefixes
 
         if self.verbose:
             print "commit into %s" % branch
@@ -1173,7 +1170,7 @@ class P4Sync(Command):
 
         s = ''
         for (key, val) in self.users.items():
-	    s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
+            s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
 
         open(self.getUserCacheFilename(), "wb").write(s)
         self.userMapFromPerforceServer = True
-- 
1.7.3.2
