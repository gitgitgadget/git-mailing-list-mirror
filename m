Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57E9C33CA1
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 00:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94412070E
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 00:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/tLxDrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgAIAz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 19:55:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42674 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgAIAz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 19:55:58 -0500
Received: by mail-oi1-f193.google.com with SMTP id 18so4417872oin.9
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 16:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NU/JAUuQcU6xlxp5zyouspMtDCIQm4wGnikaf5Keo/4=;
        b=e/tLxDrruMDxFjTRwJ+Vd43qdGqoYvbxex2cuxLuLN/mlS7E94NeLYavGrAypz0NbD
         VNgUJ+vzjwrfiBUptLGdKkTeWN/2qJ76dP+1fQtzTzgvfVzA2teUVenO3MgTwWUlT/7z
         ZLlFRU3IHmwf++nHobF4qdRzdT9xK+cD3J+T4iAlKNyyvcJOnphNE2GfrDgScXhiOv7a
         5dlUzLfaNIrx5jjaIVNxDrNJmPdCyrBauaQctWK2z5buphACz9o6su61oOO2CDu5l1IJ
         WhGMxokIVHRHF6ttNnw8mYgPCEG0Edo6+Y6X7hqbIQuQuVeyvKITfVRx3xFBmtw+VJ5m
         DQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NU/JAUuQcU6xlxp5zyouspMtDCIQm4wGnikaf5Keo/4=;
        b=MWohkxyQMd5uw8XRGRo4l6fYn65Ox5EAusrHzwV6aqfsoOglbAOjgDOITwIG+9ICkZ
         TEI0spo7fkTE52rVtyB4W8JZcwL9juhUMcuFpU8838ZLwLrVV/4APpPmjaeUP4YgV/xz
         Cq8iFcsUjS+QvgjA5ahtGCIafMVynm0OS44pwbrCbhjoq/wneT514JTJqy2qeP8nc38R
         HkZZicTLYfpfx+KGA8vdu/3wZjuVCPYRYSgHQKDJxFJsCjACWigOIl7/9+5MOFS1BdIg
         EPOF+04v/H3VE6ituQRjtZv0X0Vewhe25L9EtF9EnGDzrSJpNEq/r2qL5d9S4KEfrJYW
         XGNw==
X-Gm-Message-State: APjAAAVooBtPgraopai7yi//rGBhd2GO+cpvmnmJ5vM7YB4eV4InTHaW
        Ah6EeMjF+qjSbS97O/zBkcJI2uKNyUpUiG0FPWWc8n34
X-Google-Smtp-Source: APXvYqzUp6koeMRGi3mjCGyatJu4goLjOIoj7coYSf1Pcz/3HrKFZy4PhA70sPIi0MVax/qFABPQ/1ZYPeyaxXFTrfI=
X-Received: by 2002:aca:5588:: with SMTP id j130mr1120221oib.122.1578531357301;
 Wed, 08 Jan 2020 16:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20200108214349.GA17624@lxhi-065.adit-jv.com> <20200108223557.GE32750@szeder.dev>
In-Reply-To: <20200108223557.GE32750@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Jan 2020 16:55:46 -0800
Message-ID: <CABPp-BHsy75UGm4wTOP2_AYik_dZi-_BxtAn-hyi-ZrNRRWGuw@mail.gmail.com>
Subject: Re: Unreliable 'git rebase --onto'
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

user 0m9.644s
sys 0m3.620s
On Wed, Jan 8, 2020 at 2:36 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> On Wed, Jan 08, 2020 at 10:43:49PM +0100, Eugeniu Rosca wrote:
> > Hello Git community,
> >
> > Below is a simple reproduction scenario for what looks to be a bug (?)
> > in 'git rebase --onto' (v2.25.0-rc1-19-g042ed3e048af).
> >
> > I would appreciate your confirmation of the misbehavior.
> > If the behavior is correct/expected, I would appreciate some feedback
> > how to avoid it in future, since it occurs with the default parameters.
> >
> > 1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git
> >
> > 2. ### Cherry pick an upstream commit, to contrast the results with
> >    'git rebase --onto':
> >    $ git checkout -b v4.18-cherry-pick v4.18
> >    $ git cherry-pick 463fa44eec2fef50
> >    Auto-merging drivers/input/touchscreen/atmel_mxt_ts.c
> >    warning: inexact rename detection was skipped due to too many files.
> >    warning: you may want to set your merge.renamelimit variable to at l=
east 7216 and retry the command.

