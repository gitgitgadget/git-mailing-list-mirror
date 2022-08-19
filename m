Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0A4C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348265AbiHSKaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347966AbiHSKaI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:30:08 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB17E1148
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:30:07 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3321c2a8d4cso110050677b3.5
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PntCmgTgUm594fFFE4XxXfgG9lwCTEAdmKUgfGTwUc8=;
        b=RQj4UWr9Df1gTt9oFJTwjEYhtA5QKvPaFFZRDlc3pqTHqIfHrKe0a/5pZC8XOFV4fN
         CLoNN3XBQKWV0pG7LxH+3TcIJWrCY2g72EnupUqAZvNKxZbcNEes4COlAuHZoNBKz7Nf
         cV6/QddGr6t/Yy1ayTWI1w2LurvlVrdxYQWUTjb1jWH71U09TX1z4LzgdhkbHd0J2R0Q
         CmNjauVRPIHfrpteTuyAQHb84vjkY2coFzEpYMkMRzCFD2okIiMdVtKyM04r5/SWVuQY
         4s1wnL6Wzo9mD+lazect8sSDmV3a01m8bMN3j5yGGfQu5imuy817Teu33bv7LdMuvz7Z
         i0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PntCmgTgUm594fFFE4XxXfgG9lwCTEAdmKUgfGTwUc8=;
        b=7V5+E6imNRV2T97Nl61iM8PlqsjBxs5FFb4Fjj7/4HEInv6c0P8+fVaWCjJSiAPKjq
         /iU1oFSOJgymI7JCmLHPq3ZgUFwKhqOk4AtzCBSudjeuohUqY1drRvUCGFk0q7meSeiC
         lq1VbMCKZWGCyoKX89ai6IBoqvW9yI5mYBibLuT+1KIyG8+Ufc0gbhZXpWJuxyTWQ128
         b4Z3rwNycJ3I6tvTkr4+sNABGCOI8GYRDLQI42U8kLXYeq1+x+8GQI/nUiUZ7s7/DN76
         1+1ebAgiiKZcS2taOEL+EhVBGBMUnehmAqMVapyVk9Q3PAwCQod+gOuqSMj+jeF8mvto
         HvrA==
X-Gm-Message-State: ACgBeo2SA0jp8E3ZbtK24E4BnkyG4yltyuC1vQCvbMt45xjTuvyGyT1n
        zUVGVWqrtk74oUlfG06YHP4IAg2CzJ1jEfVVFdE=
X-Google-Smtp-Source: AA6agR6fsyE93GDoRC3X7XKZV7XBwa1/6Dc7RFCFglFrJOKR1CHS0kZq6/d0TtSSznKjELIF88ZVx01XYOPotOJgM6w=
X-Received: by 2002:a0d:cc4f:0:b0:337:ef0:ad2b with SMTP id
 o76-20020a0dcc4f000000b003370ef0ad2bmr5358475ywd.365.1660905006383; Fri, 19
 Aug 2022 03:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1309.git.git.1660806376021.gitgitgadget@gmail.com>
 <pull.1309.v2.git.git.1660809243298.gitgitgadget@gmail.com>
 <xmqqk075qyq0.fsf@gitster.g> <CM9DZ4Z18PY9.1T2O8U54X66FD@cedar>
 <CAP8UFD1304rQh+9jMUkTmTvmNBxm6BNDt3=d07+C8iXSbJb2RA@mail.gmail.com>
 <xmqqa681nsrv.fsf@gitster.g> <xmqqwnb4n98f.fsf@gitster.g>
In-Reply-To: <xmqqwnb4n98f.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 19 Aug 2022 12:29:54 +0200
Message-ID: <CAP8UFD2kMXHxvg1tKVNLhY0Gweq2YrD7+tHmZXKwguYzRQ1Qpg@mail.gmail.com>
Subject: Re: [PATCH v2] trailer: allow spaces in tokens
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Maxwell Bernstein <tekk.nolagi@gmail.com>,
        Max Bernstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Max Bernstein <donotemailthisaddress@bernsteinbear.com>,
        Max Bernstein <max@bernsteinbear.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 6:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > In short, you do not support Max's patch that allows arbitrary
> > number of white spaces anywhere but at the beginning of line,

I haven't closely followed the patches that might have tweaked the
original default behavior regarding whitespaces in tokens, but I think
in general it's not a good idea to change the default behavior for no
very good reason, because it could cause regressions in the way others
already use `git interpret-trailers`. It could have been Ok to accept
that during a few years after the original implementation was merged
in 2014, but these days people and tools (like GitLab for example)
rely on trailers and `git interpret-trailers` more and more.

So in general I think it's better to have a more cautious approach
now, like we usually have for other commands, and only allow new
options to tweak the default behavior. If one such option appears to
be very widely used, then we might decide later that it should become
the default behavior.

I understand that having commands with many options might not be
considered by some of us as good design, but if we don't like that,
then we could perhaps just have only one option, maybe called
something like "trailer.tokenFormat", or just "trailer.format", that
would contain a regex that every token, or trailer, should match.

It's a complex subject because there are different and competing
viewpoints. On one hand it can be annoying to have some trailers
ignored just because they don't match the default format in a very
small way. (And rewriting trailers could mean rewriting published
history which is not an easy thing to do.) On the other hand if we
develop something like "trailer.tokenFormat" that allows everything,
then we might consider that we should instead encourage people to do
the right thing and to use as much as possible regular trailers with a
strict format. So allowing new options to only tweak things in a small
way might be the right thing to do after all.

> > but see a room for unrelated improvement from the current code,
> > namely, to allow exactly one optional space, immediately before
> > the separator and nowhere else.
>
> Ah, no, sorry, I misread the situation.  It's not a room for
> improvement.  It is very close to what the current code already
> does, i.e. to allow optional spaces immediately before the
> separator.  The difference is that the current code allows arbitrary
> number of optional spaces, not zero or exactly one.

Yeah, I think it makes sense to not change this default behavior, but
maybe, if people don't like it for some reason, allow options to tweak
it.

> So the only thing we need to do is to update the documentation that
> Max misread as allowing spaces at arbitrary place to reflect what
> the code has been doing, i.e. an optional run of spaces is allowed
> between the "token" and the "separator"?

Yeah, I also think that the documentation should be very clear (and
accurate of course) about where whitespaces and how many of them are
allowed by default, and what can possibly be tweaked by options.

> Anybody wants to do the honors to produce such a patch, then?

Ok, I will give it a try soon.
