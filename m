Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2985C54FCE
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A57B20663
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwc1bBXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgCUSAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40463 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgCUSAR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id w26so4784687edu.7
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZXHzj8F9/88N7Ll9ROZJb2YfW9vEw6moimkoWXGdYoA=;
        b=hwc1bBXMsvhwQb2mAfRwbR+0z8uzLWRvMyqXqykwvnF0PA8HV+OtlO+i6BajP9eSg8
         N6iWHDoNOztFedxXfmFxkhJNd9V0+KCXZQrJ4/sC84jEcNCu975VlyBlbnfA0iOsPy3/
         Bnn7iQevVsfAdteH/DdIcOdLJRm67Jmti9nGDMiGbdHbwFerOK/YZ8Bi9n2H2sHGyITA
         oen0AZh9f4WF272daoZl4qZefKRhW51dMEw4JFpdalqNaT5Xf+P70LREyNU54lk6+ik8
         v+JpgP9R0QLa61ofrMCHEwWklZXGvlud1/+7lWyF6m2q62+7opKOWjIhgl7j1aHArcJI
         H55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZXHzj8F9/88N7Ll9ROZJb2YfW9vEw6moimkoWXGdYoA=;
        b=VNDeiVz4SCwAFskFOy7U3aF1hiHSmbu0ei4VLvSCYmity7DBkwxbGDQYOCGGDzh1a5
         Bjgrap1XnMJzMAZPRHH7RoATYJI3clJTJV/vIDFq/SPY9gcd5ne8/U8IAMW8qrxAo8Qn
         7DkI3eO596XfvwnmlDijn6zu0bNYluBHObmoKMPYr0RD24DbeDimoPLDBRpDwZ0UBdoI
         t+6MNQRD45u2YKk6DACSoljkl+yPYttOjx89uEl2Xh1b6g7+7s1gDl1DBgzls+LAs4VL
         pcoaMCeP4Ryu3hXmplOhrnqxyTySi1uBC4sUIlQ/bmtm7bpmdqJPqzbNRKekqrmYTh9N
         87bg==
X-Gm-Message-State: ANhLgQ1O5HlupI3nnZGWfxHGmYPx6aeihsKqzrM3FDdic0z9+GkyYQV2
        oJwE/g5+bXjoZ6YAJ++vmO/OfX4R
X-Google-Smtp-Source: ADFU+vuq2vV9FY9PMp4zSvRZ+cZEfYeuQ8OlW+NMWROOEaLzoGoyIC4yP76FMv/53h1Glf52mETkNA==
X-Received: by 2002:a17:906:86d5:: with SMTP id j21mr13581134ejy.230.1584813615235;
        Sat, 21 Mar 2020 11:00:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9sm633798edl.35.2020.03.21.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:14 -0700 (PDT)
Message-Id: <3d2531ca8187ac6929f1c3b293682706e6da668d.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 17:59:58 +0000
Subject: [PATCH v2 07/18] unpack-trees: do not mark a dirty path with
 SKIP_WORKTREE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If a path is dirty, removing from the working tree risks losing data.
As such, we want to make sure any such path is not marked with
SKIP_WORKTREE.  While the current callers of this code detect this case
and re-populate with a previous set of sparsity patterns, we want to
allow some paths to be marked with SKIP_WORKTREE while others are left
unmarked without it being considered an error.  The reason this
shouldn't be considered an error is that SKIP_WORKTREE has always been
an advisory-only setting; merge and rebase for example were free to
materialize paths and clear the SKIP_WORKTREE bit in order to accomplish
their work even though they kept the SKIP_WORKTREE bit set for other
paths.  Leaving dirty working files in the working tree is thus a
natural extension of what we have already been doing.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index dde50047a82..e8e794880ab 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -500,8 +500,11 @@ static int apply_sparse_checkout(struct index_state *istate,
 		 * also stat info may have lost after merged_entry() so calling
 		 * verify_uptodate() again may fail
 		 */
-		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
+		if (!(ce->ce_flags & CE_UPDATE) &&
+		    verify_uptodate_sparse(ce, o)) {
+			ce->ce_flags &= ~CE_SKIP_WORKTREE;
 			return -1;
+		}
 		ce->ce_flags |= CE_WT_REMOVE;
 		ce->ce_flags &= ~CE_UPDATE;
 	}
-- 
gitgitgadget

