Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EF6C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 16:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346008AbiEaQOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 12:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245339AbiEaQOK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 12:14:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5B995486
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:14:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id m20so27548388ejj.10
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShsZqbIRYtCM41eMdWLYovNJDTMDA2yOIiQigyaw3yM=;
        b=dug4pODODXUBY8xk71DbnK87m4ZuJeaFpVPrnrmLP/QMyZFELMTtWGAxBw8UZA4yNS
         RUfKNq933h13X7s7j7VywCi642wVDhvMQw6mjetb3PnnwXIRWcAEPSPiTbsuv9aDlfaH
         wg/FuAb4ejkFG2f69LuBI1FKwkPmi1dbaMhy9Tks9QkMI1sLpEIaWTUZEGoxatsxKZJC
         alB2lFlsPZNEBJSnY14i0o4Jw7zNBKu0snkarS0EldEFf5Obm944M8sh+7RI6s1+XK1I
         Wpf6DGDXnfuN/podAdzLl4w73UmiCFgEw3STlZ55Djc+RPxGBRepbZU/IrkXtoO6z2Vw
         a4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShsZqbIRYtCM41eMdWLYovNJDTMDA2yOIiQigyaw3yM=;
        b=aEVL5ZN4lbYAKSTcilVyfbXXh2AVRtpnhgq+nAH40HJYFlIQmBRFC8/O6w6tkHR9bA
         2HxkmCiAE53l24NBZmId3Ycm+DRa+dQkJ1Nf4zdkJ//i0LNRF0KaRsu7PI4MFzm2wkhY
         ox0xewlMsZbj7e5aIQyvh7PrAD1o0Gwe946Udf0QdkktGj8Wxb+ZRumRPeowSPRkps6q
         A4nGjk3I4LAFevVX7ymj0L0P31HnbyLwT1035oBcEaGjfVGOTaJNxi0zRis/MvWEXtt+
         y74w7PxVerEbuOIOszhyDrmZyu7f8eSfrM1varvEG2mnOLtZtOVRG2ywDEgyXNJYye6J
         Ljrw==
X-Gm-Message-State: AOAM531AXvC5HawLz6zOT4rIOJTjY8v1tX9uU94cPXAEtPor+fW62mqO
        aPkJy/Npe1Y75gV68bzUUxTFlKQup2hqv84mn1UZX7Y=
X-Google-Smtp-Source: ABdhPJzCXKu2Zi2isZk2UT/OWGUkuad4/2hkfJp6sb6PKbDP0deiAYEE7CPbQKN9D+YYJnPBbZlEsXa0Xw2d8o1bRLM=
X-Received: by 2002:a17:906:4ccc:b0:6fe:9155:47ae with SMTP id
 q12-20020a1709064ccc00b006fe915547aemr52417626ejt.246.1654013643308; Tue, 31
 May 2022 09:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <CALOmtcX4+ON7+J7K9X4rSYfWYnkciJdFE=v=Oeb7rUqwRt8_JA@mail.gmail.com>
 <CA+CkUQ8hf5m0GZEwcyqLgxMw1vavYey_R4P7oq8=OXc7iAj6MA@mail.gmail.com>
 <CALOmtcW=2skmUPXpnano=21i38b7sq2MEWQjH5yF2jLacZ8sQw@mail.gmail.com>
 <CA+CkUQ9ZnBXU8E=XKTk95hwM4qtZ1M_nX3LTCr5q5njPG3Es5Q@mail.gmail.com>
 <CALOmtcX7amyw3cAuthMPuagUVzJghybHFNy8ciB50yC5SCUwow@mail.gmail.com>
 <CA+CkUQ-YgmRa7ysP30GbkX07Cu_=EM5X66w3Vk=TpshP9xoi_w@mail.gmail.com>
 <CAP8UFD2uUFveiGDAbxObDOh_krmexuLe860Gu397e9KddH0UCg@mail.gmail.com>
 <CALOmtcVN8K59Zkv7XKM7w2zFCbdWKfKr=97-E3306nQHm4Zw=A@mail.gmail.com>
 <CAP8UFD1kinAwq7AL68QXqFR_dxkNFaTp2vP_DUU0KKqkbsXCDQ@mail.gmail.com>
 <CALOmtcWaQgrPTkRA6F8bL3Hp64cOxYrB4xHUa1WC+P34ZdFEbw@mail.gmail.com>
 <CAP8UFD1HGbbmJWB_TksGVLa-7nNBz5pdFi59Y7LP3EODF9Lztg@mail.gmail.com>
 <CALOmtcWFwfV11Vxf1xd_fC=HYGPNO1PtKT=E=-A104cGnAbv4g@mail.gmail.com>
 <CAP8UFD29NgffUBz0CMKyt901Z7Bj5osoBT-4Mfxfp0h_4Qo+Qw@mail.gmail.com>
 <CAP8UFD1f6KCO+=+ZoUFr06XUgEZYOZi8G0V+QKCK=bNbAE9VrQ@mail.gmail.com>
 <CALOmtcU-a0YUe2M5LwoRVU9PR4NOb8Ux-zEx144upo0oFz8PMA@mail.gmail.com> <CAP8UFD2P6seb60X9Y-an_1aVYjqLhD=g4q=xyC__WofjhA36pw@mail.gmail.com>
