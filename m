Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2E3CE0B4
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803557; cv=none; b=DmTWe56YJjWkv+oHbwxIw2r9XiQyJYLyS57NBdDfIFLtAAdgwYZusZnPHcLpxAdVVnfRY15JbpQksWevcl03HLytR0phndeuzpZDuucGd0CYyuLBEiGzed7t4AtHlXlQ7Ixei65jc1WotZDC2JUkO+lgmnNRHkXPw/KlhvEKB20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803557; c=relaxed/simple;
	bh=iFbATzSByS4KoIJ6R3JC3mwPeXjTvZGPjWJO7e/f3uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7z7g3jtbREDXEGH95kQ1PUwtYsz1ilpJBAt/E5HCnPoE6H4c+cVE4181F9AZgz3dgBSRtvdLEv4udEKRJ82u6APAXDoe/UewbktqSSj5Z/jnZ4YiLHm2MRJuQl1m0/kHWf3RBH2gycXZWVN/vOgxvKhmtbNix98cgYznsqrKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jlj/oGXI; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jlj/oGXI"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-67109935888so5666064d50.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790803550; x=1791408350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iCGeIqksKzJu6jJVXbC95dqQk36fJrk333bHNaB1ODc=;
        b=Jlj/oGXIY480popDmVaHimIMtTJz0VzCFkDMlk8eJSxZSkMHYqZOQnZ37IloarBLiE
         6+pAZ0jdwl541FEcquED7tqaK4E4Ixeu4Fpuj0a/WuGT/Em+1K2kmeAWGW4VP/DGKYRr
         ibju57tA5ysf2o8u0WEqd42TYAkqci0iSR3Efpv7g4yrNUr6WBCDzh+MI8Egd0hy/pxI
         srpex+VXM4KXKCSE6AsR6UJ1F3iGTDhx5iItMJni28wtJR/8zvGsrKrdfgVvTVyXn1/J
         PQc/odXuMyCQ2bQJOdMtGocmLpT0OLVOq+p9yfzA67pBpGVs0foypVFV78OnRFaEJGK1
         5iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803550; x=1791408350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iCGeIqksKzJu6jJVXbC95dqQk36fJrk333bHNaB1ODc=;
        b=DE8hgOZnVjiIK+lylc+TrL6JjHXdLzp50ZePqFePE535JMHAqd9vqtsW/Ns6MCeWjK
         OqYU3rbaEgDUuZkPLhMBG42YLz9qjJLcM3EISDJhM54mzjBBvSVMYlj4O2VGRbbVVtmM
         JPyXiJeYIKY7M17yV+bQsyK8uydvx6bRPgROgHoZFMuWTu/Age6Cfpvx/COOLy+uLrdG
         0XTutkS0FFm1vTg/HUl1i0CZ/alH3tJaTanq+oziS+3B2Alez2M8Oe279nl4ZP1pGrZt
         7JavUEIe2Jh+ncLSsXIhOMn/uRZYjTq9c+VtunUKCn2DNieZLEtb9qT4c2aJkN86YWqv
         0pzA==
X-Gm-Message-State: AFq9FYLmIRDM2+oDltMVV/NG/IDsj4sutRmvZZ7EKYLfoWbKc5+4czCf
	CPLVbrbCXrnsEyw4u+SGecCOQ5W1AjBgDQ+LzaRBPAblTY7PzYnO2OAB7Y+aGwZb
X-Gm-Gg: AYBFou1N2c/vlxJmEZ5i7UGlAztHBt12+Y2ry5KG8I+to5g80wW4KV5vCWN9h+L59CH
	nyhL+fXAmUpnocjCEBJcYylFIuCXF3qtgxikLZmGXrlNanxHkiZfaaBRUKLSX/1dM26skLWeId3
	Hx3bcZIQMkbonATiTcSIrVqdLNAyT1kIuj+LvwHilRIYSJHBbYMDRW6HsVnNYee3MJhUGIDsS29
	cpgcjAsklAAk/BpVja1H4XduBHKhFChD3hmwMYOfXsNA//T3VcUbjz+8tBSspwNs/GcK7WJKJCz
	vyXywm5XBczVkisbhScM9yI7KjepeTCVUUXSb4/RScC4jzJBqVCX3xNXDJi6byKCJOJz7QhZKq4
	8baZ5/5B1qCkjCqnI34URaihQEynKIhTDvbgkqiMs16kYrSQMnZWw60O8eqRY/2rnQXc8pSVl7O
	v2JAgtPi0NH8lcHcwx2DkbHHpJOwU6Ed808rHM03+AImYDxcaxB5hy7+qR8R9WEtLyugvrymykY
	E8I/v1MJ9N9sqBpchK8PpO5wwFZTJZBSQxSsmceasvYUQg7OUe8S5x2cnaq2oSKIBjBajsbIFez
	ijnwecaMvMfnkIvQwgKEDQ==
X-Received: by 2002:a05:690e:b8a:b0:671:70d2:5292 with SMTP id 956f58d0204a3-67683507d94mr1759529d50.85.1790803550486;
        Wed, 30 Sep 2026 14:25:50 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67691a15e97sm264063d50.20.2026.09.30.14.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:25:50 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Antonin Delpeuch <antonin@delpeuch.eu>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v5 2/4] stash: prepare merge options earlier
Date: Wed, 30 Sep 2026 17:24:39 -0400
Message-ID: <8e99033ef025003c35bd82069ea89b1509e8bd9b.1790803471.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790803471.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790803471.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a future commit, we will reuse these options for the index merge of
"apply --index", not just for the worktree.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 builtin/stash.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index dfea2d2c4c..d2b736d4e6 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -664,6 +664,11 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 				repo_get_index_file(the_repository), 0, NULL))
 		return error(_("cannot apply a stash in the middle of a merge"));
 
+	init_ui_merge_options(&o, the_repository);
+
+	if (quiet)
+		o.verbosity = 0;
+
 	if (index) {
 		if (oideq(&info->b_tree, &info->i_tree) ||
 		    oideq(&c_tree, &info->i_tree)) {
@@ -695,8 +700,6 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 		}
 	}
 
-	init_ui_merge_options(&o, the_repository);
-
 	o.branch1 = label_ours ? label_ours : "Updated upstream";
 	o.branch2 = label_theirs ? label_theirs : "Stashed changes";
 	o.ancestor = label_base ? label_base : "Stash base";
@@ -704,9 +707,6 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 	if (oideq(&info->b_tree, &c_tree))
 		o.branch1 = "Version stash was based on";
 
-	if (quiet)
-		o.verbosity = 0;
-
 	if (o.verbosity >= 3)
 		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
 
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

