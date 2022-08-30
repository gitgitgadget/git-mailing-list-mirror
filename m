Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64790ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiH3SvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiH3Sux (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7994DB68
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso1733596wmr.3
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Ivc0GYFwon7YWFjfTUcP59rgkrO1VN2FSeDMK/I4SJo=;
        b=HuC7LkP1zxJ3J3mRkfpggG04zNlzRaSZns1GVkU6kxRViA/x/KnJch4RjtXNg6j/EM
         2mm+2hBd8E4z50Y9JQYhyb2H//JjqcoV7CqNVX5P5irF9oLMEvJ36tPescX8edMtQoNW
         g+2mvcMcZiJkcamtO7iYr1akK+tYDvLZE1R/l6YUeirGUY2CyHqGZ0T4UpcCH0a0RKYb
         P/sO/u+v0dodEHLPBhMou07YUx0Ld+mIN8HRdJLcP11CJZMyjtxtYHF/6/VApJ043l0N
         JNs1KjMPQ9dFBOckAh0lDICyRdJ6HLGIRkZZHlMnhpD7we2HCWeij9E6MeG3IZZAB/Hs
         oWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Ivc0GYFwon7YWFjfTUcP59rgkrO1VN2FSeDMK/I4SJo=;
        b=Cs6Kg4i+rvelU+1DuWlxv7vgNwgBVm+OBMj2D3lyb/9JSuBpo5c2/i8nIOD9sA5lRR
         gxeDIg7Yp9kcdSYN1eN5dVEARAFS3TsExBCsRbmT6QxDAJkd470QZhcY/ctPRayiMcIs
         htqKxb2N/eZLccBJuksQ/XUbbqLK5bJO2Wo35wYJrOIjUjpkoUuXyxdtYi+Z16NxZ3aO
         gILPi+NQ0pBKFBh8+AWSpRb6C7TFfKimnDF2bmujMN95K2JNp6wIhu9eoPDATGny9xzo
         mMqX5SZVllkJOynGJzudHxiqZwwPHJFQsQctPL/shoJIAOPtR9FLS9In1TjagKvKJEv8
         F0ng==
X-Gm-Message-State: ACgBeo1QP2gk76oihDseDXJWMHuy2pF9MOv1RRQUlQgGI+rvLDjD3/m2
        7Hd3zihcWSqDU5/8pXtXUA/hervIqY8=
X-Google-Smtp-Source: AA6agR4B9S24AGJiE1BbDb6cYNnaOw72ibrNCI5XnxnHN/Tj8Ou5LoG+xp0JoT1vloKWW8lY5ZpoaQ==
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id g14-20020a05600c4ece00b003a60028bc59mr10529316wmq.154.1661885436235;
        Tue, 30 Aug 2022 11:50:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd22-20020a05600c1f1600b003a8436e2a94sm9188636wmb.16.2022.08.30.11.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:35 -0700 (PDT)
Message-Id: <3f052580c95ff5a570374d17391de1592aa34047.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:16 +0000
Subject: [PATCH v6 13/16] bisect: move even the command-line parsing to
 `bisect--helper`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On our journey to a fully built-in `git bisect`, this is the
last step.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c |  1 -
 git-bisect.sh            | 49 +---------------------------------------
 2 files changed, 1 insertion(+), 49 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 61e819e4efc..6bcf16d9f62 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1455,7 +1455,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_SUBCOMMAND("terms", &fn, cmd_bisect_terms),
 		OPT_SUBCOMMAND("start", &fn, cmd_bisect_start),
 		OPT_SUBCOMMAND("next", &fn, cmd_bisect_next),
-		OPT_SUBCOMMAND("state", &fn, cmd_bisect_state),
 		OPT_SUBCOMMAND("log", &fn, cmd_bisect_log),
 		OPT_SUBCOMMAND("replay", &fn, cmd_bisect_replay),
 		OPT_SUBCOMMAND("skip", &fn, cmd_bisect_skip),
diff --git a/git-bisect.sh b/git-bisect.sh
index f4df8709d84..028d39cd9ce 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -34,51 +34,4 @@ Please use "git help bisect" to get the full man page.'
 OPTIONS_SPEC=
 . git-sh-setup
 
-TERM_BAD=bad
-TERM_GOOD=good
-
-get_terms () {
-	if test -s "$GIT_DIR/BISECT_TERMS"
-	then
-		{
-		read TERM_BAD
-		read TERM_GOOD
-		} <"$GIT_DIR/BISECT_TERMS"
-	fi
-}
-
-case "$#" in
-0)
-	usage ;;
-*)
-	cmd="$1"
-	get_terms
-	shift
-	case "$cmd" in
-	help)
-		git bisect -h ;;
-	start)
-		git bisect--helper start "$@" ;;
-	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper "$cmd" "$@" ;;
-	skip)
-		git bisect--helper skip "$@" || exit;;
-	next)
-		# Not sure we want "next" at the UI level anymore.
-		git bisect--helper next "$@" || exit ;;
-	visualize|view)
-		git bisect--helper visualize "$@" || exit;;
-	reset)
-		git bisect--helper reset "$@" ;;
-	replay)
-		git bisect--helper replay "$@" || exit;;
-	log)
-		git bisect--helper log || exit ;;
-	run)
-		git bisect--helper run "$@" || exit;;
-	terms)
-		git bisect--helper terms "$@" || exit;;
-	*)
-		usage ;;
-	esac
-esac
+exec git bisect--helper "$@"
-- 
gitgitgadget

