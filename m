Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A74B38C421
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261069; cv=none; b=f6sxUbkO2+vWI+scz/lYhxAo7qeEWsA8gsBos2P7Fb38dXmT3+cqlTUbS2BD+p5q5vELvr+sVmcMzWbKl2cXpjdFlM9D1pqjxAowvalTIXZo50ZXcHAwwukEYYCXss/3bdE5t4NSCK2Ye1My9lo9CAF2tGUupXc/sCXvBa0d8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261069; c=relaxed/simple;
	bh=jbBC8mKqHAcJ2SbJY8jbXtKqQmex0cwsWxAysmp9w4Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lyj+kDnbQv9xedgLVRBXpPGQfdO9oK+5RiAF9TnL6zKSnoQ2R5JUznwMuRC+B61wkXqeLBRbjhyedeqJXQDRytB0eOBwuzzkJPcnVX7XUpU+57jwoQFUZfAmhJBdp2Aiv0CKFb2+RrNiuGoZUquy1poRKlHltVy8xYzCDJTCY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWPeD5E4; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWPeD5E4"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so20400875ad.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790261066; x=1790865866; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n7Uh+pWqPKvAUTaGhd5kOTyN5HRS0QYmdbI4NNYYCM8=;
        b=ZWPeD5E4Xs9t4DfbScXEhFu5iWiDyLZqntBbzXzOlFDpykiee8l1gMEw5qHyZuegaS
         enadDnpDYnVWYk07SEIkxCbP1SnP26CRBrXeNYacDbqh11O1EwLCYMXWxT1NZwKz0gPT
         uIIxEU0kVS3t6Bp2yhHNCz7TLfr/4zYa/5rUkPzLMcuwUfzR66Q/3Zfn9HaeMvUdzYQc
         Q4seYjaUR81a4OkGb4sopfUGBVXp7mqYVMiP0ClBG1VSjWIWNn0LSAspLtdLMDhf28wf
         Ysel/cLa5OWx+32M5EDNE4C5Ksyhf/HiIMlze5IwV4aoriIpZvOMSRZ/pdyuLmhE0+Sd
         Dy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261066; x=1790865866;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7Uh+pWqPKvAUTaGhd5kOTyN5HRS0QYmdbI4NNYYCM8=;
        b=aynBgHieqiZedIUwDPkhvNFHo9zjaUBoqP2/9BU3XV0iBelnnUCvI2TlaRfj/99xTv
         VOAjxLQqBXLG9ozVm+QXC5xcoxiBhzpv+bvToqorWnnxTec1s0PB1f4/s+oTTvJLtDbe
         1ZpwFMpNlU8VYW4yyvJFZ7hkUfB2O6Udq6LFqzW43g+3gTah1AQnXP+Fhw8n+uZJ79lu
         V9ROELqjeLdNI/RM0gcSl8ZyGpiLrGhfUyKq/2VIsBSQowk592BMeodB8bRSsPMGbwLp
         E1f5SE9pJt9SBOR6e9a0sgj+PQwx6yYUGpL1MO9D521Rbc5Y5k9xm1XjLB9sOzTCgbdQ
         ORJA==
X-Gm-Message-State: AFuF++n1z1y5tsMX9S0YQBiEsDhpvjFFu7ADTljr/1invIgyEIsxqbqC
	b6zenWTW+eNgBZ0W+c/TNO6FbpsR+DaJQFHE2erKMvYIiOYyo6hOvdGEP3khOwFv
X-Gm-Gg: AYBFou0aBZS+G9+PCvyqi4jMi5Q2gbQme4wkoBdYjGz0yAh8B7qrBQdsk3GsB91QGPV
	0f7BLI3nrHQXUr1/1uMoXVMosra8Agbyfefwsdo+Mo/bLPC+s3do2Vq8rsTCflyv2l4OfY1wqdp
	DgxTtn5BdCQ14BvfqPzXQfjkju2ZuO5YSccO4z4DCWGDPt7kQGpAkGXykViidTodAges6tUfwu9
	XgXE0e7v+ElCX3NfRnHEweZ3OaCjArwFQ3MpveSHSsryf6TWmLbyIxMlOI2CAUY86Gqe1l+zK1v
	li31T+j5/cDFcbWx56A/wKEYjNt7mTINxKUHYi47O9tS5/Pcz4MTR676JtShXloa/yLBGIWMJR8
	lJeX7PPIw8pUTF+AmwUKpikfU8wC9MJ7jsCiEOM7q45zJXiVFhvrFEbYzDdJftBs7S4l3JtKWX9
	RJ1f7bCQUrUrnMGaWJO6zhTtpeIZdivZg3VtElazmHR93xnbng3YRAXuRV1JkXFCYD7MZDBHu4w
	TI=
X-Received: by 2002:a17:902:d2c5:b0:2df:7001:1f74 with SMTP id d9443c01a7336-2df7de90e91mr23217855ad.61.1790261066321;
        Thu, 24 Sep 2026 07:44:26 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5d7a48sm28822435ad.48.2026.09.24.07.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:44:25 -0700 (PDT)
Message-Id: <a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 14:44:17 +0000
Subject: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
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

All of the info about merge conflicts has been moved to the new guide

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-merge.adoc | 125 +----------------------------------
 1 file changed, 3 insertions(+), 122 deletions(-)

