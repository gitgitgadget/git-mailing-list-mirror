Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0FB1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 22:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbeGYX5b (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 19:57:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33027 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbeGYX5b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 19:57:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so8862033wrp.0
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lYTugqnWqgponG4SauAq2B2Pfm9j7Df17a1HlMO6GD4=;
        b=YqpqCxLA7aJc8zyye/LK+HT0xSmiQ410MU0SVNBYO9/MyZ8llEBSswXqOvtmeD0N8l
         mCKoxtMNCN7W4iqds8NiiaEVMQVPPJT9dnNxnPo5sR8zUm8re3nvGnB5bm/vfMQ58k8f
         BNE8SVENir7Fietkl+uoTK3miHq8NUUzDFumM9wQbOTXfhCIGrY6GSJW7Tdn7h6M7Kyb
         BAVbsLhCefr/ExA7QltECOG43vLRQj2hMhIjMYuJFNlRTJ6fGTVOv3HC7Dd+kXwScqLO
         S92oPaeknHwai2GJu8/QAqzLUJ14iohNHY4NnSchHQqUeNJhLVMyxgSLY9jCnhUIIPsy
         kj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lYTugqnWqgponG4SauAq2B2Pfm9j7Df17a1HlMO6GD4=;
        b=QZb+K8bwJ2apTbWoOFrWk0gcxkwHPA7dUqagD9pbwl1BACpd0tJH7kH+I3lBoTozbU
         8G21Lc2HyGeY5jBkZHcAixiSGtVMpqP7PDv6AQr9CdC3VEGW/TQo59n5GXM6iB33vqM8
         EWKOVpHZ7KhaDN6fiQ1+7GZgZSD7SYyk98QTWNKDhacD5qvelefHYeHv+4yvdKL0ygYQ
         8/B9yLX47gzps07d0aNkRJxxLhrYBLQ7FW0jaovNWQrqECLtbpc/o5pkCiDEA3fOPLra
         Om2RoVA0GVQeI0GhJyj64thl8M31M3Z8PaiebeSZsb0KjV7b88+NkbAiFj6QIH8/kegc
         a4lg==
X-Gm-Message-State: AOUpUlGkEMJs0jU4wGsmH2A5lwTKiCocjDF9q9HeffQy6kMX80dh3/Dw
        czLawgZObVn9+sgl0iTX/EpnhZL6
X-Google-Smtp-Source: AAOMgpe4ceyrGkDF+ntgl+ejt7XXpahDIc/hZAlRqJ1aFo7WX3Cd1QfHzNZvrv3ostRdZbEX05pQxQ==
X-Received: by 2002:adf:efc1:: with SMTP id i1-v6mr15238443wrp.151.1532558621430;
        Wed, 25 Jul 2018 15:43:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x129-v6sm6619884wme.11.2018.07.25.15.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 15:43:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v4 00/20] rebase -i: rewrite in C
References: <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180724163221.15201-1-alban.gruin@gmail.com>
Date:   Wed, 25 Jul 2018 15:43:38 -0700
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 24 Jul 2018 18:32:01 +0200")
Message-ID: <xmqq8t5zszqd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This patch series rewrite the interactive rebase from shell to C.
>
> It is based on master (as of 2018-07-24).

With fewer number of bytes than "as of ....", you can express it in
a more useful way, even when you and others live in different
timezones and when the 'master' branch is updated more than once in
the 24-hour period.

I think you based it on b7bd9486 ("Third batch for 2.19 cycle",
2018-07-18), so you can say so

	It is based on b7bd9486 ("Third batch for 2.19 cycle",
	2018-07-18).

with a bit more bytes for the subject and be more informative.

When you rebase your series, please explain why you needed to do so
in your cover letter.  "I just wanted to catch up with the latest
'master'" is not a good enough reason.  "I wanted to make sure my
series works well with X and Y that the base of my previous attempt
did not have." is a very good reason.

I think the rebase this round is warranted, if it was done to take
advantage of the fix made by Elijah to the code that handles the
"strategy" option in 0060041d ("Fix use of strategy options with
interactive rebases", 2018-06-27), in other words, you wanted to
start from the version of read_strategy_opts() Elijah fixed when
you split parse_strategy_opts() out of it in step [15/20].

I'll send comments on individual patches separately.  

Thanks.

