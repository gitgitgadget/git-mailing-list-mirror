Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1340823C
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461019; cv=none; b=oMA0ev+JKNpbCJuA9LFcxs0hDNGsT5RqvKYU6o16QGE4GrddJZAcl+UWiP6a5zf8TfuiUQNpjKZXnun+kyQP3yDiPEMS+vzjOHj2/voTIkqLRHE98jiUsWVE4zixP7fJwfbniiGKgr42RpgVDXL2zBBAWCbwjmMcKpDFlzL6AJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461019; c=relaxed/simple;
	bh=gceb2KqHeb/KiYuXHqgxzmpUhWrufK0yqstYI9kJbcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ycq8QRMxLPHkzZV7yVByimBrrf338tPzPjRsX4oVxvEk5uuhf5ROjZOsGFIiZYsSX3qpDMrlUomDQTFmNsuo7CThkXeZtvMe0h90T3M95/ir9QNlTpxjG9ZJd31A5c8xEX7FWEVPL4sgj9zB+WN4bnftNICOaFjlh67UfAZ1i3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEmNrjp9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEmNrjp9"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-824b03d9787so15344b3a.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774461016; x=1775065816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aclj/yrJ6BoKu8eFtbFhoGTtiqbAT4Z6tFR56X7/Pd8=;
        b=CEmNrjp9ZOglzU0KnnKC7vqJ7/UFXbpQiQLt7fDHmfbLWNPto1W+0xbAxywA/4fGGt
         DKG+H6tvfUsdb88yYGFrWrW+4qJTifzj8+1H9Ufpar/kSkhzEzT7mWWYoZByli16M0Jf
         Fa/Rng0//YK4sc1Isa0LN3aZIVo4FXBe3yajYxO3JsPpw/X6zPg9RMdSCquePxW6JmWy
         nX1M6pKDy26AEhVxwlWIjYhy2AJkya1QWjRaq2LvJ9XAbOM21H0G78auaLGbSHia35NS
         yvRLGGNAgtjQbpLM0N1A/wYU8/97ECTVfyX7BV0+Ha6D/pKiBq5Ad7ee2Of0+R1TVcoM
         E7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774461016; x=1775065816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aclj/yrJ6BoKu8eFtbFhoGTtiqbAT4Z6tFR56X7/Pd8=;
        b=Y10tO9zfuq9pm2sWz8dT4ahEf/EZYglWIUcLH+GcMngPF3fStde6hM8j5Riicyf3Nq
         CvO9pXF9Fr79li5de7lXUvAEo++AgJHKyTBlZb4SUSUBqWgeAnxFFEndYaVu7Qda3vH1
         E7/qYTsdr2xfvxd+pKETONcxBURV7AUieC+Ki4yaVkd77cIgB9rvdP9SI07CM1I6aBMA
         B/P2T0ZRUHfN2XVyj5mgqFIsCn924YV3Y+GIevHgmfJ4nUhw0xTTAQMftak69gTlYEZy
         8fzecXjU978XNjS1tif7Wqn1rB7FThx+6K9ASzfGps8d7I7xYXIhcO1oZjlnyWwQl1Py
         INzA==
X-Gm-Message-State: AOJu0YwVSQ66ZdjTDPi+mUBbqw8vvo8INUQAyIcw1vQZpysqZLXaFdEO
	YlMje3majWnCkFng3568eKdHaEu9vXS6N1Q9Q9GTD+0whSXWbXxa9IDV7Ea5HVUt
X-Gm-Gg: ATEYQzz8i44uJmPFIi5sm6yEb035z34BqK1o0ZJRP5zEIGw+/frvSMAoGbnwHjOrd7u
	5xkmOMXkkXrSMlzBsu99FD6380DuDC+0n1Gwi464p8Ap4zZjkm0Wog+qdQqZWtMz5LIewLhF4dX
	txxjh0m4YKSit8vDcbmnWy/LB8Bl8Zmh+OqBQExyRqRaHKCw05pQcaVXeId/fWtAePrpOrlgw56
	7PDySPfIglMcllWM3bxROskVnHrG1D6Pg7XsrJs56kWjIquP+027bky+TZPoD+PAHZkSVOQsiUH
	+d3swljb+1iz7VGi/eKySkonG24RnxxncQ4oyZlNmFhMQStFt98Yu3dCbCRrbxGbPOAf83x1MbR
	sG/rIYr+mVWM74Oa87TrOe51QRZPNtBcMP+HaOPzJ37O6wo0HUKSq7JgJmuSj+Jj50EDn+xRrHS
	xrZhWSMA7tDuN5EfRck4Rzx6AWyXqz6n3rhx1Qf51Hu9DS1YZV8BfRe4zLLnRP9vqGU0dIYhA=
X-Received: by 2002:a17:90b:3d12:b0:35b:a94d:7ad2 with SMTP id 98e67ed59e1d1-35c0dd71818mr2409539a91.5.1774461016058;
        Wed, 25 Mar 2026 10:50:16 -0700 (PDT)
Received: from localhost.localdomain ([14.195.131.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm5041035ad.2.2026.03.25.10.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 10:50:15 -0700 (PDT)
From: Jayesh Daga <jayeshdaga99@gmail.com>
To: a3205153416@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jayeshdaga99@gmail.com
Subject: [PATCH v5] tests: use test_path_is_missing instead of '! test -f'
Date: Wed, 25 Mar 2026 17:44:33 +0000
Message-ID: <20260325174431.73101-4-jayeshdaga99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8dcc9e74-80a9-4963-aa9b-56f28e5edf45@gmail.com>
References: <8dcc9e74-80a9-4963-aa9b-56f28e5edf45@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace a raw '! test -f' check with test_path_is_missing.

The test_path_is_missing helper integrates with Git’s test
framework and produces clearer failure output. In contrast,
a plain shell '! test -f' check only reports a generic failure
status, which makes it harder to understand whether the file
unexpectedly exists or if another issue caused the test to fail.

It also avoids relying on negated shell conditions, making the
test easier to read and understand.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
v5:
- Clarify rationale for using test helper
- Explain diagnostic improvement and negation issues
- Address review comments on vague wording

v4:
- Correct commit message to match actual change
- Improve rationale (diagnostics, consistency)
- Move version notes below '---'
- Fix author name to match sign-off

v3:
- Fix commit message wording
---
 t/pack-refs-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 2fdaccb6c7..4a85d96c6b 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -61,7 +61,7 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
 test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
 	git branch f &&
 	git ${pack_refs} --all --prune &&
-	! test -f .git/refs/heads/f
+	test_path_is_missing .git/refs/heads/f
 '
 
 test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
-- 
2.43.0

