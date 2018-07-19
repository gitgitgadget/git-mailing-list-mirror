Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7DB1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 22:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeGSXbX (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 19:31:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45553 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbeGSXbX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 19:31:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id t13-v6so108777wrv.12
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Uju1v02P6elEWXH+5uF4KcxBNfHPMq3WUEH7Bi3JdMY=;
        b=tqhffeJ5f5xvcR7DadXzhr8o/kBepImlhG5P/9urDQS1iIKNKn586rlL1b9r46Yb7W
         5O7KB1IQQtQiRSlbhxeL5Xsl+jUz2JQDf1YJrOgt33Ojz/p6r5BheiBJV05TnTJWX/Rb
         H87rFuqSamqNOQHpJ75YbC/OrhzGfV/qSYq+q+6H/Wts54ZszwpYeyWQ3VHX+tFZ+M0K
         50r4QBxSLwRnAD8mYfkbOMi40rI23wo2DvXis0SjPC6nfe9oJamLPeH3C4+2BqqinDRo
         i7Ho8bLvP1UfTnwyyico+WBzvE8JUkaMOivAG7pZtE8raMEQwlaUyM9jS+219N8+2LZu
         t1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Uju1v02P6elEWXH+5uF4KcxBNfHPMq3WUEH7Bi3JdMY=;
        b=MIBYPw1lkGeHRH3gL7zLCs8z/xYx5N0CnndgOM/KrRQ4Tdni9XnVfdmJ63pRqbXImb
         LI+vAn419tGKcUkHccsuOC7sXvI1bZYBf5ZHbRUgc4/gnUGbdrxdow8IX+0/nz7lA9L4
         94V915Kf1Y2Qexcjp4/nzyGXJeiytLlsl/TT8l5nw0c1UziM4x3UFkA2uMEw0zyN0LnR
         5SFHAMIOoM4z3o7pASqBWCg2WZT7v+lB4QHvZU8mXeRLwahsOgFKEYp0SkmAu5S/pyiO
         su44COG3FGcHO+8lG3rMoA0XJHrVRO2+Zp2Rp41Q/jlIiG5uCyOgFQhSkHQW0EYRE0+s
         8lnQ==
X-Gm-Message-State: AOUpUlEgSYHENJwV+yyy7WcsBaGTSBfOx7pmuIvByONSRrfa2aqXft/B
        vhZADsOg6wAg7g9hC7Xrl4k=
X-Google-Smtp-Source: AAOMgpe1TB0Jp0HfmrMMPBOwPVit7ZmR3mWWpxphlsL6a8QYB4OO1TPCIcbeBpzGQvZNDyqi3ZwUhw==
X-Received: by 2002:adf:e887:: with SMTP id d7-v6mr8946662wrm.43.1532040369190;
        Thu, 19 Jul 2018 15:46:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m144-v6sm81300wma.36.2018.07.19.15.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 15:46:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
References: <20180719203259.GA7869@sigill.intra.peff.net>
        <20180719203901.GA8079@sigill.intra.peff.net>
Date:   Thu, 19 Jul 2018 15:46:08 -0700
In-Reply-To: <20180719203901.GA8079@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 19 Jul 2018 16:39:01 -0400")
Message-ID: <xmqqmuumdetr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For enforcement, we can rely on the compiler and just
> introduce code which breaks compilation when it sees these
> functions. This has a few advantages:
>
>   1. We know it's run as part of a build cycle, so it's
>      hard to ignore. Whereas an external linter is an extra
>      step the developer needs to remember to do.
>
>   2. Likewise, it's basically free since the compiler is
>      parsing the code anyway.
>
>   3. We know it's robust against false positives (unlike a
>      grep-based linter).
>
> The one big disadvantage is that it will only check code
> that is actually compiled, so it may miss code that isn't
> triggered on your particular system. But since presumably
> people don't add new code without compiling it (and if they
> do, the banned function list is the least of their worries),
> we really only care about failing to clean up old code when
> adding new functions to the list. And that's easy enough to
> address with a manual audit when adding a new function
> (which is what I did for the functions here).
>
> That leaves only the question of how to trigger the
> compilation error. The goals are:

I actually have another question, though.

Is it a downside that it is cumbersome to override?  This is not a
rhetorical question.  I am not convinced there will not be a legit
circumstance that calling strcpy (or whatever we are going to ban)
is the best solution and it is safe.  By "best", what I mean is "you
could instead use memcpy/strncpy/whatever" can legitimately be
argued with "but still using memcpy/strncpy/whatever is inferior
than using strcpy in this case for such and such reasons".

