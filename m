Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16559C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 10:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3AD764E99
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 10:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCOKBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 06:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCOKAm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 06:00:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341CAC061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 03:00:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lr13so65141052ejb.8
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 03:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foT1ohiqy1+uyhLW9sLQmXYOuc6vCZWXsTBuyJEISPc=;
        b=ZVWY9FRdCq5hM7TaSnapGZ0/eICKh6EI7Fh9Y8eiMQSE85Ouao+TjhyET85Ie3Nxgz
         7b4DXh2ktpw5ZPgX84yzh3pzKSOjKRtikmBwTSti4qY0EUzg+6lWbt3TfsCsvH9jJXhu
         RUE7pfWuPKW6Ml2meTOtA4JvDMp+3/H+yGCFek3hKVF9o6ZyxwARsQ6KHOCHH+bBnx4P
         EeIgDOmr1v4VO+i4yDv7AQX0db6XIBbz8xDqTKVJ/NV3kN1jaA4TG3VTltKyVH1n0Vsl
         NhgWuBtvSvr29szwYVRMQ5muszptuZwhaVv/wYpf2saCj30M15xBp7T42NB4BMQ9GI49
         TvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foT1ohiqy1+uyhLW9sLQmXYOuc6vCZWXsTBuyJEISPc=;
        b=h+s95gCiG6fh2GP1r1hsSeboU2Zu5j+jTLSxBEo8TGNMFmOh9byQpIzacnPndquM5d
         w9a2IOT2XXugHH7jEE8euF+6M7x0CoX6DdY/QrJXk0QeVw8In9CSjd4hraGxdmqrrFJn
         sY/Uz15pigZHmTmtSezBev6DFn3lhzrbFmII/LXc+FJG5Gdkt6eOSoHrxBkwOdpB9aws
         d8xpP21gJOZwE2iucfjfZlbRGOEIAIhwqLUCUEv4YNog63R7KeaJGZSV0kcIsLU03UEK
         aGA+KDFm++FEMVI1PMLk4FH0kI89RwWpugGQkRxpftoECTDtR+r3fEo2hJFBo+tUmBAu
         LvOA==
X-Gm-Message-State: AOAM533YrbxoYIxmvnsipqofh5/L4fXHo3Bz08RYDQ+/1O3vekGO3WBD
        AE/nwbt+5y83zPXdpjMkzec5tDxTxnBBl6zAcRgwPxR5eNyJKg==
X-Google-Smtp-Source: ABdhPJyHYknopmrWnli1zJAG3XUe7MvSoNPiIoTVPg0YbVNHSFWN4UHbjguR3T28SoYU5AR83Z8LRHLY57YDAS3x+h4=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr22610683ejz.341.1615802441018;
 Mon, 15 Mar 2021 03:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v6.git.1615790151073.gitgitgadget@gmail.com> <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 Mar 2021 11:00:30 +0100
Message-ID: <CAP8UFD1+Z=hV_6dLbg7fh4EntBdWdheO6gvbQjKtZFRgOAsrzw@mail.gmail.com>
Subject: Re: [PATCH v7] [GSOC] commit: add --trailer option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 10:08 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> @@ -166,6 +166,13 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>
>  include::signoff-option.txt[]
>
> +--trailer <token>[(=|:)<value>]::
> +       Specify a (<token>, <value>) pair that should be applied as a
> +       trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
> +       <committer@example.com>" --trailer "Helped-by:C O Mitter \
> +       <committer@example.com>"` will add the "Signed-off" trailer

s/"Signed-off"/"Signed-off-by"/

> +       and the "Helped-by" trailer in the commit message.)

It might be useful to point users to git interpret-trailers'
documentation, for example by adding: "See
linkgit:git-interpret-trailers[1]."

Otherwise, this looks good to me!
