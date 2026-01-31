Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94394366DA8
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769886105; cv=none; b=X8JQh1z/WZtpTPp8yZB6amiToUzb71xRkK0jyxpmcNLX23gYPmwXWp+G3NxH7LeNCwvsQY3id7MeCO61RRg4qsEx/ap+zPwq4fhqXW3MAPYqGlj6p8I2ar2ICuwQ2okyfstZZ0/BUuqXHJ1QPpKVxq/jmKOhY/zbC2jd1PhSaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769886105; c=relaxed/simple;
	bh=L+wRLUZqA/wFgGt02sQkZHUgLio3T6GGBoesWsto6hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avNQxTVaUh0vATg4+B4HyQlM2SE8AtzybE7eqpx6sMzTkdtxaeqdx/YL1fHhEeyRE3eouIWR4g++mWKa9SdJXNlxRRF8D48qGjq5jQUo5lJSTH01uX/kmh5mJjBeGtgCG1PSwqj0LeqMbZCqFYqLk863tABpXW/0FNRSP/+9wy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDlseEeV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDlseEeV"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso1199046a12.1
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 11:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769886104; x=1770490904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y3n7GqeFf/KtUnkaxe3r/4pSMwvYpqXGnUKO3FC9og=;
        b=hDlseEeV0bjiI+1ocLJ6JDUrrkxO6kJUvuMyY6S8s6QN55t0Nvs+Uh9l0ZSrAdAKFX
         tgcS4Xzo4FNivrAAMIAtENxyhBJ5b4cv5jq1tsISgopKl7WSgVdFS8P/LFYTSLPAp9a9
         g2Bv6JJ/2RxW/GiN9iapIhgSxqWCyqd3exChpTk3GXmFE/vf1s83n2jnm1mC7WqyQ+4M
         khQKgyEZu5Ph4pJSyD4wyKqjEJhtz7AnycIzBbNZLf3pFbyj224GQCwOH5w7IZwJ660y
         HU7hOjZ3ImmH3+o/3uOhAE3wZxF0+NfjJtdcYTcs4KJumH2lBsp6L0qu7gN26FLmk2oC
         LfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769886104; x=1770490904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Y3n7GqeFf/KtUnkaxe3r/4pSMwvYpqXGnUKO3FC9og=;
        b=rXUlOZaPmdl4z/z8nzd5tgG+d1sUZNum0N4TQy12U3JXrYWunum1sL/pDs6Z0cM+3d
         bz1nPfYyr5JMheOEQuZGvQn2QTSs018KovMf7Cq3BmXi5aZmYNRaqkl/EoQ5QWgmjLfC
         k+QJuASNWQ05nDu+0Zmi50gSxlZqoeZEfHdT8GphgdoYpZwF5W9W2w35ztq8diu4LcDh
         63wvecGLN64qUQkgim5sEfzI+AaAWmdGAH5LR1sYzo69vwfDC7xcfedk/RkaEEeKyGPa
         bXXVdXXhSnJvKMuH12r2DRnBT5jPy7FkLfcSIFfb7bfWW8xtcr6Zb7+gpali0Ml+iU61
         8jXA==
X-Gm-Message-State: AOJu0Yzu9l1TQaxCmP431FRydbBtiRe6+ukoygJFG3a4H7sv4h05p3G5
	RWXhr4/rlzwSXQVLBNc3+WlfvLNT/VSvfAlN3+cmjju/ktv1+8MCjVXDofEOOw==
X-Gm-Gg: AZuq6aJwjM3trjroNkeno3gnhg/9wDpAZh8n3U7hSU1EZneid4CFwj1JTXZRBes2UZ8
	HczRH9W84F1Kc+g2D72pbfpyHxbpSOx2jbM/OnRsl7QmMs9TZ4+5Fig9gYxcm8DFsNwkKsz/xHP
	ozQ81nlmmHp8N4nT78RtUhCQiFJME1vVe1x0rTzqjsbfESDY0FR/31ED1yqy0v/BQEKk3s+i8SH
	6ZfeUztD0WPo2teewFw1NUll9rfdz6/SvQKja2+ByXu1E17EsGsPdMAzIwajKT7BCYS7tb7IKQT
	VSi872O/R+kOHDUswEQGF0OKWYN3M9VKX01C5mcamAbHvoIq6TeuHUBb5l3lhBR5CLywhKQl+JU
	e6nX0j+iyP8W62OU59E5rIveYe+GVB7D075UqTZcE8l+9FbOyelYtZcqfw8Xsc9WJ+T96YUUckx
	I3q+MU2GaQq56IW0BOiq0mlLKzY1fOqXXqmVVGDZ5fdyJB
X-Received: by 2002:a17:90b:1dc4:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-3543b3b24d0mr7706031a91.23.1769886103715;
        Sat, 31 Jan 2026 11:01:43 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:c36:249a:cab4:59a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2cb419sm11151747a91.1.2026.01.31.11.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 11:01:42 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 3/3] wt-status: use hash_algo from local repository instead of global the_hash_algo
Date: Sun,  1 Feb 2026 00:27:39 +0530
Message-ID: <20260131190106.389289-4-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wt-status.c uses the global the_hash_algo even though a repository
instance is already available via struct repository *r.

Replace uses of the_hash_algo with the hash algorithm stored in the
associated repository (r->hash_algo).

This removes another dependency on global state and keeps wt-status
consistent with local repository usage.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 wt-status.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index eb1a3a254b..933d744cea 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1815,10 +1815,10 @@ void wt_status_get_state(struct repository *r,
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
@@ -2630,7 +2630,7 @@ int has_uncommitted_changes(struct repository *r,
 		 * We have no head (or it's corrupt); use the empty tree,
 		 * which will complain if the index is non-empty.
 		 */
-		struct tree *tree = lookup_tree(r, the_hash_algo->empty_tree);
+		struct tree *tree = lookup_tree(r, r->hash_algo->empty_tree);
 		add_pending_object(&rev_info, &tree->object, "");
 	}
 
-- 
2.52.0

