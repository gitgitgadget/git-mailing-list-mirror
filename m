Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1253E47B
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834009; cv=none; b=b1DbZ3CqBziyYYN8Fbc9ngF4wk2GJ6SSK303eJE3BgG0i7X3gr3XCVkTjo/kD8X4M7UGtq95grN4nDUs0Q0Jfurxz9kRS2s/jAsl5TOk1G5MQMTa6erIMgZm859gWVDrXIf0MhayaXgCFz/p0CdBSfGJGBhZ8NSnkppm1MNYO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834009; c=relaxed/simple;
	bh=xUVipBK2XPdMX30YWSax2RLZ6B5D9ibh5UAtGaMztOc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rwWVU04dzIiDxIjXS1mm+vtXgMeWy5xWTVW8gU5JWtNnlkngIXQuTgmOFeIp21wt8Wp0RT3qhQvbSsC5dVMbQU8pPGt7XnAIAo4veNrlloJfKuTELVL4O4S5mrdxTu1rZLb/rUJACA86sGxeJKkwi2sIhQOaAa9yVu02dWXlIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ6uhNKT; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ6uhNKT"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so630535a12.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741834005; x=1742438805; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANoKBSevl9EaOIVeKcMUvTLHONcyDDRY7s+8bIlu/uI=;
        b=YQ6uhNKTCxHh/P1bVPfE4cmHx/juxM/asjioMGt5sR2JeoHO7/k4hAG4mIGYbuSeIS
         9Eiyp7IsDcug11NQICG5E23RqEe3yuHF8LS9GMFzyeGq0GmLiJF1RY15ZcS/TNnIc0AK
         bjAWS2OIgm9wR1slahcGeSn7owIzsSASTG8EqaiJBgmKEnm2wpHr4biLMdWfAKxSryVw
         zRlehonZmcU+D+WFB/JCi/+fVLDUVzFLUuJyFaVDNBeeaWmKttcsSle+EjSgacMNHg/M
         lVuHSAS9LYCjzP4SIlFxTQVrrzHhROy19tTOW6zL+/vNhqV4oyDwimAP1ekWfCAX15+O
         Kdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741834005; x=1742438805;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANoKBSevl9EaOIVeKcMUvTLHONcyDDRY7s+8bIlu/uI=;
        b=rYTOrGk2Nu3Ene2lNj2ddz3aZFwgFIbdVTJZ/YgolqkO6GVie8ckFbdwr0HhE05plz
         wwnbY3Rnoz0eMbU45Vt115TQ0CU9jc0IlhVu6rcKVwujGdViwEfRiF2UoaSGqAF/zNlG
         mVIsng05e/UEAsGYCYzfEAvY6ks0sB/KCL52iVhHgzaq9RVb8wDWAMpnYd97eQfGDJCQ
         MdbXyde/VGwKgYFZOtQaim3IP7uFpkPTQlN3SFR21PZ6Sxs3WY5yVoALLx4ZJaO6tLIo
         yfOd1QXF6y0I7iC1YIpXRA0S7olyvc2h4jQ1LZ10VIcPMAeaEfz13SG3fJ4eeix88T+r
         E75g==
X-Gm-Message-State: AOJu0YxCquJCt/yy5SrRhDO6yxNeG6b23lLYyjQKtV0WULGy2kMHG6P0
	ZoreLSDqlaoDDDHuuJTFKL+z9CkfiGWaIesLOIM9e4wsyvzn93t/4kpAcQ==
X-Gm-Gg: ASbGncvoFdB9l+XdWvf8MCguc9ls5OzhIK9u3gkKtbKWTgtQTeBJiC3ScAyb8dk+HgJ
	CmPVNOBW6lhW0WGCK9oJsCfuPVHgjYvQYNK+auTWCmGArLjoyJVsGX6VhK6bQPJfkr/Qr7xClPz
	2zIoPbyynQr+Go9swOYIuSVG/QrAUzyIGYFrGS5eT5D4D28I/zAN+vLno7qC2ZLEGa7cQulHgaL
	wdYuD/BQEFvYib8/Zoy75y4KwDIuj6OeX2AVQEqETqDLQ5QFRtUu3pQO6ZpB8w4Ybt5Nme2MA9c
	FrEpb1lCdiae2k4lkOUhH0DqPIl7ILauncZ/1HFMimlzH+nrPDb7SUOv
