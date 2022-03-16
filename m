Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C2EC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344850AbiCPTBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiCPTBv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 15:01:51 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3956CA4F
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 12:00:37 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id l2so6132999ybe.8
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L79EUBY3+LrW31mjR5bJm0UFHpUMSUr5d0+aaI1O80Y=;
        b=Nwh7ruZZ/UTocvoDVHXq9BQzWyUCcxHIwNMEGiy1bO84Kf92I9JE4ZiGDcKE9AsMbM
         SvuUY2jBxgrRyixqiPIGhGxArYvBU2rNz1EInMbN7d9w7n2Wvz0Tspo8iSsPvAROtnjo
         FYHrZksDuX3PJjs1RGnTHQ0O/NUkzwUw3EgZaPl6hzcCN6Y00YjBv1sI9oVq8vOi5F81
         L5eAJh0XC9FtwmxNN+dHPMZy2PgKppH/TAOS2PjNlv/PDzV8Oh/kWmX+IfN2VmDxyUNL
         uf+p5C0ueM7Mdpdy89hVVeg+6OObRcr42VgkxHyBNwLeC0hsV16wIs5lWFnULFr7kXvX
         2ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L79EUBY3+LrW31mjR5bJm0UFHpUMSUr5d0+aaI1O80Y=;
        b=rFv7t8B0nIT46/sK8MuCw7fX35zEDhaw4yMYQZqfJv9sXbVDYcTbArqmUUquOs2ooi
         zuYCfUkkzQc5C2YXVbr8ObLsZ7OXyFBQ1z3pTrL3EiY9cPKF7Q3bnsf5RiwPVJIeOj+Y
         rs7XIa8CgeES/5vKcH4idRWyJ1uFi6LxFPZGwDy+nL1lQGwhR+utTlZ/miMcC5/fb5vF
         Ke+YsWdz6G0jKJL9mpw9vv4HuR0/3j4UZfxiK43zlBVOcAN4moAsybfr6LWVXUN1fAcR
         C4DFwKXboQm8HJoimLuDi+OwBMNVS0jGrf6lGbPjaQ8/DwOcBJO4rEesVz9421gWZO+r
         2xAQ==
X-Gm-Message-State: AOAM532vXr7shDBy1Lm1JqdMSAj+BqgA55/NtyMUYqXF43ZVaw7gFMLH
        FguGj8MlUJcmfyzhuT+2YlclJ3w2PJAYv5wG52g=
X-Google-Smtp-Source: ABdhPJwiUvTFZZ+ylyjJ+TSALga2haGSRWg4wgKrIR+4NbWR9pGDAYA48kX/6gvk4LJU9xVHk/CXRMWyqQX7dKv3nms=
X-Received: by 2002:a25:e08f:0:b0:633:7d68:f21a with SMTP id
 x137-20020a25e08f000000b006337d68f21amr1434087ybg.650.1647457236594; Wed, 16
 Mar 2022 12:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAJcwCMMMm=ZnkV3Xxbf+CpJqhRGx1KrdUzh90W-9dEPJ+i40xg@mail.gmail.com>
 <xmqq8rt9opd1.fsf@gitster.g>
In-Reply-To: <xmqq8rt9opd1.fsf@gitster.g>
From:   Andy Zhang <zhgdrx@gmail.com>
Date:   Thu, 17 Mar 2022 03:00:26 +0800
Message-ID: <CAJcwCMN67UMjSNqf2wbb5ZhK1QGicn7+ihneOc1XxJsdDVtvTw@mail.gmail.com>
Subject: Re: understand Diff Formatting --cc flag?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 17, 2022 at 12:04 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Andy Zhang <zhgdrx@gmail.com> writes:
>
> > understand Diff Formatting --cc flag?
> >
> > hi,
> >
> >   It is really too hard to understand Diff Formatting --cc flag.
> >
> >   It is hard to understand"...hunks whose contents in the parents have
> > only two variants..".
> >
> >   My question is:
> >    1)what does "variant" mean here?
>
> You may be comparing a merge of 5 parents into 1 child.  There are 5
> pairwise comparison (parent#1 with the child, parent#2 with the
> child, ..., parent#5 with the child).
>
> Among 5 parents, perhaps parent#1 and parent#2 had the same contents,
> and parent#4 and parent#5 had the same contents, different from what
> parent#1 and parent#3 had.  You have 3 variants (parent#1's, #3's
> and #4's; parent#2 has the same contents as #1, parent#5 has the
> same contents as #4).
>

[Andy wrote:] as per your comments, The 3 variants are indeed into the
following 3 groups.
My question is: why can #1 appear inside multiple groups? A and B.
   <group-A> parent#1, #3, #4;
   <group-B> parent#2, #1;
   <group-C> parent#5, #4;


> >    2)what about all the other cases? 0 variants, 1 variants, and 3
> > variants and even more?
>
> By definition, you wouldn't be making any comparison if there are 0
> variants.  1 variant means all the parents are identical, so
> whichever parent you are interested in, the difference to the child
> is interesting---such a change can only come from the person who
> merged adding a change that no parent wanted to have.  If many
> parents are different then showing the comparison with the final
> resolution from them is useful.  The case that is not so interesting
> is when one set of parents had something (call it A), and the other
> set of parents had something else (B), and the result is A.  There is
> no interesting merge conflict in there.
>

[Andy wrote:] can I explain  "--cc" flag as:
"--cc lists only either hunks which were modified from all parents, or
hunks which were modified from at least two parents and they had
different variants"
