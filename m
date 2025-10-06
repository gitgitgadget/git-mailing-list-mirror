Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F12DEA7B
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777139; cv=none; b=hpW8zsYEhstj5LoDRhHwj4E12dvbUU9ZF0l0JdrQuTnVAPGTsqU5fAHyoyt/v55OJ834c63hKRaZFbgRz3Co7/kYv6SoRRX6tg8mVVAna18KL9tqd/nZ3euKvxxfLHI35uc3qSGLQNN5nCtCgRnDl99IH1y1lG8LZlyB6PzRv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777139; c=relaxed/simple;
	bh=mq5KaBc7nBKnHBj3Xt0B8TJv70Nh/zLkiM3vmWLaRks=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=T6/rg0otLc10bjBYDDdpipIi2UHtMGoeXkYubMDSjlN/waHReUrqqiB3X/uzBjmSULpvzR9ca+9JnB1Vd15WcJ7oy83RwFmSINZCeV5XhDOz4HxjDspXNKYNe7YwprQalv/DLQnIUmwckodrtM9Rvx4yXJGsKoXC2yToXqWUarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeyifnWu; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeyifnWu"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3304a57d842so4871532a91.3
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 11:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759777137; x=1760381937; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuhKkfZPtDqA5O4ISMLTfCbww4JiNHhRyj3gLVfx+HI=;
        b=eeyifnWu065gPjhqLAiicKD5wC4barN/rnVDiQuy3j3+Jv+F/To43ATMCldtwrMXZU
         55Mb01/myamfV2JjxxLYGMbPCQDog92fZB479bY1KEcPwjnAAhOjNaq/gcAdOYW2TX7Z
         bxfX1MtKxuJ2oTspjwDuipSZCu1opjuVyo8KNVyW2VCvYVI2M5ZD8QuiwGGgzs2dcczN
         uU8iNEVVmXW7MYzjHaFZ9O5KIfZ4nQRuByVMgq+VdFftzOPONDm3n+XrQIQnwCqsx7fN
         RywKYQf90N8DWqjcwEigQ+YVG54/iU+8UmOS80vQ1sRKEkSaTugmsLdwIMXn0sidJL+O
         ulBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759777137; x=1760381937;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuhKkfZPtDqA5O4ISMLTfCbww4JiNHhRyj3gLVfx+HI=;
        b=GrwIDF2tEnvrseaKkahEICwNSf5X6BcrC66QRUFquoWUfg/AEz5AAm9K3NDP5LS/J8
         YS4UVxrHuLqSLc+stJWlnL3/gLhvXEZCHwM53nZ049a7xIsEQYuHnfvtxyRObB5oPz4L
         6bFlF7NZV9SQNKHeq9JiMYrzS+99Kwr6py3CP9/5FmIWfbdx0W7IDoq+oG5Q779/NRWQ
         G2YjvvZ9ahLeuKmvA9CN9oSfibQDBEzDIsGK54OVA7TUS2dgm+4oO4pQdmvKCTzyyR0B
         j1nTRPIOnCoGjEzM7RnZCTrRlbzHEU/ZOhxL6NTiEPjA/lANA8neTguvClBKT0i0QYYQ
         ulkg==
X-Gm-Message-State: AOJu0Ywzr64eZ7Cm/spbzrovvW9nOrpR2lYZMTqE+zZLN9/IlWOFJzCI
	nXO0kE+kXtRBdmr5Ccc2Srf8HAfAjWiGCOf3XZS6j/rfPf+JN+D/jAHRff5+txvx
X-Gm-Gg: ASbGncsv/Ib5JmuxnCq3dV5ZLtc9nD6STBd4aAvGCOwxcO+1SmtkTe1tgSokCq4FzGx
	jljlx1tF3L9lTwafNng8vI98je6TpSf8FIlczaj6avqapLAisWgdm8SrajrGQEMGIJqcBIVVtDW
	8Pgm9KJ8H/FL80L5+l1BO4bCYjfOy9rhTnGwWyyBraE80rxgiMBEHPqgC2OaBwaOnaEkPuUtroq
	zPk3Jk6xdzRwQiZv5sO51cs7Kmv8z8YD80KxB3AE06+UgKwr2hCzyGPhTazetQTaaHVzmm6SxFd
	ieunlzjA7umPOelaWNQ/n6Ba1f4Bl1as+QPkyzfbZb27aLmtEt36u4re3UbTKRRJT/E5W5fgP48
	ylwLNzyfSpI1MTfVa859RsXepNL5dJF/eJkiKdi6rNbOd8iJpRn33jN2PuOne29teW6ARJjw=
