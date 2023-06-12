Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70762C7EE43
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 20:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjFLUX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjFLUX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 16:23:58 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB64F18E
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 13:23:57 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-543a25df980so2132247a12.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686601437; x=1689193437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlZZ0FPowMQe1pfgP0qmvZzhOsDqM40wmHL2pv/++cc=;
        b=mD8WhRLRcVMikXD+H/TmP1ewe92Hb8qkl23fJrkc72sYi8GXgdolei0WCk+z1G1uQQ
         GPBOmVjxTG1fP2ew5Ajz3oHKCNg2lJz4vGWEbIUOOHvwg+vuvsc99ntRO8PC+WtmL7wf
         oZnkJkQzRD3NL4eB733etCxJnA/T8BTXAI8lrMnfYNt8eFRyg+xosQViUg30B4iBL3hL
         lMtu/Sjuht6L8nSw1Xci3UY7c2RUH/0XRiFrqULBtsriV7dp0TbvAm98oPfvS6p1KY+5
         pbupDvRk2yN47MgaCJUmTstH6SDQx8pBDzt5bhpK8BEY69M0wp3OpdpHNBHoIJDqQHAq
         azCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686601437; x=1689193437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlZZ0FPowMQe1pfgP0qmvZzhOsDqM40wmHL2pv/++cc=;
        b=H1LcB4XYjiemKkHVZ/+P+Qb4UHb5h/rLoQS7dNhUSEelbiQZGj03Q+iz98H0tVdSSm
         heFjgwTCic8oseEENDUSHdEfFZtZwpRG/QD9DnSxP4RnnCE/HL/GsvXQdUa179c/YJlf
         v31FzDVPYyosLG7fuZphlM45o5woFNV+ZVUe1I9KeRw94aE3AAp3sJiK59/pDgGD0oPO
         Tfp57AiBvl6RJLa8LzgFqqWFM1cNxoRhApuK1bPer8sKZ+76HNjbhGxsRe06OjfxcP2e
         0SrehvMjXy9MnsfWqHNseE53yH73fPOcM041J1GPPPBPskd59orEzrgqhAuylDVmEamB
         fD2g==
X-Gm-Message-State: AC+VfDycz1xJ/UiybME6J8kCXPAuuh2gMwYArffRYpaNx7PCET9SkgBk
        nbC4V0M5VO79u4YNiC8bWxcHnEIXxu0MUg==
X-Google-Smtp-Source: ACHHUZ4nOW8p4KYo7341HscTqp0CCtxm18XS9Z2ro/4DBqHQNdzZSaVZHcuZmxPw4TZI+s4AC8+SbUpzA3KFnQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a65:6416:0:b0:52c:9996:1726 with SMTP id
 a22-20020a656416000000b0052c99961726mr1431066pgv.12.1686601437296; Mon, 12
 Jun 2023 13:23:57 -0700 (PDT)
Date:   Mon, 12 Jun 2023 13:23:55 -0700
In-Reply-To: <dd21767c-7c66-cf42-1a64-954a069dc466@github.com>
Mime-Version: 1.0
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
 <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com> <506a2cf8c73549bc8f9761b56532ef08ed220da4.1685064781.git.gitgitgadget@gmail.com>
 <kl6lr0qwno2q.fsf@chooglen-macbookpro.roam.corp.google.com>
 <49509708-c0a1-2439-a551-cab05d944b66@github.com> <kl6lttvcft59.fsf@chooglen-macbookpro.roam.corp.google.com>
 <dd21767c-7c66-cf42-1a64-954a069dc466@github.com>
Message-ID: <kl6lr0qgfmzo.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 3/3] repository: move 'repository_format_worktree_config'
 to repo scope
From:   Glen Choo <chooglen@google.com>
To:     Victoria Dye <vdye@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Cc:     derrickstolee@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Even if we updated the only other 'repository_format' value
> ('repository_format_precious_objects') to be copied the same way, the
> benefit we'd get from eliminating a couple of lines of code duplication
> wouldn't necessarily outweigh the the extra complexity of a new abstraction
> - which may or may not need special-casing based on who's calling it -
> and/or the risk associated with changing behavior if we want to eliminate
> those special cases. IOW, I don't feel it's a definitive net improvement in
> this situation.

I see. In the process of doing this digging, I've become quite convinced
that the risk is minimal. I definitely want the refactor to happen, but
I suppose it's not reasonable for you to bear the risk.

I'll send a follow up patch on top of your series that implements the
cleanup I hope to see, and I'd be happy to give _that_ series a
Reviewed-by (though it's a bit weird since one of the patches will be
mine). It'll touch the same lines twice, but at least the patches will
be owned by the people who care about them the most.

>> E.g. we could support both deep and shallow copying, like:
>> 
>>   /*
>>    * Copy members from a repository_format to repository.
>>    *
>>    * If 'src' will no longer be read after copying (e.g. it will be
>>    * cleared soon), pass a nonzero value so that pointer members will be
>>    * moved to 'dest' (NULL-ed and shallow copied) instead of being deep
>>    * copied.
>>    */
>>   void copy_repository_format(struct repository *dest,
>>                               struct repository_format *src,
>>                               int take_ownership);
>
> Unless we find that we *need* to support both, this approach would be more
> harmful than helpful. If it doesn't matter whether the copy is shallow or
> deep, this design proliferates that meaningless distinction in a way that
> can easily confuse developers (or at least create more work for them as try
> to try to understand it) if they ever want to change or use the function.

Fair enough. I agree we're better off figuring out if the need exists
before trying to support it.
