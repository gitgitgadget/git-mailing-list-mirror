Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B25C2D0C2
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C327217BA
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELNjeZMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfLGRry (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:47:54 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43869 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfLGRrw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:52 -0500
Received: by mail-wr1-f43.google.com with SMTP id d16so11276526wre.10
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=30grMjwfxMpq58Y+pNq9Q1EJrfZE2e38Cnol6jyt55s=;
        b=ELNjeZMZZiuRWNWM2Q0n838OsNCtXsUIRbTQl22hcaIppZVd46PCby4fGtUrFVNK16
         9Ro/zZj5WC5FDZxjDaOs74eNRtBvYyfSe0i5G5EAMw5NMdd3jEYSeHclW/OLmPP+eqJv
         426ixmr/MK6evPhSLPomVeMLIk+y9zxucMsL0d9XxKKdKByTdZfKT5AeJN4WdTGcX+lI
         FBFPx/G0zCyhYp8Mo/UtqyHFHCa2X18bdwee3oim7+7EA3w5iRxz/Hgn1GNr2zIF982r
         +1cMwyCHfoQvg+iDMs1HEd4d0gvQtnwIeDDZThQFdzblWWZwkmFCLYC0xtZ2FbWy/DiF
         Px/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=30grMjwfxMpq58Y+pNq9Q1EJrfZE2e38Cnol6jyt55s=;
        b=YKd9kR8H6VTOMr96zg22WYTW6HrkNMkZ78gUVXvYerMduExX5P+xKytJwJ9DlDRV8g
         qH8VvJJsoIkttoL0llPO/S1xuK+R/SNxOSTAnqTH5tKfW8AIQtLOxDZ19Clsby6OeXpq
         8tD9AtQSQq9sZHcn5KYKbY1BGy8I8JaV5C9woGsfuLUeXkbnDx77mRDRaf8q/wMWKq4e
         tbjAjhwEGcFW615MMigabjSTBGZPPCJsPtNJRYjmDdbtnNbJdOQES/yVzq+qEB0oPNXP
         MdAWNjJ14EB1N5Y6nZ0f1NgTFQ2FzBBolcovfyZNWvh3NBcne9LhxH81PaaBuTAL9xf+
         /J3w==
X-Gm-Message-State: APjAAAWhCcBAf2CFhgyCWFduxGnAbq69ZDUgolK+ieWFQ9fIl92EXjDf
        kbExmA9Y9mnIbAiF3spa9WaIPKkJ
X-Google-Smtp-Source: APXvYqx+9leW9o2Hk8ZnVcMP5nDH7oA37ChRsoks3mkI240R1NJJpHnVKnTdtBSNidFkq8yYXT2Isg==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr19501254wro.51.1575740868908;
        Sat, 07 Dec 2019 09:47:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a5sm1757918wmb.37.2019.12.07.09.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:48 -0800 (PST)
Message-Id: <11d7703e411f1dced8a34defc68922ba44c614d5.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:33 +0000
Subject: [PATCH v5 05/15] git-p4: promote encodeWithUTF8() to a global
 function
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

This changelist is an intermediate submission for migrating the P4
support from Python 2 to Python 3. The code needs access to the
encodeWithUTF8() for support of non-UTF8 filenames in the clone class as
well as the sync class.

Move the function encodeWithUTF8() from the P4Sync class to a
stand-alone function.  This will allow other classes to use this
function without instanciating the P4Sync class. Change the self.verbose
reference to an optional method parameter. Update the existing
references to this function to pass the self.verbose since it is no
longer available on "self" since the function is no longer contained on
the P4Sync class.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 52 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 3153186df0..cc6c490e2c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -27,7 +27,7 @@
 import ctypes
 import errno
 
-# support basestring in python3
+# support basestring in Python 3
 try:
     unicode = unicode
 except NameError:
@@ -46,7 +46,7 @@
 try:
     from subprocess import CalledProcessError
 except ImportError:
-    # from python2.7:subprocess.py
+    # from Python 2.7:subprocess.py
     # Exception classes used by this module.
     class CalledProcessError(Exception):
         """This exception is raised when a process run by check_call() returns
@@ -587,6 +587,38 @@ def isModeExec(mode):
     # otherwise False.
     return mode[-3:] == "755"
 
+def encodeWithUTF8(path, verbose=False):
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
@@ -2748,24 +2780,12 @@ def writeToGitStream(self, gitMode, relPath, contents):
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
@@ -2848,7 +2868,7 @@ def streamOneP4File(self, file, contents):
 
     def streamOneP4Deletion(self, file):
         relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
-        relPath = self.encodeWithUTF8(relPath)
+        relPath = encodeWithUTF8(relPath, self.verbose)
         if verbose:
             sys.stdout.write("delete %s\n" % relPath)
             sys.stdout.flush()
-- 
gitgitgadget

