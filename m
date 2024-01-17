Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7EB1DA3F
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521160; cv=none; b=fzS8ci5XKBLlRr37p+eMGShTVQ/ivGd1tYqcORS3ob5C1P4M6+yJG7t8U7cIsty0CSkE97SAKWzUfAuZ/ih8AN2/BxRAQUlKj1efGxLHcUeMzsq7xHxN5hAxNVla4SnPYjPTFD7Bq8zqA4RRrrGK74n85nesgPQbnEiYIVfpQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521160; c=relaxed/simple;
	bh=utKyS/dMHidLuhPNTRmUk/hXpO0sNu4y8E2ZoNhPm/c=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc; b=AGX0WM6uj/YUFtoFlRXeFCB8gjWejqjDmoOGcXj145U7sreSahGPwEEFudg5xrvzpKKTxaDCDo1b9KdCeEWbarqfgLGIgCwNtUAA8wbrq78Ljdk/p1EupzhCANjP1BWe6haLJjyPbE/gfcxA3GjOp3REFVB4nJ+Hkwu+8GquWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiEGa2Ip; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiEGa2Ip"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso46608e87.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521157; x=1706125957; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2hQeOJIadGxV5vTJ4TdMKymzXFvMZ1iAcxKigcqFnLw=;
        b=YiEGa2IpAUrwjvMeBJ1/jKPYsruJp9qHi9BtzqUbgnGpw1Vasa8aA8pYpdPaph/Lbt
         FJsw9eRSx6OtZQUgVkCTFsLi01f8XVUMg6F/ckXEeQMHqSrTJhyFvN983CEmaxe/uvPO
         0OASQQMGbKDTDJ7mPT+/uOYMifQUOSFpHsEAXpqzXGrF8CQ50MF35GqA2VWwDIK+e5qA
         twvMF4RcxN/FmaAKPz/MhKpL94tJQvj9Vbp89MmdW/rskemJs7/wGhrsSAsQtzYldDyD
         3xj7HRiqOC9Jjx/cAYOdNlzaZ4MqE8qJwx0YR6tWDgxv+SV/T3gMlOdqAekpegl0ORkh
         W4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521157; x=1706125957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hQeOJIadGxV5vTJ4TdMKymzXFvMZ1iAcxKigcqFnLw=;
        b=XKgiBbJOE8moBM8qH0GUXMBB5UER8KWrF490uUaca/ceXice3Xh0AMfAoGktuV2512
         YM7eqIRkf/sHxr7s04xEinpMTTGRiywmSz3OJyDSdomij0pPVonDv5kujRB4ci/UJbLa
         xbi4QXu4MWbVnTfwK9CiHZuHwbgP5ZvoXHkon8LJtf8ixvy2L0i7e6YwWzRrBLiGdZIj
         cA6oyq8k0tT2WHeoPr1dkihplAvrnHaoWTo5//zE2c4oe3bwo8rOd+Yzauk0TJ9Bwgj7
         9D2fx11/FdB4unecdK1fUUhNBTUkyA2oBobcsdGjRSKNRqLOM7eYR521TylfMKttYjBf
         r61A==
X-Gm-Message-State: AOJu0Yy5ZnZTiUQOu5spIB70LiFlA5hwCpby3S6L28Pnj6iNlVuS+fph
	6C/1hWoOrAzxHhvLyfJsRc8ZiJyPPmk=
X-Google-Smtp-Source: AGHT+IGRbIiWg6KLoAMwnixks6lCD8gNf95o3tAOEFirsVruUk6w6vGZnCDXRP4Y4nxtJ6UPPlpKSw==
X-Received: by 2002:ac2:5339:0:b0:50e:7b74:fe36 with SMTP id f25-20020ac25339000000b0050e7b74fe36mr4276610lfh.44.1705521156487;
        Wed, 17 Jan 2024 11:52:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5002000000b003367ff4aadasm2346725wrt.31.2024.01.17.11.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:36 -0800 (PST)
Message-ID: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:23 +0000
Subject: [PATCH 00/12] Group reffiles tests
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
Cc: John Cai <johncai86@gmail.com>

This series groups REFFILES specific tests together. These tests are
currently grouped together across the test suite based on functionality.
However, since they exercise low-level behavior specific to the refs backend
being used (in these cases, the ref-files backend), group them together
based on which refs backend they test. This way, in the near future when the
reftables backend gets upstreamed we can add tests that exercise the
reftables backend close by in the t06xx area.

These patches also remove the REFFILES prerequisite, since all the tests in
t06xx are reffiles specific. In the near future, once the reftable backend
is upstreamed, all the tests in t06xx will be forced to run with the
reffiles backend.

John Cai (12):
  t3210: move to t0602
  remove REFFILES prerequisite
  t1414: convert test to use Git commands instead of writing refs
    manually
  t1404: move reffiles specific tests to t0600
  t1405: move reffiles specific tests to t0600
  t1406: move reffiles specific tests to t0600
  t1410: move reffiles specific tests to t0600
  t1415: move reffiles specific tests to t0600
  t1503: move reffiles specific tests to t0600
  t3903: move reffiles specific tests to t0600
  t4202: move reffiles specific tests to t0600
  t5312: move reffiles specific tests to t0600

 t/t0600-reffiles-backend.sh                   | 604 ++++++++++++++++++
 ...ck-refs.sh => t0602-reffiles-pack-refs.sh} |   0
 t/t1404-update-ref-errors.sh                  | 378 -----------
 t/t1405-main-ref-store.sh                     |  10 +-
 t/t1407-worktree-ref-store.sh                 |  37 --
 t/t1410-reflog.sh                             |  42 --
 t/t1414-reflog-walk.sh                        |  11 +-
 t/t1415-worktree-refs.sh                      |  11 -
 t/t1503-rev-parse-verify.sh                   |   5 -
 t/t2017-checkout-orphan.sh                    |   2 +-
 t/t3903-stash.sh                              |  43 --
 t/t4202-log.sh                                |  17 -
 t/t5312-prune-corruption.sh                   |  26 -
 t/test-lib-functions.sh                       |  16 +
 14 files changed, 628 insertions(+), 574 deletions(-)
 create mode 100755 t/t0600-reffiles-backend.sh
 rename t/{t3210-pack-refs.sh => t0602-reffiles-pack-refs.sh} (100%)


base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1647%2Fjohn-cai%2Fjc%2Fgroup-reffiles-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1647/john-cai/jc/group-reffiles-tests-v1
Pull-Request: https://github.com/git/git/pull/1647
-- 
gitgitgadget
