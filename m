Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6749E1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 18:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933832AbeGFSO2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 14:14:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33348 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933413AbeGFSO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 14:14:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so5978862wma.0
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BrU4MKDTM0ncF/1HDtr8c9cwzVETZvR0tfpCD1AfR/0=;
        b=Noab4cUE0vu82VFx77IyGgsu39PBY4CHN/+qJfk4QeWB4jSQ/1Ey5A2DD6oB3Mpoqe
         PeosxyC9gp/QL/C60cC6KwITUMZOjUKSt6JruQAbCTdqNM8NkOmqJma52QDQ3o+z2HGi
         EoGZBODQE8T9tSnOMHhpYUpy3HbJf1NXZAWmTlqxrV2f4UYAeX4p7fj7G9XQiHdUSZA/
         YQRdFsCjpYrzhWFcutSbDKKhqf6BrglANwJJDfQ44gTHJjscU05PdI88oPvNR13VQA/v
         9j2MTLcWpCtSWFsJ6R7s9WK6eq3ERTWCf+DLNg8D8m0WEb7UNeMLEf7KERgb/L5HLd4b
         s95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BrU4MKDTM0ncF/1HDtr8c9cwzVETZvR0tfpCD1AfR/0=;
        b=btHSTBukZ3ioETdx2otBW+VPJLV4NSCRvJ3pU5qdFmWu9j2x3kRq91N80Ma9boY88k
         bXE2T/GIdGQ+jjamkzeBNFj5+3DmISRLWNrQdjhADY1LbzvlaFhKr/Kz6x+iCHPGSSzT
         yiZnX/R6pqtFqWwQmyJfQSKjnF0Nbr2EmRReUAYwZpA/tcHCcJMAEV0+6X2HRQ/lDQ4g
         V8rLEFn7VGjKP+hdesR7vjTf7SvSZhR/xeIBz1Ht2MyX5I2LtUzxTQVmjKLwDKArFldz
         B4Ir6Bl/Fh1PrFVeneexHN11UJ48yUYDt75nISbiqCCSnrc+E7WyqjfF2Li92hp+n/a0
         Ltdg==
X-Gm-Message-State: APt69E1ki3SQxJ+jDAr7etQG842Pmy44LK+WDotdMsc9szWkpSTr+ipp
        rBx23Td13/GPPhY0UShc12A=
X-Google-Smtp-Source: AAOMgpfWr7pzHxxQwyMQvTk8owQZd++scwzUv/aka4SZ1PwZfcx1flfjxqmbQ02yu4QjcWwdaJ6Y1A==
X-Received: by 2002:a1c:d554:: with SMTP id m81-v6mr7064309wmg.28.1530900866295;
        Fri, 06 Jul 2018 11:14:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a17-v6sm6801354wrr.81.2018.07.06.11.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 11:14:25 -0700 (PDT)
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
Date:   Fri, 06 Jul 2018 11:14:24 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807041224460.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 4 Jul 2018 12:26:32 +0200 (DST)")
Message-ID: <xmqqwou8kz9b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > git rev-list --first-parent --bisect-all F..E >revs &&
>> > test_line_count = 9 revs &&
>> > for rev in E e1 e2 e3 e4 e5 e6 e7 e8
>> > do
>> >   grep "^$(git rev-parse $rev) " revs ||
>> >   {
>> >     echo "$rev not shown" >&2 &&
>> >     return 1
>> >   }
>> > done &&
>> > sed -e "s/.*(dist=\([0-9]*\)).*/\1/" revs >actual.dists &&
>> > sort -r actual.dists >actual.dists.sorted &&
>> > test_cmp actual.dists.sorted actual.dists
>> 
> From my point of view, this indicates that you want to set those exact
> dist values in stone.

As I already said, I do not think it is absolutely necessary to
declare that the minimum dist is 0 or 1, or how big one step of dist
is.  For those reading from the sidelines, the history we are
testing this new feature over looks like this

#     E		dist=0
#    / \
#   e1  |	dist=1
#   |   |
#   e2  |	dist=2
#   |   |       ...
#   |   |       ...
#   e7  |	dist=2
#   |   |
#   e8  |	dist=1
#    \ /
#     F		dist=0

Current code will say dist=0 for E and F, dist=1 for e1 and e8,
etc., and I am fine if the code suddenly start saying that E and F
(i.e. those at the boundary of the graph) have dist=1 and one hop
weighs 10 so dist=11 for e1 and e8 (i.e. those at one hop from the
boundary).

But I am not fine if E and F get larger dist than e1 and e8, or e1
and e8 get different ones.  I do not think the code quoted upfront
would catch such future breakages.

And I also do not see a reason why somebody wants to make the dist
computation to be 1-based (iow, changing the minimum from 0 to 1) or
one step not to be 1 (iow, giving 11 to e1 and e8), so while I agree
it is not strictly necessary to cast the concrete distance value in
stone, I do not see much harm doing so *if* it helps to make it
simpler the test that is necessary to make sure relative dist values
assigned to these commits are in correct order.
