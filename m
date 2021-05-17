Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF588C43460
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C5661059
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbhEQQpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbhEQQop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:44:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63655C0AF565
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w33so1607210lfu.7
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMLD7fM0sXSygPEEn1GQHrpSr0o3MxgtlVk9jtYim58=;
        b=I/jnxyDGbI6phBjZgjGdG8PPgFcvsyFR6GLi5lHFNFSaDLiySYwruuTp/UCqXTRed7
         6xz9ROWGptLOSvwiFSQ//DX6hiOuwV6I/jdDus6Spam1KPnPBC57n8eeWp+ATpT3vQ7Z
         n0DAbFc2Xv+kv5okVvhXjmgyg53ZxcC/+JNDRGrCX4A9nGo5W6Oc+9Fw/wINfzkXm2e2
         ueDZRchMGhYFnjn8HZFCcOmYe4hqSjamLs1N2Hbc5nO/tZdqO3SgRsS2f8IdiNhCejAb
         1a/fEob1d1lK2IYBT6x8OvHsh301KV/+H7IB+T95DGsEjHQtPGqfDvYjwoo1iOgXb7Qd
         jQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMLD7fM0sXSygPEEn1GQHrpSr0o3MxgtlVk9jtYim58=;
        b=lLErDBr86nYMhHX/vcvoG5J0tvaCDVBbtxK34zDVutSau9KfiowTXXvjBFyJ1Yl/RQ
         uH4ia70BrdoTngccyRPohrqZeZ79iZPNSrwG2p3eGUpc1jotNdoSWk5zUKYk2FliA2oI
         B0q6vnsyqsHSXIOdyuyq2mOUm459FvO5QmHxWGXf4j+/u4JkUkiyB892gT7Ka0htF0Bb
         vNO2+4kA7klIvsZuGTQib7lZd9QG19OJbtu8vlEQS493xzOYpAegDl5pzs/naf/h824v
         TVv6c2nbY1wSKdvQ5WVkn0FHUcTcDw015HLWVf3Ytg9Qr+z11Uuw8eWrCmbRaylqP/6l
         3bjg==
X-Gm-Message-State: AOAM530LVYaXnz2NBgpbmAh804JrYWyIyrfnRPqXwxYaWw75ODfJLhjv
        5+q9nDwgSRu0RMEkTSFVNCw=
X-Google-Smtp-Source: ABdhPJyVc7GTwwBDNErvVmEbXEn+eX1ToD4Nc0VzDGuwWOW49My+kv/dR43V+n+GR8MKLDHSErlK7g==
X-Received: by 2002:ac2:58e1:: with SMTP id v1mr410851lfo.336.1621267127332;
        Mon, 17 May 2021 08:58:47 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i8sm1996834lfd.12.2021.05.17.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:58:46 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 9/9] diff-merges: let "-m" imply "-p"
Date:   Mon, 17 May 2021 18:58:18 +0300
Message-Id: <20210517155818.32224-10-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517155818.32224-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210517155818.32224-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix long standing inconsistency between -c/--cc that do imply -p, on
one side, and -m that did not imply -p, on the other side.

Change corresponding test accordingly, as "log -m" output should now
match one from "log -m -p", rather than from just "log".

Change documentation accordingly.

NOTES:

After this patch

  git log -m

will start to produce diffs without need to provide -p as well, that
improves both consistency and usability. It gets even more useful if
one sets "log.diffMerges" configuration variable to "first-parent" to
force -m produce usual diff with respect to first parent only.

This patch does not change behavior when specific diff format is
explicitly provided on the command-line, so that commands like

  git log -m --raw
  git log -m --stat

are not affected.

Exact historical semantics of -m is still provided by
--diff-merges=separate.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 8 ++++----
 diff-merges.c                  | 1 +
 t/t4013-diff-various.sh        | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 530d1159141f..32e6dee5ac3b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -49,10 +49,9 @@ ifdef::git-log[]
 --diff-merges=m:::
 -m:::
 	This option makes diff output for merge commits to be shown in
-	the default format. `-m` will produce the output only if `-p`
-	is given as well. The default format could be changed using
+	the default format. The default format could be changed using
 	`log.diffMerges` configuration parameter, which default value
-	is `separate`.
+	is `separate`. `-m` implies `-p`.
 +
 --diff-merges=first-parent:::
 --diff-merges=1:::
@@ -62,7 +61,8 @@ ifdef::git-log[]
 --diff-merges=separate:::
 	This makes merge commits show the full diff with respect to
 	each of the parents. Separate log entry and diff is generated
-	for each parent.
+	for each parent. This is the format that `-m` produced
+	historically.
 +
 --diff-merges=combined:::
 --diff-merges=c:::
diff --git a/diff-merges.c b/diff-merges.c
index d897fd8a2933..0dfcaa1b11b0 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -107,6 +107,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 
 	if (!strcmp(arg, "-m")) {
 		set_to_default(revs);
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->merges_imply_patch = 1;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index c35cc73d08bd..15ca3c75bff7 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -454,8 +454,8 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
-test_expect_success 'log -m matches pure log' '
-	git log master >result &&
+test_expect_success 'log -m matches log -m -p' '
+	git log -m -p master >result &&
 	process_diffs result >expected &&
 	git log -m >result &&
 	process_diffs result >actual &&
-- 
2.25.1

