Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D663611B
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706416958; cv=none; b=bjgxMiI36H59V6nztJG6qoGPmcLRRaFRP3xwXGEdP1u3SMkfro1JT8y8kHwkZm8TFgc7Natn5v3IoLOgMfQO5TXAgaX2Tkc0S4h+Y8ciO8RJGsjxAcd5l5otK9ZsKR68i5Y+mtm3+9fBhc0zfHkv8/eX4TSBQ0GCeXv/fbb9EYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706416958; c=relaxed/simple;
	bh=/V3LsyU5XhEGDhcMj8D3dmpQcL1yOpshLInxe0vjgOA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z28Sn12b0LPg39EzREgY4DynrVd1w5KSqh1y7kTjm98KabuzOtk/G7WTeATAZrccq8NIhm8FM3UPHp23vhdzpyeT6jLwyM8lU785+7RGNGHTH+midgzxFEvl7uoxFHRDx9EPHeMItSTacw1lyPEv1en1DoU0hbozRVzkJ5Zc9wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V42ls4Ug; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V42ls4Ug"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ed356a6ecso14343955e9.2
        for <git@vger.kernel.org>; Sat, 27 Jan 2024 20:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706416954; x=1707021754; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3r42piPMnxSjXEZrQXPfwz7WxhflliURhIdP2N1/Fs=;
        b=V42ls4UgMyF3pX630bldYx+/Iqs7xhPoh3ZBSNqCk6Gk8LDN2Z8mQ363e05dx6njNP
         ubJpQGFGOE96Ozujrm12jncahGvRexdtzt7yDIwyoKpGaTeJWDaxl0v7VEIwdouLV15G
         gke1vGa1Mnsdm6QcFkEsC7rx8Ik/6iWd1TVBV9kHw4EvPaOSAd1k1I4DObLszEB/cfdS
         x08/au6omoy+Xefy95pG/nW2q52z1TdrEKN3CDlPSD7aRxp/mZcSrvKl5hucC+BcHo6+
         nOPpsmUNQ3GyF2USBvOOoH2BDbR88lm/fDvBm+QrgxtMvEnmLs5JoecJaSnWhNDfvjzU
         Cw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706416954; x=1707021754;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3r42piPMnxSjXEZrQXPfwz7WxhflliURhIdP2N1/Fs=;
        b=vHnf/EamHSwejB2FWWbi/hIGwOd5l2TgWu+i6tBsRLijV0CH+JSoZYyy/fT39o/T/E
         kbudKV0EUeCHsm8Li/ClVRM89g3/cOofCsY2MeIb/FDQtu49VXrz0npxTJEMvDhrtC//
         yXrhRqHX0SscSCz4QTqR5vOOFZGGHvboJ79t13vwGqUW6jVJ0W1u9cShR5h2W3brOENT
         8LTbt0yYV21g+ixlP7QjYC/bD9XcyFBgu/ofJiSeIffV2B/1ewMSQsbA6b5O5fo/CiNQ
         PmVnnX0wsYx02znF4N82/0LGE25+1gwOpOgKX6Akxifs0CETyCW/00ICAXoOlUcWmog2
         oIEg==
X-Gm-Message-State: AOJu0Yz1uWbwOhgHE3P+QgnL/R7Gs4tpqJuJXw9Sq96AhHscAwD36kv7
	H+QkSAdE1iN8CGBnU+NX650tmf9P1ZxzVCk6b4GCU3A/yyGEc1Qb1SaMIt8j
X-Google-Smtp-Source: AGHT+IFX3WVeGk9UtBv69YlRslflnhWf/OquJnN4RZ7uioQWzy1Y2vnQPI4dhWXJrdHQ2tXO/eEtcA==
X-Received: by 2002:adf:f2c2:0:b0:337:9d3b:c180 with SMTP id d2-20020adff2c2000000b003379d3bc180mr2608016wrp.4.1706416954347;
        Sat, 27 Jan 2024 20:42:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4-20020adfa4c4000000b00337d4eed87asm4790254wrb.115.2024.01.27.20.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 20:42:34 -0800 (PST)
Message-ID: <f09b0838f049de3e4b8cc6adc6cd4492bac7e967.1706416952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v5.git.1706416952.gitgitgadget@gmail.com>
References: <pull.1646.v4.git.1706079304.gitgitgadget@gmail.com>
	<pull.1646.v5.git.1706416952.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jan 2024 04:42:31 +0000
Subject: [PATCH v5 1/2] git-compat-util: add strtoi_with_tail()
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
 git-compat-util.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7c2a6538e5a..c576b1b104f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1309,6 +1309,29 @@ static inline int strtol_i(char const *s, int base, int *result)
 	return 0;
 }
 
+#define strtol_i(s,b,r) strtoi_with_tail((s), (b), (r), NULL)
+static inline int strtoi_with_tail(char const *s, int base, int *result, char **endp)
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

