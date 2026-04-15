Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C73A759E
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259666; cv=none; b=ufERgfH+vSaySBWzEwPghV2xxkYhlPBrleaicdQZO48XYfmXZnx09iK4Kx1XXq4w6K5ZMm7ebynDTvm6QHT0eMMA2gw7nBGK/iNMyMKEIOTvvsPFaMvUfKtThXohSZaq7DERw7JX6yTVL4lJF/km/B7uZJ8Y0hYspz7FAmQJnm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259666; c=relaxed/simple;
	bh=dgzktmB3UZefBssaL2ZSgY5M3yNRYA/erR3TfVJjNYM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aOmw3p5JUYgvjXG5cy5CqK17S4BvtQjEdN1uQAeEYlvMAH7qekOaBmf/EglMOuVltOTC+dUqDUc95eTYdJK8bCXVTiRBsafaNthhputUr/TsD9oUWfeGmeuy8LmVsATNhhdWZ58a4lMxwjPdUYTAKBQSliU9uKzmq30hlmsHHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzoEpdWd; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzoEpdWd"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a210c813f8so43398976d6.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259663; x=1776864463; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=TzoEpdWdCiw20ym/pTU9TXKTFxBwHhHleaFzdzCy0uwc5wzUdWczHBNufqRehHz7X0
         M9ZSdimFZPtfDowT0REjEo692BC8OrtEyHrO4WASLkm2nJLPRcdKOjfNPn0epDeC9oZR
         /fqkCDQSRwN4FaL8iHY6nNGoeDT06MfrthyxG2xFA5ovNQjkBKiDWk0xTq2hv5zOFdd1
         voUr6vtWW70ghVuus8ApCJwkIGi7BfYlJnd3iLN4R52aKYf/pgDr+YsiPrFpTwaFlm9P
         XLP6LGKYmlVeGMbaQNRnUgodhD8VvLTYNML3iUowrTIgjuY5AB/uSqa+UogBtf6FiCIp
         EaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259663; x=1776864463;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=igz/SIMlt1FpGegbsagmKQGrC8jZiG8Y7i1ASyai2k6ExfIhye17OLvfc5b5of1dKJ
         C/aaM+m//MgkuMcv5q1FV2KAXfNaiyxHDgEMamQig0uxq2YFK/MR3n0nFJhpdOsq0ray
         AMuYkhzpXiX5aEoojKwC81CvUQezrlX+b+Z+YCsISv+h3d/bcAZieb4r3suUl8rylvCY
         I1ST5gfsKnJapUkrMbBB5JnydZCVT0U0sTCt16oX243XX5KaYwWRI03Gq89uzzOEnj+Y
         H9OeOLH4VJrs89BNybWNma7pPUdHfQIIfqWg5R17WUfFtOvC9ZQslHgmoFhFrW7a7xWl
         1jog==
X-Gm-Message-State: AOJu0YyUh8C0EV7IrdoaSEsujcMbqDcJjgQXnEkTvE1h0Z3tQijzSnx5
	3Vq5AS3z+bVrPEmlDivlnbfjqDC2CukAECnM0Y77GgN5CAqKqTTt0hK7zXtxPw==
X-Gm-Gg: AeBDieviU6tCEA/bZ3NzUJ5r0khQ2IRRNfkxFVp94Qkis96NP0vJhqmsOwSKGLZuwVy
	f+kJ4rjBLvuZt1oWplG6CU+XE09ZQ0tWrzPaTyvYhNAldpiP7uXpDjUHiQh6vWXlB7VUk3cnmxC
	kLlZUXBpjzsOpBZYxiZahwYVrJjD/XFIXVlOcR9SrUQ78SvhK2lh2qQ9dHtde/M3TUnhqG4fgZo
	xleJfCvSFdKGyHc/7B2YvJXA8vOgNYdI3lPPuga5V28FVd54JitlIH+7H38QF1e9C1vCr+oLhp3
	1ZIhmQmpAop0YvgARTmrYdYqPLn2ZU/zDwsG/Nus+jD/canrSH+1F/nKYxjeHcOtI8vmZL/jl72
	KcNeUTi9G7YXy0r2wc6Lc77IlHR5h0kkL9nM7JDjfFypn6o/Q56Vc1+sDyMCMkJ7RwzQ2zW6v4P
	3tmPyGWBgq2kaeCIFozT+x7FDvQQ==
X-Received: by 2002:a05:6214:4b08:b0:8ac:b3ba:eb0f with SMTP id 6a1803df08f44-8acb3baeef0mr176999146d6.21.1776259663482;
        Wed, 15 Apr 2026 06:27:43 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c959839sm11721576d6.14.2026.04.15.06.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:27:42 -0700 (PDT)
Message-Id: <11ba6ca9aca3a693ce3eb03df802e2c8beaa2019.1776259657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 13:27:27 +0000
Subject: [PATCH v15 03/13] fsmonitor: fix hashmap memory leak in
 fsmonitor_run_daemon
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
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Jeff King <peff@peff.net>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The `state.cookies` hashmap is initialized during daemon startup but
never freed during cleanup in the `done:` label of
fsmonitor_run_daemon().  The cookie entries also have names allocated
via strbuf_detach() that must be freed individually.

Iterate the hashmap to free each cookie name, then call
hashmap_clear_and_free() to release the entries and table.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index bc4571938c..d8d32b01ef 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1404,6 +1404,15 @@ static int fsmonitor_run_daemon(void)
 done:
 	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
+	{
+		struct hashmap_iter iter;
+		struct fsmonitor_cookie_item *cookie;
+
+		hashmap_for_each_entry(&state.cookies, &iter, cookie, entry)
+			free(cookie->name);
+		hashmap_clear_and_free(&state.cookies,
+				       struct fsmonitor_cookie_item, entry);
+	}
 	fsm_listen__dtor(&state);
 	fsm_health__dtor(&state);
 
-- 
gitgitgadget

