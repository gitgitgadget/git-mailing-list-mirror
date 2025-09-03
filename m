Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6653112C5
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918211; cv=none; b=LgNmVkuSxUCW7KeBCrKCldB2FRGNPe+swsL352kHazNWT/GXQ6WPQkyQJFognce6VZpxSTZCrVwqkXPDFl+f2/FP+y+NQDEJqclh76QBXVivYHKRXtp+frhJOfnquHl8a25x6rBkzD5XOqfJk/WnxMvIsxXPAlE3iMskp9+5hE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918211; c=relaxed/simple;
	bh=Tl6BcA1/Vhus32gKpMLcrTM258PLzxJs08ksxVsHMU0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fuwwN/SgErBNTKUUmCKz+T7DNXlGKrgqoRLPvEpIonMoU062KDTf/BPi7nyujDSKqIwHLtZHwK3TJoKQfq1Q3aYlC1mZUQGAbilFItuAVdZsazg53X3y97AGFQd9rHTT29C1PvWe1PCKRNwvJ+EP8jCLeQjJLlrlbbYXBB0cSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyjprbPs; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyjprbPs"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b33945989bso1970201cf.2
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756918208; x=1757523008; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f+Q540ToHXcxPdl2UWuaTJ4lqjnrU/kpODvY8J9Y6M=;
        b=fyjprbPsJb9T8QynDGYirEUabwT1946KNNaTXkc2jYPdS5h3MOJQ7kbdX59q4hpVQL
         ObK9UgnTEnwpemAhbz7CkYp0lOJkfRU9c+SF0LDb7MZCFEPMvEiy/5CYxrytBWQM5pQi
         tBnqydHbdPzb0PzWiQlnmPU9PiMs60txUdMH8JN2XxHzE9md+mB9ZmIrFMdC7rjb0Osi
         l/Q1jItgxRFg/N4+gLrJqjm4fOj2dJOn1aenH6Y/YNumjvWRUR72gMv/T9SixQ03oQH5
         WhvilbY+YxIcbtxr5wF3XljABWQ/JEJEhVT+f3RD9sbVfIEk/Thq14K0eCrjMq4OUnw1
         xBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918208; x=1757523008;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f+Q540ToHXcxPdl2UWuaTJ4lqjnrU/kpODvY8J9Y6M=;
        b=KfNqMTNgLi9cMq03gv5sEHXGpMZFYMwLn+Bsz5Mip2GfiltLOhdL9qFnO5nrReucKS
         k4gW/shLrthSdlr/EZ10rQYocdbCIud1sr7Y5xW56Oc2uwNsYC3kq/SwIssq1XX3Ajga
         Zt+da41qgg6lmXX0ZqL8TtE5bCsNuM0GKYXk+Gf+/77MllFGbt8YV0kGmB1pCRv2JV87
         zM3SN7QcgnAHrldtjrYVh8YeX4XPlBJimiN9t+S20z/adCyK2UhUA6zLAqKkPikrZNJ2
         aJAiAtTKCQaMhtM+qbdjNRS8/epK3JbqkiA/hyi93mO+Xr3UR99qjuW+1C95vIuIgz3Y
         cGNg==
X-Gm-Message-State: AOJu0YxGz1h17WBB0vzrL+ZxZl1Gd3mrK+8dP5ptr+X2T9dxrJbNwHop
	7iiO0dbIKISYGGsjn3nBU8ASUCbxK/Q0qsPaYDsEUc1WCjmLhnn1zPyCMxsv2w==
X-Gm-Gg: ASbGncuGfhgfOmZJ/nCqi16c1xlvODUPno94KmqXl5KLuD0+E4+yGH29AraSpCqnvu2
	PMrxPfySjsSVGypr9X9BMzV0vcL4zbmjVQhIt7rjVncJLqkUIPfC+2f85tbuGUAexTUUsjbhnqn
	sWzHbmN84BdtfyFOpuG3bT61I116Uh/Er/lIhDxztKPSVxK/PyxdN4YAtybNH+PPeaEy5oaeyL8
	vs1quJv1/jD4JG3j6Hxe/5UV2ihqTtQFxAbW4SRGbnu3ppjQX2bqr/mI99Mnrh1QIDZG6lksRb/
	t30G6Dr/OLxUEqOa+v/63JREf1NTvprsjRqToXjXOVx8s5kHSj8VtwF7uZRRwnCxa0Cocr+an0y
	+WkKDO9xGMhIWa+wlYf3YooLWre0384hwkD5rPY3WPEz3vg==
