Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773CBC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 21:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE5461A81
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 21:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhKRVnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 16:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhKRVne (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 16:43:34 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2610C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 13:40:33 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u3so32841102lfl.2
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 13:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivDPg8UV+ILWZkEA1kxzAq03hnSkQfykHYKUMMeKzik=;
        b=mIZ8ywJ/o8RXYvBibGY+aPgmf4x4/aaX9p8miuNBzTjmtt/uNnFjV3h1eJJehm9AZp
         ZVoWBYl/VRIYTfvvdZlD4jtnsd68BHMLOJUBx5UmGssi/fzkiiLSXQYhO+y7taq/+1kT
         x6uNalToWHsrvMwi2JeOYlwQq9RrfGRbjonVSzG7AqDiKOG7nyajQUwDbHQEmMx9NG2c
         e0agdcrgWkheOSkJwLySmByYrQxDyPSzGUGi7OxDnOR64AYekxG0E7Sg9Qe93e2J4wsv
         8Lne9ZbFKPeTX6uDkHrPi1RY8b5+veo8BkRu7sgGtlyb7PiQ5cs8ZDG7sDcUmFvH7AYw
         CPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivDPg8UV+ILWZkEA1kxzAq03hnSkQfykHYKUMMeKzik=;
        b=4i9tMJWZcyQKkdeEh9UCjLhCgi9D6g68Uhx+3ShP5BmMRkmypdomjsRn8LnhcW4oEV
         Nx6Epzs1Nuf77ESdxUL0Aj2Apnh8Brpsz1qQPdsjI3BgLtoEvMHDkZ4N6+NM6gtHI3sp
         TVBgh+JSo97e0JmUWqE0FVH8OGlL2ezm/s684TUDzih/UEbP8yuWrLZPC4QWMcfLOfo6
         4azeXKEgb7esDQ2Kk/KfKTdW3iPapTrLbRZQ3gfaZtvj/lsJ/GRuoXCy7Pcl6DV+qLVN
         4mHB1+Cx1W/l9bbSPE0PAVFGCVJMdhtEL95ZrMESawYZoszdRt/eZBdcN2KUCg3tO0zC
         9leg==
X-Gm-Message-State: AOAM533sdZIIPdPj4mcvjYqxhCFkH+ZUBUnvhHxSYW16VQmqqSb4A62u
        C6MWRdvq2QS/kU9ppYo3sVGqjkYS7ZafdLuj5qi88Jmifhw=
X-Google-Smtp-Source: ABdhPJwsuxv/XbBbudy4e6bTDhiDVFFDgZKX0XGGqwwDsyDgJbXqf/BWUA5xH2YFm+VUg63tTyYBgkY9O33WPDIO8DU=
X-Received: by 2002:ac2:5fee:: with SMTP id s14mr26186705lfg.537.1637271632033;
 Thu, 18 Nov 2021 13:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20211118154317.639118-1-alexhenrie24@gmail.com> <xmqqk0h5w3qy.fsf@gitster.g>
In-Reply-To: <xmqqk0h5w3qy.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 18 Nov 2021 14:40:20 -0700
Message-ID: <CAMMLpeSuL2k2semwS+K1jxTNZEV79GzCymFZo+1VcsyU6bYTrg@mail.gmail.com>
Subject: Re: [PATCH] pull: don't say that merge is "the default strategy"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, sluongng@gmail.com,
        matthias.baumgarten@aixigo.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 2:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > Git no longer has a default strategy for reconciling divergent branches,
> > because there's no way for Git to know which strategy is appropriate in
> > any particular situation.
>
> A very good observation, and the patch makes sense.

Thanks, I'm glad you agree.

> > The initially proposed version of commit
> > 031e2f7ae195069d00d21cde906fce5b0318dbdd, "pull: abort by default when
> > fast-forwarding is not possible", dropped this phrase from the message.
> > It appears that leaving it in the message in the final version of the
> > patch was accidental.
>
> Hmph, the one before later iterations v$N, i.e.
>
> https://lore.kernel.org/git/dca0455898a838b46546a29ee79f0a8b112fbff5.1626536508.git.gitgitgadget@gmail.com/
>
> seems to keep "the default" label from the beginning.

I was referring to the patch that I originally wrote, before Elijah
made the changes that actually got the patch accepted:
https://lore.kernel.org/git/20210627000855.530985-1-alexhenrie24@gmail.com/

> I am tempted to drop this latter last paragraph, which looks more
> like a guess than anything else, and does not add much value to
> future readers of the "git log".

That's fine by me. I almost didn't include the second paragraph in the
commit message to begin with.

-Alex
