Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99EC2D6E4B
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770458638; cv=none; b=GK4zDlPOh4KmvDq5pP93rtRHwy8lKWVtFM09CYrtmqyJpEuuv8JVw5/qhepoT8qnvXtkgQlsD2+J222laZyzqP1z40Y2IGdeFAQct55CTZpNunrZESJzSM+hxhq0xFhzE8N2+8LGhn0NVNyNG+MO4S7HKzQ0XfJMwGRDjFYt6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770458638; c=relaxed/simple;
	bh=X29kNDdlJDwYGmPJom38f/gekWD65RrkpkdqE2ffj1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8UJ45sFZeA3rWrfXdQEwoFmi81EKVCqGOAqFXE2zm9vRnI32bgJuru4HzcqJWiJ1y9Li+jnpV/AkATOEHUvp/g+HUD0pe3xCYDLC230914ttxNOfTaqUrrAv0ZlEefFMgIdjW0hA4huRMxBcLcey4mTuatwj7beN9vvQAL0JVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0qg0grb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0qg0grb"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81f4f4d4822so1638727b3a.3
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 02:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770458638; x=1771063438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s04YQE25uGCtQnG35cw4tNx99ZgNsISw0qu+EupQgws=;
        b=D0qg0grbv9G1uwtdJTkpx0OyijIeQi9/f0pl6WbozoM2RxkcyutMGeHTdQdeLrX3uL
         tb7m8tyOtYitv582s6sMmQQvSgLsSKC8CVV2qhXmezOkYv1XWVyrFXl6QtneywUWLD96
         SUmbCCtc8WXwpd/X3DVHBx0PiciULLo00Cs21bQjRDPE9zxTnMc9KYFRe1sWaYj1T/+3
         iCa+d3diE45uJDMYs/RK8F0q5iIATtaGgQaAxU8wApWeeLY/bD8H373KU5r+kSJsMhTv
         shEJHIZD2tJvyB9QB7ne54AvaLBxyd8nX1BTLnI+j06eRNFrlgh3dCqJ/EikrGjcD4GB
         Eqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770458638; x=1771063438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s04YQE25uGCtQnG35cw4tNx99ZgNsISw0qu+EupQgws=;
        b=r+JEyebnUqHckNLN2o/IhuIUWRQqR3V9qsY5thu00wY4KxovQ+IF6EHcKjap2lq/29
         0HfTQQPGbLk1j0t+e96dfRw7zo/M/ZftoE0RJbYVeJu/EJJHAO0oOQ2nIq4QN3cxrrWq
         mq2ZASke4KGXHB9Pga0LYzfqTR3OaX8ewxRefee7me7sSbHQpzrwS8UEaPDvkU1M0Y1c
         2WHsaVFHxXXxv6YPOAYftvHgF4o8yMSLywRxIKlb8xhot0Q4La+rY9bq5JWJ+xTKDZLc
         NQy1fYmMGbyMm+J9JGDtAkocUA5e1IuoOP90tpRC0yOr/oi8g19VcfOEtYq/ZFVWlJki
         rTLQ==
X-Gm-Message-State: AOJu0Yyv8uXXLr4DrRbKLX/d7Xhaozf/J0KGFUz99oYRSWg9UOu5ebe/
	++1CQmpaP7RAiYDPzxr3kugr1a6scSOScMfRxidjFTF9u7U7Y/YvT04Cmb8/sg==
X-Gm-Gg: AZuq6aLzww1mQaSLAILvnGM1Xo4hC8NBQBYxUQqP17omvSyZYVdmc5gs+R/wRgeb0uG
	dRah85JaxTVVqU4lMLmGmDcWmJ9Q92sJSj+3IBB7hx3dpU16Nlva8Cpxx1vZIa/rnytvFRs4Aj7
	LsTNYlCGT6k/USk3hvBEgM1eMbUrI3I9tNqekIhQnf4DwffVTydI/BwUaTFO5vKPb4fruRXFv1F
	yalNuJekb0pIDf3oA2xi6D0GTtRfYU9ipHAPs/bOMWyq2VzIjStMjNHcpOeOUp67AWhjwJT2ooo
	sKCO0GtK+MndoyOJMF+sZRWUuxBJaR5kW/qXjHoaXWYREMAOtsNSi6g/hO8TfmBRnJxt3m6OaPG
	qXvD0m5dNNeLiI02lGs0edWvkkKv1phe+JfShd4cdGCeCdATWA1gb8ieJIElxH+ILOwmzwIJ9wU
	ja7QkEu3L6TURQvzJSXES0CT06rbaqZA7hxHWE1WkoWlwVGQ==
X-Received: by 2002:a05:6a00:71c1:b0:823:f96:63bb with SMTP id d2e1a72fcca58-82441755e0emr4267757b3a.52.1770458637826;
        Sat, 07 Feb 2026 02:03:57 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:b151:d56:3281:2879])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418bf024sm4435362b3a.56.2026.02.07.02.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 02:03:57 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v3 3/3] wt-status: use hash_algo from local repository instead of global the_hash_algo
Date: Sat,  7 Feb 2026 15:30:48 +0530
Message-ID: <20260207100322.1786368-4-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260207100322.1786368-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260207100322.1786368-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wt-status.c still uses the global the_hash_algo even though a repository
instance is already available via struct wt_status.

Replace uses of the_hash_algo with the hash algorithm stored in the
associated repository (s->repo->hash_algo or r->hash_algo).

This removes another dependency on global state and keeps wt-status
consistent with local repository usage.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 wt-status.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 0270d544d9..b68b3d3fde 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1817,10 +1817,10 @@ void wt_status_get_state(struct repository *r,
 	if (!sequencer_get_last_command(r, &action)) {
 		if (action == REPLAY_PICK && !state->cherry_pick_in_progress) {
 			state->cherry_pick_in_progress = 1;
-			oidcpy(&state->cherry_pick_head_oid, null_oid(the_hash_algo));
+			oidcpy(&state->cherry_pick_head_oid, null_oid(r->hash_algo));
 		} else if (action == REPLAY_REVERT && !state->revert_in_progress) {
 			state->revert_in_progress = 1;
-			oidcpy(&state->revert_head_oid, null_oid(the_hash_algo));
+			oidcpy(&state->revert_head_oid, null_oid(r->hash_algo));
 		}
 	}
 	if (get_detached_from)
@@ -2632,7 +2632,7 @@ int has_uncommitted_changes(struct repository *r,
 		 * We have no head (or it's corrupt); use the empty tree,
 		 * which will complain if the index is non-empty.
 		 */
-		struct tree *tree = lookup_tree(r, the_hash_algo->empty_tree);
+		struct tree *tree = lookup_tree(r, r->hash_algo->empty_tree);
 		add_pending_object(&rev_info, &tree->object, "");
 	}
 
-- 
2.52.0

