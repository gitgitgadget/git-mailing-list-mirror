Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F7D1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 18:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeHJVLN (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 17:11:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37336 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeHJVLN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 17:11:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so9106670wrr.4
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d2Fic6i9Gss8axBByw7oUUJvHswGL2b33wrjNjvTqKg=;
        b=X17GBrhxszHsZO/JIarFwNciCgps54BhJttd5njNHiSaj11N/AZZa3ormjkzmalkt0
         T4MFPL7kp8tPi0uerhdHya5L6YW1iGuNG937S9V6cPUQItAy/m7m0wf47TwE285odpSt
         voQv9oroDmpzk+qL/BqlU9lpj7+k9NdeCRn7qaneAUhaUbrOjt5vbcmGweU9GL39n2Z1
         YaJwL6mWT5+gji1mJuz0Uj23A7fm5W2baAHGBf09rXavgGUQR7eEZ7MiBOGJoD7pLMGZ
         0diPlJYO1eaaF7rl1H4/rXgxrvP1bIUrD64WUFIjZTDUP0kvi24lNXkaEIEEkAkStM7g
         p5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d2Fic6i9Gss8axBByw7oUUJvHswGL2b33wrjNjvTqKg=;
        b=ZR0DD3qM/fIGwlNERBWlUWRu5QISfUXxHkG8r07o9rN19hMb/q97aTL3jnoW/rVrRh
         u23yT0pM0MHITVcqa/K5xcKoL4hRPPCJtarwR1TKz2aOoFkKv7i2G2ilh3ld/NchC7Bh
         kwsHt2TI9b8uye1Qj/qnMzhVMYD1UF7YWmbS8JtXLIrr0AdMiebfxTlDcsC3iXiEanSf
         kAo+iTZy9tEdBNsfaVg8pqQ1RR1UgmdYc/Orq8vdG5Bs0neXhoN5rkU1lZeaC1COyDKY
         7xUHSP2fNFI2AoSfx11mrvvdkc0ohWS1jV7R7lYnnHhOWC5WLlMrZG0+2SnpSO3u3er7
         3OnA==
X-Gm-Message-State: AOUpUlHJof9luNRKMQut7RS24HJ73ZJLeiwzc8MPYlbCY3E3C/jPieel
        nawKFeqioMam2sPjKpTkO24=
X-Google-Smtp-Source: AA+uWPzXkXcG4aKJbM7k1qZPntBEntoSnOAuEAe9gQOdPcNEYfNH/pgzghSTvBNOuLvkd4vJOBvFiQ==
X-Received: by 2002:adf:ed8e:: with SMTP id c14-v6mr4807474wro.264.1533926409012;
        Fri, 10 Aug 2018 11:40:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j8-v6sm9999235wrp.11.2018.08.10.11.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 11:40:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking for GIT_TRACE
References: <pull.17.git.gitgitgadget@gmail.com>
        <20180809194712.GC32376@sigill.intra.peff.net>
        <xmqqo9ebb6z3.fsf@gitster-ct.c.googlers.com>
        <20180810140908.GA23507@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1808101833330.71@tvgsbejvaqbjf.bet>
        <20180810171546.GA32713@sigill.intra.peff.net>
Date:   Fri, 10 Aug 2018 11:40:08 -0700
In-Reply-To: <20180810171546.GA32713@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 10 Aug 2018 13:15:46 -0400")
Message-ID: <xmqqeff683qv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I have tried to help with the actual problem, by identifying the root
> cause (that the trace code's strategy is not fundamentally broken, but
> that it relies on O_APPEND whose guarantees are obviously not portable
> to Windows) and exploring possible solutions there (FILE_APPEND_DATA).
>
> Lacking any kind of Windows development environment, I'd just as soon
> stop there and let more knowledgeable people take over. But please don't
> characterize my presence in this thread as some kind of willful harm or
> ignoring of the problem.

Thanks.

It seems like the other Johannes and the other Jeff are also
interested, so we may hopefully see a properly fixed O_APPEND,
which would be the real solution that would help appenders
that are *not* tracing subsystem, too.



