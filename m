Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0CBC2D0A3
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 02:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A25A20872
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 02:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMBP3BO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504368AbgJ0CIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 22:08:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45941 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504358AbgJ0CIP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 22:08:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id e17so53335wru.12
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 19:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eAGCMIrzYISgsOI4Ysb1VHLBxG1XuCYBgL7tA4PpUw4=;
        b=mMBP3BO67T09kAMdngCpCfUSCzr1Zutxa+HBfWz53tBdqqJjVC5Zn6wLoXxNRbUU7I
         7k2fZ6iiBKEoV6IWC7GeKSCsl5CdDJ0fJJhoKDCzCYwOfsSW9D3dtYuwQbIJsVz1OAv4
         PS8atJy5ynGHVY86Hfh+l4Xk7R0VCh7iS5KuUeyn6rZl5FVWXACvX6PHsrna4hO3Yls6
         /T+tFxbNXB3sKCA1XtU+ixW1xfhvZb5nzfnER9y/+jp24ZUEGzH7ZjHc0exwKUN4sayZ
         gMWjuJMkNUr33UkXnMTwcK8suoi8Jh98SBFTWuAk4uTKDRAVkrKeOXKSFCuflu9JCfr7
         jYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eAGCMIrzYISgsOI4Ysb1VHLBxG1XuCYBgL7tA4PpUw4=;
        b=pRTOx0Lap7l6YKYsq8+dRn6yYgBZBG908/rcpdEAEygMtUqHuoFnFr5whKInKnFPzx
         Ib0s7emwM6lNk4fHRwpoUCsLhzK2V4EjTemOiIJb6svnmBC8ED0PqZc0CJ0Svq0dCK6T
         PGoL+K/v9nGRo2Ti0UC7xF81iO+vZjksvVu5ZgPAlVm9dnMh9BdDxHPDx03gt9dlGpPW
         n+7Ke6SH0OGj8vDhERaRHSGHz5N+aAGK4+CFPz8YaSvQUXRfW0hyYFh0Ld+JG2Vd0FQF
         zzXlC7sd9Hieik8MrXksX+Oh4/T+MUFlTK2FgzR983foxP10HRWTkL83BiDaFFapFajD
         +leQ==
X-Gm-Message-State: AOAM5322G2Eo2BvIACt2Q0B+k2z8CtX5LPC1bqqfUkwiSuz765st0w4x
        nQq/Uram77M8LT1Z0kHdr9tG6tcriBI=
X-Google-Smtp-Source: ABdhPJxvTddy2HL6Ci6bMhlKPVuYiaxZYOd3SyGE7ci6+7g051rkIBbmIadjGZHdy14US/mts37lkA==
X-Received: by 2002:adf:97dd:: with SMTP id t29mr20644326wrb.322.1603764491602;
        Mon, 26 Oct 2020 19:08:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm25369194wrr.80.2020.10.26.19.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 19:08:11 -0700 (PDT)
Message-Id: <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
References: <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 02:08:06 +0000
Subject: [PATCH v3 0/4] Beginning of new merge strategy: New API, empty implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this series, I show the new merge API I have developed in merge-ort, and
show how it differs from that provided by merge-recursive. I do this in four
steps, each corresponding to a patch.

Changes since v2:

 * Extended comments in struct merge_result and in front of function
   definitions to make API usage clearer; in particular, noting how this
   merge backend differs in not using the index (and only updating it as
   part of merge_switch_to_result()).
 * Drop the other private field of struct merge_result, for now.
 * Rename merge_inmemory_* to merge_incore_*

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
 merge-ort.h           |  58 ++++++++++++
 sequencer.c           |  71 +++++++++++---
 12 files changed, 505 insertions(+), 15 deletions(-)
 create mode 100644 builtin/fast-rebase.c
 create mode 100644 merge-ort-wrappers.c
 create mode 100644 merge-ort-wrappers.h
 create mode 100644 merge-ort.c
 create mode 100644 merge-ort.h


base-commit: 69986e19ffcfb9af674ae5180689ab7bbf92ed28
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-895%2Fnewren%2Fort-api-with-empty-implementation-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-895/newren/ort-api-with-empty-implementation-v3
Pull-Request: https://github.com/git/git/pull/895

