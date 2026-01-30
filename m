Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB933858F
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787385; cv=none; b=IZ67Q9Lebgv/3QV8Dqov6c6KYxi85cM/pkMzHbwuL4vYV+IaeQ8gCDguzcINY70Lsx54p4SKb0jeJXgLFrY4xzM6XpBRlhLT0fozQxFZRyGqfQkUcDgvlq1m9gesNxwvALBiJ7Bo13Q+S3KpGMTlssJvw/6quVsUz+EVGXGLWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787385; c=relaxed/simple;
	bh=jvgA4gkp52a2QggtRHNH8jXxZmnRo64O47MB30DOjqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP59oot3OcLbajCMBC9tEjVjbpeSGLZ1B9WczovY/fuLVQ4ctVzhNGT7GGrd6kMAJkIbqHAYnGjT9kmMGBiDCzP8KH18Q9ulR4Dr6i2TpsBf+lBnJQM+POkeYJtKmXxAbbZE0xBl3rFpYiROzskNePMhNcgJ3na/u2uTsEIPiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCFvMWbN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCFvMWbN"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81f47610542so1303723b3a.0
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 07:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769787382; x=1770392182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMblQjNvpZ1MZJP6Ozmn6Q1pVChyxgneU+0Z1+CMkLg=;
        b=HCFvMWbN8UOgTPa2DHGxozZLNhjQvnE8+H0QM3IxruRzkfCmZTnrzp2dG56GTr2FEu
         vHdIkiH0/j+2m2qX1l9E/sifaqPl+xSfbNm2GkV9VBdUKPhJ7k39PMOYTwTbdWB6dGWU
         74tuYSEgLX6/b7fm4frAgsI3io3433/28TravQVGXG10pVbZRTn09fu79v+SBG70hjvF
         oOdR+t2pvSjE8HVutBsK2IOyII7I4N/ai9765n91cXmDxVIL1Rci9EczSYy9GvnG+60n
         kbJXRh6r+rxTwv6mn8DRVHNo5Rz7cuJ/8VqopVX8NbKUjyW6Z7mCWK67B/fhiyIaqbpl
         xfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769787382; x=1770392182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMblQjNvpZ1MZJP6Ozmn6Q1pVChyxgneU+0Z1+CMkLg=;
        b=ngz5pjgv0nWSbA32sVOhsJHFkf0AFafdn/8POsUvqqXntXdegJOHn4z5w2CxN8MofH
         poIXy5Md3JXipRhCPESCb0vZoSNqSgcbC1TMpWq6BGmLHSctK7HjjqGcdlVIuHQUSZr+
         MRU6XlEAxmD0Bvpeh6WccGWMuCh70q7vEZc/qFfixtV9eWyra/GFzToko7DY6ysjgcy/
         u/3FuKDj/wx28yGTmvMyIK4A5VlML5dEIS1etDlO3qecFCKQj23tR3AA03Y4jW6TkL/T
         pRYtmYT18Yx3tYDiI02vLpKs2mY3Es8uCVu+FN5h3o/RFZ4aR1FYkWfDL5dPvYad+lZV
         oFcg==
X-Gm-Message-State: AOJu0YwxVOHARxr70cQJ/aIZcVrQ7z3+0uNi4sRkoRHWHtv06t59Suea
	KFKwB6/5KO4uI8GRb9qkNz/Qzhg04SjBl3F7HuMdeROWS/qdUFMtvxYDEdQPTw==
X-Gm-Gg: AZuq6aI8cPE8RATx76JRsIlxwlSEuu3rLDbD9j5K+UEcQUEvMUfDp+SgoGDysinKkEr
	9TkgOOyUp61IOg4UB4NS9c2nZnJ3oBy5aAPHJ/P3YfmppJFcNld7gBZXtcuLf4UU/JTvjhPU6tJ
	ym5m+0TV3MfPNnxSF9q78bQg8vBLxz9HEjFqsBYAp7LGGnrTTotKB90BYMPv9xPgOXk0JSW99XQ
	z0km+DKT+08gV2PO7ayBtWvq/uJiaefWhgUqCsi6x3j0FaaMb1WbDYWWPTpVUXpEDcgIAujs9Uf
	Cn0zMpQ2wzcVAg4K4EkBYLMr4nEckOiEkfq3Dvx2DoR03ompVowhkzr43PoPYviMKMPKCCKgqRH
	jTgRX7Kb3l44rpPQ9v6IEFLkF2aZO0v/1cF3lAbWKJ3jPTdWyDoapO0nI+Fs4UJvJ8vKr/d4riz
	usdgiPurlicRj5WjPumnnsyWGnMqCV/j4me3H9s/zxoNmphg==
X-Received: by 2002:a05:6a00:aa09:b0:7fb:f87d:a0aa with SMTP id d2e1a72fcca58-823ab878d6dmr3144280b3a.52.1769787381512;
        Fri, 30 Jan 2026 07:36:21 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:3c46:c24b:c90e:ca5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c54d4dsm10033713b3a.67.2026.01.30.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:36:21 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	sandals@crustytoothpaste.net,
	gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH V2 0/2] show-index: add warning and wrap error messages with gettext
Date: Fri, 30 Jan 2026 21:01:22 +0530
Message-ID: <20260130153603.290196-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129153948.224156-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260129153948.224156-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'git show-index' relies on implicit assumption in the absence
of repository context to fall back to SHA-1 as the hashing
algorithm.

patch 1/2: add a warning when this fallback happens.

patch 2/2: cleanup by adding gettext wrapping to all
user-facing error messages in show-index.c.

Shreyansh Paliwal (2):
  show-index: warn when falling back to SHA-1 outside a repository
  show-index: use gettext wrapping in user facing error messages

 builtin/show-index.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

---
Changes in V2:
 - Split the original patch into two separate patches for better
    clarity and distinction.
 - Improved line wrapping to around ~70 columns.
-- 
2.52.0
