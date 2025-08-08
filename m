Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C5286D4E
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666671; cv=none; b=KlVUjTD+AgimGtwnp/KdrD5/yhSMvdW+Mw8B8H5sl967EDQtuPIU7/RY1j00rRSSZiQMgoEcfMFuOrCtrb4HV9VBt6L7mJj7KSfDiS0RZUgM1LXxZJnA3sUFDnjeY+HgXWY5nZ/JcF/8n3oWmiHTy2uOBR/4cfomiXiGsn8gXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666671; c=relaxed/simple;
	bh=YsnGAA0LQo8B9UZAKjasqtY5dc4HGjaW7RsNhHIcZQc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d2F6/X1eJHuvWD+1J9RHa05zrzu+YYN4IcflfDxNjWeLAeT4EcHLiJ5kcvV2BMU5FRDZUFAckXy+Al0DQbMIZlslblAhCVM6X82T/Sq+604SC4kAYFQGCpVw5mMTLbVyAH4LG5MdVs17qFsy/RKCK9LtWalRtIIejWS6i5m6U6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZVq65MB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZVq65MB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45994a72356so17733915e9.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754666667; x=1755271467; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swwkkgv5P4RA7HuGuzCjb3/cjGYQMrIlf7SRqEeBkJ8=;
        b=MZVq65MBDy8Jdk0NlYSHfeuty5rZRwsUOsPoJzRbqWqDWnJv9MNwmOdU17TDe2sqGX
         vbFPaJ/aj3QmE6YgAbeu8Qbwi9Ut68WPAvuJblKyMMyVgjgUCptgXEtxDqn14d0jn4X4
         c3WGGDu3GKWcozEY5SCvdTdBhbVPNVqoOqV0TwVPSKtH5jbbKFaQA1K5rSdfjxI/T3Ya
         VhVAD7NHvd/e5YY0uXJG+lTbNpVq5tqglNOz+F1lx9absCNe2+V8En4fxJPuEjtStGIy
         QFrv2jq5GLbHkAzFIoeLwP6W7IkqWigzUh2kMLzRTzcY1VbwfNbwV1cvC9M8eYqrWrUV
         iqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666668; x=1755271468;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swwkkgv5P4RA7HuGuzCjb3/cjGYQMrIlf7SRqEeBkJ8=;
        b=UJjAyalrAOeA927SrcBZH4nPeKESWQxZ/lz0ZEAbRwLZR2TrxX3N6MfBArp4OlUsNy
         h39biQkEBz0DZxfcx7KgVg4iUereXVBoYFbWj/vDntzR5IHhvRRr2R+p2RhyvQLMWyCw
         xn9Da1ZZrJzO4EP7yUB+3//vWch7an4LAVsxJLT6Vf0qqNCIImtUAoV7s+8BbxFOmBGu
         A2YOfwrb6d8CdqjqvevJfbCdA9+IfXTgjJpbFwSgYb9yNBlTNES2PomU1+SVzW2kyR0W
         d1Lk065C8WPzr1/M2+YU1gH1NN08rrMKjzEi+MPnK+kPUXM+hn5J776TAzLlGSy8mmlV
         YjgA==
X-Gm-Message-State: AOJu0YwJYq64Hpsi068Ti89osu3PeCyB96by5QlPrQmzBH8VF55TVhju
	R9W3z9BIcaS31Xeg15PPLe+iOwAjKMfIQAJ247HrzxpL0rAONIaKL5BztHGgUg==
X-Gm-Gg: ASbGnctYDnGcyDG6fBoNg2j8WI6YcKiJLI7t48CHib+w7egUQ4m7y+B1hcPMWPuYe5h
	/C+tKKoTBR6Lug+M4+XiT3/Ez7b6/6D73KPovWxkQA1Z4/hvtjQ+mjeiKRNVuhQjCKRE8EiCgg6
	n+XbEiEvYsT9c4u5b9SyiE13ODKAOAnxk1EF6si+SZaz3r29QqgJDIISi9OVfT+WpQ3kweEPmdN
	dKGOgLZqETtgQG7f8HQ0N5JAa1P5AUJ6qmgVLd6PwRrX9AEtURwTeblC/RBlIvZcbET8g2i0fcT
	/hmK+adhfQBIyCbKTcsTUg3s+jeNq3ZoAout7vULR5JeHM9oaFuqjrWjhSJUz8Th6FQjZG1Tt+h
	XfNu90Bb7GAlCEZnohkBoOsI=
X-Google-Smtp-Source: AGHT+IGjPbuCClI/bsY86YQxFVlKW0FPLTr8BAFa8DTvn+hgdNHSAbLaph6DaVdTxVBkSel2i7raHQ==
X-Received: by 2002:a05:600c:4f48:b0:458:6f13:aa4a with SMTP id 5b1f17b1804b1-459ede7d697mr76398545e9.6.1754666667516;
        Fri, 08 Aug 2025 08:24:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac51asm31370825f8f.1.2025.08.08.08.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:24:27 -0700 (PDT)
Message-Id: <f4f0a5a1172b283d5254ce06ef08795286bb725c.1754666665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 15:24:22 +0000
Subject: [PATCH 2/5] doc: git rebase: dedup merge conflict discussion
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Previously there were two explanations, this combines them both into a
single explanation.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 52 ++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index fee73623990d..3087e558b509 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -36,6 +36,29 @@ from `master` and copy the changes in each of those commits on top of the
     D---E---F---G master
 ------------
 
+If there is a merge conflict during this process, `git rebase` will stop at the
+first problematic commit and leave conflict markers. If this happens, you can:
+
+1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
+   and make edits to resolve the conflict. For each file you edit, you need to
+   tell Git that the conflict has been resolved. Typically this would be
+   done with
+
+   git add <filename>
+
+   You can then continue the rebasing process with
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
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -71,13 +94,6 @@ any commits in `HEAD` which introduce the same textual changes as a commit
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
@@ -180,28 +196,6 @@ This is useful if F and G were flawed in some way, or should not be
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

