Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E74CE677
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547233; cv=none; b=sAPLKD9/eWzRf6ajOtiisBFkJVe0sfaEqmhnNrVu8Bwz4965rWtjCkglAForCZf1N4mW3kaIbuRKNyVHlbF2/685JtooqBr//I3lHZj9W/9VOCtJEuPFlhDxNldUv6kxBkgr1LGUOVKdcUmlx6sbC0FYib+Jl5j01NVn/8OMrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547233; c=relaxed/simple;
	bh=jbBC8mKqHAcJ2SbJY8jbXtKqQmex0cwsWxAysmp9w4Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qDM+mWzvzZD0TbuD7tmBZFtWyKKNYJtVOSLMvO5a8Xks0r9UBGRjP+TMqn0NFrOJpqSIytNo6lOMDMGz+p0vmh4AOoXUqMeve7gOEWtBkJjmvFA73AbIqaJB00J09PbudHwm3Y8CPsmcsnux3VaNuTj1huIGttwx1qPmPqjdojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcyzkYGo; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcyzkYGo"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6d290b10a35so1522075eaf.2
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547223; x=1792152023; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n7Uh+pWqPKvAUTaGhd5kOTyN5HRS0QYmdbI4NNYYCM8=;
        b=NcyzkYGooEzT/oCjhomsx4uWe3XTgTjbEd+yiLC0ZNIWCc/V9WAlzHvbs7Bj2jCkHn
         M/7F6dmwaIrOlEhxSDVFhCFsZmmCp/bG2/2tA9d46OwJz/0UtHMXBv32BbIyDESDZFE8
         JWgD/m5xGZZ94XuqLZFpzae0jsADIJOQekaqicC0TZR8o0ayyR5BG14401H4swNT2JmL
         J1+hlHCATM9LtyZ2TH5bGwVUzwr2PPv/KrhFmawbck3gITvJyryOGmnPV8RyIcNJvPXO
         QzPik5pU5UmxJXXgUWKsUxJHWFeUqggegqt0eQFPRCzHCi6O42MOowzht16tMxYHdVWj
         /CTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547223; x=1792152023;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7Uh+pWqPKvAUTaGhd5kOTyN5HRS0QYmdbI4NNYYCM8=;
        b=U97TVr12PCi9QHBV6FPmfWnPeaLaGlQDGoHHkEdGJhMxAep+IQOggb4HNsbHhY+W8/
         Ogb+7kWgHLZlhjsQjAHCCx6B5IRT6OtBMB2ZsjdkSpJ+hDRnXdLEJ3piyMVdZV+r4XDq
         OrDiLnMl55Cy/Oqy3JaEY1UB1ojuynL7uDj57bJe4xRghEOybkQyFEPE0c3Bb4g5gkeI
         B6DLRSKwYqdG0zGxttcfUKzKb6Ihd+SLfXNLCyBoineX197Oimn8+gAbwyPOy+76mHF0
         T/VxOcv3Mgs+lILb+SEkGREVmb2y75jkL//vvvrouGuYo5P27QoVMZUSiUfWjQr58hJC
         SzrA==
X-Gm-Message-State: AFuF++ktr96A3CPFbUeaOqm1DMw1XKrh5B9PVX5T/I6S5Yt3KmCvvoY6
	mRvnTRmaxrFEdBDBuQdIcu8gScK9IXEuUfIo/LTWVkAcrkJWkfP6MW3QMIbzqA==
X-Gm-Gg: AYBFou3R3B6dAGyocx0OsiirWHTU8Mjv1YeTwITH682zGHP5naax61ooVK8j0mDNA7s
	5O7sRA5sw52zgQRF3LFGIHMy36vW129TFoWzxha7hLLQLunzlbTwAs6APLWtslNaT1R/6c0PuM0
	sg00JQw3YuZqZUtqNNR6VQ1FR99S4GP0va0Rg3vu6wAGLXmQ0CxFGpRHuIlKGKMdymKBQs1i3oE
	UXel61cN5w+KNIT0110R0T7ND/3Q2RWkrqKMxf2HqdN4iQ17A8AU7DsFeiOC+vbiBSMyzMxXGJn
	UlvR4zpkVuyLIlH9D4XyUMUZaVOH7Atw5jhwtxp++XUNjsqwbcBaOZnlTOZSGvWf5nSEP6eOwhH
	OMUiiZMv2vbN39tq8KNMTXogBT+qWdTmcZbyRBGl7AF32jGlzJw6g+Jbg2jzbKjdv7lyvjHboAa
	6tpPOeDo+IMr+gKlOoXUbaJpHNdQM0owfK0JqIwgj5czh7bg6z22QHwtUePjldEh14oLV+bb20P
	EvnCytPZzKXXw==
X-Received: by 2002:a05:6820:1c83:b0:6e0:6c72:774 with SMTP id 006d021491bc7-6ef08e71046mr1254389eaf.6.1791547223121;
        Fri, 09 Oct 2026 05:00:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.171.13.148])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a328ee6sm1572376a34.23.2026.10.09.05.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:00:21 -0700 (PDT)
Message-Id: <d5241eb901a2cc405bdebedc30d7e8c359898ba4.1791547213.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 12:00:09 +0000
Subject: [PATCH v2 2/6] doc: git-merge: link to new merge conflicts guide
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
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
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

