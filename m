Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5521FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 15:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbdBIPHs (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 10:07:48 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36602 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbdBIPH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 10:07:29 -0500
Received: by mail-wr0-f173.google.com with SMTP id k90so85520873wrc.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 07:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48qj/plKUzfKp33lEEefm4eY1kNhXWLHKdgIBxnnOd8=;
        b=m3mar4cft7gjqMd8qV/S163D6AqRNV9sYz/vYM3vynnZZ+XSoEmsvgb89ZtRUd0Zv8
         cKhZfmpLAYK9WSdijxAXjfTnwy049x/eBA7bc5PEQFSVF1bCiDf0ReRDGo9xEq8DdPdX
         t3lZvWyW8VzgWMuYqSKD2IC7gTTbC9bsi2+BcBN+xrqNUdFNOzWawDYj7z/YQ4VVE5Bg
         E+1szOgGw3oBtklOTque91XSdTtGD97kTWSDSP5sEGmJaCs5Ir571DGGl0xYXRjUkHvQ
         LQj6REWxAtKRoQAjLfTUdXA+B/2SAAIpAx5PAyp0gm5UtS6tvTGHQaVqvwLgnLJkEftr
         5IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48qj/plKUzfKp33lEEefm4eY1kNhXWLHKdgIBxnnOd8=;
        b=PiR7p7Zm8ToIqNQbVhAuR/9psHBAKz7/xZf//M6g8sH5W5TreKAwq4hRCgtwRjNYuU
         xadRHvTrWNViJJGVKA3AKC9OxvEtncTR1o3HZBUZeC8RggB1z1IfaPYddlz3/JrdMEy8
         vx+l6OiKZLg9/p1fYMYobk3ilJe2SR2+j2JqhIPTtq8Xgl4TzTgR21ig3FIgJY4PT5Si
         NxaKfWCG2ZfnZHbLun+479KaEdIksTM28mLy//FzvOqYuBsVxG15egqKXCbvYpUtfKNB
         r3USVo7+YdAJlYMEbVz12f2Bg/GlqFraqnD5opGLWq11fHk6IGfa88ZcryLmcCoWrFWm
         qBQw==
X-Gm-Message-State: AMke39nOw7evgLzyznb5sFdZAkXKpYubgStMoIoioCxoEz4P4gSECX5WGNKbWOo/2ihS5Q==
X-Received: by 10.223.138.172 with SMTP id y41mr3310084wry.118.1486652818567;
        Thu, 09 Feb 2017 07:06:58 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id k70sm9308210wmc.3.2017.02.09.07.06.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 07:06:57 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     luke@diamand.org, gitster@pobox.com
Subject: [PATCH v2] git-p4: fix git-p4.pathEncoding for removed files
Date:   Thu,  9 Feb 2017 16:06:56 +0100
Message-Id: <20170209150656.9070-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAE5ih7-=bD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoTK02EDfg@mail.gmail.com>
References: <CAE5ih7-=bD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoTK02EDfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a9e38359e3 we taught git-p4 a way to re-encode path names from what
was used in Perforce to UTF-8. This path re-encoding worked properly for
"added" paths. "Removed" paths were not re-encoded and therefore
different from the "added" paths. Consequently, these files were not
removed in a git-p4 cloned Git repository because the path names did not
match.

Fix this by moving the re-encoding to a place that affects "added" and
"removed" paths. Add a test to demonstrate the issue.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi,

unfortunately, I missed to send this v2. I agree with Luke's review and
I moved the re-encode of the path name to the `streamOneP4File` and
`streamOneP4Deletion` explicitly.

Discussion:
http://public-inbox.org/git/CAE5ih7-=bD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoTK02EDfg@mail.gmail.com/

Thanks,
Lars


Notes:
    Base Commit: 454cb6bd52 (v2.11.0)
    Diff on Web: https://github.com/larsxschneider/git/commit/75ed3e92e2
    Checkout:    git fetch https://github.com/larsxschneider/git git-p4/fix-path-encoding-v2 && git checkout 75ed3e92e2

    Interdiff (v1..v2):

    diff --git a/git-p4.py b/git-p4.py
    index 8f311cb4e8..dac8b4955d 100755
    --- a/git-p4.py
    +++ b/git-p4.py
    @@ -2366,15 +2366,6 @@ class P4Sync(Command, P4UserMap):
                         break

             path = wildcard_decode(path)
    -        try:
    -            path.decode('ascii')
    -        except:
    -            encoding = 'utf8'
    -            if gitConfig('git-p4.pathEncoding'):
    -                encoding = gitConfig('git-p4.pathEncoding')
    -            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
    -            if self.verbose:
    -                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path)
             return path

         def splitFilesIntoBranches(self, commit):
    @@ -2427,11 +2418,24 @@ class P4Sync(Command, P4UserMap):
                 self.gitStream.write(d)
             self.gitStream.write('\n')

    +    def encodeWithUTF8(self, path):
    +        try:
    +            path.decode('ascii')
    +        except:
    +            encoding = 'utf8'
    +            if gitConfig('git-p4.pathEncoding'):
    +                encoding = gitConfig('git-p4.pathEncoding')
    +            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
    +            if self.verbose:
    +                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path)
    +        return path
    +
         # output one file from the P4 stream
         # - helper for streamP4Files

         def streamOneP4File(self, file, contents):
             relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
    +        relPath = self.encodeWithUTF8(relPath)
             if verbose:
                 size = int(self.stream_file['fileSize'])
                 sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
    @@ -2511,6 +2515,7 @@ class P4Sync(Command, P4UserMap):

         def streamOneP4Deletion(self, file):
             relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
    +        relPath = self.encodeWithUTF8(relPath)
             if verbose:
                 sys.stdout.write("delete %s\n" % relPath)
                 sys.stdout.flush()

 git-p4.py                       | 24 ++++++++++++++----------
 t/t9822-git-p4-path-encoding.sh | 16 ++++++++++++++++
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index fd5ca52462..dac8b4955d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2418,11 +2418,24 @@ class P4Sync(Command, P4UserMap):
             self.gitStream.write(d)
         self.gitStream.write('\n')

