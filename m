Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF737C2D0A3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 14:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87FC021D43
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 14:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr4Jkayk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760372AbgJXOzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 10:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760369AbgJXOzA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 10:55:00 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF5C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 07:55:00 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id m128so5722409oig.7
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Up17cgi0etZbqZhWUepgEUsDL/GOLd1VD8jhwHUw6mY=;
        b=Vr4JkaykFn7aWFoA5Rd3dHSEBlHsPVenD4xeDh7cI49D1ImakGmLZ6E48Q+fi9g6V6
         0BJ6873vAEFYZXHzei7sTXLvb7r6Ip0oyoF6F7GgOHVCvFGF2rl/NrVfXsrOIUP6CknK
         O5mw5Rsfq06ZmvvGMBFjqwzZd1K41UAgB4r0vOCyF55ZITvUKUGIW9ezX6Ca+WuLxCq3
         uuN/jwlgxETkYw6mWpUZqbaAl/LCyhrIf0Y5vcQjm4CB9/h2jdqkgwuMmb4tCEnjS9Pq
         g9kECI/klHh3I+LGM/XMjdXMqNEyoLh64zSHvdsns/+d1G1RnMEZO4VvkB2IjwUqZaiX
         pPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Up17cgi0etZbqZhWUepgEUsDL/GOLd1VD8jhwHUw6mY=;
        b=RyMdOCuX5Ncg0RwT5mvqAl3sIgIEwgdSokHgV3IP3KzyCUMACzdZyjI8uy62dfrn9F
         MhD/qkBcriCqEl4I09+YciGQAXkwrn7f4QESo/NLnf2/xK3gRTqsSkAYhminTF5VsKCI
         eL2KTtbwzk4xeGgKshrCF6ZPlaN+1MrP9OXQ7QeFbCzOF1tHPn2d2pojQMUfBr0UbaVt
         uDaQEwQAi2ZQh2NKERhceQcp2FZwMYCMdIghk7wIzrH2v1405/ZECYzyz0uRt9l2dMvu
         UbS73TiM6LOV23HjdRMt5NczROM3WfchyneyuKpsqZZuPBGfGuba10h3PQ4OpC4cJKuP
         AB7g==
X-Gm-Message-State: AOAM531ZF4nIW0wupTN3yJLAuUluOC+uZKvUByLy0astC3s+rWvYYPq8
        Rt7gOhFzK3cQiEtvUnKhayI+typSSXVOOfmNRQFa7Y7nGa4=
X-Google-Smtp-Source: ABdhPJx0QT7GMITOIp7elWd6OGA0z07/h/4hpQBySewurURUd6XJXZGCJrwBUTL+KMaWnFTbPQWBmNDMzJUQvs342AY=
X-Received: by 2002:aca:ec92:: with SMTP id k140mr6564486oih.39.1603551300150;
 Sat, 24 Oct 2020 07:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
 <54ef18182cf3a4b5d02889c139e495fa68588652.1603286555.git.gitgitgadget@gmail.com>
 <CAJm9OHczJJyn=Oq2RBGvTit4hedqs6vaYH1gto-z6emo6=n2dw@mail.gmail.com> <CAJm9OHdfxh8SGdteD48eDCA=ihGZmKJD-E67PFhCdFR63RSSTA@mail.gmail.com>
In-Reply-To: <CAJm9OHdfxh8SGdteD48eDCA=ihGZmKJD-E67PFhCdFR63RSSTA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 24 Oct 2020 07:54:49 -0700
Message-ID: <CABPp-BGnZEDXxvTR9GxW+Y2FzG9DCtOcoUPTipoAFjdhh8cpJg@mail.gmail.com>
Subject: Re: [PATCH 1/4] merge-ort: barebones API of new merge strategy with
 empty implementation
To:     Peter Baumann <peter.baumann@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 24, 2020 at 3:57 AM Peter Baumann <peter.baumann@gmail.com> wrote:
>
> Am Sa., 24. Okt. 2020 um 11:58 Uhr schrieb Peter Baumann <peter.baumann@gmail.com>:
>>>
>>> Am Do., 22. Okt. 2020 um 03:28 Uhr schrieb Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>:
>>> [... ]
>>>>
>>>> diff --git a/merge-ort.h b/merge-ort.h
>>>> new file mode 100644
>>>> index 0000000000..9c655cd3ad
>>>> --- /dev/null
>>>> +++ b/merge-ort.h
>>>> @@ -0,0 +1,49 @@
>>>> +#ifndef MERGE_ORT_H
>>>> +#define MERGE_ORT_H
>>>> +
>>>> +#include "merge-recursive.h"
>>>> +
>>>> +struct commit;
>>>> +struct tree;
>>>> +
>>>> +struct merge_result {
>>>> +       /* whether the merge is clean */
>>>> +       int clean;
>>>> +
>>>> +       /* Result of merge.  If !clean, represents what would go in worktree */
>>>> +       struct tree *tree;
>>>> +
>>>> +       /*
>>>> +        * Additional metadata used by merge_switch_to_result() or future calls
>>>> +        * to merge_inmemory_*().
>>>> +        */
>>>> +       unsigned _;
>>>> +       void *priv;
>>>> +};
>>>> +
>>>> +/* rename-detecting three-way merge, no recursion. */
>>>
>>>                                                                     ^^^^^^^^^^^^
>>>>
>>>> +void merge_inmemory_recursive(struct merge_options *opt,
>>>
>>>                                             ^^^^^^^^
>>>>
>>>> +                             struct commit_list *merge_bases,
>>>> +                             struct commit *side1,
>>>> +                             struct commit *side2,
>>>> +                             struct merge_result *result);
>>>> +
>>>> +/* rename-detecting three-way merge with recursive ancestor consolidation. */
>>>
>>>                                                                    ^^^^^^^^^^^^^^^^^^^^^^
>>>>
>>>> +void merge_inmemory_nonrecursive(struct merge_options *opt,
>>>
>>>                                             ^^^^^^^^^^^^^
>>>>
>>>> +                                struct tree *merge_base,
>>>> +                                struct tree *side1,
>>>> +                                struct tree *side2,
>>>> +                                struct merge_result *result);
>>>> +
>>>> [...]
>>>
>>>
>>> Looks like the comments above don't match the method names they are describing.
>>> I assume they should be just switched?

Whoops, indeed.  Will fix; thanks for spotting.

>>>
>>> -Peter
>>>
> Sorry, I completely messed up the markers. Serves me well for not using a fixed with font.
> Here it is again, highlighting only the relevant section:
>
> > +/* rename-detecting three-way merge, no recursion. */
>                                         ^^^^^^^^^^^^^
> > +void merge_inmemory_recursive(struct merge_options *opt,
>                        ^^^^^^^^^
>
> [...]
> > +/* rename-detecting three-way merge with recursive ancestor consolidation. */
>                                  ^^^^^^^^^^^^^^^^^^^^^^
> > +void merge_inmemory_nonrecursive(struct merge_options *opt,
>                        ^^^^^^^^^^^^
>
>
