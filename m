Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58545C0B
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006578; cv=none; b=I7R9PYExa2AwUUqVteZx+LFautz5dGytupuRnDMc1rr8JRlRf5Zaf9szmh4JMtcfAdoAuZJ/8DE6VuPumW+hDR3EhHXYINjWimRqZTe5QKUg4+ennZSAzA6KHcEBiS6juHFlHsfNWY3HXvXzC/VdtWp04zLo0CrkyuPi7DKx46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006578; c=relaxed/simple;
	bh=za/ukFKQGqA36EPz1/OuDEbzJFgoW9BziIJMv34+xwI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Mg/EuZdIqK24yYv+KkLT67zOCoLavc+NQiD7bkTpi9aia/3s3r7jI8wW82oTlByawf+xmPvcQXSRK5X0LnGGMs2V7MnHUBW0QhT5Qs3GX17At8xf1BisRFTEgfW4GSg3SOc+IFnOhvC8uJoNsB1pt9YJRFMcDpp3qJCiZY+j9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILwBCLmE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILwBCLmE"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9163ac059so75852f8f.0
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755006572; x=1755611372; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxMO6H2NhV3OshelcB7U0Qq9bv/miJ2JN23nmRaw7LI=;
        b=ILwBCLmErLv0cQrNXkFBhZecZpIeU48BJkHr1qmc+plCXA3zNooKsGRL5KJSlUKHjP
         W9TKP/oUeBdndBqrD+HUOC+8VOxnApHDmslhINl/o8ZDKkbBRlI0UksjMr/xDQFcYVby
         AEZ2J0SEtJscX16qhIfTTfqZFNOVemwJPypAYx5fKQn/stVpbVugV90PIypedziQFTX1
         rUMIwkXqiKcOnnAST809MTLVxDqtzDeC2Ssp/9WapYnEWTzR6r6zNlu+2uXJtU6/P7sI
         UCHHR5c6Kxxi8Grr1zG6M2P3Yua2sowfo3fQr8p0lqRlIM6mL9IXESCfLBCSvl6xMM3r
         lCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006572; x=1755611372;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxMO6H2NhV3OshelcB7U0Qq9bv/miJ2JN23nmRaw7LI=;
        b=hVd8WWVKiCTSrIiEmP0SuazycK5b7N72T/KSwDRXhQgeyJc1ZAh5cHDor5N4edhWaN
         yEDs5DxG//ijk/s/k5g4JIomkmg+PrAdnePMXWmuUk1kK0sta1tgextPrhuCesj0DSDN
         LkMjqN7diLW0HtVvX1dQNztksm3tdT+mDe4/J60edgXTg5xQveQ9I7Y5zdvGzgXXUR7C
         UXHt+cr9UeE395BIcXsduCy264bM+ZBgchAq2+jeu5f4Ok39vnKFJ+mR2lCUKQK4imOX
         iI5OOh1D8ofgNmtEQywmEVgoAhMMWaFQBMg9wF8AV/ShB6+JMfYxu9ZXbGuOocD0b1Zp
         Lriw==
X-Gm-Message-State: AOJu0YwmFDJOV4my6wExC0wDu7XRDpNki2vdmAkOLxfEGdpHF/HdD+NO
	/Rju+v2kngSAOdgclCBr3t9x6XXZWBmO/j8gb37FbG28fvwi2MFE4A1UcSmJ2A==
X-Gm-Gg: ASbGncusMVY3cRTlsN2A6PGau2XrkCHOaYQ/8/IPxUM8WdPMde5dbjdL6pZAxiUZTdR
	VWGtAm4LjPAUYN+ce7YeXe+9CuNfL/EHGhRn0eBI2Euq3bb+9SJQc0U+6t5hxmcChiTvKByNXBI
	Jb2Ps3KfKG/UrpER9VtkxUo56KgHTO3jOU5p/kfqZYNIi0os3hNAGxT0O8eApr8EJqnrexrZdSO
	F5N5xTphTZbQI0lhJ6ke1RFklJ09E1bQtWM7dgY5KrHPw/n29QD7MJKb0H6Gd91Frjn/35SFs9R
	4VXx1sI+58p9PKrz8Wt5pnpjUJ0DvkKsSIVEOXkZzKjB01RaW397B0kQT3YzdQNQf3v8WWiNfW/
	w24cVED/EhRB8URj3J/g0UhM=
X-Google-Smtp-Source: AGHT+IEjT05OJqHJFbtTQ5k5nBKF86y4TCZLINA8pavOHQfxlFtnsJ3nF+sO7zeAPrfctxrBidqzfg==
X-Received: by 2002:a05:6000:40cc:b0:3b7:905e:2a32 with SMTP id ffacd0b85a97d-3b910fce9b3mr2973426f8f.12.1755006571452;
        Tue, 12 Aug 2025 06:49:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b916394937sm278067f8f.6.2025.08.12.06.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:49:31 -0700 (PDT)
Message-Id: <ad63f69918df0130b6b0236d04e27f8529115cd4.1755006568.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
References: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
	<pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 13:49:25 +0000
Subject: [PATCH v7 2/5] doc: git rebase: dedup merge conflict discussion
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Previously there were two explanations, this combines them both into a
single explanation.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 49 ++++++++++++++---------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index bb5a3ff7f828..e82ceb9cbfce 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -42,6 +42,26 @@ shortcut for `git checkout topic && git rebase master`.
 ------------
 
 
+If there is a merge conflict during this process, `git rebase` will stop at the
+first problematic commit and leave conflict markers. If this happens, you can do
+one of these things:
+
+1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
+   and make edits to resolve the conflict. For each file you edit, you need to
+   tell Git that the conflict has been resolved. You can mark the conflict as
+   resolved with  `git add <filename>`. After resolving all of the conflicts,
+   you can continue the rebasing process with
+
+   git rebase --continue
+
+2. Stop the `git rebase` and return your branch to its original state with
+
+   git rebase --abort
+
+3. Skip the commit that caused the merge conflict with
+
+   git rebase --skip
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -77,13 +97,6 @@ any commits in `HEAD` which introduce the same textual changes as a commit
 in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
 with a different commit message or timestamp will be skipped).
 
-It is possible that a merge failure will prevent this process from being
-completely automatic.  You will have to resolve any such merge failure
-and run `git rebase --continue`.  Another option is to bypass the commit
-that caused the merge failure with `git rebase --skip`.  To check out the
-original `<branch>` and remove the `.git/rebase-apply` working files, use
-the command `git rebase --abort` instead.
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
@@ -186,28 +199,6 @@ This is useful if F and G were flawed in some way, or should not be
 part of topicA.  Note that the argument to `--onto` and the `<upstream>`
 parameter can be any valid commit-ish.
 
-In case of conflict, `git rebase` will stop at the first problematic commit
-and leave conflict markers in the tree.  You can use `git diff` to locate
-the markers (<<<<<<) and make edits to resolve the conflict.  For each
-file you edit, you need to tell Git that the conflict has been resolved,
-typically this would be done with
-
-
-    git add <filename>
-
-
-After resolving the conflict manually and updating the index with the
-desired resolution, you can continue the rebasing process with
-
-
-    git rebase --continue
-
-
-Alternatively, you can undo the 'git rebase' with
-
-
-    git rebase --abort
-
 MODE OPTIONS
 ------------
 
-- 
gitgitgadget

