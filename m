Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9464E1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 08:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756454AbeFSIEf (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 04:04:35 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:40387 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756436AbeFSIEW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 04:04:22 -0400
Received: by mail-wr0-f178.google.com with SMTP id l41-v6so19481562wre.7
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ju/Jcp6/3vYWnfbWZFTpDHRQliR+S0ia1d3v6O29MMM=;
        b=daKeYwy3yRQGC9nVTZTXDspe3OlNCnBEG3bWhehxCHHmpB4ddJ9W8Zwb25GjXUTOcT
         Lpn/2hLJthm/qLBgfF9hsD1CT9om1mh6FDhWlqgqRwMF9Yz7Cp4RK11Qe4I3hMePRcLU
         sgiKJFmSUuZ44i7jTNsK6bQPnxdTLp19zZESI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ju/Jcp6/3vYWnfbWZFTpDHRQliR+S0ia1d3v6O29MMM=;
        b=VeW00JnwlINUQWpZuZAN5HmW/6TbJmI9NPxlraopPzCpxLsPSrqKh6cp5tB00VIucu
         0mKUP2A/y0VzMFUkeieGqXHMOIBmLG2lRFWSmO3+7pe4H0NzAiqbSuqCtLKkqwHZ3dnM
         wpkqNlvtTJ9o8kCNXxsN5cgZ8G+IJVYeHkkeGLVZ7+4uXTalfO9iASIK9aJ2I5E+op1K
         dc6rET0qRq4FtyY58AllMqOgZVf4pDDdWfPJ/gZSYTORTrbaqWlSX2uXJ6xBCEvdcrNn
         W+5YhA2VSDieZd13Ya61eEvrq82OPS0AF1qNQ6OJQYGZcNcjFJaRjoHiWkkEtQ821JzS
         SU2g==
X-Gm-Message-State: APt69E3R7oW2dDTs5MKCVYMNwXFCdTq6SsmHPVvewTj9ePi737c4qF0R
        vDTI+rr4w0li91TumXhurrABR3V1
X-Google-Smtp-Source: ADUXVKI8gA76AfsN6w4bt+bVP/W9WtW9a9iusRswZ04bR4E8PlyWTzvUePveV2m54EniRc1ghF5pwQ==
X-Received: by 2002:adf:9724:: with SMTP id r33-v6mr13812010wrb.79.1529395460828;
        Tue, 19 Jun 2018 01:04:20 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id r2-v6sm12757215wmb.39.2018.06.19.01.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 01:04:20 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Lex Spoon <lex@lexspoon.org>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 2/6] git-p4: python3: replace dict.has_key(k) with "k in dict"
Date:   Tue, 19 Jun 2018 09:04:07 +0100
Message-Id: <20180619080411.6554-3-luke@diamand.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a
In-Reply-To: <20180619080411.6554-2-luke@diamand.org>
References: <20180619080411.6554-1-luke@diamand.org>
 <20180619080411.6554-2-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Python3 does not have the dict.has_key() function, so replace all
such calls with "k in dict". This will still work with python2.6
and python2.7.

Converted using 2to3 (plus some hand-editing)

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 78 +++++++++++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 51e9e64a73..6fcad35104 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -767,7 +767,7 @@ def gitDeleteRef(ref):
 _gitConfig = {}
 
 def gitConfig(key, typeSpecifier=None):
-    if not _gitConfig.has_key(key):
+    if key not in _gitConfig:
         cmd = [ "git", "config" ]
         if typeSpecifier:
             cmd += [ typeSpecifier ]
