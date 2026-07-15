Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC8481FAC
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128946; cv=none; b=kkSqLL9vqnrqMdtfwrFeJj9Q91UQBTQuXnMBXQQtlxgwxgE3PM3qdL5kLuW13Zg5ak1aup2GjbWoKeQ6m+vZkOst8T0Zfl9t0gBP2qBZvmkmnJBZhuDQyPD0m9m/TLzIVywa4KfEcJzTY1+V/DLS6V6kBidC+2EUvILnwBDxiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128946; c=relaxed/simple;
	bh=jWrnV3GgTRfyE1I625jLOLpWB3fN2dZMR3yNw4rlmZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlKrbHWwjjRnU+FIUGe7xahp/bUf5+O+ymNljA6MFAe88/6UMDnlnOR1afETR4YtgLi0eqOfy7y8Es2DPH/sG2GYK5TxyeiJAIe65sHvrlh3yj2HbZg4lsFrEiB6unM7lG4ky3YHkNB7hQlvc7ZPg/V4baLGnFxd39JVsGKVea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkQlo5Db; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkQlo5Db"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b1710405so30604725e9.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128943; x=1784733743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TWYpdEsTVBQyfde6bxUz0Go4UhHQXhM3f7UCcUs7OfU=;
        b=FkQlo5DbgHLh5YRrlEBdqza+l/BkMicDjgnDK43KZrGS5EapjKnR8RX4ESV+6fYDzl
         SDdGkGa2YqBNfAJDKMus+38FgNJ21cfo4T+olv7YHcWJgk1On9LlYTdfsG6y9aMAs6qy
         yyFuKEJU5shM0gofI1JsGUlHm2VR5itr2aQJ2pvNcWno+qEsguuClr0KrN1ogH0z8HlD
         CjMFDPe4x3UuIrcfn5R9OgoQ+Q/arKxpXTMTtB3NP92LGlsLRvmrWdrXojehYZDbmc2m
         InnLXu1eOW8TWrXB7ftpJCSgdE0R7/RcXV+iSv7ar5udaEh4yAB2zLEh7R66QYCf0uCt
         oRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128943; x=1784733743;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TWYpdEsTVBQyfde6bxUz0Go4UhHQXhM3f7UCcUs7OfU=;
        b=XAhRPoNxi8HWoMdOQdXCDjGsx7X/cyAbt/WPZ11+PN6ZYA9paRUKiMRYSZMyuryhoX
         /oA66w/7E4bfQj3DK76HHGVnn7KKl8cmEpYO7FXGq+mm4LuCL3043pr0c8ku6T5/zNxA
         Gyoui4rUYzCeqx3Pzcjs3nokwqY6Q1djx0YDxzAWl4TEdFD96WqTeg3Pi7CAq/71dqyd
         0YTsQcrfdz4mT3ItsASsJyq7A35Szsn1kV/ExeTPuALvrJZVzrX8szeBiJLYzemJoVdi
         kRXUmm+S/lDJKpV2K0psRjiX5Q5AD9yMraV9+8yGKMdcvrLJP4nyTQwdbLm8NFSMlJyQ
         RnuA==
X-Gm-Message-State: AOJu0YxjjC9D2cSHQsHm+Kyt5gH1ZxH1WJ4fcUYg9oBzjckxlilo5pQV
	YxoZg7sL23sU3yPpHbbW25HH3ZKzjNJ56D2w0q0sewDsZPUyWZWsKwigN28bPQ==
X-Gm-Gg: AfdE7cnr/Jpc3YCS37I1yLhSChCGU7Q6IlC4RwvCXWRpF9xKZfbZW402NBxeWInhTKT
	A7nl2c/HwGSeEejQWCG/R6T0PsAiyVzyFQ80nVoGI1jc4Iwi8Bp+V34rWEIgZeirz93bRo3qYNK
	bhb3zF9vF7CPG2GC2egV/T+tysUJf/1XJSwB0eX6Q+UQjM00HiV+EXNN8nxpmyro8608SkHJHK6
	KL7hm2/jnenXaG92Ikko/3O13v4T2iI1pNwRLNp+DuUilzTPL6CtcisuVsTSgKf5e4K/pGrnHNp
	/qA4JFjgoz0ZCXjzqxZ1z5hxBnjeHf2FlXELGM5I9SP3httqc3qHSpYT2qw86H8orLxgX5VFcDF
	38KZmy5Eubq4Rneu/sL4CMl8YVrsqf+3V9+n/n79kBH+J/pxP8lQTyVkWXmOo2yB0KmUhAVyLeC
	fZjF9I1jtkJ0dQ1BQY
X-Received: by 2002:a05:600c:8119:b0:493:f744:e7d5 with SMTP id 5b1f17b1804b1-49518324f47mr89574035e9.38.1784128943083;
        Wed, 15 Jul 2026 08:22:23 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953df0fc6esm51043395e9.9.2026.07.15.08.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:22:22 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Andrei Rybak <rybak.a.v@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 5/9] sequencer: simplify handling of fixup with conflicts
Date: Wed, 15 Jul 2026 16:21:59 +0100
Message-ID: <134d8f7e935f28da90ddd78883c8f0aa8705230f.1784128921.git.phillip.wood@dunelm.org.uk>
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

Commit e032abd5a0 (rebase: fix rewritten list for failed pick,
2023-09-06) introduced an early return when res == -1, so if
we enter this conditional block then res is positive. After the
last couple of commits the only possible positive value is 1. That
means we can simplify the code by removing the conditional call to
intend_to_amend() and have error_failed_squash() request that it is
called in error_with_patch() instead.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 70e12eab0ec..a00e3622c87 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3874,7 +3874,7 @@ static int error_failed_squash(struct repository *r,
 		return error(_("could not copy '%s' to '%s'"),
 			     rebase_path_message(),
 			     git_path_merge_msg(r));
-	return error_with_patch(r, commit, subject, subject_len, opts, 1, 0);
+	return error_with_patch(r, commit, subject, subject_len, opts, 1, 1);
 }
 
 static int do_exec(struct repository *r, const char *command_line, int quiet)
@@ -4986,8 +4986,6 @@ static int pick_one_commit(struct repository *r,
 		record_in_rewritten(&item->commit->object.oid,
 				    peek_command(todo_list, 1));
 	if (res && is_fixup(item->command)) {
-		if (res == 1)
-			intend_to_amend();
 		return error_failed_squash(r, item->commit, opts,
 					   item->arg_len, arg);
 	} else if (res && is_rebase_i(opts) && item->commit) {
-- 
2.54.0.200.gfd8d68259e3

