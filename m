Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084A3C352A5
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C850C2072C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdoDzN66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBJWG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:06:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53635 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbgBJWGX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:06:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so1002375wmh.3
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 14:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bOUIBs7f2iCCZHwxqxEuT2fL/KTg4gohWHfnQhleO7s=;
        b=HdoDzN66LzpMpeeKvUn7njC+H3znHZgf5yjUvDkgFge4LXta18ecEgca8czeQ3Rm3Q
         O2CoRWpvgvziOys6yDcHIcmMwFa6nua2oKNJsWeQCOpXw9n7pLDV2qxp9f+phQhjBbnG
         96HVJFDVZp7aBHImAC9ukhi2EWD3JL7h8ed75X7ScRMz5bG21xUT+PnxrwYxgxq4Zlv/
         AJEhlYxgis7gp64J7ApawnCMKb38mWbgXOPcEbwj63pupbGrccFXycoR5zp8UshPGk0h
         cqhDZ03hb8s5pU5qrneD65/Wve4ChY7Lmgk5qyxjmveeo8M8KaIGg0ORH/MfARxQqU1+
         F+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bOUIBs7f2iCCZHwxqxEuT2fL/KTg4gohWHfnQhleO7s=;
        b=T/77yscrzFBfC6kTqCTGBJk+rUMuDgVp0pJb+VotvZdgFCf8372mG7wO03CsHhDnm2
         2rzWVApDJrvWtj7Svd0ZrBeQT4ZU3SahE04rC/CAKMcstHB5G5/Z76wTVvjFca4AQsgx
         /pygQr8TsVIS5Or8Q/Ck5XqOYWmO0n7qO8E4sIa5dGgtsPv/DuP+vrQYMZ518HEgLe41
         dXLzYzR465YxupZVwGyjb/C53NLzKUFckq/pJEM6zZebPnhvF/sfwsbeZO3MM/m9L/+8
         L2t5hka6RbE5tfJN6u9JddfjW17waC11KWTuWn5ZutStBMtXL6n9uhPaBnAqkF1FECCR
         8elw==
X-Gm-Message-State: APjAAAU4SRonUshXcTWQD47dAfoo+W919msmiuSCB+iMuD1j0tuO6EQ0
        ny1tdyIL2EvNiCqEXnzo08+2LU64
X-Google-Smtp-Source: APXvYqxgn9D4AlrqThb/VaxkrA1IHWY/WTMpX78fD91+1AfXL71SQta4Bjjm5GwU+mH3uOd5t0dEwA==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr1156437wmf.105.1581372379874;
        Mon, 10 Feb 2020 14:06:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm2356348wrt.1.2020.02.10.14.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:06:19 -0800 (PST)
Message-Id: <596b18e5e50a956d9c52ad4a90fab3e6d309d356.1581372376.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
References: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
        <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 22:06:12 +0000
Subject: [PATCH v4 2/6] git-p4: create new function run_git_hook
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

This commit is in preparation of introducing new p4 submit hooks.

The current code in the python script git-p4.py makes the assumption
that the git hooks can be executed by subprocess.call() function.
However, when git is run on Windows, this may not work as expected.

The subprocess.call() does not cover all the use cases for properly
executing the various types of executable files on Windows.

Prepare for remediation by adding a new function, run_git_hook, that
takes 2 parameters:
* the short filename of an optionally registered git hook
* an optional list of parameters

The run_git_hook function will honor the existing behavior seen in the
current code for executing the p4-pre-submit hook:

* Hooks are looked for in core.hooksPath directory.
* If core.hooksPath is not set, then the current .git/hooks directory
  is checked.
* If the hook does not exist, the function returns True.
* If the hook file is not accessible, the function returns True.
* If the hook returns a zero exit code when executed, the function
  return True.
* If the hook returns a non-zero exit code, the function returns False.

Add the following additional functionality if git-p4.py is run on
Windows.
* If hook file is not located without an extension, search for
  any file in the associated hook directory (from the list above) that
  has the same name but with an extension.
* If the file is still not found, return True (the hook is missing)

Add a new function run_hook_command() that wraps the OS dependent
functionality for actually running the subprocess.call() with OS
dependent behavior:

