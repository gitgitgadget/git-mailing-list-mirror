Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7D1395242
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901611; cv=none; b=BiRnpdebPk40JUCKYVBAFQ9kO8Qf2SMwEWw4Mux+Ko4kOoGwq77yiyWZw0JujZkTok66QCSAQJkYLnBMbxQVsfa6SdjTJofVLoj0hwP5HDNMqbwx3doGEDo7P8blchtqG89XDgym4YC9l3rdaLkDTdhUNxEvuqjAgcGlNLZZ64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901611; c=relaxed/simple;
	bh=/uZxd+G51qmLSumOoMV+x6xHVkbVzO6B6gjzUoU6nZQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JymtmXFT3iFlqwnGfBjdmd9SYolrCxwWSxvgYGitKCeVVfA6u3RlY76xr0fDvk8VxsTJviaR7qQSgPfxNdTwMcJqgc07ayuVx5Tw4fSEVfqJDp5tkffPKaXaU1g55eIilnuA0AESCZ9WE87sgiS24ndJwAr80sMnrZHuac74+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSfwkOr5; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSfwkOr5"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so410619eec.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774901609; x=1775506409; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=izOlFsPJAtPrCqP/oL4XrcXv+O4j2XsYIRJuUjsJ9E0=;
        b=GSfwkOr5PBwRjg1rM38B4/+igXV/loxdye78Piw0Poy7GmkeH3aiP1fhbm96KTPli1
         EGm6zksWEyTtRG7ms4RQ/fc+5yRUxAtWADePO3U7EVKUtEMPSqOFRjDYiw9Cjvg5G9w2
         7m1NjuyvIOIuOmsybv3F+gC16Z/9Qa/w/aEUDBObE6WCpO4/wlc1PvEUmbYtOvFyM9jr
         VyGIlwUMgWCvd8a/+LvW2nUw99OxrDypcgJc6j5i7PTNNKmvD3kThyiGHAYK2tRk6o0/
         45pvbNl2xs/n9Fe43WFkyaT8ZsKsBYEhGTmDfirOoZ6b9mNZK9hJ0s4fT6iyXF5eCZwB
         BT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774901609; x=1775506409;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izOlFsPJAtPrCqP/oL4XrcXv+O4j2XsYIRJuUjsJ9E0=;
        b=rggjOkfcHGfmFTio9wEcl6YSxcHdZMkbGRkDr9s/4kuJxfGO6fT5wDFLUqQzl3kRq/
         3yC3zASnbXFbnt7JXF1rxVf9Bj2U+ZfJ7zfCZSbXJkghOvj7PZ7CJRa2Gj/jx2vd/GxB
         rJToDrNssf1qLhPYC3pF/t6oqF/7bVU0e5XwE8sT64xMNaZOLt885emr6h9ciOg9LtCi
         vsBwHaCKAdYMNqXAKEFCn8nzHdRDSbNfPNR+MoFT+jX7RJ2C7iYFAm/gJZNnK3PgO8p+
         2WmfpvJbqR8CHdGL+zYud1PAxR/JOUsy2TQ1br0MeuI5uU3JW+83nYNz0CiMS2ElHZ7V
         3kDQ==
X-Gm-Message-State: AOJu0YzfBKTTddHcRyxlZ2+3Gptmefzb1yx5EVGnVu/f1TPvrtSML0bL
	D2XQiV2rcyX8Y/NCd/jtIMuDdbs7zR/TnKxhFUb1MLGBvkJ4k39OftC9gMY7fw==
X-Gm-Gg: ATEYQzwwqpYuR/qdZuDOcUGUwBZIDztsaayjoIlp6AKGTCndJ7vPRNSTpc5wE55Vki0
	+DSfnLzY3aCV+MijcS7h0x3z83GMnZDhBR62QrTypQtJZ4ComlNIJXR0mV7qrat+vCW7hrWwNUn
	ECPQw4sd9BWKEbv3DabademCIT6+iHdxpJIYhRSIumFGY6d8vimz6ynyVACy0MGklCaSk9V+Ttb
	2SItMWil3cboM+vzYyWYXE2u9GVxCwFJyfaHAP6CGTt8cPaS6lP5xC0/49QHt1QYMmsMk3d/Fd4
	pGEHZFZEmpE39ep5vSig9A2mGCXyhlrUACh8FPkY39NWjiQ6JXDz+8gZiAsSJkEcJ1tHm1kDq8k
	ga087UOh7uOwxBdkfW8hhllkIEr0fuAINoB6niWKD98MlXlQVoOL0KehWmggbcwhsTBeJass9/J
	WOdhdwJUX5e79c6Yi2OgTyRW4a
