Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04B8C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 03:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09D520578
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 03:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sK0W1cR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCODl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:41:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40727 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgCODlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 23:41:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id a24so17504627edy.7
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 20:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A8XZJJ0UxcYV96T6qX+qM+oDEtBWl8LcCAyvkjme6kM=;
        b=sK0W1cR54xbYOW3dG3VueZksicdAKdkea6l7fQ7xkAL1g2Y57eZin2V+OVW/03RoTW
         5VAI35hv93SFcem3YZrCaiunTpJj/uqEhCLOVPdzUAOscLMCWI+HfEEB8+aXQDWiG1Li
         XVzzblrRnlJKCplAeNxq7LtFsB/OB6o3zujGmGm7tQFggGISnPux/naHN23QW+rAU37R
         zG4+KoR577FHwc5lrq/42OM9QLM0N7COpAPVsI3aPK9JjdIxgnUe5TFfxbqui0laZyRl
         xIjOAikRFurM77lhrJuOO3R+nmN8A+lmO+xBJ6/aBTK40JyYokKrb+O6YmRruODx/gkc
         n1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A8XZJJ0UxcYV96T6qX+qM+oDEtBWl8LcCAyvkjme6kM=;
        b=KX6BA3PlO6uVDuEKGzQEnMtPF2XnVJoUrMxFv+ix0jZVR/PAiyl2suT7KCFnnVdAnE
         RmwpkddtSnp0aAZOzEuCV8vtcIXTduQatVIkVJ6h6Q57qJvg+zoFetp15fgHbtR09m5B
         5jSfgoNWaFrjaIWDVEAI9emwaiKZdmRO2tl9oAhFm90feQ32x4c+7DC4hKpgc1r5wT+V
         ccKFPd3MV58SPAtcFkwTgUg9SVfsjpRGX2m4I2ljk9J/kDDTSZzs409oTnQlmTCm03+N
         5e5osOrGmdhxrtPkmd/g/1vBpXja62lm0o21G5820B5Zkvk/j13t/14ZrA4Ii7G4ziL0
         AeDg==
X-Gm-Message-State: ANhLgQ2KCId3z1mH9mzwX+xeY1xMCx2+vyDC4QN8wxxSZRZOzcDaV85F
        drSL6NUShQSsO0Oln22d2qRP150/
X-Google-Smtp-Source: ADFU+vvKDpN0v1yfDAE15XCVxy1tMD3cd4ufPWfoCUJmweKpz1I9EvVHFxYHKViMIpZLAHrbjnr78A==
X-Received: by 2002:a17:906:4917:: with SMTP id b23mr15377558ejq.207.1584169897727;
        Sat, 14 Mar 2020 00:11:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id qw14sm841602ejb.14.2020.03.14.00.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 00:11:37 -0700 (PDT)
Message-Id: <baa4f23421b6bc245b790cdfc1fc64f5e064bca0.1584169893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Mar 2020 07:11:30 +0000
Subject: [PATCH 4/7] unpack-trees: do not mark a dirty path with SKIP_WORKTREE
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
index 853d843b17a..8f10ac91ce1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -504,8 +504,11 @@ static int apply_sparse_checkout(struct index_state *istate,
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

