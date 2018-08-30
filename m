Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360B91F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeHaASU (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:18:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44124 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaASU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:18:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so9182183wro.11
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 13:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3BLG4iNsvopg7TMYSxQ0K+JPUaYwbQ9XGfCHut6UF2o=;
        b=TFWKKWxAJYnBGwZadZXpRqojTnT+tATNIIpFGf39h1M89KxjVpqjHoiy2pe02wLHiL
         Fo8ynfEaHOyEkYllKpiCbi/gN9+/4CK6Vziz8Dd1lhfrZxVXdPBx1Bbqt51dMCVImH9a
         Ztsf9ju30EwFt5Edfv/mgbFoG5a0m29VnZ1Rrep7ipBsiGH5z60BeHNqdqmX5Ec9U059
         kxezSZcZRvOtJbiYZlmFZWVGfskWNCM6cJcSI7kvULZhDj3IaHB9AG8MYv5jyYgddEg1
         gsWQ2+C/MZ7VpkGWVaNfTp+kG5VV9ujzWcdPmkHsuXCxpQizkZSCJYIJ1Tp6Gjw+lG8a
         n+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3BLG4iNsvopg7TMYSxQ0K+JPUaYwbQ9XGfCHut6UF2o=;
        b=sXPy8/KBf475YbcuK/5cxQYlvPxfH8waBvPl8Vwr2xvon7byIKtq/3NW+aMm0D/Mcr
         og2QiNTVTJoKDQuyn8JTUETvYulhaVl7ri0epO3wiq3jLMEkG0S/8hyCSBhM1APISM1Z
         cTrboSSeDhTYUCmHFDe7gI+nSeUKmFtp6yi8LpO3QVOZc9wsI/mKj0OBxVgXPSjxPu6T
         C4K1g8UkRN8Vaz9txBvMeF8NV5YqN7PQ1cb/kgplzd1qgybnuqUVr9h0MTtsQDvFbHST
         r3Tn2eIsSW13r9+/7Z8QnLfDny5ZMug/GkfitTto0nE4r5EG1Yx4z0OMl6ZeP2qEUzea
         DQ0Q==
X-Gm-Message-State: APzg51BabvjrC9a6KzMDpmjSMeRcJnfl4bQ71S5bY4Ylg6tZumePVzoi
        Iu7Ed2Dg5eP0Q8DZCov8qEQ=
X-Google-Smtp-Source: ANB0VdZ6UKevhOYj49lkYeCqMkGWS/bXr2xuTVcagw5CoTLNLQK0nJSweTKwJTaEmp2IAkwxubYd6w==
X-Received: by 2002:adf:cc91:: with SMTP id p17-v6mr8713283wrj.226.1535660066142;
        Thu, 30 Aug 2018 13:14:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w17-v6sm3032357wmc.43.2018.08.30.13.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 13:14:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/9] worktree: fix bugs and broaden --force applicability
References: <20180828212026.21989-1-sunshine@sunshineco.com>
        <20180830075431.GF11944@sigill.intra.peff.net>
        <CAPig+cS3-oRzQrZGM_-pXUVFE3HvMdtODurPkmYgw1vFV8zb3Q@mail.gmail.com>
        <20180830194634.GE19685@sigill.intra.peff.net>
Date:   Thu, 30 Aug 2018 13:14:24 -0700
In-Reply-To: <20180830194634.GE19685@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 30 Aug 2018 15:46:34 -0400")
Message-ID: <xmqqva7r4nof.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suppose so. I don't think I've _ever_ used distclean, and I only
> rarely use "clean" (a testament to our Makefile's efforts to accurately
> track dependencies). I'd usually use "git clean" when I want something
> pristine (because I don't want to trust the Makefile at all).

I do not trust "git clean" all that much, and pre-cleaning with
"make distclean" and then running "git clean -x" has become my bad
habit.  I jump around quite a bit during the day, which would end up
littering the working tree with *.o files that are only known to one
but not both of {maint,pu}/Makefile's distclean rules.  I even do
"for i in pu maint master next; do git checkout $i; make distclean; done"
sometimes before running "git clean -x" ;-)
