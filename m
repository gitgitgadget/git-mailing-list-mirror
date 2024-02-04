Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077726FB9
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707025724; cv=none; b=L/6A0bL9tZLEbcRH//L7AUXZJynzT8HDvAtVc9st1KqXvBR2LrcUGKEorAslNEP+xMq6MWK1Q9ARuxJa3k2f26my0NEGtT0V4WVxHaY/ilQVXDwQ9C+BfphnrkI6s/7jUm12iFN+LQ2AbYpseGBKzXmTrSq3+DOZCIWCw5Dt3j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707025724; c=relaxed/simple;
	bh=t1pnBQkJl51ZJtibERqIEoF2J8lIsj9Utdt21WIxqaw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CthxhFUROQ+pS7yhQrJhXcvwaT9AQoewO+QlXgK5F6i/BP8KQN16pZKjigHwrD3YPB6KjnCKX0Gv44PIY6w0nXouiMrGnsuGOkyRpBbZn6btRFcmD8UReKE1Z03O/1kLWSZC0CmmgLbUyR5c7JImLVCran61tSbf4DHWkZVx9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHUvMUPW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHUvMUPW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fc65783aeso17892075e9.2
        for <git@vger.kernel.org>; Sat, 03 Feb 2024 21:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707025721; x=1707630521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcJxdQl0R/kYPifJMm+diLvkXJLQZJEG1pF8oQkFxvs=;
        b=fHUvMUPWwh/v3JgjmL2QCBD5+sZuhHum60PAiiLLrKYnIBoc3HEfZD5hw6dkQrqwm3
         2g5pPkv1XoFog5OeTr7viK6cNNtRjhGu/Rja+LBbHBoEYVUxHAnu0vuZm7el3Zw9vECU
         9uJ8hYA5PbvoFQeEL8Dp5Jxh6Dlm12oO/W/y81F+UEPlH9DPEpfsmattbWxmd0HBqAjg
         yFbH7ynYg0TQ6szmJl9QfKWHKIAR0xjk30aEg6pQMmXV1qHGuE7PRxrE225WMvXmX6Sm
         gdYSghebfakyEUzTGISMKJrcQWRccgOruKyHXUWy5oWvWy7DxtJQGdnJLAYeEJYPmelo
         31Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707025721; x=1707630521;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcJxdQl0R/kYPifJMm+diLvkXJLQZJEG1pF8oQkFxvs=;
        b=CUuKVBzvOVN6F3pOBA7TOXHbXat4LfTAGJtAeseMfWM+TXfFjsyoscR4GwWvESJ22B
         xG1LmtctPlpUopfxBe4VlkudZurFW6xd3nf1hBddPoEAzk/o8GPl65qPsok/Yu3/zVpv
         y7LXShZZqdQF4txDXPZA7KYg2f4Q/XbvW7uy1dHaj7K4tkSnLC+bVrPbGOxPKsEV3Ego
         XpOm9Owk/Zzarz14pI5hLn0KxB+tbFiGM+zkpW2psXiBvmJux5ADoLRA8W/8P+rSIOyO
         kJaC7sl43Nz8hSnFAlmzbNeMBluvxc/vzfX7fSTHqL3LLACGMY05SlZ5RBlKeJfkR5xg
         ThnA==
X-Gm-Message-State: AOJu0Yx/kN+D9X/jN2TBszQokxbaPcEZmH+McdsRLgLckf/E2O6/nATJ
	Yg4g9dQUIvDlj5SY2FvSkqAb45k1fYAoutOEU1vi1M+O/1kjCaAVfqD980cF
X-Google-Smtp-Source: AGHT+IF+hQzKSfGL/LLPyjJi9jq28JDn7Ts5asK7Fj7zIRE0UzkO5+A/Kh4FKaiEthIOp8K+jBf5uw==
X-Received: by 2002:a05:600c:314b:b0:40f:b9e5:ab35 with SMTP id h11-20020a05600c314b00b0040fb9e5ab35mr1884050wmo.36.1707025720972;
        Sat, 03 Feb 2024 21:48:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXIY9vf9UjT+BHHWbay9urvaHBXeEmZUyZAbQsaqTQSNYTPUBvUfm+yJhlPYmp3ZhUuUI9GzaUrwZ0wxTW8AxbPSe7teIpZzOk=
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040fbdd6f69bsm4770805wms.33.2024.02.03.21.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 21:48:40 -0800 (PST)
Message-ID: <98e516a7be777f2697073e64b28c293e7a8a0011.1707025719.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v6.git.1707025718.gitgitgadget@gmail.com>
References: <pull.1646.v5.git.1706416952.gitgitgadget@gmail.com>
	<pull.1646.v6.git.1707025718.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Feb 2024 05:48:37 +0000
Subject: [PATCH v6 1/2] git-compat-util: add strtoi_with_tail()
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
numbers and better error handling while parsing numbers.

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 git-compat-util.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7c2a6538e5a..59256a441de 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1296,14 +1296,24 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 	return 0;
 }
 
-static inline int strtol_i(char const *s, int base, int *result)
+#define strtol_i(s,b,r) strtoi_with_tail((s), (b), (r), NULL)
+static inline int strtoi_with_tail(char const *s, int base, int *result, char **endp)
 {
 	long ul;
-	char *p;
+	char *dummy = NULL;
 
+	if (!endp)
+		endp = &dummy;
 	errno = 0;
-	ul = strtol(s, &p, base);
-	if (errno || *p || p == s || (int) ul != ul)
+	ul = strtol(s, endp, base);
+	if (errno ||
+	    /*
+	     * if we are told to parse to the end of the string by
+	     * passing NULL to endp, it is an error to have any
+	     * remaining character after the digits.
+	     */
+	   (dummy && *dummy) ||
+	    *endp == s || (int) ul != ul)
 		return -1;
 	*result = ul;
 	return 0;
-- 
gitgitgadget

