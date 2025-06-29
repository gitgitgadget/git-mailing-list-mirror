Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB932222DD
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751203254; cv=none; b=gKL2HsCsz0DH42vD1qkP4UtGzZvU7tmQEsxJVHYj2jfx1GtKpnE/UNdgWU1DgFwsr0W6ceZhUqSi6B9GBB2KOAhtS7vr93Lkg0kEDuSffxTeb5QuWgaIRH49Ik0O5uCXfqPTH14R7+TSMH7vukb0mEPtfxCQfqrDatOYSf+W7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751203254; c=relaxed/simple;
	bh=sVtkgW4IuCU1RRsxeG4rYenIUVhr9/GlEdb5+klktQY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=M/iOfbOVgLZMIcLD3mjNDZtL6d367KiWf1MH25Pp6WH6IqIGn1hSosbmsqkGNSHpz3WGDdvTZGE6s8TZSYQL0ll1kAyQ1PIf0n/wJKoA+/BJ0I7hMBuQXmih2Df2uX7BHJnA4dlnaYhp3tArojCCGArzpvMJwfCAd/1HS+qA4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT1kUvOK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT1kUvOK"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so1006495f8f.3
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 06:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751203251; x=1751808051; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnX9I5C8cILuDqN9nKqwp1+GsMoj2E4XgxwEMzagsRg=;
        b=ZT1kUvOKBi/YhVYa1LSfDZDbioLWWKBmJCVt3qydi3kwDVrpxukDBPOU9BjDlrjcaS
         DnYZBLGMm5pOzGVmGCEgr3G2Pv/9vLhY0PnG6cb6YZMKkwmJNif0buOHDJeQqYhTCW9/
         srBulWvW9JvcbyC7gaoH0gsk+mQQbhAF+5mzy3UflBs95rz+BZJ7glfM9BjSRN4+9PqN
         eS5kHnWewVBd7KzMoRwqDneNlHgoV1PgZr0qd7k7J8zOGiCnoE/Ea/XRYDF50gHN2BEK
         tm28Q2WkCv4tKx06P/AuTnqmARGzKy1LFw/Xo2bnDN0Xsju0pA5AeW6Rjkab5+AMoF8v
         hTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751203251; x=1751808051;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnX9I5C8cILuDqN9nKqwp1+GsMoj2E4XgxwEMzagsRg=;
        b=jWmFD72EWnVHk/vSe5sQqqc1itlXOTVzetMqpP38RsaKkx4xBVeQ7O4XFxnt4lSzWf
         ld9UpRv9WEk3jXAnBQZHW7AsJ4mkRpiw7FibjjahvCqsrGl7XwuJWwWeDWHmJy+GyY8Z
         2wweoh69owS8XQyTDOEJyZ3NCJ8Sv6AV9hOwDlbEx2tnkfWCiLlIGuGb6tl/doHZwhNg
         dN+Cd2j3Cgus+pVSTFwn54j5cWFxlGFCKlG7oqWwei/hP6Vv+0sNo/AC1hm6BY7d23YS
         ad+JI++VCaLwm6uAOp1ZE+vcdbz65FFu/ZshUT1C+q8sH6TGMj+xYUz+JRRkewO5H/Ip
         fveA==
X-Gm-Message-State: AOJu0YzfNEzQcR44mBk47BsucKRVqrA5zVwtTPzb6vBQ4vetevJRdjjI
	k7iiAIxjTOmkiqtByLeDPmrp80YuChaeCA2DbYvV5FI8xIaEdIxzAGh8gVsugg==
X-Gm-Gg: ASbGncvLethF5WwCYfJrCRTK3Ac3tpYptrw+eISxPnt4NurcjYy9wPuVQcnwArIQWHa
	djapHoJkSJsM+BEhTqP7N6EpRSCJLfvq3TEzNIgmWts7ih5puYE609FqHk3txTkdrhLiwMEncdw
	Z+1r+Y98czq++Zt0+p5D4yVybKxYs/Lx8A4RN4DqemKwpytCK1564Z+/5j7/1ggWybi0xyFXK0X
	KZK9NuMS7PAxGUi4bk+VpoxfsIEp2x8FW92XiRUEx7RUj3MekovjXtVsX65+U+4Udj4TJrh39qR
	5YB/WDNq+gpCAKNfcG0SsVmxMkvOfPGdfCA5NECYPKq44J0v59uRa424qWVCL60=
X-Google-Smtp-Source: AGHT+IEZYPRLEGONNRKSRsX1S3cdKKonY4t5r8LsXH7okijmKMnZZtOV3+XOJCC3UsHG+nS+HNWqlg==
X-Received: by 2002:adf:9dce:0:b0:3a4:d6ed:8e00 with SMTP id ffacd0b85a97d-3a8fdeffa19mr8153671f8f.33.1751203250493;
        Sun, 29 Jun 2025 06:20:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7098sm7631259f8f.4.2025.06.29.06.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 06:20:50 -0700 (PDT)
Message-Id: <c2346eb580c8bc802598d36bc705c1a067ce1aad.1751203241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
	<pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 29 Jun 2025 13:20:40 +0000
Subject: [PATCH v2 8/9] doc: git-log: convert diff options to new doc format
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
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

