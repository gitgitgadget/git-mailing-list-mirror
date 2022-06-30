Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83573C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 16:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiF3Q4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 12:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiF3Q4F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 12:56:05 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397193B28A
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 09:56:05 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id d5so34810060yba.5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoq0TZiTHxhK8bqGbURgIar9H62CklVxyfNkrdcxSHQ=;
        b=BHHHijLFk8CdU2zMJtykQRxiPRoH8xlHFj9KDomvxnFJwW7BjfYHeJK3sHsAmfs6PE
         ivbBdK40su0VZF03UB2Z7Zh9AsT85dsDlwIipTWRfuxx2+Nx/BifNdkUZNYD2UvLtP60
         gHkyaTCBJqfbGhrtuFaSgLScM3gu2QPwVPnNrDCNN9mLaeYY7KH+p6OtdDwCSqv4fvGd
         LWVSypzxk/+ra4qsFPADKSaZlZmH/yQUyI2eaz+B+T8zmR1rzaWhFF6Y8+N+cEs21G2T
         ZC9Mhx9XWNmXidmgfg2EwfqTROJvHDCK49wIl7b8gwwJY+jZRfPK2Xzuy9gebjRG+G6c
         q10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoq0TZiTHxhK8bqGbURgIar9H62CklVxyfNkrdcxSHQ=;
        b=POieaz1dG/m963emJN9jWo3sCWEw6VhDmgQd4ULhGoo5uGmS5fD7Y08HqFP7T7R0Rz
         xzk2/gcZIWMdT6/Swuvp8LFTBVh4Eb7Gf7DxT5ni5L0gkp2WzSMtKQTLm9xF+p9dM6qo
         vziU1162kY91zQAU4eJ1Abez5BhwX8iEzwDwpwehjaxnvtPXl6ajJ/uflBbwIiFTgLLH
         P1Xx616jjF2Vtj7921n7PXD7AdToMimk93o3TCIJLToElrOYSR8T2vJ6lnMx+MJsYeOq
         EZ642+qqGUl2YUJffzhwc49lin2kY/9GpJrszj3A910bEnoz9gDTM91/VyhFoeTiIWAL
         5ZpQ==
X-Gm-Message-State: AJIora+85vFRhu7mNGdfY7ac2fR+kjZPVcpzgQlVEd1mfKBX2LjgQf76
        lSZYV5+zfmGtyxdUHL8txiWU5NugPgQYzmaBht3SI3QGS0M=
X-Google-Smtp-Source: AGRyM1tdNDynsQZGJBugWmsDdTMTXj3Z5WIozH08raZq4LkjIBdcll6A2e7EBhtDgadm3MEY2T5IdFr0cCjB214oRpk=
X-Received: by 2002:a25:b9c7:0:b0:66c:e02d:9749 with SMTP id
 y7-20020a25b9c7000000b0066ce02d9749mr10815691ybj.494.1656608164379; Thu, 30
 Jun 2022 09:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220630142444.651948-3-siddharthasthana31@gmail.com> <ad7fff11-5ab2-d314-5e12-bdf61b854aa6@gmail.com>
In-Reply-To: <ad7fff11-5ab2-d314-5e12-bdf61b854aa6@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 30 Jun 2022 18:55:53 +0200
Message-ID: <CAP8UFD0AjU3_6URpVYafYTxYSTPeX2zw-PLwL1b5rTiQY5EvUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ident: rename commit_rewrite_person() to rewrite_ident_line()
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, Jun 30, 2022 at 5:33 PM Phillip Wood <phillip.wood123@gmail.com> wrote:

> On 30/06/2022 15:24, Siddharth Asthana wrote:
> > We will be using commit_rewrite_person() in git-cat-file to rewrite
> > ident line in commit/tag object buffers.

s/line/lines/

> > Following are the reason for renaming commit_rewrite_person():
> > - the function can be used not only on a commit buffer, but also on a
> >    tag object buffer, so having "commit" in its name is misleading.
> > - the function works on the ident line in the commit/tag object buffers,
> >    just like "split_ident_line()". Since these functions are related they
> >    should have similar terms for uniformity.
>
> I'm afraid I'm not sure about this change as the interface for
> split_ident_line() and commit_rewrite_person() are not uniform.
> split_ident_line() takes a pointer to the beginning of the name in an
> ident line and a length. commit_rewrite_person() takes the whole commit
> buffer and searches for the ident line based on the argument "what". I
> agree that having commit in the name of the function is confusing when
> it can be used for a tag, but having line in the name when it takes a
> whole buffer is also confusing.

It takes a whole buffer but it rewrites only ident lines, so maybe
"rewrite_ident_lines()" (so with "lines" instead of "line").

> Maybe buffer_rewrite_person() or
> something like that would be clearer?

I don't think "person" is better than "ident" for this, and I think
it's better to use the same name for it in split_ident_line() and the
function we are renaming.

It's true that we are not rewriting the date, so maybe
"rewrite_person_in_ident_lines()".

Thanks,
Christian.
