Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E14C433EF
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 04:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbiAIEmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 23:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiAIEmK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 23:42:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BA0C06173F
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 20:42:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id q25so30850552edb.2
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 20:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKMR+g1a9ZA4Rb9Iy4N23fwKHHVr30W1SeMbITNI13A=;
        b=mrBrBMHU4WRcImtppeRd8DGLqciY/TzW2D2hJkIhI7CRnbKlkeXarsdXlBa4Jb+Zer
         hxVawA21nAebLoKNuZqyHDfd6bvpJE0dhIrOnTmeQ8c+eai7pLxVzq+6vKNUJCIBTrOM
         QjYuAMtOEJQ3di2PndaapDKj8G9w+iMcrPC2tcEBsghQhZl9rtC249faxWs+vxDBY6JW
         J1uILvR4J2EqP8Cjv13LCPCTJGVynyIEAN/pnnc8YHc4MK2Umv0wyGteRtor4R8kwbrT
         MkZU8n8j79XFSToDRHkVJeJCY0yrkcDy8HLMuRrPjDjZzSkkSPlsXTl3KecxjSrT+kn9
         ahqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKMR+g1a9ZA4Rb9Iy4N23fwKHHVr30W1SeMbITNI13A=;
        b=zPaWEr7e07xqJeMVf3c+lRTOzXN6DpKmdENoZvl7HuDcfyX02NB36SKBPGHY+ovrYl
         kFMqiDYyl9/yrCAiPVVw7WW9aczJxjmUto5FpZpG7D6xd95/KiKMfZhCRl31AqKG+tCG
         LysurOlbWYeC+HnSc6Lik2IxrqlnHkNepZYwaCC1oSNOqgV6m+0vjNj6YPSO/4Hi8jyh
         wVwXrv/VL/49PsnHXFn63DMDYyoJCgoSgSs5XrhnFCqCfBj4lQevZF4qVejf2iCfO89r
         eOBGoZpkVbKPTfW8yyDhMgUxjWsnAFQSsD1AVnvuUiq976pluPRwtDspuRqnaiq+reCd
         rtlA==
X-Gm-Message-State: AOAM530/2iRPnObU4tbMwxRe42Wg4YyvNhaxLF/RaPdkE4fKNDZd8Evc
        +7wINtW3ecfGtM1sUjjJY685hzRZNWRKjusPL91bBa7ELww=
X-Google-Smtp-Source: ABdhPJzRJ79na7k4stbDky7c5aDusEixA94u2k03SRyBVcfYKzXTSl3JDtnc4y+0NDhLDCjbmKulzGbYDDVkIcxS2+4=
X-Received: by 2002:aa7:c883:: with SMTP id p3mr10356139eds.94.1641703328910;
 Sat, 08 Jan 2022 20:42:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 8 Jan 2022 20:41:57 -0800
Message-ID: <CABPp-BEiUKFW3XCZUgTMG2K65NpCeDruPkvzgsd_=ch+t3t=-g@mail.gmail.com>
Subject: Re: [PATCH 0/9] Sparse index: integrate with 'clean',
 'checkout-index', 'update-index'
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series continues the work to integrate commands with the sparse index,
> adding integrations with 'git clean', 'git checkout-index', and 'git
> update-index'. These three commands, while useful in their own right, are
> updated mainly because they're used in 'git stash'. A future series will
> integrate sparse index with 'stash' directly, but its subcommands must be
> integrated to avoid the performance cost of each one expanding and
> collapsing the index.

Thanks for working on these; it's very nice to see others continuing
to work on sparse-checkout issues, since it still feels somewhat
incomplete to me.  This work is perhaps less glamorous since you're
starting to work on commands less frequently used by users, but I
still feel it's very important.  Thanks for your diligence.

> The series is broken up into 4 parts:
>
>  * Patches 1-2 are minor fixups to the 'git reset' sparse index integration
>    in response to discussion [1] that came after the series was ready for
>    merge to 'next'.

These look good.

>  * Patch 3 integrates 'git clean' with the sparse index.

Yeah, since clean tends to work with untracked files instead of
tracked, and SKIP_WORKTREE is all about tracked files, I'd expect the
conversion would be simple.  Nice to see verification that it was.

>  * Patches 4-6 integrate 'git checkout-index' with the sparse index and
>    introduce a new '--ignore-skip-worktree-bits' option for use with 'git
>    checkout-index --all'.
>    * This involves changing the behavior of '--all' to respect
>      'skip-worktree' by default (i.e., it won't check out 'skip-worktree'
>      files). The '--ignore-skip-worktree-bits' option can be specified to
>      force checkout of 'skip-worktree' files, if desired.

I think the basic idea makes sense, and the patches are certainly
moving in the right direction.

If others agree with the series I'm about to submit, then patch 4
looks fine as-is and there's just a minor item about
--ignore-skip-worktree-bits without --all for checkout-index in Patch
5 (either further behavior changes, or a more detailed commit
message).  If others disagree with that other series, then I think
both patches 4 & 5 should do more work to avoid problems with
present-despite-SKIP_WORKTREE files.

However, the issues raised in Patch 7 suggest that Patch 5 might need
some reworking (independent of the other series I'm about to submit).

Patch 6 looks good either way.

>  * Patches 7-9 integrate 'git update-index' with the sparse index.
>    * Note that, although this integrates the sparse index with
>      '--cacheinfo', sparse directories still cannot be updated using that
>      option (see the prior discussion [2] for more details on why)

Patch 9 might benefit from a small commit message rewording.

I either misunderstood Patch 8, or it has a disconnect of some kind
between the commit message and the testcase.

I've left various comments on patch 7; it'll probably need updates and
likely points to further changes needed in patch 5.


Anyway, I tend to concentrate on perceived issues when reviewing
rather than on what looks good, but despite the fact that I think
there are some further improvements needed, overall I think this looks
like some nice work.  Keep it up!
