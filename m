Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA62F069E
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183112; cv=none; b=f630B3hxmqTI0WO8mTPYsJhrS8kzszX4q687uo09BojAjxAY7v3nOJExXU4X+LpfhXt3Jm0JYZUgZmy46FdrEx8si04KtN+H9YPwU2SI/YBWRBKM3nVLVLYw2hatuGxpZBFzupGdmnD9i/32B9WQ9sT/s+MF8K6VG7h7BmFWwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183112; c=relaxed/simple;
	bh=TeIPUDS+vHz5/TMx+yGjf8YtEH83rc8jg7WK7iZfgrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mI+467O+EL7Tuk5Rxg7wI0uszlyrornpSwIEQI6BtASPAfNmnE2SF8PXj5nqi9ziaPj3CxIGbQ6VjQBQWXoABShSxLMPBBcIzWh5rAtXXuAKL/jm5GdEOCUyqqKLs/WTGla8a9nmTn3vXiVUiMRVlZ3hsgH41DY7oRlfodx7lFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+wqB3+D; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+wqB3+D"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07c081660aso116509466b.0
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758183109; x=1758787909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYfDe4BgEwoLeRMRSq+TFdffhHPG7+HnprKnPi5I8Bk=;
        b=U+wqB3+DRRhZ/iq1yF5ZEQlXBRhRAE5XdGXhACPbmA88qg/qsZEyH8zGVZ63pEdlbR
         r57NMIoRKx9SP4mKufk/acdi5P5A9CotGEd52aM/ckgUOq70I0ymQjLcPQBukKNtIhlA
         yNWbsMz5/1lWu8pfYMrWVc3E/+tSoBXwds8nnh+4g4UErQkeV2CJwb3GxnO4aiuATRKS
         zcUpGLDqm2DSOSBbfhnHDYwA6uFrwZ8/wIBSphJkVfsO8jOG32ZXsU7MPy2F9gSs1p1J
         8bq+erq+2xbLB3F3Y4scdXHlBk1FeGKpcr3fj6x3/bzYu0oULIBd0wWuoM82oLLyIhha
         WzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183109; x=1758787909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYfDe4BgEwoLeRMRSq+TFdffhHPG7+HnprKnPi5I8Bk=;
        b=A8u+/Z5O6SLCzjCoyH/d7Vmsdz1vL0gRlzPirKJSGR8+/Ykwa4WYalmlHAiI6yqOBg
         9vF5ZfGRKc6A8A+NV4KCLm8xIokjrC3ABGAS80xnjcmm4SwKXljngXcUKTRbdN71kCuf
         ZDE6zSS6uXp0Y/Ro+PIL91flsCwDcElfExjjnv2Plmquxpc/aU7PVnm4Utzzh0QwNVlM
         6rjL27IEL3N4cj0UNf1EMBZarGvQ2imU2+381E9TYNMVwCBI1sDhmoxXVCYd3er/03cz
         LuQittpX7T3NC4pF7dncGGKaTefxfpOFiZWz9BRPMYqP/O7G4zqqDSsqx3tdjUwQ58fh
         RE9Q==
X-Gm-Message-State: AOJu0YwRWp76TuDJVxmN0G5shg4Fj2PzDAS+Zser2fZZsQP1VQpmqUJP
	FHvMMIRUyYUusijBm09rP/SswJLr4NsHBqWtEAM4JW7vQJ17LaCID1zs
