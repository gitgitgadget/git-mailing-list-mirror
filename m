Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABAF63D9
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 04:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706416959; cv=none; b=EGFp8C78V8ElPHpsr5UKYELfKJ/ewGLev/o2eEuLOgwbAiA4ArrXYOplqz21EmPdfuChJsyn/lmaO0Jw4RStQRIov+T5iLRmuBH5gWngRGjv8PjJa7FHb/B18EQ/5dQepvalf03/xHxLI6ny3wVT/mMUNBqLML8mO//5m8+rPYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706416959; c=relaxed/simple;
	bh=7OzWWH480D9y4QRp1Ct6fFzJEblka5C8hZrO6UjedzY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rK9+VdlMCInzRHXrzQD0nEyON0c2VfL6elmkYdN2ydPkHtnNEW5T5Z4JlwETiqj90j0q3HHboXAJTc1u4N5D9X1WTZhxrVL5FFf5HNik9uKqMM+vJhZCzpcumOUqWvU+i12qh+qGkAz1wVP2lic6oZZNE/2Zjhohboaea8CERoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+ty7ql7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+ty7ql7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ed3101ce3so32749545e9.2
        for <git@vger.kernel.org>; Sat, 27 Jan 2024 20:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706416955; x=1707021755; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkl11tAQxhk6kNYb+NxUU1IaiaU4nY6Syst86cT/Yq4=;
        b=L+ty7ql7Ttd9xcS4kE94yKc14L05RJizlnsV2XEGa4z2RkMMRhW+cqQ2aodRtaFbZA
         o2m70sQ6LXNg3fUkbtWrJCr6uNZehPDlF7RhsQd6vEMIcRiDq/MVPmz5GznwucVBap3j
         kc2Peyublc3EDCZt2gHA7fOTAOz262A3dXqcJfz6oAFxwYOzOf1s3gLz/MtdtL1Uw3PX
         l16rllAgUqhc682Gs4IJ38QtPJlwR90DX/ign2cbL8yIHlUfDPmI4gE7cf3iDCBzdcSm
         IhzCwfO56oOexRkGoosJGdqu9uyOT/a1Hvt6f/c9X6Go20VoWB7QT2nQu+WyZLyWtuyB
         iHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706416955; x=1707021755;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkl11tAQxhk6kNYb+NxUU1IaiaU4nY6Syst86cT/Yq4=;
        b=QcpfQ1oulrawwsN5DS35PabcsdNin4hbv6Q7hfeFKLDdV/Ydyw7Z5CC1YF6BsB1uAk
         wrWkVNO8Cs6cSnz6NMjopsaInuSoWO6hHKb5ZE9buGotk81eiFOjLoefsD2iIf5+nTPu
         I9jIJKE856dCNIo36lD/p8aSF0FWrGRqAdXnQnCVzeX/jAfC00InPR6Oh6tSkuoyFw5w
         3it8yBTH9JKE+kSgiwvR+XBbGk055fMJKWAE/NxYUn3xDezEOERGqRrkY6rkvQKNkOuu
         H0z5XRAHF6SDjOHR2D9PmbW1B2iZ6XScQ7EN+yLAZibTIgx61UB6Wfh/X6db82/iQc1b
         9jrA==
X-Gm-Message-State: AOJu0YyCX9L/k+/5PzHyPUQEDhL6KZReVMCYnqixZIq860lwVyUIydew
	kZ09hbmOS3XwdRZXyfYSSxXpGayv3GA2pJJG4p38TeL8X+UhwLfzKRNlmmhZ
X-Google-Smtp-Source: AGHT+IHi/sYzpHrXoi32fT3hwbVttkGUlyPAReO6XYlegQZAEQVZEp74q7oAqRTj/lFxGmU7kT5kcw==
X-Received: by 2002:a05:6000:1c6:b0:337:9a60:f006 with SMTP id t6-20020a05600001c600b003379a60f006mr1631658wrx.5.1706416954912;
        Sat, 27 Jan 2024 20:42:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11-20020adfe3cb000000b0033838c2c169sm4729816wrm.108.2024.01.27.20.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 20:42:34 -0800 (PST)
Message-ID: <ee8f4ae991d71d399a9c07086f56a38f7531b6cf.1706416952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v5.git.1706416952.gitgitgadget@gmail.com>
References: <pull.1646.v4.git.1706079304.gitgitgadget@gmail.com>
	<pull.1646.v5.git.1706416952.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jan 2024 04:42:32 +0000
Subject: [PATCH v5 2/2] patch-id: replace `atoi()` with `strtoi_with_tail`
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
Cc: Mohit Marathe <mohitmarathe@proton.me>,
    Mohit Marathe <mohitmarathe23@gmail.com>

From: Mohit Marathe <mohitmarathe23@gmail.com>

The change is made to improve the error-handling capabilities
during the conversion of string to integers. The
`strtoi_with_tail` function offers a more robust mechanism for
converting strings to integers by providing enhanced error
detection. Unlike `atoi`, `strtoi_with_tail` allows the code to
differentiate between a valid conversion and an invalid one,
offering better resilience against potential issues such as
reading hunk header of a corrupted patch.

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 builtin/patch-id.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3894d2b9706..4e9a301e9fb 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
@@ -29,14 +30,16 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 {
 	static const char digits[] = "0123456789";
 	const char *q, *r;
+	char *endp;
 	int n;
 
 	q = p + 4;
 	n = strspn(q, digits);
 	if (q[n] == ',') {
 		q += n + 1;
-		*p_before = atoi(q);
-		n = strspn(q, digits);
+		if (strtoi_with_tail(q, 10, p_before, &endp) != 0)
+			return 0;
+		n = endp - q;
 	} else {
 		*p_before = 1;
 	}
@@ -48,8 +51,9 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	n = strspn(r, digits);
 	if (r[n] == ',') {
 		r += n + 1;
-		*p_after = atoi(r);
-		n = strspn(r, digits);
+		if (strtoi_with_tail(r, 10, p_after, &endp) != 0)
+			return 0;
+		n = endp - r;
 	} else {
 		*p_after = 1;
 	}
-- 
gitgitgadget
