Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A57DC433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 21:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0EA610C8
	for <git@archiver.kernel.org>; Sun, 16 May 2021 21:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhEPVIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 17:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhEPVIf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 17:08:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF32C061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 14:07:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i17so4332255wrq.11
        for <git@vger.kernel.org>; Sun, 16 May 2021 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mtp3KKtbQpqMnRUpG66ddXQ9aP3rNHdtMjWWdzvIxMw=;
        b=GpijMtqLfWr2PoYTQgg8JEAfHlOhIZzDyn5bEqw+KR0ZkkZYwFtssCoPcQ6viywicD
         fv9tbbAFOjkVOlV9vnN2M/qJcsvC8Fso7Kv4FG0b3p1po7H7p0s8eMBWTYGYDEJt2kgd
         MQWuJjalmdwM15KlWiraIID/LDXiHHun/7kvCrpC7amULHXD7PAmknEEGzuHe9yBrtI3
         wOH6HICTFJc2j9EpSgYY3IIYbJ5kLyR0eR0wJX5KNvgQATT8vwqxNPk+M6jLGmj8z+qE
         lcl9pxuKQWFRgS5GB5AWO8krMoa0Kgkgb8cfeWsw65u3vIY05DM7UtJHfRxvpD/laZej
         yrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mtp3KKtbQpqMnRUpG66ddXQ9aP3rNHdtMjWWdzvIxMw=;
        b=CGfTTGbJjiXiMeuKvDn0M9DTqWrXF53nagutgPl2KfKDZRGYS9MYKL8dvyUj5Cx8Fs
         llpeoZkvyTY73geV1qBfr31E85duukxi2X2EVwun0mYc7l2pKUW9rVYeFzhAQAmPk0xC
         o0BogX7M2Tdy0+GWc2tdTeutx1l6VzzbW1h9ib+unIGGQjcLYOODJVrzfGHPA6GNvr9J
         GtAaAGYajXEArPEfJYUGCqWTEPGnnS8uezUMJnXPEpXrUShsOcNeT7a7Z0BLi9bL+kSr
         U/zdGoO9ZyJgdwczIRUgUz569tz0iED65Ew6GyRg/kF12o20zUywXCz1PC4tVEVfdi4n
         hE6g==
X-Gm-Message-State: AOAM531jtgQRqASXc4lRuW06RfIy++Nw5U1Y7iIOqxYcvvtEWA2CwCc4
        9jTzonLltfVoU4NuZoG29bkWJceTxIyOLcpsEkw=
X-Google-Smtp-Source: ABdhPJzJkU9LVHWqyVO86wczHwYvroIPWwPMYdjdUZSZHqlYU6LGt82T16HMS1csesq0eBhDFV9oPJtGHJdLAenHLwE=
X-Received: by 2002:a5d:5184:: with SMTP id k4mr25047741wrv.84.1621199237651;
 Sun, 16 May 2021 14:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
 <1dc7877e-adb4-e3f5-3b59-bd45f9673596@gmail.com> <60a1699eedcd4_109fc7208e1@natae.notmuch>
 <7ab75f6a-14a8-1aa7-ad0-20f484e2c8@crashcourse.ca>
In-Reply-To: <7ab75f6a-14a8-1aa7-ad0-20f484e2c8@crashcourse.ca>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 16 May 2021 16:07:06 -0500
Message-ID: <CAMP44s3AKCTjHshRz7Nc4KzSj3orBrrV24V1tb1gs3=Yh=PhSA@mail.gmail.com>
Subject: Re: [PATCH] describe-doc: clarify default length of abbreviation
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Anders_H=C3=B6ckersten_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git <git@vger.kernel.org>,
        =?UTF-8?Q?Anders_H=C3=B6ckersten?= <anders@hockersten.se>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 16, 2021 at 2:00 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Sun, 16 May 2021, Felipe Contreras wrote:
> > Bagas Sanjaya wrote:

> > > What is the birthday paradox then?
> >
> > It's a probability fact that goes against common sense. In a romm
> > with 23 people you are 50% likely to find two people with the same
> > birthday.
> >
> > https://en.wikipedia.org/wiki/Birthday_problem
>
>   i've had to explain the logic behind this to people who really have
> a tough time understanding this, and it's a concept that applies in a
> lot of places (surprisingly).

Indeed. Very very few people actually understand probability. Any
intuition you have is almost always wrong. Even professional
probabilists get probability wrong consistently.

I've found it's safer and easier to not trust my intuition, write
code, and that way get the probability (also called Monte Carlo
method).

I have a git repository with tricky simulations and I actually had
written one for the birthday paradox, but I had not pushed it. Now I
have [1].

The actual code is just two lines:

  birthdays = Array.new($n) { rand(365.25) }
  birthdays.any? { |e| birthdays.count(e) > 1 }

Yet our brain somehow has trouble figuring out the approximate result
of that computation.

Cheers.

[1] https://github.com/felipec/simulation/blob/master/examples/birthday

-- 
Felipe Contreras
