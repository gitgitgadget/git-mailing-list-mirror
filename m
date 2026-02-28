Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CE91F0991
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772287391; cv=none; b=Nntel2YD0PdbHzH50kYaC6BsGm0X2JrUWHqufPdBngYvdZDzB3nxEOJk9Q+I5KyBlgTa6ywKbe2v0RNVrjz/DpJdky3mEctJEn0kVc+M5Xw4K4evujN/gycHKmAg/qds6azy3kwHMuce7xpyrcUheZ8L8CtoXDVn3OwVbNtR4/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772287391; c=relaxed/simple;
	bh=hQxziG7vmUW6ufRbbzdoD5Qt1sqKluvEEKS7IEbYoU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsMuF6XgpZe2LdQETzcA6EIhG0sRilnRQP5dznVLGPF+w98dDNB1tzZIVCFTaOADg2B9KTEhY1WNDi48wGbb6+wj8G5LU+jKWkXCYjWdu0wQu71bUbcXRJ0l2MRcJwlGFqvBOh2lWjwPb1HShe/Mcp2RKj36pV/QgLkBMxk0fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqF1gNWM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqF1gNWM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824b5f015bcso3524125b3a.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 06:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772287390; x=1772892190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jI0eaS0bDhTN94PPF5Omhn5N/bdHkIi9EcoX10SWJZ4=;
        b=EqF1gNWMZs2CAM7gODmkL+KBByl4ENEnUWjf4e5N8ervOGtmIvvxuDCAkSMlm1nRdg
         F6084vVhtA24NdGxGwv11DAM8EJ5/801IDbJEIefHZpBCZYciXLQ0XoKDHVevPXM1C41
         eMLbCjMjnrtRYuG9833pNZZaADVDFlIfAepJHfM7mOqjNo2r9kExKyZLheQNzm7S5cLj
         0txX0K12d8qyIIh+etv1tqlkxBVv44JuqlH5ypOikQXrUEPVXajs1EKFObXHUhQ5ReK4
         WQbIF3z7ZZdCvptjVaVRppfqBO0af80t5BOo4lpWPh1MH0Z4KfEGSjfF63J+AwwBzu4m
         cRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772287390; x=1772892190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jI0eaS0bDhTN94PPF5Omhn5N/bdHkIi9EcoX10SWJZ4=;
        b=g6MlLlJ4jahJkrVuiE754c4fDtaFVIdB26GHgN45l0xHoWyZ+IN3HOY6OJqkETJg4S
         OWtJFu9q4MFLzf0u/4I4GygV1sR/lBuWw9cZpn9vFDw+qPlTZhWGutVTfawqQaMHekIL
         /ztMVNwekeWQdYGIEBodfgc+N7J9jzPj5KT0i6ArL3e9NOjCl88adFOuqk+2AbW9v6ge
         xYNIeCB/d49MCZ1bIRukHB7Vmct5M2Tyyl/WwetUKdzFomOBP+PsZmuWpWrkI6KU+yB3
         tDSduRH97pbvz/XiUcVKnyhoRfUIZ+LiwpVP38UoHUVYHscOjP2EooWFIuwai/7+7U76
         HhlA==
X-Gm-Message-State: AOJu0YwBmdKyD0t3ypCakZwbqylGWZb/6J2c5rZLVfelQqmjqZ0Zelvm
	K6PH7J568g4iZK04KSqmPpi5ZOBlTOGOK961LFNIHWRQe0wB9LB3NkpzXO6g8g==
X-Gm-Gg: ATEYQzxUej9ZgbRPiP4QsMLbBZdnezCsOS50aPVSNQoUyfzQZEHcZRpNaUfEFEuzjWH
	GL/VofDoqWVevuK2lmXqtVc36S5kex6iiUdiDHW368e8ZaikW5Okrg9eah77NhAV5eAE3heUtcx
	Ful7ks9WpvwMoVmeq4yjd21kwSzMH21DJtwgKUu7SvmHrbPOovYC59ocCABXyqjaV/Hq5oV1dAA
	RM9UfurdQ4dBzAh2irYNh1u3VLcu5ClmkIJqFzIJRHdlqKEd055l7O2mabXW2spOKUF/UVH469j
	QHD6Yyf3FG6qZZnGlNc3m71itFCbHW0wEGqBQUgGBwhVcgjl5+tki+Tt498T9kLPNKwc4E4nrIP
	OUbgmp7xn6T2qO6MI5hzxWiq0ktjxOdR6oXbUjWBxbjBP6q4NAOyd4QDFj+u6XH5zVP5fsDELVF
	zu1Ak1FzWugvyq4nwBSaemgEmdfIXT6Lw=
X-Received: by 2002:a05:6a00:a14:b0:827:3ed6:9122 with SMTP id d2e1a72fcca58-8274da77da5mr6527351b3a.59.1772287389530;
        Sat, 28 Feb 2026 06:03:09 -0800 (PST)
Received: from dorna-OEM.. ([103.152.144.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4c9b5sm8309971b3a.9.2026.02.28.06.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 06:03:09 -0800 (PST)
From: drona <dronarajgyawali@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Dorna Raj Gyawali <dronarajgyawali@gmail.com>
Subject: [PATCH v2] v2: revert per-repo move + add clarifying comment
Date: Sat, 28 Feb 2026 19:47:58 +0545
Message-ID: <20260228140259.21139-1-dronarajgyawali@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227125654.249676-1-dronarajgyawali@gmail.com>
References: <20260227125654.249676-1-dronarajgyawali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dorna Raj Gyawali <dronarajgyawali@gmail.com>

Following Junio's feedback: this flag is a user/process preference,
not repository-specific. Reverted the repo_settings changes.

Added a small comment for future contributors.

Signed-off-by: Dorna Raj Gyawali <dronarajgyawali@gmail.com>
---
 environment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index 0026eb2274..09c34d1776 100644
--- a/environment.c
+++ b/environment.c
@@ -49,7 +49,7 @@ int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
 int is_bare_repository_cfg = -1; /* unspecified */
-int warn_on_object_refname_ambiguity = 1;
+int warn_on_object_refname_ambiguity = 1; /* process-wide user preference */
 char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
-- 
2.43.0

