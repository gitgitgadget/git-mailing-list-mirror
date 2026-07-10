Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA4414A07
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683614; cv=none; b=tliZz5Rn8gXxV0NwCxZJ+5lLoKX1caTaCR71ucqn8mUc0kqxBRr0GfBya+UYAqJiGCtXeKRsQxSqmci7rN5dZCEk7YhiheTl6asYKY8beRzYbkuGeO6JaamXRBQZRcL8ng1ICCvm7tsNWPsHvgeukwLJZXx0KctKMki6fBckPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683614; c=relaxed/simple;
	bh=UqalL05URYmAOvl/p+Gaqm4cCOqgxV4yCB0nasYGJ3Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RfDyqXl53iWdmp5boaZ+9o2ubI6yC8xb5sa2lhs38lRKmGBa8+uYZs6gNuB04KvzQSghwAx84Cusybzl/exS9IYMJmtFHfd+qNda86Tazxe7466SKkgCknnHA2r3H4kCYPcPTT0hIlMG/ElFYnoCOOP3sBlE3p/778+IXUTLbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVKO9pmr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVKO9pmr"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so790218b3a.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683583; x=1784288383; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a5eWBmiC1mAbY5f3P9iuefmqtIRV01BwfLsyEJtoebg=;
        b=CVKO9pmrgHjCJFb4Q8ufAahqq/oZ3SQxoF8bZydWprg342/Q2GDbl+phLbbP4T28Ys
         S9f7ThlL/pf9jgaFIL3ch0swfvjmnO0GkpSQVMzpjfhEDlAiJTpAe+8+gbNiIfX3DOt4
         fids14fw00CRFw20x35IKCUqgH+hZhS9JWfGSbL22dF2vGIZzbC1yRW0SRMHHExWb7J2
         +Vh2PoORDotVWFZeATrL01WfHkSj/hdKIlTqN4hVngdjjfBtwkJZtbXUK2JZLWD7S/yn
         g0ascvrMI1ppuFkr6UAg8O7dAMoaRG7ImihJ4j74/KXDJkviUnsI9W5u4ShWe+W4m821
         LUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683583; x=1784288383;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5eWBmiC1mAbY5f3P9iuefmqtIRV01BwfLsyEJtoebg=;
        b=GaAcjJroxpdLqsWFusRI/I30BLcB7qeceMkSPh1c2Ee9iICjD5k3BMzYt5Pz2pSkdG
         DNNSnS5kTpoTL/B8hWlKz8iU7QXxpUNpFxC7dQDKyAbeQJTzfbdzPjNSM6wqJbP0aeXA
         ovbHxcVj6vO+aTmIhKgXSDcFYrWzBz7kUQXMZihJXpHqJcjM8KQciKBn4O6Eqsy/v22W
         0/rBFJSwxEc5GTD9TN5XTHtnHu/AOtDb4UEI1hq9PI6ArpbVUe689Q8lPCEIQU8LOcHf
         RLaaFP0xbR4BTFfU0rsg1scUmYdVkRWlhGM3PvkQDouXaNR7MQUMZ1y4P7URV/ca9Q73
         rwIA==
X-Gm-Message-State: AOJu0YwDZMtLOxIZfqT0zitjFc7/eoRLHPO2B9yVxf4qiAh+xSpqFboe
	RRbCl5G4WBeFczgKo+DGvULMKpB8SDUjpG8RlooBnJZ03eCPkZhivVqjJbUu2+Xp
X-Gm-Gg: AfdE7clfIZo/ipkNhqinkdBHlqWWdRRzGpTwo4VoOPrzUvc5g5cdN6mwFlvtUn0Zpel
	eCJH5eHevFlUnJrSDP21k30tn9aPxezVKUHJkSgIJeXbOhX7Zwrm4e3ROXqudMMrw5+pr+r3yEx
	jAMgMiGmWdGRJrAyKkxTh+3Fmc3xuw2aOhQiVNSpfnQ6WeSqnI9LGy9sa3HsGrp3uvLStTAfY+x
	frBcnMCteTyt3cJcckihmjfMyiOBiSi4zmS0HlkUnz7PuaRS4kDpHEa0M4r73GeFM9fPuPReFaw
	a13ui6jVXfRgfsI59nS6WX4yQIKj9ATnG0kkFN2TTlp3irwcKMVgEqfXOKr2QraIUUr23R2jcST
	ybGoi5dGa1Y7q38A+aHmJ7/PTLjIZ1IduAyGUmBj7B+t6D5OgDipXmbnvR4DldxHJZvO/fylim+
	VR5tBIdT9dLq/mi2mo
X-Received: by 2002:a05:6a00:3a0a:b0:847:9367:e054 with SMTP id d2e1a72fcca58-8484344d655mr9950141b3a.57.1783683581220;
        Fri, 10 Jul 2026 04:39:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8485a18e996sm2588479b3a.56.2026.07.10.04.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:40 -0700 (PDT)
Message-Id: <df00334f8b8cb85a928e1ca22aa12dd6b87fb154.1783683577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:25 +0000
Subject: [PATCH v2 01/12] diffcore-break: guard against NULLed queue entries
 in merge loop
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The outer loop in `diffcore_merge_broken()` sets `q->queue[j]` to NULL
when it merges a broken pair back together, and has a NULL check to skip
such entries on subsequent iterations. The inner loop, however, lacks
this guard: when it scans forward looking for a matching peer, it can
encounter a slot that was NULLed by a previous outer-loop iteration and
dereference it unconditionally.

In practice this requires at least two broken pairs whose peers
both survive rename/copy detection and appear later in the queue,
which is rare but not impossible.

Add the same `if (!pp) continue` guard to the inner loop.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diffcore-break.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/diffcore-break.c b/diffcore-break.c
index 17b5ad1fed..b5bcc956cc 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -289,6 +289,8 @@ void diffcore_merge_broken(void)
 			 */
 			for (j = i + 1; j < q->nr; j++) {
 				struct diff_filepair *pp = q->queue[j];
+				if (!pp)
+					continue;
 				if (pp->broken_pair &&
 				    !strcmp(pp->one->path, pp->two->path) &&
 				    !strcmp(p->one->path, pp->two->path)) {
-- 
gitgitgadget

