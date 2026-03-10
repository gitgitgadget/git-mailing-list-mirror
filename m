Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252573A7584
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144623; cv=none; b=JVtnkS5OhOD3SsKyvTYpctmuVyU5hkkLLt38pl7RpaM9RCpMcpGaZ19uYtB37ohPZlTZ5vX6GJ1MMGojYcs8Ua3N1NCv4DEEZZeJH4JcJxRYB9BKSSMNKj8MTOggcMOfxvLskZR7dhHXcL1ACJsXM0QG9VKcqn0U+xhne9w5Jb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144623; c=relaxed/simple;
	bh=Q4aWdm8z5Y/jzE/cNn66HOdPvFbATnVtNZ7sLltPxUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBaBXE9Lm5Th2xDjtkqYBYTxLFpyWcXhyE3PKLRv3UZrHz1Sc6PpeFqSOdgbfpOy7Sy8CCw4MvJeAhYNJ5yPUHLQC02vVppbirJHBlxBruLPdNeEKy192qm9Cs/BV4BX2zFsZxwFx7hEd4DmScJF0gGS3hw/vRVcCOpn73hedNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXCsYbOY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXCsYbOY"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c739e680bebso1070544a12.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773144621; x=1773749421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=feU4gYh2dasZaL5Qlr3idxXyhVESH7zckcNnujcr28s=;
        b=QXCsYbOYBF22eEd0j5xyCXdGJwO10ah1hB6vPnFUNnZ8qSLdwP6Kl6MywX44u2iZCN
         u9iLcv/ootoD/LFzJL6Tk9XnO9Ex5qsJlglG8MCM71YLMvUkPHzlohau7XWCOzhU9D6G
         ND6Uwb7F2LR9p93Fb6VAxe9eWx/xxR1bE5xD+vxxTTFbhWtHslB2tLBJJORAoOKcnPS7
         mGY+82li8+rt4jIzXSVpamyDYvMjlEhuuY0Mulw8I9XXdt6Ska+IT5yTR2zhR3SEaLxL
         MO+4MYgyo0hE8cyvbhUn/M1FDdfK7OWgZSQTAB9GEYX6xlB4F/asNfqw3ku4Xlo2C9zu
         VLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144621; x=1773749421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feU4gYh2dasZaL5Qlr3idxXyhVESH7zckcNnujcr28s=;
        b=cix0USkFGmeqqB+Z6fU+asDwn+OLms8tfelm/pdxtekxTJRtKBsDwKM9MUyQDaYGsO
         SvuKAb7s9t3bv21Jm3oGJsHw7o/lY7K1eZwWoAcdFAceJO8tCgnzUFUAEI/ObSSRHETX
         nQ3EmbAy44mvWM/0fNOu7MWwr+8TRbiK1rH6VRWWu/PegGxPR1BEa6AKyKzExer3oGKN
         bK1eag1kKj4DzX+jyVt1vZtJd0dLGXl4eP5WXAzOlcOJHOKlePQ2LUR504prb6HY7V6v
         JVn7YARJtF5pkahuUp7l+r2ByCPTxcySqML0tBBMfIzqFc/ZQtTboilEL0fRIUooByZm
         Ifmg==
X-Gm-Message-State: AOJu0YzwJZG0dc/USLPLpr7eIvGymI9kpVwwkpMuUo7MlJv0Y8k/y18r
	6Z4wocGwvZ5N+MGBZDX43hLN9wHPdQriFVJd7f4hXeCoYa3T+s+E2spo37CfZSVbYHk=
X-Gm-Gg: ATEYQzxEO3XdC0O7jlyvhliemXMWK93BMgw1aRIu7vzcD8AlVlOOshQLpMYwqlbFLC+
	M/thA7A2NgBT6ZtjbdQcokDv3fHIuRcGlV+wBWyJh06YdZsGIfizLm54rXHd9QNw7CtJNykaxCz
	Sosres5NU5M7W/CX1YJcfJKqs5mmgz/OArCyP41u+EFDMm0c/up7vVUcwDeHBjbBHy2Qy7r2iYW
	zaQrY5HTaUtc7hHP01KTPCwStqlc/H2t5XhXjGl30whZqkEST4btXGYlvDIgWwQt6T9o6GoGQUD
	di7l+ufn/TwTDBb/w52vCuiHotE3jpTlykohsl6wCSXrj1SYejxJqCzFUkWlAbhsQTIKoi5bpK4
	uf8pRllUL0/qbxFgWcgrVPlvw+1JIMq80GRioK3OgXEqHMlKy4i5YARG6Nle0JdmMLf8esfLwqF
	i8JdNFkFC5I5UZQriB42bmaiGh1H1KHkDi0ilRvMhiJyyMuT7Mqh5kZ/qE3BeY
X-Received: by 2002:a17:903:a8f:b0:2a7:c188:bd1b with SMTP id d9443c01a7336-2aea2040a5cmr29238415ad.25.1773144621068;
        Tue, 10 Mar 2026 05:10:21 -0700 (PDT)
Received: from localhost.localdomain ([14.139.107.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840b6639sm208978345ad.86.2026.03.10.05.10.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Mar 2026 05:10:20 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH] submodule--helper: replace malloc with xmalloc
Date: Tue, 10 Mar 2026 17:40:13 +0530
Message-ID: <20260310121013.39291-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The submodule_summary_callback() function currently uses a raw malloc()
which could lead to NULL pointer dereference.

Standardize this by replacing malloc() with xmalloc() for error handling.
Also, remove the unnecessary type cast and use sizeof(*temp) instead of
struct name in xmalloc to improve maintainability of the code.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 143f7cb3cc..f3e132888f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1160,7 +1160,7 @@ static void submodule_summary_callback(struct diff_queue_struct *q,
 
 		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
 			continue;
-		temp = (struct module_cb*)malloc(sizeof(struct module_cb));
+		temp = xmalloc(sizeof(*temp));
 		temp->mod_src = p->one->mode;
 		temp->mod_dst = p->two->mode;
 		temp->oid_src = p->one->oid;
-- 
2.51.2

