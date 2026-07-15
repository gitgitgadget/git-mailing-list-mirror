Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB448B39E
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128947; cv=none; b=CPEqZWV+p95Pe8tkQGBj8gdhUm7rQ1QTKYTPLRloZYPQFIbQo59mwcjqQUf3kYXQ4HIDkvdCmFyoqksA4r8fmj9QYmI+60SyGeYmVW3Dw4OXy5Ml/1PN8J7RoeClO/s+gcFk+btfrJO/rMnfuRFbHSq2HVNHBk3HODJEkEGgsbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128947; c=relaxed/simple;
	bh=ZbKJWaiRokPIg95hS4lUcOdW70G9RSWlg5z11fe6Iy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFu2p4MKxRAYjPEAaEhqeuNgtA4F9QfCwCwXzgtjbbUNLZiBAtxuD+EVmUSZDorm4O+LDioV7Tfoq12DOcFYKO4Q+Zt0bNyHe8nJRi69r2tqJqswkdop9sIeyG3LZMrrgCC2h4CnvCHE5XndaeIZr022JM5+06ON1mIVnEvU6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owpziWUq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owpziWUq"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b27c7451so9781215e9.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128944; x=1784733744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HZYk1jP3QSgGU4goLjLRm17r8oM1VBtX4tbBktG1v1E=;
        b=owpziWUq3W4Shr6pPqkdVnK7LiAAc0T1cRqxyZlJ2nS5ky4RutLP3peSXRJ3fRE502
         nugsL55Q8cl65sdsVpbrj/eTWOTiuZ85xlpezykHYRpOh+ZAXnFzc8P/jBg56fylGlRp
         n3n0wTfzSX/JzoyxuPUoEmIQblr238pSTYhLlM0sktBESuLOQr9t9PH3RfxwwgiioPJ8
         FMuMvBlg+8TjWrX3DcZkzSzZ/9LYSTBje0Pg1r6rjiuhy0b1oYSQCku33Pwe8MHEQJcL
         eyBHaQKK93P7dE1ifphShecKut6fc53ZDVnSVvhaql9YgTTGwXbG2GvpdmHOCcNEYntv
         l+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128944; x=1784733744;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZYk1jP3QSgGU4goLjLRm17r8oM1VBtX4tbBktG1v1E=;
        b=oDNOZNE6FSZQDSYkIzjzS2OG+Vdu3gfmNHUYrKa3P8xfwcCh1vORgsSdo66ymozMyl
         DOkjf+zwe2ZFB8bshaOm0Sa/SXbfK18tC5S/2nmgh0M6W0UwcYbbWYf+FWmh07MIFvVo
         gmwoqKEX8Ney0K9ROz4bjoV5PPc2E6wTt6O9Yu8iekbRl12YB8F+uxys1g75pxbRvQJV
         W8Xtq2yah5niKMo/NbytiVS3nXosuxkILttkZ2Iot6DtIWOOJryh5PkAt9Yn3VBW1TQG
         GJle/7wiSQ4Mp9Hhy4HaHZgnN63CuGlNxCIW/p8fLAVxkJ6fMtysZ+v+x0DFtsxORopf
         swIw==
X-Gm-Message-State: AOJu0YywkSpSR76i7jtNLozV891iIyeyiJrDYNJMXixgUoW7HtO8U5Y0
	El02yurHvvStavAR9ghVGzjg7iJtK2RO/5EwOsgLQxyMoJG+IhlNkA9LVoObVw==
X-Gm-Gg: AfdE7cmo/XFdEaHR6ukBpFb+oT8m3Nvmi9Gr+rrd69XEH5sbUYiK7UA1Gi2vOlu/3wW
	m3h2yCXoCta8llPctr1ELILUR1xJMtwm3bWZFo3BIgJyvrqCePSAalxPEQ0jiWHIr465mTRKT/z
	1rmBv2djyuoxFS1+O2z0HraAib46KfoOBt+ga6TYaq72q81fIFK3iIVQES1ab1wEcE4pM+jM3e1
	8p2KfalXy3yb+chM5a8qit08n0aMx27cuvRh2ICvaqoKIGuXhIobMqf+jZ0bc6Ou7iv217l1zC5
	nk1hJxAgB+gzMTA7C5DpdGpcx0yO8ku8hb0ggynk9oXj31RB3nHySqnXJbZy5ZubnC3D8RIr7uf
	32YVblleKUSlo5YzvWXdJB4KjKI/rvYBLONR5VndVHDW+vJ6bRRKuO4eVgKrBYg/G5+9pFLKrr+
	Te2SO8HlmcyQ4QOWTP
X-Received: by 2002:a05:600d:8444:20b0:493:e2c3:af25 with SMTP id 5b1f17b1804b1-493f88bd90emr146363035e9.12.1784128944112;
        Wed, 15 Jul 2026 08:22:24 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953df0fc6esm51043395e9.9.2026.07.15.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:22:23 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Andrei Rybak <rybak.a.v@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 6/9] sequencer: remove unnecessary condition in pick_one_commit()
Date: Wed, 15 Jul 2026 16:22:00 +0100
Message-ID: <e3091dee633ea59d1ed853f4f0ca0fca29d0ec13.1784128921.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1784128921.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1784128921.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

item->commit holds the commit to be picked and so it must be non-NULL
otherwise pick_one_commit() would not know which commit to pick.
It is also unconditionally dereferenced in do_pick_commit() which is
called at the top of this function. Therefore the check to see if it
is non-NULL is superfluous.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index a00e3622c87..8f3eed205e7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4988,7 +4988,7 @@ static int pick_one_commit(struct repository *r,
 	if (res && is_fixup(item->command)) {
 		return error_failed_squash(r, item->commit, opts,
 					   item->arg_len, arg);
-	} else if (res && is_rebase_i(opts) && item->commit) {
+	} else if (res && is_rebase_i(opts)) {
 		int to_amend = 0;
 		struct object_id oid;
 
-- 
2.54.0.200.gfd8d68259e3