X-Received: by 2002:a05:7300:7491:b0:2c4:7bb:5c94 with SMTP id 5a478bee46e88-2c407bb60ebmr5297545eec.11.1774901609031;
        Mon, 30 Mar 2026 13:13:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.217.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda306sm8009687eec.3.2026.03.30.13.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:13:28 -0700 (PDT)
Message-Id: <pull.2258.git.git.1774901607564.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 20:13:27 +0000
Subject: [PATCH] unpack-trees: use explicit repository in trace2 calls
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>

From: Jayesh Daga <jayeshdaga99@gmail.com>

trace2 calls in unpack-trees.c use the global 'the_repository',
even though the relevant context provides an explicit repository
pointer via 'istate->repo' or the local 'repo' variable.

Using the global repository can result in incorrect trace2 output
when multiple repository instances are in use, as events may be
attributed to the wrong repository.

Use explicit repository pointers instead to ensure correct
repository attribution.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
    unpack-trees: use explicit repository in trace2 calls
    
    trace2 calls in unpack-trees.c use the global 'the_repository', even
    though the relevant context provides an explicit repository pointer via
    'istate->repo' or the local 'repo' variable.
    
    Using the global repository can result in incorrect trace2 output when
    multiple repository instances are in use, as events may be attributed to
    the wrong repository.
    
    Use explicit repository pointers instead in these call sites to ensure
    correct repository attribution.
    
    Signed-off-by: Jayesh Daga jayeshdaga99@gmail.com
    
    cc :Karthik Nayak karthik.188@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2258%2Fjayesh0104%2Funpack-trees-trace2-repo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2258/jayesh0104/unpack-trees-trace2-repo-v1
Pull-Request: https://github.com/git/git/pull/2258

 unpack-trees.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 998a1e6dc7..191b9d4769 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1780,14 +1780,14 @@ static int clear_ce_flags(struct index_state *istate,
 
 	xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
 		  (unsigned long)select_mask, (unsigned long)clear_mask);
-	trace2_region_enter("unpack_trees", label, the_repository);
+	trace2_region_enter("unpack_trees", label, istate->repo);
 	rval = clear_ce_flags_1(istate,
 				istate->cache,
 				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
 				pl, 0, 0);
-	trace2_region_leave("unpack_trees", label, the_repository);
+	trace2_region_leave("unpack_trees", label, istate->repo);
 
 	stop_progress(&istate->progress);
 	return rval;
@@ -1903,7 +1903,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		BUG("o->df_conflict_entry is an output only field");
 
 	trace_performance_enter();
-	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
+	trace2_region_enter("unpack_trees", "unpack_trees", repo);
 
 	prepare_repo_settings(repo);
 	if (repo->settings.command_requires_full_index) {
@@ -2007,9 +2007,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		}
 
 		trace_performance_enter();
-		trace2_region_enter("unpack_trees", "traverse_trees", the_repository);
+		trace2_region_enter("unpack_trees", "traverse_trees", repo);
 		ret = traverse_trees(o->src_index, len, t, &info);
-		trace2_region_leave("unpack_trees", "traverse_trees", the_repository);
+		trace2_region_leave("unpack_trees", "traverse_trees", repo);
 		trace_performance_leave("traverse_trees");
 		if (ret < 0)
 			goto return_failed;
@@ -2106,7 +2106,7 @@ done:
 		dir_clear(o->internal.dir);
 		o->internal.dir = NULL;
 	}
-	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
+	trace2_region_leave("unpack_trees", "unpack_trees", repo);
 	trace_performance_leave("unpack_trees");
 	return ret;
 

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
gitgitgadget
