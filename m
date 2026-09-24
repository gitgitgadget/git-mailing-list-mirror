Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FA23ED5C3
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238486; cv=none; b=SylDs669HR89boOf4KarYmcOf7nQevki0HMpiTWur/TloLtQHbg50nsyXQKvyPxU7IwKaUTcTbbqS8VF2+LTyk/I6poMW5F2FUjFn7EO8hJQ3ZWsS8p7VoVd9LBO7RugGbYLjLSMsdZd4iPjSY8Ae+z4cjqz7inAQnmng2diT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238486; c=relaxed/simple;
	bh=5AVNsoucjNkxrhFhdpigUIwDl9habqHNoRQfh7Q2GxI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qyfrMEU24DFzpqnqPwRtdlux2erDHI0iSf9hS2/yK6w6IEIPpsvqnHxEZ+f2NH1Djoej5fvdNYYmrCyMIG3MRkvlYufZ6W4kV2dp4EJXrQaLHUxgWHbdG0HQVHfYAacfc7GgUEJeSwcnR5AanuZOTTxHRGx4mxsO46swXucU/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peo2qeLH; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peo2qeLH"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3115c4451c8so490787eec.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238484; x=1790843284; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t8ydUMmKKyrLfrfa0vfpLEKISeB7YBxOqFsuEe/JNvA=;
        b=peo2qeLHRccW4+4ScPRxsUP0/3UsgviDzRxcP13zn/SLRsyzxM6sfrdsn8MirCvifU
         WWbY/JakuhuJPGF1pgRt4YrrXYBsNpeCwwxpb+b1PyHgQsgC6oF+1mZpqwCDET1+ckcT
         p8Fn3ZTOzC5x4kmYR37VZyBuRk9cnl0/NcNFm70anP5aU4mM3yh5Yp09bXLYivwLWduy
         1h6OU6xBaAg2zqSov8nqin7M2sBFULeZnWV56rfW+OkG6o1HbDc2G0SiLNqxrkoNgtTH
         5mTlN7hNvzldV1Z8wHvbtyyEJ9d+eV8bHKIZV7DUavI799+4QZHok/ikrmnAeu/HbQQp
         yNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238484; x=1790843284;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8ydUMmKKyrLfrfa0vfpLEKISeB7YBxOqFsuEe/JNvA=;
        b=qJ2u28mIfTGiIT4O3wVot51D1YTpDUCyQyotNarr0+S6ezgTj+QJ1YSaAoOaIitbQH
         8Ga8dCJ355WHYEIfOr+gupx8RhQ/14w9oT/pjQohLFeYEakXSiFRaR6xHDadegGH3QXZ
         V8U4nyZtfFgWVEwRdbZ3pvB9/9+5aCR5tPWtfCqGOuNuiUPkkjUbtbAoqZgMS5ie2dcu
         MK2hEE8/F3/5Ny7uO/+tMZb13WFRRyykLH+V4JP22K7kpu8iAZXbL4g2a32re5/OwwTC
         rhy2XO388kdeZibp4HQHUZaIAyoWo9mLOsy0aIWkzcooveFab/Z6FRJeBqVwml9on83g
         K6Tw==
X-Gm-Message-State: AFuF++k9k5k3CESvql0xNi8SRouGcS8DeIPfUghWGSNliCbbl6r/AVxb
	n7ui91jwnKfRXKbLT9KlNFH6D5xntHbEOpQ4b/Po4dd1P7T81jW4EtVcVC0wyVLU