X-Google-Smtp-Source: AGHT+IHkd9XdmLuJPqJoeX2+8l6nCb8QD2CgAVsv8TX/ZNTf/kx62o8EVVwMYnzE/BbTR6DNRnOTtw==
X-Received: by 2002:a17:90b:4b49:b0:336:b604:78be with SMTP id 98e67ed59e1d1-339c2784862mr16825773a91.25.1759777136752;
        Mon, 06 Oct 2025 11:58:56 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.217.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099b1e362sm12777872a12.21.2025.10.06.11.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 11:58:56 -0700 (PDT)
Message-Id: <10a9718421aa842573a2ba1ecf58d2cc46b5edd9.1759777131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
References: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
	<pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Oct 2025 18:58:48 +0000
Subject: [PATCH v5 2/5] doc: add an UPSTREAM BRANCHES section to
 pull/push/fetch
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
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback: one user mentioned that they don't know what the
term "upstream branch" means. As far as I can tell, the most complete
description is under the `--track` option in `git branch`. Upstreams
are an important concept in Git and the `git branch` man page is not an
obvious place for that information to live.

There's also a very terse description of "upstream branch" in the
glossary that's missing a lot of key information, like the fact that the
upstream is used by `git status` and `git pull`, as well as a
description in `git-config` in `branch.<name>.remote` which doesn't
explain the relationship to `git status` either.

Since the `git pull`, `git push`, and `git fetch` man pages already
include sections on REMOTES and the syntax for URLs, add a section on
UPSTREAM BRANCHES to `urls-remotes.adoc`.

In the new UPSTREAM BRANCHES section, cover the various ways that
upstreams branches are automatically set in Git, since users may
mistakenly think that their branch does not have an upstream branch if
they didn't explicitly set one.

A terminology note: Git uses two terms for this concept:

- "tracking" as in "the tracking information for the 'foo' branch"
  or the `--track` option to `git branch`
- "upstream" or "upstream branch", as in `git push --set-upstream`.
  This term is also used in the `git rebase` man page to refer to the
  first argument to `git rebase`, as well as in `git pull` to refer to
  the branch which is going to be merged into the current branch ("merge
  the upstream branch into the current branch")

Use "upstream branch" as a heading for this concept even though the term
"upstream branch" is not always used strictly in the sense of "the
tracking information for the current branch". "Upstream" is used much
more often than "tracking" in the Git docs to refer to this concept and
the goal is to help users understand the docs.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/urls-remotes.adoc | 42 +++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-remotes.adoc
index 9b10151198..57b1646d3e 100644
--- a/Documentation/urls-remotes.adoc
+++ b/Documentation/urls-remotes.adoc
@@ -92,5 +92,47 @@ git push uses:
 ------------
 
 
+[[UPSTREAM-BRANCHES]]
+UPSTREAM BRANCHES
+-----------------
+
+Branches in Git can optionally have an upstream remote branch.
+Git defaults to using the upstream branch for remote operations, for example:
+
+* It's the default for `git pull` or `git fetch` with no arguments.
+* It's the default for `git push` with no arguments, with some exceptions.
+  For example, you can use the `branch.<name>.pushRemote` option to push
+  to a different remote than you pull from, and by default with
+  `push.default=simple` the upstream branch you configure must have
+  the same name.
+* Various commands, including `git checkout` and `git status`, will
+  show you how many commits have been added to your current branch and
+  the upstream since you forked from it, for example "Your branch and
+  'origin/main' have diverged, and have 2 and 3 different commits each
+  respectively".
+
+The upstream is stored in `.git/config`, in the "remote" and "merge"
+fields. For example, if `main`'s upstream is `origin/main`:
 
+------------
+[branch "main"]
+   remote = origin
+   merge = refs/heads/main
+------------
 
+You can set an upstream branch explicitly with
+`git push --set-upstream <remote> <branch>`
+but Git will often automatically set the upstream for you, for example:
+
+* When you clone a repository, Git will automatically set the upstream
+  for the default branch.
+* If you have the `push.autoSetupRemote` configuration option set,
+  `git push` will automatically set the upstream the first time you push
+  a branch.
+* Checking out a remote-tracking branch with `git checkout <branch>`
+  will automatically create a local branch with that name and set
+  the upstream to the remote branch.
+
+[NOTE]
+Upstream branches are sometimes referred to as "tracking information",
+as in "set the branch's tracking information".
-- 
gitgitgadget

