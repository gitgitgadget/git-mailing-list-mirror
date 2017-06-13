Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2188E1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbdFMRaY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:30:24 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33224 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdFMRaX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:30:23 -0400
Received: by mail-pf0-f176.google.com with SMTP id 83so71096605pfr.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VNpL5xLoO9u5yiHr+urpEb6i/ZXCFI09LnN9GDcx/20=;
        b=E8lphENWiQzAp3dClDHosxnyBaXVdkfxXZ6OnLYmWRoysd0+7jq64wCTBh9HT1lVrl
         3PsApuc7WH/8izwTkBQS7DgXT8D/kpjTOLvBmp6oz69jku6U1jzdtFnT+g/E8qzWGQfG
         1CnE6qeHFqKU84+ICMI0jrxtIkFV0pbi1BG11nPhbpaFDsyO64VB6BEZdv1XttG5AF22
         z7EWh/ZppyWmqIhskMy4eJgr5KrtCATvSrnZRSwKvM3ZMP/GPcw9x/7Q93jxf4H0WMD2
         KmKKlMT4G/W3Wo4iyPFmLU/L8sCohTB4yuEK/HkUxfZTHwYkZ1PocU39spCY+f6KBeLX
         BDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VNpL5xLoO9u5yiHr+urpEb6i/ZXCFI09LnN9GDcx/20=;
        b=ixA+TECV3nlH5EIJRTR6RNuPkE8yxQUtHee5YGgtaehM5lV+AqoLb8rsObQelQ18mv
         kn9HliUE9OMaPJLdj2d/n6euJ84LiYjvNFDCZ8JKPyWCVQnkY2omM6sPH74bh9G/DPsR
         CydCz3W2iXY0SmAzjPFf4xC59OaOrUP1QpquKXzVYLNbo2IquhIo+/hU5uCQI+ht6Wmp
         y8RA4PJnLiQg4rzuxIkLcvOh7ZOoqb5xj8vXaX5TekFrN6Ku+oUf1iFpFJwi3oO/TO+n
         ISCkg+ePmtP2HcJm8p5oWqP6ENMQkM0/pCGORnCXIXU88OneIp2Hxs+srFDcMnZ3R+mf
         pUQw==
X-Gm-Message-State: AKS2vOwy9rGJS+Tk8X/CPo69JafRPWqe/Xaj/niR2cZyd6XSn0XCPKwt
        whQ6H3UUHa81obxaSbim4jeCZKDSL4mF0hRX2g==
X-Received: by 10.84.224.205 with SMTP id k13mr783579pln.279.1497375022861;
 Tue, 13 Jun 2017 10:30:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 13 Jun 2017 10:30:22 -0700 (PDT)
In-Reply-To: <xmqqo9tr7qkk.fsf@gitster.mtv.corp.google.com>
References: <20170613023151.9688-1-sbeller@google.com> <xmqqvanz9afq.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYR+qh1X-dQixdpDbcr5z-DJ2mkdncaVn_8y90kNco9tw@mail.gmail.com>
 <xmqqa85b9626.fsf@gitster.mtv.corp.google.com> <CAGZ79kYV8Ngis=ux50Zs1r5XOBUJ=hw2=8BEkNqk7PiGamX0AA@mail.gmail.com>
 <xmqqo9tr7qkk.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Jun 2017 10:30:22 -0700
Message-ID: <CAGZ79kafV5aXd9SAOHHGOgsAdpuY=YV6yWoWSsuG9rncLYhphA@mail.gmail.com>
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 10:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Here is what currently happens:
>>
>>>
>>>          context
>>>         -B              dim  oldMoved
>>>         -B              dim  oldMoved
>>>         -B              highlight oldMovedAlternative
>>>         -A              highlight oldMovedAlternative
>>>         -A              dim  oldMoved
>>>         -A              dim  oldMoved
>>>          context
>>>         +A              dim  newMoved
>>>         +A              dim  newMoved
>>>         +A              highlight  newMovedAlternative
>>>         +B              highlight  newMovedAlternative
>>>         +B              dim  newMoved
>>>         +B              dim  newMoved
>>>          context
>>>
>>
>> So the there is only one "highlight" color in each block.
>> There is no separate hightligh-for-ending-block and
>> highlight-for-new-block respectively.
>
> I think the adjacentbounds mode is simply broken if that is the
> design.

ok. Going by this reasoning, would you claim that allbounds would
also be broken design:

> git show --color-moved=allbounds:
>          context
>         -B              oldMovedAlternative
>         -B              oldMoved
>         -B              oldMovedAlternative
>         -A              oldMovedAlternative
>         -A              oldMoved
>         -A              oldMovedAlternative
>          context
>         +A              newMovedAlternative
>         +A              newMoved
>         +A              newMovedAlternative
>         +B              newMovedAlternative
>         +B              newMoved
>         +B              newMovedAlternative
>          context


>
> In the above simplified case, you can get away with only a single
> "highlight" color, but you cannot tell where the boundaries are when
> three or more lines are shuffled, no?

But you do not want to (yet)? The goal is not to tell you where the bounds
are, but the goal is to point out that extra care is required for review of
these particular 3 lines.

So IMHO this feature helps for drawing reviewer attention, but not for
explaining blocks.

In an extreme alternative design, we would have just annotated
each hunk in the context lines for example telling that there are
n out of m new lines. But that information by itself is not useful for
review

Instead this alternative moved line detection could have an impact
on diff stats.
