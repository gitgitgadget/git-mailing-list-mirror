Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE75C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398F121739
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnqpPmzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgBKS6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:58:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44226 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgBKS6L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 13:58:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so13763156wrx.11
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vw5qC2GoztL0B9O6MLGAEj6794odm2BdjiURoalFecE=;
        b=KnqpPmzkrR00QF7rsStwzSEl056xQAx+GoZDIzqtJsCH0usMhaecFn8uGa3B19JFCE
         Y3T8/sW/MFqC3XUeyWpIKFUvqm83rZYel+KnAVkSlcHo7IQC0+osV5X7pyY+IESoqSuC
         Xvr3Kk2608mdGf/6m+3AOorAX7ltjFy/pZ3gk9VYEOe+fXAsjz9MOVOwx6S/+IU0eDO4
         WIXu/vBD9pTP6ExdfMf9Jv65cyxeUedOdW1GzOLomEaXoBgV/zH/B8PLT61B435BVP+7
         BTcFoMOweX98B71039dWiyK8T0GKqD6ICgOGECLUVF14l+dnSXO7oDv+tVPwuY9xsU4l
         HfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vw5qC2GoztL0B9O6MLGAEj6794odm2BdjiURoalFecE=;
        b=YfmSbJ26jtHPa09k5pA5YFyyUSBwZU11WIv8jZkj4zyqhkL8MsrmRa3oS8fnXXszgK
         LO+rju/MP5YvO1zFjkmj9StIDZTFEl6v7OwfyD/KV43JVNNgV9HdChSMri+fxatnvHky
         /kdNxM4XCBbbQX8oID0I0mC5/5hGzR7C17aA8OJs6AFWXp9cvKfM+UyCAolzLfmSJr6W
         2MEEiTcdFknvS8XOmawFFvCONhRWL3ce1kkIVSBkT0FDkZ9MopH2FMsxJGhbDoAcqRLo
         j3ETivNRkGlQdPG68mgshKPPQIjjRPhCtsWmwVVpPc496jpL5GVzXL3P7Ey7ypUl5+ua
         Okng==
X-Gm-Message-State: APjAAAXtBh5Rt0oTRFGcieiYArc2J4MKMW9Iv1pD0Y9cUASM80hfpQLA
        agBnBxN/ivNP3g4Yakndwe4tY9jF
X-Google-Smtp-Source: APXvYqwwxmdbEpTIJrPhI+UZWEQlAZHBSHyA/FpQAZUQmoqYME6THsGfsmzegZm7cQgPtNul0ax4Fg==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr9957238wru.173.1581447489411;
        Tue, 11 Feb 2020 10:58:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14sm6461879wrm.28.2020.02.11.10.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 10:58:08 -0800 (PST)
Message-Id: <05b8c7ad673ec465ade93c53261fd83dd7cbbce0.1581447485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
References: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
        <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 18:58:01 +0000
Subject: [PATCH v5 4/7] git-p4: add --no-verify option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Add new command line option --no-verify:

Add a new command line option "--no-verify" to the Submit command of
git-p4.py.  This option will function in the spirit of the existing
--no-verify command line option found in git commit. It will cause the
P4 Submit function to ignore the existing p4-pre-submit.

Change the execution of the existing trigger p4-pre-submit to honor the
--no-verify option. Before exiting on failure of this hook, display
text to the user explaining which hook has failed and the impact
of using the --no-verify option.

Change the call of the p4-pre-submit hook to use the new run_git_hook
function. This is in preparation of additional hooks to be added.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 Documentation/git-p4.txt   | 10 ++++++++--
 Documentation/githooks.txt |  5 ++++-
 git-p4.py                  | 32 +++++++++++++++++++-------------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 3494a1db3e..362b50eb21 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -374,14 +374,20 @@ These options can be used to modify 'git p4 submit' behavior.
     been submitted. Implies --disable-rebase. Can also be set with
     git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
 
-Hook for submit
-~~~~~~~~~~~~~~~
+Hooks for submit
+----------------
+
+p4-pre-submit
+~~~~~~~~~~~~~
+
 The `p4-pre-submit` hook is executed if it exists and is executable.
 The hook takes no parameters and nothing from standard input. Exiting with
 non-zero status from this script prevents `git-p4 submit` from launching.
+It can be bypassed with the `--no-verify` command line option.
 
 One usage scenario is to run unit tests in the hook.
 
+
 Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 rebase' behavior.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 50365f2914..8cf6b08b55 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -520,7 +520,10 @@ p4-pre-submit
 
 This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
 from standard input. Exiting with non-zero status from this script prevent
-`git-p4 submit` from launching. Run `git-p4 submit --help` for details.
+`git-p4 submit` from launching. It can be bypassed with the `--no-verify`
+command line option. Run `git-p4 submit --help` for details.
+
+
 
 post-index-change
 ~~~~~~~~~~~~~~~~~
diff --git a/git-p4.py b/git-p4.py
index b1c86678fc..c969d9235b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1588,13 +1588,17 @@ def __init__(self):
                                      "work from a local git branch that is not master"),
                 optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
                                      help="Skip Perforce sync of p4/master after submit or shelve"),
+                optparse.make_option("--no-verify", dest="no_verify", action="store_true",
+                                     help="Bypass p4-pre-submit"),
         ]
         self.description = """Submit changes from git to the perforce depot.\n
-    The `p4-pre-submit` hook is executed if it exists and is executable.
-    The hook takes no parameters and nothing from standard input. Exiting with
-    non-zero status from this script prevents `git-p4 submit` from launching.
+    The `p4-pre-submit` hook is executed if it exists and is executable. It
+    can be bypassed with the `--no-verify` command line option. The hook takes
+    no parameters and nothing from standard input. Exiting with a non-zero status
+    from this script prevents `git-p4 submit` from launching.
 
-    One usage scenario is to run unit tests in the hook."""
+    One usage scenario is to run unit tests in the hook.
+    """
 
         self.usage += " [name of git branch to submit into perforce depot]"
         self.origin = ""
@@ -1612,6 +1616,7 @@ def __init__(self):
         self.exportLabels = False
         self.p4HasMoveCommand = p4_has_move_command()
         self.branch = None
+        self.no_verify = False
 
         if gitConfig('git-p4.largeFileSystem'):
             die("Large file system not supported for git-p4 submit command. Please remove it from config.")
@@ -2405,16 +2410,17 @@ def run(self, args):
             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
                      (len(commits), num_shelves))
 
-        try:
-            if not run_git_hook("p4-pre-submit"):
-                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
-                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
-                    "however,\nthis will also skip the p4-changelist hook as well.")
+        if not self.no_verify:
+            try:
+                if not run_git_hook("p4-pre-submit"):
+                    print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
+                        "this pre-submission check by adding\nthe command line option '--no-verify', " \
+                        "however,\nthis will also skip the p4-changelist hook as well.")
+                    sys.exit(1)
+            except Exception as e:
+                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
+                    "with the error '{0}'".format(e.message) )
                 sys.exit(1)
-        except Exception as e:
-            print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
-                "with the error '{0}'".format(e.message) )
-            sys.exit(1)
 
         #
         # Apply the commits, one at a time.  On failure, ask if should
-- 
gitgitgadget

