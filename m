Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA021991CD
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369116; cv=none; b=PRNLMeF2cdjbX4wTJ1edS+DaCwkKuOiB1ibN55B0zLfRfkjSnAZZ1aX99HYRAEiwZ2VsFL8hVBK2CeosEglkJ7FcLCnfadIPkR3pDEQcOzLvOz1PuFBjgK4ThoiamuoLtk00Qd4j4FBQmezFKLBgA14Of1/RFKkeIOPBcNKKqs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369116; c=relaxed/simple;
	bh=q36Nn5XXkvbG0TLNsLQw6og1YVIOTItPwlGSTs20ltQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hw3+brfFVVNbc2fW3ZmWjWzt3UiB4duHth3LjBAyK9OcX/yUA7UxnJheFVTBHD8KdoaR3RkITfgA8DZFMGznkzHITs9awi3BRfhNRTFbGyyhPJc1hGioUU5ItrF9p9hre8VpRuFKRAFok3oBSve/7yyEaG93wAMVMJ6u5AOOUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0aFORCe; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0aFORCe"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso4278621fa.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742369112; x=1742973912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Jqef0PRuNiD0Qcz0fE3OpQ99Td1DgpGZlcLaT7BCMw=;
        b=H0aFORCeMt2Rg+TLp6ae9GJeiRlB0yRbteNVGu2ro70JGAWTH9J3rlBKXjyzoaBk4M
         lZRzhL7cP92nDrgRDabaE/a19D22yykFPU+h7dtWNIA8CiysIcDR9kLrhJ5/T/AdS+HP
         gw+N1iHGMWqpb9gAfBfdIADCDKBGe2cgciJKZ4lE2AnFoJ6g9y/RIolfR/+7gFs8hvq6
         frVdaxfIi8t3BFHXlB6fSa4K8MtwuSHhei2+xbP4KLdCu46xYzk1JVdKaUbV3hqA9tCz
         YEpAWEjI6TzwJUL1Za06csIYIahTlMqLDXlEiAaAZoX8m4Hu9XBSEKtJp57D4LR/XNpk
         GSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742369112; x=1742973912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Jqef0PRuNiD0Qcz0fE3OpQ99Td1DgpGZlcLaT7BCMw=;
        b=rL0cNQYH+VAHqPRvRRCbKn+do5M4m9C/Li8hrUzTeaRPTDkcAiOYM/LH/oO5IT6IEs
         WFC75XFq6OW2zIAJoXqOa0SYxqTU2xX0Sq/QGGbW4vV+FbG8Ar30BYZm7BvcltMIZWGH
         nYjIKmaM3BvHRrhqTS1TojTyOKoIH3KPq7BWrnHEK7219yn/5uBymgFjGsq3GJWepst5
         5dKegFCnqbSrkwdhW8xUm6mUhK0LijhscHXefiZIgHflAjZ1dQNXItjfygeeu9SNaCw5
         iopFtFg181kF465mbm8ra40oNRsgCi/5mY1mw0+gfGeL6vXtt7vhcGkTJ9z/JaXjJ2oL
         us1Q==
X-Gm-Message-State: AOJu0YxKUoVNabKlvdy5ghX+SUYNGvC3hIgLUfof2TBgsZCHxwGTlia2
	CYZIGGhqrrsqR8I6L++4KFmbGi4jI1cD3b20ccV7WzX1vGsdqa0afpSPqA==
X-Gm-Gg: ASbGnctd+20+9BtWkeHwheXU1LGzzEfJJaqiiXZErNgazEbjH4jETKGSCO2IBW9/CtV
	Fz7BJm9ELkJ8SieOWvg9Tvzhhe/Mr27U4vTkSFtSUykPZQvRekgz4suDqAaYA1b2ZKN/NVCl4kI
	PCez5JhCJUSmvnC8MTgeufDoAGp9va9veCbezkzCUxCGA3fvOzzyW3oD7d0EWrkkKY8Zoc7KXAF
	esVlF83DXrNUvTZoEwcXE4K1XE2XgFDpfby+sd3uBnC3Fh1AWWjNR7GY5hpw7qD3JXQl8s4tNIj
	BpBvrn+FsLmgTV4pZb1OD+3as9tAJdC5yLPWoVwyYIcm+bCVXxDohiax+4OouA==
X-Google-Smtp-Source: AGHT+IHDfVv9zJAknPDy3USml4foE9wveQuc5SuKVwDyK1aCb/bdp2Gl7BFRO8fqkxKIPHrY+IMzmg==
X-Received: by 2002:a2e:9cd2:0:b0:30b:f599:d78f with SMTP id 38308e7fff4ca-30cd95bc544mr33747631fa.7.1742369111791;
        Wed, 19 Mar 2025 00:25:11 -0700 (PDT)
Received: from localhost.localdomain ([217.116.228.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f209d6esm22089541fa.112.2025.03.19.00.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:25:10 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 2/8] pretty: simplify if-else to reduce code duplication
Date: Wed, 19 Mar 2025 08:23:35 +0100
Message-ID: <5f787ddac2d80391feadb8cf6be379fc8e58652f.1742367347.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec
In-Reply-To: <cover.1742367347.git.martin.agren@gmail.com>
References: <cover.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

First we look for "auto,", then we try "always,", then we fall back to
the default, which is to do exactly the same thing as we do for "auto,".
The amount of code duplication isn't huge, but still: reading this code
carefully requires spending at least *some* time on making sure the two
blocks of code are indeed identical.

Rearrange the checks so that we end with the default case,
opportunistically consuming the "auto," which may or may not be there.

In the "always," case, we don't actually *do* anything, so if we were
into golfing, we'd just write the whole thing as a single

  if (!skip_prefix(begin, "always,", &begin)) {
    ...
  }

If we ever learn something new besides "always," and "auto," we'd need
to pull things apart again. Plus we still need somewhere to place the
comment. Let's focus on code de-duplication rather than golfing for now.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 pretty.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index a4e5fc5c50..6a4264dd01 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1076,13 +1076,11 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 		if (!end)
 			return 0;
 
-		if (skip_prefix(begin, "auto,", &begin)) {
-			if (!want_color(c->pretty_ctx->color))
-				return end - placeholder + 1;
-		} else if (skip_prefix(begin, "always,", &begin)) {
+		if (skip_prefix(begin, "always,", &begin)) {
 			/* nothing to do; we do not respect want_color at all */
 		} else {
 			/* the default is the same as "auto" */
+			skip_prefix(begin, "auto,", &begin);
 			if (!want_color(c->pretty_ctx->color))
 				return end - placeholder + 1;
 		}
-- 
2.49.0.472.ge94155a9ec

