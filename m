Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D974908A3
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816801; cv=none; b=gLp78Y7hvm7/JmuaTqZQyVTkE6LqmuOdwRUyfvjeH80UWC1XJFIjqJW+asU/T5fcTT+iqkxmSXMsaD7UdjxIeJj3sDJ6mCzhGi8nLlZztVPmB365I27J2PpgFVfN6Kwqh2Vr3uhSCyuku2OZOrLELy4EteWd1S8/FLjA9AGLj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816801; c=relaxed/simple;
	bh=jbBC8mKqHAcJ2SbJY8jbXtKqQmex0cwsWxAysmp9w4Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OXpx+XAZwfZt2UKw8K1d4b9RganjRlP+kF5/29ljRBQiTodhDhU2VM29OF2tVpqtfetLCpEEl7rhpwqN297LMbcJs0E+43uQNu2rUJsAKI4lHv8B84G6XimT3VispJ3Z6ww2M6n4qLZM3VhVl/aRTefKi/d5WS1W5DO7rl/7fJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q02n+wJT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q02n+wJT"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ae9bc9a2fcso31009687b3.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816798; x=1792421598; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n7Uh+pWqPKvAUTaGhd5kOTyN5HRS0QYmdbI4NNYYCM8=;
        b=Q02n+wJTmWb84nN8Wokhqx+kRnVbMc2jzCQMcAvBxkgObEQRxMu9EvM8OXeCWjrCTP
         CbB5ybmXNdMJXwriLC9ApA7HSOgtXA0olTgwBmKGNAjg55g4YN/+zLz/kYxjWOb5lWy8
         DLSFkBbWP6c0PgIqqxV7pMJSv9bqoqcOP6g0iQCescH+FGe7MxDUZIt3kU+01JgnVxvq
         imFZ8s7KohIsRAHHBZMWcsWlj9Bt926CGRnYwTMB9yHhz4mfJkpCvAxnL4WqdwXDd69o
         yCTGh7vjrnfqoGz/CJeFAM/sun1FRoGj9PalqtWVZzmcCMV2zGxyqSd9I+eW7pgop32K
         3LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816798; x=1792421598;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7Uh+pWqPKvAUTaGhd5kOTyN5HRS0QYmdbI4NNYYCM8=;
        b=QMbR3QeedYyTBbOfnUdyqPt3bHzYe4rLrinQ5p+ywH8MwbhHSUKHJZUwJzKEaQ15+e
         9gMAyeqUcWOaPrrOD1cFadq8R9RWO+4dLr+MZQvmaBVzJq304i9Aq9o/sEsuYNqqt2Dj
         loPypuO3G+DGuJFpbCrpQ2HuXjBYTQJVEietDr0ZVC9VHDQPZ04oOyFeh+FtzsLxCc9O
         jRNDM4YMSpgN7RAj+aXdWtZ2eAgbd4nTnRIzEa4HVvvEl398Y+9R/HVDiUQca6p9dqmM
         uBnGVVi0Kf3UEb0Dav6JL9IAgwEuqUtvu8NM1Foh7Dyi1dc8lHVytqI5B22+0nvWggJX
         arqA==
X-Gm-Message-State: AFq9FYItHnRJNvbTQnahP4XXe4v8PQbv+QTI0wT185/MSn4KU63TmpI4
	KBQ/jkh+Vfi4dL3PkLXaea4gQtsKVq3an4vm2rSsSe07qH9bIH8d9O1e9pa0mD/6
X-Gm-Gg: AYBFou11SVbNtdwAGufaEfgJdorqou72crknNN3ixuXjadR6CZgxe+bVZbQ00fwrO9y
	ZALJDNsWr3X+TPwp+Qaw18BuJS7r2+3mAzVyPrJJ7817K5bT5SldRC7levoL5Up36Of0kjLCS+x
	2kiqhvrBgqetT7ZZAghunafuRDkVf/3un+AByvV3auFohP58eMp7buy1477AeuFk90PC9N671jS
	8Khgtccunh0VnNOuQRZ8hBVHoDhldGWt4DwzsWza1Ejonlo3FvOBT7NnMvZqncjkko26doNuR2A
	rOK8Ok5teLHwwSSnFn+gjHGe1F3CeBN77A+HvQMgligs8ddLk/1lpRXVuWqWu/mqnMRIi2ZTURg
	xKnvQdJ7Dm0zLovHL53l/AjfPXtu/atknikCeJWC7SBQhmfcnVkzytjtR7U8r+VR6CV9RVWq+CQ
	H5hUuysOWysmlvi5rpbejHsQ9COTV176bnNO81wkiAe5y7ozJfM43nkcLQt4hvfz/JItGXWZlH
X-Received: by 2002:a05:690c:95:b0:873:5c6b:a31d with SMTP id 00721157ae682-8b07edb162amr33858377b3.23.1791816798446;
        Mon, 12 Oct 2026 07:53:18 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.84.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f27f159sm35274067b3.47.2026.10.12.07.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:53:17 -0700 (PDT)
Message-Id: <8bdbd64ca3532e03b90810d55c32330fa3df4872.1791816795.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 14:53:11 +0000
Subject: [PATCH v3 2/6] doc: git-merge: link to new merge conflicts guide
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

