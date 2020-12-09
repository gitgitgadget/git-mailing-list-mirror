Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DFEC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D1223B87
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgLIGhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 01:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgLIGhI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 01:37:08 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44327C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 22:36:28 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id v14so417314wml.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 22:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IpgWUJPfdacHjQ4k6wKMLbc8Prqjh2Nx19YVeD3nOJY=;
        b=cwWxSxkV47qjXSHGhNMb0jxFFiPlnBpd3COZWS21LIj2mQl5XXt2O18AfV6CUEaK9m
         nYIf8ws/e9/3L+2azTEb4+XSOB2uqOTe69HJNB2u+Gqz/ZY4hGJCAkR8LvgFoFaLBjTM
         uuS0KKAaAAkSO/pzMlLVNdt6myb8hY75seIUNGbQKY/BTqjDPnGv20GVVQJFScfGqX43
         tyxpQrky4I78atjdkWl65ejII7lieSeWhy4P032IQhPZwILb9dtu5K/P3NF8Q250Ojcw
         QYR4Dq4gog7HBxvlbjI5HXzIFqQkCGmNGCklvnJ0sXGPaR/fGawzDKs+cKWUKoWjrQmK
         TjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IpgWUJPfdacHjQ4k6wKMLbc8Prqjh2Nx19YVeD3nOJY=;
        b=fiJ16yVWgIZl7AIq4p0tjs2DasXo8LIVZChE2sajPoIjA96l2YKsX0iqGJWqtHVsQw
         eYVpBouGMgGJTsIBoEK8Y634raWDPD7FIoF7ezxz1hvJqqVHIk7ahBYTkaIbLusHtKGy
         LmdYlyzEaMIaQPgwCJd7BcJtsejorMvIi96v2qrI08vJRc4SXUUx3ziz40cgM7kbrLVj
         tqWpPiwNgGFGZoRYxsktvbirA7PM0AoG9RQLTfUpPZRHHcjm8eNcgfCyVEpqxAfeJR9f
         2UO39979jWOuCVhdp6n5gPxEhoYAL+N6p9fjNJCeb1Ufb74B2XoWIkTQJE566l2sjOvv
         p83Q==
X-Gm-Message-State: AOAM530XYVYYbBArewD2fylWkIPy4bmfu2HPJiqRn74gaMzdfCj9dEcr
        fnw0t2a3l/+LCixpe3XdVMbYMzbwScgF5BqHO6M=
X-Google-Smtp-Source: ABdhPJxaNQQkkLEQnQ+O17N7HxQ0MMZ2IodrihXNqaIjhbuTkBzE4aTr54MrcFapXE11StPLtyf9U4SKCygdz7yQfFw=
X-Received: by 2002:a1c:df57:: with SMTP id w84mr996280wmg.37.1607495787054;
 Tue, 08 Dec 2020 22:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20201209002619.25468-1-felipe.contreras@gmail.com> <X9A1On3v35nEjL7i@camp.crustytoothpaste.net>
In-Reply-To: <X9A1On3v35nEjL7i@camp.crustytoothpaste.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 00:36:16 -0600
Message-ID: <CAMP44s0W3En0ZuNfBOOZhfeFUeFRvEFs7khAFRraocuDaFpbNA@mail.gmail.com>
Subject: Re: [PATCH] Add project-wide .vimrc configuration
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 8, 2020 at 8:24 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-12-09 at 00:26:19, Felipe Contreras wrote:
> > It's not efficient that everyone must set specific configurations in all
> > their ~/.vimrc files; we can have a project-wide .vimrc that everyone
> > can use.
> >
> > By default it's ignored, you need the following in your ~/.vimrc
> >
> >   set exrc
> >   set secure
>
> I would strongly recommend against advising users to use this
> configuration.  Vim has been known to have repeated security problems
> with what options are allowed in restricted environments, and even with
> the secure option, it's still easy to do something like this:
>
>   func Foo()
>     !echo >/tmp/foo
>   endfunction
>
>   nmap i :call Foo()<CR>
>
> When the user hits "i" to enter insert mode, they'll execute the
> attacker's arbitrary code.

v2 should probably deal with that.

> > We could add the vim modelines at the bottom of every file, like other
> > projects do, but this seems more sensible.
>
> We have an .editorconfig file[0], which is a cross-editor file that can be
> used to specify these settings.  It is supported by many editors out of
> the box, although Vim requires a plugin.  Since we don't want to support
> configuration for every editor under the sun, it makes sense to use a
> single file for multiple editors and let people configure their editor
> accordingly.

Sure. But it doesn't set cinoptions, nor does it set filetypes for
documentation and tests.

Plus, it's a single file, it's not like we are adding modesets at the
bottom of every single file like other projects do.

Also, we don't have to support configurations for every editor under
the sun, that's a slippery slope fallacy.

We can stop at 1 editor: the most widely used editor by developers by far [1].

Cheers.

[1] https://pkgstats.archlinux.de/packages#query=vim

-- 
Felipe Contreras
