Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0D2C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 06:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488F122D3E
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 06:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgLEGMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 01:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbgLEGMr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 01:12:47 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C87C061A54
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 22:11:43 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id k4so8143766edl.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 22:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=83Lhr4Y7vYEL7cFXbD7uOnS4SgnnH+Mrnmx3i9SQFvA=;
        b=H8a7bVMnUUjfiHAlWvfmsB2JhPUZOpaEgSTPgyzZlhLwmVfaVI/RMJbQc7UVbBMup7
         XQ2d2DLKzWGeuZtSc5S0YSTa015cIHWo7vIlDxNz0/KwfhH9DocGBuyOHophLxGBcvlf
         rYdESugQvjWJhZMoheFAuGF5tdCidrAMnsIK4sAN5P9G87/QUBO6PF12STJJqSJoBtK2
         pZeexYuhWzsYqs49vujquCOhat6VzeW7CxymObW8B0HNMkOfq73TtNqjHKKTfiDNC+o8
         wj8dS8HnGoLTvS19WO5/hRcnJw1UENNw2lQgAUGUaJipxtXL+bs7zIbNzkReoXp5uA0l
         DqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=83Lhr4Y7vYEL7cFXbD7uOnS4SgnnH+Mrnmx3i9SQFvA=;
        b=rf+GGeWrjTi3U5m4D1p0sHYyu8E5FPhBM7hO1kdlMDh22YVn94QtfBMOwahnGFX7VM
         xbdF7upiXURqovHs4wJvp6pUsowYYUCiVvd15WrOcJzon+B4JAY01BYyeexb8HKer3bp
         Ewv8WKbNBLrkag28x9GyIKr6cB7z7f7KTdQ+zOi8tGFx64S1VYauay4ituGVaHg/juAo
         IFd7qd77rQNAETigY70+iqDNqYJC9jXdHTxEyY/w3Lqcx7o4/8aOihj51ntYvtwoae1+
         Cm8NbP/35KpYmu59YddVGK+TBB5ge0kG5fnBSZHi/4n1XIU1viHEeW//9EgBBfHoX6gG
         6wvg==
X-Gm-Message-State: AOAM5311cpvdHrZK/2UifOGyYk0wG1B8tYxlAA97KbLw92eMxlvk1TmX
        AcWGkmzzhZHoLpvoTT22K1ytq76gB49xqY21mC8=
X-Google-Smtp-Source: ABdhPJzwCOK5OXKCucEt4qbbokIC+0CPvHc7JioQUFCr7BY5EZhc/wZqyNhW4zPd/eUZ9Ei6apKRncDoUYYq9dWofBA=
X-Received: by 2002:a50:8163:: with SMTP id 90mr10781395edc.142.1607148702516;
 Fri, 04 Dec 2020 22:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20201025212652.3003036-1-anders@0x63.nu> <20201205013918.18981-4-avarab@gmail.com>
In-Reply-To: <20201205013918.18981-4-avarab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Dec 2020 07:11:31 +0100
Message-ID: <CAP8UFD1gTOKLs55ceVwsDW=uSyW4wx_9eF9Wra5KVP8B19Jx_Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] pretty format %(trailers): add a "keyonly"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 2:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Add support for a "keyonly". This allows for easier parsing out of the
> key and value. Before if you didn't want to make assumptions about how
> the key was formatted. You'd need to parse it out as e.g.:
>
>     --pretty=3Dformat:'%H%x00%(trailers:separator=3D%x00%x00)' \
>                        '%x00%(trailers:separator=3D%x00%x00,valueonly)'
>
> And then proceed to deduce keys by looking at those two and
> subtracting the value plus the hardcoded ": " separator from the
> non-valueonly %(trailers) line. Now it's possible to simply do:
>
>     --pretty=3Dformat:'%H%x00%(trailers:separator=3D%x00%x00,keyonly)' \
>                     '%x00%(trailers:separator=3D%x00%x00,valueonly)'
>
> Which at least reduces it to a state machine where you get N keys and
> correlate them with N values. Even better would be to have a way to
> change the ": " delimiter to something easily machine-readable (a key
> might contain ": " too). A follow-up change will add support for that.

Well explained.

> diff --git a/trailer.c b/trailer.c
> index b00b35ea0eb..40f31e4dfc2 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1233,8 +1233,11 @@ static void format_trailer_info(struct strbuf *out=
,
>                                 if (opts->separator && out->len !=3D orig=
len)
>                                         strbuf_addbuf(out, opts->separato=
r);
>                                 if (!opts->value_only)
> -                                       strbuf_addf(out, "%s: ", tok.buf)=
;
> -                               strbuf_addbuf(out, &val);
> +                                       strbuf_addstr(out, tok.buf);

Maybe `strbuf_addbuf(out, &tok);`

> +                               if (!opts->key_only && !opts->value_only)
> +                                       strbuf_addstr(out, ": ");
> +                               if (!opts->key_only)
> +                                       strbuf_addbuf(out, &val);

The above is probably correct, but it feels strange to write the key
after the separator and the value, and that the key is in a variable
called "val".
