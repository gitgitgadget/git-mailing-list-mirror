Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A28C352A2
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 15:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D576A217BA
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUTocnrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBFPPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:15:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46416 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBFPPy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 10:15:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so7615744wrl.13
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 07:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=muuHikLOVSl7IcahZd1vEc4AR0nGLF8yZaa2PccH3j8=;
        b=NUTocnrvcwM3vBCtDkTA56BK+XDunRsCU77U8WOvec+GhAURWgOXqNo7Cn8bauEFW+
         MaAUElH4NRgKEWV8OE/NmNtHpKwNkxj07zP9bzOrJJU/JoYbN1zYSGJ2kPemSxriNgKV
         lGx+F2DgSgs1zPO7XH6kGe5aMcv4CiAXPtEwFCiSSoTgE5s9L4Sg9er1ZMv4DQtKSABz
         lYRwOd1ehgaajJ7rKaStvCOED2irvqE3PhTRqDbSVkmSTr3y11YZ8B1gpPCUUxj6kaGS
         miEvQba8loVl6TRxHbr5Z7/fc1qeNkGMnQXOTFrl9XiyqrvahSgVUUmgWeX59qCxrSwr
         S/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=muuHikLOVSl7IcahZd1vEc4AR0nGLF8yZaa2PccH3j8=;
        b=OXulhx8tVzBEY7t+tLTNXfjKetzzpxU6Fm/i8J5uk0lUJ+LlxfCvVJci50ZGY+fqaA
         73qyO2v85XXN9BmlzyUo95M14GiklxXJQd5+3VJuJJk6C6PZp9CgHdKMNHRAJk43Ld5s
         eDemICtgx3y4/b3SYyItDS1OA0mj6TE/yEUAL+uAAks3zMmTy1aFNP49Zw4xnloJKE12
         qs4tNcCBcgJq/PPkJgZogP1MQS53xz5W+aM7NDeu7pheaR26F7js+gB8jeZ66u5WIpDa
         Qt4SOoJmNOtO25lVEVtWZuPd7th3xAkWESzhSGK2tvL+WpO+dw8iIzgR9V0TWwSDT5/J
         784A==
X-Gm-Message-State: APjAAAW5YbMu+Q2+/kLIT/k/krgJnC/sUeCaFrHT91ux965+D3cDxoHz
        MPqpOG1PrUnRO2bsnLcck0+5tz5Y
X-Google-Smtp-Source: APXvYqyls1pDwhgjDzJSYLtjYClXvBAjxaE6nP2TkPZogq95/LFNzLVmy7hz8Dq8QlX3gIyvYgDaiw==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr4472141wrs.247.1581002152253;
        Thu, 06 Feb 2020 07:15:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm4074808wmj.2.2020.02.06.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:15:51 -0800 (PST)
Message-Id: <85918a7edb6482cc1c555917075f8cfd2f18ba32.1581002149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
References: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
        <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 15:15:45 +0000
Subject: [PATCH v3 2/5] git-p4: create new function run_git_hook
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
 git-p4.py | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 7d8a5ee788..d4c39f112b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -26,6 +26,7 @@
 import zlib
 import ctypes
 import errno
+import glob
 
 # support basestring in python3
 try:
@@ -186,6 +187,67 @@ def prompt(prompt_text):
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
+        hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
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
+            hook_file = files[0]
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
@@ -4125,7 +4187,6 @@ def printUsage(commands):
     "unshelve" : P4Unshelve,
 }
 
-
 def main():
     if len(sys.argv[1:]) == 0:
         printUsage(commands.keys())
-- 
gitgitgadget

