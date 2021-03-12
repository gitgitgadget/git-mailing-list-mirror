Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB23C4332B
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096DD64F7B
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhCLWsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 17:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbhCLWsR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 17:48:17 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD3C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 14:48:16 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id t4so26112793qkp.1
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 14:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DffCOz+Ock6QePmxrPLDPN3bWn1VOqXtiAhStrQzeq0=;
        b=BXVi7J7xjG4bGMV3oyFmlp/Jga9J+04l51I7+MW0y+bkoJIBtMf6SQenLuhmPeyxxg
         pQTb1/kCjmnmI+u9q/qugVC2k+Ld2BlnUq0kRVhP5s8w+E/nCTwFV1aZaXn899xCxVgt
         /u6qfMsv23YmKYVShKjYovU9Dr+5gUsNxIhPRBOpiFpQ4PAalcQAElL9FLVDtPzsBBtQ
         fGFhyNExCxrQ2/2ZmsNYR/r9Gdt2X3LbP7LxnGflQnDmoVIQMSGofnAPayAhax+altUD
         Xd7R8PgEPpfJE0L54fZleQUoblmYO78RNCUyaQRSfYL+BxSDOZWh4vpkIFzZu0eCpvld
         v9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DffCOz+Ock6QePmxrPLDPN3bWn1VOqXtiAhStrQzeq0=;
        b=lfyhCqQp0teTwZ8NGE8PYMZfV2nHANqSBZMBfUthLKYEmUBxvv4jiG2ftVIdZmqo7H
         jeDCDgH9rSlAixztpG3vG67VFze7f8Kx7JF/Cm2GXXXaY4QtUJPodmjT75d05n5JGtyJ
         abaocsnhx8ROR1tgji4vqMXrc8ALzA62CmF+cKlb7qo8JQ7Z4WfC5/JGUCacKQhtpsVY
         ZM3b+N6cF0p/uIMAR7+iUGERiQ5x3BoJgRMf10iKCaIR4oBeaaK60iCaX2wlsirF8u3l
         KUl2MhTKbFNeOhVzH1i3esljLmdS41MC6AA97lWUGZ6HsvHFHTrfVqB4toitMdJCV1Bi
         mqSA==
X-Gm-Message-State: AOAM533jqHX1jvcEyPmVJ7VmSna4hG7wyNHAtqMpx4qsYJzikaoHRvjn
        uMgXtMvCyFRweoeIQcXdwH41jYZdE+gC5w==
X-Google-Smtp-Source: ABdhPJynJ/+hpFKDlOjUrAdX6P9DqC1valNUYCQVyYaQPN9mTlBScM/a83yAXcf4fi70KwVren4JBA==
X-Received: by 2002:a05:620a:5b3:: with SMTP id q19mr15150685qkq.98.1615589295404;
        Fri, 12 Mar 2021 14:48:15 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j1sm4870400qti.55.2021.03.12.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 14:48:14 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Subject: [PATCH v3 3/7] add: make --chmod and --renormalize honor sparse checkouts
Date:   Fri, 12 Mar 2021 19:47:58 -0300
Message-Id: <c90d5e3c2327d0ea43afc3f1b98dca76cf4973c2.1615588108.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615588108.git.matheus.bernardino@usp.br>
References: <cover.1615588108.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c                  | 5 +++++
 t/t3705-add-sparse-checkout.sh | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 24ed7e25f3..5fec21a792 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -46,6 +46,9 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 		struct cache_entry *ce = active_cache[i];
 		int err;
 
+		if (ce_skip_worktree(ce))
+			continue;
+
 		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
 			continue;
 
@@ -144,6 +147,8 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
+		if (ce_skip_worktree(ce))
+			continue;
 		if (ce_stage(ce))
 			continue; /* do not touch unmerged paths */
 		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 6c5b8be863..00b10ac877 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -78,14 +78,14 @@ test_expect_success 'git add --refresh does not update sparse entries' '
 	test_cmp before after
 '
 
-test_expect_failure 'git add --chmod does not update sparse entries' '
+test_expect_success 'git add --chmod does not update sparse entries' '
 	setup_sparse_entry &&
 	git add --chmod=+x sparse_entry &&
 	test_sparse_entry_unchanged &&
 	! test -x sparse_entry
 '
 
-test_expect_failure 'git add --renormalize does not update sparse entries' '
+test_expect_success 'git add --renormalize does not update sparse entries' '
 	test_config core.autocrlf false &&
 	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
 	echo "sparse_entry text=auto" >.gitattributes &&
-- 
2.30.1

