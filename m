Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF994C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 23:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbiF0XUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbiF0XUV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 19:20:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FE24095
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 16:20:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s1so15097143wra.9
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dC7zu0g7q0DZybNVr+B74oxgXF0YkxKWLPuktbSqfGY=;
        b=Xa2zLAkAPJNPvgKhl+KcMwbbNNDJlXfRfvvsJ3kxEC1yo3JPiC2S6v5Q+QiQ0iUh06
         jXW8UtsoCtU0MX4+8AKmaUNNVR6fOFYJad1GQlXIgO0rGL927LIjajX82lpvIe5Q4nmo
         KW72YIe5BWevcFHApewTPb/kBfLtRhaljIRlZlOe/EODVMlpmvHr7KAfLRywrs2vaUBu
         cyid8BuLS55qpWIboLMltI8dISXleZLbTyS19Q6qWz09X0Ms0KDsRgfcgkstSeTEEi1J
         NB4LZFioRh++a5lcVEFycBWdCajYpjyPqXBDzlL7v6muezTWlFj9fTPWBIKEgGG0RmG+
         uW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dC7zu0g7q0DZybNVr+B74oxgXF0YkxKWLPuktbSqfGY=;
        b=TTP6Ubzo0GgN4Zepaxwuxbrh7n8SBmO/h5slTGgCj18AESsOzbBFIqTkYdF+nWMtDz
         5pfdXq12S0zH5N4IF7H6EH+tw75+ruEST4JrWpTRj9cfB1AQ90yGuw4Sta5D8qBC4H7D
         4aPCjTAufuaLa3jXDuJu4H8R31ZNiOVrO44ERH9LAedcygKfPwZQSUleRVTL14CkMrfv
         qR4Q/OldZubtxIWapXRzQItkjmdfArs346/3GqydMmTH8lPQP/LyRCCt51Fo8c01q7AX
         GZD0ncf6l5f/qcmuLwXQ50MNs9aifnWnVf5xJpV1nlUKnntRuG2FTMwVy7isJpI2Sqw0
         c8qg==
X-Gm-Message-State: AJIora/0BmOVYAP42WFIk4AJkO9eqnrhIqgwD3A51uEc7IQ9wumjrrop
        7gi2p1jM6dzgJwZ6hm/tGdiGfMULJm5NLA==
X-Google-Smtp-Source: AGRyM1st6ZY9dQnkVYqzgUwlhFTq64MPOnoz+cGJv+IwE2WPo5Z386ncoZjarXVa4aSZ6N5KqPFV0w==
X-Received: by 2002:a5d:5262:0:b0:21b:84a8:8417 with SMTP id l2-20020a5d5262000000b0021b84a88417mr14438769wrc.119.1656372018726;
        Mon, 27 Jun 2022 16:20:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a1c6a08000000b003a044fe7fe7sm9188480wmc.9.2022.06.27.16.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:20:18 -0700 (PDT)
Message-Id: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 23:20:12 +0000
Subject: [PATCH 0/5] submodule: remove "--recursive-prefix"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

= Description

This series is a refactor of "git submodule--helper update" that replaces
"--recursive-prefix" with "--super-prefix" (see Background). This was
initially motivated by:

 * Junio's suggestion to simplify the code [1] (in response to a memory leak
   found by Johannes Schindelin [2]).
 * A desire to use the module_list API + get_submodule_displaypath() outside
   of builtin/submodule--helper.c (I expect to use this to check out
   branches in each submodule).

But it also happens to remove some overly complicated/duplicated code that
was literally converted from shell :)

= Background

When recursing into nested submodules, Git commands keep track of the path
from the superproject to the submodule in order to print a "display path" to
the user, e.g.

Submodule path '../super/sub/nested-sub': checked out 'abcdef'

For historical reasons, "git submodule--helper update" uses
"--recursive-prefix" for this purpose, but it should use "--super-prefix"
instead because:

 * That's what every other command uses (not just submodule--helper
   subcommands).
 * Using the "--super-prefix" helper functions makes the "git
   submodule--helper update" code simpler

= Patch organization

 * Patch 1/5 makes sure that display paths are only computed using display
   path helper functions ([do_]get_submodule_displaypath()) and fixes some
   display paths that we never realized were broken.
 * Patches 2-3/5 simplify and deduplicate some display path computations.
 * Patch 4/5 replaces "--recursive-prefix" with "--super-prefix", making
   do_get_submodule_displaypath() obsolete.
 * Patch 5/5 removes do_get_submodule_displaypath().

= Interactions with other series

This would have been rebased onto ab/submodule-cleanup, but it's not yet
clear to me if that series will be merged first. That series is almost done,
but Ævar is still doing some digging on SUPPORT_SUPER_PREFIX [3] and may
come back with findings that affect this series.

Fortunately, this series is only tangentially related to
ab/submodule-cleanup, and the conflicts are quite simple:

| this | ab/submodule-cleanup | resolution |
|-----------------------------+-------------------------------+---------------------------|
| push --super-prefix arg | add new "ud" var | keep both |
|-----------------------------+-------------------------------+---------------------------|
| remove "--recursive-prefix" | add "--checkout", "--rebase", | keep both |
| | "--merge" | |
|-----------------------------+-------------------------------+---------------------------|
| add SUPPORT_SUPER_PREFIX | remove SUPPORT_SUPER_PREFIX | keep
ab/submodule-cleanup | | to "git submodule--helper | from "git
submodule--helper" | | | update" | | |

= Future work

At the end of this series, get_submodule_displaypath() can be moved to
submodule.h, which would make submodule.c:get_super_prefix_or_empty()
obsolete. I have a patch that demonstrates this (CI run: [4]), but I decided
to keep this series more focused on "git submodule--helper update" so that
it's easier to review.

[1] https://lore.kernel.org/git/xmqq35g5xmmv.fsf@gitster.g [2]
https://lore.kernel.org/git/877a45867ae368bf9e053caedcb6cf421e02344d.1655336146.git.gitgitgadget@gmail.com
[3]
https://lore.kernel.org/git/patch-v3-02.12-082e015781e-20220622T142012Z-avarab@gmail.com
[4] https://github.com/chooglen/git/actions/runs/2572557584

Glen Choo (5):
  submodule--helper update: use display path helper
  submodule--helper: don't recreate recursive prefix
  submodule--helper: use correct display path helper
  submodule--helper update: use --super-prefix
  submodule--helper: remove display path helper

 builtin/submodule--helper.c | 82 +++++++++----------------------------
 t/t7406-submodule-update.sh | 59 ++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 62 deletions(-)


base-commit: 39c15e485575089eb77c769f6da02f98a55905e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1282%2Fchooglen%2Fsubmodule%2Fremove-recursive-prefix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1282/chooglen/submodule/remove-recursive-prefix-v1
Pull-Request: https://github.com/git/git/pull/1282
-- 
gitgitgadget
