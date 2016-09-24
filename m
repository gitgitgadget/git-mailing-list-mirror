Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E294207EC
	for <e@80x24.org>; Sat, 24 Sep 2016 00:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757343AbcIXAN5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 20:13:57 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35753 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752993AbcIXANz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 20:13:55 -0400
Received: by mail-pa0-f41.google.com with SMTP id oz2so44590925pac.2
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 17:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jvHH7Lu/OZ6DxMPnVBhcK4oOE3Mv3DGqmi75SQ1Gs0o=;
        b=ctyjYIljTa9sM6RAGKABqD6DwUWYI7Nkpi1ucT7OZ5yGdMx89BJ6fjN3dGBqRIgpU8
         O8Qt7vSwPjv1OOPAg2PIUVBGnCwYIKEvz7qT41698KC9k8YNWDbIg22tWUqYU5Vjluqq
         oF805V5pBwbB+LZDKgEoJrOo8uRxbMpjm1n519dhHR1xquR+3OVS/PZICz9cWEVoy6yY
         lDlfnrNfDfr6i072y0q8s+/U+UF+cOn/2gVKRz/BLx1xD5JlrU+vHtsnFStRFa1/G+xO
         G5n84VwnOvT5MoQ+yIm+s/bTk5dXoVr8h6STNZV+CAsIO6qyqq1NUlYXb29u7cJxnfQP
         cwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jvHH7Lu/OZ6DxMPnVBhcK4oOE3Mv3DGqmi75SQ1Gs0o=;
        b=ie8X+EZsWML2aNbOtaBgCdaubBjsukHHvzxedOUKiDdf5KtS3DQS6pzASwtpsLGIZb
         5PM5M/7JIzM72pX58qgqN7HEzvzfs9DrDIRe3M7A9aS/ce5RWzsddEgtobBcZ8ScKhn+
         GHW57IdOvuf8FUmE8PNtOeYEWAfbm5YIrDcLlj6auulqLs1j0FIPo70frw6vzvygxDzO
         rJn0ABXtum+01Y4YXYANKJBaqN93pvjJx7DOin1S+m982O+4dYN4nFijFEa112ldCp9n
         M/A93fjeqZK5b+2YpDAgXxf7MEJqYE2ysSP2mJT4hiM6p6SYcBuhuPKhMaS2xik2aHlJ
         HPYA==
X-Gm-Message-State: AE9vXwNk/t2MQkXgueTSLsdyybyvlJcgOqPa6GlRs9eBbBiZSwOEH6NEGhwWvCW5aDYMHdz2
X-Received: by 10.66.249.103 with SMTP id yt7mr16838806pac.46.1474676035082;
        Fri, 23 Sep 2016 17:13:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4836:46ae:fc5e:2de9])
        by smtp.gmail.com with ESMTPSA id 22sm14001082pft.10.2016.09.23.17.13.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Sep 2016 17:13:54 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/3 v3] submodules: make submodule-prefix option an envvar
Date:   Fri, 23 Sep 2016 17:13:32 -0700
Message-Id: <1474676014-134568-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1474676014-134568-1-git-send-email-bmwill@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a submodule-prefix enviorment variable
'GIT_INTERNAL_SUBMODULE_PREFIX' which can be used by commands which have
--recurse-submodule options.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h       | 1 +
 environment.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/cache.h b/cache.h
index 3556326..ae88a35 100644
--- a/cache.h
+++ b/cache.h
@@ -408,6 +408,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
+#define GIT_SUBMODULE_PREFIX_ENVIRONMENT "GIT_INTERNAL_SUBMODULE_PREFIX"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
diff --git a/environment.c b/environment.c
index ca72464..7380815 100644
--- a/environment.c
+++ b/environment.c
@@ -120,6 +120,7 @@ const char * const local_repo_env[] = {
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
+	GIT_SUBMODULE_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
 	GIT_COMMON_DIR_ENVIRONMENT,
 	NULL
-- 
2.8.0.rc3.226.g39d4020

