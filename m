Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724371D8E01
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656714; cv=none; b=UJfD9Cylehuv0X8xkw2TsXlBSQ/hB+cC1jFVav6pT8FL5rVfTUEY0AtsgeRCFiEhCVPJC6hEgVVS46KEaXti7r3uVweAyh/TtX4NTSQ6WG1GiTGutjBPZdLLLeUpzgGQw3WXocsScf5r9b5NXT8GGtQ4ZIS7JZmrs2HrxXhQIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656714; c=relaxed/simple;
	bh=xTiWELuWcNe1sDLR7b3y35UAbv7wwi//pl2A0x16Xt4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M7KB10hIetxmOLY8yEO7FY3wCAA1smjiwzmBYCU9Z2xP4D6JjiKNTJApaxt/NXz/Q89cJHE7YiM/yHfGPwO1RlizJyZjgergV5Uu2kDZt1qT6EyyjpihRofK3JL1tYeE4zZ9+LLuhNBE0aVp3qy49rGyLcQ6UCXMOtHyu632Hbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDte4jcG; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDte4jcG"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4248b13dc1eso39980075ab.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758656711; x=1759261511; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpK5W7eSbTLP2+wa2AFj73E5YR4VU00wPmpYHDmtZJE=;
        b=SDte4jcG3kD2aqBnQGI8vs0Q0qJ/51hyRGmvIveneqOX1cILRGodzOmh20KgyUJcki
         WtzAgkoajx0FUb8JwWWD/OANN+MHZYFVZjFKUt69icClmqx34cwOfIRARWWbAgHBVISb
         3/yIgpapFdxuqi0eA/w+wgvlsT+3Sgqe9iu4Fvv5QyCwxpPZryslUQUrtkJmCq/ozcUV
         Y7cPuDvkdMHMi6wTA4XFoluHSendAm7qL6gw9UGr5cEau9hbNy7zqcnrwhoY8GxZ7Vw3
         Em0NAuzvKJcvY1pTbrV1v08xUhty2IG8zXVM1+ZlwG5r+IxvRxPK6Rt0bKI0IbOJYPu/
         wBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656711; x=1759261511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpK5W7eSbTLP2+wa2AFj73E5YR4VU00wPmpYHDmtZJE=;
        b=c/ELIJtbKCIZT2dqjeBkgSuYYj5KLYtCYv7WfJMQp3qK/o/LZ9DnYG+mB99dsgezAe
         OV7Qu2TNMusrPqKikCFi5YV2nhZT4R6+nPZjaPBoBjWDZtN1Raz5b0yGevyd6RbK5ehc
         o93nh6gSCBMa49NmP3H9CUkNShziaoLrjvuXop1tc6He6R8Kr87o64nzrEc9QbcHPPN/
         o8PLp5UtdUedssYo3wiDpIkNBWtQ/8Z/eeBIHR6nz7wsnAe0MMyY/7+gz/unJ+EYgYaP
         ddjFh2csouWoqmSo/Dx+eTdKAMvoDLU3/RVw8023ymBqKYW/uJRpfPe3N0eQQjJpg5w1
         xk3g==
X-Gm-Message-State: AOJu0YxdxXlVlDBk+buZEt437dEtHpnDkG4/OFmBqmrdaOpaFBQzVh9Q
	ekk87e7dHfoUTxTMY84I1EaZHYzhWZLGO3UFAHPzWJHxBwq6RvJ2CJfmxtL8F0ch
X-Gm-Gg: ASbGncuic8ulpMKHHqvZsGpQAmCq1OF4dzdvPD0HhJzPul+h3JeUPOY8aT1p9Mc5Lq+
	vfcCtYNnJ8uSvIl+AQQ6EVBF486LaEzePGzEGWTfh6kVas6uD6wK+8SbXiZT69waXkASG91uCDM
	iCcXpcMXn7PYpSh5WEPyKQi5mInDmy3jkWzyH/U7nMbzHrkSDFcjXKKmUZb5h6xwMTecT5qLKHG
	8EXTzQ8R76sNqz89bNJYK8FFbqSrX3O3pU1BMjVGsQkXGUbs2fPKDefQPK44uJCGC9zfDVjtu7p
	DJaiNfMuxIwOVR4lAikQ0J6xq099VgWr3yFqx6YmHp5YYrX4D+vIqd21po+sbal9g4zpM6nNap7
	kHmKk26Zl7H+5jCmS2QgdXvUJeQ==
X-Google-Smtp-Source: AGHT+IEfG/BgHJ+Xs4PNAvek4KIQzwME9zgrxQobCOgA/x0JkNYXqZoAySwwlC5azIrlNmNOmFs8EA==
X-Received: by 2002:a05:6e02:194b:b0:423:fd07:d3f6 with SMTP id e9e14a558f8ab-42581e7eb70mr54058715ab.15.1758656710973;
        Tue, 23 Sep 2025 12:45:10 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.130.210])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42577270beesm31733915ab.44.2025.09.23.12.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:45:10 -0700 (PDT)
Message-Id: <76dc2c19fb2b642c5842349a8c1ba504180c9203.1758656702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 19:45:01 +0000
Subject: [PATCH 3/4] doc: git-pull: delete the example
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
index 61d18fef36..91903b0a94 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -30,32 +30,6 @@ branch. There are 4 main options for integrating the remote branch:
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

