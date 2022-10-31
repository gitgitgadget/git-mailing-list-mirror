Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926CFFA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 14:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiJaOaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 10:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiJaOaO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 10:30:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ED86587
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 07:30:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q9so29965560ejd.0
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RN5uQaov/rNuDiBdzIQULpFsII2MCxcp7ei/zy4QLRA=;
        b=Sq6ixnYDtd+aECTJ+EDBLH8m/7ZhgIEp/PnKXbJbyVdPUtiDMxs1DroleVFYioX4ay
         ogu8N0yCd5QmC+7bylJ71pvf+4K7q+mR+kQ/Q4y9DQjmIRGtLA2NxeV6bpTOam4UvjXx
         56MZzyXniGJrFPxiIkOl54LmfEXLTjnTun0XpshO+07gS0lh8GdpBTEZiX39r6lxBSQL
         W4YYy9oklDjahxoniVGIMZoZqSletWBmvKKJccPPxgBkEONRR8SvQpZ2Kr/cHosheEbg
         1XZydhKnw9E3zMAHO//GnSt9htQX3Ju6F75kDiB5YJYfvty8+clUp1O4iwBkAHZXiG+/
         Yhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RN5uQaov/rNuDiBdzIQULpFsII2MCxcp7ei/zy4QLRA=;
        b=yONg0Ppli6NZg8c6xLcdcNSCH41Qv64oVoq/MZTpnrUhyq5mZnGSl9qlNiMxzka+pJ
         k33iXZQkFgCe9q1JkCzPE5JjE/yZzJzv0J7o352HUkGE+X1jAhc9UoGZI90r3qFyeBG0
         aPqoCJ+BS4YuVxCcSyv3OQ+kV3zpFAl3WGA7ASygn9tQbelqG060KPbSkPeHEgRobX0c
         na9IkSlbBPxBAz6gVgqTpZbyr4pNTapcPvHWfvX5QrNnmA900l/Ly1/xReQucE71jFzw
         MavUWetAseurIvZKfHEUHrEM+lT2WUiNmdeFLFW9B0Cf8ZFSuwVUcOJipVfAkiG1Ot95
         ZeYQ==
X-Gm-Message-State: ACrzQf3QPP9qmCJdECZnNMtrfNUeUnmT4CvbWld5A8wHchN0bx/SNi96
        eV+AIrUD28np4fjM16x5/mTqHIlCMe+6hoLn6+Gxpv/xQvY=
X-Google-Smtp-Source: AMsMyM7esvEbE3uM0ccFo7etgDIG/jA5L7fSL0nCya4MRg/OeLDfap7b1JaFCzGP2xlYz2wPeXcYzej8xw40M1VrIG4=
X-Received: by 2002:a17:907:9d03:b0:7ad:e310:ea8 with SMTP id
 kt3-20020a1709079d0300b007ade3100ea8mr1665249ejc.400.1667226612208; Mon, 31
 Oct 2022 07:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
 <4364224f9bddc8f1e40875ebc540b28225317176.1663609659.git.gitgitgadget@gmail.com>
 <xmqqczbdl6wl.fsf@gitster.g> <CAPOJW5yxRETdVk014gQYFud9_Nrt+OQGSVNQ8Pw2wDEMMFMm1Q@mail.gmail.com>
 <CAPOJW5z_ZRChNo8PGBmJu=vvjTL2cYL8oTdVwoDRh-UHt2Dy4w@mail.gmail.com> <58841dcd-e732-416f-5ab0-fd5a5d8de4c7@github.com>
In-Reply-To: <58841dcd-e732-416f-5ab0-fd5a5d8de4c7@github.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Mon, 31 Oct 2022 20:00:00 +0530
Message-ID: <CAPOJW5yEa9MZBPFRiKbaQXw3cv7NM6i4sbVh35CVhZ4JN_q8gw@mail.gmail.com>
Subject: Re: [PATCH 3/5] roaring: teach Git to write roaring bitmaps
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 1:16 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 10/30/2022 2:35 AM, Abhradeep Chakraborty wrote:
> > Hello all,
> >
> > It has been a month since I didn't get involved in any open source
> > contributions (including Git). This is due to the fact that I was
> > focusing more on mastering theories and also that it was a festive
> > month. So, I am now resuming my work. There are many things I have to
> > cover (including this patch series).
> > But before that I want to ask you a question - As you have noticed
> > already, the Roaring library has a lot of styling issues (Moreover it
> > is using C11). So Should I fix all these issues? or Should I make a
> > new library (using Git's compatibility library "git-compat-util.h") by
> > taking CRoaring as a reference? The pros are that it would be easier
> > to format the bitmap library specific files and it can use Git
> > compatible functions.
> >
> > I would love to hear your opinions. Thanks :)
>
> I HAVE OPINIONS! :D
>
> Mostly, there are two things I'd like for you to keep in mind:
>
> 1. Using the library as-is is a great way to prototype and dig in on
>    the performance measurement side. Can you construct or clone enough
>    interesting repositories to get a feeling of the effect of the
>    roaring format compared to the EWAH format? If there is no benefit
>    to switching, then we can save everyone a lot of work by marking
>    that as an incorrect road. However, if there is sufficient evidence
>    that it's working well, then we have established a baseline that
>    the full implementation should match (at least, if not do better).

Got it. Yeah, I can do it.

Now I am very much clear about how to proceed with it ;-)
Thanks for your reply!!
