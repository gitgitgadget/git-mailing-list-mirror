Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED5A1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 15:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389758AbeHARIZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 13:08:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45954 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389627AbeHARIY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 13:08:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id f12-v6so10601829wrv.12
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Y1HyyUqOgY7ZOImugXQFa6qXilcSyxLmzJoo9ODD2MY=;
        b=nTL8YCKUY6VDHJ2A8UtlWPkKbfOEGpR/PNX1JrRYdI6F3lDsubSXaSIkQYQsXVZaKP
         mwHmXVh7XtZUWjjWs7SnsdnDwOm1GYne9B5P9Bh4PxwsYhO1N9+QB6zjqEB7guq68WDx
         +kcgTY/f8EdwWGNLU4Qd/krKSHVDyfpUds80S8JklP+7CRAFJkcEhxtyggpwSVXfokO/
         tvHegKJ40004/u2s5Z9XUGpDzFzSXTMQ2/wBse7WBuWWxmQcUmTU55TIKUT+B1EQPIDK
         ezn2WdRZtX4AmSebRywLzGAOo7EYwFgZqbaEi0bAygqbIAKGDO2CcLcceUBiBPluSzuR
         ygKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Y1HyyUqOgY7ZOImugXQFa6qXilcSyxLmzJoo9ODD2MY=;
        b=Xl6BjWVXPhEtPxVsM4elXcDf68mFXWUtUx09DHsDGyWxm+AX5beiPDzzA7maubE3yM
         NS8bdtd/qy6MkEhbUM7MSZHDh6tMs+UyRA7RwnrPQhU4tfnFA506VVrj7nKGwXKxa8Zo
         G14gNOB6vMLP2yw7Ag3TSMz8TIVsCgPwsiPspdPT484SRlLJZDd0TGPbC5OWnHPeQLII
         rqMS2XsQYib4xcWwMKhegImJbyRBBnNt/rIxnS0eCF0J3/wsnNfIpc+zztyNc2B0S0Tc
         QYEBMkZmyNEacdsEBjmWk+WQv9FM4PED0DrpK262KEf1UBkTV8Sm8PrSx9OSoFCkaW6A
         sCYA==
X-Gm-Message-State: AOUpUlGelIyAflnbgaSccaQEk0f9KU+flGgSeOm/10xi6FNXjzHPskP/
        vZ5sgN3r981IaRcrXeSFEY5DozJy
X-Google-Smtp-Source: AAOMgpcXPO5xu3eV4B66SmXa1iZ4buZFxf22i7nInr01S4EG0Qqbn3dNXGqagc/UEIobmLJqBSH6dg==
X-Received: by 2002:adf:9546:: with SMTP id 64-v6mr23848508wrs.257.1533136931604;
        Wed, 01 Aug 2018 08:22:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u7-v6sm7545555wmd.46.2018.08.01.08.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 08:22:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] sequencer: fix quoting in write_author_script
References: <20180731073331.40007-1-sunshine@sunshineco.com>
        <20180731111532.9358-1-phillip.wood@talktalk.net>
        <20180731111532.9358-3-phillip.wood@talktalk.net>
        <CAPig+cR5VHP8muo5_A_9t7OPZam8O_uPb0nd73B15Ye92n+p7Q@mail.gmail.com>
        <22f98273-f7f4-adf3-1a8b-b0e4ec6029b3@talktalk.net>
Date:   Wed, 01 Aug 2018 08:22:10 -0700
In-Reply-To: <22f98273-f7f4-adf3-1a8b-b0e4ec6029b3@talktalk.net> (Phillip
        Wood's message of "Wed, 1 Aug 2018 11:24:14 +0100")
Message-ID: <xmqqin4u863h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>> Is the:
>>
>>      ...for some reason sq_dequote() called by read_author_ident()
>>      seems to handle the broken quoting correctly.
>>
>> bit outdated? We know now from patch 2/4 of my series[1] that
>> read_author_ident() wasn't handling it correctly at all. It was merely
>> ignoring the return value from sq_dequote() and using whatever broken
>> value came back from it.
>
> Yes you're right, when I tested it...
>
> Thanks for your comments, I'll do a reroll

Thanks, both.  Sounds like we are quickly converging to the
resolution ;-)
