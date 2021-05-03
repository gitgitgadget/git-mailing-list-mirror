Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85943C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 13:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CE46115B
	for <git@archiver.kernel.org>; Mon,  3 May 2021 13:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhECNg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 09:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbhECNgz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 09:36:55 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9EDC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 06:36:01 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z14so4055594ioc.12
        for <git@vger.kernel.org>; Mon, 03 May 2021 06:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yK1p0cOUEubAeFQYxksorE9rR7QQIfAaQslPK4649HE=;
        b=a6LMa9g448jy/EM0srx1wxsZuGBPzLAb0C9NPThcADV2mSTRarrpnOCsKrG9/oErlu
         l5vuxO3eCBZ3x+xPARbk8s1D0fJIXjFHUBCMEpuQciQCMrLiDLeQ8b+BODgGgO9GYX75
         Hp8R5H6sZ1HJeIgk3GQkBxnNWlBRJCvYFamnQIc3eukLQJypAhBdPRWE+RBnx80EJdrs
         QfL5ETBUDNVaxmY28tWXvH7urRdDpThtUyWS4lt/UUBKts32g7a/0qw9sg10epvUjqov
         Dn8lm+sAclnhG1LVE5dbkqmryKGVKsFRp+BBkmQBjcOGg1FzgMbwXWkSsfNZmYWFHVm/
         Zs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yK1p0cOUEubAeFQYxksorE9rR7QQIfAaQslPK4649HE=;
        b=FUTVq1HumgjMHT7vvOti17iQOtW6tbSs+S0tqyeA1JtE/LwuDjLgUufjmcRPmW0Z5z
         3DqOjPUILXgwB4rdPChidsNaeE7ctXHlZd9qYcm629bEGiTNewWOW5d/xPciCVPARgyS
         /VSZFjzQHsUq6P7e51OsS6a4Seb0byTBd+J1JkVmf7PfC9N6GDhrRxFRDiiD8ATy0B3s
         irRYifJ8mTXy89Mk8JzyUe/xbK8dSMlyASWo9GT+nnz5wLdZ+LQpOWWfPiQJMzYH8+l8
         iR/uhcylOHPYD0JVUNnEiaMC7CAN3FzUTjHmH23hcmonDcMb5ax6L8logmTX06qOVrnk
         2zFQ==
X-Gm-Message-State: AOAM533Y1lcEtU1TmK5IXcDtJfG+E42STo245RVVwPsJJPD3g1csmgh5
        EK1+Tv7SaRGVCRiXRXGpcBbl2GEnr5mLl8Z/VbSaKar63pAzI39XW7C3iw==
X-Google-Smtp-Source: ABdhPJzBhlUS2ZbQ0/P0vFB1XIRblpHVO3jjlQ831V7Ufx/6rehN36KSHiT+tw0me7lt6VYoROIBvs3WA1SplsPgfJ4=
X-Received: by 2002:a02:84a5:: with SMTP id f34mr18761043jai.50.1620048961019;
 Mon, 03 May 2021 06:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqr1itfo41.fsf@gitster.g> <CAOLTT8TWLUCOnL=s-SgCaJYbOw7YCyX5WNssZw5HCspaSAoxmw@mail.gmail.com>
 <xmqq1raobncr.fsf@gitster.g>
In-Reply-To: <xmqq1raobncr.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 3 May 2021 21:35:45 +0800
Message-ID: <CAOLTT8SDb0sUfOYTBwvNQgdp9sOzOokxmPzXaCaB2ALbsYkHig@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2021, #06; Thu, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Here is a small typo error, I forget a small blank, which was pointed
> > out by Josh
> > Soref in https://github.com/gitgitgadget/git/pull/939
> >
> > - '%ch':: committer date, human style(like the `--date=human` option of
> > + '%ch':: committer date, human style (like the `--date=human` option of
>
> Please update it with an incremental patch as the topic has been
> merged to 'next' a few days ago already.
>

OK, I will resubmit it.

> > I have a little doubt here. Do I need to modify the "Commit-Count"
> > example in the docs immediately? I thought this should be left to
> > the next step?
> >
> > If necessary, I will make changes immediately.
>
> We've done the "after waiting" part already, so I should have
> updated the topic summary for this one.
>
> I just re-read the second patch and the count example that leaves an
> empty "commit-count:" does look strange.  We probably want to update
> it before the topic hits 'next'.  While at it, you might want to add
> the "Helped-by: " example we discussed.
>
> The phrase "global script" looks strange---just call it "script"
> would be much easier to understand, as things that are in ~/bin do
> not sound "global" to everybody (it is effective across
> repositories, so is a bit wider than per-repository, but it is of
> course not visible to other users).
>
> Thanks.

I know what I should do now.

Thanks.
--
ZheNing Hu
