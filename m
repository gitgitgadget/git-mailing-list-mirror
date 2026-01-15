Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258739A81F
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768481813; cv=none; b=CUUHA/1WADyW7DcYP3z2/OPWnoQmNXGXbst/q4ax63WMe1czu6d+zl/uBKTdAIUK0G9IHte26R8wxN+Jy4JpOii14IzHlsRw0yZMUfZ34GjLCArPw+dvJ7TyVjDMzuPZBOS9JEb8cuSiikJh+mmLapbrwUIgHQXNmqkSN0Zec2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768481813; c=relaxed/simple;
	bh=TJ0LyJsa7SZws6EJr3yQRkL9LNrEOh1a8Wu9ZL7FxFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aka9Ybc+0Gr8cTs/SjOIfe4gPY851UlPf4Eotu/LIWCeLUHbZzMexd3dKnHC7URhFCkIt0Wz52mPJfc7tM37Wb/sg1DqB+yEuO99PFc55OZ8aXIYS0rfVVHc2qK1ojVqMrvshATvZi1Qf+LNzSJRGCrS5Ap4SFPdbNPDXBzfhZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+GuOrDW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+GuOrDW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801bc32725so2687435e9.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 04:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768481810; x=1769086610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiKE9+1GWR6Sk1i/TDDMHCgLrb2FsSwgC1ot56k87/U=;
        b=d+GuOrDWQWPslMTCG+UQWPxRwqt8ru4oIJsmmghaaAOxZRw/7CjDrRK1CJH3m411/1
         gc88PWFt5GSNYSKy49fMq6APb8X5eSgsHpES+zoFxpOOyjvrmkLOWA6dBYGbjfXH3+gJ
         zJKfCMZEkmx1OEUf8WNUB8IlWHlfkDKzgjE73I3CAu4EOcuJ+quiunXScoWbTgKHYBHU
         oq10YonTkePxC0JSIiqdfGEuVqs7RkWhkSkXyi1V0jsTcigYq1kvWx9Fq0vu66WOJe+Y
         NkoAhEjaIP0iIvmzzT+oiY3/Vl0NQ+k3PYLQH4nMNTIaNSeyE2hEOzsTMvhzN3mXqHw0
         3xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768481810; x=1769086610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XiKE9+1GWR6Sk1i/TDDMHCgLrb2FsSwgC1ot56k87/U=;
        b=XC2KOPxMa5UTyHksrIa6xlC6AfXfJCwxO84OhBt+lpaoIDqbsY+Q1RT8yAj9FmQyf/
         OW7FCZUhXAs/e5hkKRjkLPbuvZoIJr49mJSbZK6AiKbjsDfUOInTfe6aGdKmK9xEZSqL
         SStSnoMD6b4Jf0x/NZKKDZtzYRYBqE8QQeq4ftmfMpVcCf7W2wpJWcyPKhW9rwA1ffJg
         /zsIRMBwLjF2V1XCiQiAjEgMZ5A4c+sm5xYuR33c8kGwLX1Lh9oTDbyonHpRhhi8vpEM
         TsoAwGwO/c38n0HFX+dj1fMGbfIkHLCyZqdMCyo9Jt5UCv5UV2oV4jLl74ZJePLU2M2c
         ziZA==
X-Gm-Message-State: AOJu0Yz8dOQBbfgWUimSFO8X5m4aYkxcMgcNA+sCZwuSKbvxd61DQ81r
	QG8Bicr4kk+CoFYu4fGU6CHv1tCaVAUepF0bb0IJrQECNCSliPfz6bX7gvX1Gc1r
X-Gm-Gg: AY/fxX5syZ1dBXxuo6fs+vFvoMeKA/cFdhH3kgw4/zlGV05XFvZO3hv/Ml7Y80evA8u
	f4QPy8uQTRcyseVApiB9ekpO/ouD8+eB68R36gu6VKMf7IXy2ErAjqXU6L3RO4bI4uK3JGZbhhK
	2gFVrln250+RZ801CZth+JAwS/aqhbpzpimxZDGyy/sDVFY2M5cUQNMjOPVuyCcPRpOQ3kn0x8m
	2kIAm+UP8tVuV1zOhDBGqdoHqNi6/JlymQeyR9lgNsRHxC1Aw2/0QGHoNiK4neRCDZpHB0qkx5Y
	EQw8XXRmvG9fenCrDa8DpelH7OXrwYBn9kXqhPkurAsvuXnoZ7GguUNKIVuePMvjuiQAOmJ78P+
	8PCwOyJ1r4iD8GjAviODiM3gn/sGu/KWJ0dxnIZwU1Y6D7K1+vs7d7tPp8oTc9KZ724OStXKH0f
	56OIZj0JnckYNDVtDFA8th8/fAsL/qYZetXiBPlLniqejraOIxMyECT/QTE21Cds/cgCU=
X-Received: by 2002:a05:600c:35d6:b0:477:214f:bd95 with SMTP id 5b1f17b1804b1-47ee33517b3mr61060885e9.23.1768481810064;
        Thu, 15 Jan 2026 04:56:50 -0800 (PST)
Received: from localhost.localdomain ([115.98.235.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f3b7a5f94sm48886435e9.0.2026.01.15.04.56.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jan 2026 04:56:49 -0800 (PST)
From: amisha <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	derrickstolee@github.com,
	amisha <amishhhaaaa@gmail.com>
Subject: [PATCH v2] sparse-checkout: optimize string_list construction
Date: Thu, 15 Jan 2026 18:26:37 +0530
Message-ID: <20260115125637.90345-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114192803.4852-1-amishhhaaaa@gmail.com>
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve O(n^2) complexity to O(n log n) while building a sorted 'string_list' by constructing it unsorted and sorting it afterwards.

Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 builtin/sparse-checkout.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..edabe7cbd9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -91,7 +91,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 
 		hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
 			/* pe->pattern starts with "/", skip it */
-			string_list_insert(&sl, pe->pattern + 1);
+			string_list_append(&sl, pe->pattern + 1);
 		}
 
 		string_list_sort(&sl);
@@ -289,11 +289,10 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     pe->pattern,
 					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
+			string_list_append(&sl, pe->pattern);
 	}
 
 	string_list_sort(&sl);
-	string_list_remove_duplicates(&sl, 0);
 
 	fprintf(fp, "/*\n!/*/\n");
 
@@ -311,13 +310,12 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     pe->pattern,
 					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
+			string_list_append(&sl, pe->pattern);
 	}
 
 	strbuf_release(&parent_pattern);
 
 	string_list_sort(&sl);
-	string_list_remove_duplicates(&sl, 0);
 
 	for (i = 0; i < sl.nr; i++) {
 		char *pattern = escaped_pattern(sl.items[i].string);
-- 
2.51.0

