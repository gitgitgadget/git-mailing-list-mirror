Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F51C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 23:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbiBOXSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 18:18:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiBOXSl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 18:18:41 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D3DC1C9E
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 15:18:31 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g39so488141lfv.10
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 15:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2JywiGcCp/+J3vEqMWMhvBYx3DYCNVszlv1DBa8VwbI=;
        b=kjpT6tgiPXmiaYZaanQuLbZocJ3KXrHfRz1J5fKim9P7k/sDY2dCoGoUQ51Y49YVzN
         Z4GtQDVo8AQB8T8p3WMiQGXK1NoBJnJ3VQeYGW24Cs0BlXbTdLjSgV3T4DPU15tjPlzn
         3tOJT9PcSVhlw/ytaRQvlu+11OD2dMm06LqkbNb5z5f4ECS7o+jHQepi/P1LD4FNTxB+
         FHBNm3Kcy7094qxc5aNv+5GTuLnKJP+WwNc5Wf6HPrNz85cXgDYSIChn3bzi6v8Clwf8
         C4uUAGOxj7VhMLYu91y9lxicrVtXi1I3ENfHZKk15qxdeGWFDrHoljSNkK92x3gqmbld
         a+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JywiGcCp/+J3vEqMWMhvBYx3DYCNVszlv1DBa8VwbI=;
        b=cxkMlIsX5Bh4BQld8R2tSJOqzFp3iEbgHuAOvd5HMyJ8SLOhXpUMWXMvs7ZGD+IMBH
         AWBh2h4dkCodNajxSX758297KA66K6wHzEgScdwfUM8/muAIwYybeDiTM3gsCAzldjHS
         8Y5NCf5doN+AiTv6rI16nMfb5TiBJBc5ysh4bEbHNmLbltLPNiQUbpUnFScM2qqY9kqS
         H2uw5wzUe6pNMROiSi6nSQ2LSk6UPvN3sKR+Kg6HFei6Yp+0PSW3vrU68Aj8LkwqEFZm
         6Q3nLdl25hXHRE1lH6Cm/bewkBbdN0/8OGg/PSTvDikpKWgqIxGLUS6548Yi9Kti+IQV
         tY8Q==
X-Gm-Message-State: AOAM5301YxvSUtxvWKyRSBWRcpUbKRfrFaHsa6ou1MU6hZXN79/Fe5fR
        OgILivYKL9TaPrVafVnW+nceYVQ9RSq55rMi7Mo=
X-Google-Smtp-Source: ABdhPJxp6sdhWv0MgDkwFONjsWP2s2/pRm9HwVHHqK2xAHq5FJJYZoAIaTQdQfUOTSwpHoYU47iI+kIxakwE511mdvc=
X-Received: by 2002:a05:6512:a89:b0:442:d4fa:9bad with SMTP id
 m9-20020a0565120a8900b00442d4fa9badmr12048lfu.93.1644967109329; Tue, 15 Feb
 2022 15:18:29 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local> <CAP8UFD1Mqv=MUcdjjhTpOkP0yWpnv9Jr=aB5G+4XmAqWsJBX4g@mail.gmail.com>
 <CAP8UFD2FfJA1ruhxzv3tcxhsssHBeHGCbGFDiz+-fFmpx39Gqg@mail.gmail.com>
In-Reply-To: <CAP8UFD2FfJA1ruhxzv3tcxhsssHBeHGCbGFDiz+-fFmpx39Gqg@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Wed, 16 Feb 2022 04:48:17 +0530
Message-ID: <CA+CkUQ9VTs7n9B+ApH1BYC=Uq4yvrZm0fsG0RJB8PVg_BBSCfw@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Christian Couder <christian.couder@gmail.com>
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

On Mon, Feb 14, 2022 at 2:59 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> I added the "Unify ref-filter formats with other pretty formats" to
> continue Hariom Verma's work during GSoC 2020. I would be happy to
> co-mentor it if someone is interested to co-mentor it with me.

Since I worked on this for quite some time. I maybe am able to provide
some insights. If it's not too late, I would like to co-mentor it with
you.

Thanks,
Hariom
