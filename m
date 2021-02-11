Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20051C4332B
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 15:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A5B64EC5
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 15:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhBKPWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 10:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhBKPTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 10:19:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8E6C061574
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 07:15:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id w4so5883142wmi.4
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 07:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dartmouth.edu; s=google1;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSVODli2OAqK2qY99oPb7MRTKlkDC43uXFz7G9IHZsc=;
        b=t5WnBJdny3JIfg8hEip1JAVvqa3Uprx6WddCCw1N7wgHxLAsk8cQ2zap/HEttASOxF
         AmwqUNRYVTXLa9CRnn3SXPnm/icCmM08+kYWH3R0yyYzNCwHCR9gjrW1/lM9E9+aZYTA
         34p3SXos7j8AGskhscekrK7lz4MPXzzU3UlX+eeU9EH1brmabfUrF0Fp3Sfa8Oj4G0Sv
         sgKHU+fNJAckgL/ggZvoguA4L1UBQiIoMLagBMPY69Rp2JMRXUEDt0Dqspi+tB7Pijz2
         UOCQJuNmkSb7ruyTEXglzNLXevIwODeS9qA0GJ+4sbpOiDKFB5RYgF2aw2yfThFTtOY6
         kwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSVODli2OAqK2qY99oPb7MRTKlkDC43uXFz7G9IHZsc=;
        b=Tt3QkHxhDeZezZPvoM9XNqe9Z3cfJeB7kPy9j552o1Jv6gAgdzcDSA+VNZpzlK2ML7
         C68EbtOrNHELP1e0fipIDMWbhT3ErpZE9MGO6BPplp9P1taLgWdJqivKvDRvt5yFjPET
         q4T2OuxvmLUIy3qUwLxLXR0oesxR8OkRWSy5NIaqsv+NaPj/DuPE0JidlULwrwIiBkyW
         JbwbgCR8GybC8jl5TA1I8Wq0/rHXfqHZ8Ta4yYeolBHO0DWgcEcy4plVdGZguStPLFVv
         RpmBYQHPdf+dA5f1vcu8P/wda/VHZ/kMFsbjI3zl0Qa5IDUnM/i2BRG2z/JqwapEF8oB
         y7Zg==
X-Gm-Message-State: AOAM531W0OdQEx8k59pR1X04hJ78feUbKtyBneSN9bkXBISncUgt5Rjr
        uhwJi1PKRtC3uUZJLqAf2gIlej9d6nr2wO4xjDtQKw==
X-Google-Smtp-Source: ABdhPJy6Xy+eDMschPYd4b3SoRqL+3PMg+LZSZEctjiYqHboAgh/ZylAyjFctrxcyryH3FqyOpZOeWBPkP35mhAHK5I=
X-Received: by 2002:a7b:cb05:: with SMTP id u5mr5558959wmj.140.1613056525614;
 Thu, 11 Feb 2021 07:15:25 -0800 (PST)
MIME-Version: 1.0
References: <CAKH6PiWS5DvqctFnvZ+uyOzBs75hcy9HzbW_3gUCu+RE+oOYyw@mail.gmail.com>
 <YCAk8Zx8KvZhaJMx@camp.crustytoothpaste.net> <xmqqlfbz927i.fsf@gitster.c.googlers.com>
 <YCAzcs1e08Qnk2wa@coredump.intra.peff.net> <CAPig+cQ=nR7O+uNAufB7ohKN2ZoUP6n1aLbZBz2jeFKMFbaAcA@mail.gmail.com>
 <CA+kUOakk_=DRzroNb+0_RcfbkaOYLJxY=AtYMe4YQwuhB+_P_w@mail.gmail.com>
In-Reply-To: <CA+kUOakk_=DRzroNb+0_RcfbkaOYLJxY=AtYMe4YQwuhB+_P_w@mail.gmail.com>
From:   M Douglas McIlroy <m.douglas.mcilroy@dartmouth.edu>
Date:   Thu, 11 Feb 2021 10:15:09 -0500
Message-ID: <CAKH6PiXj39+8SQLiJfdDWyg=vmqiNAba=DKffg3adfztWJ0w_Q@mail.gmail.com>
Subject: Re: default editor
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric and Adam,

Many thanks for so thoroughly exploring my query. I have long lived
with the limitations of
invoking Windows apps from Cygwin. Fortuitously I could work around
them without resorting
to "command prompt", though clearly that isn't always possible. And
you have shed light
on the difficulty of the opposite: invoking Cygwin apps from Windows.

Doug

On Mon, Feb 8, 2021 at 5:03 AM Adam Dinwoodie <adam@dinwoodie.org> wrote:
>
> On Sun, 7 Feb 2021 at 21:59, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > By the way, it's also possible to install Cygwin's Git from the Cygwin
> > installer rather than attempting to use the Git provided by the
> > Git-For-Windows project. The combination of Cygwin `ed` and Cygwin
> > `git` works just fine (in my tests) once you configure `ed` as the Git
> > editor either by setting GIT_EDITOR or EDITOR environment variables to
> > `ed -l` or by configuring git itself:
> >
> >     git config --global --add core.config 'ed -l'
> >
> > (You would want to uninstall Git-For-Windows, too, if you have it installed.)
>
> As the Cygwin Git maintainer, I'd strongly recommend this approach:
> either use a Cygwin toolchain or a Git for Windows one, rather than
> trying to combine the two. While Cygwin and the Git for Windows
> environment share common ancestry, they have substantial differences
> arising from the fact that Cygwin generally attempts to provide an
> environment that's as close to Unix-like as possible, while Git for
> Windows is aiming for compatibility with native Windows applications.
> Differences in handling paths and return codes are to be expected.
>
> I expect it is possible to use a Cygwin editor with Git for Windows,
> but I don't think it's an expected use case, and I'm not aware of
> anyone else having produced and published documentation of the
> configuration and wrapper scripts I imagine you would need to convert
> between the two interfaces.
>
> Adam
