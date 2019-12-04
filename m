Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89483C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527DF2073C
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucuuZIe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfLDW3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:29:48 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39345 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfLDW3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:29:46 -0500
Received: by mail-wr1-f43.google.com with SMTP id y11so1112207wrt.6
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N2pqbez6QuyRw2bMBb/v8SGaZ3M53Bs8crmhS9TCJyQ=;
        b=ucuuZIe0L7dUsjesrTS4Mv0EaOBr3HRijsdzBGdt4HtohP4D3TqlMW9ZF2gjGacLUi
         T4K/rJ28kek5RzJOveO3fI8lQaSjqw94C23nhry3+UQor7lYd9CeA3qeolYSRsUaXhgc
         DkTOwCXMWpRXXeddvb0xmn2k3fkAAmadvzxvLyQ1moc/3kbnoh/3rOq0hUyNFaD+Su2b
         qFxsvFpDIQgEt8ItlGkcutHLtczePnICnGuIs3CnZ2ctUlrqdA2x/9Kz/moFnVPgkyrl
         mqMEmELnTKkuRbxjCOD0fKsaJMhHi+lN+wvEf8FGipzXNOyFyXrRHweX5B7vG5NHlpCT
         N+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N2pqbez6QuyRw2bMBb/v8SGaZ3M53Bs8crmhS9TCJyQ=;
        b=pHNLm47xjdyQPVRavRIOeRmAJfF87YSYlBNcKy2vbtTFhknjwKQGUUFAvANF2rb/Xw
         SFI4HHdKjcDrhkXoS3fiMXAd+YBJILAwvsxyv9af+AbEMdmXQchS845shUuCu/GD3mVT
         toqH7c4dq5jp5o6mvqvpgvyHhI/Kr96SQMf7gcVSXh+it1qyUEDhhdamxr2hV+nQ0yp9
         wh29b4M4U/f8vxGXKzhuxstAattuIPoKMa52lIVPB9cam4P/n10dViT/ZecsymRoJJjx
         +840GwYybs94XNsWgIuVAH9uGamQsFjWtDyjP6GTSEuaT+cv+BzU2bZYnx0xIXuQsWyl
         84bg==
X-Gm-Message-State: APjAAAWxIAXtnhDBBEujD2EduuEvBvcapNQg08o6TmEBFMkbzfDsKV6M
        UCuli+OESvceoMlsweFu2N3SHTyp
X-Google-Smtp-Source: APXvYqzGFygr+hDpTkac/FkitSpTcpYQI8HUWz7RG87htDsca9Gs2sp3mmSli+OsLdhbS+eX60uVGA==
X-Received: by 2002:adf:f508:: with SMTP id q8mr3398517wro.334.1575498583782;
        Wed, 04 Dec 2019 14:29:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z64sm8991043wmg.30.2019.12.04.14.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 14:29:43 -0800 (PST)
Message-Id: <1bf7b073b047ca7625d0861b160a9602135f7baf.1575498578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 22:29:31 +0000
Subject: [PATCH v4 05/11] git-p4: Add new functions in preparation of usage
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

This changelist is an intermediate submission for migrating the P4 support from Python2 to Python3. The code needs access to the encodeWithUTF8() for support of non-UTF8 filenames in the clone class as well as the sync class.

Move the function encodeWithUTF8() from the P4Sync class to a stand-alone function.  This will allow other classes to use this function without instanciating the P4Sync class. Change the self.verbose reference to an optional method parameter. Update the existing references to this function to pass the self.verbose since it is no longer available on "self" since the function is no longer contained on the P4Sync class.

Modify the functions write_pipe() and p4_write_pipe() to remove the return value.  The return value for both functions is the number of bytes, but the meaning is lost under python3 since the count does not match the number of characters that may have been encoded.  Additionally, the return value was never used, so this is removed to avoid future ambiguity.

Add a new method gitConfigSet(). This method will set a value in the git configuration cache list.

