Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287231F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 16:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeK1DwD (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 22:52:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44203 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbeK1DwC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 22:52:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so16973355lfe.11
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 08:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xEYQMiIKagrO5r2UaaIWiWV3vExbIPwQ5ntLG3rXpw=;
        b=bmmiuSptpwjFlg2diPrR/1STyCJq0j8UwR6vWgvJRD8ojljVZuWFDwKUG0YjnqabUc
         iHL0WmyZZc7Lxwf982hph/MIq6zvHG776lFbrykRkPJXpjOcdSsEvurezFC7UmRLXJwY
         Fqg2EbVVKPHbfLh4lnSqzX8H/pJvg8kkk21fdazohHKMsAmwQ8p1TKmwEDALieXsnf2W
         nZd5VHCiRMFcjSiEsCL+CFKxqpbWmheqr2MRmjv4VwQQv1GMYWQ4cda7q3VFS9kVWUZE
         JID068JoKJm9aS01bb//iBNo60TnpLlI+mrDocE5xcTm3iZJ1zKsMMphO0pfn3ZwxxK8
         X4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xEYQMiIKagrO5r2UaaIWiWV3vExbIPwQ5ntLG3rXpw=;
        b=M9OjDaQp6ur9V0r36QU58zJhO/R4pZ0opBA1Zl0n2krsvNOyNdHdUqkgkBmfWgDcnn
         57irqBjNdEXWw0VHUsHHpGwqMNyZVG9AQ2IxHL6+/gCaWSjHIFV+j38ZJTTbHViZpOQs
         lw0bGlJ23Jj2jtv+w64KyHPyJBNIl64two385KvUkEEGfMtgEifjQfb6P5fSAjCC/eGv
         /FFoJFugFJxg1gMuaF07AU+uFPA9f79a2pDcsBnsp+ej7wHLEE+M32gv0VnrS5f/WnpF
         3kbxZfSfVU1XL+CodXaMWZrbvCTfAIJY1KGWj0vAtpcjGBQn/PRvugcVbThqpzUYjVKp
         p29Q==
X-Gm-Message-State: AGRZ1gKxgCYKFZmP7pPsAa4+UCFxCiHi/OPB1k2bF5mcP+4fhRJxRxwO
        zuF4jCsMz6ZM1AAmyKSkD/M=
X-Google-Smtp-Source: AJdET5eCvitBqOg5MoFceB30oJUdTmbNR+r7U0c8YnqakIklLxf2X6vMNsVkEYyF9kkxdsjYELDJag==
X-Received: by 2002:a19:1019:: with SMTP id f25mr18844664lfi.54.1543337610791;
        Tue, 27 Nov 2018 08:53:30 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm694016lfe.42.2018.11.27.08.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:53:30 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>, t.gummerer@gmail.com
Subject: [PATCH v2 3/7] checkout: move 'confict_style' to checkout_opts
Date:   Tue, 27 Nov 2018 17:52:07 +0100
Message-Id: <20181127165211.24763-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181127165211.24763-1-pclouds@gmail.com>
References: <20181120174554.GA29910@duynguyen.home>
 <20181127165211.24763-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 31245c1eb4..211a347a0c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -55,6 +55,7 @@ struct checkout_opts {
 	int new_branch_log;
 	enum branch_track track;
 	struct diff_options diff_options;
+	char *conflict_style;
 
 	int branch_exists;
 	const char *prefix;
@@ -1228,7 +1229,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct checkout_opts real_opts;
 	struct checkout_opts *opts = &real_opts;
 	struct branch_info new_branch_info;
-	char *conflict_style = NULL;
 	int dwim_new_local_branch = 1;
 	int dwim_remotes_matched = 0;
 	struct option options[] = {
@@ -1254,7 +1254,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
-		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
+		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
@@ -1290,9 +1290,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			opts->show_progress = isatty(2);
 	}
 
-	if (conflict_style) {
+	if (opts->conflict_style) {
 		opts->merge = 1; /* implied */
-		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
+		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
 	}
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
-- 
2.19.1.1327.g328c130451.dirty

