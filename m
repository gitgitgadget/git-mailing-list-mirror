Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E1B676
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343477; cv=none; b=s5SLfJvw5H5tF5a18eQSoYHYmE4lzFpT6ITNliqkvZ+gnaJvgs6b0m3mqqzJ+zu9MLaxqOGuNt/yb8gtzBKwlZ/MVBGJ4GasW2iGoAgeHC1e2ZKzJkhBnkJbfhHSl2VGXzXazlTuajPZsyU3Isb1av833HLNYEdEUsGT1xetl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343477; c=relaxed/simple;
	bh=QEYhxqdV06ATiUnQf2zTq+U70dw8TJKii5arvMzgZIY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QpvRzzPgVG5hmfYFfE0tk9KN1ebDnivMlhGeUoqmgUH4RY3TX5hPPNzoFHPuTftC9H5RwjRAc2ZYa6ciW/nzh/Wklat+ppaeyx2oXecEpoEvn/8Ml1yXptNYaI78gPPfjWekUzrW2KEGPXJnkW77LpYjqXX7c1+QcZAoOkgZ1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eY7l/Z8t; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY7l/Z8t"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e9so17789175e9.3
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343474; x=1714948274; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgsaR/idZFjMkK+l/iXfIWqvhrgquolw9lHdh+k4HVg=;
        b=eY7l/Z8tHK2EZZpfi7iR/Tlwb+70WzfUe/qAzzh5Lh3taoSYBArpIOZqKng7XAO95r
         FFGTd9dylpxuPtyrlY4vkkpY2E+rBspLULoGJTW0NDS5HEoxZ06LsW7+jK3jheVOQb3y
         KikmV0xtPGoi+iiQmm1qKcf9VmGbqI13gDGAQBa9KfsdzOckfgwG0GJKZFxMu49n0Fbh
         p7RVtVjVf3ug3I40BkgglceSm2pk/VqQCxjE3c6n9v80TJb+qHciOZA2VDtdOMn451VB
         7LiCIYYHRDHsDmjZb/JmDb2Bu/IG4KbHiJG0GJ9CbdCK5eCM+/iwibWb9Bvo5hpsTPGU
         +baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343474; x=1714948274;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgsaR/idZFjMkK+l/iXfIWqvhrgquolw9lHdh+k4HVg=;
        b=ZoCvxGt54vnqSc0+EBliIxs51wVbJc5Whx1JHnN9mPu+eFBFted22YZ1jkl3ECHYva
         4J7/IwYhGmd1+Hre8L9Xp5mRqZIPtaPgEkvyFPDO5Q5dmuw7cXhHOPp+A4mslYX8/43S
         hmbON3MBQCSP+JCrq939rjSh7VdMKTAT4Ve6ixcB+G/Q50s1mxTSRSbe6miO7Rbgcrq/
         tD9o7c0TGXqvxJqNCeZBm1dxWMSIcgjlpV6zAMTbPLwGSJ87NjoiZOjO2spGg48UAYnZ
         pYm9k0ou9gvYnHCfNcPW09mRmfPrENifCOEAbRc5MG0Nxup5UpZ6uYGNuUsprIhIw+Tk
         K2JA==
X-Gm-Message-State: AOJu0YxkS70dUKyR57iV5g9+8WUuYApOoOiEzM2k8cjPGEPg8SjgNoGp
	nYmXxdMia4BwdjkkChmFwCy8S1QOX2Xyozp8XWdRMTYSjAckZ01aaTCFcw==
X-Google-Smtp-Source: AGHT+IFirLY1romzUbho7mMFbFaZxv8DJb+BsaDYw9I9y0MQKg42iGPKLs3E49xDDqBZ3Cpbm+nvFw==
X-Received: by 2002:a05:600c:3ba1:b0:41c:97e:20b9 with SMTP id n33-20020a05600c3ba100b0041c097e20b9mr2538813wms.14.1714343473688;
        Sun, 28 Apr 2024 15:31:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b00418d68df226sm39997172wmq.0.2024.04.28.15.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:13 -0700 (PDT)
Message-Id: <4e93509c80f944b2d10c6d62853cecb78aa6a464.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:30:59 +0000
Subject: [PATCH 11/13] url-parse: output URL components selected by user
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

Parse the specified git URL component from each of the given git URLs
and print them to standard output, one per line.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 builtin/url-parse.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/builtin/url-parse.c b/builtin/url-parse.c
index ab996eadf38..6c1a8676bad 100644
--- a/builtin/url-parse.c
+++ b/builtin/url-parse.c
@@ -102,6 +102,8 @@ static char *extract(enum url_component component, struct url_info *info)
 int cmd_url_parse(int argc, const char **argv, const char *prefix)
 {
 	struct url_info info;
+	enum url_component selected = URL_NONE;
+	char *extracted;
 	int i;
 
 	argc = parse_options(argc, argv, prefix,
@@ -109,8 +111,20 @@ int cmd_url_parse(int argc, const char **argv, const char *prefix)
 		builtin_url_parse_usage,
 		0);
 
+	if (component_arg)
+		selected = get_component_or_die(component_arg);
+
 	for (i = 0; i < argc; ++i) {
 		parse_or_die(argv[i], &info);
+
+		if (selected != URL_NONE) {
+			extracted = extract(selected, &info);
+			if (extracted) {
+				puts(extracted);
+				free(extracted);
+			}
+		}
+
 		free(info.url);
 	}
 
-- 
gitgitgadget

