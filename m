Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0276158A36
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821509; cv=none; b=C6mrc3RSuzlp39y7qMAFAtmx/dH3ENL52obTj3uNDFiV87trsa0Oqq94Uab3zVMU7VUZcMecX3ZyTmfSm3BGJSSTWLnfWJZ0xc19nfcN9U0bJhvlTO7r9VW99NVYg3nXOZgWfA2WqaGbPQuduNbFJFAkxE7wb8EgXSImZE3d+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821509; c=relaxed/simple;
	bh=o8Ii+keb638e76pNCffq7cD58azl7fRuFq5lmVMT3Vk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lWL60+/+3Smgo8MQRC0Q9BegN3Mnavr6iLSemn+uXkMjbJs515+xGrE4H2yxiAXAhtWpowFwEvffisRni/KSqOA+Ft8L91FWFyWFPmekLKIehPbbqShZS0+PEXhVkGq8xX7IHjdzSooJeMAokuzGiGYinOETI7KcDJl3jeKbRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkoQjiQy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkoQjiQy"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so58430035e9.2
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721821506; x=1722426306; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n60XrBbnRBphxdLOallX7knQUSRYJ8MdRWM+lfj/nWM=;
        b=kkoQjiQyuDQ1d2nYV+Pbbk0AG9cRMmT0NAmYHt9+JNmtW2U3T6cjEl+jGCFCgpCNhP
         qFFivPOmWbAmSeCaUkIWta8X9VCnhOyCt+834lClaFHktGXyIeX7Fj+LeaGbPsT7qGGK
         Wz3HKL9iFlhT84OJ5eG2ixMTqgcRnLdeOtwYi4Gk4XVm0qjxsB4V6CD64PZTeJv8Awdl
         14bYdiedBQw+PhqQW4FOQqVraGdHzxcB7JUb8fU81LZekjvjUXSs7ZchJRL6Nwo+z9BN
         BkIFPUVFRj2UuZTKJyXD3QHMqqbuFPR2LuGf9S12kAiuQtO3b4vYu/hkcdoj+fR3tuxw
         9qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721821506; x=1722426306;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n60XrBbnRBphxdLOallX7knQUSRYJ8MdRWM+lfj/nWM=;
        b=q1YbNBRsri//OeZEZ2AslGTERQqmXzztSaoUU32jkaf8QOPAxbmW/1COHSy4DuLOMP
         qVa+bmr+W2CXm9YVXZdxx+Yd5BJpWlAWxpE1hPT7OXTDSbG4v4t2XGdz8l9Wlh/uShm0
         5bQ80yPCMsLZnHGQzpT11/gvKjCF855V4jpjCxLgksqe/54O+5zGeyqBCqPwVujMgvJj
         4IOmigeORQ97dhJ0jW4SoL/ilqhAvApL6kLSa4LDCrVpDu1WM/Z0yGU2sxh23/hzCfqM
         D33cZarT1thyifCNDZbHdTibYFjHWUJONX45C/F1bnoaOU+u/b7/KvdvyvdSeEvBxPlb
         CFYg==
X-Gm-Message-State: AOJu0YwqQPKaSY+XKNw+w1re0VuNovUdoqTRnIteQx0JiFlr1KIRqSTW
	O6fa0sTva56tSOUTa7Ilrx+V3UQrwG9qIW+HLd8U5PYAffcAl8Aree9jLw==
X-Google-Smtp-Source: AGHT+IGtulV4SKdgSWubw3rDmz4MsZYOGquN14JpTQmU8ID9BNgtBG+PPDF7KhNaCAt08fbfiDbtmg==
X-Received: by 2002:a05:600c:1906:b0:426:58cb:8ca4 with SMTP id 5b1f17b1804b1-427f7adf1fbmr20863405e9.37.1721821505520;
        Wed, 24 Jul 2024 04:45:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9359422sm26688275e9.10.2024.07.24.04.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 04:45:04 -0700 (PDT)
Message-Id: <pull.1744.v2.git.git.1721821503173.gitgitgadget@gmail.com>
In-Reply-To: <pull.1744.git.git.1721117039874.gitgitgadget@gmail.com>
References: <pull.1744.git.git.1721117039874.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jul 2024 11:45:03 +0000
Subject: [PATCH v2] Fix to avoid high memory footprint
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
Cc: Jeff King <peff@peff.net>,
    Haritha  <harithamma.d@ibm.com>,
    D Harithamma <harithamma.d@ibm.com>

