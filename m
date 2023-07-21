Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D192EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 18:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjGUS0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjGUS0w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 14:26:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C672D6D
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:26:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5839e70f346so8487527b3.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689964008; x=1690568808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf3elx24k7AdKcw6nv3XosFMa4ASKdQcEYcTSDSQmPs=;
        b=x7Hft2G1N7AaVoHDn6pVOXWjMhIl0hi4Nten+ZIbiBN63LA7UQItbQKHc21TFikkGN
         Yitk6H0jaK11ihEVNHpPpkRTItOY4c9OFhvRMLv7y+wjWMqeNayrh8aZnhEy4XSGtxiY
         DnkwlNnwFsMZOpIsW7TGFfQOehsApbgknn2fbxdDtwAvnOjBKvhRzA5vQ5kDlm+dfJye
         8mZqiQP/AjnRo+8Ync7W4+VJnx4AznBx8K6uAhbF1zoKZRIEsXbWl6UiMuJkqfPIO//0
         LaRZoTxtZyimNKVG1Xtpa2C6Xq9H/6L+78ohty1g6nrbf+7nC5EeBIDEz+cEfKk7DMAs
         G2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689964008; x=1690568808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf3elx24k7AdKcw6nv3XosFMa4ASKdQcEYcTSDSQmPs=;
        b=X0qskL0VtQvncxChpeG+Dzsgr6REl+V9f0JBIimGt+zFYUylbXGE8nc8GRPRzYp1YU
         FlDGwO43VMYPkzfNYUDj0fuViWgsjc9F5MPdKcFLnCsb+KzNT6l1h67ZDjel8OoF7w7b
         doe2G8ImT9FLYY2W+I3aYmC8j+x5tINXqQl9EaMY0R+90/QVaDxsvQKOc4uW7gOSzsl/
         fPng7VTk07oYGsgy/10umoFlY7/1jmpucjPfLH8KdMe8CMxNtjlnKv+v6FGaTJV049bQ
         zjisZClBXU7KLOWpXku5kAtB/f+XV66OrlMA1lREEtdJYZYlUhJGQbhOMNmF7JbCkW0D
         mUsQ==
X-Gm-Message-State: ABy/qLZqVDPtgRI+n7MZb4M2NWK7Esab7p407z6gSIfiGLM4zUK3dCDm
        fZiBviwysvlYXHtbjC34hCIZR/+Pngq8EQ==
X-Google-Smtp-Source: APBJJlGogCkhjNsHl467K6dcvgcqVvsEbJohCiPF4iteu4hNZKRywsmGR1T7B8FA47l3Ru51pur2r43Xe33rPA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:af4c:0:b0:573:54d8:e5be with SMTP id
 x12-20020a81af4c000000b0057354d8e5bemr9322ywj.3.1689964008383; Fri, 21 Jul
 2023 11:26:48 -0700 (PDT)
Date:   Fri, 21 Jul 2023 11:26:38 -0700
In-Reply-To: <xmqqzg3q1g2y.fsf@gitster.g>
Mime-Version: 1.0
References: <20230714194249.66862-1-five231003@gmail.com> <20230719162424.70781-1-five231003@gmail.com>
 <20230719162424.70781-2-five231003@gmail.com> <xmqqjzuv5vvg.fsf@gitster.g>
 <kl6lzg3qzdhn.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqzg3q1g2y.fsf@gitster.g>
Message-ID: <kl6lr0p1yvc1.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 1/2] ref-filter: add multiple-option parsing functions
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>>> 	So whatever framework we choose, it should allow adding a
>>> 	test or two to this patch easily, without being too
>>> 	intrusive.  Would that be a good and concrete evaluation
>>> 	criterion?
>>
>> Perhaps, but the biggest blocker to adding a unit tests is whether the
>> source file itself is amenable to being unit tested (e.g. does it depend
>> on global state? does it compile easily?).
>
> Now would this particular example, the change to ref-filter.c file,
> be a reasonable guinea-pig test case for candidate test frameworks
> to add tests for these two helper functions?  They are pretty-much
> plain vanilla string manipulation functions that does not depend too
> many things that are specific to Git.

Ah, yes. This would be close-to-ideal candidate then.

> They may use helpers we
> wrote, i.e. xstrndup(), skip_prefix(), and git_parse_maybe_bool(),
> but they shouldn't depend on the program start-up sequence,
> discovering repositories, installing at-exit handers, and other
> stuff.  It was why I wondered if it can be used as a good evaluation
> criterion---if a test framework cannot easily add tests while this
> patch was being proposed in a non-intrusive way to demonstrate how
> these two functions are supposed to work and to protect their
> implementations from future breakage, it would not be all that
> useful, I would imagine.

The current thinking among Googlers is that we won't remove the helpers
from library code. Git will either provide them, e.g. via Calvin's
git-std-lib RFC [1], or we will provide ways for callers to bring their
own implementation (like trace2 or exit, since it doesn't necessarily
make sense to use Git's implementation). So yes, the test framework
should be able to support this sort of compilation pattern. I'm not sure
how much test frameworks differ in this regard, maybe Josh has some
insight here.

[1] https://lore.kernel.org/git/20230627195251.1973421-1-calvinwan@google.com
