Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288E720A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 03:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbeLMDOO (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 22:14:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35505 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbeLMDON (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 22:14:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so848469wmh.0
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 19:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l9mMsgZNYKxGGD+DZty/zboh7Igcm2REKX4itIWaKv4=;
        b=ETE1UcMZsSntdghGKKLWsl1BtCBH2RtDAwvlXdiUE/MPi/B8D2vQNIDiQTVuFVuzoZ
         nuEM/7HzsjMNhde1hsG4vnOvZj2ym3srqNAQWxcD/wcNFsY1pYQJcUoIS/DbDuByskRI
         roStF2hfJ0+3LXSow/ZdNRH+D4eXiJH982ATvYje+d+91ER/snPf9zTqS1SzPWWUfxJV
         FfSjLjg9Rp+ndLI7zqb7nCzKA6Dcrkn2ifEmqmkLHZ6VzoDjr3rQW79j4Co4XSvwrA+b
         k7ilXQcgFQxlurr4A5z47LEG6XKfTV3XP0ciCF2536V7S7eNUNPKdDR+NeMarnv/75Yn
         +iTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l9mMsgZNYKxGGD+DZty/zboh7Igcm2REKX4itIWaKv4=;
        b=C6pFg+2g2zsKl7dvlxQIluC+AxKPWHvuBVZNfaPqDKDEBPxlwPyxrdhocslQeMGpeG
         gjbOvEx9vvw99sGwl1Ttkf+wV20xFxhlQUG854I6R9qP+yW0sLvvCDkX/xaGGOsu3/Xd
         AqIRacqOnIOfhjt/eNi3qDVztPRe0/TIAvV7TQLX5fVqlR+ugkG6x8UciLsc1v4nWkoV
         aMsTCUJohhO9QuzlnI0Bugbh6dfBlg5c6gu55bp9/SEqy3yLtCdNLRzVdltG31tSXtoD
         8cAOcxdQ6CEX7IvovoRuD1PNWZtz2aNHdsJjO6LPhIQ1t0GUSst71kha0E40hjv5eWlO
         OPIg==
X-Gm-Message-State: AA+aEWbgu+gJx7g93qNF+Y+JMUvx6S81YYxLczf6cGFfpzGRP9B43b4r
        fORMt7lUFZW7LX8QwzoY4VPu1PHNo+4=
X-Google-Smtp-Source: AFSGD/WxvNm2DwWiMyJr23vnF7ngCz7eweHjLyOM8YnKXOiWhKLAtnM4x82Y1Uwtjr+h0JWwckILlw==
X-Received: by 2002:a1c:35ca:: with SMTP id c193mr8345507wma.146.1544670851721;
        Wed, 12 Dec 2018 19:14:11 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t5sm660930wmd.15.2018.12.12.19.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 19:14:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] submodule--helper: fix BUG message in ensure_core_worktree
References: <20181207235425.128568-1-sbeller@google.com>
        <20181207235425.128568-4-sbeller@google.com>
        <xmqqsgz87bj9.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kb0Vqk8Gtao6OdKx7gJi6pCEpLzcqQsk=uqCLfePZrmVw@mail.gmail.com>
Date:   Thu, 13 Dec 2018 12:14:10 +0900
In-Reply-To: <CAGZ79kb0Vqk8Gtao6OdKx7gJi6pCEpLzcqQsk=uqCLfePZrmVw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 12 Dec 2018 14:46:50 -0800")
Message-ID: <xmqq5zvygltp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Unlike the step 2/4 I commented on, this does explain what this
>> wants to do and why, at least when looked from sideways.  Is the
>> above saying the same as the following two-liner?
>>
>>         An ealier mistake while rebasing to produce 74d4731da1
>>         failed to update this BUG message.  Fix this.
>
> I am not sure if it was rebasing, which was executed mistakenly.
> So maybe just saying "74d4731da1 contains a faulty BUG
> message. Fix it." would do.
>
> The intent of the longer message was to shed light in how I found
> the BUG (ie. I did not see the BUG message, which would ask me
> to actually fix a bug, but found it via code inspection), which I
> thought was valuable information, too.

I guess that it could be stated in a way to make it valuable, but in
the presented text, I somehow found it was making the more important
part of the description (i.e. "this patch fixes a mistake made by
74d4731da1") buried and harder to grok.

Thanks.
