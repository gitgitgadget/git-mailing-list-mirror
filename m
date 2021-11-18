Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA70C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 11:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4ED861261
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 11:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344301AbhKRLrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 06:47:35 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:34437 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbhKRLpd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 06:45:33 -0500
Received: by mail-ed1-f48.google.com with SMTP id x15so25739370edv.1
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 03:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mBIO0LWZkm6gVWMVB1zgyadekBACmZh5LjcFsOLOSI=;
        b=k/PXUIIT+uJhYEPcQq087G/rBqbErQLyV5bzd4yFUXltavGQSVpDNBp+5cOVzdLByV
         R/4TfygifUjDPrWgxZ3VJVRG65e3EjJ/CkvXtGKglRwoEzFlLgMLURcvFWLkcsuJlEp8
         lG/LrlpauM4mHtWoha6Gpcg9d9/acR3jfnaA+C7bXYn5yhukwiZWzkJGv2/ENO6xQfop
         Xg1gexQb/Nm3BF8lVABadRWNoN4oe6vS2vMsxV1hwIEcf2MkZ4dFNXvAnZfb0+Yc1sTD
         zlIyhA6kovsdLtiDqWdspOZOPDmbRkaXgI7uv79Aq8S8O9u3q6CsIO4XR0OCctDvQzCO
         MXFA==
X-Gm-Message-State: AOAM532yek6Ps2IB9qyvplJoCEVqhbFZ33SgM0D/pbKqismXgHYTfdVv
        1gnGoBYkOqlbhvHTYi+WmjIn0cR6w7veu+8p3U4=
X-Google-Smtp-Source: ABdhPJzGtIGVJm8JOvhwx2PBWuk9lKKeeGtW+QtnypbKboNezhdTyrxcSAqL2KGzxdH01MnyONvkcz/oLlN4o9HrYrA=
X-Received: by 2002:aa7:c30e:: with SMTP id l14mr10263340edq.370.1637235751667;
 Thu, 18 Nov 2021 03:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20211118103424.6464-1-bagasdotme@gmail.com>
In-Reply-To: <20211118103424.6464-1-bagasdotme@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Nov 2021 06:42:20 -0500
Message-ID: <CAPig+cTKNYCoiRiDyi-KxxvheiYJ4rAxFY7vHx-r+qNyXYHNjA@mail.gmail.com>
Subject: Re: [PATCH v2] fetch-pack: parameterize message containing 'ready' keyword
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 5:35 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> The protocol keyword 'ready' isn't meant for translation. Pass it as
> parameter instead of spell it in die() message (and potentially confuse
> translators).
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> diff --git a/fetch-pack.c b/fetch-pack.c
> @@ -1410,9 +1410,13 @@ static int process_ack(struct fetch_negotiator *negotiator,
>         if (*received_ready && reader->status != PACKET_READ_DELIM)
> -               die(_("expected packfile to be sent after 'ready'"));
> +               /* TRANSLATORS: The parameter will be 'ready', a protocol
> +                * keyword */
> +               die(_("expected packfile to be sent after '%s"), "ready");

Missing closing single-quote after %s.

>         if (!*received_ready && reader->status != PACKET_READ_FLUSH)
> -               die(_("expected no other sections to be sent after no 'ready'"));
> +               /* TRANSLATORS: The parameter will be 'ready', a protocol
> +                * keyword */
> +               die(_("expected no other sections to be sent after no '%s"), "ready");

Missing closing single-quote after %s.

>         return 0;
>  }
