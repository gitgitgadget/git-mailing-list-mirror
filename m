Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856ECC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4BE6113D
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349956AbhIHSTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 14:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349892AbhIHST3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 14:19:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E88EC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 11:18:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a62-20020a254d410000b0290592f360b0ccso3412402ybb.14
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xt/VX876xrsX5wgQ+eNdVWWflK1GwqJS1EuQBodiZtQ=;
        b=BrgeI4BX6J3bVAUHd93iaYkHi3XQxK81pmkn80ZSciETdwAJf9QueTSNZJmQz23NSU
         EzGecU1YQMfzXF8nfxkXs2+//eVRK1U+hhZnr0q+YwvQI0jE4l27xOQajxtAgV7eMR9G
         pJRSxJyvIMUx0eK34W5WvPjfSJWhs1yPTFe8B3/xqBnf/M4YpgwTFgBLZkN4LMb1G28j
         vG6UnjjBMGoRU69Ou5k1FFop6ylzuYwDsI7elJxzjIC6LNW5B4inDxeDhi2kKW3ysV4f
         QHF2dNZ2gtz45+vIL4tBbQDfvqFLrvQNfgglGb69GDje/gVaYW9RGvqUNZyU4rSeKmSK
         Sc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xt/VX876xrsX5wgQ+eNdVWWflK1GwqJS1EuQBodiZtQ=;
        b=2KuivXax9cHz6tY99vJ14oHGAZzWIa8mR+bmb/75u4LEu5y/phbmtmYYYW0WNnMNHx
         owlB4QM8do0KNqk6g3O/OXkc+nzdWN4b5SRNz/1BsgMscnV8jeVamisUxyvElizxTiyk
         kv4/BzyEcwwSwv5NKOQIzEtw2e2ypdf5kHItnmAos7n3gEsZ3JBMQlmkyHano2tb4c4c
         ILfzJ2RGtwXaVelFE9n3Bbp1dPYXHxhqk23Vnl0GPhw+GL7mTexcEPet8mtCHV7DSlWb
         LeRELPb5PTomocVdH5NRMeEB3tnwXGkdJxBUEFpd9O3ZbxK9G4CSrwX+WXKX+fPvYRka
         jgbQ==
X-Gm-Message-State: AOAM5324/j2WoWRs8PGKt1CuedEHYJ2sJ4j31krGb8ByCDszBXyAhE0b
        X/PcYqRkqFsW7mSLptnxSedgPkG2F6YQv37nH83xBz8SlKZkiVeUMQBXbBea7L8M4nwnUsiBSqx
        ETplReN0YzAMm76Lm2VgedllLX69stQ92D3kRJK60Ru6fQsY8NWf0NnTZ/TAVT9dJn3M8VPmECD
        b9
X-Google-Smtp-Source: ABdhPJx0C8w8GvqG8kRi7jnu2vx11fKTg4at0scl0VfFhJGA1Gr9Qp+1ijzYwbfpaf5aJ2Soxe3j0kAmI/Bc/pAH9lDe
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:6087:: with SMTP id
 u129mr6138288ybb.513.1631125100457; Wed, 08 Sep 2021 11:18:20 -0700 (PDT)
Date:   Wed,  8 Sep 2021 11:18:12 -0700
Message-Id: <cover.1631123754.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 0/3] More add_submodule_odb() cleanup in merge code
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(CC-ing Elijah in case he has insight into the merge-ort part.)

While continuing the effort into removing add_submodule_odb() (as part
of the submodule partial clone effort) I came across this part of the
merge code that specifies the repository being operated on in two ways:
one as a struct repository pointer and the other as a path. This patch
set unifies the two.

I normally would not send refactoring patches unless I also have a
feature patch that uses the results of said refactoring, but in this
case, I think that these patches are worth having since they clarify a
potentially unclear part of the API.

Note that these patches mean that the merging code no longer supports
submodules that have their .git dirs in the worktree, but from what I
can tell, this seems to be the direction we're going in
(repo_submodule_init() does not support such submodules).

Patch 3 is included to show how I'm verifying some things. Including
something like that in the master branch would probably require
conditional compilation (to exclude the additional field in struct
object used for checking, among other things), so I'm just including it
here for informational purposes.

All these patches work under GIT_TEST_MERGE_ALGORITHM=recursive and
GIT_TEST_MERGE_ALGORITHM=ort (and when that envvar is unset, for good
measure).

Jonathan Tan (3):
  t6437: run absorbgitdirs on repos
  revision: remove "submodule" from opt struct
  DO NOT SUBMIT commit-reach,revision: verify non-mixing

 alloc.c                    |  2 +
 commit-reach.c             | 60 +++++++++++++++++-------
 merge-ort.c                | 55 +++++++++++++++-------
 merge-recursive.c          | 51 +++++++++++++-------
 object.h                   |  1 +
 revision.c                 | 96 ++++++++++++++++++++++----------------
 revision.h                 |  1 -
 t/t6437-submodule-merge.sh |  9 ++--
 8 files changed, 179 insertions(+), 96 deletions(-)

-- 
2.33.0.309.g3052b89438-goog

