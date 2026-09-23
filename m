Received: from mail-yx2-f14.google.com (mail-yx2-f14.google.com [74.125.224.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13E48034C
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168357; cv=none; b=V283YvZaMXKV5xJ7yxuEBYsMdeS5ikhPg2mgaT24xKsBCxw5rFiF8DyLtfeX+EQH91fDF1UOJxx5a8EWdFV8dUzXdHfahY6Oax5iYul1wetFstmiHUid/Z3P+Jj7KSQen/QIrSok3PZNVkVJUhVrv0RWCQL6bPr8Ta0tW3AWDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168357; c=relaxed/simple;
	bh=nmnT+BxbiKicnTMIzE0Yj8KI0BLjqIhI30o2ODkPOv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsrERiSxxr22XErQtL+VpvXCxOTJpgWG5/IRwA3wDi10VPEjxptaFyfB1l+VP9OKIfS5F+V/YXI5Ar2oDpYWgw1BkmHa20P/oasMtGLdYZOURyRSCDGzEHF+oN4KcKyYVQKSVioFQC9b+eeGsEzF1W4I0wBLj/YaBPl3/F5oysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoYKXnB8; arc=none smtp.client-ip=74.125.224.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoYKXnB8"
Received: by mail-yx2-f14.google.com with SMTP id 956f58d0204a3-66e4ab19127so1066177d50.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790168355; x=1790773155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66djkRtAq3SzNbU24/rC1d9K636KQEvK0LfSphyMTO0=;
        b=hoYKXnB8+xiA4ZPHE7YKCytD6YasTNUh3yh08KVyxXjgH7BGlqXd13HT8YHAHst7J6
         Ydp9wuCo89Odhm57YFZ3AmG6XQ4VPEKG6LdynTRSZ35o7LTco7ylrn3cirEH/zY9pTgt
         vGJusFqMoLDxKdrC593PmQOLGk0znyD9zK7n7/sp3j+peGr8YGsuM3R/QO4ajV/0xhGF
         alhUNCJCRoYuPyoD2XFEHWiDqCoZXYzNjvs+3AsFHj6GwF9ABHCSOKhprCQmpoKWCa+s
         mJ6qsbeMUvGu5BvSVWhOgGeY2UW/YJQ1+W9OVbsWLbjz7EA7fkCkzTEBt9hLQEusp8wq
         l8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790168355; x=1790773155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=66djkRtAq3SzNbU24/rC1d9K636KQEvK0LfSphyMTO0=;
        b=pBPpI4L4g7/fjfhHivTkHKdtKDB3qnOzab0QYJjRPNII/zEA/NeoJJuQB5r/Es74NE
         gTV2t249UlzQuTWtiozV01WRw0H7gbmunOpXEUbRUc1m+FyCsdFKZleRJLpALYRwl/Tq
         Ly+9ChvbKztXmhdntFx+GqNvBZfPSvea7xN2JD6fm7XdDJFym4aeTLhnsuO2qTX+zEcJ
         UblBQtMaBCLTK7VRCE1mpGOPW6iKQQYiwFIQqMVK+9YO5NFzeEFB6Av31y0EoBKelviy
         SDSYx0DYrHVio+vy0yv75uyDYieOCNLsKdNSmde3CYgcpJtp2DA5hjL5uEUhH9sVl5A+
         J2hw==
X-Gm-Message-State: AFuF++kwiTdBLgTsw8aZA4p7PVpkryO6na4XD5BJC4HnWynUxRkWbU49
	8tLtbERcXalTvVhwrWLZZRjaUUO2k4RIqFdgG+yzhBldfwmLUnmGbz9PplVa0Pw7
X-Gm-Gg: AYBFou1GKgSDjwt+nl6pGhyavLupiiwjId307falLnHeHVObMyt/eCuqmfFsceZmPzP
	Qx7S8tScELRNSKtQb9pYAi6Ezf54vv3hEABK8I/GBiTPe/qthYQzUGc5FUzfm0qxalgiiYTKgIh
	FvnLxa9J8NTFTwc51foORHQ8raTOfIXvW3/JNAgKoUaVX4Q5L5L1DdgI+JHWG3k/8PbN+68bia3
	9Sk4jXyXenYl32pcMzg25cY4jf9JgVvSjJJWrRvsODKq4ski+rspRemlwljTkPK+xYjx4SjHzPA
	B592iTYAxn7JhVwfna+9vnbmqxjm1J55jiBrdXEFzNdT+AoE++SKyOw8bkZ1eetH4ecGsBDhB74
	5u9CM2ue8lcQRx+Gm2mEyNOOv2hazGXLbnOXcIGktW3iHTMl4Ciflg0Buw1m44ie31s7PLOlaIi
	P2W+/uPqV5ym6fO8EsvZPMkc+URC+CF26u6BSu8uCexe5nR4uNoX5RgHgrK6keUDvGel33xmpEL
	TkLAqm1UCyeVF80dDU/xmR4cZU0yxs56T4sALVQwOxu4TKOvNMfALZpUg1SwtcbPEEGjxQFvPZf
	Xgy8DASYyS6s/9hX+ISdfA==
X-Received: by 2002:a05:690e:813:20b0:66e:461c:428b with SMTP id 956f58d0204a3-672d57982e6mr1101850d50.30.1790168355196;
        Wed, 23 Sep 2026 05:59:15 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672d81ce7dcsm833063d50.18.2026.09.23.05.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:59:14 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	John Cai <johncai86@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 1/4] builtin/stash: remove unused header
Date: Wed, 23 Sep 2026 08:58:04 -0400
Message-ID: <b6798c8a25993913d2ba13b8f3b08d602364ca44.1790168285.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790168285.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790168285.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang complains that oid-array.h is unused. Certainly none of the
oid_array* functions, types, etc., are used, and the
transitively-included hash.h declarations are used but covered by a
pre-existing direct #include of hash.h.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 builtin/stash.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b..dfea2d2c4c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -31,7 +31,6 @@
 #include "reflog.h"
 #include "reflog-walk.h"
 #include "add-interactive.h"
-#include "oid-array.h"
 #include "commit.h"
 
 #define INCLUDE_ALL_FILES 2
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

