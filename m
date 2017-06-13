Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA3D31FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbdFMRQT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:16:19 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36446 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbdFMRQR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:16:17 -0400
Received: by mail-pg0-f44.google.com with SMTP id a70so63447439pge.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qHtDIPWdVJ82fESWNSJfUW5b+kwxG+0piMOkbn8UEzI=;
        b=AcdszQFrVJPMi2icyFH0zuqaiIZU6XceROLKlUsW0JjrClWjPuv57DEDi84LToGFKe
         Fglzo0yC6KgtkA3RDsQX/1+SFdX5IiNTVrMFOo5io5qra6CuIMaRY6WTjYh3qIxXQoRo
         561BqouGo0fHWANgqtqu1InRKmi8qnl0z9rfzusMpXoc8lK6XaBKTDUoBN7sf7/zOQPW
         59pcu13n3bQRjcDPTFTIvbtQ1DMcpBCxXw5htXjj6R4qSYlcBUS3l2QjhJ5UDD5wSoLg
         PCEri4cYaNY8LiJjj5SU8ZyxKteFpxlWD2NpBfHGP1XgGn/zlHgTj9RXIXuQekkxrqsc
         6hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qHtDIPWdVJ82fESWNSJfUW5b+kwxG+0piMOkbn8UEzI=;
        b=C0UVcfpXdercqqhjLd9GzWzHV7O7ERgnOb0/cZ+ST0ShRE88P0O2f08HZAQ9zFkldP
         ohah+EgxwwrXiJBjUTKZJQKrBmyMnwcjx6EzIVUoBZ7c9gsrAS7sX30zqIcZuiwP845F
         GEB3k9IeFfwKUzJxmCbT2vQCs7VhQhF01N46gmwNil/DFAHUXpYVgZibjtPshIXJY5l1
         aj+sKiZJT+B7/LMTYXWp7T5hEibTH1yEVD/iL7UkOhUo93Az+Apo9c6wsbddVkFK6NRT
         1NfkiiOTZvEDuBOrSG+DXHOmoIE8HF45WxBgYHBuQ/XQVpY60qV9+nRJuu0mpcsB2YyM
         TJGQ==
X-Gm-Message-State: AKS2vOwcdgyzFYxU5Bx80KR21Lf1kmMWT2quaS3cuGJvXoYKwt/F3lbj
        6BZolF6NI1jbTQ==
X-Received: by 10.99.163.110 with SMTP id v46mr646177pgn.210.1497374177192;
        Tue, 13 Jun 2017 10:16:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id g27sm25151214pfd.80.2017.06.13.10.16.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:16:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] add: warn when adding an embedded repository
References: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net>
        <20170613092408.db22ygki6wg2t23d@sigill.intra.peff.net>
Date:   Tue, 13 Jun 2017 10:16:15 -0700
In-Reply-To: <20170613092408.db22ygki6wg2t23d@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 13 Jun 2017 05:24:08 -0400")
Message-ID: <xmqqshj37qqo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I also waffled on whether we should ask the submodule code
> whether it knows about a particular path. Technically:
>
>   git config submodule.foo.path foo
>   git config submodule.foo.url git://...
>   git add foo
>
> is legal, but would still warn with this patch. 

Did you mean "git config -f .gitmodules" for the first two?  If so,
I think I agree that (1) it should be legal and (2) we should be
able to add the check on top of this patch.

Or do you really mean the case in which these are in .git/config?
