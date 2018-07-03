Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702211F85A
	for <e@80x24.org>; Tue,  3 Jul 2018 19:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeGCTkt (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 15:40:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37764 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeGCTkq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 15:40:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id n17-v6so3458658wmh.2
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jkee9hz/hulYRrgH6s1Tno1YJoTcGSs90m2AHT1kvAg=;
        b=PKM9KwbgaIryKnjmNWLTcck2bK6FS9WuGDBJ/2jl4ieSla2919EB2ajmu828DsFcvt
         QjbCI2DbZQkbEiOsR0EgBKLfcxjunHOHb6K+Opm/Ue4wNmifvuLm7/NRnpk6EtzsH6co
         Shm1JPINprRNY4rvz7GlDpUwbhFfAoBBledXWZytQK/laL1t2tZZJqpQhSAmk/Cxb2XQ
         nTW5tj5AZH2PG5Aayo64k9SPS7IcuTf63D81HC/Okj/CTM9DxkX3mUErptdisGZd8WCW
         ajSc7P2svJs7CeffKnELYjvfWIKc/rWcABMdmc8JFa0i53y0+Ts2Vn9wrnPzNtc0SEjj
         TzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jkee9hz/hulYRrgH6s1Tno1YJoTcGSs90m2AHT1kvAg=;
        b=KZ484kDdSH0YX6jyvATqTN+f2mlIxSmdHOS1XLOBeLvr4t6rvJLqvy2YIOpINxbdiO
         eJ4M4yg66AMFPQWKwwwskxEEiRlVLvo+OoWApzrpYeI5hilzblKtQUr+GNcrQS+Rkc0a
         M784xBoNUjsileYF3qyeiOkDDVITT4LPNLF16XL50TpPSkgWQhtcOBVQykehdEJYBIcx
         KoMYwRgiz/eJZYE0Ef9fx+fALQ3nwGXW+lahMI60GWxJkov+zZLc/NNgfjJ7K5p2aWYL
         qOanuAjk6mapuB2/Z61mxgEchZ/rsgZxsTVXQqlx/ryut4qJRi28//R9jRef6SRpL2Jc
         aYJg==
X-Gm-Message-State: APt69E0l+UqriOnTZ9ZR9vn8t5PqQWvvvfM0H3An+ryF0CQR3aG6tmgr
        nmxXhGCjtHO7el2irQyuJo0=
X-Google-Smtp-Source: AAOMgpeE3d5jZSO5SSrIJHKt7Ly376tv7or7+S/ahwk0/4TB+VRSnp00TtAI1F7b1FLwbFvtaEX1BQ==
X-Received: by 2002:a1c:9616:: with SMTP id y22-v6mr4966899wmd.72.1530646845199;
        Tue, 03 Jul 2018 12:40:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q70-v6sm4001224wmd.45.2018.07.03.12.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 12:40:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/25] fix buggy tests, modernize tests, fix broken &&-chains
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Date:   Tue, 03 Jul 2018 12:40:44 -0700
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Sun, 1 Jul 2018 20:23:40 -0400")
Message-ID: <xmqqa7r8qf9f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> It is split out from an earlier series[1] which additionally extended
> --chain-lint to work within subshells. I decided to make this an
> independent series because these (hopefully) non-controversial changes
> all stand on their own merit, and because I don't want to flood the list
> repeatedly with this lengthy series as I re-roll the "extend
> --chain-lint to work in subshells" functionality from [1].

Thanks for doing so; very much appreciated.

Not that I vehemently oppose to the --chain-lint change, but I do
like the fact that I do not even have to worry about it when queuing
these 25 patches.

Will queue.
