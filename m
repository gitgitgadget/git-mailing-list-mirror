Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD9CC433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D038206D8
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJeu3ha4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgEPLRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 07:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgEPLRS (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 07:17:18 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8ADC061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:17:17 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id p7so1257021vkf.5
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A6IuDcA5+NGZD6ce8BUnewyH2Qah1I36o2+TRMZGg14=;
        b=jJeu3ha4g6jNW9lfqkL8UjTHLixe1BaMBpLSy29rI4LdKpS7bssewyBiBLBLwljNEE
         iNWo04h8r2HnwDuORvjcVHWe2aSYAV/NqVhDW901M6tVKgpMBew0h4xZCntBl9tyTTWs
         lokzcI+U2w0dFLTtU3adpoNIuZLE5eBDApNwA36KoMPWfTVpKVIrewHXwCT8In9PmJ+v
         TfJ/wiwphrO74lfPbkalAfh8dFIZ5AI2PW4efWEweTiGE2ZtAvThtEnfRESNmIvjGmhA
         ZohVx2l/DuGzf5AyEEPEoxxJ63PlRzCHSC1WpobZ+ds7k02hkYPiW/F7GCwNRnJVmyes
         OojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A6IuDcA5+NGZD6ce8BUnewyH2Qah1I36o2+TRMZGg14=;
        b=UpYo7Uo56Qt0KJWvfOj4eSy2I5aYkkXq3hQFQLGYXxleHa2i94RXBHUr9x9TQ3QfUS
         q7Pan6sAm/rOM/KiUCVVXLraX1zHcUtfWPOjQhzJNRfUreEbwOOg8wijGnVlbTVghaZy
         he9MCJmi2jJ+H5NHiB/+H2Dp1fRXeTuLC7xarszXyMqq3kj0deR+EY3kqdZKkHUjwPI5
         XJlvzqp1FoxfnvMbseyuiorIXh/g/IKonCLSkeaxvyuaMk2j0jagUi0yTKp4Hbm9diKA
         5L4zjh74lhdcsPz4P6Yfg0BUBjUmUj5hn+1GXk4rMO6vd+e8Y2j2KxiZOnzhyiOM4sGW
         SeYA==
X-Gm-Message-State: AOAM5330GrHtMIP2aZQ5nU8g9lpVKm2dy9lplr7pT4g5pk/Y4ZYcLhf/
        jvh9b+2UnHQYpkrAmEHuQnSyThKojfBrvhCgSUU=
X-Google-Smtp-Source: ABdhPJwDbW3D6L10zKKkaKPD2UXuj1cYr6jjM+IYfCmmiA0dY+TyZKI1B7eW89Yjr/RjwzhuUUIrea/XocBll7jNGtU=
X-Received: by 2002:a1f:a150:: with SMTP id k77mr5876236vke.88.1589627836963;
 Sat, 16 May 2020 04:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-36-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-36-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 13:17:06 +0200
Message-ID: <CAN0heSqcv6cTJcptOo=BgTwxcTkdL+mm-HKgX4UBnTscECJJTg@mail.gmail.com>
Subject: Re: [PATCH 35/44] remote-curl: detect algorithm for dumb HTTP by size
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:57, brian m. carlson
<sandals@crustytoothpaste.net> wrote:

> +       options.hash_algo = detect_hash_algo(heads);
> +       if (!options.hash_algo)
> +               die("%sinfo/refs not valid: could not determine hash algorithm; "
> +                   "is this a git repository?",
> +                   url.buf);

Should this use `transport_anonymize_url()`?

>                 if (data[i] == '\n') {
> -                       if (mid - start != the_hash_algo->hexsz)
> +                       if (mid - start != options.hash_algo->hexsz)
>                                 die(_("%sinfo/refs not valid: is this a git repository?"),
>                                     transport_anonymize_url(url.buf));

Like here and elsewhere.

>                         data[i] = 0;
>                         ref_name = mid + 1;
>                         ref = alloc_ref(ref_name);
> -                       get_oid_hex(start, &ref->old_oid);
> +                       get_oid_hex_algop(start, &ref->old_oid, options.hash_algo);

Other than that, looks ok.



Martin