X-Google-Smtp-Source: AGHT+IECW9ZI1MyzuoZH1Abmh2eAXPo+ojbtTSKyS+4d0DEwXWw+BOZeSXFENTX7B/bVIReaPZ4x1w==
X-Received: by 2002:a05:622a:5144:b0:4b4:8f9f:7469 with SMTP id d75a77b69052e-4b48f9f8a35mr37989961cf.18.1756918208181;
        Wed, 03 Sep 2025 09:50:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.213.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aa60dbf87sm135896385a.3.2025.09.03.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:50:07 -0700 (PDT)
Message-Id: <043fec7e66dc57427f441b020f9eb7862ba93fc1.1756918202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
References: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
	<pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Sep 2025 16:49:59 +0000
Subject: [PATCH v3 3/6] doc: git-checkout: clarify `-b` and `-B`
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
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Remove some unnecessary detail about `--track` (users can refer
  to the OPTIONS section instead)
- Explain what the start point defaults to
- Describe `-B` much more tersely as "the same as `-b`, except ..",
  since potential users of `-B` are almost certainly already very
  familiar with `-b`. Move all of the other contents of `-B` to `-b`,
  updating the example so that it's appropriate for `-b`

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 44 ++++++++++++++-------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 50923ff118..a2777fb5b0 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -46,27 +46,21 @@ $ git checkout -b <branch> --track <remote>/<branch>
 Running `git checkout` without specifying a branch has no effect except
 to print out the tracking information for the current branch.
 
-`git checkout (-b|-B) <new-branch> [<start-point>]`::
-
-	Specifying `-b` causes a new branch to be created as if
-	linkgit:git-branch[1] were called and then checked out.  In
-	this case you can use the `--track` or `--no-track` options,
-	which will be passed to `git branch`.  As a convenience,
-	`--track` without `-b` implies branch creation; see the
-	description of `--track` below.
-+
-If `-B` is given, _<new-branch>_ is created if it doesn't exist; otherwise, it
-is reset. This is the transactional equivalent of
-+
-------------
-$ git branch -f <branch> [<start-point>]
-$ git checkout <branch>
-------------
+`git checkout -b <new-branch> [<start-point>]`::
+
+	Create a new branch named _<new-branch>_, start it at _<start-point>_
+	(defaults to the current commit), and check out the new branch.
+	You can use the `--track` or `--no-track` options to set the branch's
+	upstream tracking information.
 +
-that is to say, the branch is not reset/created unless "git checkout" is
-successful (e.g., when the branch is in use in another worktree, not
-just the current branch stays the same, but the branch is not reset to
-the start-point, either).
+This fails without making any changes if there's an error checking out
+_<new-branch>_, for example if checking out the `<start-point>`
+commit would overwrite your uncommitted changes.
+
+`git checkout -B <branch> [<start-point>]`::
+
+	The same as `-b`, except that if the branch already exists it
+	resets `_<branch>_` to the start point instead of creating it.
 
 `git checkout --detach [<branch>]`::
 `git checkout [--detach] <commit>`::
@@ -156,16 +150,14 @@ of it").
 	see linkgit:git-branch[1] for details.
 
 `-B <new-branch>`::
-	Creates the branch _<new-branch>_, start it at _<start-point>_;
-	if it already exists, then reset it to _<start-point>_. And then
-	check the resulting branch out.  This is equivalent to running
-	`git branch` with `-f` followed by `git checkout` of that branch;
-	see linkgit:git-branch[1] for details.
+	The same as `-b`, except that if the branch already exists it
+	resets `_<branch>_` to the start point instead of creating it.
 
 `-t`::
 `--track[=(direct|inherit)]`::
 	When creating a new branch, set up "upstream" configuration. See
-	`--track` in linkgit:git-branch[1] for details.
+	`--track` in linkgit:git-branch[1] for details. As a convenience,
+	--track without -b implies branch creation.
 +
 If no `-b` option is given, the name of the new branch will be
 derived from the remote-tracking branch, by looking at the local part of
-- 
gitgitgadget

