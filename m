Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75962505A9
	for <git@vger.kernel.org>; Tue, 20 May 2025 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753485; cv=none; b=RO1LdVaXoeGRXrWmNTztif7gCCPro8PgjpHQRbhKOG7UOLNlOWp3UxRRbjcpIlRl9ecIP36rMnFATiyO+edsNiBvECKh28hXtMkZQ9pZlhn58qEWB3VLqx9JhGRDZAVybMqvFly6uhAe+Be/zgLj1LfKqHjTgck5RF5c9Is/t3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753485; c=relaxed/simple;
	bh=dSqgfVrfrJD4N4aOCkiob6f2a8HoTuzGzPcMgUyXQjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWiY2imvP2eqA/tsKcSCT/kZtMldZOfe48D1JD2ZzxB4+7VHw5oOPYJlu6Q3c14ZMY73+18B01mEbOHZ/UuW9Fx7T++6SrPnxgW3Wjghf+v3Kp2HSeBxwUtj8B8OGx36cGpi/gGvWfbO61Wol2M/qMX4xqWV3wAtt9Z59A6LXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMq5n465; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMq5n465"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a365a6804eso2051872f8f.3
        for <git@vger.kernel.org>; Tue, 20 May 2025 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747753482; x=1748358282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JmPZUzVb/NBLdHDlQ//SgzKw0bTBd72Qgib/n29xIHQ=;
        b=KMq5n465JUSk79VvDkdgjeM3j6Ad60fUk3GJ4M9mLKacSEv6C1oP8Qhuno2xtS9v01
         tLURtxJsCGhIQ3f0p1660NXdVjTk8G8iSj3IwF9rCc0QFm2cEoPYn7nSS+jhR2weQAS1
         iBgE3EA17PpkVL6epkgBYLO5jRCluBX9GjH953r83jVL/GVeEkqWSJyOGv2sW3tiL0s2
         K1P9diJ0Jq8NVeeiFzSYcbpwIvC8iClzPsFZuBTQNAUsQWPaN1bZbSR+X0jMYfZjXo5M
         nj4YJ5Q07JsNlQVsB+cQxedv7JqVKhBSlzc8uG0y86uANsezZ414lyuZSM2NJbxL0NE4
         uvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753482; x=1748358282;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmPZUzVb/NBLdHDlQ//SgzKw0bTBd72Qgib/n29xIHQ=;
        b=tAMEqeG8m+X+vOzcBcnudN8PDIsoWQMg83NM+kP8PxoW2XgTRmCroQRH00C/VnXMGs
         wmP7miobw+zbQbz5mvYRt8X4kR7CeTUbyeVuQE6qqS62Th9r5/4clguJBugfbSliwMtS
         J6idwn4kYDYG/ZQvoUP4ZWDMGlcs409Zf027KrGQrTGqj6fe6q0dejlL1NOHailxtGNy
         eTdpLD8SGnFDF42oI+JvbE7oJXozuXK2YVJx3IUPTrDnG9cmKyv10eLp7PGJEr+uEZwc
         mX+H0xauu3I1P8TufufEK9/L/VO91C9N6UFky04qUZXQZrN8ThyfU3kQ5C5GE30t4dWb
         3kVg==
X-Gm-Message-State: AOJu0YzzkW+da25MOyTqapSqraXqfBdzQIqmpMCwKlQvRwyyarfAHmQ2
	BTlkZ8UYQY+lEu7EFGsIg9LFcdwcHZIqqI+250aE/yG1tMlWD8c72wQfPEv+4w==
X-Gm-Gg: ASbGncvSCxKN3eogzYFRTHW13qD40N+6SmDVs8Ri33vtARMV/GmmDRQg2+fTjrgGZMv
	FX0Ae/q3KTwERu7QIkaW7OdtCfPITIppl2w4mV+ZSv+q3IxeX+r0rabECyxX1IijBvkO0xDOu+s
	biydPxqjgJLaDkI/RjVt/4Xr3XtJDQJKJiwKJbREFVRkw2+4nSZJroLBU/ia01SylgRtvhYE0ks
	CRMDF7MoNkUCiWNJA3K/weECOQ6OZhTPcKUdFXJ889CDMVma5II0p5RkH1dP7aWsdk6Uzb6OomC
	Yrm4UXrAesBAe4gawP41lLAT2neZfR2Xkw3O+yEBSTnfx4U8Aqra8TyhlzvUIOT2oro=
X-Google-Smtp-Source: AGHT+IEx5SKkrJwM660KGvDJb2WYoIQbi6o8xNh/wCvRZaxvuaLjU0ftJZMYr2plrjD/ivgiwq9mbQ==
X-Received: by 2002:a05:6000:230a:b0:3a3:64d2:cee2 with SMTP id ffacd0b85a97d-3a364d2d10dmr12007819f8f.45.1747753481755;
        Tue, 20 May 2025 08:04:41 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm17014029f8f.11.2025.05.20.08.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:04:41 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/4] midx repack: avoid potential integer overflow on 64 bit systems
Date: Tue, 20 May 2025 16:04:25 +0100
Message-ID: <9f07da4fe71d21b14226d8f0132cd3c8600fba13.1747753388.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

On a 64 bit system the calculation

    p->pack_size * pack_info[i].referenced_objects

could overflow. If a pack file contains 2^28 objects with an average
compressed size of 1KB then the pack size will be 2^38B. If all of the
objects are referenced by the multi-pack index the sum above will
overflow. Avoid this by using shifted integer arithmetic and changing
the order of the calculation so that the pack size is divided by the
total number of objects in the pack before multiplying by the number of
objects referenced by the multi-pack index. Using a shift of 14 bits
should give reasonable accuracy while avoiding overflow for pack sizes
less that 1PB.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 midx-write.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index c7cb2315431..2ee381e8fcd 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1704,9 +1704,15 @@ static void fill_included_packs_batch(struct repository *r,
 		if (!want_included_pack(r, m, pack_kept_objects, pack_int_id))
 			continue;
 
-		expected_size = uint64_mult(p->pack_size,
-					    pack_info[i].referenced_objects);
+		/*
+		 * Use shifted integer arithmetic to calculate the
+		 * expected pack size to ~4 significant digits without
+		 * overflow for packsizes less that 1PB.
+		 */
+		expected_size = (uint64_t)pack_info[i].referenced_objects << 14;
 		expected_size /= p->num_objects;
+		expected_size = u64_mult(expected_size, p->pack_size);
+		expected_size = u64_add(expected_size, 1u << 13) >> 14;
 
 		if (expected_size >= batch_size)
 			continue;
-- 
2.49.0.897.gfad3eb7d210

