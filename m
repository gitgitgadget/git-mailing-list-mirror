Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F7CC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF4F61288
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbhDLNae (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbhDLNa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 09:30:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A07C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 06:30:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id v6so19005260ejo.6
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OqNlWhRnA1bS3tOGXNPX1VINxkPeK7KjTmuxKkGKaY=;
        b=D5NZUSSxRUdmhlQpy+aUs5vrzw6FZx0xddoWD5cKOKI/M3Olag4q5EiWPlTay3b2ZM
         Dtbl/xFXLFfQNUuaK/r6xif2ww/MUwFM5f7cnmDmi6WDByRtoJmhIB7RryqHNmmlePZh
         kBK7kF3C2TJj5scDyPx4f68Q3owacy7OycLZNTCdz0ucWsVEfJTxMhoWNf1cRe4JzSNM
         wGkusblvgUZuQulQLNRpZgHIkycVirkrmJdhIq5WOcceR/VFCrIoKSFmzfzIeGX1mPXA
         nxYuW3KH6QVepRNH+VG9QlpAL/bclo9WlgNtpb4DmbU2LszQJ4r0pleig55SobjNctVI
         kh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OqNlWhRnA1bS3tOGXNPX1VINxkPeK7KjTmuxKkGKaY=;
        b=aTLWGJZw8/NHcQ2AoEquQyRCetvL4m44Q+N0ny/0NCQYU6o7fKEbSyuzfw0E1ZQKsY
         daPWtU3h2KV8tVjyoOeqmxDhVuXormSflx321wljWBVbbjnPIcD23gDmXfItxJ1YwlWW
         MvuorsrsIxirHINJUvBbffRFdifuu4F8iYQPYoAFEVVWx/kako3GTIqGwtWMegUwoLha
         E0lPzNP7jckPdeJeopOJdGdNEbFQhiTnzM720TL2wUaYEEhSrS3i9rhF6s6km0dtr497
         iQebApaFUGDbg2B5IdLSZfw2C+zD3cqnnbUb2oDfNgJLj+2NvJ5zNzunuL1gJrDL5yCz
         yeRA==
X-Gm-Message-State: AOAM532/DhJNNDlrlR5hilPyLU38DDdAbNMwN+lHyXh+VfjUg9NgYFXP
        BBV++029WuVZmJBjkIgxYmtOlSeCJzWu6CewSkNYBEu39GU=
X-Google-Smtp-Source: ABdhPJxDPgftGhvTRd/6DlcK0TehumA/Qz2yeNgZIM6PH6b8wWJyGcsRRUbmAY3TdAvDcvJxmyFJqc9xfG6/Q7ML/Xs=
X-Received: by 2002:a17:906:1a0d:: with SMTP id i13mr11160750ejf.197.1618234207643;
 Mon, 12 Apr 2021 06:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <E6E88000-9C18-4035-9A14-8B406617351A@gmail.com>
 <F3446051-620F-4C7B-A306-5C36922A976C@gmail.com> <CAP8UFD2hhtpnz+WE2J9iLbzfRJ2k5EOtUMRW=QcH9xe1U6y69g@mail.gmail.com>
 <F6B9AC67-EB44-4FD9-A7A0-A6494BAE3BC7@gmail.com> <f721d35c-72fe-fe18-edfc-8745966e41af@gmail.com>
 <5E858DC0-E642-4E0D-BDCD-40F62198DE11@gmail.com>
In-Reply-To: <5E858DC0-E642-4E0D-BDCD-40F62198DE11@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 12 Apr 2021 15:29:56 +0200
Message-ID: <CAP8UFD16Y7+S0057fYG-K9o85kKVLQBmUZMTB9CVScK8TvM62g@mail.gmail.com>
Subject: Re: [GSoC][Draft Proposal v2] Finish converting git submodule to builtin
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 7:56 AM Atharva Raykar <raykar.ath@gmail.com> wrote:
> On 12-Apr-2021, at 01:02, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:
> > On 11/04/21 3:10 pm, Atharva Raykar wrote:

> >> The example I gave for how to handle the presence of the remote flag
> >> and the function that performs the module updation method (ie, the `case`
> >> on line 611) was just to illustrate the above workflow, rather than say
> >> that this is how I will exactly do it.
> >> I also would like to know what level of granularity is ideal for the
> >> proposal. For now I have tried to keep it at "whatever I will surely
> >> follow through when I work on the project", which at the moment is the
> >> covered by the four points I mentioned above.
> >> If I go too much into detail about the functions and arguments
> >> of every helper in my example, I will feel compelled to do the same for
> >> the `git submodule add` example. I also will have to reason more carefully
> >> because I do not want to end up in a situation where I do not actually
> >> stick to my proposal all that much, because I realise in my investigation
> >> phase that there is a different, much better way.
> >> Do let me know what is preferred.
> >
> > It makes sense that you don't want to go into too much detail in your
> > proposal. I think Christian wasn't expecting it either. As far as I
> > understand, he was just trying to make your proposal clear to the person
> > who reads it. Just mentioning something like,
> >
> >  This would perform the work being done by the shell script past the
> >  flags being parsed and make the necessary call to `update_clone()',
> >  which returns information about the cloned modules.
> >
> > is not clear as it doesn't say how you're "thinking" the function would
> > return information. Mention this would be helpful for the reader to know
> > what your expectations are and if they need any correction. So, it is
> > better to mention such related information to make your proposal
> > complete. The high-level flow looks good to me.
>
> Alright, I get what you mean. I hope my v3 communicated my intention
> more clearly. Translating my thoughts to text is hard work, and the
> good part of revisiting my proposal and fleshing out the details is
> it is forcing me to understand the problem better :)

Yeah, the idea is that you should try to show in your proposal that
you have understood some of the problems well enough. If there are
things that are not clear or not very detailed, they are not very
useful as they won't show us that you have understood much. It's
better to focus on a few things or examples and explain them clearly
and with enough detail, than to try to cover a lot of ground in a
vague way.

In other words if you can explain well a sensible plan to convert a
small part of the code, and give sensible details about that small
part, we can have trust that you will manage to do it for the whole
project even if some of the details change.
