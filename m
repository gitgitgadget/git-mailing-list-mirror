Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8B7C33CB8
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9515C2081E
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nx2GnJ4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgAPGOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43882 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbgAPGOm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so17874030wre.10
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1L5TUqtZXh1wJ+N8DSIXV31eikZOXtmyNNjjFDz0WFM=;
        b=nx2GnJ4O69hlT7cz/9vvGAZ+uPhMx2CJDiWjRz550dC1lxtyiENjVRnMTQ6dr1Ytt9
         eODzK9ePVYA1BsY/h138cq7JavGGMdIX4gHKpTdovNJLSZHss5jU48VUTy2PpFOAg6lF
         GVubgA94JoPD4ynaUTtWZYZSTVVdwjAnZtRqV94Xi+elFD2UZGxIo7dwN/MfgHD+iSC0
         XAnfjJpkIDuWJesy78N23oQOIP+UupPmyLk42MCdsK+y7jea1XukoQerkj9baNiAkLHc
         S2lfaRpjw9zyhFO5YKGPRHXdcwM7PV2hr+RdSUcWmzxsdcm6G4fXc4egO1A7YsoJyHPI
         vNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1L5TUqtZXh1wJ+N8DSIXV31eikZOXtmyNNjjFDz0WFM=;
        b=XVG2kiGl5+y5J6ElOEbvgtTJTmsRe0RUYV18n5SK7VQTDWehnC/DOPOsK1WaAh/iQz
         YEZj+ypXGn8TumYpSAihOg+NmLFeiN1utJJZvHRTB2j6sXSC18XQ56f96pld4DcVv6pz
         Tv5xXSaEKiLUeg2ysa1AsfsqR5CxTdGoW1M05NoaNVAh+iNZ9xjQP+bARXUjxf5mEWB/
         YOfnR8g5KDR2MOjM5ZZHkwThdmcaP5lRXIj5spT1rYjYaUiytmdz4mN9kndXWR73qrcJ
         JnN7htY+3YU4Ii33yzgBeyPMnt3YcqF8UgNSGnounn2u0496My7+bSg4Oxmne2fQtYnl
         pdDA==
X-Gm-Message-State: APjAAAUB+UrfJTJBmd3GniSsERb0Z2ooHm1YIUZN4mKUwe/FH4e57TUA
        3m32VUJTgIZ1thnYpd0i1bO/REgR
X-Google-Smtp-Source: APXvYqx0MP5cYzQX6R9ObCj0MGA9pNYlYTlH9WfkgApVP3G9YVomRb02OrNqnvH3Ptpdb7qQ2SCnaQ==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr1286642wrv.144.1579155280870;
        Wed, 15 Jan 2020 22:14:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f207sm1927109wme.9.2020.01.15.22.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:40 -0800 (PST)
Message-Id: <b6b6597eef8114b97dfcf37db9fa4d37ec944d15.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:21 +0000
Subject: [PATCH v4 07/19] rebase: make sure to pass along the quiet flag to
 the sequencer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
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
index 57875485df..e8d518ac8d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -120,6 +120,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.allow_empty_message = opts->allow_empty_message;
 	replay.drop_redundant_commits = (opts->empty == EMPTY_DROP);
 	replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
+	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
 	replay.verbose = opts->flags & REBASE_VERBOSE;
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
@@ -1476,7 +1477,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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

