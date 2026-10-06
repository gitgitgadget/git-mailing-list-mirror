Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842AA25B0A3
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270518; cv=none; b=GiPJPQqSxhxhwXBtUPo5Zz8PLiFKoKFUDHdBf/SwuyJiHe8rWO1PS7f6Al70CqHXCTLU75XI8cxdSxgv9N0vOq41klgSNiqWQ7n69OLoiddMxg4EgNAmHY19D+WWP5fRChlOQDUQkNeQkexr3MJodcPhQ0FEI1eZzc1TMZOOO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270518; c=relaxed/simple;
	bh=hy7Eq/b8XaZkbceUPYMEC4vMNBfqyrzG53dl+l+OHxk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eSUTeNU/eWOo+p2irBF+S+gRAQLQf95NIxTJqX6Dfl/oFupVKTXsPQ6f7ohr/760C4nMuuWwjcrnQI+A0I/lqkpemYSn5AqUy04+T5lBdhd4KySxyMY1pQ79FLP0EOgAJvD588roLmNyA4wUxwnX5W884+vTi7qXIinKeqdZmb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lg1b/+Pd; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg1b/+Pd"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b21f71613fso131314b6e.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 00:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791270516; x=1791875316; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6JUZFsOve3uadmF2PcqgcvJnsG5+FJa1VRvE3YJq0LA=;
        b=Lg1b/+PdgNtpj+4Wd4anUxDOQhmyAYL1IdDIsSC45bzW116Sum97HiF5VqVo6ydCk5
         oVnPR7n28NnrzMkyQYbX7V8ny2ofAVi1gh9C1DOojCmp/WkNoPR1DPckQvOntmJW0egH
         ntfsI/97QfII37ug1mSB/7GCKoGKV6fSAMLHJBerVzb8z2ovP08HM6uFitck97ZG7bXQ
         oyNDleQvwH+huZyEF7P7XfWGd2D1ZVcUtzX00cFbhqw4Kdz2j1cbKCeeLN+H6/OhCqVS
         xEz87BiOlQz1YSiLO/0awf40rfNITO60KRdB1U+BLN+00qMk4N+6tuPzzyEiRJuaJTKV
         CHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791270516; x=1791875316;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6JUZFsOve3uadmF2PcqgcvJnsG5+FJa1VRvE3YJq0LA=;
        b=GPvSF7/pP33+ixB48R0+1JYkHw2ZUrv83Wic9iaBREFKl5F+2/9WP+a6FDSSDW5McL
         rWSzkHMmY9VqX1W6QacBkGAMQ9Ed1fdXoTX9fsLzUZwHD8VM73ehcbTTl9RqFmsRz7gF
         YYCIyTD0+sP6CtAfrMhhsEKAfXfFkA6jgeznbiEYkzcw80A7ZyQXu9+3/QUpFJkIBVxm
         AROq1J5CHCpi88h8An7ZHMyI81YBVJdp0yQfMsX8OCA/+8Z9/tLqZWuiWxSZYWB7YtVi
         PrySLG61+cOFbYWdwQCB0Eeu9r7cUmNQF1TgkYzoh0xjvwUUzsWdPuJ5+MXP1BesfRF9
         8OnQ==
X-Gm-Message-State: AFuF++nMkEkQv39Pcdh3LLpr1ZkXLyg+rO5Gq7VgYkjiZJSk5FKNi/zV
	AHQg6PtPNFarLbsqjZaUZXXi18mwIbm8Nzm14hOkMW14kjurLOnjFeNJHegKSSI2
X-Gm-Gg: AYBFou1Xe8NxGg6xdDSV/JjADh3kOlB0ZUsoq3qukdvIZo/5IZq7Et1c6xivbMuXhCf
	kVnfHnGI0RZEjcZOHxtJ1J9VpjLoQY04G4qb8anrF/dh2nqWlPNW9v8ZxRUR0sKxSm36vCAN8Qv
	0gVrF4nNnGv3zPeKLwarEzWnxnKLVpUt3fjNlkk7IgYoEbCh5IUbaKf0pUAeXVw+fStgEvhaV2h
	iSrsg6K5Lw7I5hM+N/tD191qLWE8svfEAub5NFiG+T9oourmWUInJi9VCifCPRvaUdWSKzlnV17
	SiswxikOfhFla3xdrcYIvjBdLItpk2wmGOacVRqRDYZKIFOIcrCOaH4R5ffAssepnH1SvB1L4j+
	M5yLs1f8sSMzZvXA1jbUv/92Mw/3jyia4HnqjJfgIsPjOSg9rZBsk/rTSJgMNzptPHZN+nKZI1T
	doQnXSwl2lhNtLEJDng1/jlvRNCFwNOHjEnq8FiTa2mFP/tYqrJZJzupciEHxVRmX+O5WfHdc8k
	ME=
X-Received: by 2002:a05:6808:50aa:b0:4f8:716d:793e with SMTP id 5614622812f47-4fb40da0aaemr552910b6e.46.1791270516151;
        Tue, 06 Oct 2026 00:08:36 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.187.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16e3caafsm11711759fac.9.2026.10.06.00.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:08:34 -0700 (PDT)
Message-Id: <46f98796e7b07d93899f2c43c2699a82834e9778.1791270504.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
References: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 07:08:21 +0000
Subject: [PATCH 3/6] status: suggest a force push after a clean rebase
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

After rebasing pushed work onto a newer upstream without changing it,
"git status" says the branch was rebased cleanly but gives no hint on
how to publish it. A plain "git push" is rejected, so suggest a force
push:

  Your branch and 'origin/topic' have diverged,
  and have 51 and 1 different commits each (rebased cleanly on 'upstream/main').
    (use "git push --force-with-lease" to publish your local commits)

The lease still stops the push if someone else updated the push branch
since it was last fetched.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                 | 7 +++++--
 t/t6040-tracking-info.sh | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 89d142cc7e..af8d026073 100644
--- a/remote.c
+++ b/remote.c
@@ -2468,7 +2468,7 @@ static void format_branch_comparison(struct strbuf *sb,
 					_("  (use \"git pull\" to update your local branch)\n"));
 		}
 	} else {
-		if (same_changes)
+		if (same_changes) {
 			strbuf_addf(sb,
 				Q_("Your branch and '%s' have diverged,\n"
 				       "and have %d and %d different commit each "
@@ -2478,7 +2478,10 @@ static void format_branch_comparison(struct strbuf *sb,
 				       "(rebased cleanly on '%s').\n",
 				   ours + theirs),
 				branch_name, ours, theirs, upstream_name);
-		else if (upstream_name)
+			if (use_push_advice && advice_enabled(ADVICE_STATUS_HINTS))
+				strbuf_addstr(sb,
+					_("  (use \"git push --force-with-lease\" to publish your local commits)\n"));
+		} else if (upstream_name)
 			strbuf_addf(sb,
 				Q_("Your branch and '%s' have diverged,\n"
 				       "and have %d and %d different commit each "
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 2ebc3573da..4074c6663a 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -802,6 +802,7 @@ test_expect_success 'status.compareBranches after a clean rebase of the push bra
 
 	Your branch and ${SQ}origin/feature19${SQ} have diverged,
 	and have 3 and 1 different commits each (rebased cleanly on ${SQ}origin/main${SQ}).
+	  (use "git push --force-with-lease" to publish your local commits)
 
 	nothing to commit, working tree clean
 	EOF
-- 
gitgitgadget

