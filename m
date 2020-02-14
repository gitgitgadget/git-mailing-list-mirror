Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFEBC2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6372187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSkpPmT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbgBNOow (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:44:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42613 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgBNOov (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 09:44:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so11171648wrd.9
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 06:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uUqGfofknPcEAQ5nvTP1fA2W60P4i7uhCRCHfpO2L5s=;
        b=LSkpPmT+Abr5kKt4FsQ9Y7KeQHf1P6aeyzuBkuF40HaS3ICkdgYRtCEl/6Vm7MhHBp
         AGQU3gdESHOJOSASUDdjtvLHOYFC8UA39JfiFYfUGp3rI3wmvn0+QdVAH/46RTXcsyTd
         4zTiAlIZdPnoNRTulQjdwf+/t3dATg1tlNmk10GHKSwuCvRCZx94ocI+dOqH5vetniJx
         k+yJwUmQPeKqgNzZey57u5L5tO6jSbaMTOCdU0Q13jsFAXROTi3PzHWF6YTDQNaU9nCN
         es90jnpu7ec7+XUM4IFeDoaGMqazIuWvp7IaXHcsfx4yhwYPxxP8kJFFBmAnFxhqYCSu
         pQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uUqGfofknPcEAQ5nvTP1fA2W60P4i7uhCRCHfpO2L5s=;
        b=Pu9zKvDsBd2kuB3rY+hIRVpCXZUhzxtI90MAveon1+TtHXGhNXJ2zTa2DYb/e2/Ao7
         a405M1RfwcLRDNSEC0uXapIzIvU58MVbxzKd1bJC36CAHkUIWDRqk7KEudEzhuJ28o9P
         xvDAidTuLt7OZbshV01dyKSRya37b/ubBypCxivcWK6xt5630J1sicJsk3JKNIczqjmG
         fwYpCguDJ237bbUjlBelYMYtwVUK62UcweldXFIVuUUPuNMRNTfBFCrfMAwRJRzVWEUl
         DVFFcsyqH9tkLYQbVxhdGzvXgUHkt9ESAGERP2CUgEfXr5r6Wg1omX2lES0ev3sEctxq
         Urhg==
X-Gm-Message-State: APjAAAX6hLkMYQbUnM0pBywZUNsx0v5Plhhg+0u3TRJqLzzl7fRaL2jo
        XLWM/C9Ysk8JGupNN94I0YXAaa+W
X-Google-Smtp-Source: APXvYqxE0qKvavcp01iVEHQOhMz682Kx0AQQmFHAnbvF+JvLhKMkh4vY5Q2SOj7ZQMYq+d55VnSV+Q==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr4314399wrj.261.1581691489187;
        Fri, 14 Feb 2020 06:44:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm7446748wmg.46.2020.02.14.06.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 06:44:48 -0800 (PST)
Message-Id: <72c3d642a9749fa0072bf1dbd5c652c8866d30b1.1581691486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
References: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
        <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Feb 2020 14:44:41 +0000
Subject: [PATCH v6 2/7] git-p4: create new function run_git_hook
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
 git-p4.py | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 65b6d4dca08..4eccea3fa58 100755
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
@@ -2337,12 +2405,7 @@ def run(self, args):
             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
                      (len(commits), num_shelves))
 
-        hooks_path = gitConfig("core.hooksPath")
-        if len(hooks_path) <= 0:
-            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
-
-        hook_file = os.path.join(hooks_path, "p4-pre-submit")
-        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
+        if not run_git_hook("p4-pre-submit"):
             sys.exit(1)
 
         #
@@ -4124,7 +4187,6 @@ def printUsage(commands):
     "unshelve" : P4Unshelve,
 }
 
-
 def main():
     if len(sys.argv[1:]) == 0:
         printUsage(commands.keys())
-- 
gitgitgadget

