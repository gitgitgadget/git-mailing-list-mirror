Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E433FC4321E
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 12:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKXM6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 07:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiKXM6W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 07:58:22 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3024FB0400
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 04:58:16 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k7so1403455pll.6
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 04:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAEUqP6fcMgMTDO1NsHxuY1kqZA4Or6NIFsg8vyPl5k=;
        b=SLoX868n2EIHk8gz+Zte5iV+/xMWfc4LD5tVjczcctm22zsA/5INGdreJanrZrdGJn
         yv2jVm4DZlveeVs/k6GlywmGYj+bvCWxQVJkM7bKzUKzal2sVGEWiDpJfEe9MidKRPQg
         Cps7omf2Y48YYdnUmAmccfuyvukqa8Iqs0wfRkAEMUZahnGCAQzs/jQXKNg/1+rfDGbh
         n7sGEba97cgkuEE943JU3a8gAdk3ONYSKfLvbP/A8sghg/sZs/VhEC5pK1WDcJEalhY3
         yEL/w3fU57dh9syeMSAFQIZFpzoxKDr8B2q16PqtErvoMXs5oXomNMJ4NNI/7qkcpxiC
         0kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAEUqP6fcMgMTDO1NsHxuY1kqZA4Or6NIFsg8vyPl5k=;
        b=u3lrm5ltQAymdw/+h6UAwt5352xLfIyIKwpAHZumhlxgpBr6OAgUPohHaMLj3dem5o
         +Ni2YZla8noIWi91/mpa+0ZtzQgqwFDc9+pJRc5Y6qKm7vznozl6B+zKihkqtiDLqt3S
         d2fsV7aUH0+Csl2n4dYOyUg+HCf5BqyfUfSu4Z9rR0IDsEX1cKILwMiAryNapuoqi9N3
         rTRUaSi6RildTgVleDzOvZvo//jWci9wwGKfiwo5Rbm6NPR9R4SqaA1rMxxpMuCzZH5j
         7YS1367/wtQ7HSE44Af1PXzjTzdYtPoYaDBizzKIDlGTKzVoab8g+uabec/oPyADhnKf
         5rQw==
X-Gm-Message-State: ANoB5plEpX2X9bCyMeDLZZROGEPtDCLiyogNowod4bwOSf84zkYjUr8z
        8PIOILLWdTEcSOZXLvqMCe3yfxdCbJ6cEMNBYMnrdjbWEvN9ag==
X-Google-Smtp-Source: AA0mqf4YZipv5XmBgPT67V7/4m4hocK3Y2M2EhBTsZwLpkSJKoB2cy/HAMbNL+Df76TchlICbIec/kWp2L4Rfhuh6ag=
X-Received: by 2002:a17:902:e9c2:b0:187:4920:3a78 with SMTP id
 2-20020a170902e9c200b0018749203a78mr13283669plk.88.1669294695631; Thu, 24 Nov
 2022 04:58:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com> <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
 <Y30a0ulfxyE7dnYi@coredump.intra.peff.net> <CAF5D8-vSsBsdiA8SiDgqUFkL9_3N-v+psVxj-AcibOB88gxWfA@mail.gmail.com>
 <Y37EPdUkBhsSPmRD@coredump.intra.peff.net> <CAF5D8-u14grTa9cUo=ge8TVRKNYtVHWhFHDW8yYD9gD8=f0Byg@mail.gmail.com>
In-Reply-To: <CAF5D8-u14grTa9cUo=ge8TVRKNYtVHWhFHDW8yYD9gD8=f0Byg@mail.gmail.com>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Thu, 24 Nov 2022 21:58:04 +0900
Message-ID: <CAF5D8-vXK81U_n06u=p=B9urTWyQ5+fN8_w9FeCWQOv1xen07Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] git-jump: invoke emacs/emacsclient
To:     Jeff King <peff@peff.net>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2022 at 9:32 PM Yoichi Nakayama
<yoichi.nakayama@gmail.com> wrote:
>
> On Thu, Nov 24, 2022 at 10:09 AM Jeff King <peff@peff.net> wrote:
> >
> > On Wed, Nov 23, 2022 at 02:33:50PM +0900, Yoichi Nakayama wrote:
> >
> > > On Wed, Nov 23, 2022 at 3:54 AM Jeff King <peff@peff.net> wrote:
> > > > Hmm, I know I suggested using a temporary file since "cat $tmpfile"
> > > > should be pretty safe. But it does still have problems if your tmp
> > > > directory has spaces. Or even other metacharacters, which I think will
> > > > be interpreted by the eval, since $@ is expanded in the outermost level
> > > > of the shell.
> > >
> > > Right. But the problem is not specific to emacs (it happens in vim too).
> > > Let's fix it another time (as you noted, that's pretty unlikely, and we may
> > > not even need to fix it).
> >
> > Good point. The vim version is easier to fix (we just need to
> > double-quote \$1 inside the eval), but the fact that nobody has
> > complained is an indication that it does not really matter.
>
> I've confirmed the vim version is fixed by
>     eval "$editor -q \"\$1\""
>
> With your hint, I found the emacs version can be fixed
> by single-quoting the variable (I found a mistake in the
> emacs version. Since there is only one argument, I
> should use $1 instead of $@. I'll fix it.), and the vim
> version can be also in the similar form with single quote:
>     eval "$editor -q '$1'"
>
> The original vim version used the notation \$1 instead of $1.
> I'm worried that the emacs version might need the backslash.
> What does the backslash mean? Is it necessary?

I found the answer myself. The backslash is to leave the
evaluation of the argument to the 'eval' execution.
And another question arose. Why do we use eval?
What is the difference from running it directly like below?
    $editor -q $1

-- 
Yoichi NAKAYAMA
