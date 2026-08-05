Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85348550A
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946507; cv=none; b=KfsXz4nIUv+RtQ9+ACipKQEV/yogF0s/3KrzVpavyLf25i+qN4MvECVS37zCBdkcGagQvpxwquEWjahb6gM6NlWRQ5BPNA8KRUKDB81Au6ea04IRI8MJEkdIJrSwkEsydO+1oHrIoXcSh1YX+CoUrwd7gU7k8ZKtdVJUjAK0ZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946507; c=relaxed/simple;
	bh=nQoo89Tuvwiq0Wf4memVLPmGl5DPelWekXA5nOU5DMc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UeHkFFahjXY6GycfExoHHHzQkF75lVdphh2jc8E6ENZkxHFFtr65HakznnTk0EwzcXc6s3kz1M/s071WHcidU2rMcTTSeVgQ3WT7NcThggHZC4hZb7JWAShpyyRLIaIPnwbrDdwHGG/X1RRsyxAc9iwEDoPkZXgO1KxdIwBmSUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo6CJboo; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo6CJboo"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ebd88be784so849294a34.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946496; x=1786551296; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BNUGlZqmC3UwAswP7RqQWAaSYO8d9oo4yqjiXiRq1V4=;
        b=Mo6CJbooR9OnM20db4eVT2vfFgIfKxcSJdNWbJmmeVHKcepZZMPOTnYyQk6u6wB9oA
         dYIPwOev7W9QGkv9nJOrnhInE79AefAGYTj5nU8Pp8ygsule9G9uTSa1sC2MJF4Oz8tS
         rwlhD2LhBxAKeWu/0wgZ9P3ARVNUNHmjHewkd7s2qSE7OSEQpeWojKVqp6cbSOxy/3nk
         1bGd5PF2eNZGBmxRhTUqOYAtFTyVBVb/BtJs77Jf4x4XpVV5xiuG39omRHjly2UVV5s6
         CXNnRTjot0p/QXaB8qC/wqyQUOga5mk/ID08+q4TguiHyVKVCe27GeGtku+WFs6cS6Z9
         Azww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946496; x=1786551296;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNUGlZqmC3UwAswP7RqQWAaSYO8d9oo4yqjiXiRq1V4=;
        b=Dk2mZHFEm1gLuh/P6ICx4ay0sOKt+lrWn7QL/nIkw1OF/rkyvIYWDWpRYL7fEePbLk
         G6Gy6mNEgvO39wRI5gFFCMVbXZcRIua0Pj2vgzFObB7VGkjgqnaa46sQc5Ve29YecQ5U
         HVf5AveFUuuqQndZEsKExhA5Mi57Zsmc5WX87syLrV9CXDFr5X8ZPuuIbCm76JlxQ7Bu
         xnRIHGXpQeeF+pNuvh5fsH2GONoAxpsHTLzjiUnEOcDZ4MIdEeOdZPL7nZ6DANpCSoS2
         1TSS5bnRDu2PQnMECJelRJQ4fNzTVQqLHl24cajZTlRhpVvkbYTIRlZEnSzYx4PpYW2n
         o2KA==
X-Gm-Message-State: AOJu0Yyn3JPhpKtekfve5lANHag1Hq4xLYVxFwG3H5F5OePvo5zYg9D7
	ljEJhSKsR7DIPkxaTmFjSIXPzIfDd/8iSriVDprlV1BuOIJhHyqA3xLLfaGmMLji
X-Gm-Gg: AR+sD115PXyHDebqXRI+b8GHJPLWzhFMamcxcwqoGnPKgWLNvWGdLsowx7jjRbWJOy4
	DWSiw8Ir4or461r2C/cXxwyx8N6VK3bdsCDmLmP5yiSkQ4a9ZV/uTePhl4ukAmlX7mH+uae8kcG
	+HGmHToSOI/ntSImRJ8jGpP+FLk0gLCsQu3RPusN7dnrI32vz4oV7ifDwn4YnzgY1ZPWV7cdIDp
	7LQ6EYBEBPCb44Qbz9rCf4+75T1s4VSeIdCwlr91d4mwNvzXTqS9fyXqfkEMvh6IocCF5yahdWo
	6H70BL17CsDPwIgxiPnX0uUQxTXP6vsAsUdFo7bGHOSwB/lR4RBhE3PhQ2LIq0G+p0gSEa2aYik
	pvjZzZUzK7yHdl48nO1XCUrTEmdYHbYGJ7U6MPVKOh9H3M9mQj2cDZAgpVw15Nx9YQRXWk+8E1G
	kLyWWimujquxql7IgER/QaU1GBzURFRZi6HeMcstQ6mHChOkfOL1MYUJJLMCCObwkRTg==
X-Received: by 2002:a05:6830:6d4e:b0:7e9:e709:44f6 with SMTP id 46e09a7af769-7f1e5e5ac31mr5539535a34.12.1785946495912;
        Wed, 05 Aug 2026 09:14:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.142.251])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df30117dsm2975357a34.1.2026.08.05.09.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:14:55 -0700 (PDT)
Message-Id: <c701d2f9b22fcad39ce1713b80570020084ba515.1785946479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 16:14:37 +0000
Subject: [PATCH v2 10/12] http-push: widen `start_put()`'s size local from
 `ssize_t` to `size_t`
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The local is initialised from `git_deflate_bound()` (an unsigned upper
bound on the deflated output, never negative) and used in exactly three
places: the initialising assignment, `strbuf_grow(buf, size)` whose
parameter is already `size_t`, and `stream.avail_out` which became
`size_t` in the prior commit. There is no comparison against zero or a
negative value, no subtraction, no arithmetic that depends on
signedness, and no path that would assign a signed quantity to it.

The original `ssize_t` was the wrong type to begin with: a
`git_deflate_bound()` result above `SSIZE_MAX` would have wrapped
negative on assignment and then implicitly re-extended to a huge
`size_t` at `strbuf_grow()`/`stream.avail_out`, requesting an absurd
allocation. That is not a real-world concern for the object sizes
http-push pushes today, but it is also the reason the type needs to move
to `size_t` before `git_deflate_bound()` itself is widened.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http-push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 3c23cbba27..2a07d14259 100644
--- a/http-push.c
+++ b/http-push.c
@@ -367,7 +367,7 @@ static void start_put(struct transfer_request *request)
 	void *unpacked;
 	size_t len;
 	int hdrlen;
-	ssize_t size;
+	size_t size;
 	git_zstream stream;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-- 
gitgitgadget

