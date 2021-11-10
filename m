Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB16C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 21:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB88611F2
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 21:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhKJVVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 16:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbhKJVVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 16:21:35 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B02C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 13:18:47 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id h23so3892269ila.4
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 13:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fRYRp2+iZKzUjcdIo8V5o21G4X/4c6EGe3EuxgVEmg=;
        b=dIq6UCsKkgWVEGMnAeKJ6o+cBz/mwTp9421FeH5Cfa25uT9HcwJ3nhHJD2nHlKyV6k
         2Wn8MBmmHCgXVta/GExPOVM3FKSkni0GZnbXrbj4T7YCtoSCtHMvftspElI4u4+uudV5
         pVfC3YDJ0+TCN/nSegnGOjqnUH6lNjDM9q0EusFaW2Rt5EOHpvJWcu1N6yjseST/Jdzr
         KH2ouD5LL/5VTCDNBvGJPuwR+9cyzPeUI77NXBWFgagQkS+xxiRbDTGkVdZkg1F+uCUV
         sCVqcbHRo/3AzF7os9jF0uenTE79n2TtySTQI9gdsWqltnjjPM1nR9XjubYyX0Wv59M3
         Kr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fRYRp2+iZKzUjcdIo8V5o21G4X/4c6EGe3EuxgVEmg=;
        b=K1U2Gmshm9uVU+2GPFoaD2pr27iqcmEeQ2wlgLB244WonDyl1xD/VtdIS3enboPRAv
         lPO+auke3BDIbTmExGuKhiPE8EJ4gTOyZJOfdN90X9/M87BiZaOupilXehCIfm7sZqSX
         EW62wdhjUeBOZsHShn+oTVw+oCa/Nc3vqylwnF3CuQDqMOZJmo/Pw4hnZnweQaAuVooM
         DXeGQCs0TjCimzYVRuOmS0YZzg7n1Jl690yoHJcAJ1sTEcd8tRVSS6d1wLpgLRxKc/xs
         u56eJnuE1k/hMF+9OpGeC1YsqJJ7w0UI72mn99VDKceykSWB3QvM++M2JO49L1SYMPOM
         x3rw==
X-Gm-Message-State: AOAM532L46dlwQpGygi56RHXGSwMQdX5Vyu3CGW2SOgexIFbLRV2i8bi
        e87feusQK0UPODpyGDJzJV+npbUIPAJ+qTUMm6vyBA==
X-Google-Smtp-Source: ABdhPJzAhZZI47TBymTVNslYmtZhbMMqf9Iv1AeBVUI9rjJXWS9hlIddMbreTBh7goVRNMGN8VEaxNf1sJpGzoVZNLI=
X-Received: by 2002:a05:6e02:160e:: with SMTP id t14mr1312596ilu.15.1636579127095;
 Wed, 10 Nov 2021 13:18:47 -0800 (PST)
MIME-Version: 1.0
References: <a6098f98946bd9cc1186ab9c83d917566c78b805.1635532975.git.gitgitgadget@gmail.com>
 <20211108230111.1101434-1-jonathantanmy@google.com>
In-Reply-To: <20211108230111.1101434-1-jonathantanmy@google.com>
From:   Ivan Frade <ifrade@google.com>
Date:   Wed, 10 Nov 2021 13:18:35 -0800
Message-ID: <CANQMx9VFeLAJQn1+AyF-rtXikpgr_LotnudPqOP=k0qwWgZdDA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fetch-pack: redact packfile urls in traces
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, avarab@gmail.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 8, 2021 at 3:01 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > +                     reader.options &= ~PACKET_READ_REDACT_URI_PATH;
>
> Probably worth commenting why you're resetting the flag (avoid the
> relatively expensive URI check when we don't need it).

Done

>
> > diff --git a/pkt-line.c b/pkt-line.c
...
> > +     len = strspn(buffer, "0123456789abcdefABCDEF");
> > +     if (len != (int)the_hash_algo->hexsz || buffer[len] != ' ')
> > +             return NULL; /* required "<hash>SP" not seen */
>
> Optional: As I said in my reply (just sent out), checking for both SHA-1
> and SHA-256 lengths is reasonable too.

Done (with a comment indicating they are the hash sizes of SHA1 and SHA256)

> > +     GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
>
> No need for GIT_TRACE=1 since you're not checking stdout. Also I don't
> think GIT_TEST_SIDEBAND_ALL=1 is needed - we should check that it works
> even without a test variable (and I've checked and it seems to work).

Done in both tests.

Thanks,