From: D Harithamma <harithamma.d@ibm.com>

This fix avoids high memory footprint when adding files that require
conversion.  Git has a trace_encoding routine that prints trace output
when GIT_TRACE_WORKING_TREE_ENCODING=1 is set. This environment
variable is used to debug the encoding contents.  When a 40MB file is
added, it requests close to 1.8GB of storage from xrealloc which can
lead to out of memory errors.  However, the check for
GIT_TRACE_WORKING_TREE_ENCODING is done after the string is allocated.
This resolves high memory footprints even when
GIT_TRACE_WORKING_TREE_ENCODING is not active.  This fix adds an early
exit to avoid the unnecessary memory allocation.

Signed-off-by: Harithamma D <harithamma.d@ibm.com>
---
    Fix to avoid high memory footprint
    
    This fix avoids high memory footprint when adding files that require
    conversion
    
    Git has a trace_encoding routine that prints trace output when
    GIT_TRACE_WORKING_TREE_ENCODING=1 is set. This environment variable is
    used to debug the encoding contents. When a 40MB file is added, it
    requests close to 1.8GB of storage from xrealloc which can lead to out
    of memory errors. However, the check for GIT_TRACE_WORKING_TREE_ENCODING
    is done after the string is allocated. This resolves high memory
    footprints even when GIT_TRACE_WORKING_TREE_ENCODING is not active. This
    fix adds an early exit to avoid the unnecessary memory allocation.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1744%2FHarithaIBM%2FmemFootprintFix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1744/HarithaIBM/memFootprintFix-v2
Pull-Request: https://github.com/git/git/pull/1744

Range-diff vs v1:

 1:  51c02f58fd6 ! 1:  500b7eacf2a Fix to avoid high memory footprint
     @@ Metadata
       ## Commit message ##
          Fix to avoid high memory footprint
      
     -    This fix avoids high memory footprint when
     -    adding files that require conversion.
     -    Git has a trace_encoding routine that prints trace
     -    output when GIT_TRACE_WORKING_TREE_ENCODING=1 is
     -    set. This environment variable is used to debug
     -    the encoding contents.
     -    When a 40MB file is added, it requests close to
     -    1.8GB of storage from xrealloc which can lead
     -    to out of memory errors.
     -    However, the check for
     -    GIT_TRACE_WORKING_TREE_ENCODING is done after
     -    the string is allocated. This resolves high
     -    memory footprints even when
     -    GIT_TRACE_WORKING_TREE_ENCODING is not active.
     -    This fix adds an early exit to avoid the
     -    unnecessary memory allocation.
     +    This fix avoids high memory footprint when adding files that require
     +    conversion.  Git has a trace_encoding routine that prints trace output
     +    when GIT_TRACE_WORKING_TREE_ENCODING=1 is set. This environment
     +    variable is used to debug the encoding contents.  When a 40MB file is
     +    added, it requests close to 1.8GB of storage from xrealloc which can
     +    lead to out of memory errors.  However, the check for
     +    GIT_TRACE_WORKING_TREE_ENCODING is done after the string is allocated.
     +    This resolves high memory footprints even when
     +    GIT_TRACE_WORKING_TREE_ENCODING is not active.  This fix adds an early
     +    exit to avoid the unnecessary memory allocation.
      
     -    Signed-off-by: Haritha D <harithamma.d@ibm.com>
     +    Signed-off-by: Harithamma D <harithamma.d@ibm.com>
      
       ## convert.c ##
      @@ convert.c: static void trace_encoding(const char *context, const char *path,
       	struct strbuf trace = STRBUF_INIT;
       	int i;
       
     -+	// If tracing is not on, exit early to avoid high memory footprint
     -+	if (!trace_pass_fl(&coe)) {
     ++	if (!trace_want(&coe))
      +		return;
     -+	}
      +
       	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
       	for (i = 0; i < len && buf; ++i) {


 convert.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/convert.c b/convert.c
index d8737fe0f2d..c4ddc4de81b 100644
--- a/convert.c
+++ b/convert.c
@@ -324,6 +324,9 @@ static void trace_encoding(const char *context, const char *path,
 	struct strbuf trace = STRBUF_INIT;
 	int i;
 
+	if (!trace_want(&coe))
+		return;
+
 	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
 	for (i = 0; i < len && buf; ++i) {
 		strbuf_addf(

base-commit: 557ae147e6cdc9db121269b058c757ac5092f9c9
-- 
gitgitgadget
