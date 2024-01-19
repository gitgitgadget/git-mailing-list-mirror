Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC656748
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695547; cv=none; b=dVn7zOqcwWgBjt34LJ39DBbj8YzbVsKCMmH0JXed5xs35Yd/7zHKTYxMHtiNo5vCYCkvQOuxnHmGTFI1A1ceMFAaGJkuBGv2Lheg+aeRnTtYJkfw5GqXqBsAH0aQkq1heaV3B+BfBzHURIwqtJmlmp+dlIkCcMxzFgEb4wdXTgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695547; c=relaxed/simple;
	bh=j0schq5v4lqqg4ce3At9Aj9BOcebxauq2xI/a5+JCLY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BHbcTcLeaS1nVsY0xR5rLGJrUYke1Oi2pzwH4iyN3gXQWKEs4cEXfv3Cn33BdvR8Z8hR4jJWDDKrdCSKdp1mcOBOqEpBzhL0aMyXfKJ5weMPoccuk2DwIp56mgxzUM6Kxdm2+cXnKzbfAINzOyOFh5o2eK4xfAwDpECWYTbdx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZgT1yZP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZgT1yZP"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-337d05b8942so1161182f8f.3
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695543; x=1706300343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4y67568yoGGZeGE8rxJjvzBSLHPQi5Sa0wc/oFKt0R8=;
        b=lZgT1yZPDQfPwfCY1ggXT3G/cYQUDI2/CPtFtSBezUb9cKZ2LiU+kTP5otpS8jP7vx
         glQKT+35PAOXghp1L8BQKCz3oZI0w8YtDi0zMbhg/Lx2k9N9OhgVEm4b7mIlhsC9iwTM
         sh6/U30LNA6TlbJ0vFALl5LP03yBGfg2FsDq5cHB/pvukqDSZSiY2zMh4PGw1dJscDtF
         SMCUprwynQ0ZPrF6bRSe77IhfRGuNFqyrIleHUEqh7BeIpxuS2sYO4FDMKqTxeUTIdBw
         o6TbjIw6ebHapkjh9yzgOM8ZRkovse/ZLEMXltXc606trLSyu/SQbyYoZzq0ZmZJWpo2
         6+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695543; x=1706300343;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4y67568yoGGZeGE8rxJjvzBSLHPQi5Sa0wc/oFKt0R8=;
        b=rYj7r3BlyMft6MaQHxOyiJj3lG45v0mkYb67usiuQgxWa8ZsOlX8+eJKqBz8K5SsKx
         91MmSOtqoyUEfgsdP/Rb8w4aSVesitSaqtdtRecmjsQN+MHaJPMQ/dGopB4el6KgZAuk
         6mpP2B48MX922grzl8wcIhE5c37OQs2WJR57+j2ykIzKKV4p5emq+6nGBnmknkMIRSNR
         fn4Oj/IyO5zOM5KVSYN+qqvzH0/6NLQ7wB1+uJUIFPDaPbo+44h7gVIu8oRXedxfE9TU
         OCA5cQElGsmeocYjrzy9fyoBaeSxxtbyyGNBqXDzlIyZfv+zskIBzT2mHL+inLqSqkQM
         /EFQ==
X-Gm-Message-State: AOJu0Yx6SKYRj5MzTokKDw4d2VxN/fmMsrq8WoQpzyTsbeLde1oS5wkX
	grMTtXpyv/tqws0uCggpcFIztf6xtVkyqw1b0nar3J0Q1JF7F87BgpDhkGXZ
X-Google-Smtp-Source: AGHT+IHyvIzbCVl9e6HNxDvGClRhITkaLMrb7F9TiIEPZMoHLQLA/FAR1b0qPE+ELkllc0oLVCrluQ==
X-Received: by 2002:a5d:5907:0:b0:337:c4da:9f3d with SMTP id v7-20020a5d5907000000b00337c4da9f3dmr163122wrd.2.1705695543422;
        Fri, 19 Jan 2024 12:19:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6-20020adfb306000000b00339208ecb30sm2265824wrd.68.2024.01.19.12.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:02 -0800 (PST)
Message-ID: <29c32d3e6f7c5dbea53705782a9d4371655afd2d.1705695540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:18:50 +0000
Subject: [PATCH v2 02/12] remove REFFILES prerequisite for some tests in t1405
 and t2017
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
Cc: Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

These tests are compatible with the reftable backend and thus do not
need the REFFILES prerequisite. Even though 53af25e4
(t1405: mark test that checks existence as REFFILES, 2022-01-31) and
53af25e4 (t1405: mark test that checks existence as REFFILES,
2022-01-31) marked these tests to require REFFILES, the reftable backend
in its current state does indeed work with these tests.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t1405-main-ref-store.sh  | 2 +-
 t/t2017-checkout-orphan.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index e4627cf1b61..62c1eadb190 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -112,7 +112,7 @@ test_expect_success 'delete_reflog(HEAD)' '
 	test_must_fail git reflog exists HEAD
 '
 
-test_expect_success REFFILES 'create-reflog(HEAD)' '
+test_expect_success 'create-reflog(HEAD)' '
 	$RUN create-reflog HEAD &&
 	git reflog exists HEAD
 '
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 947d1587ac8..a5c7358eeab 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -86,7 +86,7 @@ test_expect_success '--orphan makes reflog by default' '
 	git rev-parse --verify delta@{0}
 '
 
-test_expect_success REFFILES '--orphan does not make reflog when core.logAllRefUpdates = false' '
+test_expect_success '--orphan does not make reflog when core.logAllRefUpdates = false' '
 	git checkout main &&
 	git config core.logAllRefUpdates false &&
 	git checkout --orphan epsilon &&
-- 
gitgitgadget

