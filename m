Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB671F7569
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237058; cv=none; b=KAH159CtM3OZMXOqJ4ChZMkT+5Q4XoCPOvIA3UxW+GPnXzAPIjA8ZzybyAjDLhSB+VFwHWxswshmq7duT5eVTeiFeXIYS6+4CM9zB2QlVb4WV/HUjOWzfY+n9tTjcQpPmS3vZYwJAbT8WKu2gPn1Yt9WBTR4bcxh4ZTQWcYlYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237058; c=relaxed/simple;
	bh=gLMI6IJ6CcDqx/ZXKWOc/IY8qsJxK0BdI2fGTBhsMRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFWVqkki5+FBawemhl1hwpHO22Hvzp9ti3ekq/5vXx/7C5GXQW75RzkPW67Ic1owvX+/Dgp6svYxJbYzIDQagvYfV4aSKcdkHykF4ovzVg1mtOVL3lP0KNwERire+JElbyoBjZBZOtkCDgyvXRHyeAZ11LdOZBYa7NlQpMgAjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S78f25Jz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S78f25Jz"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so1008762466b.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 06:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733237055; x=1733841855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqjB2OdKxdnsqXQsD3tnxV3W7gul/wGnDPAE3Q3qqY4=;
        b=S78f25Jzj3/Cp8yOocoS/7NxeeaVl7HN3cuxZ5HOQTsPYkykBJRUJVIvvsmkNFedGn
         ZBR84MC2hE+oowaAI+RkO1aM+ydBmlD44vFSMqxpzJiD/fB2pkcewMY618mD43NG6Wix
         wgjhKj/Hr+x1xXWHtNrQeVV23bp/4NAp+jnaRi0E5kz4XYWK7hd/9cleCsa/8NYoPaMY
         GC4WjxAi9XuUQWvfTvGpnXNa6GmUFWsdWeHmLNSisRCgQwwH/k7mllXCflnLsJ2nM5X3
         N38n4sJ6cyE9+m/P1+hVJXfvUzncHyHI4EB+oBCsGHGS2l7ChlEeF/fcR7SrMackV8j2
         Nfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237055; x=1733841855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqjB2OdKxdnsqXQsD3tnxV3W7gul/wGnDPAE3Q3qqY4=;
        b=hljuVIzm4GbpgMopfmaNnY7kxP+FIQ1H8HTs4Pj3cDhSj9BXNwiwcejzunPbpcYoGx
         U2A4BW1xjB4yRphknISO6346urP0+dkNkhY9Wcc70szYp5DUMB0hETQ2xdNSeYpc5L0M
         jl8Znl3YV69KdfLBZGuS3k8LgfHv9S/OtzrnlPq8+6oM4FhOCQLMSfPtkOUjvlAE7woh
         T1ez1OffCSXdDjDKPIIuOWYSKu7hR6eDx+FcMt1CTJDMeMh+yqYV3BHksinoIqS+CjVb
         o91kd5APtDUz8yVBlFDTOcfk7NAQieptnpi8e2z5+Iqeq0g3DnUZJO/t0ZB5YCcv30mh
         VHAg==
X-Gm-Message-State: AOJu0Yw3rW4a4nd7gbttgsQh/4+xRQxJlKu8xWvPF+e6xTZPQDCUs4zc
	lYmEeIXVFCr1c4gjZcgLOvcXiv7uN0IPJ1GkmtYI95i/SBkq/G3P
X-Gm-Gg: ASbGncsDOTJeSa7K6PC8S43KvrEk+oMAGp8+o9rZwXr3V8JW4YjihJtxU4j+qQobweK
	AX0xPZdUiuRR4R/DmOx4gLzGbFsFWZq9I3QQSXHJ/lCDyC1HS9M3Qyvzk6dHUcTKeectJoBCl6H
	g6fktgCnkXQUeZ1NZwQHv4d/pu8ksVaPz/bPZa62vzvmXxrp5x7oMlj5dwkd0uX1jGBOcDP+94v
	EAquhOHQNUZDdPEm+iuoSNrCnl97z+wl9hBGviJvWlkQZNgE0vKypqqtzvrLCYFYJEm
X-Google-Smtp-Source: AGHT+IGHrhhYatxJpc0AtCjZiqLQ+hbuveYhebIgsLWfCziBWLFHSnM+yKq2jEqGojgU6Uqqp0xG8g==
X-Received: by 2002:a17:907:6d17:b0:aa5:2e71:3727 with SMTP id a640c23a62f3a-aa594708696mr2144920466b.21.1733237054946;
        Tue, 03 Dec 2024 06:44:14 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de782sm619021466b.56.2024.12.03.06.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:44:14 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v10 10/10] packfile.c: remove unnecessary prepare_packed_git() call
Date: Tue,  3 Dec 2024 15:44:04 +0100
Message-ID: <e33fa2ea0d481248ccdbb808e228d5ee1b5feebc.1733236936.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733236936.git.karthik.188@gmail.com>
References: <cover.1733236936.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Taylor Blau <me@ttaylorr.com>

In 454ea2e4d7 (treewide: use get_all_packs, 2018-08-20) we converted
existing calls to both:

  - get_packed_git(), as well as
  - the_repository->objects->packed_git

, to instead use the new get_all_packs() function.

In the instance that this commit addresses, there was a preceding call
to prepare_packed_git(), which dates all the way back to 660c889e46
(sha1_file: add for_each iterators for loose and packed objects,
2014-10-15) when its caller (for_each_packed_object()) was first
introduced.

This call could have been removed in 454ea2e4d7, since get_all_packs()
itself calls prepare_packed_git(). But the translation in 454ea2e4d7 was
(to the best of my knowledge) a find-and-replace rather than inspecting
each individual caller.

Having an extra prepare_packed_git() call here is harmless, since it
will notice that we have already set the 'packed_git_initialized' field
and the call will be a noop. So we're only talking about a few dozen CPU
cycles to set up and tear down the stack frame.

But having a lone prepare_packed_git() call immediately before a call to
get_all_packs() confused me, so let's remove it as redundant to avoid
more confusion in the future.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 2e0e28c7de..9c4bd81a8c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2220,7 +2220,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	int r = 0;
 	int pack_errors = 0;
 
-	prepare_packed_git(repo);
 	for (p = get_all_packs(repo); p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
-- 
2.47.1

