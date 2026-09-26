Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BF3BE632
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425054; cv=none; b=SXwvOReeKpp07Td+o+JOuk18To/MzejTonIvNm7ny+WpkDy8nNWdDFcgi/bBjO1UVEeuPwwfKz3YWaqceO4RuxYaIpVAQvzBC1ofbGuYSEEuWgQ2nqcZctnWUdC821/V3Lk1Jn4KUCLeOMR7wc6WxoL+s/5Kq6bKy35rZtKcw1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425054; c=relaxed/simple;
	bh=nmnT+BxbiKicnTMIzE0Yj8KI0BLjqIhI30o2ODkPOv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCIPFt1wqUrwxr2Nm1mUfKlgcCSY4vDpeMCNtExqToLd7ttRJ4/hp7Z36PnAYOK8RjSTzfzh4we5VXIYksNaDhDXesOpHa/n8drFPpK/8FHxKyxm5X6GzpuaE2Hox+xBONMLh0juye7iaJIcplqjmVd4M9Z6NxGfN50Y4E8s0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdzEznB0; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdzEznB0"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a8878695e8so4271307b3.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790425051; x=1791029851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66djkRtAq3SzNbU24/rC1d9K636KQEvK0LfSphyMTO0=;
        b=DdzEznB0X35AsuXkOP90Wag7kE9PkDeOdX9Njb0Ea11g66ezAQLzbHzAk/tR2E7/VG
         TLqEw22VtYtcqRWeGrzwazqay/egauJH/p8y5WWbP7SHWO5/HC8G6pK05Qd4tRub/JuI
         KrK9cdgsSJr+QdKSDpC8lLgoloDcH7x9WpSOf4k1NH0yoHv3Yfvrpv9VkQfojKJWhffh
         g8G9n7C5p/pSkfzaOzTmAPYG5fqgW5sQ4MRI2ZSi9Cd3kdEjfE9U4uj0eV8Z3DR6ilYG
         yCcXL0ZlCc22NV+KtV8f6erwreC8I1dORgybuhKiz63NEVCM4QbCj4DEBU/UwlCBps+e
         UlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790425051; x=1791029851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=66djkRtAq3SzNbU24/rC1d9K636KQEvK0LfSphyMTO0=;
        b=gqWGp6sy8OCpE/scyA6d4+WwQaglxuiMwt70F24H68oI5xcr3TrGnKT9GsQYG0Hk3Y
         o0DV4XgFCft2Z/fLuB6sR/D5WfC+rcRNLwBdGodfjrZXdxFqppjVs6rCa+jAaGs9lgav
         owB2Qu3PPd6HvC9porhzmLZxiBGqoCmiedPTBsTR7HRPzQWKe1qGLwZAHgwMniIg3oEk
         ux6ar0Sh5w8vj1vzm1PMTPKPO5My1fYtZ046YIxTrBeZY+E8IWyrZZbNJbZbrrMGxNUT
         mDRKwNfiOrT3cEQO/w3d/LHKjD9yEukFS3onlDExvZqtN6N94z+rMiJXLC14DZ/VrAjw
         Qfag==
X-Gm-Message-State: AFq9FYIPdAi2dKUyjW2FzIqQOZM/uI7MwPnLBRiD23CKipzLX7H8MnAI
	BdewDtrNBE2DK0nTliq8PKKEg+GiW+yJZYcmRlth/ohDfBLk3cvjvMQ8LXK6TPgd
X-Gm-Gg: AYBFou0ErU0PAdpNqXwqDyCL0NEEBKyWRxpL082Fqrs8oWLlpnqfZCHYDqW8yyjWFFb
	EAhLUC/eXtJDpsDBCroZz3+cq5wc3vVpsW95FJvqmvUiGwmP+Fj70F2ETgOqvgGvhUvV+IcCoX0
	NOOtzu0EyvU3CRBVKLZ0acwvSvN+OK5TL2A630++LOulexFL+YvK9Hy3q7IQbJybXqjCAlus6Fh
	f6jz/j69//A80BaBqFlFyS3CtFaODVM5qOg0RBw0EJ1JwjrOqEy7Kx0VlpPac6mTA6LFAmG+3cd
	h04qtNCxiLxk40L3oC+H+c84k+mz2NWNBjHPL/RSvQMffRNfiZ80PsWRjzr8jByTWJa9MemSlS+
	mWw5EsUIaepl5CZPSUbDjB+dvz0TaDG4ODWIP12Yi6yc0qyTzmYcIFZahHxGK7Zwg3sD45AmT48
	TW4qWR+shLQwtqbtUnO71qOpGiP+l8MscitYO6Z/FZIQnXuSgwrbOJUjurqi9Y478WipmjorHxY
	NVfPhyWD/fDI6du6riHx+AloN5YJBEos8s9m7FZWa8K2Mt1nrlhWVeKhL3uwRu10RNwBqv+LKLi
	37XIKrN6IoB0evr5m9cSDQ==
X-Received: by 2002:a05:690e:d43:b0:674:98a:23a3 with SMTP id 956f58d0204a3-674098a3b8bmr1991792d50.45.1790425051569;
        Sat, 26 Sep 2026 05:17:31 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ee9d17csm2179151d50.5.2026.09.26.05.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 05:17:31 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/5] builtin/stash: remove unused header
Date: Sat, 26 Sep 2026 08:16:44 -0400
Message-ID: <6a165c4df456b6bd5e5ab46664b023a45e670926.1790425008.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790425008.git.ben.knoble@gmail.com>
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
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

