Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C0B25A2C9
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951544; cv=none; b=OXhyMfPCaQbrsRnrUvO0yI7KfSz3g3aSyoZY+3vf6I1uXxYoJn3IB39c44JG8nO2Wc9W1X18c2B6hlbHLKToiXORgtLUzWGPtPto8CJKrpdpi9fB7YiIJtwccb2UEdVhGnL2fccW1BBCNds3Y6ehbkgYQkgXi9gkB5RG3Dg+Fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951544; c=relaxed/simple;
	bh=iGOZkxMTSTmY0eE5oM8AQbv/QZfJLqoJgqUrqYgScVQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YXTYoVjrn+zpCqjaW4iMIdwsMkofjyGqt2zNiDIuoWnFnx8LVcJ8o5u9bYLCisrRcVyYhpCwNcCEjEejtDOGI+Tgq3+ZHSOOHH63ghnqEGgTRbC+zdKc+H48OrIuLLbs4AqgcEBBM0v9IEh/mDzMWWTpi+9+d/Wuz7Tr3SdhGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca4bwBea; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca4bwBea"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so97817a12.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 12:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759951541; x=1760556341; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPlOMOvjyql9nJxMHMUwxPgTTCb/RP3ym4kIpviEZAY=;
        b=Ca4bwBeazJU7s4etDfT6b/HPniU23znkDj49C/AaFWQuKSCAjE27ZX2TJl7SpCr0to
         7PIcK+EBqc5qEPGjHQI2+9/O34Fsxj2g5vV3LknJPqDaYCFwhWZEuQiHhMcIwpaRul+A
         MSd8mVFv4MrwhlH25LqG+atUq3NtiXpAGJXdieBZcUnUPpap6uenmQ7+sRSrG2u7h9nw
         ivNf7l357KEIXAi493tL9RFPgH0SI+GBcG8vgUXjSn/4dTw56o9k5Ny8buneXG8aWtm9
         y1a9tzvxlg2yp1s3DVfnmwFuEMObx7AGIo3FF8PczWoGLBmsmvxQMtNqHqVo25Y3ECyw
         Vxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759951541; x=1760556341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPlOMOvjyql9nJxMHMUwxPgTTCb/RP3ym4kIpviEZAY=;
        b=F1Os+giWemsU5hTtn2YSac5fmOjH3OO6wHPZdXmgRrwNQqHfUeUnib3VDfGaTuxI5H
         tzUkQz/YANyzW77u97zR6t+bkyfzv4wAYEAhuJQ4IvkylPl30AxMpqW0PNA1KnLGH5B1
         6UFYaBMX9vWioXY0cT3mSD/ESckFbyl5opitHCDtDUviGJy83W3JqwQ6EiZsJbEYligc
         lqRnvDGa63hvywatL0NJB5IhkXsmhVLVubsJ8khD8bvMsbgSSHfLGRM4jRKCKneYQqq0
         HhaelbuCZ/672S73uXTtZnuXT2Hv46DHTN5RYt7ywq4fWvS1qATkFCM0LPJeQXg5cmsK
         8/iQ==
X-Gm-Message-State: AOJu0Yzana2mIbXslHAU/48/+p4gXiIPpchDEgi0AaJe0FZ87CuGYWdh
	O7vy7hmKqWw/YBTGXidya7TR4xacS/1FgGPjOihdKe5g0vtR31ly+X82Dq0VmwLr
X-Gm-Gg: ASbGncuIZNWmJ0VqNrH084KKkKjeu3BM8Pm98aSJlRk61ULvfHLVVsF/iIUa19bk7Kq
	qEv/aB3ZIOwFTzaady/j17DE3Rlb70tGHlOjDUnPM4w9JaQ26kwJ+3qLkUXUqR4zSjhpiSSP+0U
	Iq3HyWRvhoGWku/y0hQ/t/EUQMBY9lkIuxnIa+AaVcgXuneO5Jguk6D+ZNo5Lp7rJId0Y+aBMm2
	40LhYDbp7Z97NMVjo7jxy/pxeST7F53SvA4RPlOf0/D7kvy7cD/dbS5uHDoQB5ICHYuR/XjQPfP
	4rag2evbok9juzmeLH2e9qvpNfnLntFNV3zOoIRo4UnQGgJvt3+jH1xJmwGXhkBm0xsakDFcurP
	ZM+orpiIw9/XwOxOjEpnvIWrTI6Vvb9orr5dha1lvQV21zMeYNBPslJdzQhNlXA==
X-Google-Smtp-Source: AGHT+IHPA1+gA+VsK3evW2zKtrW6ZH7aICf6LtjjE9YanZASp1oqEkvbRC7Q+RrfzzhIlWRtaz0yNQ==
X-Received: by 2002:a17:902:d50f:b0:278:9051:8ea9 with SMTP id d9443c01a7336-290272dc4a7mr66728615ad.40.1759951541291;
        Wed, 08 Oct 2025 12:25:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6e2asm5228495ad.23.2025.10.08.12.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:25:40 -0700 (PDT)
Message-Id: <323e81f2fd4efadf21bf5a77fe164d09e12665b6.1759951536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
	<pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Oct 2025 19:25:35 +0000
Subject: [PATCH v2 3/4] doc: git-pull: delete the example
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
    Chris Torek <chris.torek@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback: this example is confusing because it implies that
`git pull` will run `git merge` by default, but the default is
`--ff-only`.

We could instead show an example of a fast-forward merge, but that may
not add a lot since fast-forward merges are relatively simple. This lets
us keep the description short.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 6e9fa14967..dc93e5e6d7 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -35,32 +35,6 @@ There are 4 main options for integrating the remote branch:
 You can also set the configuration options `pull.rebase`, `pull.squash`,
 or `pull.ff` with your preferred behaviour.
 
-Assume the following history exists and the current branch is
-"`master`":
-
-------------
-	  A---B---C master on origin
-	 /
-    D---E---F---G master
-	^
-	origin/master in your repository
-------------
-
-Then "`git pull`" will fetch and replay the changes from the remote
-`master` branch since it diverged from the local `master` (i.e., `E`)
-until its current commit (`C`) on top of `master` and record the
-result in a new commit along with the names of the two parent commits
-and a log message from the user describing the changes.
-
-------------
-	  A---B---C origin/master
-	 /         \
-    D---E---F---G---H master
-------------
-
-See linkgit:git-merge[1] for details, including how conflicts
-are presented and handled.
-
 In Git 1.7.0 or later, to cancel a conflicting merge, use
 `git reset --merge`.  *Warning*: In older versions of Git, running 'git pull'
 with uncommitted changes is discouraged: while possible, it leaves you
-- 
gitgitgadget

