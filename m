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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ABE0201CF
	for <e@80x24.org>; Thu, 18 May 2017 20:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbdERUOJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 16:14:09 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36847 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbdERUOI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 16:14:08 -0400
Received: by mail-qk0-f193.google.com with SMTP id y128so7540348qka.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4SMlK2SDoaygvpT/hu8PIev8zhaFAJ0aGBmwcdKlbyA=;
        b=VpryJARLPGLHmIiArA3F20Kho77NhIpdt/CfSxseNNiWxCWHCV3bugEjgPdTMZSn6x
         j2iTYdEobW3fOaNOaeSDnujC/mmSzHGIASf2ajUoi7R0XpyABHBBk36FZH6sGtnpLfIG
         R1o+EpTJ0+Op6yRPDYSPhywQIn+FLsWVvam7yE1jaMtnxOqW6DAc5sbTZfMNCVqvYVyz
         Bpy9OW6qqZLXlLzH8zK5Pz29t5SXDy4vhdtMmIvnLsZHcbZcvQeIlHOkn3BqN+xb+M9y
         eTCpqYFn07xBzDJyuQVuCEGeEfMlA8Iu0xuWrzjo6ObJnW/GntjnDu7cEaMlQI+nv4gZ
         fxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4SMlK2SDoaygvpT/hu8PIev8zhaFAJ0aGBmwcdKlbyA=;
        b=QdN/IhmW9KEvEW8vVfCUysaKt61qamkgg6QU/56H0UMJy3BrPmLrseVAEPAERq3QtE
         SJSePogvpRHSqjEL+4ja2DoQwIUp3IzsA1ED7TO+vLMLQ6WZ5r+tiu43I0maxzb/ww4L
         PDlq5/6MGIXSphzq7ByrTJW30nv+i0A/Km9P2RJG3W/+RvqI4ehXTOPTWHqlEU48IIvr
         xMOTSpceD9DTUeK86bLdafV59mwqmr0NziJuEY00JRFuhLgpFSjs/ku/VZyB69tKucyx
         v7c5eHOVVHjh/M3yv2Z+XfbS2W+C3acscQbNmMZAGqZiE8h0aBsvte+UuB+tQlBax9im
         SWWg==
X-Gm-Message-State: AODbwcDOky+YgNwsXwuKx9EGfDkuo5iHBiXzsgptwq5BQe0DJzN6/9+z
        3KxmWIySFyV66A==
X-Received: by 10.55.100.204 with SMTP id y195mr6091103qkb.290.1495138447648;
        Thu, 18 May 2017 13:14:07 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id y17sm4369133qtc.29.2017.05.18.13.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 13:14:07 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v2 2/6] dir: make lookup_untracked() available outside of dir.c
Date:   Thu, 18 May 2017 16:13:29 -0400
Message-Id: <20170518201333.13088-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.6.g4597375fc3
In-Reply-To: <20170518201333.13088-1-benpeart@microsoft.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
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
2.13.0.windows.1.6.g4597375fc3