X-Gm-Gg: ASbGncsU0fYgQJH9vf8yzZm9E8sH8SX9qurpWD2ECaymGfzYUO7IXzdXO7jr15XjHOL
	2IoJCmmlJsSL07bQWjup912hFIEDML+SZWdfnXVBQ1KYC7XFLplwnXmRM3aX50oXK+3Kppkvmvm
	l6otqzJMO+mSg9l2J/iakcmteR2QddVPUMh0i54hvS61OQMhaOhDiOUYd7ZDbFTAsEsokFBsjf2
	TqFbIjIHNmLmlHeOp5qzUZNyvLxPb2HcOVhUoKyG/YOu7+XYQKWZdSUJqLBrigoNa0fytDRHe+9
	l++ii4ONzPpmH/YRWKCg1YVRSc6x2NwuRdecXFtFKFCTgC5IUfHAoQ9yvQKmLrIqPhPE3Zs+kYb
	Nnx13ljhXCOvielZYWRlhH5bUrBLZMsPKVsJa3WVpFgIgp3c=
X-Google-Smtp-Source: AGHT+IEvntkvkE2eT3oJRcbg/wOPac/dFAEplazX+80hxSG2TSn4J82SqIdJut+ENmss9LYFTRFSxQ==
X-Received: by 2002:a17:907:3e13:b0:b07:c94c:a1aa with SMTP id a640c23a62f3a-b1bc00ffe10mr585880466b.57.1758183109316;
        Thu, 18 Sep 2025 01:11:49 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2802:b9c0:7d04:71e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd2ce20f4sm139986566b.111.2025.09.18.01.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:11:49 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 18 Sep 2025 10:11:42 +0200
Subject: [PATCH v3 1/8] refs: remove unused headers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-228-reftable-introduce-consistency-checks-v3-1-271af03eb34d@gmail.com>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, shejialuo@gmail.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=TeIPUDS+vHz5/TMx+yGjf8YtEH83rc8jg7WK7iZfgrA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjLvsKc5ZAv0wmqJgncxhY3Twqhrpg24D12q
 tVY/cwgrNCzbIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoy77CAAoJED7VnySO
 Rox/O+ML/0aARr7q3MsTetSlWw8cq+gIsbnIqbUDJ272yIindqa3pT0mf6YXeFo3WOpEWfdaask
 XriSvewWnuQPXXT0A7RKZreDCGOs93nMaiUckfEsWry34DOX64MjtEf4+I6NJi80AYD4zZi9QVL
 /5MXqoGJhxpAfczHpZlShzjDKkCYEIDmKcCI7rsLMFqVWHYrXX4leJ/uJIGwXsM6t+uTI6HLDPL
 Ljztkd7YS9mOJBap8Ju6g9zieMQA8gtFyiR8G/eBohhXGCK/bIs1eWgmFfghYpV5WtL7uGOqf/m
 SF/s9ViR2udQHL40uid1dtk1pf/yL65cBwWJv2RZVS+PunfZF1SPJvMVdIf+2SggOW6NUFGOI9d
 hYbR0SPr9D1wRctcWoqUU7zIyF093Km2ZwEbofOdtCFENj1asuKxbEhGYTdvz5URZv93c7DMhJY
 sy90wXRL+NeaX36FBc6kURLLvGFTG6gXlHnX08yNHqPsZepYE81Z2fe4MUBdgfcH0UZXzmhqfY5
 7Y=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the 'refs/' namespace, some of the included header files are not
needed, let's remove them.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/debug.c            | 1 -
 refs/files-backend.c    | 1 -
 refs/reftable-backend.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 1cb955961e..697adbd0dc 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "hex.h"
 #include "refs-internal.h"
-#include "string-list.h"
 #include "trace.h"
 
 static struct trace_key trace_refs = TRACE_KEY_INIT(REFS);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1b3bf26add..d4fb033417 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -20,7 +20,6 @@
 #include "../dir-iterator.h"
 #include "../lockfile.h"
 #include "../object.h"
-#include "../object-file.h"
 #include "../path.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 9e889da2ff..2152349cb9 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -11,7 +11,6 @@
 #include "../hex.h"
 #include "../iterator.h"
 #include "../ident.h"
-#include "../lockfile.h"
 #include "../object.h"
 #include "../path.h"
 #include "../refs.h"

-- 
2.51.0

