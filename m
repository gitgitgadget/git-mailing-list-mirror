Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD2C3F6B0
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 21:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbiHXVGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiHXVGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 17:06:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42236E898
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:06:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y127so14716766pfy.5
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8R5yYgz0WEm76g7mfn1ML4kN67OHmUu7ZEhNrfkT1D4=;
        b=aSniFk0WAQ77EcJCsTKcnfRCDkQrBgcBPYCibJ0d2fvAthD5NvKBfT49j75dqdtRwl
         4Xm1SBz+rA8n4wPOlVNdmlEl6E4zQD3Dw54F9Ja/vH8g0ac3NwcDYhIa4k/KNXhc2pXl
         AzIrcTlvVZBMR/DxFQoLHp3wL7WNqk4gY/4hANa5vYizyQa4Qa2obR01UFGOI1mnWes3
         9h0NRwzEgZ2di40GZ9oiUNqDVT9Qq+UPi27XQXnHYW1WYg/DyPzvXSLMKmupvhpYcuWW
         drWw9rvEK04cKFCHaIW+ueiDUUc0Vca3obf7DDXIeYE1kHZiY6yvL6F5WFq+FtQ6Pdfe
         K/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8R5yYgz0WEm76g7mfn1ML4kN67OHmUu7ZEhNrfkT1D4=;
        b=xZWXj1x87N74bYoUmMFQhbD6R2VzRmlVhVPHo3s0HbiGhp9s+LC+VNa2l9LsxqCn2s
         TGAih9JlBY6R4P2UvE/2FjOJiTNOq6+s1OM4o8z2fcGKYTZam1tzCJO+X7thjquRKZKa
         PFnIh/3h/qVFAUQhsvbHDBek6e8rV2JOPIOw3jCZF44ttLVtYAZwdwdNVmzkoi3V3dM5
         Z7KgCskNoXOXMEQJ3vQUhSv3rUAilp8+JnikYo7XiWZnaxUk7rHSTZMJGpXG+R/y/6al
         n0WPy/yWgksB0GJ/C4dCMaHyMqH+m05ly/XQrbIn3v2Ydiql/uCibyzjGZvU4NZfjQIo
         BT6g==
X-Gm-Message-State: ACgBeo3UN2FLNyAR27AlkPpWM1anLm0WkoQLIvCGam9L8aK4LG+DygLd
        uNBQzzBPxqo4eHUrrRkzXPFawAVFD7M=
X-Google-Smtp-Source: AA6agR7VF0kUiqxfJOoKJBb4O3pxuU1sC7L2C/DN+3NRaKpY+9MyhOpNFP1lZun81RN3cONpsy/wMg==
X-Received: by 2002:a65:5688:0:b0:3c2:1015:988e with SMTP id v8-20020a655688000000b003c21015988emr606235pgs.280.1661375206169;
        Wed, 24 Aug 2022 14:06:46 -0700 (PDT)
Received: from ?IPV6:2600:380:7712:a9e4:18cf:29c3:6992:d9fc? ([2600:380:7712:a9e4:18cf:29c3:6992:d9fc])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b0016bf803341asm9746560plg.146.2022.08.24.14.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 14:06:45 -0700 (PDT)
Message-ID: <666dc1a3-5f18-c487-6290-44b0646f5724@gmail.com>
Date:   Thu, 25 Aug 2022 05:06:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 2/2] builtin/grep.c: integrate with sparse index
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220817075633.217934-3-shaoxuan.yuan02@gmail.com>
 <19dea639-389a-7258-e424-4912bde226df@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <19dea639-389a-7258-e424-4912bde226df@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2022 10:23 PM, Derrick Stolee wrote:
 > On 8/17/2022 3:56 AM, Shaoxuan Yuan wrote:
 >> Turn on sparse index and remove ensure_full_index().
 >>
 >> Change it to only expands the index when using --sparse.
 >>
 >> The p2000 tests demonstrate a ~99.4% execution time reduction for
 >> `git grep` using a sparse index.
 >>
 >> Test                                           HEAD~1 HEAD
 >> 
-----------------------------------------------------------------------------
 >> 2000.78: git grep --cached bogus (full-v3)     0.019 0.018  (-5.2%)
 >> 2000.79: git grep --cached bogus (full-v4)     0.017 0.016  (-5.8%)
 >> 2000.80: git grep --cached bogus (sparse-v3)   0.29 0.0015 (-99.4%)
 >> 2000.81: git grep --cached bogus (sparse-v4)   0.30 0.0018 (-99.4%)
 >
 > Good results.
 >
 > I think we could get interesting results even with the --sparse
 > option if you go another step further (perhaps as a patch after
 > this one).

