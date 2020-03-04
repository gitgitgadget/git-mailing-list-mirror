Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8EEC3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 12:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28C52166E
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 12:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7sYRzYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgCDMih (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:38:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54590 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDMih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 07:38:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id i9so1890265wml.4
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 04:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tiYwo/CiXH7KPHDOgmALLtVgUOSxa+5saMe3rg2HtjA=;
        b=g7sYRzYDfXok+0C84CfkgPUZ8RB8kUnlhT3meHcEzzJumijAy1JZovvEYZ/HJgsc1+
         GGWmrHDOsBG3KG+AdXc6RRb1vAKRgtvN3uZSppj6QrQaqDwEpRHpQG1Z/cX0oibLcTPd
         wwWuUhySSk7i7etdr1FdFyg/sLNaOm7dW7nOlFfFnbMGmt+GMb4ZJAL+joAYko70Sdfh
         rYDtVftoQtJArOPQnqbUEl3EsHyqXEchyLfZoy20K4bHu5/M6SWRP9rGf+ZJv/FYKxcq
         X0sFGvQVrTeA6bfGtrSDw4/kSZSkciPadj0z49HA40E50qhHVYTd5M3Zb+DtA1GHfLr1
         kFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tiYwo/CiXH7KPHDOgmALLtVgUOSxa+5saMe3rg2HtjA=;
        b=t0UXqh+UvQh/XT85mSuYYMUp3dX6Tx4zsE/GTe0Jh/yIXCY5M6eQJKuJWt/xOZWUP9
         bkR/npmf+vxOH21EsDFDc1Di7v1PEEmQ2pYb14Lc1JKHh/hfcO4Grpn410/GoPiq9qf5
         uroN/ocCNcoGJK0afNaZ2+l2peIr/ff5JVwat5w9tPjneZ9dI7sTnRhQ+cRbxZu/K/XD
         pat/x+w4LjrTpZaYkjCc48py2oLgnYWaQO2LdO9ZWETsx89w99BAUXIAXBgZ8J79R5mk
         19X8fSOKNJ23bI4zhdjkhWAOSbSoPTq5iEQqGtZAfVwP639NNwQXQgazujKIPBjVKO3a
         wKEw==
X-Gm-Message-State: ANhLgQ0S9PuCyReMeZ2I6lhrGkqtrHMpmENSVXO12DDhidhQxhFVLzHf
        z/IFAJm6AITD0+HWR2iHGiTwwwIX
X-Google-Smtp-Source: ADFU+vuznr9N1iMMxShciM3DFNozDqBwo2hbK+ww1X59q2ib2M9VGM6QkhfovWdgcrJloIbMVf268g==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr3489497wmj.0.1583325515461;
        Wed, 04 Mar 2020 04:38:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m25sm3821846wml.35.2020.03.04.04.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 04:38:35 -0800 (PST)
Message-Id: <pull.719.v2.git.git.1583325514607.gitgitgadget@gmail.com>
In-Reply-To: <pull.719.git.git.1583220197856.gitgitgadget@gmail.com>
References: <pull.719.git.git.1583220197856.gitgitgadget@gmail.com>
From:   "Takuya N via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Mar 2020 12:38:34 +0000
Subject: [PATCH v2] doc: use 'rev' instead of 'commit' for merge-base
 arguments
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
but merge-base accepts any commit references. Like rev-parse, the name
of arguments should be <rev> instead of <commit>.

Signed-off-by: Takuya Noguchi <takninnovationresearch@gmail.com>
---
    doc: use 'rev' instead of 'commit' for merge-base arguments
    
    The notation can be misunderstandable only for commit SHA1, but
    merge-base accepts any commit references. Like rev-parse, the name of
    arguments should be instead of .
    
    Changes since v1:
    
     * Use rev instead of ref, not commit-ish which is less used than rev
       through the document.
    
    Signed-off-by: Takuya Noguchi takninnovationresearch@gmail.com
    [takninnovationresearch@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-719%2Ftnir%2Fmerge-base-supporting-refs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-719/tnir/merge-base-supporting-refs-v2
Pull-Request: https://github.com/git/git/pull/719

Range-diff vs v1:

 1:  9c83cf1c620 ! 1:  6e2157da4b1 doc: use 'ref' instead of 'commit' for merge-base arguments
     @@ -1,10 +1,10 @@
      Author: Takuya Noguchi <takninnovationresearch@gmail.com>
      
     -    doc: use 'ref' instead of 'commit' for merge-base arguments
     +    doc: use 'rev' instead of 'commit' for merge-base arguments
      
          The notation <commit> can be misunderstandable only for commit SHA1,
     -    but merge-base accepts any commit references. Like reflog, the name of
     -    arguments should be <ref> instead of <commit>.
     +    but merge-base accepts any commit references. Like rev-parse, the name
     +    of arguments should be <rev> instead of <commit>.
      
          Signed-off-by: Takuya Noguchi <takninnovationresearch@gmail.com>
      
     @@ -20,11 +20,11 @@
      -'git merge-base' --is-ancestor <commit> <commit>
      -'git merge-base' --independent <commit>...
      -'git merge-base' --fork-point <ref> [<commit>]
     -+'git merge-base' [-a|--all] <ref> <ref>...
     -+'git merge-base' [-a|--all] --octopus <ref>...
     -+'git merge-base' --is-ancestor <ref> <ref>
     -+'git merge-base' --independent <ref>...
     -+'git merge-base' --fork-point <ref> [<ref>]
     ++'git merge-base' [-a|--all] <rev> <rev>...
     ++'git merge-base' [-a|--all] --octopus <rev>...
     ++'git merge-base' --is-ancestor <rev> <rev>
     ++'git merge-base' --independent <rev>...
     ++'git merge-base' --fork-point <ref> [<rev>]
       
       DESCRIPTION
       -----------
     @@ -41,11 +41,11 @@
      -	N_("git merge-base --independent <commit>..."),
      -	N_("git merge-base --is-ancestor <commit> <commit>"),
      -	N_("git merge-base --fork-point <ref> [<commit>]"),
     -+	N_("git merge-base [-a | --all] <ref> <ref>..."),
     -+	N_("git merge-base [-a | --all] --octopus <ref>..."),
     -+	N_("git merge-base --independent <ref>..."),
     -+	N_("git merge-base --is-ancestor <ref> <ref>"),
     -+	N_("git merge-base --fork-point <ref1> [<ref2>]"),
     ++	N_("git merge-base [-a | --all] <rev> <rev>..."),
     ++	N_("git merge-base [-a | --all] --octopus <rev>..."),
     ++	N_("git merge-base --independent <rev>..."),
     ++	N_("git merge-base --is-ancestor <rev> <rev>"),
     ++	N_("git merge-base --fork-point <ref> [<rev>]"),
       	NULL
       };
       
     @@ -54,7 +54,7 @@
       			    N_("is the first one ancestor of the other?"), 'a'),
       		OPT_CMDMODE(0, "fork-point", &cmdmode,
      -			    N_("find where <commit> forked from reflog of <ref>"), 'f'),
     -+			    N_("find where <ref2> forked from reflog of <ref1>"), 'f'),
     ++			    N_("find where <rev> forked from reflog of <ref>"), 'f'),
       		OPT_END()
       	};
       


 Documentation/git-merge-base.txt | 10 +++++-----
 builtin/merge-base.c             | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 2d944e0851f..60438a00871 100644
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
+'git merge-base' [-a|--all] <rev> <rev>...
+'git merge-base' [-a|--all] --octopus <rev>...
+'git merge-base' --is-ancestor <rev> <rev>
+'git merge-base' --independent <rev>...
+'git merge-base' --fork-point <ref> [<rev>]
 
 DESCRIPTION
 -----------
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index e3f8da13b69..e03f2269e88 100644
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
+	N_("git merge-base [-a | --all] <rev> <rev>..."),
+	N_("git merge-base [-a | --all] --octopus <rev>..."),
+	N_("git merge-base --independent <rev>..."),
+	N_("git merge-base --is-ancestor <rev> <rev>"),
+	N_("git merge-base --fork-point <ref> [<rev>]"),
 	NULL
 };
 
@@ -158,7 +158,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "is-ancestor", &cmdmode,
 			    N_("is the first one ancestor of the other?"), 'a'),
 		OPT_CMDMODE(0, "fork-point", &cmdmode,
-			    N_("find where <commit> forked from reflog of <ref>"), 'f'),
+			    N_("find where <rev> forked from reflog of <ref>"), 'f'),
 		OPT_END()
 	};
 

base-commit: 2f268890c2cd2f115424936bbee27f8269080e5e
-- 
gitgitgadget
