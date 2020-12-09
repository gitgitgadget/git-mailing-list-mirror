Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2FCC19437
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 02:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DAB23B23
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 02:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgLICqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 21:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgLICqr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 21:46:47 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D40C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 18:46:01 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id b62so822106otc.5
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 18:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yE0SAaYyf2YaoPK5KbyzJvAq5Yo1xtQwwug8443Ef5U=;
        b=n6BVpjWID0r+odjfZPb7hDtAjB+Ea7xFp09NpV5vGTrarplteprm/FP+M3Qj1atNy4
         pGqsKutcJi+Dx5gro3VDVyLWtq5IzzTYgX9LoG5/+lzzzeTMrCC8AXfKuaEcfPFB7aIh
         hphJwFeVk1ZcoJxUP+VPsy7OsDwHNKBPlCdinzy4z0735j/gTkrVv6iu5QF7xPcF5suJ
         N86ls21pAnpGYfYPc4jSXiFA6dP8REdVihI5eedFNj5uXHehPrnGAs8ovtMdx6D32v5s
         SgHYLvn4hdCJGgmV7IJvC0GFcOSYlUcGEaMB23/qESjl53puho4FS4k1blFEkKLSrgSJ
         Y2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yE0SAaYyf2YaoPK5KbyzJvAq5Yo1xtQwwug8443Ef5U=;
        b=JJjJkm+I/xscx27z/n8vpZWf7eKzz4XQzsffG0k2OfMkqq9b5H6Ouogjeay9rnDJla
         vRTXLYwrobiHUqQLWaOihNxQ6K+DyZEQFGVp57ImvTbn5gPAOM2d0UorpZHR/XLJBVUx
         ZWjQYTuZtdwsHpvTy6zg0QzhrJhETcNi8PJJxWtZLI8zdmpye1QKhyHrG1+EUtUefLqr
         ijsVY7xwktHc/i17E2/fWmE+B/662TTHaEWwNoZcIfnPoEfLyQCphLJ57NQP84SaJr/V
         4K50wUEifJjUIv+yd5m3T6K0dFPO8xtjS5DlM3nCQM+P3ICpQtm3c6jM614nk9zaa9zx
         /Fag==
X-Gm-Message-State: AOAM531TRUiCFSNo3C1Z5ySNlA0nqJ7rQei3H32CVQg50Azy/luv5u6W
        SPdglaehB3JoI36c4heLrcGuBuXJBSAXt+kNXZE=
X-Google-Smtp-Source: ABdhPJwPh++l/odlTrZgXFVKSqz6Uv1IoOkOv1jbA2DR0R3BgsJ3NK5DURj93Doyt66QVp8TEqc3+BHVY3VVr41Lxn0=
X-Received: by 2002:a05:6830:10:: with SMTP id c16mr100880otp.162.1607481960627;
 Tue, 08 Dec 2020 18:46:00 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Dec 2020 18:45:49 -0800
Message-ID: <CABPp-BGcyRURykePOafjcE1z9J8U5awF=PZw1ufx+8Ow+k3j3w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2020, #01; Tue, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Dec 8, 2020 at 5:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/diffcore-rename (2020-12-07) 5 commits
>  - diffcore-rename: simplify and accelerate register_rename_src()
>  - diffcore-rename: reduce jumpiness in progress counters
>  - diffcore-rename: rename num_create to num_targets
>  - diffcore-rename: remove unnecessary if-clause
>  - diffcore-rename: avoid usage of global in too_many_rename_candidates()

Curious.  I submitted 7 patches for this series.  While one wasn't all
that important (tweaking wording in comments), the final patch was.
Looking at it again, I notice I somehow messed up the commit summary
(missing the "area:" prefix).  Is that why the final commit was
dropped or does something else need to be fixed up too?  And if I
resubmit, do you want the other patch you dropped left out?

> * en/merge-ort-2 (2020-12-08) 7 commits
>  - merge-ort: add modify/delete handling and delayed output processing
>  - merge-ort: add die-not-implemented stub handle_content_merge() functio=
n
>  - merge-ort: add function grouping comments
>  - merge-ort: add a paths_to_free field to merge_options_internal
>  - merge-ort: add a path_conflict field to merge_options_internal
>  - merge-ort: add a clear_internal_opts helper
>  - merge-ort: add a few includes
>  (this branch uses en/merge-ort-impl.)
>
>  More "ORT" merge strategy.
>
>  Needs review.

Reviewed by Stolee:
https://lore.kernel.org/git/2ea0aab8-934f-3eaa-e3d0-9ae35a278748@gmail.com/

(More review is good, of course, I was just surprised by the label.)

