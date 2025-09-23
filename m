Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0028032D
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649476; cv=none; b=sHdqrPjyF9YeuQk1H3w24WR9l97YJHCtPA8+xm9B5ho89yHfkEU40ry3CEYfFF8T7pGk0XEvWV+YHyVCBTEIr4USZWCX/1G8zF4ZpQPfCb7QBVmGV70621EQtW3sP5VZIjIiqRQIHSmb0HynUuKFNgxLLBDITa6KidJa64V3nVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649476; c=relaxed/simple;
	bh=WBSoZInItHg1vKYvI7EgBkhPdLNG/tWdnBzZ+DPEglE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mkQYdxFUU5WZnEwPKK5CM/fbdEkzE2gC6lIYQg5bGT4qZAegG3RoTIhrbTKew6RM3Vs3NPkirqq1aV4JMDAyN5Y87nYywH5L/Ml1ZcMZ1FasKAJ/a9pFPPx9Gi121T2/uAEDLnrvep5B9lo581vs0l6RIfW9PCYiBCzxIxVMi7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5RWnV9g; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5RWnV9g"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8c3414ad279so74457339f.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758649474; x=1759254274; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWy903bcKBsclAwsQWXk3guUybIYw0sq6wUXQES1eL4=;
        b=B5RWnV9gFzAFo6GYBpgsVIdsnn3J+TWKxyxICeA0NIkWRsxNs2dUs4+FLlZYg5992Q
         i6aopY4fLpMTGUnjT+sT6JyV+QwqjJOM1L1fyECFV6gS0rc0cENiUe9LWFOgOTed2xwm
         ZLRyffz1FdNOSZbEM/I1Rcqo7pPw5n43o3vcot4wA7MyX+v7nb2rWFz0UsWtYDK2SLeh
         +HtWWSAh4KReSr+gZVPHL810Z9my6+wdEVyW6kY7tWcfp26fI0BnIj8Z3/wsT+ycYA2K
         aytzdTd/esFUUhnIDp80AUP6NaziPfRAR2BvsLAUNeJ0Ge+g7YA9Shki5IonnUhvCISZ
         CP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649474; x=1759254274;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWy903bcKBsclAwsQWXk3guUybIYw0sq6wUXQES1eL4=;
        b=R+zwLv4LLX9Gyk02O6dOo7FReCST3pR+jzZlNaRBqtyPSXsq4uSwxw9OtTO7sLr3TG
         szlBVo0tgYF2oBLgm0QojgggAJLe171aFsvGA2Cuse9kRoPw68H8bY++lCTYjB2i3aF5
         IKmjHzLJToWvAQ0vieGMhaZ7NZiYkI0UIc9DM+Ry+GbkU4x8OtoX6d/gRvg13Z4/VlAO
         X6/sIeTaZBGXnIgurujXT9czdLopgRZiOlMsxSsajbIXl2EC3cG0Fp7IAfE4Q1PtUGH0
         VqaqHfqSf9GDYUt8UD2aitKcp+aWgsn3cqi/e6z/JGcyUX40iE5dSqjYCr7YAO75ErIp
         G08w==
X-Gm-Message-State: AOJu0YzqHhq/BKK8WVz0jlimMz0o5YFi0yf3hWmGLaHjvYfD40NsvEzj
	qyhmwjR2c1qHIJp1ps9T31w2uK+uhdfDGhkW7YKC4avytch3ZEG4E+M3C0vsFA==
X-Gm-Gg: ASbGnct9QEDI6R50K/Djn31gOWzjW63KGNCjnGJ41/kPWEi8YFkTLwC0itZc7AGMNl4
	0ML79G/Sh44QXdZ6X7sACkdO4sf3KzId4YVOyDEPmvsx0MWxwyADH0dhwS9S4nQ/z87aJrODzYF
	bTgb+LHaDGACEZoyRlVm+6fYvtWcYWGhAI6ONDiC/8/NhnQubkNmZ/JfNPP0OzlBeeG863pixFO
	LaGLduxyWV4L6I/Bh0L8HAXvcQYqHm8BH9wPWCmdGcwks6tkEklBdISvjKfAaEY+dt3qpVc0ImE
	uiPw3bIwlNp+7Iq0QHFDhILhGwIuEWOUo4bMudnS67cAlhMvNyo8bnnqVL21OmImgOcMVVnk8Dw
	lh+jtFJMZSI07N5MxIGT20NtbGGoZpqEdlzI=
