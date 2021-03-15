Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FADBC433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 08:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0AB64E74
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 08:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhCOH7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 03:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhCOH7W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 03:59:22 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5296C061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:59:22 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u62so17833145oib.6
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QK+PjVcTziq+RdEo9lcxYM8YnP970ufMRDpNRvvGaU=;
        b=TCnFOTQTfzQuQVes0HWuTSlYWrRJ73fA683RCpdBi9n1afCzF13dIskbgquvVTMhTT
         gMAjPn5bydALTw9lHzho8jCjhrHXSuRhIn6ZtWy9XAK9DYZp81feCILiLbSEPoLLlT4j
         rgPOgbqV86x2m1Aa60jqdWUb9olzFbLAQeekJ7Y4yxzMK8ELRu+DtQwbSj23JW8XkN4R
         BTt3F5NqeHaw9yZQ6fZpP+wjRrkDhU3IG733/PL2NBN97jbJ5d2A4AOp+rKC+PTKTEM9
         gqSx0ZdVXt9bGOXhR5WCHfmZ41pDQpgQEF/EzaPcl95gggscr0oP9HHhYjLSZ7U69jZw
         JIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QK+PjVcTziq+RdEo9lcxYM8YnP970ufMRDpNRvvGaU=;
        b=TlAmo+JtfiwAZPI3A1zdDYtFEaN7DJbeFr4IEIna7nHmDlPyzm+DuEfvwq9hIaielh
         NTvC7p/lEeNbr9ROXkBQywr9HHYn3NVQBBqxDGZb32HcOBAiEvViR87pUmFjhILCDl4C
         kwMiO4RPFV3jN47fKQddyDnrHYrGAxzQbovLZ+WWe3Q1YuOpB2KhlnRWMKhsM2WxYFkY
         QIy3gLQEDarD3rMPYv4IfqrhVAoOvMdXSVK9zCaJ9ryC7r2wtPmWY7Diqw52m+3B7K44
         4zDej+lYh+Uwa7Q+o977jrhbifqJcFM8N8z4/E0uIhDl/aDJRhfbgJibu3sS8LMzv+6c
         l91w==
X-Gm-Message-State: AOAM530bEi+o0QbZ5eq5olqogUT5TlcPz1zHwJ24MHcW/5J5N0D90ydW
        5zaceyTI3A1+UqniwCWZBQBbL6980XQjn6sRDH0nKa8O2/o=
X-Google-Smtp-Source: ABdhPJyIkeP5kg3RNNdJ48LBlullWM4D9We9tPlc4E3tNtAjP74saSZiFv6KsjmOavWGkM4kHXdYFMXuzggPfwtEcmw=
X-Received: by 2002:a05:6808:1a:: with SMTP id u26mr17184882oic.163.1615795162146;
 Mon, 15 Mar 2021 00:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-3-charvi077@gmail.com>
 <CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com>
 <CAPSFM5c8saGs=+OvXvZw-T2jPpdUfkmm9_BZOmZwUo=WO1sdQg@mail.gmail.com>
 <CAPig+cTBXBjZkJoGFYpzWBnEOmV52dnoBHxceuoe3pu3F0BnYw@mail.gmail.com>
 <xmqqft0y4gl5.fsf@gitster.g> <CAPSFM5f_=+S5XbE928a-q+OmaPi0iVQXZbJnHVy=ycGwdd8tGA@mail.gmail.com>
 <xmqqblbl4aro.fsf@gitster.g> <CAPig+cTO0umN4nAQi_qZEvTByCHFVavM-KbtfhkukXEUdzLPhg@mail.gmail.com>
In-Reply-To: <CAPig+cTO0umN4nAQi_qZEvTByCHFVavM-KbtfhkukXEUdzLPhg@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Mon, 15 Mar 2021 13:29:11 +0530
Message-ID: <CAPSFM5fQeB8dOQRzWkwAJCkHtNb2GXUWqgJUHCWoJh0vdDp_Fg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 15 Mar 2021 at 04:37, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Mar 14, 2021 at 6:43 PM Junio C Hamano <gitster@pobox.com> wrote:
> > FWIW I am also fine with Eric's simpler "open code it right there"
> > suggestion in this case.  Just like the "skip alphas" suggestion, it
> > makes the logic to parse subcommand name out isolated to a single
> > place without asking readers to refer to the implementation of a
> > helper, and it would be short enough.
>
> Likewise. If you're going to re-roll anyhow, the open-coded:
>
>     char *p = fixup_mesage;
>     while (isalpha(*p))
>         p++;
>     if (p > fixup_message && *p == ':') {
>         *p = '\0';
>         fixup_commit = p + 1;
>
> would be perfectly fine with me too (or any simple variation on that
> theme). Whether or not it's worth re-rolling again, I leave up to you
> and Junio.

okay, I agree too. I have updated it in the re-roll.

Thanks for all the detailed reviews and suggestions.

Thanks and Regards,
Charvi
