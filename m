Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0471EC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiI1IkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiI1Ijn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5888222A6
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bk15so10871263wrb.13
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KFPD0Zh+O2ETtHnUrvkGHpwYBSO22ale6ykO8UgJ0as=;
        b=mVQuhpNwVz1W8r7XWk8GhCVs5R+F4cbeRur42rw5lfs4L3ZEdik6j8wFAyNZzb68T9
         v+RTrR06IbT2IWvQOX4AH7jH4n6ieXZznppqEP0hHZ2vzBGbwg+CEySgTWZoIURTCBIo
         /UhlqWi5CG9tVDAh7g4zX4cR0gfStVkq4jt/dh5vXq9533yRNNkO4osGtQnC5wsnLnlA
         WPrv+Lrx10YgkfB+yHar8+WQZwAU8to3FvbVHPafsiYEMB7kd7AocjdSM8JcZg7kdWa2
         YWcdxSJlbessvRVNyjgd71anl5wPxWGnpLvAO6mkPZhzL4cqZjpCl0oT8REjhW+f70Ie
         nBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KFPD0Zh+O2ETtHnUrvkGHpwYBSO22ale6ykO8UgJ0as=;
        b=Wd33C5mgG/LuIN7130H393/rlHjQFUGtFoZh6oxc7PTMqxCM/1jnEKJywaVRP/s35f
         aW6iKvWt26ht2jFFx2I3b47roa9yuauXV/PD0CNYOzpfZKs9h4FdJBvwc4wHLG1T4kMI
         i7qiFFfCclI6mune2kO1QCKEK7zhre0bJXXbzOUKjqbbOMSDNfMe+g+VHkCm1IsUUmnB
         ySRk8woHNgilF6aPzpzM9k2Y+6EvC/R+B5UGfbSDjLSHqT098XVI4lMlbph3wdFz1Nw9
         Eu13OY1pofMP0UrYLOW4cLqd9XAghYF0zUse7p2Y3ncbX0hJKdlnqjNyHgkAG93BxXu/
         kLrg==
X-Gm-Message-State: ACrzQf0d9mB+nsfhj1AmpHu0UYCusKj1UsAwxW7SyQuJK/NMb8uVLpRo
        N9m0lTskqehxxLmP+kZ3+c7oJrIF555yUg==
X-Google-Smtp-Source: AMsMyM4ws/Ku+ajabHUiyC5zeppAUJ8R+RXxQRaBR2fIh5TCsg2EWU6zqQ2ql0P0XYA9Xt6RWWJMPw==
X-Received: by 2002:adf:ee84:0:b0:22c:c87d:1a14 with SMTP id b4-20020adfee84000000b0022cc87d1a14mr1133862wro.639.1664354380002;
        Wed, 28 Sep 2022 01:39:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/35] blame: use a more detailed usage_msg_optf() error on bad -L
Date:   Wed, 28 Sep 2022 10:38:59 +0200
Message-Id: <patch-v2-04.35-707cf48a900-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the error message emitted when there's a bad -L argument, and
do so using the parse-options.c flavor of "usage()", instead of using
the non-parse-options.c usage() function. This was the last user of
usage() in this file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index a9fe8cf7a68..8ec59fa2096 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1108,12 +1108,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	anchor = 1;
 	range_set_init(&ranges, range_list.nr);
 	for (range_i = 0; range_i < range_list.nr; ++range_i) {
+		const char *arg = range_list.items[range_i].string;
 		long bottom, top;
-		if (parse_range_arg(range_list.items[range_i].string,
-				    nth_line_cb, &sb, lno, anchor,
+		if (parse_range_arg(arg, nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path,
 				    the_repository->index))
-			usage(blame_usage);
+			usage_msg_optf(_("failed to parse -L argument '%s'"),
+				       blame_opt_usage, options, arg);
 		if ((!lno && (top || bottom)) || lno < bottom)
 			die(Q_("file %s has only %lu line",
 			       "file %s has only %lu lines",
-- 
2.38.0.rc1.925.gb61c5ccd7da