Lots of renames...

> >    [v4.18-cherry-pick bd142b45bf3a] Input: atmel_mxt_ts - disable IRQ a=
cross suspend
> >     Author: Evan Green <evgreen@chromium.org>
> >     Date: Wed Oct 2 14:00:21 2019 -0700
> >     1 file changed, 4 insertions(+)
> >
> > 3. ### In spite of the warning, the result matches the original commit:
> >    $ vimdiff <(git show 463fa44eec2fef50) <(git show v4.18-cherry-pick)
> >
> > 4. ### Now, backport the same commit via 'git rebase --onto'
> >    $ git rebase --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
> >    First, rewinding head to replay your work on top of it...
> >    Applying: Input: atmel_mxt_ts - disable IRQ across suspend
> >
> > 5. ### The result is different:
> >    $ git branch v4.18-rebase-onto
> >    $ git diff v4.18-cherry-pick v4.18-rebase-onto
> >
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/t=
ouchscreen/atmel_mxt_ts.c
> > index b45958e89cc5..2345b587662b 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -3139,8 +3139,6 @@ static int __maybe_unused mxt_suspend(struct devi=
ce *dev)
> >
> >       mutex_unlock(&input_dev->mutex);
> >
> > -     disable_irq(data->irq);
> > -
> >       return 0;
> >  }
> >
> > @@ -3162,6 +3160,8 @@ static int __maybe_unused mxt_resume(struct devic=
e *dev)
> >
> >       mutex_unlock(&input_dev->mutex);
> >
> > +     disable_irq(data->irq);
> > +
> >       return 0;
> >  }
> >
> >
> > In a nutshell, purely from user's perspective:
> >  - I get a warning from 'git cherry pick', with perfect results
> >  - I get no warning from 'git rebase --onto', with wrong results
> >
> > Does git still behave expectedly? TIA!
>
> This is a known issue with the 'am' backend of 'git rebase'.
>
> The good news is that work is already well under way to change the
> default backend from 'am' to 'merge', which will solve this issue.
> From the log message of aa523de170 (rebase: change the default backend
> from "am" to "merge", 2019-12-24):
>
>   The am-backend drops information and thus limits what we can do:
>   [...]
>     * reduction in context from only having a few lines beyond those
>       changed means that when context lines are non-unique we can apply
>       patches incorrectly.[2]
>   [...]
>   [2] https://lore.kernel.org/git/CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDoc=
KeO+>
>
> Alas, there is unexpected bad news: with that commit the runtime of
> your 'git rebase --onto' command goes from <1sec to over 50secs.
> Cc-ing Elijah, author of that patch...

I see slowdown, but not nearly as big as you report:

$ git checkout -b v4.18-cherry-pick v4.18
$ time git cherry-pick 463fa44eec2fef50
Auto-merging drivers/input/touchscreen/atmel_mxt_ts.c
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at
least 7216 and retry the command.
[v4.18-cherry-pick 88d39cdf3e80] Input: atmel_mxt_ts - disable IRQ
across suspend
 Author: Evan Green <evgreen@chromium.org>
 Date: Wed Oct 2 14:00:21 2019 -0700
 1 file changed, 4 insertions(+)

real 0m1.110s
user 0m0.956s
sys 0m0.284s
$ time git rebase --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef5
First, rewinding head to replay your work on top of it...
Applying: Input: atmel_mxt_ts - disable IRQ across suspend

real 0m1.643s
user 0m1.296s
sys 0m0.264s
$ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at
least 7216 and retry the command.
Successfully rebased and updated detached HEAD.

real 0m13.305s
user 0m9.644s
sys 0m3.620s




Interestingly, turning off rename detection only speeds it up a little bit:
$ time git rebase -m -Xno-renames --onto v4.18 463fa44eec2fef50~
463fa44eec2fef50
Successfully rebased and updated detached HEAD.

real 0m11.955s
user 0m8.732s
sys 0m3.424s


This is an interesting testcase; I'm going to try to find some time to
dig in further.
