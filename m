Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0981A76DE
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185372; cv=none; b=Lq7R7L8gImNRGheo1SJ0utzuoXuB8KE55B3tWQr1FgAU4okDYmIzz/CcFGQ4erckxRhZVJNWtpkOlnUOdo1g6vZCZXtkWLg6x2UGKLAEifuXdrT4pOWzRLUOFkMVP0HgBiynB0zEp586zrtxzOp5DshxTd8Bjlfj+W1IhVw21n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185372; c=relaxed/simple;
	bh=RwSw2n0VGxAinrFutu8sBIvZqSbF0hYODfcduSUKH/E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ORWJZ/E3JgSMJgSDGmF7To5TVDNZJQuEKwP0gNZ3TZtnUigyMW/rsxMybvomychPJqTVgCmmisrsrVbwUh3x9T0glVrREXBCTqdqyoiEyYHS1cTeedeOImmkNZRtof8Isa+oWa++UjX6EANCpLO9bJHb6NYy9xX7yXBYdmC+bpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4fMNbM3; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4fMNbM3"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so59115701fa.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727185368; x=1727790168; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvXWV3eIL+YO9QwpdbtM7lr2gqNwX9dCeM2yR1rvk+Y=;
        b=N4fMNbM3x6/nc0kTT0KNbm6+vHSZc5jUVM5fkWO8rER4u5Jyc6fRNz1Zf0hTaD3JzI
         /FadJdxceYmGskKHFO5PqXwknJnnWwRF1AMiXpjbafbpgA1SpHGRKIYkkqSS3RqVgMIU
         nS3Gf8mBCy6OyJOZI255x7io08nf5BhfRFIBRIqrmAj6G+umh08ZhyLmBA+bhUaRwvi9
         K7XNow4mrHicl17BAA3FwTuxUALBbgK4EO+AbWMRv+NeDZIS/b78aKcz5Tr4DmjWhpuY
         lLDLrLqf4R8CfTWXrWzLgEk339DynFeKzD2BNZUqVD2qSjMliGAdPNQ4VINhJb5Um/9W
         cu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185368; x=1727790168;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvXWV3eIL+YO9QwpdbtM7lr2gqNwX9dCeM2yR1rvk+Y=;
        b=pGBMFDaXsQu4rq0jTmmqhARglumEurk9Fx9ku3AhzGi1QpzLLxy+ifgyzIFUpuI5rW
         SfA9eG4G6mGlYa7C+qYbNZ70bfkMq/5a+dWVXSx3jYgp8giKNh0YgnEKfCqcJogOKPDm
         9BscOEf6/J8x6dPEQZ6yTYo06ahpTf3NziYtEV05W0Nscolk/lnL7e3b55sD7voWBao8
         S+bCYd/JFOxQMvD6JUqOC92PzTMmm+nFUBeXG3MPQ9ULIr6p40hRiCJtnoJxtUf3vHUA
         t4kZFofZ2rzSWko6fQPYL46gpxIeusl/LaugIHdq4ZNvCj/Z1wj2qBPathVnUhcuaGwS
         wqjA==
X-Gm-Message-State: AOJu0Yyb26nZY+7nKx9aJ8DJ9eARS74+2Zs4mF+IWdokXQ5FYI9feiy4
	1io6SOKTPe4XDgFTGv//uDNJLrC7jVTuRsYZFDV1jYr17hBhWsqaUBLp3Q==
X-Google-Smtp-Source: AGHT+IFgv1fCL7XiHzEMhSYQ3xxM449+sb4AuRfI2H3il/79GsTb88gepcn7tRRM4hQ8YgTslKqGyw==
X-Received: by 2002:a2e:74f:0:b0:2f6:4f17:aead with SMTP id 38308e7fff4ca-2f7cb2f9851mr66855701fa.21.1727185367863;
        Tue, 24 Sep 2024 06:42:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4968f4sm763566a12.27.2024.09.24.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:42:46 -0700 (PDT)
Message-Id: <1bf2b017dd3f9fd3d91687307fd519b24fc0f965.1727185364.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Sep 2024 13:42:42 +0000
Subject: [PATCH 2/4] annotate: remove usage of the_repository global
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Remove the the_repository with the repository argument that gets passed
down through the builtin function.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/annotate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/annotate.c b/builtin/annotate.c
index a99179fe4dd..ce3dfaafb28 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2006 Ryan Anderson
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "strvec.h"
@@ -12,7 +11,7 @@
 int cmd_annotate(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 struct repository *repo)
 {
 	struct strvec args = STRVEC_INIT;
 	int i;
@@ -23,5 +22,5 @@ int cmd_annotate(int argc,
 		strvec_push(&args, argv[i]);
 	}
 
-	return cmd_blame(args.nr, args.v, prefix, the_repository);
+	return cmd_blame(args.nr, args.v, prefix, repo);
 }
-- 
gitgitgadget

