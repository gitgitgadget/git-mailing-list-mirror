Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556E9C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 11:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E5D64DBD
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 11:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhCAL6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 06:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbhCAL6k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 06:58:40 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE363C061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 03:58:00 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id a7so17353056iok.12
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 03:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+7xk0eKwupdClrg94gw1/JLwmDPy1pS7gFPQuEvwaY=;
        b=3GHg4A36sdqklLVA19OYV0yQR2JGmPyAJ3dmp8VGBoesNx6iVoV7SZzzPJ3w842LQu
         HKwoEBkTkccPjvh5WwRSHp8iC1X9nvTxyN03TLCYnlRg1xr8SXLQaAiEUF9oZbPybim4
         mJRNS27wLy477jABtI3YFyfXy+UEEs127AC2Gzwmu77plGscDKZTBesQcWFKEfsf7Usd
         9Z6yfkBkq2dz1k2beGqEsJIDjcHsyYXHCAuGUV7m0L6h1y8YkOXNnolGQabWvyt4SE8E
         9B2O3aAft1iVaGXkB05mMO/PhwmhoX4+7jXH1KaIE5fIc5cBYP7gorNWSCe8XxuD57pn
         KnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+7xk0eKwupdClrg94gw1/JLwmDPy1pS7gFPQuEvwaY=;
        b=YgxqS+bHaHB+2iAfc2UeZUkab/dT9IF/PeH75Zo0MXadGQ0E4TKOKQlseeBRbZ+4T1
         WHf6x8kMN83ie3+xGOIVQq839kloMtlgpXalAcON640BRyroJNkx1I4JMTpe1nBAgAp6
         SAKoZd0IFfHaWXbAAwzqrxEI6lxXIGRI45rbeAobNJmbYrv8wDQn/oUG7eySkYxFtB8J
         p1jlrT0xty2ew89VQonEe+lbnrwFz/63zl6M4Yt9TEjarJfE4n+aHOg5Vgd4aba9GumC
         +j7gq+MBAXRaaFOD3XUqf6GZBfkQeH1YgnXOj1eaQa2laO6wnj5nQEloe/eYETA7V9Ur
         SdIw==
X-Gm-Message-State: AOAM530+MeeMKl3g2BTZuhZDXa0AwZV5ajFyA1IZ1JyCnNUmEU3bz/Sz
        OC7Lu2F45PxCknwGY+RnuvAADVrvYZ1cBvzTzq4m/qVD5rkoMx1y
X-Google-Smtp-Source: ABdhPJzcrbP4T7AdvX59FWvfW3WRAnlzGMIBfK6wkRfFCcoxFpOb6Td1SjcA275s0JjogfekNQ/KCwWLzwgmaqEBRI8=
X-Received: by 2002:a02:24a:: with SMTP id 71mr15701670jau.22.1614599880036;
 Mon, 01 Mar 2021 03:58:00 -0800 (PST)
MIME-Version: 1.0
References: <CAFLLRpJgfseK5P8ZJm7iEW1onf7ROVSkyeuPfh1+qoHHjsC8uw@mail.gmail.com>
 <20210226205458.2909811-1-jonathantanmy@google.com>
In-Reply-To: <20210226205458.2909811-1-jonathantanmy@google.com>
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Mon, 1 Mar 2021 11:57:43 +0000
Message-ID: <CAFLLRpLoy6c_WSt1RR2-SPMzKK-MaBpkrCPuGqGGf8SwpCiSEA@mail.gmail.com>
Subject: Re: partial clone: promisor fetch during push (pack-objects)
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, 26 Feb 2021 at 20:55, Jonathan Tan <jonathantanmy@google.com> wrote:
> So the cause is not that we are unnecessarily
> pushing the missing objects, but because they appear in the window when
> we do delta compression (just like you said at the start).

Thanks for persevering :)

>
> > 2. Seems like a bug that check_object() doesn't honour
> > fetch_if_missing and skip the call to prefetch_to_pack().
>
> We do need to fetch if we're trying to pack a missing object. I think
> the real bug here is that we shouldn't prefetch if the to_pack entry has
> preferred_base set (which means that it will not go into the final
> packfile and is just available for delta compression).

That makes sense, I had a feeling it wouldn't be quite as simple as my
suggestion.

>
> > 3. But push doesn't pass --missing= to pack-objects anyway, so that
> > wouldn't actually solve the original issue. Should it?
>
> If we fix the bug I described above, I think it's still OK if push
> doesn't pass --missing=.

I'll have a go at a patch. Any suggestions on how to approach
writing/expanding a test to cover this?

Thanks, Rob :)
