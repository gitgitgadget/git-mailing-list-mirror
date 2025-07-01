Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB0274FF5
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371050; cv=none; b=H9xUYjzmpehJdsaDBJQFXzzp+8RoDi997YklDEJcupIckJO9Z1ZA25DsXMKFozBuQcQ0m+gETWvzhAbYrH732Yv//5d2YufRF8mrz0C1weOvNPXnnnkzqZhDzdJq9ZkyUL4+rWkILHuWBBp50C/ieRwlMhmf8445nfOXgpyfeSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371050; c=relaxed/simple;
	bh=/5NF2E5SkyXky6PkGFOAhJKXVDF3u7h4VBar9D8KULc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K35mVzlpD2TibbBLVyHYjaYFagbe5wEEeUlWofmjWwT9QoLkqFQ5YSKA52rrwk1rI2Y9IZqydavrKQRgPU4d/kv3Hq/a+DRO4IiMbOg6QDWoeW5NmnIfqlFyaU9aTO6s+ep9M6vstM5XndJ5MvDettFla9CqLRHbi3EAdq5FRYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I45IUPOQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I45IUPOQ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235d6de331fso38726125ad.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 04:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751371047; x=1751975847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A4s6PvwByUgNCV01Vt9S5xNyyg+nvgQQFOcJgrgRIs8=;
        b=I45IUPOQVyLc3JoB/h/TjkbvQ7Fv1BeNQbRjfDLvyisT6rOkZVvULnUzCkP4wkvunn
         jWu+WUHi42YzOhfsp3FwJhLim9G6XId1CwVO0jLlB8lUyN7kDzHqSgHB4tsPqoP3w2i4
         JXeAIlmf12qxsQxc7W/ZmETq58mQ49BHUp6JY3omN4yym9rtKVfQLphiW2RG8lcDjCSI
         gboinvGQJmYy48fTNqOH3vnUDHbNmrSamZC2V6yx01fW04s/u5kZ24Ot72cqNQVdSZr/
         GHT+WY4PtwW4JU/HpkhCub9hQocFCF1USyTr4mDE4ugbwV/KCymzNETfEfKUVfo+rLkU
         oKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751371047; x=1751975847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4s6PvwByUgNCV01Vt9S5xNyyg+nvgQQFOcJgrgRIs8=;
        b=Jr1BfAG22mDgTEttmVzABWbNIVhQQxuA6FYsymdzR8+5A4L4teACmf2YzpU7xgoh+3
         lt3yL1mvDPGimZCumWu9NQy+hjjCkYlmDj0/uAhYBKjHOgc3zcyJPTsMzzKC4hoCu4Lk
         E+gAeVcjda7C9fqw6KPB8jexalKBNX12ArPeImSC4bD9nevssi8jJOVRRvkMnHY0XwtI
         Zpi/1Mgjgh/VWNmvUAiq2KOYAN9U/vly2QS6oJlXdGoY0kzGZ8DmypHqgn1dkDdCrTyY
         XbY15s4HztPZvsH7Icf+/tdAWC1WG3uz0X5abD48FRgV4ZUw+cHdEoQNOx/pFqOxjL8/
         OY/w==
X-Gm-Message-State: AOJu0YwqzAwggtHT9bPCNj0XjR+K7JjxuYwM9YZrPn3sDbU/rnlVXdrG
	ZShMuj9y0qLAmInJ0G6mBYP5YsoGQIzpIsooPa5fXO6tIILsarslgdVJCac7dbUjwmOG0Y4wNub
	2pMIB8lE=
X-Gm-Gg: ASbGncu8yc5RfPgFC7H/YO7s1A+QX7qWIGTU1VXhSLNatbgiGCsP5f2kVgwhDYzDqm5
	cmbNsvb9Hki3a4zZiIR43/xWwvY4pZ5mzPHd/jDKOzYlqDBSXDWALTpyMqlngmRLPATkSZC/EEK
	BDPlWGVblxBKL3oYp3U7F0DOHIsaq/cpQfgqfl2URCfCr2H4f3C33xNF8OLZ4Rz1/8dM2C9hZpb
	ClIMwhtOjy00eC4QzGkU1y0d9Dgz60MxDPiw67yVzrFvbjqNgX38KwYirp3WjHMYVrGmiFVTcy9
	3v4h0Nxt7X2+kHV/yd6eHWjQxOD1hAh22YFUqG/7wvpQJP4OnA/Q3zkpDppQ2LlJR1aJW/353Yh
	KTjmXJIYzUJ6atw/bxrd2EYs=
X-Google-Smtp-Source: AGHT+IEUuGGD3P2QXC5unue+qwcICmpPV9T9+Q+KyOPRLMKus5yr6w///H/HdCbgk2lHtxysTz1OOw==
X-Received: by 2002:a17:903:2451:b0:235:5a9:9769 with SMTP id d9443c01a7336-23ac4605d87mr244124355ad.25.1751371046639;
        Tue, 01 Jul 2025 04:57:26 -0700 (PDT)
Received: from LTY2K703JV.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b8be5sm103618635ad.189.2025.07.01.04.57.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Jul 2025 04:57:26 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH] read-cache: report lock error when refreshing index
Date: Tue,  1 Jul 2025 19:57:19 +0800
Message-ID: <20250701115719.85226-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the repo_refresh_and_write_index of read-cache.c, we return -1 to
indicate that writing the index to disk failed.
However, callers do not use this information. Commands such as stash print
  "could not write index"
and then exit, which does not help to discover the exact problem.

We can let repo_hold_locked_index print the error message if the locking
failed.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 read-cache.c     |  2 +-
 t/t3903-stash.sh | 15 +++------------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c0bb760ad..50e842bfa 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1456,7 +1456,7 @@ int repo_refresh_and_write_index(struct repository *repo,
 	struct lock_file lock_file = LOCK_INIT;
 	int fd, ret = 0;
 
-	fd = repo_hold_locked_index(repo, &lock_file, 0);
+	fd = repo_hold_locked_index(repo, &lock_file, gentle ? 0 : LOCK_REPORT_ON_ERROR);
 	if (!gentle && fd < 0)
 		return -1;
 	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 35b85c790..39098ade4 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1571,11 +1571,8 @@ test_expect_success 'stash create reports a locked index' '
 		echo change >A.file &&
 		touch .git/index.lock &&
 
-		cat >expect <<-EOF &&
-		error: could not write index
-		EOF
 		test_must_fail git stash create 2>err &&
-		test_cmp expect err
+		test_grep "error: Unable to create '.*index.lock'" err
 	)
 '
 
@@ -1588,11 +1585,8 @@ test_expect_success 'stash push reports a locked index' '
 		echo change >A.file &&
 		touch .git/index.lock &&
 
-		cat >expect <<-EOF &&
-		error: could not write index
-		EOF
 		test_must_fail git stash push 2>err &&
-		test_cmp expect err
+		test_grep "error: Unable to create '.*index.lock'" err
 	)
 '
 
@@ -1606,11 +1600,8 @@ test_expect_success 'stash apply reports a locked index' '
 		git stash push &&
 		touch .git/index.lock &&
 
-		cat >expect <<-EOF &&
-		error: could not write index
-		EOF
 		test_must_fail git stash apply 2>err &&
-		test_cmp expect err
+		test_grep "error: Unable to create '.*index.lock'" err
 	)
 '
 
-- 
2.50.0

