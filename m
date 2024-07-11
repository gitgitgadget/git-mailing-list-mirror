Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C01A08DA
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739505; cv=none; b=PNF2kdlwbwwlw0QLk94pqc/muIIK7cV8c1eDNaSFr+p7pvzO8Hf5I+jfrh3p6zdh2Tr9m43oofOuAv7/xJ+oKE4yyEMEE5TVnlV51jN7/GtSCQAj54frMtX6AMZg0rRoRzAMvdoS5Kz2Ero6J1pkvvWwaX3MdCiw9xMmlOJ6Kr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739505; c=relaxed/simple;
	bh=X4hE+H8Z1mDrZwOiKzXK0l++3FlajlA8Z1GvV7ZqIAg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hj0oCCLgHbrAT0XeLjU0yRrUxQUdbeC0Y6WEtmb56/mBhDuQ4UXlgxOsD2eGjGe8Nr0+9/RIR9aatmIaqJhnWLPB9n/IcOnzv7BQTqtFrdC2Co6cwsTgoptX5PjC4WX/T7zH8N27GgtGqzbdWoCXSCU6Oa5a+KbyL6MmcTQ/J00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5I4q8lJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5I4q8lJ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3679df4cb4cso925398f8f.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720739502; x=1721344302; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCqo5imxUdi2MwtXOaJpLZGB4nbapaxdZRNCFgMicOY=;
        b=C5I4q8lJXbo+tQDGkPpIO1fnf1+6f6kpRget/cAOqI8U0fTLauRJ+dHOdjOGWKk7gS
         LchdG5c0MBvx3lWKWYGhRuWZUN7SKZX6VPYa2OVbQXdJYQlaoe9eo1nKiR848J5ZtyCM
         L7AwLvyYHfVZrUGjFxv3d2QdMm2PhTPDW6fISV4v6DhGfAkBNH0XYOOh32Z+pWLOFAyo
         hXVUHCPeyhTtomcMVjf8tm2OZJUvvH1U6aZwLpvhxm1lEXtkfaV0RVy9rLmHlFR1orrR
         RKs9Yxovxn4wdCpOgNWaqpdPDUMI+QoSj0ond5BzuN/jeWLKEs6wJVNVIArO5+quvHqW
         vUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720739502; x=1721344302;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCqo5imxUdi2MwtXOaJpLZGB4nbapaxdZRNCFgMicOY=;
        b=tRdOfESF9jW2l+nmUpDML9zpJPfklxOGOHPkUW2a8WFP+WfIY7yLd8BfwhtFSm62CL
         mFchUOghEmETnxy7+GH7CJOF8tljzyAHGHfeC8ApGLNkgCaGJLS4Lw5dKk8YGr7VHtNh
         LUi6453dhogR6I8veBkADKXI7MsitzLv//AnvWKleorRzK8/q4TNITBjhEnR7X9ZcL9N
         /IBGYAtLIS+JzS/5zE4jVoBzucdCikvS/pZYD6i3f7UM3TAZvPEABt1xof6MY0L+vmHi
         BvkQG1P0Q9v/IbS4QjYaByqwMLBVMF4DIJf5x1dW4CR5phuX7Lbw7IEkBmcDGQ+PPCWU
         oseg==
X-Gm-Message-State: AOJu0YwVsoTgzvAZkVzsI/NPUGAKzMisjHmB3BL9zVlJfZ2a40X/HwVI
	ozYKmUz9pQ7XJV57TwnMGRd5RrChO/o2aQtaTOUQmHhsCX3bJDgpZCwmbQ==
X-Google-Smtp-Source: AGHT+IFvBbH0iL0o6RPBq9lrTWh7wo3jJPthtLpBj8ne1hyQqeM28UdsGJ+8C7ed0qbRbedjtpJthw==
X-Received: by 2002:adf:e9c8:0:b0:35f:314a:229c with SMTP id ffacd0b85a97d-36804fd655bmr63760f8f.28.1720739502194;
        Thu, 11 Jul 2024 16:11:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab80asm8773628f8f.109.2024.07.11.16.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:11:41 -0700 (PDT)
Message-Id: <f04cfd91bd9a3a462294ea9125e72b3e6bb64865.1720739496.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
	<pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jul 2024 23:11:33 +0000
Subject: [PATCH v2 4/7] mingw(is_msys2_sh): handle forward slashes in the
 `sh.exe` path, too
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Whether the full path to the MSYS2 Bash is specified using backslashes
or forward slashes, in either case the command-line arguments need to be
quoted in the MSYS2-specific manner instead of using regular Win32
command-line quoting rules.

In preparation for `prepare_shell_cmd()` to use the full path to
`sh.exe` (with forward slashes for consistency), let's teach the
`is_msys2_sh()` function about this; Otherwise 5580.4 'clone with
backslashed path' would fail once `prepare_shell_cmd()` uses the full
path instead of merely `sh`.

This patch relies on the just-introduced fix where `fspathcmp()` handles
backslashes and forward slashes as equivalent on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6097b8f9e60..29d3f09768c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1546,7 +1546,7 @@ static int is_msys2_sh(const char *cmd)
 		return ret;
 	}
 
-	if (ends_with(cmd, "\\sh.exe")) {
+	if (ends_with(cmd, "\\sh.exe") || ends_with(cmd, "/sh.exe")) {
 		static char *sh;
 
 		if (!sh)
-- 
gitgitgadget

