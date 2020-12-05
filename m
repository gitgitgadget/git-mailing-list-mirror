Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C52C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 06:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6920222D2A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 06:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgLEGrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 01:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLEGrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 01:47:09 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A4BC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 22:46:23 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ce23so8139940ejb.8
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 22:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wt6eWiChLC8VRwwpId3mXaw8DV/N8QSNYpqRkApIluI=;
        b=g1DwpRxj5tDGpGxPqs9WnXTvI0TgSR4St2ypZ1bHUF5kut1BR9FgvP4Dgk+o5uiAlD
         bIAVKYdtxowRLfoOaucbcY8MKYLw9i2f37Jk6Pmb2jv3YtGDKK8VvxTuiByY35IrmDmE
         mF4P5mV+e8KZZcIirM0dfqHJVAInGpE9rX6VfETqVwKLtB4Ry8GVaCg83dMapBjPWPRg
         Wa14+ovoGftHPVl5MeGOtKy2/AwZ6PSNkVNPIk3bWp2Ov1PP7oI5viUgNUBWagwO4b8v
         4/Ik1WoudrB9M/VCftIQ25ov7eu/o3ur1HUu0PkiYDOa2OK/GlOuEXl5JJHcBfYyJIlq
         sK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wt6eWiChLC8VRwwpId3mXaw8DV/N8QSNYpqRkApIluI=;
        b=kiPf+pb9IJ6pS/jr17M8JPnY0FPfU+gWFl+xHDqdQteycXEZSKcx8E0vxPmUBud+J2
         fk+kif/C2t56pG0hdGIUgXFC397tjkpXkmVQQw6Y3BlA7mjhC9e5e9fu3/vhsb8ksM96
         RdNlD1oSvwOr6BHfRgnx3YNi+Ewpc0pNazIqngPCb87Kun+GukbaJdslkLql4RCzQEPi
         vyi6/b+QwLLJ3S1uYrrF8AxVcA2kiZpYMYwMmx1ftYxqSJECiOdm+ogK8LjTzHrYgdHc
         NjLG9XRGmGSdveKciVg1d4ygTcpsSc2b7VZbS6zL/wcBzC2znsQWpAKgFMnvtCpVXkQp
         OM/A==
X-Gm-Message-State: AOAM530kNKB2oTKuuXQScgCHYfAA9hV4mqQCJO4rb2+Dy7RxS0yBuBvN
        R7M2T80P/WALC5xLbdsv36RODfroCBNj0t6nB4wXWLhod76ypA==
X-Google-Smtp-Source: ABdhPJwZjRXNhSQfyFzO5YxONQheR/tcvY58JMlCg7i50By4JcJXnZgFQKC3x6K9lV+b4hw8w2IQBGtrtLaAkZovfmo=
X-Received: by 2002:a17:906:3883:: with SMTP id q3mr10259715ejd.160.1607150780969;
 Fri, 04 Dec 2020 22:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20201025212652.3003036-1-anders@0x63.nu> <20201205013918.18981-5-avarab@gmail.com>
In-Reply-To: <20201205013918.18981-5-avarab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Dec 2020 07:46:09 +0100
Message-ID: <CAP8UFD0iXTLRc9yeyT10w8e7s-8ygPh3A645ss=gXvBrK+D5pQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] pretty-format %(trailers): fix broken standalone "valueonly"
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
> Fix %(trailers:valueonly) being a noop due to on overly eager

s/on/an/

> optimization. When new trailer options were added they needed to be
> listed at the start of the format_trailer_info() function. E.g. as was
> done in 250bea0c165 (pretty: allow showing specific trailers,
> 2019-01-28).

It seems that  you mean this part of the above patch:

       /* If we want the whole block untouched, we can take the fast path. =
*/
-       if (!opts->only_trailers && !opts->unfold) {
+       if (!opts->only_trailers && !opts->unfold && !opts->filter) {

but this could perhaps be clearer with:

"When new trailer options were added, a check that the new option is
not used needed to be added at the start of the format_trailer_info()
function to see if we could take the fast path of writing the whole
trailer as is."

instead of:

"When new trailer options were added they needed to be listed at the
start of the format_trailer_info() function."

> When d9b936db522 (pretty: add support for "valueonly" option in
> %(trailers), 2019-01-28) was added this was omitted by mistake.

Maybe: s/was added this was/was added, this check was/

> Thus
> %(trailers:valueonly) was a noop, instead of showing only trailer
> value. This wasn't caught because the tests for it always combined it
> with other options.
>
> Let's fix the bug, and switch away from this pattern requiring us to
> remember to add new flags to the start of the function.

s/to add new flags/to add a new check for each new option/

> Instead as
> soon as we see the ":" in "%(trailers:" we skip the fast path. That
> over-matches for "%(trailers:)", but I think that's OK.

Yeah, I think so too. I wonder if it is worth checking that
"%(trailers:)" still works in the same way as "%(trailers)" though.

>  struct process_trailer_options {
> +       int have_options;
>         int in_place;
>         int trim_empty;
>         int only_trailers;

If all of these are booleans, we might want to save a few bytes at one
point by using bit fields.
