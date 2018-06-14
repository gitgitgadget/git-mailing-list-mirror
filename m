Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E61411F403
	for <e@80x24.org>; Thu, 14 Jun 2018 18:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754791AbeFNS1G (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 14:27:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40415 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754660AbeFNS1G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 14:27:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so13705813wmc.5
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Mbp2R1P6vJF7L1FxOB2cKdv9seA55olfsMt3afP8k3Q=;
        b=DBJHXNwuRXZeNxq1tE8B7INIQBI/ZLOqY/RprgjHghrtUMZrVjVEgB7j0FxdaCx5VW
         QDHuqhOIQK/OL4LXH2NnMsSR/uDH+3eQTjCOxN1AI7xatHDom9uKkwJgubt17zWXHI0q
         I9K72cXmJcffpIylDtsgN4dTRPgbAI+pZkpZMtPFkWrf+Cp4OQg880VlKE8+iuFGVLWZ
         ehbWVQKwGep1Ht1dsuTvZhLCuwzbp/QxTZTXBX/tyxMuO+aeJMukcmdDsDH44E2V8ZtS
         7otjvjGhSkaWbm0mmJG9q/oKSpzjrs1NxiY758sJKpkO6W5ohnhj690pgL0cEg7v1EmA
         b6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Mbp2R1P6vJF7L1FxOB2cKdv9seA55olfsMt3afP8k3Q=;
        b=cnpvKD70v2VVDmWb6rqZvzfc9J5des0FeyYq/eZ4BKbaO8Xo/sVKvjb4OJ+gRTGpSh
         ObtNx4UPFGGR68vekeTsT29R2ivqtiedfGi42s7U0aJ4iygNJSKwpzBt3shAsPjGnD6S
         7opmi6YsRy8DDujTx1n1jItFoPK+5W+S+avtXcBdkTI1P4SU5vtcUvmjxPFnSu9VG9WD
         y2b+iVogBOxjY5WDTF2D16Wa2SK2DybRqsz1qXd3BeUuJyjDyi+R8bUNIqVAzLl9sbZ0
         JeI3MbbYfEtzcI1p/HrphQ9EvTRB8vYKvKZD6dcooTqRskHZEJ5ZOLJgozWW2fjxqQyH
         xEuQ==
X-Gm-Message-State: APt69E2w+Td/Cp/KqosrC6yaj/DuLugtjSejirD4yxdtZRfIt0K4ya1I
        Z8k2XNxVW5x8arYlAXoKKfAaH19A
X-Google-Smtp-Source: ADUXVKK2NixPiYO7hE5TWCKAS/p/m7Tbnhswah8Eo1Q9DCHN/e5gtUfov+pT56+dm3nWm+FEWdt6fw==
X-Received: by 2002:a1c:20c7:: with SMTP id g190-v6mr2910110wmg.2.1529000824663;
        Thu, 14 Jun 2018 11:27:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v138-v6sm9050480wmd.47.2018.06.14.11.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 11:27:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] t/lib-httpd: sort log based on timestamp to avoid occasional failure
References: <20180614123107.11608-1-szeder.dev@gmail.com>
        <20180614123107.11608-5-szeder.dev@gmail.com>
        <20180614175325.GA14935@sigill.intra.peff.net>
Date:   Thu, 14 Jun 2018 11:27:03 -0700
In-Reply-To: <20180614175325.GA14935@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 14 Jun 2018 13:53:26 -0400")
Message-ID: <xmqqefh94420.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>     Another alternative is to simply accept that these tests are racy, and
>>     that the resulting test failures are rare enough that it isn't worth
>>     the complexity of the workaround, but adding a comment to the affected
>>     tests warning about the raciness is sufficient.  (But I wrote this
>>     when I first saw and tracked down this failure; since then I observed
>>     it four more times... :)
>
> It's definitely bugged me. I'd be happy to see some solution. I've been
> close to suggesting that reading apache logs is simply not robust, and
> we should focus our tests on the git-visible state changes (e.g., seeing
> successful requests, updated refs, etc).

Hmph, that certainly is "checking only the things that matter",
which is desirable.

> A side effect of that is that it would become a lot easier to support
> other webservers in our test scripts (though that may still be a fool's
> errand just due to the amount of custom config we seem to carry).
