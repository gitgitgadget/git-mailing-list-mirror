Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606E179B5
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709703863; cv=none; b=bp3uW4McaPLEKFUNPeZAAGqLVz5b+7xSra64sA3zMm+EycSY4fkJHboxjNLgkwZrj9cq5U6sIpW+vvT1GLKx7yl9DiRqRDLX7tNWHvrA9oiepoDAFPwOz7UbjgBmUEjWiK3QO7llWgm07DupJztACjjwr6n1mProh2/CmTrCtFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709703863; c=relaxed/simple;
	bh=0kE/Ig7ZbXYIzvxqPR0AvJympt4qG5icgy6YEWqO4XI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kYgNU6DjmA7aY0Q3/wHRcIADdSSdjwTPwu0GPAGJWKmDXl6S7hH/F2OgKHQbnxEAyGPktwra09B76jwfg99vhNueUFxwoWREYtYtcu5IInhB4jY35sAKou+sU31a5B3s3s8Yr9M7mMhRDmS0hQxX7oEoA6ASlNgyzO3lec2edsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCJZyUsT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCJZyUsT"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412e0feb40eso22433285e9.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 21:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709703859; x=1710308659; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pJ0oKFdT8Oy44kHn0T9YDt2NGNNtJteskApSllNkd0=;
        b=BCJZyUsTmuwOCPwyCs0XDEfKCNx8gvQ1L8RwPJedSEJqCH1106kUGKds919JmB8Gs/
         hBwuuWSqXTf5WGyMaD9+MHk5hicY2JG+4IzfVJPEByw2FHL5WocSWrOhlXL44L5Gzv9g
         0SXchB4eHAvnh3jSBGTqSBYiQiGPRRGN0wSIL5BTAATW6XXWYX213IWMaFAyGrzGzXI1
         iw1Kc5cKDBHgWeA6IWoPNUPlnD/zMDVQ8hJkOHf5K1Mn4ftIoHaPDx66It0EeoJ75Xe1
         di4IRDtiRm6nKesNk535XRL/21HqP1E77ndbRBJ2h6k9UtISiY4lKGi/oyydVSXQoa9M
         BHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709703859; x=1710308659;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pJ0oKFdT8Oy44kHn0T9YDt2NGNNtJteskApSllNkd0=;
        b=Ae1zxVvZvc0LaL7/oQqOHFUtTNAS3ypZwXYXKpMuBk0ofFAzVH1xa4n5OmRClEQEbb
         byM1+fzmh1RGoU1qN6ol3dSrt3tvexTxGp2+2wOssf6kcuMqoXxgoy1O5pCNk7CDUev/
         sdqdzDRJAmq8KkhyFwWoxCCpahNv/JgkiLf2WPN1wrRA8VWeikKZ3kpsJ719HJ4lZLV4
         SYKZmRHMzNzZ1kpDIK7F2CFEVaoRPowerqXyIRw5A6LCOKJ7LFD7CbQkKvnSvu1eliMc
         B5nxrKZB36sgPGI++nOoNna+0xn8S+EoKiW5Al8Ud+MsCLRqnSp5by1NaikZE6r1m6z2
         v/lw==
X-Gm-Message-State: AOJu0Yx0kb8wYSeM/Kq0zcvmt2k1gjoC4bJLYTn99DDfkELfkvERktou
	n8EErghJqded8qeDzd7Oi+4nwDByI39Pn6QukA/6toYBSxg04JQNbkgDDf8p
X-Google-Smtp-Source: AGHT+IGS/r8BA+JgRk71HTQP2LH+MZiErR4VkNKmb+/qPwYEJMpdWrp8/qPrA+hTJ7kilCTGbQZfQA==
X-Received: by 2002:a5d:5750:0:b0:33d:1145:8787 with SMTP id q16-20020a5d5750000000b0033d11458787mr9533528wrw.25.1709703859294;
        Tue, 05 Mar 2024 21:44:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bp22-20020a5d5a96000000b0033e56f97129sm632637wrb.32.2024.03.05.21.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 21:44:18 -0800 (PST)
