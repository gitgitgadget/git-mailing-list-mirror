Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AE9C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 18:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A955A60FE3
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 18:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242604AbhJOS2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 14:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbhJOS2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 14:28:49 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42711C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 11:26:43 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i11so8053414ila.12
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 11:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rG086dsGkZlJSo800qHLJhSDIaCmmSK9UZPgntPWyNw=;
        b=ggjCBSpKOwI7/lZ2d9EQHExHQUUTJXsQvCagknAq+OHLEy23Pn5GJC4xrlPMPh9fOW
         mjEfrA6N5fWwlBJfouAzOj3e9mfgYMRsX3h7QYLubbeEBTakIj9nO2pT5ShUNdi4+lnK
         PY0tpHbHMHJU5DBQ7ML5B5iftV2Cp5pboJ5llJ6gW6c6SPgm5WjzL4+sOI+a+9RLDsy/
         XPjPKKreZE85lElDbXLDbWYl7mGDZ4Yp+Eesh0uyJWd9++mnWYW7+S4ckMkswe9bHBKZ
         5zH+pxqB8RAmfNrUC2rEQSq0tk0evMjUUWqI6ab62v53WByhRlXDn+oHcgZyI/1DiSKO
         tPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rG086dsGkZlJSo800qHLJhSDIaCmmSK9UZPgntPWyNw=;
        b=Q9zFDg+TaR4DdxTQ6wrQnz7kaqQv/avyZYKHNrrDBaHmDYdqXuPvwqmcg+V4wncfd3
         Eq60HtTo1VbPxsYc4PTgnznOBY/Y5AlBurPIPVPibMFJjZEz/7iu/tpg08lAvCowvcVG
         LTYF0oG4ERFgFYC3M+HCuM6v9FchRd0xiaYNPlkPjoEkLOLvZcGwkKnO+RweI6AymV8P
         xeRI/Ofudy8pbNsv6uW1Fezb2CEPIhYDIYQHDxOVP54ito9gn+LfU5COPN8BfzQGbNls
         8te37UKv4crBL0kL8fiXgkn+jUor21MwIOYUDtVEclrTKh33AkLhkVJGzFsXy46CaD2L
         JzJQ==
X-Gm-Message-State: AOAM5315KBLsjBl4/aoejhIIH7ESfKBOGZ5W22qj2MD3c1g3NoHvuf6Y
        YLV22279USOpn0aO3Urj6xjHcrFj4ZUk+usl6HE=
X-Google-Smtp-Source: ABdhPJxjOzNLhhpyqz7d4gXDA+ECQlh6BfbyLehsbbIK6erGoW0gatWKYZAg3IxnoLXz6SHrxNPu1CyTAheaAYMNPnM=
X-Received: by 2002:a05:6e02:1c89:: with SMTP id w9mr4930999ill.237.1634322402777;
 Fri, 15 Oct 2021 11:26:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:c949:0:0:0:0:0 with HTTP; Fri, 15 Oct 2021 11:26:42
 -0700 (PDT)
In-Reply-To: <xmqq1r4m6u84.fsf@gitster.g>
References: <CAGiEHCtdjA+cVXjN43NPbSZfrDtr-kDtPMN4x_VTGSJuPZ8bcg@mail.gmail.com>
 <xmqq1r4m6u84.fsf@gitster.g>
From:   milan hauth <milahu@gmail.com>
Date:   Fri, 15 Oct 2021 20:26:42 +0200
Message-ID: <CAGiEHCsY_xQ8RECiX_+HFRrSL509TZEuaq6J2ZejC0Qrsj1p9Q@mail.gmail.com>
Subject: Re: force deterministic trees on git push - exact sort-order of filenames
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

aah!

thanks for clarifying this implementation detail

so git trees are deterministic already.
this makes my life much easier : )
