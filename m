Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E6DC4332F
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 15:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D5461211
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 15:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbhIWPFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbhIWPFg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 11:05:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB2FC06175F
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 08:04:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s17so6257285edd.8
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CaE1wiiydCdirxPVE779Sey8ivOGrj/VX+YRKbIYeM4=;
        b=Nq0e8BZ6FzynObhAexQHK8dbZX8itHEDf8ePNDwle8f6tyLlwZsxc/E4d62Vf8diSk
         EPhUpLwzYNvQsktjO+ziuk9s5gOEx4xab9lUEKZBpDt2jAQcUOphFgYzQ3KUJF1ixnwn
         LzKZPR5i2+clOdxm14spxVp+yW/b6v25SDR3uBA44i2o7hNGdTHw8giKWqPtT76xvVlN
         6yfJ4Fdqy9TGSlqvhnQEfQeU4bES52opyKHwpXwNnWGHh7raXxQjRCUiYdSGOpCzGQCU
         CT3f10hRTksQZ1y+Znf9mAK2m/xxu2OA+/zzG59F99I9r5F61FTXjKtpvhbSnkum9YtS
         IlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CaE1wiiydCdirxPVE779Sey8ivOGrj/VX+YRKbIYeM4=;
        b=naoJjg4czfkAb6o73ltpUJjW47nS2l+Fn3V2Cf7/cxqMJa4qZIBOVvKZnpmtonUyjk
         sY+DC5ogZ7XymdubC2ofz3WqRU0sJvdOzHKcgYGG1mx37QEArQpzO8F6R4Qi/DvcFwCg
         W2Okot4PQBj8M6foneHIct8231DL12JZJ08JvLf3M7gSHoRS8dGXMkXhZQYudo/K2L+j
         7pGZkZX+pZ8sBadbH5CGw6EgeiQe6TDRV7GB0P18YhBc1WKU1/lEhTWTUU2n4x9iSqeZ
         Z0bN04RoY+3GIbnET3qEi4qR5u0cXzSytGlZY/m0FTI84B0OWDompZC8jc943yMOfvkh
         Jbvw==
X-Gm-Message-State: AOAM532Hlk1HQu8ffxgIxMFe4qHCq49MAyAp9o+Kr579hoTJxu3luLnM
        wzKlu6x5sJojZl/aQS/53BAtC3exOpKBSg==
X-Google-Smtp-Source: ABdhPJwnO4GF/rGJZtVwh4YaQhqsF7t0w+N5AZZoIHeOmfrOswnDjhl+Wdj6T25LPS7vXc68XC+lXg==
X-Received: by 2002:a17:906:7792:: with SMTP id s18mr5359660ejm.492.1632409403524;
        Thu, 23 Sep 2021 08:03:23 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q9sm3120447ejf.70.2021.09.23.08.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:03:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/7] Builtin FSMonitor Part 1
Date:   Thu, 23 Sep 2021 16:33:20 +0200
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
Message-ID: <87v92r49mt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Jeff Hostetler via GitGitGadget wrote:

> Here is V2 of Part 1 of my Builtin FSMonitor series.
>
> Changes since V1 include:
>
>  * Drop the Trace2 memory leak.
>  * Added a new "child_ready" event to Trace2 as an alternative to the
>    "child_exit" event for background processes.
>  * Convert the Trace2-related NEEDSWORK items in "start_bg_command()" to use
>    the new "child_ready" event.
>  * Various minor code and documentation cleanups.

I see 7/7 still has a pattern you included only to make a compiler error
better. I noted in
https://lore.kernel.org/git/87ilyycko3.fsf@evledraar.gmail.com/ that it
make the error worse, on at least clang. You didn't note which compiler
you were massaging, presumably MSVC.

I think that's a relatively small matter, but it *is* one I know about,
and there's no reply there, mention of it being unaddressed here or in
the commit message.

I haven't gone back & re-read v1 and seen if there's more unaddresed
feedback from others, instead I wanted to encourage you to provide such
a summary.

It really helps when a series is re-rolled to aid review both for
newcomers and returning reviewers. I really don't care about "getting my
way" on such a minor thing.

But it is frustrating to have the state of a re-roll be observably
indistinguishable from one's E-Mail not having been received, when
that's the case you've got to go back and re-read the thread, scour the
range-diff, and generalyl do a lot of work that the person doing the
re-roll has done, but either didn't keep notes, or didn't share them.

Personally I'm in the habit of "flagging" (starring in GMail terms)
E-Mails with outstanding unaddresed comments I get on my own topics,
then when I re-roll them I look at the thread, and "unwind the stack" as
it were by removing flags on E-Mails that I've either addressed via
updated commit messages, or added a note to a WIP cover letter.

E.g. here (just an example that includes Taylor, since he reviewed v1
here) is a case where Taylor suggested something that I didn't go for,
but i'd like to think noting it helped him catch up:
https://lore.kernel.org/git/cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com/

All the best, just trying to make the reviewer & re-rolling process
better for everyone.
