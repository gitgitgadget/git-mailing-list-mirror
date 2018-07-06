Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 760C81F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbeGFVnH (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:43:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52284 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbeGFVnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:43:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id w16-v6so15962740wmc.2
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IrG4jadoxF2FI/syI9iKn2QhJOtIXDlE9sTSrj2IwEs=;
        b=aTIRLEx0TatvDx4bFL/g6fseQDhg7aMJWMmsqYTg5ApWe2q/Q5j4SDmZcASx/DuEO5
         s2sjBLmYI7kJ+rvunfzGjBm1e5N2+lTMzQ+ExgfHRhABHCki7ik6fbJVUvD3cmmCv6OQ
         r4Ad1/mfhwWMZN4QlszI5qViCyamtmAtCopNx8vSgMchDyfVIpx13y5TxL8oPb+ZgDEX
         kQfEI0ijt7kCZETyO53tMKmcQbKZBRmCi8yHY+MvK3p+0MGENeyEWGjXYdzzWp6oFK3Y
         ZlfMBfGBAslq+1mUkDutKb7IUFFb4XyJTCSD8fwYzfflgYOFwH/Tcf4MCllkfxJLJsDd
         JZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IrG4jadoxF2FI/syI9iKn2QhJOtIXDlE9sTSrj2IwEs=;
        b=bifyHIQWa1PJVkXZhYjbOYdKUmHsQOTp11hQRqroXjQTspE9nL52D2AcQWL+d1ANkt
         HZJNd1h6ZffRidLLb4jzvxNH9T73fDlhWqWScQHJ1yKm5qys6q2kJMJU46CGviYUJLbg
         AMH4fc9+VGRf6Kije0l48rnpFzmfpiT73Qdx+vnL9c1iU6WoIWBqFQ969m1oCVjtBADi
         yX5JuppgI1gbSmRPTRIOU+hKFNGTVluneF8EfT4ERdDsVV23mZiSoKIUv9YzEMGWtYwV
         gmz0B6/+W7EERXOc0ILhIx4K5XS6GOpl1YRkV6YuWTbql+AYgXql5WXn7/Agy7grpJT1
         dpkw==
X-Gm-Message-State: APt69E10c8/N+W1L5xHo0JednvdGUQX3mQpj9nr9xp2DL1d8rmpEz4QO
        GzipnXV7Pa3uvs1Sz8GIluu543n2
X-Google-Smtp-Source: AAOMgpcDjqGnXv3EywAmo6BerR8eYFqRXH1a6LWYNq2lDx7Zo8Kz1ukkKgFzohuMPxE6jcvBqV4wzQ==
X-Received: by 2002:a1c:2c03:: with SMTP id s3-v6mr7666688wms.109.1530913385266;
        Fri, 06 Jul 2018 14:43:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o4-v6sm20685915wra.3.2018.07.06.14.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:43:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Tiago Botelho <tiagonbotelho@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list --bisect
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com>
        <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
        <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com>
        <xmqqa7rhi40f.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1806271254210.21419@tvgsbejvaqbjf.bet>
        <xmqqwoukgpr9.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1806281505160.73@tvgsbejvaqbjf.bet>
        <xmqqvaa2yjo1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1806291317150.74@tvgsbejvaqbjf.bet>
        <CAADF+x3jd5G9+SP3UmhwqrR_T6BuD0PkQJ3x+NLpq2BJ_Ej-Sw@mail.gmail.com>
        <xmqq36x0ndza.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807041224460.75@tvgsbejvaqbjf.bet>
        <xmqqwou8kz9b.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807062123280.75@tvgsbejvaqbjf.bet>
Date:   Fri, 06 Jul 2018 14:43:03 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807062123280.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 6 Jul 2018 22:33:56 +0200 (DST)")
Message-ID: <xmqqfu0whwgo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> And I also do not see a reason why somebody wants to make the dist
>> computation to be 1-based (iow, changing the minimum from 0 to 1) or
>> one step not to be 1 (iow, giving 11 to e1 and e8), so while I agree
>> it is not strictly necessary to cast the concrete distance value in
>> stone, I do not see much harm doing so *if* it helps to make it
>> simpler the test that is necessary to make sure relative dist values
>> assigned to these commits are in correct order.
>
> I guess that you still want to misunderstand me.

Not at all.  

> So in this case, quite obviously what you want to do is to verify that E
> and F get larger dist than e1 and e8. So that is what you test for. Not
> some fixed text that might require adjusting in the future for any other
> reason than a real bug.

The most important part of the above quote is "*if* it helps..."
part, and I do think the downside of insisting on dist being exactly
0 for E and F is acceptable than having to write the "E and F must
get the same dist value, and e1 and e8 must get the same dist value
that is larger than the value that E and F gets, ..." test without
doing so *and* still keep the resulting test readable.  It is a
tradeoff and we are drawing the line differently (I am being more
practical here than insisting on requiring absolute minimum and
nothing more).



