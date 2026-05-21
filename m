Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9AE2D3A75
	for <git@vger.kernel.org>; Thu, 21 May 2026 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371115; cv=none; b=fNaqRZELqD6WBrX+249Ro7Nu9atZ/I7S5ow5J4R8Zx5EAN2fM1YC33/2OsiGeXflS54xuoTh6byhWdLUATCh3LC1FwH9BVyq26yAlBjB60hlVGKaCRpMfblgs64BwMK9LTebKd5LqpIUtEMRIM6SVHcx/UdNEMzgoqPhJ3ofS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371115; c=relaxed/simple;
	bh=p4KjZSskMlEvQjSktNrVnCTtrJAxFXVdfaXpIYZzodM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PBf+qekuNWpuVPj04n3DrkTZMFjsxTvzWPpuP75KLrmdFmlnJlTl5ghplGouo06b5EyMk7T2IgWCWC+TNEzDi/GJF1AU5n7x7J1wBq46+X7WMpdsVNeNUR2ZOcF32fPr46Lm/k8b3/iEO8Evo5Ijr6GGPND4A6eyPDzWV1zRCGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/CeyKeQ; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/CeyKeQ"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13621cca8f5so2118609c88.0
        for <git@vger.kernel.org>; Thu, 21 May 2026 06:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371112; x=1779975912; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqDCiwFH+qxQ5Ihn9K2ilFJGF2K/U4lvnMnB2ulIGxY=;
        b=f/CeyKeQAdUwWItfaAh2Y6KYYZ77Czbb9krmczvkW5DbhtnW1wVqxNdBgqcDrLmKp+
         1VwjqEWHqkR+S4/n7+WJKqigI/rOQp5zBxnZA7wT9OgxFbbRgDhk9Tpg5Q8ua7QE/MfY
         50WCrWXauMhlvVLJJJ+KL6FAIeten97UFYDZC2yPmSlmXTGEWDkPFR8Z2tg1hcXLhv+i
         FaaTw385DiNohNSYtqpUxvrfc29sg16XhdfDPHZMxrrdR9VwYatpgJYlMsQfJ2EEm7Jb
         ezaxZVq4Fi5Nfs5Mii1laAkBXHM+wiFABMMaSnlvjs8KLG19RMBO3Be3e7XotXRlqenz
         1WvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371112; x=1779975912;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xqDCiwFH+qxQ5Ihn9K2ilFJGF2K/U4lvnMnB2ulIGxY=;
        b=ERIF++HvgzApKe1wipTIYmbRiR3QWvoeFagSeCoiM7P2Da5v5WwF/qYa+Y2AwGKOpo
         uhvUhgVUPXk26cca20OAkTgcKrRfiMvnj9fQMDHv/AC4ZKZN8h7TA5umVMuhFCIPYu5H
         3y5LH+b0KdI5Vrie+/pM2isGDnd9J7z/j2aL/amU0PM+3V8IlOOty3zA0zSBmMX6MXDK
         VcvzweYpLpX97lz3/MGJSD4KMnN6g0HrFdvG7LYTV47hsjqsnpxBTyqSkB+1FuVfYRMx
         uy9ynF0lsMy1G2GnHMHhNG5XgaYy59Dn6umJNkP+zfTk+EgqWvVCmahhrlOCxogGt79X
         2ZcA==
X-Gm-Message-State: AOJu0Yz07f0C5GkVT9kZsub1UPvgt+bNx2j9Z3oYrsP4Dr9pVQrjtk4R
	vQmbcXVGtRuladjsSVs50fM0qYAeSlq8f3LYS+/gWCFZUOtAaYrihR1yqtx4bg==
X-Gm-Gg: Acq92OHa2DB9VJ3dtYMQkhocICGVDYDCD1w9jqApn5i4ZOXv9Mi8OS+8CKhE7GgXylC
	29+6JvnQrWP4fFgATmM4o9a9hDxRUiWgdkPI+UcI1xY7pjQPhaCWvuJBpthpGtculvuvnxrzCrX
	8qnNQFTTiFPCiLOmZ1kegu+LsW+MjkUmWl2LP2EXEUl+awtyPyLA0dsvXTLw/PyOlsgTX4x6uJh
	Kf4h+LlnjS7afrraIunTjeHRGPTzrUzhIlk9+/4Ow+LevGOcmsWIaRjRL3rgYS08z23BPtiJ7Uy
	JboUx+1+rAtjSYFP3jgae1tdGDPQcKT0M2M/ZTAc/06r7JMbXXy9ZmQP47Z1OvGs6aDEsmOSUXm
	FOuYJSWriAPSxpUSEdyLIKjAz5eub5JIsxLcmC8Ck/aj6Hw+orMpeqqTA0+zxQxpgb3wLadqYQm
	MbinFR8GjdOwltC5oyiTYr4/UeCKY=
