Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0BAC2D0D2
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63419206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqtoum5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfLTRJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:09:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36884 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfLTRJz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:09:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id cy15so8948852edb.4
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LYw++dU8UaeUfbRm94CZWxP7yRgnSdg8gaKNkRp7iC4=;
        b=hqtoum5VRsZbsILlUL2JyXlCFWwacqipxZuHhsb/3KX0b7QU9f6Y/kcW7oI14yr5xM
         cvMcx3Q7IRMPRvsE9tImCDG6H+iibV5KnP9OZ6XbIJ8/yMCSEcb2dvxBGYeZpk9hKMw5
         BSJzN3GLhw8Dtx2ga9p7p1b7ZbeJJY6LwFuDXyUN95uAzKPeAFbMtblk6aN3j6AbWtdf
         IsvyzrXmFMio3+D9q0uWqsGEsvEi5xvR8dxoK+DsduSwrfbSsSBgJyjNZ5GkfTyTG9w/
         0LjSv8MmNT7Su1O4wy/i8hAVV4BVmcOseENPW0yXM7tMfwhkeDuhcrHUUN4j6JAOmDMK
         Sm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LYw++dU8UaeUfbRm94CZWxP7yRgnSdg8gaKNkRp7iC4=;
        b=EKyIiYPodqnxfe+F91VWEsJxslDeHUQimYIcczRR4T7VFTwd3uCa59BYH14athcuwp
         p6Q2ffz+Lh9fETGVPhPmLsRJldzTDh3oOHQOWEYFekknxVOpHgCWPvdvgDh6e+Ybl+fb
         pakNXNQKhn8YwewnCPuJNVRVEbQ9YR+76CKVTDtfGan2DrKCQ1kQvRmW4tMTOfgpvSr1
         xieWpZeSjADCYZkoZpwOvqBHJAPEDab81vQCSYWGseBXL+c2mgcX9TICGNf2PD6w+wDo
         6Zl/qp5a4ay7xI9xFOEvqcoZbLlZdn2/ey6I8tZBgtgkyG65ljYNS13Hpu/lSrnJP9bu
         wV7g==
X-Gm-Message-State: APjAAAXs/Y1PspIOrYqQGBRHyippiaTzJTINHuXqFekOg0cl/8zZ2zTA
        +pcQaMQsjTRQV3J0apWCmowtwBb/
X-Google-Smtp-Source: APXvYqzQorgf994DsPyyQv3peNL7TL0Ll8x6YQvl0u1hrUDMvsT5ytdXzwzjJXwMR/hlg0yVOGGZpA==
X-Received: by 2002:a05:6402:545:: with SMTP id i5mr16763116edx.11.1576861793199;
        Fri, 20 Dec 2019 09:09:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm1188581eja.63.2019.12.20.09.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:09:52 -0800 (PST)
Message-Id: <66bee10d1ca45548cf9b5a5bc2e17703ed54a82f.1576861788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:37 +0000
Subject: [PATCH 04/15] rebase: make sure to pass along the quiet flag to the
 sequencer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c  | 3 ++-
 t/t3400-rebase.sh | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c71d169688..cc8f3f008f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -126,6 +126,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
 	replay.ask_on_initially_empty = (opts->empty == EMPTY_ASK &&
 					 !(opts->flags & REBASE_INTERACTIVE_EXPLICIT));
+	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
 	replay.verbose = opts->flags & REBASE_VERBOSE;
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.committer_date_is_author_date =
@@ -1506,7 +1507,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("allow pre-rebase hook to run")),
 		OPT_NEGBIT('q', "quiet", &options.flags,
 			   N_("be quiet. implies --no-stat"),
-			   REBASE_NO_QUIET| REBASE_VERBOSE | REBASE_DIFFSTAT),
+			   REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
 		OPT_BIT('v', "verbose", &options.flags,
 			N_("display a diffstat of what changed upstream"),
 			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 221b35f2df..79762b989a 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -206,12 +206,18 @@ test_expect_success 'cherry-picked commits and fork-point work together' '
 	test_cmp expect D
 '
 
-test_expect_success 'rebase -q is quiet' '
+test_expect_success 'rebase --am -q is quiet' '
 	git checkout -b quiet topic &&
 	git rebase -q master >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
+test_expect_success 'rebase --merge -q is quiet' '
+	git checkout -B quiet topic &&
+	git rebase --merge -q master >output.out 2>&1 &&
+	test_must_be_empty output.out
+'
+
 test_expect_success 'Rebase a commit that sprinkles CRs in' '
 	(
 		echo "One" &&
-- 
gitgitgadget

