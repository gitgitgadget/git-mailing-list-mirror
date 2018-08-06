Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26946208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbeHFRNe (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:13:34 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33198 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732384AbeHFRNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:13:33 -0400
Received: by mail-wr1-f43.google.com with SMTP id g6-v6so12725250wrp.0
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VAHD978VN+HGIqHoIE9KieZ8PuJJt193jGLtrW3chCA=;
        b=f6OxqnCBi/Yoq6laRzN8SVIvcns5ik1LoZxHT0DyijHwmZV5qfonEAnU+7AVNEXDap
         4kggXxH+M1w/Zp+vRsOMoYX1uuLm+lR3HzaYThlsJWAa1TLQyFnoO9j4k68DB9NQ6cwv
         w8sULco48Pbi3LQ9XbeQ42pdlzV0ycqeoj1cQpZ3YVzNQ+lxm8kcnrZo7UIeKTWhKdQN
         LVltQ+x38LMd/K/gCU0TtQJDO7tHkljREuM3X8UOo0BUvrlFIzJCF9wreOmG8J9z2vmR
         dlPSkG0loDOgItuLNWPharIkbTuIUSm60jZb4p3GnN46Zm7YvMDWbbF/D9hSvytqOWW8
         bQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VAHD978VN+HGIqHoIE9KieZ8PuJJt193jGLtrW3chCA=;
        b=tARbpX6aZARaWWrNGRHdx4L1f6AoU3+d1t5pd+gxQfTn2fG+9Ntgm4CqG8RDEvcqBt
         2c6VLXi/Vt5p6Oo/lTHk/6oq0rAb7KNE3SBTvaofOakP2QjvB+8eETJSnYkClVU3S1JE
         95a2pO70mAaogGaJzFGLfE+N2Ru/TSBUu7hrDCsM7oT5PY4QH5u41DiWmXAOb5gQMvNy
         3/6/eSZsvSPFnVj1rVKxeVYmyh2W0qr+jrURXOmKIHcHvfrUIJBLPdHOZ71vO2a2S97q
         fnhzFWgASopveq3uLRVWIwMYktjxqvhNN95v5i7CMU6DnKuxikRYib3u31Uu7eR6vzhc
         uYCQ==
X-Gm-Message-State: AOUpUlHW3d1ZmWeWT2nobcz+gSxPJAAnhNEb4MQn7Ep1MWgH/qgLQ+z6
        BW43K3dM7aLIxAc8j2D6DsQ=
X-Google-Smtp-Source: AAOMgpcPdd7QysgDuSUuEMIO/nFM5o/xIeBStjYnJ48F/s+z6NYLIGk+BkUOvA5RhAa5C0VN8y+MSg==
X-Received: by 2002:adf:bbd4:: with SMTP id z20-v6mr10223815wrg.183.1533567842272;
        Mon, 06 Aug 2018 08:04:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x14-v6sm9282174wrv.21.2018.08.06.08.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 08:04:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Tan <pyokagan@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] t4150: fix broken test for am --scissors
References: <f91c7393-4f1b-1cf5-b870-f42e9bd18d64@gmail.com>
        <8f69d82b-0f35-754f-0096-853d6b463db7@gmail.com>
        <bea0e5d0-d944-ddd8-c3ab-a95355352b47@gmail.com>
        <CACRoPnTWxYvGfqgGt2r5ETOhfJZnqr1fTO9Fzwp-u25XbMGPPQ@mail.gmail.com>
Date:   Mon, 06 Aug 2018 08:04:00 -0700
In-Reply-To: <CACRoPnTWxYvGfqgGt2r5ETOhfJZnqr1fTO9Fzwp-u25XbMGPPQ@mail.gmail.com>
        (Paul Tan's message of "Mon, 6 Aug 2018 16:58:52 +0800")
Message-ID: <xmqqpnyvr0yn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Tan <pyokagan@gmail.com> writes:

> I've taken a look at the original test, and it is pretty broken. My
> ...
> So, there are 3 problems that will need to be fixed.
> ...
> This fixes problem (3) by using an in-body header.
> ...
> This fixes the first half of problem (2) by making the naming of the
> files the same.
> ...
> Nit: I'm not quite sure about naming the tag "scissors-used" though,
> since this commit was not created from the output of "git am
> --scissors". Maybe it should be named `commit-without-scissors-line`
> or something?
>
> This hunk removes the line:
>
>     git format-patch --stdout scissors^ >scissors-patch.eml &&
>
> without a corresponding replacement, but that is fine because the test
> should not be using a patch without a scissors line.
> ...
> This fixes the other half of problem (2) by making the naming of the
> files the same.
> ...
> So, this patch fixes the 3 problems with the tests, and so looks correct to me.

Beautifully explained.  There are many styles of patch review, and
I'd personally call this "think aloud to follow the patch author's
flow of thought." style.  Your review is probably one of the best
examples of reviews in the style.  Very readable, helping readers to
reach the same degree of understanding of what problem the patch
tries to address and how, and demonostrates the reviewer thought
through the problem just as deeply as the patch author, all of which
gives weight to the final "looks correct to me".

Thanks, both.  Will queue.

