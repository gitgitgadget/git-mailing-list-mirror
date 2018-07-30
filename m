Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585831F597
	for <e@80x24.org>; Mon, 30 Jul 2018 14:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeG3Q3q (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 12:29:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36059 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeG3Q3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 12:29:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so48404wmc.1
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uu+cAEzaJwJTQuK60kN+rehdSx2BxZOnv5IYK6TRsTw=;
        b=nOdLFl+7ucVMZWEL4V/zmA34StAQU29QBWJbLzY3nWrqQIUXIluXBWIOCFejia8yPa
         CBjKugus+ePU4Zf1rTWdghJMOUCbtcmTqnWFwxhFG+TD1riAWHS4uvqhlNn1wETNt17V
         +Ff/axTeMWzZbddwA6OFCRmQB01d8FZTEhBvmxgVlQYOAJSYcvNhcwfTyQRbwuRPGI2p
         opoVEIFA9sW03w/R+ILctB0s3Vplp2h5IDvPBy7VGQCBsfhy1QHko8bqKjhYos/wbIdT
         5vVYhv3dNvJgj1MV3pogiAr0yAU5UgY3tFFIWOhUu0Gf+l0w/gnf061etIikn13k+pPQ
         PACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uu+cAEzaJwJTQuK60kN+rehdSx2BxZOnv5IYK6TRsTw=;
        b=kO5W84tRZzAJ9Sn1d+qjWa0m7b+IH+eZuj4WqGpv+QhVLNaQOF/Wrvsxrb9m9Gq0xa
         wmrO/VbVbtDS87RY+l6e0pBKBI+nc8qBEh4iRibnp3rkSFBVOaT3yGai57Bm56RxNc26
         tes7z/swiMbnC/Mwntkk451bAYtquyOgIRfU2ck0/4DEux7Jyv3DvJy7JrvotVpLlCRv
         96p3zg1Uc3NnO7J+FAbl9tBPW4OZkwY+h2/T87rlBCYEGxRE5jn33nLm5yNTvkak94M1
         ufnQoKfvGd9O1mZnwcAr9OpTEq5JCGV/t+oKzks2sd94ZsB+SNEUVqa8VVhYMti/KNqL
         I0lA==
X-Gm-Message-State: AOUpUlE+S11dGhsBk6b7i9bZI7L1xSgpG6vHxRRYgCFJ4+AcoF2wZDBw
        Zf30Daox/edysKvLd+s08TQ=
X-Google-Smtp-Source: AAOMgpc+lCwFCKPWmuD+DDXP6HRgMUhVDbBeJgPeP29pZlyKrnwTlTrHfOH7SPV8lwj8vKepi+nU2w==
X-Received: by 2002:a1c:d702:: with SMTP id o2-v6mr15447053wmg.115.1532962462308;
        Mon, 30 Jul 2018 07:54:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j9-v6sm27344734wrv.5.2018.07.30.07.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 07:54:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michael <aixtools@felt.demon.nl>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Dan Shumow <shumow@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: Is detecting endianness at compile-time unworkable?
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
        <20180729181006.GC945730@genre.crustytoothpaste.net>
        <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
        <20180729192753.GD945730@genre.crustytoothpaste.net>
        <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
        <20180729200623.GF945730@genre.crustytoothpaste.net>
        <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
        <87wotdt649.fsf@evledraar.gmail.com>
Date:   Mon, 30 Jul 2018 07:54:21 -0700
In-Reply-To: <87wotdt649.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 30 Jul 2018 11:39:18 +0200")
Message-ID: <xmqq600wkc4i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> And, as an aside, the reason we can't easily make it better ourselves is
> because the build process for git.git doesn't have a facility to run
> code to detect this type of stuff (the configure script is always
> optional). So we can't just run this test ourselves.

It won't help those who cross-compile anyway.  I thought we declared
"we make a reasonable effort to guess the target endianness from the
system header by inspecting usual macros, but will not aim to cover
every system on the planet---instead there is a knob to tweak it for
those on exotic platforms" last time we discussed this?
