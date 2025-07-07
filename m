Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F5245020
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914426; cv=none; b=SaWS5kJaPrkeE+Z2lzaxQyxV6HMTuOVVxPuYsYsU4IiGVabbwL0HvQ9DfISsNDtEAoxJEnE0cwcCUaMtSShYizu3IyT5MfFh7LfLXjBaYGRma06Czzr1730MVKDuShtKK+vS4WLiKY45tS6EYLWq9J8k0U1xgUPGueLXv8rMzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914426; c=relaxed/simple;
	bh=sVtkgW4IuCU1RRsxeG4rYenIUVhr9/GlEdb5+klktQY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=IOzzAs4OrcKiLfF9mUqaWCfDak9KeDFnsQYxO4GtOFBumGSzxpPFt7PQ4JPymcnoGqA7LeL5Dx55cCUtKr+xDoxqzuC93FtYlj9DodL3p8Q8en+D2mg3SI4geMJLTSBs/wBsvxBPMzd7AWchjHWMcjxD0oxMKUUISwIo6TRqarc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grQIsnTI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grQIsnTI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d6ade159so30743165e9.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 11:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751914422; x=1752519222; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnX9I5C8cILuDqN9nKqwp1+GsMoj2E4XgxwEMzagsRg=;
        b=grQIsnTI6fOMmhNcz0gkeFTwBoX2XvaC/HDNc9NxL4llVcs55fCfG1X7YlKkT19hgO
         3R0+rlj8b2jzy+Dfxj3jLcM1JqV/FR6bRTV7MWmESHIwrFQvc/KAtPfj1cr7+HrUb0yM
         KT8o1vYlgsF/7yr68Hh+Qye6ieh5ZsttduYW6jRf9y17EELrZRFwKr7Smi5x5J8jr6LN
         6N4kWTV2yfFb+2j7ffdOihJX7u4jb/aPkbdUhEFBwEJM0Iur5PCOEyVFIez5ZFhaD/Dr
         WU3kFI1YaXW7TRqLXPQNrZeH1cDAj2YCq+jfQYi10UiHqzS/NDoO1viSQGbzluPfrC/y
         MI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751914422; x=1752519222;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnX9I5C8cILuDqN9nKqwp1+GsMoj2E4XgxwEMzagsRg=;
        b=SIuA6hGP5ItZbPzjphVyMaGAkeO/CANUYDcVzPXdDhQnemPmgruIUPv+Xsearo0gTC
         R9bwHD2wDFwjlpEtv8UFf3JwFxOJToP4ImelTGHe6b+G5aEin3fP364YF3dVaDtXXFTg
         zwSxchQdvzTzG1EbZPwz2zlGZydUAxYGJU73bva+x7gJ+znOLYxYFqiZTlbCZ3emxPJJ
         OJBSWZbUw0Cr4Yr6pVuppHvuDur8HojTTtcpmbLukJ4wlukg9WaXj+EuItCBH9OJLj83
         iyqhlQq73uzy7dlV+1cidJmXiSJYr1UZ3ijedSv40lT2+0c8YfXZ0H7eFEE7+gkhswse
         qyMQ==
X-Gm-Message-State: AOJu0YzvwgVgg9vqAauzGcWRCkBAE7tUBX2Bput4fZ7HxOTg172nQe0n
	NZq8yaOben5e16pFcCj7XV9DQmbYf7D3s+rwS+GXqTELdYucSrz2TWT9I465Lw==
X-Gm-Gg: ASbGncsc1barsocem4Ce/anKBkwE7DCV/cGHtZT/2yU8riaSQCG6R/Am05EaNCJbt24
	EJFGoR3wKpZmZviOvQff8kDWrCP6jiXMp7QpKNmQPGNYqOXcfVE23uYUAfuhUZNHNIzRzX42hsa
	DtAEF47soOKd/DRw5L1Zz420Iz77gqS7uA0b4aTxzhGVkIaa/jKVom6t0/oCWURvvmxShj4LEbd
	zwTQAPmpnJAfIME3FnswoNScP92tihhTaIAGWsZzclTi3tLWQ4AE+APHOawiloVWDw2qZwiHCCa
	PUiWrrnqfB5Gx9Fm7F4h+sKIAvGYG7lZraMKexDidCaXtgZ3Xjm8YVmEFG/t9zU=
