Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DFCC433FE
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326A161027
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhJOJqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbhJOJqA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:46:00 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E21C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id y3so25584352wrl.1
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2IfnekGUFQv+RuEJuq7vz1NTBNJbzmG1J0vDxTvH/uU=;
        b=XVSMSFkQ8Sib9/YB6Xr91ambWDB/tOHoc/JL03a7Ce20ZNied+QmGV1fUGBswZWE91
         Ftem+2up0z+vlsqK6R2lQT5hTsYHAcX7jjm2/Anrb/xSapHyUJLXKWK8bgyqwbTn5+tW
         Or8rKi9wxUWcfxtDKgx2nIyL1PoeC5waA6h3NIc/Ns59O+Kyl+jqm1ZxbIVW0juzp2cY
         zDDHo31Tj3mW3QHwmxgI3f47IMNe7SzDIbn3mUTaLkR7nyMPFiycwKkJJB3QxgZQvW9o
         NwwGeuGpb6yWRQv3s0tFtzNgL1rdVYQBTuiFyKpePuYUpzRsB35g4PDRnq5Lk6aACYS/
         dqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2IfnekGUFQv+RuEJuq7vz1NTBNJbzmG1J0vDxTvH/uU=;
        b=6lNpfy94OsHEoQGPlBMiEmO+oc0baycaH2F1bHd/3rAj/ZvexqzZ0Bc3s9C8+M/mRv
         765jyMLuSp2aqvx4OyoukAUEqQTTLjmnKkFUN4UbHN03AVNMDPodHIc4KMjazEoD1DGH
         q7//RRAnLusgAvbLAOgs99EBUvswazzp2nV3RAld0Yb8zQN7PkVdWgj2LSX5QW5ns1TT
         RTq8/Qdd5bwoEVIywYUoynpc3kqnNMtTHcdTPnuYNDY0C0KDgWfSUSXz0JsCre7KGT5h
         9ZrTMJimLabtuYovjQnDbrtOpj/8xlg8sOBVNyHO18hig0xe5OyTbp1EKm4ZDv3ZtPZ3
         9YwA==
X-Gm-Message-State: AOAM532yefbim+yHxf4H/aB7xEQKfqB8LjUP7GBcilXg7hyHP2/zhyjW
        OPV7+oupclXaQLSjdC9jqyShVBcVj23flg==
X-Google-Smtp-Source: ABdhPJyywVbBdfuA+lfMvYjGU6l56/ACgdeKvAUHySflsfz2iem9hQQRuJC5P+J42OAd3h9qcTBJMQ==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr12974820wri.253.1634291032794;
        Fri, 15 Oct 2021 02:43:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm5963648wrz.58.2021.10.15.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:43:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/13] git-p4: use 'git hook' to run hooks
Date:   Fri, 15 Oct 2021 11:43:37 +0200
Message-Id: <patch-v2-09.13-b1f52733e3c-20211015T093918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Instead of duplicating the behavior of run-command.h:run_hook_le() in
Python, we can directly call 'git hook run'. We emulate the existence
check with the --ignore-missing flag.

As this is the last hook execution in git.git to not go through "git
hook run" or the hook.[ch] library we can now be absolutely sure that
our assertion in hook.c that only hooks known by the generated (from
githooks(5)) hook-list.h are permitted.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-p4.py | 72 ++++++-------------------------------------------------
 1 file changed, 7 insertions(+), 65 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226aa..1f24cbf0bca 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -207,71 +207,13 @@ def decode_path(path):
         return path
 
 def run_git_hook(cmd, param=[]):
-    """Execute a hook if the hook exists."""
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
-        return True
-
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
-
+    """args are specified with -a <arg> -a <arg> -a <arg>"""
+    args = ['git', 'hook', 'run', '--ignore-missing', cmd]
+    if param:
+        args.append("--")
+        for p in param:
+            args.append(p)
+    return subprocess.call(args) == 0
 
 def write_pipe(c, stdin):
     if verbose:
-- 
2.33.1.1338.g20da966911a