Range-diff vs v2:

 1:  b9e73975ea ! 1:  3357ea415e merge-ort: barebones API of new merge strategy with empty implementation
     @@ merge-ort.c (new)
      +	die("Not yet implemented");
      +}
      +
     -+void merge_inmemory_nonrecursive(struct merge_options *opt,
     -+				 struct tree *merge_base,
     -+				 struct tree *side1,
     -+				 struct tree *side2,
     -+				 struct merge_result *result)
     ++void merge_incore_nonrecursive(struct merge_options *opt,
     ++			       struct tree *merge_base,
     ++			       struct tree *side1,
     ++			       struct tree *side2,
     ++			       struct merge_result *result)
      +{
      +	die("Not yet implemented");
      +}
      +
     -+void merge_inmemory_recursive(struct merge_options *opt,
     -+			      struct commit_list *merge_bases,
     -+			      struct commit *side1,
     -+			      struct commit *side2,
     -+			      struct merge_result *result)
     ++void merge_incore_recursive(struct merge_options *opt,
     ++			    struct commit_list *merge_bases,
     ++			    struct commit *side1,
     ++			    struct commit *side2,
     ++			    struct merge_result *result)
      +{
      +	die("Not yet implemented");
      +}
     @@ merge-ort.h (new)
      +struct tree;
      +
      +struct merge_result {
     -+	/* whether the merge is clean */
     ++	/* Whether the merge is clean */
      +	int clean;
      +
     -+	/* Result of merge.  If !clean, represents what would go in worktree */
     ++	/*
     ++	 * Result of merge.  If !clean, represents what would go in worktree
     ++	 * (thus possibly including files containing conflict markers).
     ++	 */
      +	struct tree *tree;
      +
      +	/*
      +	 * Additional metadata used by merge_switch_to_result() or future calls
     -+	 * to merge_inmemory_*().  Not for external use.
     ++	 * to merge_incore_*().  Includes data needed to update the index (if
     ++	 * !clean) and to print "CONFLICT" messages.  Not for external use.
      +	 */
      +	void *priv;
     -+	unsigned ate;
      +};
      +
     -+/* rename-detecting three-way merge with recursive ancestor consolidation. */
     -+void merge_inmemory_recursive(struct merge_options *opt,
     -+			      struct commit_list *merge_bases,
     -+			      struct commit *side1,
     -+			      struct commit *side2,
     -+			      struct merge_result *result);
     ++/*
     ++ * rename-detecting three-way merge with recursive ancestor consolidation.
     ++ * working tree and index are untouched.
     ++ */
     ++void merge_incore_recursive(struct merge_options *opt,
     ++			    struct commit_list *merge_bases,
     ++			    struct commit *side1,
     ++			    struct commit *side2,
     ++			    struct merge_result *result);
      +
     -+/* rename-detecting three-way merge, no recursion. */
     -+void merge_inmemory_nonrecursive(struct merge_options *opt,
     -+				 struct tree *merge_base,
     -+				 struct tree *side1,
     -+				 struct tree *side2,
     -+				 struct merge_result *result);
     ++/*
     ++ * rename-detecting three-way merge, no recursion.
     ++ * working tree and index are untouched.
     ++ */
     ++void merge_incore_nonrecursive(struct merge_options *opt,
     ++			       struct tree *merge_base,
     ++			       struct tree *side1,
     ++			       struct tree *side2,
     ++			       struct merge_result *result);
      +
     -+/* Update the working tree and index from head to result after inmemory merge */
     ++/* Update the working tree and index from head to result after incore merge */
      +void merge_switch_to_result(struct merge_options *opt,
      +			    struct tree *head,
      +			    struct merge_result *result,
 2:  a9fff811a2 ! 2:  d7f6a834ab merge-ort-wrappers: new convience wrappers to mimic the old merge API
     @@ merge-ort-wrappers.c (new)
      +	}
      +
      +	memset(&result, 0, sizeof(result));
     -+	merge_inmemory_nonrecursive(opt, merge_base, head, merge, &result);
     ++	merge_incore_nonrecursive(opt, merge_base, head, merge, &result);
      +	merge_switch_to_result(opt, head, &result, 1, 1);
      +
      +	return result.clean;
     @@ merge-ort-wrappers.c (new)
      +		return -1;
      +
      +	memset(&tmp, 0, sizeof(tmp));
     -+	merge_inmemory_recursive(opt, merge_bases, side1, side2, &tmp);
     ++	merge_incore_recursive(opt, merge_bases, side1, side2, &tmp);
      +	merge_switch_to_result(opt, head, &tmp, 1, 1);
      +	*result = NULL;
      +
 3:  f38d140c15 ! 3:  27ad756600 fast-rebase: demonstrate merge-ort's API via temporary/hidden command
     @@ builtin/fast-rebase.c (new)
      +		merge_opt.branch2 = short_commit_name(commit);
      +		merge_opt.ancestor = xstrfmt("parent of %s", merge_opt.branch2);
      +
     -+		merge_inmemory_nonrecursive(&merge_opt,
     -+					    base_tree,
     -+					    result.tree,
     -+					    next_tree,
     -+					    &result);
     ++		merge_incore_nonrecursive(&merge_opt,
     ++					  base_tree,
     ++					  result.tree,
     ++					  next_tree,
     ++					  &result);
      +
      +		free((char*)merge_opt.ancestor);
      +		merge_opt.ancestor = NULL;
 4:  5f6c97b889 ! 4:  0479d59c33 merge,rebase,revert: select ort or recursive by config or environment
     @@ sequencer.c: static int do_recursive_merge(struct repository *r,
      -	strbuf_release(&o.obuf);
      +	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
      +		memset(&result, 0, sizeof(result));
     -+		merge_inmemory_nonrecursive(&o, base_tree, head_tree, next_tree,
     ++		merge_incore_nonrecursive(&o, base_tree, head_tree, next_tree,
      +					    &result);
      +		show_output = !is_rebase_i(opts) || !result.clean;
      +		/*
     @@ sequencer.c: static int do_merge(struct repository *r,
      -	ret = merge_recursive(&o, head_commit, merge_commit, reversed, &i);
      +	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
      +		/*
     -+		 * TODO: Should use merge_inmemory_recursive() and
     ++		 * TODO: Should use merge_incore_recursive() and
      +		 * merge_switch_to_result(), skipping the call to
      +		 * merge_switch_to_result() when we don't actually need to
      +		 * update the index and working copy immediately.

-- 
gitgitgadget
