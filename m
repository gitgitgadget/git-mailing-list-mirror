Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F100C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 19:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF0260F38
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 19:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhHPT5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 15:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhHPT5u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 15:57:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D42C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 12:57:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y6so12260749lje.2
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 12:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8Im+kczRwnT1L8Wca9nsjelXl8j/joSSkeamIej/gw=;
        b=DvSFpDgehfsc/qGDP+qTNpOGSdf5rgXBgE7PpCG0HAhZD0/jRjP0kiO6hqsSce9neJ
         VEqGd4bbl9Kk29FgVODi0KkxKluDs+aI4t7v36/15tydhu/gi0/6njCASC4awRa6DCyr
         EkiycFblPOHeHCVfXRlALU3GU+xkXN3TxPgzDWz6Z7+mxy9iJcpzMbDLTmIhK8F76kWM
         NNSjLPaTAL+28+VY6MfIQun6CD5pwo9yAbH4FgjrwCQLlbcxkgPU+BVQIixh/EBfT8V6
         o5Lb4bHSHu+wDfb5VmkfZWz2nb/C+QNtQiVpczhEc7mLz1DpexICgCiAMErWylNGEh4E
         H+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8Im+kczRwnT1L8Wca9nsjelXl8j/joSSkeamIej/gw=;
        b=rN9cHUHC4bS+lIfCImy87iqQSvZiIxSBxxm2JGOU+k+kOWEnu5TAwf9K/MSTruhmgA
         G0JMi1rUMFVUCd23fwRZUYq8Clggr/4iKqKo0lwZXIZUVkm1LgpPelvu5TLCbGV7OoNs
         3R+g3HdJtf4fjqem67pIXNfaob5Cy0BmMcpw19rUmGHjnydsGqAkGQbx5tJMiH9vyLes
         pSqFvaXXbJbfNz/RArU3bAmP2A+kBVzWJ4Ryhq/WagsliaeFquBdmkKKfhtUmkR3wcwv
         wFmJyJMJUNGW2aVKKpIlPAhpFziQn/YtpZO04rbw3klJbkJMhKZoDI0Gv0IXSpTzd3ZW
         W7Ow==
X-Gm-Message-State: AOAM530qbPzS7Tdth43U5kWHAQa6/WAJ6MoOZ7JfPTeNCi+11RgmoJQS
        WaNDydWQzm46ySi4ewYCjR+aOV+KCpWznFm5BELaVQ==
X-Google-Smtp-Source: ABdhPJz/+jRfezP4fU9f0+3I0EDXwAiADCktRAK/IG3jMV/Wed44VP4UXgEQhH9pH94ldI/Fl5i+JGq+KVanJ/yKA90=
X-Received: by 2002:a2e:a591:: with SMTP id m17mr240310ljp.113.1629143836785;
 Mon, 16 Aug 2021 12:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
 <cover.1628888668.git.jonathantanmy@google.com> <94db10a4e5943d689113693c64633ddffa5508cc.1628888668.git.jonathantanmy@google.com>
 <CAHd-oW7nv-Y_QmhA2gcX5GoWxus88inmbcXQ5kPiSRLBdhtoUw@mail.gmail.com>
In-Reply-To: <CAHd-oW7nv-Y_QmhA2gcX5GoWxus88inmbcXQ5kPiSRLBdhtoUw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 16 Aug 2021 16:57:05 -0300
Message-ID: <CAHd-oW6o2nSd15NPE3H8zjTtTehVWLsxF6oR5cjYw8uKUEVhUQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] submodule-config: pass repo upon blob config read
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 11:32 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Fri, Aug 13, 2021 at 6:05 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > When reading the config of a submodule, if reading from a blob, read
> > using an explicitly specified repository instead of by adding the
> > submodule's ODB as an alternate and then reading an object from
> > the_repository.
>
> Great!
>
> At first, I thought this would also allow us to remove another
> NEEDSWORK comment in grep_submodule(), together with a lock
> protection:
>
> /*
>  * NEEDSWORK: repo_read_gitmodules() might call
>  * add_to_alternates_memory() via config_from_gitmodules(). This
>  * operation causes a race condition with concurrent object readings
>  * performed by the worker threads. That's why we need obj_read_lock()
>  * here. It should be removed once it's no longer necessary to add the
>  * subrepo's odbs to the in-memory alternates list.
>  */
> obj_read_lock();
> repo_read_gitmodules(subrepo, 0);
>
> Back when I wrote this comment, my conclusion was that the alternates
> mechanics were the only thread-unsafe object-reading operations in
> repo_read_gitmodules()'s call chains. So once the add-to-alternates
> mechanics were gone, we could also remove the lock.
>
> But with further inspection now, I see that this is not really the
> case. For example, we have a few global variables in packfile.c
> collecting some statistics (pack_mmap_calls, pack_open_windows, etc.)
> which are updated on obj readings from both the_repository *and*
> submodules.

Sorry, this is incorrect. I forgot that repo_read_object_file() (which
is part of repo_read_gitmodules()'s call chain) also acquires the
obj_read_mutex before accessing those global variables. So the
NEEDSWORK might be right.

Nevertheless, I think it might be better to look into
repo_read_gitmodules() more carefully before removing this lock. And
this is something for another series. Sorry about the noise.
