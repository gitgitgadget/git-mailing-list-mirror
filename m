Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69590C6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDVUWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDVUWP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:22:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE439188
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:22:13 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so19943335e9.2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194932; x=1684786932;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifRidpigvacKsm6USGVzuT4L642KtiAk8Uj6R0staYo=;
        b=bw3Fx+tCBtx7HITbIpGJ5bQX7KFofMJkP79xIXLvzHC9/vY755AGB+PqxOcKQeieGZ
         DjfDlTHRzIqatbIf/Sn51RAxOs3kp8EZC6mak/mWpdMuyc9RqXOK7uceBpHDIz093Sed
         nzWuiozmSugfGfnQfHW1ng10uvR4L5RAAO/xQoVus3q9FrbN9VAG2sJcDlo+Kt8tgqM5
         mzVz6Ug7QUluR4ZQD92FucfQom0ROhpMDjNQTgotXvRhh1VN0BvlWOFjMkkQfqH/yKqJ
         LgeYbVC+ou4Ro5DLD0BISG4iM9MC45XSpQ4EB0f5UXcdAMFZiUXBbIyd1q+seqbac7qb
         7Jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194932; x=1684786932;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifRidpigvacKsm6USGVzuT4L642KtiAk8Uj6R0staYo=;
        b=L0MnGzZcNNocu5kswGOnYswfI5yJy8bmKqK/0tSmgJhpZPjhEFfPfC8SgpHziDuDT0
         KCgsq+fd7WvdNxA7UBJ003RWFG287rR2615uJ/LZGQIKYfICev4TxFFuIO0qQ4QX70LV
         NcEmhcO1i8J9QfmMEtoU0fe2KDUwg+Q8nMkamTjIfdNuwp+hvxAIL19TTmiYIs7371yv
         8olN6MLQFJUlTbBOuVZD4KChyrepzKM364gh8c3Bj52SIvfADWbkjIBharWjZElodQq1
         RY4JUaNnBrBX999iYWVIsN/VoeoosOvgpWJ8Jp746iBMSQ/1PHPLkk4OJtoxS5sjPnQJ
         AdgA==
X-Gm-Message-State: AAQBX9dTo8Eg0Gd24yipLtteB7bC0aiUbaUI2BUA/hVqJ9kt64UVwoZ+
        0QlT2ELTELLaWq0H63PxoowMYPJPhjo=
X-Google-Smtp-Source: AKy350YNrMKe6AJ0OsvnREeGCrhevlUszQw2ieUyT2JKIQlHY11YQTTvxe2DmxLlx596Lsoy0SgOgA==
X-Received: by 2002:a1c:7302:0:b0:3f1:758e:40eb with SMTP id d2-20020a1c7302000000b003f1758e40ebmr4067139wmb.17.1682194932154;
        Sat, 22 Apr 2023 13:22:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i40-20020a05600c4b2800b003ee6aa4e6a9sm11346994wmp.5.2023.04.22.13.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:22:11 -0700 (PDT)
Message-Id: <pull.1518.v2.git.1682194930766.gitgitgadget@gmail.com>
In-Reply-To: <pull.1518.git.1681974847078.gitgitgadget@gmail.com>
References: <pull.1518.git.1681974847078.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:22:10 +0000
Subject: [PATCH v2] merge-ort: fix calling merge_finalize() with no
 intermediate merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If some code sets up the data structures for a merge, but then never
actually performs one before calling merge_finalize(), then
merge_finalize() wouldn't notice that result->priv was NULL and
return early, resulting in following that NULL pointer and getting
a segfault.  There is currently no code in the git codebase that does
this, but this issue was found during testing of some proposed patches
that had the following structure:

    struct merge_options merge_opt;
    struct merge_result result;

    init_merge_options(&merge_opt, the_repository);
    memset(&result, 0, sizeof(result));

    <do N merges, for some value of N>

    merge_finalize(&merge_opt, &result);

where some flags could cause the code to have N=0, i.e. doing no merges.
Add a check for result->priv being NULL and return early to avoid a
segfault in these kinds of cases.

While at it, ensure the FREE_AND_NULL() in the function does something
useful with the nulling aspect, namely sets result->priv to NULL rather
than a mere temporary.

Reported-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-ort: fix calling merge_finalize() with no intermediate merge
    
    Changes since v1:
    
     * Moved code into an if-block instead of returning early, as suggested
       by Stolee.
    
    See
    https://lore.kernel.org/git/CABPp-BHCdjOutYqdMO1NbYKNA0BgkXRgwUEKK=MX0kXM-5G_DQ@mail.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1518%2Fnewren%2Ffix-merge-finalize-with-no-merge-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1518/newren/fix-merge-finalize-with-no-merge-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1518

Range-diff vs v1:

 1:  e636027f60c ! 1:  2cb1c63f05b merge-ort: fix calling merge_finalize() with no intermediate merge
     @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
       
      -	clear_or_reinit_internal_opts(opti, 0);
      -	FREE_AND_NULL(opti);
     -+	if (!result->priv)
     -+		return;
     -+	clear_or_reinit_internal_opts(result->priv, 0);
     -+	FREE_AND_NULL(result->priv);
     ++	if (result->priv) {
     ++		clear_or_reinit_internal_opts(result->priv, 0);
     ++		FREE_AND_NULL(result->priv);
     ++	}
       }
       
       /*** Function Grouping: helper functions for merge_incore_*() ***/


 merge-ort.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 5bf64354d16..29966fc082f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4718,14 +4718,14 @@ void merge_switch_to_result(struct merge_options *opt,
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result)
 {
-	struct merge_options_internal *opti = result->priv;
-
 	if (opt->renormalize)
 		git_attr_set_direction(GIT_ATTR_CHECKIN);
 	assert(opt->priv == NULL);
 
-	clear_or_reinit_internal_opts(opti, 0);
-	FREE_AND_NULL(opti);
+	if (result->priv) {
+		clear_or_reinit_internal_opts(result->priv, 0);
+		FREE_AND_NULL(result->priv);
+	}
 }
 
 /*** Function Grouping: helper functions for merge_incore_*() ***/

base-commit: 667fcf4e15379790f0b609d6a83d578e69f20301
-- 
gitgitgadget