X-Google-Smtp-Source: AGHT+IE1PnDqBzJkUv2eoqS42hxO3AD544P8o00JxrX+mTiIGWD9PjA1qvtolfDa2b6Qls7sEGpc5g==
X-Received: by 2002:a05:6000:4308:b0:3a6:e1bd:6102 with SMTP id ffacd0b85a97d-3b4970429fdmr9497022f8f.49.1751914422144;
        Mon, 07 Jul 2025 11:53:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bd4dsm10843395f8f.7.2025.07.07.11.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:53:41 -0700 (PDT)
Message-Id: <207fc49a20111109ef18fcf2ae6d3060312a8aa9.1751914412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
References: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
	<pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Jul 2025 18:53:31 +0000
Subject: [PATCH v3 8/9] doc: git-log: convert diff options to new doc format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.
- In description lists, put each option on its own line, to make them more
searchable and enable automatic translation of the options.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/diff-options.adoc | 40 +++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index 640eb6e7db58..f3a35d81411f 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -37,32 +37,32 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
--m::
+`-m`::
 	Show diffs for merge commits in the default format. This is
 	similar to `--diff-merges=on`, except `-m` will
 	produce no output unless `-p` is given as well.
 
--c::
+`-c`::
 	Produce combined diff output for merge commits.
 	Shortcut for `--diff-merges=combined -p`.
 
---cc::
+`--cc`::
 	Produce dense combined diff output for merge commits.
 	Shortcut for `--diff-merges=dense-combined -p`.
 
---dd::
+`--dd`::
 	Produce diff with respect to first parent for both merge and
 	regular commits.
 	Shortcut for `--diff-merges=first-parent -p`.
 
---remerge-diff::
+`--remerge-diff`::
 	Produce remerge-diff output for merge commits.
 	Shortcut for `--diff-merges=remerge -p`.
 
---no-diff-merges::
+`--no-diff-merges`::
 	Synonym for `--diff-merges=off`.
 
---diff-merges=<format>::
+`--diff-merges=<format>`::
 	Specify diff format to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in
 	which case `first-parent` is the default.
@@ -70,48 +70,54 @@ ifdef::git-log[]
 The following formats are supported:
 +
 --
-off, none::
+`off`::
+`none`::
 	Disable output of diffs for merge commits. Useful to override
 	implied value.
 
-on, m::
+`on`::
+`m`::
 	Make diff output for merge commits to be shown in the default
 	format. The default format can be changed using
 	`log.diffMerges` configuration variable, whose default value
 	is `separate`.
 
-first-parent, 1::
+`first-parent`::
+`1`::
 	Show full diff with respect to first parent. This is the same
 	format as `--patch` produces for non-merge commits.
 
-separate::
+`separate`::
 	Show full diff with respect to each of parents.
 	Separate log entry and diff is generated for each parent.
 
-combined, c::
+`combined`::
+`c`::
 	Show differences from each of the parents to the merge
 	result simultaneously instead of showing pairwise diff between
 	a parent and the result one at a time. Furthermore, it lists
 	only files which were modified from all parents.
 
-dense-combined, cc::
+`dense-combined`::
+`cc`::
 	Further compress output produced by `--diff-merges=combined`
 	by omitting uninteresting hunks whose contents in the parents
 	have only two variants and the merge result picks one of them
 	without modification.
 
-remerge, r::
-	Remerge two-parent merge commits to create a temporary tree
+`remerge`::
+`r`:: Remerge two-parent merge commits to create a temporary tree
 	object--potentially containing files with conflict markers
 	and such.  A diff is then shown between that temporary tree
 	and the actual merge commit.
+--
 +
 The output emitted when this option is used is subject to change, and
 so is its interaction with other options (unless explicitly
 documented).
---
 
---combined-all-paths::
+
+`--combined-all-paths`::
 	Cause combined diffs (used for merge commits) to
 	list the name of the file from all parents.  It thus only has
 	effect when `--diff-merges=[dense-]combined` is in use, and
-- 
gitgitgadget

