Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCB2C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 22:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE04B6126A
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 22:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhJEWB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 18:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbhJEWB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 18:01:26 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8AEC061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 14:59:32 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id jo30so641538qvb.3
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p1uiy2q71/z/mBB1PscDsqRvI98YEMm8GrmwwqCDbP4=;
        b=PQdIeEu57n1ooJqKpdLFvdqqGxUow6tLlT5VhfYPikgFNzEm7kVJYsDNObvj/wbXic
         sj2lSNBdS7tF/t/pIjtU+pafY8FA2idYGZI+a8980BuguBxWMbZTnLyvopthg7bXM2jQ
         FhXyL70X2E6/AjgjaiODHSTZItb5eYexKQ2ZxRYOIg3ky0WDtGH72euz/dlvd9LqkQkG
         okOz6PWqAtQT/vU7zRKcFopA7aP2w3GrfkL3wuc9LI/JLnIT9jLUFDXJqe3ml3yi99UW
         Hc4FUUYituA25Mpn+UjHh2sZYUyx8yffHITychF7R28MLT6FrKGC2P0KlGvzHl7M1E6F
         amRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p1uiy2q71/z/mBB1PscDsqRvI98YEMm8GrmwwqCDbP4=;
        b=gMScLEn/zbOYJfRIeMCU9Y7+SIx5phDbXim5yeF2/RPinBpuKTOo0ov2m3eylY0BvQ
         1V850uUweTMRe2qWFJSiYy5JkP0EXs2i4Z3NpT02T+bPVPuHE4mYxJPdROzqG4tM6cEB
         dRJCXbJSw7JCG6pn1CRBlO2I0kWR2LOD7gjk904AQeL9xpmKihJr380QQq7Nd7MxDStI
         2LxT1oJeKn9PnvF2p4tZN/MZzcL82XVKhQgREkTzUg4g4ZB4DMoP51HPMzoaehxIak1C
         2bGjJX8toJLeF4W+v6TMLqJ0UxwgqtuBPy8+czlXTBXwbroB5q66Dzr1D8durTYoU2oc
         bqVQ==
X-Gm-Message-State: AOAM530sj+DoYMLlHOqWa/Es58ErvqBYdpiSDbgyxMmdmLBiJ12Se06H
        JshMctloQf/X0er0Bq3ZC9v9
X-Google-Smtp-Source: ABdhPJzbOxjG6MhsJV12kDSuFheqGZ3zJUD9h7p07OSIUGxLBpc8G1mD54uFijNd/PVJmZsuCGvlNg==
X-Received: by 2002:a0c:f249:: with SMTP id z9mr979873qvl.61.1633471171207;
        Tue, 05 Oct 2021 14:59:31 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id m5sm12482999qtk.88.2021.10.05.14.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 14:59:30 -0700 (PDT)
Message-ID: <9b99e856-24cc-03fd-7871-de92dc6e39b6@github.com>
Date:   Tue, 5 Oct 2021 17:59:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v2 1/7] reset: behave correctly with sparse-checkout
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Kevin Willford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <22c69bc60308fef13acd7c3aab4e11e175c89440.1633440057.git.gitgitgadget@gmail.com>
 <xmqqfstftgk6.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqfstftgk6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Wouldn't a fix to the situation be to 
> 
>  * Add the blob for "skip" taken from the initial commit to the
>    index, just like the entry for "no-skip" is updated;
> 
>  * But remember that "skip" was marked with "skip-worktree" bit
>    immediately before "git reset" was asked to do its thing, and
>    re-add the bit to the path in the index before "git reset" gives
>    the control back to the usre;
> 
>  * And keep the working tree untouched, without writing anything out
>    to "skip".  If the user had a (possibly unrelated) file there, it
>    will not be overwritten, and if the user left the path absent, it
>    will still be absent.
> 
> so that the last three diagnostic commands in the above sample
> sequence would instead read:
> 
>     $ ls *skip
>     no-skip
>     $ git ls-files -t
>     M no-skip
>     S skip
>     $ git status -suno
>      M no-skip
> 
> i.e. skip gets updated in the index only, nothing changes in the
> working tree for "skip" or "no-skip", and status reports that
> "no-skip" is different from the index but "skip" hasn't changed in
> the working tree since the index (thanks to its skip-worktree bit).
> 
> Then the user will be happy in the same way as the user was happy
> immediately after the state marked with "There is no 'reset' done
> yet so far." above, on both counts, not just for "status does not
> report something got changed" part but also "user didn't want to see
> 'skip' in the working tree, and 'skip' did not materialize" part.
> 
> Thanks.
> 

Thanks for the thorough explanation, I'm on-board with your approach (and
will re-roll the series with that implemented). A lot of my thought process
(and confusion) came from a comment in e5ca291076 (t1092: document bad
sparse-checkout behavior, 2021-07-14) suggesting that full and sparse
checkouts should have the same result in scenarios like the one you
outlined above. The problem is, as noted earlier, it's impossible to tell
whether (using your example):

1. the user deleted `skip` because they intentionally want to remove it from
   the worktree, and it should continue to be deleted after a reset.
2. `skip` doesn't exist in the worktree because it's excluded from the
   sparse checkout definition and the user does not want its current state
   "deleted" after a reset.

As a result, there's no way `git reset --mixed` could be expected to behave
the same way in full checkouts as it does in sparse, and the most consistent
solution is that the worktree should remain untouched with `skip-worktree`
preserved.
