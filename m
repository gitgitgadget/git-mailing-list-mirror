Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6ABA45
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774183593; cv=none; b=BAw2+S4SWLA0PboZyY8SbBUHBFerkWxwmVqmOWcrCSNwY+CeyuP2KJo7AnLXUlg2bqCs3m/qJI5BXHlKaFJztEBDcjdXJPV90A4vmeyzzimA12SykOqYLLg1ouNPkJYoIXYrqcBQxF3m83x0tPlOJc2P4B4Y+l89sK3YaPd9el0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774183593; c=relaxed/simple;
	bh=s1GjPEDDoYnRa6tTB+8zPR6Fn30RP7EM4NCd4BxrIxk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=KbxIBSJcad6i1DM4Y0FtSWaq+fL/e3jxJdhbeo4B4lTY7pAf5S8urlCeUEsY3aIsW3lJGwxQ+uly7HFSaCTAAw6Q9l+Yg2bi3kYtLw1XWj3uzPtCrgxckFcOh4GVL0p6vVE2CYh2p/mVaJtvqsRAwbljhWBmgD28UGC21Zfnkxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+41oL4G; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+41oL4G"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1271257ae53so3771262c88.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774183590; x=1774788390; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ON2b7VSTQUTgRZQd9oZ3N1gS8m1oTAYfykjKo3Zw6hc=;
        b=b+41oL4GgKYGJrqAIX3oEUcIWsQqqHGa2RQubBAaqaeCNQEtbOGfByIUwWxss7xmvG
         qlDTKIx011RxL67zlvHL+5ptM1Cb95XDk4xw+FEfU8U4lBfayFqJOAcHsjcq1QWfVUmf
         ZUSCnAlqtnTMrzBmYEStzfIkGgnqovFSetiOCgE4KT6N5KT+HslJwhV1e9nznllYHI76
         On9UpvtBDVyS5+LOspaDqbVaU2WjerHg2sCxW1XbcpLSzRLQiTUvSdcciO4nUurKp5iE
         ZdmbvYP3aNXwhuoyylcTAvXVHcJnqYADOXtR3fM9Xo1TpIMJemvXiAhxb9oI/L2m2R3H
         N25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774183590; x=1774788390;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON2b7VSTQUTgRZQd9oZ3N1gS8m1oTAYfykjKo3Zw6hc=;
        b=ImApbOaC93/Qi99tcLIXfc/FziIzGewbX2ILzg3TIR1eFklAJ1xzeHzPo93I8mcdmc
         1Bfq6/5CUP8xl7FdkgyIDIbAhWybE3dRI9ULPbzwgBOpiUDGMQauNuTJlZaG+LczswnO
         HSlwJo2Xb1/xIviceDYWd0Me510wzjtWQF71ZNmXWgSiljemc6IwaM3UWf5dkdhDzuPo
         Bkn0S7W2XElWtDbgIp++2AgWs1wigL6Q9bml5MEhqJ5jC4g5+dcmCbVMmV4TjY/A+Z6j
         6z7gC6vk7K7aDQ0eeXMW5LqO4f7U82jpm+8gUjWDcqjqiXIy4T51Z7EbnObGhSTol+kQ
         e/sQ==
X-Gm-Message-State: AOJu0Yy3AEREJ0BLzNSFvDtVwQzEQcaHj9t3Z18Lv6UsBM+ilg04YJAm
	KqH2aV89p3op0ztUtrnoCqI++6Ct5MZ6c/FL9bDbCyyfsfdsS8MeMqHvzvJr7g==
X-Gm-Gg: ATEYQzwOSln/Ij6y/ZdcnJEZUZXuIVEUkS+SHOQUxNwdkNJU7xiBmx4pBw0DhEd68Kh
	EI8t1GMRpn8rE2fP72a224Dml4vxcOP8WWgoijd6BUZeY0AiTc+23WneHmISqGr32RdQoRb+qys
	pzfZU1bBzt58I4NEwl8nFAbMp2oZogQgkP+u96d7ue4hTBkzU9l/iVyIWcpqR/B46IK7Wvwkv6g
	muJRTHjjJ+eOYn4VmecUXGMdkot9ydxoi+5VXHzFQC20DG7LcVacJVVlABXu1Pj066mDkKhW75X
	ctZrxJX+b/ewXjMGmzxhmcbfcZesga1tAurt8Xk4Q9MpQqLYkr0sPTdva/2UJIQ0/Xl4SWprrW5
	puqqASrg8x4HU2IDYrd17o9v/QVxJH9OANRoWPA65sixW6sK346KADIQkBWTOm+1ynAdJRTeUJE
	7h8lXbOwMczwD9avhc363dUg+UxIg=
X-Received: by 2002:a05:7022:260b:b0:119:e55a:9c03 with SMTP id a92af1059eb24-12a726e81d3mr4042365c88.31.1774183590353;
        Sun, 22 Mar 2026 05:46:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.160])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733dd8c0sm7293774c88.5.2026.03.22.05.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 05:46:28 -0700 (PDT)
Message-Id: <pull.2247.git.git.1774183586.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Mar 2026 12:46:24 +0000
Subject: [PATCH 0/2] t/pack-refs-tests: fix helper usage
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
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>


High-level (Intent & Context)
=============================

The test script t/pack-refs-tests.sh has two issues that prevent it from
running correctly.

It uses: ! test -f .git/refs/heads/f

This is inconsistent with the Git test framework, where helper functions
such as test_path_is_missing should be used instead of raw test checks.


Low-level (Implementation & Justification)
==========================================

Without sourcing test-lib.sh, the test framework is not initialized, leading
to errors such as: test_expect_success: not found

 * Replaced raw file check with the appropriate helper:

- ! test -f .git/refs/heads/f
+ test_path_is_missing .git/refs/heads/f


Summary

 * Replace test -f with test_path_is_missing

jayesh0104 (2):
  t/pack-refs-tests: drop '-f' from test_path_is_missing
  t/pack-refs-tests: drop '-f' from test_path_is_missing

 t/pack-refs-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2247%2Fjayesh0104%2Ffix-pack-refs-test-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2247/jayesh0104/fix-pack-refs-test-v1
Pull-Request: https://github.com/git/git/pull/2247
-- 
gitgitgadget
