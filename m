Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB730299A8F
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313157; cv=none; b=leMxVVVZeAJRnfmcCvHngIVC1th2Y/a9sYLhiktT1vyMbgQOM7zISWtKeslYp4N2QQqAAurAwEvbl23FJlcKJ/xFfr78Ej50gv0XfoaSUNcFurwwRDVaxYyCVP8cUcPza1msI8KHF9O4mrirrD3PPY5PCyZp5mFFYTU1C4qQYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313157; c=relaxed/simple;
	bh=s09d307bFvq5r9zY7L17mqJ7U0mLiV6+CK3PvjXPM4k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a+fjTBMbGfX/TIAealD0yas/HUQ2iWtcHUb3uMckNECGCX2U5hI7NZDmwVlkXbg2c+8wJQUd5ZoI0CJ8Yx1Ur6Jfu5o+ny1/ngPaNEX66r84yYpKOUG7EbpGbLPROHptprjv3XJCPb3nnFXq2US2RwJsViBrJeRPEAs84nIajDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llO72F+W; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llO72F+W"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-441c99459e9so5828935e9.3
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313153; x=1747917953; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo+HGu8VQ+HkwVUWccfXpE47X1RTXiuZPP1JqXZ3gBY=;
        b=llO72F+W6wAwkgLWv/F7mCZwILv0eIKrl7b504crNlvWPtX4iXepnqZ5LnFQNRH7B+
         ykoLYe/pw2F2nDcTwTdnk5W0xZGdWkx1Z7fgnxOgVg7gBeyK0p4BmlaE8UqSdco6jTdl
         1qkDUhRq4BgOaI7Cz4MEmaa4UJYBIx66hlWhNBzNPUvzxieroPgHzvVGMm/Cn6jguZ7q
         PoGGqL17G4GPmtj/WTDp/8I50anTn0y/cID1yxzcpzDCu9LgNWhDIzrdFgQKzIVb9rA4
         GoyysJJ5nsZ9kSCh8GeMyqlssGchpdygK5slrA517jgHP1YTKy9f/ckTluzHmBr7rItg
         EQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313153; x=1747917953;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zo+HGu8VQ+HkwVUWccfXpE47X1RTXiuZPP1JqXZ3gBY=;
        b=KfzwyH0lbfpH+xClmBH/AUd/PtCoKjoKIffImTct/KsuMfl6hVSTHbC2gdAVUv53qj
         w3cRBurv7OIFplglQMK6nJaBBlD2iZIM+TugS8I0A4y/YltWuXLEYBMZ8TdNxj32YVI7
         Oa6WsIqb/M2up8zUHh/0h0jwvRgTJCkc+NiMnA1nSf5UQ4HgP/AaaapLpWD/QBKcJawS
         ZJywPDOsyLjgJTMBZnWcJwXYrz2V7ONuner8pI5lq4EuvonR8dpEX9WZKGpCPLB3KO6Q
         gDQlFnbqEdmKr2raNrdCbR+Me3gi8MQcP5N8f4FN8zVFtsVZWPCRdW4afuzrLkIHQ22G
         Wc6w==
X-Gm-Message-State: AOJu0YwGI7tgx9jpvd1hwJCMP4AwIz0XLX8pQosuPz1Bq6mz/ixUAzLO
	PF7Zn0KtvGUtC/xvLE29hhztf7rWOqt5HUkQSD+1jCIi3q6YIPx+M90qOg==
X-Gm-Gg: ASbGnctVLFh06ITB1km5pcVkkpGVWWXIfzebt2z9LY7oK8kGK57AspnUaMmWLGjMgvg
	UxAwoCsjcyzf/lMcch7s7YSl1lQGRB9mRJ++kon1PdIP86yBapjaPDfgfASbby5+Bpb9U1GMLGF
	i/waGXuBGkp2zRFUo+YWEtX3wkTOCFmhZcF4jFPt0sOa55yraFmwnYZsCi8j4CoRbg8WUdbMgNI
	F3sdZEkDeip4PjL8f+7s/05NkYZRP7SW1kET9jB32C6Ti1GwF7JeKt4cwAr9i8jH8OFEEOUGoCu
	ZZosXz+bRcmBdmey0e35X1qC84ypuPo01GRyJH/T9AmFQjLFYCIL
X-Google-Smtp-Source: AGHT+IE/qb9h63vxdx8e8WASin56rHkQFvonoamE6bRPg8oXIplQ7tVi78HnxhALWyMitoFG9mLV/w==
X-Received: by 2002:a05:600c:3ba8:b0:439:8c80:6af4 with SMTP id 5b1f17b1804b1-442f2110f24mr67879905e9.19.1747313153258;
        Thu, 15 May 2025 05:45:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3368e3fsm69778645e9.2.2025.05.15.05.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:52 -0700 (PDT)
Message-Id: <223a0053eb7f94dfd28db8f528b73a489f907444.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:37 +0000
Subject: [PATCH 12/14] submodule: check return value of
 `submodule_from_path()`
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

As pointed out by CodeQL, it could be NULL and we usually check for
that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/submodule--helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c1a8029714bf..55826b82407c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1934,6 +1934,9 @@ static int determine_submodule_update_strategy(struct repository *r,
 	const char *val;
 	int ret;
 
+	if (!sub)
+		return error(_("could not retrieve submodule information for path '%s'"), path);
+
 	key = xstrfmt("submodule.%s.update", sub->name);
 
 	if (update) {
-- 
gitgitgadget

