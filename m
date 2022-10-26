Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6336BC38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 16:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiJZQCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 12:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbiJZQBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 12:01:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCC85727B
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 09:01:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b11so8323117pjp.2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=un2z/pHf2v7C84/GD9SsxFnJdvYyxxbn7WdxNWRJ84I=;
        b=LAL5TSP82U9GXRB/DFO8VQ8l9NjhyFnTUw2mUta4uMfkIb01/Jmir6JvzG9P6B8D1w
         keeeIjfA9wAoqXQzM1GB3bv8S13Ux8xpoLek+kIyVJziewpJFcIcfghfKqlG0RIAw2+b
         ter6uz5KrbY0HE46vWG4ZJZwBpH3+0nex68pMAy8gtlyS0dU/l9De7L6q1dJA8ueRAFX
         ejiCLkvpO6dpQVghsPF4NdwqoPBuFUSKqvdrMwRkJpK8jPZ6YaYVTRSKoMl2v8ZpccaP
         eJxCv+jix1G3M7CofL1tfVnXuRieahLlH2oIVaa87i+7/2/FlPav/mcIE625xyClFsuC
         JGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=un2z/pHf2v7C84/GD9SsxFnJdvYyxxbn7WdxNWRJ84I=;
        b=uEMcz7sUPQKOOc+uMHM3JyNx7oG4UovH0/VjxWEQwp0tcCY4ljLXTtdWZxi3zk7AzR
         d1t7BFcoyuz7TvfGBGyYpjc63nDABKsG5ftEP0ngUzP8EJ1JzlrR76epZO+vWb2suUnv
         kVMHYeAhfg8UjjcOy2cfxCHYk5LPGjYRdFOk8nRhKKyUpyfEdot396HVuN5Aq7QKGfO1
         K0QYNACceeyiLSGPIDXr3ozfRTBa0CrH3Lxfm9HnkdKEhpvVmRqpFfrvwLMlYin9RG8k
         J/uil9uesIBJw0prhOq37k098tpFbGSMDbzZqOXtXiFlebEFlWA4JfJRuUhrOCAgArvY
         /FUA==
X-Gm-Message-State: ACrzQf3rZOyli+w6BgTCVSCwD44+ImF3rrpMJdJV+qT2Wn2IR7oOGXeX
        fWdibCdpPNlJnoQaBEYp/TE=
X-Google-Smtp-Source: AMsMyM69Rxodt3MGi3ALbEzd5d0gjLXX5Sr+1CHoMh+6R7vE4a+ROxKIwg5+HxAU84kNlqFhWekc2Q==
X-Received: by 2002:a17:902:e88a:b0:186:e5ac:694f with SMTP id w10-20020a170902e88a00b00186e5ac694fmr1341883plg.32.1666800073155;
        Wed, 26 Oct 2022 09:01:13 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090a1c8900b002071ee97923sm1267087pjt.53.2022.10.26.09.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:01:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Anh Le via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, Anh Le <anh@canva.com>
Subject: Re: [PATCH] index: add trace2 region for clear skip worktree
References: <pull.1368.git.git.1666742722502.gitgitgadget@gmail.com>
        <xmqq35bbmfz6.fsf@gitster.g>
        <d4103788-5153-11f2-487f-5cc795d261a8@jeffhostetler.com>
Date:   Wed, 26 Oct 2022 09:01:12 -0700
In-Reply-To: <d4103788-5153-11f2-487f-5cc795d261a8@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 26 Oct 2022 10:13:18 -0400")
Message-ID: <xmqq8rl2lgl3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> In the worst case, we walk the entire index and lstat() for a
> significant number of skipped-and-not-present files, then near
> the end of the loop, we find a skipped-but-present directory
> and have to restart the loop.  The second pass will still run
> the full loop again.  Will the second pass actually see any
> skipped cache-entries?  Will it re-lstat() them?  Could the
> `goto restart` just be a `break` or `return`?
>
> I haven't had time to look under the hood here, but I was
> hoping that these two counters would help the series author
> collect telemetry over many runs and gain more insight into
> the perf problem.

Without being able to answer these questions, would we be able to
interpret the numbers reported from these counters?

> Continuing the example from above, if we've already paid the
> costs to lstat() the 95% sparse files AND THEN near the bottom
> of the loop we have to do a restart, then we should expect
> this loop to be doubly slow.  It was my hope that this combination
> of counters would help us understand the variations in perf.

Yes, I understand that double-counting may give some clue to detect
that, but it just looked roundabout way to do that.  Perhaps
counting the path inspected during the first iteration and the path
inspected during the second iteration, separately, without the "how
many times did we repeat?", would give you a better picture?  "After
inspecting 2400 paths, we need to go back and then ended up scanning
3000 paths in the flattened index in the second round" would be
easier to interpret than "We needed flattening, and scanned 5400
paths in total in the two iterations".

> WRT the `intmax_t` vs just `int`: either is fine.

I thought "int" was supposed to be natural machine word, while
incrementing "intmax_t" is allowed to be much slower than "int".
Do we expect more than 2 billion paths?
