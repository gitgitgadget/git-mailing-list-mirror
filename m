Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BE4C27C7A
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 06:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348263AbjHQGxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 02:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348299AbjHQGwh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 02:52:37 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750571FF3
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 23:52:36 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58d40c2debeso11868867b3.2
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 23:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692255155; x=1692859955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gaGRlA+IAAuSvGxsr13dGZWhhnciaCaypoIwk6ry9U=;
        b=a1ScLLzK9LeTr/TD4mFZ7qY/pF4mvzyM5mBNh+c1lEnv7lXn/tIkFXCoBz0iU/CuU5
         iGBtbB3sHBcaC2aef/CumoeWntQu7L0HczcrPzbJu2ET0gAjqDZHil2cDuP0iF9S/lde
         nJ+t+1fzxuS1FBUG7zGnXdQIRqNL+dY42WGgqBn1k8SDgpNNblGzeBEu0nMUYVO1h6wV
         5RkBetI2etMGl8H636ezVEYrSQbqxRjocce1oCP8Z6lGEqwiTzXEbeNfsTO0FFEhlfeQ
         DWbwLpWt2NnxzUH63bfwTQO3eVPz4+HvkD+tz72zKaJaKyXl17hyFObIFlhiCCEYfjXm
         gc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692255155; x=1692859955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gaGRlA+IAAuSvGxsr13dGZWhhnciaCaypoIwk6ry9U=;
        b=D1qy3GyeZIa5MwvXfWf4BN78Yx9uN1IBiHqs38z9k0QYAY495wAnpH44HSaioNPvEm
         Biv3MC0IbPPJzfo7LhwcJboqUD4pH1FKumEaQQgZocxr7EaxOwKZ1dH5MqK+bL8Ddt53
         1TSG9MPRgnGMf6QFUpOc02YfWHaXauDoNelSLXuMsDON0Kfd1/u2LcOXuG54JlzzoUiy
         y1TO3cM/jvDTdrLT6plZZb51Y2KkrvSdForooMb+1ZQ7TsNWcK5Pt4Q1W9DEhc8J0gbs
         qvYf7FsJp/475PLdpxJcviYCLjQamiU6lFRmnUdikn+oWKl5ln9dNpgDA7OQudesz0En
         9b4A==
X-Gm-Message-State: AOJu0YzbmlPngCg5CjMAvN9jNdwCAzmm7eJV0va1NaKJf5E031LaYFPL
        804nf+8TqEOwjwKV+V6hvccw+Nos5GNlIXJjk+IxQC0r
X-Google-Smtp-Source: AGHT+IEpx7fL14iLEOVTZ350Xp0sHd8Jxs/3hRhWij/x7OYXieiUbg3YTYPH1oXwCI5q6jXfeXQ1pcHVlVorNoqrk+4=
X-Received: by 2002:a25:6b44:0:b0:d63:5e7:4e1b with SMTP id
 o4-20020a256b44000000b00d6305e74e1bmr3899308ybm.26.1692255155454; Wed, 16 Aug
 2023 23:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <f2e31e70ff6cbf105d00aa5d1188554def34e142.1692194193.git.martin.agren@gmail.com>
 <20230817025222.75033-1-tenglong.tl@alibaba-inc.com>
In-Reply-To: <20230817025222.75033-1-tenglong.tl@alibaba-inc.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 17 Aug 2023 08:52:23 +0200
Message-ID: <CAN0heSoNTPaX6Z-MZnhHHN3CUc5ez7dgjvT-khknAHZeYfPQUw@mail.gmail.com>
Subject: Re: [PATCH 2/4] notes doc: tidy up `--no-stripspace` paragraph
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 17 Aug 2023 at 04:52, Teng Long <dyroneteng@gmail.com> wrote:
>
> "Martin =C3=85gren" <martin.agren@gmail.com> writes:
>
> >       Strip leading and trailing whitespace from the note message.
> >       Also strip out empty lines other than a single line between
> > -     paragraphs. For lines starting with `#` will be stripped out
> > -     in non-editor cases like "-m", "-F" and "-C", but not in
> > -     editor case like "git notes edit", "-c", etc.
> > +     paragraphs. Lines starting with `#` will be stripped out
> > +     in non-editor cases like `-m`, `-F` and `-C`, but not in
> > +     editor case like `git notes edit`, `-c`, etc.
>
> Oops! I didn't notice to distingush ` and ", there are some places
> still using ", but here we think to use ` is the apppropriate
> way to surround option and command, etc. in docs, right?

Yes, we prefer `backticks`. The coding guidelines go into this around
line 730(!). Of course, we're far from perfect. This file does a pretty
good job at it, but it could always be better. This patch was mostly
"since I'm touching this anyway, let's do this now so any future cleanup
will be slightly easier".

Martin
