Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7319E839
	for <git@vger.kernel.org>; Sat, 23 May 2026 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534466; cv=none; b=Xwwx3CQYiyGYW1fZ7Yo/Kcw/KJD++b2tPZdZtqXKWbV9+tgP3X2fU+uZ00P5lUf9c5qBiMcTvx1MCqSY5O9oqz9sH+NONAabhlhTb5fa8iRWZFjaXlO625OeNpzE8x1Mp1a0OZtb4cOfHDfD7a/HS0yPU4HvGFvq+7hxHRCE3EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534466; c=relaxed/simple;
	bh=8Ao5YcAGynNqfJbeFBhtdySSDnboS9Sh3EqB/XjYmFA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=UysuMG5qA6+eqYqUx4qanBoc7N0h/+T+49K3a43gIVD2FAWbOdeB0vfcAjq+z97ykWDXlnJ46yxn/AsipsUXp42sYhmzfsB2WJbUrzNPKjUvjvB3hDKK+87zPvjXD1LKz6zn2Obmp8lfBbl5L/cp4IiO3iaJ8y9tPLKOUh4sOeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtE6O19e; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtE6O19e"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-913cc4d7c71so875269885a.2
        for <git@vger.kernel.org>; Sat, 23 May 2026 04:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534464; x=1780139264; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SuKVd9Moc9MrzHeB7hiIVcguyZj6zVlGME96Daiia/A=;
        b=RtE6O19eruxK+TQjgDVZgP8XvYDdFwrJEvtV925Bt2Qx+xogEudKFfmmdd8lO5avxK
         t1PnvjxpH1eTapaj9F07cEYCbL7CpuAEbzMmbG0ROmNBOyd63+5fQTtBlkcJ8hhjXDZj
         i1yBcwVKnTtiUiYswpdzu2mxW4UWNEHhvo0QWWcfNdashUq+WUm5sq/wM6OO3NuvSaGt
         JYASqZwoiRnVuyhwlr1XhDIfZnmIG3IW4CzB5NrndT2MQSt9qgVewtpOxWqR8kmDj+iN
         q2jR/WjPg67ERX4zqSPJ2GC+uvBb299g0di21tA9/6rRs41ywDZvx2xejZhOgveeo5YQ
         reMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534464; x=1780139264;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuKVd9Moc9MrzHeB7hiIVcguyZj6zVlGME96Daiia/A=;
        b=A+FqHTUEoPO+i9LXfX+VTWS+eG9aRmSCFaczz6YQdbRLJ6bu7d4A4Q+JBoqoXRK8xk
         sPO+Cwv2KNZBVe/4TdKHS7FX4PZhCu3LMEaC02zn/kJybYfDZYk6p53mTv1dkdzqFNdR
         unl1+bLATGDWQsuEhE+sd/MrOZiOxHZcCx144SrjYgcIliWq6s4VMEjU1QHlIh+23n53
         L1W1MiKXbrK4cAx20P1Lbwrcls19zt+Hw86XC8BQcE2NKPKjvpQmwGicm6dszGH8lc6g
         UGfcTwK77/LESIrotDI0MxyVWTShnMxFex6s4Ol9n9brc+M6EV9RfeFTt2wF3xs4hqwi
         DGCQ==
X-Gm-Message-State: AOJu0YyXAoxLRbQ21cDnXrVi5uGZEmxZz1BVKsE8+N+ZmhzX4ii/LI7Y
	2rVfFi8uAJ5h9NWgDLs8wjItYrT2xYxh5gQGrboUFMPxCoobgzc/E8Yy5PH7kw==
X-Gm-Gg: Acq92OEMxWcAaAIMl44Jy2sOrx+EiqutvyPPLrFnWOLEWk1Xnr3FSsDUtCHCnYxJV0I
	4rR2fLpEymsDSFn2Ys1mrnqzbxj+Sy9AFNfkzv+xuqdbjosAP1EjeQd6aUM5R4XPsEVm48i/Yq+
	V8QmvStz7+t7l1Sf/09xKSiXO7MWxoaI1j4OExFWFbiB+zbJ1umxU3XCWNOSE3YbF1bLteA89/W
	WAyH+y82fJA9PhvvT9iBzPlUCO+ODmUDeGH+Z0rA+SR27o9b8YnQy3cCZvcrGzrJ/LgUL8iX/TJ
	OOt2iLV0h7EqLh15IPYYkbXMAeitrPmjqNy7si+nXxyI0x3Vd+eQJ6UV0IbN0+ingVlE9ER6ijC
	jyDlTInl0ZPPacr1jpsgrMrX8Nf3m3qNtcZFp1dPdDhwyCPO1IQnU0deB1Pt8P2E8jmvjBuN7VL
	HdizCOaqdsdAxEKYj/IUysjlqkJg==
X-Received: by 2002:a05:620a:284b:b0:8ed:dc5a:f668 with SMTP id af79cd13be357-914b4a1d6ecmr1013692985a.58.1779534463892;
        Sat, 23 May 2026 04:07:43 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.159.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb90bf62sm377929285a.20.2026.05.23.04.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 04:07:43 -0700 (PDT)
Message-Id: <pull.2256.git.git.1779534462.gitgitgadget@gmail.com>
From: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 May 2026 11:07:40 +0000
Subject: [PATCH 0/2] [GSoC Patch] t2000: modernize path checks to use helper functions
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
Cc: Christian Couder <christian.couder@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Zakariyah Ali <zakariyahali100@gmail.com>

This is my GSoC microproject submission modernizing test path checks in
t/t2000-conflict-when-checking-files-out.sh.

Replace old-style path checks using test -f, test -d, and test ! -h with
dedicated test helper functions for improved test clarity and consistency.

This modernization improves test script readability by using Git's dedicated
test helpers:

test -f → test_path_is_file test -d → test_path_is_dir test ! -h && test -f
→ test_path_is_file_not_symlink test ! -h && test -d →
test_path_is_dir_not_symlink Found instances using: git grep 'test -[efd]'
t/ | grep 'test -[efd].*&&'

Converted 5 instances in t/t2000-conflict-when-checking-files-out.sh

This improves test clarity and consistency across the test suite.

I'm excited to contribute to Git and look forward to your feedback!

Zakariyah Ali (2):
  t2000: consolidate second scenario into a single test block
  t2000: cleanup unused debug code and variables

 t/t2000-conflict-when-checking-files-out.sh | 65 +++------------------
 1 file changed, 8 insertions(+), 57 deletions(-)


base-commit: 60f07c4f5c5f81c8a994d9e06b31a4a3a1679864
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2256%2Falibaba0010%2Fmodernize-test-path-checking-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2256/alibaba0010/modernize-test-path-checking-v1
Pull-Request: https://github.com/git/git/pull/2256
-- 
gitgitgadget
