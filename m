Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C0168A8
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706078890; cv=none; b=pk/4prcpKY/VRtRuVGB61NkxuA3Q0mNIoWkuvEtrdweRT5cu86QJqzO3X1zmEk1BNgag61Y2ypO4hDMLsElEQuEflyHO866tbmevJu1AO8uHKGZg6jtkBMXcdISZE+SM/2+Zb4Rt5XONk6S7iVNDj7CVeHF2h+Ngsh7b5fH366s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706078890; c=relaxed/simple;
	bh=cvB9/72Wxp5HfkFdJNKQXcnlmLIA3G9LNM+2P1toZUg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DgbvVAg+qYgPsli4TT/sOnyxxksiZrrBV2h2+Y/DvJR9hKcBkcfLeVqfEPEZYMFpXM5QvpFhEIUiVlMI/JyzRIDGRjXs1EGeuOlSUrJTI2pM/UhRel5bNOIz2kaUMPlvQVfrCKWiRhGX2AcgLo6d9VxDMxY3WFpliNGE9WeBYD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1rU1IkV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1rU1IkV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so29650295e9.2
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 22:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706078886; x=1706683686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx1AMjOq3+OH82dLgTsfAb8gURv04azI+Pk9ozmtWZ8=;
        b=f1rU1IkVfb2JIhQoIBbV9yym99JpYyEOH8BlAUMuS0MgK3F1TLfMhy+7+1N3meVz4y
         qwT3RK2ky/PeSMMHxTvHSbywzeOQMAUM9ZHfX1AjhsvvZnge70L6yxorGizYdu+N6n/R
         eQQkqn49ldNghJEyMjW3g9o22FT3plVvkGVawvtHqlpWkIb2rE7ocIdl+MVlqHt2kZrG
         Y2Qjep1h7nVY8a+ygNy95cbOxHLJH4/9/xfvTi5XFFFZ6DyTe2376tS/ix61EP37Mu5M
         Eu7baoI3l5uOfdKgyTA4NT3stganHJVvZVYh49JbnP2310Naf5gWD+J5vHTBC8Bxagoi
         bUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706078886; x=1706683686;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx1AMjOq3+OH82dLgTsfAb8gURv04azI+Pk9ozmtWZ8=;
        b=HiBTmyhv+wrY6ArcSncmZmV6ppkXxRblEDv4QIYQW9vCPIqxmEyRwpPot4TkNulnhJ
         3s1B/G5wjFnDz4b5LTYFp/WsNX1oJXsVknu1CSTFwAGUunata6P5a7trfEOgWZKJBaCn
         ZTU4CgfwYrLzGXMWZTw+Zif9LyaDcMTDXcCbSLDX1CnigBoDQ9esPp7kRltSb7dTNsBC
         vDPjSDCQqi9rkWP3bnyRTygtvjCfFnWgorwG8jqOYDMAmHzi2EubL0wpgcgigAYUi10p
         qE7TUyK44ZshFfGUtkNLULzf4uhI0ztlzurG+CBgqVV3YM5IRKSer5aGzNTVBM7NqN56
         aLng==
X-Gm-Message-State: AOJu0YzLjTUnSjamCLXjsH6Kf4He8yN9BxagHyJytpVupjpJ/1shDbrV
	jw+QsgkOsKM6EywPc0zL7oK+kttQ8iXA6/xMipSox5XikLibgl+jYipGxYJe
X-Google-Smtp-Source: AGHT+IE2sWum+kVhZcBg+Kw40XzOOeU1SQRZ/mvmp9aClNos9yLQUT7Cz/DVr4uRNdo2sHPleYqKwQ==
X-Received: by 2002:a05:600c:5118:b0:40e:a7cf:10e0 with SMTP id o24-20020a05600c511800b0040ea7cf10e0mr858192wms.20.1706078886612;
        Tue, 23 Jan 2024 22:48:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm44242417wmq.12.2024.01.23.22.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:48:06 -0800 (PST)
Message-ID: <60ea85a701a05831b0adf1e3f9a7a97fd31ef43f.1706078885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v3.git.1706078885.gitgitgadget@gmail.com>
References: <pull.1646.v2.git.1706077977.gitgitgadget@gmail.com>
	<pull.1646.v3.git.1706078885.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 06:48:04 +0000
Subject: [PATCH v3 1/2] git-compat-util: add strtol_i_updated()
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

