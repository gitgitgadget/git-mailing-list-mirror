Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269079FD
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729143; cv=none; b=s2egRxctG3Vn3EKGCoQotGNkwMicnBpibkXY+sH3VvWL/YSdd+rM2PgjujtpMAXTWsnEC6KgcWi8omnR6HuSzXBhNWop8TgUFgNAZYS7bZ0RhR8GL9NAKjB1sszhcEcZi+96RoIMA392QcwWcUkOP8BWbXn7s4/ZoTu/81/aUaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729143; c=relaxed/simple;
	bh=esoWDlL3hIMObLFZ+LcjArkcVyZW/tVYysZlICCesi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REwmboribsezQP0Tym64vVGqBZoGBTlQ9742dlA9Nx9y309ig+Z5AgQgIP1I7s+ZECRKTvCULvuma2mVp2BVz6mHzFWXs/qwXPhFzWRg9S5Lu1JN3STM+pGC/adHEz+Whu+1iXZYXFOqO84POHF3qQbVuXZnfVjU8rANcHIKjYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BncQazOX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BncQazOX"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a850270e2so712389066b.0
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 06:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730729140; x=1731333940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uR7hPLBKV00pSLNEoGFKnOu2ftKf8a2eO5iD+U6EE0=;
        b=BncQazOX0sMoW2RYcm73kS+hDlSQYVaviK2dXmq0gnWaESyA2lQ2Nyc9Vqks6MCUPU
         LyI0MF8Zj+PTj5iG1R3UtVoS+IaNrWaswOOfe/NjPHXPm5KqKOxl7U/WSdSTtYzw8iS0
         8xso2qn/aQg17TbAdWDeW9OdAjUBACz7ZpGo3IgBY4LasVRqpJpYSHV/qUISOg4VNHGl
         J9W5fgBcRs0HTl6io6omb4n354uDb4ZQi8dVG13X1ksCHSF8fZZFoujYpFzoorrt++Ms
         1kwyPg3SWSb9znA4UnIeg4szMFZ+IqB4qXaX0p0/QW+uFu7UGLH7ybUNggJ+8rT5City
         errQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729140; x=1731333940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uR7hPLBKV00pSLNEoGFKnOu2ftKf8a2eO5iD+U6EE0=;
        b=KZJGXNMjLa2Iwz5Mkl9+2IvsOeliNYGpA8FtGZH5gsGR8IfngzjoTSGkhamwmUzRXC
         +CcBw1Cqd9YyVwsn9ZNpStdqmoQtryjyug2xpD7+HFm+8ZxQtiSNxsqXQJRG7yEQMSUR
         Bw7n0If2wW7RnRko5lCyB9VsClYoLZer5sJSkobofIrLUkVGnmR9RU7rWviNWlBz4ipW
         M6lCoPIrOGscJrxnlnPDd3Cl+QNzgndTBTXena7yjNc/WE8e/1q+Sf9wurHg+V8gdMA9
         0yGnuLAzIaIRikk0moa05YQU8vWxxn14sDL8xZkm5xKOIUSGc8WMad5J17O4EeCcW+LY
         ccKw==
X-Gm-Message-State: AOJu0Yzhlx0EVIc+rDK2e3o+5icG3MBd0qt1DcQ0yU3huSBmjk+A4IKT
	HjAPRO9/dA7oki9DW/fW8z/3Jq3OmNmRBhp/fFQhWo8cS81MXOBc+IqY1W2lLjQ=
X-Google-Smtp-Source: AGHT+IGB0IO+4K+rqRFPiCE2MJYOBqQiicp+iyB3ytgBdE6HTvGX8GtyeBrEvV7Iy3eUY5I3rrpCtg==
X-Received: by 2002:a17:906:7953:b0:a90:df6f:f086 with SMTP id a640c23a62f3a-a9e6553bec2mr1113566566b.11.1730729140479;
        Mon, 04 Nov 2024 06:05:40 -0800 (PST)
Received: from localhost.localdomain ([5.18.179.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e5516sm556327866b.107.2024.11.04.06.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:05:40 -0800 (PST)
From: Matthew Bystrin <dev.mbstr@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Idriss Fekir <mcsm224@gmail.com>,
	Lessley Dennington <lessleydennington@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 1/1] git: ignore paginate for commands with DELAY_PAGER_CONFIG
Date: Mon,  4 Nov 2024 17:05:36 +0300
Message-ID: <20241104140536.4970-2-dev.mbstr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104140536.4970-1-dev.mbstr@gmail.com>
References: <20241104140536.4970-1-dev.mbstr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling commands using editor in terminal with `--paginate` option break
things. For example `git --paginate config --edit`. Add extra check to
ignore paginate flag in case command have DELAY_PAGER_CONFIG set.

Signed-off-by: Matthew Bystrin <dev.mbstr@gmail.com>
---
 git.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index c2c1b8e22c..2b3b049f4a 100644
--- a/git.c
+++ b/git.c
@@ -464,11 +464,12 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	}
 	assert(!prefix || *prefix);
 	precompose_argv_prefix(argc, argv, NULL);
-	if (use_pager == -1 && run_setup &&
-		!(p->option & DELAY_PAGER_CONFIG))
+	if (use_pager == -1 && run_setup && !(p->option & DELAY_PAGER_CONFIG))
 		use_pager = check_pager_config(p->cmd);
 	if (use_pager == -1 && p->option & USE_PAGER)
 		use_pager = 1;
+	if (use_pager == 1 && (p->option & DELAY_PAGER_CONFIG))
+		use_pager = 0;
 	if (run_setup && startup_info->have_repository)
 		/* get_git_dir() may set up repo, avoid that */
 		trace_repo_setup();
-- 
2.43.0

