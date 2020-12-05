Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF36EC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 04:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5C022D72
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 04:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgLEEB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 23:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEEB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 23:01:58 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A270C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 20:01:18 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id z7so7199406wrn.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 20:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLqGR4mi9mYGd5FIEgdBl0Zu1kNzn59wYV0tDvOT9g8=;
        b=qlYp+u6FekomBVsiqzoF9B6TYGE8lWAJN63cxbd8kXoS9kAjUhOT08zaZVWyXW0Zv2
         2195WQ3LOSaG5f+9E2UfEQyu/jWitvIPMl7JGlwogtUj/NWdX6BfG/xe0WJoqs267XgM
         LiY0wPPn+SN3KzI42g5wQompGrFbTZcw+ZLHUGr09Uh3Z1AKl/HSgBAB+iIabRRRXLsd
         Lg5cbFv++fooOJdRiduMidc4uFjWojv44ESlqBFyaYlB85jqfDeDB7lm5CX/Oq2jgPy1
         eaQBf+JSMel4YttJLEL3FoJDOiDHs8ABq1EqYu7D8cSpPJynIQwvW2vmvhbDKhlKR6dB
         fKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLqGR4mi9mYGd5FIEgdBl0Zu1kNzn59wYV0tDvOT9g8=;
        b=mHcpCImYbBqa2rI3j4miMds/XcClc7FW5VxmdchioOoGW7eaNmH3lGmWgfNFtSOv3u
         M8XvkQjmtRtFlX1YpQ2JdwvsgQqwR+UGGPgnA14ahn8b0S4DWhQYC+Aja2o82YFuGUC+
         QDCBa990UI9LlhyeJK9g5idcJrYdT3PHi9bWFxvs+Nt/2XLLCFZUmKx7rOHCinupuQlo
         3TAKpgxEoMw8/6c2d8n4hYzCICCFxtRODmddEqC0mIlAIFM3XWd8xrWP03Ef6B6ZR+dx
         cNlC0OdHdgc22A/8hrhLyKl9hG2gfcp3v51rwBUVelDgiAJbY0C5J7rl5Etv+sLdlZvi
         MQCQ==
X-Gm-Message-State: AOAM5311oX3GOg1hUXY2QnTu+Xqywxwz0J5k+dJbylM3mBFISR9+KMVW
        er2Tu/O3IR4qsfMcL6P2O5LUaMoV+VwuyNREsV8=
X-Google-Smtp-Source: ABdhPJwkK1Xsi+n2iiGDFpsoaah+twCW73M9S7G5BvO0caTyNhe+Z4/xr40IiytOwj+H4Q8egD8qxKv/snaY4hmW9R8=
X-Received: by 2002:adf:e788:: with SMTP id n8mr8200170wrm.84.1607140877051;
 Fri, 04 Dec 2020 20:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-12-felipe.contreras@gmail.com> <CABPp-BG0WWvk96T757WMx=004qVqkf+SU8m3cCZsb1feTZJ80Q@mail.gmail.com>
In-Reply-To: <CABPp-BG0WWvk96T757WMx=004qVqkf+SU8m3cCZsb1feTZJ80Q@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 22:01:06 -0600
Message-ID: <CAMP44s1wFPQ0mEExYUQfxYx2AjMZS2=zL5ihfjp3qjp+EfNe9Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] tentative: pull: change the semantics of --ff-only
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 5:39 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > We want --ff-only to make sense only when no --merge or --rebase option
> > is specified.
>
> A lot of git commands have opposite options, and git allows them both
> to be specified with the last one winning.  Thus, much like
>   git log --patch --no-patch
> mean show logs without patches and
>   git log --no-patch --patch
> means show logs with patches, I would similarly expect the following
> two commands to have opposite behavior:
>   git pull --merge --no-ff
>   git pull --no-ff --merge

Good point.

Although I presume you meant --ff-only.

Taking that into consideration it may be possible to make --ff-only
work straightforwardly.

Further changes to the code are needed though. In the meantime I'm
sending a quick patch on top of this series.

Cheers.

-- 
Felipe Contreras
