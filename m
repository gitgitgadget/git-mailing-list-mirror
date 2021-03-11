Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7554C4360C
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC8B64F95
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCKCMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhCKCLr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:47 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B9FC061761
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:36 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id k185so14272178qkb.17
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SnF4+xvrJCimJCe+8zZxVyDOEtpGuUX/xjX/UPmE6mw=;
        b=O79uHMcbCTzeUFlBR1lykYS2oBdPTzcM6rPrK8SjeW9oDj9kcQyVNL88UXVLbb1zvR
         aVR8tVutQS1yAOZrN1Z6vAs8EK+Tjvi1rOmmj5LmMBkVFpWYBKBqbbwS+e+j4NnpR+AL
         ag83MVvLC5275vtgxOgRHclvDzVjvE1zhvZUVSFKOUV9Npg+jiG/K9PJrrsqeWnuVO7X
         VE3k6t0owXFNLVQuh839IYprtH+m1yFxp/Roy2zlvE7OINJcY+x4sN+AXi01dSU8P/eT
         2IeYV9bLbx0k4lOvLfX5jf5m8bTUlJXhqj5xVS+om+ZvbXu5It1w41Tn3pmpFNk4x3en
         oSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SnF4+xvrJCimJCe+8zZxVyDOEtpGuUX/xjX/UPmE6mw=;
        b=hZzjCqnW9h02ZVZhZZzI3T0CLzVF4YP+OufFSqZPUODqiaKkqLvM+EituoImD/mb+u
         WNkUmD62L8nut+GkzYM2173eyXhl1ssh9qeNAiu8A5xqpMTEU8oBsmTUAyLFmo4PFHGL
         TF/phnL1YXfR3I85aeokvI6iaInG9xc5aQFEyHsMFsudh6ZWK15dqiVUa+W2cDKJYdar
         Dfny1DVFevUSYux66IoxdpHCxA7UJsETqBuEfYmJ2FufUgI/ZMFTTqC3E/0EAHKHGurC
         ZfgmSloUQVpIR8vOVu4a9zQ9jEabaxy3sANDm2j/1Rj+r1C+MMXK/3vyI+B5+EuoSEZd
         JUUQ==
X-Gm-Message-State: AOAM532TYA9o9dmer1gfaenmDN5ktFSXH8Uqzm5xfoPRYw0Sy9n8szSv
        cKFFVfkg4KLAxb/sOvUizQE2aKb3KdAD9Q7W7uO1t7yoWPQVqPAXxXVfWGpo0H9XAWDY9yk13Ax
        kDfmVKE2j8FVpXUJh4mfBKuasaEDYWnjOB8Pc1IXnkbG7NBMflBRCIKR7H6pE6hk1+VBmEld7+w
        ==
X-Google-Smtp-Source: ABdhPJw/cud39csES+05Q1FjqUbk9hF2CJkcfxssVLySJ6Bp9yW8AFkpSUkTwNYd38+O36TOM+UXhBgdQOSyi8B88Tg=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:fd41:: with SMTP id
 j1mr4089072qvs.29.1615428695384; Wed, 10 Mar 2021 18:11:35 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:25 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-26-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 25/37] git-p4: use 'git hook' to run hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of duplicating the behavior of run-command.h:run_hook_le() in
Python, we can directly call 'git hook run'. As a bonus, this means
git-p4 learns how to find hook specifications from the Git config as
well as from the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Maybe there is a better way to do this - I had a hard time getting this to run
    locally, and Python is not my forte, so if anybody has a better approach I'd
    love to just take that patch instead :)
    
    Since v6, removed the developer debug print statements.... :X
    
    Maybe there is a better way to do this - I had a hard time getting this to run
    locally, and Python is not my forte, so if anybody has a better approach I'd
    love to just take that patch instead :)

 git-p4.py | 67 +++++--------------------------------------------------
 1 file changed, 6 insertions(+), 61 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 09c9e93ac4..4b1c69822c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -208,70 +208,15 @@ def decode_path(path):
 
 def run_git_hook(cmd, param=[]):
     """Execute a hook if the hook exists."""
-    if verbose:
-        sys.stderr.write("Looking for hook: %s\n" % cmd)
-        sys.stderr.flush()
-
-    hooks_path = gitConfig("core.hooksPath")
-    if len(hooks_path) <= 0:
-        hooks_path = os.path.join(os.environ["GIT_DIR"], "hooks")
-
-    if not isinstance(param, list):
-        param=[param]
-
-    # resolve hook file name, OS depdenent
-    hook_file = os.path.join(hooks_path, cmd)
-    if platform.system() == 'Windows':
-        if not os.path.isfile(hook_file):
-            # look for the file with an extension
-            files = glob.glob(hook_file + ".*")
-            if not files:
-                return True
-            files.sort()
-            hook_file = files.pop()
-            while hook_file.upper().endswith(".SAMPLE"):
-                # The file is a sample hook. We don't want it
-                if len(files) > 0:
-                    hook_file = files.pop()
-                else:
-                    return True
-
-    if not os.path.isfile(hook_file) or not os.access(hook_file, os.X_OK):
+    if not cmd:
         return True
 
-    return run_hook_command(hook_file, param) == 0
-
-def run_hook_command(cmd, param):
-    """Executes a git hook command
-       cmd = the command line file to be executed. This can be
-       a file that is run by OS association.
-
-       param = a list of parameters to pass to the cmd command
-
-       On windows, the extension is checked to see if it should
-       be run with the Git for Windows Bash shell.  If there
-       is no file extension, the file is deemed a bash shell
-       and will be handed off to sh.exe. Otherwise, Windows
-       will be called with the shell to handle the file assocation.
-
-       For non Windows operating systems, the file is called
-       as an executable.
-    """
-    cli = [cmd] + param
-    use_shell = False
-    if platform.system() == 'Windows':
-        (root,ext) = os.path.splitext(cmd)
-        if ext == "":
-            exe_path = os.environ.get("EXEPATH")
-            if exe_path is None:
-                exe_path = ""
-            else:
-                exe_path = os.path.join(exe_path, "bin")
-            cli = [os.path.join(exe_path, "SH.EXE")] + cli
-        else:
-            use_shell = True
-    return subprocess.call(cli, shell=use_shell)
+    """args are specified with -a <arg> -a <arg> -a <arg>"""
+    args = (['git', 'hook', 'run'] +
+	    ["-a" + arg for arg in param] +
+	    [cmd])
 
+    return subprocess.call(args) == 0
 
 def write_pipe(c, stdin):
     if verbose:
-- 
2.31.0.rc2.261.g7f71774620-goog

