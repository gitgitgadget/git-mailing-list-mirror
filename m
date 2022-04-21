Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CBEC433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 08:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387095AbiDUJCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 05:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387176AbiDUJCH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 05:02:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0722514
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 01:58:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t12so4236702pll.7
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 01:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCcNNkxDRbOknvFmrflO08ozujgzlpuJT9qRfprrj6E=;
        b=qOLj9IxoeLdfUxE61UjvdzkbzDCq6Xl4kY/kyb3+jK0ZmHaD21odrfrPSLTwSmy+Pl
         /3uwt/axWspSOjpiiLNyDxnenMq69mPqnAVyktjbm+1Q3TWzwkY1Z92kRm5+kdfw1XB3
         mpNLe9H55vqCW92bL2UiiG5sZSjMymuI3p52fduRcO1Fiq016B6dZC6vTxtWeustxOJe
         dpkFm47CyueHyNFEdijb3nyX+yuJjPzm5LdBTpTG4u1PPe7DvgnR+3cC8mryhhacVdS/
         voJzqfRC1/QvZDW35tEuLn4ICQtZlRxhiuQilj52KLf0VTRFYXP2FGRPW2jdX5SBvxBq
         Fmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCcNNkxDRbOknvFmrflO08ozujgzlpuJT9qRfprrj6E=;
        b=kJXUEcyJVc2dx3x2qDlisx6OBLEQ5dG95perC7Ksf41II8G6VHmCyzBxUF3KT6CQfM
         x6E9K7wdE2vd6FLFwZ1CwD1ISLNNYfuhdXC0jEb45XbI+s3nh0izX7qwCyreHwy3OIWI
         fRrYGYB6VtJXUpkTbXT2f0HOLA2BF6P06iQ96UNY8MmbvnA3P7kRHoRmzsv+9dCI2zz5
         yEa/iyKbuE2jnGtirn2l44NbaMpPYCmyT+euIsW4JJOfT+KLIf96iIyR7lJYFecKhkYh
         UqRCqeYkxJT6h6RSLEuLtKoLCyePVPePTwABXydqPnXV7QT0Mw2encPsT2ngKedk+P3b
         XcjA==
X-Gm-Message-State: AOAM5336hbSNthnhg7MhY5aYDy4Rexu/I+6dk+VZAoB3agOCz4eNsT1Z
        6HhUENmcUcJZ3lkCNeOWmKyEVyML9p7Nz7aEJ2E=
X-Google-Smtp-Source: ABdhPJw4WwiL2hrMvJ7FHIQmK1DrCvqq6hTsAxNSjT/f4Cj7+Dk0ZpYRUQTVRFmHXlNaXjhvHymai7I0UEMGaRij5XU=
X-Received: by 2002:a17:90b:1d0c:b0:1d2:a91e:24dc with SMTP id
 on12-20020a17090b1d0c00b001d2a91e24dcmr9370149pjb.165.1650531530418; Thu, 21
 Apr 2022 01:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com> <E6525E16-10E8-4C08-A596-6C16AD31F62A@gmail.com>
 <CANsrJQcq-nWPaCyM3qR1d_u4U8wERdKbxFKMVK6Db9uWtyoFfQ@mail.gmail.com>
 <6ab769f8-92da-774f-9d33-4ab5c1eaab6b@gmail.com> <CAABMjtFw3dXd8kp82Hqz_NDMxV-U4mDD5y_MrxPj2bvinR3OXQ@mail.gmail.com>
In-Reply-To: <CAABMjtFw3dXd8kp82Hqz_NDMxV-U4mDD5y_MrxPj2bvinR3OXQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 21 Apr 2022 10:58:39 +0200
Message-ID: <CAP8UFD0i4vC3uwmaqMaLRLzCBYwHWoEmbJrOz_69gQcxnqkM8Q@mail.gmail.com>
Subject: Re: [GSoC] Contributor candidate introduction
To:     Labnan Khalid Masum <khalid.masum.92@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jayati Shrivastava <gaurijove@gmail.com>,
        Plato Kiorpelidis <kioplato@gmail.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Jack McGuinness <jmcguinness2@ucmerced.edu>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Apr 20, 2022 at 8:31 PM Labnan Khalid Masum
<khalid.masum.92@gmail.com> wrote:
>
> Hello,
>
> I shall not be able to participate in GSoC this year. I'll try to contribute
> and understand the codebase more instead and try to participate next
> year hopefully.

Thanks for letting us know! You are very welcome to participate next
year and contribute in the meantime.

Chances are high to get accepted for those who start getting involved early.

Best,
Christian.
