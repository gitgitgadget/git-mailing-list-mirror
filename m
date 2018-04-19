Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF7C91F404
	for <e@80x24.org>; Thu, 19 Apr 2018 23:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbeDSXZR (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 19:25:17 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:41182 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753601AbeDSXZR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 19:25:17 -0400
Received: by mail-wr0-f178.google.com with SMTP id v24-v6so18190214wra.8
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yTDzQ2nHBD4SBC/UFwaN8CSErXRadX/4gy9BWp0D78g=;
        b=LAeCRtyZNBRlGs13z9PvKg2FTRQOlureYpidK+0wkwegASgF4QHldSRT1Pz2x6FTr1
         IECAvy3i2mRCSypFpGfigKa1aJmJQl/DgjAQP8Ila5NkLsQ0yhcplsDrUpQv+FszfNj1
         aJ4Bh4YQrKWAJJLPu20SpdWOZrAnpTHU7KbbxQ2zOOC0rlvCv9FgV7u31KYmvALSpgr7
         2G4d28oRg+2rMHqmCiuAJuWa933mrU9X2jaJ3a5cWklpWPUBCzyPL46sXhA8eV7EZGHD
         RpD1r/AWTGqQt5cXKcP3GTbU49I++MGORmvux8W9j80stXHpJMoGogzKyCyPDVhvjTqJ
         5CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yTDzQ2nHBD4SBC/UFwaN8CSErXRadX/4gy9BWp0D78g=;
        b=GQVG0OkfZv6Tq2N5NxlQFPxfezXo/FPT4H5IhlI7RdzXxbRGbokSxRcWCe1gMnup1O
         ijZsCrAGO6xflhARdSwUs6WUBaZ9pH2adri5qMK3ARhIKvQOkqFGSw7lQpWdInsimWxW
         15zkJWBVWr+P5t0TIYlkQx5KWh+DDXIw5cY1AEqwDG9H8LZ2BuN6bP7vPD7ahBNM9uwz
         AB90O3qNqC2NnaON3BDc/sWeRAJj/IV/zPUqgcSiFgJMmn83/WSyvn4JfwGh/LW0O2lK
         WA0qN2VC8z7LV5mJhKtc8yKyDVyiQXUyl/Kkhx+6pM9CndlOpXcb/C5rvn17Q7M0TCIz
         qLMw==
X-Gm-Message-State: ALQs6tAqlWX/Mlg8cnSE+JDpgK25jZZTgC2Pjw5U7KYlQW6cPVbGmqmH
        ZZoEj/To3BJjvHObJYPZsKg1GvNk
X-Google-Smtp-Source: AIpwx4+HubtsHHBHHFIiTAdQe/s+YF+eoxNDrV9J3EzbmXHNGxQidoYDZHeSHJGvp4ugitw3eSWfYA==
X-Received: by 10.28.21.84 with SMTP id 81mr395181wmv.36.1524180315602;
        Thu, 19 Apr 2018 16:25:15 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v134sm304282wmv.32.2018.04.19.16.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 16:25:14 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/2] completion: improvements for git stash
Date:   Fri, 20 Apr 2018 00:25:12 +0100
Message-Id: <20180419232514.16572-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <20180417212945.24002-1-t.gummerer@gmail.com>
References: <20180417212945.24002-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous round was at <20180417212945.24002-1-t.gummerer@gmail.com>.

Thanks Junio for your input on the previous round.

This round drops what was 1/3 in the previous round.  We keep
completing the options for 'git stash save', so calling the variable
'save_opts' and defining what would be 'push_opts' as 'save_opts' +
'--message' makes sense.

2/3 (now 1/2) was mostly rewritten.  We now no longer suggest 'save'
in 'git stash <tab>', complete 'git stash s<tab>' will complete to
'git stash show', but 'git stash sa<tab>' (or longer) will keep
completing to 'git stash save', as the user most likely already knows
about 'git stash save', and wanted to type that.  We also keep
completing the options for 'git stash save' on 'git stash save
--<tab>'.

3/3 (now 2/2) stays the same as in the previous round.

I didn't find a good way to implement "reluctant completion" (I'm also
by no means an expert in bash completion, so there may well be a way I
couldn't find by googl'ing around), so I left that out of this
series.

I don't think it's strictly necessary for the deprecation either, as
we can just print a warning message when the user actually uses 'git
stash save' at some point, which would make a message printed when
using the completion redundant anyway.  I feel like that warning
message is not something we're quite ready for yet and I'd rather wait
a few more releases before doing that though.

Thomas Gummerer (2):
  completion: stop showing 'save' for stash by default
  completion: make stash -p and alias for stash push -p

 contrib/completion/git-completion.bash | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.17.0.252.gfe0a9eaf31

