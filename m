Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03CF31F45F
	for <e@80x24.org>; Fri, 10 May 2019 15:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfEJPKD (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 11:10:03 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:34384 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfEJPKC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 11:10:02 -0400
Received: by mail-ed1-f51.google.com with SMTP id p27so5599583eda.1
        for <git@vger.kernel.org>; Fri, 10 May 2019 08:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=BUXexiY/bamQKT9TqST9MiImqvhd2w4nQTkXXWLpcm4=;
        b=lBflIeB5NERZfBnApQHDpdAExk1O8Edq89tCLedS6RZ+AAtMtjsce6sMg4s2KWzQvw
         RnWG8u+lcD7YuIsCkq5dA6iBBwnphkbQx/TdkGX6c8S22UyFRh7ldZ9aIOcl31//NSIO
         rsaoBAxOlNgvf/+a+xcre0KyWN6VraL8BSta5SS+O7WWzBMiuufehadY7Y0AkG/LyHmX
         qAxiaLrfi3doViukTouQuE7pfa7qZeVTT9YyGvzGJyLdO4XGS8TxOkd+y+Jt1nAdcipI
         dqgIC2dUUUfrGxQdGtvdore95J34PXmeEe9nHRP1aFN0e10Ijwcw29UjKN5RGsobOJtv
         6rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=BUXexiY/bamQKT9TqST9MiImqvhd2w4nQTkXXWLpcm4=;
        b=sY/5QzoJOJ15wRFZCx+yuBt3uzb9m6/gKuQBxBLaF113LOAj1mChcXAJ+NIq1uvAVy
         bVDE+Gb5nWDQcoJG0MTwH/QXlgvLe1qSs5YS4klSeOmOW505nO1Pkc5GTCqSpTmyXrID
         Aryod2aTfdu/IShAXHgQEK2HBgns5GQG7rcMt0iEGQL8oXmHthiJiOkjsSvvMpXjOz5Q
         txwLLd/v7HUFDDiUppfx2is/iES63vqeZM5OJ4Ax0jy9fc6wwWHdQnBZdMvH9xw6Uwch
         msPuDQF2kEt+arkvPWzd3hc4wwl8JNQJfD9w+g6/e8ku7ZfoWZ8KCF6VWBQAy0bZRPIW
         s16g==
X-Gm-Message-State: APjAAAVQVbsTuVXNiAwSuOMZmAuIlzO06kjElR+Lmi2En8d7PPAcNaDy
        lTnF2utKRle2XJ+f1Bh6lgqYAIW3jWU=
X-Google-Smtp-Source: APXvYqzAOaa0vZfuA117UhLPEyp3O4Cc8z92VLFVdOQELXDWsMGHJP5ZcOvKkkcorz5ob6WmfIxWjw==
X-Received: by 2002:a50:acc1:: with SMTP id x59mr11485840edc.264.1557501000559;
        Fri, 10 May 2019 08:10:00 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id x30sm1516368edd.74.2019.05.10.08.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 08:09:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: I made a flame graph renderer for git's trace2 output
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
Date:   Fri, 10 May 2019 17:09:58 +0200
Message-ID: <87zhnuwdkp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a flamegraph of where git's test suite spends its time on my box:
https://vm.nix.is/~avar/noindex/git-tests.svg

I hacked up a script for this today to plot trace2 production data, as
noted there it's at:
https://github.com/avar/FlameGraph/tree/stackcollapse-git-tr2-event

What are flamegraphs? See http://www.brendangregg.com/flamegraphs.html

As noted in TODOs in the script there's various stuff I'd like to do
better, and this also shows how we need a lot more trace regions to get
granular data.

But it's already quite cool, and I'll keep improving it. I'll submit a
PR to Brendan's parent repo once I'm happy enough with it, I figure it
makes more sense there than in git.git, but maybe we'd eventually want
to teach the test suite to optionally use something like this.