X-Received: by 2002:a05:7022:69d:b0:133:54fb:7241 with SMTP id a92af1059eb24-136322777famr1495448c88.0.1779371111931;
        Thu, 21 May 2026 06:45:11 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.226.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1365232eec1sm226773c88.3.2026.05.21.06.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:45:11 -0700 (PDT)
Message-Id: <pull.2108.v3.git.1779371110195.gitgitgadget@gmail.com>
In-Reply-To: <pull.2108.v2.git.1779280307112.gitgitgadget@gmail.com>
References: <pull.2108.v2.git.1779280307112.gitgitgadget@gmail.com>
From: "Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 May 2026 13:45:09 +0000
Subject: [PATCH v3] git-jump: pick a mode automatically when invoked without
 arguments
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
Cc: Jeff King <peff@peff.net>,
    Greg Hurrell <greg@hurrell.net>,
    Erik Cervin Edin <erik@cervined.in>,
    Junio C Hamano <gitster@pobox.com>,
    Greg Hurrell <greg.hurrell@datadoghq.com>,
    Greg Hurrell <greg.hurrell@datadoghq.com>

From: Greg Hurrell <greg.hurrell@datadoghq.com>

When `git jump` is invoked with no positional arguments (and no
arguments after `--stdout`) it currently prints usage and exits with
status 1.

But there are two situations where we can usefully infer the most
valuable and likely mode that a user would want to use, and select it
automatically:

1. When there are unmerged paths in the index, the user likely
   wants `git jump merge`.

2. When the working tree has unstaged changes, the user likely
   wants `git jump diff`.

In this commit we teach `git jump` a new "auto" mode which detects these
cases and dispatches to the corresponding mode automatically. The user
can either explicitly spell out `git jump auto`, or just leave it at
`git jump` (because "auto" is the default).

If none of the interesting cases listed above applies, then auto mode
falls back to the existing usage-and-exit behavior.

Signed-off-by: Greg Hurrell <greg.hurrell@datadoghq.com>
---
    git-jump: pick a mode automatically when invoked without arguments
    
    Changes since v2; all of these in response to feedback from Junio:
    
     * Removed stray # from README.
     * Don't both teaching "auto" to select "ws" mode, because it is always
       subsumed by "diff".
     * Update usage string to make clear that git jump --stdout foo is not a
       synonym for git jump --stdout auto foo, because distinguishing
       between foo as <mode> and foo as <arg> is fraught with ambiguity.
    
    In answer to Junio's question:
    
    > If more than one interesting cases apply, what happens, and what
    > should happen?
    
    it's an ordered choice (merge > diff).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2108%2Fwincent%2Fauto-jump-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2108/wincent/auto-jump-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2108

