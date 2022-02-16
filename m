Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27745C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 15:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiBPPlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:41:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiBPPlD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 10:41:03 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6082905A5
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:40:47 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id k25so168190ejp.5
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qe0unW/41Xtzn3wdiODhkwm/ZZVPBnbzZe/ODJfhGis=;
        b=BX0Mf+e1CHIxENk8kFNwgyvJFhmeACGH+hUaNdAIWlZOs64f7m7pAc/155zae1o69Q
         f+ydFkkSF8yXDk7mKdSBfa+f5x/n2mOgkyPdsExffUojoJv5dE9eyfac+7BronmC+Jbj
         b2YxYQhJHOp9pHf5UAjt1oYW2d4x20N6eW288A/4Jo/XfKDYiCxUiD5Mu6Pz5BTJfULX
         gV3Hv6Jca22EQkjy7OKSZco272s6TfbqDB/uvVnFI+4fzmocjbvyE2ISvKhTvzNlJgyD
         hk+KS9tgsA1bV47CXF+KVPPgJAfCRQ/PP9lVBSC9Z5Nn6X/dDt3WaYr99mdqngHTMMrY
         +O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qe0unW/41Xtzn3wdiODhkwm/ZZVPBnbzZe/ODJfhGis=;
        b=doK7WBHsDBuHxti9k3XR+5h9ITf079Sls84gA7A+7rLwHd39xxkwIs/2NgzreDd/+P
         c47DGaTGM33q90c5fJ3fremMS7NisnkstLp8URJGtJqElwMDMKBV2onDiE3HDiPw1ZTV
         M+qYRnvD/H8Nu8e8nbhhRhzZWgr5+HAKr2A7RHRiGyR2ww9x0WfnbtBRlkna/PpcRO6c
         xk4EFmqapGuZXx7tWP1bZHB6u7NhyNv+CDqW1HujHhPJLYRY+iqfISmXGfHUEqwbcG2J
         AhYcEau9EKO+vsNYbX6PZhvwzVRPJjGshf2f7vl2V7r2V5iE6+w62hvkvUJZVWatEPv9
         4EXQ==
X-Gm-Message-State: AOAM532rydRaKljaOk1k9uwHW2vN5HH4/07g9+T8aIY4Xp/VZ9vjQqhw
        mlpsv4/tLi19fzNOicjWUdsAufQHHp0jH405d2M=
X-Google-Smtp-Source: ABdhPJzQuA/DYrMoL4FuK5aA2MzRPGuzutJuOHYuzDdwcC6PuT6deUE/F0ImD+LNm8CwOWJnm1gmxxX0UpF7pIW63fs=
X-Received: by 2002:a17:906:5c4:b0:6cd:8d9c:3c7d with SMTP id
 t4-20020a17090605c400b006cd8d9c3c7dmr2885604ejt.554.1645026046195; Wed, 16
 Feb 2022 07:40:46 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local> <CAP8UFD1Mqv=MUcdjjhTpOkP0yWpnv9Jr=aB5G+4XmAqWsJBX4g@mail.gmail.com>
 <CAP8UFD2FfJA1ruhxzv3tcxhsssHBeHGCbGFDiz+-fFmpx39Gqg@mail.gmail.com> <CA+CkUQ9VTs7n9B+ApH1BYC=Uq4yvrZm0fsG0RJB8PVg_BBSCfw@mail.gmail.com>
In-Reply-To: <CA+CkUQ9VTs7n9B+ApH1BYC=Uq4yvrZm0fsG0RJB8PVg_BBSCfw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 Feb 2022 16:40:35 +0100
Message-ID: <CAP8UFD0cNLUSbiABnj3UTrAk36DTePNctNWn8U3wrXMGjA6HFg@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Feb 16, 2022 at 12:18 AM Hariom verma <hariom18599@gmail.com> wrote:
>
> Hi,
>
> On Mon, Feb 14, 2022 at 2:59 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > I added the "Unify ref-filter formats with other pretty formats" to
> > continue Hariom Verma's work during GSoC 2020. I would be happy to
> > co-mentor it if someone is interested to co-mentor it with me.
>
> Since I worked on this for quite some time. I maybe am able to provide
> some insights. If it's not too late, I would like to co-mentor it with
> you.

Great! I am happy to co-mentor it with you!

Kaartic, I hope it's ok for you.

Thanks both,
Christian.
