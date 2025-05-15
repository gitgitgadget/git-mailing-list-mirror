Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA829A9F2
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313152; cv=none; b=iV+Md8yAOVU4OgzjciL+IcYqJ7+SX/Jy+vlC2FWXC95RPR3a2QfNS432CLmAFNah055RiET67qQMmVdkRNL9B46r8dtpSOCh8wojB95GGreZ+4954Ous3GLEZ8PyP81Ra6yeOQkrlp8pmLyhHkvhIaqmQ4Dtxzn/va1u/6Ggs1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313152; c=relaxed/simple;
	bh=KTbXRFHDiAo6jAPFF9AKHil8Nz6WFn0I5zvaIgRM52Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U0NS6/jjBOGwBXAznddJ61cIP7uPtnC9Lj7jqm7mgS8EigFQBgH5sSkU/jyUqavaI7+zmzOHv/oOSYSXVoGC7ZP4J3+zqa3KD/AwLLWePmg8egDHmLQgfZ+ajoMHFSx9EvtcPaO9OTZ5Jk/ve8o19nmf9xmDWmDHRYtusOuqwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThJZsCbi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThJZsCbi"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0ba0b6b76so749125f8f.1
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313148; x=1747917948; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hvIJwZs/S3AxTX77Jw4k9hnA93Hw8M8dn7JYGbX1Xg=;
        b=ThJZsCbihWpNidqLOXniLDDCW9+bjDsUwUkLhUxqJ5QKYt8inu1MhXAx3p4tKjbyVh
         EY0Yw9fhwdekiGO6snZxf/FGWqolVLt4vh7gJWXQ+AbVL8DTd2dyoNuXEvZj3GyDFlzd
         3ksI9VfYEj11UHyJGFZadMjFQ4IbemPWPmHng0VtgC/2+PeswkYOFoVW2qucLQWNSbeB
         9QzUHCST62QIZhtw0u623txoOKimyPuCwtsTMPOajOJDn1y8zxzog6ZS4gA7hcTe10d3
         XCPRW1LvtGR9ywqaOhcyYcxvpYTP7J1zqMuTh6ftudSPMaWOyukfOCUAlhQLL3BeXspd
         2SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313148; x=1747917948;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hvIJwZs/S3AxTX77Jw4k9hnA93Hw8M8dn7JYGbX1Xg=;
        b=HwbL4p6LZdo+or7Muv6sGPOYBUOgiXLbIPDJ0ushga816q559DbbPo/9BUh4pNs4If
         gCckZD1P1zb3xvs1mfaDAOPEceps15sn+HlRTeMs3mijksEiBTSw/leAlX8R0HAYAs4G
         dlw46u9OT8EBzdRKL2FytpzPqADmi6iTXkzFA6De6ccSlXctwevwObOCVjtFH+jGz54h
         fM3spX614sh19chAO0XxZW0x+70uxpH/hAWK4u5mjiSyP/giVkdv6euKaiqdmWw0pQK/
         VUL47EbQ9plVMC11xfCyQUe8ATH9+sLwCEyA5IFtDYT7eFxP/wYxStW9w6TP+GY2UbCP
         itxg==
X-Gm-Message-State: AOJu0YyXslQ5itDDhCJ2vigIc6fUAai6M7qJCel5HnehgEOPGuXTBdma
	WJSmBFrUhxurxr0ZWjrUks5UytJ04+6uBxg9eD70vmqiGfeAZLBx8/zkmQ==
X-Gm-Gg: ASbGncvjHjWOhVZE9tpIMkOyNOExcxvZdV7hgvG+zjN99tGRQI9TYlZEP4IQJzfZ1Ka
	+zsGUewePdyJhCR7yDkGIrdpkv9qu2qjsqNDUYFEipMcurAWFjoQajTGlnaObGdV1t2xzJNCtib
	Kjp4NrgX9PA/xdqS+WUvjL8wk66oShAIEQxf+l0H2OkV7OVwJyFUxIlQ+qDjo5n9/GuyxMv8mIm
	1SWaF0QRr3qDLEZNL1HR7Owt3qoAXxt80pJOoXI1R8B4a3YYL9g2oeYW8inZYQLNC6fsUe+z6aZ
	FDJxfSj3Ktv5Lj3OfActxaVX+PvHfaPXyahH7J+n0Km2bDuZjzMm
X-Google-Smtp-Source: AGHT+IGs/UxKvymQfWlPNbby5Wf6ZBt1usLinmOAlZVbzR+uVSpoSMzb+hzfPLukskk8RQCXcF4KCw==
X-Received: by 2002:a05:6000:3105:b0:3a0:9f24:7749 with SMTP id ffacd0b85a97d-3a3537a0a41mr2030312f8f.36.1747313148501;
        Thu, 15 May 2025 05:45:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2961sm22632961f8f.45.2025.05.15.05.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:47 -0700 (PDT)
Message-Id: <8d1efe06d9ee7a00e8408e37deea88c469f835ea.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:33 +0000
Subject: [PATCH 08/14] push: defensive programming
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

CodeQL points out that `branch_get()` can return NULL values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 92d530e5c4df..db698c103424 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -90,7 +90,7 @@ static void refspec_append_mapped(struct refspec *refspec, const char *ref,
 	if (push_default == PUSH_DEFAULT_UPSTREAM &&
 	    skip_prefix(matched->name, "refs/heads/", &branch_name)) {
 		struct branch *branch = branch_get(branch_name);
-		if (branch->merge_nr == 1 && branch->merge[0]->src) {
+		if (branch && branch->merge_nr == 1 && branch->merge[0]->src) {
 			refspec_appendf(refspec, "%s:%s",
 					ref, branch->merge[0]->src);
 			return;
-- 
gitgitgadget

