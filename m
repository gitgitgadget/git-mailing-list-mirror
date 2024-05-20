Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF9137C48
	for <git@vger.kernel.org>; Mon, 20 May 2024 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236533; cv=none; b=iHnCymj+sXk/xrBehpDKNhUmxZOiWbGG/wsbachW6vQaavHMWw0snG7Dp1ObddAm3fIoqeeEAZKqzOghWfPvttDTtfpzStvAvkNhCn8Hkx2DC9lSweh17gTP3iQBXKkEHHGjAeyuu7/BGWHQeNcey8jtCxdn8AlSkYke6Flx1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236533; c=relaxed/simple;
	bh=eomBttJUDugeAh4/E/RHJ5Kl046QR71tdtyo18mV/ck=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P+1FX7LwQdDiSig28gEiv+/exIUZdUBWnC+CItIZ9APaPoB+qTo+536hcTI6YEFdI8TP4BFIUjF/V0Bu4Eurjir32TLOMuh0D+bjugh3wbnll+ZmgNiwi5yOt+ionN89pt3rZKh/SdrIgYVTu+WTqG63+iQacZn3Ui1R2KsHC4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwV4MozY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwV4MozY"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-351da5838fcso2810023f8f.1
        for <git@vger.kernel.org>; Mon, 20 May 2024 13:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716236530; x=1716841330; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa4ywTRMbTP0sOgRCz5rqk9gwHUD4hcDu9QhBPTQQ6M=;
        b=hwV4MozYzj68WmswCojsUwVPqojixexgCx06HBsW8nYXpM+POy8q8istnCnN0uI2E7
         P5Gbupg2GAuuJ6u8oUWdJGvHAaUXu9p1ouimgm3+4B+hofXr+RKjO979SCV9PLJSMIea
         StQnaJWrE9iiJ6TGVnPmUJwIi7oLE45/vhGN91Z0Px0sme2B8+Uq5RInuO0awM/DgHCT
         EltmSQhS+2Le7cb0aG23N8seMTvzomJBAoZlyosnBX3nJZWIG6b0Hnblab4jJMO1ZyYp
         0tSHcA4O77DDocy7B9lRw5elG11KVe3DyQRtIvhHHr4Bnyl94MYoN0Q1VXPbn2CbdfXX
         iXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716236530; x=1716841330;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa4ywTRMbTP0sOgRCz5rqk9gwHUD4hcDu9QhBPTQQ6M=;
        b=FBZk3nfyGl2rVJyVqcVZhIFppfBRogcvaIm9Po5wY48hpLs41hWCJcv5DmdRHFMYcD
         W6EHkH88PAUBpswgEaThgKiDGPQMVsnNx8oeKnyg9HJNRAfq8pdoQ/U7Dvx08lx7reEY
         PEDeVYdot01JrYF7s8xk9/hVvLpeOkQYfHZVvPnJdXqgkXo4VhdKNVal2aZOj9g40JZk
         HVEr8G9fI3ptwqaNzraME+N/+dZuqJmLC4Bdmv70UjENj94I5XPvYzcLeQOzwS9psFRl
         c3R2tfxAoAOZELSSlI1Z4clZyMKxuKO0oB+Vs2VLeWriJWZWeLuOKAZ5LMuAuFhLTB+q
         XCUQ==
X-Gm-Message-State: AOJu0YzDQLxFEr+rGcEFmzBcEE3qzQbKL31YJmvauGpGHb8iskR5gXWg
	f/9cEoBixmJbbDOv4JjS/9n9h3mm6Ds8Is4I89h+f+br9HIpumZIo+k8pg==
X-Google-Smtp-Source: AGHT+IGHlJd+NeSuUTXknGCPrloMiobEYLj8ygnpnWIOCj6195u+gfAC5+ebhjPgh/G0Fd6ffmcGfQ==
X-Received: by 2002:a05:6000:114c:b0:34d:a9:6642 with SMTP id ffacd0b85a97d-3504a73821emr23497791f8f.28.1716236529604;
        Mon, 20 May 2024 13:22:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3525f7f7d88sm10651425f8f.57.2024.05.20.13.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:22:09 -0700 (PDT)
Message-Id: <d4a003bf2ceafcc6d47d01d21b7faff48c9e85aa.1716236526.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 May 2024 20:22:00 +0000
Subject: [PATCH v3 1/6] hook: plug a new memory leak
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
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 8db1e8743c0 (clone: prevent hooks from running during a clone,
2024-03-28), I introduced an inadvertent memory leak that was
unfortunately not caught before v2.45.1 was released. Here is a fix.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 hook.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 632b537b993..fc974cee1d8 100644
--- a/hook.c
+++ b/hook.c
@@ -18,8 +18,10 @@ static int identical_to_template_hook(const char *name, const char *path)
 		found_template_hook = access(template_path.buf, X_OK) >= 0;
 	}
 #endif
-	if (!found_template_hook)
+	if (!found_template_hook) {
+		strbuf_release(&template_path);
 		return 0;
+	}
 
 	ret = do_files_match(template_path.buf, path);
 
-- 
gitgitgadget

