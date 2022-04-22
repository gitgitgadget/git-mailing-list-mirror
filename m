Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0896C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 11:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447035AbiDVLS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 07:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446942AbiDVLS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 07:18:56 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56048517CA
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 04:16:03 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id f7so2885449uap.4
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqWBD2yuARRQ27AzAx+x8kE+4MGleebwTDvg1ppI1xg=;
        b=BjqsSNVHW2kGlsec2HiUfkoMdUVsy7eZ7PE3QaOLRKSdfjOYBJyKScKi20RU2E4woH
         /X+aUje/4n/P0LaKG6fcsc2Pdywk/k2R4IwptaIP/LGNhPzpsxFv/nwBRlpmhMhrpz8X
         9eADYGQMJPerIZmPj0pQbtFO7X5LTYHLf0aRqgXo8es79/4aXtR6kZsyIvFdVgXR0pi2
         6Szgoo3DqNEXhlHoG6FwTcPErMcs1kibrM0RLXdQUyBufJeeX3Pm22CEN8Rd7JkHqg3J
         Xa3al+7xOvzGVxFn4jdKKXM6oBFPyTi3MvwfUSwhx9H5aQd1mQHVKQkNjsLEgD3i6Yc+
         BfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqWBD2yuARRQ27AzAx+x8kE+4MGleebwTDvg1ppI1xg=;
        b=ZZAatp8Aw3vRMopuy+P1jqINA9JgyYF17pGvOCalZ5+/fNuBOb/LNvzRIkwqh6SE/8
         SnVSRZIF7ACd4//JqEJCiki7hzfyB+t7fewL8UXjnNT35i0AXb/QU7OTHQpgbWOGUG26
         qAc0c/gMYVbxSjhDcDT0KD8h+d80trA68EzsJmStmSzLQk+uEOboNPEpWz8Co+auxvlF
         yu99FkYQ4sEBn3FGiWC8Pzljm56Hyf3xSG+0gCNPzup9h/0/eXahEL2LhW3ZO/Z+jO5q
         beMtALMYOhSlIzCP+o4zqViQh4RNKlNdXm/kMBtQl9tS5FKjfevQcAZ4VCRHz+xJxTXo
         9+Gw==
X-Gm-Message-State: AOAM533RJmMHe3HWC0gE8GQQfCa43MssawqfFzA5bB2EtkRvOGVHJP3x
        wQJeCkUuQhr8nhYVrwWrWGzv9J0x1JIjFrn8RfTVbcBB
X-Google-Smtp-Source: ABdhPJwBBfvxq+FJhORvDDQy18WFHGzX/3QV6uTcYngN5UUhY/jeOaRvV6ThQpXeMGPpsXradPNq499REmlRshvTCWI=
X-Received: by 2002:ab0:6d81:0:b0:35d:30f8:730f with SMTP id
 m1-20020ab06d81000000b0035d30f8730fmr1390943uah.62.1650626162440; Fri, 22 Apr
 2022 04:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20220422T085958Z-avarab@gmail.com> <patch-v2-2.3-2805e89623c-20220422T085958Z-avarab@gmail.com>
In-Reply-To: <patch-v2-2.3-2805e89623c-20220422T085958Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 22 Apr 2022 04:15:51 -0700
Message-ID: <CAPUEsphEBdcxi_wbJxSQugo-bXS+eaEuhNuxciccux96M-B9cA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] CI: don't care about SHA256 mismatch on upstream
 "perforce" package
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 82fa87f97af..cab6e04a358 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -37,7 +37,14 @@ macos-latest)
>         test -z "$BREW_INSTALL_PACKAGES" ||
>         brew install $BREW_INSTALL_PACKAGES
>         brew link --force gettext
> -       brew install perforce
> +       brew install perforce || {
> +               echo Installing perforce failed, assuming and working around SHA256 mismatch >&2 &&
> +
> +               path=$(brew edit --print-path perforce) &&
> +               sed 's/\(sha256.\).*/\1:no_check/' <"$path" >"$path".tmp &&
> +               mv "$path".tmp "$path" &&
> +               brew install perforce

brew install $path

seems to be a safer way to ensure that brew will use the locally modified cask

Carlo