Message-ID: <pull.1663.v4.git.git.1709703857881.gitgitgadget@gmail.com>
In-Reply-To: <pull.1663.v3.git.git.1708841439516.gitgitgadget@gmail.com>
References: <pull.1663.v3.git.git.1708841439516.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Mar 2024 05:44:17 +0000
Subject: [PATCH v4] build: support z/OS (OS/390).
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
Cc: Haritha D <Harithamma.D@ibm.com>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    rsbecker@nexbridge.com,
    Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

Introduced z/OS (OS/390) as a platform in config.mak.uname

Signed-off-by: Haritha D <harithamma.d@ibm.com>
---
    This PR enables a successful git build on z/OS.
    
    Introduced z/OS (OS/390) as a platform in config.mak.uname

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1663%2FHarithaIBM%2Fzos-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1663/HarithaIBM/zos-v4
Pull-Request: https://github.com/git/git/pull/1663

Range-diff vs v3:

 1:  2f1ad41bc14 ! 1:  cbc38a801e9 build: support z/OS (OS/390).
     @@ Metadata
       ## Commit message ##
          build: support z/OS (OS/390).
      
     -    Since the z/OS linker does not support searching dynamic libraries,
     -    and the current setting of CC_LD_DYNPATH results in a directory
     -    to be supplied to the link step with no option as the suffix,
     -    it causes a linker error because the z/OS LD linker
     -    does not accept directories as input.
     -    Therefore, -L option is added.
     -    Also introduced z/OS (OS/390) as a platform in config.mak.uname
     +    Introduced z/OS (OS/390) as a platform in config.mak.uname
      
          Signed-off-by: Haritha D <harithamma.d@ibm.com>
      
     @@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
       	SHELL_PATH = /usr/coreutils/bin/bash
       endif
      +ifeq ($(uname_S),OS/390)
     -+        NO_SYS_POLL_H = YesPlease
     -+        NO_STRCASESTR = YesPlease
     -+        NO_REGEX = YesPlease
     -+        NO_MMAP = YesPlease
     -+        NO_NSEC = YesPlease
     -+        NO_STRLCPY = YesPlease
     -+        NO_MEMMEM = YesPlease
     -+        NO_GECOS_IN_PWENT = YesPlease
     -+        HAVE_STRINGS_H = YesPlease
     -+       NEEDS_MODE_TRANSLATION = YesPlease
     ++	NO_SYS_POLL_H = YesPlease
     ++	NO_STRCASESTR = YesPlease
     ++	NO_REGEX = YesPlease
     ++	NO_MMAP = YesPlease
     ++	NO_NSEC = YesPlease
     ++	NO_STRLCPY = YesPlease
     ++	NO_MEMMEM = YesPlease
     ++	NO_GECOS_IN_PWENT = YesPlease
     ++	HAVE_STRINGS_H = YesPlease
     ++	NEEDS_MODE_TRANSLATION = YesPlease
      +endif
       ifeq ($(uname_S),MINGW)
       	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)


 config.mak.uname | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index dacc95172dc..d0dcca2ec55 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -638,6 +638,18 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
 	SHELL_PATH = /usr/coreutils/bin/bash
 endif
+ifeq ($(uname_S),OS/390)
+	NO_SYS_POLL_H = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_REGEX = YesPlease
+	NO_MMAP = YesPlease
+	NO_NSEC = YesPlease
+	NO_STRLCPY = YesPlease
+	NO_MEMMEM = YesPlease
+	NO_GECOS_IN_PWENT = YesPlease
+	HAVE_STRINGS_H = YesPlease
+	NEEDS_MODE_TRANSLATION = YesPlease
+endif
 ifeq ($(uname_S),MINGW)
 	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
 		$(error "Building with MSys is no longer supported")

base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
-- 
gitgitgadget
