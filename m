Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B42C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 06:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2A6610CB
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 06:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBGyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 02:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBGyq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 02:54:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB81C0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 23:54:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hq27so6169099ejc.9
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EkepKAdBAFidFzkaosJy0SzU8RvrWQWfeeUE4m7lshE=;
        b=FhxLApyFDiA7bZ4ZIaJ0u5IPSflk9cIp2/3iisB4/UgzQdsbIy94YUSQMeYmbIHl6G
         KCWeX95cqLv7bgA/ms8vDbcaukZCjbavboX/T6Pb3XXT/C9iLbLWtDYYyp0e5hVWxEjW
         I4NeR/Q0Nw+2LWs1dtXGIzn2Xvd4wbDpnhj4Er17YxY+VWl/hDCuPi9iwPp8W9d3aWd/
         buKTk0eaAcA/brTmW4tmJYquG8wXaXuEGXKuySqtu+qMAxdUs86nxOXORYv6rOzOuEiU
         3VP5jxCjoFrG+kbt0WeFCh1uCUzOdjQOoq+8dxuJgiYMeWQCrabUr1dSJu9UkTc4llFR
         ZgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EkepKAdBAFidFzkaosJy0SzU8RvrWQWfeeUE4m7lshE=;
        b=MfoTjN6kfKcix4La7FWcO63EtvaFztrD1FdjST9L7BYUdlLWMVnI4iSLJiYk7Chu0i
         K+Ugd4k5tm/i3lg8nDThH4ynigbUhYAX94/tFCegnCzIJgs358mT+efp49mVFXaoUy0H
         uSmse7/FS5gsgZwN4va2CyQyauM6LmtTMR4wG3pxbFpAEum7tAQZPyvlr988N0DLLgzS
         mRZ1SCbhmCcQFFSB96j91kpDIYLV8EzbuKbplMbeKFcDzS5HgiP3hAFyMcLBu98NQYsy
         DircLLlJzMI4ksIBbiE2+xYgnvQSuCfECPe/SWzsWGP2Czb7PJ8HLZm+/4vG76PQV9w9
         8N7g==
X-Gm-Message-State: AOAM530z2wfAmJMFGYhgznmJsQiGBUe42N7ZV8+WIsZVXoEUtkivvn60
        KOBo7SH3boauffyn7qPWgWfR2SJsUQaC+BT8wsQ=
X-Google-Smtp-Source: ABdhPJy6AnFpsJJF6d4AcBUmrsiAn84ka6Zsp1uaFEu7jXIWsYzx1w3PfLKEVGHOyvqMu9D8xIuhTmdDucyOsRikw6M=
X-Received: by 2002:a17:906:2795:: with SMTP id j21mr12700919ejc.283.1617346483843;
 Thu, 01 Apr 2021 23:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJqRXRgc1buSsG4pzr7G03BTfhf4AXWos7sfrwpdJbMMDcsG9A@mail.gmail.com>
In-Reply-To: <CAJqRXRgc1buSsG4pzr7G03BTfhf4AXWos7sfrwpdJbMMDcsG9A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 2 Apr 2021 08:54:32 +0200
Message-ID: <CAP8UFD0G6ywB6ATn7rtcwAkwZsD0a9bD5Qa_emDrMdvW+5fQrA@mail.gmail.com>
Subject: Re: Interested In finishing convert git submodule script to builtin
To:     Gagandeep Bhatia <gagandeepbhatia2303@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Mar 31, 2021 at 1:12 PM Gagandeep Bhatia
<gagandeepbhatia2303@gmail.com> wrote:
>
> Hey Team Git, I'm Gagandeep Bhatia, currently pursuing the 2nd year at
> Christ University, Bangalore, India. You can reach me at
> gagandeepbhatia2303@gmail.com or +919466935025.
> I went through your upcoming projects on Google Summer of Code, your
> idea on mixing desk interface improvements is really impressive.

I am not sure what you mean with "mixing desk interface improvements".

> The best part about your project's quite likely that if you=E2=80=99re us=
ing
> submodules, you=E2=80=99re doing so because you really want to work on th=
e
> code in the submodule at the same time as you=E2=80=99re working on the c=
ode
> in the main project (or across several submodules).
> I truly want to become part of this project for better mutual
> achievement, in the past, I have done a few projects, which will help
> me to contribute my best in this project.
> It will be really kind if you can share some more details about your
> project, so I learn more about your project.
> with regards.

Please take a look at:

https://git.github.io/General-Application-Information/

You are welcome to ask specific questions on the mailing list.

Best,
Christian.
