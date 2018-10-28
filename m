Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FC461F453
	for <e@80x24.org>; Sun, 28 Oct 2018 06:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeJ1Pft (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 11:35:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45870 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeJ1Pft (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 11:35:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id c24-v6so3715765lfi.12
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 23:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YICb1dBgDa4LM229qG6/527E5MtMS+f7K7YwXjgwCL0=;
        b=ueUfmkiHugMlTTFJy/w81maijWTdK5YPwYRhdI2eon+6jdSgoZNIIvaqaJEc/5ewLf
         E6ZGe/7D8FhjUDMae7ytPTHBNW6AIhz7dr2+Vuu5QaDVCJLBl93p+u/kHdGxC5J9T5fF
         iDam92nfzFGyx8Y+j5Ha4kr7bFqpNNuaLfrUZ7gd8Gi5fZcrLwM8KSrkt42Fj2vKqDQT
         sl45mWgRfgTWxEt0L7h5X/OkzQ+cD1vChthcbIFxGQOfnRhHeMv4g/Dcu2t+XEkoIuyy
         nj5lYhq15dhvQI1OqWvvORMHvgAyiLcYX8tp6YCq1lh11enT1CgkXwQbQhTUyDVNprSy
         g8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YICb1dBgDa4LM229qG6/527E5MtMS+f7K7YwXjgwCL0=;
        b=nBlJ/v0zr1bUmva29N8YBh+GSu5f7gDMsWEdC8jjO6OwZwh9uxk5HtlwrpnlatCO6i
         ccUEZY+U1t7nvmIzXIGWelWMXegmILgvFBvL7Ucvg7Uhazorh3HgcDRagVoI7h2F8Jhx
         NeXFXNt1tWOrsVFGkxmCHFhP/SL5uTbf2ZUO22Vz63rNgijgyV0PAWGJRVVzDrulq8Q5
         1C6EHBRuKRXmQaqL95VSSfxEiP66vRQ1xaDPrrJCG0fBndME6+gyZ6jfpJondRqbEKlR
         30LmbVue7vjM7IXjD+RP7KHt6QiKWEFD/k51s0a39wzJAK2refUqnc1H17QE5pxFciOe
         evXw==
X-Gm-Message-State: AGRZ1gIFqQYoMTepQHTuRBE3rb/3iGfIUOEruyapR4jDR9GdY5ewYqla
        mBw7VKUsjP58mQK3RcRvT40qRB8Q
X-Google-Smtp-Source: AJdET5ewdfPs+4nA78lSI4aj0Fe6JWOUNoT1Xi8PmMvP9/B6DH0pjS2V5EXM6wecAHsQWYuA0FZahw==
X-Received: by 2002:a19:be16:: with SMTP id o22mr5566860lff.22.1540709524498;
        Sat, 27 Oct 2018 23:52:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v23-v6sm148847ljd.70.2018.10.27.23.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 23:52:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/12] alias.c: mark split_cmdline_strerror() strings for translation
Date:   Sun, 28 Oct 2018 07:51:47 +0100
Message-Id: <20181028065157.26727-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181028065157.26727-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function can be part of translated messages. To make sure we
don't have a sentence with mixed languages, mark the strings for
translation, but only use translated strings in places we know we will
output translated strings.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 alias.c         | 4 ++--
 builtin/merge.c | 2 +-
 git.c           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/alias.c b/alias.c
index a7e4e57130..c471538020 100644
--- a/alias.c
+++ b/alias.c
@@ -47,8 +47,8 @@ void list_aliases(struct string_list *list)
 #define SPLIT_CMDLINE_BAD_ENDING 1
 #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
 static const char *split_cmdline_errors[] = {
-	"cmdline ends with \\",
-	"unclosed quote"
+	N_("cmdline ends with \\"),
+	N_("unclosed quote")
 };
 
 int split_cmdline(char *cmdline, const char ***argv)
diff --git a/builtin/merge.c b/builtin/merge.c
index 4aa6071598..92ba7e1c6d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -577,7 +577,7 @@ static void parse_branch_merge_options(char *bmo)
 	argc = split_cmdline(bmo, &argv);
 	if (argc < 0)
 		die(_("Bad branch.%s.mergeoptions string: %s"), branch,
-		    split_cmdline_strerror(argc));
+		    _(split_cmdline_strerror(argc)));
 	REALLOC_ARRAY(argv, argc + 2);
 	MOVE_ARRAY(argv + 1, argv, argc + 1);
 	argc++;
diff --git a/git.c b/git.c
index 1ad565c5c8..09d6169f6c 100644
--- a/git.c
+++ b/git.c
@@ -344,7 +344,7 @@ static int handle_alias(int *argcp, const char ***argv)
 		count = split_cmdline(alias_string, &new_argv);
 		if (count < 0)
 			die(_("bad alias.%s string: %s"), alias_command,
-			    split_cmdline_strerror(count));
+			    _(split_cmdline_strerror(count)));
 		option_count = handle_options(&new_argv, &count, &envchanged);
 		if (envchanged)
 			die(_("alias '%s' changes environment variables.\n"
-- 
2.19.1.647.g708186aaf9

