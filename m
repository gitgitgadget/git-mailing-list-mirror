Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37073763EF
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400281; cv=none; b=jSEKNbaEfX3od0PWK6gOBXDfbSCriyiU1Wg1MJyvzw0+jQd9wOnL/K7ZjlKbnfJ77bm21K5q2qiAaCLGKjanc7a2tsFBc0FPNjlp78REhF/zqg/lAbTR7PmAn/CX/NJziK6v83iGKxSt20hxkDga8RyxVPIXooeM+3urealmjAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400281; c=relaxed/simple;
	bh=WlAVCZv1vTIGI27NO4zu0LVYzGNW9oTXI51RaMttLjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejEeORorv8rgFCkkkZYSeCD+fgoyRBxARQIX4l6tR7P+SBkPES22ebYC13CA34ErQJsrDfn5aBbT6ot/yUv2SFcWASfmxsfMpoErqjQvV0Sp6Y7KhJj8qxV2fFhay0C6jj4frKuK/jnttBqFhojL7siTgYg7s0YgalX+EqsV4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnLbNxDS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnLbNxDS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4101fc00832so11846825e9.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 05:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707400278; x=1708005078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDTU2iJB3MJ6UQ/7B8AuIDzoCBbdaRMCgCBIY8DkBhk=;
        b=WnLbNxDSpGMOxYkhUPmZ3XPb4BH+nj/frN75d1Qg/u2oHIKSpAoPOI/h5BVA+7vK7Q
         YF+andPxHOY7XU9+/oEKLlMESFGj32wptH/xDB0S3kMWPrx8xCHlhcWuU3f+2TtAQRLf
         CWETeuLvQPltR+uPVMrQOCvUWNoG4/wiOcDkrOEOiKRRXIbc3QxFelOA0z+yRVlFZWDd
         7o2d+B5AmC56KH73iiLiu7Sg8AzYSo3pqNiPTw8OFvQLb+pLD4dZVLWmCHNT83ydUcvq
         75j7tA2Bw/TgpCS1oOw1uqiizBeIhecZyxrbWnkchPKWdQfJA18ZQxQ+KfhgNwi7IYva
         Q/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400278; x=1708005078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDTU2iJB3MJ6UQ/7B8AuIDzoCBbdaRMCgCBIY8DkBhk=;
        b=ICbLNX3NDFiCS8k6Fo4iDR8cC5E73XmXg+L3MNmcwLspBhYen6fkGTr8ADaABc2Os9
         xS915ncG9Qu5i22uxhRIqmpIsguyMw2bSdgV5hnz1PJoh7lZY5OaaNuXmSGf67IC/4hZ
         Ie23x7/23XKWOflJK1++Ms9+gHH9SADxcu91qnr2+PozRRXNEMNk4dQN6KUHRqUwCgvc
         rra/SLvkADd2vKvEJ31njl1RUtKMTm7s4Gwy+o13sI5OhpH0TOGygxVI7dFp0NRbjNjB
         zNs+tI5JLwD1C95O/FCpd/JqAk6nEwnLkmugOhBq2JAr2ObCLfJ8x1As1UjAmDL3cFlr
         7NQw==
X-Gm-Message-State: AOJu0YxcNkxOOCiNWGSVjzX59MSk8Olv5uNVRjR+r/JeYyst943jC2lL
	fyG8G6GlL0tvE7O4exfiurfEl40jMTXqZk6lk2o0+gJobmTBzbij7DyG5xiJ
X-Google-Smtp-Source: AGHT+IGL6c6LPoLFw1Po6H3XY2dBcPy/6YN15maOksa2FCVx9tMj7KYcNeNdl6Q82Bnqn/pckQLd1Q==
X-Received: by 2002:a05:600c:3d91:b0:410:5578:d9a0 with SMTP id bi17-20020a05600c3d9100b004105578d9a0mr4701wmb.21.1707400277472;
        Thu, 08 Feb 2024 05:51:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/ujc9tPPZyMvTYpILC4NuJGjNb02YjMYvDEGWfBahl0PZCMJLp6xut6T2sqUiVJe/bvO7Wt/WDLcvl4QIdvRmtvexUOpxrRlo6NT3RwNxQhjfJb+BuX5/fHpwNgitcFqLZgBF0dPt5Ewe+yX1ssyE0Ny6eSe6A9kI4R/AgHngooaxn2Xjd+q9jM1xpT1zgWM0aTroxm+aPRIqclvjggp10B5YijJHDAv0Hk1aCMva
Received: from localhost.localdomain ([2001:861:3f04:7ca0:4c16:5b8b:3341:9836])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b0040ebf603a89sm1698307wmq.11.2024.02.08.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:51:17 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Linus Arver <linusa@google.com>,
	Christian Couder <christian.couder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/4] revision: clarify a 'return NULL' in get_reference()
Date: Thu,  8 Feb 2024 14:50:52 +0100
Message-ID: <20240208135055.2705260-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.565.g97b5fd12a3.dirty
In-Reply-To: <20240208135055.2705260-1-christian.couder@gmail.com>
References: <20240208135055.2705260-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general when we know a pointer variable is NULL, it's clearer to
explicitly return NULL than to return that variable.

In get_reference() when 'object' is NULL, we already return NULL
when 'revs->exclude_promisor_objects && is_promisor_object(oid)' is
true, but we return 'object' when 'revs->ignore_missing' is true.

Let's make the code clearer and more uniform by also explicitly
returning NULL when 'revs->ignore_missing' is true.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2424c9bd67..4c5cd7c3ce 100644
--- a/revision.c
+++ b/revision.c
@@ -385,7 +385,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 
 	if (!object) {
 		if (revs->ignore_missing)
-			return object;
+			return NULL;
 		if (revs->exclude_promisor_objects && is_promisor_object(oid))
 			return NULL;
 		die("bad object %s", name);
-- 
2.43.0.565.g97b5fd12a3.dirty

