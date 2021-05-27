Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065DBC4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 07:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D880E613DD
	for <git@archiver.kernel.org>; Thu, 27 May 2021 07:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhE0H1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 03:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhE0H1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 03:27:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D1C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 00:26:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb17so6428613ejc.8
        for <git@vger.kernel.org>; Thu, 27 May 2021 00:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v88HozHdJUt2tN/31pAf3LZc+h1NgIruCSv+/16r6Ss=;
        b=UE1GYSDkRXEqhH5mRu9M6dJ0uJD5Igw+ziNRqQbAXLnrW9zFGXCuLqWN759LSsX800
         OMk9xrAG5sMw5cLx/VXGyq8wmzQ6dqIkLG3a3GBVZzOBByKeN/nO0bHOjW+LPJcMOzTl
         gOi5pW2vBUCs20XsWpmevsXN9cQNjstLFsuE2Kznmj8A0ibhwTuemwhY7RuckQ+GslYO
         8yNtyO1zttG8okBGSDqZMBeG7hj8zNkfzj8xw9RSM7et7F1yUhXVz5bmbFH8imwOxSU9
         SfrF8JfM37AVacd4slzR0zUXBWkK1jEXSBxFvTytJ+vaPEEgq0QnflWa5RpsCgQkcqgH
         VzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v88HozHdJUt2tN/31pAf3LZc+h1NgIruCSv+/16r6Ss=;
        b=dKYjaNOMRsniSJ//YR+3LtYlq51PpcscNPSIFNXFnQk0BpP+BCVKcma5AtLDXNy1Gt
         CgNbsx+l+rJsJPnj+5HEj71ePiMycHAngsrl4WeHuAl+r1YOVUj+nYv94lWaIr1Yd62G
         vnLlI5QAlBE1A46fpjs+g90S794bUh8/VP/tXytO5ovIxTUsUT2sJ6K6QWUcyywVagHB
         7gLdKGjJUHY3kADuNXzr+IGAM/4s3+gO7eTgPpv8SVRrH+67CuYvkW0+jv+tpoJcENeH
         GtQHIzAtMQ8acSUIZ5NijSNMdReQePN/XpYuY/CmtbF+z45UQmRz7zcttoZJLMVo3r7N
         YzRg==
X-Gm-Message-State: AOAM531cnEEsXNlllamAI/+CrbnFLbh9OtS89KyErcL3+iy1U5iOpuzz
        UHUCK6551yzJ47L+ltbXmiclAxJlrQsXCBU3Dvs=
X-Google-Smtp-Source: ABdhPJycxgQTbD0e6tRLeUorYTsA+IG+ocptbWLdIO7Slk+pZT1ecs4Cs31hYgQ3EFxTg/3eSQ8WjIllApg/ryE6qbc=
X-Received: by 2002:a17:906:f190:: with SMTP id gs16mr455618ejb.551.1622100360954;
 Thu, 27 May 2021 00:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
In-Reply-To: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 27 May 2021 09:25:49 +0200
Message-ID: <CAP8UFD0DoG5MR3V0eoy5LLf6mRBnthZMKjdmOiS8rhCQWRxoZw@mail.gmail.com>
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of
 following them
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a few nits that you can take into account if you reroll the patch
for another reason, but I am not sure they are worth rerolling by
themselves.

On Thu, May 27, 2021 at 3:27 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> t2080 makes a few copies of a test repository and later performs a
> branch switch on each one of the copies to verify that parallel checkout
> and sequential checkout produce the same results. However, the
> repository is copied with `cp -R` which, on some systems, defaults to
> following symlinks on the directory hierarchy and copying their target
> files instead of copying the symlinks themselves. AIX is one example of
> system where this happens. Because the symlinks are not preserved, the
> copied repositories have paths that do not match what is in the index,
> causing git to abort the checkout operation that we want to test. This

s/git/Git/

> makes the test fail on these systems.
>
> Fix this by copying the repository with the POSIX flag '-P', which
> forces cp to copy the symlinks instead of following them. Note that we
> already use this flag for other cp invocations in our test suite (see
> t7001).

Maybe you could mention 00764ca10e (test: fix t7001 cp to use POSIX
options, 2014-04-11) that also fixed t7001 in a similar way.

> With this change, t2080 now passes on AIX.

Thanks!
