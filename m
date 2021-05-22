Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8C0C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D77F61019
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhEVVRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 17:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhEVVRM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 17:17:12 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57DC061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 14:15:46 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id x15so23250317oic.13
        for <git@vger.kernel.org>; Sat, 22 May 2021 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SSt+sy9QHxJCDjwnW3MjBkIlxoT15+ccoyttTP0HoKQ=;
        b=uB3qDaSUbo/bQO0sgT/D+rkL4aCj9yyLZyHFAL73znz8K4ulQ5Y72AMVMumqVbiSgf
         BiTWs4IXM1R6OHXYieRC/X8X8rOa4413aPE5Elu8tQUrBWA0mt2+9JtkCruVkO1Ew4OZ
         gqitWeIkTUh69Wu8d22ykM2IgO9A0U6K3m8OOxYiuAkxvYggNii92RXnVY6mszZ5425U
         8EIPI/IsWQw/HAYXW9nf7yEcV19y1qmy6wS4koIabBDyULwiW/ln0CnRrYonP0+qQrKS
         mZZEV6aiDbA5TJHdRyX/s0mw9wdI9iINzQfwQMbwJtTCz/qMXYEd4X7i/KdXLIuM8V/2
         Xv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SSt+sy9QHxJCDjwnW3MjBkIlxoT15+ccoyttTP0HoKQ=;
        b=PpYUzpXuafT5ZnItWyNY8BKNuGt/hhw9wa1vH58J42lFXKO/c6MT6BrKbQhwlIcTG9
         Q4+PyIBE08Ei6XbRwaADCY7Vg4TPpSvcYZFztzUko1mD0nFWo8CnSj7D3XndhXF9wJAs
         9iRMw0uwLzdodmVJvnVnFD5Lzs1FTpdPQ4tUSuIGu/uHU9LsFj5KUttKJ+SUyuab7erc
         h0JKhpExcXyGO3F8QKW0E7wphgT2z4HUog/AjbDLv3crQvbziNSQr9cWiIZ6ABd/hwsM
         vjV8/Ocxey1OqX1UIIvV7dcONCINn0c8+Wf0bf/0x8xG3osRbFW0MlK58whkrLYU/2AF
         henw==
X-Gm-Message-State: AOAM530rNStM5VYHT5KgYORdd+02cKCzdGJrLJSnu0xGGWASJEpQWIct
        tKuStq1bUPM0Tu+kprh9dXg=
X-Google-Smtp-Source: ABdhPJxlX7TAnatjT5JYFfeIydi4JYHwdcYANgqxfVWFJHItTibnZBTFwPIaaaiS+PJis1W2Mpqkeg==
X-Received: by 2002:aca:ed8d:: with SMTP id l135mr6365607oih.4.1621718145378;
        Sat, 22 May 2021 14:15:45 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id u201sm1863209oia.10.2021.05.22.14.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 14:15:45 -0700 (PDT)
Date:   Sat, 22 May 2021 16:15:43 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60a9747fc56de_857e9208b6@natae.notmuch>
In-Reply-To: <YKjVZ28fxqGq7Baq@coredump.intra.peff.net>
References: <20210522011718.541986-1-felipe.contreras@gmail.com>
 <YKjVZ28fxqGq7Baq@coredump.intra.peff.net>
Subject: Re: [PATCH v5] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, May 21, 2021 at 08:17:18PM -0500, Felipe Contreras wrote:
> 
> > +	/* Add red to bold, blue to underline, and magenta to standout */
> > +	/* No visual information is lost */
> > +	setenv("LESS", "Dd+r$Du+b$Ds+m", 0);
> 
> Unlike the LESS_TERMCAP_* strategy, this completely breaks "git help"
> on my system:
> 
>   $ ./git help git
>   There is no -D option ("less --help" for help)
> 
>   $ man less | grep -A1 '^ *-D'
>          -Dxcolor or --color=xcolor
>                 [MS-DOS only] Sets the color of the text displayed.  x is a single
> 
> This is less 551-2 on Debian unstable.

I see.

Looking at their history it seems they only enabled this for non-MS-DOS
builds in 2021.

That explains why most people haven't found this yet, and are using
LESS_TERMCAP_*.

I'll revert back to LESS_TERMCAP_ and test with an ancient version of
less.

Thanks for testing.

-- 
Felipe Contreras
