Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532CB676
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343474; cv=none; b=GcyfDGcWlqM2qbIPK/k4vDnleMtg2x82xSnli6E+XcrJ6C4vJa4siLfTk40KNMlF1t/yce7I3MMtZ6ZHfj79chcVqa0rTAR+TtxkMF7qvYaydXIvgBQ2yGrnDLNBs/rrc1HpDUjaLXMaZpxDwf7v5369bkGNK9cdpDdg4qZ4lcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343474; c=relaxed/simple;
	bh=gPQW1182XW+A/k/6EdV3XLrwR5Xatsjgvi4Z45ts/Es=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NPKtgBjBp83EjFtueLZNUSOcEszmL648B8lMGWIWYLTRWtqdRsil1YCrrLaQalaz71qAEYFI+KZYSgrqJyxk8LQKZWdwreR/0iGdaAlhvN5wNhdC4HpGZP6CIeK+/dIMvvyzCW4+DhHwayZp1UTjacnoGnISQm4LhDXhikDw7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoivdMOf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoivdMOf"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b2119da94so32001965e9.0
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343470; x=1714948270; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2J5CGbkoKSJ0e9rVf0Ut0etUwKNENSPNV4ltbSnlQo=;
        b=PoivdMOf5Y6yXmgw08wohKhcWCfLjGQhHrzjMQCW6UH2YIf4MFLpUAZRS0t5V/JnXw
         dXC+ziawyt64NF77io+KaXWDmx6SArmtcC3d3IVL+hnOGwDlKNBzNgyMcsE59sQP73ma
         9LwY/5P8FEubgMC8AsNLnnIT4gBPe6UUK7hRFHwr9J8a6tdhcvu6eowZfnnr78b1C03W
         IWIlLVSLi6WozikQtlI3Dsi98boDNTya4w1vhbWq8lh448VQbb/eYZUu7N0Ei42EjZly
         n+XQUkVvD0T+cbfTNv3xn9sG0ch7kTBitUzeVMjpazBTYVObJIKRj7PSc8UozwryzXJf
         XXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343470; x=1714948270;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2J5CGbkoKSJ0e9rVf0Ut0etUwKNENSPNV4ltbSnlQo=;
        b=m/Hxv7mRPI5yHX/mLIyGbgaULP+OQ0lMkf3crzBSNN8gXbC0mmNMJ9Bl1ZAtqF+F6O
         pPBMTw7+pn8Lizlz3SZd4A1MUvs1X7ZJo7WCEc3PlQqNxkKZIgjHI6eVLiZIYe322e7n
         QwVHDSiNakfhsWbhn+pNgtSQykWLMyE1BEMuzJ7gxXw5BGYL7sx9QtvHqlk8RTREgMhN
         DMD+XL+/6SSFOlRfbYciYOdBMIrSy2C8Y7vMth4TjNyiHZRp1b8lecZyLbiBjiwbG8jD
         w1ZP34rgjajMEr37hUh51KeN1q1Pw8n1Lx/cqyX91Pkyd0RBhjPGq0Uz+bMPFRr14ouQ
         EB9w==
X-Gm-Message-State: AOJu0YxVXSEa2h8c1jTmw2pACsbmCuo7cvpPKd437oxrjg/vr6cyJdRH
	SLnMM2IrnyQkzH6SR71Yu4gzKF/oPT+Df4BK5zwSs1ajoz+0XEYImwCYjw==
X-Google-Smtp-Source: AGHT+IH6yrUXoXi2ggxO4UhD9a2K+Zq8exM1+MAvykSnQXnOw+7zuKZ8EPYkKQB1FD2sjEtjGzXScw==
X-Received: by 2002:a05:600c:3508:b0:418:dbad:c57d with SMTP id h8-20020a05600c350800b00418dbadc57dmr5469817wmq.28.1714343470587;
        Sun, 28 Apr 2024 15:31:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b0041bf45c0665sm5324457wmq.15.2024.04.28.15.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:09 -0700 (PDT)
Message-Id: <a2acfdbc76c29f59c24c8a8b25076bde121efdf3.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:30:56 +0000
Subject: [PATCH 08/13] url-parse: define usage and options
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
Cc: Matheus Moreira <matheus.a.m.moreira@gmail.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Create the data structures expected by the git option parser.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 builtin/url-parse.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/builtin/url-parse.c b/builtin/url-parse.c
index 15923460a78..c6095b37ede 100644
--- a/builtin/url-parse.c
+++ b/builtin/url-parse.c
@@ -11,8 +11,22 @@
 
 #include "builtin.h"
 #include "gettext.h"
+#include "parse-options.h"
 #include "urlmatch.h"
 
+static const char * const builtin_url_parse_usage[] = {
+	N_("git url-parse [<options>] [--] <url>..."),
+	NULL
+};
+
+static char *component_arg = NULL;
+
+static struct option builtin_url_parse_options[] = {
+	OPT_STRING('c', "component", &component_arg, "<component>", \
+		N_("which URL component to extract")),
+	OPT_END(),
+};
+
 enum url_component {
 	URL_NONE = 0,
 	URL_PROTOCOL,
-- 
gitgitgadget