OK.

 >>
 >> Optional reading about performance test results
 >> -----------------------------------------------
 >> Notice that because `git-grep` needs to parse blobs in the index, the
 >> index reading time is minuscule comparing to the object parsing time.
 >> And because of this, the p2000 test results cannot clearly reflect the
 >> speedup for index reading: combining with the object parsing time,
 >> the aggregated time difference is extremely close between HEAD~1 and
 >> HEAD.
 >>
 >> Hence, the results presenting here are not directly extracted from the
 >> p2000 test results. Instead, to make the performance difference more
 >> visible, the test command is manually ran with GIT_TRACE2_PERF in the
 >> four repos (full-v3, sparse-v3, full-v4, sparse-v4). The numbers here
 >> are then extracted from the time difference between "region_enter" and
 >> "region_leave" of label "do_read_index".
 >
 > This is a good point, but I don't recommend displaying them as if they
 > were the output of a "./run HEAD~1 HEAD -- p2000-sparse-operations.sh"
 > command. Instead, point out that the performance test does not show a
 > major improvement and instead you have these "Before" and "After" results
 > from testing manually and extracting trace2 regions.

OK.

 >> @@ -519,11 +519,15 @@ static int grep_cache(struct grep_opt *opt,
 >>          strbuf_addstr(&name, repo->submodule_prefix);
 >>      }
 >>
 >> +    prepare_repo_settings(repo);
 >> +    repo->settings.command_requires_full_index = 0;
 >> +
 >
 > The best pattern is to put this in cmd_grep() immediately after parsing
 > options. This guarantees that we don't parse and expand the index in any
 > other code path.

Got it.

 >>      if (repo_read_index(repo) < 0)
 >>          die(_("index file corrupt"));
 >>
 >> -    /* TODO: audit for interaction with sparse-index. */
 >> -    ensure_full_index(repo->index);
 >> +    if (grep_sparse)

A side note: this condition should be `grep_sparse && cached`.

 >> +        ensure_full_index(repo->index);
 >> +
 > As mentioned before, this approach is the simplest way to make the case
 > without --sparse faster, but the case _with_ --sparse will still be slow.
 > The way to fix this would be to modify this portion of the loop:

I'm not sure. If --sparse here means we want to expand the index, it
is expected to be slow (ensure_full_index is slow), isn't it?

 >     if (S_ISREG(ce->ce_mode) &&
 >         match_pathspec(repo->index, pathspec, name.buf, name.len, 0, 
NULL,
 >                S_ISDIR(ce->ce_mode) ||
 >                S_ISGITLINK(ce->ce_mode))) {
 >
 > by adding an initial case
 >
 >     if (S_ISSPARSEDIR(ce->ce_mode)) {
 >         hit |= grep_tree(opt, &ce->oid, name.buf, 0, name.buf);
 >     } else if (S_ISREG(ce->ce_mode) &&
 >            match_pathspec(repo->index, pathspec, name.buf, name.len, 
0, NULL,
 >                   S_ISDIR(ce->ce_mode) ||
 >                   S_ISGITLINK(ce->ce_mode))) {
 >
 > and appropriately implement "grep_tree()" to walk the tree at ce->oid to
 > find all matching files within, then call grep_oid() for each of those
 > paths.

Tree walking is faster, yes. So, for this approach to be faster, I
think you are suggesting we should not expand the index, even when
--sparse is given? Instead, we just rely on the tree walking logic,
right?

 > Bonus points if you recognize that the pathspec uses prefix checks that
 > allow pruning the search space and not parsing all of the trees
 > recursively. But that can definitely be delayed for a future enhancement.

OK.

 >> +test_expect_success 'grep expands index using --sparse' '
 >> +    init_repos &&
 >> +
 >> +    # With --sparse and --cached, do not ignore sparse entries and
 >> +    # expand the index.
 >> +    test_all_match git grep --sparse --cached a
 >> +'
 >
 > Here, you're testing that the behavior matches, but not testing that the
 > index expands. (It does describe why you didn't include it in the later
 > ensure_not_expanded tests.)

I was trying to "imply" the index expansion because of the behavior
match. Yes, I think the test should be more explicit.

 >> +
 >> +test_expect_success 'grep is not expanded' '
 >> +    init_repos &&
 >> +
 >> +    ensure_not_expanded grep a &&
 >> +    ensure_not_expanded grep a -- deep/* &&
 >> +    # grep does not match anything per se, so ! is used
 >
 > It can be helpful to say why:
 >
 >     # All files within the folder1/* pathspec are sparse,
 >     # so this command does not find any matches.

OK.

--
Thanks,
Shaoxuan


