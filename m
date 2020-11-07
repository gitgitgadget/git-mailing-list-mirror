Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9FAC388F7
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 10:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE7C206C1
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 10:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzWD7eY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgKGKLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 05:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgKGKLP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Nov 2020 05:11:15 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67691C0613CF
        for <git@vger.kernel.org>; Sat,  7 Nov 2020 02:11:15 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id oq3so5401013ejb.7
        for <git@vger.kernel.org>; Sat, 07 Nov 2020 02:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LGhSa3gKKnCQ1BJgy5Jyam7IU4q6vAL66osEEhNBuQ=;
        b=gzWD7eY3xnN2Uiw+xBN4JmnirPoiZE2o38ilI9aVR7lA3hUQCZEHyVknzphw244YOx
         aJuyh5EPtKbiM0N86ewAsIDeLE0dsHnBSDlrKBEIRIUpm7Wp9qjL6aI8MP1z1OApXHro
         5kJEuLxRUQuTQQud9sqjti666+9tZqngFyvpt4byq3tLLv0b0M/rtEaMXcykcEmUeyYi
         udVA/GcRCdcJz2mwNjS01A5k72hlz2Z1jJni6/t9h0okbvFcCub+kacx6OfevbnqiBn1
         RIudaZHCY7565csoDuBWr1Bh0xP/o9ImtpZBHwGDsJkybnwo2cQ9spyhwXeUTrLCB5AS
         S1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LGhSa3gKKnCQ1BJgy5Jyam7IU4q6vAL66osEEhNBuQ=;
        b=PpQtFPrvh0eAd6y371w1fEriM846aYu+QeWVVCOswIVgl1EqZaOl1yblOP95YXecFv
         l0UlKNuoDCprzqRywbp4g9GqnyF6R6faG4BK9FRMquB7SGzbG4xM3EivaPfOjuEygNHX
         MPXNtb6kx2Pssqnjan4jy9qzEnOZwIdYfSDkEIZDa0gS6IKcDZJZSpyhlmSU8kQ5uKOV
         tLEGyZRRJC0UZaSSkycYwLYBN1gkJv8dEriTjiyn7YU26k9wHtZuEBcH89ZwPDtdeV/X
         rT+Rjtp1mF+LXddsDqVKzzvOSzOHKv48VMvRFmF8U3mdJcRVdUzSaeghvdsqzbBbOBYx
         ESIw==
X-Gm-Message-State: AOAM530ntakavacl9uyQlBKdWtIlec+rLaP8ce2vEJmBf2/NCvLqIXPP
        f439uc/CzVmzejAXFU/U/l1rXQI7UY5zO7KxIxbBrXpV5qL8JBWs
X-Google-Smtp-Source: ABdhPJyoATCz0GqIr/0NXxGXu5Va8TLu08WPGsyCY4oVrr86g7c9o0ndOiFDJJKO6xzvTkZzWnj/v5HeMa/yRZktT3s=
X-Received: by 2002:a17:906:c8d8:: with SMTP id gc24mr6453324ejb.417.1604743874034;
 Sat, 07 Nov 2020 02:11:14 -0800 (PST)
MIME-Version: 1.0
References: <CAKkAvaxrG0aYw-wo_WW7zSkX=mjU8ABgXGbbPCFOhMBa4WTJ+Q@mail.gmail.com>
 <xmqq1rh9ptka.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rh9ptka.fsf@gitster.c.googlers.com>
From:   ryenus <ryenus@gmail.com>
Date:   Sat, 7 Nov 2020 18:11:02 +0800
Message-ID: <CAKkAvawVbyTPxDFQMEJMh+dzgQ_C0PXtbQKMo8xMNjgL_buGng@mail.gmail.com>
Subject: Re: support comma-separated fetch specs list?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 4 Nov 2020 at 13:41, Junio C Hamano <gitster@pobox.com> wrote:
>
> ryenus <ryenus@gmail.com> writes:
>
> > It's nice to have negative ref spec support with 2.29 release, so now
> > we can have
> >
> > ```
> > [remote "origin"]
> >   fetch = +refs/heads/*:refs/remotes/origin/*
> >   fetch = ^refs/heads/gh-pages
> > ```
> >
> > What about having all the fetch specs put together in one comma-separated list?
> > Like this:
> >
> > ```
> > [remote "origin"]
> >   fetch = +refs/heads/*:refs/remotes/origin/*,^refs/heads/gh-pages
> > ```
>
> I thought comma was a valid character that you can have in refnames,
> so no, I do not think it would fly without breaking existing users.
>
> What problem are you trying to solve?

I guess the problem is mainly about intuition? Since comma-separated
lists are everywhere.

Personally I never thought about using comma in refnames, or even knew
it's allowed.

Well, now I know because, after skimming through the 2.29 release notes,
I tried out the negative refspec feature in a repo where I'd like to
exclude the gh-pages branch. But somehow I appended a comma and the
negative refspec to the existing fetch line, and expected it to work,
then, oops, I got dozens of those refnames with commas, and had to go
inside the .git dir and managed the clean up all the mess. And that's
for sure and nice and hard lesson :-)

Maybe the cause is also my ignorance or lack of carefulness to read the
docs, but searching for "comma separated list" in Git manual would
return hundreds of results:
https://www.google.com/search?q=%22comma+separated%22+list+site%3Agit-scm.com

So I guess it's fair to expect it to work in the fetch spec as well?
