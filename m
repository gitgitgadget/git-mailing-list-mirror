Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78591C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 14:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3EB61494
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 14:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCUOr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 10:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCUOr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 10:47:29 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0861AC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 07:47:29 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u4so17876515ljo.6
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5/UzPQC7BzsidXfO3lYqBb38OQ7vVdqI6kd/9g9YB6g=;
        b=H59JKm1r1D+Qqfbup1s+cmn7gFkhMvKVIxSo/IEQHfRBBy8EabQLxmXq/kN50A6W1G
         OC1CyLBbOCFB4XHJZw8LrxaUPE/vVInQcm4FA2AS+F3V8l32GiizDmkv8iTycEeqf4jj
         cKISx/M4MyIt2asQ75wWavQy1DxCZCra5sWy1x/9PEtn7Wx2g/WKBvoP75gLEEXpFPPU
         rBRASWwz7oE2El1kI9U44I/tRbsRga+C2KKN7KI9hAYvJ62b3tQPgzWJsAAKVJ9HPWUL
         4sJ+KBKm0AnmeQ00pToRMkLs4YAfUgzYzVwjq3PzS4aQow7pDm/istVWiMGnna/Hyz5H
         NlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5/UzPQC7BzsidXfO3lYqBb38OQ7vVdqI6kd/9g9YB6g=;
        b=RY1oKgHsF/0JALC96C80mL59sMHvQ3blYc5VNQYtIIzyRrWTTOg1xrvfmtANjlhIX5
         Wq2gd7BJxE9ozi+EVbOKBRLR6IKWbawnfoZ8e+kQsY2lgo3JYMSanihyfkn4AZbwlj4I
         PnzDeDXMFqRWaK6KbuGeaPP0bXVeudtK49Op7M8XcwKLCN/pK5gWrIiBhw4EL8gzBiqa
         u+Dd51EPxPg/9aqShCvKB1RtKFRLRuCPnYNKQJUMffclYkz7a2KB1HT3BXWPz60dhMmU
         PH7/I/DlBhtpHWWD0iiBV81GJB3HbXUMl0e6yO+8lDQbjPSHFf2G6F20WkUWGa/1bYkM
         bIRQ==
X-Gm-Message-State: AOAM532d9BdqVLER6SspijSg8Fh1EW0BOcN0NsUD7W3hBv43OSgIPcUx
        KQR1EGlCArRQQuZMndIGvQvJMkBC8GDkocAdrpTOc9rgoRE=
X-Google-Smtp-Source: ABdhPJzhLFIAT1MBaUjfKlR/wGX5TudSQ9SWMzM+NRzmdgMl1YrOIJEktqUjvK9MXn87ZNyDFBu+/Kgu+W69NFKhXU8=
X-Received: by 2002:a2e:88ca:: with SMTP id a10mr6755283ljk.55.1616338047259;
 Sun, 21 Mar 2021 07:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.983.git.git.1616323936790.gitgitgadget@gmail.com>
In-Reply-To: <pull.983.git.git.1616323936790.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 21 Mar 2021 11:47:16 -0300
Message-ID: <CAHd-oW6hOQ5Qim1xMOJ23kjcpo1M-K1dDvzGKYjBCD9XoT2G+A@mail.gmail.com>
Subject: Re: [PATCH] fix null pointer dereference
To:     =?UTF-8?Q?Kleber_Tarc=C3=ADsio_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?Kleber_Tarc=C3=ADsio?= <klebertarcisio@yahoo.com.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Kleber. And welcome to the list!

On Sun, Mar 21, 2021 at 7:53 AM Kleber Tarc=C3=ADsio via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: =3D?UTF-8?q?Kleber=3D20Tarc=3DC3=3DADsio?=3D <klebertarcisio@yahoo.=
com.br>
>
> The malloc function can return null when the memory allocation fails. Thi=
s commit adds a condition to handle these cases properly. https://cwe.mitre=
.org/data/definitions/476.html

If you are going to re-roll this series, please wrap the commit
message body at 72 columns. This helps viewing the message in
80-columns terminals. (For more info on this and other commit message
conventions used by the Git project, please take a look at the
corresponding sections at Documentation/MyFirstContribution.txt and
Documentation/SubmittingPatches).

Thanks,
Matheus
