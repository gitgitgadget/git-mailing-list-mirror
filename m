Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229FFC3B1A0
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E308E24649
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ilt+04Vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbgBNOo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:44:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37718 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387421AbgBNOoz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 09:44:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so10903548wme.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nn8NEkjsKQAY7KAdevbPz0Qu2jcUWo6F6jKeN/6cKNs=;
        b=Ilt+04VbwJZN4xyJcJqusdUaRGuruzVET0giOQOQdVDIHylkCgKFcROTulkeE3IjKg
         Es9O0WDvqpnv3ng5fdBU5WmUEPFjc70PKocjWabMasDSrnLqtPoP+0aOX4Yk8Gu6ZFmf
         PwDVT6fvIqlyMlmvkfc6mdcSVU/4zoaRckeO67LwWzmREItPEp7X+vjRlHgwSMbKldGb
         LQT1WpcNcfBhSkbebq0u0Rfn4oVcTKsEW7hiDlC3PH3lBF36btM3fmQDRsi6jTuowMZN
         waqfCQtB09cqEMO/1OPE7uA2mbNUyz1/krsV0uQdOCEaBs+xiS8jg6QRddmO48roBkkp
         fizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nn8NEkjsKQAY7KAdevbPz0Qu2jcUWo6F6jKeN/6cKNs=;
        b=EkCK5XEhp3nPeg1Ufjog1nOin+5wv5SVkU/vlrQTlmHPJnK7yxQ+4cR1a+CuYoquGS
         dAGG454Fintt1L2/euWsAGauCK542BEa0RPKEeIqR+bEgiyMLrYtwST8vnfu5TC6ExsG
         fM4UMRvkgCQBsaX9TjBangi4QCFjiChjHUouCWj7fkNe2YvwMOU3L0d6kwFtX9lzzcq/
         1dqK+KPtss2i8iqsFZEObyB/yQ0ECh0jCI82wJHKtHLyJNGKixRxITguB6KsVH5L0hoc
         5bZLqqO0z1euDdmBL8BPJYuXb3Vtva7YxXT04jtM21pKtIWMdcyUxFsikB2+fDWw4/E8
         6qFA==
X-Gm-Message-State: APjAAAXeNB71RBhS9gp9npIGsqh8la7PkJ+W88zDKkB4pB9sEYsnkWWb
        jkfspQ/LrpECimIdZZwU0MspUbb8
X-Google-Smtp-Source: APXvYqz53HzSczbA/ltBl4s7Jx04yfg1Ja/ebyd2amy7/5ck6enewLQEFc+d52jiZZ0juJJDWBH79Q==
X-Received: by 2002:a05:600c:2406:: with SMTP id 6mr5084889wmp.30.1581691491148;
        Fri, 14 Feb 2020 06:44:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm7404519wrq.16.2020.02.14.06.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 06:44:50 -0800 (PST)
Message-Id: <cf4de224f8ad7239efdf3eb0d0edd49bbde1db44.1581691486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
References: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
        <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Feb 2020 14:44:43 +0000
Subject: [PATCH v6 4/7] git-p4: add --no-verify option
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
index 3494a1db3eb..362b50eb212 100644
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
index 50365f2914e..8cf6b08b55b 100644
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
index b1c86678fc6..c969d9235b1 100755
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

