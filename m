Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6E3A1A3
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711215372; cv=none; b=Oue5ahrirQyu2xz/Q6knTKum7G1CRuAdxYPZ0Hf4SEnrnoXVSgvBM1iY5Y3/UgPe5VJHCJQ4aKfWc/68NvSzGYLL3alxnYZqfRfp6rl76T2YiyrlOtPUc7RZ5Y7tz9eFzifqqhQhI/46dXSyF4pTHCboVXt3Y17Dx73L0tCVNvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711215372; c=relaxed/simple;
	bh=COyyyj4C+H2DJu2s0SQ+BcpL4AUy/y3mDxnoRv3G6NU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=MlCCy3knO2lPJQGDxD8VUDE97bgnbBCoJXWBrsV1evJbecgtOyJqSgqMf3t6HvC31IduPQ9SJP9J7sjyevTDKCf3ZTLTAVSGrArIIC3Q96DSlhZ1z3p6E3Zj6QcgA92NmjXAvBFZCZzFqm6NLSp0mVT4vldHP303tpfK2Q+nZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvSoQDLZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvSoQDLZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41484c4ec03so1851495e9.0
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711215369; x=1711820169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbAa3cnpWLlPm+ArXelO7q7566t5BgdcCUzs+JiNo1U=;
        b=jvSoQDLZIiBSS+IddZBwk9Gs7iFTS0JKB43UBuRCsRUcdo0buvJMsfN98ApTrnjmit
         bVng7bescWVZPw9cBAXC/hnPFmEoXnFcTLRr+YNID9WPq+QizHvHIRDLgVBJPB38IoOA
         IKm6Vt08Dcs6pKyuyybL2+2rZ21wTkrTd+3jfyfbH7VfZc+75j3ec+AudTBIayCpuSDq
         /uCWArrYNTXAJRw73va16mqKGniH1I1ij3turC0f7zHRB8vwsRyWv29hzrEwd16CYuNj
         SzIsAoih1AzgthUFoPYgKg2fEuvxi86g20mh3YIhmSQd8qfLII2pJ/wTtaG2CLM6kmX/
         KD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711215369; x=1711820169;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbAa3cnpWLlPm+ArXelO7q7566t5BgdcCUzs+JiNo1U=;
        b=B/0tBZMAruNRZdO6aAEMSGOTsmr+dn98gYolwfsJczCYgY0FoeBgN2Mwj4D91doWvs
         ziIGc+3cD5u6o+bjjyyaEVtHPfM3dS5k3WU5D895BFcs4z6tOjLKR1VZxbCZikpu+79U
         ANMnPcJGTiqg9xRSk5x/54a0swKAs0dx8VdmDBCF/5u+1YFnFo7NdDN0VsosqH4OUUua
         +A8aCMfERkdIMG3/cAskW4wY4okp+68mOdgJYmtBUATGAytTMvL8aTceomSK+P/8onQR
         YJeGmyCwi/HSGKHkStczGgp0QtnkfJ3GeFgeB4cuaO7cQUW6uB4nax1du9S59VN4voVH
         GUWg==
X-Gm-Message-State: AOJu0Yz9ZNfgixldt5yt3h5ZnMYrCCKpmY6tM+khdVnaR6M8QM8xs9T2
	B5agpmBJpJNZebVoiHkpSgBJbrDuLjv9/dCXuQID/7HRqDZzb06OXAX5DSPx
X-Google-Smtp-Source: AGHT+IERFDV6ZFnu4REap8eEHvurGNt0W/t+hULrJGwo0ooxQIrd2WAXJAwYVTDJUqQguN/kDRBPyA==
X-Received: by 2002:a05:600c:1912:b0:414:7e73:5673 with SMTP id j18-20020a05600c191200b004147e735673mr1908431wmq.12.1711215368682;
        Sat, 23 Mar 2024 10:36:08 -0700 (PDT)
Received: from gmail.com (181.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.181])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b004148213216esm1886714wmq.46.2024.03.23.10.36.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 10:36:08 -0700 (PDT)
Message-ID: <bf1b2aef-2d8f-4b24-be2a-1a312f9f9f01@gmail.com>
Date: Sat, 23 Mar 2024 18:36:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] bugreport: add a new line between questions
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <35de2d76-a03e-4a36-9bb7-6b6ffa4ea123@gmail.com>
Content-Language: en-US
In-Reply-To: <35de2d76-a03e-4a36-9bb7-6b6ffa4ea123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Occasionally, we receive reports where the user have filled in the blank
line we provide between each proposed question, without leaving any
space between the answer and the next question.  This makes reading the
report uncomfortable.

Perhaps we can suggest to the user to include a blank line if we
duplicate the empty line we provide.  Let's do that and see what
happens.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/bugreport.c  | 8 ++++----
 t/t0091-bugreport.sh | 4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 25f860a0d9..01b72163b9 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -77,13 +77,13 @@ static int get_bug_template(struct strbuf *template)
 "Please answer the following questions to help us understand your issue.\n"
 "\n"
 "What did you do before the bug happened? (Steps to reproduce your issue)\n"
-"\n"
+"\n\n"
 "What did you expect to happen? (Expected behavior)\n"
-"\n"
+"\n\n"
 "What happened instead? (Actual behavior)\n"
-"\n"
+"\n\n"
 "What's different between what you expected and what actually happened?\n"
-"\n"
+"\n\n"
 "Anything else you want to add:\n"
 "\n"
 "Please review the rest of the bug report below.\n"
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index fca39048fe..f9c1ff9cb2 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -18,12 +18,16 @@ test_expect_success 'report contains wanted template (before first section)' '
 
 	What did you do before the bug happened? (Steps to reproduce your issue)
 
+
 	What did you expect to happen? (Expected behavior)
 
+
 	What happened instead? (Actual behavior)
 
+
 	What'\''s different between what you expected and what actually happened?
 
+
 	Anything else you want to add:
 
 	Please review the rest of the bug report below.
-- 
2.44.0.494.g7a0daf3e0d
