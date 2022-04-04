Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53654C3A59E
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379904AbiDDVVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379531AbiDDRZL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 13:25:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6F81E3E9
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 10:23:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z12so18575989lfu.10
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JMViY8HQ/dV+ch5OdZh8kpHHlKQAGjz6CM/BDe/ogcg=;
        b=E7xJ2X/6xqBD6ja7m4ZlYRX3ECVg29050BO3HG2+C545TavD5jR1Mp5B1P6gIx+2H9
         gsIKAxp7jYs5gws85c14KtP2JR309rdnk9aGgvgMCWS2OwBq/YlQ/Sjy5/rzGm4fAb6W
         eQ+Q7f4C37s9f50mO94sWnOi+8RYkINWdm9FvKx+7+8no3btrR7jtvO2vd/juHvASnSv
         1rDKjHCx0X8OjC98UcRJEvqN3hT/bjM0CLlftqvwDW/eMEGBpgoc7b8R5aBD4NpNMOnh
         XBEj2ztsKFV50p1hwO8RZ55XH39569493PlMRf8oEoKgOa1nlCGm/xYoZSSR+LQT7n/y
         uBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JMViY8HQ/dV+ch5OdZh8kpHHlKQAGjz6CM/BDe/ogcg=;
        b=V4+IuAK13GJwHfJjMxqH9Cpe6AlZokvAfjHr6VFBVd2LNG2LOJQ5seLFi23RqLVdOf
         NXyP9Zr1H4Kwq0EfmIEtejdPGpLOfMJHh1LiugM/acqmc8tzzuwJJaKbBXkzq1r2s/Wi
         OfOqTYM9a8Xp9TW1s3RM8MmUrymGTjRO0um3vilhdJw/5RzCO8BZFyaB84WKJyl3fRuU
         AbKOo26l01T13CPiM3fKvGKAkbmeQfZWakZ6OvLD8cNOtAeKzRIPp3x+gFh7JloST8/u
         0aRHfu5qSw+wtTNp7YwPQQt/H+TNH+R9YAU44aBLBFK3Z/ewqQJGQdtTlAKqJuuUeKbH
         sPvw==
X-Gm-Message-State: AOAM5314iZ54w5N4oOExCFqLXoCgDl6RsIiUUVccz/g1xTq6gtF2pVAU
        L6KgY8U+XgW8hg5YLVE9hfc9PWvoj/vy+svaUkA=
X-Google-Smtp-Source: ABdhPJzpgULJltHZ9VVYg8zhqgb2luv8zlCTl7LpJmb+8PfhFn75FB1Yqx7hPLoyXv5ek3WMxpMtgS5WV4EvkUt3Sjw=
X-Received: by 2002:a05:6512:b92:b0:44b:36d:27e0 with SMTP id
 b18-20020a0565120b9200b0044b036d27e0mr329663lfv.537.1649092993331; Mon, 04
 Apr 2022 10:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220404055151.160184-1-alexhenrie24@gmail.com> <CAPMMpohXLG2BsO2N1He9aBxm_VuQGCtf32AC67jVkuHQnwVw8A@mail.gmail.com>
In-Reply-To: <CAPMMpohXLG2BsO2N1He9aBxm_VuQGCtf32AC67jVkuHQnwVw8A@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 4 Apr 2022 11:23:02 -0600
Message-ID: <CAMMLpeRQm=PwvmvEWy387oFsjQXNgPnbgqSnre8Hz7iLJxPM_g@mail.gmail.com>
Subject: Re: [PATCH] convert: clarify line ending conversion warning
To:     Tao Klerks <tao@klerks.biz>
Cc:     Git mailing list <git@vger.kernel.org>, prohaska@zib.de,
        eyvind.bernhardsen@gmail.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 4, 2022 at 9:22 AM Tao Klerks <tao@klerks.biz> wrote:
>
> On Mon, Apr 4, 2022 at 7:52 AM Alex Henrie <alexhenrie24@gmail.com> wrote:
> >
> > The warning about converting line endings is extremely confusing. Its
> > two sentences each use the word "will" without specifying a timeframe,
> > which makes it sound like both sentences are referring to the same
> > timeframe. On top of that, it uses the term "original line endings"
> > without saying whether "original" means LF or CRLF.
> >
> > Rephrase the warning to be clear that line endings have not been changed
> > in the working directory but will be changed on the next checkout, and
> > explicitly say which line endings the file currently has in the working
> > directory.
> >
>
> I think this change is generally a great idea (I agree the existing
> message is confusing / not as helpful as it could be).
>
> I think we could do slightly better than "the next time you check it
> out", however, in terms of clarity. I just tested and the way I
> personally would inelegantly describe it is "the next time you switch
> to, merge in, or rebase a branch that has different content for this
> file, or explicitly check the file out". I understand "check it out"
> is probably technically correct, but as a user, I'm left wondering
> whether that's the next time I check it out from scratch (i.e., switch
> to a branch that does not have the file, and then switch back - which,
> incidentally, is what I originally *assumed* would happen before your
> patch - I had never checked), or the next time I switch branches at
> all, or the next time I switch to (/merge in /rebase onto) a branch
> that has different content for that *specific file*.

I would prefer a short message to a long-winded one. How about "the
next time Git touches it"?

-Alex
