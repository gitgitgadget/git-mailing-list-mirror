Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67E7C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 05:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868936139C
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 05:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243781AbhDFFQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 01:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbhDFFQe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 01:16:34 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF593C061574
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 22:16:27 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c15so3212676ilj.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 22:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eJWvDnhFZFSNJmXywFgcw9GXHGrcQCbzPfJ0tQYBVG0=;
        b=rmMGSedJ0oc3GbRa5M3CHAjPyXHVzClFG+WpTZbPiqur0/+0hsivVCvcx3F+Ftn8jI
         dlkPZB0CnMCXONyF0/zTdDfKp7RfEsorXKnyk5k9u0rbKaWXvK/7f8NP5WpFi+fbj+VX
         f1hr7eG+LFW0xsRBA/zG14fWMqvRAUPPia5BpsSEVXl4Fj/6alyhyCztj5Jky/oTZtew
         Tb/Jfy7a8PH5DkE0IeX4u8byxOEABiTuBAadpL5WIxg6ZkYzaa1OFRce7lzw7XDIdvWf
         giYrY57nVpWmt5WxwPXEQCA7DimQ5H0CWe3Yxbb+xq5MQ1CWcIktY7rvTy3t/jqkBqW6
         FjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eJWvDnhFZFSNJmXywFgcw9GXHGrcQCbzPfJ0tQYBVG0=;
        b=AmpnNHwTk/HFlxvNUw4naLS8+GP6Kel/XlTmCU/Vf1TYUSNDFn0PEr5x9JhH4bMcbK
         BLdWLQirRUAospgX558GnRSwnQar5nPCopp8u4S5w9C0tKZX/ZYrWbuDOV2DAm8ihCb0
         lTGBfzmTdHqwE6ZFB7WhCsxhw1wdqnnDwW4ob5LVWv7DC2aDnzd+2PKisahuEFid8OVR
         8mxu0RyxZ2xmsvApOItF/gFcwdaKInTOWcXDygA0caKpZLzUazsfo4k7ChynLfMocrCL
         jWCIFWHBII+aLhEFq79adbuTQCQEfX6lGc3tAPKXWdem23P9aTGnofsYZ/ikLOSTrVpL
         uhpg==
X-Gm-Message-State: AOAM532ss6WauyudeBbnhLLVbfpUyY7b69DOXwfqhekYA9ETif9qudhj
        aPepbrRWg/7iMAKF0Y0VZCpCuGpTJMmKw1q+ozY=
X-Google-Smtp-Source: ABdhPJwsZt/YEC9vnAVgb+PeyslF6kYfXlyNVC8GyZfPytSG270GW46l7/C/6q7SDjCGKRlMfXJbS4qXbllzKYwqFa4=
X-Received: by 2002:a92:3644:: with SMTP id d4mr23131344ilf.53.1617686187319;
 Mon, 05 Apr 2021 22:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
 <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> <xmqqim544dl4.fsf@gitster.g>
 <CAP8UFD0AZWey045qK=9h8nVCVwK09s=t-=Z7OVBpvr4LAvSLUw@mail.gmail.com>
 <xmqq8s5x7ht1.fsf@gitster.g> <CAP8UFD17=BxHRkb7nmC8XsiGet+J=Adzqv4P6d9jzgnKXT9LJw@mail.gmail.com>
 <CAP8UFD08Lagij6oqpOJkpbzMLRgQ08=mDfiyf1qXyD5VW6Ae7A@mail.gmail.com>
In-Reply-To: <CAP8UFD08Lagij6oqpOJkpbzMLRgQ08=mDfiyf1qXyD5VW6Ae7A@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 6 Apr 2021 13:16:14 +0800
Message-ID: <CAOLTT8TrJn+V-4WijCfi=q5JpvfBj_oMfWRx9TX-0Cs5uShmOg@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio and Christian,

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=
=886=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8811:52=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Tue, Apr 6, 2021 at 5:47 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > On Mon, Apr 5, 2021 at 1:26 AM Junio C Hamano <gitster@pobox.com> wrote=
:
> > >
> > > Christian Couder <christian.couder@gmail.com> writes:
>
> > > > I would say it would behave as if:
> > > >
> > > > $ git interpret-trailers --trailer Foo=3D input-file
> > >
> > > Hmmm.  That means that the descrition in the original is quite
> > > misleading, no?
> >
> > Yeah, I agree it is misleading and difficult to understand.
> >
> > > If it said
> > >
> > >         ... as if "--trailer" "<token>=3D<value>" arguments were give=
n
> > >         to "git interpret-trailers" command near the beginning of
> > >         its command line
> > >
> > > then that may be closer description of the command line you are
> > > forming, but as its written (with or without my attempt to clarify
> > > above), it was impossible to infer that you are behaving as if
> > > another --trailer option (with <token>=3D<value> as its value) was
> > > given.
> >
> > I agree.
>
> By the way it might be better to first have a patch that clarifies the
> existing documentation of ".command", before the patch that adds
> ".cmd". This way the first patch that only clarifies the documentation
> could be backported to maintenance branches of old releases.

This first patch should explain errors of ".command", and then explain that
we will no longer use it, right?

I find in the status update description:
"Seems to break new tests for .command variant in zh/commit-trailer"
I have tryed to merge my local branch 1e9a657(trailer-cmd) and
2daae3d(upstream/zh/commit-trailer)

I can't find any tests errors after merging, is there something unexpected
happened?

--
ZheNing Hu