+    def encodeWithUTF8(self, path):
+        try:
+            path.decode('ascii')
+        except:
+            encoding = 'utf8'
+            if gitConfig('git-p4.pathEncoding'):
+                encoding = gitConfig('git-p4.pathEncoding')
+            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
+            if self.verbose:
+                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path)
+        return path
+
     # output one file from the P4 stream
     # - helper for streamP4Files

     def streamOneP4File(self, file, contents):
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
+        relPath = self.encodeWithUTF8(relPath)
         if verbose:
             size = int(self.stream_file['fileSize'])
             sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
@@ -2495,16 +2508,6 @@ class P4Sync(Command, P4UserMap):
             text = regexp.sub(r'$\1$', text)
             contents = [ text ]

-        try:
-            relPath.decode('ascii')
-        except:
-            encoding = 'utf8'
-            if gitConfig('git-p4.pathEncoding'):
-                encoding = gitConfig('git-p4.pathEncoding')
-            relPath = relPath.decode(encoding, 'replace').encode('utf8', 'replace')
-            if self.verbose:
-                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, relPath)
-
         if self.largeFileSystem:
             (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)

@@ -2512,6 +2515,7 @@ class P4Sync(Command, P4UserMap):

     def streamOneP4Deletion(self, file):
         relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
+        relPath = self.encodeWithUTF8(relPath)
         if verbose:
             sys.stdout.write("delete %s\n" % relPath)
             sys.stdout.flush()
diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index 7b83e696a9..c78477c19b 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -51,6 +51,22 @@ test_expect_success 'Clone repo containing iso8859-1 encoded paths with git-p4.p
 	)
 '

+test_expect_success 'Delete iso8859-1 encoded paths and clone' '
+	(
+		cd "$cli" &&
+		ISO8859="$(printf "$ISO8859_ESCAPED")" &&
+		p4 delete "$ISO8859" &&
+		p4 submit -d "remove file"
+	) &&
+	git p4 clone --destination="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git -c core.quotepath=false ls-files >actual &&
+		test_must_be_empty actual
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '

base-commit: 454cb6bd52a4de614a3633e4f547af03d5c3b640
--
2.11.0

