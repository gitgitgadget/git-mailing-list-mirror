Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6E6C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446247AbiDVJzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386031AbiDVJzr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:55:47 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA853731
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:52:54 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id d9so6955103vsh.10
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x6/+socBBmducgCLRdqBbGGjvNgRF3xDEV8sGwRa20Q=;
        b=UBH6ma2t0DuCdhqjjqOwIxK05r1gOJrhBqFeSAyu34GWIYiN9liIbpxsZL4biWB+EQ
         Bnr0KdDFILr3b+F1JO0BGDR5Mck8XCXvy5zC/Kzo696SSbLkYIDvxGrNGynO/x86rr44
         Gf94RO4YxB/Nc2qM7G0yB6NjMeL9koNI5twd0fnR+sjZBHUycb5EpS0gS+HqvkyFroCb
         5b/kq91/Z/A9fJXqmqrzQWh61lqECwvJrX1FAwwgKzLvjWWkDR5ZgiymDCrNJjfI3qGs
         W5s1XbB8F6z602ktC9oOvRoHvtjFjrRqkX5aieW2e09Ow9qcS8t/NwxiIeVAB902cbHa
         vXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x6/+socBBmducgCLRdqBbGGjvNgRF3xDEV8sGwRa20Q=;
        b=D0bhmaJDKWKL2y+NXQ9xH1igvWOdMB19nyTqpRWyjTUM14mIZwG/OMD0y3INum+0Zu
         NVStOLhKQ6x7h1OJuBz3VTxdAm/0rJE1hqgGwxCn354t8kYFa8QvY7KwL+Rds3n83yf6
         pdvSfef8fsKrjtHs+gtPetMRZagzg4jFkyqYuXMUq2Sm+WWFTwgdijv8y0nWTgoOQ2Ey
         oxOR4ocnrrRgoEJPuYJ2caFeFWnD3cy/oo2NZoRMktpE4rnpTTjUcn1+gIBF7JgIdHST
         6mIMoqBIjdPwH5bg68vVJphpCLOkhApm5yhSh9+AtBxMnai6rHtTkvX+LNw/Eexy+VtZ
         uuZQ==
X-Gm-Message-State: AOAM530Q8+R3tgusf9LfJ45LgC5i7N7yDQcVWo/k0vuxQ7FTxyTRktvo
        Rl8jB7w7im9NBui3J+7b7yOI7TDxZzeI2FE6iYdqB1hM
X-Google-Smtp-Source: ABdhPJwQ+aitNl4QeoAU8ZkcUatSnicuXSPVd0tj/gvjCbt/GaGpv5Jh/prvt/ROfb/ijd/7fyGc/ZouJBsRvwOmUd8=
X-Received: by 2002:a05:6102:f92:b0:32a:6c4d:f399 with SMTP id
 e18-20020a0561020f9200b0032a6c4df399mr1184347vsv.5.1650621173596; Fri, 22 Apr
 2022 02:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20220422T085958Z-avarab@gmail.com> <patch-v2-1.3-dcedf03c2d7-20220422T085958Z-avarab@gmail.com>
In-Reply-To: <patch-v2-1.3-dcedf03c2d7-20220422T085958Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 22 Apr 2022 02:52:42 -0700
Message-ID: <CAPUEspiuV4XjQH_r+uRMnstRfR4apB0Z83SoVbJTe7xrncyP-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] CI: run "brew install perforce" without past workarounds
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2022 at 2:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index dbcebad2fb2..82fa87f97af 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -37,13 +37,7 @@ macos-latest)
>         test -z "$BREW_INSTALL_PACKAGES" ||
>         brew install $BREW_INSTALL_PACKAGES
>         brew link --force gettext
> -       brew install --cask --no-quarantine perforce || {
> -               # Update the definitions and try again
> -               cask_repo=3D"$(brew --repository)"/Library/Taps/homebrew/=
homebrew-cask &&
> -               git -C "$cask_repo" pull --no-stat --ff-only &&
> -               brew install --cask --no-quarantine perforce
> -       } ||
> -       brew install homebrew/cask/perforce
> +       brew install perforce

While this might work under the current VM configuration used by
github actions, is definitely not the usual configuration in macOS
installations and therefore likely to break if run locally (as some
other on the fly changes attempt to suggest)

keeping the "--no-quarantine" makes for a less likely to fail option
(since SIP is enabled by default), and therefore I am also concerned
that by removing all these other (learned the hard way) workarounds we
might be making this more fragile for the future as well.

instead of this rewrite of the brew interface logic, removing brew as
you suggested would be probably better.

Carlo
