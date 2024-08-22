Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187B1CE6E4
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347292; cv=none; b=UO6ldmNPBdr8+wb0DKOHYKqzmnk2KaljM7Kh22lhbFc8DEndWB8Gx4OqHEZc+agb0ZUk9Z40lVSZE6SOXGnU0HSCoAdZLyHv+V1YVRD5/qvXiYXYODzFeu/fnIRusIRfX/AKImWkTT3RQnHrwj6Uh4tw1mTxfw/KHuA1TUg8azc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347292; c=relaxed/simple;
	bh=WEbYMY2z8c1BbgLKRfEuWyUWuRUw4BtS6ragJcQfaws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVsl/ra7W5dEVAbA7TiTfiYi7D+2l134/FlKi1Bwh5Q9JCyNW42aIUNbkky+484tMNG30vbgPShLDDbNRY2sHZ4mepDhF22Z0W1cWFR35wCh2w2RYjK1ysjNEaPmduKgZhngPhlQnEgEcxD0vR1CwODXYT1IfFptzCHZq/AAYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STOL7MM8; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STOL7MM8"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-71423704ef3so945861b3a.3
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724347289; x=1724952089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9JZs28wcUmn5uiwnJMToqYNSJ755Khwkn0ErgLyMqpE=;
        b=STOL7MM87kys33yr3I0FmN41mpEfOr9ZLjFKHmKf4TPLFo5jLIUX4dq67VqHEw1bQZ
         9NgD7M3CFO5LvGQOaj3rFFwxFE9KQCgTdt70eVS9yzuGHV18yVIZrP1UfTcc3pnbzHfs
         MXyziEW8rJJwPIM19yPKt+RM96e6Eq35rm+QTd61b8WlqpcL8I3sKBebMtuVsu78g+cz
         hNjp9PY9MAIEJ847J8RFU5ioGssdcrhEihSWpJomm5Ym4MXCm9Own7NKoKZjnMLYnuqm
         e4ZegQjE/8bMcltVDBX8bKckAjK01LAfO53AcjDArRHCleH2lCRmoY2aRST+PxInqT+8
         hpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347289; x=1724952089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JZs28wcUmn5uiwnJMToqYNSJ755Khwkn0ErgLyMqpE=;
        b=SQnpbEticSQvcAoKUzXlbppciqjZ5fOy5J6m1jNpQRtCgaHyEA107I0e0pswc/4681
         Jvyk7mpFyAPQRSQP+qfCwVQ54T16eN65jXsVyAIxL5kYjTS8YQ+s58a2Cn97Yasl+WCZ
         3w1/RfuUg3oxehXiosDE3kb6I1SyWxCTGTLYUxI78/VFEJr3Nlc4k3l7LYwLZbW3gHGT
         qF0fIKKitvtarb90TIrnR9D5mkni4QFQjc2Z6NFk4N6WLfZdE7omKLX2tNTtdERc8jd+
         Ghju0pQH/UhOTpHhkocblwD9+eJvh7vKHLn0W+AewaL02lz8NR+KnIjNbmgi/LtAJp7S
         jg8w==
X-Gm-Message-State: AOJu0YxlfKzm6SzeFMH4sSxqHWwSA0ww9PSbkp3vaaJ7nl4cgm7lbBNz
	VVomvvGzyogjFIgOaJ6WucWKbf0Gnm2IaLJhApK/aQgbID/So3alFWQdP9y9yjA=
X-Google-Smtp-Source: AGHT+IGCOKiYVSPxdyyQesXAQWKfMhsfIi7VLrAk6T6dfXa3jetM0I3fSxLgSMHJbWg3ivbwyRQdrg==
X-Received: by 2002:a05:6a00:1894:b0:70d:323f:d0c6 with SMTP id d2e1a72fcca58-7143670ebedmr3551391b3a.24.1724347289386;
        Thu, 22 Aug 2024 10:21:29 -0700 (PDT)
Received: from localhost ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm1629218b3a.39.2024.08.22.10.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 10:21:28 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
To: git@vger.kernel.org
Cc: Celeste Liu <CoelacanthusHex@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] doc: replace 3 dash with correct 2 dash in git-config(1)
Date: Fri, 23 Aug 2024 01:20:41 +0800
Message-ID: <20240822172042.54065-1-CoelacanthusHex@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
introduced this typo.

Fixes: 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
---
 Documentation/git-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 65c645d461..79360328aa 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -130,7 +130,7 @@ OPTIONS
 --all::
 	With `get`, return all values for a multi-valued key.
 
----regexp::
+--regexp::
 	With `get`, interpret the name as a regular expression. Regular
 	expression matching is currently case-sensitive and done against a
 	canonicalized version of the key in which section and variable names
-- 
2.46.0

