Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E713E8B2
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822227; cv=none; b=h/JNLyfQpCTHLzNlPaxuNMdt21Q3+8fGIjok8MSW9dI0Vi2+I04k/bK86o99fOz18NPfOPczNDcmrszcgXvG6boQECg4Ec30OmcEeCGaTJQGH+ATCj04a3czVHYCpSn+uCl0X17g2OI5JM2n9OsQCkmS+4AXTsNDt3jotuZOxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822227; c=relaxed/simple;
	bh=dv86RoM3q19DhenLaBv2QX3QHbbudDevx4d6dQFfQ7Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=jni81806dZSkHavwGJsI28lYJCjAI1xL7dE1xlUrm8V9bxrDIdiRxrG9k2emEPAc1cOTzCd9hyQk9/KR3EOy2qwE2+NzLp/VcU6483qAPOS8l3Hu0J5cv6AsRwgT/GHCIk879QTOn8Oe6J6ySyuDxr8wSkz7b2UarXZNaSff6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kh91Jo4r; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh91Jo4r"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-417d14b39feso3977995e9.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712822224; x=1713427024; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jVJub8svHObD+hMUVtH/vcCuupZK3zt8HM8LjPSclc=;
        b=kh91Jo4rHzFtJwpqxvVCVUdWYtRzA1AkQmXWW8AccnadCSoowIinfbA4Dv3P7LT/Wl
         QGMgsjbQoRI62E3f3Q1xX0YEkq0bQXkEFD7JGaEf9bM03tBLTUr5m5E7cFVib8ZStjXj
         dsqoGovHgFtb3JxkPG+ReOHU0wJnBdVfgLKvcqptwlTdHDajxhozHlfik3nXxeg/8dlx
         6rI+7h9MvxndixlkYhOwve6pYzGmHKTvNyaQ+oH0kQtozdyGI5+uDbLemaPMc/UoPx0j
         TOaqaaxJz1uXVcYpa4j6lomX7K9fRYxY8q1NN7fGla1TYInVMoz1c6IFQdYuLIOyPsnn
         ubtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712822224; x=1713427024;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jVJub8svHObD+hMUVtH/vcCuupZK3zt8HM8LjPSclc=;
        b=G+xdt46jl4bphEUivWdRhf+KPWOQ8urrx18Nq4+5KgRzGrfRc37ARDkd47FG1VO7G/
         kZtxfcliVHjijHQTPqwNGcwhYuVcrrJTGAn8/mGApWfvzHrdw+J+6UmY7skR9UI7C6yr
         nYH+TrRIw0xuQCwXW3u5Uxm4oWX+JFz5jzAX3MB5pokP5Kl05Ge3dHV5ZsEvFm/Rt/J6
         N+0G3ElKIKuXEvgKeCueWGHLN4NJ9mdnay7CpTScgY9vwhThC1qh21nfA8TX3dG7IZNS
         1D3oYaoP/mnrzeNVUueqhyq0FeK5fdwu9IO7xcRRlgQ4iOK7+Yzdcbj4wsI4EP5XCLYI
         nQLQ==
X-Gm-Message-State: AOJu0YxFGuvhDZnO7GjCD6EFgXi6o4dEuaS0Dlb1dpXqqIG2xjNG3mdH
	/Te2Hze3cyXOtLbACT2iDEBtVZzjwL8aI7MT2Ibl3+WJ7hCq01BAxV2G5g==
X-Google-Smtp-Source: AGHT+IHQh5MtyukefhAdJM4mRmC/3Mv/BLLrpi6Z/UML/7Fo4n0oiBt93G1WYguo2ebYgu3ZqgR+Bg==
X-Received: by 2002:a05:600c:3b0f:b0:416:a51e:23bf with SMTP id m15-20020a05600c3b0f00b00416a51e23bfmr3758265wms.3.1712822223774;
        Thu, 11 Apr 2024 00:57:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b00417e326ff3bsm313556wmb.36.2024.04.11.00.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:57:03 -0700 (PDT)
Message-Id: <28a5625f32cca6ef134a385fe9ba66962c40100f.1712822221.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1669.v2.git.git.1712822221.gitgitgadget@gmail.com>
References: <pull.1669.git.git.1707479467028.gitgitgadget@gmail.com>
	<pull.1669.v2.git.git.1712822221.gitgitgadget@gmail.com>
From: "=?UTF-8?q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?=
 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 07:57:00 +0000
Subject: [PATCH v2 1/2] doc: git.txt-Fix inconsistency param description
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?= <ttdlyu@163.com>,
    =?UTF-8?q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?=
 <ttdlyu@163.com>

From: =?UTF-8?q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?=
 <ttdlyu@163.com>

Signed-off-by: 秃头灯笼鱼 <ttdlyu@163.com>
---
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0d25224c969..eee277495bd 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
-    [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
+    [--git-dir=<path>] [--work-tree=<path>] [--namespace=<path>]
     [--config-env=<name>=<envvar>] <command> [<args>]
 
 DESCRIPTION
-- 
gitgitgadget

