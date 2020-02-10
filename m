Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3707BC352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6052072C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sze/NYbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBJWGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:06:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41843 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgBJWGW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:06:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so9745807wrw.8
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 14:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j7D3DIc+ayzTK8uxUbVZtmcbThmrh6EhkQI8RDciGE0=;
        b=sze/NYbtPtccRPbJkAt2rFTPKGMRE2KIEBDXadWPd6afoE3huGQivRIgBn4pwp8H9K
         OxJLeImw2q78DcqiPphCfl1Y8wdD+a4zzY9HF5C/z+MyoOEaELHx/imLXz/eW2eSyowE
         g/F0UV2VYjEE1s6dt0thDUXsTaHMCPCWtVho9WaCl+lDLFUYZc7IFrhfQmcQrSihY+i2
         86FiUvvVG6qcDKlO7/Wfc1aMP/GX69wbgHMlbsh0bNWqRyzC2LParqK+v7k6jDAir2jL
         aR3OPj88pl/ouDSlQDMe37rKQmbDWXtl6WJmIPJUo5VqD3RMMTixaxr3ApkIF7s7GIi6
         TZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j7D3DIc+ayzTK8uxUbVZtmcbThmrh6EhkQI8RDciGE0=;
        b=cYGpCqVtwmylwEhADSyjuWgEs/xcLxUWU7V2/ODlZMLHKDXpY3y3q36F/wK6UtM/rX
         gdAs4giuZn5YtwP4mQ+AZbtMz7GYZN1Gui4LTm13f+eVz6H/8cUwtDXmDzLwrvJWm0Nt
         6B8RtVmwf0x3Ba8B4fv0kMhmZ4EmsQD3qjbctkgqccrkzP354Ayyq1jtIBUsN4qdDvpS
         3Ny9wJPKljkBn9uXFfdoq1fB3nNUcm1UpEFUbV2bnzGZM5P4lA7McqPOvO6SUhLK+wbp
         sJaNgoAsfKUm1ph42dmPFCyueA8dusDKor8mz7SMgu/lYMjFkRf+5Lfg+reEDI2VJl2P
         VLiw==
X-Gm-Message-State: APjAAAVMcPyccl6DpgC+oq6Pja41IKltq+cSvSUwkIKPQLpjWvrOWLLV
        09kabRmavZ4fDEmIrwe3d+jrZQdb
X-Google-Smtp-Source: APXvYqzZuFi+iAuK+NF7LBZMfLDDWF/SOXwcwHW9fh2T4NFINcZRvvYzKHjiAk56Y9MWklDhhxZwBg==
X-Received: by 2002:adf:f091:: with SMTP id n17mr3884976wro.387.1581372380966;
        Mon, 10 Feb 2020 14:06:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s65sm890998wmf.48.2020.02.10.14.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:06:20 -0800 (PST)
Message-Id: <57a6166ed1884e22a46d60b61c9cae88f0cc6abb.1581372376.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
References: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
        <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 22:06:13 +0000
Subject: [PATCH v4 3/6] git-p4: add --no-verify option
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
 git-p4.py                  | 13 +++++++++----
 3 files changed, 21 insertions(+), 7 deletions(-)

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
index b1c86678fc..58551bcb09 100755
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
-- 
gitgitgadget

