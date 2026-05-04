Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCD3E4C70
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914530; cv=none; b=owNdnxweDH65Fxli9DdQ6huJT9MRlmy9HkdHbGBs9+S6rVkKq2X7Hkw/kYaocPCKaKCqSfDziuUrF4D6wx3dnv6+1FMceeGMBcoLtkrcfB7JE6m4MMcaQ4A9X4TwslRUBEeD4EogXW/6tiUG2Wyk89iNdlUUuhq2clyx1tYPv7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914530; c=relaxed/simple;
	bh=XrqegptEScXZEZ4tIqgZeYMz23cFOzFGfQgW7Le8H1E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NSftD3uZiFOM1CLq5Ky67gqRGiQ+8ncj7cWW4/31tUEvKxqeP+zBmxCgBM9LqmroNvNioAtj36Yv44YyckHZH8qW1WJmT+48OdS9x6sVD4cpSfFwg4AAdZx+ZaRabFNiq4xYQEyqUEBFyHgwH6NG1oIUJcty1VMmhUMfhK29esQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3dyQeXR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3dyQeXR"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899a9f445cbso45842646d6.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914522; x=1778519322; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzfeQKNRFbHs8UYc9tcKAr1Sqop512vg8zVhUqsKnsQ=;
        b=A3dyQeXR+7oS/NpBNR7kqtmo+Ol7aYZjCSoJmwkrXev5hfeQkCuZJLFq5J838jXdA3
         NSUGXFmyxatXUoB/v98vTCVZEYWIWSdiNeduqTXpc/2fnJrpQdffaxJn0wB3Lc1x4Voa
         YbOBrK9Nq1gpyswEVrfUpKcNlhWcNNbXXKB0aRpV5+QUpbn+V42HxkDfzCdMUc353IoG
         feszT5740V1J73AiP78mZd8bLpShtYHJqm3krAGH2yXS22FWgX2AzNdxQYYgTpTCYeq6
         DJhHW7cU0XMuy7y3KUg+jnG/l+Ms8v5gXu12iTdvTLrgzQnnYpijCk5P/FgWfrm1ujlw
         +zDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914522; x=1778519322;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UzfeQKNRFbHs8UYc9tcKAr1Sqop512vg8zVhUqsKnsQ=;
        b=qSjXNLIT8g9pEEVov7hQG49LXAI8c4yA81dw1p8YkSAKY9AEvg3M+XoA1l8BvxeE0K
         vf4xR2cbbxwzqrc2cq2fw2bilaIO2nwjZh8wqu1uEN73hYgm2ZuUXZUsh8GGbn74iJKN
         FqcaBUaztPrcpncsTQstvAi9SAoq5vxGoDe20+B3qgC1NzGdcAOiIYx4ILKrAEn5Hljn
         AgOFQOr4m5U3HZ9n7wjHcQCTQi+aFGCrwaunkcn0He0owuDf1AOUQRYrDzAokZ8zXGPd
         dLjLR0Ok/tEK7Z0E648adQs5sURgGkoO+DzVeZHHjrqXPpgL3GhoyG7nXktXqbcTQT5G
         4gdw==
X-Gm-Message-State: AOJu0Yz6HNhDdzwyFoKcuWT+qBQb1f0jFVxTnY8JDGOKmDOtMWW1ACJF
	8xgDrbaZgEHHp1249U3vdIvxT8+Pm0hZYpw88UMP36/91NNwCX0UV59KqKIZLT2h
X-Gm-Gg: AeBDiessDT4F4U26QipiisrbtN48y+RWCH09PIprRTiT7IOonlgiRiiaEYYFx8LDG5S
	olGwsX/FYMApWqDigf2o8WBbNeUuMzyux0Rv1kjY63eYysFBBjoMf0OdM4kQDTUz86dweeqy8DR
	erBHaA11q33t+05zN8vt+2G1E9DtzIzduH29BdFGbJBwva9gOxK9Eanz4nk0TiKKGZAEnX7EqYf
	NRpk3ZhQoaTIUnnGUasBL15fCV+Qf7gUIq2FSD1TbUSnM/ghG1V6cB/PXAXNRyglSGtMqCuByoc
	UM9Qj+wS446xuRy+U87LLaWgMPOEcrUfK6NScOETnZKNPjxAqucflg19tS//9X2nP/NHW9dKp5H
	Vl3xurRd/RIMew0xALguYLKBVtAxRFFHGdkr6F9CMS6T0OQuVrOuXV5X/56HKKgA/8XcufFQ6NF
	WuAFUNOGBZpXpb70ttjL5rG9NGZ9IVbyIbayP3
X-Received: by 2002:a05:6214:5294:b0:8ac:b619:5ec3 with SMTP id 6a1803df08f44-8b6699ca01amr167168766d6.50.1777914521992;
        Mon, 04 May 2026 10:08:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.231.101.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5390ec38asm124023346d6.11.2026.05.04.10.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:08:41 -0700 (PDT)
Message-Id: <5b44410b2f9b3ebf01d582445542b6aca9984c2e.1777914508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
	<pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 17:08:27 +0000
Subject: [PATCH v2 10/11] t5608: mark >4GB tests as EXPENSIVE
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Even with precomputed pack constants that reduced the helper's
runtime from minutes to seconds, the >4GB clone tests still take
200-850 seconds across CI jobs. The bottleneck is no longer the
pack generation but the clone operations themselves: transporting,
unpacking, and indexing 4 GiB of data through unpack-objects and
index-pack is inherently expensive.

As Jeff King pointed out [1], t5608 alone takes 160 seconds on his
laptop while the rest of the entire test suite finishes in under 90
seconds, and the test's disk footprint (4+ GiB source repo, then
two clones) is problematic for developers who use RAM disks for
their trash directories.

Gate the >4GB tests on the EXPENSIVE prereq (which requires
GIT_TEST_LONG to be set) in addition to SIZE_T_IS_64BIT, keeping
them out of normal local test runs.

[1] https://lore.kernel.org/git/20260501063805.GA2038915@coredump.intra.peff.net/

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5608-clone-2gb.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index af93302dde..4f8a95ddda 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -49,7 +49,7 @@ test_expect_success 'clone - with worktree, file:// protocol' '
 
 '
 
-test_expect_success SIZE_T_IS_64BIT 'set up repo with >4GB object' '
+test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'set up repo with >4GB object' '
 	large_blob_size=$((4*1024*1024*1024+1)) &&
 	git init --bare 4gb-repo &&
 	head_oid=$(test-tool synthesize pack \
@@ -60,7 +60,7 @@ test_expect_success SIZE_T_IS_64BIT 'set up repo with >4GB object' '
 	git -C 4gb-repo symbolic-ref HEAD refs/heads/main
 '
 
-test_expect_success SIZE_T_IS_64BIT 'clone >4GB object via unpack-objects' '
+test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'clone >4GB object via unpack-objects' '
 	# The synthesized pack has five objects, so a large unpack limit keeps
 	# fetch-pack on the unpack-objects path.
 	git -c fetch.unpackLimit=100 clone --bare \
@@ -76,7 +76,7 @@ test_expect_success SIZE_T_IS_64BIT 'clone >4GB object via unpack-objects' '
 	test "$source_blob" = "$clone_blob"
 '
 
-test_expect_success SIZE_T_IS_64BIT 'clone with >4GB object via index-pack' '
+test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'clone with >4GB object via index-pack' '
 	# Force fetch-pack to hand the pack to index-pack instead.
 	git -c fetch.unpackLimit=1 clone --bare \
 		"file://$(pwd)/4gb-repo" 4gb-clone-index &&
-- 
gitgitgadget

