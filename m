Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19344C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8544611C9
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhECPCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 11:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhECPC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 11:02:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D280EC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 08:01:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 124so8527555lff.5
        for <git@vger.kernel.org>; Mon, 03 May 2021 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4mrfow+QIJ4cGA4VVHCEwY/RQ8ZT6ZmbVr8KN4bQinQ=;
        b=ak5Nawaao43/Tw+FcRQXfny8dy/e5QcJ/IIBC9A0iOu2xWHD1YUmwZ5EmXwKc3iTn6
         wcrkH9WD02cxy9uwaOR4La8aBUnNNpML4JDP7qZgQymt3ISQdpoyNb9+2eEjYo+XLAUF
         I41rwCX2ScunVQmjOH6gTXOKrlgsxGClPAyKZfhn8IJdHbYBK/rQr8hOcRYwdx3v01GZ
         38/6hqlBY9xgXAe1yGA3gN9VugSxucCZsiU9iXzrh18FE/At1MQo+OQ5CryO7gTKBwx2
         4Yb6HSlc76OB1gpOIsNLpZ7cDem9hRiGFz0s4cCHhOQs/EdiamGsOyL21hFDwRQ+z5pM
         RHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4mrfow+QIJ4cGA4VVHCEwY/RQ8ZT6ZmbVr8KN4bQinQ=;
        b=l+HyVUvXlxJ+vaPgPxYz/Y8A8meHhvyZgysDcpDDLzvhqe69XDTr9aBc9OcWs6CxhV
         y0HJeDG7B9vLexNNaSQ4uhZeDFAY9h9YLukItIzh9Uc8I5dp86MUgSlT+HALfFM9GRTz
         ikDzWIVPQNG6vWL9Ad/CBAhMswh3FmdYVB5B0tZE1zUacF0g7ftX7zsfog5HfSZMLpys
         qOcajuf+e6BHGQBUVCDqoNFGORwcPTKbenOLsSrKQYsJqU7Tebxb5qOfWd//FZelEJ/Q
         oxeUegHivxMMqI2rP24Rj8IfWyxYeEjUDR9WVEi3FWDrGnpAmOlU91hWSMpI6VsEowi7
         0qBQ==
X-Gm-Message-State: AOAM531MYzM29MahR51KAaTtSYA25tFBFu7yQmDqzZ5Va4ks2PKYwolU
        2kCkD5t1rzNGiaxyCUOj5YsP58cdbgSMSzsCPMKgKQ==
X-Google-Smtp-Source: ABdhPJzlQ/GR+Rwkej+0K1IzXiDpT4GRwqjN+S+7M62LR1Xw9npLY12Z6aVHrEL5VQ+ifbX3I0Ov9UlTooE2y8zZT0M=
X-Received: by 2002:a05:6512:ad6:: with SMTP id n22mr13235877lfu.527.1620054090972;
 Mon, 03 May 2021 08:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619104091.git.matheus.bernardino@usp.br>
 <cover.1619818517.git.matheus.bernardino@usp.br> <20210502101239.dyevkjcp7jzov2rd@tb-raspi4>
In-Reply-To: <20210502101239.dyevkjcp7jzov2rd@tb-raspi4>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 3 May 2021 12:01:20 -0300
Message-ID: <CAHd-oW4_1V91dFM9O3Q1S1D5mkLvWeyC+nwSyxd38dgqKhS8OQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Parallel Checkout (part 3)
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 2, 2021 at 7:12 AM Torsten B=C3=B6gershausen <tboegi@web.de> wr=
ote:
>
> On Fri, Apr 30, 2021 at 06:40:27PM -0300, Matheus Tavares wrote:
>
> []
>
> Thank's for the work.
> I just make a quick test:
>
> "swapping" git.git between
>
> HEAD is now at e870325ee8 The third batch
> and
> HEAD is now at 7e39198978 The thirteenth batch
>
> On a Desktop running Linux.
> Using the git.git repo, mounted as nfs on an oldish NAS
> with spinning disks (and WLAN) gave this timing:
>
> git -c checkout.workers=3D1
> 2 minutes, some seconds.
>
> git -c checkout.workers=3D4
> 1 minute, some seconds.
>
> git -c checkout.workers=3D16
> 40..44 seconds
>
> Not a scientific measurement, just a positive feedback from a real-world.

Nice! Thanks for testing the parallel version and for your feedback on
it, I appreciate it.

> Good work, I'm looking forward to have this feature in git.git

Thanks :)