If a hook file exists on Windows:
* If there is no extension, set the launch executable to be SH.EXE
  - Look for SH.EXE under the environmental variable EXEPATH in the
    bin/ directory.
  - If %EXEPATH%/bin/sh.exe exists, use this as the actual executable.
  - If %EXEPATH%/bin/sh.exe does not exist, use sh.exe
  - Execute subprocess.call() without the shell (shell=False)
* If there is an extension, execute subprocess.call() with teh shell
  (shell=True) and consider the file to be the executable.

The return value from run_hook_command() is the subprocess.call()
return value.

These functions are added in this commit, but are only staged and not
yet used.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 65b6d4dca0..b1c86678fc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -26,6 +26,7 @@
 import zlib
 import ctypes
 import errno
+import glob
 
 # support basestring in python3
 try:
@@ -185,6 +186,73 @@ def prompt(prompt_text):
         if response in choices:
             return response
 
+def run_git_hook(cmd, param=[]):
+    """Execute a hook if the hook exists."""
+    if verbose:
+        sys.stderr.write("Looking for hook: %s\n" % cmd)
+        sys.stderr.flush()
+
+    hooks_path = gitConfig("core.hooksPath")
+    if len(hooks_path) <= 0:
+        hooks_path = os.path.join(os.environ["GIT_DIR"], "hooks")
+
+    if not isinstance(param, list):
+        param=[param]
+
+    # resolve hook file name, OS depdenent
+    hook_file = os.path.join(hooks_path, cmd)
+    if platform.system() == 'Windows':
+        if not os.path.isfile(hook_file):
+            # look for the file with an extension
+            files = glob.glob(hook_file + ".*")
+            if not files:
+                return True
+            files.sort()
+            hook_file = files.pop()
+            while hook_file.upper().endswith(".SAMPLE"):
+                # The file is a sample hook. We don't want it
+                if len(files) > 0:
+                    hook_file = files.pop()
+                else:
+                    return True
+
+    if not os.path.isfile(hook_file) or not os.access(hook_file, os.X_OK):
+        return True
+
+    return run_hook_command(hook_file, param) == 0
+
+def run_hook_command(cmd, param):
+    """Executes a git hook command
+       cmd = the command line file to be executed. This can be
+       a file that is run by OS association.
+
+       param = a list of parameters to pass to the cmd command
+
+       On windows, the extension is checked to see if it should
+       be run with the Git for Windows Bash shell.  If there
+       is no file extension, the file is deemed a bash shell
+       and will be handed off to sh.exe. Otherwise, Windows
+       will be called with the shell to handle the file assocation.
+
+       For non Windows operating systems, the file is called
+       as an executable.
+    """
+    cli = [cmd] + param
+    use_shell = False
+    if platform.system() == 'Windows':
+        (root,ext) = os.path.splitext(cmd)
+        if ext == "":
+            exe_path = os.environ.get("EXEPATH")
+            if exe_path is None:
+                exe_path = ""
+            else:
+                exe_path = os.path.join(exe_path, "bin")
+            cli = [os.path.join(exe_path, "SH.EXE")] + cli
+        else:
+            use_shell = True
+    return subprocess.call(cli, shell=use_shell)
+
+
 def write_pipe(c, stdin):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
@@ -2337,12 +2405,15 @@ def run(self, args):
             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
                      (len(commits), num_shelves))
 
-        hooks_path = gitConfig("core.hooksPath")
-        if len(hooks_path) <= 0:
-            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
-
-        hook_file = os.path.join(hooks_path, "p4-pre-submit")
-        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
+        try:
+            if not run_git_hook("p4-pre-submit"):
+                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
+                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
+                    "however,\nthis will also skip the p4-changelist hook as well.")
+                sys.exit(1)
+        except Exception as e:
+            print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
+                "with the error '{0}'".format(e.message) )
             sys.exit(1)
 
         #
@@ -4124,7 +4195,6 @@ def printUsage(commands):
     "unshelve" : P4Unshelve,
 }
 
-
 def main():
     if len(sys.argv[1:]) == 0:
         printUsage(commands.keys())
-- 
gitgitgadget

