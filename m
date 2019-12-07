Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED231C2D0BE
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A0524673
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRuqO2bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfLGRr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:47:59 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40805 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfLGRry (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:54 -0500
Received: by mail-wm1-f47.google.com with SMTP id t14so10539164wmi.5
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=udxcfKZlkTcXFsmoVhUqXRiSTeFNwO86ZLi7Q3Qvs7M=;
        b=RRuqO2bi6j+AgT/PGE1hEukm5/l/jrGFUtm/6y78cC+qKbsXRR98ceMvv0jMw13jjx
         WG0rzry+LWnpQLxY2PY/1R150yOl3Yk9K9Hieim/WY1VIyWDZMJoHhDaaxmc4iBiNOGn
         GxNC0tBC6JvauXaUhYYX+6RCaBYTYqe8rvHR7Cokd59pRzbeGIGl+KT5uenMT/o1iaWg
         /hUoScmZskd30GxweR9OZA4jRTSjrTzMfJlbNQjNxjgdNAt3OGy87q0FbfFcyYKVjH3T
         vL9I/RPmMMrYeEmRJ1MeNYiAakxRO7GP/QM095XoBo6h96slFZ1yZmzn0cFO5BvZBm5s
         ilLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=udxcfKZlkTcXFsmoVhUqXRiSTeFNwO86ZLi7Q3Qvs7M=;
        b=Dpla0aYuPYa4lai17+NV2rVrK9hKCGbAkx223O5bsMA4Mz0iBNJPJSSZMIWQC/I3V3
         OmtXb0cNIEwPbYs5fSbkCdIDgpO91HUepzYub2DRKflyc5uMHvmbGVIPR7r3xWkCDw/N
         QOj7kdSFNJ07h/obZ2KX7wlQ8NGyUbdiYNCrUuu6thqjoe6JUky9UtP01x9WWhxOjNFK
         a0B3ttEu7ukUm16qWEEtLTrFtnl4mOtJjSxHbqPfD98ZPKPk84NySng6cfzL/4h5jVy2
         8rJO3MA9Y1eialD7m8A5EuKz7fzyy+fyAQR1v6S+rIO7R8xOhjOcRwXHnE8pUrbTij7U
         fr4g==
X-Gm-Message-State: APjAAAUbc5/jlJI4aiX+mojdu0SqT4YfZ37LYng6EUxHx+VdKIl83332
        s0pmD7+3icMAen4zDY1OpjqBVqoj
X-Google-Smtp-Source: APXvYqwZixmBefbZcw1tUw8XLQWraV+1iRn5AaeqnlOF383xqqEZscbbooLM9Hf6shckA+uGCux1gg==
X-Received: by 2002:a1c:5448:: with SMTP id p8mr16778063wmi.70.1575740871716;
        Sat, 07 Dec 2019 09:47:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1sm20259426wrs.24.2019.12.07.09.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:51 -0800 (PST)
Message-Id: <a221eb8bb68975030966897a220ba2d328b000f5.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:37 +0000
Subject: [PATCH v5 09/15] git-p4: python 3 syntax changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Python 3 handles strings differently than Python 2.7.  Since Python 2
is reaching it's end of life, a series of changes are being submitted to
enable python 3.5 and following support. The current code fails basic
tests under python 3.5.

There are a number of translations suggested by modernize/futureize that
should be taken to fix numerous non-string specific issues.

Change references to the X.next() iterator to the function next(X) which
is compatible with both Python2 and Python3.

Change references to X.keys() to list(X.keys()) to return a list that
can be iterated in both Python2 and Python3.

Add the literal text (object) to the end of class definitions to be
consistent with Python3 class definition.

Change integer divison to use "//" instead of "/"  Under Both Python 2
and Python 3 // will return a floor()ed result which matches existing
functionality.

Change the format string for displaying decimal values from %d to %4.1f%
when displaying a progress.  This avoids displaying long repeating
decimals in user displayed text.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 55 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e6f7513384..fc6c9406c2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -26,6 +26,9 @@
 import zlib
 import ctypes
 import errno
+import os.path
+import codecs
+import io
 
 # support basestring in Python 3
 try:
@@ -639,7 +642,7 @@ def parseDiffTreeEntry(entry):
 
     If the pattern is not matched, None is returned."""
 
-    match = diffTreePattern().next().match(entry)
+    match = next(diffTreePattern()).match(entry)
     if match:
         return {
             'src_mode': match.group(1),
@@ -980,7 +983,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
     branchByDepotPath = {}
-    for branch in branches.keys():
+    for branch in list(branches.keys()):
         tip = branches[branch]
         log = extractLogMessageFromGitCommit(tip)
         settings = extractSettingsGitLog(log)
@@ -1174,7 +1177,7 @@ def getClientSpec():
     client_name = entry["Client"]
 
     # just the keys that start with "View"
-    view_keys = [ k for k in entry.keys() if k.startswith("View") ]
+    view_keys = [ k for k in list(entry.keys()) if k.startswith("View") ]
 
     # hold this new View
     view = View(client_name)
@@ -1416,7 +1419,7 @@ def processContent(self, git_mode, relPath, contents):
         else:
             return LargeFileSystem.processContent(self, git_mode, relPath, contents)
 
-class Command:
+class Command(object):
     delete_actions = ( "delete", "move/delete", "purge" )
     add_actions = ( "add", "branch", "move/add" )
 
@@ -1431,7 +1434,7 @@ def ensure_value(self, attr, value):
             setattr(self, attr, value)
         return getattr(self, attr)
 
-class P4UserMap:
+class P4UserMap(object):
     def __init__(self):
         self.userMapFromPerforceServer = False
         self.myP4UserId = None
@@ -1482,7 +1485,7 @@ def getUserMapFromPerforceServer(self):
                 self.emails[email] = user
 
         s = ''
-        for (key, val) in self.users.items():
+        for (key, val) in list(self.users.items()):
             s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
 
         open(self.getUserCacheFilename(), "wb").write(s)
@@ -1833,7 +1836,7 @@ def prepareSubmitTemplate(self, changelist=None):
                 break
         if not change_entry:
             die('Failed to decode output of p4 change -o')
-        for key, value in change_entry.iteritems():
+        for key, value in list(change_entry.items()):
             if key.startswith('File'):
                 if 'depot-paths' in settings:
                     if not [p for p in settings['depot-paths']
@@ -2077,7 +2080,7 @@ def applyCommit(self, id):
             p4_delete(f)
 
         # Set/clear executable bits
-        for f in filesToChangeExecBit.keys():
+        for f in list(filesToChangeExecBit.keys()):
             mode = filesToChangeExecBit[f]
             setP4ExecBit(f, mode)
 
@@ -2330,7 +2333,7 @@ def run(self, args):
             self.clientSpecDirs = getClientSpec()
 
         # Check for the existence of P4 branches
-        branchesDetected = (len(p4BranchesInGit().keys()) > 1)
+        branchesDetected = (len(list(p4BranchesInGit().keys())) > 1)
 
         if self.useClientSpec and not branchesDetected:
             # all files are relative to the client spec
@@ -2721,7 +2724,7 @@ def __init__(self):
         self.knownBranches = {}
         self.initialParents = {}
 
-        self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
+        self.tz = "%+03d%02d" % (- time.timezone // 3600, ((- time.timezone % 3600) // 60))
         self.labels = {}
 
     # Force a checkpoint in fast-import and wait for it to finish
@@ -2838,7 +2841,7 @@ def splitFilesIntoBranches(self, commit):
             else:
                 relPath = self.stripRepoPath(path, self.depotPaths)
 
-            for branch in self.knownBranches.keys():
+            for branch in list(self.knownBranches.keys()):
                 # add a trailing slash so that a commit into qt/4.2foo
                 # doesn't end up in qt/4.2, e.g.
                 if p4PathStartsWith(relPath, branch + "/"):
@@ -2867,7 +2870,7 @@ def streamOneP4File(self, file, contents):
                 size = int(self.stream_file['fileSize'])
             else:
                 size = 0 # deleted files don't get a fileSize apparently
-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
+            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size//1024//1024))
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
@@ -2967,7 +2970,7 @@ def streamP4FilesCb(self, marshalled):
             required_bytes = int((4 * int(self.stream_file["fileSize"])) - calcDiskFree())
             if required_bytes > 0:
                 err = 'Not enough space left on %s! Free at least %i MB.' % (
-                    os.getcwd(), required_bytes/1024/1024
+                    os.getcwd(), required_bytes//1024//1024
                 )
 
         if err:
@@ -2996,7 +2999,7 @@ def streamP4FilesCb(self, marshalled):
 
         # pick up the new file information... for the
         # 'data' field we need to append to our array
-        for k in marshalled.keys():
+        for k in list(marshalled.keys()):
             if k == 'data':
                 if 'streamContentSize' not in self.stream_file:
                     self.stream_file['streamContentSize'] = 0
@@ -3011,8 +3014,8 @@ def streamP4FilesCb(self, marshalled):
             'depotFile' in self.stream_file):
             size = int(self.stream_file["fileSize"])
             if size > 0:
-                progress = 100*self.stream_file['streamContentSize']/size
-                sys.stdout.write('\r%s %d%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size/1024/1024)))
+                progress = 100.0*self.stream_file['streamContentSize']/size
+                sys.stdout.write('\r%s %4.1f%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size//1024//1024)))
                 sys.stdout.flush()
 
         self.stream_have_file_info = True
@@ -3093,7 +3096,7 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
 
         gitStream.write("tagger %s\n" % tagger)
 
-        print("labelDetails=",labelDetails)
+        print(("labelDetails=",labelDetails))
         if 'Description' in labelDetails:
             description = labelDetails['Description']
         else:
@@ -3232,7 +3235,7 @@ def getLabels(self):
             self.labels[newestChange] = [output, revisions]
 
         if self.verbose:
-            print("Label changes: %s" % self.labels.keys())
+            print("Label changes: %s" % list(self.labels.keys()))
 
     # Import p4 labels as git tags. A direct mapping does not
     # exist, so assume that if all the files are at the same revision
@@ -3375,7 +3378,7 @@ def getBranchMapping(self):
 
     def getBranchMappingFromGitBranches(self):
         branches = p4BranchesInGit(self.importIntoRemotes)
-        for branch in branches.keys():
+        for branch in list(branches.keys()):
             if branch == "master":
                 branch = "main"
             else:
@@ -3487,14 +3490,14 @@ def importChanges(self, changes, origin_revision=0):
             self.updateOptionDict(description)
 
             if not self.silent:
-                sys.stdout.write("\rImporting revision %s (%s%%)" % (change, cnt * 100 / len(changes)))
+                sys.stdout.write("\rImporting revision %s (%4.1f%%)" % (change, cnt * 100 / len(changes)))
                 sys.stdout.flush()
             cnt = cnt + 1
 
             try:
                 if self.detectBranches:
                     branches = self.splitFilesIntoBranches(description)
-                    for branch in branches.keys():
+                    for branch in list(branches.keys()):
                         ## HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
                         self.branchPrefixes = [ branchPrefix ]
@@ -3683,13 +3686,13 @@ def run(self, args):
                 if short in branches:
                     self.p4BranchesInGit = [ short ]
             else:
-                self.p4BranchesInGit = branches.keys()
+                self.p4BranchesInGit = list(branches.keys())
 
             if len(self.p4BranchesInGit) > 1:
                 if not self.silent:
                     print("Importing from/into multiple branches")
                 self.detectBranches = True
-                for branch in branches.keys():
+                for branch in list(branches.keys()):
                     self.initialParents[self.refPrefix + branch] = \
                         branches[branch]
 
@@ -4073,7 +4076,7 @@ def findLastP4Revision(self, starting_point):
             to find the P4 commit we are based on, and the depot-paths.
         """
 
-        for parent in (range(65535)):
+        for parent in (list(range(65535))):
             log = extractLogMessageFromGitCommit("{0}^{1}".format(starting_point, parent))
             settings = extractSettingsGitLog(log)
             if 'change' in settings:
@@ -4212,7 +4215,7 @@ def printUsage(commands):
 
 def main():
     if len(sys.argv[1:]) == 0:
-        printUsage(commands.keys())
+        printUsage(list(commands.keys()))
         sys.exit(2)
 
     cmdName = sys.argv[1]
@@ -4222,7 +4225,7 @@ def main():
     except KeyError:
         print("unknown command %s" % cmdName)
         print("")
-        printUsage(commands.keys())
+        printUsage(list(commands.keys()))
         sys.exit(2)
 
     options = cmd.options
-- 
gitgitgadget

