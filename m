Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED23120D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 15:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbdFAPv3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 11:51:29 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:32939 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdFAPv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 11:51:26 -0400
Received: by mail-qk0-f195.google.com with SMTP id c206so6238445qkb.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0WgUAzKiInK+A9UZ16fadV0k65K5pKTfwX0mHKBHBwI=;
        b=TSkFxvw5vKzrUZfS5JYZ9ivr2Y42bzBEIMP2MpEn46V0a+ZWIbDPd3QzD5iwkvwu6P
         cXVseL4JZUu0xv8bScpEtJYgILn/dpW8pEZ5S3u7ZmlEnBkGVxxPpR8V4Xqr4BvEuvu2
         P0brihqDzF4Ezi9XGafHY4NUIY7OBVlHwmnY8YDI1FpzsW7TGuBbCigog92MsH8cJ2T+
         pe1np+CKWi92a7xSJNy4dS3FlGDBGwnXYLaQ+OTnmVl2dKpqHxkF35AZnPtT7FOFUJfQ
         /FD12z3Y7YYwitbvi1X3VPt/wNrnOdCC1LEQ84SMI/L29mtDZieWpX1+m8wu1fwTB42R
         fifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0WgUAzKiInK+A9UZ16fadV0k65K5pKTfwX0mHKBHBwI=;
        b=iKD7/BpThrsS7/SaMJaTUQtLXcBq8C76iu6dF9xg1qnQJ+eB0qEUeGY7WJHCnRtxi0
         eplLFTGg0SCff6J6cAW4gMNscApXvrqyY/jFbLw8ejMcP9woT3DM5NOw/IsvaPSaGzao
         zNAuRWVYNmC/sjzG6IfsobshNhGaMDMNtrj1eTYdk2FhNqPcWn3sxNHz1g1DGCCYlGOm
         pJQmJovdAt0yp9ZzZkrI5z+l1ZPLumVYLmoEE8qE7fBBUNQZyPdnUWCHoFjusJXEAXyY
         5lDQ44SRuGmAGU+tEjOB602s17EoEUKk1dAfoIticMkYzjsuMH65ogDS9amKplvfy56N
         +XbQ==
X-Gm-Message-State: AKS2vOwaIGu9W3klGrx5khmsAXXSQD3zk3nKn9SkUXyfHc2/CS2q9MPu
        ZZQ/ZQRWEfgi1FHYpUE=
X-Received: by 10.55.129.65 with SMTP id c62mr2575983qkd.229.1496332280425;
        Thu, 01 Jun 2017 08:51:20 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id w41sm12715524qtg.34.2017.06.01.08.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 08:51:19 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v4 2/6] dir: make lookup_untracked() available outside of dir.c
Date:   Thu,  1 Jun 2017 11:51:01 -0400
Message-Id: <20170601155105.28356-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.9.gc201c67b71
In-Reply-To: <20170601155105.28356-1-benpeart@microsoft.com>
References: <20170601155105.28356-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the static qualifier from lookup_untracked() and make it
available to other modules by exporting it from dir.h.  This will be
used later when we need to find entries to mark 'fsmonitor dirty.'

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
2.13.0.windows.1.9.gc201c67b71

