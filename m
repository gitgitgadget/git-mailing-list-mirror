Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E23BC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 08:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiGUIRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 04:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiGUIQp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 04:16:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3607D7B6
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k11so676586wrx.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8hOFrkxXUiIasWHVohoJoM+SqtUciFu2UG5GIzqdmgU=;
        b=EZjJqDssuqERMfUuVTspAKXG3kvQHiGZQ9m0Hto6qTZH5GvJAr/IqK60/AL7XgP0yR
         sRVK0BVqGGBrzKIHBfH0/AiARaNu+809A2lcS0q0kEIRmovKkwFB0Ub1bUP5uFxGs9gg
         KoO38AgHYMC6cFaFi2P4roU446KtCrQHupMujLR+LsnnZDQIEhM6J3lpCYNk2xAlSpgH
         J+DiTKMB2ZYgESrwG3V9+igtImVdy3+r3+FX0M74gwhDVCprRTFOu4X2LpcDSlbpXzTi
         kMbbaJJFuhDxpDOxjVZw9XF3BFRU653xBWkLXzF1UPb6qEUJ1zM4z+GUyBnExCjubIZd
         vMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8hOFrkxXUiIasWHVohoJoM+SqtUciFu2UG5GIzqdmgU=;
        b=VvbpJtJR9bBu0gIw7muz90vEgNWRx46GTsCVG3/G/QQapg+YHzPe0fkiZJ2OGq9dwC
         WlrMPWPhKsd/QGkYk4XihcyzdiuWGv2T4NzEpN5vwiqBSiq36xkhtG8W8YC9p3PwCUSl
         5k+kvwEO06ZOC3TYUyUXXFkP84qnLFcA0I9L1OCfbi442UGBDVp5MS8eDzh4XURYIKQi
         1iVM5Y0pUD7Kn4RMEp+9TJa5L7WHE5qsgjCe5FnWrul94F92HuFLfw5eCpdTKn14MPQS
         XDR0nuUpau+QyT1BwiRcs8SQoYR+xlukZ82EBLJ5V/oK3VWlYNFTGmXgXIYy27Xrmxj7
         cWEQ==
X-Gm-Message-State: AJIora+GkcW9c9gc4hjpwUBTLMNDwqkif3i2LweL5rVmt0tsLp4nK04i
        tSnQ/K6ci/2ys7iTLXa7W105rQugPVI=
X-Google-Smtp-Source: AGRyM1u6J54yzUOfS73YYRazpKGFia/hzkkJozlAVuJkCUm4KVe/G7ojLqumrabCuvkdUyQkExxRKQ==
X-Received: by 2002:a5d:414a:0:b0:21d:6be5:1765 with SMTP id c10-20020a5d414a000000b0021d6be51765mr34246617wrq.419.1658391402536;
        Thu, 21 Jul 2022 01:16:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003a32251c3f9sm5732267wms.5.2022.07.21.01.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:16:42 -0700 (PDT)
Message-Id: <887967c1f3fd6f03cf1d0bb3c19ed16819541092.1658391391.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 08:16:30 +0000
Subject: [PATCH v3 6/7] merge: ensure we can actually restore pre-merge state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Merge strategies can:
  * succeed with a clean merge
  * succeed with a conflicted merge
  * fail to handle the given type of merge

If one is thinking in terms of automatic mergeability, they would use
the word "fail" instead of "succeed" for the second bullet, but I am
focusing here on ability of the merge strategy to handle the given
inputs, not on whether the given inputs are mergeable.  The third
category is about the merge strategy failing to know how to handle the
given data; examples include:

  * Passing more than 2 branches to 'recursive' or 'ort'
  * Passing 2 or fewer branches to 'octopus'
  * Trying to do more complicated merges with 'resolve' (I believe
    directory/file conflicts will cause it to bail.)
  * Octopus running into a merge conflict for any branch OTHER than
    the final one (see the "exit 2" codepath of commit 98efc8f3d8
    ("octopus: allow manual resolve on the last round.", 2006-01-13))

That final one is particularly interesting, because it shows that the
merge strategy can muck with the index and working tree, and THEN bail
and say "sorry, this strategy cannot handle this type of merge; use
something else".

Further, we do not currently expect the individual strategies to clean
up after themselves, but instead expect builtin/merge.c to do so.  For
it to be able to, it needs to save the state before trying the merge
strategy so it can have something to restore to.  Therefore, remove the
shortcut bypassing the save_state() call.

There is another bug on the restore_state() side of things, so no
testcase will be added until the next commit when we have addressed that
issue as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f807bf335bd..11bb4bab0a1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1686,12 +1686,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * tree in the index -- this means that the index must be in
 	 * sync with the head commit.  The strategies are responsible
 	 * to ensure this.
+	 *
+	 * Stash away the local changes so that we can try more than one
+	 * and/or recover from merge strategies bailing while leaving the
+	 * index and working tree polluted.
 	 */
-	if (use_strategies_nr == 1 ||
-	    /*
-	     * Stash away the local changes so that we can try more than one.
-	     */
-	    save_state(&stash))
+	if (save_state(&stash))
 		oidclr(&stash);
 
 	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
-- 
gitgitgadget

