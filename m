Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDE2BD0B
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876051; cv=none; b=RYiYi00lyexau9vAX6iJoJfLDBC+oY+93aFYu4dGJA0f1wlBTdMGFgYSClZe47QQhWlcShnflhqnqdgrrzwItaQv94+o8/Ikwy7jjcKiz6p5HfW3l+h4RVu8aa+WBbGFo1UZ0jxbRGCtE+9Ul3tWcOjkewO23lDgs6W5jtSVzJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876051; c=relaxed/simple;
	bh=2NzM4bZHhPX71SSEQtxvOXBOhAep6WN+eutJcXKoYdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mCk5xsueOGbhp5J/EeTEfT6DHBKrMQseCVQwLQ9chpAckic05xbeARNzEE80GpnEqFx1VNMA7Nn/Xi5529DbVJnZnUV/KMSp6f445lrBTI5/XAo0oIU+I6pWyJ1oa3ktWv2+NlAoOB6UYiJCrJ1GNj/V7raqomSTKqXDmUPnFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeDcbG5l; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeDcbG5l"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso18216975e9.3
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 08:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769876048; x=1770480848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IdOlw3rdQCk72p5g1qXKgBdIjz//hlsGRq5nlwMMHGo=;
        b=LeDcbG5lSsyP8ptgLgEl8NDRIiquAMnWJoYI8CY4LxZmjUb2OhMr3Lwe4N47Ny8enF
         NDm1Cx15/PXyt8vl6WAhe6FKzKj8v4kofezeF38zO3ZxSsCvqdHeFUmlijz2xBNpl5nk
         APmBCU3HmKOL7bw76/onZ5MH72nz7kcWjBAsreYcVh2z0SSAud2FSx8LxVEdLwkVZpmU
         Gs3rETWGJZvZRYY2wYSW3fxz0GcUc1WEXqj8DmToPcJLU8JR9fHoiZ+3N3U+byaLzYcU
         9ulq7a3U62b6FTmNaFr0J/bZj95+s/J2d82XDBohS8LOWYg0+P87YWRKw7FLpaDrqGlN
         ZgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769876048; x=1770480848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdOlw3rdQCk72p5g1qXKgBdIjz//hlsGRq5nlwMMHGo=;
        b=BCvvw/reNN639vBhY3/ACf1cHAMGxV4QuuvUx/bUB7mSBKUu/Y8i+e5bXRKStluPW6
         h9f4R6z/enyxxSBAwFBKCSuxrzYRkZplSCVFdg83gGYrqQZ5rjrnvJYEqIcRwNYZsm5e
         bOCu0ijZ0213M7qI/v1FnDVbcZF+61l94xT/Yn7q+P1YuF4ZfDp3pjwIfROlo/TSvL5z
         i0dKWJ+j4qHQYW4hkyluqkHRRXBTz3If9Yk34HeQkMAgr+EGHDyFvJjcGkXLfQZfm9/U
         1XF2XODtQm1UlsZ+iK3ip5wuhx/SR/zPu3r1gU3FeBgOCfbH68Po7/bxGVj5kiYl2nLY
         Z4Vw==
X-Gm-Message-State: AOJu0YwPyUeLg9Yv2LEgTZH+JuKxTWKJiPtvBnUk9nB+2RkCT32vTFJn
	4RWewjhzrN7DOzU2qdvOffoNb4jcGPa5xVnvoam/aQhMndYwpkZciw0xwqSlYg==
X-Gm-Gg: AZuq6aKEQ1PgOOoecinMqR71vZSNQB+sQ6rtPs4I9qC21A5xCFRm0/TLADa6gGzR+Da
	VY4Vq555GZNoJ/GxSF2WrZj/n6zpCeRdpF7YML879f9mg/rjqHY3+UXL4OTulvGorQNwWugpp6x
	rqTnJkKESt/mhaprAglIIaQBtSF0PvNSEOWT8B+e8ABW2akvOhlHzQXPOUisBuBT1GqMCyhLNPk
	FYOQR79rsPNi4hJ+dzmr/TjcbLbBjHs1/bn0vGTqQ5E1FonQRKtxd/jHPIEhYRVBqx2eexIQHzg
	au1ONxJj0UOmz6/4Yp4w9JI9TN0kqa/7wnpZhn726AK2gUS2YfC1UDdRzb5DH3RG7RH90QRlVYS
	OtOb+YiZNj3WOPRr8GYRI/G9uGn6zrDsV4cfoiOlF1b5dqPDRz5sFW0ELzyIQ6kaqyVaihhWepo
	APZSxETAxTWGbMeypDdHfuEPCVbpeVtrGhMqy84ESCRVmc52Y20eNaRMUE
X-Received: by 2002:a05:600c:1e24:b0:480:6a46:3616 with SMTP id 5b1f17b1804b1-482db448890mr84802445e9.4.1769876048361;
        Sat, 31 Jan 2026 08:14:08 -0800 (PST)
Received: from localhost.localdomain ([156.210.131.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbd0cb55sm53660995e9.6.2026.01.31.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 08:14:07 -0800 (PST)
From: Abdalrhman Mohamed <eng.abdalrhman.abdalmonem@gmail.com>
X-Google-Original-From: Abdalrhman Mohamed <Eng.Abdalrhman.Abdalmonem@gmail.com>
To: git@vger.kernel.org
Cc: Abdalrhman Mohamed <Eng.Abdalrhman.Abdalmonem@gmail.com>
Subject: [PATCH] .github/CONTRIBUTING.md: fix broken link to SubmittingPatches
Date: Sat, 31 Jan 2026 18:14:01 +0200
Message-Id: <20260131161401.48693-1-Eng.Abdalrhman.Abdalmonem@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The link to SubmittingPatches documentation was pointing to a
non-existent 'Documentation' branch. Correct it to point to the
'master' branch so that new contributors on GitHub can find the
submission guidelines.

Signed-off-by: Abdalrhman Mohamed <Eng.Abdalrhman.Abdalmonem@gmail.com>
---
 .github/CONTRIBUTING.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
index c8755e38de..e5d696fd42 100644
--- a/.github/CONTRIBUTING.md
+++ b/.github/CONTRIBUTING.md
@@ -10,7 +10,7 @@ conveniently send your Pull Requests commits to our mailing list.
 
 Please read ["A note from the maintainer"](https://git.kernel.org/pub/scm/git/git.git/plain/MaintNotes?h=todo)
 to learn how the Git project is managed, and how you can work with it.
-In addition, we highly recommend you to read [our submission guidelines](../Documentation/SubmittingPatches).
+In addition, we highly recommend you to read [our submission guidelines](https://github.com/git/git/blob/master/Documentation/SubmittingPatches).
 
 If you prefer video, then [this talk](https://www.youtube.com/watch?v=Q7i_qQW__q4&feature=youtu.be&t=6m4s)
 might be useful to you as the presenter walks you through the contribution
-- 
2.25.1