In-Reply-To: <CAP8UFD2P6seb60X9Y-an_1aVYjqLhD=g4q=xyC__WofjhA36pw@mail.gmail.com>
From:   Tapasweni Pathak <tapaswenipathak@gmail.com>
Date:   Tue, 31 May 2022 21:43:27 +0530
Message-ID: <CALOmtcWYebnpDyZ0UwkXkp_=7fA8ioLGVfrtNwMzuWO2jnJoEA@mail.gmail.com>
Subject: Re: Unify ref-filter formats with other pretty formats: GSoC'22
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Took a while. I hope we would be in a habit to connect to old conversations. :)

On Mon, Apr 25, 2022 at 2:07 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Tapasweni,
>
> On Fri, Apr 22, 2022 at 12:40 PM Tapasweni Pathak
> <tapaswenipathak@gmail.com> wrote:
> >
> > Hi Taylor, Hi Junio,
> >
> > I have added the mailing list (++git@vger.kernel.org) in this email,
> > hope now it lands better in your mailbox.
> >
> > I would be happy to take these tasks, not that I require any
> > mentorship but to work with folks who are involved.
>
> I am sure that there will be folks who are involved who will work with
> you if you select one of the projects we suggested. We don't suggest
> projects we are not interested in. The old timers who suggest them and
> are willing to mentor usually do get involved in them.

Yes, sure, sending the initial draft for git-scm.com in the next
email. I will soon loop in the plan/timeline for two other tasks,
described.
>
> > I have had times
> > where my work has not been seen for quarters and then closed after
> > reviews cycles, never let it re-happen.
>
> We cannot guarantee that your work will be merged, as some better
> solution might be found, or someone else will decide to do it in
> another way and it might turn out to be better. But otherwise you can
> be pretty sure that your work will get reviewed. It might take some
> time and we might ask for a lot of changes in the reviews though.

Sure!
>
> > It is a nice and respectful way to say, already deeply involved folks
> > as mentors, for someone who is entering the org or community. Not that
> > I require any tech or engineering help or otherwise, I mostly work
> > independently, just don't want to go my work stale and be clear on
> > what exactly is required (before or after a discussion, rather w/ or
> > w/o any discussions)
>
> I think we are open to answering specific questions about what is
> required for the work we suggest. We might sometimes be wrong though
> and realize it later, so the requirements (or sometimes the whole
> solution we suggest) could change along the way. That's how software
> development works. And even in this case the fact that we realize that
> our requirements were wrong is an achievement.

Agree!
