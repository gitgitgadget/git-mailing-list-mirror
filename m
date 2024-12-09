Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E31145B18
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763083; cv=none; b=Mm5dsOXI4ekhwf1KKogplWrgJZNcgWnwC4wJW7aOpD+iGlsQnOine4urflvfQZb9nbm1PXB6NfQY5QEHJQdi1tItAWG693thFz3iYLzfg5iBxRBC1hadGapprbidHiBfN/vVAEMwQ5yNIMm6tyxuIrJrYxBmrRS0EtL5Jl9uSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763083; c=relaxed/simple;
	bh=1OQ3GAwFz7FYXr8pVPz1MKEZeg0MI469s8Ls6Uzc2+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WackUTpczDRvyEneAsJ6eL8Ar+yS1swAARE1T21JpGkdMgDat0VaCOk/nw17yxFyg8GfnYTZAxBepjQ+6ZrKCAYAc6igx4Gpd1GKl6tsKdr8Fz3RCFV7FTCRh03ZcaEq1e0gWhXytPyQwWeGO2G21NpI4ILvj3JGHcmPyBLVVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr5gChzw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr5gChzw"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3cd821c60so269570a12.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 08:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763079; x=1734367879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV0fTLWmm6YG6cgWUVjxRbRAxVrlwq00vVpaHsKjHEk=;
        b=Mr5gChzwuzV7UpA5gzjBgXBORkHZIFm+VUQKlgtXmEM73ngT/jDNh/LY3XhFFo9+PK
         5opJLl7Mk8sq9MmmeLQhz1e6QHXBdXXXJm4XIvz+Ny+mi6uIKPa6XYjw+Cg49MV5UX4p
         dnTxzuKRl6hwSyV7m5/ZbXGIw1u7hgCemV6CvHC16Qq40Pk4EaXDPiAK6yC6JtQz0yLL
         L1KHSKdHD/fgyLv8kiGBEWlVgLNc38e/XwJ7tChKQdfBwHe8apcwVFcu/4OT993B6C/L
         DTl77fbJ4s+sxGZ1Zrdt36/o8MGOa3SMEMtWegHQ+IzIkNd03R5YfHdT2N+7YW/yWkCr
         Daiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763079; x=1734367879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV0fTLWmm6YG6cgWUVjxRbRAxVrlwq00vVpaHsKjHEk=;
        b=goFJhDIzFb46ie+sItRe5rFFKfC+OTmTLeTzGxg4WoQcDRcMvfJevV4y1VSIgLICah
         x5bNOKpEpQdbJElrpfSXjGb9aKcdChISyfjT/DFYKVC4JQI5sbCLwwMI9xUEuHctPq9D
         DPsb/dL2MPKRPScvma7u2Gi7psWqKQ/3TDSR92rSMO3nrtqKoTEtyVeQW9Zsts4P/Tod
         ygcVkQfAz824wbP85SLdpM4izIOKhLJ2MoX2UpNyZ3HV6HPW9Q9n67+goCMXZ093U2Yp
         C57PmG7KomroQvfY2Wd8iqBB37li8G86lDWrG3cfzRmaf8B/rA1/2KGD8SzwwaXpoW+9
         tkKg==
X-Gm-Message-State: AOJu0YzdFtyahAzv+hNdTYucyq99HVLhrNL4zPq6PHttVSTGO5R7yRi5
	LpT+a8+oiLjGmfUvWvTXtYjWswKw/6GhI+wCCQ5qv1wJCDUzrZsKipOr4+zt
X-Gm-Gg: ASbGncufYRLB0cdEBD0/+jmz//8Rd2kp6kis+L8E0RPeTE0S9QDOAHCMxm+8SfLgkch
	/YjdtRJnkUQuOeiIMAb7C1rjmPx/EljaZmLy23VnwoyMvjJxw/YTnmwHadMSwfgJlPfk0FEuYUm
	QwYXaQS7nfaQr+mZF2TFVDsHeRF58Vz9F29zEv18kL9cDemmc4/tCvHwbE/6JRQQ1YO+Olj386e
	F0vg7VwMWmpDF8QrQJm12fKZ6E5YYKoLHk92ZhVzo2H+bEryZ0lj838dGI=
X-Google-Smtp-Source: AGHT+IGFT6oMOQ+TR863435svR6oU3idG91IW6LduLfUi8wvsRcSqmnGq6toUB/4YRCnKRzcWThq/w==
X-Received: by 2002:a17:907:948f:b0:a9e:80ed:5cc6 with SMTP id a640c23a62f3a-aa69f27f1f0mr12729966b.13.1733763079100;
        Mon, 09 Dec 2024 08:51:19 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474e27sm300539766b.102.2024.12.09.08.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:51:18 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v2 1/8] git-submodule.sh: make some variables boolean
Date: Mon,  9 Dec 2024 18:50:02 +0200
Message-Id: <20241209165009.40653-2-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241209165009.40653-1-royeldar0@gmail.com>
References: <20241207135201.2536-1-royeldar0@gmail.com>
 <20241209165009.40653-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-submodule.sh parses various options and switches, it sets some
variables to values; in particular, every switch that is passed causes a
corresponding variable to be set to 1, which then affects the options
given to git-submodule--helper.

Some variables are assigned "$1", although there is no reason for it;
this was actually noticed in 757d092 for the "$cached" variable.

Make some variables boolean, in order to increase consistency throughout
the script and reduce possible confusion.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 03c5a220a2..107011f613 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -78,7 +78,7 @@ cmd_add()
 			shift
 			;;
 		-f | --force)
-			force=$1
+			force=1
 			;;
 		-q|--quiet)
 			quiet=1
@@ -231,7 +231,7 @@ cmd_deinit()
 	do
 		case "$1" in
 		-f|--force)
-			force=$1
+			force=1
 			;;
 		-q|--quiet)
 			quiet=1
@@ -294,7 +294,7 @@ cmd_update()
 			nofetch=1
 			;;
 		-f|--force)
-			force=$1
+			force=1
 			;;
 		-r|--rebase)
 			rebase=1
@@ -500,10 +500,10 @@ cmd_summary() {
 			cached=1
 			;;
 		--files)
-			files="$1"
+			files=1
 			;;
 		--for-status)
-			for_status="$1"
+			for_status=1
 			;;
 		-n|--summary-limit)
 			summary_limit="$2"
-- 
2.30.2

