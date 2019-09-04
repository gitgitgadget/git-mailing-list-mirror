Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531E61F461
	for <e@80x24.org>; Wed,  4 Sep 2019 02:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfIDCWl (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 22:22:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35884 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfIDCWl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 22:22:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id o12so11086172qtf.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 19:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YgvmEl+Rek+JJ3V6k3i3nichpR0GUvKMnlhoF9BN73M=;
        b=gZ22bBjPjE91xbCVILKO+pTXdHLlC0b9QeZi02XO5Ex7LBPpT/xQSLcWgKQkzsV005
         BmNeL7hIO2zBR1w9/7YEvS6XCOuUEOcvYGtTlcfrLgNrW2KcRJKMKL7vVJTUsDk9jSqv
         BRndk0M0wDiVhRcmAjx6N2WLZTxMN4NCDjhHB/bMgrr3HGK9Own+pkwMpeUQeOAg6vK4
         UdYLLRrN324XMKzDI3xRPbKvp0T/tKhH3YTXKdweqnTkoevirzF2Z6n4JE6B0StW68Lq
         PLVlVX7F8RX4Ec7CJmb0x6CN/LrJDiRCC/9AwrbBslP3BB7z4JjCOBTUE4GE+t50jg4l
         WFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YgvmEl+Rek+JJ3V6k3i3nichpR0GUvKMnlhoF9BN73M=;
        b=Xl/1s1RzrXDXcaR2xRFCe1QxkombmtpYIU6rpL8pfTDfcprEiQNlnnvMJRuq9Y6VUs
         oRh3MPPD+46UsA+exygBYXPiX/maUCkIZeG7nJR2LQvDaJLHMGohwDt9Pb0dp5v8Y6nq
         dX2e9YV7p3c0KNgDTEFqCWECzefHvqdvvEXw+8CzeTRBpsiqtwW0PgK9Q8juwsTxEUxd
         NUlrjfGmaUxJKQM07j2QPktXrDVXq2WBepTvxbTWfLi8tazaKSJO8K63FiQi4uIKO+D3
         yg+ONUTOcnTpim4ygUohGB5+6ROpHor7R8nc19d1ifJPXXhNJxTmGa4inZ7vzSJuiEIU
         n4Qg==
X-Gm-Message-State: APjAAAXl0/IXdke5HS5G8uvJbbGMHpvvbG+8MEqw9sZYe4gHVhpyjF2K
        JWJs4u+cWkAf3SQbgkmZ551NEQ==
X-Google-Smtp-Source: APXvYqz8OzgpDsDfHznlE01lpCnwcPRXkixg5V88h5u9evMtaur59Ggqn/kL6r1oaPsn1igvbAsZOw==
X-Received: by 2002:ac8:e4e:: with SMTP id j14mr37148124qti.113.1567563760030;
        Tue, 03 Sep 2019 19:22:40 -0700 (PDT)
Received: from localhost ([2605:9480:205:dfe1:24fd:2e2b:8aac:d853])
        by smtp.gmail.com with ESMTPSA id h4sm9594108qkf.126.2019.09.03.19.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 19:22:39 -0700 (PDT)
Date:   Tue, 3 Sep 2019 22:22:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     stolee@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net
Subject: [RFC PATCH 0/1] commit-graph.c: handle corrupt commit trees
Message-ID: <cover.1567563244.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was running some of the new 'git commit-graph' commands, and noticed
that I could consistently get 'git commit-graph write --reachable' to
segfault when a commit's root tree is corrupt.

I have an extremely-unfinished fix attached as an RFC PATCH below, but I
wanted to get a few thoughts on this before sending it out as a non-RFC.

In my patch, I simply 'die()' when a commit isn't able to be parsed
(i.e., when 'parse_commit_no_graph' returns a non-zero code), but I
wanted to see if others thought that this was an OK approach. Some
thoughts:

  * It seems like we could write a commit-graph by placing a "filler"
    entry where the broken commit would have gone. I don't see any place
    where this is implemented currently, but this seems like a viable
    alternative to not writing _any_ commits into the commit-graph.

  * Could we learn about the corruption earlier? Ideally (in the obscene
    of these placeholder objects that indicate corruption), we wouldn't
    start writing a commit-graph until all of the objects in it are
    known to be good.

    This seems like a costly operation when it comes to memory, but
    maybe I'm thinking about it the wrong way.

Depending on the approach here, I'll clean up the commit and message, as
well as add a test that demonstrates the breakage and subsequent fix.

Thanks in advance for your feedback :-).

Taylor Blau (1):
  commit-graph.c: die on un-parseable commits

 commit-graph.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--
2.22.0
