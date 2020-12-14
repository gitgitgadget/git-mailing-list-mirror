Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC18EC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C3622583
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440156AbgLNQLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440153AbgLNQLz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:11:55 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFD1C0613D3
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:11:15 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id h18so16206324otq.12
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGPNt9FxBriMvVuuVPHORM67aFBO0F2V6cCKYZ7N358=;
        b=KOwPzxrcBKMTXa8MqquYrFBAwuqjNm7S4JU7Xu/BYJww20BVgtFjhPMdgrOhXKC72z
         Y1W5/N7n6vU5rhf7gitDJMutorItMYmZc3TA/bI+yONKpc+u13ZccsEc62CgTSRwMkqq
         2JfxArgnXCpwhy3BZtWd1wA9GWmQ0hW0N6tMdt13h0fhXwBYS0eQdWrR6m3e5ZJOicVB
         yN9bryFdAHPSFM4U8/1qcje7P7f5BvJswAq19TrusIYFNivb1dhwkoeixsGow+4zj8Pi
         m+LkRfxj7//YKEnzNMkJtKG5KOhaYNDsp0D/GRCfmtk0ou5n8SapFmPPltQuvUt+YZ74
         oQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGPNt9FxBriMvVuuVPHORM67aFBO0F2V6cCKYZ7N358=;
        b=jxeHvaGRIlWpFZOWdvdVIY0ZR7878IsvD3nA+a7KDt90/6MPYnXutjqd5iOcHXyaIT
         lg+alt6u6Y6clJStd91oTwYRbUc2WP0jDXCGJuDWGkv84lokBDG3irMlR3BxPM3RFh37
         IIWk5cKwf3pMv0dqAvpTMffOGIJQOYa8V/edzKKID2hoCvI3i2psGOTMmOUu0JxNMsXB
         dOLjrNewpcd6bNKIt492VrxeA75ihxKgThkh9IcgOnBMoQGqwUGF+h1+Ia6eWIQEtnBB
         fD04LrRcvMJohL3KA39ocXgdQMX7JxIgJ5XqkYhO2lR7Qkj/Btppiz6Gy7EzqUu054GS
         xPVw==
X-Gm-Message-State: AOAM530lJLHkh4dWASn/1gMSA2IYzamdsPd4KbM2UERfg2LGCREJdkD0
        kfhIcOY3ps8OSDzlCq+i2FwVoXfYDEbrXPgZ9K4=
X-Google-Smtp-Source: ABdhPJxKYNHT9g20+H6sKitYZfSrXQPRmZlWUeNrrFjWt+tcYDeKTpCBxadDzBd73Qtky5VN+ifXdmivLREFYgQcENk=
X-Received: by 2002:a05:6830:10:: with SMTP id c16mr19890987otp.162.1607962274455;
 Mon, 14 Dec 2020 08:11:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <b9e0e1a60b92a6a220193bf9fe80796df91126a7.1607542887.git.gitgitgadget@gmail.com>
 <84a4d97b-8496-4c83-5d32-19f57e17a871@gmail.com> <CABPp-BHa0zehQd-axmb4bF6fR4PTWwGu9uLjOzgTW8_Gu12iZA@mail.gmail.com>
 <7b0aafae-cd57-d4f7-ac85-238471428d24@gmail.com> <nycvar.QRO.7.76.6.2012141641230.25979@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2012141641230.25979@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Dec 2020 08:11:03 -0800
Message-ID: <CABPp-BHyNuhNtc6JQgQRBsQFbobzYyS6fs=nopRuv8c1+9zW_w@mail.gmail.com>
Subject: Re: [PATCH 02/11] merge-ort: add initial outline for basic rename detection
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Dec 14, 2020 at 7:42 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah & Stolee,
>
> On Mon, 14 Dec 2020, Derrick Stolee wrote:
>
> > On 12/13/2020 2:47 AM, Elijah Newren wrote:
> > >
> > > Sorry for two different email responses to the same email...
> > >
> > > Addressing the comments on this patchset mean re-submitting
> > > en/merge-ort-impl, and causing conflicts in en/merge-ort-2 and this
> > > series en/merge-ort-3.  Since gitgitgadget will not allow me to submit
> > > patches against a series that isn't published by Junio, I'll need to
> > > ask Junio to temporarily drop both of these series, then later
> > > resubmit en/merge-ort-2 after he publishes my updates to
> > > en/merge-ort-impl.  Then when he publishes my updates to
> > > en/merge-ort-2, I'll be able to submit my already-rebased patches for
> > > en/merge-ort-3.
> >
> > Let's chat privately about perhaps creatin
>
> Yes, I am totally willing to push up temporary branches if that helps you,
> or even giving you push permissions to do that.
>
> Ciao,
> Dscho

Given the amount of changes left to push up, I suspect there'll be
more cases where it'd be useful.  If I could get push permissions, and
a suggested namespace to use for such temporary branches, that'd help.

In this particular case, though, one of my two fears was already
realized -- Junio jumped in and did the work of rebasing and conflict
resolving for en/merge-ort-2 and en/merge-ort-3.  I didn't want to
burden him with that extra work, but what he pushed up for
en/merge-ort-2 is identical to what I have.  So, all I have to do is
push en/merge-ort-3 with the extra changes I have in it.  So this
particular time is taken care of.

Thanks!