X-Gm-Gg: AYBFou27JV44pT0NsLYuCr0cvv8XV+7RpQypL2Vyh5Lcfoi3jD1QMwzT46v7sq4f9la
	RhPb5/b+E4rkAyFp29+B87PkyO7AesjbygLQy9qPCGBR/i45yk4OLzZhhVaWYFrkC9RfKw+28IS
	qpNmWfPYLYYEhCymxfuTjJzOszOiE4B98UMWx9KAqqDUBizZwloivSG5TEAjeGAZkspApP0y8BT
	VXO5SemOUTL7dKE7yreWRfAWuk+qTqcxxykmT3VUSa9lZ5nuJ7NclELeShGSlZ0w+xBkFWlQl6l
	pFDdQvS7IET9dUzU6u5Xdqa/ikxMATdyOcsl8duHcSniQoGyzN4EDWYbTmdyPiXT496xVR77Yxc
	44WZRgUGh+Elst/HrLuAHhmo0tAD8jSw7hc1RarH+k3jHh01yRfYvsmojGpM7aJnlZfKM8mt8VZ
	3Xv5B8cVjXOhLceagClI7AcnujTMYQpEEGKqO7V8l1ucDeFUi6hOW0nlcsJouC+e5n35pTphnbx
	/M=
X-Received: by 2002:a05:7300:4fa6:b0:33c:1941:8f8e with SMTP id 5a478bee46e88-34005966077mr1152997eec.13.1790238483794;
        Thu, 24 Sep 2026 01:28:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.46.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7bf6bsm11355900eec.8.2026.09.24.01.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:28:03 -0700 (PDT)
Message-Id: <pull.2411.v2.git.git.1790238482045.gitgitgadget@gmail.com>
In-Reply-To: <pull.2411.git.git.1790093506966.gitgitgadget@gmail.com>
References: <pull.2411.git.git.1790093506966.gitgitgadget@gmail.com>
From: "Anupam Mediratta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 08:28:02 +0000
Subject: [PATCH v2] git-p4: avoid shell interpretation of commit ids in
 applyCommit
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Anupam Mediratta <mediratta@gmail.com>,
    Anupam Mediratta <mediratta@gmail.com>

From: Anupam Mediratta <mediratta@gmail.com>

applyCommit() builds a `git diff-tree ... | git apply ...` pipeline as a
shell command string, interpolating the commit id and running it via
os.system()/system(shell=True). The id usually comes from `git rev-list`
output (safe, plain SHA-1s), but it can also come verbatim from the
user-supplied `--commit` option, which is never validated
(git-p4.py:2620-2631). A value such as `$(some-command)` passed to
`--commit` is executed by the shell during command substitution, even
though the value is wrapped in double quotes.

Replace the shell pipeline with two argument-vector subprocess calls
connected directly through a pipe, matching the pattern already used
throughout this file (read_pipe, read_pipe_lines, p4_system). This
removes the shell entirely, rather than relying on quoting the
interpolated value.

The shell-based call that applied the patch for real went through
git-p4.py's own system() helper, which raises CalledProcessError on a
non-zero exit status, so a failed apply aborted the submit. Keep that
behaviour by giving the new helper the same ignore_error contract
system() uses: it raises unless the caller asks for the status, and the
two callers that test the status for themselves ask for it.

Add a regression test exercising `git p4 submit --commit` with a shell
metacharacter payload, verifying it is never interpreted.

Signed-off-by: Anupam Mediratta <mediratta@gmail.com>
---
    git-p4: avoid shell interpretation of commit ids in applyCommit
    
    P4Submit.applyCommit() builds a git diff-tree | git apply pipeline as a
    shell command string and runs it with os.system()/system(shell=True).
    The commit id it interpolates is usually a plain SHA-1 from git
    rev-list, but it can also come straight from the unvalidated --commit
    command-line option, so a value such as $(some-command) passed to
    --commit gets executed by the shell during command substitution.
    
    This replaces the shell pipeline with two argument-vector subprocess
    calls connected directly through a pipe, the same pattern already used
    everywhere else in this file (read_pipe, read_pipe_lines, p4_system), so
    there's no shell left to escape correctly. It also adds a regression
    test in t9803 that submits a commit id crafted with shell metacharacters
    and checks they're never executed.
    
    I have read https://git-scm.com/docs/SubmittingPatches#ai and confirm
    this contribution complies with it.
    
    Changes since v1: as Junio pointed out, the call that applies the patch
    for real used to go through git-p4.py's own system() helper, which
    raises CalledProcessError on a non-zero exit status, so a failed git
    apply aborted the submit; v1 dropped that and silently carried on. The
    new helper now takes the same ignore_error argument system() does and
    raises by default, and the two callers that inspect the exit status
    themselves pass ignore_error=True.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2411%2Fanupamme%2Ffix-repo-git-git-p4-cwe-78-shell-injection-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2411/anupamme/fix-repo-git-git-p4-cwe-78-shell-injection-v2
