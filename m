Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569F182B7
	for <git@vger.kernel.org>; Sat, 10 May 2025 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902055; cv=none; b=X5D07qf4bVD20Rl/C9L90PV1CdpjXsT+QaztH9J14/u60nva99Qe0N0VBvNCq1jnZ4uTyPpq5ivVYkNHaX79YaAMeomf7jB5HMkaWnbOHqD+yXnZQtSKHnCneYiAdxogv9HtnLhyrMhRdrDAMhPSUl5ZA0i9qlM0RYnJ/EIye9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902055; c=relaxed/simple;
	bh=uSXYeTv98b6ldWOMndYQVjltDpgR72BwN8CH6sOOYpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pNZMJBI8ufnBDM+RlOcLfB8rMzi7/KIKz2LPPw642DGUk3ifgIcCVGtly/8auqAy4hXd/aaXAdwomx1BKOsoaJo6P1ylgMwGYkIMO1InDWoN5/ehp6U2FBvAd3Sc86d4vpwYYxhlN8BpyZ3seISn4O1qjsMSM071Qj46/NUy9Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIYW2QO6; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIYW2QO6"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e6df1419f94so2579023276.0
        for <git@vger.kernel.org>; Sat, 10 May 2025 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746902052; x=1747506852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qTgzaKjofYgcxHU4avwRe1VKnQG6Y5IFVuKMP8lSZ2U=;
        b=lIYW2QO6TmhkgRUgcKvz8uIRwQBTCOvsaX9CaLS0qEPZ7KedPQcYexeOfJgk4H0LPd
         P2xn/JDgrqZTg2D39d1xaCBA7YtsVL9L/qw+vGKa8orK1BKN8WQU6iwyf7um0+0k0olq
         Jq4YJ26NxBZQ/iItlzowS1L10dnv9KeVfrd4CMh7P719l2WSsXyvlfYLU2sbMg+Q0aG1
         yStZzsZjW1Q8j+OT33753/m0WU3MrBXYvH8D4to12rJXMjGJtx8N8mQN5C/TPeaEOARO
         RW8R4hfyS7pRpbEeUe53LUQ4bf/vXMZGznVA7fNBSs6aXUFKRd7VFX0LM/qcjd6LxE9g
         4dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746902052; x=1747506852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTgzaKjofYgcxHU4avwRe1VKnQG6Y5IFVuKMP8lSZ2U=;
        b=vw/aRn+nTBacdfCYLjqKnjWO9ZUSiM7hxIZw3/9GuLxBBVDNE/wzk/DBhG7pikNluv
         KJ7pJWpi64ht0nUmZAUSSm2ZIZ/ewvRolsfdFFjY4Qw5deUNzgEFtth9UD2vnW9qJ4Fq
         DvaxQlUGJWjwI55Pu2AdhOFRC/qXCDhJIYr28QodioIiorzmB9zlCNBB7vsqLR3IELsT
         fYesnNWo9WbFgwUg09Kd6b/GBVVa5zLGRPGfVf8/udtWN3MvkjUJxcp+5SurVFToKq3Q
         JxULGZ8OzC1kEgbd7k6PTBxqnf33TjQJcdnHqAWiqS0NMZldY+LU7RVCF3WsHmzaKt6p
         jRnw==
X-Gm-Message-State: AOJu0Ywu/ga8+3NYxLZ1agzKsN10S5wNOJKTtzZog+ZyWW77XqUtnG2w
	Ae1WpUvJEypdPdHGBFM0q754SdHOZeXJbHEaLuXlfhTaJlOuP0u+t4Yl4g==
X-Gm-Gg: ASbGnctLf/L+xP7YlCD3UlS7+9q7Jvz6Maeb7Wz/Mi0xVqtNITbVZGGC5Cxr1AO3npg
	h1Sgu2na7j88x5mFe2tvO6OiRedskSdR+X7x2svaBqXmr9sSvUaIoFNRpH8GoChpfTUW+OKgiY2
	4Anjldk4OBnlTJH4LT9kldjmRhCHZCqUFOd8a9Rx5qFH6jUllEuVlr7GDb9/50e8/ZTLnUqkfwL
	0WP0N3WqoIVHq1yGrYUxifskibS9oqYrnIo+Gqdl+ZdeTQ/5X64tE2JS0qB8BXDo2vT2ZbPt8ct
	bkFFiVai1T2vz6DUljYhF/BDQsICstVx0Ja1NwF3ar73o2cQRZB02VPncUYZ83IjUAK4dTE2Fq0
	WTbcGnSXEr/t2X1l/WN0Rgm1O
X-Google-Smtp-Source: AGHT+IHlS2tcIjcdXSIn1ZvZrwkVNObjHPW2jDEmXa+/WUDrD1SMFAC3EPu8mOTokBcpZ9YPEmfGag==
X-Received: by 2002:a05:6902:2002:b0:e78:f98b:539 with SMTP id 3f1490d57ef6-e78fdcebc0fmr10919810276.23.1746902051967;
        Sat, 10 May 2025 11:34:11 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:541:bcf5:33bd:f1fc])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd4a72f0sm1191649276.20.2025.05.10.11.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:34:11 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH 0/9] make stash apply with --index by default
Date: Sat, 10 May 2025 14:33:35 -0400
Message-ID: <20250510183358.36806-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since git-stash's inception, it has defaulted to stashing the index but not
restoring it. This has caused some confusion: change the default as part of Git
3.0 to unstash the index, too.

I ran into this myself a while back and did some digging; it appears that other
have been bit, too (see references in patch 3). Moreover, when git-stash was
originally written, defaulting with --index was suggested but not implemented
before the script merged. So this RFC should bring us back towards "less
confusing," hopefully.

The series is structured as follows:

Patches 1-2: unrelated prep/style commits noticed while working on tests.
Patch 3: update Documentation/BreakingChanges.adoc. This seems like a natural
    place to discuss the proposal, so it contains no other changes.
Patch 4: make it so in builtin/stash.c.
Patches 5-9: update the impacted tests. Separated out for ease of review. I used
    a style more like "split the test into 2: one with, one without breaking
    changes." In retrospect, the diff might be smaller (and the 2 versions of
    the test easier to compare) if I used "test_has_prereq" in the tests… but at
    the cost of making the tests harder to follow. Thoughts?

D. Ben Knoble (9):
  t3903: reduce dependencies on previous tests
  t3905: remove unneeded blank line
  BreakingChanges: announce stash {apply,pop} will imply --index
  stash: restore the index by default when breaking changes are enabled
  t0450: mark stash documentation as a known discrepancy
  t3903: adjust stash test to account for --[no-]index with breaking
    changes
  t3904: adjust stash -p test to account for index states with breaking
    changes
  t3905: adjust stash -u tests for breaking changes
  t3906: adjust stash submodule tests to account for breaking changes

 Documentation/BreakingChanges.adoc |  11 ++
 Documentation/git-stash.adoc       |   6 ++
 builtin/stash.c                    |  38 +++++++
 t/lib-submodule-update.sh          |  24 ++++-
 t/t0450/adoc-help-mismatches       |   1 +
 t/t3903-stash.sh                   | 161 +++++++++++++++++++++++++++--
 t/t3904-stash-patch.sh             |  14 ++-
 t/t3905-stash-include-untracked.sh |  40 ++++++-
 8 files changed, 276 insertions(+), 19 deletions(-)


base-commit: 1ee85f0e215f22b0878d0ad4b2445d12bbb63887
-- 
2.48.1

