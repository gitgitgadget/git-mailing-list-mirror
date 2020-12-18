Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA766C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7F423B70
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 16:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgLRQRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgLRQRI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 11:17:08 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF853C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 08:16:27 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b2so2925815edm.3
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 08:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ileKvvLXY3kAWxUgFg+PFoUeiyO2HAzxRfKMfiakweo=;
        b=NYuQL2J9iiGPLITOVymQO2NcOVt3uK/iTsydAgszcIIZ+h1zY1Bwlk0c+gg9SYEyZ1
         +9tE6AWi6mpvMEvWTdliSiMuWqGdlkPuhQfBXNbHMUux3nAYYgz3gyFTqCT/jpT+ofPn
         WItUuGV9QgVf1YLfOpo5/ynvSC0gI+yAWeevm93fp+7aGUSRve1bREfaz3Db19CL0xpz
         xSub4Pbnh/4EcLte8XXqfLz78yg4+vsy8NkhHUiaX+CFS0XUvqlenTup5Uv6t4t25X8h
         qIwwjHNcUfOxWwstlHLxyoRIYREyjVVDepucGiXdmgrPIpwRqVB9kPzD9FhASFfZVJaL
         R2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ileKvvLXY3kAWxUgFg+PFoUeiyO2HAzxRfKMfiakweo=;
        b=hShU1BKs84U2gYfSQsQJO0VkYtGFihx+zih5hyy3OC6QE037p3H94vKJui724eoo5T
         BVR9BrDgMGcsmZnAOhFAq/WupN4GIgw80c1VuvIqQFMx9wf63LvaGK2vVM5KyVlB3oYO
         AYdxN7priBi2A/eHiMLQdiJwDPcMlFwr5H9pNMI103v44NwnroUpJ2MoXxwC25L4nvq1
         qD4bb6tYBl/fxk9xuPkf/dhjakHx16HcXMyBGbaMN9JjaqofFEIxTpk+Eq2IiVpnmDSe
         3nqs5NP1qUQmkeWqSJNnFFzSwGUAR9gSL5XREKDzhZr4rR/DChm/jzKgmn5W4xQ6ICfA
         8JWw==
X-Gm-Message-State: AOAM533Q8KXli2SElxYTmmQqq2HiMeKibPnSiFE11KP4BNBdVoyiPDA/
        q81GIBjfP66LVD26NF/E1zYh3XyKQ9ZpuJa2IRD4SKS0zkdsXA==
X-Google-Smtp-Source: ABdhPJxQ046jhyxR0soyZhpl7TSUxlI+b3hQFm6jvYUyJxiv6U8NSL4/gRTV5gCu2ywx4K1qB6xDZUT+ZMAdajzYsoA=
X-Received: by 2002:a05:6402:318f:: with SMTP id di15mr5126852edb.237.1608308186477;
 Fri, 18 Dec 2020 08:16:26 -0800 (PST)
MIME-Version: 1.0
References: <PH0PR11MB48875130A7DF30A7394DD3619DC30@PH0PR11MB4887.namprd11.prod.outlook.com>
 <5fdccc25255b7_1273af2086c@natae.notmuch>
In-Reply-To: <5fdccc25255b7_1273af2086c@natae.notmuch>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 18 Dec 2020 17:16:15 +0100
Message-ID: <CAP8UFD1XMA7y6qXXS8h2HZXTuC8nGVkxTiMG3ZA54XJJg=gAsQ@mail.gmail.com>
Subject: Re: Feature request: 'git bisect run' option to redundantly check
 start and end commits
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Ed Avis <ed.avis@qmaw.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 4:39 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Ed Avis wrote:
> > When kicking off a 'git bisect run', I have manually chosen good and
> > bad commits, but I would like to double check that the command given
> > to run really does succeed for the good commit and fail for the bad
> > one.  Of course I can switch to those commits and run it manually, but
> > mistakes can happen.  It's frustrating to set up a bisection and then
> > find at the end that the first bad commit is the one immediately after
> > 'good', because the command string just failed every time.  An
> > optional startup check of the two endpoints would only be a small
> > slowdown in most cases, but could save a lot of time.
>
> I like this idea.

I like this idea too.

> I for one have to think twice if I should do the extra check manually or
> not, and the biggest reason why I usually don't is because it would not
> be automated.
>
> With an option like that I would have no excuse.
>
> Here's a quick patch to implement such feature (it doesn't apply
> directly, it's mostly for human eyes).

There has been a lot of work over the years to port code from shell in
git-bisect.sh to C in builtin/bisect--helper.c. So it would be nice,
if you plan to implement this feature, if you could do it directly in
builtin/bisect--helper.c.

Thanks,
Christian.
