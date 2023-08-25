Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCEBC6FA8F
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 00:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjHYAxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 20:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbjHYAxV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 20:53:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82A7E67
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 17:53:19 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bb8a12e819so5632061fa.1
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 17:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692924798; x=1693529598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTvXw48Kp7ph6do/jEDndgUCHoz7k0PMd08twgj7gmo=;
        b=LyuHiiDh0cCuhSoPKPgv/UveDZNcdAQ+5uyCeECSEoM3OwIA9yCWXzPhNuCvMlFVZY
         0PUVDVaJXsGB/QnLralLN8Pa+IRuNcBOxTpTQwx8IGJse/ADqyFInhfyfSRNN/shRx3n
         pU9H/z89StFQed3/+FGiO5OJBqbiftITzuBpSO2HzzGRzk34M8y5zTIuC5wPXkFzXzHU
         XrwshxnlefRp47WqI6WZUgcB0/R3CWhPY7F2eIqk3TUm/XbKwOiwLJrQLvXdRdM4MduB
         vdrA9iofG3h3sKe1yFo+Dpd2V7nkGMElFU8LGHGLkGJTn38XtLrAtVe+IpeGm6MPJwXt
         fS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692924798; x=1693529598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTvXw48Kp7ph6do/jEDndgUCHoz7k0PMd08twgj7gmo=;
        b=Ha0ZQbsaGzs6IA7cXdk41+crv5uuYpRe4IxOr6/JYOCQMhssH5BIKNGwYf6nkLvVuV
         9pkqlYnTr/3NjsAmmGRAmnVYuB5T9cZCWvQy5qeR0oaR6XWLU4vVlb1r7V5ir1LPwIcM
         tEXbnXsF28MqngG3N//OE/vjiZGsFwX82o1/SMeywZKgTsaDCC8Wd4zHHSbwmS4/EUwR
         MCJeSedkY6g8887Hz4ezT2gepU996TRzKmoVJzumCfmj9u9xE1skMabtzSePcnVg+37j
         KTrXGXLuPWjdVUehLsXPSKExcc6iiuObBfpoKqIwhTmDX5OyoyzONRuFZTDbz3eG8qpw
         RmUA==
X-Gm-Message-State: AOJu0Yw5YLQ1gZKDCetWJpCwTqLMq7JtUu9170ygC4zsHDI2gHiQBf2H
        FvaN6uqu2Wg9nqF74gjScOorNomoDbWXGOtKOsedYYMm
X-Google-Smtp-Source: AGHT+IFShcFr/lI6G1V+m2QYBlMWeMAIOf7HGGqaaTZhaQWa8AIKr/9maOgzMfZh2Hc4j5ql693yv7nXKqw86XnRF40=
X-Received: by 2002:a2e:b0e4:0:b0:2bc:d0f8:fb4f with SMTP id
 h4-20020a2eb0e4000000b002bcd0f8fb4fmr7712866ljl.7.1692924797577; Thu, 24 Aug
 2023 17:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJU=AjWatV6A5Vx-yqRfG=yeUWxMvKocc4nTsdq58WHjaYFEzw@mail.gmail.com>
 <ZOfgKQfqvef9FXZ6@nand.local>
In-Reply-To: <ZOfgKQfqvef9FXZ6@nand.local>
From:   Alexei Podtelezhnikov <apodtele@gmail.com>
Date:   Thu, 24 Aug 2023 20:53:06 -0400
Message-ID: <CAJU=AjU6cggm+P3d_Ke4uyks79j7uYipbp0xPq7jJ+nCgNSUZg@mail.gmail.com>
Subject: Re: confused git diff -G
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2023 at 6:56=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Thu, Aug 24, 2023 at 06:08:18PM -0400, Alexei Podtelezhnikov wrote:
> > I find this sections of the docs confusing:
> >
> > git diff -G (https://git.kernel.org/pub/scm/git/git.git/tree/Documentat=
ion/diff-options.txt#n656)
> >
> >  I do not follow why the example talks about `git log -G` and commits.
> > I see that thai file is included in git-log .txt but I do not
> > understand how to use git  diff -G.
>
> I agree that it can be somewhat confusing :-).

[skip to the practical example]

> given to `-G`, like so:
>
>     $ git -C repo diff --stat HEAD^
>      a | 1 +
>      b | 1 +
>      2 files changed, 2 insertions(+)
>     $ git -C repo diff --stat HEAD^ -G a
>      a | 1 +
>      1 file changed, 1 insertion(+)
>     $ git -C repo diff --stat HEAD^ -G b
>      b | 1 +
>      1 file changed, 1 insertion(+)

Do you mean that-G is only useful to filter files and not the content
of changes? That I can do without -G. Canyou give a better example?
