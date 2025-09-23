Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC15283FE5
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649484; cv=none; b=cpCjq7QwG7S4akwAPK88vPDcQUqpNznyu1/X9ROfEqhAKNV6UOS54aX5sZf5+J9U3A/nXnd6kE0VOV86ypwcgcJ7NNSzG506W8cZBeHYc52W3RiBuJK56Eq7Ds+NGrfJT2HZL745dsJm1XR4ahc3Olchh4+MUgWbuEWZZuSyGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649484; c=relaxed/simple;
	bh=VyJR9GTNMA4sLwaTUkvnKzhy/MAm0CBYFn8ZjS2UsVo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EA++745253iMcU1wl/H+Z4qd7dMY3s+U1zsnDHdIbEywRcMA757IuMUVrJWtdwh7L3DTGs3EBwn5GijGRAHE8RvfgmTyUWOJxiJbGlvHRK0JttCUsXTR8UOnM/lNXtkq1iG8BbeGVqabpQ7iUDoROEdSdjBjfmb5nvSATxQkU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bz4E6drT; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz4E6drT"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8876de33c86so499456039f.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758649481; x=1759254281; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st4SPsUN0Br4in5Ec3q7RcjEEacwuFNvgFRWfghIFrE=;
        b=Bz4E6drTZjVo52tLKN/6RxqGjKu/bVgOlxN76MqJB5rDt25GVyENLCfveYCkwyEzCD
         J4i6irHJbhujQDYZpYQP3Royi89YudENhiSnWQRfjD/jYeaP9QkvxQFhah3plpMje2Co
         +D5aVFEWazCPfSkN6ot5ZzoyuICkmEd/jT4CVsBIE1VnwjNAinAR6yCgM84PDQfimSN1
         8zG44lMs2E3KrSrBaj7NpOL+WE7ElUjxRRnrc9TDCCw01qDhO2AquATmkE7WnSL3Uz1a
         pmIHPs9H81s4Ane9Rf3XseYeTpT+c5ELaHo6ph4c+ZnS40tdkouh9rog5eZ9RgL5gvon
         Nl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649481; x=1759254281;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st4SPsUN0Br4in5Ec3q7RcjEEacwuFNvgFRWfghIFrE=;
        b=NWl6H+Au85GhtY9aCSHzbWVOGUy+lKQoYEHNJ+IrTTd4iUmsbBdmqzkXcqEWc2+yYR
         7fkgpNkIpTR5No3YYr4+G5rSEp8JwDwQbCktD6KIbj5OoXd9/sB9xCkyONaKK3qOOza4
         428xdlgZ6bS6+9ZEqyVRdbD/k5YyC5nGsLfkEmlKzZWD2GwY7NCbUxJb2RFx80DFElue
         eaCfaah+hty6YNG7dNygNMS8GQCGo31OM7nGA5sJ/FHWQRLWEZQufGtMOHyQYuMhkcg+
         IORTq89ZyTEomD5GFwIwWD/2KPq4Jk4jwizItRgGf7/62KThN7FDz7VJDu6LqmW/8zFU
         XVFQ==
X-Gm-Message-State: AOJu0YwdL+WqqaqkzUlt7brIdjGlkncs9PBvhhe21ARiMgqVzbgjErzT
	VBArL+scExucKmpGce0bMClhMTewv4Q8m85eux0Sh62jP48lIlf4FFbsArAQ8imy
X-Gm-Gg: ASbGncuS6IaSHigCsUSR/PfgGBXGEISa1NxUJ+KaCqiFwzhh5IQKgnwHQfXc1lJ3S7x
	t0d1pyVSLNstdaHta+WFbWsaEUOmNKqTF+xys3FmDbKJ2nuVEQxd920wEFn87V22BcSValrUi52
	Wd4JvMomct16KR4qTaK0my6oWZjZIX2c9bq3eVgtTwOq7dCAhTPQUocg5t2x1aA/gFuHldxsb46
	DiknbTVzg1cxruXvz4OnS+EPZ9cW/juEF6yd0UvbBUppRPAFpBPDzjsPC59yPVJU/zHW6KSTXNw
	hvq3dKPP7sXiNuQpelUxql9wLl0sYqcZcy11OY94StWAf68c2YbbF5ScthqKLE6tsbaN21X7zjv
	gFQcOTWyb2j9X1Nj4kb1j4yAQ
X-Google-Smtp-Source: AGHT+IEjs+DjP1yVGTEx/MvchtWJ0ZUZe8Jw2l3ssv5TtnxefVwAMN7vDGA/5S/tIJu3+23PiJN4Cw==
X-Received: by 2002:a05:6602:3a14:b0:896:db58:683 with SMTP id ca18e2360f4ac-8e1ef4afa06mr603081639f.2.1758649481352;
        Tue, 23 Sep 2025 10:44:41 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.97])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46d5772ebsm574016939f.7.2025.09.23.10.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:44:40 -0700 (PDT)
Message-Id: <bfd60729832f07c442a9eb90b5d83abfac6d9974.1758649472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 17:44:31 +0000
Subject: [PATCH v3 3/4] doc: git-push: clarify "where to push"
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

Be clearer about what we're describing ("which repository" instead of
"where to push"), and start with a positive "try X, then Y, then Z"
instead of a negative ("if X is not specified..").

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index 25d972f248..368f2625a2 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -23,10 +23,10 @@ Updates one or more branches, tags, or other references in a remote
 repository from your local repository, and sends all necessary data
 that isn't already on the remote.
 
-When the command line does not specify where to push with the
-`<repository>` argument, `branch.*.remote` configuration for the
-current branch is consulted to determine where to push.  If the
-configuration is missing, it defaults to 'origin'.
+To decide which repository to push to, Git uses the `<repository>`
+argument (for example `git push dev`), then if that's not specified the
+upstream configuration for the current branch, and then defaults
+to `origin`.
 
 When the command line does not specify what to push with `<refspec>...`
 arguments or `--all`, `--mirror`, `--tags` options, the command finds
-- 
gitgitgadget

