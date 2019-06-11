Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BCB91F609
	for <e@80x24.org>; Tue, 11 Jun 2019 13:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbfFKNDl (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 09:03:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50782 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387631AbfFKNDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 09:03:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so2883780wmf.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+1Ls5BEFluKuxgRa+1cYmN5CulL+wMld3mvXLyocT0o=;
        b=JNwvxW0DnDRIILNgWy4SCYSLhS1JqzpErbymqfz0MWRBCOxK6sPcByHPuzumOJ5rrw
         zhSnNdbUBDgQylhR5UmDpquK/OIjPnb1EfG/1M5Os0NLjxqpFhp7dlsNgc48Tzc+lkUr
         kIvn7RrbyJTB3gVUc5Q59QPspi4LzIzcLo1jyP+NnTQGHK8wg1PlbyqBE1tcNrsRWTuQ
         9O/MFzR2F0Jfj/L1P1z099z4w92SOPiBGuCV08LuiNgAZPEwt5CQVkRkk0sBOUaky1XG
         pGwwyYrZNYo85DeZBQrayedsFctZjSXFSwynr6Pvx+R6nQqtlg8h3bh2WMh+NazjVIIE
         bHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1Ls5BEFluKuxgRa+1cYmN5CulL+wMld3mvXLyocT0o=;
        b=lnkS4xf0AIeyXaN/+2elqZNs+iqvKLBL52yaxtnaMNcfSo6+hhFeqhue4DFVP3fjiu
         qCD3Rz5FZ0uE6xkHSdaGbxQM4bbGa8z1tfmb8IfTbFl3ClcJd6jTzSrvDjx3sP7BbU+m
         jSi7cJ+fR2n+KspF0R1kzMA/yGH2+ZC9g3tQ6Z8Jf1CMWL+KrzCXoptyRlrwFX6HaCus
         4FnTLg9u810A2sCzUcYvBHDpUub2MtsJdvkvLeKPRJCQC30YWsmoJlTMWYevSlrtSIyd
         +k9Hi8LAZhp/bj7E3BOFz6Ja80NHTPpNdzSBEN04bjwm/+gJoiMi75tz6CLE6mIzA+Vz
         c/ZQ==
X-Gm-Message-State: APjAAAXP3F1OeMuo7HWqYirFr70/N49OMyYaF4BAX+MJdH2/XhLHD5mQ
        NdoG6k/vVGEnEQpvlfxQzxw=
X-Google-Smtp-Source: APXvYqwnbUId5a9HEel0orN2sMKv7kUWtVHSrlFeAbmOOtJv9ugGBuLTZoNFK7lBRt0kQJlq/7PU0A==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr4698664wma.34.1560258217809;
        Tue, 11 Jun 2019 06:03:37 -0700 (PDT)
Received: from localhost.localdomain (x4d0cbedf.dyn.telefonica.de. [77.12.190.223])
        by smtp.gmail.com with ESMTPSA id l190sm2561524wml.16.2019.06.11.06.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 06:03:37 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/4] t3404-rebase-interactive: use the 'q_to_cr' helper
Date:   Tue, 11 Jun 2019 15:03:17 +0200
Message-Id: <20190611130320.18499-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.566.g58873a45ff
In-Reply-To: <20190611130320.18499-1-szeder.dev@gmail.com>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'rebase -i respects rebase.missingCommitsCheck = warn' checks
the output of 'git rebase', including progress lines: it prepares the
expected output from a here-doc using LFs at the end of progress
lines, and converts the command's actual output by replacing the
progress lines' CRs with LFs with a one-shot local helper funcion.
Similar tests (in t3420) thoroughly checking 'git rebase's output do
it the other way around: they leave the output of 'git rebase' as-is,
and prepare the expected output with the necessary CRs in it using the
common 'q_to_cr' test helper function from 'test-lib-functions.sh'.

Change this test to use the 'q_to_cr' test helper to prepare the
expected output, too.

This way this test will be more consistent with other, similar tests,
and it will make further updates to this test in a later patch of this
series just a tad bit simpler.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3404-rebase-interactive.sh | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1723e1a858..e66e95d453 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1304,7 +1304,7 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = ignore' '
 		actual
 '
 
-cat >expect <<EOF
+q_to_cr >expect <<EOF
 Warning: some commits may have been dropped accidentally.
 Dropped commits (newer to older):
  - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
@@ -1313,24 +1313,15 @@ To avoid this message, use "drop" to explicitly remove a commit.
 Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
 The possible behaviours are: ignore, warn, error.
 
-Rebasing (1/4)
-Rebasing (2/4)
-Rebasing (3/4)
-Rebasing (4/4)
-Successfully rebased and updated refs/heads/missing-commit.
+Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QSuccessfully rebased and updated refs/heads/missing-commit.
 EOF
 
-cr_to_nl () {
-	tr '\015' '\012'
-}
-
 test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
 	test_config rebase.missingCommitsCheck warn &&
 	rebase_setup_and_clean missing-commit &&
 	set_fake_editor &&
 	FAKE_LINES="1 2 3 4" \
-		git rebase -i --root 2>actual.2 &&
-	cr_to_nl <actual.2 >actual &&
+		git rebase -i --root 2>actual &&
 	test_i18ncmp expect actual &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p)
 '
-- 
2.22.0.566.g58873a45ff

