Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D3DC433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 21:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiF2Vxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 17:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiF2Vxk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 17:53:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD5120F6F
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 14:53:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a15so16278737pfv.13
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=3ye/KPfhLV7QbeLIj3efXh5SgrZFxzFzndgBRxT+Krg=;
        b=fPy7Tqwyv4CqyJ7hyT76zendDWBwJks609ol/yndBkCpLz5xMi/LkA562twtTb3Zzm
         JcRX7grCp9xgi6jeyhxpQsjrF+70Fc36RWgrjwSOrt+IQvsReCkWEw0zK/nw/NATiO4Q
         BJPlFEqVr4HpUpuvCqUrVGmw1VXK9JPBMEzu9Hf73pM5qfk1KThs5CVVl4mwI7v0IDJC
         4OguSSaMsxb8GrbXt1f7n263aphEJOUVqdUrVaJGfHKxW6egpm9euguY7c67LJEeJwCR
         E2mQLFhH/r/dBLpZPqKrLrwCxlMvTjtZmVSrowPyBgO7HFbkOMvVEBHqJZ3O5aadAMo5
         RvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3ye/KPfhLV7QbeLIj3efXh5SgrZFxzFzndgBRxT+Krg=;
        b=27mN6MdahFKMrlg8sfmz1IvS2S6alM898ZHw5zGH5O4uiJY5594vXUl9wukQ7Z4R4k
         9Nya8zIjionCFS9kig/5Kbl3uGIc50wjYTo8jrUPaGFC3cBFPTyro3FfkzY1h/cK7dhT
         wSUyqIAvQgnfrCUGQq6VrO2JjclTBtdmtXAl9sWl8QhC23lZdvqQBhpifuPaIWDXK3/K
         g0JEQ6YZfweb1ahCJS/tK4Tc0fiaq8BOPwYcoKYQzdXcYw39q1pebO2ypMhDqWI0y1VR
         K2VxyHvB5CH8EZ1RaUNBCv337DHGXwfyAet6Z2GM3bbEf3o9ydcUqhv+3QDfhk4esjG1
         EYzg==
X-Gm-Message-State: AJIora+EmKgtFT91ONfT613kIXUFlZQfLpqPk6wHxYDhEQ9/2dNbu00X
        y7O5tpxrw9M88GXr+Fo0U5gP
X-Google-Smtp-Source: AGRyM1t+Wl742PaR74U0a133k388wPqQTcKad9gyucfqHe7KfoPCNy8ckUI4XD+8pp0LrPxYuXq1TQ==
X-Received: by 2002:a05:6a00:808:b0:525:3c3f:7393 with SMTP id m8-20020a056a00080800b005253c3f7393mr12286960pfk.57.1656539618768;
        Wed, 29 Jun 2022 14:53:38 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b0016a61e965f0sm4290200plh.280.2022.06.29.14.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 14:53:38 -0700 (PDT)
Message-ID: <96034b3f-9811-38c1-7afe-c1c9dd243f0e@github.com>
Date:   Wed, 29 Jun 2022 14:53:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: git bug report: 'git add' hangs in a large repo which has
 sparse-checkout file with large number of patterns in it
Content-Language: en-US
To:     Dian Xu <dianxudev@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
References: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dian Xu wrote:
> Dear Git developers,
> 
> Reporting Issue:
>               'git add' hangs in a large repo which has
> sparse-checkout file with large number of patterns in it
> 
> Found in:
>               Git 2.34.3. Issue occurs after 'audit for interaction
> with sparse-index' was introduced in add.c
> 
> Reproduction steps:
>               1. Clone a repo which has e.g. 2 million plus files
>               2. Enable sparse checkout by: git config core.sparsecheckout true
>               3. Create a .git/info/sparse-checkout file with a large
> number of patterns, e.g. 16k plus lines
>               4. Run 'git add', which will hang> 
> Investigations:
>               1. Stack trace:
>                        add.c: cmd_add
>                   -> add.c: prune_directory
>                   -> pathspec.c: add_pathspec_matches_against_index
>                   -> dir.c: path_in_sparse_checkout_1
>               2. In Git 2.33.3, the loop at pathspec.c line 42 runs
> fast, even when istate->cache_nr is at 2 million
>               3. Since Git 2.34.3, the newly introduced 'audit for
> interaction with sparse-index' (dir.c line 1459:
> path_in_sparse_checkout_1) decides to loop through 2 million files and
> match each one of them against the sparse-checkout patterns
>               4. This hits the O(n^2) problem thus causes 'git add' to
> hang (or ~1.5 hours to finish)

Thanks for the explanation, it helped me narrow down the source to an exact
commit (49fdd51a23 (add: skip tracked paths outside sparse-checkout cone,
2021-09-24)). 

You're correct that the `path_in_sparse_checkout()` check is slow [1].
However, it only runs on files that are not "hidden" with the
`SKIP_WORKTREE` flag. Ideally, if you're using sparse-checkout, this will
only be a small subset of your 2 million files. 

In your repro steps, you're adding patterns to a file then immediately
running `git add`. If that reflects how you're usually working with
sparse-checkout, `SKIP_WORKTREE` likely isn't being applied properly before
the `add`. You can check to see whether file(s) have the flag properly
applied with `git ls-files -t <file or dir names>` - each `SKIP_WORKTREE`
file should have an "S" next to it. "H" indicates that the flag is *not*
applied.

If you see that most of the files that *should* be sparse don't have
`SKIP_WORKTREE` applied, you can run `git sparse-checkout reapply` (make
sure you don't have any modified files outside the patterns you're
applying!). The downside is that it'll be as slow as what you're reporting
for `git add`, but any subsequent `add` (or reset, status, etc.) should be
much faster.

If you do all of that but things are still slow, then the way we check
pathspecs in `git add` would need to change (not trivial, but probably not
impossible either). At a cursory glance, I can think of a few options for
that:

1. Remove the `path_in_sparse_checkout()` check. It's the simplest solution,
   but it means you'd be able to stage files for commit outside the
   sparse-checkout patterns without using the '--sparse' option. I don't
   personally think that's a huge issue, but given that the implementation
   was intentionally changed *away* from this approach, I'd defer to other
   contributors to see if that's an okay change to make.
2. After every call to `ce_path_match()`, check if all pathspecs are marked
   as `seen` and, if so, return early. This would slow down each individual
   file check and wouldn't help you if a pathspec matches nothing, but
   prevents checking more files once all pathspecs are matched.
3. Do some heuristic checks on the pathspecs before checking index entries.
   For example, exact file or directory matches could be searched in the
   index. This would still require falling back on the per-file checks if
   not all pathspecs are matched, but makes some typical use-cases much
   faster.

There are almost certainly other options, and I can dig around `add.c` more
to see if there's anything I'm missing (although I'd love to hear other
ideas too!). 

Hopefully this helps!
- Victoria

[1] `path_in_sparse_checkout()` is significantly faster in cone mode, but
with 16k patterns I'm assuming you're not using cone patterns ;)

> 
> Please help us take a look at this issue and let us know if you need
> more information.
> 
> Thanks,
> 
> Dian Xu
> Mathworks, Inc
> 1 Lakeside Campus Drive, Natick, MA 01760
> 508-647-3583