Range-diff vs v2:

 1:  5fbc8480ef ! 1:  af758dcfd2 git-jump: pick a mode automatically when invoked without arguments
     @@ Commit message
          arguments after `--stdout`) it currently prints usage and exits with
          status 1.
      
     -    But there are several situations where we can usefully infer the most
     +    But there are two situations where we can usefully infer the most
          valuable and likely mode that a user would want to use, and select it
          automatically:
      
     @@ Commit message
          2. When the working tree has unstaged changes, the user likely
             wants `git jump diff`.
      
     -    3. In the presence of conflict markers or whitespace errors (as reported
     -       by `git diff --check`), the user likely wants `git jump ws`.
     -
          In this commit we teach `git jump` a new "auto" mode which detects these
          cases and dispatches to the corresponding mode automatically. The user
          can either explicitly spell out `git jump auto`, or just leave it at
     @@ contrib/git-jump/README: git jump grep foo_bar
       git jump grep -i foo_bar
       
      +# jump to places with conflict markers or whitespace errors
     -+# (as reported by # `git diff --check`)
     ++# (as reported by `git diff --check`)
      +git jump ws
      +
       # use the silver searcher for git jump grep
     @@ contrib/git-jump/README: git jump grep foo_bar
      +# whitespace problems; otherwise show usage
      +git jump auto
      +
     -+# with no explicit mode, same as "auto"
     ++# with no explicit mode and no args, same as "auto"
      +git jump
       --------------------------------------------------
       
     @@ contrib/git-jump/README: git jump grep foo_bar
      
       ## contrib/git-jump/git-jump ##
      @@
     - 
       usage() {
       	cat <<\EOF
     --usage: git jump [--stdout] <mode> [<args>]
     -+usage: git jump [--stdout] [<mode>] [<args>]
     + usage: git jump [--stdout] <mode> [<args>]
     ++   or: git jump [--stdout]
       
       Jump to interesting elements in an editor.
      -The <mode> parameter is one of:
     -+The <mode> parameter is one of the following,
     -+defaulting to "auto" if omitted:
     ++The <mode> parameter is one of the following.
     ++With no <mode> and no <args>, it defaults to "auto".
       
       diff: elements are diff hunks. Arguments are given to diff.
       
     @@ contrib/git-jump/git-jump: mode_ws() {
      +		mode_merge "$@"
      +	elif ! git diff --quiet "$@"; then
      +		mode_diff "$@"
     -+	elif ! git diff --check >/dev/null 2>&1; then
     -+		mode_ws "$@"
      +	else
      +		usage >&2
      +		exit 1


 contrib/git-jump/README   | 12 ++++++++++++
 contrib/git-jump/git-jump | 26 +++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 3211841305..aabec4a756 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -75,8 +75,20 @@ git jump grep foo_bar
 # arbitrary grep options
 git jump grep -i foo_bar
 
+# jump to places with conflict markers or whitespace errors
+# (as reported by `git diff --check`)
+git jump ws
+
 # use the silver searcher for git jump grep
 git config jump.grepCmd "ag --column"
+
+# pick a mode automatically: "merge" if there are unmerged paths,
+# "diff" if the worktree has unstaged changes, "ws" if there are
+# whitespace problems; otherwise show usage
+git jump auto
+
+# with no explicit mode and no args, same as "auto"
+git jump
 --------------------------------------------------
 
 You can use the optional argument '--stdout' to print the listing to
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 8d1d5d79a6..79286d8112 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -3,9 +3,11 @@
 usage() {
 	cat <<\EOF
 usage: git jump [--stdout] <mode> [<args>]
+   or: git jump [--stdout]
 
 Jump to interesting elements in an editor.
-The <mode> parameter is one of:
+The <mode> parameter is one of the following.
+With no <mode> and no <args>, it defaults to "auto".
 
 diff: elements are diff hunks. Arguments are given to diff.
 
@@ -16,6 +18,10 @@ grep: elements are grep hits. Arguments are given to git grep or, if
 
 ws: elements are whitespace errors. Arguments are given to diff --check.
 
+auto: select one of the other modes based on worktree state;
+      "merge" if there are unmerged paths, "diff" if there are
+      unstaged changes, "ws" if there are whitespace errors.
+
 If the optional argument `--stdout` is given, print the quickfix
 lines to standard output instead of feeding it to the editor.
 EOF
@@ -82,6 +88,21 @@ mode_ws() {
 	git diff --check "$@"
 }
 
+mode_auto() {
+	if test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != "true"; then
+		usage >&2
+		exit 1
+	fi
+	if test -n "$(git ls-files -u "$@")"; then
+		mode_merge "$@"
+	elif ! git diff --quiet "$@"; then
+		mode_diff "$@"
+	else
+		usage >&2
+		exit 1
+	fi
+}
+
 use_stdout=
 while test $# -gt 0; do
 	case "$1" in
@@ -99,8 +120,7 @@ while test $# -gt 0; do
 	shift
 done
 if test $# -lt 1; then
-	usage >&2
-	exit 1
+	set -- auto
 fi
 mode=$1; shift
 type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }

base-commit: aec3f587505a472db67e9462d0702e7d463a449d
-- 
gitgitgadget