Pull-Request: https://github.com/git/git/pull/2411

Range-diff vs v1:

 1:  391e429a2a ! 1:  6fcacc71b8 git-p4: avoid shell interpretation of commit ids in applyCommit
     @@ Commit message
          removes the shell entirely, rather than relying on quoting the
          interpolated value.
      
     +    The shell-based call that applied the patch for real went through
     +    git-p4.py's own system() helper, which raises CalledProcessError on a
     +    non-zero exit status, so a failed apply aborted the submit. Keep that
     +    behaviour by giving the new helper the same ignore_error contract
     +    system() uses: it raises unless the caller asks for the status, and the
     +    two callers that test the status for themselves ask for it.
     +
          Add a regression test exercising `git p4 submit --commit` with a shell
          metacharacter payload, verifying it is never interpreted.
      
     @@ git-p4.py: def p4_system(cmd, *k, **kw):
               raise subprocess.CalledProcessError(retcode, real_cmd)
       
       
     -+def diffTreeApply(id, applyArgs):
     ++def diffTreeApply(id, applyArgs, ignore_error=False):
      +    """Pipe `git diff-tree --full-index -p <id>` into `git apply <applyArgs>`
      +    without a shell, so id can never be interpreted as shell syntax. Returns
     -+    the exit status of git apply."""
     ++    the exit status of git apply, raising CalledProcessError on a non-zero
     ++    status unless ignore_error is set."""
      +    diffArgv = ["git", "diff-tree", "--full-index", "-p", id]
      +    applyArgv = ["git", "apply"] + applyArgs
      +    if verbose:
     @@ git-p4.py: def p4_system(cmd, *k, **kw):
      +    diffProc.stdout.close()
      +    applyProc.wait()
      +    diffProc.wait()
     -+    return applyProc.returncode
     ++    retcode = applyProc.returncode
     ++    if retcode and not ignore_error:
     ++        raise subprocess.CalledProcessError(retcode, applyArgv)
     ++    return retcode
      +
      +
       def die_bad_access(s):
     @@ git-p4.py: class P4Submit(Command, P4UserMap):
      -            print("TryPatch: %s" % tryPatchCmd)
      -
      -        if os.system(tryPatchCmd) != 0:
     -+        if diffTreeApply(id, tryPatchArgs) != 0:
     ++        if diffTreeApply(id, tryPatchArgs, ignore_error=True) != 0:
                   fixed_rcs_keywords = False
                   patch_succeeded = False
                   print("Unfortunately applying the change failed!")
     @@ git-p4.py: class P4Submit(Command, P4UserMap):
                   if fixed_rcs_keywords:
                       print("Retrying the patch with RCS keywords cleaned up")
      -                if os.system(tryPatchCmd) == 0:
     -+                if diffTreeApply(id, tryPatchArgs) == 0:
     ++                if diffTreeApply(id, tryPatchArgs, ignore_error=True) == 0:
                           patch_succeeded = True
                           print("Patch succeesed this time with RCS keywords cleaned")
       


 git-p4.py                         | 35 ++++++++++++++++++++++---------
 t/t9803-git-p4-shell-metachars.sh | 16 ++++++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c0ca7becaf..e716831554 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -465,6 +465,26 @@ def p4_system(cmd, *k, **kw):
         raise subprocess.CalledProcessError(retcode, real_cmd)
 
 
+def diffTreeApply(id, applyArgs, ignore_error=False):
+    """Pipe `git diff-tree --full-index -p <id>` into `git apply <applyArgs>`
+    without a shell, so id can never be interpreted as shell syntax. Returns
+    the exit status of git apply, raising CalledProcessError on a non-zero
+    status unless ignore_error is set."""
+    diffArgv = ["git", "diff-tree", "--full-index", "-p", id]
+    applyArgv = ["git", "apply"] + applyArgs
+    if verbose:
+        print("TryPatch: %s | %s" % (" ".join(diffArgv), " ".join(applyArgv)))
+    diffProc = subprocess.Popen(diffArgv, stdout=subprocess.PIPE)
+    applyProc = subprocess.Popen(applyArgv, stdin=diffProc.stdout)
+    diffProc.stdout.close()
+    applyProc.wait()
+    diffProc.wait()
+    retcode = applyProc.returncode
+    if retcode and not ignore_error:
+        raise subprocess.CalledProcessError(retcode, applyArgv)
+    return retcode
+
+
 def die_bad_access(s):
     die("failure accessing depot: {0}".format(s.rstrip()))
 
@@ -2234,16 +2254,11 @@ class P4Submit(Command, P4UserMap):
             else:
                 die("unknown modifier %s for %s" % (modifier, path))
 
-        diffcmd = "git diff-tree --full-index -p \"%s\"" % (id)
-        patchcmd = diffcmd + " | git apply "
-        tryPatchCmd = patchcmd + "--check -"
-        applyPatchCmd = patchcmd + "--check --apply -"
+        tryPatchArgs = ["--check", "-"]
+        applyPatchArgs = ["--check", "--apply", "-"]
         patch_succeeded = True
 
-        if verbose:
-            print("TryPatch: %s" % tryPatchCmd)
-
-        if os.system(tryPatchCmd) != 0:
+        if diffTreeApply(id, tryPatchArgs, ignore_error=True) != 0:
             fixed_rcs_keywords = False
             patch_succeeded = False
             print("Unfortunately applying the change failed!")
@@ -2279,7 +2294,7 @@ class P4Submit(Command, P4UserMap):
 
             if fixed_rcs_keywords:
                 print("Retrying the patch with RCS keywords cleaned up")
-                if os.system(tryPatchCmd) == 0:
+                if diffTreeApply(id, tryPatchArgs, ignore_error=True) == 0:
                     patch_succeeded = True
                     print("Patch succeesed this time with RCS keywords cleaned")
 
@@ -2291,7 +2306,7 @@ class P4Submit(Command, P4UserMap):
         #
         # Apply the patch for real, and do add/delete/+x handling.
         #
-        system(applyPatchCmd, shell=True)
+        diffTreeApply(id, applyPatchArgs)
 
         for f in filesToChangeType:
             p4_edit(f, "-t", "auto")
diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
index 2913277013..ef8fd6e094 100755
--- a/t/t9803-git-p4-shell-metachars.sh
+++ b/t/t9803-git-p4-shell-metachars.sh
@@ -105,4 +105,20 @@ test_expect_success 'branch with shell char' '
 	)
 '
 
+test_expect_success 'git p4 submit --commit does not execute shell metachars in commit id' '
+	git p4 clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEditCheck true &&
+		echo f3 >file3 &&
+		git add file3 &&
+		git commit -m "add file3" &&
+		name='"'"'$(touch${IFS}injection-marker)'"'"' &&
+		git branch "$name" HEAD &&
+		P4EDITOR="test-tool chmtime +5" git p4 submit --commit "$name"
+	) &&
+	test_path_is_missing "$cli/injection-marker"
+'
+
 test_done

base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
gitgitgadget
