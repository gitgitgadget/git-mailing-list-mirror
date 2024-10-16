Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95B5478E
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112799; cv=none; b=VvsFVa/bpLnCfVwLzKdAbCKXjKplOsIKYxQS6s+RaNFYwpOutd/hTkdROAM7w7Hm/eLUZxRtDMHwNlwIxp4bm4VfVO3CzTnI2jCW8qhRE8eCkD/e2hWhWRARrhKtpbSVVz3hnyjax8FhMa3YjSFgl35nlcLfuKjsodlJ3KFXbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112799; c=relaxed/simple;
	bh=qhmbrzyq4e8Lt7Q3UUGktHPrlhgT5T0wkd8qoq0wYbs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=qmamGGywWSbHmq1imij4ieUF/uDJQ7tuiO4//t5Cgqc8XtiHPPnBGdmQufZfTZD4HpcDPNF+0amaHzgpYD5bLp6Ag2TejsJZiMQ0Q/j1uj+syUyV5183724e+M89yf7TSR223dPEw8OgTLj6KiQizkEXQQ5QmWhy3ib2ASzBwFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KszGk2NG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KszGk2NG"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so368513a12.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729112796; x=1729717596; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CSq2Ry/3jTzD/wxQzdSG0VgTVH7C7ka2x7tliiM2e7o=;
        b=KszGk2NGwMg6xZtZIFnDwkIO0NMe6TXxUNeqaoSiJHggjB+qqx2XaAEGPhN2xu70kp
         LvF98K3P80brgBYXNXhGr/ZEFDAIKJUlyJ0He7CHwss5mS3DbL3HHkn0igMNZj00tZ45
         q/WuESWBI9HcRHrgMznoJJpa3G0KemVH3bc+I+/NsQH6pE0D0m49bPfOxmXUSCkhZjk3
         1N/xre6RqSWAdXkKt9r96LKCDRKgwk6IcANaYckQSOO9GwWCzaf3GXZ+BrxiqofURCxZ
         zVMtYDw9qkY8DDm8rJwzMZFwx+aO3PiRnWXqQVJcvYnLJQqMWaRiHJ3zHGU+EQsXmgBM
         f2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729112796; x=1729717596;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSq2Ry/3jTzD/wxQzdSG0VgTVH7C7ka2x7tliiM2e7o=;
        b=WVa07l9imLthCx0Ji+pgfSz7HScAApkavif1bsChPy7/SN+hnIfKsxz2W8wnjh8Y8a
         cvzVEippbQrABZH6351PvyJ4rx2ZbJyk91fosJvtzHZq4rGSVtc+erWTvEx0FPvrMSUq
         1Gmiu5Muys2mTTcQQ18TKq5TJ51sUdfOqyE07hOZMoY4joYVjQivzke8uIqwAhjvXlSC
         +Cj+PAo/4JhoAKV58JuAEBIIyLi/GIzRdepilEO8roVIkz5gXVgyGtDpyTmB+1Ssh11T
         mrMONHBnGK8SGcGPLxx6P8lvMTGyRF9OK7j75Q7fF1H6Iy8qZPpjr9YOU7R4jBf/ryzT
         jGiA==
X-Gm-Message-State: AOJu0Yw/h3bhoIPbnDuZdfDGb4YsqV6GdzB0Q8DakEnZ0aLFj/6WQ3uF
	u5H17J92SbcNF/Tgxm49iaG8eMeyusQWxhxsndCox73CL2pOoDutCpWm/g==
X-Google-Smtp-Source: AGHT+IFBXgbKC5WkR5aL0vHFxIVka301isebX5TMqroX4zD4RB2e9nWwuVaRfw2aXNJT3iPCwmXWsQ==
X-Received: by 2002:a05:6402:5c9:b0:5c9:58a0:240a with SMTP id 4fb4d7f45d1cf-5c9950b9252mr3974117a12.14.1729112795885;
        Wed, 16 Oct 2024 14:06:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d7b7be8sm2036261a12.97.2024.10.16.14.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:06:35 -0700 (PDT)
Message-Id: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
From: "Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 16 Oct 2024 21:06:34 +0000
Subject: [PATCH] upload-pack: fix how ALLOW_ANY_SHA1 flag is disabled
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    David Turner <dturner@twosigma.com>,
    Piotr Szlazak <piotr.szlazak@gmail.com>,
    Piotr Szlazak <piotr.szlazak@gmail.com>

From: Piotr Szlazak <piotr.szlazak@gmail.com>

ALLOW_ANY_SHA1 implies ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1.
Yet ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1 flags can be enabled
independently.
If uploadpack.allowAnySHA1InWant is not enabled in config file,
other flags should not be disabled together with ALLOW_ANY_SHA1.
They should be kept enabled if they were separately enabled in
config file with they respective options.

Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
---
    upload-pack: fix how ALLOW_ANY_SHA1 flag is disabled

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1814%2Fpszlazak%2Fupload-pack-allow-flags-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1814/pszlazak/upload-pack-allow-flags-v1
Pull-Request: https://github.com/git/git/pull/1814

 upload-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 6d6e0f9f980..cf99b228719 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -53,6 +53,7 @@ enum allow_uor {
 	/* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
 	ALLOW_REACHABLE_SHA1 = 0x02,
 	/* Allow request of any sha1. Implies ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1. */
+	/* As this flag implies other two flags, be careful when it must be disabled. */
 	ALLOW_ANY_SHA1 = 0x07
 };
 
@@ -1368,7 +1369,7 @@ static int upload_pack_config(const char *var, const char *value,
 		if (git_config_bool(var, value))
 			data->allow_uor |= ALLOW_ANY_SHA1;
 		else
-			data->allow_uor &= ~ALLOW_ANY_SHA1;
+			data->allow_uor &= ~(ALLOW_ANY_SHA1 -(ALLOW_TIP_SHA1|ALLOW_REACHABLE_SHA1));
 	} else if (!strcmp("uploadpack.keepalive", var)) {
 		data->keepalive = git_config_int(var, value, ctx->kvi);
 		if (!data->keepalive)

base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
-- 
gitgitgadget
