Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14920C47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF916128D
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhE0AMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbhE0AL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:28 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D375C061763
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:48 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id o14-20020a05620a0d4eb02903a5eee61155so1822985qkl.9
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XoaFu9RjJSgGuLhD0KFOCrlNkYT8AahKe3FsNktkh5o=;
        b=Q8ouFtMakxxOFF6QpPXVdp99beqBBoKkByZi7M/tVJQDQrqkIWskhg/3L11+9aWhxF
         DMKARGtYdTlgZBn6oZk5HI+rzTIVBqQ/PcGmP/IdmTehOTl/s2YuuC9MfVtnjXb7RKtj
         tNADYFtSnlVb53RApgOIjKyvClI42biiEJo1VkJJdCQm06Xo+ULUMCuLzL+LFT0+I8Ky
         B3+Twt+RseJXWde2Zafy2sujTN/h4FLXZZRVDav/7KlWACn0PQ1kR7uI5rfgrIhWHCcY
         b2esWbgjGmn63Y+/4n15mYWiFcbuN3GTQVspU5ImYj0N/kfpIcoY8P5cde3Of3qHF7z9
         mwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XoaFu9RjJSgGuLhD0KFOCrlNkYT8AahKe3FsNktkh5o=;
        b=DGKCq5zK3WpPK+gV95br+mDU4fbQaGRlhZdv+obOw+k5YVH4QsJct+IhjHilT7Jyyv
         tTBvYmarLLLEPBQ68PB8nLZ6Au6BVxMNO2MpJNUw2Ban9DdrB2+KktkeHyYrXwqpzx2C
         RCcl8//WxNcAKB03dWCMxcn1bRHAgA8iwPtu0Sw/+79FOWswDbnklaeIQt7+eH7bMszO
         GdIIfkZeGx7kRP+eT879hQYpUWYO8R4aVZGkLhtzTm3qfuw9WU1+e92MBeekOU0ZcNSl
         i1buHuIs49Yt/aWKy0qg3AnEBV8qa90VhphSHQhrXyVqBhRygmzNCKw2GEnStdMh23v8
         Sr5g==
X-Gm-Message-State: AOAM5328DIvTbSM8uX7jSe9OVP13DoRze1N0aAzcBPP9o42JWTuSllhQ
        mS3OP/HcZnK2IcDJsi2pjXBvXHMgBUDz42l1MwIL/4k7nMhGgSw32GydzINw07f0754jP3xstay
        +rH2MNo/B8i9xodg/3dIGCDxr7dgNKvRl77mil3C8Zu5EAcDl647UoWx8y/8OhOF862UOPgUr0g
        ==
X-Google-Smtp-Source: ABdhPJzq5GzLLsa+0fk0kodVExYaUYlSGipXYeKfwieUn9GouwG0G5L/tcuyWAfPDAw+27IeT5lhF1Q34YBO1bpYskA=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:1421:: with SMTP id
 o1mr529752qvx.33.1622074187489; Wed, 26 May 2021 17:09:47 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:43 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-25-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 24/37] git-p4: use 'git hook' to run hooks
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
index d34a1946b7..b7192d1153 100755
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
2.31.1.818.g46aad6cb9e-goog

