Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184D19440
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLaB48M9"
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34299FA
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:46 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d12b3b479so618916d6.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697744385; x=1698349185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAkoeCjTOE+20TgEESJjQDJvFdoOVG8zsbfAyTj65zw=;
        b=aLaB48M9iKCb6BHko0xdUp5DFUYwdSP929GqJuWwlIsl1M36j1JGXGRar9YYmHDP3y
         jS0dUxGxqAEq+PjOz26YtPeBWgTjJgJ2LaZcm1qoofcyoUcb5LG05xFxUtzVn32aFXt4
         aWRvVTnPMOzqGCy5OSct/GdMyMbM33d0Fls6XRGyByVNMC7ml0v3evXcnjdLcjJus3YD
         TPKZMJQa6PMYRJe8tefQYxaoxEn+/wwFSccP8n0YTuDkLg+5d3u7gvvEdvVBaZhCKFJM
         nDTahJ7mtabdhuPoIvQo85IxO4lkGxH/zFBuVqd4WUuXDa4T5TCnU9tO5xqbQqJeq0jg
         yvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697744385; x=1698349185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAkoeCjTOE+20TgEESJjQDJvFdoOVG8zsbfAyTj65zw=;
        b=poCPO4hE3O5rkD/ElUk247iQeqvd8aIV4kHRaf6EnmD7NVWht6K2Td1T9Vlr8NJ8dH
         bBpDPzo4Us86yt0bL4jd4SCKm5XToLwUV+1ymuXFpLZrmmDfci7+HCx/rTL/8CdpCdNN
         xQwEB+nBTOlgZJU05mPeI2pEKDLLy/AtejaNP/sRkHQVNlqAsw+5diH818KT4vVO7F7n
         8Oz1cXupKvXKXyDIOZy/4WL3u3EADMy7dpOe3LdyAEaYeEp8NoQFiBVA/PnKYPOzO7e8
         1LPPoYk3JrJhutqckWv3kcpN3nnrvHQG9Y40zRFrbSWoOLBtDaXnYhy8pCtVWgfIkyPS
         KDwQ==
X-Gm-Message-State: AOJu0YzH2lp8UyDLS67TZwHf6VqnnXzj7vJKOsSpfWrMuu7OHOiIJ2KW
	OLO4RONO07fIp++9AVeLkxXTxCdW1Es=
X-Google-Smtp-Source: AGHT+IHb+FvdRB/hr7sK9wwQA07Hk7xpZyDaTAIbvJZMd6nnXUR19DWnKwesQUGxn6rZg0WB+vly9w==
X-Received: by 2002:a0c:a9d7:0:b0:66d:3548:9c1a with SMTP id c23-20020a0ca9d7000000b0066d35489c1amr3125113qvb.54.1697744385239;
        Thu, 19 Oct 2023 12:39:45 -0700 (PDT)
Received: from u.ad.analog.com (cpc99472-lich12-2-0-cust1752.3-2.cable.virginm.net. [80.2.214.217])
        by smtp.gmail.com with ESMTPSA id ph5-20020a0562144a4500b0066d0ab215b5sm99940qvb.13.2023.10.19.12.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:39:44 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH 2/7] log: use designated inits for decoration_colors
Date: Thu, 19 Oct 2023 20:39:06 +0100
Message-ID: <20231019193911.1669705-3-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231003205442.22963-1-andy.koppe@gmail.com>
References: <20231003205442.22963-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use designated initializers instead of comments to denote the slots in
the decoration_colors array for holding color settings, to reduce the
likelihood of mistakes when extending the array.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 log-tree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 504da6b519e..8bdf889f022 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -34,13 +34,13 @@ static int decoration_loaded;
 static int decoration_flags;
 
 static char decoration_colors[][COLOR_MAXLEN] = {
-	GIT_COLOR_RESET,
-	GIT_COLOR_BOLD_GREEN,	/* REF_LOCAL */
-	GIT_COLOR_BOLD_RED,	/* REF_REMOTE */
-	GIT_COLOR_BOLD_YELLOW,	/* REF_TAG */
-	GIT_COLOR_BOLD_MAGENTA,	/* REF_STASH */
-	GIT_COLOR_BOLD_CYAN,	/* REF_HEAD */
-	GIT_COLOR_BOLD_BLUE,	/* GRAFTED */
+	[DECORATION_NONE]	= GIT_COLOR_RESET,
+	[DECORATION_REF_LOCAL]	= GIT_COLOR_BOLD_GREEN,
+	[DECORATION_REF_REMOTE]	= GIT_COLOR_BOLD_RED,
+	[DECORATION_REF_TAG]	= GIT_COLOR_BOLD_YELLOW,
+	[DECORATION_REF_STASH]	= GIT_COLOR_BOLD_MAGENTA,
+	[DECORATION_REF_HEAD]	= GIT_COLOR_BOLD_CYAN,
+	[DECORATION_GRAFTED]	= GIT_COLOR_BOLD_BLUE,
 };
 
 static const char *color_decorate_slots[] = {
-- 
2.42.GIT

