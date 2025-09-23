Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97131285073
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649482; cv=none; b=tv5fpsGg0h4MJ5JQhVhSbaudec0BJP8iyAkj+TNSIBPr7/g1Z27yNBsgINrw8BaQy+yWst8v5PKB4H5LfGz7NUX7MSicEQ4zaZb1t3WZCkdd4f17VKf0o4pUjoEAYujSOh9zVoOW91nXZSnNs2xLVMQhBdv4Cthuu4FKgzEkBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649482; c=relaxed/simple;
	bh=AgbVflgb5MNJEuG3QSvMjmxBGFUI7XalEMW1aQQ+lsE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k2SkJyVDZWE+WjFbsghRy/Vfiqro+1X1Hku6p4EdqDMmk+DjjjABLDpVytTZVc7tQfI3sQ1sKKuL0prwTXjFsZ576ndlfEF4WMY9bT/fiG/IFUtzDqdyjhLFMojRyOcy+Z5FAI1S9CD0N6/d1rFWnSuaVo16A1W4FnYiyUIPgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXF8/yP3; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXF8/yP3"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-88776dcac7aso191627639f.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758649479; x=1759254279; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f40TmGAAM9QvWojrPwfH5YOF0qvFgqnwwNQ5u2xFLaw=;
        b=JXF8/yP3qanc+EcsS4mq0gEbFWDatZgsu+fsQvEQbVimPaP2P6FYH8MsvQo5E6wg2u
         6//Hgzd2gXU1Uql6109h8bnUKu9A4jQnf1SiRndr/R5BFZeqW09ScQEUCWaZUQwczU7Y
         GZyiktk7HcCiT9lDjlWr1bPddXd/CN1RaO0mrIp+4y4pO9jvb47gfttcbHp03gdP8udb
         rk69rxxKoW7XudBYOw/a/Z4ixSktiUxTupTaq5I0IGiguI0XC2s9P7ji9bOy/cjaHATM
         WNdbz0YCY1/x9t7GHCCK5rQECgP9pxsPrWTHyx21IjzCzSd+qrWyxlyWpTB9vXloBGkf
         AqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649479; x=1759254279;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f40TmGAAM9QvWojrPwfH5YOF0qvFgqnwwNQ5u2xFLaw=;
        b=mMZif79yICVHhL37q74w5IlMK5yhbKHcwBTBJVJAiPyZsbt/IWOhYQupP9qzZnpf2a
         5rCIVWt03iVO0ZWXHqYV6rEyg1N1qAVjV9JkxDAD1Sapgz9KmMl1ez6nw6i+O54qTIcw
         o2insPfzICY+Ug5jTBTRQzM2/nYG0NikNO1Ly8/0/vEaWZ8IbcSKad6YoHw3sUFTXqhz
         Js9ED2eKIOwAe6ECTNESMUiGxYKCJDPgGjYFDCziNIy/lOd44s73EqdVHnsafIbhiZ+B
         oX5ZgRJnGXLkpbVzThXJ1Tw9mzD/4+o7mJUZ1Xdsx/r3kZsc9nn/SiKAOqcH4ZJiuknw
         thNw==
X-Gm-Message-State: AOJu0Yz3w1g75F2C6L4zuzdKGXcUQmNtlXNi8zvOgMfFMdsoq3mcMzs6
	tIy9zwTIbhiA4UWCdJG88N09P1XubgOnR3fejPjc8LqgWrdl4CLZv581LK/pdhrz
X-Gm-Gg: ASbGncu2hq74nh9Iy464iE+QzWJ6MxcB/4f++OqeRsi56UIhDXzYmDgdfN9pTXMaVma
	NSKrGYrCXefcq4AnLJgOwlCzhiVDSWgACuiDgxsJASUARPZlYuxn884GGBJrQaA50zGsloi0fyr
	jmdAvvT1sv3ffx6Y7Y7XRrKhZ12VRufbPWHmuauxzOAZshFA5NOvVnE5/eRXQjh7/w7YcG665cq
	VXsMhd5P8SETgJQbklGcoV3sGV+3B2af38605+9BiK68MMHS/TRqsf1ZsljcWMfzMtlLkv0ZD/o
	815BfygB6xHZTWz8QtDenDMA+pM1u8XwlPPgWFAO61QJgPbCk0xDvXIoqjZdDoGenVGI/yFkFp1
	2FwCwsXoLf1lZjswq2T3RzHZa
X-Google-Smtp-Source: AGHT+IHS5Y28ZL+2/f7ISiUNgQ9eOICit1dg85YuZPDEACqhMPjDIvfy46Kz1pjTiXG4xQSfXGel9g==
X-Received: by 2002:a6b:6807:0:b0:886:fa71:f544 with SMTP id ca18e2360f4ac-8e207385375mr479314039f.17.1758649479227;
        Tue, 23 Sep 2025 10:44:39 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.97])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-55dba4465f4sm2653094173.37.2025.09.23.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:44:38 -0700 (PDT)
Message-Id: <3ecfb5c3a67723f160e8161e212d77f95964539c.1758649472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 17:44:30 +0000
Subject: [PATCH v3 2/4] doc: add an UPSTREAM BRANCHES section to
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
UPSTREAM BRANCHES to `urls-remotes.adoc` and rename it to
`urls-remotes-upstreams.adoc`. That's an awkward name but at least it's
clear what's in the file.

In the new UPSTREAM BRANCHES section, cover the various ways that
upstreams branches are automatically set in Git, since users may
mistakenly think that their branch does not have an upstream branch if
they didn't explicitly set one.

A terminology note: Git uses two terms for this concept:

- "tracking" as in "the current branch is _tracking_ some remote"
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
 Documentation/urls-remotes.adoc | 44 ++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-remotes.adoc
index 9b10151198..1138a5889d 100644
--- a/Documentation/urls-remotes.adoc
+++ b/Documentation/urls-remotes.adoc
@@ -91,6 +91,44 @@ git push uses:
 	HEAD:refs/heads/<head>
 ------------
 
-
-
-
+UPSTREAM BRANCHES[[UPSTREAM-BRANCHES]]
+--------------------------------------
+
+Branches in Git can optionally have an upstream remote branch.
+Git defaults to using the upstream branch for remote operations, for example:
+
+* It's the default for `git pull` or `git fetch` with no arguments
+* It's the default for `git push` with no arguments, with some exceptions.
+  For example, you can use the `branch.<name>.pushRemote` option to push
+  to a different remote than you pull from, and by default with
+  `push.default=simple` the upstream branch you configure must have
+  the same name.
+* Various commands, including `git checkout` and `git status`, will
+  show you how many commits have been added to your current branch and
+  the upstream since you forked from it, for example "Your branch and
+  'origin/main' have diverged, and have 2 and 3 different commits each
+  respectively"
+
+The upstream is stored in `.git/config`, in the "remote" and "merge"
+fields. For example, if `main`'s upstream is `origin/main`:
+
+	[branch "main"]
+	   remote = origin
+	   merge = refs/heads/main
+
+You can set an upstream branch explicitly with
+`git push --set-upstream <remote> <branch>` or `git branch --track`,
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

