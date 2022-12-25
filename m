Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBDBC41535
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 11:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLYLGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 06:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLYLGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 06:06:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E3FBA6
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 03:06:02 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so8628366pjm.2
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 03:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/guV/d25BbLdjLUsHUdBwrXe7GTjtPOHoyeMwYxpcjs=;
        b=Kyc7DZceG2Bl65TG7x14FLDrVlXLPrd6n+ByADnZ/Xxpjn8cSgSKV7IHDciq5Vs43A
         tYXUIu0lULkbFOL+MXND7IJhRwaxvQ24Cl1Xcdwk2uTWsIeftrxQpCCa4VTQhWEJYVb6
         sIE9sdlFHxa4+ZDUte2vVbnJm9+6fSkbc2KpW/KeSLKtuJ6jE3+5Vf1yZodPZL9O8lkV
         9PakfLY/rJCoizJ3BDaXeOd3WLez+aAXW6rpdG4+vjUCRxdW/8QIf9ElY7+9cI/I0uF/
         34WkzPHHieczGx6O/olMMYM7IPylmV278+CinungTeraHN3oDjJVh/AIybQ1vfWlBLII
         ultA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/guV/d25BbLdjLUsHUdBwrXe7GTjtPOHoyeMwYxpcjs=;
        b=d7U4sV4sTWUedS+bfVy2SjYm5g39EzkXF0hA5nGMRMnOZP0GVrv10pHGtY8Rr/nBcB
         xkdz86L9DAWDp0wJWc6m7Y9ApXg/VfzSsT/Pm3070vDL5YBrQzr98v1MTkLusOMmszOI
         WMLu+RuEVplF+0v+AIsG6dCGLXpePU0BAe+j1tLJggwt+m6iTVmij1XXeB67jkaW9s2g
         GN1TVAUaMxjwCweijELQO/kk0jNLJ8u+zcN2uWHyllRJUQriaBJseanrseWrTVSit79r
         RtwLWE3DJh5twC8wItziEGT2JHswn7al66jwiHZI369eSVHVKPZ4UCWY3KdzGQQ3ZFpu
         XhXw==
X-Gm-Message-State: AFqh2kpG7C90d2l9cdG1BXq/k48S/8tIyZaObalJMBkKxdEqu85lIp0W
        iI6uZegYbrFYj/Fb+hC/iUW9Fvn4hFf/tQ==
X-Google-Smtp-Source: AMrXdXvCRrBvdgD0ufaQe7l/bvqTcgPJPjNA/s6RKjUmaQAsi14w4ywtrxAkkHr6ChpG8c2WT6rvug==
X-Received: by 2002:a17:902:ccc1:b0:189:5ff5:eb92 with SMTP id z1-20020a170902ccc100b001895ff5eb92mr20014603ple.39.1671966362449;
        Sun, 25 Dec 2022 03:06:02 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b00186b86ed450sm5232207plh.156.2022.12.25.03.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:06:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Hubert Jasudowicz <hubert.jasudowicz@stmcyber.pl>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] bundle: don't segfault on "git bundle <subcmd>"
References: <20221220123142.812965-1-hubertj@stmcyber.pl>
        <patch-1.1-2319eb2ddbd-20221220T133941Z-avarab@gmail.com>
        <12f06dc2-8bfe-8cbe-c6b8-659f5bf92ea4@stmcyber.pl>
Date:   Sun, 25 Dec 2022 20:06:01 +0900
Message-ID: <xmqqzgbboi92.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hubert Jasudowicz <hubert.jasudowicz@stmcyber.pl> writes:

> Seems to work. Thanks!
>
> Tested-by: Hubert Jasudowicz <hubertj@stmcyber.pl>
>
> Hubert Jasudowicz

Thanks for reporting and testing.

