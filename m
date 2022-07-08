Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895E1C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 01:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiGHB4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 21:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiGHB4d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 21:56:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DF773902
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 18:56:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g1so17597994edb.12
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 18:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYR7ooSWZRxE85/CofVEcYKxReLftJs+wrLWTLWWplE=;
        b=hLsW1QD68n+juxQpwYHaYTzg0DBhVU6ugiiHcRhVhhld1XTtirqnaMCoTxJ6+y3hqs
         vJudVqPOr0xZ9cCf/0kefo1cj4mSLP/8j7l4Jijk/4jQIJeRCWWbjLH7Fl1Esxc732vg
         5QacDuP4uySjjlQ2DaVl9V1AvEFvDAz6bQtkcr1Lg1fhnuVOWn4IIn1YZs07MvnrPTmO
         rawyT9zOgUnxeKb9NNiDHnl3xgwItdRwcephrKgWTOFarwAMvox0mUmc9z9Cw5LV8YaB
         //M/WzGX2sn+d6BvsAbjyjs5wwtNxdh7NkYIMq0OpSsL0RR7hWkjjv3nJHogEbDyxign
         AlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYR7ooSWZRxE85/CofVEcYKxReLftJs+wrLWTLWWplE=;
        b=zVl3n83wi5urfOgVErBF1/uZhXxK8jX3cciCbN/RRjCcUCe+mu/VpHR2JKSJ3ZmFyM
         04R1dcPGLhUIko5pnN7wpcvPnxGwKpn6CATLvLls5eIhKeTS2B88x0J7TtvdSMEVFf+I
         GZwWsLLmwirtDEDNdzFtRT5sjpfgnhAQjYpU3NEiuVVF0ACZc95WodEVwH5lLwxaXlca
         fF3S52F06veml9pVqCtfYGHjGwUiZess1GkTjUnnF444X89Ffti9wG0/60DzcDYmK//W
         BpDF6jOQxB0uVtEIJ591aEzkU7go8UCUmUSNwGKqKg+l4YvyoP4+YxznAOBfotDGOi5B
         jp4g==
X-Gm-Message-State: AJIora8uKcpxnSa0kJeOEnNgT1MpEiSRR9MCbbzAfS8LJgQ1IfSlvAEU
        wMMaMPIDQrqXXEaYCRqZM1PQuiv46ERjr4Ql2O97KP/oBBs=
X-Google-Smtp-Source: AGRyM1uF2ssrs/kIeNVbTSHX2l6EsQ+t1u/eBqkoiRNwRRBm9Xtmz+Gyo2PF9SdQCmvCVBoxWCXfKHr4UPwjzUDTJtQ=
X-Received: by 2002:a05:6402:4242:b0:437:7771:982c with SMTP id
 g2-20020a056402424200b004377771982cmr1543477edb.146.1657245390732; Thu, 07
 Jul 2022 18:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR08MB773203CE3206B8DEFB172B2F94839@PH0PR08MB7732.namprd08.prod.outlook.com>
In-Reply-To: <PH0PR08MB773203CE3206B8DEFB172B2F94839@PH0PR08MB7732.namprd08.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Jul 2022 18:56:19 -0700
Message-ID: <CABPp-BH2zuYe87xhjdp5v7M7i+EfEgLHAZgwfzJUAxGk1CFgfA@mail.gmail.com>
Subject: Re: git describe is not returning the expected tag
To:     Florian Pfaff <florian.pfaff@hitachivantara.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the detailed report and simple reproduction steps.  Very cool.

On Wed, Jul 6, 2022 at 11:43 PM Florian Pfaff
<florian.pfaff@hitachivantara.com> wrote:
>
> I am experimenting with git describe as we want to use this in our CI system. However, I am not getting the expected results and neither the git describe documentation nor googling nor stackoverflow have helped me understand why.
>
> The repository
> ==============
>
> git log --oneline --graph
>
> * 9a45651 (HEAD -> main) m c7
> *   b7982a9 merged r3
> |\
> | * 8c2adbe (tag: v3.0.0) r3 c1
> |/
> * 273a50e m c6
> *   6014487 merged r2
> |\
> | * aa906b8 (tag: v2.0.0) r2 c2
> | * 716c189 r2 c1
> |/
> * f0e2c71 m c5
> * d42bc37 m c4
> *   9060516 merged r1
> |\
> | * 619d331 (tag: v1.0.0) r1 c2
> | * 75f90de r1 c1
> * | 372f1fe m c3
> |/
> * a27d5e4 m c2
> * a66cb53 m c1
>
>
> Expected result
> ===============
>
> When running git describe on main I'd expect   v3.0.0-x-d???????

In particular, according to the documentation, this should be named
v3.0.0-2-g9a45651

> Actual result
> =============
>
> What I am getting instead is  v2.0.0-13-g9a45651

Even if you were to delete the v3.0.0 tag, this wouldn't be the
correct answer.  The expected result in that case would be
v2.0.0-5-g9a45651.  So, it finds the wrong tag AND gets the count
wrong.

> More information
> ================
>
> git describe --debug
> ---------------------
>
>         # git describe --debug
>         describe HEAD
>         No exact match on refs or tags, searching to describe
>          annotated         13 v2.0.0
>          annotated         13 v1.0.0
>          annotated         14 v3.0.0

and indeed, here we see that the counts are off for all the tags.  Way
off, even in this simple repository.  The counts should be 5, 11, and
2 rather than 13, 13, and 14.

>         traversed 15 commits
>         v2.0.0-13-g9a45651
>
>
> amount of commits between tag and HEAD
> --------------------------------------
>
>     $ git log --oneline v2.0.0..HEAD | wc -l
>     5
>
>     $ git log --oneline v3.0.0..HEAD | wc -l
>     2

Here you show what the counts should be.

> git version
> -----------
>
>     I have tested 2.36.1 and 2.37.0 both on Ubuntu 20.04.4 LTS both installed from # deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu focal main
>
>
> Script to recreate the repository
> ---------------------------------
>
>     https://gist.github.com/twigs/bb0cbe29af55b8141c19d25de47e0eed

Thanks for the script.  If you add a "sleep 1" after every commit or
merge command, `git describe` happens to return the right output.
Basically, `git describe` is broken.  This appears to have been
discussed previously, see here:
https://lore.kernel.org/git/20191008123156.GG11529@szeder.dev/, but
looks like there was never quite as simple of a testcase as this one.

If anyone's reading this and wants to dig in, and try to fix, feel
free.  I don't have time to dig further.
