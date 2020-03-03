Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCB1C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 07:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461F020CC7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 07:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYZ9GcGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCCHXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:23:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41198 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgCCHXV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 02:23:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id m25so3011579edq.8
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 23:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Biy7iHmmMbMTz3Q/6fDz6eodDgMg8IA4JMyLRx7jJao=;
        b=MYZ9GcGJEf9AXcNP07EVZGp7PL2mh5MTuIpsalVHaPeNEN4aUJ3sR3stSfL/ZCbfFk
         WsofKBLW+4dNREdXZ0E6xwnUR7pmMfXKeSNBdwzjxS3EBJGWkI72KHB+90O1NVgJ0gaM
         CNhcTWOv2AK7+8XhWEC0gzv0mPnKWNjRn59X/Sao+uxAf+CiTI+bgM7t4HoPhBG6S1nB
         CHPe8Ocoss5KD6HgZ3kKnG7YdNRmqqkJEF118tNUorY/KdQK3R5yi8HCyVp2fWNbjaFi
         fdPzk5ZfHozQR1hgoSJcM68hUkJlfAeOLLW34lyoJEUaa7W93edVT8PXhmKUQwm+mREA
         rNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Biy7iHmmMbMTz3Q/6fDz6eodDgMg8IA4JMyLRx7jJao=;
        b=VNKrezhu05bH2s0wCu+MrMUEubnt5Hrn32LGvVlcjR3eDPyE5jTxblOZAyLfd7E1xE
         V6IyOLlGD0iYsAe2stUdjt7+1k5eoNO7QABWaMEQh+mYCPB291f4KsGZAYMmPljG2ZTG
         Q7nNJZwUMpgb0/B/gRBBp0pRWzHsRgE0UQ/yqtgansbH9IoVxxUTMQXjtldvEYzw39om
         yNXpm1MukMcfrz7+A342YC7fwPWaAUeEVvqa7rdWFT3hAZ6YtOAS24nxiM1875eD+HBq
         7CaXTsQ+3htSn1v9ajvWDEOZMWWc0KaFHzRr4lNTUmKGmoWbaE0fniWSaAsomrMbGk92
         KzOw==
X-Gm-Message-State: ANhLgQ1SGFBV6QlLMq9bexSHauRFizuFwRwqKGM47vIGWRglrxYz9/Pp
        Tn/DoiA9JD9YUEhm2j8cmhGJ3LtK
X-Google-Smtp-Source: ADFU+vti+poxqXtJw87Wqok0c6OiNqf2AvJ7Wm3joqzAjHWlLoCDGgckPj1vNo19vF/XuTCObH046g==
X-Received: by 2002:a17:906:ce3c:: with SMTP id sd28mr2789629ejb.273.1583220198910;
        Mon, 02 Mar 2020 23:23:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3sm1229126edj.2.2020.03.02.23.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 23:23:18 -0800 (PST)
Message-Id: <pull.719.git.git.1583220197856.gitgitgadget@gmail.com>
From:   "Takuya N via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Mar 2020 07:23:17 +0000
Subject: [PATCH] doc: use 'ref' instead of 'commit' for merge-base arguments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Takuya N <takninnovationresearch@gmail.com>,
        Takuya Noguchi <takninnovationresearch@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Takuya Noguchi <takninnovationresearch@gmail.com>

The notation <commit> can be misunderstandable only for commit SHA1,
but merge-base accepts any commit references. Like reflog, the name of
arguments should be <ref> instead of <commit>.

Signed-off-by: Takuya Noguchi <takninnovationresearch@gmail.com>
---
    doc: use 'ref' instead of 'commit' for merge-base arguments
    
    The notation <commit> can be misunderstandable only for commit SHA1, but 
    merge-base accepts any commit references. Like reflog, the name of
    arguments should be <ref> rather than <commit>.
    
    Signed-off-by: Takuya Noguchi takninnovationresearch@gmail.com
    [takninnovationresearch@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-719%2Ftnir%2Fmerge-base-supporting-refs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-719/tnir/merge-base-supporting-refs-v1
Pull-Request: https://github.com/git/git/pull/719

 Documentation/git-merge-base.txt | 10 +++++-----
 builtin/merge-base.c             | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 2d944e0851f..b87528ef269 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -9,11 +9,11 @@ git-merge-base - Find as good common ancestors as possible for a merge
 SYNOPSIS
 --------
 [verse]
-'git merge-base' [-a|--all] <commit> <commit>...
-'git merge-base' [-a|--all] --octopus <commit>...
-'git merge-base' --is-ancestor <commit> <commit>
-'git merge-base' --independent <commit>...
-'git merge-base' --fork-point <ref> [<commit>]
+'git merge-base' [-a|--all] <ref> <ref>...
+'git merge-base' [-a|--all] --octopus <ref>...
+'git merge-base' --is-ancestor <ref> <ref>
+'git merge-base' --independent <ref>...
+'git merge-base' --fork-point <ref> [<ref>]
 
 DESCRIPTION
 -----------
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index e3f8da13b69..910916ae0ec 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -29,11 +29,11 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 }
 
 static const char * const merge_base_usage[] = {
-	N_("git merge-base [-a | --all] <commit> <commit>..."),
-	N_("git merge-base [-a | --all] --octopus <commit>..."),
-	N_("git merge-base --independent <commit>..."),
-	N_("git merge-base --is-ancestor <commit> <commit>"),
-	N_("git merge-base --fork-point <ref> [<commit>]"),
+	N_("git merge-base [-a | --all] <ref> <ref>..."),
+	N_("git merge-base [-a | --all] --octopus <ref>..."),
+	N_("git merge-base --independent <ref>..."),
+	N_("git merge-base --is-ancestor <ref> <ref>"),
+	N_("git merge-base --fork-point <ref1> [<ref2>]"),
 	NULL
 };
 
@@ -158,7 +158,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "is-ancestor", &cmdmode,
 			    N_("is the first one ancestor of the other?"), 'a'),
 		OPT_CMDMODE(0, "fork-point", &cmdmode,
-			    N_("find where <commit> forked from reflog of <ref>"), 'f'),
+			    N_("find where <ref2> forked from reflog of <ref1>"), 'f'),
 		OPT_END()
 	};
 

base-commit: 2d2118b814c11f509e1aa76cb07110f7231668dc
-- 
gitgitgadget
