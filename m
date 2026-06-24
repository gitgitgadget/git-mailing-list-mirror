Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A72DECA1
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303269; cv=none; b=khj55kMbwvGs82jSmih01bPnC4Qt/qEkTRkn/0+N9bjh6hS/PsxAFqyGwcNHg+Ldz4jkLxTaCD75vdLgce5u3OH3U3dcX04hezaMXtRR0uqIavLlOf4wguRQ8XH6Y8qtxdfCX5vNOTnclvIPnIfp+aYUbmvojNzRbt7+dapchFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303269; c=relaxed/simple;
	bh=y4RNQWDK9ZOGmX7j+7ii76+nqeoaPX0P/LOtFhBkcsU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YI9JpFdk+VNFHiHYkmaSGZWEshAXn34ThD69u5xDCiybGWRBfQIiuf/FP6/MkHxKcXgfkcvlfxXSKoTd1vsoV/XjejEh5L5kn3Z9AJFok55LC+QFcLRgoynDRtoN0RrdLRoc857ZJO04c0+2nZDrEhaWN4jfpIUAOnJOBbNAB0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsrH0IA+; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsrH0IA+"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8de412e58edso11572626d6.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303267; x=1782908067; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnO6c55lDsOrocmOtMgK3MI/x1NQ3qEdxvPpiQ4Iusw=;
        b=NsrH0IA+kdT4dECvyeoN9egjldSeJ7LD1aTNk7A+MMfvNkn+Gpgi9zvI8aZNEGxUrw
         fjliD6Anaa9YDqAuYpPvWqmg6RK+aP+RK/X/Lb3h88T46cR8nyweLgQHzF9v/yRtHO+E
         Qg1r6NvJFzx0Ic9AXgOQG6TsPuZeB5/lcOo4Z3z2LG9yuZcCA7tufBssTBJk2r9Emx6x
         CwCUC44Fl+fzpKVSICT7SgsxnsC7ye8rq4UkM1CvsHztBtIv+tAS2S1RNGIYbHBwgp69
         xrxvObyfP9kkJYcZyTNnZtj1+CKpZ69zG7xSjlLbfSxbUU42vIav6lRRLb1EYt3TFxaA
         9Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303267; x=1782908067;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nnO6c55lDsOrocmOtMgK3MI/x1NQ3qEdxvPpiQ4Iusw=;
        b=aSIp3B0LleYUJNDPLTNEQ6RhqmOXZZwHUiDKtVzqm5GGc/RWkngsMXPvS29437sylq
         OHDK4H+FNNpH2MJ+8MUByYdVrHjJnv2NhmYu+RQssmyUO8FyNO/xFJVoRWDup4yPewAa
         EwT1m0xjOBJciSqmW7187uKn7XvGCnLUnyoaxd01GGNrRuGA27X48hLNRLtfd4jQi9EK
         T5DOsl4i3LVk4/MXgy9ujqcRd6yJdebyNfVcHzur4ERmBikTekTFWlc2iSLJDo2i9eIL
         c3YcluyAyLgc40u1VmxXE+2bRsq6FEWdlZmmams8wp3/ngk4Wdo9dttbVTODb7fdo0RA
         V+XQ==
X-Gm-Message-State: AOJu0YwkEswNQ+IiyVNMHyzD+6AoWgQH9iMQIMuZNqaDmnYxQfHYQVvG
	oj1TGPesuEy/gwpbCgSbt6AsgTjwUvEpLuuf7qRHizYTNsY5qhoujF4iz/7XGyjM
X-Gm-Gg: AfdE7cm06DsVV5Bht8ppXWSZpE/S+VYGxndd7PbBLRAuU4p2JShmp1jbf8CpAWELsYN
	jjHYgKjEjAqyICk/eakdIe9Z3Se5LiSjupxrSRHhE2nKYBhSa/9GhcC2As41wpM7EI5LZZx/P3u
	6/jiam/trsDdrOdRhNtO/JrvccQGoYfuGo8bvtBso5hw9lzyn8+yLi4+ZXJuyD4R2lr22T+Q4rA
	xZrK6cIeOwIHkGe4N3oURsnDi18MVwNh+fsAMGxkW+Cf730olKqENH1Tl3rvVTSkbTHmPEU/SmV
	gsSOYQcONIaV/sZL8czSSGlX8Cj3giIWyjQeWxyKCg1L7bLUpJaIgUZyd/zB3JA3bpVSaSfs0f5
	ay11JZLUGFWcbPDr4ntQNQY8ANlK1m1Miqn8caLV9Q+HoHOYzT9Udr8F+FF7nT7btxbHuzNPGnA
	QeonYH6Dn+T0GvS1s=
X-Received: by 2002:a05:6214:3b85:b0:8ca:1eb5:eaa3 with SMTP id 6a1803df08f44-8df91431b0emr336921156d6.27.1782303266797;
        Wed, 24 Jun 2026 05:14:26 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.92.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df8303ebe1sm150638496d6.49.2026.06.24.05.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:14:26 -0700 (PDT)
Message-Id: <8c72f01083237c00397dd074beda8f854e882cbe.1782303254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 12:14:12 +0000
Subject: [PATCH v2 6/7] commit-reach: remove unused nonstale_queue dedup
 wrappers
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

nonstale_queue_put_dedup() and nonstale_queue_get_dedup() became
unused after the previous commit. The core nonstale_queue functions
remain in use by ahead_behind().

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index bf102f5e28..e0d9874f99 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -79,24 +79,6 @@ static void clear_nonstale_queue(struct nonstale_queue *queue)
 	queue->max_nonstale = NULL;
 }
 
-static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
-				     struct commit *c)
-{
-	if (c->object.flags & ENQUEUED)
-		return;
-	c->object.flags |= ENQUEUED;
-	nonstale_queue_put(queue, c);
-}
-
-static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
-{
-	struct commit *commit = nonstale_queue_get(queue);
-
-	if (commit)
-		commit->object.flags &= ~ENQUEUED;
-	return commit;
-}
-
 /*
  * Priority queue with per-side commit counters for paint_down_to_common().
  * Each non-stale queued commit occupies exactly one bucket: PARENT1-only,
-- 
gitgitgadget

