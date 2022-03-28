Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C560C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 14:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbiC1OD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiC1OD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 10:03:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264E45EBF3
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n35so8448890wms.5
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nw49BMaoTkahNaO04BaBlwhV8/MFsK39zzjQi/XasVM=;
        b=BAsxUf4uuDia810d2iyXgySdsrdTkxpVWvEx1G0ALd4gXYY3eELas5MOW1M5PkVyX9
         iD2zGywl7Ict8DAlw5dkG6BZXl3x/AOz3zpATcbW1YwIi7XEU8arsCEGat62zQp1mIYq
         CunaRKSKNENyTfgpyAJZu21C2O/LWBZAZCrin3xEq34xwO6fwYcYg9Qb4fuxkSdCbeLc
         COIgvujN9EfmfOmtB9RiVLdvtXQe+ut98rw1y+ntGPdgV9yH5InC2bnfCZJY0rCjAxoW
         I66lfGodOUJrxPT4G59+NCim5FVNB+oeW8EE5ku0n05rrTzVW9G8SLoHWkex+QX8a+rB
         /F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nw49BMaoTkahNaO04BaBlwhV8/MFsK39zzjQi/XasVM=;
        b=FhfWTMtt0ZKSRopgFshLDgnmbzCHHpRMrpgDt+fwpOgRgERVYq60dVI0bZgno0gqtR
         O1j+jDBa4VRCAG4f/oBfaT4J4cHnFA+sqorqz2EX/SUZdw5hIJS8ml1RXRQLo5kGccHD
         hfLdSo7AqYLjKkwjGgq2Rxn8joT1m1lhARTeu2cnZfJvebbRQlJ6Qd4GYCyzhRRcHrs1
         EtyhbjIOEF5XIaM9DIi/poPKqygr8F6NkLV/qgiyO33dMief/QyJXS0M5ccKczlMABQg
         6aDwYPFM3fxKCNBchMCTtfY0qKvW3cZ3JyI1uzACALQxg032y8PdkASOI8mLXW1QcQZ5
         rSjQ==
X-Gm-Message-State: AOAM530AW9eD8V71aUHnHTz+WPisZsrJJnetkG1SASJjlv0bRO1FGf/B
        wHB9TFlMwFK01cH+reU/7QTMJvJBHm8=
X-Google-Smtp-Source: ABdhPJz9dnukCCltBkNdsaJpPUKG4iMvfD6Lxw3lMhoLMgnDheiDBdsADqPHuquT9X+aMHTePgZ9jw==
X-Received: by 2002:a05:600c:590:b0:38c:804e:4197 with SMTP id o16-20020a05600c059000b0038c804e4197mr26858092wmd.22.1648476133842;
        Mon, 28 Mar 2022 07:02:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14-20020a056000154e00b00203f8adde0csm15584725wry.32.2022.03.28.07.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:02:12 -0700 (PDT)
Message-Id: <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 14:02:04 +0000
Subject: [PATCH v4 0/7] fetch: add repair: full refetch without negotiation (was: "refiltering")
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a filter is changed on a partial clone repository, for example from
blob:none to blob:limit=1m, there is currently no straightforward way to
bulk-refetch the objects that match the new filter for existing local
commits. This is because the client will report commits as "have" during
fetch negotiation and any dependent objects won't be included in the
transferred pack. Another use case is discussed at [1].

