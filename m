Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866F52F278
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923456; cv=none; b=Pu49JASmP4DzYxu+0GhngUusIh7P3Mak6iQAdlB5heYeM2qZV2W5cX4sUJUNxL07kPuABhRIfTPO38dN4XSXwpnbHETmguVqePw+Ok66pWghNAehlOP5wQrmXiQ5xkHUuxWfKeOCP3QzG+SCFRyDXnpnivYE7yEIzTYk15/oN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923456; c=relaxed/simple;
	bh=66YwjHR3kiSsefVn4ONQAhx32Ej5B9xIquUxhJow+VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZIsdC+ALF/ZXxMrjNBhxoSSV/5jUhLF6tcTalJJSL1YX1OPlCe3rXFcr4kTX9ClYL8D2+taGytJoRidvHQTxVN0CgV6X/vDCNAqGXt6smWnCl4LJ4V5PAQ4vCUYzIi/swRcnAFt73W+wK+DoW4fym1fKSiZqAir0wAjegXf7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIRV9aEi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIRV9aEi"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c315729ad50so565199666b.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791923453; x=1792528253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=btgmj80aPFXCiML7wPrTHUONCbvbINVvkYPXl2Rhe24=;
        b=VIRV9aEi6SW3baaCt35uS2PQTJxuDDtajsZBzQ0aNtz6dHHRa7XYNj7sFlUZjbHacy
         2SJFBeSZz64+TLlL5X2l3Vj7BModB1cl37XHRSAjCyXd30xqMgHKPt+scnzHPdNixsQn
         7R6B2so+KQFT00E/qkuls3tHE2NJo0YCsosu4D3CrtFdy6JL678GIGILZPG2Ca3Mj25Q
         jV/zW9Z86bLOITReGujoSf9kKdE2fxY1BMOz7v/cy/dqwpxwhA9RXDigbrdQHcHwI7UE
         pxwhosXftznm6z88MTDUln0dZ7s/5dLY7nyAlw3fRmj2jvmNjXl+4sjLw3o1xSOlsdma
         NqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923453; x=1792528253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=btgmj80aPFXCiML7wPrTHUONCbvbINVvkYPXl2Rhe24=;
        b=fzod4a2h9A40Ji5fQD2SHhL22fFlteqIKFd0rRrhpMMPwIiKm66BGk+phXfd8IhCyc
         /Q34FK2MzdmBINcNvyvxhVTuxgZYfKfzUQqYwRSiMQoXOXp0NzXMZ2qePuWErBCoylgo
         GhIklJ2wyUJ2Ubwj6/8D+Bo1B9ySxRGDMBHL5FK/dGQmN8nKow8TZQCAYByKaR8Y8QDB
         8TvV7FKKOcmw2HITchkLekNBdgWkM1ucw7bg3ruWOdYVr8NXTJBP424X3DVEmKr9MoR3
         MyWf+qOx8x40Tjqjx9EQJtTBAdQqI19SVcP7BYrtYqh16fzajSkPgdDdTiH+/2TC1COB
         gHUA==
X-Gm-Message-State: AFq9FYKXEfpy1RfcZ+HgV9xtnQZujPZyXTIpS7VuobraccZgqmYYgwNa
	oEft2TPmPqzXI41QzJh0lWQDkvvARD76W5Gu4sl5BSMYk8mhOJF9CS/ZiaVjqncqSLe0pg==
X-Gm-Gg: AYBFou34KdW7bzZJggXSjWUePNe0lcn8HpA42/CQj3uTrAwix8hOhpkHvrtP/v6NeNA
	25B8VV4+Psoxjr+fRf9C55Qi7SR7dyOQMArgV4tyAENxSwnrHIUDXYB8BX+UQJ7gByXQQnwWsUc
	YVWMzocvesHapiMN2348bc5drhuR7N1sg+x1cwEN+ucABr0GOf28xnxkqWhvQOL4OGutpZO6wfd
	pSidUcvbpF7lPOGufXdvw1LZ1WPMXW+RPYLN1xQ186zATqlAtzeRgWyDILokvo0gwRO/dcY6bfq
	kM+OySF68K8JTicNDHN+j3GsC7BZIKhLlm6xqc2FkrsaIv+s9dHTZNJTzmLO9+odlam6Pi83Glc
	pnCHwtoRH1kk4X7VunM9z8okTkYJ/xABultZS0NTxzajTAs2lOAnlIwf7MYDhn8A1gcxGFOXPzk
	biGPn3iCzv8Lsz0Ej07mchIJRbM+9mT4SGNISPngiRYK9fYIo/FtlbqxZdeZdQfrbFYdcjDpS48
	kUBXGCiSVUtygUEJZm1F8CTE5rAgrgj0X4rdy4rsCdhgEeMCx1O6IAz+sOwIz5phUyh2h7Y/bSO
	o99ZvFMNK5Ybn9YrtZaJp8X2FG6AKA53qZeLD3VMPMk4DZQrea79QKTcnaDkkO+BPfm33zAFEw=
	=
X-Received: by 2002:a17:907:9686:b0:c1f:983f:d8a with SMTP id a640c23a62f3a-c31aa017261mr1394334166b.24.1791923452536;
        Tue, 13 Oct 2026 13:30:52 -0700 (PDT)
Received: from localhost.localdomain ([104.28.219.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c34adc25c89sm297329266b.45.2026.10.13.13.30.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 13:30:51 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v2] delta-islands: use Q_() for island count
Date: Tue, 13 Oct 2026 21:30:42 +0100
Message-ID: <20261013203042.58610-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013164922.93099-1-okhuomonajayi54@gmail.com>
References: <20261013164922.93099-1-okhuomonajayi54@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The progress message "Marked %d islands, done." is marked for
translation with _(), which gives translators a single form for
every count. It reads wrongly when only one island is marked, and
languages with more than two plural forms cannot translate it
correctly.

Use Q_() with a singular and a plural form so the right one is
picked from island_counter.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
Changes since v1:
- Removed the "Found with" git grep paragraph from the commit
  message, as suggested by Junio. No code was changed.

 delta-islands.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/delta-islands.c b/delta-islands.c
index e71a7e1c05..c1c0f992f5 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -496,7 +496,9 @@ void load_delta_islands(struct repository *r, int progress)
 	free_remote_islands(ild.remote_islands);
 
 	if (progress)
-		fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);
+		fprintf(stderr, Q_("Marked %d island, done.\n",
+				   "Marked %d islands, done.\n", island_counter),
+			island_counter);
 }
 
 void propagate_island_marks(struct repository *r, struct commit *commit)
-- 
2.54.0

