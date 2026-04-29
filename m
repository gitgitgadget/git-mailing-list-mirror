Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291E423A9A
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500516; cv=none; b=Iw5Us7L99GWyNOBPfarRIaObbzd5N4d9BLYrc81dP4gsnJR/ZCM0F3nIg8QezCQQZIaUIuej8VcmNPKGH7reVBOMchvPfLMOVV/NQL69TcByZ6DC2jBx11T6YHVJqsOviJS1DnLb153amZq0DNd1mzYJjh3tXU0oKeUcE2HVCWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500516; c=relaxed/simple;
	bh=19FOPPnArSEHJcHbWg9A0gghYl3JfVaGn6wre0DjQ34=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tJsh/TX3/Bt+a2mEJo7Eb0Je+aPh+NVC8FdoJ+UeXPzTPfDj3PTCPEodlhN24cNu5WJgqLx6s9FTd35uIU5iyg+p8WHTHruv3/lhtXbfrQvY1ydlf+MiPdcT+gjvhuBo1Rwd4Z52qQv9gjHKlyEs8tJjfE95QokS5w9gZpbm99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/KaemLk; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/KaemLk"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ef5776530bso29719085a.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777500504; x=1778105304; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPgEuXhRQMAPwVHO3J7aOEKTdY6A8uKnhAJcXOIzr+4=;
        b=K/KaemLkNT6occ5IxTNJ/BafMYyyRT2oKm0n3gMUgnhFYI252GJasD+P5pzDzoAIGM
         ayNx3JmjIJ10QQmx5W6a91ka1udMBPlUqjYtKx3TgzkvT3Kjv/NK83yzQCXVjTXL6ntt
         IWgeHwcmJElHrTliSM/3kDnltmUuuB0xKWNv/AXSiEgXB4Z+4/CHzM21fA/maCFpkG9v
         8gJW/UDXZSKR1g32PpSMkSaXwRJ315m9cTJPtkZDpzcdrT1alP3MGnOWBM0E0zy6GvuZ
         jirTYb3ZoaUEs09JsI4GlHMCOhefu0pfc04k8E6CQZ5GmrzV15yqyAaf5DQ/ZqsLoeoM
         SN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777500504; x=1778105304;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UPgEuXhRQMAPwVHO3J7aOEKTdY6A8uKnhAJcXOIzr+4=;
        b=cQovMQg5qtXDxKojAv9CIfJghrx3OQ4XXmpup0ZEvPhoS/6QNEJMO50IZpVxh5XbW9
         EkeGt8jCzIw69VQgfpwmUwxsRxEXPzaaI8u2cpJeym2Vg9Ju5ckni4jLigEy4wi+jkgD
         nys8P24SlmOjRuxCI2jVg1VCHMSU5Yl4SQxRwE2PGafW863lI/8GDxvdt9HZD/3bFxeS
         j6IiIvuBw3SZaXfb+ed9iiAZCYkWvKeL3Pu3Wnb3vLMinRsx8woc8Q6uZp6ky7QliQXo
         r0NDehlgVaIobI/Ao0+SDJktwEuPYE/N5ptjzdhluDzNlf2syc9OFpDGfnTruznkL/GE
         a3JA==
X-Gm-Message-State: AOJu0Yw801kTFKWZu9RtU13qaejbNBpc23Lg2WqajbRSNRc/Z9DoL9Lg
	tVTgvAxxCxEIJwCDJtMLfEWRUFJGdLfSXR9jJyEdE+vEgS1CbzMrOeYKQVjAAw==
X-Gm-Gg: AeBDieunl+9MfTrAEGyrfQcxCAuca3GjvNR6vHSCpAFG44W7Hp/LG7Jr7dXbSikbTqx
	x8sYMsXqZrGKQpIRSVa0Kwqd5OiCPeDLQ9mnkcXcQeOTtN8Y4EDlCFrO3L8JPt46nt9/wAFXBCU
	ajCPo3YNpmzMYNNNdK+rQkeGCOhD/VfZ8PLzZmlr1WqTmW5GMgykg4rdI+8iJmWemnziIY9EqYZ
	c4lLZVYTzNgRviD8OVFjNZkmQxrglcV+jpijaZtCQ/40pnSU1a7UKVvSCoRYDDR0W2+oC8PKtCn
	ram+KsBlyIwh6ANbPnP/75mG6iJhXxyO9VBHSEhHVnnTCH8Cv1PCdIRb78NvA2UJiZjgftgN9Ti
	Y/B147arM5cOX39bTSYhAMpjgL7wWg/k52qDLxjHWKyHQHEyYsGGJEp1R7s3B1KS/YU5CqBt02N
	7oXZfGWTNOFa3tiQzFHTkM/M1sUoEGDWetI/yCd6w=
X-Received: by 2002:a05:620a:f0f:b0:8f0:7516:daa7 with SMTP id af79cd13be357-8fa88942bc2mr95511085a.35.1777500503854;
        Wed, 29 Apr 2026 15:08:23 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.100.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940051f74sm280318985a.38.2026.04.29.15.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:08:23 -0700 (PDT)
Message-Id: <a5174802f453c3f26f950efcc5416ff961a6e4ab.1777500495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
References: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
	<pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Apr 2026 22:08:15 +0000
Subject: [PATCH v6 6/6] xdiff/xdl_cleanup_records: make execution of action
 easier to follow
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Helped-by: Phillip Wood
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index ddd0577676..beef711067 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -336,24 +336,44 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 */
 	xdf1->nreff = 0;
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
-		if (action1[i] == KEEP ||
-		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
+		uint8_t action = action1[i];
+
+		if (action == INVESTIGATE) {
+			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
+				action = KEEP;
+			else
+				action = DISCARD;
+		}
+
+		if (action == KEEP) {
 			xdf1->reference_index[xdf1->nreff++] = i;
-			/* changed[i] remains false, i.e. keep */
-		} else
+			/* changed[i] remains false */
+		} else if (action == DISCARD) {
 			xdf1->changed[i] = true;
-			/* i.e. discard */
+		} else {
+			BUG("Illegal state for action");
+		}
 	}
 
 	xdf2->nreff = 0;
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
-		if (action2[i] == KEEP ||
-		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
+		uint8_t action = action2[i];
+
+		if (action == INVESTIGATE) {
+			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
+				action = KEEP;
+			else
+				action = DISCARD;
+		}
+
+		if (action == KEEP) {
 			xdf2->reference_index[xdf2->nreff++] = i;
-			/* changed[i] remains false, i.e. keep */
-		} else
+			/* changed[i] remains false */
+		} else if (action == DISCARD) {
 			xdf2->changed[i] = true;
-			/* i.e. discard */
+		} else {
+			BUG("Illegal state for action");
+		}
 	}
 
 cleanup:
-- 
gitgitgadget