> [Stalled]
>
> * mt/grep-sparse-checkout (2020-12-06) 10 commits
>  - t7817: do not depend on any specific default branch name
>  - config: add setting to ignore sparsity patterns in some cmds
>  - grep: honor sparse checkout patterns
>  - config: correctly read worktree configs in submodules
>  - config: make do_git_config_sequence receive a 'struct repository'
>  - t/helper/test-config: unify exit labels
>  - t/helper/test-config: diagnose missing arguments
>  - t/helper/test-config: be consistent with exit codes
>  - t1308-config-set: avoid false positives when using test-config
>  - doc: grep: unify info on configuration variables
>  (this branch is used by mt/rm-sparse-checkout.)
>
>  "git grep" has been tweaked to be limited to the sparse checkout
>  paths.
>
>
> * mt/rm-sparse-checkout (2020-12-08) 1 commit
>  - rm: honor sparse checkout patterns
>  (this branch uses mt/grep-sparse-checkout.)
>
>  "git rm" follows suit to "git grep" to ignore paths outside the
>  sparsity pattern when the sparse checkout feature is in use.
>
>  Need to wait for how these fit in larger picture.
>  cf. <CABPp-BGMX3wb7LiS1HkJpGveoW3J1oR0vVHbKTF5+qYLRF+59g@mail.gmail.com>

Sorry for taking a while on these.  :-(  I'll try to get back to it soon...

> * so/log-diff-merge (2020-11-09) 27 commits
>  - doc/git-show: include --diff-merges description
>  - doc/rev-list-options: document --first-parent implies --diff-merges=3D=
first-parent
>  - doc/diff-generate-patch: mention new --diff-merges option
>  - doc/git-log: describe new --diff-merges options
>  - t4013: add test for --diff-merges=3Dfirst-parent
>  - diff-merges: implement new values for --diff-merges
>  - diff-merges: make -m/-c/--cc explicitly mutually exclusive
>  - diff-merges: refactor opt settings into separate functions
>  - diff-merges: get rid of now empty diff_merges_init_revs()
>  - diff-merges: group diff-merge flags next to each other inside 'rev_inf=
o'
>  - diff-merges: split 'ignore_merges' field
>  - diff-merges: fix -m to properly override -c/--cc
>  - t4013: add tests for -m failing to override -c/--cc
>  - t4013: support test_expect_failure through ':failure' magic
>  - diff-merges: revise revs->diff flag handling
>  - diff-merges: introduce revs->first_parent_merges flag
>  - diff-merges: new function diff_merges_set_dense_combined_if_unset()
>  - diff-merges: new function diff_merges_suppress()
>  - diff-merges: re-arrange functions to match the order they are called i=
n
>  - diff-merges: rename diff_merges_default_to_enable() to match semantics
>  - diff-merges: move checks for first_parent_only out of the module
>  - diff-merges: rename all functions to have common prefix
>  - revision: move diff merges functions to its own diff-merges.c
>  - revision: provide implementation for diff merges tweaks
>  - revision: factor out initialization of diff-merge related settings
>  - revision: factor out setup of diff-merge related settings
>  - revision: factor out parsing of diff-merge related options
>
>  "git log" learned a new "--diff-merges=3D<how>" option.
>
>  Needs review.

I think you can update this to "Awaiting reroll", as per
https://lore.kernel.org/git/87wnxyfz07.fsf@osv.gnss.ru/ .

> * en/merge-ort-impl (2020-12-06) 21 commits
>  - merge-ort: free data structures in merge_finalize()
>  - merge-ort: add implementation of record_conflicted_index_entries()
>  - tree: enable cmp_cache_name_compare() to be used elsewhere
>  - merge-ort: add implementation of checkout()
>  - merge-ort: basic outline for merge_switch_to_result()
>  - merge-ort: step 3 of tree writing -- handling subdirectories as we go
>  - merge-ort: step 2 of tree writing -- function to create tree object
>  - merge-ort: step 1 of tree writing -- record basenames, modes, and oids
>  - merge-ort: have process_entries operate in a defined order
>  - merge-ort: add a preliminary simple process_entries() implementation
>  - merge-ort: avoid recursing into identical trees
>  - merge-ort: record stage and auxiliary info for every path
>  - merge-ort: compute a few more useful fields for collect_merge_info
>  - merge-ort: avoid repeating fill_tree_descriptor() on the same tree
>  - merge-ort: implement a very basic collect_merge_info()
>  - merge-ort: add an err() function similar to one from merge-recursive
>  - merge-ort: use histogram diff
>  - merge-ort: port merge_start() from merge-recursive
>  - merge-ort: add some high-level algorithm structure
>  - merge-ort: setup basic internal data structures
>  - Merge branch 'en/strmap' into en/merge-ort-impl
>  (this branch is used by en/merge-ort-2.)
>
>  Needs review.

Round 2 got pretty deep reviews by both Stolee and Jonthan Tan, at
least the first 15 patches (which I think were the most crucial to
review).  Both led to some significant restructures of certain
portions.

Round 3 also got some reviews from =C3=86var.

I think I've addressed all the feedback in v4 (which is sadly labelled
as v2 due to switching from send-email to gitgitgadget part way
through the series).  If there's more review needed, I'd say getting a
thumbs-up or thumbs-down from Stolee and Jonathan on whether I
addressed their feedback adequately would be great, and having someone
give a look over the 2nd-to-last and 4th-to-last patches would always
be a plus.  Was that what you had in mind in marking this as "Needs
review"?
