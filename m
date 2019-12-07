Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324EEC2BBE2
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05845217BA
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo5FW7mD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfLGRsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:48:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36355 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfLGRrx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so11345686wru.3
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z3oyfxleLGsd3u4DfBh7GyxAd22AsIddLqrP+H0OSzE=;
        b=Xo5FW7mDsxR9YuYw97+peyEfobwyPQkHDEwclPmHHLGs8D2+5GbeC+eko5zT0oU0Bu
         9SiUOk632xEJx1TgNZqE0KImdPIGRtVb07uf30MrUgwEC0SVdI5qKP1SluesKgOvEHhA
         W24rMeQ5bMEli2Rzfs8lvOEOT7C50KvR3LLXWaza0PbBgO/tFNyX/yfqqvf1ag1Qk7eM
         fp0eddRioha7TMmAWKThwgpKSR4uFI2r2lfy0ow43qaunhbvff2v4i5xvAWNk1RfA2RD
         MfmAnnnC5HholY8tcZLDSWXzDtPkbhpo1PCbn7oloQnRhDPTmleZezKI+kSZsmAlM2vv
         V58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z3oyfxleLGsd3u4DfBh7GyxAd22AsIddLqrP+H0OSzE=;
        b=j6jvOxq4bKjvt5EEHL4ZUnxzBF65+sUOQcouNmD1/RyPSXvVncs+7m/ybyzk0iWeu0
         t1z1vBEOCc08TcnvWhlM7/3ODqEsyayMlu50hHUBy5K9hMElcg3HhR03awCPorynnMs6
         wjh25FBrkX9WWWNyOtHII9zAfkMCGgszLaZ5tsRdqtZ8tQL4oiuUFMzZCMOzAhvrs1px
         KYlLJWHHuxxNL+I9SuNYWNlJWQVbZkBrXVJANQeXwKxh68RKlLJTomX65p6j2LxDHsT/
         tubsQyl6YPavs6Hr+f3T/s/VRaMJeIeGTuJj1+z43+7tcREJOwn0ZO/DhzFtp/Qp0GW/
         92xw==
X-Gm-Message-State: APjAAAWp3lAd85sqMdpmlsiIWBL15TojjG4DwvbRwPwRtYzNTCDVMttw
        xoEiu5EiQgj2o7nsLosWuTFpe6I7
X-Google-Smtp-Source: APXvYqwq3Wvb2ivQ2behwHreZCD1EaTTdE6x4/CfuCinKe4o4LZ/VRAYJChZkIn28Mh9z9F3I3QeEQ==
X-Received: by 2002:adf:f20b:: with SMTP id p11mr21243310wro.195.1575740872513;
        Sat, 07 Dec 2019 09:47:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm19791993wrt.37.2019.12.07.09.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:51 -0800 (PST)
Message-Id: <b962cce8cd455d4cc561b14b4f498d5553067985.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:38 +0000
Subject: [PATCH v5 10/15] git-p4: fix assumed path separators to be more
 Windows friendly
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

When a computer is configured to use Git for windows and Python for
windows, and not a Unix subsystem like cygwin or WSL, the directory
separator changes and causes git-p4 to fail to properly determine paths.

Fix 3 path separator errors:

1. getUserCacheFilename() - should not use string concatenation. Change
   this code to use os.path.join to build an OS tolerant path.

2. defaultDestiantion used the OS.path.split to split depot paths.  This
   is incorrect on windows. Change the code to split on a forward
   slash(/) instead since depot paths use this character regardless  of
   the operating system.

3. The call to isValidGitDir() in the main code also used a literal
   forward slash. Change the code to use os.path.join to correctly
   format the path for the operating system.

These three changes allow the suggested windows configuration to
properly locate files while retaining the existing behavior on
non-windows operating systems.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index fc6c9406c2..1838045078 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1459,8 +1459,10 @@ def p4UserIsMe(self, p4User):
             return True
 
     def getUserCacheFilename(self):
+        """ Returns the filename of the username cache
+        """
         home = os.environ.get("HOME", os.environ.get("USERPROFILE"))
-        return home + "/.gitp4-usercache.txt"
+        return os.path.join(home, ".gitp4-usercache.txt")
 
     def getUserMapFromPerforceServer(self):
         if self.userMapFromPerforceServer:
@@ -3978,13 +3980,16 @@ def __init__(self):
         self.cloneBare = False
 
     def defaultDestination(self, args):
+        """ Returns the last path component as the default git
+            repository directory name
+        """
         ## TODO: use common prefix of args?
         depotPath = args[0]
         depotDir = re.sub("(@[^@]*)$", "", depotPath)
         depotDir = re.sub("(#[^#]*)$", "", depotDir)
         depotDir = re.sub(r"\.\.\.$", "", depotDir)
         depotDir = re.sub(r"/$", "", depotDir)
-        return os.path.split(depotDir)[1]
+        return depotDir.split('/')[-1]
 
     def run(self, args):
         if len(args) < 1:
@@ -4257,8 +4262,8 @@ def main():
                         chdir(cdup);
 
         if not isValidGitDir(cmd.gitdir):
-            if isValidGitDir(cmd.gitdir + "/.git"):
-                cmd.gitdir += "/.git"
+            if isValidGitDir(os.path.join(cmd.gitdir, ".git")):
+                cmd.gitdir = os.path.join(cmd.gitdir, ".git")
             else:
                 die("fatal: cannot locate git repository at %s" % cmd.gitdir)
 
-- 
gitgitgadget

