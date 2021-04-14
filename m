Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0075DC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 00:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC95613B6
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 00:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348224AbhDNA0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 20:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348215AbhDNA0m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 20:26:42 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613C0C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 17:26:21 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id o16so21401239ljp.3
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 17:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KU/mMfmG5yT6DO+a6a+IX6KhbhXM66rjdsQ5nvPFNeI=;
        b=KE+IOepMTYT8jOScQr1zXAe6bHCgN2nBkS7L6v/Cxvk3bCqWyIGQ2ytYV8TLCJyqGj
         q1j0LlzLVLQwQsHxjoWJ6/Ekonzh41+n9UEqgjiGpPk2U6dv2hmuIoHjgpUMwA4luKnl
         TMvzqhvFJV+auqu1mehYMA2sEbbJxzMNkPrKFm2b2W3PnM6V+f9pJmdZtyT2kPK4Zh5T
         G0rE6w1Cdlevim+8JZieBuuz327o0/DEYavIg9c1p5hZSgl96aqT9GQCjgQ2hbRnmHMa
         tp0uFBlp9dOMwXfYwqTaRk733WVBLnzym5cbWguVoyDnKv9qMEogQOpeZ/JjliqbYAI2
         8AbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KU/mMfmG5yT6DO+a6a+IX6KhbhXM66rjdsQ5nvPFNeI=;
        b=kOuSSl+qy45h03wC7EM2GzxSsk9TPbqTl75xw5qx51dWkL2bEgSsoyJOOklRRBEM0X
         kVyxWgWCpsBxZT6nfH6X/KYv/ANnDo0/VJkene0+O0LyDdx0NRrb3lTf2jJrNwfk2CRT
         bh7BWMx21mnJ+7K5lgNQX/CIIkJTXYKWRYLZAopx9RrCi/z8Hm39FU92QHRWkaVyLDO+
         GMRXfJM4suYJb2M6y2JQSnIX2t9J+0NkUG8vLxR7lF7XHL1SebrwbQ49+u5yMszrUS6W
         GvDWM+Pxijo8tiqI0xw0GEYMfL/G2U5710wRke5zHybSxmfChFvOf+HJh0QcaaqzTe/g
         121g==
X-Gm-Message-State: AOAM530KCjS7Gg7QEC6DdiuzTI+rYIolXGaVtsNxYHMJsrc9iZWXV4vU
        vTLXf5xnO6JYMZeAVFqIIDSYvTIfuKtWRHWvIb0=
X-Google-Smtp-Source: ABdhPJx52LTc6Cr7uMRHses0pnNYnXQiE8Y0RBiMbkwt6O7Mgww6P/15bv5uyBEeMYrZgEoGCRR8lm84uMutoYmLFCw=
X-Received: by 2002:a2e:9710:: with SMTP id r16mr23513087lji.25.1618359973626;
 Tue, 13 Apr 2021 17:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHwnEogvmTZ-VS5GksoGEiyo3EHO+At+xeWa3frXUESD3HicnQ@mail.gmail.com>
In-Reply-To: <CAHwnEogvmTZ-VS5GksoGEiyo3EHO+At+xeWa3frXUESD3HicnQ@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 13 Apr 2021 17:26:02 -0700
Message-ID: <CAPx1GvdeNEyPEZ7GdRKeAevnvjyLmoXHjQP0W6iToDsJPAqDHA@mail.gmail.com>
Subject: Re: `git fetch` not updating 'origin/HEAD' after branch rename
To:     Sam Bostock <sam.bostock@shopify.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 5:18 PM Sam Bostock <sam.bostock@shopify.com> wrote:
> Long story short, it seems to me that `git fetch` should update
> "refs/remotes/origin/HEAD" when the upstream HEAD changes, but it
> doesn't.

It's never been the *intent* to have `git fetch` update
the corresponding remote-tracking `HEAD` ref.  To make
that happen, you must run `git remote`:

    git remote set-head origin -a

for instance.

I have, however, often thought that this is the wrong
*default* way for things to work, and that at least by default,
`git fetch origin` should update `origin/HEAD` if the
fetch result indicates that it should.  See also Junio's
reply.  I think a configuration knob (similar to `fetch.prune`)
would be reasonable here.  Users could then be encouraged
to set `fetch.prune` to `true`, and `fetch.update-remote-HEAD`
(or whatever) to `true` as well.

Chris
