Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F173BC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61652073C
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkBieDct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfLDW3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:29:44 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:52713 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfLDW3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:29:44 -0500
Received: by mail-wm1-f43.google.com with SMTP id p9so1482848wmc.2
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JcaZgyysud3FVYO9lXHt87MA5RbnQXWDEH6oMQULAD0=;
        b=hkBieDctosvHMaNWd5LVissrmI7M5Kwnxi/pUpj84sFoq1EHr5YRj9xCeJbo78qt3d
         u8FHjXcA2vWevrM1vvYHyjUGO8XwwL4tSreiS3PcwD57gW5EwGY7htn8yFOv20LdDD1r
         mtX7+/OzNm3/abS5pntmp/jeS7f8yULtK6ooDPHV7bOhal7XD7Y/Cl36d8zmymsKieKF
         wGBWYpu+g336DshFOyoHS3bKGK8V4o1aXituoaRxayebFedPLTG9aBEgDIbJRyJawQei
         Ah5YEa6N1DyQ0RjoIOSP7hPd6nXLCLvayvOIuc9O2UziXxSK2JNJHv732/cku54SVlD/
         FoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JcaZgyysud3FVYO9lXHt87MA5RbnQXWDEH6oMQULAD0=;
        b=qVUkW6GM5m6iauWmGGpUYKwDlHyC7xX7A1rVae2jQXGCFjqozUPnYTrbKLqhpUZK5j
         vfrNOMe4gQwnZlIPaebw+NVEisn8afc6+bZjYfXrOqFisQ1NI06EjWoZuK10wRh7IQWE
         w282mB8M+oeL18CvwgBzvyq/rTkOhHj2SeS8vUnU6pBfstQcv/lWOQGPj9E436PPUWs3
         bgdaVAfCepl+cjnLDyifu4wJwfQFR04YFvNiEMmxPAYJmbJx7PXGyLk7EDf05rUernC6
         ZktPQQZQKKymOpyrIbG3lPNwaYi2/jSzUqEEt6GIU/WPw16pKwRh0e3W6BaBTczwgNlN
         Ul7Q==
X-Gm-Message-State: APjAAAXmdUyOxtS46vhr5oQE7WQPD9k43w70suJOtC3UyPkl7bfp2COQ
        BRP033DYQOv4OHkylVQl/5QxFAiO
X-Google-Smtp-Source: APXvYqxSrNUCCEyxT3d33L1gxQggq99D5xnQrCzORY7inLxsyQPPM0/o4SgRiSGm59yQE9HVCKHbmQ==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr2009290wmb.164.1575498581177;
        Wed, 04 Dec 2019 14:29:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n30sm8156843wmd.3.2019.12.04.14.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 14:29:40 -0800 (PST)
Message-Id: <0ef2f56b04803cad2e60bf881e86d8bdd69463a6.1575498577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 22:29:28 +0000
Subject: [PATCH v4 02/11] git-p4: change the expansion test from basestring to
 list
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

Python 3+ handles strings differently than Python 2.7.  Since Python 2 is reaching it's end of life, a series of changes are being submitted to enable python 3.7+ support. The current code fails basic tests under python 3.7.

Change references to basestring in the isinstance tests to use list instead. This prepares the code to remove all references to basestring.

The original code used basestring in a test to determine if a list or literal string was passed into 9 different functions.  This is used to determine if the shell should be evoked when calling subprocess methods.

Signed-off-by: Ben Keene <seraphire@gmail.com>
(cherry picked from commit 5b1b1c145479b5d5fd242122737a3134890409e6)
---
 git-p4.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b2ffbc057b..0f27996393 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -109,7 +109,7 @@ def p4_build_cmd(cmd):
         # Provide a way to not pass this option by setting git-p4.retries to 0
         real_cmd += ["-r", str(retries)]
 
-    if isinstance(cmd,basestring):
+    if not isinstance(cmd, list):
         real_cmd = ' '.join(real_cmd) + ' ' + cmd
     else:
         real_cmd += cmd
@@ -175,7 +175,7 @@ def write_pipe(c, stdin):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
 
-    expand = isinstance(c,basestring)
+    expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdin=subprocess.PIPE, shell=expand)
     pipe = p.stdin
     val = pipe.write(stdin)
@@ -197,7 +197,7 @@ def read_pipe_full(c):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
-    expand = isinstance(c,basestring)
+    expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
     (out, err) = p.communicate()
     return (p.returncode, out, err)
@@ -233,7 +233,7 @@ def read_pipe_lines(c):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
-    expand = isinstance(c, basestring)
+    expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
     pipe = p.stdout
     val = pipe.readlines()
@@ -276,7 +276,7 @@ def p4_has_move_command():
     return True
 
 def system(cmd, ignore_error=False):
-    expand = isinstance(cmd,basestring)
+    expand = not isinstance(cmd, list)
     if verbose:
         sys.stderr.write("executing %s\n" % str(cmd))
     retcode = subprocess.call(cmd, shell=expand)
@@ -288,7 +288,7 @@ def system(cmd, ignore_error=False):
 def p4_system(cmd):
     """Specifically invoke p4 as the system command. """
     real_cmd = p4_build_cmd(cmd)
-    expand = isinstance(real_cmd, basestring)
+    expand = not isinstance(real_cmd, list)
     retcode = subprocess.call(real_cmd, shell=expand)
     if retcode:
         raise CalledProcessError(retcode, real_cmd)
@@ -526,7 +526,7 @@ def getP4OpenedType(file):
 # Return the set of all p4 labels
 def getP4Labels(depotPaths):
     labels = set()
-    if isinstance(depotPaths,basestring):
+    if not isinstance(depotPaths, list):
         depotPaths = [depotPaths]
 
     for l in p4CmdList(["labels"] + ["%s..." % p for p in depotPaths]):
@@ -613,7 +613,7 @@ def isModeExecChanged(src_mode, dst_mode):
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         errors_as_exceptions=False):
 
-    if isinstance(cmd,basestring):
+    if not isinstance(cmd, list):
         cmd = "-G " + cmd
         expand = True
     else:
@@ -630,7 +630,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     stdin_file = None
     if stdin is not None:
         stdin_file = tempfile.TemporaryFile(prefix='p4-stdin', mode=stdin_mode)
-        if isinstance(stdin,basestring):
+        if not isinstance(stdin, list):
             stdin_file.write(stdin)
         else:
             for i in stdin:
-- 
gitgitgadget

