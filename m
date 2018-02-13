Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD2D1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 21:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965898AbeBMV6A (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 16:58:00 -0500
Received: from mail-pl0-f41.google.com ([209.85.160.41]:38880 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965871AbeBMV56 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 16:57:58 -0500
Received: by mail-pl0-f41.google.com with SMTP id h10so705471plt.5
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 13:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qu8baorJU48anTkrAQ1vVkPGggrUEgOMcyEhxnjy7Nc=;
        b=ZLnfB9AxxEhUm/puagddyM4LgDsI5htUbc+HR/oFg2ckKTBTbVymF3RATYHdLzpgf8
         QAGvPWZO4FSp3+wKTQfYD87YKZpi9dfgRA0ktQ6gNibdaeonkiWuCD881jZdcBj3PNHM
         OFj1jNAb9aPWHampILugW/dRn6+m9/gncFyEy7Z9pVox80Chs0QaEYEBWFs6oHzhP4zJ
         yXhUVZWOwGeItLlyTWAidrzOhjvoVlV/QhSj9pf6uJVF3nMoYBMs2BXV+vitbjAdcJXW
         UaEUFBdpSvA893xhCCIXdbCKxytcSCJ830vnx2qOQqNEOFSd1QnWlqf6weQGoq5LYVkV
         It8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qu8baorJU48anTkrAQ1vVkPGggrUEgOMcyEhxnjy7Nc=;
        b=LvvmjcEOlamAH+zgE6QfQ5TmKkzYeKflhMvXKwV0kBZ+REGe1nOTbLWTxQNiFFJ8PJ
         9eSlOfE4iFo2KhXcyR8iZM7LOp2prAVXhqZmrfVsbdAupI6yjSqMZhGGbguHhlMelHSU
         lZ1Y6kewiz3QOgolyP0mEEV8jiGXdoDIxxnGjIJAVCC1Sv0GDS8kqKypJOAbSfrM+TTu
         5loKDULQHN2hOQmevPeCYcCLKpcMfZbxERopQ7ds6331kEBC0HeDdVj9B0oh8zjnCrN4
         dPV/aJxd71gLNvjV1brvRVwGmlZuBtKciaupWcNYKsh7U4Q2bRpgtmACVr1idU0b4qyA
         SHuQ==
X-Gm-Message-State: APf1xPAgeinlMNb5PB2cepgq8dSPhzG/dtOqPIeDiWKS1KhwiFG8snCD
        KRvvZvhYKjLLpqIfD7j+4+qkwy1Nbj4=
X-Google-Smtp-Source: AH8x2262/kN96R8sWONJv6mOnwkqK/06y5gP4GZk+hBFyJ9oxzOtDIKF8hJlrf+412s5xXoT2QxMbw==
X-Received: by 2002:a17:902:2843:: with SMTP id e61-v6mr2415871plb.260.1518559078173;
        Tue, 13 Feb 2018 13:57:58 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id s67sm4590800pfg.104.2018.02.13.13.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 13:57:56 -0800 (PST)
Date:   Tue, 13 Feb 2018 13:57:55 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 05/14] commit-graph: implement 'git-commit-graph
 write'
Message-Id: <20180213135755.85944f875fdca85b6d4db9a3@google.com>
In-Reply-To: <1518122258-157281-6-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-6-git-send-email-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  8 Feb 2018 15:37:29 -0500
Derrick Stolee <stolee@gmail.com> wrote:

> +test_expect_success 'setup full repo' '
> +	rm -rf .git &&
> +	mkdir full &&
> +	cd full &&
> +	git init &&
> +	packdir=".git/objects/pack"'

Thanks for simplifying the repo generated in the test. One more style
nit: the final apostrophe goes onto its own line.
