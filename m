Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A7C312835
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918212; cv=none; b=PWVoYWFrNsvVOWhlvCo5l6q+7f1z+EcyjJqgpmIUwA8SBeiZdeeLNvO8Cnblf4aNy/D1UExTMeyoWvLcnAYdmueZAgiSQnQ3e6rV3WyM8L5GyUXiGrSFe88IDvkThDoh4TL0bB/1tidwUT+0opqmArGiWrjnUflmU8KExZSJ2/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918212; c=relaxed/simple;
	bh=0f60XgvqiswZe+9bOA4WZJbmAUUl1nPiKS8zqG1KKYM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LinS/QQoGcYy9+AjT3NSUu+bQQNICEDToP9lZw43SkUAkXF50wa7bi50lEFK2xppyFOFaYKiL68pvJJXTC/bvBSSqf66nT7jV738sOi3img82kYhOjyaVEeQnIwSSlXC/iL4CKUg40g4QDEstz4qatFXtD93WQiUgo53ynM8vbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBAr/6hP; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBAr/6hP"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e86faa158fso6043685a.1
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756918209; x=1757523009; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE0A8/d1o17x6rONhhVyATvXkWiEqP8RkSS+EoNcKJg=;
        b=MBAr/6hP68m5BRTbYoXr0G7XqwwkKysBPRnNHhPx9b6O/gh46pTIEpYSk0ljWqrUl2
         rej1ZbkwpSwguHBOVspfW66jib8LHSEUDBSoHnCydSrCgxnjUG5k6Q4m8aTndVSTQpis
         r/sH/Pqe/30l4eeXskiwgjv2Vc+M/wzIb7GHSVDU9ORGcjXlKewTvB2l6QxJ4rohpZNL
         yZ0ernXb4FFoL6LeG0i4G6/znSDN6wBpyK2QK015iTZk0hM38vOeC7eFzypsfgQrZnMM
         CQ7MkF1izLuFeKmmzk5pqM9taShXXnl1vYjRaWHrweKsY4wE16WBB56V9o2KRERkfirA
         UJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918209; x=1757523009;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE0A8/d1o17x6rONhhVyATvXkWiEqP8RkSS+EoNcKJg=;
        b=f2SXICF2B2cLL2qCPOdZaYuoQ3wk+brupBE4Bv4j2Vsfvw4JJM9Xbh8LF5XqDdnCan
         dtqmBMkLsVQeMFsESLwkuiTz8r4Sj1E300BtMaFt3gjQXFMP8stQUWD/pYGTZv+AmYV3
         sNA9Y7mqMK6FcK0nKg3kPvuBAxn8AmoTs/K7HQnOSgsFaDyyZLFmli7rCBT8R00eVASi
         111FPtWoU3CiEbG3o69WtvYL+tz+jMq0p7jxJSk28mO2GlmISZgdHBvZr2xMyfWNtcO5
         ORMD2KgtYTyvBau0K1V/jA1oadV8Y5R3CvEVLV9sV2alTn6OocbANeu17+gC8U4Rcl0L
         Qm7A==
X-Gm-Message-State: AOJu0YyPv0bunwRvG4ceNyvr3iYBT0YjVfX4wVOxBAEL3oVgeO2zErgF
	HevPp5/NGbH/142PkHi54nx32MlauQCGje05BQUt7feuqzgY+0HaJ8779Db5yQ==
X-Gm-Gg: ASbGnctLZwAmCW+h3qekuKj0JilGjz03HkjkSYzz+b3UqI8HELwQp7qtCCXLM6ckAxi
	aSREYH3yfDrDe0Sj0T/T9Ep4mfVntfL9e4ghycRadTyM2DDDSvWcfu91URMVaGWXBuy0nqalO3H
	pXpDvd4FUL5cRmUbOWm9J6mx/5YX935x+ME5fDpqpKxWMt52CwoIn2jwJYU4MIKradY07EHxA3g
	sWOKAol1a6tFWcHMh46UCm8qniciZmRIsVmlGzcLTgWmaCWayGk29M0jqMNjAbi311pCWwxQO7X
	iaxAK349UuLsHNw5DodjcdcXmpUNwCCDA890a5iix/c35yEhrxKCrzoORjNI6qZ1Ei9BjjIeNGW
	0nJdgdk7hboSze92fPT/mXEFR
X-Google-Smtp-Source: AGHT+IHjndfg63hlogcnHamZGo5apm1OLaZNvaWK2qxaCm8FKqawgg1KuUWvPFjkoxTGaWPRtgH3iQ==
X-Received: by 2002:a05:620a:3188:b0:7fe:e18:d4b7 with SMTP id af79cd13be357-7fed3224e49mr1589043285a.13.1756918209203;
        Wed, 03 Sep 2025 09:50:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.213.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aa6e49847sm132864885a.15.2025.09.03.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:50:08 -0700 (PDT)
Message-Id: <6ce31b62787694610138e052f3d4fcf6ebbcfddd.1756918202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
References: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
	<pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Sep 2025 16:50:00 +0000
Subject: [PATCH v3 4/6] doc: git-checkout: deduplicate --detach explanation
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
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Say that `git checkout --detach` is almost the same as `git checkout`
instead of duplicating the content of the `git checkout` section, since
many users will already be familiar with what `git checkout` does.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index a2777fb5b0..d35fd32ce8 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -65,16 +65,9 @@ commit would overwrite your uncommitted changes.
 `git checkout --detach [<branch>]`::
 `git checkout [--detach] <commit>`::
 
-	Prepare to work on top of _<commit>_, by detaching `HEAD` at it
-	(see "DETACHED HEAD" section), and updating the index and the
-	files in the working tree.  Local modifications to the files
-	in the working tree are kept, so that the resulting working
-	tree will be the state recorded in the commit plus the local
-	modifications.
-+
-When the _<commit>_ argument is a branch name, the `--detach` option can
-be used to detach `HEAD` at the tip of the branch (`git checkout
-<branch>` would check out that branch without detaching `HEAD`).
+	The same as `git checkout <branch>`, except that instead of pointing
+	`HEAD` at the branch, it points `HEAD` at the commit ID.
+	See the "DETACHED HEAD" section below for more.
 +
 Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
 
-- 
gitgitgadget

