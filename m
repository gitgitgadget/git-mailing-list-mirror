Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B298C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EB365028
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCPFxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 01:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhCPFxi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 01:53:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083B6C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:53:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o19so20059128edc.3
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZZurzphF9V0u1lNutCzGdD2JKrkvNaMLtqEOPmCHOk=;
        b=pxZfDo7bZMX5dA6sn1nRXLGoEzAcwe81cJXboFWbnLOswXJhfJWRko6XAwy1jl6V3R
         z3XRLUxKAuGcHDef2kmq+05368M89L7pa5QUooFzuYrXNEudfCaQKn24WOli7hDkO9Co
         hdqmaPEGIewNFb06Rh5KpmB4ZoBXOdgNQ1fxG0fggdUOwuGm2EDJFXDlQEbuf/p/PBpX
         Ipg+EAmm4wzaw5kOqvXezaG9/fmdhFlezxj0iwDJvI6moFk9LNEfwOUMbmqUaExHixVj
         iTUH+40X0XPb9MKvx5OhP+3DKJM02YHHncRREcJUw+ecrqOEYoV5gxnI9I1PdrFuP7Uk
         SE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZZurzphF9V0u1lNutCzGdD2JKrkvNaMLtqEOPmCHOk=;
        b=VSFsvrlQZGAzskgCn7CWjGWIuelFaO9A0qkcffb97YG3L5qhMrWEjKMrNzfnMVYKdj
         xaMTS57A9PEfWOgizhNePJMsUufrvRz947deNJpugtYPrEcmO7yznBtYb4K9WDF0w6wX
         jzgReo0Y+dIxb9p5jeVZULj4HTMrCGQr7qLGwsMANsN9KmhUfHKZzk3UKVNWU1RX+P4p
         x0id21/o0oavLOjGBoUp3bA42cas5KKYeUypvM3TWFFWQU8UBq7UVM4/Ei1bTyGlL4QM
         l3e1A/QIzGMTdhd19sxb01nBz7IlDBupdMWNMWqsC7LqvWCB/E/p6Wr3tJB6G1FWDevB
         Yb9g==
X-Gm-Message-State: AOAM533K8yqQtnRvEcltPlwTC7mjedtokbOX/lIk7cLbE2+gvcPAeew8
        8S17Q4V7pCwNPF5pNobIEYvCdTu0xQH3Fkx9rR4=
X-Google-Smtp-Source: ABdhPJx03ZezozOrcMdVZABg60ZINVV22kVjRhASPmwQwAQ8q8bYNNmpryHiGJYhLXfZ3pMZ69bo4acL3+ntsYYzRkA=
X-Received: by 2002:a05:6402:1d33:: with SMTP id dh19mr33535256edb.362.1615874016842;
 Mon, 15 Mar 2021 22:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
 <pull.901.v8.git.1615813658.gitgitgadget@gmail.com> <68e0bd9e2d6f0a89d60db730eb77507d6a17a5ae.1615813658.git.gitgitgadget@gmail.com>
In-Reply-To: <68e0bd9e2d6f0a89d60db730eb77507d6a17a5ae.1615813658.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 16 Mar 2021 06:53:25 +0100
Message-ID: <CAP8UFD0tgXi6Hq42dzsAAGMOhvLxqaUuBqex0CreyRb_XD5rxQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] interpret_trailers: for three options parse add warning
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

On Mon, Mar 15, 2021 at 2:07 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> When using `interpret-trailers`, if user accidentally fill in the
> wrong option values (e.g. `--if-exists=addd` or `--where=begin` or
> `--if-missing=do-nothing`), git will exit quietly, and the user may
> not even know what happened.
>
> So lets provides warnings when git parsing this three options:
> "unknown value '%s' for key ('where'|'--if-exist'|'--if-missing')".
> This will remind the user :"Oh, it was because of my spelling error."
> (or using a synonym for error).

I am not against this, but I just want to say that when I previously
worked on `interpret-trailers` I think I implemented or suggested such
warnings, but they were rejected.

I think the reason they were rejected was to improve compatibility
with future versions of Git where more options would be implemented.

For example if in a few years someone implements `--where=middle` and
some people use it in a script like this:

git interpret-trailers --where=middle --trailer foo=bar

Then when such a script would be used with a recent version of Git it
would work well, while if it would be used with an old version of Git
it would emit warnings. And these warnings might actually be more
annoying than the fact that the trailer is not put in the middle.

I might be wrong and there might have been other reasons though. Also
things might have changed since that time, as not many options if any
have been added since then.