diff --git a/Documentation/git-merge.adoc b/Documentation/git-merge.adoc
index a055384ad6..5b7b41cd10 100644
--- a/Documentation/git-merge.adoc
+++ b/Documentation/git-merge.adoc
@@ -49,7 +49,8 @@ a log message from the user describing the changes. Before the operation,
 A merge stops if there's a conflict that cannot be resolved
 automatically or if `--no-commit` was provided when initiating the
 merge. At that point you can run `git merge --abort` or `git merge
---continue`.
+--continue`. See linkgit:gitmergeconflicts[7]
+(or `git help mergeconflicts`) for a guide to handling merge conflicts.
 
 `git merge --abort` will abort the merge process and try to reconstruct
 the pre-merge state. However, if there were uncommitted changes when the
@@ -231,127 +232,6 @@ git merge v1.2.3^0
 git merge --ff-only v1.2.3
 ----
 
-HOW CONFLICTS ARE PRESENTED
----------------------------
-
-During a merge, the working tree files are updated to reflect the result
-of the merge.  Among the changes made to the common ancestor's version,
-non-overlapping ones (that is, you changed an area of the file while the
-other side left that area intact, or vice versa) are incorporated in the
-final result verbatim.  When both sides made changes to the same area,
-however, Git cannot randomly pick one side over the other, and asks you to
-resolve it by leaving what both sides did to that area.
-
-By default, Git uses the same style as the one used by the "merge" program
-from the RCS suite to present such a conflicted hunk, like this:
-
-------------
-Here are lines that are either unchanged from the common
-ancestor, or cleanly resolved because only one side changed,
-or cleanly resolved because both sides changed the same way.
-<<<<<<< yours:sample.txt
-Conflict resolution is hard;
-let's go shopping.
-=======
-Git makes conflict resolution easy.
->>>>>>> theirs:sample.txt
-And here is another line that is cleanly resolved or unmodified.
-------------
-
-The area where a pair of conflicting changes happened is marked with markers
-+<<<<<<<+, `=======`, and +>>>>>>>+.  The part before the `=======`
-is typically your side, and the part afterwards is typically their side.
-
-The default format does not show what the original said in the conflicting
-area.  You cannot tell how many lines are deleted and replaced with
-Barbie's remark on your side.  The only thing you can tell is that your
-side wants to say it is hard and you'd prefer to go shopping, while the
-other side wants to claim it is easy.
-
-An alternative style can be used by setting the `merge.conflictStyle`
-configuration variable to either `diff3` or `zdiff3`.  In `diff3`
-style, the above conflict may look like this:
-
-------------
-Here are lines that are either unchanged from the common
-ancestor, or cleanly resolved because only one side changed,
-<<<<<<< yours:sample.txt
-or cleanly resolved because both sides changed the same way.
-Conflict resolution is hard;
-let's go shopping.
-||||||| base:sample.txt
-or cleanly resolved because both sides changed identically.
-Conflict resolution is hard.
-=======
-or cleanly resolved because both sides changed the same way.
-Git makes conflict resolution easy.
->>>>>>> theirs:sample.txt
-And here is another line that is cleanly resolved or unmodified.
-------------
-
-while in `zdiff3` style, it may look like this:
-
-------------
-Here are lines that are either unchanged from the common
-ancestor, or cleanly resolved because only one side changed,
-or cleanly resolved because both sides changed the same way.
-<<<<<<< yours:sample.txt
-Conflict resolution is hard;
-let's go shopping.
-||||||| base:sample.txt
-or cleanly resolved because both sides changed identically.
-Conflict resolution is hard.
-=======
-Git makes conflict resolution easy.
->>>>>>> theirs:sample.txt
-And here is another line that is cleanly resolved or unmodified.
-------------
-
-In addition to the +<<<<<<<+, `=======`, and +>>>>>>>+ markers, it uses
-another +|||||||+ marker that is followed by the original text.  You can
-tell that the original just stated a fact, and your side simply gave in to
-that statement and gave up, while the other side tried to have a more
-positive attitude.  You can sometimes come up with a better resolution by
-viewing the original.
-
-
-HOW TO RESOLVE CONFLICTS
-------------------------
-
-After seeing a conflict, you can do two things:
-
- * Decide not to merge.  The only clean-ups you need are to reset
-   the index file to the `HEAD` commit to reverse 2. and to clean
-   up working tree changes made by 2. and 3.; `git merge --abort`
-   can be used for this.
-
- * Resolve the conflicts.  Git will mark the conflicts in
-   the working tree.  Edit the files into shape and
-   `git add` them to the index.  Use `git commit` or
-   `git merge --continue` to seal the deal. The latter command
-   checks whether there is a (interrupted) merge in progress
-   before calling `git commit`.
-
-You can work through the conflict with a number of tools:
-
- * Use a mergetool.  `git mergetool` to launch a graphical
-   mergetool which will work through the merge with you.
-
- * Look at the diffs.  `git diff` will show a three-way diff,
-   highlighting changes from both the `HEAD` and `MERGE_HEAD`
-   versions. `git diff AUTO_MERGE` will show what changes you've
-   made so far to resolve textual conflicts.
-
- * Look at the diffs from each branch. `git log --merge -p <path>`
-   will show diffs first for the `HEAD` version and then the
-   `MERGE_HEAD` version.
-
- * Look at the originals.  `git show :1:filename` shows the
-   common ancestor, `git show :2:filename` shows the `HEAD`
-   version, and `git show :3:filename` shows the `MERGE_HEAD`
-   version.
-
-
 EXAMPLES
 --------
 
@@ -406,6 +286,7 @@ linkgit:git-reset[1],
 linkgit:git-diff[1], linkgit:git-ls-files[1],
 linkgit:git-add[1], linkgit:git-rm[1],
 linkgit:git-mergetool[1]
+linkgit:gitmergeconflicts[7]
 
 GIT
 ---
-- 
gitgitgadget

