Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE8EC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CD3206F4
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="z+/JqxOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgFJSPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgFJSPK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 14:15:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E77C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 11:15:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n23so3675406ljh.7
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LgFhgXwwz1vbufStyXnu/vPGzt9rRyZxjnJhrqr/2oI=;
        b=z+/JqxOqfpfFfcJdEN+P7ZYQAF1aghtVUW97CgpEi4qOTnprnfOzrOHhGkVKV52Seg
         3evjPcxlzJ5W1tXTX9msHblsRUDU+nGTzj0zxMQixwSGAAH0XkQEAFSAZSy5/5reBcRU
         4j4YUQGtFCRwbDdvyaraJQJSXZ6d8KknsZzn01EGGhZY7/BzjyLq44Vszh3OUzvFjfdC
         Co7K4m0I+tQHZo8hdHQGGUEWbuIHPWJYV8VbvtCT1jW1kUbZ/2UwCavNcVkCGF5eEqjt
         h2cR9pJ3CVAoLcbn9wKa+IDdWxHdpTlyv90khwPAeSZF3E9vIzRp5ePKXLVHpD3iG7VI
         dWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgFhgXwwz1vbufStyXnu/vPGzt9rRyZxjnJhrqr/2oI=;
        b=etuZlH2+EzFCBMlFvAQ1dJ94CZM80tKPXVyx4ALRDFJZOwS2hRyj5AZkXCKnb4E/f+
         I3GF/8WxeXTzxXErJCJlnAnZxFpK+MeJSc56r/bRRXrGtxiaF7vwjO05zMV9R7aMFEsm
         ZYaQrnSVmCeSsmbeo6N7zgc1XdJF2MSVbnL+xsEfHC+Cts6J3k90kbDZayFu/kaWshNq
         69NC8OqqY8fdMr2QAQchOkz7ajm0JC7hODOd2Ie/Rw2Fy1DwVOJqHhocyNV/WyXla4Qi
         VMrS2N7Ol5IawxAIAIHUz24UmB/wAiqmTvK2A6qPWOXWm+s0R+wm96wtk/J8VRS6PVOq
         i3vQ==
X-Gm-Message-State: AOAM5312LDO3YOBPBq+hMF1HF8VWJQz4SHB6Dg1Gdrj5iAPxJat7vbys
        dbKhSdH0KRsaiQpbTOqaV1s3L7hcM0cdlruXgt1u1A==
X-Google-Smtp-Source: ABdhPJxdrsANnVvI6jp3WhvoL0WRIFreM56MmGUCEaAHcIwQc8hX9NNjaVNJz40153Q/4yBvkq5jRxwqk6HXCDIsIWQ=
X-Received: by 2002:a2e:1558:: with SMTP id 24mr2377825ljv.202.1591812908160;
 Wed, 10 Jun 2020 11:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7_6+Jv+SQG3qh8eRjwJmqnRJKs=_bAV3WaC4-SKkoywg@mail.gmail.com>
 <20200522142611.1217757-1-newren@gmail.com> <562542d2-2a90-8683-a7fa-cbffb2e26bff@gmail.com>
 <CAHd-oW7BXWzaWsvsh0dQt7NgeBcz0HSbcwKVYA7sPjUinarsng@mail.gmail.com> <909e19aa-9d96-a68a-eed0-d721948b9dbc@gmail.com>
In-Reply-To: <909e19aa-9d96-a68a-eed0-d721948b9dbc@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 10 Jun 2020 15:14:56 -0300
Message-ID: <CAHd-oW4OKw2Eff10LodnQfuYxm0o=QHLL8eyQUZ06B8xiK8sgg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 2:42 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/10/2020 12:22 PM, Matheus Tavares Bernardino wrote:
> > On Wed, Jun 10, 2020 at 8:41 AM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 5/22/2020 10:26 AM, Elijah Newren wrote:
> >>> +This may mean that even if your sparsity patterns include or exclude
> >>> +submodules, until you manually initialize or deinitialize them, commands
> >>> +like grep that work on tracked files in the working copy will ignore "not
> >>> +yet initialized" submodules and pay attention to "left behind" ones.
> >>
> >> I don't think that "left behind" is a good phrase here. It feels like
> >> they've been _dropped_ instead of _persisted despite sparse-checkout
> >> changes_.
> >>
> >> Perhaps:
> >>
> >>   commands like `git grep` that work on tracked files in the working copy
> >>   will pay attention only to initialized submodules, regardless of the
> >>   sparse-checkout definition.
> >
> > Hmm, I'm a little confused by the "regardless of the sparse-checkout
> > definition". The plan we discussed for grep was to not recurse into
> > submodules if they have the SKIP_WORKTREE bit set [1], wasn't it?
> >
> > [1]: https://lore.kernel.org/git/CABPp-BE6M9ATDYuQh8f_r3S00dM2Cv9vM3T5j5W_odbVzhC-5A@mail.gmail.com/
>
> Thanks for correcting my misunderstanding. By introducing
> `git grep` into this documentation, I have also made it
> co-dependent on your series. Instead, Elijah was probably
> purposeful in his use of "grep" over "git grep".

I think he used grep referring to git-grep as he mentioned "tracked
files in the working copy". Maybe he wanted to describe the current
state of git-grep, which does recurse into initialized submodules even
when they don't match the sparsity patterns. Was that it, Elijah?

If so, since this behavior is changed in mt/grep-sparse-checkout, I
think I should also change this doc section within my series. Or we
change the doc in this patch and make it dependent on the series.
