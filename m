Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFE1C84DE
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 05:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347936; cv=none; b=avZwoNkAmePmzlRa1ZxXqa3FL63i34Ag2HmlgogK0yGSQqVR+189hYcwzDXWeyuu6m/Ij5GNgCuNQq7pzsZ9RMCgx343rAOSfVvZpKolbhBvlcUJS7MCHooMF7QPXG7eL7RLAU+Q5uY4v2+tIP8eFnX+LQut6gDbBZy68i3e7uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347936; c=relaxed/simple;
	bh=m7MNaL+VprNQZl/4gFT9AE819bOlWcV9KjvSdgChT1k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KqO+kQGP1/xRxDX9fTBvT8D/a1yksTlo1WsqaDcvAPxFijH7lxEgG9m3wCred+gCloLR6QimtT62QRF3hD38EewgZ5BtZslSwQ+pBKwaiFVoTDr7LjeBzXFx69bnZn85sQdV8xoykDt+korMZyyzmgtAf1NNXOcdzrwxA8jED9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy2ThToU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy2ThToU"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f379662cso2368211f8f.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 22:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751347932; x=1751952732; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAoM9RYF+GkU2hdQcHZFeKD/Hwi8Qo5YE479fVfAokY=;
        b=Cy2ThToU3N29Xt/FsJLBT9BOEXKzV/UDJMi5UFIuC74DukiCfTaR2VYMrCCXaTSfQW
         oWfNbpGm8qvHGPc1FEwTOE6eDOk01FaDc+oeoo9rz6IVG9nZLMq4Rppbwk+sKiAToXW7
         E9x35TXwKVDjhI6XFPFLJHvn/OQyxeWibjShHB1NsGcCD8z/Bj5WLg3RQgDlN9g5lAxH
         GC0s+GxK3Ti45ez0Peez/Uu+iRkaBVswu6RsiKr4EJcx2nASxrqXN8FNvJbZgkIe3upJ
         8B6VheS0V4b2svL/TG4J66pqgMHAOZ32mpvs6LrRuWPLQvSzGcAl6lNtoeaFA/V/VbWj
         jDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751347932; x=1751952732;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAoM9RYF+GkU2hdQcHZFeKD/Hwi8Qo5YE479fVfAokY=;
        b=ZITSZPPcSrELe9hiWhgJsOUR0xlMEjnXmKiOhevuKrZ9b084mABvu7mBT4ACIQ5pWX
         oZQSLY9+B/wp7x8YlFdraHmSmhBGa5vzIj3l7xCieei0HsA3XEIKytWrI08n46YtL8e3
         tQCXeWsTu62UAczlt23HuuImXn7WDyM64ItDt/VeGrVETzk3eEQYpYSeXBLuSfOwMPZk
         hmBK4zBKCyHXbRE7aYDIAxOkYV1AwX1XJaljBN+xMR+ABaC9sfv8EjjQQxNESHmeFVh7
         EMRWX5osyM+3NNpQQelM1jKSdXRVkQZKllqGkW0xJqcLCvVRbSzpaTxNenJXRjJ4SHFE
         dQvg==
X-Gm-Message-State: AOJu0Yy4jinhhlxJJRgKWZ3t/VFUt0rrdE2yf1eE6LJtZHUqsJQP05WB
	szkf8Bbtk1zPkRfxg3BrYEJWKv0IyQVziB9aF3hiO5XMhnZwMhizmLh1HLuszA==
X-Gm-Gg: ASbGncutaHetuqynLikPh1kSSNUFYg7+TyKAzORlIHaSFDEVD8qQVK1eSK7pslyOOQm
	DbrIoUkYq+1TyP5v3Y16zBf+KF0TgqArXaVzdqjiwIRKoPBjJmkgqPy8gnKYh3TnglvWlr6d1sw
	7kgWtlEIn5wB0JVWzt7QkggwYLdjvollcAGiD6lG6+gRVOw8Jw7WFFJu0z81uLCavk9dAAPUZ0a
	EfAUnUtX697cg3liWpghT4mwckohXa8VNmTx0SUU3mU0eJJ3TuoGSej/vB4UnahUEu/ZA0Wmqq/
	1/C/ABcVWPYDeIt/Af6ySfUHrUthT8KaM1BpPd5t+nfgRZS6D+9I1rc3SObbnUY=
X-Google-Smtp-Source: AGHT+IGMEVKcXv7NFwdyjXpTmdsqUDVEgShxdm/Up2BpSYYs8hjX1esEugpnFlH/XjHJDDV+9tWtJg==
X-Received: by 2002:a05:6000:26ca:b0:3a1:fa6c:4735 with SMTP id ffacd0b85a97d-3a8fdeff683mr14770492f8f.35.1751347931962;
        Mon, 30 Jun 2025 22:32:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f923sm11874504f8f.89.2025.06.30.22.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 22:32:11 -0700 (PDT)
Message-Id: <6a082930ea3afaae03aaf87a861da8806799301a.1751347929.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v6.git.git.1751347929.gitgitgadget@gmail.com>
References: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
	<pull.1962.v6.git.git.1751347929.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Jul 2025 05:32:08 +0000
Subject: [PATCH v6 2/3] pack-bitmap: reword comments in test_bitmap_commits()
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
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

The comment in pack-bitmap.c:test_bitmap_commits(), suggests that
we can avoid reading the commit table altogether. However, this
comment is misleading. The reason we load bitmap entries here is
because test_bitmap_commits() needs to print the commit IDs from the
bitmap, and we must read the bitmap entries to obtain those commit IDs.
So reword this comment.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 pack-bitmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 38588b4aec01..330f07609835 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2839,8 +2839,9 @@ int test_bitmap_commits(struct repository *r)
 		die(_("failed to load bitmap indexes"));
 
 	/*
-	 * As this function is only used to print bitmap selected
-	 * commits, we don't have to read the commit table.
+	 * Since this function needs to print the bitmapped
+	 * commits, bypass the commit lookup table (if one exists)
+	 * by forcing the bitmap to eagerly load its entries.
 	 */
 	if (bitmap_git->table_lookup) {
 		if (load_bitmap_entries_v1(bitmap_git) < 0)
-- 
gitgitgadget