X-Google-Smtp-Source: AGHT+IEXZApeXCZydAE7jndXzN+lF194qLiRhMUhodjHXlB8t5k5SqQB/yvAN7BEp46Xc4BwdmgjTg==
X-Received: by 2002:a05:6e02:160e:b0:40d:e7d8:63fa with SMTP id e9e14a558f8ab-42581e9b6cfmr49323545ab.26.1758649473529;
        Tue, 23 Sep 2025 10:44:33 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.97])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5608003cf11sm2115627173.6.2025.09.23.10.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:44:33 -0700 (PDT)
Message-Id: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 17:44:28 +0000
Subject: [PATCH v3 0/4] doc: git-push: clarify DESCRIPTION section
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>

I surveyed 16 Git users about the git push man page. Here's a rewrite of the
DESCRIPTION section and the definition of <refspec> based on the feedback.
The goal is to clarify it while communicating the same information. The most
common piece of feedback was that folks didn't understand what the term
"ref" means. Most of the users who said they did not understand the term
"ref" have been using Git for 10+ years.

changes in v2:

 * The biggest change is to add a new UPSTREAM BRANCHES section to explain
   what an upstream is
 * Drop the "refspec" changes from this patch series, I've made revisions to
   them based on the comments here but I felt like this was getting too big.
 * Added some backticks `` that I'd missed, from Ben's review
 * From Junio's review, "The current branch must have a configured upstream
   with the same name, so this will fail when pushing a new branch" was not
   true, so replace it with a less detailed but hopefully true statement.
   After a very long conversation with Ben I realized that actually
   push.default=simple's behaviour is not really that simple (perhaps I
   should think of it as more "safe" than "simple", since "current" seems
   simpler), so it's more realistic to refer any questions to the
   CONFIGURATION section which describes the behaviour in more detail.
 * Rewrite all the commits to explain the problem they're trying to solve &
   thinking behind them in more detail. Let me know if I added too much /
   not enough detail.

changes in v3:

 * mention that git push also needs to send data in addition to updating the
   branch, from Junio's review
 * fix a newline, from Junio's review
 * un-rename urls-remotes.adoc, from Junio's review
 * mention pushRemote and git checkout in the UPSTREAM BRANCHES section and
   be clearer about what's meant by "the relationship between the current
   branch and the upstream", from Junio's review
 * fix AsciiDoc formatting issue, from Junio's review

Julia Evans (4):
  doc: git-push: clarify intro
  doc: add an UPSTREAM BRANCHES section to pull/push/fetch
  doc: git-push: clarify "where to push"
  doc: git-push: clarify "what to push"

 Documentation/git-push.adoc     | 43 +++++++++++++++++---------------
 Documentation/urls-remotes.adoc | 44 ++++++++++++++++++++++++++++++---
 2 files changed, 64 insertions(+), 23 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1964%2Fjvns%2Fclarify-push-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1964/jvns/clarify-push-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1964