@@ -781,12 +781,12 @@ def gitConfigBool(key):
        variable is set to true, and False if set to false or not present
        in the config."""
 
-    if not _gitConfig.has_key(key):
+    if key not in _gitConfig:
         _gitConfig[key] = gitConfig(key, '--bool') == "true"
     return _gitConfig[key]
 
 def gitConfigInt(key):
-    if not _gitConfig.has_key(key):
+    if key not in _gitConfig:
         cmd = [ "git", "config", "--int", key ]
         s = read_pipe(cmd, ignore_error=True)
         v = s.strip()
@@ -797,7 +797,7 @@ def gitConfigInt(key):
     return _gitConfig[key]
 
 def gitConfigList(key):
-    if not _gitConfig.has_key(key):
+    if key not in _gitConfig:
         s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
         _gitConfig[key] = s.strip().splitlines()
         if _gitConfig[key] == ['']:
@@ -855,7 +855,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
         tip = branches[branch]
         log = extractLogMessageFromGitCommit(tip)
         settings = extractSettingsGitLog(log)
-        if settings.has_key("depot-paths"):
+        if "depot-paths" in settings:
             paths = ",".join(settings["depot-paths"])
             branchByDepotPath[paths] = "remotes/p4/" + branch
 
@@ -865,9 +865,9 @@ def findUpstreamBranchPoint(head = "HEAD"):
         commit = head + "~%s" % parent
         log = extractLogMessageFromGitCommit(commit)
         settings = extractSettingsGitLog(log)
-        if settings.has_key("depot-paths"):
+        if "depot-paths" in settings:
             paths = ",".join(settings["depot-paths"])
-            if branchByDepotPath.has_key(paths):
+            if paths in branchByDepotPath:
                 return [branchByDepotPath[paths], settings]
 
         parent = parent + 1
@@ -891,8 +891,8 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
         originHead = line
 
         original = extractSettingsGitLog(extractLogMessageFromGitCommit(originHead))
-        if (not original.has_key('depot-paths')
-            or not original.has_key('change')):
+        if ('depot-paths' not in original
+            or 'change' not in original):
             continue
 
         update = False
@@ -902,7 +902,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
             update = True
         else:
             settings = extractSettingsGitLog(extractLogMessageFromGitCommit(remoteHead))
-            if settings.has_key('change') > 0:
+            if 'change' in settings:
                 if settings['depot-paths'] == original['depot-paths']:
                     originP4Change = int(original['change'])
                     p4Change = int(settings['change'])
@@ -1002,7 +1002,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
 
         # Insert changes in chronological order
         for entry in reversed(result):
-            if not entry.has_key('change'):
+            if 'change' not in entry:
                 continue
             changes.add(int(entry['change']))
 
@@ -1312,7 +1312,7 @@ def p4UserId(self):
 
         results = p4CmdList("user -o")
         for r in results:
-            if r.has_key('User'):
+            if 'User' in r:
                 self.myP4UserId = r['User']
                 return r['User']
         die("Could not find your p4 user id")
@@ -1336,7 +1336,7 @@ def getUserMapFromPerforceServer(self):
         self.emails = {}
 
         for output in p4CmdList("users"):
-            if not output.has_key("User"):
+            if "User" not in output:
                 continue
             self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
             self.emails[output["Email"]] = output["User"]
@@ -1588,7 +1588,7 @@ def p4UserForCommit(self,id):
         gitEmail = read_pipe(["git", "log", "--max-count=1",
                               "--format=%ae", id])
         gitEmail = gitEmail.strip()
-        if not self.emails.has_key(gitEmail):
+        if gitEmail not in self.emails:
             return (None,gitEmail)
         else:
             return (self.emails[gitEmail],gitEmail)
@@ -1612,14 +1612,14 @@ def lastP4Changelist(self):
         results = p4CmdList("client -o")        # find the current client
         client = None
         for r in results:
-            if r.has_key('Client'):
+            if 'Client' in r:
                 client = r['Client']
                 break
         if not client:
             die("could not get client spec")
         results = p4CmdList(["changes", "-c", client, "-m", "1"])
         for r in results:
-            if r.has_key('change'):
+            if 'change' in r:
                 return r['change']
         die("Could not get changelist number for last submit - cannot patch up user details")
 
@@ -1637,10 +1637,10 @@ def modifyChangelistUser(self, changelist, newUser):
 
         result = p4CmdList("change -f -i", stdin=input)
         for r in result:
-            if r.has_key('code'):
+            if 'code' in r:
                 if r['code'] == 'error':
                     die("Could not modify user field of changelist %s to %s:%s" % (changelist, newUser, r['data']))
-            if r.has_key('data'):
+            if 'data' in r:
                 print("Updated user field for changelist %s to %s" % (changelist, newUser))
                 return
         die("Could not modify user field of changelist %s to %s" % (changelist, newUser))
@@ -1650,7 +1650,7 @@ def canChangeChangelists(self):
         # which are required to modify changelists.
         results = p4CmdList(["protects", self.depotPath])
         for r in results:
-            if r.has_key('perm'):
+            if 'perm' in r:
                 if r['perm'] == 'admin':
                     return 1
                 if r['perm'] == 'super':
@@ -1690,7 +1690,7 @@ def prepareSubmitTemplate(self, changelist=None):
         if changelist:
             args.append(str(changelist))
         for entry in p4CmdList(args):
-            if not entry.has_key('code'):
+            if 'code' not in entry:
                 continue
             if entry['code'] == 'stat':
                 change_entry = entry
@@ -1699,7 +1699,7 @@ def prepareSubmitTemplate(self, changelist=None):
             die('Failed to decode output of p4 change -o')
         for key, value in change_entry.iteritems():
             if key.startswith('File'):
-                if settings.has_key('depot-paths'):
+                if 'depot-paths' in settings:
                     if not [p for p in settings['depot-paths']
                             if p4PathStartsWith(value, p)]:
                         continue
@@ -1710,7 +1710,7 @@ def prepareSubmitTemplate(self, changelist=None):
                 continue
         # Output in the order expected by prepareLogMessage
         for key in ['Change', 'Client', 'User', 'Status', 'Description', 'Jobs']:
-            if not change_entry.has_key(key):
+            if key not in change_entry:
                 continue
             template += '\n'
             template += key + ':'
@@ -1738,7 +1738,7 @@ def edit_template(self, template_file):
         mtime = os.stat(template_file).st_mtime
 
         # invoke the editor
-        if os.environ.has_key("P4EDITOR") and (os.environ.get("P4EDITOR") != ""):
+        if "P4EDITOR" in os.environ and (os.environ.get("P4EDITOR") != ""):
             editor = os.environ.get("P4EDITOR")
         else:
             editor = read_pipe("git var GIT_EDITOR").strip()
@@ -1762,7 +1762,7 @@ def edit_template(self, template_file):
 
     def get_diff_description(self, editedFiles, filesToAdd, symlinks):
         # diff
-        if os.environ.has_key("P4DIFF"):
+        if "P4DIFF" in os.environ:
             del(os.environ["P4DIFF"])
         diff = ""
         for editedFile in editedFiles:
@@ -2085,7 +2085,7 @@ def exportGitTags(self, gitTags):
             logMessage = extractLogMessageFromGitCommit(name)
             values = extractSettingsGitLog(logMessage)
 
-            if not values.has_key('change'):
+            if 'change' not in values:
                 # a tag pointing to something not sent to p4; ignore
                 if verbose:
                     print "git tag %s does not give a p4 commit" % name
@@ -2600,7 +2600,7 @@ def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0, origin_r
                              for path in self.cloneExclude]
         files = []
         fnum = 0
-        while commit.has_key("depotFile%s" % fnum):
+        while "depotFile%s" % fnum in commit:
             path =  commit["depotFile%s" % fnum]
 
             if [p for p in self.cloneExclude
@@ -2638,7 +2638,7 @@ def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0, origin_r
     def extractJobsFromCommit(self, commit):
         jobs = []
         jnum = 0
-        while commit.has_key("job%s" % jnum):
+        while "job%s" % jnum in commit:
             job = commit["job%s" % jnum]
             jobs.append(job)
             jnum = jnum + 1
@@ -2686,7 +2686,7 @@ def splitFilesIntoBranches(self, commit):
 
         branches = {}
         fnum = 0
-        while commit.has_key("depotFile%s" % fnum):
+        while "depotFile%s" % fnum in commit:
             path =  commit["depotFile%s" % fnum]
             found = [p for p in self.depotPaths
                      if p4PathStartsWith(path, p)]
@@ -2866,7 +2866,7 @@ def streamP4FilesCb(self, marshalled):
             else:
                 die("Error from p4 print: %s" % err)
 
-        if marshalled.has_key('depotFile') and self.stream_have_file_info:
+        if 'depotFile' in marshalled and self.stream_have_file_info:
             # start of a new file - output the old one first
             self.streamOneP4File(self.stream_file, self.stream_contents)
             self.stream_file = {}
@@ -2938,7 +2938,7 @@ def streamP4FilesCbSelf(entry):
                       cb=streamP4FilesCbSelf)
 
             # do the last chunk
-            if self.stream_file.has_key('depotFile'):
+            if 'depotFile' in self.stream_file:
                 self.streamOneP4File(self.stream_file, self.stream_contents)
 
     def make_email(self, userid):
@@ -2957,7 +2957,7 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
         gitStream.write("tag %s\n" % labelName)
         gitStream.write("from %s\n" % commit)
 
-        if labelDetails.has_key('Owner'):
+        if 'Owner' in labelDetails:
             owner = labelDetails["Owner"]
         else:
             owner = None
@@ -2973,7 +2973,7 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
         gitStream.write("tagger %s\n" % tagger)
 
         print "labelDetails=",labelDetails
-        if labelDetails.has_key('Description'):
+        if 'Description' in labelDetails:
             description = labelDetails['Description']
         else:
             description = 'Label from git p4'
@@ -3052,7 +3052,7 @@ def commit(self, details, files, branch, parent = ""):
 
         change = int(details["change"])
 
-        if self.labels.has_key(change):
+        if change in self.labels:
             label = self.labels[change]
             labelDetails = label[0]
             labelRevisions = label[1]
@@ -3141,7 +3141,7 @@ def importP4Labels(self, stream, p4Labels):
             change = p4Cmd(["changes", "-m", "1"] + ["%s...@%s" % (p, name)
                                 for p in self.depotPaths])
 
-            if change.has_key('change'):
+            if 'change' in change:
                 # find the corresponding git commit; take the oldest commit
                 changelist = int(change['change'])
                 if changelist in self.committedChanges:
@@ -3200,7 +3200,7 @@ def getBranchMapping(self):
         for info in p4CmdList(command):
             details = p4Cmd(["branch", "-o", info["branch"]])
             viewIdx = 0
-            while details.has_key("View%s" % viewIdx):
+            while "View%s" % viewIdx in details:
                 paths = details["View%s" % viewIdx].split(" ")
                 viewIdx = viewIdx + 1
                 # require standard //depot/foo/... //depot/bar/... mapping
@@ -3266,7 +3266,7 @@ def updateOptionDict(self, d):
         d["options"] = ' '.join(sorted(option_keys.keys()))
 
     def readOptions(self, d):
-        self.keepRepoPath = (d.has_key('options')
+        self.keepRepoPath = ('options' in d
                              and ('keepRepoPath' in d['options']))
 
     def gitRefForBranch(self, branch):
@@ -3576,8 +3576,8 @@ def run(self, args):
                 settings = extractSettingsGitLog(logMsg)
 
                 self.readOptions(settings)
-                if (settings.has_key('depot-paths')
-                    and settings.has_key ('change')):
+                if ('depot-paths' in settings
+                    and 'change' in settings):
                     change = int(settings['change']) + 1
                     p4Change = max(p4Change, change)
 
@@ -3950,7 +3950,7 @@ def findLastP4Revision(self, starting_point):
         for parent in (range(65535)):
             log = extractLogMessageFromGitCommit("{0}^{1}".format(starting_point, parent))
             settings = extractSettingsGitLog(log)
-            if settings.has_key('change'):
+            if 'change' in settings:
                 return settings
 
         sys.exit("could not find git-p4 commits in {0}".format(self.origin))
-- 
2.18.0.rc1.242.g61856ae69a

