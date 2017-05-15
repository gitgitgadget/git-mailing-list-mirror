Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C536A201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966315AbdEOTOO (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:14:14 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35921 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966194AbdEOTON (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:14:13 -0400
Received: by mail-qt0-f194.google.com with SMTP id j13so17332520qta.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=idmobJGR5el2gKxme4u18x8xrT2zUDCFQuDUoW/wKEk=;
        b=LuBUOcjL7Ka4MJqkciYnUP32InxmGcAj85BXBUzYnLslifua1cZowlM8ccopzgs8f4
         Bfrm0QfSquVQGlOVseVDT5kbtPtqHTLEmKXyZoLolwp2Snb22ss5Nts4F1LGGluFbX+c
         maRe0ZbkNmAVWbzN08n33OjICi+d8sh7u1dFn4kQoYfgB3c/hW76RcJEskLM/AoQBFlW
         rgcXdrKCpARzAGXO0BfElG75SLk62reFSdyqIG72CoTqmrvKI9sqjpm8gExqxA/+JReo
         doZDRWh9ZIbGAijjzRFFpKqS+x6Z99bBYiQ3N0WgCRDBP62qshhpEwgVCLYUr5ZO1+Qf
         phBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=idmobJGR5el2gKxme4u18x8xrT2zUDCFQuDUoW/wKEk=;
        b=Qkd/NHmE11nvhfBoRYEtqMdHXge3Bp5vo/mFfwlPixdAUQiBgrdp45oHTkTkgGLiZx
         HUaLvZR5QVn9oqr5yPAYZcBEC3U1wPhiQNTZ6j7+rtcQdkhcxGCJwe8U3dGdwJb6Y/No
         ZGoFoN5vH1c6x2KfL5yl51/V+562CqgkxqV7aQ7bPzMpLO0kDH0C4j7m8w5fl6N7zVEk
         XrJlZBdLbuPnCzRRtBIPNQB9Tnd6S7IG/k5MENQfXZ7yEPmIiPP8NKf+nnD4DTr8r14w
         IWMX0EwqOQrMCGTxnz6wfx3RYqASmQ3cOJa1HGmc6C8FDD3o4ElZaii1uGrDtaHI1l6a
         vFbw==
X-Gm-Message-State: AODbwcDdtzDgGGZKR7Ku1MZQCp1IcmVYHHpngfxfvxf4XKu8c29p5XcU
        3Y+J7stjL/ZikQ==
X-Received: by 10.200.52.60 with SMTP id u57mr6880597qtb.225.1494875652221;
        Mon, 15 May 2017 12:14:12 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 47sm9086903qts.26.2017.05.15.12.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 12:14:11 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v1 1/5] dir: make lookup_untracked() available outside of dir.c
Date:   Mon, 15 May 2017 15:13:43 -0400
Message-Id: <20170515191347.1892-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.6.g4597375fc3
In-Reply-To: <20170515191347.1892-1-benpeart@microsoft.com>
References: <20170515191347.1892-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the static qualifier from lookup_untracked() and make it
available to other modules by exporting it from dir.h.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 dir.c | 2 +-
 dir.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index f451bfa48c..1b5558fdf9 100644
--- a/dir.c
+++ b/dir.c
@@ -660,7 +660,7 @@ static void trim_trailing_spaces(char *buf)
  *
  * If "name" has the trailing slash, it'll be excluded in the search.
  */
-static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
 						    struct untracked_cache_dir *dir,
 						    const char *name, int len)
 {
diff --git a/dir.h b/dir.h
index bf23a470af..9e387551bd 100644
--- a/dir.h
+++ b/dir.h
@@ -339,4 +339,7 @@ extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git
 extern void relocate_gitdir(const char *path,
 			    const char *old_git_dir,
 			    const char *new_git_dir);
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
+					     struct untracked_cache_dir *dir,
+					     const char *name, int len);
 #endif
-- 
2.13.0.windows.1.6.g4597375fc3

