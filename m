Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22125C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbhKVQ5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbhKVQ5O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:57:14 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA85C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:54:07 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id m192so14394032qke.2
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4ABHGt0v5GcHkHg8ledKOth20KH+r55GhzLpfD8X5w0=;
        b=IZmipmQFSjcdDTpASNMpHyDE08LvNG+Jzc5kambLJ2gjEPKMzVolpet/oipP/F6PC6
         32C8CTuKKRHEOlpTGCCUKmBlRNISc7nGYKUn0la+wxpKaNYNgdDXrzpoIvxdsFV3H2lX
         jcqXeHF6i3vEgzRwH0IAUTKsBTGp4V7DeguZc9bDFkN/96MA/y4TWgX7Vr3Etv30A9N3
         Wl+0bS7Lf0IByF5VCC/B62zWhkcxB2EDtk8MtIbzCJOc3d6ma5JEKroqPRPQDIoqO/f3
         j1EC2RDmC175WL3RFyANjx1MGEnSZt5RWko8THBZeBf9lhllDPeKx4tycTmab0ru4I1G
         PWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4ABHGt0v5GcHkHg8ledKOth20KH+r55GhzLpfD8X5w0=;
        b=d5K/En42NpjhLvvcXexagP2Nfbh8GDvczPZsXygBuZBYg491k8zR87yCnurM5yW1JI
         6Q6Si2S82o7y1FRqLSRUdbW9CWNJi7oR4DU4kD9Fiw9Ggj37WA7APVE8W3L5HMz5+hOH
         mvPYPW4fmOk7c6Ti4XkJMWHepE/38H5vh53htbXeEKG7PBBW1tfc8TiGxbNap1XbZsLO
         1dhiCTt6hjboxlfOciIG+OCj59f78e3qPwCQuM4/7nyylPVdZdIpPEaZL5TA5NSBdDep
         DCaIYFyc+l7hMTvG96Ml6Gl1wF+GmdS3oXQ900HBTq/yfntsxBWTME2urp6rOF1f9+a4
         sJuw==
X-Gm-Message-State: AOAM533TC0cVw/Or74L7Cta6zNRfAY98RnsYlB9N3lK3/0uW72msl/HC
        8LCbLgq/dITVtKH4VPONATIH
X-Google-Smtp-Source: ABdhPJz7J76HdYv59nlgUJIjDxZEUrUQBMZ+H18BPXuCaxB6aAEIsvZ3Kyfgw0dSpCAm8qq+gkPVdA==
X-Received: by 2002:a05:620a:372a:: with SMTP id de42mr48742765qkb.14.1637600046691;
        Mon, 22 Nov 2021 08:54:06 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id i7sm5050619qkn.0.2021.11.22.08.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 08:54:06 -0800 (PST)
Message-ID: <b3f33d40-d418-f285-4a32-1db7a2c4c465@github.com>
Date:   Mon, 22 Nov 2021 11:54:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v5 7/8] reset: make --mixed sparse-aware
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
 <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
 <a9135a5ed64f031fa2b46baabf179611dde60e71.1635345563.git.gitgitgadget@gmail.com>
 <CABPp-BH9qXZObVkEyuLOzoOvw_uPfC_n9QSR=by2+-GVgAGgSw@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BH9qXZObVkEyuLOzoOvw_uPfC_n9QSR=by2+-GVgAGgSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> Sorry, one more thing...
