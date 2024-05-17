Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD412A1D2
	for <git@vger.kernel.org>; Fri, 17 May 2024 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715987764; cv=none; b=CO5Op1GpmR5vQH7Ws2g/A/sF6+PYysmmL/V2yQVfFMhEvcGVG5pP6pPauYHhqw9CXncVhmjztli85UFwf4j1+UrxLxF2J7nOEvzamSIhLC+8c9CxebgbxTOxvWJM6cr/PBkmZ6HARRUWUzIM+9zzHk0go0yGdQNnHw4R4DGTGgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715987764; c=relaxed/simple;
	bh=g3mcr9oNJA2YWVKdqdh6JD9CfQ682VkR8dwEEitGi70=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bZCjRT78JfGI95aKfnC2NJcJSKjSEtrl66ikatvSDDOGGrJQQEfNuke1oOjYgFS4BVxDsRkDB4qiEAJuvCVj9NZse1/mjSkUecEN5yhXlAWzD/2a7c6ERyaCJFsEmD64KRI/uS3ZqGHt70cvD26DUcsplnZXkvOejYlOnWyiLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkrtW+0/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkrtW+0/"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354b722fe81so434974f8f.3
        for <git@vger.kernel.org>; Fri, 17 May 2024 16:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715987760; x=1716592560; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3TcY6SNGMN9D4Tqo4JhzJB1VLG5CDwDx+Tm37TVHyE=;
        b=IkrtW+0/F8PWJe/OfeNOoJGDKKJ+DDQP9wJRVbrn19mpEqMo33zumNqf3NXRvIZSA/
         btImjwiQ+dy/ZSJNPuRWQLRGk+4x+wIpYEINPZdUMAC0UdNJrUBjbAmmVeWdbLUsfU3C
         xttg9b9GYOyacaWRiqcu8/Y0z5O1YVMC8hT8NvzfyuEgvcWj2hTaPmokfnTECYodHiIf
         YU6L3x4zsogFEQlRGXnk3/q9u9SL80dDrZXNuu/9Tr06Mudi/VQWP9AF/M01KTAJykK1
         4nGiN7vYXWYXwP5gbzSOidjzJgNBGhLPJTrVYXftKLl6eMQzFnljiHSHBB8q6EuMDyno
         B79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715987760; x=1716592560;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3TcY6SNGMN9D4Tqo4JhzJB1VLG5CDwDx+Tm37TVHyE=;
        b=Hf3r9nRTeGmtz5G3Nb3AgTqSY+Pd3Bk2rzmxdvjPkB4hP9ojT6nLyWwS24SOIYc51e
         pnB1VTYooM3ejSPTGow8HRaStPGjzaYZEp4MNF/I4YIgxcsPNe15VlAiWIPA/uby4Lu2
         SyzQFZAxYxRM5pOfqYaFrP5vAaC78+PnPV+ONIPnE7VBTCeJs+Uzd/OYUcvGXcwi8fZn
         zFqNO4aQwdkJfplrEk97qFwSZGyrG9RlDeAvMLXiThFJbndGATHMOFfDbEX2QmK+6nhW
         j5lLXSCm/cqRWTATV5qMONm60VJHKpSboFcWRvbVrM28WMXN2mzlHNpL2yxrpLYti2F2
         XUKA==
X-Gm-Message-State: AOJu0YwieQjLKFWHXsEotrqDYH/q1WoIDo3tzSk2s0lnYDx4X+ivjaT8
	xsXXPl5sDRY01qadiamxLyv60Q+dIHtoByOgSWrfffR1NKQO6wlAXJxbAA==
X-Google-Smtp-Source: AGHT+IFq2ppLGqWlaRGCSWdtKLFfOH2jA0LvCmTk2e1lwLyTU1BaL98LKLP7gwe9iv4K4tuvDg/Rqg==
X-Received: by 2002:a05:6000:1010:b0:351:d383:631e with SMTP id ffacd0b85a97d-351d3836377mr5139480f8f.24.1715987760417;
        Fri, 17 May 2024 16:16:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm22522615f8f.66.2024.05.17.16.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 16:16:00 -0700 (PDT)
Message-Id: <961dfc35f426388d660cca4e92f43e169819886a.1715987756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 23:15:50 +0000
Subject: [PATCH 2/8] init: use the correct path of the templates directory
 again
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

In df93e407f06 (init: refactor the template directory discovery into its
own function, 2024-03-29), I refactored the way the templates directory
is discovered.

The refactoring was faithful, but missed a reference in the `Makefile`
where the `DEFAULT_GIT_TEMPLATE_DIR` constant is defined. As a
consequence, Git v2.45.1 and friends will always use the hard-coded path
`/usr/share/git-core/templates`.

Let's fix that by defining the `DEFAULT_GIT_TEMPLATE_DIR` when building
`setup.o`, where that constant is actually used.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 093829ae283..4b1502ba2c6 100644
--- a/Makefile
+++ b/Makefile
@@ -2751,7 +2751,7 @@ exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
 	'-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"'
 
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
-builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
+setup.sp setup.s setup.o: EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
 config.sp config.s config.o: GIT-PREFIX
-- 
gitgitgadget

