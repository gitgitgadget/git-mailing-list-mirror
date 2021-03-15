Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE449C4332D
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 15:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C976A64E74
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 15:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhCOPeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 11:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhCOPeR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 11:34:17 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F111C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 08:34:17 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id n23so7214027otq.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wyID7q2zemF0HbpRw52J7bY5gxc92O8hmRayboyIW7Q=;
        b=cKm0v7L7yfIOlTTdgTg5TTqPPqnlOMaO1+gYGqWO0u8BE8vK93VkROEJDA8umMwUge
         WvH9ShtsmpiJaMM1jrxc/rwl9vbe9dMc91DYnoke0zyq/c2APwZrJTAZb9Di091CCQ7+
         UVafPa1mru0rt9hX/RIwYfNJMCEpuDi6yXqRFqjLfQU+xCPsGLsaqgCfCZ9fdIFU7tyU
         ZkdrqBPLJSFcDvm9VT2NV15YPbo7P78Bb4V6V7+3jqEOIiHVxHRsq4qnTgzFwNEZeUoW
         DvaNQq7CGXtmaXrvm8nz5ZA6fL/I2kOKAA8juh2ZlfTgcFIRnGdSnyC28esEDqjBU6/I
         F1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wyID7q2zemF0HbpRw52J7bY5gxc92O8hmRayboyIW7Q=;
        b=aloK9IakC9uSIxlxYZuN1ulzsmWiOZLtYSbWm7Qhp2f4z7p+k+QX6YIm6mSt4fyrW0
         Q2LIimu3tFVVIbB7QwvGDv0SAc4/5xQzEUsrW4Xf9UrOxc5TQ0WYCDEmYCc6/POSXgY+
         kUqRpO6y3ngH6fYaj8LykkrU55aIK0jqxlbQ381zz/FeP/h0dM7ZdF2Df8+/xMh2kL2t
         VHuXXa3Vk+iN5MKHDx8hzXLLCYehdtXeiJXQ6zOhJ0lzKFe5cisnDZbslnwWJF2ETQn3
         FH0DkfGEt0Nqc9tk6C9e8jh+NuRT23Y5vg9VC9aKDw94WBqBP8vDoYP5yHz5/q/ESfvT
         88TQ==
X-Gm-Message-State: AOAM530g7UkeoU+SjxLXKdU11Fz7tlZRuLNoNf9im+qnCfhOXGqMq7jQ
        0QP59hZJ+1vg92p6XM3xOy2fFh3l/4qOglFfMBnPcLrG2N4=
X-Google-Smtp-Source: ABdhPJwVKaHNJjoYGdqFwWYA/oi5XryBLNPSGng18h8BV+yHDilhq12GZ1xjiRRYfLbcgfOhi/6VVWwh+McJGaQMTX4=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr14265502otf.162.1615822456761;
 Mon, 15 Mar 2021 08:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.853.git.1615674128.gitgitgadget@gmail.com> <8422759a-a4a3-4dc6-4ae7-4a61896b9946@gmail.com>
In-Reply-To: <8422759a-a4a3-4dc6-4ae7-4a61896b9946@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Mar 2021 08:34:05 -0700
Message-ID: <CABPp-BGBrmKhca9Lf7UF6AHkT7P5RD8uVpXQiqxhwMsQnRHeeg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Optimization batch 10: avoid detecting even more
 irrelevant renames
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 8:21 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/13/2021 5:22 PM, Elijah Newren via GitGitGadget wrote:> =3D=3D=3D Re=
sults =3D=3D=3D
> >
> > For the testcases mentioned in commit 557ac03 ("merge-ort: begin perfor=
mance
> > work; instrument with trace2_region_* calls", 2020-10-28), the changes =
in
> > just this series improves the performance as follows:
> >
> >                      Before Series           After Series
> > no-renames:        5.680 s =C2=B1  0.096 s     5.665 s =C2=B1  0.129 s
> > mega-renames:     13.812 s =C2=B1  0.162 s    11.435 s =C2=B1  0.158 s
> > just-one-mega:   506.0  ms =C2=B1  3.9  ms   494.2  ms =C2=B1  6.1  ms
> >
> >
> > While those results may look somewhat meager, it is important to note t=
hat
> > the previous optimizations have already reduced rename detection time t=
o
> > nearly 0 for these particular testcases so there just isn't much left t=
o
> > improve. The final patch in the series shows an alternate testcase wher=
e the
> > previous optimizations aren't as effective (a simple cherry-pick of a c=
ommit
> > that simply adds one new empty file), where there was a speedup factor =
of
> > approximately 3 due to this series:
> >
> >                      Before Series           After Series
> > pick-empty:        1.936 s =C2=B1  0.024 s     688.1 ms =C2=B1  4.2 ms
> >
> >
> > There was also another testcase at $DAYJOB where I saw a factor 7
> > improvement from this particular optimization, so it certainly has the
> > potential to help when the previous optimizations are not quite enough.
>
> These performance numbers continue to be impressive.
>
> I read through this series and found it clearly described. I can't
> completely vouch for its correctness, because there are a lot of
> moving parts at this point. I'll trust the test cases and Elijah's
> additional manual testing at this point.

Thanks for reading through it.  I understand the comment; in my
opinion this was the most complex of the nine "Optimization batch"
series to review (batch 8 was the second most complex, and batch 13
will be the third); I tried to simplify it as much as possible, but
there's just more stuff to simultaneously track in order to get this
one implemented.  Thanks for reading through it.

> Outside of me talking out loud about an enum (which you can ignore)
> I didn't see anything unusual about the code.

Ah, that answers my other question then.  :-)

Thanks!