Signed-off-by: Ben Keene <seraphire@gmail.com>
(cherry picked from commit affe888f432bb6833df78962e8671fccdf76c47a)
---
 git-p4.py | 60 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b283ef1029..2659531c2e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -237,6 +237,8 @@ def die(msg):
         sys.exit(1)
 
 def write_pipe(c, stdin):
+    """ Executes the command 'c', passing 'stdin' on the standard input
+    """
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
 
@@ -248,11 +250,12 @@ def write_pipe(c, stdin):
     if p.wait():
         die('Command failed: %s' % str(c))
 
-    return val
 
 def p4_write_pipe(c, stdin):
+    """ Runs a P4 command 'c', passing 'stdin' data to P4
+    """
     real_cmd = p4_build_cmd(c)
-    return write_pipe(real_cmd, stdin)
+    write_pipe(real_cmd, stdin)
 
 def read_pipe_full(c):
     """ Read output from  command. Returns a tuple
@@ -653,6 +656,38 @@ def isModeExec(mode):
     # otherwise False.
     return mode[-3:] == "755"
 
+def encodeWithUTF8(path, verbose = False):
+    """ Ensure that the path is encoded as a UTF-8 string
+
+        Returns bytes(P3)/str(P2)
+    """
+   
+    if isunicode:
+        try:
+            if isinstance(path, unicode):
+                # It is already unicode, cast it as a bytes
+                # that is encoded as utf-8.
+                return path.encode('utf-8', 'strict')
+            path.decode('ascii', 'strict')
+        except:
+            encoding = 'utf8'
+            if gitConfig('git-p4.pathEncoding'):
+                encoding = gitConfig('git-p4.pathEncoding')
+            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
+            if verbose:
+                print('\nNOTE:Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, to_unicode(path)))
+    else:    
+        try:
+            path.decode('ascii')
+        except:
+            encoding = 'utf8'
+            if gitConfig('git-p4.pathEncoding'):
+                encoding = gitConfig('git-p4.pathEncoding')
+            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
+            if verbose:
+                print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
+    return path
+
 class P4Exception(Exception):
     """ Base class for exceptions from the p4 client """
     def __init__(self, exit_code):
@@ -891,6 +926,11 @@ def gitConfigList(key):
             _gitConfig[key] = []
     return _gitConfig[key]
 
+def gitConfigSet(key, value):
+    """ Set the git configuration key 'key' to 'value' for this session
+    """
+    _gitConfig[key] = value
+
 def p4BranchesInGit(branchesAreInRemotes=True):
     """Find all the branches whose names start with "p4/", looking
        in remotes or heads as specified by the argument.  Return
@@ -2814,24 +2854,12 @@ def writeToGitStream(self, gitMode, relPath, contents):
             self.gitStream.write(d)
         self.gitStream.write('\n')
 
-    def encodeWithUTF8(self, path):
-        try:
-            path.decode('ascii')
-        except:
-            encoding = 'utf8'
-            if gitConfig('git-p4.pathEncoding'):
-                encoding = gitConfig('git-p4.pathEncoding')
-            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
-            if self.verbose:
-                print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
-        return path
-
     # output one file from the P4 stream
     # - helper for streamP4Files
 
     def streamOneP4File(self, file, contents):
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
-        relPath = self.encodeWithUTF8(relPath)
+        relPath = encodeWithUTF8(relPath, self.verbose)
         if verbose:
             if 'fileSize' in self.stream_file:
                 size = int(self.stream_file['fileSize'])
@@ -2914,7 +2942,7 @@ def streamOneP4File(self, file, contents):
 
     def streamOneP4Deletion(self, file):
         relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
-        relPath = self.encodeWithUTF8(relPath)
+        relPath = encodeWithUTF8(relPath, self.verbose)
         if verbose:
             sys.stdout.write("delete %s\n" % relPath)
             sys.stdout.flush()
-- 
gitgitgadget

