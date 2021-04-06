Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DBAC433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 03:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484E8613B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 03:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbhDFDsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 23:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbhDFDsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 23:48:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BEDC061574
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 20:48:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qo10so9268621ejb.6
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 20:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6McASzbaIa8ISYHXn89gVJKU7Idoa/ZVwQmMqaUsjJI=;
        b=HqVqJKiqqb6y20lfCpQr7QKwR3H/GdlTxFCYROCIiE45OcxQi/fIu2bX8kRdEMdkzG
         YmpbZbNe1gagqdVNEkK7GziG3Uk7HQ+/zfXuxaOSTPi/hs0s8fr2+nSNMYHxKLiAxEOW
         kvrQexi+5mUOsxvJZX0pmOmu7fEs7gbICLPMJszkVrmO9u1wIG5th2MBqmAl9E7P7TB6
         seM0TRS0Kncm05XXhpclzHw5xMADKPlt1E7JJNnA+96OJwte1yv+UViR4kV+74Q+CMzS
         M34SvYYwp5maCoaEbpqOC8ALnssDyMqd6IkE3qMkduqNCQmRytMCZ9uaZX2YNO3rmLgE
         +odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6McASzbaIa8ISYHXn89gVJKU7Idoa/ZVwQmMqaUsjJI=;
        b=LK6KbcqEPJunqB0CIFuOXuThU2Eg5Si/lK94MZJrZfwwFGP9gjXlZaUKjtmct9tSKg
         oSPvitTEW+k7H6GlfHDx5N0BUQCOfU/E84gbveM3yuuW4zpDASBRJd5+N/G22DrPXhQg
         qValrXEF91ijU5fmrKx5DEABR3UwrIc1nLJQXGAAy08hbxRgF4UbyW23FnV3zucz19bI
         0rn27A1ZBfhjuXhgnKmxajkraH0kVM15iOZRqnxJA0Vrns8fd6IGzgLDYQOn0pwaVqR9
         xDZgsma1eFLSUW/Pbfg6LaiHR4YONA+QF9zD6WcN/Nz0qkctDyEBZvTeWzEuHHe3NZq1
         uEEA==
X-Gm-Message-State: AOAM5331Bh32EKVlFPZD7DWT7ks3KjxxGMpsaIb46qtsnSyTLuAdUJ38
        Q06+rbdPlJFlGpy5F66HdHY02OiUX+Zsrbl2yyI=
X-Google-Smtp-Source: ABdhPJwpbfYSBYhWCJb+NgTnnJWKNuPmdPLgHCMmeXSMGskjZaYJHqn/anT3E/S3+u38CEdVKY8GSzokrTULZKZmZbc=
X-Received: by 2002:a17:907:8315:: with SMTP id mq21mr18390360ejc.197.1617680881989;
 Mon, 05 Apr 2021 20:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
 <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> <xmqqim544dl4.fsf@gitster.g>
 <CAP8UFD0AZWey045qK=9h8nVCVwK09s=t-=Z7OVBpvr4LAvSLUw@mail.gmail.com> <xmqq8s5x7ht1.fsf@gitster.g>
In-Reply-To: <xmqq8s5x7ht1.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 6 Apr 2021 05:47:50 +0200
Message-ID: <CAP8UFD17=BxHRkb7nmC8XsiGet+J=Adzqv4P6d9jzgnKXT9LJw@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 5, 2021 at 1:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Fri, Apr 2, 2021 at 10:49 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> ...
> >>         ... as if a '<token>=<value>' argument were added at the
> >>         beginning of the "git interpret-trailers" command, the
> >>         command specified by this configuration variable will be
> >>         called with an empty string as the argument.
> >>
> >> is my attempt,
> >
> > It looks better to me.
> >
> >> but I am not still sure what that "as if" part is
> >> trying to say.  Does it mean with
> >>
> >>         [trailer "Foo"] cmd = foo-cmd
> >>
> >> and the 'input-file' does not have "Foo: <some existing value>"
> >> trailer in it, the command "git interpret-trailers input-file"
> >> would behave as if this command was run
> >>
> >>         $ Foo= git interpret-trailers input-file
> >
> > I would say it would behave as if:
> >
> > $ git interpret-trailers --trailer Foo= input-file
>
> Hmmm.  That means that the descrition in the original is quite
> misleading, no?

Yeah, I agree it is misleading and difficult to understand.

> If it said
>
>         ... as if "--trailer" "<token>=<value>" arguments were given
>         to "git interpret-trailers" command near the beginning of
>         its command line
>
> then that may be closer description of the command line you are
> forming, but as its written (with or without my attempt to clarify
> above), it was impossible to infer that you are behaving as if
> another --trailer option (with <token>=<value> as its value) was
> given.

I agree.
