Received: from mail-pj2-f18.google.com (mail-pj2-f18.google.com [74.125.227.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C323BB69B
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261067; cv=none; b=Cvg5UjqUQq4vltO36w5hOLXvt0qkS4oo4nOnTdgS7Z/tF/4uzJAsvLIEY1k+fYxz6n9OIxkx/eNB+mi1p1FWdi7n2PZRBwTuRgMhwY3U8oe0q2tbYZzU9LqsK0Y9nD0kX6vPdqePp0wCcLoRkkzyhdFusaAXIy/lCCWVTLbi1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261067; c=relaxed/simple;
	bh=fPE9V1YJP+9PcNIPJfkj1o+B9H18rx2AOv7IndoYPnQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Lw1bl2ZpFV8gO7IY2b6GFcSbc22snl5NSvWSsKMrrUGo5JJ1LmnamtGf+HRaPJqdvMMANpOI+KmEA11XQifXqvB0AHzrJW7vU0eEvDso78tyiP2VAw3HKUAnVpr2hSImAGV09NCzUgClYroU7nMS32tJAdeMGrm8jf7uG9VnaE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBn14jeq; arc=none smtp.client-ip=74.125.227.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBn14jeq"
Received: by mail-pj2-f18.google.com with SMTP id d9443c01a7336-2db22383fe8so10045935ad.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790261065; x=1790865865; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ud17r3GHPoL46lA0Kp4V4pPp/pqz3YNEHDupWsuflho=;
        b=JBn14jeqcX33aDO3OKwyth+Kpnc3cCnz6VlXoV//2G1dO4Dc2zhm7nuCJxSfgn7pRE
         O5RrLX42oLdFvXzjNNzflwkmvRfXzbFy6ilAAzwnGGUBD/zI9D0Qts1Ozz0l7/ByPLy8
         J3u0hBGvKJJTvYfTO4PDx2hQN7SNmvTv+S+IP2Jhnwbn/EivaMECov5hEjZaeJHAC2d+
         JOOHAimuK2lvyxioOH+4bgFfI0SyV6fruygyZq/pAB8EQxf32M95lbv8hrDnRMNEiCXF
         6DzIwkOZd40aJCH8IWVFG3qigXKTDYSgJSVGjPWuy/uI/SFrpR4prslxm73kf7lQo6/4
         Nd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261065; x=1790865865;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ud17r3GHPoL46lA0Kp4V4pPp/pqz3YNEHDupWsuflho=;
        b=IRbNqfSXjEUJPieSLbP45sNAlAl49CqqNal0mtwiSnrrDwoIBqUmtw8QwLCYnWtpwX
         IYIErGLybRSn2JUWqSaiml0Mr+xPGFHAG8Kip+1tw5uCphYaQeNhUK+3L4AEtUGsWhx+
         SQT2HZwfGaPzLKdwLthz7f5XO/fpMgTAqhnze8yyCppkwrHIlOds19Gx5wuay/lNsd/r
         DkbpfqgBr7Kh4yizGDCWaZJiMXWw9sDy6Fi53++BlFuD2eix9E0mGZRLQL6/posdCfi3
         Gbp/eDmbST2YMLAIDCtgcSZSMKp+Y2U4TGMGPFBqkrZyU6/sjOJ61AubKf6pJ/9mnZmR
         rOBQ==
X-Gm-Message-State: AFuF++lshHyteJriiF04dEaSN7xqUthp06YgEHWSHnAhn6IajAIZ7HBy
	zZxaG77EaOtlcCyDzwjydm/osjUs0ZWD+pS0TRw6c4ELe0TceI1F0PNbbayyy1K7
X-Gm-Gg: AYBFou1NkRUC+MgzEyGh0Qr/ALlf3CydSw3/s93Dm3wn6+rQdbRbQ8ZbXnkVteK7Fcy
	+DgKUlhOA50jX5aF0cXbSzTvjTXwq7rDiFBwWyVR+J86xcduCQUQPM+mmfnZ9dQMpsnp1oDcpfl
	wwRg3L0FOeLYTxtjiZdpRDalTa32GHVId36jZqO9mYI7+smbUQey5nrOflwVxrvFM1h8BLGcu55
	d+irr6uWKn9gMmIahSW5EQ2RraNLriGKVVLTscTPEoPVr74BnsudyJiCPU+aplsLc/Bq8SoB/Hq
	NyCz+QyiSP+bJx95YuApear6CV6DB03srxkK+9K5Z/m21aaTQRT49VjeCitPgUgDnekjYWZpnYa
	VMKXU9XSZdtCehsbM/McPOiBKDYTrPKRPjHDocDQ9lKOoVip3BnPmJJADxIQP/J6ZIrvk/cqR9y
	/NcBFcdoQfBXafajR5bV4l3WFgA7hs2mk+GnX3NQWZccmF3mABGAFW6CBTlupibJGBYiWHSTr7B
	8A=
X-Received: by 2002:a17:903:3c6e:b0:2dd:ad73:c98c with SMTP id d9443c01a7336-2df7deb7a58mr21007445ad.36.1790261064984;
        Thu, 24 Sep 2026 07:44:24 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a7b76sm28632715ad.20.2026.09.24.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:44:24 -0700 (PDT)
Message-Id: <ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 14:44:16 +0000
Subject: [PATCH 1/7] [doc] Add new gitmergeconflicts man page
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
Cc: ps@pks.im,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Introduce a new page, `gitmergeconflicts`, that explains the process of
handling a merge conflict in a way that addresses the following issues,
which came from feedback from Git users on the current explanation of
merge conflicts in the `git merge` man page:

- The process for resolving a merge conflict is only explained in the
  `git merge` man page, even though there are several other commands
  which can result in conflicts
- Sometimes we use "ours" and "theirs" to refer to the two sides of
  the merge conflicts and sometimes we use HEAD and MERGE_HEAD. It should
  be consistent. Also the terms "ours" and "theirs" are not explained.
  Similarly, it says "The part before the `=======` is typically your
  side...", but doesn't explain what "typically" means.
- It introduces the merge format using an analogy to RCS, which very few
  Git users have ever used
- In "The only clean-ups you need are to reset the index file to the
  `HEAD` commit to reverse 2. and to clean up working tree changes made
  by 2. and 3.", it's not clear to users what "2" and "3" are supposed
  to mean
- It uses a cultural reference ("Conflict resolution is hard; let's go
  shopping.") which is confusing or unfamiliar to some people. I think it
  would be clearer for users to use a code example instead.
- It doesn't explain the difference between diff3 and zdiff3
- It sometimes uses the term "area" and sometimes uses the term "hunk"

Also document the unified `--abort`, `--continue` workflow in one
place, since it's a really nice example of a place Git has a consistent
interface between similar commands.

Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/Makefile               |   1 +
 Documentation/gitmergeconflicts.adoc | 294 +++++++++++++++++++++++++++
 Documentation/meson.build            |   1 +
 3 files changed, 296 insertions(+)
 create mode 100644 Documentation/gitmergeconflicts.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f8dea4b395..bc49641dda 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -58,6 +58,7 @@ MAN7_TXT += gitdiffcore.adoc
 MAN7_TXT += giteveryday.adoc
 MAN7_TXT += gitfaq.adoc
 MAN7_TXT += gitglossary.adoc
+MAN7_TXT += gitmergeconflicts.adoc
 MAN7_TXT += gitpacking.adoc
 MAN7_TXT += gitnamespaces.adoc
 MAN7_TXT += gitremote-helpers.adoc
diff --git a/Documentation/gitmergeconflicts.adoc b/Documentation/gitmergeconflicts.adoc
new file mode 100644
index 0000000000..612b683e40
--- /dev/null
+++ b/Documentation/gitmergeconflicts.adoc
@@ -0,0 +1,294 @@
+gitmergeconflicts(7)
+====================
+
+NAME
+----
+gitmergeconflicts - Guide to handling merge conflicts
+
+
+SYNOPSIS
+--------
+Guide to handling merge conflicts
+
+
+DESCRIPTION
+-----------
+
+Merge conflicts can happen during a `git merge`, `git rebase`, `git
+cherry-pick`, `git pull`, or `git revert`. All of those commands use
+the same merge algorithm, and the process for resolving a merge conflict
+is always very similar.
+
+The most common ways to handle a merge conflict are:
+
+* Resolve the conflict. (see <<resolve,HOW TO RESOLVE A MERGE CONFLICT>>
+  below for details)
+* Or stop the operation and return your branch to its original state
+  with the appropriate `--abort` command, for example `git merge --abort`
+  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
+  for how to find the command to run.
+
+
+[[markers]]
+MERGE CONFLICT MARKERS
+----------------------
+
+Merge conflicts happen when both of the sides being merged edit the same
+area of a file. When this happens, Git will update the conflicted file
+to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
+For example, here's a merge conflict where both sides edited a list of
+fruits in different ways:
+
+----
+FRUITS = [
+    "apple",
+<<<<<<< HEAD
+    "cherry",
+=======
+    "banana",
+>>>>>>> add-fruit
+    "mango",
+    "orange",
+]
+----
+
+The code from one side of the merge conflict is between `<<<<<<<` and
+`=======`, and the code for the other side is between `=======` and
+`>>>>>>>`. See <<ours,"OURS" AND "THEIRS">> below for a full explanation
+of which side is which.
+
+
+[[resolve]]
+HOW TO RESOLVE A MERGE CONFLICT
+-------------------------------
+
+The process for resolving a merge conflict is:
+
+1. Run `git status` to get a list of files with merge conflicts
+2. For each one, find the conflict markers
+   (the `<<<<<<<`, `=======`, `>>>>>>>`) and edit the code to
+   fix the conflict
+3. Run `git add FILENAME` for each file to mark the conflict as resolved
+4. Run the appropriate `--continue` command to continue the operation
+   that was interrupted by the conflict, for example `git merge --continue`
+   or `git rebase --continue`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>>
+   below for how to find the command to run.
++
+Note: During a `git merge`, `git commit` and `git merge --continue` do
+the the same thing.
+
+
+[[example]]
+EXAMPLE OF RESOLVING A MERGE CONFLICT
+-------------------------------------
+
+If you see this in your code during a merge conflict:
+
+----
+FRUITS = [
+    "apple",
+<<<<<<< HEAD
+    "cherry",
+    "mango",
+=======
+    "banana",
+    "mango",
+>>>>>>> add-fruit
+    "orange",
+]
+----
+
+Then you might edit that part of the code like this,
+which includes the fruits from both sides of the conflict:
+
+----
+FRUITS = [
+    "apple",
+    "banana",
+    "cherry",
+    "mango",
+    "orange",
+]
+----
+
+
+[[tools]]
+TOOLS FOR HANDLING MERGE CONFLICTS
+----------------------------------
+
+Here are some ways to get extra context while handling a merge conflict:
+
+* There are many graphical "merge tools" for Git, which will normally
+  show you the different versions of the code side by side.
+  If you have a mergetool configured, `git mergetool` will launch it.
+  See also `merge.tool` in linkgit:git-config[1] for a list of
+  the mergetools Git supports.
+
+* You can set the configuration option `merge.conflictstyle=diff3`.
+  See <<diff3,DIFF3 AND ZDIFF3>> below for more.
+
+* Look at the original files.  `git show :1:filename` shows the
+  common ancestor, `git show :2:filename` shows the "ours"
+  version, and `git show :3:filename` shows the "theirs"
+  version.
+
+Here are some ways to track your progress while handling a conflict:
+
+* Use `git status` to get a list of files with conflicts
+
+* Use `git diff --check` to make sure you haven't left any merge
+  conflict markers in a file by accident. It will print "leftover
+  conflict marker" if it finds any.
+
+* Use `git diff AUTO_MERGE` to show what changes you've made so far to
+  resolve the conflicts.
+
+[[git_status]]
+EXAMPLE: GIT STATUS OUTPUT
+--------------------------
+
+When you're in a merge conflict, you can find out what commands to run
+to handle the conflict by running `git status`.
+
+For example, this `git status` output tells you that:
+
+* `git rebase --abort` will safely bring your branch back to its
+  original state
+* you should run `git rebase --continue` when you're done resolving all
+  the conflicts
+* there's one file left with conflicts in it: `fruits.py`
+
+----
+$ git status
+You are currently rebasing branch 'main' on '58a9fcc'.
+  (fix conflicts and then run "git rebase --continue")
+  (use "git rebase --skip" to skip this patch)
+  (use "git rebase --abort" to check out the original branch)
+
+Unmerged paths:
+  (use "git restore --staged <file>..." to unstage)
+  (use "git add <file>..." to mark resolution)
+        both modified:   fruits.py
+----
+
+
+[[diff3]]
+DIFF3 AND ZDIFF3
+----------------
+
+By default, Git doesn't include the original code when formatting
+a merge conflict. To include the original code, you can set the
+configuration option `merge.conflictstyle` to `diff3` or `zdiff3`.
+This extra context can make it much easier to understand what's
+happening in a merge conflict.
+
+Here's an example of what a merge conflict would look like when using
+`diff3`. It shows, in order, the "ours" side of the conflict, the
+original code (`"mangoooo"`), and the "theirs" side of the
+conflict. With this view, you can see that both sides fixed the spelling
+mistake in "mango", and each added one fruit to the list.
+
+----
+FRUITS = [
+    "apple",
+<<<<<<< HEAD
+    "cherry",
+    "mango",
+||||||| 1c22e48
+    "mangoooo",
+=======
+    "banana",
+    "mango",
+>>>>>>> add-fruit
+    "orange",
+]
+----
+
+Here's the same example using `zdiff3`. `zdiff3` takes lines that are
+shared between both sides (the `"mango"` line) and moves them outside
+the conflicted area. This makes the conflicted area shorter, but the
+downside is that it's impossible to tell if `"mango"` was part of the
+original list of fruits or not.
+
+----
+FRUITS = [
+    "apple",
+<<<<<<< HEAD
+    "cherry",
+||||||| 1c22e48
+    "mangoooo",
+=======
+    "banana",
+>>>>>>> add-fruit
+    "mango",
+    "orange",
+]
+----
+
+
+[[ours]]
+"OURS" AND "THEIRS"
+-------------------
+
+Git refers to the first part of a merge conflict (between `<<<<<<<`
+and `=======`) as "ours" and the second part (between `=======` and
+`>>>>>>>`) as "theirs".
+
+Normally, "ours" is the commit that was checked out before you started
+the merge, and "theirs" is the other commit.
+
+But when the merge conflict was caused by a `git rebase`, it's the
+opposite: "theirs" is the commit that was checked out before you started
+the merge. This is because under the hood, `git rebase main` checks out
+the `main` commit first before doing the merge operation.
+
+These terms in Git all mean the same thing when dealing with a merge
+conflict:
+
+* "common ancestor", "base", and "stage 1"
+* "ours", "us", "stage 2", and `HEAD`
+* "theirs", "them", and "stage 3"
+
+[[automerge]]
+Example of using `AUTO_MERGE`
+-----------------------------
+
+`git diff AUTO_MERGE` will show what changes you've made so far to
+resolve conflicts. `AUTO_MERGE` is a reference that Git creates during a
+merge. It contains the result of running the merge algorithm.
+
+For example, if we resolved the conflict the way we did in the
+<<example,example above>>, the diff would look like this:
+
+----
+ FRUITS = [
+     "apple",
+-<<<<<<< HEAD
+-    "cherry",
+-=======
+     "banana",
+->>>>>>> add-fruit
++    "cherry",
+     "mango",
+     "orange",
+]
+----
+
+[NOTE]
+`AUTO_MERGE` is only set if you're using the default Git merge algorithm.
+
+
+SEE ALSO
+--------
+
+linkgit:git-revert[1]
+linkgit:git-merge[1]
+linkgit:git-rebase[1]
+linkgit:git-cherry-pick[1]
+linkgit:git-pull[1]
+linkgit:git-diff[1]
+
+GIT
+---
+
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f4854f802d..51647957e0 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -202,6 +202,7 @@ manpages = {
   'gitfaq.adoc' : 7,
   'gitglossary.adoc' : 7,
   'gitpacking.adoc' : 7,
+  'gitmergeconflicts.adoc' : 7,
   'gitnamespaces.adoc' : 7,
   'gitremote-helpers.adoc' : 7,
   'gitrevisions.adoc' : 7,
-- 
gitgitgadget

