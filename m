Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA041F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 16:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbeGKQbw (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 12:31:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38019 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeGKQbv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 12:31:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so3181104wmf.3
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=toE1v44k3fm0UjpEJduf2+XsnGKyLiPwMYeXiLmha5w=;
        b=Xk6kb1TNk7oLtUSu8u254DTQX0sHxvNLkLnaC4mSntykSSvLaM0Vssu66x5qVdF3Gy
         EKRc3zHntWvaXTEgezm24CrSA9d+xS0WVseAmxThCHcYzIickPA5PLJItrJsNczjMvmQ
         WinqA4iUKWTGqsWiMlmU57LGmhMzJcY4WDUZmHXGwUuej3Z/OvRlU57e1RanhlfUtCfm
         QxXmk1zEMIrU6niytAMuB1V8YlkLrDIJ063K52V8y5nsRoXm3ZwKzRJrACSFB6AuWGFv
         pPTCX5dYqR55Xel6CHMB13zBlL7khEt0aLDFjfZeDGcngopcpsUQNRtfa+vI1/8tXuzP
         Bkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=toE1v44k3fm0UjpEJduf2+XsnGKyLiPwMYeXiLmha5w=;
        b=FovR76GdUk8Sl6HdnM+Jl6KAzNXOY2CHQKrYrV+qXscEFOj/JGT7zEFCvmNGMbmUil
         IBPJUFQgIhT8JWky8QNxlLZFSrAi0xtHu+53YdQ38qkTmmW8kDC1/ouQixpUUYy4+8nP
         3Yfel0YU/p8y5skQZY9AqozyTwt9nEua3e1kCzI1jKA+9cpWyKixGuDk4GYKavFmBsVG
         h6O34ydlk81k/PH/s6MvpFKNlXvnPTILM8Md+6VCBBYaPS0aBromYwO6i0JTcUbRnj4r
         PLwvVFPKw50+TQmmgQv2LR6j/iOvxEPbpSaUigco5ayWFHUDm6/+19bWHSNJH1YE4eCH
         pk+w==
X-Gm-Message-State: APt69E1AsHqXeb2hP3DqS/nUyBiQXr66IUukU+QrAYwFoGbH6LDJYsRh
        ILhwgpDgufgFjvFhyJKZ+fY=
X-Google-Smtp-Source: AAOMgpePLTNH/RbJ1szXoJZvI4Q7TEHXhKRe+BmTyq7VtgWwcQpsFAridZklHzJSX2r7YXaHwPrp5Q==
X-Received: by 2002:a1c:d78c:: with SMTP id o134-v6mr17202288wmg.115.1531326404904;
        Wed, 11 Jul 2018 09:26:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p3-v6sm34513761wrg.47.2018.07.11.09.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:26:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 9/9] gpg-interface t: extend the existing GPG tests with GPGSM
References: <cover.1531208187.git.henning.schild@siemens.com>
        <f97d2d79f6a46ddffcd0065239f99b084708e813.1531208187.git.henning.schild@siemens.com>
        <20180710170901.GH23624@sigill.intra.peff.net>
        <20180711123824.7e0be91a@md1pvb1c.ad001.siemens.net>
        <20180711125109.GC23835@sigill.intra.peff.net>
        <20180711154019.202e75c5@md1pvb1c.ad001.siemens.net>
        <20180711143554.GG23835@sigill.intra.peff.net>
Date:   Wed, 11 Jul 2018 09:26:43 -0700
In-Reply-To: <20180711143554.GG23835@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 11 Jul 2018 10:35:54 -0400")
Message-ID: <xmqqa7qx4u2k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> While addressing 1 make 2 obvious and worse, addressing 2 is a whole
>> different story and should probably be discussed outside of this
>> thread. And i would not like to inherit responsibility for 2. In
>> fact the whole discussion emphasizes that it was a good idea to make
>> GPGSM depend on GPG, because it allows to somewhat reuse existing tests.
>
> IMHO there is a big difference between inheriting responsibility for
> something, and not making it worse.

Well said.
