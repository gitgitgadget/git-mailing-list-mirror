Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFB4C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJQN7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJQN7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:59:03 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9595F22F
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:59:00 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id f205so2206339yba.2
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ58P3Ra4CNrdn+cnbGoiVNb+/J2gVUIhY125k2gFP0=;
        b=c9XsHaQ+nPuLfk1dln7CpiR/pFtw3uvDHxNI0MUxJWc6tH0tYxAOTUTss+PcG8wl6l
         RsENP3O5bVfLRA49ZLQ2E5frr7348DWh+H2OHbGs9RHi4VEwfu6mGUTKasYAS5BCc/OL
         eAseBk3P5ReNpHEJUXxegeDjiVIHB6kYNnmRM+dThrrxJkHidMIlRX+chdXdWmwH7mgH
         OuqgTsc7X7LkSF1RXi8OvHVjF0dYZHnAxUqc5jFeTJ//Dji6Im9oCwCKQ24wVbnyTime
         zwdPe3QR+vRYbMOWxlIVSKtKWdkqmgPIdf/MGBwqOnFJ03UQupAzOpfPKFvbWa76zKJi
         l0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJ58P3Ra4CNrdn+cnbGoiVNb+/J2gVUIhY125k2gFP0=;
        b=AL+rWykRb+ur25jk3u0G47iWpn58Y0OC4R6ZKnZJwIFO3Rm7AWXDEcMQ+uxYw6Sfcu
         HgIzZ33zKHq6vggB/9Z91eTlAgNUcwTi4/IG3wmt+A2L/dRdOyWxW/BLcqoUEDnGGu8N
         yHBq8F/nqvWlhOnfZ0cS5jxryi7ZLnoa3KPJoPU7QrDRlyIxUwf2tVKzX91PoSpVIrJ8
         2rkzzrlxFAMIM6jk7/E8PfNskQFED7cvQ23CMe+dDbJrB/IaVy3wQRA54Q0pcrk5NbS3
         MCb8qQaAP14zYND0COMGIR6tCBvD1GljDia0uj6qXvBQs8hyhLSqaK/Xzw9EzXU7B4ys
         qdRw==
X-Gm-Message-State: ACrzQf1d929feQFq7sy/1jZHUEZti+rfD0jcGDkqAMVi0nhQ6NRouhgM
        7vVtoK4jkJteQ89Gc5RoMWme+3czAnYmeKpIcHUysmyEr5M=
X-Google-Smtp-Source: AMsMyM5XeQsiBDV72ctgy6s5xQwdBMLBUyyzJl68Ye0NuAlolbqA5mJeFTgzOxjKZ9XeZ+Pkbz2DbtbP6VYW0CQmUCM=
X-Received: by 2002:a25:2fc8:0:b0:6bf:7267:3114 with SMTP id
 v191-20020a252fc8000000b006bf72673114mr9060576ybv.447.1666015138806; Mon, 17
 Oct 2022 06:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiEsN9dJj61VdnoT2=TYV54WTLA_-qL4CiT7=imuvuBdmw@mail.gmail.com>
In-Reply-To: <CA+PPyiEsN9dJj61VdnoT2=TYV54WTLA_-qL4CiT7=imuvuBdmw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 17 Oct 2022 15:58:47 +0200
Message-ID: <CAP8UFD1JwZU3DiimZOruLv+x18UFdK5phMxnWnHyiOyh-XR4Ng@mail.gmail.com>
Subject: Re: [Outreachy]Amend error messages and prompts of various (sub)commands
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wilberforce,

On Sat, Oct 15, 2022 at 3:08 PM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
>
> Hi team,
>
> My first microproject is still at seen stage, so I decided to look for
> a good first issue from the repo to get more familiar with the process
> of patch submission and I found I would be interested in
> https://github.com/gitgitgadget/git/issues/635
>
> The Git suite CodingGuidelines suggest this about Error messages, but
> I found that git-compat-util.h contains die("Cannot handle files this
> big"); which breaks one of the rules
>
> I want to change it to die("cannot handle files this big");
>
> Someone should give me a go ahead on this

You can do it if you want, but this would be a very small
contribution. This would be Ok for a microproject, but you have
already worked on one, so you should probably aim at something a bit
more complex. See the "Only ONE quality focused microproject per
applicant" section in
https://git.github.io/General-Microproject-Information/.

By the way, please put your possible mentors (Hariom and me) in Cc.

Thanks,
Christian.
