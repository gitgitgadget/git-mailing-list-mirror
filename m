Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C45369999
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766074253; cv=none; b=ne9ebc3lDBVdExapFUZKffrIEwOQNvWMkU6nKC4p+nlBh6tRmRV3XnlUDm2HG6UV+NE1vLSM4SxWXciU48CcRaHnqtEAsmWRC41j5mP5+ZGmSLXaXU7tdIQWuvrqx0TXIuKggttAYpIXzwM/wpbzO55H/1DZo+JRI/UIYnR0rVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766074253; c=relaxed/simple;
	bh=GZXGFfvrNNRMEosgUTsuCpWBE/OxUgiY4v/n8yzXTkE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Rt8CeVB6YN0GCWF/qXonB7Wav5sWZqa2OOllGSM39CuxtgbfKKLXGLZyf5/BV+zRFLqqmRT9F14wPOfeE8J+uvFnkFSGArb0GDdleWiqMsm0xAuaZxf1+wu6vdEtwrR8iidFq4urwD/t/KGSpYxdIhtbHivObOYAJnObQJRmkOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dwqfcog4; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwqfcog4"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c7aee74dceso289766a34.2
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 08:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766074250; x=1766679050; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=18u1gBQH20WF1R1A8Gc0HVOWZhmbfmaqsHrHPJq5OlE=;
        b=Dwqfcog42y+YJlxbZFMV//YWOrycAiuTirykb1Xjv2D2mqPzHXrT12vwMUZjtjVKKU
         dmuPZClVI/YtjjIAVUaE/yGHNo+xMlovn+2ZLGEV55lnRs/as2BKaDOo5xt8I1Y5T5+Z
         NVr7f/KhDoiLIGpqGfI2IIVBavCKeRZ+9SXkMG9cNSISAWDOn88SDxsgXiQcOR2+GaXp
         o5gt0iv0uojs/KBQsCu82WxiqGFvXpGLBZFAA2jVPANpg96CN8NiML4MEgNuQjnU3XLB
         NNFJWPSym4dKxrSPLKgtzVm6zShVXO/pG8MqVT8Cpp/q/1c8/iqYNJTVv/4FVk/NWpdo
         RlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766074250; x=1766679050;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18u1gBQH20WF1R1A8Gc0HVOWZhmbfmaqsHrHPJq5OlE=;
        b=FzqbQe9kr/rgOEuMeQYH3/bOBo2OGNWuCUH2k4DWF3Knhbuj5906Wm9pNVXl01awQn
         V/y0D/EiwpuWt16BIyOyNm5vQTJNuRaedH+CcAnpvQ9xvYSsfL58OHyZy3bWidi74N8v
         gmEjpZC3wvPalb/fU/+u6HPTheMtNjU/mSn5sM8qECBI6JL5bM3+KH579txD7B95hL/D
         FECu4O79Nhc7BmuASjhVa18XKnl1E/WsGKxQzMbBXvjaz2ccpvadvQtzmorVdAIRyEeo
         aSul9UcAQzA9SmUcY/zzSwUvXiNFnpbggHt6NvrcWDJEJwhpN3wTdRZOG3ilAswlw8zj
         q++Q==
X-Gm-Message-State: AOJu0Yw3lqZq07pxWIqxv+hE+z/zzDtublYXAKia7qPcPcWzYH15kM4q
	zL1OzitR9ylLpYOiyoV4gDv2ZsCkzExbeAjziXi3RyTcPxSuRzOAQqNYvwCI2g==
X-Gm-Gg: AY/fxX643KEvCR/fzFFy4rQTgHmvXcN9RWLBhsw5ziEXflVkhZE16zqmYAzNrnbvtOE
	u+16XyG5YNs9eIhp/vIcWoSjKcY+u6Palt9LJWlWqOqBLn0mNWUwlfg2jT8ZmwCUlZmYIXnFeyy
	mUfWa0R8k8lvtZv7D7TDQXVSqmcq+jszBI5bhC7VTgwukqLNB5gywoftQmvAhaB89eLihIPMdgA
	nOxG7/G/x0ch0hEUR4+uyezOUa/JTbzgwvFFFIW3wv7TJMUw3p2DFV6PHi3v8ezx7e4dP7VGZ1G
	IomiDl4BKoJW97e9j3MnZ0pU11TodTn7/XQ1+oslTOW2JQKLTB4JYe7FY8CM2Ed1cdjeBSTV5G9
	tReTuBClegHr2WPkvKhdHjOnfORUjz9Rq4cPNpbMag0Cp8gVbFbQ5rdWbmlJJ3tkH7o6Pdd+2uS
	twm4ZzX28xOi6lWg==
X-Google-Smtp-Source: AGHT+IEzYWjHCG8+PbKsMOIA71qBiMStMAKhZD1hGhr9jz5iy1thnKEbfx2I2KAlGSMZ2JcH3i0ecg==
X-Received: by 2002:a05:6830:4393:b0:7c7:5f8c:71a3 with SMTP id 46e09a7af769-7cae82ebb9fmr10737911a34.2.1766074250660;
        Thu, 18 Dec 2025 08:10:50 -0800 (PST)
Received: from [127.0.0.1] ([52.176.138.195])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc59be4f40sm1963667a34.28.2025.12.18.08.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:10:50 -0800 (PST)
Message-Id: <pull.2130.git.git.1766074249443.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 16:10:49 +0000
Subject: [PATCH] refs: dereference the value of the required pointer
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
Cc: AZero13 <gfunni234@gmail.com>,
    Greg Funni <gfunni234@gmail.com>

From: Greg Funni <gfunni234@gmail.com>

Currently, this always prints yes because required is non-null.

This is the wrong behavior. The boolean must be
dereferenced.

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    refs: dereference the value of the required pointer
    
    Currently, this always prints yes because required is non-null.
    
    This is the wrong behavior. The boolean must be dereferenced.
    
    Signed-off-by: Greg Funni gfunni234@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2130%2FAZero13%2Fref-cache-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2130/AZero13/ref-cache-v1
Pull-Request: https://github.com/git/git/pull/2130

 refs/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/debug.c b/refs/debug.c
index 3e31228c9a..639db0f26e 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -139,7 +139,7 @@ static int debug_optimize_required(struct ref_store *ref_store,
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res = drefs->refs->be->optimize_required(drefs->refs, opts, required);
 	trace_printf_key(&trace_refs, "optimize_required: %s, res: %d\n",
-			 required ? "yes" : "no", res);
+			 *required ? "yes" : "no", res);
 	return res;
 }
 

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
