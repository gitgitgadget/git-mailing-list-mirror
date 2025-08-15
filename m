Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD02E5D23
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276756; cv=none; b=jFT3Yc2TD1e3PKYgNYw4Nvf3Ip9IAB9p+dhvoGY+30Mmd2S0Tlw6QcDJXgqGRymuI6jApoym+ELhZNH2D7w9aCxruaY3Yi5AC6ZShHMCavCQCg2t5o45rgVByv/6HfJ6BkvhnOyhYDZPdTLkYRNwAg+BX3YLMwweWwhjzQKqkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276756; c=relaxed/simple;
	bh=zv1Qp7WHKpWgLyeZFXJrdToWkz46Ro+JeRyyTSwMcIg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l/1GHnpUYlUUcHsqEcrsJXFwdplltSxnjI5V1HM1I0QhoOc1P4i0NZHRzj7WWymHFUM4OVXa2asEJqTly0eZIE8WC86XD9RMZM96FxI1IRbrSJ6Uni+9MD+3gtSHZWNGBVZXwzcx/ua08/dkmTQcycXowGe3WqfTE7jnKQZkE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQGZo+Cq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQGZo+Cq"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so1161215f8f.3
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755276753; x=1755881553; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oQc0uVpWvCny1ZGlUNwBc8xRvmihROYVwRfD68hBUA=;
        b=OQGZo+Cqysfwqw2PUXKQN5tnBmsvxLKfcr7Lbp186q8wP8UGJ7qF91ZHG+GA/uNxLp
         mhJxIx1oTanyN4zXcqGD/YtdTI6qAFPW0q8rFMGU/Lm9OSnPHByFTyGjNmUOQZPlrZyj
         CsjRL0LPd7GCQnaRfIjSGudjFJ08NyMP/Rx0tRZTAXBteZv7tT8wDlpKd983Mfk95gmM
         FwrNacfoj2/oq5fitgnNGy9CjB9DHJgAF0mj7Tvb/SpvlvFFunj7HgvoRfZlU9vFX0bK
         BEQU7Lc7r4wGk5p2JLuk58/7vqA4SjL67nNdyGf+vr0/v3dT227XBrd+ng9DrGf8GkTE
         tL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755276753; x=1755881553;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oQc0uVpWvCny1ZGlUNwBc8xRvmihROYVwRfD68hBUA=;
        b=p/J+3hMUnZJTFXN+91zW+3x7sH2KCwRX/qbMWpLhk+ONkNBc/t+nHFPsjGXdJc7M0/
         Mxh0+TwfwJdbr2jcHmHEITEH/cNrTzUPWoj9dF16bdOXpfFsXCGXOliBBUnYQWRmcC39
         GF1n+jqRgMXMqleaug1+724hNP3+1GJozP0sYbkAV6SuHfF0zovnGgFjGp0loXwQD+gN
         XZwhKO3Xu3h+pU0mpXrUaCD14OpaD0qHqSx8m0cdqAtqifu4RSL9wc95O5chwaq1a0DB
         XB8n/xDDwY2EMglKk+pvRK9kgS2e+iLyX5mji63s3TydwB6QcZtmWz9oCLUqrIh9UTJ4
         iUdg==
X-Gm-Message-State: AOJu0Yz57DMhtaBVVwZ6brNtFloTP3jFXSYCLSrKYaI5YwMF80fBLZzw
	RYalX97cgDasCwc46VUdF91na6zYXCn+GJ8QbVp0sN8vdTfzcqZd5ed5T/iHJg==
X-Gm-Gg: ASbGnctmoFCSpXRsJoteEpILY68b8ywWfdJ8BVRYb982+wve0VmLF9JIg9HdI7TqH0U
	YT2HatNZdzuWxaUh2N8g2YYRp9fKLWWIgroKicB7zZ0O4q2efRTJVAhl6/diF5R4CBcZc4L0uDj
	spcZTvzK5u6eDS1IkNzT8bfkHbbj0roO2qhk+ftgbsx66FGAOxUvzBf40F7V5vta9kENiU786bY
	+XvjIhpFQI4vbcbLT+8A864KP5WSOwCmQngPAgGTqswJ5WB9nGK4CDD1fOXm1fxPoSTBzM5ZW15
	CStMEb3av1dSshHXswQmunyX3sL+lKQIM3PhacdOmFquE8mnWPRPd3r22T839oqo8V7tV+Mm29S
	/v/vohAzJ+7OSGXBEOWS0hzQ=
X-Google-Smtp-Source: AGHT+IHc3Awnnxm0aoBdZHI2VwA1x6nE8C/Ysx3ZMi2akpc5YemL9rIoOUwYYYq5O6w7VJS1nBnbag==
X-Received: by 2002:adf:fac5:0:b0:3b8:fa8c:f1ac with SMTP id ffacd0b85a97d-3bb672efea7mr1807960f8f.24.1755276752980;
        Fri, 15 Aug 2025 09:52:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676caf79sm2509190f8f.42.2025.08.15.09.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:52:32 -0700 (PDT)
Message-Id: <e7a8fbbe53c9cf5cb7b8d822e72ff4219de37e1c.1755276750.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
References: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
	<pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 16:52:26 +0000
Subject: [PATCH v8 1/5] doc: git-rebase: start with an example
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

- Start with an example that mirrors the example in the `git-merge` man
  page, to make it easier for folks to understand the difference between
  a rebase and a merge.
- Mention that rebase can combine or reorder commits

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 52 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 956d3048f5a6..bb5a3ff7f828 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -16,6 +16,32 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+Transplant a series of commits onto a different starting point.
+You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
+MODE below for how to do that.
+
+For example, imagine that you have been working on the `topic` branch in this
+history, and you want to "catch up" to the work done on the `master` branch.
+
+------------
+          A---B---C topic
+         /
+    D---E---F---G master
+------------
+
+You want to transplant the commits you made on `topic` since it diverged from
+`master` (i.e. A, B, and C), on top of the current `master`.  You can do this
+by running `git rebase master` while the `topic` branch is checked out.  If you
+want to rebase `topic` while on another branch, `git rebase master topic` is a
+shortcut for `git checkout topic && git rebase master`.
+
+------------
+                  A'--B'--C' topic
+                 /
+    D---E---F---G master
+------------
+
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -58,32 +84,6 @@ that caused the merge failure with `git rebase --skip`.  To check out the
 original `<branch>` and remove the `.git/rebase-apply` working files, use
 the command `git rebase --abort` instead.
 
-Assume the following history exists and the current branch is "topic":
-
-------------
-          A---B---C topic
-         /
-    D---E---F---G master
-------------
-
-From this point, the result of either of the following commands:
-
-
-    git rebase master
-    git rebase master topic
-
-would be:
-
-------------
-                  A'--B'--C' topic
-                 /
-    D---E---F---G master
-------------
-
-*NOTE:* The latter form is just a short-hand of `git checkout topic`
-followed by `git rebase master`. When rebase exits `topic` will
-remain the checked-out branch.
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
-- 
gitgitgadget

