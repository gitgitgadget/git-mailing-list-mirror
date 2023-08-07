Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93C6C001DE
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjHGQ4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjHGQ4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:56:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528BE10E9
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:56:28 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so7825821e87.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427385; x=1692032185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5U8b2wuYzNfiH/kND/++VKO2FN7gPkwNhtWg4Dtjqw=;
        b=NpVkTQAABRoZCIrfoA6Px3RDs8K92iJAR4ADEiM3PvfTP+UUeP6YJ8/2kSQ+FUEsK1
         3j5BVWXyimcwm/KmGGJag3kWCuvpR/vKvrOm2xt/ARkDgDbWP1M0DTJT/RFrOeqGVh1L
         LSfi+1pIb77Fa46l/LuxvrMkIwpcxFQHPqEArhUqsWOBhFpEJ+mVKWtm8ZvfEojjooNS
         1WQhR0RcwGwK/QuXWVK//DIYObak2bAcI7qmu7NW6RoSYU6LxmWHKEXFAHhLa7lzKIw4
         w+i3ikMkWLWleFbjXolBcVp9TvayR/sVo7w7qgBsYtsj+Q8yUZyqsa2m+ut2vXSJs5QW
         24WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427385; x=1692032185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5U8b2wuYzNfiH/kND/++VKO2FN7gPkwNhtWg4Dtjqw=;
        b=A+QWqtzOs/VH6QURupZn9JYA4nQwh1wWYhfxkh75TRwi43vfddP7R3uoXCzPgj+5x/
         zcVI+Zr1UywEvMKRjMnoF3tpIrVJMzeJON7oZjvzxRXp0OX8+pRw0fOVh/47Nw318lFt
         0jhVRdukvQyowosgS+VSgzPIU0lHGIzIoR1EmJYNv1+oKanLjQMINq8XV9dGJjO09ayy
         Jgibxwqs7870Qfu5hcjLtSv0sExxFVUB4t+VEzHcfnTR6hWBFH15AyFg+vRjeUNzSS0t
         fzq+hNlKVIBbw9l9rZi+f35o/4Q8k2uhBFewELQKGntc6VfUTaNTkKy1fjlZm/gXKl7D
         4FhA==
X-Gm-Message-State: AOJu0YyhkmjEyh+QG0wTgR7Z6nrBFxERkvS4h0vyVHJw9LoM3lnXxSVV
        kIqs8xljgrV/WxETtGUvE4WWVMGVZBYokDiIvY8=
X-Google-Smtp-Source: AGHT+IE+msoLwINTEVdXkJ0qK2osuXMODWZl0uCLOOHzscFHVrL1m27vk0nkRXfAg4kWJnnXBhZulsatyYBdOzmw+oc=
X-Received: by 2002:a19:8c47:0:b0:4fb:893a:d322 with SMTP id
 i7-20020a198c47000000b004fb893ad322mr6513886lfj.68.1691427384373; Mon, 07 Aug
 2023 09:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqfs518gdh.fsf@gitster.g> <CAP8UFD1vuB2kRr890B7GXum9HAMjRep86zy2tE4yE2C3W5QGHA@mail.gmail.com>
 <CAP8UFD2Fw+oGz4VK=_i3B_D_VMQqMoXTJPpXRbkDiWjHciEqJw@mail.gmail.com> <xmqqv8dqhlkz.fsf@gitster.g>
In-Reply-To: <xmqqv8dqhlkz.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 Aug 2023 09:56:12 -0700
Message-ID: <CABPp-BE5h6C1iuGDz4HdJzb2bDLidEnQ0_U4fv93JrYXA2_cbw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2023, #01; Wed, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 7, 2023 at 9:19=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
[...]
> >> However in a recent article
> >> (https://github.blog/2023-07-27-scaling-merge-ort-across-github/)
> >> GitHub says that they are already using git-replay (though not sure
> >> it's this exact version or another one), and GitLab plans to use it
> >> too.
>
> So there are plenty folks who are capable of reviewing but they are
> not interested in giving it to the general public by withholding
> their reviews ;-)?

I can see how one could jump to that conclusion, but I don't think
it's warranted.  I have a little information that might shed some
light:

-----

At the beginning of July, well before the above link came out,
Johannes sent me an email pointing me at
https://github.blog/changelog/2023-06-28-rebase-commits-now-created-using-t=
he-merge-ort-strategy/.
In the email, he also noted my earlier stated concerns on the list
(about releasing `replay` early possibly painting us into a corner
preventing some desired goals for the tool from being realized), and
tried to ensure we could still work towards having a `replay` command
like the one I envisioned while also asking for my thoughts on pushing
for the current portion of work to be published and included in git.
My sense was he was pushing for the work to be released, but just
being careful about my concerns first.

Unfortunately, I was on vacation that week, and sadly have otherwise
been buried in coming up to speed on a new team and haven't had time
to even respond to git-related stuff.  I didn't respond to him until
late last week.

I pointed out that the 'EXPERIMENTAL' banner addresses most of my
concerns so it should be fine to move forward, but I suspect my delay
has resulted in him now being buried in other matters, and in the
mean-time the article Christian highlighted was produced by others.

-----

Anyway, hope that helps.  I did review V2 and have been meaning to
comment on V3 (and respond to Toon's comments), though not sure my
"review" counts as such since I'm the original author of most of the
patches...

(And sorry for being missing in action.  I've flagged a few other
emails that I'm hoping I can follow up on, but my time is currently
quite limited...)
