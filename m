Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD61C3567B
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 11:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE55620828
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 11:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5SCXQy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBXLJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:09:20 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39952 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXLJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 06:09:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so8312811otr.7
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 03:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBLj6Dx18LCzallpRSf41cNn1TwPNj3OFZJwB1PB+E8=;
        b=A5SCXQy8x3L2sfVWl76yYeWWw9llkcdnGWxSz9yw1vuK5An/Vds+PFUahnQs5+sseR
         LPjXuK5UzdBor9tm/Jfvla0i6+Vj0NIKorD0+u+CIxMvvc8GRtuLtEeuDVqvujhTBvF0
         9KjupmUIrFa0UCaXWua7Txc3XZVNZHEpAwU9trq3YccnXHWAbKiL6FU7v9qUUhr/Xrqq
         A8t1QQVV/RcyEUK/TEPZlzhjEDvdVkZgqLK7xbuqviAq6CzMB+Mxhkb7LDCjcxUwg9tG
         1nlnWmlTOwv7eOPNOznmxlYN9aJ9DwgY+tj0ERPc0ATGqRHPqQhvLQ5gDSiLbshBPQEL
         KvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBLj6Dx18LCzallpRSf41cNn1TwPNj3OFZJwB1PB+E8=;
        b=JtxufeRMyo9MFf+JWJ8jm+jqGle0y+DZ9tOWbEsZPNAUxUg9mElGrvq5wfvhnVDfOb
         FbaQ3SwE+7IpnchApePmb/PhMIoaaee7p79przgcvq3whVeRwtBLTUz4QpjXM+cryuAH
         kKPFM/+EreJlUrWXz9m8wYouPJAHu9nXsD98LJMNIfEi9Ho71Mmwy763zvHBZWLnR905
         r49gF1ra6FM8LhZO/qcT7Ce5HBKjcGyrVYlCPssso574zpZ07McIizyz4JKic0UTtiyh
         4t4KG0e4v9jdr6wrPvYdOgm2InHZQ+qC5/iIun9Sl+COH8sPbH3qx9ffBSnkpzQAnD/v
         wpaQ==
X-Gm-Message-State: APjAAAW5SoHEnSVsABpudwSriJRlkXk44iMldVIldum/S3/HLOSYCSAP
        O3ze2fPvSaScjqXsLltYjxC1hlnB+Vab5B3TFEE=
X-Google-Smtp-Source: APXvYqx5TTWgh2KvK1S+rV1/FtYCIBc1w1VszN1uP+a/wom8NrsojSSFPmRVgpI7ddcW2eIkXFgf0ANl27Ua9qFhg78=
X-Received: by 2002:a05:6830:88:: with SMTP id a8mr25287034oto.177.1582542559390;
 Mon, 24 Feb 2020 03:09:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
 <pull.535.v3.git.1582484231.gitgitgadget@gmail.com> <8718facbc951614f19407afa6ca8d6110507483d.1582484231.git.gitgitgadget@gmail.com>
 <CAPig+cTh-uu-obh9aeDOV9ptbVwRmkujgucbu9ei1Qa3qSNG_A@mail.gmail.com>
In-Reply-To: <CAPig+cTh-uu-obh9aeDOV9ptbVwRmkujgucbu9ei1Qa3qSNG_A@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Mon, 24 Feb 2020 16:39:08 +0530
Message-ID: <CA+CkUQ8ZsxesE=d+DQ+67SEHPJXdHjbSKhWeVifPeKBymqy8pw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] get_main_worktree(): allow it to be called in the
 Git directory
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>, johannes.schindelin@gmx.de,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, Feb 24, 2020 at 7:12 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> This title is a bit too generic; it fails to explain what this patch
> is really fixing. Perhaps:
>
>     get_main_worktree: correctly normalize worktree path when in .git dir
>
> or something.
>
> "Git directory" is imprecise. As a reader, I can't tell if this means
> the main worktree into which the project is checked out or the `.git`
> directory itself. Please write it instead as "`.git` directory".
> [...]
> This change makes the code unnecessarily confusing and effectively
> turns the final line into dead code. I would much rather see the three
> cases spelled out explicitly, perhaps like this:
>
>     if (!strbuf_strip_suffix(&worktree_path, "/.git/.") && /* in .git dir */
>         !strbuf_strip_suffix(&worktree_path, "/.git/")) /* in worktree */
>             strbuf_strip_suffix(&worktree_path, "/."); /* in bare repo */

I'll implement these comments in the next revision for sure.

> Also, please add a test to ensure that this behavior doesn't regress
> in the future. You can probably test it via the "git worktree list"
> command, so perhaps add the test to t/t2402-worktree-list.sh.

There already exists tests in "t/t2402-worktree-list.sh" which lists and
verifies all worktrees. Does this make sense to write a new test that
also does kinda the same thing?

Thanks,
Hariom
