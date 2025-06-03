Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E64CE08
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920453; cv=none; b=uEELzYXYc0jlXnfftT+5gLnS3IpssB4sTcpI3O70utRPe2EVMFIDdw8oo//QXAcOExRMCZuJi+GahgA46CXepVXIq0wi29RKxuj6waMHGgfeecu7GpL7SDlt/WVKKjb0o0mZD+OR6bt2D0Ke5kBl88Nscm/trVEdOQPSEzOOPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920453; c=relaxed/simple;
	bh=dzjFOSsN25J8ZygqmzyQzRcsy5ku9+aqGNiDGlvRs6M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f7JgWjyECi8O0EkbZETEWBGvi1+HBru5gX5QJe9/N5HNVNvueTSNObUlheIeBaejiFjQSSxTNZxMduVMTLS6LU9IqA/Ws7+Wyt7Fi8qE593msFdS6DbyqvyL2ZyDSyp2P/hCRdzdPikDSBHc6l3U5vdsFlX3gh03KPLv8sHpUuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7FcANwg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7FcANwg"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a3798794d3so4331615f8f.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 20:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748920449; x=1749525249; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqn0o9P85HQM1R91qqPFp/LMNq1P649fTH9vpiCqMdE=;
        b=g7FcANwgjMLQZP5g6yIJNRBJUz92bK/B4OUxBL7aoYso2a5Dd7HyLQqdQnxQKHZUl4
         J6f3irbdrBqw/glYrzMr85A/zOS0sQ8+3p2Z5PPDr2El3+lDxzYGGF9ecu6d3SewIdaZ
         6lCu+e4C9b+kkTLd1vRysgv9yZntuy0m01LuU85DMRsoPWn8yXPw5oxnlLQUMnuE5q2p
         bgJun0MFskEH3nzvFuWAbVDQKf2S3VykS57QzestSOz9wkios6HT1mz3U3T0CgrREHQ3
         TM6fgkqd5qgcTiyrgmTjD1ml98brPuDuG5IxsVA5HEBbZCfm54CKoUxRBH2OFGIUtrxI
         gXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748920449; x=1749525249;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqn0o9P85HQM1R91qqPFp/LMNq1P649fTH9vpiCqMdE=;
        b=ZLAkrTX7dRmeyZJ4nCQZmfqI+yvscgnXwEWzGfyx+GtjfwJ1DGz1Upy2ridzcIdNM4
         lyRYiuwfT5ePr/lcEOroe0BqepBxOXF3fK3urV3Zu5cf6iih5mkaoWbF5VANcb7c9iYL
         KoNKxuGWfdrWKUIka0kdicPlaYOsaJToXJBzx+UqZEU9n/wp5zxHRRgGeI9MUiYwCCGk
         chp+KiDE5ITQg7Ddp3ooRQgwmAUswWKfl8scnqmOEOT5g4BRSOr1AbhhPqep3a66czgU
         t5ZFCzaVzHrRHPCvClFjRYBqViIV6wIv8U99gkDc1TV2DkVjzE5Uw+5+cHF0DncVJ+uM
         j7ew==
X-Gm-Message-State: AOJu0Yy+lkomo4TZjEFRXkt8M+7ht3lFJnljmuprMUxRGiBid59NYAyA
	hJEVfgQqxggx0GFnWeQJQ+ufDs8pSYdQ/7so2uAMgM1XFflFmxjaUTizxaJydg==
X-Gm-Gg: ASbGncuOfG4IiSNTgfYpPw/5Mwbdvwpi3WYgstvUQoxgUw/IghG5pwo5V0Z3A8VBNAV
	pN9G7V1lVJsjsAaQDehGvJRT89Bc/zCE+5U89n80/h63EdBQqZqSjm3TPsxhUn+mFX6/oJpKry2
	iErauWNEMB9f20iwerDcZiWuvJl3HCwscZbWPym6WkExdWcL3YipDyD7lVJIdp2No2lTDuESvYj
	FQRRY8RkjpPbNMXzwUTzjskBjhFCK4Q8RmjtdFLc8O6JNKP2/1sMxR17hFaXVk8PUUuKnIQlZc/
	9q4PswkvhuS2h6odJZ5NXf/PVzQPSlXOk4rXwy5jTDHnipGjrPV7
X-Google-Smtp-Source: AGHT+IHRoCZmN6VgpdfidiPMI4zn4Aul/gWuxkLat3GnKRbGRkiNJpb4t9SQbI8Ho1DE8A4dyPRowQ==
X-Received: by 2002:a05:6000:381:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3a4fe398aeemr7957037f8f.49.1748920448946;
        Mon, 02 Jun 2025 20:14:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b83dsm16686208f8f.1.2025.06.02.20.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 20:14:08 -0700 (PDT)
Message-Id: <a75d0a3cc7fc78d13e7703bd02a7e30fbd601831.1748920445.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
References: <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
	<pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Jun 2025 03:14:03 +0000
Subject: [PATCH v5 2/3] pack-bitmap: reword comments in test_bitmap_commits()
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

In pack-bitmap.c:test_bitmap_commits(), it comments

    /*
     * As this function is only used to print bitmap selected
     * commits, we don't have to read the commit table.
     */

This suggests that we can avoid reading the commit table altogether.
However, this comment is misleading. The reason we load bitmap entries here
is because test_bitmap_commits() needs to print the commit IDs from the
bitmap, and we must read the bitmap entries to obtain those commit IDs.
So reword this comment.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 pack-bitmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index fd19c2255163..e514c9da239b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2839,8 +2839,9 @@ int test_bitmap_commits(struct repository *r)
 		die(_("failed to load bitmap indexes"));
 
 	/*
-	 * As this function is only used to print bitmap selected
-	 * commits, we don't have to read the commit table.
+	 * Since this function needs to print bitmap selected
+	 * commits, bypass the commit lookup table (if one exists)
+	 * by forcing the bitmap to eagerly load its entries.
 	 */
 	if (bitmap_git->table_lookup) {
 		if (load_bitmap_entries_v1(bitmap_git) < 0)
-- 
gitgitgadget