Range-diff vs v2:

 1:  270edd2b00 ! 1:  2870c77e80 doc: git-push: clarify intro
     @@ Documentation/git-push.adoc: SYNOPSIS
      -every time you push into it, by setting up 'hooks' there.  See
      -documentation for linkgit:git-receive-pack[1].
      +Updates one or more branches, tags, or other references in a remote
     -+repository from your local repository.
     ++repository from your local repository, and sends all necessary data
     ++that isn't already on the remote.
       
       When the command line does not specify where to push with the
       `<repository>` argument, `branch.*.remote` configuration for the
     @@ Documentation/git-push.adoc: corresponding upstream branch, but as a safety meas
      +You can make interesting things happen to a repository
      +every time you push into it, by setting up 'hooks' there.  See
      +documentation for linkgit:git-receive-pack[1].
     ++
       
       OPTIONS[[OPTIONS]]
       ------------------
 2:  0ec629d403 ! 2:  3ecfb5c3a6 doc: add an UPSTREAM BRANCHES section to pull/push/fetch
     @@ Commit message
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     - ## Documentation/git-fetch.adoc ##
     -@@ Documentation/git-fetch.adoc: include::pull-fetch-param.adoc[]
     - 	Read refspecs, one per line, from stdin in addition to those provided
     - 	as arguments. The "tag <name>" format is not supported.
     - 
     --include::urls-remotes.adoc[]
     -+include::urls-remotes-upstreams.adoc[]
     - 
     - 
     - CONFIGURED REMOTE-TRACKING BRANCHES[[CRTB]]
     -
     - ## Documentation/git-pull.adoc ##
     -@@ Documentation/git-pull.adoc: include::fetch-options.adoc[]
     - 
     - include::pull-fetch-param.adoc[]
     - 
     --include::urls-remotes.adoc[]
     -+include::urls-remotes-upstreams.adoc[]
     - 
     - include::merge-strategies.adoc[]
     - 
     -
     - ## Documentation/git-push.adoc ##
     -@@ Documentation/git-push.adoc: further recursion will occur. In this case, "only" is treated as "on-demand".
     - --ipv6::
     - 	Use IPv6 addresses only, ignoring IPv4 addresses.
     - 
     --include::urls-remotes.adoc[]
     -+include::urls-remotes-upstreams.adoc[]
     - 
     - OUTPUT
     - ------
     -
     - ## Documentation/urls-remotes.adoc => Documentation/urls-remotes-upstreams.adoc ##
     -@@ Documentation/urls-remotes-upstreams.adoc: git push uses:
     + ## Documentation/urls-remotes.adoc ##
     +@@ Documentation/urls-remotes.adoc: git push uses:
       	HEAD:refs/heads/<head>
       ------------
       
     @@ Documentation/urls-remotes-upstreams.adoc: git push uses:
      +Git defaults to using the upstream branch for remote operations, for example:
      +
      +* It's the default for `git pull` or `git fetch` with no arguments
     -+* It's sometimes the default for `git push` with no arguments. See the
     -+  `push.default` section of linkgit:git-config[1] for the details.
     -+* `git status` and `git branch -v` will show the
     -+  relationship between the current branch and the upstream,
     -+  for example "Your branch is up to date with origin/main"
     ++* It's the default for `git push` with no arguments, with some exceptions.
     ++  For example, you can use the `branch.<name>.pushRemote` option to push
     ++  to a different remote than you pull from, and by default with
     ++  `push.default=simple` the upstream branch you configure must have
     ++  the same name.
     ++* Various commands, including `git checkout` and `git status`, will
     ++  show you how many commits have been added to your current branch and
     ++  the upstream since you forked from it, for example "Your branch and
     ++  'origin/main' have diverged, and have 2 and 3 different commits each
     ++  respectively"
      +
      +The upstream is stored in `.git/config`, in the "remote" and "merge"
      +fields. For example, if `main`'s upstream is `origin/main`:
      +
     -+```
     -+[branch "main"]
     -+   remote = origin
     -+   merge = refs/heads/main
     -+```
     ++	[branch "main"]
     ++	   remote = origin
     ++	   merge = refs/heads/main
      +
      +You can set an upstream branch explicitly with
      +`git push --set-upstream <remote> <branch>` or `git branch --track`,
 3:  374740c678 ! 3:  bfd6072983 doc: git-push: clarify "where to push"
     @@ Commit message
          doc: git-push: clarify "where to push"
      
          Be clearer about what we're describing ("which repository" instead of
     -    "what to push"), and start with a positive "try X, then Y, then Z"
     +    "where to push"), and start with a positive "try X, then Y, then Z"
          instead of a negative ("if X is not specified..").
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-push.adoc ##
     -@@ Documentation/git-push.adoc: DESCRIPTION
     - Updates one or more branches, tags, or other references in a remote
     - repository from your local repository.
     +@@ Documentation/git-push.adoc: Updates one or more branches, tags, or other references in a remote
     + repository from your local repository, and sends all necessary data
     + that isn't already on the remote.
       
      -When the command line does not specify where to push with the
      -`<repository>` argument, `branch.*.remote` configuration for the
 4:  59732f1e47 = 4:  be6453d010 doc: git-push: clarify "what to push"

-- 
gitgitgadget
