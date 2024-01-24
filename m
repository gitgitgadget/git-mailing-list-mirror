Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D422516415
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079310; cv=none; b=iPBpaAUSa2pE33QU3bfIv0mTKp+AHjris+z8bjuwB2AdHGSaDq6CQaA34WBY6Qm+LMIBqXMHHOiYj3QdKDcdgNDj6vEvCefb/J7383TB7NsBvPlD6mtJ20t0eCSFHXR8TMe6gIU5wON0zsTAQo8/A6xNXTc//Phtx6aw0Tt2Vng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079310; c=relaxed/simple;
	bh=cvB9/72Wxp5HfkFdJNKQXcnlmLIA3G9LNM+2P1toZUg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G/l6ie5f3HTSCFhMsv1LzCvpacchAn0UltsH/iSMlAdj80of1K0zvO89a3wP0dsRqhOgIWfgY8vsHG0DZCsIasqXBCjWP/+C7PNcx4OQC1hevsRUUeb/9Q3PmxrOcGj7BbZM8LXdHQIH2b6GGWTLIgzQ1Thj1MpyCet4W+ePrtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPL0vYmF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPL0vYmF"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ec3535225so9550345e9.2
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 22:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706079306; x=1706684106; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx1AMjOq3+OH82dLgTsfAb8gURv04azI+Pk9ozmtWZ8=;
        b=iPL0vYmFQvgWn7ECe5DSBqmd8Z8zN90+WUR8FOuRobn31QArx2vhgqxuuC6K9bdB1V
         0MmroC6OWZ0D+uD163wiL9/ESBiyB1A3U91J4spzPFaD8p4r55WQKJNOQ4TP8LqDtIrx
         ffTBX2AQ+1daUlycear5Q626ehClXxSEJ3nZ4Q9xJCwJhXsU7lItoZVJ1qNXZcUNBbz8
         lfNFy/fB5VaF/VXdPP6klu2la3hwAyWbxeXE0nVmLoCk1fDq1hSKLSXCk37PY4zL7oaM
         WPdFZ5P/V8mB2v8Bp8pf1fVjNU4bH2kT0geqmyV3kaREzQ7qKQ29z+ePpe4MmUCYiPxP
         8Cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706079306; x=1706684106;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx1AMjOq3+OH82dLgTsfAb8gURv04azI+Pk9ozmtWZ8=;
        b=J4WQ9JpFaUMV29Vy0V8+fnahTVeZA+S5ldbep5PtmNjXRBvBQ/foPsXcmJVbPteMPd
         O+gZJzQmD+7u7tcRCv+ZGzzgVxcRhm/3m14cj+gv8Ju7jlbe1KKtiGqTiSfTxJXLiVSX
         bSdKten99dzm4CC3lqWJ22iu3GDJ/Xhm/5TA9ZjW9vQ6J8S8/3VUTjJ5tPZ7Mh6jHr0C
         4DXNiaseGdi1JtwIDiijmGKjqN9LL2TmivM62TnCD/BK2UY4UpcHFr+b/nrjh325h51Z
         hKoQ5XeSdzoaXVM/JJIk38eNG28Q9uBT7AME7sWEMl+vAoSX//iwNb0/4OK4MuKK3/9y
         BgEA==
X-Gm-Message-State: AOJu0Yyg+4i76bHcB/NfBAKKJFkocgPqe9N4XPVPXfvALF5YbVFCcC9p
	Y+pNsHFfUOx2EU9dcD2pXB/nGDe3HfIbat6vckt1inxwqBsVj3GY5EUpS1NL
X-Google-Smtp-Source: AGHT+IHXvw/XxdmoMGzN4/9aFxZZtNTGZj2qHhG1UoKZD+7QTXNm4imcdJ6knbTSO9pAspvPW+UW4A==
X-Received: by 2002:a05:600c:3ba2:b0:40e:a328:25ff with SMTP id n34-20020a05600c3ba200b0040ea32825ffmr644728wms.93.1706079306515;
        Tue, 23 Jan 2024 22:55:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m36-20020a05600c3b2400b0040ebfbff33csm3564213wms.36.2024.01.23.22.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:55:05 -0800 (PST)
Message-ID: <60ea85a701a05831b0adf1e3f9a7a97fd31ef43f.1706079304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v4.git.1706079304.gitgitgadget@gmail.com>
References: <pull.1646.v3.git.1706078885.gitgitgadget@gmail.com>
	<pull.1646.v4.git.1706079304.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 06:55:03 +0000
Subject: [PATCH v4 1/2] git-compat-util: add strtol_i_updated()
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

