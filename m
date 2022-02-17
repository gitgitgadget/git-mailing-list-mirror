Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8988CC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 21:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbiBQVAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 16:00:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243881AbiBQVAs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 16:00:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9945D163D79
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 13:00:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e3so11176847wra.0
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 13:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hAW6R2ySxgelOc2U0U+hzA3PQNVnJvQAk9GJQ1kfQuM=;
        b=XJcFD9NbXSqiO4ah5BmuSZLLcqI8KNLdNJpjjjnsjVDKISOpWdWh7/ammOvp/rboTG
         0m+gtICIFHLkPozARtUWF3bgiKHBWZJFBLCwh+1hlwYTJMrwpQbn0iDu9km5OWKGK9nu
         gbDwNsmtrPk1iGsIpF/wlMau4ms2lVmxeHhTlLXSbG9hU9u1owOye08vYPikPussbeg7
         NINY2s0sW/HmkNHvA6jDr80DLXBUppnD4nhFrSCKhS8Z5I64qeK//8pCibHB43SbridU
         6N6wZEiIsAGcW5w5SXh/nbe4BdOOZGmUuyVb6t3vUThOvfOsUTrkx0Ddn6F32G4a5GDd
         a0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hAW6R2ySxgelOc2U0U+hzA3PQNVnJvQAk9GJQ1kfQuM=;
        b=nr+5Q2A2do2ZATnVv2Foi05lOP1/mkGvpMRA53RlGWy8cJaLmB8EZNoJWTm0HaKeUZ
         oHUX2M+tAPsO7/M8cvcX8bw+XLLAbt4MsvPcRAnRmxGOy68Vmae9XPu0LNQHPk4cREme
         V/86EM22ZMijufvdCuWVqeWXzfazVFm8qeAZ9UEKALWOvB9XVCv7++aXb4P2pEYE01/I
         o7svHrRmn6ixkNuWeZ9ClxNsUcJ0JYbKNcxsEbr6EqCWDUtLklpyk1Kv/aTsK/w2s5b/
         01iDSzf/UspCOVYc3+hrRJrtVlLmtTWoDRy7ICgZ0v7U0U3OZ7w7uhAu+81asTd9z/Y3
         VK2g==
X-Gm-Message-State: AOAM530CMyoCcLBdkdwRRJJbAayUx96cJmRwA3sF3HeGaphUiacFAXu4
        TLxpgkSDK006xtejwEauyqLcsBrVPvc=
X-Google-Smtp-Source: ABdhPJzAZHArCWTdc3BHgJcCKnonIEJADW6otUOY706cz3DRsLELAqj973Q//a9zyDrTMkgGSX4+Mw==
X-Received: by 2002:adf:fbd0:0:b0:1e6:8ec3:570 with SMTP id d16-20020adffbd0000000b001e68ec30570mr3907101wrs.396.1645131631775;
        Thu, 17 Feb 2022 13:00:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13sm39694010wrv.24.2022.02.17.13.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 13:00:31 -0800 (PST)
Message-Id: <pull.1058.v2.git.1645131630140.gitgitgadget@gmail.com>
In-Reply-To: <pull.1058.git.1644860224151.gitgitgadget@gmail.com>
References: <pull.1058.git.1644860224151.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 21:00:29 +0000
Subject: [PATCH v2] dir: force untracked cache with core.untrackedCache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The GIT_FORCE_UNTRACKED_CACHE environment variable writes the untracked
cache more frequently than the core.untrackedCache config variable. This
is due to how read_directory() handles the creation of an untracked
cache.

Before this change, Git would not create the untracked cache extension
for an index that did not already have one. Users would need to run a
command such as 'git update-index --untracked-cache' before the index
would actually contain an untracked cache.

In particular, users noticed that the untracked cache would not appear
even with core.untrackedCache=true. Some users reported setting
GIT_FORCE_UNTRACKED_CACHE=1 in their engineering system environment to
ensure the untracked cache would be created.

The decision to not write the untracked cache without an environment
variable tracks back to fc9ecbeb9 (dir.c: don't flag the index as dirty
for changes to the untracked cache, 2018-02-05). The motivation of that
change is that writing the index is expensive, and if the untracked
cache is the only thing that needs to be written, then it is more
expensive than the benefit of the cache. However, this also means that
the untracked cache never gets populated, so the user who enabled it via
config does not actually get the extension until running 'git
update-index --untracked-cache' manually or using the environment
variable.

We have had a version of this change in the microsoft/git fork for a few
major releases now. It has been working well to get users into a good
state. Yes, that first index write is slow, but the remaining index
writes are much faster than they would be without this change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    dir: force untracked cache with core.untrackedCache
    
    We have seen users in the wild that have had core.untrackedCache
    enabled, but never actually have an untracked cache created for them. We
    have a test in t7063 that shows git status should write the untracked
    cache, so I'm not exactly sure how users are in this state for long.
    
    This patch fixes the situation. I also know of another group that sets
    GIT_FORCE_UNTRACKED_CACHE=1 in their developer environment in order to
    get this behavior.
    
    -Stolee
    
    
    Update in v2
    ============
    
     * Edited the commit message to be clearer.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1058%2Fderrickstolee%2Funtracked-cache-write-more-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1058/derrickstolee/untracked-cache-write-more-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1058

Range-diff vs v1:

 1:  061ee9a379d ! 1:  8d132bc5566 dir: force untracked cache with core.untrackedCache
     @@ Commit message
          The GIT_FORCE_UNTRACKED_CACHE environment variable writes the untracked
          cache more frequently than the core.untrackedCache config variable. This
          is due to how read_directory() handles the creation of an untracked
     -    cache. The old mechanism required using something like 'git update-index
     -    --untracked-cache' before the index would actually contain an untracked
     -    cache. This was noted as a performance problem on macOS in the past, and
     -    this is a resolution for that issue.
     +    cache.
     +
     +    Before this change, Git would not create the untracked cache extension
     +    for an index that did not already have one. Users would need to run a
     +    command such as 'git update-index --untracked-cache' before the index
     +    would actually contain an untracked cache.
     +
     +    In particular, users noticed that the untracked cache would not appear
     +    even with core.untrackedCache=true. Some users reported setting
     +    GIT_FORCE_UNTRACKED_CACHE=1 in their engineering system environment to
     +    ensure the untracked cache would be created.
      
          The decision to not write the untracked cache without an environment
          variable tracks back to fc9ecbeb9 (dir.c: don't flag the index as dirty


 dir.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index d91295f2bcd..79a5f6918c8 100644
--- a/dir.c
+++ b/dir.c
@@ -2936,7 +2936,9 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 
 		if (force_untracked_cache < 0)
 			force_untracked_cache =
-				git_env_bool("GIT_FORCE_UNTRACKED_CACHE", 0);
+				git_env_bool("GIT_FORCE_UNTRACKED_CACHE", -1);
+		if (force_untracked_cache < 0)
+			force_untracked_cache = (istate->repo->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE);
 		if (force_untracked_cache &&
 			dir->untracked == istate->untracked &&
 		    (dir->untracked->dir_opened ||

base-commit: b80121027d1247a0754b3cc46897fee75c050b44
-- 
gitgitgadget
