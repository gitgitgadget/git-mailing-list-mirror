Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A81221294
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754680532; cv=none; b=HphNf77wGk6xl87RJaw4py7wW/vzlLMexZe9GE5HWlL2lEC+d05iHSlBT2O0i9XnCzqyBEUX58omRHKLJ6iiLhwfib8a/WsOJJGyl1qafQ0pGEeF1f22fR0naC+3M5pTfOAwhtnf1jHmBRKGFy3Zjau3rU6HNkn+yY8YJs2oDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754680532; c=relaxed/simple;
	bh=GwwITLNrFdwyo5wDr6lvV6IZicEizV3B39frREV5FT0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RUbTCDea67xT84uTVBDojvcHH2Ja6Hbm2oRa+elwuExCeSm+paRvHB462bLFPZvmDFVxcq5leEw4FgUvoThGlJIXszpMwMinwRhoPWu3IKSQkgcvlca8f5AneZGXnUKrl8Kx9peD8R18eJ/D0tqWv2UM7zClHxYldWKBR3kvacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae9BlV5C; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae9BlV5C"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b794a013bcso1861159f8f.2
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754680528; x=1755285328; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ndt4ntVDvjqyp49SZQYTinSgZIt6HUAOOzIGm3XQTSI=;
        b=Ae9BlV5CKrbU0GfOWTlqTkrSmf8hg0G0mcwRQtKZnkx8q/xwUGIfQYp+en+AguW2pB
         bOb2gkvMYTo7EVISdUUFEnH2hEZIcBm2PdvEwAgRKZWNFd7sa0vtBj9lZYlNAm9mou8W
         LGP6Cl/lqwe5++zkcbPvvXI6da39z40Pswh7FUtNs1PU60vdRWidzz3BpMXn/DXrpNJ3
         /qmm489LYuniR1nS1Y/c5uEToqblW8LdnGgcfMf8sx+wPFYkSwRE4Fx9gsGdNTbGq9Vp
         Y+/a2aNkj5cvp01b/l49bjkTMcw1KO+wvGySyoJ43mm71spjCx7M2vTtM/FM0ZapwiZU
         Ybog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754680528; x=1755285328;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ndt4ntVDvjqyp49SZQYTinSgZIt6HUAOOzIGm3XQTSI=;
        b=aHZv62mMBZRzCQCo0CoukeoSJo2HZ7Sloohhl1SHH08Fg0cstWsZWoTRTS6pVQQL4P
         AfHSB02ndlo+jr9GoiKGKXMnDIRODFOnaqaUa2dkFwJvqqmQO6GdlG58hwKt1Zzs2Ut4
         xYf/NoY3+oVzgvaZcfdrAdggnk1gD5Rb/Z3CWuRg3PwjvcCFLmZWbhQq2UDBh9MbK51b
         0KGx4J8BykH/49dOisRTggDLcYNkAF0Qk2jg8SczmS28gYbgzGOpwpBU3F6qhC3noZQe
         d9uy7ajdP9cORm4MIncRr3i9doUnRitXQLNQcVvUjIGK6ejj8gtnYIu9VRMXL7Il1B4S
         kpvQ==
X-Gm-Message-State: AOJu0YzNUylIYScNbcUpYAu2qhy9Zi2s+sYuiamu1AHVCvVgO7vFDYk/
	X/7euBRcKTaWsdmUS5PvIZZlRDZSlAegfNqZlHsYsdMlkFRYettNrd9q84CkZw==
X-Gm-Gg: ASbGncuKHRuGAAJUZ3rD5UM7yErQFDV8S98qUKtNru8QDRyfBTcGsUiN55LxHUBLRA3
	Ozs7KZwTaUOsvtO3kSLmRO7GYp48a01Huxi4Zn+7LBVv2V4VvJPnCiCMOceN1rsms0d8MbW0+NO
	IFuPNTM1F24sxqqe6fjgLQHSD2XLjb9SHysSAhy3YwD0XiR6rBLgE63B04g24hmnlW9usaJBLHF
	5tQqssLtzVPZ3+UWuWeqnAXoBqPdc6uyHn9QJIUYmvAVn0YRDvFZOf5R3KOQfTlBGwEQbS/7ArP
	K9klBdcNilCZY8zcGmi2g/KE88i5nvJZ8eRDe8irJKr/pEoCWidFcz4u13HvahyRI9CIRyznxcE
	qfrnywvQmVb/jR6sL/DPhUyQ=
X-Google-Smtp-Source: AGHT+IFUmEmf31y7zNYKcxvYbUzw/twfEunZGFuvkROAMKZHOPZxUor23YofbxiN6k6NuM8NdLCFFw==
X-Received: by 2002:a05:6000:26c8:b0:3b7:7898:6df5 with SMTP id ffacd0b85a97d-3b900b4da22mr3244501f8f.14.1754680527718;
        Fri, 08 Aug 2025 12:15:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b501f22dsm176917885e9.0.2025.08.08.12.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:15:27 -0700 (PDT)
Message-Id: <26b742eb49f935147ac373bf9435827a6f85e531.1754680525.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
	<pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 19:15:21 +0000
Subject: [PATCH v2 1/5] doc: git-rebase: start with an example
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

Start with an example that mirrors the example in the `git-merge` man
page, to make it easier for folks to understand the difference between a
rebase and a merge.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 49 ++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 956d3048f5a6..6dacf693bd71 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -16,6 +16,29 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+Transplant a series of commits onto a different starting point.
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
+short-cut for `git switch topic && git rebase master`.
+
+------------
+                  A'--B'--C' topic
+                 /
+    D---E---F---G master
+------------
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -58,32 +81,6 @@ that caused the merge failure with `git rebase --skip`.  To check out the
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

