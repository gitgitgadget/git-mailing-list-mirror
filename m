Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB3541E70
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093510; cv=none; b=qZe7QIJq9HAoDc/P6MwVPB1igfb646awCjKOlawtPY0Xo6ZaLVkqcVq2YlX9+3q5ch4BGRZGomSzLcfzV3Cz0H0Kfo1rQWjqOgOb4kKPCRkjSmitAkNWv5WUCzmp2zdbHFd7wcxuFSfQzLxmwR3V3llmqQXjh4F60eynXRgkViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093510; c=relaxed/simple;
	bh=T2pB0cRs2fxKqri/dJTDK+RUasZM6ZdWwSA2Qgi26M4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=bRNpWnINIivOXFNwNX4FSiQE/brt/XqVGr8Hc1vrW8clVYpQ/cm+HFGuBc6/LbckIyCrtp2KnJ1cNkCY1nZDvW0L+9yXCYV8uPtx045tEqrjNvC6JTnTtJ4CtFRgLHcHFze04y8PaOMWp5GI93Hh6KSO0yDRkmX6uc5zWavWiMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZW2SftA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZW2SftA"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so28436a91.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790093509; x=1790698309; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T4Kj5oyCZxTTLoWCU/MHtLsilf4spA3x3seZ3q05DEc=;
        b=gZW2SftAabtkOvvx0/H5Cb4mPvA1j1unTFJkOfQGyO97Na4cGrOLWeHWhKU7n/JpdR
         muoTgtC1PZz0MdAhwxnJg9/fRPvadj2cEY1duMJfigCRcRuumAWUhI0/LFBojC8k/rgE
         tNJwYPENBKXBRUbiFgChB5Erlyly8rakHWN1wgRozPp4Qc0pXGEAIRjX5PeXPfjXYQvS
         YRxHsxBs3smhtPrVnJrBX97RCZrKnhUVNL5vN1NMVdPj2cFdEPXwUyjRxnMzOuM7mLDr
         s+YJtdFoQCYhc+aeezmkChWFG37MHuXDHvmZ5WWRoMctfe7PcHLoJlRaZ81R/02tcw+F
         K2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093509; x=1790698309;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T4Kj5oyCZxTTLoWCU/MHtLsilf4spA3x3seZ3q05DEc=;
        b=kVfhyGijZePZwxNyKUJJea05wr4OJr5slemUIT7nJ3Wq3CBVN/VYxmebIy3+b8rK0E
         tbeSJZN3OK6dR19ysoGacR/3YdVFmBePihobHrAtc3adr2inFywWHNchlKnG4IXnRfGb
         0Jsi2CkPZ9mP+WAX8OSHwkqwNqidhQo2FlrMDpmhpD3FuNQnwZLrGk0fSmXrMAG3QXJc
         9TbWrTPw4p9IKFISAC43dHYRWLIs2nTlulj2eWqcW5fsQ9rLY+U5YGxv8Jg3PTJuaoIu
         C2qjVMaekDDX108mGdy6aIctbgzihI+z3yHeYLS7dB/J0VlCFHuAjZHmXkgQ+ek2u3sh
         Iw7Q==
X-Gm-Message-State: AFuF++kG8VEgcrnVW9kJSvuqNKfYgRlWuw4KoaxvKEXpMLyfPk8+SIln
	MzZp9VDJ3MlEO2fZtOw69F0nSV5VvCOp+tAH3xoVS+IShRqeqUEDORANLASrrA==
