Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1103555D861
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992448; cv=none; b=d5XTTSqzsvrZcItc+Z+o0V5pFwzs04H7Ax0NpdOyD68PArvBHDXaaX9BpRds0VT5Bz0gHHiHChFyvXsUlAP90FzvawKdiOgJaIiO1yWPQfqeDO5gvi+SgoG6zKGXwvTqbhc4sNZ6D635u15d60aD+aqeLZdRZao9DtRSrAx1V50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992448; c=relaxed/simple;
	bh=M/T0O4WFm7werbpQZft8dShuNcxcqEHYgu+hNtWs3G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCpA9pkabqD5X1VNyykNtV/mqYaqakfCaasu0wLwouq3USVTAcHiQYgN0TeIReVFZGt9rcTEW9eKD+IIJG+VWf5MicvDrvjQ5B1Kj7akjC9lcDy8fEozAsnT6Hq5GYX2loQ9t6ypDyaucjGS8+RflZTeRRQ/6nmwtmKCpb7p5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nk+RI1ZH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nk+RI1ZH"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afe75f055so595682f8f.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992444; x=1792597244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YmBMpzBjUGW8YNW8Rn0paVufGdRLWO7YVdcWv5LCpzw=;
        b=nk+RI1ZH7Pdw+MHXzAb5n+Bz9HaZEkgmLAq29/lkkaygtaXK6RE1oUOg897zhuA5UK
         bIsr5G4jbC25G+vBi3nNAmltyVKAcnuRhVTugwPjVmEFGdwqghME9AW8PMyMqklg3FdZ
         k/xqQL81Wo1P8n58npQ0IaawPl8xO/BtzGQkWKiSADFQgXpdk6/qAnAgxvfWN8RnZRKE
         j24m6lKD+MeBDcHGwgO/LRaf2mkKRQq5miZU50SK1riJclWcdFIl83rAM27VJWNgqS73
         35k+7a5cEbDLikI2gprKc+OBdjJI4cGgWcnLfKyxeHNGbKYVKK0PrGFMrlO1i2O+h2gc
         YVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992444; x=1792597244;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YmBMpzBjUGW8YNW8Rn0paVufGdRLWO7YVdcWv5LCpzw=;
        b=enLNor50YZMGcqcbJxqcw38L01DJ6318Tfa1JJ6/81cWS2dSKEXFrLiYihCn7MiRCA
         1OVjNBkP5qzR2FrBj/kMusnh1oRe4KabHO7/2nPjR4xlm/T7Hg6G6FHz2o0z0/bdqBHU
         K0bIqr90lMOGJrO5YGHcQ5X6dOrEQBuQ4rgC9Dfbf2/AauyHbPr47zkbKXB2biuFMPvO
         l1CSdR8RKlejltEzmZ9PlPJsqhUmnROtYQl/FpLrdjvdtFIjDO5XVJQdykS11KkwBqhK
         VQZ16bJmJ+9x6qkw8K49PSvhj9QJdJPFCtaNjHq9DVEI0Vax8bSbdgSimyUWL62Jclfv
         j81Q==
X-Gm-Message-State: AFq9FYIRipm7uWFI/dyrElkW8PZ/ig9PWbhk9PhcXOYTRVVTzz6ZLi6W
	Giqm+uJaKYlSqG9A5nNs5434l3eY1HH4v4TzYv3MEiA8H2mhWtD28zhFvgMTFA==
X-Gm-Gg: AYBFou1ONtKNky5QOQuMbf+Eu2smwJX8JmDSRcIM/cWDctW6jP0yCHIsPluHnMismMV
	K4dG3QHA9knlf9fcPRoMioYQEKgaGghR4tA4+jSYimF/xq+dggM09jC4Y0Ck/GbsFyJvEMJxdrX
	xSuN1EZxjZ3W5G44nFm72JIdAXGsRZLDsd7Qgw6/oVCNhadwk42izJ/2LH+IkWFHu1OseS5H3N4
	Og7V2wqSwZitr1WKhp19RGHk6V3upCGvOMDklHG/LE97/58udIVRf9SeXI4y/voJIR5ZRkrFEHB
	aY2ybtZsV6Jp79iDC8u3nYgkIV0KxwouJtFr1X7Hs+GIgz3OZ3c8WXH/oZv/dFupcaIZ4FySGH1
	MkB2hj7BWfC7TmBatqisuBVh6KWzYO5uisDXmciUpaUzmsfQJan5ekU9420l5IYfh6apS2RwBFu
	mtUUR0mzEjwk3U5Od1rOOfpzjhaSXpehhFBVXpm1e7n6ESWgRBJ7CRvL3e461W+VSyV9E/5X458
	e6k/XA7jJWJ
X-Received: by 2002:a5d:588e:0:b0:48d:c186:dcc6 with SMTP id ffacd0b85a97d-48dc186dd62mr26779575f8f.57.1791992443914;
        Wed, 14 Oct 2026 08:40:43 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967acasm10324829f8f.2.2026.10.14.08.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:40:43 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 7/7] stash: simplify reset_tree() function signature
Date: Wed, 14 Oct 2026 16:40:19 +0100
Message-ID: <db53bf3b57e2bef504ad137fc1d896a2bc840e14.1791992404.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791992404.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1791992404.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

There is only one caller and it does not want to update the worktree or
reset the index so remove those unused parameters.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 55916259c3..bc1252790b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -332,7 +332,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix,
 	return do_clear_stash();
 }
 
-static int reset_tree(struct object_id *i_tree, int update, int reset)
+static int reset_tree(struct object_id *i_tree)
 {
 	int nr_trees = 1;
 	struct unpack_trees_options opts;
@@ -358,10 +358,6 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.src_index = the_repository->index;
 	opts.dst_index = the_repository->index;
 	opts.merge = 1;
-	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
-	opts.update = update;
-	if (update)
-		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = oneway_merge;
 
 	if (unpack_trees(nr_trees, t, &opts))
@@ -738,7 +734,7 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 	}
 
 	if (has_index) {
-		if (reset_tree(&index_tree, 0, 0))
+		if (reset_tree(&index_tree))
 			ret = -1;
 	} else {
 		unstage_changes_unless_new(&c_tree);
-- 
2.56.0.134.g299a3c16181