This patch series introduces a --refetch option to fetch & fetch-pack to
enable doing a full fetch without performing any commit negotiation with the
remote, as a fresh clone does. It builds upon cbe566a071 ("negotiator/noop:
add noop fetch negotiator", 2020-08-18).

 * Using --refetch will produce duplicated objects between the existing and
   newly fetched packs, but maintenance will clean them up when it runs
   automatically post-fetch (if enabled).
 * If a user fetches with --refetch applying a more restrictive partial
   clone filter than previously (eg: blob:limit=1m then blob:limit=1k) the
   eventual state is a no-op, since any referenced object already in the
   local repository is never removed. More advanced repacking which could
   improve this scenario is currently proposed at [2].

[1]
https://lore.kernel.org/git/aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com/
[2]
https://lore.kernel.org/git/21ED346B-A906-4905-B061-EDE53691C586@gmail.com/

Changes since v3:

 * Mention fetch --refetch in the remote.<name>.partialclonefilter
   documentation.

Changes since v2:

 * Changed the name from "repair" to "refetch". While it's conceivable to
   use it in some object DB repair situations that's not the focus of these
   changes.
 * Pass config options to maintenance via GIT_CONFIG_PARAMETERS
 * Split out auto-maintenance to a separate & more robust test
 * Minor fixes/improvements from reviews by Junio & Ævar

Changes since RFC (v1):

 * Changed the name from "refilter" to "repair"
 * Removed dependency between server-side support for filtering and repair
 * Added a test case for a shallow clone
 * Post-fetch auto maintenance now strongly encourages
   repacking/consolidation

Reviewed-by: Calvin Wan calvinwan@google.com

Robert Coup (7):
  fetch-negotiator: add specific noop initializer
  fetch-pack: add refetch
  builtin/fetch-pack: add --refetch option
  fetch: add --refetch option
  t5615-partial-clone: add test for fetch --refetch
  fetch: after refetch, encourage auto gc repacking
  docs: mention --refetch fetch option

 Documentation/config/remote.txt           |  6 +-
 Documentation/fetch-options.txt           | 10 +++
 Documentation/git-fetch-pack.txt          |  4 ++
 Documentation/technical/partial-clone.txt |  3 +
 builtin/fetch-pack.c                      |  4 ++
 builtin/fetch.c                           | 34 +++++++++-
 fetch-negotiator.c                        |  5 ++
 fetch-negotiator.h                        |  8 +++
 fetch-pack.c                              | 46 ++++++++-----
 fetch-pack.h                              |  1 +
 remote-curl.c                             |  6 ++
 t/t5616-partial-clone.sh                  | 81 ++++++++++++++++++++++-
 transport-helper.c                        |  3 +
 transport.c                               |  4 ++
 transport.h                               |  4 ++
 15 files changed, 197 insertions(+), 22 deletions(-)


base-commit: abf474a5dd901f28013c52155411a48fd4c09922
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1138%2Frcoup%2Frc-partial-clone-refilter-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1138/rcoup/rc-partial-clone-refilter-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1138

Range-diff vs v3:

 1:  96a75be3d8a = 1:  6cd6d4a59f6 fetch-negotiator: add specific noop initializer
 2:  04ca6a07f85 = 2:  03f0de3d28c fetch-pack: add refetch
 3:  879d30c4473 = 3:  f7942344ff8 builtin/fetch-pack: add --refetch option
 4:  a503b98f333 = 4:  78501bbf281 fetch: add --refetch option
 5:  01f22e784a5 = 5:  6c17167ac1e t5615-partial-clone: add test for fetch --refetch
 6:  31046625987 = 6:  28c07219fd8 fetch: after refetch, encourage auto gc repacking
 7:  f923a06aab5 ! 7:  da1e6de7a9f doc/partial-clone: mention --refetch fetch option
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    doc/partial-clone: mention --refetch fetch option
     +    docs: mention --refetch fetch option
      
     -    Document it for partial clones as a means to apply a new filter.
     +    Document it for partial clones as a means to apply a new filter, and
     +    reference it from the remote.<name>.partialclonefilter config parameter.
      
          Signed-off-by: Robert Coup <robert@coup.net.nz>
      
     + ## Documentation/config/remote.txt ##
     +@@ Documentation/config/remote.txt: remote.<name>.promisor::
     + 	objects.
     + 
     + remote.<name>.partialclonefilter::
     +-	The filter that will be applied when fetching from this
     +-	promisor remote.
     ++	The filter that will be applied when fetching from this	promisor remote.
     ++	Changing or clearing this value will only affect fetches for new commits.
     ++	To fetch associated objects for commits already present in the local object
     ++	database, use the `--refetch` option of linkgit:git-fetch[1].
     +
       ## Documentation/technical/partial-clone.txt ##
      @@ Documentation/technical/partial-clone.txt: Fetching Missing Objects
         currently fetches all objects referred to by the requested objects, even

-- 
gitgitgadget
