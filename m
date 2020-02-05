Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF029C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E44F2082E
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLBHQxtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBEWiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:38:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38687 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgBEWiV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:38:21 -0500
Received: by mail-ot1-f65.google.com with SMTP id z9so3626052oth.5
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pALK4UjT1zThXGdslm5K1jwS32K3zPQtj4Tg0MLPOCI=;
        b=fLBHQxtT0BNy1Jd0tOoGD8zIuItzKxeLu0WYW5SBxdqXgEZVevIFl9L7uR6AFVavjg
         eCjjtBgvM8EEq7FGoWWzvSX3WnJUmxvJY6qXjxatvOkkbWiC6ALka/EDFZcv8WLa/Cg1
         igAhi5SGAsAPWlBu/t2I1WC+oLPF0QTUg5ERS8eRAhxSXe/9UuCi0fuPVQbklRfc/BlU
         MlJOEg5Ht1r+Fq0LScsd9jjwK+8mGGtuZJuIEU9IUetfvw5pkcAJbKkH1pPxyocZO2uY
         83hglaLmoaEqkkhulHYxwhp7OL/Syrk5L56LjuG/Jn1RVFple02OBVFEpu0oPNW8lJTM
         Fq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pALK4UjT1zThXGdslm5K1jwS32K3zPQtj4Tg0MLPOCI=;
        b=PzGrh2ll1dgq04Ld7DqZk3Vsp+Tj2sWNBJSsDkXiOF2CiJ95FPCL2bA7iJgf5gOPr/
         pYgnvqaelXmWxhAtEPJwPaynW0l8YvjXEFcG7XUwPdVBR7QYH06nvifiVCUfzBgjoj2t
         BXhaGYibOyu4+OHNSWsdZbFI6o10V88xGKY4GAwhGKVGRdytumVRC4l6WdYZkIL3BH+t
         74/X9yWelaOlVHkPsinRcM3vIbomyIPv3s8lw2p8XGJ56AHURDOUWiZcGOsEK5YRKf7A
         /KDUNY56r8XVIgPtHPJQRg2Ei7Da5RNfBSowPm7FgQfysE/hXV6bDwSTNGAtkOtzKB62
         65Hw==
X-Gm-Message-State: APjAAAUnJSvs6p+7mBi0xG9d74PtzTNoUK3Nqi28s+MspGnh6u0fwtXA
        RDfKbIR6XV1KIgbW4hyRNV2oNVpQ2qcB6mhJ+5Y=
X-Google-Smtp-Source: APXvYqyHgMa2UUwFoUxjR+XOJkES1MBiYGfyeiqqdqJR6BvNmaR3+7zPcWNseBeZRbRcUVJnlSRs8RA+oKrfy5E3jRI=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr27042327otq.112.1580942298440;
 Wed, 05 Feb 2020 14:38:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com> <47e7c9e6-7d83-185d-792d-f8e084c1a7a1@gmail.com>
 <xmqqa75w68wd.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa75w68wd.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Feb 2020 14:38:07 -0800
Message-ID: <CABPp-BHONuRyt8VJqRuoCF2rGYZ5EhH9KJXQZ3NO69rYwA5J3g@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] rebase: make the default backend configurable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 5, 2020 at 1:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> Changes possibly missing from this version, for discussion:
> >>
> >>   * I did not remove the --am option as suggested by Phillip, since Junio and
> >>     Phillip were still discussing whether it is wanted/needed.
> >>   * I did not address the last two items Jonathan brought up as I
> >>     couldn't find enough information to reproduce or understand the problems.
> >
> > I think I've got a fix for the failure with
> > --committer-date-is-author-date that Jonathan reported which I'll post
> > next week - the bug was not in this series, it was just exposed by
> > it. I'll try and read through this series next week as well.
> >
> > Best Wishes
>
> Thanks.
>
> As to the "--am" option, I do not care too deeply about it anymore,
> so if there is nothing else that we need to further polish, should
> we move this forward to 'next' soonish?

I was hoping to hear back from Phillip, as he always provides great
comments.  I believe I've addressed all his comments up through v3,
but he hasn't had time in the last 2.5 weeks to review v4.

There was also an issue surrounding post-commit hooks that I think
Jonathan and/or Emily were looking in to.  I haven't heard from them
in a while, but I didn't think the issue was a blocker either.  If it
is, I can try to help push something along.

So, the current state is that there's nothing left for me to polish
that I know of.  If others know of things I've missed or want to
review v4 and point out changes I should make, I'm happy to make them.
