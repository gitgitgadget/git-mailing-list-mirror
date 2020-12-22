Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1541C433E6
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 22:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7302E23139
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 22:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgLVWuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 17:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgLVWuT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 17:50:19 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3C0C0613D3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 14:49:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y19so35554022lfa.13
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 14:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Ne/WNH+yStUV/Gp72jffMrcVWeC3yS87li7TjMWnjw=;
        b=rVabJzcgEwnEt0+EieawkES7zIo5VOcMl37udz5M5kR9WSRE2QHsZ++p7F0LLuJx7B
         Fmy56UADnJJgYF9wQr2hProX7FlrDLdhhQ0hDKPPhIIszXwfk6+6mNgzk+XBhdUGblWc
         cUACsjEp9iUbXtUgDCOuh2akssxNdGlAewgSkLkXM3/j20iudMJS5OnFVN/fJRILszxV
         R0vD41PVmFC7mzZbOy+cs6QCnIL0DWD6RBAfnWNPH3YxRGg6cGZwdjMgbxkviAr9vZIR
         o7ZbFDQ1gdiQY9a4aUD0hqEnPuMwqHhR+DuffI0CqEtf1PX26FVQt+9YG+YQP8HltWzW
         BsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Ne/WNH+yStUV/Gp72jffMrcVWeC3yS87li7TjMWnjw=;
        b=j9WRapl/9pYcqkIlx35Gjxk7pi6DD/FS+XC4X8L2AnjP8siwZ2pVZ6uSUU6LlvdKtM
         XKkrr1aw2SS3p3wR4yZ42icAoZnIMGab9ZZlLYSumdRS6CWC/7levdXZfhV0ESoYOVZG
         vN7NERDX4IBk+DOPB68//2QHSn2kNRHku4yfNCYk5Hs8hFBsHm7wKQn/p4rEhB6OGNg6
         /iDOYrX5EtKDcQSXlJUAkk7gBtXRYPuOq8DRFjvPykM7sVHC/9GbzeW+NerpNqgY+6aC
         gjO4NfTnXxEAKSsuCx79BNu979mfqJOLnYUbdeoit2eB2LE/GgPorYwQ3HaeYzeMIRTR
         WjAg==
X-Gm-Message-State: AOAM533WjYies4LSYeHjg6slWMIRvIeX+I/EB3XRvj6ZFYqliNcn8YXY
        /ji6fvJnRbGZe0xkgjhpe8jvRuIwpH3AllJyOi+2Vw==
X-Google-Smtp-Source: ABdhPJzD4USFy8XB1OevPDuAdvR0yepU7TrPo6Nkd93GTjwdT+ZxqVFF+iGzRH1GUNSUpubhP96XApfJiClyzUZKZHk=
X-Received: by 2002:a05:651c:1386:: with SMTP id k6mr10304784ljb.113.1608677377148;
 Tue, 22 Dec 2020 14:49:37 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3tqugm.fsf@gitster.c.googlers.com> <3f0403b84ab06b9deb7c5c189792bebe1db586a7.1606866276.git.matheus.bernardino@usp.br>
 <CA+kUOamDD_SDNLk3sPSwNAojrAAP+g38MjkfG4JMPRTGOVAKAQ@mail.gmail.com>
 <87y2ht4pfr.fsf@Rainer.invalid> <CA+kUOam3h859kK76QuS9OFojeavXO15JNpinUQ0vPrAXrcsCoA@mail.gmail.com>
 <87pn354ijn.fsf@Rainer.invalid> <CA+kUOamSd_3z8LbYt8QRx==HauYXoCe95B5hAW1W-LdnwGP-xw@mail.gmail.com>
In-Reply-To: <CA+kUOamSd_3z8LbYt8QRx==HauYXoCe95B5hAW1W-LdnwGP-xw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 22 Dec 2020 19:49:26 -0300
Message-ID: <CAHd-oW7XJL_a1zMAUetHzvrh8DrLT4g2awv-fjbTdeLVLKVsew@mail.gmail.com>
Subject: Re: [PATCH] apply: don't use core.sharedRepository to create working
 tree files
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Achim Gratz <Stromeko@nexgo.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 22, 2020 at 7:24 PM Adam Dinwoodie <adam@dinwoodie.org> wrote:
>
> Cracked it, and it's a simple error in the test script. It wasn't
> readily obvious because the error gets silently swallowed, and
> presumably because the command isn't necessary on most *nix systems
> that have different behaviour for inheriting permissions, but the
> entire problem is fixed with the following diff:
>
> --- a/t/t4129-apply-samemode.sh
> +++ b/t/t4129-apply-samemode.sh
> @@ -78,7 +78,7 @@
>         test_config core.sharedRepository 0666 &&
>         (
>                 # Remove a default ACL if possible.
> -               (setfacl -k newdir 2>/dev/null || true) &&
> +               (setfacl -k . 2>/dev/null || true) &&
>                 umask 0077 &&
>
>                 # Test both files (f1) and leading dirs (d)
>
> It looks like the erroneous line was copied from t0001-init.sh, but
> that's a test where "newdir" is actually an existent directory, where
> we never use a directory of that name in this test script.

My bad, I should have been more careful here. Thanks for finding the problem!

> I'm assuming this is a simple and obvious enough fix that it can just
> get squashed into the original commit, but I don't know if that breaks
> things given the original commit is now included in rc tags. Let me
> know if I need to format and submit this as a full patch?

Yeah, since the original patch is already merged into `master`, I
think a new patch fixing the problem would be more appropriate.

Thanks,
Matheus
