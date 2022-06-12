Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2245AC433EF
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 06:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiFLGgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 02:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiFLGgM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 02:36:12 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A5852B2B
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 23:36:10 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id r12so3047473vsg.8
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 23:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUoTnt+l0E/5PvEMg7KH0H856/onOsQF87KCsl90goo=;
        b=dyFvK5o57+xG8WRJFBuVJAARYJc9p10fNJguAz+WmqHogYhKaYpBprZYSTunTuHcg9
         qBmMlBEaCmHP0GCbyEysCtXh5yaO+BoNk4qvhEsda/vyrM+QKFKqfOpvs+/V9HzdGfNr
         SFZx5j95TMz1sI/06jEOf6ZbQXV7dyZSvmkPobFLMoL5ROxg73cPGnN/2hZVEtYuDFUW
         EpFWVrZ6/6kE3RMEUbpMOGCNEK94gjjnqSM6MXAVb9tfS0OmR2RU+At1dC/f8pyl+SjX
         uKUHZlIZTtijMGhjEY/uZlZH0jfHffVjblRFb28TXBS85WhRMjKrN66RbzajkIc1V3h5
         WCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUoTnt+l0E/5PvEMg7KH0H856/onOsQF87KCsl90goo=;
        b=kfZE4ARa3h/pNnWd+/b4V7Z4QwtWdZ/7tpAQia9IgSykviWKAV9Vz5s0BfUNuZsLLw
         g3nkn91v4jZqIhelpqDDbxZE4gyfjLVE0eQPwVfFWu2id9csCOhfAU8kFWTCj4c4VMnP
         rDZcRXJtP81Gc1r4q6H+hqqPtBDQAsqEku2iMI9pprkGirc28uKXI4CMSUGS8CgR7n9B
         XQWlmjLw2rCGjRtoUWnN7avyvC3T579BcKnoDmzbnD/NyIWaFZivTMwNHgkf/DKzXsC3
         mtxZ4TlXJg3auHzaBpTfIdxe6+tl2qJJD0XgDPcLmcu1gfmGpyap9PPS9RGzwGlMngVq
         V1Kg==
X-Gm-Message-State: AOAM532BwfiX+WY3557sMEI5XGa/kAho5rrw64t+tLIhH7D5HyjG8HZj
        1LLjk43yQrsBtCTkFXQc1TJZhCzjmrzjiBLfS5U=
X-Google-Smtp-Source: ABdhPJzLR++qBi+8UJd12i9EpZr2LEzsQVfEi2UjspwGJUiiUMb/kt8BgDKeqe82BSCH8FejPW7uuX43gw3I33NF/m8=
X-Received: by 2002:a05:6102:3126:b0:349:f1a7:fe32 with SMTP id
 f6-20020a056102312600b00349f1a7fe32mr23582226vsh.55.1655015769618; Sat, 11
 Jun 2022 23:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAChcVumTgNqRTt=EtThXiw9ga=W9WC-uS0XOkz7T+TbtGKeU+w@mail.gmail.com>
 <xmqq1qvwfntm.fsf@gitster.g>
In-Reply-To: <xmqq1qvwfntm.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 11 Jun 2022 23:36:00 -0700
Message-ID: <CA+P7+xqfthRZkn76FxG8xuGU670k0zyCCTe0d26_pe1HVTkXpQ@mail.gmail.com>
Subject: Re: Should `git remote show` display excluded branches as to-be-fetched?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pavel Rappo <pavel.rappo@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 10, 2022 at 10:08 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Pavel Rappo <pavel.rappo@gmail.com> writes:
>
> > Here's a console session:
> >
> >   % git config --get-all remote.jdk19.fetch
> >   +refs/heads/*:refs/remotes/jdk19/*
> >   ^refs/heads/pr/*
>
> Thanks
>
> "Negative refspecs" is relatively new feature introduced in c0192df6
> (refspec: add support for negative refspecs, 2020-09-30), so it
> would not be so surprising if it still had some surprising behaviour
> ;-)
>
> Jacob, care to take a look?
>
> >   % git remote show jdk19
> >
> >   * remote jdk19
> >     Fetch URL: git@github.com:openjdk/jdk19.git
> >     Push  URL: git@github.com:openjdk/jdk19.git
> >     HEAD branch: master
> >     Remote branches:
> >       master tracked
> >       pr/1   new (next fetch will store in remotes/jdk19)
> >       pr/2   new (next fetch will store in remotes/jdk19)
> >       pr/3   new (next fetch will store in remotes/jdk19)
> >     Local ref configured for 'git push':
> >       master pushes to master (fast-forwardable)
> >
> > I would naively expect the pr/1, pr/2, and pr/3 branches to be either:
> >
> > - not displayed, or better
> > - displayed with a hint that they won't be fetched (since they match a
> > _negative_ refspec, which is the second line in the `git config`
> > output above)
> >
> > Thanks,
> > -Pavel

This is almost certainly an oversight in that the particular code path
does not process negative refspecs. I can hopefully take a closer look
at this next week.
