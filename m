Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746A9C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437226108C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbhERDdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 23:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbhERDdj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 23:33:39 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F0C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:32:21 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id d21so8443588oic.11
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ON6JJOFskRB3MKKV7e6jG9AUY8DkUWr0B3/xlXy9H0=;
        b=q3TH/vToKmtod9ZJAOhVK2RretMAF42CZyBvgy8MVbcdjnFh9RXJlbtIzYKb8qkNJs
         jp88fcEyujFaJVFCYob6MoEs7HmIjSpSWs1k90zmUBR3+Qa3L7YwGNzoJskBK4568tY5
         fnnkeMkRW1Jvu0bszhSkrLh6b2gEdXpr3oVfPAUG1JZrdnE5dlTL0LhNKA+TXPvMP5ov
         p/MQseZwkJDMJhOWwyzaACBNfYJ7F9n31fwjgY/26nQv7gsySTcjK3cNqqGUWk75cIgk
         OVKhvxxxzXHKYk0E1aRxeQr2uFvTiYZMPJ6hq+Y9tu7jYaXnet+8+uVOXCjfG+INZ91z
         1Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ON6JJOFskRB3MKKV7e6jG9AUY8DkUWr0B3/xlXy9H0=;
        b=KH+8yRi8WAzZ32Gn1fWeyKFfs9nENh2L7H9n4ZPTD+fNKgRA0YD6nLdbDo2O4A8OOS
         v/ZmYXhnLE+G/lwgJpgOp6DzuLl/qG96ZJsXEChQ1QAs8ENDeMPAT178JfACP2GVAOaP
         2vWHK5Y9EV5fTxQob/Qz8iPFvr+WqrlU+QP+NBucjNWfI+3QEjIZfZS7Bnt7iTvWxWzk
         gEFysbTNWaC2icgp03MMfZx7GR1SZZwE97bfHsE3Tq9u9uD9DvEI9WcUdLkzPXGMqgSK
         QxnhbdiP3Q7iRwXqLr1OXHcDXpmg3R/KoRjs6tGdTaFA1OooecVbzT+8Z9fWYOG6QEIW
         pblQ==
X-Gm-Message-State: AOAM5328tHAwKKaKM7O7bHSSs3CDFT2ZM4Cro4t+Ao+Xs2DlEoeY8sTK
        5jOURCwIBf6YzhJZL37ecXYwxvxB2IA00N++3gA=
X-Google-Smtp-Source: ABdhPJwS4igBaRtPXE8BsnMDHNyw50ozS94lijXHswO7rzDkq1tdlEPaLF0oU4HX47ljGDXpYBqWlPBpe3reeJG0B0k=
X-Received: by 2002:aca:30cd:: with SMTP id w196mr1760716oiw.167.1621308740493;
 Mon, 17 May 2021 20:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
 <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com> <179f992edc9254803252ae10e5d692f3755a40f3.1620840502.git.gitgitgadget@gmail.com>
 <bac325b9-8370-601b-a348-a7270df8b824@gmail.com> <xmqqa6ot6t7m.fsf@gitster.g>
In-Reply-To: <xmqqa6ot6t7m.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 May 2021 20:32:09 -0700
Message-ID: <CABPp-BH1MzWb-Xchm=DiUj+M73W9zzR6RUG91A7WO908MCt=6A@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] dir: update stale description of treat_directory()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 12:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <stolee@gmail.com> writes:
>
> > On 5/12/2021 1:28 PM, Derrick Stolee via GitGitGadget wrote:
> >> From: Derrick Stolee <stolee@gmail.com>
> >>
> >> The documentation comment for treat_directory() was originally written
> >> in 095952 (Teach directory traversal about subprojects, 2007-04-11)
> >> which was before the 'struct dir_struct' split its bitfield of named
> >> options into a 'flags' enum in 7c4c97c0 (Turn the flags in struct
> >> dir_struct into a single variable, 2009-02-16). When those flags
> >> changed, the comment became stale, since members like
> >> 'show_other_directories' transitioned into flags like
> >> DIR_SHOW_OTHER_DIRECTORIES.
> >>
> >> Update the comments for treat_directory() to use these flag names rather
> >> than the old member names.
> >>
> >> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> >> Reviewed-by: Elijah Newren <newren@gmail.com>
> >
> > I think you want the "Reviewed-by" before the "Signed-off-by",
> > followed by your own sign-off.
>
> Grabbing somebody else's signed-off patch, and forwarding it (with
> or without tweaks and enhancements) with your own sign-off would be
> a sufficient sign that you've inspected the patch deeply enough to
> be confident that it is worth forwarding.  So I think you can even
> lose the reviewed-by.
>
> But as long as you are relaying somebody else's patch, DCO asks you
> to sign it off yourself.
>
> Thanks.

I was going to go fix this up, but it looks like en/dir-traversal has
already merged down to next.

We could revert the last two patches of the series out of next
(allowing the first seven with the important fixes to merge down) and
then I could resubmit just the last two patches.  Or we could just let
them all merge down as-is.  Preferences?
