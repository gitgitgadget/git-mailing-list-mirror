Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83640C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiCIT6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiCIT6e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:58:34 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF0B62
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:57:35 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g19so3197550pfc.9
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Sg6xPXHgEF55yvM616b6x86ClzVmN8oHf5AcqHqa4s=;
        b=p7qigZMbjMBiInzJgYHf170uMzxCutr1AjSFniI4dfUmCF8O8L+fLSVsdju0WSDdR+
         XzKodnd08HfL6rGWaVu7B0rbs6aYivpaU+hwXbcx0kJ9ip1Lt5ixumfEE39U8MS93ClK
         YiCZYQxpz298YJlLaOTcYYRoHdDLxkv5/zZhArX8K9WHNO2TOwPVO/VOsCJqABR1RMBJ
         PF6snS7qjiMzBBobNmrlLbw5QnWKMOJKHP3QLP263gTgySaUbvEyMkoAMuWYJOYtfKrc
         g1bJnYp91O85ZE6hI42AxZT+Euu8C57XJ9eOMcC5wkd5Q5Oe/4znhygHPCqYYsYXAy4l
         BdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Sg6xPXHgEF55yvM616b6x86ClzVmN8oHf5AcqHqa4s=;
        b=KsOoyiShzKa9JsUAiDa67EtTJQn1iVKt2VsnJkCa/+1PaJRcaB55v/CYJ0k7dE5MK/
         QuQe7Uio3jv5pqTn/1nNG9cnAby4iYASvnu4omx6kt0MyuHB0QzDrjT1r+T3NIjGq8T7
         Zr9acUn3jU6FO8FT/bSugS0wgezqh5ooPjZzdYYELYn9rjO+s5U7kFt10eTcR1PLFryJ
         1pw2fB4rGjUrM3mufKkl7xLV+FYEqA5pUNVa1F/MsQOOdYx5ovkcacP6QaDBudC7AODI
         Dr0I2j+0mggxVbj1TfNI7IoEsB3hHfay3v1SypVWdyUTT6eJ018ls7xk3XpuY4oxfhqV
         DTCA==
X-Gm-Message-State: AOAM533NJoIuxKhDpTcbrPP9jnpoqXjS38am3l+gp+NTWv8RgQv6R4Bm
        lUZOwVJWtqb52vJbF4HcRXmFaQZcit2ywqSAzEI=
X-Google-Smtp-Source: ABdhPJwv5cE8njVQ54DHpJvgpi44AiRQ+2G9i4966ZjKLNDpMAe84A7yxHRTJDajxQWYvMOcB8HvGQsF4en5qEwTrWw=
X-Received: by 2002:a62:1d91:0:b0:4f6:f558:6d15 with SMTP id
 d139-20020a621d91000000b004f6f5586d15mr1141283pfd.79.1646855854932; Wed, 09
 Mar 2022 11:57:34 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <9d2e58ab-2d8f-0797-84ed-0c1e8941edaa@gmail.com> <CAP8UFD38WDwMKf3tMKGt6hMxmsuZk2JkDRJaOZsXFqHvbVLRLQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201281114440.347@tvgsbejvaqbjf.bet> <22e484c3-f313-5335-5f34-5df019b7ee98@gmail.com>
 <nycvar.QRO.7.76.6.2203091249060.357@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2203091249060.357@tvgsbejvaqbjf.bet>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date:   Thu, 10 Mar 2022 01:27:23 +0530
Message-ID: <CA+ARAtqjFhR2W8OjzGgPmtin4g_9M-8jjyJ0XsS1_401uxBrLg@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Mar 9, 2022 at 5:19 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Kaartic,
>
> On Sun, 30 Jan 2022, Kaartic Sivaraam wrote:
>
> > On 28/01/22 4:15 pm, Johannes Schindelin wrote:
> > >
> > > A project that I would personally find a lot of fun, with a great impact,
> > > and never really talked about on this list, would be to offer a good
> > > replacement for the `git daemon`: its purpose is to make it easy to stand
> > > up an ad-hoc server, to allow developers to clone/fetch (and even push, if
> > > that is enabled) via the network, unauthenticated. Now, the git://
> > > protocol has served us well in the beginning, but it is increasingly
> > > obvious that we should use https:// wherever possible. Wouldn't it be fun
> > > to have a `git daemon` that talks https:// by default, maybe even
> > > optionally offering a real web UI via gitweb? This is not as huge of a
> > > project as it sounds, Jeff Hostetler already did a ton of work to that end
> > > over in the Microsoft fork of Git: the `test-gvfs-protocol` helper is used
> > > in the regression tests to offer Git repositories via http:// and the
> > > biggest task to convert this to an HTTP-speaking `git daemon` would be to
> > > rip out the GVFS parts. After that, HTTPS support could be added.
> > >
> >
> > Sounds interesting. Would you mind drafting this into a project proposal
> > for GSoC. Then we could add it to the list of ideas document [1].
> >
> > Also, would you be willing to mentor a student in case they pick this
> > project? Or would you rather leave it to others?
>
> I would _love_ to mentor a student, but my time constraints do not allow
> me to do that.
>

That's understandable. Thanks for sharing the project idea!

In case anyone else is interested to volunteer as a mentor for this project,
do chime in. We could then add this one to the ideas list.

--
Sivaraam
