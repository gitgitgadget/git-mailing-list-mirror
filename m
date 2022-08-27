Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28298ECAAD2
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiH0MrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiH0Mo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69F2D8
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b5so4757400wrr.5
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=LNl5SVdJoRTLtmYCF1Gl2szB2InWVkGCdpMEEKC38No=;
        b=cI04kUWMrhczuIOoGZ19hmtnjXxjXqy3gaYE+NhXGlQWP0F6uoZKK0mJn9r6IoBZMR
         D/zXNZ65uKl6b+muQ85oAcJHNrjg93e1KkdogUbHD+BMcKRsU/GPQERglsvrBtB2AuY7
         fIAv8xFMMPAoGRsQjndVtF0uCLRnpQctG4DY6KmARZ33iA1TLwwtqDj8rNV5yb1jhWSb
         XB5sUeEUbB9vhS+SbaL2Ji0CjoeIsT4IbivOQE5VQoQ95UG1+b6t2obz4P3MnBqZK9Xu
         lVwwypmEe4Uo8825XyoNRw4PdM+Lh76MkkHJGllX+0orc/zfXTumR4qdc06Xyi01uXUh
         RJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=LNl5SVdJoRTLtmYCF1Gl2szB2InWVkGCdpMEEKC38No=;
        b=TSqZBCMhGWlaVFa+nZ0UThqr5uM7Y5LrYH5RqbkI1NY1l4kHL2iG1j9UKNYK2o+7XQ
         NJmpylsYKbAMjbKtua8COEXNd3UCIuWYyWmEzWFdnRZZy/hunI6q6TrNp1o4LluEqQoA
         lhDh2/v4uJZjaqYviGo2OX2lN3GQlIeSpeuZQjQoP4ZdlvrsJ/tbx9v111zp/W4Ct0vg
         RW8nMjaYQa6UNp5qKzlyII2NGtm1q+ztW0M2oJ3M61wYDurmgo/1MHtJ+mIGi0m8Whn7
         3RPeYRRpW5xICx0MyvREt3LKC95Q0Htyer4u+RdRi/x62pmdJO+Y76on+2DnjbetLSkB
         VevA==
X-Gm-Message-State: ACgBeo2dgyqMuxBcfNxlrgc8HB++QMwDvEZC9pZMjgVuWWgiKznXTmmL
        rjvDVOO0JGYBZ/9InpnGdZffoUy3yNQ=
X-Google-Smtp-Source: AA6agR7cUbqgblGIcVJC8VbUViayPVIuSucb2cFLexqDiwE8piix45ZlJVot2CPDw9T9Ac6pbMdnvQ==
X-Received: by 2002:adf:f1ca:0:b0:226:cf9d:7c2a with SMTP id z10-20020adff1ca000000b00226cf9d7c2amr2128228wro.392.1661604283953;
        Sat, 27 Aug 2022 05:44:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j34-20020a05600c1c2200b003a682354f63sm2946648wms.11.2022.08.27.05.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:43 -0700 (PDT)
Message-Id: <32bf74e3050a6e30e1e3fb1e77ce0d53f9054fd6.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:21 +0000
Subject: [PATCH v5 13/16] bisect: move even the command-line parsing to
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
index 9f78bd45ca5..d243a9132e2 100644
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

