Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78743C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 07:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A0A64E00
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 07:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhA2H5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 02:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhA2H5H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 02:57:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464B3C061756
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 23:57:53 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ox12so11681295ejb.2
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 23:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNMuqK7qGHaKdjbQXHq9OSpMwFKc7WcnScDXtKXgSyE=;
        b=u5yYFiyi2l55uk7LVx7Y4geG7KCBZgdtAuIfd+CpTxaCp91/LeoQXFOobibvGwoo1i
         YSXjEP01S8iGGTp3zaQU9TWyJID20IcwrINVTDjRqRVeicIZRUnQtUhFuEZCx7sJNKyv
         BWxmw1pd0IwWZ/RTBErFWUlJOsbdaLqy1bWFwHihSD//pnDdyz+0P4tZOICnlAagllw2
         +cIENOZ779DhFRO3mnWJYwqD1TFOpqX6wBzk49VDVJwGL7ZjKOU5obYROvzmpqv90iKi
         uM96PnPA5tKfc9KtytEPi8Mhje6snpXoyE+3V3YMmsQ+xHTPuuvbccGzebNeU249gd1c
         1LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNMuqK7qGHaKdjbQXHq9OSpMwFKc7WcnScDXtKXgSyE=;
        b=N2RzHSAqB1VwqvQczyIpQWgVZ17PuT/5Wb/Co2Xut2F0HkbbhRwz16v3UE+lwv65v/
         e3AulcAW4P6Pw6M+6klJ++ur7nlqMax4VOsi4tOoz3bABErpawrbnp2OisNeyeb6rilC
         RazBiUWEMdNnzFWai4xQ0QkXjLZG2ixGHVZFpM5fdalUMSRKcNMwyS4rhzSY0mOWmlIh
         a37e8pwA1IFnAzoXgy3MobGLcTXUBLmhDAGWOBcdJUAyv0vjbw1nH0DNdvS/N8xTUcCu
         d9QW8ezwp6DjZ+b13/hHDnXsAPs+hmXHRpY8ycypoH/mlP5Orz2s/9BeJA9zDP/3xbNb
         cjPg==
X-Gm-Message-State: AOAM5323yqFcLv9iRFPJiGv7URDA+IpG7ZeYWoH0E/KAE5tNA6pRsbcL
        rsebfuYtaoYqXs6DF3r2rki6HlEkqOz6AoYxDGE=
X-Google-Smtp-Source: ABdhPJwfzNA/zyNpN1ttQNQ3QEoNbNX6j55zI57BSBw+2+dRXSgzvu0ieIZEcM6VwavtT/cpEoFVgrXADd3N8mqBaEM=
X-Received: by 2002:a17:906:3883:: with SMTP id q3mr3291797ejd.160.1611907072100;
 Thu, 28 Jan 2021 23:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20210125191710.45161-1-mirucam@gmail.com> <20210125191710.45161-5-mirucam@gmail.com>
In-Reply-To: <20210125191710.45161-5-mirucam@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 29 Jan 2021 08:57:40 +0100
Message-ID: <CAP8UFD0mezb35u3SPi2Q2w-oCfA8NYAmacropNQQHumC7Vdkxg@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] bisect--helper: use `res` instead of return in
 BISECT_RESET case option
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 8:17 PM Miriam Rubio <mirucam@gmail.com> wrote:

> @@ -1043,7 +1043,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>         case BISECT_RESET:
>                 if (argc > 1)
>                         return error(_("--bisect-reset requires either no argument or a commit"));
> -               return !!bisect_reset(argc ? argv[0] : NULL);
> +               res = bisect_reset(argc ? argv[0] : NULL);
>                 break;

This "break;" was not necessary before but it becomes necessary when
the above "return ..." is replaced with something else.

>         case CHECK_AND_SET_TERMS:
>                 if (argc != 3)
