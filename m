Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920F8288E
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324472; cv=none; b=VQSM4RBCKd3XipmmlNRo0E79cED41KVS0ol0GuugMTXIKa2erLz+7eRLRSCaMGkO3qlpdnkdnIdxCjmG/QQ6bjYTFIfHiYr8zPjeF8Ajp8HJmRng0GlDLL81Ol+AZb37qJIwJ+dbvrTttaSMVHb8K4Sne8K/lKnpwFns9bjRwvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324472; c=relaxed/simple;
	bh=QSb/Qh/k/jtO5PpkL3y6lTEdSq/J5NWkFsE0nmeVhaY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pT5wU37EEno8rNTQCRGKP9qg0NYM99eBaJpmAYFcWvDrpo63z7JggA0cLmcoRxs//3jH1BvS4O7DIOgvGSwyhXtTzPA9upPhE8XRxzXFLZWPTe2smWpiWhUaM5Lf+O5OslAskvspY1kfl4QwVVyyKASnthuaHauXKKcDY9W+IFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWKsqNpx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWKsqNpx"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4101d4c5772so79925e9.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324468; x=1707929268; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2HklqQzwQdN85hogz+D0Bk5KjHPdNYbw/bviEKo8cw=;
        b=DWKsqNpxvKQM+bUe5MYpmbM5YNpEZgRmkkX3aRneCzl4jL+RBFXwhI3uZPSYc+FxN9
         SLd4vaJ77AP1fc37YDD9X05jovd7DB7z+GKKj1DrIv5MSJgrN8P5XfjmUkUUQXK64Row
         /BlzLkBlpeW3WO3YCMcMdgdt+FVX7g6vAkmFGvQhiSNwUn9NZSuuf9hhVjVlViX85uTf
         nbdyNrkA/PaPdQC+qVPlgXlVC2hFyB2bu4PpeQSS8UKXiIhY1+wi2W2Mj7XopFVgahQB
         1sG4qPTZc2sBVEIWKEY5kMg7nkAhLND2UqUtGc7dyNmKZnHae5TtFdbXo7xgRfl/0jeW
         xkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324468; x=1707929268;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2HklqQzwQdN85hogz+D0Bk5KjHPdNYbw/bviEKo8cw=;
        b=P6NrTrxdFlakn4fdeR554EqtMGHQQnPtzJaZe2Bw1M5zJQMln+lRHfG3JqvYR3XJ2E
         AfjGgL4Az/r7aVBzX/sIFbj1EBUcikWXkRnGvXy2Enma1QdoJcr0VvXz1n9wOqSLxd/K
         LgGXOq5pUSADEVsEnkij1mdFxJNBm7wqM22AXRRz6fD7D3/gqjqDCHu1xd7gxJal4/fi
         TZLOS1IBc2CqNIIdiyYdhpGYo5Fr/M7VfTG/KmlmPQM2wFHxoUYpfBONJXMMM8sG5qZY
         2REtYJPJSlf3nBOOvtg2oX+qXPwTy+UJ4Eh2dFhx1KKBh/t39tcuoW1LXOh7JdWz9sFS
         H9lA==
X-Gm-Message-State: AOJu0YwELZdH2KW4UmYVrooFDUEp8kJmytQrhni30+vyEsnNHUxsmCeI
	VaYrGwehevceHGCqWNbTLdRyW5IV6hwsrHWnPgFAg1h7k4cyu5cj2zpvvRH7
X-Google-Smtp-Source: AGHT+IEGn041fVT1uIQ+f59C4mhvn+Y43SSD00Uy8df+dVgx7bto0nDVz+qDybWUorieG9CJvRAmow==
X-Received: by 2002:a05:600c:450f:b0:40f:db22:728 with SMTP id t15-20020a05600c450f00b0040fdb220728mr27292wmo.1.1707324468637;
        Wed, 07 Feb 2024 08:47:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1F5z0IOYwiv3XDYn0XccdpG9X2SvskmKIzpK2TeVL7d7DsCWnVWljzlU/kmMQ02SIhdaU3Vfn0AFtFN3dGBIhXZR3Ii4fjBqT3A==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0040e527602c8sm5814975wmq.9.2024.02.07.08.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:47:47 -0800 (PST)
Message-ID: <43c04749513d07733f5fa2c15a694d99d31fe6e3.1707324462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
	<pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 16:47:41 +0000
Subject: [PATCH v2 5/5] cache-tree: avoid an unnecessary check
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The first thing the `parse_tree()` function does is to return early if
the tree has already been parsed. Therefore we do not need to guard the
`parse_tree()` call behind a check of that flag.

As of time of writing, there are no other instances of this in Git's
code bases: whenever the `parsed` flag guards a `parse_tree()` call, it
guards more than just that call.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index c6508b64a5c..78d6ba92853 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -779,7 +779,7 @@ static void prime_cache_tree_rec(struct repository *r,
 			struct cache_tree_sub *sub;
 			struct tree *subtree = lookup_tree(r, &entry.oid);
 
-			if (!subtree->object.parsed && parse_tree(subtree) < 0)
+			if (parse_tree(subtree) < 0)
 				exit(128);
 			sub = cache_tree_sub(it, entry.path);
 			sub->cache_tree = cache_tree();
-- 
gitgitgadget
