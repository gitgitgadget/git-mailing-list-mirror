Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D146BF
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 04:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738815619; cv=none; b=sGH76myYj4a0oOXBs1Nd8htcuRWLDe2qGDWiSYXibVAc3UWKAkSZractFZaCr/fzDFxrCAzSdyL/PaePjuBThY8OGgrZpbnkXNwJmOPpXQpjnf7xKVhHzefoS7T8aL39YHiTGdSSHl2YdiPgdjhnWBU0AOySewZK2KfI3wsnTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738815619; c=relaxed/simple;
	bh=7+WcGfyVwvMqaFlvdrqGc6yzUsRrD3X+juCMCpm+Fmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ski65K7yePVf0H5Mq3rN4SC+iPLnMpoLB1/2BUjzIwU9B6hdF2eyd3vsVeQVixLvRjt1jbPEx1Ct38jtVNwkf1vgwF9AgUbfG/WlTB13RGODyZwiBGtP2P3seevZmRnjw/GH8p2SC6GjP/y69wshjhVg81dVv1884OdwWtqijn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWqFWw4L; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWqFWw4L"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f200014f1so7071545ad.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 20:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738815617; x=1739420417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKVhAd5TjD8/sR9k/KctHt3j2JouUCBSFKxW82FEMJ8=;
        b=eWqFWw4LaTM3kcqVy0+s3Q65TXGKY4yReWm+e5M32GaUKUWhckAUT9u4uANi5sG/xZ
         OJWK/ojOs8De3DQlBek/0YP10mdtXFtOJnDjp1yHfOeLFYtsPjOvClEGLWFsJQcL+lDh
         VqFR5GkZpgz/YLDryGBtD7Ah1vs6cD3J/cdpbfKi0nKgJSBMutlEiPpGTdmy2ncm06KN
         GnEP+F0B9jQ536Z2vvHnDp+Ut+Utdw7wG5Op0YUUx4cSIVDbR6QLrI8rZm7YdhUjtaz8
         /+sa6rA5ntI0/innIXT+KR1YFDxTQYOVN8SgvQxmM1vtSJiTq8/pEqOYwrDnKphMot8w
         TxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738815617; x=1739420417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKVhAd5TjD8/sR9k/KctHt3j2JouUCBSFKxW82FEMJ8=;
        b=vITV62+qcaC6tjqeNr2WWk8ojFwmxwLcGXa6FWnPAa8YEzXnmUrcc7SPijJ0zBKy+m
         JJUybZ8Obvue3K2cK+YXIbYLEPA6CB0+ZfaCAnHF0T0tyA6pFQyB21WmRvKrC4cOMFmy
         bIfxagBpbtXbafuIsEu/lxo6oJBbldK9+DSO+fBhoeYUWkcB5MUyL8UOfUaaXo0mv3Wm
         d0s6C4qw5y1ZpEC1XXJmzcwrqenq8uIwlq7GqXDRQeml3CT8kEcr6XlLFk5zqVh72PGp
         VeF6zJNMVc7sUCiM/aQl2ky5uPl0QB6ormcLD6UtCHS5EYiSEy7Qxo13slnPnAuo5Ua9
         RXuw==
X-Gm-Message-State: AOJu0YzhW7L1N5rBrtB0QKhtwIk4kZkGD4ywKsMCHSUPKBx7FWUeAc+n
	oQIarQjxpAFFL5KShotLGdELGegCBM2NRQfmR+UiuEszsag14grwz1YQWw==
X-Gm-Gg: ASbGnctEbh2IlllH4Cr0dxU9M+U+1SeWc8SrBxru2RqljuQ0W/LvjXpmhhv35zILQbi
	Tdz9lXkkb6LUyh5l3Re75Okrn/otlVRh2TTdqmXnQzExSgHFWoCCsyky82czhicn628fJQkIfmz
	nPsOdTnO382ZAf4NjH4jm0XedO/lpIIy7ZlrJSqBmAHJsZS6eAv1xD2aE7ATr6D2c/4H1XSy7ds
	FJDDfu5YQmWRPhb4V8hCXQTT12g0YJ97Dklyurw64pRnDrvMIcZTqxq7257Zc//MOoV0MlTHobK
	1eEMQ2gCtoObIrxNliM19Abreg==
X-Google-Smtp-Source: AGHT+IGtMzCFQkgCCtrbvHfOGM+5gGURx0Fx8dcmZlrbr1ipwzmJb4gwSL7BvG8Czju6C7QGnQ7z/A==
X-Received: by 2002:a17:902:f642:b0:21c:1462:17ae with SMTP id d9443c01a7336-21f17df9bb7mr104750985ad.19.1738815617337;
        Wed, 05 Feb 2025 20:20:17 -0800 (PST)
Received: from localhost.localdomain ([172.56.121.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e63fsm2384045ad.41.2025.02.05.20.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 20:20:16 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 3/3] difftool: eliminate use of USE_THE_REPOSITORY_VARIABLE
Date: Wed,  5 Feb 2025 20:20:10 -0800
Message-ID: <20250206042010.865947-3-davvid@gmail.com>
X-Mailer: git-send-email 2.48.1.461.g612e419e04
In-Reply-To: <20250206042010.865947-1-davvid@gmail.com>
References: <20250206042010.865947-1-davvid@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the USE_THE_REPOSITORY_VARIABLE #define now that all
state is passed to each function from callers.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 81d733dfdf..41cd00066c 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -12,8 +12,6 @@
  * Copyright (C) 2016 Johannes Schindelin
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
 
 #include "abspath.h"
-- 
2.48.1.461.g612e419e04