X-Google-Smtp-Source: AGHT+IFhkKwBRmeHtn5Hh0ujJKlujp/HwoNJ93MlgS2bS78A/Zx98LxMOo1t+UfO1VqrYwd2BKr6xA==
X-Received: by 2002:a17:907:9492:b0:ac2:d5c6:43ad with SMTP id a640c23a62f3a-ac2d5c64c0dmr787890866b.30.1741834004620;
        Wed, 12 Mar 2025 19:46:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a9bcf3sm20780966b.162.2025.03.12.19.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:46:44 -0700 (PDT)
Message-Id: <f401a8e09676c9c808792665c3ffadd9d2672485.1741834001.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
	<pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Mar 2025 02:46:37 +0000
Subject: [PATCH v2 2/6] merge-ort: allow rename detection to be disabled
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <me@ttaylorr.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When merge-ort was written, I did not at first allow rename detection to
be disabled, because I suspected that most folks disabling rename
detection were doing so solely for performance reasons.  Since I put a
lot of working into providing dramatic speedups for rename detection
performance as used by the merge machinery, I wanted to know if there
were still real world repositories where rename detection was
problematic from a performance perspective.  We have had years now to
collect such information, and while we never received one, waiting
longer with the option disabled seems unlikely to help surface such
issues at this point.  Also, there has been at least one request to
allow rename detection to be disabled for behavioral rather than
performance reasons (see the thread including
https://lore.kernel.org/git/CABPp-BG-Nx6SCxxkGXn_Fwd2wseifMFND8eddvWxiZVZk0zRaA@mail.gmail.com/
), so let's start heeding the config and command line settings.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.adoc | 12 ++++++------
 merge-ort.c                         |  5 +++++
 t/t4301-merge-tree-write-tree.sh    |  6 ++++++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-strategies.adoc
index 93822ebc4e8..59f5ae36ccb 100644
--- a/Documentation/merge-strategies.adoc
+++ b/Documentation/merge-strategies.adoc
@@ -82,6 +82,11 @@ find-renames[=<n>];;
 rename-threshold=<n>;;
 	Deprecated synonym for `find-renames=<n>`.
 
+no-renames;;
+	Turn off rename detection. This overrides the `merge.renames`
+	configuration variable.
+	See also linkgit:git-diff[1] `--no-renames`.
+
 subtree[=<path>];;
 	This option is a more advanced form of 'subtree' strategy, where
 	the strategy makes a guess on how two trees must be shifted to
@@ -107,7 +112,7 @@ For a path that is a submodule, the same caution as 'ort' applies to this
 strategy.
 +
 The 'recursive' strategy takes the same options as 'ort'.  However,
-there are three additional options that 'ort' ignores (not documented
+there are two additional options that 'ort' ignores (not documented
 above) that are potentially useful with the 'recursive' strategy:
 
 patience;;
@@ -121,11 +126,6 @@ diff-algorithm=[patience|minimal|histogram|myers];;
 	specifically uses `diff-algorithm=histogram`, while `recursive`
 	defaults to the `diff.algorithm` config setting.
 
-no-renames;;
-	Turn off rename detection. This overrides the `merge.renames`
-	configuration variable.
-	See also linkgit:git-diff[1] `--no-renames`.
-
 resolve::
 	This can only resolve two heads (i.e. the current branch
 	and another branch you pulled from) using a 3-way merge
diff --git a/merge-ort.c b/merge-ort.c
index b4ff24403a1..1d3b690224e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3448,6 +3448,11 @@ static int detect_and_process_renames(struct merge_options *opt)
 
 	if (!possible_renames(renames))
 		goto cleanup;
+	if (!opt->detect_renames) {
+		renames->redo_after_renames = 0;
+		renames->cached_pairs_valid_side = 0;
+		goto cleanup;
+	}
 
 	trace2_region_enter("merge", "regular renames", opt->repo);
 	detection_run |= detect_regular_renames(opt, MERGE_SIDE1);
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index eea19907b55..44f7d077593 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -73,6 +73,12 @@ test_expect_success 'Clean merge' '
 	test_cmp expect actual
 '
 
+# Repeat the previous test, but turn off rename detection
+test_expect_success 'Failed merge without rename detection' '
+	test_must_fail git -c diff.renames=false merge-tree --write-tree side1 side3 >out &&
+	grep "CONFLICT (modify/delete): numbers deleted" out
+'
+
 test_expect_success 'Content merge and a few conflicts' '
 	git checkout side1^0 &&
 	test_must_fail git merge side2 &&
-- 
gitgitgadget

