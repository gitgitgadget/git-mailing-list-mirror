Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F497C2D0A3
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1858223B0
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa4Wwi7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786745AbgJZQ5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:57:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38667 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786707AbgJZQ5b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 12:57:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id n18so13469686wrs.5
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 09:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ydgUZWdOThFfcRRnjXI0SMHojzJUaiR3XlSG8RcHs+k=;
        b=sa4Wwi7RBXYd6d4VxubQpxUZOTOzND28kpQmG4R153nbDNlAg2snXO2R98D5pi9LYt
         Ly0a7PlEqJ2C+ZIgAe+sXrNPCTjSGQoC09dL0nYGErF1PRDkbyGR4mxuWeNo4Fj43EB/
         vNbuJrNX+K9sDSgkV+pR2qAWOcmUhCuYpQy9uNbC6LubUbiN70oyISd262JiAw5xVmVr
         j95geZe8SWtizcgzxFR+NrB1/ns+se2t+0AcgF6xFf8M0xmJu/+KQnq0ZOuXxUewK9VF
         e3tJjDzm1yqFjmNHQbKNKIn4iJV2k7juNY2ooYIfgFyHq3kycB/AFuwQP4vRsJL/PAhX
         agqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ydgUZWdOThFfcRRnjXI0SMHojzJUaiR3XlSG8RcHs+k=;
        b=o71xo4n/USxHC0i40nOjTgUNAQLG8/STr7t5bgPA3eZIebWiFpgqjtVTv8AQgyWss2
         lFnKUFFKzL9ODLXPob97vCOogrupD41Tkx8EnA7AMMvGoB49LcmUQeoXNf04t9ladZJI
         KIp/L7KsZgwEXaUGPmCVS74+/uiurjLer9Nijon+ArGEylnia6tlTZXdJ1mnaNftpSLm
         nrifa0nhDmbyj45XBTxJZifuZjQZ4O7sQ/XKmjgjPePJDw0fvWZU/lWhv9iHcaADO2vc
         6WR/MkQkk737DEm7Ta2Bw5mFWc7zu4ME5YfZh9rLUxrRYEsYGjvfa6LHMQagtUz7ITlj
         8uRA==
X-Gm-Message-State: AOAM531QYFVqKMffKfEBXMmuWqLIrCMG9kXrcr5a3g4p5MLGxgFb5dTZ
        di/q/jnRaOrgcJvzz839EHnrhi4b25c=
X-Google-Smtp-Source: ABdhPJywmdiJMogg8F7K9b4d/QBp3aA9bXGavMxRye52JiahflH17HIZZs9t7jACYDj3sDnW8/cCFw==
X-Received: by 2002:a5d:6904:: with SMTP id t4mr19823875wru.410.1603731449532;
        Mon, 26 Oct 2020 09:57:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h206sm22149807wmf.47.2020.10.26.09.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:57:29 -0700 (PDT)
Message-Id: <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 16:57:24 +0000
Subject: [PATCH v2 0/4] Beginning of new merge strategy: New API, empty implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this series, I try to show the new merge API I have developed in
merge-ort and show how it differs from that provided by merge-recursive. I
do this in four steps, each corresponding to a patch.

Changes since v1 (thanks to Taylor and Peter for the suggestions in their
reviews):

 * Point out in the first commit message that the next three patches will be
   providing example usage of the new API.
 * Rename a variable away from '_' in a way that continues the "private"
   theme.
 * Unswap function comments that were placed next to the wrong functions.

Elijah Newren (4):
  merge-ort: barebones API of new merge strategy with empty
    implementation
  merge-ort-wrappers: new convience wrappers to mimic the old merge API
  fast-rebase: demonstrate merge-ort's API via temporary/hidden command
  merge,rebase,revert: select ort or recursive by config or environment

 Makefile              |   3 +
 builtin.h             |   1 +
 builtin/fast-rebase.c | 210 ++++++++++++++++++++++++++++++++++++++++++
 builtin/merge.c       |  26 +++++-
 builtin/rebase.c      |   9 +-
 builtin/revert.c      |   2 +
 git.c                 |   1 +
 merge-ort-wrappers.c  |  62 +++++++++++++
 merge-ort-wrappers.h  |  25 +++++
 merge-ort.c           |  52 +++++++++++
 merge-ort.h           |  49 ++++++++++
 sequencer.c           |  71 +++++++++++---
 12 files changed, 496 insertions(+), 15 deletions(-)
 create mode 100644 builtin/fast-rebase.c
 create mode 100644 merge-ort-wrappers.c
 create mode 100644 merge-ort-wrappers.h
 create mode 100644 merge-ort.c
 create mode 100644 merge-ort.h


base-commit: 69986e19ffcfb9af674ae5180689ab7bbf92ed28
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-895%2Fnewren%2Fort-api-with-empty-implementation-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-895/newren/ort-api-with-empty-implementation-v2
Pull-Request: https://github.com/git/git/pull/895

Range-diff vs v1:

 1:  54ef18182c ! 1:  b9e73975ea merge-ort: barebones API of new merge strategy with empty implementation
     @@ Commit message
          can perform a merge between two branches, neither of which match the
          index or the working tree, without clobbering the index or working tree.
      
     +    The next three commits will demonstrate various uses of this new API.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Makefile ##
     @@ merge-ort.h (new)
      +
      +	/*
      +	 * Additional metadata used by merge_switch_to_result() or future calls
     -+	 * to merge_inmemory_*().
     ++	 * to merge_inmemory_*().  Not for external use.
      +	 */
     -+	unsigned _;
      +	void *priv;
     ++	unsigned ate;
      +};
      +
     -+/* rename-detecting three-way merge, no recursion. */
     ++/* rename-detecting three-way merge with recursive ancestor consolidation. */
      +void merge_inmemory_recursive(struct merge_options *opt,
      +			      struct commit_list *merge_bases,
      +			      struct commit *side1,
      +			      struct commit *side2,
      +			      struct merge_result *result);
      +
     -+/* rename-detecting three-way merge with recursive ancestor consolidation. */
     ++/* rename-detecting three-way merge, no recursion. */
      +void merge_inmemory_nonrecursive(struct merge_options *opt,
      +				 struct tree *merge_base,
      +				 struct tree *side1,
 2:  f597609b88 = 2:  a9fff811a2 merge-ort-wrappers: new convience wrappers to mimic the old merge API
 3:  a1357fb3b3 = 3:  f38d140c15 fast-rebase: demonstrate merge-ort's API via temporary/hidden command
 4:  06ecea215f = 4:  5f6c97b889 merge,rebase,revert: select ort or recursive by config or environment

-- 
gitgitgadget
