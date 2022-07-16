Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AE6C43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 21:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiGPVig (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 17:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGPVif (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 17:38:35 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214BA186D3
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 14:38:35 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso6243952otv.3
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 14:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZj+Iy5hQHzfA2zCLPQ73Qh0rUkoEu+6cvQn9U3lvzo=;
        b=mAOkaXVGd3nOmjKg+WJpQWf/lQ0j5HS/2dplZeYU2boSrCVYC6sehsQlBhDa4aSfaF
         XoeO5gq/QnswOI6+gqeyDp76u9AaGrnsULigEkeWchz+wYuq+6J9sOxN+SKr3+7oWSSQ
         V4ILL83EiD5OgjTPvhbEwh7XtSxxGgNrL2pd2vfoT9LFc+xT8DmLoy0FVZYqrfKO11+H
         HD/BPiQYmb0Hg/vC3cZ1n1gGDlbJ9V8DRJGojguvW7QREQFcMSgFK4fvhTMCyAzSDZ3G
         +p4GxnKM4f1HBAa002SJcdq80sCHSBw0DGyg+0sbpLxN3SGLaGh49383FZzvGa3LpgEy
         xu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZj+Iy5hQHzfA2zCLPQ73Qh0rUkoEu+6cvQn9U3lvzo=;
        b=ynfUZMBgyaqfecX72DDLMjRtvWRVDADemzpBpdh5dGtatWd13BBUVSUvsndfvCOyFZ
         1cV07FrNFY8nNfKvOaAEnvwi/3wa3Ji6Tni2c2GraoD4nyxV4dZsq04+mybNNHs9zD3z
         wnJpVDEU1EsYyEWFbTHIzF2me8FXQVwrbBKfWiRMJ/QKIDKLolnSIlJf4PYVqmbzmRBW
         NjvjBwiTevuZ6Hj5ySXGW5jLuluvbklqlS4T+4wGk24AylPiIDZirp2Z/kBuZGfbF6cN
         RsQLJAxXAVBRDIew7+5VXISiu48CqRQYHctuJuLOe3Na+wc1OK3h5hO0Dc1qcGaIfD9T
         G0wg==
X-Gm-Message-State: AJIora9ZWcOU5/sTNEtyfWO9RzX3oNF1GMYCUumGz1jVcMC7jYQ89eoz
        9m90gAAScl+0cR7pCWPUaEEr/tuTBR/lLhJ0k8w=
X-Google-Smtp-Source: AGRyM1sxdByUkpbG6pNYX+BUumcMv7hDSAHboA7ExpStXWW4rBBI+6u5Ya0XVjp7dEAjRoRx0ypnJ096R4xpRWXR8fQ=
X-Received: by 2002:a9d:7a84:0:b0:61c:6f66:d299 with SMTP id
 l4-20020a9d7a84000000b0061c6f66d299mr7473747otn.145.1658007514436; Sat, 16
 Jul 2022 14:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X_a+ycefqvz0LaO0KK1LuTqgE=iUhooPRXeo3mq-zXkp+nCA@mail.gmail.com>
 <220715.86fsj2zeqn.gmgdl@evledraar.gmail.com>
In-Reply-To: <220715.86fsj2zeqn.gmgdl@evledraar.gmail.com>
From:   Sim Tov <smntov@gmail.com>
Date:   Sun, 17 Jul 2022 00:38:23 +0300
Message-ID: <CA+X_a+zbG_CDP6D0zxozRoUmBeWm4dVxQ=xYRqFeWrk+FR5p0g@mail.gmail.com>
Subject: Re: git: detect file creator
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much, again, for the very useful suggestions!

> > 1. Do you have an idea how can I list all the files **created** (not
> > authored / committed) by a user, so I can implement a fair characters
> > counting?
>
> If you want to adapt your current script perhaps --diff-filter helps,
> but...

I added `--diff-filter=AR` to my original command like this:

git log --use-mailmap --no-merges --diff-filter=AR
--author="CertainEditor" --name-only --pretty=format:""

and it seems to do the job! May I have missed/messed something here?

> > 2. Maybe some commit hooks can be used that will check whether the
> > Author of a new commit is different from the previous one and if true
> > - override it to the previous Author?
>
> ..it seems you should fundamentally stop using it, and instead iterate
> over the commits, and pay for a "diff". Then you'd get the original
> change, as well as the change-on-top.

2.1. Will such iteration over history not more time consuming compared
to my command?
2.2. Will it not account for useless "diff"s, like add some rubbish,
delete that rubbish - and I'll have to pay for it...

> > 3. Those small changes by a non-creator may be left not paid for (as
> > this action is not so intensive and may be reciprocal), but if you
> > have a good idea how I can pay for the "diff" the non-creator provides
> > - it would be nice!
>
> Just wc -l on the changed files(s) before & after, and pay the abs()
> difference.

I pay per character, so you probably mean `wc -m`... but what do you
mean by changed files? The command above
is part of a script I run all the time I want to measure each editors'
char count... it might be even without any specific
recent changes...

> > Do you think this "diff" should be deducted from the creator? And if
> > yes - how?
>
> You could walk it back with "git blame" I guess.
>
> But you might want to consider the economic & social mis-incentives of
> lifting money from your co-workers coffers by pointing out a mistake to
> them...

Good point :-) I will not do it.
