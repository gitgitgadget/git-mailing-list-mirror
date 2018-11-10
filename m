Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126E51F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeKJPYa (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:24:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34792 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeKJPYa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:24:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so3379270ljd.1
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u607s6TBq7hhZ1r7Y5t9m5gpdBRk7PZpWS31r6MNCnw=;
        b=gE8mzy5VcCa2MPq99sqRihjiwPpqacpRwV+lsuQsZ+p5J5cZlgIo49Sq9wTr6TwfkA
         OM4zveG2DUeSXw6ZIxWQOt/65u8x16H7+JdTkyD7m+GPbkFCxeR2oY4izfhyxNVYMrRS
         CNQ0f2+LwzH9xUEqRzEaLCOaVntOAzEShYMZRUKwnx9jD2oedBtDLtSG1FN+/mY3kxwA
         /pSe0gxX3XCdMzrV7ERteRW0U9er37B0mRt2YbE0oQ+bwEdJeXRnDajp3ZjnUFR0e146
         yfIWYc+wwKJYUoCqzGEz2U/4QUjT06n3o5MvKNIYcxblXc0WzSCEwcBD9yp8K98rxD8J
         w5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u607s6TBq7hhZ1r7Y5t9m5gpdBRk7PZpWS31r6MNCnw=;
        b=nIa4CUn8NDvtEYW72iJUvlKCfj3ibLHW9dbdrNdkhI0yfs9CBiDqTSJAKQrIUOI8pU
         cuog2PTQjIhF18OLwNwrKwHHxl0WHzPMWBi7r5Y40Io9e5ZF+nPzdLo6DqPxxT7W3yXF
         AQPpvEjNfUzein75RTDvzrfjA/H0fXKo6ot2PTPBccurtwY0+1Qg0y36+vamLPGgSrHL
         tjg89oWqQi2lvkrrKWcOePghldLddN3x3qWzfpgDAbLR5PhjuJG0/eFoPsjYe+YJsRSB
         th6xZyoJLUVfgjCQkRRmKtUR8cNJxJqt+XKUbCmVbAG/Y6kwTZLbjNtVRjRBjKKK69VD
         +s+w==
X-Gm-Message-State: AGRZ1gKzd9u6WAXjaUith7IIupbEL8bdoygWIdcddXpOWggFhfSXGXER
        PkmYMc6nkVWv+wF03Sz1tO4=
X-Google-Smtp-Source: AJdET5fHDFrIKPd0lNkQSWqNqhzeC6sng2/8jhtBEwwfe/HygWxTvJr13sMei1jBqI2TGZb9/9JjzA==
X-Received: by 2002:a2e:9b15:: with SMTP id u21-v6mr7117623lji.29.1541826984222;
        Fri, 09 Nov 2018 21:16:24 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:23 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 02/16] alias.c: mark split_cmdline_strerror() strings for translation
Date:   Sat, 10 Nov 2018 06:16:01 +0100
Message-Id: <20181110051615.8641-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
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
index 5fd30da093..c7e122cfc1 100644
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
2.19.1.1231.g84aef82467

