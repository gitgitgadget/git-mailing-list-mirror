Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F827C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0923223AA8
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgLHUdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHUdM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:33:12 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8119C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 12:32:26 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id p126so20828668oif.7
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 12:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6NJsZeZXzQkE9JUgRXWKCTTe3wKeKn4nIjqykMEI8iE=;
        b=maa/0hrVTIO3W9qzOeGe49Lbb2ocQsEgn/9iS5swJGN9Zk8o5aLGyF6bi2dvgSFami
         SifZh7zPWPXqYaJ7p8Chq6C1rjb6xFsLRX9owzBGKNO/MYU0SXNrAwOiE8YkmiOz8N9r
         dPXqLJ5jOK3cuVTJAxKHn7kIgApAKJ1v8A4BsQ8fGBpN3V0mXiUSyklYJJ8i5bj/nIWe
         XwlsBTczpuiWi+1c+V9dQ4vWTyaU3hRee3yMY9Xk2gqBFC6JWtvQGL5X7FpQ4/okpH2H
         tXxRLBg1hWNVO7oCK7kT1tFXAmSD/145fOrerjz0d1o/n7zhAqYojbGbSevP2TT0+Yip
         BukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6NJsZeZXzQkE9JUgRXWKCTTe3wKeKn4nIjqykMEI8iE=;
        b=PAgwqtPJC1UFwBe0pXEFw/P4i7PD6nDM1a2dzktBEmV8f1TZ9GWXEpLuec2d1yIwKd
         LEzh1Bp3yIk+78DuDbUB+YrWhpbVglqCLwZtCR1Cr27xGS02sHvwgOvG69/hOPsnvXXm
         qbg87RddA0gSPgWCVVK3glGpJ2zZNPPt2nvdhGvAOOK1cvmA9VjCvB/eF3j+ajhcEvaq
         BFhSTClmDGoN6hSN2jTQ3OXnUtjcOSh6YHo61G3UIvBspRzKUPgM//8EYt6ZVnTZsHmU
         7Cd3BJuiLX3Ta45/EU4390M7na6+uiI6okD7EBrXjhQumgBWkUmxE1rfp9TiQyqlGiPh
         Qv5Q==
X-Gm-Message-State: AOAM533hluznUk+bM+2lvs5LUvuP9vmtz8CC38ePcl118U+Gsc+Ad7kf
        6JS1jsHNgVTPVNgwYbyx2jUw3gbSCwVLCL7I
X-Google-Smtp-Source: ABdhPJyrLlNEMbjrhc3mrHJE8rMjvohqQBIyCiWk/YisJj+jj0vfpz4KCjdPWTWL4DvofYCGorljvw==
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr3985406oif.162.1607457639400;
        Tue, 08 Dec 2020 12:00:39 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id v4sm2038852otk.50.2020.12.08.12.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:00:38 -0800 (PST)
Date:   Tue, 8 Dec 2020 15:00:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5310: stop expecting the default branch name `master`
Message-ID: <X8/bYzjP569wEL5x@nand.local>
References: <pull.809.git.1607260623935.gitgitgadget@gmail.com>
 <xmqqim9dbh17.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqim9dbh17.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 07, 2020 at 10:35:48AM -0800, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> >     This one goes on top of tb/pack-bitmap, and requires an update of
> >     js/default-branch-name-tests-final-stretch (it no longer needs to
> >     hard-code GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in t5310).
>
> As the targetted topic is not in 'next' and marked with "Needs a bit
> of reshuffling?", I'd appreciate this patch to be also forwarded so
> that I do not have to worry about it myself.

Ah, sorry that I missed this before sending out v3. I was hoping that
the fixup would be limited to one patch, but this needs to be either
spread across multiple patches, or applied at the end.

Since I already sent v3, how do you want to handle this?

Thanks,
Taylor
