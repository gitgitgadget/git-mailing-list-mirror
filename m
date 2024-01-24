Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA6BE69
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077983; cv=none; b=oYy9wiFMIhz7BNuxeKhoDmvX3SSchWCgRNHR5weYHwuSqZjNvdHAWgtlWE/nLOAI0Vl7h32IGY6Jt6f4zjdfQg+mLcypBCWcsLsKKTFhlm+nN29cM51nlCdtkDu4Qs8UTi9GsksQrG95lSjrMmCF9bUf8iXVp6Qeuq3vQl+IBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077983; c=relaxed/simple;
	bh=cvB9/72Wxp5HfkFdJNKQXcnlmLIA3G9LNM+2P1toZUg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FRzguj46ecnaasoh3VMQjEMg0uR4pr4ZuIfIRMYPLpyoY4fOGw4RNsB/JQrsOqm1tzcNhw7TQRKzrZuTfm7dxggnGi1IQj7VRchtWF/PxUUQwT3X8EMq/dQcIMz38L+LVReRgF4Xu5r+muSQNBhXW7mbO+PYsKgswe/rs8SyZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAM5hWcW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAM5hWcW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40eb0836f8dso24725445e9.2
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 22:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706077979; x=1706682779; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx1AMjOq3+OH82dLgTsfAb8gURv04azI+Pk9ozmtWZ8=;
        b=QAM5hWcWjJimJxStwcnFckZCALswZb9sGBEqQoDtLjtRiveI444KvR4EVGrG47xEVc
         FsTw5qD3FcUe2EulLEvBVnYWK4rCNgDl08lNz+llHFB6D0t1xNs/hXwz/Y0J5S4/M4vx
         6QiBH5z35xQfvzKS+zx6mqcohKVsMiydxC/meoVssXD/ZlRjvWjmrnpFm8sWtmGzgEBW
         myIqOMN92Q3b9pP2WJBbagubv9EwCmkhOM5zBlu0xbBEMnMXxzJ6Q4Czpbb+s1YqoIxX
         d7whdk/BsWXRMzr4tIgXFTJml/QN4MIwIFu1+lq+WXHmHJT/9kiBt/ZpIXROWWdQdFG+
         YVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706077979; x=1706682779;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx1AMjOq3+OH82dLgTsfAb8gURv04azI+Pk9ozmtWZ8=;
        b=b2p9G1ddDqWq1bUmNHKymcnn5JqD+26R3ZIemRzYaEvBhtUbbwwbDudVEQ10rsIxNe
         hKFc9Fm1snYgpWuXIu2C0x+7CycNtxi8Fcea4cRQSbwbmJhAQj9+hD/CJ1H2p6WGUZdO
         z8FItmZyfMJJNSPPt3oN+KMuxeRBeoPIhv9A8hT+HRNPGs55FFhMgNzpVbJtzcd8AviA
         WNtZwsLPcJFbmY+gQ1g+RTxHHorL6QgVhFA2LJFpAp8MNpHGN1VkS8dbYIa4I06BAhtL
         37m09THw2b6T+AT6NtBdgBqktDlAc9Ou7fZ743fNCdIkbn5gk6sJJ+YUt1LjtE5rgU4b
         6dwg==
X-Gm-Message-State: AOJu0Yza9UYQ3FiXXkJbpoL9OuFGpfE0gaCcKK8VL0Y5oQyR6honN1Hc
	Cqzkycu96LD/mqBICUugx5zF4CnkBY12QLbbjx2JmnLBVA+UtbwrwBMgPtou
X-Google-Smtp-Source: AGHT+IGxRjCroVyO6Syp6rLrY3IwpyQVwZx2yQaY2Q5Dg/S2BO93WCQ0UdUckPxBr76t/sBn7VGdkg==
X-Received: by 2002:a05:600c:c85:b0:40e:6247:5f7 with SMTP id fj5-20020a05600c0c8500b0040e624705f7mr756364wmb.45.1706077979293;
        Tue, 23 Jan 2024 22:32:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b0040e4bcfd826sm45396477wmp.47.2024.01.23.22.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:32:59 -0800 (PST)
Message-ID: <60ea85a701a05831b0adf1e3f9a7a97fd31ef43f.1706077977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v2.git.1706077977.gitgitgadget@gmail.com>
References: <pull.1646.git.1705913519.gitgitgadget@gmail.com>
	<pull.1646.v2.git.1706077977.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 06:32:56 +0000
Subject: [PATCH v2 1/2] git-compat-util: add strtol_i_updated()
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

This function is an updated version of strtol_i() function. It will
give more control to handle parsing of the characters after the
integer and better error handling while parsing numbers.

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 git-compat-util.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7c2a6538e5a..b38d7c7f8f1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1309,6 +1309,29 @@ static inline int strtol_i(char const *s, int base, int *result)
 	return 0;
 }
 
+#define strtol_i(s,b,r) strtol_i_updated((s), (b), (r), NULL)
+static inline int strtol_i_updated(char const *s, int base, int *result, char **endp)
+{
+	long ul;
+	char *dummy = NULL;
+
+	if (!endp)
+		endp = &dummy;
+	errno = 0;
+	ul = strtol(s, endp, base);
+	if (errno ||
+	    /*
+	     * if we are told to parse to the end of the string by
+	     * passing NULL to endp, it is an error to have any
+	     * remaining character after the digits.
+	     */
+	   (dummy && *dummy) ||
+	    *endp == s || (int) ul != ul)
+		return -1;
+	*result = ul;
+	return 0;
+}
+
 void git_stable_qsort(void *base, size_t nmemb, size_t size,
 		      int(*compar)(const void *, const void *));
 #ifdef INTERNAL_QSORT
-- 
gitgitgadget

