Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D407C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 06:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A94206D4
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 06:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0mMKoKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgG2GQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2GQI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 02:16:08 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC3C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 23:16:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so16541317edy.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 23:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIGGKurCLCvY2Z31yhPbQqokFYrH4eJX1wCdO2mq6yE=;
        b=A0mMKoKZG9ZiE6fEifoI9gCIvytotGLdVG2dpuvoTB6quSiV7CYEfdzB7E1g7VQu9N
         lmUWc43jRqrJ7QapL+4PoTIiLwUyLEJETciw1s4DZihF7fa5Kpw680x1ypUNQOcXHMGJ
         Vd14RwdawGAtfGPjA72h6/P10SEuHvWFIsNuyU+A8g5e0JixiSrSGACk15dkKoUkJRQ5
         Zi/lBKdSIp/Fg5vBas46VO4bes3yRYaDX5PT7EiHs9QbCvj91cqfofU3C+89lYx+vW4b
         cV8mUyhjXTP8p2rGPi2d1ii7nkGievU5kNt0p6kRMbRrJp39+RKwbZemfqTnBazUY67d
         JBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIGGKurCLCvY2Z31yhPbQqokFYrH4eJX1wCdO2mq6yE=;
        b=Rt7Z0xtksE7VQZ0YngxbFIK9vLLwhw7JwEi/UG2vOPZTGuQ6W2jboJxT8gGOcOuyx6
         jidfvlbaiTxrmYkdp3YyBrSqPM92+HlAKefoxHl8gHxbkS6ZjrNICVK4Nso+vS+sMJhu
         WxCdsIPozVeZsrszNcSN2UuqFyEoBFw2UonQoz+/OXi/zMzY1jlMyttBMrITxTGhlZ5M
         Epmc8hp8HsPmiWQq6/VFb+9o8O9ywXNGz1coqPqfVzWLxeYOX5U0zT7FyqyRbwNVGFa0
         ZWOXDoqIvHqDKMS2ChWkf9bScOHL+vo8dqmrAycPULjD3oUSXLQfs5H6P4z/GjtY1JGQ
         VEeQ==
X-Gm-Message-State: AOAM530IhVLaTzAokeTg2wBNWPhQZuRn5aF5Aue1Tznapyb9tq765pvr
        WaznzGjGnW5zwMIwX8iVIjfh4TCWDID4bCsTHcQVkhgI1Yo=
X-Google-Smtp-Source: ABdhPJzX+MN1iaOMa09+d3y0WwsnWFx9Q0H+ZVxm/Xg6YAia61HS7aOZK/9cOoJgLrNMKUpZMOZdQtJXaAHh5A0pw4c=
X-Received: by 2002:aa7:d3d9:: with SMTP id o25mr2933164edr.362.1596003366253;
 Tue, 28 Jul 2020 23:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200728202124.GA1021264@coredump.intra.peff.net>
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 29 Jul 2020 08:15:54 +0200
Message-ID: <CAP8UFD26J6W50SeQqJiG0y04kcdNzr6RRT7ZeJmrQ2V-QTS3Lg@mail.gmail.com>
Subject: Re: [PATCH 0/11] renaming argv_array
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 10:23 PM Jeff King <peff@peff.net> wrote:
>
> The argv_array data type has turned out to be useful in our code base,
> but the name isn't very good. From patch 2 of this series:
>
>   The name "argv-array" isn't very good, because it describes what the
>   data type can be used for (program argument arrays), not what it
>   actually is (a dynamically-growing string array that maintains a
>   NULL-terminator invariant).

I cannot help but notice that you still use "array" when describing
what it is. You actually use "string array" to describe what it is,
and at the same time say that the name should describe what it is. So
I would expect after the above sentence that you would rename it to
"string_array" or "str_array".

In patch 2 you also say:

> I settled on "strvec" because "vector" is the name for a dynamic array
> type in many programming languages.

in which you also use "array" to describe it.

> "strarray" would work, too, but it's
> longer and a bit more awkward to say (and don't we all say these things
> in our mind as we type them?).

It's longer than "strarray" by 2 characters only.

Also we still use "array" in "oid_array" which is very similar to
this. And the implementation is based on the ALLOC_GROW macro which
uses the REALLOC_ARRAY macro.

We also use ALLOC_ARRAY, FLEX_ARRAY, CALLOC_ARRAY, COPY_ARRAY and
MOVE_ARRAY macros.

So if you don't like the "array" part of the name, are you going to
also change "oid_array" into "oidvec" and for example "REALLOC_ARRAY"
into "REALLOC_VEC" or "REALLOC_VECTOR"?

If you want to change only "argv_array" (and not also "oid_array",
"REALLOC_ARRAY" and perhaps other *_ARRAY macros) into something else,
then I think it would be better to be consistent with them.