> 
> On Wed, Oct 27, 2021 at 7:39 AM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Victoria Dye <vdye@github.com>
>>
>> Remove the `ensure_full_index` guard on `read_from_tree` and update `git
>> reset --mixed` to ensure it can use sparse directory index entries wherever
>> possible. Sparse directory entries are reset use `diff_tree_oid`, which
>> requires `change` and `add_remove` functions to process the internal
>> contents of the sparse directory. The `recursive` diff option handles cases
>> in which `reset --mixed` must diff/merge files that are nested multiple
>> levels deep in a sparse directory.
>>
>> The use of pathspecs with `git reset --mixed` introduces scenarios in which
>> internal contents of sparse directories may be matched by the pathspec. In
>> order to reset *all* files in the repo that may match the pathspec, the
>> following conditions on the pathspec require index expansion before
>> performing the reset:
>>
>> * "magic" pathspecs
>> * wildcard pathspecs that do not match only in-cone files or entire sparse
>>   directories
>> * literal pathspecs matching something outside the sparse checkout
>>   definition
>>
>> Helped-by: Elijah Newren <newren@gmail.com>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  builtin/reset.c                          | 78 +++++++++++++++++++++++-
>>  t/t1092-sparse-checkout-compatibility.sh | 17 ++++++
>>  2 files changed, 93 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index 0ac0de7dc97..60517e7e1d6 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -148,7 +148,9 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>>                  * If the file 1) corresponds to an existing index entry with
>>                  * skip-worktree set, or 2) does not exist in the index but is
>>                  * outside the sparse checkout definition, add a skip-worktree bit
>> -                * to the new index entry.
>> +                * to the new index entry. Note that a sparse index will be expanded
>> +                * if this entry is outside the sparse cone - this is necessary
>> +                * to properly construct the reset sparse directory.
>>                  */
>>                 pos = cache_name_pos(one->path, strlen(one->path));
>>                 if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
>> @@ -166,6 +168,73 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>>         }
>>  }
>>
>> +static int pathspec_needs_expanded_index(const struct pathspec *pathspec)
>> +{
>> +       unsigned int i, pos;
>> +       int res = 0;
>> +       char *skip_worktree_seen = NULL;
>> +
>> +       /*
>> +        * When using a magic pathspec, assume for the sake of simplicity that
>> +        * the index needs to be expanded to match all matchable files.
>> +        */
>> +       if (pathspec->magic)
>> +               return 1;
>> +
>> +       for (i = 0; i < pathspec->nr; i++) {
>> +               struct pathspec_item item = pathspec->items[i];
>> +
>> +               /*
>> +                * If the pathspec item has a wildcard, the index should be expanded
>> +                * if the pathspec has the possibility of matching a subset of entries inside
>> +                * of a sparse directory (but not the entire directory).
>> +                *
>> +                * If the pathspec item is a literal path, the index only needs to be expanded
>> +                * if a) the pathspec isn't in the sparse checkout cone (to make sure we don't
>> +                * expand for in-cone files) and b) it doesn't match any sparse directories
>> +                * (since we can reset whole sparse directories without expanding them).
>> +                */
>> +               if (item.nowildcard_len < item.len) {
>> +                       for (pos = 0; pos < active_nr; pos++) {
>> +                               struct cache_entry *ce = active_cache[pos];
>> +
>> +                               if (!S_ISSPARSEDIR(ce->ce_mode))
>> +                                       continue;
>> +
>> +                               /*
>> +                                * If the pre-wildcard length is longer than the sparse
>> +                                * directory name and the sparse directory is the first
>> +                                * component of the pathspec, need to expand the index.
>> +                                */
>> +                               if (item.nowildcard_len > ce_namelen(ce) &&
>> +                                   !strncmp(item.original, ce->name, ce_namelen(ce))) {
>> +                                       res = 1;
>> +                                       break;
>> +                               }
>> +
>> +                               /*
>> +                                * If the pre-wildcard length is shorter than the sparse
>> +                                * directory and the pathspec does not match the whole
>> +                                * directory, need to expand the index.
>> +                                */
>> +                               if (!strncmp(item.original, ce->name, item.nowildcard_len) &&
>> +                                   wildmatch(item.original, ce->name, 0)) {
>> +                                       res = 1;
>> +                                       break;
>> +                               }
>> +                       }
>> +               } else if (!path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
>> +                          !matches_skip_worktree(pathspec, i, &skip_worktree_seen))
>> +                       res = 1;
>> +
>> +               if (res > 0)
>> +                       break;
>> +       }
>> +
>> +       free(skip_worktree_seen);
>> +       return res;
>> +}
>> +
>>  static int read_from_tree(const struct pathspec *pathspec,
>>                           struct object_id *tree_oid,
>>                           int intent_to_add)
>> @@ -178,9 +247,14 @@ static int read_from_tree(const struct pathspec *pathspec,
>>         opt.format_callback = update_index_from_diff;
>>         opt.format_callback_data = &intent_to_add;
>>         opt.flags.override_submodule_config = 1;
>> +       opt.flags.recursive = 1;
>>         opt.repo = the_repository;
>> +       opt.change = diff_change;
>> +       opt.add_remove = diff_addremove;
>> +
>> +       if (pathspec->nr && the_index.sparse_index && pathspec_needs_expanded_index(pathspec))
>> +               ensure_full_index(&the_index);
>>
>> -       ensure_full_index(&the_index);
>>         if (do_diff_cache(tree_oid, &opt))
>>                 return 1;
>>         diffcore_std(&opt);
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 5664ff8f039..44d5e11c762 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -781,11 +781,28 @@ test_expect_success 'sparse-index is not expanded' '
>>                 ensure_not_expanded reset --hard $ref || return 1
>>         done &&
>>
>> +       ensure_not_expanded reset --mixed base &&
>>         ensure_not_expanded reset --hard update-deep &&
>>         ensure_not_expanded reset --keep base &&
>>         ensure_not_expanded reset --merge update-deep &&
>>         ensure_not_expanded reset --hard &&
>>
>> +       ensure_not_expanded reset base -- deep/a &&
>> +       ensure_not_expanded reset base -- nonexistent-file &&
>> +       ensure_not_expanded reset deepest -- deep &&
>> +
>> +       # Although folder1 is outside the sparse definition, it exists as a
>> +       # directory entry in the index, so the pathspec will not force the
>> +       # index to be expanded.
>> +       ensure_not_expanded reset deepest -- folder1 &&
>> +       ensure_not_expanded reset deepest -- folder1/ &&
>> +
>> +       # Wildcard identifies only in-cone files, no index expansion
>> +       ensure_not_expanded reset deepest -- deep/\* &&
>> +
>> +       # Wildcard identifies only full sparse directories, no index expansion
>> +       ensure_not_expanded reset deepest -- folder\* &&
>> +
> 
> You've added two testcases where a wildcard results in no index
> expansion; should there also be a test where a wildcard results in
> index expansion for completeness?
> 

The tests haven't verified when the index *is* expanded for any of the
commands implemented so far (save for the one ensuring that, when the index
is expanded, the expansion is logged via trace2). I see the value in it
(e.g. using the tests to demonstrate what can trigger index expansion).
Conversely, if the tests are intended to confirm "successful" sparse index
support (where index expansion is equivalent to "the sparse index is not
supported"), then verifying index expansion doesn't necessarily fit that
purpose. 

I'm not sure which interpretation is "correct", but if it does make sense to
test expansion cases I'm happy to add them here (or, if not in this series,
add a TODO to include them in the future).

For what it's worth, the test 'reset with wildcard pathspec' in [4/8] is
intended to cover a broader set of wildcard scenarios (verifying
correctness, rather than index expansion). Given the other updates I intend
to make to wildcard handling, I'm planning on adding cases to that test in 
my next re-roll.
