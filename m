Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A74B2D46DF
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531679; cv=none; b=kT2bYZEQvR/6iopT2UUGpsF2mWt2rWWHpK0Blnw3HczipOYa7kI8IAW6sJmNWq0oGSBoA3CR4hXaZiCYuaS79FxNGJg6F2rLGwyP8pJaSvzhXz7VcH9TsBvL2oWe89DtU5nVkqyz4uoJ13GsOFpZyof17D/mUVj7sJB6C3OrcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531679; c=relaxed/simple;
	bh=ixc8zRlTw6ABdgNUANwWlVYzcWmsUFuozov33T5iHCc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RdJFA5hCNQk7qUN7YAr2hkHhn/HpOZ2fSRYIlWgLSE+9Q55+qeMd2zqLTMzyoKfP7+pNAMeSVt33VOWNPdyiwx8d9J8Z7C4Tb18gTwihzk++An1tRcu0P6A4J4UnGpL3a+tpwavb7IeF4FWyAo3NwvwhEyzuE6x4rxnZBRSdI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NV6espu3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV6espu3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32dc4faa0d7so846694a91.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757531677; x=1758136477; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql5ftJtxhqkrMKPer/MOxN8XPYRMlYm/MEqZwwC5kag=;
        b=NV6espu3PTn4zWoOKM+wbro/nWi0mna+heJg1qAtTvA+lDbz4sODkqufTYh6Xv2qXh
         63rWTrxsQWqnG7raUH/QpQzRCHZ7cILJkExvpQxp9rkXShzun+W8CqXTTN/2nrt16RCE
         AsKSpoSVh3fr/jhjBHwRFTCD2Z30c/TYP9z7sqkpOnCrCkipf77UlDz2fWivh/yx01LM
         5NVq3jeNexhrtlnMVi4eh6QYmtKnzRHB0xHu81flKEy/U6BdrmKqsvBpi+QQnsNP7hYm
         mve5TYhSFwd7mG7WzohNsLgKCnf/tL71F9Ke6OcuWjQCA0jT6qhWknIVvhn8WkSFdduV
         1dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531677; x=1758136477;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ql5ftJtxhqkrMKPer/MOxN8XPYRMlYm/MEqZwwC5kag=;
        b=GW/a8CHHNbLYrcjMZ1XO+SflYsPUaTKKTtglUwE2Ec5Spc+VSjbYwB3u3krzRdgLJR
         cXfZ5yAzFk5bNVq4B/XblD6KyMKuY8Z93Un+CHnhRFJxwD7dK6aJvZolWZPFDioo0FWL
         TmEyAtO6iMw5nGBFccNT8ATY1vykyXoAWlYpBoZGM4GDULfZhsX0ouE322Yr8Y60nl7s
         ufsTS1lQkbKpv7rJUeLUctoWI7XJokYdQWXfOOACHUUS78YIbclOmyURBWaMYws6ExYc
         5KVmCCNgCW1gG3Gz/+2nz3hTmRi83Xo2qojIhBBz+t/Xo6TKcmI4TqFV7CrP0rOJMINR
         ho/w==
X-Gm-Message-State: AOJu0YyX29iYIIRoZh/ALZizmEsYS/kOkMXOsQL4sIraX/5tG1Q/lHfp
	KJvrk/iH8HEWOHTVx8vg6hLe6ibaNzzBSU2uDB0O1LIImT6RAdsMV7v7v0/RbQ==
X-Gm-Gg: ASbGnctF5XOTj55VNYJran3hLoumhb4fJsZXZVp4iLNyZE0E8PW1ksPSKIpWCRIMU3h
	54CMR1mZ1EeVyQ6gTnqFuvNj6ZqELQZhGcB7B5n2ZaTOqBfXqwplnCkaEhd3w9yI/qXLZj7JA07
	LPR/EcCD0t6cW18fkby9Blt3EFZefsJu3CdTQpP6Hc5+LR+IV7bx8hpSKGepSFD2h6h83fQAnsL
	YM+lghQPNLfGw8dMh+vfQwbUXLquS9s1sQpL1N9W0YPd98vAqA8At5JLbMxAHpikE68H6jTYA0x
	ciwpeL64+hE+f06IZxhCoFA+TamJSXQtg/0Xwvsxjr0LOheKQqWIwptcH2Y9DDMVPekjAyffJKB
	PAEZXygurncih8Ji3WLeIhsjEIy0=
X-Google-Smtp-Source: AGHT+IEm1+xaCb+Tz5M1A8oQV+o/FG6lbklahg5Fqvw/MG3+ISHwITTxc8ORm/ifyswTzKvPjhlzrQ==
X-Received: by 2002:a17:90b:3f8e:b0:32b:9f1e:ef0e with SMTP id 98e67ed59e1d1-32d43f66628mr21679573a91.23.1757531676811;
        Wed, 10 Sep 2025 12:14:36 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.201.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb60fadcsm3440268a91.21.2025.09.10.12.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:14:36 -0700 (PDT)
Message-Id: <e636475cba2246ea98e461579a25b41b0ef4e99d.1757531669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
References: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
	<pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Sep 2025 19:14:26 +0000
Subject: [PATCH v4 4/7] doc: git-checkout: clarify `-b` and `-B`
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

From user feedback: several users reported having trouble understanding
the difference between `-b` and `-B` ("I think it's because my brain
expects it to contrast with `-b`, but instead it starts off explaining
how they're the same").

Also, in `-B`, 2 users can't tell what the branch is reset *to*.

Simplify the sentence structure in the explanations of `-b` and `-B` and
add a little extra information (what `<start-point>` is, what the branch
is reset to).

Splitting up `-b` and `-B` into separate items helps simplify the
sentence structure since there's less "In this case...".

Replace the long "the branch is not reset/created unless "git checkout"
is successful..." with just "will fail", since we should generally
assume that Git will fail operations in a clean way and not leave
operations half-finished, and that cases where it does not fail cleanly
are the exceptions that the documentation should flag.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 44 ++++++++++++++-------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 0db32b098e..7ae2ae9483 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -47,27 +47,21 @@ $ git checkout -b <branch> --track <remote>/<branch>
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
+This will fail if there's an error checking out _<new-branch>_, for
+example if checking out the `<start-point>` commit would overwrite your
+uncommitted changes.
+
+`git checkout -B <branch> [<start-point>]`::
+
+	The same as `-b`, except that if the branch already exists it
+	resets `_<branch>_` to the start point instead of failing.
 
 `git checkout --detach [<branch>]`::
 `git checkout [--detach] <commit>`::
@@ -157,16 +151,14 @@ of it").
 	see linkgit:git-branch[1] for details.
 
 `-B <new-branch>`::
-	Creates the branch _<new-branch>_, start it at _<start-point>_;
-	if it already exists, then reset it to _<start-point>_. And then
-	check the resulting branch out.  This is equivalent to running
-	`git branch` with `-f` followed by `git checkout` of that branch;
-	see linkgit:git-branch[1] for details.
+	The same as `-b`, except that if the branch already exists it
+	resets `_<branch>_` to the start point instead of failing.
 
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

