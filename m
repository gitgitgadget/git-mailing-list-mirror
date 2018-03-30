Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6D21F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbeC3TBC (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:01:02 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:52538 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbeC3TBB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:01:01 -0400
Received: by mail-wm0-f53.google.com with SMTP id l9so16882477wmh.2
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JPBwS2AIfyPs9MlKjWPxK1UEfB/7Shg+0fAQaXbjIa0=;
        b=lcpWee+1YKnBRHivm0QyuuJ45MlZa2uik+IPkZO+EItx7M+wVe32/HISKd1bIWgDe0
         KNS2STKU5FnTWbj9c7GElgm0SwG4U73gs6sJul/y4fNPjK8QoeAgnAjwWmBEg+FF9kDK
         lUrliq9OreTJSyfsPB7VldA6UHZEaNNm2ZBYOUHF6p3rDFKI6Se8TC90WKIUFDzXt0Xm
         fIK5pTxRhRcjoeD8VvmZh7l8kExfsoiXZoFnMZj0H+91mK3lnOTDqp2y6PEjJ06IXGim
         +SYSnfZF88xxpGQ4LSLYcX33Fc24fXQyn377cxYhFutA+e+E1zBJozhi9w+FTXI/TodS
         +u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JPBwS2AIfyPs9MlKjWPxK1UEfB/7Shg+0fAQaXbjIa0=;
        b=OGJ41LqHvq7FgTeIPua2CeQMjRVPrTgsmhVJ/uXf0GZ1S7ajjF0AoXg3brskQugla2
         WpUNAPQ0zV101tHiL73mO8JOmocLPXFvNq0ui16Cd2oH4QC5kdAJlqVRuFmlqRH07VxH
         ICCJ+x2DUiA+6YzuXWVBnLfkkx/u8je42And1SyQaqsEwzeDItPU0MhH4SRbOOrUjxFX
         oA4uqvzLUImUV4Bl3e33re9MYCx7KZNwe8kRhGOwns1fuIMhDBBn/JEuU5SqG5MtyjrQ
         ZBlyPPqjBWvRuy4bEywnrkGfGbVCkuoCa4YVMqfwGJsmBQxL4Brd6y/itITHADXnHfLO
         dclQ==
X-Gm-Message-State: AElRT7E1SpMegCMuIYYlXbe1/LGqG5HHb4SI5+pC2klWFWvtpcu2PJAo
        /TIIqEJoXdCsBSuVcQ+HdHw=
X-Google-Smtp-Source: AIpwx4/lKX6PZrlMKLrO9X0LzFxwdUXVBBuz3jMu8tvyZkdmNOUhBDL70WWtcS1BdPMehq7IRAWGTA==
X-Received: by 10.28.177.215 with SMTP id a206mr2969683wmf.142.1522436459548;
        Fri, 30 Mar 2018 12:00:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z9sm15431298wrz.4.2018.03.30.12.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 12:00:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
        <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
        <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
        <20180329194159.GB2939@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
        <87in9dwsxl.fsf@evledraar.gmail.com>
        <xmqqefk14jlb.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803302042570.5026@qfpub.tvgsbejvaqbjf.bet>
Date:   Fri, 30 Mar 2018 12:00:58 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1803302042570.5026@qfpub.tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 30 Mar 2018 20:44:46 +0200
        (DST)")
Message-ID: <xmqqfu4h2xsl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> What would be a *really* good strategy is: "Oh, there is a problem! Let's
> acknowledge it and try to come up with a solution rather than a
> work-around".
>
> EXPENSIVE_ON_WINDOWS is a symptom. Not a solution.

Yes, it is a workaround.  Making shell faster on windows would of
course be one possible solution to make t/t*.sh scripts go faster
;-)  Or update parts of t/t*.sh so that the equivalent test coverage
can be kept while running making them go faster on Windows.




