Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B36C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 12:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245330AbiFJM6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 08:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbiFJM6s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 08:58:48 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2241912DA
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 05:58:46 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id y188so17397696ybe.11
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/MfmhSzYgVtphjiB5FkIWCNGX0Mi9eHzNUD0yjrgpk=;
        b=FV17+k00eJXmSoQF5JhaV+p5LFnqvn6jwAHmG2gt8VRcvl+TdyzqlMnxZ1ZCIMiZ1e
         uqPR94jZl5JbpyXJ7Ue0n6Rl/tYiP+U9yDi4KNi3KBkb0cQ42C4qkPRpzeVzEzYrj1at
         VSFgvIlCYT/7UHAleQkxZBM+vEZFdmE8rdMczm72YuG3xmvSoRys157rEiXc49IpdQsr
         Z1QXPDd/rmkh3g0UVdcHsyw2HVeSSoqINe//6u36mutQ6jSydj0u8W76wAuxVDMoQQiw
         T07c7G/EX2QsCIRSva+oArYCMdZL0PQiSxvFTTzRuSZ1ozpyg/FR9rTkG+RN68oaLbum
         WKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/MfmhSzYgVtphjiB5FkIWCNGX0Mi9eHzNUD0yjrgpk=;
        b=sgaYfNBaRgicPr9byHID6rsjm64GYnmUNX5M1qx6P8DMiOvAnCLH6ZasbhjWLQXxhV
         J3QEQQcEet1i3FhywxK98KpA/8qsnjZK62EiaZiNeIDeWVD3kES9hKQPVSkHljkLRGmz
         ipE5J3li0Uy0buJtQaPUjted20zqxYz2Uq6hQAcoV8jGNkT8ii+qk88OCUVbelHLWDRH
         05478jZxwQcQ3H3RAuet5glYaD3pXb1CvxOl9IaUSYoPWz9SelINlFPbRzLEr9CYAN42
         trNW6bnpPPn+525Udr9QWtm4Q0xTetP1J714LYR3+M6YmaaDYva4Aato82ZnaxKNq+eB
         BM6Q==
X-Gm-Message-State: AOAM531cOXwh5Mc0fZyWCA9CL2ktyO+B25N8BbtyYm0BoYtQ3q8XrQ8Y
        qQrEynvKWaGX5478Scl2iVaJb/ams+6W1SJE/PSXjyvTumE=
X-Google-Smtp-Source: ABdhPJyBxvH0d3JTJtvbX0tS3kfa7UkEyDNAtfo572hMuogh2Zha3O6t7Kb9fJ31wTjND3Uwtl8UORi/TqnEBkQzk7k=
X-Received: by 2002:a25:2207:0:b0:65f:2b5b:75a8 with SMTP id
 i7-20020a252207000000b0065f2b5b75a8mr48669755ybi.377.1654865925333; Fri, 10
 Jun 2022 05:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <CANteD_zD9ViBi5woHycU_CR1rJcv7YjKDFDiKTA8de04yrTs5Q@mail.gmail.com>
 <20220527195545.33984-1-git.jonathan.bressat@gmail.com> <82beb916d9c44a069f30ec4ff261e3be@SAMBXP02.univ-lyon1.fr>
 <88e41596-d369-958f-f75c-c0b2cd86c2b5@univ-lyon1.fr>
In-Reply-To: <88e41596-d369-958f-f75c-c0b2cd86c2b5@univ-lyon1.fr>
From:   Guillaume Cogoni <cogoni.guillaume@gmail.com>
Date:   Fri, 10 Jun 2022 14:58:41 +0200
Message-ID: <CAA0Qn1vtPy8GhO-vON9YFPZoN0s2EwwLn3LUUNs1e3N1i5KyBA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] error message now advice to use the new option
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     Jonathan Bressat <git.jonathan.bressat@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>,
        BRESSAT JONATHAN p1802864 <jonathan.bressat@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Thanks for your reviews.
We will take in consideration what you say for the next version.

Sincerely,
Guillaume COGONI and Jonathan BRESSAT

On Sat, Jun 4, 2022 at 4:57 PM Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> wrote:
>
> On 5/27/22 21:55, Jonathan Bressat wrote:
>  > Subject: Re: [PATCH v2 4/4] error message now advice to use the new
> option
>
> Commit messages are usually written with imperative tone. The "now"
> doesn't add information, the reader can guess that the commit message
> describes the new behavior.
>
> "suggest --overwrite-same-content in error message when appropriate" ?
>
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -760,6 +760,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
> >                                      &new_branch_info->commit->object.oid :
> >                                      &new_branch_info->oid, NULL);
> >               topts.preserve_ignored = !opts->overwrite_ignore;
> > +             topts.overwrite_same_content = 0;/* FIXME: opts->overwrite_same_content */
>
> Why not use opts->overwrite_same_content in the code rather than saying
> you should in a comment?
>
> Actually, doesn't this hunk belong to the previous commit?
>
> The rest of the patch looks good to me.
>
> --
> Matthieu Moy
> https://matthieu-moy.fr/
