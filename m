Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE83C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 11:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1552224B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 11:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI+mUaPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393519AbgJTLsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 07:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393373AbgJTLsa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 07:48:30 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E0BC061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 04:48:28 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h10so1818633oie.5
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6l/FfOCkAm1trNQhHwVOeXBTsZnnv4gODMQTN6/ao8=;
        b=XI+mUaPFREQNA7gJqo2zDRl1tbSchc1uBaxJDT74l+PHlMtl4VoWGMP9o31pomV4Mz
         xHqFsndEiPq2HjaGnkx6uh1uhGU7cpbRndRJNO3mZ8lpN3DNkMiHyqV94jgJ5Irndu7K
         /f5nGmY8VOitOFoZh/a5K0PTXcovAdgLhmkgO+FrV6X2/BpujgbQZgIR1s2ModVAVYkE
         pHjTWUWczrLqlEe8XaZpGxD6X1xa1XVQAKH0O1dPhtj6a5petKj0MijsuEIdJG3CY4Tc
         VJkpN9aHbS095/Nnb1j/sT2fgSiVH3k47T6V+2o9Ooy7z7YrqHW8IogqQSdUvj6aWJP7
         EtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6l/FfOCkAm1trNQhHwVOeXBTsZnnv4gODMQTN6/ao8=;
        b=OuauhfEpq312v5zMB7++2RPhAAsltjpy9A51rcDM0UkJam2LFpHIZwGJTzmF6oU/pt
         8JCOmV+tTgQkmxlinNjfXqXKboJCgA01yCTyrbCVty7URpG03wTkGCoYM+A8p46lt1rn
         CaOk4B5ddO6t85/2F7Y0CwMYkjMnwIiloH6FysOGEHjdny1PvAo0z/vJrEjmIE751NfG
         qtBxCKhslCB7FEq+T3MUPMlSZPfW5N8i6j4+1KNrIBxQn0c3UNkHe/g4ZSH4kMSWQNuE
         WN51IkdcHJApGBak71ARdIJLnPQYs2P6FDv/Ko6Ecu0inPAdS3UbHty1yyyNq4C/IHzt
         Jm4A==
X-Gm-Message-State: AOAM531dUqCnMpEepIZhgKeS+oZvmtQCBbL7WdE6omZgCDhqajwu4HfP
        fn+/hW9SdCdKaUcBdD8VGgmg2yA14viRGBsYoZc=
X-Google-Smtp-Source: ABdhPJypiq9IJgIo9WCp1ycS8grFuYj2WkxGm5YL8GGAeXT/I4ZAY9s+RKnr/iZnHOp1xXOHNqLriCNbN3rRqDReG2k=
X-Received: by 2002:aca:5d43:: with SMTP id r64mr1537367oib.163.1603194507815;
 Tue, 20 Oct 2020 04:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201015175709.20121-1-charvi077@gmail.com> <20201017075455.9660-1-charvi077@gmail.com>
 <20201017075455.9660-5-charvi077@gmail.com> <cf26c039-0870-ced6-5347-ab3f24343105@gmail.com>
 <CAPSFM5ejRWUc2mCtqTPH4a6Q-WWUC4mQHU=bsHkjJOdG4kwW0g@mail.gmail.com>
 <3b501a3a-b675-3eb7-975a-cc9206f15057@gmail.com> <CAPSFM5fvBt+x840XOwzwPBvXK7_1qB-sb+_M3LoPuKv_P=VvDA@mail.gmail.com>
 <20201019202456.GC42778@nand.local> <6825abcc-b8e7-e539-6e8b-f46086a982d3@gmail.com>
In-Reply-To: <6825abcc-b8e7-e539-6e8b-f46086a982d3@gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 20 Oct 2020 17:18:16 +0530
Message-ID: <CAPSFM5daLAhNd9pmVq9-vd=1Ygx-PLKa1To16PDkUWUjebKsfA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5][Outreachy] t7201: avoid using cd outside of subshells
To:     phillip.wood@dunelm.org.uk
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Oct 2020 at 14:43, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Charvi
>
> On 19/10/2020 21:25, Taylor Blau wrote:
> > Hi Charvi,
> >
> > On Mon, Oct 19, 2020 at 10:54:57PM +0530, Charvi Mendiratta wrote:
> >> Yes, thanks a lot Philip I understood the reason. I will do the corrections in
> >> commit message and commit body as below :
> >> t7201: using 'git -C' to avoid subshell
> >>
> >> Using 'git-C' instead of 'cd' inside of subshell, to avoid the extra process
> >> of starting a new subshell
> >>
> >> [...]
> >
> > That said, a couple of notes:
> >
> >    - Your subject message is good. It is concise, to-the-point, and
> >      accurately describes the change. Good.
> >
> >    - The body is similarly short, but could be rewritten to use the
> >      imperative mood. But, it is redundant with the subject. The subject
> >      says "we are using 'git -C' to avoid creating a subshell", and the
> >      patch says exactly the same.
> >
> > ...So, you can do one of two things. Either you can abbreviate the
> > subject, adding the additional detail in the patch message, or you could
> > leave the subject as-is and delete the patch message entirely.
> >
> > Either would be fine with me, but certainly Phillip or others could
> > chime in, too.
>
> I'm happy with either, but I would suggest changing the subject so the
> description starts with 'use' rather than 'using'
>

Thank you Phillip, I have updated the changes in the next patch .

> Best Wishes
>
> Phillip
>
> > Thanks,
> > Taylor
> >
Thanks and Regards,
Charvi