X-Gm-Gg: AYBFou1Y/KSE4geLQLO5vhipDCPl4+8LH0sdZmLqXOEGDYLBPFjEuTf4+eA9GYw4vkR
	62e2qSr2CMn3OL/lTpJtYvg/H9r6xZMs89IHHcaY8kP4MG7qijhJiPp5J4ztSgUQtnvMuHGjunb
	RAG2ae3CyDNnf7VL+afzV6jVCapwvI5eiZzimMOk07RG40WCcBZQIEvhVtEwtbFmmB42VyzkIpv
	agZuWKv4XYnOsV0600pwTakhTfDtMlckKi9arf8dp4/YEz9qFxECFuZYM3cOiGSKf4MVZu9P+LJ
	smpmiWfL52qR/BC4wrXTsL9Nt3DHSQwxY18Kt8xOnW0yXoRFkr6xBOB1/gOrbFkSgkTi3ZB7nQF
	/KWKvF/e/HI3tjIH22f0xNRS6FKkIaQ3xi0aQ5GLbjqxJkYGuYjwxkCJl/ihAz4hTXtvXl/ku6M
	iT9RcJHWxenrwafAyKapJqdEfxZtFKgxZQ9oO9FJ1HPkhrPXcrNqzigVcGb2DW2O+V8SRMed0r
X-Received: by 2002:a17:90b:554b:b0:3a0:25f0:d89f with SMTP id 98e67ed59e1d1-3a073272540mr1576638a91.54.1790093508459;
        Tue, 22 Sep 2026 09:11:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f2a44cc8sm5632538c88.13.2026.09.22.09.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:11:47 -0700 (PDT)
Message-Id: <pull.2411.git.git.1790093506966.gitgitgadget@gmail.com>
From: "Anupam Mediratta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Sep 2026 16:11:46 +0000
Subject: [PATCH] git-p4: avoid shell interpretation of commit ids in
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
    
    Changes since v1: corrected the description of the affected data (it's
    the unvalidated --commit argument, not Perforce server data, that was
    ever exploitable here), removed the shell entirely instead of quoting
    the interpolated value, replaced a test that never reached the
    vulnerable code with one that drives it through git p4 submit --commit,
    and fixed the commit message format (subsystem prefix, rationale,
    sign-off).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2411%2Fanupamme%2Ffix-repo-git-git-p4-cwe-78-shell-injection-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2411/anupamme/fix-repo-git-git-p4-cwe-78-shell-injection-v1
Pull-Request: https://github.com/git/git/pull/2411

 git-p4.py                         | 31 +++++++++++++++++++++----------
 t/t9803-git-p4-shell-metachars.sh | 16 ++++++++++++++++
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c0ca7becaf..b09f5cd740 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -465,6 +465,22 @@ def p4_system(cmd, *k, **kw):
         raise subprocess.CalledProcessError(retcode, real_cmd)
 
 
+def diffTreeApply(id, applyArgs):
+    """Pipe `git diff-tree --full-index -p <id>` into `git apply <applyArgs>`
+    without a shell, so id can never be interpreted as shell syntax. Returns
+    the exit status of git apply."""
+    diffArgv = ["git", "diff-tree", "--full-index", "-p", id]
+    applyArgv = ["git", "apply"] + applyArgs
+    if verbose:
+        print("TryPatch: %s | %s" % (" ".join(diffArgv), " ".join(applyArgv)))
+    diffProc = subprocess.Popen(diffArgv, stdout=subprocess.PIPE)
+    applyProc = subprocess.Popen(applyArgv, stdin=diffProc.stdout)
+    diffProc.stdout.close()
+    applyProc.wait()
+    diffProc.wait()
+    return applyProc.returncode
+
+
 def die_bad_access(s):
     die("failure accessing depot: {0}".format(s.rstrip()))
 
@@ -2234,16 +2250,11 @@ class P4Submit(Command, P4UserMap):
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
+        if diffTreeApply(id, tryPatchArgs) != 0:
             fixed_rcs_keywords = False
             patch_succeeded = False
             print("Unfortunately applying the change failed!")
@@ -2279,7 +2290,7 @@ class P4Submit(Command, P4UserMap):
 
             if fixed_rcs_keywords:
                 print("Retrying the patch with RCS keywords cleaned up")
-                if os.system(tryPatchCmd) == 0:
+                if diffTreeApply(id, tryPatchArgs) == 0:
                     patch_succeeded = True
                     print("Patch succeesed this time with RCS keywords cleaned")
 
@@ -2291,7 +2302,7 @@ class P4Submit(Command, P4UserMap):
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
